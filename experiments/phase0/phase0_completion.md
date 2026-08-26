# Phase-0 Completion: V3 Baseline Establishment

Date: 2026-08-25 23:55 - 2026-08-26 01:25 +03
Executor: agent session under the "PHASE-0 COMPLETION" task prompt.
Scope kept: no kernel/launch/model modifications, no optimization, GGUF untouched.

## Verdict

COMPLETE. V3 baselines are established and stored; production restored and
validated. Final line: RESTORE_OK (evidence in section 5).

## 1. Pre-flight (section 2 of task)

| check | result |
|-------|--------|
| P0C-0a production running build-p3 + V3 | FAILED as stated at window open: pidfile PID 65019 dead, port 8080 silent (same as B0-1). RESOLVED by prod_start.sh relaunch; /proc/<pid>/exe validated == build-p3/bin/llama-server, MTP draft context confirmed in log. Deviation recorded in commands/window_start.txt. |
| P0C-0b GPU idle | PASS: SCLK 64 MHz, 13 W, GPU ~0%; 1.25 GB VRAM = desktop session |
| P0C-0c initial VRAM + swap | VRAM used 1.25 GB / 16 GiB total; swap 6.73 GB pre-existing (13.0 GB peak mid-window from unrelated desktop anon pressure; per-arm deltas <=0); MemAvailable 18.08 GB at start |

Fingerprints: model sha256 fd4730dd... (recomputed this window, byte-identical to
the Phase-0 gate bytes; note v3_quant_distribution.json's size field is misrecorded,
actual 9,828,981,664 B); binary sha256 280556cc...; git HEAD 66dcba5eb, tracked clean.

## 2. Stored baseline recreation (section 3)

results2/p3_quality_suite.py run in both configs; outputs combined into
results2/correctness/baseline_v3.json (copy: experiments/phase0/baseline_v3.json).

| config | det | sampled | puzzle | degen_trap |
|--------|-----|---------|--------|------------|
| MTP ON (prod flags, ctx 65536) | 10/12 PASS | 9/9 | FAIL ("8", known) | FAIL (new loop surface, known) |
| MTP OFF (ctx 131072, no spec) | 10/12 PASS | 8/9 (turkish s=777 known quirk) | FAIL ("8", known) | FAIL (new loop surface, known) |

Both failures reproduce EXACTLY the expected findings from correctness_gate_v3.md
and are documented in baseline_v3.json as "known V3 behavior changes":
puzzle answers 8 instead of 9; degen_trap_p1k degenerates on a different trigger.
All other deterministic tests pass in both configs. Semantic smoke heads for both
configs recorded into baseline_v3.json with determinism self-check identical=true;
this new baseline supersedes the void/contaminated baseline_ON_prod_v3.json (B0-4).

## 3. Baseline measurements (section 4)

Full ladder executed per Phase-1B methodology (fresh instance per arm, pidfile
policy, greedy, fixed prompts, pp from fresh rep1, >=3 reps with spread <1% -
two ON arms needed a 5-rep rerun to meet the spread criterion, both disclosed).
Contexts: 1k/16k/63k/128k both MTP states; 131k measured for OFF (fits: peak
14.34 GiB), skipped for ON by the pre-declared VRAM gate after on-128k peaked
15.42 GiB - reason documented, nothing fabricated.

Headline numbers (tg tok/s med, pp fresh, acc):

| ctx | OFF tg | OFF pp | ON tg | ON pp | acc | speedup |
|-----|--------|--------|-------|-------|-----|---------|
| 1k | 23.606 | 524.4 | 40.370 | 501.3 | 0.92 | +71% |
| 16k | 21.809 | 496.7 | 43.894 | 482.9 | 1.00 | +101% |
| 63k | 16.440 | 339.6 | 32.114 | 327.3 | 0.92 | +95% |
| 128k | 12.678 (s) | 234.5 | 24.485 (s) | 224.0 | 1.00 | +93% |
| 131k | 12.484 (s) | 232.9 | not measured (gate) | - | - | - |

(s) = single-pass per 128k policy. Full table with spreads/reps/VRAM:
experiments/phase0/phase1b_baseline_v3.md section 3.

Key finding: V3 OFF-side decode is +4.4..7.0% faster than V2 across contexts,
consistent with the quant distribution's -9.7% streamed bytes per step; MTP ON
gains much more (draft block upgraded to Q6_K/Q8_0), with acceptance rates up.

## 4. Outputs (section 5)

- results2/correctness/baseline_v3.json AND experiments/phase0/baseline_v3.json
- experiments/phase0/phase1b_baseline_v3.md (supersedes .gate_blocked_20260825.md stub)
- experiments/phase0/phase0_completion.md (this file)
- Supporting raw artifacts under experiments/phase0/{raw,logs,commands,bin,summary}

Reporting discipline (section 6): every number carries context label + MTP state +
rep count + spread where applicable; units are tok/s (server-reported timings);
all conditions same-window; deviations listed explicitly (stale pidfile restart;
delta-based swap guard interpretation; process-group kill incident; ctx-resize
vs Phase-1B methodology).

## 5. Restore (section 7)

- Production relaunched via ops/bin/prod_start.sh: PID 96742 in
  ops/run/llama-server.pid; readlink /proc/96742/exe ==
  <REPO_ROOT>/build-p3/bin/llama-server; flags verbatim prod_flags.env
  (V3 model, ctx 65536, spec draft-mtp n-max 4 p-min 0.8).
- Health: {"status":"ok"}.
- Semantic spot-check vs NEW baseline_v3.json (MTP ON heads): 6/6 CHARACTER-EXACT.
- Final VRAM: 14.59 GB used; swap: 8.31 GB (recovering); MemAvailable 15.41 GB.

RESTORE_OK
