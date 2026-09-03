# Phase-2B MTP OFF Profiling Results

Date: 2026-08-24 17:10-19:15 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Binary: build-p3/bin/llama-server sha256 280556cc... (Phase-1B fingerprint match)
Scope: kernel-level attribution for MTP OFF token generation only. No code,
kernel, build, or parameter changes were made. No commits.

## Final verdict

SUCCESS

All planned arms executed: 3 untraced + 1 traced pass per primary arm
(16k/63k), single-pass untraced + gated single-pass traced at 128k, plus the
O1-off-1k reference. Sanity gate passed (-0.93% vs Phase-1B). Trace overhead
5.3-7.6% (under the 25% gate). Production restored on build-p3, health OK,
6/6 semantic outputs identical to the stored production baseline. One guard
note: swap baseline had drifted +3.3 GiB before the 128k traced arm (stale
profiler-instance pages); during that arm swap was RECLAIMED by -1.1 GiB and
no guard ever breached.

## 1. Approval state

- OPERATOR_PROFILING_WINDOW_APPROVAL = YES: honored.
- OPERATOR_PRODUCTION_STOP_APPROVAL = YES: honored; stop via validated
  pidfile PID only.
- TRACED_128K_APPROVAL = YES, SINGLE_PASS_GATED: honored; exactly one traced
  128k request, run only after untraced 128k succeeded and guards passed.
- INCLUDE_O2_MTP_ON = NO: no MTP ON arm was run anywhere in this window.
- ALLOW_PROFILER_PERMISSION_ESCALATION = NO / EXPECT_ROCPROF_NO_SUDO=YES:
  rocprofv3 ran without sudo; no escalation attempted; no permission errors.

## 2. Pre-check results

Full detail: precheck.md.

- git: HEAD == 66dcba5eb7dd92cd460cfc040c7cae42f1254e20, tracked files clean,
  untracked experiment artifacts only. PASS
- binary: build-p3/bin/llama-server sha256 280556cca031...ad070c13, 16000 B,
  mtime 2026-08-24 00:20 (+0300) - identical to Phase-1B. PASS
- model: Qwen3.8-27B-UD-Q2_K_XL.gguf present, 10,676,423,744 B. PASS
- disk/memory: /home 16 GB free (>= 10 GB required); MemAvailable 14 GiB with
  production up, 17 GiB after stop; pre-existing swap usage recorded as
  baseline reference. PASS (128k re-gated immediately before that arm)
- profiler: rocprofv3 1.1.0 (ROCm 7.2.4) runs without sudo. PASS
- ops files: prod_flags.env / pidfile_policy.md / measurement_window.md all
  present. PASS
- production state: PID 397813 alive, /proc exe = build-p3/bin/llama-server,
  cmdline contained model path, health {"status":"ok"}. PASS

## 3. Untraced sanity results

- P1-off-16k median tg = 20.261 tok/s (cached reps 20.261 / 20.264).
- Phase-1B reference = 20.451; delta = -0.93%, inside the +/-5% band.
- SANITY GATE: PASS. Tracing proceeded after this gate.
- Secondary checks: O1-off-1k 21.855 (ref 22.055, -0.9%), P2-off-63k 15.561
  (ref 15.740, -1.1%), P3-off-128k 12.032 (ref 11.981, +0.4%). All within ~1%
  of Phase-1B; environment equivalent.
- Note: prompt_n came out 16390 @16k and 63528 @63k vs Phase-1B's 16356 /
  63514 (+0.2%): make_text tokenizer-adjustment loop variance. Decode length
  and prompts are otherwise identical; impact negligible.

## 4. Arm execution table

Untraced server instance: one shared process for all untraced arms (pidfile
ops/run/prof-p2b-untraced.pid); traced arms each used a dedicated rocprofv3-
wrapped instance. Rep structure matches Phase-1B: rep1 fresh prefill,
remaining reps cached.

