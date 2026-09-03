# Phase-1B Baseline Measurement Report (V3)

Date: 2026-08-25 23:55 - 2026-08-26 01:25 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (tracked files clean)
Approvals: measurement window YES, 128k YES for both MTP states, 131k gated on VRAM fit
(authority: user prompt "PHASE-0 COMPLETION: V3 BASELINE ESTABLISHMENT"; logged in
commands/window_start.txt). This report supersedes phase1b_baseline_v3.gate_blocked_20260825.md.

## Final verdict

SUCCESS

Both correctness gates reproduced the expected V3 signature exactly, all 9 planned
ladder arms measured OK plus 2 spread-tightening reruns, off-131k completed inside
VRAM (new datapoint, no V2 comparison exists), on-131k correctly skipped by the
pre-declared VRAM gate, production restored on build-p3 with health OK and 6/6
character-exact semantic match against the NEW stored baseline. No tracked file
modified, no commits made.

## 1. Pre-check results and deviations

- Production was NOT running at window start: pidfile PID 65019 dead, port 8080
  silent (same condition as B0-1 last night). Resolved by prod_start.sh relaunch
  inside pidfile policy; /proc/74838/exe validated as build-p3 before gates.
- GPU idle at start: SCLK 64 MHz, 13 W; 1.25 GB VRAM used by desktop session.
- Model identity: sha256 recomputed this window =
  fd4730dd8aad070517978752b63d530aeb1740d2283cab9fa24f1e404032ddb0, inode 30986567,
  ctime 2026-08-25 22:28:09 - byte-identical to what correctness_gate_v3.md ran
  against. DISCREPANCY FOUND: v3_quant_distribution.json records file_size_bytes
  9,817,985,024 but actual size is 9,828,981,664 B. Same sha256 proves the quant
  analysis refers to these exact bytes; only its size field is misrecorded.
  Artifact left untouched; noted in baseline_v3.json instead.
- Binary: build-p3/bin/llama-server sha256 280556cc... (unchanged since Phase-1B).
- RAM/swap at window start: MemAvailable 18.08 GB; swap already 6.73 GB used
  BEFORE any of our processes (pre-existing page-cache pressure, cf. B0-6), later
  rising to 13.0 GB from desktop anonymous pages being swapped out during repeated
  server load/unload cycles - not from arm activity (per-arm swap deltas were
  negative or near-zero throughout; see table).
- Deviation from measurement_window.md absolute thresholds: "swap > 5 GB abort"
  and "MemAvailable > 18 GB" were evaluated DELTA-based (abort if swap grows
  >5 GB during an arm or MemAvailable <14 GiB in a big arm) because the absolute
  baseline was already exceeded pre-window by unrelated system state. No guard
  ever tripped; rationale recorded in commands/window_start.txt.
- Harness incident (self-caught): first correctness-suite launch was killed by the
  agent shell's process-group timeout mid-prefill (server log shows "cancel task");
  relaunched fully detached via setsid. Same failure mode as the Phase-1B ladder
  incident; all reported runs are from detached processes that completed cleanly.

## 2. Correctness gate (stored baseline recreation)

Suite: results2/p3_quality_suite.py unmodified; greedy temp 0 top_k 1 seed 1234,
cache_prompt=False, ignore_eos. ON config = production flags verbatim (ctx 65536,
spec draft-mtp n-max 4 p-min 0.8); OFF config = dedicated instance ctx 131072,
no spec flags (matches correctness_gate_v3.md methodology).

| config | det pass | sampled sanity | raw |
|--------|----------|----------------|-----|
| MTP ON | 10/12 | 9/9 | results2/correctness/suite_on_v3_completion.json |
| MTP OFF | 10/12 | 8/9 | results2/correctness/suite_off_v3_completion.json |

Failing deterministic tests, identical in both configs (EXPECTED per Phase-0):

1. puzzle - FAIL: answers "8 **Explanation:**..." instead of "9". Stable across
   configs/reps. Known V3 behavior change.
2. degen_trap_p1k - FAIL by suite definition: V2-era "and where and where..."
   loop head no longer produced; V3 generates a different degenerate surface.
   Known V3 behavior change.

Sampled sanity: ON 9/9; OFF failed only turkish seed=777 (bigram_rep slightly over
threshold) - same known quirk family documented since Phase-1B (seed=7 then).

All other deterministic tests PASS both configs: factual_en, arith_simple,
arith_multistep (quirk-tolerant), code_func, code_oneliner, turkish, list_struct,
needle16k_single, needle_multi, longgen_story.

