# Phase-2B In-Model Kernel-Level Attribution (re-run)

Date: 2026-08-25 (window 20:12-21:40 +03)
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Binary: build-p3/bin/llama-server, sha256 280556cca031...ad070c13 (Phase-1B
fingerprint match; unchanged since the Aug-24 Phase-2B run).
GPU: AMD Radeon RX 7800 XT (gfx1101), ROCm 7.2.4, rocprofv3 1.1.0.
Scope: MEASUREMENT ONLY. No kernel, build, model, or flag changes. No commits.
All traced numbers below come from fresh in-model traced runs of the real
server executed in THIS window (operator chose full re-run over reuse of the
Aug-24 artifacts, which are retained untouched under traces/, raw/, logs/).

## 0. Execution summary

- Production (PID 15652, build-p3, MTP ON prod flags) stopped cleanly via
  ops/bin/prod_stop.sh --i-have-explicit-approval at 20:26 (+03). Exit after
  SIGINT in 10 s. Pre-stop VRAM used 14.71 GB / 17.16 GB; swap used 57 MiB.
- Untraced instance prof-p2b2-untraced: arms U-1k/U-16k/U-63k/U-128k.
  U-16k sanity gate PASS (+0.94% vs Phase-1B 20.451; spread 0.18% < 1%).
- Traced instances (rocprofv3 --kernel-trace --stats, one per arm):
  T2_O1-off-1k, T2_P1-off-16k, T2_P2-off-63k, T2_P3-off-128k. Each ran two
  requests on one instance: a prefill probe (n_predict=1, cache_prompt=false)
  and a cached decode request (n_predict=36..40). All stops required SIGKILL
  escalation per ops/docs/traced_server_signal_behavior.md; every trace
  flushed intact (verified by file size and internally consistent call
  counts: quantize_row 433/step, FA-tile 32/step across all arms).
- Guards: T-128k VRAM peak sample 15.128 GB -> free 1.88 GiB (> 300 MiB);
  within-arm swap delta +187 MiB (< 512 MiB guard); no abort conditions hit.
- Production restored via prod_start.sh; RESTORE_OK at end of this file.

## 1. Untraced baselines (this window)

Server-reported timings; rep1 fresh prefill, remaining reps cached.

| Arm | reps | tg tok/s median | spread | pp fresh tok/s | vs Phase-1B ref |
|-----|------|-----------------|--------|----------------|-----------------|
| U-1k   | 3 | 22.243 | 0.54% | 515.16 | +0.85% (ref 22.055) |
| U-16k  | 3 | 20.643 | 0.18% | 485.05 | +0.94% (ref 20.451) |
| U-63k  | 3 | 15.645 | 0.10% | 331.98 | -0.60% (ref 15.740) |
| U-128k | 1 | 12.242 | single | 231.32 | +2.18% (ref 11.981) |

Environment equivalence established: all arms within +/-2.2% of Phase-1B.
Untraced ms/token used for overhead gating (cached-rep predicted_ms/n):
44.886 @1k, 48.431 @16k, 63.956 @63k, 81.689 @128k.

## 2. Overhead gate (BLOCKER condition) - PASS everywhere

Traced step period = median marker-to-marker time between consecutive
lm_head GEMV kernels over clean steps (profiler buffer-flush stall events
excluded; see §7 methodology note).

| Arm | clean steps | step period ms | traced tok/s | untraced ms/tok | overhead |
|-----|-------------|----------------|--------------|-----------------|----------|
| T2_O1-off-1k  | 37/39 | 48.872 | 20.46 | 44.886 | +8.9% |
| T2_P1-off-16k | 36/39 | 52.089 | 19.20 | 48.431 | +7.6% |
| T2_P2-off-63k | 38/39 | 67.227 | 14.88 | 63.956 | +5.1% |
| T2_P3-off-128k| 34/35 | 85.745 | 11.66 | 81.689 | +5.0% |

All under the 25% gate. Absolute ms/token from traced arms are usable;
relative shares are primary anyway. Consistent with Aug-24 run (5.3-7.6%).

