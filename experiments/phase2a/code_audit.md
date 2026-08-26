# Phase-2A Read-Only Code Audit

Date: 2026-08-24
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb
Binary context: build-p3/bin/llama-server (production), HIP backend, gfx1101,
build flags: GGML_HIP=ON, GGML_HIP_GRAPHS=ON, GGML_HIP_MMQ_MFMA=ON,
GGML_HIP_NO_VMM=ON, GGML_CUDA_FA_ALL_QUANTS=ON, GPU_TARGETS=gfx1101.
Method: read-only source inspection + read-only GGUF header inspection.
No code was modified. Primary focus: MTP OFF token generation.

## 0. Architecture facts that shape every path below

Verified from the GGUF header (gguf-py, weights not loaded):

| Item | Value |
|------|-------|
| Trunk layers | 64 |
| Dense full-attention layers | 16 (every 4th; attn_q/k/v/o present) |
| GDN linear-attention layers | 48 (fused attn_qkv + attn_gate + ssm_*) |
| MTP block | blk.64 (dense-type attention + nextn.* tensors) |
| Heads | 24 q / 4 kv, head size 256, GQA 6x |
| FFN | 17408, all 65 blocks |

Selection code: src/models/qwen35.cpp:21-27 falls back to
full_attention_interval=4 when attention.recurrent_layers is absent from the
GGUF (it is absent here). Graph builders:
src/models/qwen35.cpp graph::graph (137) for the trunk,
graph_mtp (489) for the draft.

Per decode step op counts (MTP OFF, derived):
- matmul ops: dense 16x4 (q,k,v,o) + GDN 48x5 (qkv,gate,beta,alpha,out)
  + FFN 64x3 + output head 1 = ~497
- flash_attn_ext ops: 16
- gated_delta_net / ssm ops: 48 (+ ssm_conv 48)
- norms/rope/activations: several hundred small kernels

Evidence strength HIGH for counts of weight-bearing tensors (GGUF-derived);
MEDIUM for exact op counts (derived from graph builders, not traced).

## A. IQ3_XXS GEMV / vec_dot path

Files and symbols:

| What | Where |
|------|-------|
| vec_dot_iq3_xxs_q8_1 | ggml/src/ggml-cuda/vecdotq.cuh:1155-1188 |
| VDR_IQ3_XXS_Q8_1_MMVQ = 2 | vecdotq.cuh:1152 |
| MMVQ type switch incl IQ3_XXS | ggml/src/ggml-cuda/mmvq.cu:30,1207-1208 |
| mul_mat dispatch chain | ggml/src/ggml-cuda/ggml-cuda.cu:1857-1869 |
| should_use_mmvq | mmvq.cu:289-373 |
| MMVQ_MAX_BATCH_SIZE = 8 | mmvq.cuh:3 |
| RDNA3 nwarps table | mmvq.cu:452-472 (MMVQ_PARAMETERS_RDNA3_0) |
| WARP_SIZE 32 | ggml/src/ggml-cuda/common.cuh:46 |

Mechanism:

1. Decode dispatch: for gfx1101 (RDNA3, non-CDNA) should_use_mmvq returns
   ne11 <= 8, so every decode-shaped matmul (batch 1..8, including MTP verify
   batches) takes ggml_cuda_mul_mat_vec_q (ggml-cuda.cu:1861-1863). Prefill
   (ne11 = ubatch) falls through to should_use_mmq -> MMQ kernels.
2. Kernel: mul_mat_vec_iq3_xxs_q8_1<...>; each thread computes one output
   element dot via vec_dot_iq3_xxs_q8_1: unpacks two int-packed iq3 grid
   lookups (iq3xxs_grid), sign handling with __vcmpne4/__vsub4, two dp4a per
   4-byte lane pair, scale from fp16 d * q8_1 ds.