| arm | context | mode | traced | reps | tg tok/s | pp tok/s | VRAM peak GiB | swap delta MiB | status |
|-----|---------|------|--------|------|----------|----------|---------------|----------------|--------|
| O1-off-1k | 1024 | off | no | 1 | 21.855 | 509.3 | 13.94 | -4.0 | OK |
| P1-off-16k | 16384 | off | no | 3 | 20.261 (med) | 469.8 fresh | 14.00 | -37.6 | OK |
| P2-off-63k | 64512 | off | no | 3 | 15.561 (med) | 331.8 fresh | 14.00 | -100.9 | OK |
| P3-off-128k | 131072 | off | no | 1 | 12.032 | 230.2 | 13.97 | -246.4 | OK |
| T_O1-off-1k | 1024 | off | yes | 1 | 20.192 | 507.6 | n/a | n/a | OK |
| T_P1-off-16k (pp phase) | 16384 | off | yes | 1 req npred=1 | - | 481.4 | n/a | n/a | OK |
| T_P1-off-16k (tg phase) | 16384 | off | yes | cached 128 | 18.936 | - | n/a | n/a | OK |
| T_P2-off-63k (pp phase) | 64512 | off | yes | 1 req npred=1 | - | 329.2 | n/a | n/a | OK |
| T_P2-off-63k (tg phase) | 64512 | off | yes | cached 380 | 14.730 | - | n/a | n/a | OK |
| T_P3-off-128k | 131072 | off | yes | 1 (single pass) | 11.376 | 230.4 | 13.74 peak sample | -1172 (reclaimed) | OK |

Traced tok/s are NOT comparable to untraced numbers (attribution only).
Server config everywhere: -c 131072 -ngl 999 --load-mode mmap -fa on
-ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --metrics;
greedy sampling (temp 0, top_k 1, seed 1234, ignore_eos); NO speculative
flags anywhere in this window.

## 5. Kernel attribution tables

Decode phase, MTP OFF, per generated token (traced; category totals from
rocprofv3 kernel traces; "step wall" from server predicted_ms of the same
request; busy = sum of kernel durations).

P1-off-16k decode (step wall 53.07 ms traced / 49.36 ms untraced-equivalent;
kernel busy 45.19 ms):

| category | calls/token | total ms | ms/token | % of busy | notes |
|---|---|---|---|---|---|
| IQ3_XXS GEMV (mul_mat_vec_q type18) | 224.5 | 3954.7 | 30.896 | 68.36 | dominant |
| other quant GEMV IQ3_S | 96.0 | 623.6 | 4.872 | 10.78 | |
| attention FA tile (flash_attn_tile*) | 32.0 | 297.0 | 2.321 | 5.13 | incl combine_results |
| norm/rope/act elementwise | 642.5 | 212.5 | 1.660 | 3.67 | |
| GEMV Q3_K (lm_head) | 1.0 | 188.4 | 1.472 | 3.26 | |
| dequant/staging (dequantize_block_q4_0 KV->F16) | 32.0 | 183.6 | 1.435 | 3.17 | full-cache stage |
| other/sampling/get_rows/memcpy | 135.0 | 87.8 | 0.686 | 1.52 | |
| quantize_q8_1 row kernels | 433.5 | 79.1 | 0.618 | 1.37 | launch-heavy, time-cheap |
| GDN (gated_delta_net+ssm_conv+fwht) | 160.0 | 68.6 | 0.536 | 1.19 | |
| GEMV IQ1_M (96 tiny tensors) | 96.0 | 47.5 | 0.371 | 0.82 | negligible bytes |
| KV store/copy (set_rows_quant/cpy_scalar) | 64.0 | 26.4 | 0.206 | 0.46 | |
| GEMV IQ4_XS | 16.0 | 15.4 | 0.120 | 0.27 | |
| attention VEC (flash_attn_ext_vec) | 0 | 0 | 0 | 0 | ZERO on this build (expected) |

P2-off-63k decode (step wall 68.02 ms traced; busy 59.88 ms):

| category | calls/token | ms/token | % of busy | notes |
|---|---|---|---|---|
| IQ3_XXS GEMV | 224.2 | 30.995 | 51.76 | unchanged vs 16k |
| attention FA tile | 32.0 | 9.554 | 15.96 | ~linear x3.9 vs 16k |
| dequant/staging | 32.0 | 8.807 | 14.71 | superlinear x6.1 vs 16k |
| GEMV IQ3_S | 96.0 | 4.882 | 8.15 | unchanged |
| norm/rope/act | 641.5 | 1.656 | 2.77 | |
| GEMV Q3_K | 1.0 | 1.466 | 2.45 | |
| other | 135.0 | 0.675 | 1.13 | |
| quantize_q8_1 | 433.2 | 0.620 | 1.04 | |
| GDN | 160.0 | 0.532 | 0.89 | |
| GEMV IQ1_M | 96.0 | 0.366 | 0.61 | |
| KV store/copy | 64.0 | 0.204 | 0.34 | |
| GEMV IQ4_XS | 16.0 | 0.119 | 0.20 | |

