# Phase-1 GOD-MODE TRACE - Ultimate Profiling Report (V3)

Date: 2026-08-26, window 02:22-05:20 (+03).
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Binary: build-p3/bin/llama-server, sha256 280556cca031...ad070c13 (Phase-1B fingerprint match).
Model: Qwen3.8-27B-UD-Q2_K_XL.gguf V3, sha256 fd4730dd...2ddb0 (recomputed this window).
GPU: AMD Radeon RX 7800 XT (gfx1101), ROCm 7.2.4, rocprofv3 1.1.0.
Scope: MEASUREMENT ONLY. No kernel, build, model, or flag changes. No commits.
Machine-readable twin: experiments/phase1/phase1_attribution.json.
Deviations/blockers: experiments/phase1/phase1_blockers.md.

## 0. Execution summary

- Pre-flight P1-0a found production DOWN at window start (pidfile PID 96742 dead,
  port 8080 silent); relaunched via prod_start.sh -> PID 106088 validated
  (/proc exe = build-p3), health ok, then stopped via prod_stop.sh to free port 8080.
- Untraced ladder U-{1k,16k,63k,128k,131k}-OFF + U-{1k..128k}-ON: all OK, spreads
  < 1% (two ON arms re-run 5-rep per Phase-1B rerun policy).
- Traced arms T-{1k,16k,63k,128k,131k}-OFF and T-{1k,16k,63k,128k}-ON: one
  rocprofv3 --kernel-trace --stats instance each, probe prefill (n_predict=1)
  + cached decode (n_predict=32). All 9 OK; every stop required SIGKILL
  escalation per ops/docs/traced_server_signal_behavior.md; all traces flushed
  intact (verified by internally consistent call counts, e.g. exactly 2018
  kernels/step and 32 FA-tile pairs/token on every OFF arm).
- VRAM guard never tripped. Traced peaks were BELOW untraced peaks
  (e.g. T-131k-OFF 12.74 GiB traced vs 13.30 GiB untraced): rocprofv3 kernel
  tracing adds no measurable device memory. T-128k-ON peak sampled 14.74 GiB
  (rocm-smi spot checks during the run read ~15.8 GB absolute incl. desktop).
- Overhead gate PASSED on all arms (max 8.2% OFF step-period method; max 24.0%
  ON server-timing method at 16k, flagged marginal but under the 25% line).
- Production restored at end of window; RESTORE_OK with 6/6 semantic match.

## 1. Untraced baselines (overhead-gate denominators)

Server-reported timings; rep1 fresh prefill, remaining reps cached;
greedy temp 0 top_k 1 seed 1234; same prompt family as Phase-1B
(make_text seeds 4201024/555001/777001/888111/888112 + summarize suffix);
context right-sized per arm as in Phase-0 ladder.

| arm | ctx used | prompt_n | reps | tg tok/s med | spread | pp fresh | acc | vram peak |
|-----|----------|----------|------|--------------|--------|----------|-----|-----------|
| U-1k-OFF   | 2048   | 991    | 4 | 23.481 | 0.42% | 518.17 | - | 10.45 GiB |
| U-16k-OFF  | 17408  | 16390  | 3 | 21.594 | 0.19% | 494.42 | - | 10.74 GiB |
| U-63k-OFF  | 64512  | 63528  | 3 | 16.477 | 0.21% | 339.66 | - | 11.77 GiB |
| U-128k-OFF | 131072 | 129487 | 3 | 12.507 | 0.53% | 234.39 | - | 13.33 GiB |
| U-131k-OFF | 135168 | 131032 | 3 | 12.481 | 0.33% | 232.57 | - | 13.30 GiB |
| U-1k-ON    | 2048   | 991    | 4 | 40.692 | 0.68% | 496.79 | 0.9205 | 11.95 GiB |
| U-16k-ON r2| 17408  | 16390  | 5 | 44.181 | 0.91% | 483.45 | 1.0000 | 12.41 GiB |
| U-63k-ON   | 64512  | 63528  | 3 | 31.908 | 0.86% | 326.24 | 0.9190 | 13.61 GiB |
| U-128k-ON r2 | 131072 | 129487 | 5 | 24.795 | 1.04% (cached-only 0.17%) | 224.32 | 1.0000 | 15.37 GiB |

