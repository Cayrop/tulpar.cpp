# Subagent-G: GEMM Routing & WMMA Audit

Phase-5 audit of routing decode workloads from MMVQ (GEMV) to MMQ (GEMM) for
IQ3_XXS on gfx1101 (RX 7800 XT, RDNA3), plus ISA verification of WMMA usage in
the MMQ kernel and a synthetic MMQ-vs-MMVQ benchmark at Phase-4E shapes.

## 1. MMQ dispatch chain

Dispatch order in `ggml_cuda_mul_mat` (ggml-cuda.cu:1837-1869):
MMVF -> MMF -> **MMVQ** -> **MMQ** -> cuBLAS. MMVQ is consulted first, so
whenever `should_use_mmvq` returns true, MMQ is never reached.

- `should_use_mmvq` (mmvq.cu:289-373): NVIDIA/CDNA have per-type tables; AMD
  RDNA has none, so gfx1101 falls through to the generic
  `return ne11 <= MMVQ_MAX_BATCH_SIZE;` (mmvq.cu:372).
  `MMVQ_MAX_BATCH_SIZE = 8` (mmvq.cuh:3).
- `should_use_mmq` (mmq.cu:259-383): IQ3_XXS is a supported type. For RDNA3
  with WMMA available (`amd_wmma_available`, common.cuh:340-342), IQ3_XXS hits
  the `default: return true;` case (mmq.cu:367) - i.e. MMQ claims ALL ne11.
  The only reason it does not run today is that MMVQ wins the earlier check.

Consequences:

- MTP verify batches (ne11 = 4-5) currently take MMVQ because `4 <= 8`.
- Changing the threshold to `ne11 <= 1` would make ne11 = 2..8 fall through to
  MMQ, which accepts them (`should_use_mmq == true`). The change belongs in
  the generic fallthrough at mmvq.cu:372 (or an RDNA3-specific table), not in
  mmq.cu. There is no runtime env-var override; `GGML_CUDA_FORCE_MMQ`
  (mmq.cu:320) is compile-time only and would NOT bypass MMVQ anyway since it
  only affects `should_use_mmq`.
- Minimum ne11 for MMQ activation on gfx1101 as built today: ne11 = 9
  (first value where `should_use_mmvq` returns false).

## 2. MMQ RDNA3 config for IQ3_XXS

mmq-config-rdna3.cuh:209-220 defines 12 entries for IQ3_XXS. Decoded via the
CASE macro (mmq.cuh:206-214) and struct ggml_cuda_mmq_config (mmq.cuh:165-178):

| J (dst tile) | nthreads | occupancy | I | sram_layout | K_vram | stream_k |
|--------------|----------|-----------|-----|-------------|--------|----------|
| 16, 32       | 128      | 2         | 64  | Q8_0        | 256    | false    |
| 48..128      | 256      | 2         | 128 | Q8_0        | 256    | false    |

(fallback=true variants: J=16/32 nthreads=128; fallback=false adds J=48..128
with nthreads=256.)

Field meaning: I = tile along src0 rows / dst cols (N), J = tile along
src1->ne[1] (batch tokens, M). There is no explicit "use_mma" flag in the
config; MMA data layout is implied for RDNA3 by
`use_mma_data_layout()` returning true when `AMD_WMMA_AVAILABLE` is defined
(mmq.cuh:196-202, common.cuh:269-271). `rows_per_warp()` = 16 on WMMA builds.

Kernel selection for small batch (mmq.cuh:1469-1494): `mul_mat_q_switch_J`
picks the smallest config J with `ceil(ne11/J) == 1`. For any ne11 <= 16 that
is J=16 -> kernel `mul_mat_q<IQ3_XXS, 16, fallback=0>` (fallback=0 because
ne01 % 128 == 0 for both FFN shapes). Grid: nty x ntx=1, independent of ne11
within one J-tile.

The MMA vec_dot used is `ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma` with DS layout
D4 (mmq.cuh:803-808): `load_tiles_iq3_xxs` dequantizes LUT-based IQ3_XXS into
q8_0-style int tiles in shared memory, then 16x16x16 int8 MMA tiles are fed to
`mma(C, A, B)`.

**WMMA usage per source: YES** (for RDNA3 builds).

## 3. ISA disassembly findings

