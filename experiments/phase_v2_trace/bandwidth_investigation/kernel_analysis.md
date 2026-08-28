# Kernel Analysis — IQ3_XXS vs Q3_K vec_dot

## Source Locations (READ ONLY)

| File | Function | Lines |
|------|----------|------:|
| `ggml/src/ggml-cuda/vecdotq.cuh` | `vec_dot_iq3_xxs_q8_1` | 1155-1188 |
| `ggml/src/ggml-cuda/vecdotq.cuh` | `vec_dot_q3_K_q8_1` (wrapper) | 883-908 |
| `ggml/src/ggml-cuda/vecdotq.cuh` | `vec_dot_q3_K_q8_1_impl_mmvq` (core) | 450-480 |
| `ggml/src/ggml-cuda/vecdotq.cuh` | `block_iq3_xxs` struct | `ggml-common.h:407-411` |
| `ggml/src/ggml-cuda/vecdotq.cuh` | `block_q3_K` struct | `ggml-common.h:391-396` |

## Block Layout (QK_K = 256, both types)

| Quant | struct (bytes) | raw quants | scales | meta |
|-------|----------------:|-----------:|-------:|------|
| IQ3_XXS | 98 | 96 (`qs[3*QK_K/8]`) | 0 (packed in `qs[96..99]` as `aux32`) | `__half d` (2 B) |
| Q3_K | 110 | 96 (`qs[QK_K/4]`) + 32 (`hmask[QK_K/8]`) | 12 (6-bit packed) | `__half d` (2 B) |

Both types store 256 quantized values per block, but Q3_K is 12 % larger (110 vs 98 B) due to the high-bit mask and 6-bit scales.

## IQ3_XXS Kernel Inner Loop (vecdotq.cuh:1155-1188)

```cpp
// Per call (one warp, one kbx, one kqs):
// 1. Load 4 bytes of quants + 4 bytes of aux32 (8 B of useful state)
const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

// 2. Unrolled 4x, per iter:
for (int l0 = 0; l0 < 8; l0 += 2) {
    //    a. GATHER from 1 KB lookup table in device global memory
    const int2 grid_pos = make_int2(
        iq3xxs_grid[q3[l0+0]],       // 4-byte global load
        iq3xxs_grid[q3[l0+1]]);      // 4-byte global load
    const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

    //    b. Bit-flip grid values by sign mask
    const int signs0 = __vcmpne4(signs & 0x08040201, 0);
    const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
    const int signs1 = __vcmpne4(signs & 0x80402010, 0);
    const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);

    //    c. Load 4 B of Q8_1
    const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0+0);
    const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0+1);

    //    d. INT8 dot product
    sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
    sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
}
```

### Properties
- **Block weight load**: 2 int reads = 8 B from the per-block `qs[]` (in VRAM).
- **Lookup table**: 2 × 4 B = 8 B fetched from `iq3xxs_grid[256]` (1024 B table) per inner iter. 4 iters → **32 B of gather loads per vec_dot call** (worst case — if every index is different).
- **Q8_1 load**: 2 × 4 B = 8 B.
- **Compute per call**: 4 iter × 2 dp4a = 8 INT8 dp4a (= 32 mul-adds = 32 INT8 ops).
- **Bytes per call (best case, lookup fully cached)**: ~24 B (8 quants + 8 Q8_1 + 8 aux32 reuses already loaded). Best case is 24 B / 32 ops.
- **Bytes per call (lookup table miss on every access)**: ~56 B (24 + 32 of gather).

### Dependency chain
1. Load `q3_packed` (1 global load) → split into 8 `q3[l]` indices
2. For each index pair `(q3[l+0], q3[l+1])`: **2 dependent global loads** to `iq3xxs_grid[]`
3. Apply sign mask → `grid_l`, `grid_h` (register-only)
4. Load `u0`, `u1` (Q8_1 already in cache after first access)
5. dp4a → `sumi`