Environment equivalence vs Phase-1B V3 baseline: every arm within +/-1.4%
(e.g. off-16k 21.594 vs 21.809 = -1.0%; off-63k 16.477 vs 16.440 = +0.2%;
on-63k 31.908 vs 32.114 = -0.6%). U-16k-ON first pass spread 1.25% and
U-128k-ON 2.10% exceeded the gate; 5-rep re-runs brought them to 0.91% and
1.04% respectively (cached-rep-only spread at 128k: 0.17%; fresh rep is the
outlier). Values reported above are the compliant runs.
U-131k-ON NOT RUN per task red line (would not fit).

## 2. Overhead gate (BLOCKER condition)

Two denominators reported: step-period method (median marker-to-marker between
consecutive lm_head GEMV markers over clean steps; primary, matches Phase-2B)
and server-timings method for cross-check.

| arm | untraced ms/tok | traced step period ms | overhead (step period) | traced server tg | overhead (server) |
|-----|-----------------|----------------------|------------------------|------------------|-------------------|
| T-1k-OFF   | 42.539 | 46.017 | +8.2% | 22.137 tok/s | +5.7% |
| T-16k-OFF  | 46.287 | 49.575 | +7.1% | 20.562 tok/s | +4.8% |
| T-63k-OFF  | 60.689 | 64.004 | +5.5% | 15.946 tok/s | +3.2% |
| T-128k-OFF | 79.879 | 82.782 | +3.6% | 12.328 tok/s | +1.4% |
| T-131k-OFF | 80.225 | 83.113 | +3.6% | 12.274 tok/s | +1.7% |
| T-1k-ON    | 24.572 | n/a (aggregate mode) | - | 33.677 tok/s | +17.2% |
| T-16k-ON   | 22.625 | n/a | - | 33.572 tok/s | +24.0% (marginal, flagged) |
| T-63k-ON   | 31.305 | n/a | - | 28.819 tok/s | +9.8% |
| T-128k-ON  | 40.330 | n/a | - | 23.277 tok/s | +6.1% |

Verdict: no BLOCKER. All arms under 25%. Absolute traced timings usable;
relative shares remain primary. MTP ON traced shares carry the larger
uncertainty (server-average includes stochastic profiler flush stalls).

## 3. Decode attribution per token, MTP OFF (kernel busy by category)

Clean-step means; 28 clean steps used per arm (of 31 segments; exclusions are
profiler buffer-flush stall steps and the cache-restore head segment).

ms/token by category:

| category | 1k | 16k | 63k | 128k | 131k |
|----------|----|----|----|------|------|
| GEMV IQ3_XXS | 9.491 | 9.519 | 9.506 | 9.525 | 9.526 |
| GEMV IQ2_S | 6.898 | 6.924 | 6.909 | 6.896 | 6.890 |
| GEMV IQ2_XXS | 5.021 | 5.029 | 5.034 | 5.035 | 5.023 |
| GEMV IQ3_S | 4.548 | 4.559 | 4.555 | 4.546 | 4.545 |
| GEMV IQ2_XS | 3.338 | 3.345 | 3.342 | 3.343 | 3.339 |
| attention FA tile (+combine) | 0.299 | 2.331 | 9.376 | 17.031 | 17.253 |
| staging dequant (K/V->F16) | 0.104 | 1.423 | 8.736 | 19.646 | 19.875 |
| norm/rope/act elementwise | 1.706 | 1.720 | 1.694 | 1.705 | 1.703 |
| GEMV Q4_K (incl. lm_head) | 1.488 | 1.495 | 1.487 | 1.487 | 1.487 |
| GEMV IQ4_XS | 1.001 | 1.084 | 0.993 | 0.991 | 0.990 |
| GEMV IQ1_S | 0.946 | 0.967 | 0.946 | 0.947 | 0.946 |
| GEMV Q2_K | 0.714 | 0.715 | 0.713 | 0.713 | 0.711 |
| quantize_row_q8_1 | 0.646 | 0.650 | 0.637 | 0.642 | 0.660 |
| emb/state get_rows (F32) | 0.535 | 0.538 | 0.533 | 0.531 | 0.531 |
| GDN (gated_delta_net+ssm_conv+fwht) | 0.513 | 0.528 | 0.524 | 0.530 | 0.528 |
| GEMV Q3_K | 0.315 | 0.315 | 0.315 | 0.316 | 0.317 |
| GEMV Q8_0 (ssm alpha/dt, tiny) | 0.255 | 0.255 | 0.255 | 0.247 | 0.245 |
| KV store/copy (set_rows_quant/cpy) | 0.219 | 0.217 | 0.216 | 0.210 | 0.209 |
| other (copyBuffer/sampling glue) | 0.144 | 0.142 | 0.142 | 0.142 | 0.142 |
| GEMV IQ1_M | 0.035 | 0.035 | 0.035 | 0.035 | 0.035 |
| GEMV Q5_K | 0.022 | 0.022 | 0.022 | 0.022 | 0.022 |
| **step period (median)** | **46.02** | **49.57** | **64.00** | **82.78** | **83.11** |
| kernel busy total | 38.24 | 41.81 | 55.97 | 74.54 | 74.98 |
| non-stall gaps + sampling tail | 7.83 | 7.80 | 8.00 | 8.23 | 8.17 |

