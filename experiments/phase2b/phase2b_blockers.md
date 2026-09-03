# Phase-2B Re-Run Blockers and Deviations

Date: 2026-08-25
Rule: empty would be fine; this file records every deviation honestly.

## B1. Execution-mode deviation (operator-approved)

The prompt mandated a full fresh execution although Phase-2B had already been
executed successfully on 2026-08-24 against the byte-identical binary
(sha256 280556cc..., git HEAD 66dcba5eb unchanged; Aug-24 artifacts under
experiments/phase2b/{results.md,traces,raw,logs}). Per explicit operator
choice ("Full fresh re-run") this window re-executed everything. Both runs
are retained; nothing from the Aug-24 dataset was modified.

## B2. U-128k / T-128k prompt overflow (HTTP 400) - resolved

bench.make_text tokenizer-adjustment tolerance (max(8, 1%) = +/-1311 tokens)
let the 128k prompt land at 131102 tokens > 131072 ctx on this window's run.
Server rejected with HTTP 400 BEFORE any GPU compute; no guard tripped; the
measurement instance stayed healthy.
Fix: deterministic fitting prompt built once and saved to
phase2b_raw/R_U-off-128k/prompt_128k_fit.txt (129048 tokens); used for both
R_U-off-128k and the T2_P3 traced arm. For T2_P3 the failed request hit a
FRESHLY STARTED instance whose trace then contained only load+warmup+the
real probe/main requests of attempt 2 on the SAME instance: single-pass
rule respected (exactly one traced 128k prefill+generation).
Recommendation: clamp make_text targets below ctx - n_predict - margin for
any future 128k arm.

## B3. p2b_run.py mem_snapshot swap-column bug (pre-existing)

mem_snapshot() sets swap_used_b = int(swap[3]) which is the SWAP FREE column
(swap[2] is used). Consequence: all Aug-24 "swap delta" values carry an
inverted sign convention. This window's reports use direct free -b column-3
accounting instead. The old script was left untouched intentionally; use
run_u128k.py/mem_snap or manual free parsing going forward.

## B4. rocprofv3 buffer-flush stalls during decode

Traced decode requests show stochastic single-step stalls of 0.1-0.5 s
(observed at steps ~12-13 of T2_P1-off-16k: 485 ms + 136 ms). These are
profiler-side buffer flushes, NOT server behavior:
- server-reported traced tg averages are depressed by them (e.g., 15.57
  tok/s @16k vs true steady-state ~19.2);
- per-step statistics in phase2b_attribution exclude steps whose period
  exceeds median x1.25-1.30, and stall events >=5 ms are listed separately;
- overhead gate uses clean medians (7.6% @16k), consistent with Aug-24's
  6.5% measured over a longer (128-token) window that diluted the stalls.
Implication for future runs: either trace more tokens per window (Aug-24
style npred>=96) or always report clean-median step periods; never compare
raw short-window traced averages against untraced rates.

## B5. SIGKILL escalation on every traced stop (expected)

All four traced instances ignored SIGINT beyond 120 s (script wait) /
~300 s runtime as documented in ops/docs/traced_server_signal_behavior.md.
SIGKILL applied via srv_ctl_p2b.sh stop (recorded in logs/force_kills.txt,
appended). Trace integrity verified after each kill by file sizes and by
internally consistent call counts (433 quantize_row/step, 32 FA-tile/step,
40 or 36 lm_head markers == generated tokens).

## B6. Optional arm T-16k-MTPON skipped

Prior operator decision (INCLUDE_O2_MTP_ON = NO, recorded in Aug-24
results.md sec 1) stands; the optional comparison arm was not run.

## B7. Session swap drift (no action needed)

Swap used: 57 MiB (pre-stop baseline) -> ~3.6 GB after untraced arms ->
~5.3 GB at end of window. Driven by page-cache pressure from repeated
10.7 GB model mmaps + trace CSV writes; MemAvailable stayed >= 18.1 GB;
within-arm deltas far below the 512 MiB abort rule (largest: +187 MiB on
T2_P3). Recorded for completeness; recommend swap snapshot immediately
before each future gated arm (as done here).

## B8. Weight-ledger correction discovered during analysis

env/model_bytes_by_type.json totals include blk.64 nextn tensors
(IQ3_S 42,803,200 B + IQ4_XS 172,687,360 B) which NEVER stream during MTP
OFF decode. Corrected MTP-OFF streamed total = 10,022,072,320 B vs ledger
10,237,562,880 B. This resolves the Aug-24 open issue 3 / IQ4_XS "1826 GB/s"
anomaly: corrected IQ4_XS effective BW is 376 GB/s (60% of nominal), in
line with Q3_K's 374 GB/s. IQ3_XXS bytes were unaffected (no nextn XXS).

## B9. Analysis-script bug found and fixed during this window

analyze_arm.py initially extended each step's wall to the NEXT marker
(off-by-one), doubling apparent step periods (102 vs 52 ms). Caught by
cross-checking marker-to-marker distances; fixed before any reported
number was produced. No artifact written with wrong walls except one
intermediate derived JSON that was overwritten by the fixed rerun.