Caveat: server-reported averages for the traced decode requests
(15.571 tok/s @16k etc.) are depressed by transient rocprofv3 buffer-flush
stalls (e.g., 485 ms + 136 ms pauses inside two steps at 16k). Those stalls
are profiler artifacts, not server behavior; they are excluded from all
per-step statistics and listed separately in the JSON.

## 3. Decode attribution per token (H-P2B tables)

Kernel busy by category, MTP OFF, per generated token, clean-step means.

T2_P1-off-16k (step period 52.09 ms = busy 45.19 + gaps 6.89 + sampling tail ~0.6):

| category | calls/tok | ms/tok | % of busy |
|---|---|---|---|
| GEMV IQ3_XXS (mul_mat_vec_q type18) | 224.0 | 30.458 | 68.35 |
| GEMV IQ3_S | 96.0 | 4.816 | 10.81 |
| attention FA tile (flash_attn_tile+combine) | 32.0 | 2.264 | 5.08 |
| norm/rope/act elementwise | 641.0 | 1.661 | 3.73 |
| GEMV Q3_K (lm_head) | 1.0 | 1.461 | 3.28 |
| staging dequant (dequantize_block_q4_0 K/V->F16) | 32.0 | 1.431 | 3.21 |
| other (get_rows/copyBuffer/sampling glue) | 135.0 | 0.670 | 1.50 |
| quantize_q8_1 row kernels | 433.0 | 0.609 | 1.37 |
| GDN (gated_delta_net+ssm_conv+fwht) | 160.0 | 0.520 | 1.17 |
| GEMV IQ1_M (96 tiny tensors) | 96.0 | 0.355 | 0.80 |
| KV store/copy (set_rows_quant/cpy_scalar) | 64.0 | 0.198 | 0.44 |
| GEMV IQ4_XS | 16.0 | 0.119 | 0.27 |
| attention VEC (flash_attn_ext_vec) | 0 | 0 | 0 |

Scaling across contexts (ms/token):

| category | 1k | 16k | 63k | 128k |
|---|---|---|---|---|
| GEMV IQ3_XXS | 30.476 | 30.458 | 30.406 | 30.432 |
| GEMV IQ3_S | 4.805 | 4.816 | 4.796 | 4.791 |
| attention FA tile | 0.331 | 2.264 | 9.557 | 17.121 |
| staging dequant | 0.121 | 1.431 | 8.939 | 19.634 |
| norm/rope/act | 1.657* | 1.661 | 1.664* | 1.697* |
| GEMV Q3_K lm_head | 1.474 | 1.461 | 1.462 | 1.459 |
| quantize_q8_1 | 0.612 | 0.609 | 0.623 | 0.621 |
| GDN | 0.518 | 0.520 | 0.526 | 0.522 |
| KV store/copy | 0.196 | 0.198 | 0.198 | 0.206 |
| step period (median) | 48.87 | 52.09 | 67.23 | 85.75 |

(*approx values from category table; see JSON for exact.)

GEMV time is context-independent (weights stream every step regardless of L).
Everything attention-side grows with L; everything else is flat.

## 4. H-P2B-1: in-model IQ3_XXS GEMV effective bandwidth

Weight bytes corrected for MTP OFF: GGUF totals minus blk.64 (MTP nextn)
tensors, which never stream during plain decode. This also RESOLVES the
Aug-24 report's IQ4_XS anomaly (1826 GB/s): 172.7 MB of the ledger's
217.3 MB "IQ4_XS" was the unused nextn v-proj.

| type | bytes/step | ms/tok @16k | eff GB/s | % of 624 nominal |
|---|---|---|---|---|
| IQ3_XXS | 8,092,385,280 | 30.458 | 265.7 | 42.6% |
| IQ3_S   | 1,333,657,600 | 4.816  | 276.9 | 44.4% |
| Q3_K    |   546,304,000 | 1.461  | 373.9 | 59.9% |
| IQ4_XS  |    44,564,480 | 0.119  | 376.1 | 60.3% |
| IQ1_M   |     5,160,960 | 0.355  | n/m (launch-bound) | - |
| TOTAL streamed | 10,022,072,320 | 37.207 | 269.4 aggregate | 43.2% |