Launch counts per token (identical at every context, graph-deterministic):
102 IQ3_XXS, 96 Q8_0, 64 IQ2_S, 51 IQ3_S, 43 IQ2_XXS, 31 IQ2_XS, 21 Q4_K,
17 IQ4_XS, 15 Q2_K, 14 IQ1_S, 5 Q3_K, 2 Q5_K, 1 IQ1_M; 462 quantize_row_q8_1,
160 GDN kernels, 32 FA tile + 32 combine, 32 staging dequant, 64 KV store,
670 norm/rope/act, 97 F32 get_rows (embedding + 48x2 GDN state gathers).

Structural reading:
- Weight streaming (all GEMV) is context-flat at ~34.1 ms/tok; it is 89% of
  busy at 1k but 45.7% at 128k.
- Attention-side (staging + tile + store) grows from 0.62 ms/tok (1k) to
  36.89 ms/tok (128k) = 49.5% of busy / 44.6% of step period at 128k.
  At 128k/131k staging alone (19.65/19.88 ms/tok) is the #1 cost, ahead of
  IQ3_XXS GEMV (9.52); tile is #2 attention cost (17.03/17.25).
- Everything else is flat: GDN ~0.53 ms/tok (~0.8% of busy at 128k),
  quantize ~0.65, KV store ~0.21, norms ~1.7.
- flash_attn_ext_vec: ZERO launches everywhere (tile dispatch confirmed; no
  VEC surprise).
- New-vs-V2 shape: V2's single dominant GEMV type (IQ3_XXS 68% of busy @16k)
  is replaced by five co-dominant types (IQ3_XXS 23%, IQ2_S 17%, IQ2_XXS 12%,
  IQ3_S 11%, IQ2_XS 8% at 16k). All prior V2 per-type attribution is void.

## 4. Effective bandwidth per quant type (decode, MTP OFF)

eff_BW = streamed weight bytes per step (experiments/phase0/
v3_quant_distribution.json, MTP OFF stream table) / mean kernel time per token.
Nominal 624 GB/s. LB = launch-bound (tiny tensors, BW not meaningful).