Method (same as Subagent-A): objcopy dump `.hip_fatbin` from
build-p3/bin/libggml-hip.so -> clang-offload-bundler unbundle
hipv4-amdgcn-amd-amdhsa--gfx1101 -> split nested code objects by ELF magic ->
co_098.o holds all `mul_mat_q<ggml_type18, J, fb>` instantiations -> llvm-objdump.

Disassembly saved under raw/: mmq_iq3_xxs_J16.s (2311 lines),
mmq_iq3_xxs_J64.s (2103 lines).

For `_ZL9mul_mat_qIL9ggml_type18ELi16ELb0EE...` (the exact instantiation that
MTP verify shapes would use):

- **WMMA instructions present: YES**
  - 16x `v_wmma_i32_16x16x16_iu8` per unrolled K-block (raw/mmq_iq3_xxs_J16.s:1957-2184)
  - Variant: `v_wmma_i32_16x16x16_iu8` - RDNA3 16x16x16 int8 WMMA, w32 wave,
    accumulating into VGPR quads-pairs chained across calls, operands loaded
    from LDS via `ds_load_b128`. `neg_lo:[1,1,0]` handles signed quant values.
  - Kernel metadata: 193 VGPRs, 0 AGPRs, 128 threads/block (J=16 config).
  - The J=64 instantiation contains the same 16 WMMA ops per block.
- `v_mfma_*`: absent (CDNA-only, correct).
- `v_dot4_i32_iu8` / scalar dot products: absent from the MMA kernel body.
- Global loads (`global_load_b32/b64`) stage quantized weights + q8_1
  activations into LDS; all math flows through WMMA.

Conclusion: MMQ for IQ3_XXS on RDNA3 is a genuine WMMA tensor-core path, not a
scalar/LDS-dot GEMM.

## 4. Fused GLU / ncols_dst

- RDNA3_0 MMVQ table (mmvq.cu:452-472): ncols_dst=1 whitelist gives
  IQ3_XXS nwarps=1 (default case); every ncols_dst > 1 also returns 1.
  ncols_dst=2 does NOT change nwarps or the table.
- Fused mul_mat_vec_q + GLU exists (ggml-cuda.cu pattern {MUL_MAT, MUL_MAT,
  GLU} at :3766-3803 and MoE variants) but is hard-restricted to
  **ncols_dst == 1**: `mul_mat_vec_q_switch_fusion` asserts
  "fusion only supported for ncols_dst=1" (mmvq.cu:861-872), and
  `should_fuse_mul_mat_vec_q` requires dst->ne[1] == 1 for MUL_MAT
  (ggml-cuda.cu:1805-1807).
- Production model Qwen3.8-27B-UD-Q2_K_XL uses separate ffn_gate/ffn_up
  tensors (src/models/qwen35.cpp:92-94, build_ffn at :477-479), so the
  {mul_mat, mul_mat, GLU} fusion pattern matches. At batch=1 decode the fused
  GLU path IS active (one kernel computes gate+up+GLU); at MTP verify
  (ne[1] = 4-5) it is disabled and gate/up run as two separate MMVQ kernels
  with ncols_dst=4/5.

## 5. Synthetic benchmark results

Harness: experiments/phase5/subagent_g/bench_gemm_routing.cpp, linked against
the stock build-p3 libraries (dispatch untouched). Raw data: results.csv.
30 timed iterations after 5 warmups, min reported. Random weights quantized
once on host; identical bytes fed to GPU and CPU reference.

Key dispatch fact making this benchmark valid for the routing question:
MMQ time is flat across one J-tile (measured n=9/12/16 within 0.2%), because
kernel, grid, and K-loop do not depend on ne11 <= J=16. Therefore measured
MMQ(n=9..16) equals what forced MMQ(n=4-5) would cost.

ffn_down W[5120x17408] iq3_xxs (32.5 MiB weights):

| n | path | ms (min) | eff GB/s | GFLOPS |
|-----|------|---------|----------|--------|
| 1 | MMVQ | 0.160 | 213.0 | 1113 |
| 2 | MMVQ | 0.171 | 199.0 | 2080 |
| 4 | MMVQ | 0.195 | 175.3 | 3664 |
| 5 | MMVQ | 0.208 | 164.0 | 4284 |
| 8 | MMVQ | 0.240 | 142.0 | 5936 |
| 9 | MMQ | 0.254 | 134.4 | 6318 |
| 12 | MMQ | 0.254 | 134.6 | 8436 |
| 16 | MMQ | 0.255 | 133.6 | 11168 |
| 32 | MMQ | 0.317 | 107.6 | 17991 |
| 64 | MMQ | 0.456 | 74.9 | 25028 |

