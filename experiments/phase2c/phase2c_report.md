# Phase-2C Operational Fix Report

Date: 2026-08-24 (fix window, production stop approved by operator)
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Scope: ops script path fix, ledger drift correction, traced-server signal doc,
agents.md numerical-safety rule, restart validation. No source, kernel, CMake,
build, model, quantization, or git changes were made.

## Final verdict

PARTIAL

Tasks 1-4 completed and verified. Task 5 (restart via corrected script) is
BLOCKED: an unexpected live production server, started out-of-band by the
operator during this fix window, occupies port 8080 and is not in the pidfile.
No stop authority exists for it (pidfile policy: capture does not grant stop
authority; prohibition: no process touched outside the validated pidfile
procedure). The corrected scripts are ready and will be validated on the next
operator-approved stop.

## 1. Scripts fixed

- prod_start.sh before: PROD_BIN="${ROOT}/build/bin/llama-server"
- prod_start.sh after: PROD_BIN="<REPO_ROOT>/build-p3/bin/llama-server"
  + FALLBACK_BIN="<REPO_ROOT>/build/bin/llama-server" (clearly
  marked fallback-only) + comment block (build-p3 validated in Phase-1B and
  Phase-2B; build/bin fallback only; stop script validates /proc/PID/exe
  against PROD_BIN).
- prod_stop.sh before: PROD_BIN="${ROOT}/build/bin/llama-server"
- prod_stop.sh after: PROD_BIN="<REPO_ROOT>/build-p3/bin/llama-server"
  + FALLBACK_BIN (reference only) + same comment block. Stop logic unchanged:
  reads ops/run/llama-server.pid, validates /proc/PID/exe against PROD_BIN and
  cmdline model path, refuses to stop on validation failure, SIGTERM first,
  SIGKILL only with explicit --allow-force-kill, never pgrep-based kill.
- prod_status.sh: path reference existed (line 6) and was stale; updated to
  PROD_BIN="${ROOT}/build-p3/bin/llama-server" (no other change).
- Backups:
  - ops/bin/prod_start.sh.bak-phase2c-20260824-215813
  - ops/bin/prod_stop.sh.bak-phase2c-20260824-215813
  - ops/bin/prod_status.sh.bak-phase2c-20260824-215813
- bash -n: prod_start.sh OK, prod_stop.sh OK, prod_status.sh OK.
- shellcheck: MISSING_TOOL (not installed on host).

## 2. Ledger correction

- File: experiments/phase2a/evidence_ledger.md section 2.10 (fact 10).
- Old (drifted) values: total ~= 10.2-10.3 GB with per-group "ssm_out 0.65
  IQ3_S, dense q/k/o ~0.92 IQ3_S" (implies IQ3_S ~1.57 GB) and "v 0.05 IQ4_XS".
- Corrected values (exact, from source file):
  - streamed total = 10,237,562,880 B (9.530 GiB), excluding token_embd
  - IQ3_XXS 8,092,385,280 B (7.537 GiB)
  - IQ3_S 1,376,460,800 B (1.282 GiB)
  - Q3_K 546,304,000 B (0.509 GiB)
  - IQ4_XS 217,251,840 B (0.202 GiB)
  - IQ1_M 5,160,960 B (0.005 GiB)
  - token_embd Q2_K 417,177,600 B (0.389 GiB), excluded from streamed total
- Source file used: experiments/phase2b/env/model_bytes_by_type.json.
- Required one-line note appended to the item (token_embd consumed by
  get_rows, never by GEMV, excluded from streamed-weight total).
- Backup: experiments/phase2a/evidence_ledger.md.bak-phase2c-20260824-215813.
- No other part of the ledger was changed.

## 3. Traced-server signal doc

- File created: ops/docs/traced_server_signal_behavior.md
- Documents: SIGINT ignored beyond ~300 s under rocprofv3 (6/6 Phase-2B
  traced instances required SIGKILL escalation, see
  experiments/phase2b/logs/force_kills.txt); trace buffers flushed intact
  every time; recommendation to use short-lived traced instances and stop
  promptly; profiler artifact, not a production concern. No script changes.