| type | bytes/step | eff GB/s (1k/16k/63k/128k) | % nominal | verdict |
|------|------------|-----------------------------|-----------|---------|
| IQ3_XXS | 2,480,701,440 | 261 / 261 / 261 / 260 | 41.8% | low, unchanged vs V2 (265.7) |
| IQ2_S   | 1,534,935,040 | 222 / 222 / 222 / 223 | 35.6% | LOW - worst large type |
| IQ3_S   | 1,297,612,800 | 285 / 285 / 285 / 285 | 45.7% | low-mid |
| IQ2_XXS |   919,142,400 | 183 / 183 / 183 / 182 | 29.3% | LOWEST of the big types |
| Q4_K    |   803,635,200 | 540 / 538 / 540 / 540 | 86.5% | excellent |
| IQ2_XS  |   668,344,320 | 200 / 200 / 200 / 200 | 32.0% | LOW |
| IQ4_XS  |   551,485,440 | 551 / 509 / 555 / 557 | 88-89% | excellent |
| IQ1_S   |   348,160,000 | 368 / 360 / 368 / 368 | 59% | mid |
| Q2_K    |   285,573,120 | 400 / 400 / 400 / 401 | 64% | mid |
| Q3_K    |   105,881,600 | 336 / 336 / 336 / 335 | 54% | mid |
| Q8_0    |    25,067,520 | ~100 (LB, 96 tiny launches) | - | launch-bound |
| IQ1_M   |    11,468,800 | n/m (LB, 1 launch) | - | launch-bound |
| Q5_K    |     7,208,960 | n/m (LB-scale, 2 launches) | - | too small |
| TOTAL streamed | 9,049,798,656 | 265.6 aggregate (flat across ctx) | 42.6% | |

Key facts:
- Aggregate effective weight-stream bandwidth is 264-266 GB/s (42.5-42.6% of
  nominal) at EVERY context - statistically identical to V2's 269.4 GB/s
  despite the completely different type mix.
- The new IQ2 family streams SLOWER than IQ3_XXS: IQ2_XXS 183 GB/s (-30% vs
  XXS), IQ2_XS 200 (-23%), IQ2_S 222 (-15%). Together they carry 3.12 GB/step
  (34% of stream) at an average ~208 GB/s. If they ran at IQ3_XXS's 261 GB/s,
  ~2.0 ms/token would be saved (about +4% tg at 16k).
- 4-bit K-quants (Q4_K lm_head/output, IQ4_XS) run at 86-89% of nominal -
  near peak. The deficit is specific to the i-qant IQ2/IQ3 gather-heavy
  formats, consistent with the Phase-3 synthetic diagnosis (latency-bound
  dequant gather chain).

## 5. Attention staging analysis

Byte model per token of context (16 dense layers, GQA kv dim 1024, q4_0 KV):
staging reads L x 18,432 B (q4_0 K+V) and writes L x 65,536 B (F16);
FA tile re-reads L x 65,536 B (F16). Same model as Phase-2B corrected math.

| ctx | staging ms/tok | tile ms/tok | KV store ms/tok | staging eff GB/s (r+w) | tile eff GB/s (reread) | attn total ms/tok (% of busy) |
|-----|---------------|-------------|-----------------|------------------------|------------------------|-------------------------------|
| 1k   | 0.104  | 0.299  | 0.219 | 797 | 217 | 0.62 (1.6%) |
| 16k  | 1.423  | 2.331  | 0.217 | 967 | 461 | 3.97 (9.5%) |
| 63k  | 8.736  | 9.376  | 0.216 | 611 | 444 | 18.33 (32.7%) |
| 128k | 19.646 | 17.031 | 0.210 | 553 | 498 | 36.89 (49.5%) |
| 131k | 19.875 | 17.253 | 0.209 | 554 | 498 | 37.34 (49.8%) |

Scaling analysis:
- Staging time ratios vs context growth: 16k->63k x6.14 time for x3.88 tokens
  (SUPERLINEAR); 63k->128k x2.25 for x2.04 (mildly superlinear);
  16k->128k x13.8 for x7.9. 1k->16k is SUBlinear (x13.6 time for x16.5 tokens).
- Tile scales near-linearly above 16k (x7.31 for x7.9 from 16k->128k) and is
  sublinear below.
- Implied staging bandwidth: >900 GB/s class at 16k (impossible from DRAM),
  collapsing to DRAM-class 553-611 GB/s at 63k+. The crossover sits between
  16k and 63k in this dataset. The analytic per-layer staged working set
  (1152 B x L) crosses the 64 MiB Infinity Cache at L ~= 58.2k; the measured
  collapse is consistent with that boundary. As in Phase-2B this capacity
  explanation remains a HYPOTHESIS (consistent, not directly proven); the
  added 131k point (554 GB/s, flat vs 128k) strengthens DRAM-convergence.