gateup W[17408x5120] iq3_xxs (32.5 MiB weights):

| n | path | ms (min) | eff GB/s | GFLOPS |
|-----|------|---------|----------|--------|
| 1 | MMVQ | 0.158 | 216.6 | 1132 |
| 2 | MMVQ | 0.169 | 201.5 | 2105 |
| 4 | MMVQ | 0.196 | 174.1 | 3637 |
| 5 | MMVQ | 0.209 | 163.1 | 4260 |
| 8 | MMVQ | 0.315 | 108.5 | 4534 |
| 9 | MMQ | 0.318 | 107.2 | 5042 |
| 12 | MMQ | 0.320 | 106.6 | 6684 |
| 16 | MMQ | 0.321 | 106.5 | 8900 |
| 32 | MMQ | 0.378 | 90.2 | 15085 |
| 64 | MMQ | 0.622 | 54.9 | 18356 |

Control: ffn_down_f16_ctrl n=4 -> max abs err vs CPU 2.2e-4 (float rounding
only), proving the harness itself is exact and the IQ3_XXS error below comes
from int8 activation quantization, not measurement artifacts.

Bit-exactness verdict: neither MMVQ nor MMQ is bit-exact against the F32 CPU
reference (both quantize activations to q8_1). Max abs err ~0.47-1.04 over
output ranges of +-70 (K=5120) / +-130 (K=17408), i.e. ~0.7-1% relative -
consistent between MMVQ and MMQ, as expected for the shared q8_1 activation
quantization. This matches llama.cpp test tolerances (NMSE ~1e-4 range) and
does NOT indicate a kernel defect.

Observations:

- Forced MMQ routing at MTP verify sizes would cost ~0.254 ms (ffn_down) /
  ~0.318 ms (gateup) vs MMVQ 0.195-0.209 ms: MMVQ wins by ~30% (ffn_down) and
  ~50% (gateup) per matmul.
- Even at n=8 MMVQ still beats MMQ on ffn_down (0.240 vs 0.254).
- Effective bandwidth peaks at ~215 GB/s (n=1 MMVQ) versus ~624 GB/s hardware
  peak: both paths are latency/occupancy limited at decode batch sizes, and
  MMQ's WMMA throughput does not convert into bandwidth at these sizes.
- Anomaly worth noting separately: gateup MMVQ regresses sharply at n=8
  (0.315 ms, +50% over n=5) while ffn_down does not (0.240 ms, +15%).

## 6. Verdict

- Is GEMM routing viable for MTP verify? **NO** - MMQ costs +30%/+50% more per
  matmul than MMVQ at ne11=4-5 (measured via the flat-in-J-tile property).
- Is GEMM routing viable for MTP OFF (batch=1)? **NO** - MMQ is ~59% slower
  (0.254 vs 0.160 ms ffn_down; 0.318 vs 0.158 ms gateup). Additionally batch=1
  already gets the fused GLU single-kernel path, which routing away would lose.
- Does MMQ use WMMA on RDNA3 for IQ3_XXS? **YES** - `v_wmma_i32_16x16x16_iu8`
  confirmed in the shipped binary for `mul_mat_q<IQ3_XXS, J, fb>` kernels.
- Recommended next step: close the GEMM-routing hypothesis. The remaining
  decode-side levers are outside kernel routing; if anything is pursued, the
  gateup ncols_dst=8 regression (Section 5 anomaly) and extending fused GLU to
  ncols_dst>1 are the only concrete leads observed here, neither of which
  involves MMQ.

## 7. Files produced

- experiments/phase5/subagent_g/bench_gemm_routing.cpp - harness source
- experiments/phase5/subagent_g/bench_gemm_routing - compiled binary
- experiments/phase5/subagent_g/results.csv - raw measurements
- experiments/phase5/subagent_g/raw/mmq_iq3_xxs_J16.s - disassembly,
  mul_mat_q<IQ3_XXS, 16, false> (contains v_wmma)
- experiments/phase5/subagent_g/raw/mmq_iq3_xxs_J64.s - disassembly,
  mul_mat_q<IQ3_XXS, 64, false>
