# Phase-2C-EXT End-to-End Validation Report

Date: 2026-08-24
Scope: operational validation only. No source/kernel/build/model/git changes made.

## Final verdict

VALIDATION_OK

## 1. prod_capture_pid.sh fix

- Backup path: `ops/bin/prod_capture_pid.sh.bak-phase2c-ext-20260824-221046`
- New validation path: `<REPO_ROOT>/build-p3/bin/llama-server`
  (`PROD_BIN="${ROOT}/build-p3/bin/llama-server"`, line 6; single-line change)
- `bash -n`: SYNTAX_OK
- Semantics preserved: capture does not grant stop authority; /proc/PID/exe +
  cmdline model match required; single candidate only, abort on ambiguity;
  pidfile written only after verification.
- Live exercise of the fixed capture script was NOT needed: prod_start.sh wrote
  the pidfile itself (see section 3), so the Task-4 fallback did not trigger.

## 2. Pre-start state

- Pidfile `ops/run/llama-server.pid` before: absent (ops/run/ empty).
- Out-of-band process detected: YES.
  - PID 575503, exe = `<REPO_ROOT>/build-p3/bin/llama-server`,
    cmdline `-c 131072` (operator kitty session flags, not prod flags),
    port 8080 bound, 13.9 GB VRAM held.
  - Reported OUT_OF_BAND_RUNNING / NEEDS_OPERATOR_STOP. Not signaled by agent
    (no stop authority outside validated pidfile procedure).
  - Operator stopped it from their own terminal; re-check confirmed:
    /proc/575503 gone, zero llama-server processes, GPU idle
    (1068/16368 MB baseline VRAM, GFX 0-5%).
- Port 8080 before start: free.

## 3. prod_start.sh execution

- Exit code: 0 ("=== Production server started successfully ===")
- Start log path: `ops/logs/llama-server.20260824_221157.log`
- PID written to pidfile: **579238** (`ops/run/llama-server.pid`)
- `/proc/579238/exe` = `<REPO_ROOT>/build-p3/bin/llama-server`: MATCH
- `/health`: `{"status":"ok"}` (~10 s after launch)

## 4. Semantic spot-check

- Setup: 6 SMOKE prompts from `results2/correctness_suite.py`, temp 0,
  top_k 1, seed 1234, n_predict 48, ignore_eos, greedy.
- 6/6 match vs `experiments/phase2b/restore/semantic_check.json`: **yes**
  (all 6 expectation checks pass in current run; note baseline also had the
  same single expect-miss on "math2", reproduced identically).
- Comparison method note: the stored baseline heads were sliced at ~112-120
  chars, the current suite slices at 80 chars. All 6 current heads are byte-
  exact prefixes of their baseline heads (verified programmatically,
  BASELINE_REPRO_PREFIX_6_OF_6 = True). Content identical to truncation point.
- Output file path: `ops/logs/semantic_spotcheck_phase2c_ext.json`

Per-test:

| test | expect_pass | baseline prefix match |
|------|-------------|-----------------------|
| math | true | true |
| math2 | false (same as baseline: answers "40", deterministic) | true |
| puzzle | true | true |
| factual | true | true |
| code | true | true |
| code2 | true | true |

## 5. Final production state

- PID: 579238 (uptime ~2 min at final check, RSS ~2.8 GB)
- Pidfile path: `ops/run/llama-server.pid`
- Health status: ok (`{"status":"ok"}`)
- VRAM usage: 13857/16368 MB (RX 7800 XT, via amd-smi)
- Binary sha256:
  `280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13`
  Matches Phase-1B fingerprint `280556cc`: YES

## 6. Open issues

1. `prod_capture_pid.sh` fix is syntax-validated but was not exercised live
   this phase (pidfile was populated by prod_start.sh directly). Next natural
   exercise: next planned production restart cycle.
2. Head-slice length mismatch between current `correctness_suite.py` (80
   chars) and the phase2b baseline generator (~120 chars). Harmless; future
   comparisons should use prefix matching or regenerate the baseline with the
   current suite.
3. "math2" smoke expectation miss is pre-existing and deterministic (model
   answers 40 instead of 80 km/h); identical in baseline and current run.
   Known model behavior, not a regression.