3. RDNA3-specific launch config exists but EXCLUDES all IQ/K-quants except
   Q6_K: at ncols_dst=1 the whitelist (mmvq.cu:455-469) grants nwarps=8 only
   to q4_0/q4_1/q5_0/q5_1/q8_0/IQ4_NL; IQ3_XXS falls to default nwarps=1,
   i.e. a single 32-thread wavefront per workgroup handles one output row
   tile. This is the single most suspicious launch-shape fact on the primary
   weight type (~6.5 GB of IQ3_XXS FFN + GDN tensors streamed per step).
   Evidence strength HIGH (code read); expected impact for MTP OFF:
   HIGH at short/mid ctx if effective BW is far below nominal.
4. Expected bytes/token traffic: total weight stream ~= 10.25 GB/step
   (see evidence_ledger sec 2.10). At 22 tok/s (45 ms/step) the whole step
   budget implies <= ~230 GB/s average even if NOTHING else cost anything;
   if GEMV is ~50% of the step, effective GEMV BW is ~115 GB/s class.
   These are bounds, not measurements.
5. Measurement needed (Phase-2B): sum of mul_mat_vec_* kernel durations per
   step (traced run), divided by 10.25 GB known weight bytes -> effective
   GB/s; same number per quant type (IQ3_XXS vs IQ3_S vs Q3_K).

## B. quantize_q8_1 / q8 activation staging

Files and symbols:

| What | Where |
|------|-------|
| quantize_row_q8_1_cuda host wrapper | ggml/src/ggml-cuda/quantize.cu:558 |
| call site in MMVQ (per op) | mmvq.cu:1332 (allocates padded src1_q8_1 buffer each call) |
| MMQ activation quantize | mmq.cu:152,156,226-236 (quantize_mmq_q8_1_cuda family) |
| inline FA-VEC q8_1-to-shared | fattn-common.cuh:332 (quantize_q8_1_to_shared), used by fattn-vec.cuh:181 - NOT active at DK256/RDNA3 since VEC is never selected there |

Mechanism:

1. Every MMVQ matmul re-quantizes its F32 input to q8_1 immediately before
   launching the GEMV kernel. There is no cross-op reuse: ~497 matmul ops
   per decode step imply up to ~497 quantize_row_q8_1 launches per step
   (MTP OFF estimate; MEDIUM confidence until traced).
2. Each launch is tiny (~512 floats for this model's n_embd=5120 activations,
   2 KB payload), so kernel duration is likely microseconds and the cost may
   be dominated by launch/dispatch overhead rather than memory traffic.
   Under HIP graphs the CPU launch cost collapses into the captured graph,
   so the residual cost is GPU-side scheduling gaps between tiny kernels.
3. Fusion opportunity (identify only): the fork already carries fusion
   plumbing in the MMVQ/MoE path (mmvq.cu fusion->x_scale/gate_scale/
   glu_op around mmvq.cu:1295-1310), proving fused-producer patterns are
   expressible here. Candidate evidence needed before designing anything:
   (a) traced count + duration of quantize_row_q8_1 per step,
   (b) host gap distribution between quantize and GEMV kernels inside graph
   replay, (c) whether any producer->consumer pairs share identical inputs.
   Do NOT implement fusion in Phase-2B; measure first.

Evidence strength HIGH (call sites), impact UNKNOWN pending trace.

## C. Attention / flash attention / q4 KV path (head size 256)

Files and symbols:

| What | Where |
|------|-------|
| Dispatch function | ggml/src/ggml-cuda/fattn.cu:ggml_cuda_get_best_fattn_kernel (391-536) |
| Fork change enabling TILE decode | fattn.cu:527-533 (commit 66dcba5eb) |
| Tensor-core availability helpers | common.cuh:316-350 |
| Whole-cache F16 staging | fattn-common.cuh:launch_fattn 1022-1084 |
| Staging buffer alloc | fattn.cu:538-570 (dst extra data) |
| Tile configs (AMD/RDNA table) | fatnn-tile.cuh:293-297 (256/256 cases) |
| ncols2 selection (GQA 6 -> 2) | fatnn-tile.cuh:1298-1318 |
| Mask-based KV_max skip gate | fattn-common.cuh:1094 (needs Q->ne[1] >= 1024) |