P3-off-128k decode (step wall 88.47 ms traced / 83.1 ms untraced; busy
79.44 ms):

| category | calls/token | ms/token | % of busy | notes |
|---|---|---|---|---|
| IQ3_XXS GEMV | 224.7 | 30.844 | 38.83 | still constant |
| dequant/staging | 32.0 | 19.939 | 25.10 | #2 cost at 128k |
| attention FA tile | 32.0 | 18.070 | 22.75 | |
| GEMV IQ3_S | 96.0 | 4.835 | 6.09 | |
| norm/rope/act | 643.0 | 1.704 | 2.15 | |
| GEMV Q3_K | 1.0 | 1.473 | 1.85 | |
| other | 135.0 | 0.691 | 0.87 | |
| quantize_q8_1 | 433.7 | 0.620 | 0.78 | |
| GDN | 160.0 | 0.524 | 0.66 | |
| GEMV IQ1_M | 96.0 | 0.366 | 0.46 | |
| KV store/copy | 64.0 | 0.221 | 0.28 | |
| GEMV IQ4_XS | 16.0 | 0.119 | 0.15 | |

Prefill-phase splits (share of prefill kernel-busy):

| category | 16k | 63k | 128k |
|---|---|---|---|
| MMQ GEMM IQ3_XXS | 61.06% | 41.72% | 28.98% |
| attention FA tile | 16.31% | 42.60% | 60.00% |
| MMQ GEMM IQ3_S | 9.37% | 6.40% | 4.45% |
| GDN scan | 6.01% | 4.11% | 2.84% |
| norm/rope/act | 4.25% | 2.95% | 1.99% |
| quantize_mmq_q8_1 | 1.40% | 0.98% | 0.65% |
| MMQ IQ4_XS + staging f16 + rocBLAS GEMM (IQ1_M path) + rest | ~1.6% | ~1.2% | ~1.1% |

Prefill note: IQ1_M weights are served via a dequant-to-F16 + rocBLAS Cijk
path during prefill (visible as dequantize_block_iq1_m + convert_unary +
Cijk_Alik_Bljk kernels, < 0.5% of prefill busy).

## 6. Hypothesis verdicts

H-2A-GEMV: CONFIRMED.
- Evidence: GEMV categories sum to 38.8-39.0 ms/token of kernel busy at EVERY
  context (85-86% of busy at 1k/16k; 65% at 63k; 49% at 128k). IQ3_XXS alone
  is 68.4% of busy at 16k. Effective streaming bandwidth measured 262 GB/s
  for IQ3_XXS, 274 GB/s aggregate - far below nominal 624 GB/s.
- Falsification condition ("GEMV share < 30% of step at 16k" or effective BW
  >= 450 GB/s): decisively NOT met.

H-2A-QUANT: REFUTED.
- Evidence: quantize_row_q8_1 runs 433-434 launches/token but costs only
  0.618-0.620 ms/token (1.0-1.4% of step wall). quantize_mmq_q8_1 in prefill
  is 0.65-1.40% of PP busy. The audit's "~500 launches create meaningful
  overhead" is not supported by kernel times.
- Falsification condition ("< 5% of step wall"): met -> hypothesis fails.
- Adjacent-gap caveat: traced host gap is 7.9-9.0 ms/token, but 3-4 ms/token
  of that is trace overhead (untraced-vs-traced step-wall delta); the true
  residual gap (~4-5 ms/token worst case) is not attributable to quantize
  launches specifically.