Verdict H-P2B-1: CONFIRMED. In-model IQ3_XXS effective bandwidth is
265.7 GB/s = 42.6% of nominal 624 GB/s, decisively below the >=450 GB/s
falsification line; IQ3_XXS GEMV alone is 68.4% of kernel busy at 16k and
its absolute time is constant across contexts. Comparison to synthetic:
the ~215 GB/s synthetic-era figure UNDERSTATES in-model (265.7); the
Phase-3 synthetic diagnosis (latency-bound gather chain at low co-resident
wavefronts) remains the plausible mechanism, but the in-model number is the
authoritative denominator for planning. Note: prior-run figures used the
uncorrected ledger (IQ3_XXS identical; IQ3_S/IQ4_XS now corrected here).

## 5. H-P2B-2: quantize launches and inter-kernel gaps

Launch counts: 433.0 quantize_row_q8_1 launches per decode step at EVERY
context (prior estimate ~497 matmul ops; measured 433 - some matmuls share
or skip requant; close enough to validate the order of magnitude).
Kernel duration sum: 0.609-0.623 ms/token (1.2-1.3% of step period).

Inter-kernel gap analysis (device-side idle from kernel timestamps,
clean steps, gaps < 5 ms; overlaps clamped):

| metric | 1k | 16k | 63k | 128k |
|---|---|---|---|---|
| non-stall gap total ms/token | 6.91 | 6.89 | 6.93 | 6.97 |
| gaps per step (~count) | ~1870 | ~1929 | ~1929 | ~1929 |
| median gap | 3.4 us | 3.4 us | 3.4 us | 3.4 us |
| p95 / p99 gap | 3.8 / 4.1 us | 3.8 / 4.1 us | 3.8 / 4.2 us | 3.8 / 4.3 us |
| max non-stall gap | 0.54 ms | 0.35 ms | 0.56 ms | 0.35 ms |
| sampling tail (post-lm_head to next get_rows) | 0.79 ms | 0.64 ms | 0.99 ms | 1.22 ms |
| total GPU idle/token (gaps+tail) | ~7.7 | ~7.5 | ~7.9 | ~8.2 |

Largest transition contributors at 16k (summed idle per token):
- quantize_q8_1 -> mul_mat_vec_q: 1.487 ms/tok over 433 launches
  (mean 3.43 us each) - the single largest transition bucket.
- rms_norm_f32 -> quantize_q8_1: 0.43 ms/tok.
- mul_mat_vec_q -> rms_norm_f32: 0.40 ms/tok.
- unary_gated_op_kernel -> quantize_q8_1: 0.38 ms/tok.
- mul_mat_vec_q -> k_bin_bcast: 0.33 ms/tok.

Gap-before-category split at 16k (ms/token): NORM_ROPE_ACT 2.32,
QUANT_ROW_decode 1.49, GEMV_IQ3_XXS 0.77, OTHER 0.60, GDN 0.56,
GEMV_IQ1_M 0.33, KV_STORE 0.22, GEMV_IQ3_S 0.33.

Verdict H-P2B-2: REFUTED as a dominant cost. The idle is real (~7.5 ms/token
= 14.4% of step period at 16k) but it is DISTRIBUTED: ~1900 micro-gaps of
median 3.4 us each; no single transition dominates. Quantize-adjacent idle
(before + after quantize kernels) sums to ~2.97 ms/token (43% of idle),
but with 433 launches that is 6.9 us per launch pair - consistent with
per-launch scheduling floor rather than a fixable bubble. Because graphs
are ACTIVE (§8), this idle is GPU/stream-side scheduling + memory-system
drain, NOT CPU launch latency.

## 6. H-P2B-3: GDN decode share

gated_delta_net_cuda + ssm_conv + fwht: 160 calls/token, 0.518-0.526
ms/token at ALL contexts = ~1.0% of step period at 16k (1.2% of busy).
FAR below the 20% promotion threshold. No dedicated GDN hypothesis
warranted. Prefill GDN share falls 6.6% (1k) -> 2.9% (128k) of PP busy.

## 7. H-P2B-4: attention F16 staging vs tile kernel

Separation per dense layer per token: staging = dequantize_block_q4_0
(32 calls/token = K+V x 16 layers); tile = flash_attn_tile(+combine).
Corrected byte model per token of context (q4_0 = 18 B/32 elems;
n_embd_kv_gqa = 1024; 16 dense layers):
- staging read q4_0: L x 18,432 B
- staging write F16: L x 65,536 B   (NOTE: corrects the code audit's
  L x 36,864 figure, which implied a 2x F16/q4 ratio instead of 3.56x)