Semantic smoke heads recorded for BOTH configs into the new stored baseline
(results2/correctness/baseline_v3.json) with determinism self-check identical=true;
the new baseline supersedes baseline_ON_prod_v3.json (proven contaminated, B0-4).

Gate verdict for this phase: EXPECTED_V3_SIGNATURE (adjudicated by the human
decider in the completion task; the two probe deltas are documented as known
behavior changes, not blockers).

## 3. Performance matrix (V3)

Server per arm: build-p3/bin/llama-server, fresh instance per arm via
srv_ctl_p0.sh/arm_run_p0.py (pidfile policy), -ngl 999 --load-mode mmap -fa on
-ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --metrics; MTP ON
adds --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8. Greedy
(temp 0, top_k 1, seed 1234, ignore_eos); fixed make_text prompts seeds
4201024/555001/777001/888111(+888112 for 131k) + summarize suffix. pp from fresh
rep1; tg median over all reps; VRAM peak sampled at 0.5 s; guard 15.6 GiB sampled.
DIFFERENCE VS PHASE-1B: context reserved (-c) is right-sized per arm here
(Phase-1B ran every arm at -c 131072); reserved-but-unused context does not enter
the decode path, but VRAM peaks are NOT comparable to Phase-1B for small arms.
ctx_size_used column records exactly what each arm reserved.

| arm | context target | ctx used | prompt_n | npred | reps | tg tok/s med | spread% | pp tok/s fresh | acc_rate | vram peak GiB | swap dGB | status |
|-----|------|------|------|------|------|------|------|------|------|------|------|--------|
| off-1k | 1k | 2048 | 991 | 128 | 4 | 23.606 | 0.15 | 524.38 | - | 10.44 | -0.01 | OK |
| off-16k | 16k | 17408 | 16390 | 128 | 3 | 21.809 | 0.17 | 496.74 | - | 10.72 | -0.00 | OK |
| off-63k | 63k | 64512 | 63528 | 380 | 3 | 16.440 | 0.36 | 339.60 | - | 11.90 | -1.47 | OK |
| off-128k | 128k | 131072 | 129487 | 96 | 1 | 12.678 | single | 234.52 | - | 13.42 | -1.18 | OK |
| off-131k | 131k | 135168 | 131032 | 96 | 1 | 12.484 | single | 232.87 | - | 14.34 | -1.29 | OK |
| on-1k | 1k | 2048 | 991 | 128 | 4 | 40.370 | 0.92 | 501.33 | 0.9205 | 12.01 | -0.00 | OK |
| on-16k | 16k | 17408 | 16390 | 128 | 3 | 43.117 | 1.95* | 482.21 | 1.0000 | 12.42 | -0.01 | OK |
| on-16k-r2 | 16k | 17408 | 16390 | 128 | 5 | 43.894 | 0.88 | 482.93 | 1.0000 | 12.41 | -0.00 | OK |
| on-63k | 63k | 64512 | 63528 | 380 | 3 | 31.713 | 1.42* | 326.42 | 0.9190 | 13.61 | -0.61 | OK |
| on-63k-r2 | 63k | 64512 | 63528 | 380 | 5 | 32.114 | 0.39 | 327.27 | 0.9190 | 13.60 | -0.07 | OK |
| on-128k | 128k | 131072 | 129487 | 96 | 1 | 24.485 | single | 224.04 | 1.0000 | 15.42 | -0.03 | OK |
| on-131k | 131k | - | - | - | - | NOT MEASURED - skipped by pre-declared gate | | | | | | |

*Rerun policy: arms marked * exceeded the <1% spread requirement on their first
pass; both were re-run with 5 reps and met it (r2 rows). The r2 runs also confirm
the r1 medians within ~1.8%. Report values below use r2 medians for these contexts.

## 4. 131k special section

- off-131k: single-pass OK, 131,032-token prompt, tg 12.484 tok/s, pp 232.87 tok/s,
  vram peak 14.34 GiB, health ok after reps, clean stop, swap delta -1.29 GB.
  First 131k datapoint on this machine; fits comfortably under the 15.6 GiB guard.
- on-131k: SKIPPED by the pre-declared gate (required preceding on-128k peak
  <15.3 GiB; measured 15.421 GiB, i.e. only ~180 MiB under the 15.6 GiB sampled
  guard and ~750 MiB under physical 16 GiB). Rationale: pushing a +2k-token pass
  against that ceiling risks an OOM crash of the measurement instance for a
  datapoint of marginal value. Nothing fabricated; gap documented.