H-2A-ATTN-STAGING: CONFIRMED (decisively at long context).
- Evidence: whole-cache q4_0->F16 staging (dequantize_block_q4_0, 32 calls/
  token = K+V x 16 dense layers) scales 1.435 -> 8.807 -> 19.939 ms/token
  across 16k/63k/128k. Share of kernel busy: 3.2% -> 14.7% -> 25.1%. At 128k
  staging+FA tile+store = 48% of kernel busy. Scaling is SUPERLINEAR in
  cache length (x6.1 and x13.9 per-call cost for x3.9 and x7.9 tokens).
- Falsification condition ("staging share < 15% of step at 63k/128k"): met at
  63k only marginally (13.0% of step wall); decisively violated at 128k
  (22.5% of step wall).

H-2A-KV-READ: REFUTED at mid context per its own criterion; nuance below.
- Evidence: KV store/copy kernels are trivial everywhere (0.206-0.221 ms/
  token, constant). KV-complex share (cpy/set_rows/staging/tile-attributable)
  at 16k = 8.8% of busy < the 10% falsification threshold -> formally
  refuted at 16k.
- Nuance: the hypothesis' core claim "raw q4_0 bandwidth itself is NOT
  limiting" IS consistent with the data; the long-context KV burden shows up
  under STAGING (superlinear dequant) and FA tile time, not in the store
  path or raw q4_0 reads.

H-2A-PP: CONFIRMED.
- Evidence: from 16k to 128k prefill, MMQ GEMM share FALLS 70.8% -> 33.6%
  while flash_attn_tile share RISES 16.3% -> 60.0%. The PP collapse
  (485 -> 231 tok/s) tracks growing attention tile work, not GEMM regression.
