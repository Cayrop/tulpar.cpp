# WMMA Feasibility for MMQ IQ3_XXS on RDNA3

## RDNA3 (gfx1101) WMMA Support

RDNA3 WMMA instructions available (from ROCm docs and mma.cuh):
- `v_wmma_f32_16x16x16_f16_w32` (FP16 input, FP32 accum) - 16x16x16
- `v_wmma_f32_16x16x16_bf16_w32` (BF16 input, FP32 accum) - 16x16x16
- `v_wmma_i32_16x16x16_iu8_w32` (INT8 input, INT32 accum) - 16x16x16

## Current Status: WMMA IS USED

The MMQ IQ3_XXS kernel on RDNA3 ALREADY uses
`v_wmma_i32_16x16x16_iu8_w32` via the MMA data layout path. The flow:

1. `mul_mat_q<IQ3_XXS, J, fb>` (mmq.cuh:946) calls
   `mul_mat_q_process_tile` (mmq.cuh:867).
2. `ggml_cuda_mmq_get_util_funcs<IQ3_XXS>()` (mmq.cuh:535) returns the
   MMA variants because `use_mma_data_layout()` is true on RDNA3.
3. `ggml_cuda_mmq_load_tiles_iq3_xxs` dequantizes IQ3_XXS -> int8 tile
   in LDS using the `iq3xxs_grid` lookup and sign flipping.
4. `ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma` (mmq-vec-dot.cuh:142) calls
   `mma(C, A, B)` where tiles are int32/int32/int32.
5. `mma<16, 16, int, ...>(D, A, B)` (mma.cuh:1306) for RDNA3
   calls `__builtin_amdgcn_wmma_i32_16x16x16_iu8_w32` twice
   (mma.cuh:1330-1331) to cover K=16 with two K=8 chunks.

This is **already** INT8 WMMA. So the question of "is WMMA viable" is
answered: it is viable, it is in use.

The relevant question is: **is the dequant+dot pipeline optimal**?

## IQ3_XXS to WMMA Mapping

### Option A (current): IQ3_XXS -> INT8 -> WMMA
- Status: ACTIVE.
- Throughput: 16x16x16 INT8 MAC per wmma call = 4096 INT8 ops.
- On RDNA3, two wmma calls per K=16 sub-iteration = 8192 INT8 ops.
- For the active J=16 variant with 4 warps, the 4 warps issue 2 wmma each
  = 8 wmma per K-sub-iteration. Per K-block (256 elements) = 2 sub-iter *
  8 wmma = 16 wmma. (Matches ISA count: 16 v_wmma_i32_16x16x16_iu8 in
  .LBB37_15.)
- Total INT8 MACs per K-block: 16 * 4096 = 65536. For 4 warps, that's
  16384 MACs per warp per K-block = 16384 / 32 lanes = 512 MACs/lane.

### Option B: IQ3_XXS -> FP16 -> WMMA FP16
- Would require converting each INT8 dequantized value to FP16 before
  the WMMA call.
- `v_wmma_f32_16x16x16_f16_w32` does 16x16x16 FP16 MAC = 4096 FMA ops.
- Throughput on RDNA3: 2x INT8 WMMA per cycle (I8 is 2x faster than
  FP16 typically, but the peak TOPS depends on SKU).
- Conversion cost: 1 `v_cvt_f16_i16` per INT8 element = 4 instructions
  per 4 INT8 values.
- For the IQ3_XXS path which already has FP16 d scale, the additional
  conversion is ~4 ops per element. For 256 K-elements, that's 1024 ops
  per K-block of extra work.
- Verdict: WORSE. Adds overhead for no gain.

### Option C: Format incompatible
- IQ3_XXS is 3-bit with sign bits and a 256-entry grid lookup. There is
  no direct path to any WMMA format. Dequant to INT8 (or FP16) is
  required.
- Verdict: NOT APPLICABLE.

## Comparison with Q3_K

Q3_K does NOT use a lookup table. Its dequant is register-only
(arithmetic on packed 2-bit codes). Q3_K is also a 3-bit-per-element
quant but with a different storage format.

Q3_K MMQ on RDNA3:
- Uses `vec_dot_q8_0_16_q8_1_mma` (mmq-vec-dot.cuh:481), which is
  the same MMA dispatch.
- Also uses `v_wmma_i32_16x16x16_iu8_w32`.
- VGPR/wave: 254 (more than IQ3_XXS).
- Hot loop: 1634 lines (vs 2063 for IQ3_XXS).

So Q3_K is also using WMMA but with simpler dequant (no grid lookup).
The WMMA call count is the same (16 per hot loop iter) but the
surrounding VALU work is ~25% less (1634 vs 2063 lines).

## What would improve performance?

1. **Reduce dequant VALU work** (biggest lever)
   - The `v_and/v_lshrrev/v_bfe/v_cmp/v_cndmask` chain (716 ops in
     the hot loop) consumes ~35% of the instruction count.
   - Pre-computing sign masks in a more compact form, or fusing
     multiple QR3_XXS iterations into one vector op, would reduce
     the dequant cost.
   - The lookup `iq3xxs_grid[q3[2*l+0]]` is already a single
     `global_load_d16_b16`, so it's not the bottleneck.

2. **Pipeline depth / waitcnt hiding**
   - 46 vmcnt waits in the hot loop = ~9% of total instructions.
   - Better software pipelining (issuing the next iteration's
     global_loads earlier) could hide this.

3. **LDS bank conflicts** (minor)
   - The ds_loads are large (b128 = 16 bytes per load). The sram_stride
     is 76 (4-byte units = 304 bytes per row). The MMA reads pattern
     should be checked for bank conflicts.

4. **occupancy = 2 vs 3** (limited gain)
   - As shown in occupancy_analysis.md, raising occupancy from 2 to 3
     could give up to 50% more warps/CU (12 vs 8), but the bottleneck
     is per-warp VALU work, not occupancy.

5. **MMMA peak utilization**
   - The 16 wmma calls per K-block achieve ~16384 MACs per warp.
   - RDNA3 peak INT8 TOPS: ~1700 TOPS for Navi 31 (gfx1100) or
     1657 TOPS for Navi 33 (gfx1101) at 2.5 GHz (per AMD spec, varies).
   - 16 wmma * 4096 ops / 4 cycles per wmma (estimated issue rate) =
     64 cycles per K-block for MMA. With 4 warps in flight, this is
     16 cycles per warp. The dequant chain is ~200 cycles per warp.
   - **MMA is not the bottleneck**.

## Summary

WMMA is already used (INT8, RDNA3 native). The bottleneck is dequant VALU
work, not MMA throughput. Further WMMA optimization (different format,
larger tile) is not the right direction.