- Verdict for Phase-2 planning: at 128k, whole-cache-per-call F16 staging is
  the single largest decode cost (26.4% of busy). A persistent incremental F16
  sidecar would remove up to ~19.6 ms/token of DRAM traffic IF the sidecar
  stays IC-resident or is written incrementally (design question, not solved
  here).

## 6. Inter-kernel gap analysis (decode OFF)

Idle inside clean steps (< 5 ms gaps; >= 5 ms events counted separately as
profiler flush stalls):

| metric | 1k | 16k | 63k | 128k | 131k |
|--------|----|----|----|------|------|
| gaps per step | ~2017 | ~2016 | ~2016 | ~2016 | ~2016 |
| median gap | 3.4 us | 3.4 us | 3.4 us | 3.4 us | 3.4 us |
| p95 / p99 gap | 3.8 / 4.2 us | 3.8 / 4.4 us | 3.8 / 4.4 us | 3.8 / 4.4 us | 3.8 / 4.4 us |
| max non-stall gap | 0.54 ms | 0.36 ms | 0.54 ms | 0.54 ms | 0.38 ms |
| non-stall gap total ms/tok | 7.199 | 7.191 | 7.218 | 7.233 | 7.221 |
| sampling tail ms/tok (median) | 0.63 | 0.61 | 0.78 | 1.00 | 0.95 |
| total GPU idle ms/tok | 7.83 | 7.80 | 8.00 | 8.23 | 8.17 |
| stall events (>5 ms) per 32-tok run | 2 | 2-3 | 2 | 2 | 2 |

Top transition contributors at 16k (summed idle per token, mean per event):

| transition | ms/tok | count/tok | mean |
|------------|--------|-----------|------|
| quantize_q8_1 -> mul_mat_vec_q | 1.59 | 462 | 3.44 us |
| unary_gated_op_kernel -> quantize_q8_1 | 0.475 | 141 | 3.37 us |
| rms_norm_f32 -> quantize_q8_1 | 0.432 | 128 | 3.38 us |
| mul_mat_vec_q -> rms_norm_f32 | 0.404 | 112 | 3.61 us |
| mul_mat_vec_q -> k_bin_bcast | 0.331 | 96 | 3.45 us |
| mul_mat_vec_q -> unary_gated_op_kernel | 0.274 | 77 | 3.56 us |

Gap-before-category split at 16k (ms/token idle before each category):
GEMV_IQ3_XXS 1.66, NORM_ROPE_ACT 1.53, QUANT_ROW 1.09, GEMV_IQ2_S 0.71,
OTHER 0.52, GEMV_IQ2_XXS 0.44, GDN 0.39, GEMV_IQ3_S 0.35, remaining < 0.3 each.

