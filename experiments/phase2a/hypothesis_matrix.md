# Phase-2A Hypothesis Matrix

Date: 2026-08-24
Purpose: guide Phase-2B measurement. No hypothesis is proven in this phase.
Priority: P0 = must measure in the first profiling window; P1 = measure if
window allows; P2 = optional/secondary. All priorities serve the primary
target: 40 tok/s TG with MTP OFF.

## H-2A-GEMV

- Area: IQ3_XXS MMVQ decode GEMM efficiency.
- Hypothesis: Effective IQ3_XXS GEMV bandwidth on gfx1101 is far below
  nominal 624 GB/s (plausibly 100-250 GB/s class), making weight-streaming
  the dominant MTP OFF cost at 1k-16k context. Contributing code fact:
  RDNA3 MMVQ launch table gives IQ3_XXS nwarps=1 (single wavefront) at
  ncols_dst=1 while simple quants get nwarps=8 (mmvq.cu:452-472).
- Why it matters for MTP OFF 40 tok/s: ~10.25 GB of weights are streamed
  per decode step. At 40 tok/s the whole step budget is 25 ms; weights
  alone need >= 16.4 ms even at perfect 624 GB/s. Every point of GEMV
  inefficiency directly caps the achievable tok/s ceiling.
- Evidence from Phase-1B or code audit: 22.06 tok/s @1k measured; audit
  bounds imply <= ~230 GB/s average step bandwidth even with zero other
  costs; nwarps=1 config for the dominant quant type.
- Falsification condition: traced GEMV kernel-time sum shows effective
  BW >= ~450 GB/s, i.e. GEMV <= ~23 ms per 10 steps... concretely: if
  mul_mat_vec time share is < 30% of step time at 16k, GEMV is not the
  bottleneck.
- Phase-2B measurement needed: traced 16k MTP OFF run; sum durations of
  all mul_mat_vec_* kernels; divide by known per-type weight bytes;
  report GB/s per quant type and GEMV ms/token share.
- Priority: P0.

## H-2A-QUANT

- Area: quantize_row_q8_1 activation staging around GEMV kernels.
- Hypothesis: ~500 tiny quantize launches per decode step create meaningful
  GPU scheduling gaps / tail latency around GEMVs, measurable as
  inter-kernel gaps inside graph replay even though CPU launch cost is
  hidden by graphs.
- Why it matters for MTP OFF 40 tok/s: hundreds of microsecond-class gaps
  per step can sum to several ms/token - a pure overhead tax independent
  of math efficiency.
- Evidence from Phase-1B or code audit: mmvq.cu:1332 quantizes src1 per
  op; ~497 matmul ops/step derived in code_audit sec 0/B; no cross-op
  q8_1 reuse exists.
- Falsification condition: traced quantize total + adjacent gap time <
  5% of step wall at 16k.
- Phase-2B measurement needed: kernel count + duration for quantize_row_
  q8_1*; host/device gap estimate = step wall - sum(kernel busy) per step.
- Priority: P0.

## H-2A-ATTN-STAGING

- Area: TILE flash attention whole-cache F16 staging (q4_0 KV).
- Hypothesis: At long context the dominant attention cost is not the tile
  kernel math but the per-call full-cache dequant-to-F16 round trip
  (read q4 + write f16 + re-read f16 ~= 11.8 GiB/token at 128k across 16
  dense layers), which scales linearly with context per token.
- Why it matters for MTP OFF 40 tok/s: this term alone consumes a growing
  fraction of the 25 ms/token budget as context grows; removing it
  (persistent incremental F16 sidecar direction) is the largest single
  long-context lever visible in code today.
- Evidence from Phase-1B or code audit: fattn-common.cuh:1022-1084 stages
  full K and V every call; fork commit 66dcba5eb accepted this cost to
  escape the slower VEC kernel; tg drops 20.45 -> 15.74 -> 11.98 across
  16k/63k/128k in near-linear-with-L fashion.
- Falsification condition: traced staging-kernel (to_fp16/dequantize)
  time share < 15% of step at 63k/128k.
- Phase-2B measurement needed: per-kernel times at 16k/63k/128k for
  staging vs flash_attn_tile; derive staging ms/token curve.
- Priority: P0.

## H-2A-KV-READ