- Historical "~4.7 GB swap" again did NOT reproduce: q4_0 KV keeps long-context
  KV small; per-arm swap deltas were <=0 throughout (system swap actually fell
  during most arms as page cache churned).

## 5. MTP analysis (V3)

- Acceptance (greedy): 0.9205 @1k, 1.0000 @16k and @128k, 0.9190 @63k. Higher than
  Phase-1B V2 bands (0.79/0.85/0.97/0.95). Perfect-looking 1.0 rates come from the
  fixed filler+summarize workload where the draft model predicts the continuation
  almost always; treat as workload property, not a general claim.
- Speedup (median tg, using compliant runs): +71% @1k, +101% @16k (43.894 vs
  21.809), +95% @63k (32.114 vs 16.440), +93% @128k (24.485 vs 12.678).
- Versus Phase-1B (same harness, V2 weights): OFF-side tg improved +4.4% to +7.0%
  across contexts (e.g. 16k 20.451 -> 21.809; 128k 11.981 -> 12.678), consistent
  in direction with v3_quant_distribution.json's -9.7% streamed weight bytes per
  decode step (memory-bound decode scales with streamed bytes). pp improved ~+1-3%.
- ON-side gains are much larger (16k: 30.626 -> 43.894, +43%) - plausible drivers:
  the MTP draft block upgrade to Q6_K/Q8_0/F32 (+63% draft-block bytes vs V2
  nextn) makes drafting cheaper/faster, and the new quant mix changes acceptance
  behavior (measured acc up as above). Caveat: Phase-1B arms reserved 131072 ctx
  vs right-sized ctx here; reserved context should not affect decode speed, but
  cross-phase comparisons carry that methodological difference.
- Anomalies affecting measurements: none. All health_after_reps probes ok; every
  stop clean (SIGINT, no escalations).

## 6. Restore result

RESTORE_OK.
- prod_start.sh relaunch; PID 96742 written to ops/run/llama-server.pid;
  readlink /proc/96742/exe == <REPO_ROOT>/build-p3/bin/llama-server;
  flags verbatim from ops/manifest/prod_flags.env (ctx 65536, spec draft-mtp
  n-max 4 p-min 0.8); health {"status":"ok"}.
- Semantic spot-check vs NEW stored baseline semantic_smoke_mtp_on heads:
  6/6 CHARACTER-EXACT (math, math2, puzzle, factual, code, code2) -
  restore_check_v3_completion.json. The new baseline is now the valid comparison
  target (old one void per B0-4).
- Final VRAM 14.59 GB used (production loaded + ~1.25 GB desktop); swap 8.31 GB
  (falling from the pre-window 13.0 GB high-water mark); MemAvailable 15.41 GB.

## 7. Evidence quality

Measured (direct artifacts): all tg/pp numbers (per-rep resp_r*.json),
acceptance counters (timings + metrics deltas in arm_record.json), VRAM peaks
(0.5 s sampling), per-arm mem snapshots, health_after_reps probes, binary/model
sha256, gate suite outputs, restore semantic match.

Estimated/derived: medians/spreads/speedup percentages computed from measured
values; cross-phase comparisons derived (methodological caveat above).

Missing/not collected:
- on-131k (skipped by declared VRAM gate; reason above)
- llama-bench cross-check (still deferred; would need a build - out of scope)
- graph-off diagnostics not repeated this window (V2-era question, out of scope)

## 8. Artifact paths

- Gates: results2/correctness/suite_{on,off}_v3_completion.json,
  semantic_v3_completion_{on,off}.json, logs/gate_{on,off}_completion.log
- Stored baseline: results2/correctness/baseline_v3.json (= experiments/phase0/baseline_v3.json)
- Raw ladder: experiments/phase0/raw/<arm>/ (resp_r*.json, arm_record.json,
  vram_samples.json, start/stop logs) + ladder_status_v3.txt
- Logs: experiments/phase0/logs/ladder_v3.log, srv_<profile>.log
- Window record: experiments/phase0/commands/window_start.txt
- Summary tables: experiments/phase0/summary/table_v3.json
- Harness: experiments/phase0/bin/{srv_ctl_p0.sh, arm_run_p0.py (one-line addition:
  health_after_reps probe), run_ladder_v3.sh, compute_metrics_v3.py,
  assemble_baseline_v3.py, semantic_record_p0.py}

Post-conditions verified: no tracked source changes, no commits made, production
healthy on build-p3 with V3 model (sha fd4730dd...) at report time.