Reading (same conclusion as V2, now for V3's fatter graph): idle is real
(~7.8-8.2 ms/token = 9-17% of step period depending on ctx) but DISTRIBUTED -
~2016 micro-gaps of median 3.4 us around 2018 kernels/step; no single bubble.
The quantize->GEMV adjacency is the biggest bucket (1.59 ms/tok) simply
because it fires 462x/token. With graphs active (sec 7) this is GPU/stream
scheduling floor, not CPU launch latency. Below the 10 ms/ms-token promotion
threshold of task section 8.5.

## 7. Graph behavior verification

- Zero "warmup reset" events in ALL 20 instance logs (11 untraced incl.
  reruns + 9 traced).
- Every OFF traced arm: last "graphs reused" counter == generated tokens
  exactly (32/32) => 100% of decode steps replayed captured graphs while
  rocprofv3 traced them; the trace contains the full graph-replayed stream
  (deterministic 2018-kernel steps prove replay, not eager re-launch).
- ON traced arms: reuse counters recorded (probe=1, main=4-5); semantics of
  the counter differ under the speculative multi-plan flow, but zero resets +
  nonzero reuse confirm graphs active there too. Kernel counts per round are
  consistent with replayed verify/draft graphs.
- Consequence: measured inter-kernel idle is GPU/stream-side scheduling and
  memory-system drain, NOT CPU launch latency.

## 8. MTP-specific metrics (traced ON arms)

| arm | acceptance (traced req) | draft_n | accepted | span ms/gen tok | kernel busy ms/gen tok |
|-----|------------------------|---------|----------|-----------------|------------------------|
| T-1k-ON   | 0.8182 | 22 | 18 | 32.27 | 24.13 |
| T-16k-ON  | 1.0000 | 19 | 19 | 32.57 | 24.44 |
| T-63k-ON  | 0.8400 | 25 | 21 | 38.36 | 30.72 |
| T-128k-ON | 1.0000 | 21 | 21 | 47.80 | 39.72 |

(Untraced acceptance for reference: 0.9205 / 1.0 / 0.919 / 1.0 - the fixed
filler+summarize workload drafts nearly perfectly; traced single-request
values vary with round luck.)

Attribution per generated token (aggregate mode; per-step segmentation is not
valid under drafting because a "round" produces up to 5 tokens):
- Draft-block cost is directly visible as GEMV_Q6_K (blk.64 nextn weights are
  the only Q6_K tensors): 0.95 ms/gen tok at 1k (3.95% of busy), falling to
  0.90 at 128k (2.3%) as attention dominates. Draft block total (incl its
  norms/rope share) is small; NO dedicated draft-path bottleneck.
- Shared lm_head (Q4_K) runs once per draft step plus once per verify: Q4_K
  launches rise from 21/token (OFF) to ~40-45/round-equivalent; Q4_K busy
  rises to 2.07-2.37 ms/gen tok (vs 1.49 ms/tok OFF) - the price of shared-head
  drafting, still minor.
- Verify batch shapes confirmed via flash_attn_tile template census:
  ncols1=1 (single-token) plus ncols1 in {4, 8} instantiations present in all
  ON traces => multi-row verify batches executed through the TILE kernel as
  designed (MMVQ handles ne11 <= 8 on the GEMV side). ne11 itself is not
  exposed by the tracer; template census + MMVQ launch counts are the
  evidence (documented inference, not a direct measurement).
- Attention under ON at 128k: tile 13.39 + staging 6.76 = 20.15 ms/gen tok
  (vs 36.7 OFF) - speculative batching amortizes attention over accepted
  tokens, which explains most of the 1.93x ON speedup at 128k.

## 9. Prefill attribution (fresh PP probes, share of PP kernel busy)

Probe request = full fresh prefill, n_predict=1, per context.

| category | 1k | 16k | 63k | 128k | 131k |
|----------|----|----|----|------|------|
| attention FA tile | 2.0% | 16.6% | 43.1% | 60.5% | 60.8% |
| MMQ GEMM IQ3_XXS | 22.2% | 19.2% | 13.1% | 9.1% | 9.0% |
| ROCBLAS_GEMM (hipBLAS fallback, see below) | 20.1% | 17.6% | 11.9% | 8.3% | 8.2% |
| MMQ GEMM IQ2_XXS | 11.9% | 10.2% | 7.0% | 4.8% | 4.8% |
| MMQ GEMM IQ3_S | 10.6% | 9.1% | 6.2% | 4.3% | 4.3% |
| GDN scan | 6.8% | 6.1% | 4.1% | 2.9% | 2.8% |
| MMQ GEMM IQ1_S | 5.7% | 4.9% | 3.4% | 2.3% | 2.3% |
| norm/rope/act | 4.8% | 4.3% | 2.9% | 2.0% | 2.0% |
| MMQ GEMM IQ4_XS | 3.2% | 2.8% | 1.9% | 1.3% | 1.3% |
| staging dequant (KV->F16 for FA) | 2.9% | 2.6% | 2.0% | 1.6% | 1.6% |
| MMQ GEMM Q8_0 | 1.8% | 1.5% | 0.9% | 0.6% | 0.6% |

PP rates (untraced fresh probes this window): 518 / 494 / 340 / 234 / 233 tok/s.

NEW FINDING (V3-specific, code-audit-linked): a significant slice of PP GEMM
runs through hipBLAS, NOT through MMQ kernels. Mechanism verified in source:
ggml_cuda_should_use_mmq() on RDNA3 restricts Q2_K / IQ2_XS / IQ2_S to
ne11 <= 128 (gfx1101 is RDNA3_0), so at prefill ubatch 512 those types fall
through to ggml_cuda_mul_mat_cublas(): weights dequantized to F16 every call,
activations converted F32->F16, Cijk F16 GEMM (rocBLAS), output converted back.
Measured feed census at 16k probe: iq2_s 2144 launches, iq2_xs 1088,
q2_K 480, iq1_m 32; their weight->F16 staging costs ~805 ms per 16k prefill
on top of the 5.7 s of Cijk GEMM itself. At 63k: 8308/4216/1860/125 launches.
IQ1_M also routes here despite the switch default (MMQ instantiation likely
absent for it on this arch). Decode is unaffected (ne11<=8 -> MMVQ).
This is recorded as a Phase-5 candidate (raise RDNA3 ne11 threshold or add
MMQ coverage for these types); NOT acted on.

The 234 -> 60.5%-attention structure otherwise mirrors V2: PP long-context
collapse is attention-tile-driven (tile share 16.6% -> 60.5% from 16k to
128k while MMQ XXS falls 19.2% -> 9.1%).

## 10. Hypothesis verdicts

Task section 8 logic, adjudicated against this window's measurements:

| # | hypothesis | verdict | evidence |
|---|------------|---------|----------|
| 8.1 | attention staging still dominant @128k | CONFIRMED (stronger than expected) | staging 19.65 ms/tok = 26.4% of busy = #1 single cost at 128k/131k; attn total 49.5% of busy. V2 value (19.63) reproduced exactly - architecture-bound, not quant-bound. IC crossover bracketed [16k, 63k], consistent with analytic ~58k. |
| 8.2 | new quant types have lower GEMV BW | CONFIRMED | IQ2_XXS 183 / IQ2_XS 200 / IQ2_S 222 GB/s vs IQ3_XXS 261; Q4_K/IQ4_XS at 86-89% show the deficit is format-specific (gather chains), not general. Flag for Phase-3 kernel tuning. |
| 8.3 | GDN share higher in V3 | REFUTED | 0.51-0.53 ms/tok = ~1.0% of step at 16k (48 layers, 160 launches); identical to V2. No promotion. |
| 8.4 | PP bottleneck shifts away from FA tile | REFUTED | FA tile is STILL dominant at 63k-131k PP (43.1%/60.5%/60.8%). NEW second finding: hipBLAS fallback for IQ2_S/IQ2_XS/Q2_K/IQ1_M is 8-20% of PP busy (biggest at short ctx). Phase-5 has two levers now. |
| 8.5 | inter-kernel gaps larger in V3 | REFUTED (marginally higher, same class) | 7.2 ms/tok non-stall + 0.6-1.0 tail = 7.8-8.2 vs V2 ~7.5; distributed micro-gaps (median 3.4 us, ~2016/step); graphs active. Below the 10 ms promotion threshold. |

Carry-over from Phase-2A unknowns, now closed for V3:
- Kernel-level ms/token attribution: DONE (sec 3).
- Effective in-model GEMV BW per type: DONE (sec 4); aggregate 265 GB/s.
- quantize_row_q8_1 cost: 462 launches/token, 0.64-0.66 ms/tok (~1.4% of step) - minor.
- Staging vs tile split: DONE (sec 5).
- PP breakdown: DONE (sec 9); PP drop is FA-tile-driven + hipBLAS fallback noted.
- Long-context decode classification: 1k-16k GEMV-bound (>85% of busy), 63k mixed
  (staging+tile 32.7%, GEMV 57%), 128k/131k attention-staging-bound (staging alone
  26.4% > any GEMV type; attn 49.5%).
- GDN across contexts: flat ~0.53 ms/tok; negligible.
- Graph behavior beyond 16k and under MTP verify shapes: active everywhere incl.
  131k and all ON arms (sec 7).

## 11. Ideas recorded (NOT executed)

1. Persistent incremental F16 K/V sidecar for the 16 dense layers (largest
   128k lever, ~19.6 ms/tok ceiling); must respect the Infinity-Cache capacity
   finding (a naive sidecar at 128k is 2.36 GiB and will be DRAM-resident).
2. RDNA3 MMVQ launch-config work for the IQ2/IQ3 family (nwarps table excludes
   all i-quants except via default path; measured 183-261 GB/s vs 540+ for
   plain K-quants).
3. Extend should_use_mmq RDNA3 ne11 thresholds (or MMQ coverage) for
   IQ2_S/IQ2_XS/Q2_K/IQ1_M to kill the dequant+F16+hipBLAS detour in prefill.
4. Quantize->GEMV fusion adjacency remains the top gap bucket (1.59 ms/tok)
   but per-event cost is at the 3.4 us scheduling floor; only worth revisiting
   after 1-3.
5. Directly verify the IC crossover with a per-layer-footprint sweep before
   designing any staging replacement (Phase-2B idea carried forward).

## 12. Deviations, caveats

- Production was down at window start (relaunch documented in sec 0 and
  blockers file). All lifecycle actions pidfile-based; identity validated
  before every stop.
- U-16k-ON / U-128k-ON needed 5-rep re-runs (spread gate); values above use
  the compliant runs; r1 medians agreed within 0.8% / 2.0%.
- T-128k-ON ran last with close VRAM monitoring (untraced peak leaves only
  ~190 MB under the guard); completed OK, sampled peak 14.74 GiB.
- Single-pass rule respected for 128k/131k traced generations (one each).
- Optional comparison arms T-*-MTP4 SKIPPED as redundant: production/probe
  flags already use --spec-draft-n-max 4, so T-*-ON arms ARE the mtp4 arms.
- rocprofv3 buffer-flush stalls (2-3 per 32-token traced run, 15 ms class)
  excluded from per-step statistics; counts listed per arm in the JSON.
- p2b_run.py-era mem_snapshot column bug does not apply here: this phase's
  drivers read free -b columns correctly (swap_used_b = col 3).
- EMB_GET_ROWS bucket: 97 calls/token are k_get_rows_float variants (embedding
  lookup + 2 GDN state gathers per layer). No k_get_rows_kq appears anywhere,
  i.e. no quantized get_rows executes; the embedding path evidently operates
  on F32-resident data. Exact load-time mechanism not chased further (not
  needed for attribution; recorded as observation).
- Units: ms/token = milliseconds per generated token (decode) or per prompt
  token (PP); GB/s = 1e9 B/s; GiB = 2^30 B. rocm-smi absolute readings mix
  GB/GiB across historical docs; this report labels each number.

(RESTORE record appended in sec 13.)

## 13. Production restore record

- prod_start.sh executed 05:18 +03; health OK after 10 s.
- PID 144016 written to ops/run/llama-server.pid; readlink /proc/144016/exe ==
  <REPO_ROOT>/build-p3/bin/llama-server (build-p3, no fallback);
  flags verbatim prod_flags.env (ctx 65536, draft-mtp n-max 4 p-min 0.8).
- Health: {"status":"ok"}.
- Semantic spot-check vs NEW stored baseline results2/correctness/baseline_v3.json
  (semantic_smoke_mtp_on heads): 6/6 CHARACTER-EXACT (math 391, math2 480/45,
  puzzle "  8  **Explanation:**..." - the V3 signature answer, factual Paris,
  code, code2). Record: experiments/phase1/restore_semantic_check.json.
- Degenerate-loop probe: model still enters a degenerate repetition loop
  ("apple, banana, ..." x8 on the induction prompt), consistent with the V3
  known behavior family. Caveat: probe prompt is not byte-identical to the
  suite's degen_trap_p1k, so this confirms the loop BEHAVIOR class, not a
  character-exact match of that test's surface.
- Final VRAM used 14.06 GB / visible (production resident, GPU idle);
  swap 1.45 GB (FELL from 5.92 GB pre-window); MemAvailable 24.44 GB.
- Post-conditions: no tracked source changes, no commits made.

RESTORE_OK