- tile re-read F16:  L x 65,536 B

| ctx | staging ms/tok | tile ms/tok | KV store ms/tok | staging eff GB/s (r+w model) | tile eff GB/s (re-read model) |
|---|---|---|---|---|---|
| 1k   | 0.121 | 0.331 | 0.196 | 709 | 203 |
| 16k  | 1.431 | 2.264 | 0.198 | 961 | 474 |
| 63k  | 8.939 | 9.557 | 0.198 | 606 | 442 |
| 128k | 19.634 | 17.121 | 0.206 | 561 | 502 |

Findings:
- Staging scales SUPERLINEARLY in L: x13.7 time for x8.0 tokens (16k->128k).
  Tile scales near-linearly above 16k (x7.6 for x8.0) but superlinearly
  1k->16k. KV store is flat/trivial (~0.2 ms/tok).
- INTERPRETATION (analytical, not a direct measurement): the pure traffic
  model implies >900 GB/s effective staging bandwidth at 16k - impossible
  from DRAM - while at 63k/128k it converges to 560-610 GB/s, i.e.,
  DRAM-class. Per-layer staged working set = 1152 B x L (q4 side);
  it crosses the RX 7800 XT's 64 MB Infinity Cache around L ~= 58k. Below
  that, most staging traffic is served from cache; above it, every byte
  streams from DRAM. This coherently explains BOTH the superlinear scaling
  curve AND why the audit's linear-in-L traffic prediction fails. Treat as
  a hypothesis for future design work, not as a measured fact.
- Verdict H-P2B-4: CONFIRMED. At 128k, staging (19.63) + tile (17.12) +
  store (0.21) = 36.97 ms/token = 42.6% of the 85.7 ms step period (48.1%
  of kernel busy). Staging alone is the #2 cost at 128k, ahead of
  everything except IQ3_XXS GEMV. The code-audit's "~11.8 GiB/token"
  estimate becomes ~19.4 GiB/token total attention traffic with corrected
  F16-write math (still same qualitative conclusion).

## 8. H-P2B-5: graph behavior during tracing

- Zero "warmup reset" events in ANY instance log (untraced or traced).
- Untraced session cumulative "graphs reused" reached 1982 across 4 arms.
- Every traced instance replayed graphs for EVERY decode step:
  reused counts == generated counts exactly (40/40/40/36). rocprofv3
  captured graph-launched dispatches completely.
- Consequence: measured inter-kernel gaps are GPU/stream-side (scheduling,
  dependency drain, memory system), NOT CPU launch latency. CPU launch
  cost is amortized by graph replay during the traced windows.

Verdict H-P2B-5: graphs ACTIVE throughout; gap interpretation in §5 stands.

## 9. Prefill breakdown (probe requests, share of PP kernel busy)

| category | 1k | 16k | 63k | 128k |
|---|---|---|---|---|
| MMQ GEMM IQ3_XXS | 69.7% | 61.2% | 41.6% | 29.1% |
| attention FA tile | 2.0% | 16.3% | 42.8% | 59.8% |
| MMQ GEMM IQ3_S | 10.7% | 9.4% | 6.4% | 4.5% |
| GDN scan | 6.6% | 6.0% | 4.1% | 2.9% |
| norm/rope/act | 4.9% | 4.2% | 2.9% | 2.0% |
| quantize_mmq_q8_1 | ~1.3% | 1.4% | 0.9% | 0.7% |

PP rates this window: 515 / 485 / 332 / 231 tok/s (fresh probes).
The 485 -> 231 collapse from 16k to 128k is attention-tile-driven:
tile share rises 16.3% -> 59.8% while MMQ XXS share falls 61.2% -> 29.1%
(absolute MMQ time grows sublinearly). Matches the Aug-24 finding within
0.3 percentage points at every context.

## 10. Hypothesis verdicts (summary)