Mechanism:

1. For gfx1101 with DK=DV=256, type_k=type_v=q4_0:
   - turing/volta MMA: NVIDIA-only, false.
   - amd_mfma_available: CDNA-only under !GGML_HIP_NO_MMQ_MFMA; this build
     sets GGML_HIP_NO_MMQ_MFMA=ON, so false regardless (common.cuh:332-338).
   - amd_wmma_available true on RDNA3, but the WMMA branch requires
     Q->ne[0] <= 128 (fattn.cu:515); DK=256 excludes it.
   => NO tensor-core FA path is reachable. Everything lands in the generic
   TILE vs VEC choice.
2. The generic VEC branch would take Q->ne[1] <= 2 batches (decode AND
   2-token verify), but the fork guard (fattn.cu:527) disables it for
   RDNA3 + head size 256 + quantized KV. Result: ALL attention shapes
   (decode ncols 1-2, MTP verify <= 5, prefill ubatch) use
   flash_attn_tile<256,256,ncols1,2>. Decode uses ncols1=1 (gqa_ratio 6 % 2
   path, fatnn-tile.cuh:1309-1311); RDNA tile config for ncols=2:
   nthreads=64, occupancy=8, nbatch_fa=32, nbatch_K=64.
3. Cost structure of TILE with q4_0 KV: need_f16_K/V = true forces a FULL
   dequantization of the entire used K cache and V cache to F16 staging
   buffers on EVERY attention call (fattn-common.cuh:1022-1084,
   to_fp16_cuda over ggml_nelements(K)). With 16 dense layers this is
   32 conversion launches per decode token.
   Per-token traffic at context length L:
     staging read  L x 18,432 B (q4_0 K+V, 16 layers)
     staging write L x 36,864 B (F16)
     FA kernel re-read L x 36,864 B (F16)
   At 128k: ~11.8 GiB/token total attention-side traffic vs ~10.25 GB
   weight traffic - comparable magnitude, which makes long-context decode
   plausibly attention-staging-bound rather than GEMV-bound.
   Evidence strength HIGH for mechanism; impact classification needs traces.
4. GQA effects: gqa_ratio_eff = 2 (from ratio 6); the tile kernel processes
   2 query heads per KV-head tile pass; occupancy 8 blocks/SM target.
   Whether gfx1101 reaches that occupancy at 256-wide tiles is unknown.
5. full_attention_interval=4 does NOT create SWA windows here: qwen35.cpp
   maps non-multiples to RECURRENT layers, so the KV cache holds full
   history for the 16 dense layers only; there is no sliding-window mask
   traffic. The mask-scan optimization (fattn-common.cuh:1094) stays off
   during decode (ne11 < 1024).