The critical path per iter is: **1 global load (q3) → 1 dependent global load (grid) → 1 dp4a**. Latency for the first grid lookup is the chain bottleneck.

### Where does `iq3xxs_grid` live?
Defined in `ggml/src/ggml-common.h:1017-1050` as
`GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)`.
For the CUDA/HIP build (`GGML_COMMON_IMPL_CUDA`/`GGML_COMMON_IMPL_HIP`), this expands to
`static const __device__ uint32_t iq3xxs_grid[256]` — i.e. **device global memory**, not constant memory, not shared memory. Size = 1024 B.

After first access it lives in L1 (32 KB per CU) and L2 (4 MB shared). Random 4-byte access from 60 CUs is fine for L1/L2 but each gather is still a load instruction.

## Q3_K Kernel Inner Loop (vecdotq.cuh:450-480)

```cpp
// Per call (one warp, one kbx, one iqs):
// 1. Load 4 B of low-bits quants
const int vl = get_int_b2(bq3_K->qs, iqs);
// 2. Load 4 B of high-bit mask
const int vh = ~get_int_b2(bq3_K->hmask, iqs % (QI3_K/2)) >> bq8_offset;
// 3. Loop over QR3_K (=2) sub-blocks, per iter:
for (int i = 0; i < QR3_K; ++i) {
    const int isc = scale_offset + 2*i;
    //    a. Read scale (1-2 byte arithmetic on a 4 B word)
    const int sc_low  = (scales[isc_low] >> sc_shift_low) & 0xF;
    const int sc_high = ((scales[(QK_K/32) + isc_high] >> sc_shift_high) & 3) << 4;
    const int sc = (sc_low | sc_high) - 32;
    //    b. Combine low/high bits DIRECTLY (no lookup table)
    const int vil = (vl >> (2*i)) & 0x03030303;
    const int vih = ((vh >> i) << 2) & 0x04040404;
    const int vi  = __vsubss4(vil, vih);
    //    c. dp4a with Q8_1
    sumf += d8[i] * (ggml_cuda_dp4a(vi, u[i], 0) * sc);
}
```

### Properties
- **Block weight load**: 8 B (4 B `qs` + 4 B `hmask`) — slightly more than IQ3_XXS.
- **No lookup table**. The dequantized INT4 value is reconstructed from shift/and/sub operations on registers only.
- **Compute per call**: 2 iter × 1 dp4a = 2 INT8 dp4a (= 8 mul-adds) + 1 INT16 FMA for the scale.
- **Bytes per call**: 8 B (quants) + 8 B (Q8_1 already cached) + 4 B (scales, first iter) ≈ 20 B.
- **Dependency chain**: 1 global load (qs) + 1 global load (hmask) + register-only dequant + 1 dp4a. **No dependent load to a lookup table**.

### Where do Q3_K scales live?
12 bytes per block, packed in `scales[12]`. Lives in VRAM (with the rest of the block), but is only loaded once per block, then sits in L1 for the 2 inner iter steps.

## Structural Comparison

| Property | IQ3_XXS | Q3_K |
|----------|---------|------|
| Block size (bytes) | 98 | 110 |
| Bytes of state per vec_dot | 8 (qs) | 12 (qs + hmask + scales header) |
| Has lookup table? | Yes, 1024 B in device global | No |
| Dependent global loads per iter | 2 (grid l + grid h) | 0 (registers only) |
| dp4a ops per call | 8 | 2 (× 2 sub-blocks of 32 elems each) |
| Bytes per call (best case) | 24 + 8 = 32 (incl. table hit) | 20 |
| Bytes per call (table miss) | 56 | 20 |
| Critical path per inner iter | 1 grid dep-load → 1 dp4a | 1 register op → 1 dp4a |
| Iter unroll | 4 (8 elems in 2 pairs) | 2 (sub-blocks) |

