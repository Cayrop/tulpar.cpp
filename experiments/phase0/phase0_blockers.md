# Phase-0 Blockers and Deviations

Date: 2026-08-25
Rule: records every deviation honestly; empty would be fine.

## B0-1. Production was NOT running at phase start (P0-0a failed as stated)

ops/run/llama-server.pid held PID 51668, dead; no llama-server process on the
host; port 8080 silent. Whoever stopped the previous instance tonight left a
stale pidfile. Resolved inside pidfile policy only (prod_stop.sh removed the
stale entry; prod_start.sh relaunched). No pkill/killall used anywhere.

## B0-2. Model file was replaced twice this evening (mtime-preserving copy)

Evidence chain:
- model mtime 21:48:47, ctime 22:28:09 (+03). A ctime later than mtime with a
  server started at 21:49:53 means the inode data changed AFTER that server
  loaded the path.
- The 21:49:53 instance produced outputs character-identical to the V2-era
  baseline (semantic_check_rerun.json 6/6 at 21:52:51) - only possible with
  behaviorally V2-equivalent weights.
- Current bytes (sha256 fd4730dd..., inode 30986567, verified == server mmap)
  have an IQ2/IQ3-heavy dynamic distribution and do NOT reproduce those heads.

Consequences:
1. experiments/phase2b/restore/semantic_check_rerun.json is VOID for the
   current file (recorded against pre-22:28 bytes).
2. This phase's measurements and gate results all refer to the CURRENT bytes
   (sha fd4730dd...), which are treated as the intended V3 placement
   (9.83 GB matches the phase's expectation).
Recommendation: swap procedures should log sha256 + ctime/mtime + size in the
ops manifest at every replacement, and never use timestamp-preserving copies
without recording it.

## B0-3. GATE_FAIL -> baselines not run (phase rule applied)

Deterministic suite 10/12 both configs; semantic spot-check 2/6 vs stored
baseline. Full analysis and decision framing:
correctness_gate_v3.md. Phase-1B-style baseline ladder intentionally NOT
started; see phase1b_baseline_v3.md.

## B0-4. Stored semantic baseline is contaminated (pre-existing, now proven)

baseline_ON_prod_v3.json "factual" out_head echoes "capital of Germany" while
the test prompt asks about France - KV/LCP slot reuse from its recording
session leaked into the stored heads. Any future character-exact criterion
must be recorded with cache_prompt=False and fresh slot state.

## B0-5. Harness-side sizing bug in my needle_128k helper (self-caught)

First attempt sent a ~195k-token prompt -> HTTP 400 BEFORE any GPU compute;
no guard tripped; measurement instance stayed healthy. Fixed by correcting
the build_needle_prompt argument mapping (~1.55x word-to-token factor);
second attempt landed 124,119 tokens and PASSED.

## B0-6. Minor operational notes

- rocm-smi prints "AMD GPU device(s) is/are in a low-power state" after every
  clean stop - benign power-state transition message, VRAM numbers valid.
- System swap used is high tonight (13.67 GB of 33.56 GB at restore time,
  up from ~6.4 GB pre-phase) driven by page-cache pressure from repeated
  ~9.8 GB model mmaps across the evening; MemAvailable >= 18-20 GiB
  throughout; no arm-level swap surge occurred (no performance arms ran).

## Not blocked / verified healthy

- Binary fingerprint unchanged (280556cc...); git HEAD 66dcba5eb unchanged;
  no tracked files modified by this phase.
- All stop/start cycles used the validated pidfile scripts; every stop was a
  first-try SIGINT success (no SIGKILL escalations in this phase).