- Falsification condition ("GEMM share rising enough to explain > 50% of the
  slowdown"): not met; direction is opposite.

H-2A-GRAPH: CONFIRMED (minor and dormant).
- Evidence: zero "warmup reset" events in any log; graphs reused counters
  accumulate monotonically (final 1758 over the untraced session covering all
  four arms); no recapture storms (< 1% of steps anywhere). Phase-1B already
  bounded graph-off cost at -2.6% tg at 16k.

H-2A-MTP-SECONDARY: NOT_MEASURED (O2 MTP ON comparison excluded by operator
approval state; no future MTP ON data exists yet).

## 7. Effective GEMV bandwidth

Exact weight bytes read from GGUF header (env/model_bytes_by_type.json);
per-step streamed bytes assumed equal to resident matmul-relevant tensor
bytes (all listed tensors participate in every decode step; embedding table
is Q2_K 0.389 GiB but is consumed by get_rows, never by GEMV):

| quant type | GiB/step | ms/token (measured, constant across ctx) | eff. GB/s | % of 624 nominal |
|---|---|---|---|---|
| IQ3_XXS | 7.537 | 30.87 | 262 | 42% |
| IQ3_S | 1.282 | 4.86 | 283 | 45% |
| Q3_K (lm_head) | 0.509 | 1.47 | 372 | 60% |
| IQ4_XS | 0.202 | 0.119 | 1826* | (293%)* |
| IQ1_M | 0.005 | 0.366 | n/m (launch-bound, negligible bytes) | - |
| TOTAL streamed | 9.530 | 37.3 | 274 aggregate | 44% |

*IQ4_XS number exceeds plausible DRAM bandwidth: either only part of those
bytes stream per step or the kernel is not purely bandwidth-bound at this
size. Do not use it as a bandwidth claim.

- Comparison with nominal 624 GB/s (RX 7800 XT): IQ3_XXS GEMV achieves ~42%.
- Comparison with Phase-1B implied bound: Phase-1B's <=~230 GB/s whole-step
  average bound (weights/time at 48.9 ms steps) is consistent with the
  measured split: 274 GB/s during the 37.3 ms of GEMV busy + non-GEMV work
  filling the rest of the step.
- H-2A-GEMV guessed "100-250 GB/s class": measured slightly above that band
  (262) but far below the 450 GB/s refutation line.

## 8. Attention staging analysis

Staging (full-cache q4_0->F16 dequant before TILE attention, K+V x 16 dense
layers = 32 calls/token) vs flash_attn_tile vs store:

| ctx | staging ms/tok | tile ms/tok | store ms/tok | attn complex % of busy |
|-----|----------------|-------------|--------------|------------------------|
| 1k | ~0.03 | ~0.15 | 0.21 | ~1% |
| 16k | 1.435 | 2.321 | 0.206 | 8.8% |
| 63k | 8.807 | 9.554 | 0.204 | 31.0% |
| 128k | 19.939 | 18.070 | 0.221 | 48.2% |

- Tile scales ~linearly with L (x3.9 / x7.9 for 63k/128k vs 16k).
- Staging scales SUPERLINEARLY (x6.1 / x13.9 per-call cost). Mechanism
  unknown (candidates: L2 behavior, wave quantization at larger grids,
  write-allocate traffic of the F16 sidecar). This curve is the single most
  important new fact for long-context optimization planning.
- Verdict: YES - long-context decode is staging-bound in combination with
  tile math; at 128k nearly half the step is attention-complex work, and
  staging alone costs more than everything except GEMV.

## 9. quantize_q8_1 analysis

- Launches/token (decode): 433.5 (16k) / 433.2 (63k) / 433.7 (128k) - close
  to the audit estimate of ~500 matmul ops/step, confirming the count.
- Time/token: 0.618-0.620 ms/token (1.0-1.4% of step wall) across contexts.
- Prefill counterpart quantize_mmq_q8_1: 0.65-1.40% of PP busy.
- Adjacent-gap evidence: host gap (step wall - kernel busy) measures 7.9 /
  8.1 / 9.0 ms/token traced at 16k/63k/128k, BUT the traced-vs-untraced step
  wall delta is only 3.71 / 3.76 / 5.36 ms/token, so true device-idle time is
  roughly 4-5 ms/token at most. Nothing ties these gaps specifically to the
  433 tiny launches; their own duration is ~15 us/launch aggregated.
- Verdict: overhead NOT meaningful. H-2A-QUANT refuted. If a residual few-ms
  gap exists, it must be attributed by other means (e.g., graph-node timing)
  before spending effort on it.

## 10. GDN analysis

- gated_delta_net_cuda + ssm_conv + fwht: 160 calls/token (48 layers),
  0.52-0.54 ms/token decode at every context (0.7-1.3% of busy).
- Prefill: 2.84-6.01% of PP busy, roughly linear in tokens.
- Share at 16k is FAR below the 20% promotion threshold. No dedicated
  H-2A-GDN hypothesis warranted on current evidence.

## 11. PP analysis

Trace phase separation worked reliably (prefill isolated via dedicated
n_predict=1 requests; discriminator quantize_mmq vs quantize_row cross-checked
against known request timings).

| ctx | pp tok/s | dominant prefill categories |
|-----|----------|------------------------------|
| 16k | 469.8-509 | MMQ IQ3_XXS 61.1%, tile 16.3%, MMQ IQ3_S 9.4%, GDN 6.0% |
| 63k | 331.8 | tile 42.6%, MMQ XXS 41.7%, MMQ IQ3_S 6.4%, GDN 4.1% |
| 128k | 230.2-230.7 | tile 60.0%, MMQ XXS 29.0%, MMQ IQ3_S 4.5%, GDN 2.8% |

- Likely cause of PP drop: prefill flash_attn_tile work growing superlinearly
  with context (same signature as decode-side staging growth). GEMM does not
  regress; its absolute time grows sublinearly and its share falls.
- Unknowns: why tile/staging scale superlinearly; exact role of the rocBLAS
  path for IQ1_M tensors during prefill (<0.5% busy today).

## 12. Graph evidence

- Untraced session log: cumulative "graphs reused" reached 1758 across
  O1/P1/P2/P3; zero "warmup reset" lines; no recapture anomaly.
- Per-arm reused counts (cumulative snapshots): warmup ~408, after O1 534,
  after P1 911, after P2 1288, after P3 1665, final print_timing 1758.
- Traced instances also replayed graphs normally (decode kernels appear in
  traces with graph-driven periodicity; rocprofv3 captured graph-launched
  dispatches fully - verified by call counts matching 32/96/128-step math).

## 13. Trace overhead

- Verbosity used: rocprofv3 --kernel-trace --stats ONLY (no HW counters, no
  API/memory traces), CSV output, demangled names.
- Overhead = 1 - traced_tg/untraced_tg:
  - P1-off-16k: 1 - 18.936/20.261 = 6.5%
  - P2-off-63k: 1 - 14.730/15.561 = 5.3%
  - P3-off-128k: 1 - 11.376/12.032 = 5.5%
  - O1-off-1k: 1 - 20.192/21.855 = 7.6%
- All under the 25% gate; no verbosity reduction needed; traced shares are
  reliable. Traced numbers were never mixed into untraced tables.

## 14. Production restore

- RESTORE_OK, NO fallback needed (RESTORE_FALLBACK_USED = NO).
- Binary: build-p3/bin/llama-server (sha256 re-verified post-restore).
- Flags: prod_flags.env verbatim including spec flags draft-mtp/n-max 4/p-min
  0.8 and GGML_CUDA_DISABLE_GRAPHS intentionally unset (matches actual
  pre-window production process).
- Log: ops/logs/llama-server.20260824_190834.log; model loaded in ~3 s
  (page-cached).
- PID 505420 written to ops/run/llama-server.pid; /proc/PID/exe validated ->
  build-p3/bin/llama-server.
- Health: {"status":"ok"} (restore/final_health.json); metrics snapshot saved
  (restore/final_metrics.txt; spec_decode counters active).
- Semantic check vs stored production baseline outputs: 6/6 output-prefix
  MATCH. The math2 test "expects 80" but the STORED BASELINE ITSELF records
  math2 as fail with the identical "  40 **Step-by-step Deduction:**..." head;
  restored output is character-identical to baseline. No regression.
- Note: ops/bin/prod_stop.sh and prod_start.sh still hardcode the stale
  build/bin production path; the identical validated-pidfile procedure was
  executed manually (stop) and via an equivalent script using the corrected
  manifest path (start). See open issues.

## 15. Open issues

1. ops/bin/prod_start.sh / prod_stop.sh hardcode build/bin as PROD_BIN,
   contradicting the corrected manifest (build-p3). Any future operator use
   would mis-validate or mis-launch. Needs a human-approved ops fix.
2. Profiled (rocprofv3-wrapped) servers ignore SIGINT beyond 300 s; every
   traced stop required SIGKILL escalation (recorded in logs/force_kills.txt).
   Trace buffers flushed intact every time (verified by file sizes/timestamps
   and internally consistent call counts).
3. Weight-type ledger drift: evidence_ledger sec 2.10 says v-proj 0.05 GB
   IQ4_XS and IQ3_S ~1.57 GB; GGUF header shows IQ4_XS 0.202 GiB total and
   IQ3_S 1.282 GiB; token_embd is Q2_K (0.389 GiB) and never streams through
   GEMV. Ledger should be corrected from env/model_bytes_by_type.json.
4. Superlinear staging/tile scaling mechanism unexplained (see sec 8/11) -
   candidate for a focused micro-investigation before designing fixes.
5. Host gap of ~4-5 ms/token (post trace-overhead correction) remains
   unattributed; small but non-zero. Only worth chasing after the big rocks.
6. Disk headroom on /home is tight (~15 GB free). Raw traces kept per policy
   (T_P3 trace alone is 302 MB; total ~600 MB - fine now, but watch it).
7. Swap baseline drift (+3.3 GiB stale pages accumulated during repeated
   profiler instance loads) documented; self-reclaimed during the 128k traced
   arm. No action needed, but future windows should snapshot swap right
   before each gated arm.

## 16. Recommended next phase

Design-only follow-ups (no implementation without a new approved design
phase), in evidence order:

1. Design study: eliminate per-call full-cache q4_0->F16 staging in TILE
   attention (persistent incremental F16 K/V sidecar for the 16 dense
   layers). Largest lever at 63k/128k (up to ~20 ms/token at 128k), directly
   attacks both decode staging and a large part of the PP tile growth.
2. Design study: IQ3_XXS GEMV efficiency (RDNA3 mmvq launch config, esp. the
   nwarps=1 single-wavefront issue) - 262 GB/s effective vs 624 nominal caps
   the entire MTP OFF ceiling at every context.
3. Optional micro-task: explain superlinear staging/tile scaling before
   choosing between sidecar layouts (informs item 1 design choices).

Explicitly NOT recommended from this evidence: quantize-launch elimination
(refuted, ~0.6 ms/token), KV store path work (refuted at mid context),
GDN-specific work (0.5 ms/token), graph tuning (dormant).