## 4. agents.md numerical-safety rule

- Appended as new section "## 15. GEMV Numerical-Safety Rule (permanent)" at
  the end of agents.md (file otherwise untouched; rule text as specified:
  performance-only changes, no numerical path change; three mandatory gates -
  correctness gate, deterministic greedy comparison against baseline logits,
  MTP acceptance check; numerical-altering changes must be flagged and must
  not merge unless all three pass).
- Backup: agents.md.bak-phase2c-20260824-215813.

## 5. Production restart validation

- pidfile: ops/run/llama-server.pid contained 505420 (Phase-2B restore
  instance), PID DEAD -> stale pidfile removed, as instructed.
- GPU idle check: FAILED. A live production server exists outside the
  pidfile.
- Unexpected live production (operator-managed, out-of-band):
  - PID 568705, started 21:12:52 from the operator's kitty terminal
    (ppid chain: fish 568333 -> kitty 568320 -> Hyprland), exe
    <REPO_ROOT>/build-p3/bin/llama-server, full production cmdline
    (model, 0.0.0.0:8080, MTP spec flags), health ok. Died during this phase.
  - PID 575503, started 21:49:54 from the same terminal, same exe and
    cmdline, currently running, health {"status":"ok"}, VRAM ~15.4 GiB used.
  - The operator is actively restarting production from their own terminal
    during this fix window.
- Restart via corrected prod_start.sh: NOT EXECUTED (BLOCKED).
  - Port 8080 is occupied by the untracked live instance; a second start would
    fail to bind, and the script's health check would falsely pass against
    the existing server while the pidfile pointed at a dead PID.
  - No stop authority for the live instance: it is not in the pidfile, and
    pidfile policy rule 7 states capture does NOT grant stop authority.
  - Per prohibition, no process was touched outside the validated pidfile
    procedure.
- /proc/exe match: current live instance 575503 exe =
  <REPO_ROOT>/build-p3/bin/llama-server, which matches the
  corrected PROD_BIN (manual verification, read-only).
- Health: {"status":"ok"} (live instance 575503).
- Semantic spot-check (greedy: temp 0, top_k 1, seed 1234, n_predict 48,
  ignore_eos, 6 SMOKE prompts from results2/correctness_suite.py, run against
  live instance 575503): 6/6 output heads character-identical to the stored
  production baseline (experiments/phase2b/restore/semantic_check.json),
  including the known math2 quirk (baseline itself records math2 as fail;
  live output identical). No regression. Result saved to
  /tmp/opencode/phase2c_semantic_spotcheck.json.
- Start log path: N/A (no new start performed; live instance was started
  out-of-band from the operator's terminal and has no ops log).

## 6. Open issues

1. Restart validation of the corrected prod_start.sh remains outstanding:
   the operator is currently running production out-of-band (PID 575503, not
   in the pidfile). On the next operator-approved stop (validated pidfile
   procedure, explicit approval), run ops/bin/prod_start.sh to validate the
   corrected script end-to-end.
2. The live production PID is untracked (stale pidfile removed per task).
   Capture is permitted for tracking (capture does not grant stop authority).
   Note: ops/bin/prod_capture_pid.sh still validates against the stale
   build/bin path and would FAIL against a build-p3 instance; it is outside
   this phase's allowed-change list and is flagged for the operator.
3. shellcheck unavailable on host (MISSING_TOOL); bash -n used instead.
4. Phase-2B open issues 4-7 remain open (superlinear staging/tile scaling
   mechanism, ~4-5 ms/token host gap, /home disk headroom, swap snapshot
   discipline). Unchanged by this phase.
5. Phase-2B open issue 1 (stale ops script paths) is RESOLVED by this phase
   (scripts now match the corrected manifest). Phase-2B open issue 2 (traced
   server signals) is documented in ops/docs/traced_server_signal_behavior.md.
   Phase-2B open issue 3 (ledger drift) is RESOLVED by this phase.