6. Likely dominant 128k MTP OFF attention cost: the F16 staging round trip
   plus the F16 re-read (fact 3), NOT the raw q4_0 bandwidth. Legacy report
   section 10 already sketched the fix direction (persistent F16 sidecar
   updated incrementally by set_rows; Metal precedent #23114).
7. Required Phase-2B measurement: per-kernel times for
   flash_attn_tile<...>, the to_fp16/dequantize staging kernels, and cpy
   store kernels, at 16k/63k/128k; derive ms/token shares.

## D. KV cache / staging

Files and symbols:

| What | Where |
|------|-------|
| Unified KV cache | src/llama-kv-cache.cpp/.h |
| seq_cp / state_write / state_read | llama-kv-cache.cpp:449 / 1969 / 2039 |
| Server checkpoint accounting | tools/server/server-task.cpp:1722-1728 |
| f32->q4_0 store quantization | ggml/src/ggml-cuda/cpy-utils.cuh:17 (quantize_f32_q4_0_block), cpy.cu:294 (cpy_q_f32) |

Mechanism:

1. q4_0 KV is managed directly by the unified cache; there is NO persistent
   F16 copy at the cache level. The only q4->f16 staging lives inside the
   attention launcher (sec C.3) and repeats every call.
2. Per-token KV write path: rope'd K and V are copied+quantized into cache
   views via cpy kernels: 32 small launches per token (16 layers x K,V),
   ~18.4 KB stored per token. Traffic negligible; launch count relevant.
3. --cache-prompt checkpoints: server saves/restores sequence state blobs
   (state_write/state_read + server-task checkpoint size accounting).
   Phase-1B cached reps show prompt_n=4 with 119-470 ms prompt_ms at 63k -
   that is restore copy + suffix re-prefill, not full re-prefill. Any
   Phase-2B untraced timing must use the same fresh/cached convention as
   Phase-1B or numbers will not be comparable.
4. Context checkpoints (CTX_CHECKPOINTS=4 in manifest) add VRAM copies of
   cache segments; part of the measured 13.39 GiB peak envelope.

Evidence strength HIGH (paths read); impact LOW-MEDIUM for decode,
MEDIUM for cached-rep measurement methodology.

## E. MTP / speculative path (secondary)

Files and symbols:

| What | Where |
|------|-------|
| spec type mapping "draft-mtp" | common/speculative.cpp:36 |
| draft-mtp implementation class | common/speculative.cpp:1281 (common_speculative_impl_draft_mtp) |
| hidden-state handoff API | src/llama-ext.h:93-108; llama-context.cpp:1162 (set_embeddings_nextn), :944 (get_embeddings_nextn_ith) |
| draft context construction | src/llama-model.cpp:2172-2282 (LLAMA_CONTEXT_TYPE_MTP: separate plain KV cache holding only the nextn layer) |
| nextn graph builder | src/models/qwen35.cpp:489-645 (eh_proj/enorm/hnorm concat -> transformer block -> shared head) |
| acceptance counters/metrics | tools/server/server-task.cpp:1554-1612 (spec_decode_num_draft_tokens_total, num_accepted_tokens_total, num_drafts_total, accepted_tokens_per_pos_total) |

Mechanism facts (architectural record only):

1. Target context extracts h_nextn (pre-output-norm hidden states);
   the draft context runs ONLY the nextn block over [token embd; h]
   through eh_proj. Draft-n-max 4 semantics live in the speculative loop.
2. Verify batches grow ne11 to drafted+1 tokens; those still route to MMVQ
   (ne11 <= 8) and TILE attention; graphs must tolerate varying ne11
   (property compare in sec G decides recapture vs update).
3. Existing metrics already give drafts/tokens/accepted/per-position rates;
   what they do NOT give is time attribution.
4. Minimal instrumentation points for a later phase (names only):
   common/speculative.cpp draft step entry/exit, verify batch decode call,
   and per-phase llama_decode timings surfaced as new metrics fields.
   Not prioritized; MTP OFF remains the target.

## F. PP / prefill path

Files and symbols:

| What | Where |
|------|-------|
| MMQ selection | ggml-cuda.cu:1865-1868; mmq.cu:259+ |
| RDNA3 MMQ config incl IQ3_XXS | ggml/src/ggml-cuda/mmq-config-rdna3.cuh:209-213 |
| Prefill FA dispatch | fatnn-tile via fattn.cu (same chain; ncols1 large) |
| GDN chunked scan kernel | ggml/src/ggml-cuda/gated_delta_net.cu (launch_gated_delta_net :170, S_v variants 16/32/64/128; keep_rs template) |
| ssm_conv | ggml/src/ggml-cuda/ssm-conv.cu |
| MFMA availability | common.cuh:332-338 (CDNA-only; GGML_HIP_NO_MMQ_MFMA=ON set anyway) |

Mechanism:

1. Prefill GEMMs use MMQ with an explicit RDNA3 config table for IQ3_XXS
   (SRAM layout Q8_0 entries). Matrix-instruction usage: no MFMA anywhere
   (CDNA-gated); WMMA FA path unreachable at DK=256 (sec C.1). MMQ-level
   matrix-instruction use depends on the rdna3 table flags whose meaning
   (mma bools at CASE lines) was not fully decoded - UNKNOWN, low priority
   because prefill is already fast relative to targets.
2. Prefill attention also pays the whole-cache F16 staging per dense layer
   per ubatch (same launch_fattn path). Total staging traffic across a
   fresh N-token prefill is O(N^2 / (2 x ubatch)); at 128k/ubatch 512 the
   arithmetic gives ~1.5 s aggregate - real but small against the 561 s
   measured prefill. So staging does NOT explain the PP drop.
3. Candidate causes for 485 -> 231 tok/s (16k -> 128k) remain open:
   growing FA tile work on 16 dense layers, KV_max mask scans once
   ne11 >= 1024 (fattn-common.cuh:1094), KV store writes, GDN chunked-scan
   scaling. Phase-2B must break PP down by kernel category at 16k vs 128k.

## G. Graph execution

Files and symbols:

| What | Where |
|------|-------|
| Graph compute entry | ggml/src/ggml-cuda/ggml-cuda.cu:4247-4304 |
| Graph key | ggml-cuda.cu:2581-2583 (key = cgraph->nodes[0] pointer) |
| uid fast-path ("graphs reused" log) | ggml-cuda.cu:2591-2596 |
| Property snapshot compare | ggml-cuda.cu:2585-2625 |
| Warmup rule (2 stable calls) | ggml-cuda.cu:4267-4286 ("warmup complete"/"warmup reset") |
| Exec update failure -> re-instantiate | ggml-cuda.cu:2627-2649 |
| Compatibility gate (mul_mat_id sync) | ggml-cuda.cu:2548-2579 (not triggered: model has no MoE) |

Mechanism:

1. Capture requires: graphs compiled in (GGML_HIP_GRAPHS), cc >= Volta,
   compatibility pass, then TWO consecutive calls with zero property change
   ("warmup"); afterwards every unchanged call replays the instantiated
   graph. Production log "graphs reused = 3291" matches the uid fast-path
   message (line 2593) - direct evidence graphs are active and stable in
   production for the main decode shape.
2. Keying by nodes[0] pointer means distinct plans normally get distinct
   keys, but allocator address reuse can alias keys across plan lifetimes;
   the legacy instrumented run saw resets with ZERO property mismatches and
   suspected exactly this. Current production evidence shows stable reuse,
   so this remains a documented risk, not an observed active problem.
3. MTP verify shapes: ne11 varies 1..~5 across rounds. Property compare
   includes src data pointers and ne/nb of sources; a shape-changing node
   chain either updates the exec (cudaGraphExecUpdate) or resets warmup and
   recaptures. Phase-2B should capture the reset/reuse counters from logs
   per arm (grep-able strings exist) to quantify churn under MTP ON
   comparison arms; MTP OFF decode shape is static and stable.

## H. Audit summary table

| Area | Evidence strength | Expected MTP-OFF impact | Phase-2B measurement |
|------|-------------------|-------------------------|----------------------|
| A IQ3_XXS GEMV (nwarps=1 on RDNA3) | HIGH | HIGH | traced mul_mat_vec time sums -> effective GB/s |
| B quantize_q8_1 staging | HIGH (sites) | UNKNOWN | launch count + duration per step; gap analysis |
| C TILE FA + whole-cache F16 staging | HIGH | HIGH at 63k/128k | staging vs tile kernel ms/token |
| D KV cache/store + checkpoints | HIGH | LOW-MED | cpy/set_rows times; fresh-vs-cached discipline |
| E MTP path | HIGH | secondary | none required (metrics exist) |
| F PP/prefill breakdown | MED-HIGH | MED | 16k vs 128k PP kernel category split |
| G HIP graphs | HIGH | LOW at 16k (measured) | reset/reuse counters per arm |