| hypothesis | verdict |
|---|---|
| H-P2B-1 in-model IQ3_XXS GEMV BW | CONFIRMED: 265.7 GB/s = 42.6% of 624; dominant cost at all contexts |
| H-P2B-2 quantize/gap overhead | REFUTED as dominant: kernels 0.61 ms/tok; idle distributed (~1900 x 3.4 us); quantize-adjacent ~3.0 ms/tok of 7.5 ms/tok total idle |
| H-P2B-3 GDN share | LOW: ~1.0% of step at 16k; no promotion |
| H-P2B-4 attention staging vs tile | CONFIRMED: staging #2 cost at 128k (25% of busy); superlinear; cache-capacity interpretation proposed |
| H-P2B-5 graphs active | CONFIRMED: 100% replay coverage in all traced windows |

Cross-check vs Aug-24 run (same binary): all kernel-time categories agree
within ~1-5% (e.g., IQ3_XXS 30.86 vs 30.46 ms/tok; staging@128k 19.94 vs
19.63; quantize 433.5 vs 433.0 launches; PP category shares within 0.3pp).

## 11. Ideas (NOT executed)

Recorded only; no implementation attempted or authorized in this phase.
1. Persistent incremental F16 K/V sidecar for the 16 dense layers to
   eliminate per-call whole-cache staging (largest long-context lever;
   would need IC-resident layout thinking given the §7 capacity finding).
2. RDNA3 mmvq launch-config work for IQ3_XXS (nwarps=1 single wavefront at
   ncols_dst=1) to raise the 265.7 GB/s ceiling.
3. Investigate whether the ~7.5 ms/token distributed inter-kernel idle can
   be shrunk by batching tiny elementwise producers (norm->quantize pairs)
   - only worth revisiting after 1 and 2.
4. Explain/verify the Infinity-Cache-capacity crossover directly (per-layer
   footprint sweep) before designing any staging replacement.

## 12. Deviations and notes (details in phase2b_blockers.md)

- Operator selected FULL FRESH RE-RUN although complete Aug-24 traces for
  the identical binary existed; both datasets are retained.
- T2_P3-off-128k attempt 1 failed fast with HTTP 400 (make_text tokenizer
  tolerance produced 131102 tokens > 131072 ctx; NO GPU compute occurred);
  attempt 2 on the SAME instance used a saved 129048-token fitting prompt.
  Single-pass rule respected (one traced 128k generation total).
- Optional arm T-16k-MTPON SKIPPED (prior operator decision
  INCLUDE_O2_MTP_ON = NO recorded in Aug-24 results.md sec 1).
- p2b_run.py mem_snapshot has a column bug: its swap_used_b reads the
  SWAP FREE column (so historical negative deltas mean used GREW).
  This window's numbers use correct accounting (free -b col 3).
- Session-level swap drift: 57 MiB pre-stop -> ~5.3 GB post-window
  (page-cache pressure from repeated 10.7 GB model mmaps + trace writes);
  MemAvailable never dropped below 18.1 GB; within-arm delta at 128k was
  +187 MiB (guard 512 MiB).
- rocprofv3 buffer-flush stalls (0.1-0.5 s single-gap pauses) occur
  stochastically mid-decode; excluded from stats, listed per-arm in JSON.

(RESTORE line appended after §13 once production restore completes.)

## 13. Production restore record

- prod_start.sh executed 21:49:53 (+03); health OK after 10 s.
- PID 51668 written to ops/run/llama-server.pid; /proc/51668/exe validated
  = <REPO_ROOT>/build-p3/bin/llama-server (build-p3, no fallback).
- Flags: prod_flags.env verbatim via prod_start.sh (identical config to the
  pre-window production process: -c 65536 + draft-mtp spec flags).
- Health: {"status":"ok"}.
- Semantic spot-check vs results2/correctness/baseline_ON_prod_v3.json:
  6/6 character-identical output-head matches using the original Phase-1B
  suite prompts (results2/p3_quality_suite.py), including the baseline's own
  math2 "40" quirk output. Record:
  experiments/phase2b/restore/semantic_check_rerun.json.
- Final VRAM used: 14.93 GB / 17.16 GB (production resident; GPU idle).
- Swap: 57 MiB pre-stop -> 6.24 GB final (session drift documented in
  phase2b_blockers.md B7; MemAvailable 17.2 GB at finish).

RESTORE_OK
