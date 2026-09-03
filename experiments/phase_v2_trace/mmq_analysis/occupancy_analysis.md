# MMQ IQ3_XXS Occupancy Analysis (gfx1101, J=16, fallback=true)

## gfx1101 Hardware Parameters

- 2 SIMDs per CU
- 32 lanes per wave (RDNA3 uses 32-wide waves by default)
- 1536 VGPRs per SIMD
- 64 KiB LDS per CU (groups 0..63; configurable up to 128 KiB on some
  Navi 3x SKUs, but the standard 64 KiB applies for gfx1101)
- MAX_WAVES_PER_SIMD = 16 (16 * 32 lanes = 512 threads/SIMD)

For reference, GEMV/Q4_0 kernel uses 12/32 lanes (occupancy ~37.5%) and
the 32-lane waves get 2-3 waves per SIMD.

## Active kernel (J=16, fallback=true) parameters

| Param        | Value | Source                                    |
|--------------|-------|-------------------------------------------|
| nthreads     | 128   | mmq-config-rdna3.cuh:211                  |
| nwarps       | 4     | 128/32 = 4                                |
| I            | 64    | mmq-config-rdna3.cuh:211                  |
| J            | 16    | mmq-config-rdna3.cuh:211                  |
| K_vram       | 256   | MMQ_ITER_K                                |
| occupancy    | 2     | target (launch bound via __launch_bounds__)|
| VGPR/wave    | 214   | .num_vgpr from .amdhsa_kernel             |
| SGPR/wave    | 36    | .numbered_sgpr                            |
| LDS per block| ~20 KiB | 19,456 (X tile) + 576 (Y tile) + 64 (ids) |

## VGPR-limited occupancy

waves_per_SIMD = floor(1536 / 214) = floor(7.18) = **7**

But the kernel declares `__launch_bounds__(128, 2)`, which requests only
2 blocks per CU. Each block has 4 warps, so 8 warps per block? No:
`nthreads=128`, `warp_size=32` => 4 warps per block. 2 blocks => 8 warps
per CU.

2 blocks * 4 warps * 32 lanes = 256 threads per CU (for this kernel).

That is 256/1024 = 25% theoretical occupancy (assuming gfx1101 has 1024
threads per CU, 2 SIMDs * 16 waves * 32 lanes = 1024). The actual
occupancy is determined by min(launch_bounds, hardware-cap).

Launch-bounded occupancy = 2 blocks * 4 warps = 8 warps per CU
8/32 = 25% (out of 32 warps per CU on RDNA3).

But VGPR limit is 7 waves/SIMD * 2 SIMDs = 14 warps per CU, so VGPR
alone would allow 14/32 = 44%. The 2 block launch-bound limits this
to 8/32 = 25%.

If we removed the launch-bounds occupancy hint, the maximum would be:
- 1536 / 214 = 7 waves/SIMD * 2 SIMDs = 14 warps
- 14 warps / 4 warps-per-block = 3.5 -> 3 blocks per CU
- 3 * 4 = 12 warps per CU
- 12/32 = 37.5%

LDS limit (assuming 64 KiB per CU):
- 20 KiB per block * 3 blocks = 60 KiB -> fits, 3 blocks per CU possible
- 20 KiB per block * 4 blocks = 80 KiB -> does not fit, capped at 3

So the maximum hardware-limited occupancy is 3 blocks per CU (12 warps,
37.5%).

The kernel uses 2 blocks per CU, which is **less than the hardware maximum
of 3**. This means the launch bound is leaving 1 block worth of resources
unused (8 KiB LDS + 7-4 = 3 wave slots / SIMD).

## SGPR

36 SGPRs per wave. 32 lanes = 1 SGPR slot, 1024 max per SIMD in RDNA3.
36 SGPRs are a non-issue (32-lane: 1 SGPR block).

## Why is occupancy 2 (not 3)?

Looking at the existing config (mmq-config-rdna3.cuh:209-220), every
J/fallback combination for IQ3_XXS uses `occupancy=2`. This is a
deliberate design choice to:
- Save LDS (20 KiB * 2 = 40 KiB, vs 60 KiB at occupancy=3)
- Avoid spills when the tile grows with larger J

For the J=16 variant, occupancy=2 is over-conservative: LDS has room for
3 blocks (60 KiB < 64 KiB).

## Comparison with Q3_K (J=16, fallback=true)

Q3_K uses 254 VGPR/wave, which is more than IQ3_XXS. So Q3_K is more
register-constrained.

For Q3_K:
- 1536/254 = 6 waves/SIMD * 2 SIMDs = 12 warps max
- 12 warps / 4 = 3 blocks max (same as IQ3_XXS if we ignore launch-bounds)
- 3 blocks * 4 warps = 12 warps = 37.5%

Q3_K also has `occupancy=2` in the config.

## Summary

| Metric                       | IQ3_XXS | Q3_K   |
|------------------------------|--------:|-------:|
| VGPR/wave                    |   214   |  254   |
| Waves/SIMD (max from VGPR)   |    7    |   6    |
| LDS/block (approx)           | ~20 KiB | ~20 KiB|
| Blocks/SIMD (LDS-limited)    |    3    |   3    |
| Launch bound (config)        |    2    |   2    |
| **Effective warps/CU**       |    8    |   8    |
| **Effective occupancy**      |   25%   |  25%   |
| Theoretical max occupancy    |   37.5% |  37.5% |

Both kernels leave ~12% of theoretical occupancy on the table due to the
conservative `occupancy=2` launch bound. Raising it to 3 would give
12.5% more warps but no LDS headroom, so it would not help in practice.

## Memory bandwidth utilization

The kernel issues 54 global_loads in the hot loop (across all threads).
For a single warp:
- Per K-block (256 elements), each thread loads:
  - 1 FP16 d scale (2 bytes)
  - 1 b32 qs word (4 bytes) via 2x `get_int_b2`
  - 1 b32 aux32 (4 bytes) - actually it's part of the qs read
- Total per K-block per thread: ~10 bytes
- For 4 warps in block * 32 threads = 128 threads
  - Per block: 128 * 10 = 1280 bytes

For RDNA3, the L1/L2 bandwidth is ~5 TB/s aggregate. At 2 blocks/CU * 32 CUs
* 1280 B/block, this is tiny - the dequant grid lookup is bandwidth-cheap.

## Note on GEMV/Q4_0 comparison

The Phase V1 analysis showed GEMV Q4_0 runs at 12/32 lane occupancy (37.5%)
with full SIMD utilization. The MMQ IQ3_XXS uses 8/32 warps (25%),
**lower than GEMV occupancy**.

This is a known limitation: MMQ tiles are large and require many registers
per thread, so even though there are 4 warps per block, the blocks are
sparse on the SIMDs.