- Area: KV read traffic and store path.
- Hypothesis: After staging, the FA kernel's F16 KV re-read plus per-token
  q4_0 store copies form the second-order KV term; raw q4_0 bandwidth
  itself is NOT a limiting factor at current contexts.
- Why it matters for MTP OFF 40 tok/s: decides whether future work should
  target cache layout/format or only staging elimination.
- Evidence from Phase-1B or code audit: cpy store path cpy.cu:294 +
  cpy-utils.cuh:17; KV volume arithmetic in code_audit sec D.
- Falsification condition: KV-related kernels (cpy/set_rows/staging/
  tile-KV-read attributable share) < 10% of step at 16k.
- Phase-2B measurement needed: category totals for cpy/dequantize/tile
  kernels; compare 16k vs 128k scaling slope against L-linear prediction.
- Priority: P1 (resolved together with H-2A-ATTN-STAGING in the same trace).

## H-2A-PP

- Area: Prefill kernel mix at long context.
- Hypothesis: PP degradation (485 -> 231 tok/s from 16k to 128k) comes from
  growing prefill attention tile work + KV_max mask scans + KV store
  traffic, NOT from GEMM regression; GDN chunked-scan cost is roughly
  linear and secondary.
- Why it matters for MTP OFF 40 tok/s: PP is half of perceived speed at
  long ctx; also verifies no shared dispatch pathology with decode.
- Evidence from Phase-1B or code audit: PP table 1c; audit sec F shows
  MMQ RDNA3 configs exist and staging aggregate is small (~1.5 s of 561 s
  at 128k), excluding one popular explanation.
- Falsification condition: 16k vs 128k traced PP shows GEMM (MMQ) share
  rising enough to explain > 50% of the slowdown.
- Phase-2B measurement needed: PP-phase kernel categories at 16k and 128k
  (attention tile, mask scan, MMQ, GDN scan, cpy); prompt_ms split by
  category.
- Priority: P1.

## H-2A-GRAPH

- Area: HIP graph capture/replay overhead and churn.
- Hypothesis: Graph overhead is minor for MTP OFF decode shapes at all
  contexts (Phase-1B showed only -2.6% when disabled at 16k); churn risk
  from nodes[0] key aliasing exists but is dormant in production.
- Why it matters for MTP OFF 40 tok/s: rules host-gap/graph causes in or
  out so effort goes to kernels instead; MTP ON benefits would be a bonus,
  not a target.
- Evidence from Phase-1B or code audit: A2 vs D1 diagnostic; production
  "graphs reused = 3291"; graph mechanics ggml-cuda.cu:4247-4304.
- Falsification condition: untraced-vs-traced delta or reset counters show
  recapture storms (> ~1% of steps) during any MTP OFF arm.
- Phase-2B measurement needed: grep "warmup reset"/"graphs reused" counts
  per arm from server logs; untraced sanity arm to bound trace overhead.
- Priority: P2.

## H-2A-MTP-SECONDARY

- Area: draft-mtp verify path interaction with base execution.
- Hypothesis: Verify batches (ne11 up to ~5) already route through the same
  MMVQ/TILE paths, so MTP OFF improvements transfer to MTP ON; no separate
  MTP tuning is required for the primary target.
- Why it matters for MTP OFF 40 tok/s: confirms strategy that base-path
  gains compound into user-visible MTP speeds without spec-flag changes.
- Evidence from Phase-1B or code audit: should_use_mmvq ne11<=8 covers
  verify sizes; fattn TILE serves all ncols; acceptance 0.79-0.97 stable.
- Falsification condition: trace of an MTP ON comparison arm shows verify
  batches hitting different kernels than expected (e.g. VEC, cuBLAS
  fallback) at any context.
- Phase-2B measurement needed: optional single MTP ON 16k comparison arm;
  kernel names present vs absent in trace.
- Priority: P2.

## Cross-cutting unknown kept explicit

GDN (gated_delta_net + ssm_conv) decode cost on 48 layers has NO hypothesis
ID above because there is currently no evidence pointing either way; its
kernel times fall out of the same traces as H-2A-GEMV/QUANT. If its share
exceeds ~20% of step at 16k, promote a dedicated H-2A-GDN hypothesis before
any optimization planning.
