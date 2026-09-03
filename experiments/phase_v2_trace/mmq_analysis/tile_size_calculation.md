# MMQ IQ3_XXS Tile Size Analysis (RDNA3, J=16 active)

## Current configuration

From `mmq-config-rdna3.cuh:209-220`, the active variant for IQ3_XXS is:
```
I=64, J=16, nthreads=128, nwarps=4, K_vram=256
```

The I=64 / J=16 tile has 64*16 = 1024 output cells per block.

## LDS usage

LDS layout (from mmq.cuh):
- `tile_x` (X tile in shared): `I * sram_stride * 4` bytes
  - `sram_stride = 2*32 + 2*32/QI8_0 + 4 = 64 + 8 + 4 = 76` 4-byte elements
  - Total: `64 * 76 * 4 = 19,456 B = 19.0 KiB`
- `tile_y` (Y tile): padded to `nwarps*warp_size = 128` ints = 512 B
- `ids_dst_shared`: 16 ints = 64 B
- Total: ~20 KiB per block

## Register usage

214 VGPR/wave. With 4 warps/block and 2 blocks/CU:
- 2 * 4 = 8 warps per CU
- 8 * 214 = 1712 VGPRs per CU (out of 2*1536 = 3072)
- That is 56% of VGPR file per CU
- **Registers are the limiting factor, not LDS**

## Alternative tile sizes (calculation only)

### Smaller I (32 instead of 64)
- `tile_x`: `32 * 76 * 4 = 9,728 B` (9.5 KiB) - half the LDS
- Per-block compute: 32*16 = 512 output cells (half the work per block)
- VGPR/wave: probably similar, maybe 150-180 (less accum state)
  - Estimate: ~33% reduction in accum registers = 214 * 0.66 = 141 VGPR
- LDS at 9.5 KiB allows 6 blocks/CU (vs 3 currently)
- 1536/141 = 10 waves/SIMD, but capped by LDS to 6 blocks => 6 warps
  per block, capped at nwarps*blocks = 4*6 = 24 warps? Not really,
  blocks_per_SIMD = 3, so 12 warps/CU
- Actually, halving I halves the row-stride, so we could fit
  ~150 VGPR/wave, giving 1536/150 = 10 waves/SIMD, but the
  `__launch_bounds__` would cap to the requested occupancy.
- The block does half the work, so we'd need 2x more blocks
  to do the same total work.

### Larger I (128 instead of 64)
- `tile_x`: `128 * 76 * 4 = 38,912 B` (38 KiB)
- Per-block compute: 128*16 = 2048 cells
- This already exists in the config (mmq-config-rdna3.cuh:212) for
  J>=48 with nthreads=256, nwarps=8.
- For 128 KiB LDS: 128/38 = 3 blocks/CU
- For 64 KiB LDS: only 1 block/CU (severe under-utilization)
- VGPR estimate: 214 * 2 = ~428 VGPR, exceeds 1536/4=384 per wave slot.
  Likely 256+ VGPR/wave, which would force occupancy=1.

### Smaller J (8 instead of 16)
- J=8 is not in the config (mmq-config-rdna3.cuh doesn't have a J=8
  CASE for IQ3_XXS with either fallback value).
- This is because the MMA tile requires J >= tile_C::J = 16, so J=8 would
  only fill half the C tile.

### Different ITER_K
- `MMQ_ITER_K = 256` is fixed. The K dimension of the tile is hard-coded
  in mmq-vec-dot.cuh:166 (`k01 = 0..MMQ_TILE_NE_K`).
- Increasing ITER_K increases the per-iteration work but does not change
  the LDS or VGPR footprint linearly (the Y tile in LDS grows, but the X
  tile stays the same).

## What if we doubled I to 128 and halved J to 8?

Hypothetical: I=128, J=8, J=16
- Wait, J=8 doesn't fit MMA tile.
- I=128, J=16: tile_x 38 KiB, only 1 block/CU, 8 warps/CU = same
  occupancy. Worse because fewer blocks hide latency.

## What if we kept I=64 but used 3 blocks/CU?

Removing the launch-bounds occupancy=2 -> occupancy=3:
- LDS: 20 KiB * 3 = 60 KiB (fits in 64 KiB)
- VGPR/wave: still 214, so 3 blocks * 4 warps = 12 warps/CU
- Occupancy: 12/32 = 37.5% (up from 25%)
- **Gain**: +50% in occupancy, but per-block resources are the same
  so per-block latency is unchanged. Expected speedup: 1.0-1.2x
  (limited by LDS contention at the boundary).

## What if we reduced I to 32?

Smaller tiles = more blocks per CU, but same total work split differently.
With I=32, J=16:
- tile_x: 9.5 KiB
- VGPR: probably 130-150 (estimate)
- 6 blocks/CU * 4 warps = 24 warps/CU theoretical
- Capped by launch-bounds and actual occupancy = some value between 12 and 24
- 24/32 = 75% (very high)
- But 2x as many blocks needed for same work, so per-block overhead
  (loop bookkeeping, etc.) doubles.

This is a more invasive change. The current 64/16 split is a sweet spot
for this format on RDNA3.

## Conclusion

The tile size (I=64, J=16) is well-tuned. The bottleneck is **not** tile
size but the dequantization work per K-iteration. Changing I changes the
per-block work but the per-K-iteration cost is fixed (dequant time +
MMA time). Larger I amortizes the per-block overhead but doesn't help
the dequant path.