### Why Q3_K is faster (per byte)
- **No gather to 1 KB table**: every weight is reconstructed with shift/and/sub on registers.
- **Fewer instructions, no memory pipeline stall**: the kernel has nothing to wait on after the initial block load.
- **Slightly larger block (110 vs 98 B)**: 12 % more data per block, but no scattered reads, so the bandwidth utilization is higher (each warp reads contiguous 32 KB of weight per row).

### Why IQ3_XXS is slower
- **Each 32-element half of the block requires 2 random 4-byte gathers into `iq3xxs_grid[]`**, which the compiler must emit as 2 dependent global loads per iter, 4 iter → 8 dependent loads per vec_dot.
- **The first `iq3xxs_grid[]` access in each vec_dot stalls the warp** until the load completes. The other 31 lanes hit the same latency (or hit cached entries).
- **More dp4a ops per vec_dot (8 vs 2)**: each dp4a has its own latency and consumes more issue slots; even with full ILP across 4 iters, the schedule is heavier.

## Launch Geometry (gfx1101, ncols_dst=1, single-token decode)

From `ggml/src/ggml-cuda/mmvq.cu:452-471` (`calc_nwarps` for `MMVQ_PARAMETERS_RDNA3_0`):
- IQ3_XXS → nwarps=1, `__launch_bounds__(32, 1)`
- Q3_K → nwarps=1, `__launch_bounds__(32, 1)`

From `calc_rows_per_block` (line 524): for RDNA3, `return 1` (no small_k promotion). So:
- block_dims = (32, 1, 1) = 1 warp
- rows_per_block = 1 (one output row per block)
- block_nums = (nrows_x, nchannels_dst, 1)

`blocks_per_iter` = `vdr * nwarps * warp_size / qi`:
- IQ3_XXS (vdr=2, qi=4): `2 * 1 * 32 / 4 = 16` kbx per iter
- Q3_K (vdr=1, qi=4): `1 * 1 * 32 / 4 = 8` kbx per iter

Initial `kbx = tid / (qi/vdr)`:
- IQ3_XXS: tid/2; first iter uses threads 0..31 (all valid for ncols_x ≥ 8*256 = 2048)
- Q3_K: tid/4; first iter uses threads 0..31 (all valid for ncols_x ≥ 8*256 = 2048)

For typical Qwen3-8B expert dim ncols_x = 1536 (blocks_per_row_x = 6):
- IQ3_XXS iter 1: threads 0..11 active (kbx 0..5), 20/32 lanes idle
- Q3_K iter 1: threads 0..5 active (kbx 0..5), 26/32 lanes idle
- Both: no second iter needed (kbx+16 or +8 ≥ 6)

So both kernels suffer similar lane under-utilization. Q3_K actually has *more* idle lanes per block (6 vs 12 active), yet is faster — confirming the bottleneck is not lane count but per-active-thread work.

## Per-block throughput (one warp, one row)

For an ncols_x=1536 row (blocks_per_row_x=6):
- IQ3_XXS: 12 active lanes × 1 vec_dot each = 12 vec_dots/block. Each vec_dot does 8 dp4a + 8 dep global loads. Total: 96 dp4a + 96 dependent global loads per row.
- Q3_K: 6 active lanes × 1 vec_dot each = 6 vec_dots/block. Each vec_dot does 2 dp4a (× 2 sub-blocks) + 0 dep global loads. Total: 12 dp4a + 0 dep global loads per row.

Bytes read per row (excl. Q8_1):
- IQ3_XXS: 12 blocks × (98 B block + ~32 B gather to table) ≈ 1560 B. If table in L1, 12 × 98 = 1176 B.
- Q3_K: 6 blocks × 110 B = 660 B.

**Per-row bytes**: IQ3_XXS reads ~1.8-2.4× more data per row than Q3_K (mainly because it uses 2× the blocks for the same K, since vdr=2).

This matches the production gap: Q3_K achieves 503.6 GB/s; IQ3_XXS achieves 350.7 GB/s. The ratio 350.7/503.6 = 0.70, in the same ballpark as the per-row byte ratio.
