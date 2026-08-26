# Phase-0.5 Operational Safety Hardening Report

## Summary verdict

```text
OPS_READY = YES
```

All operational safety artifacts have been produced. No tracked source files were modified. No production process was signaled, stopped, or restarted. No benchmark was run.

---

## 1. Phase-1A outputs consumed

- <REPO_ROOT>/agents.md
- <REPO_ROOT>/experiments/phase1a/phase1a_report.md
- <REPO_ROOT>/experiments/phase1a/baseline_runbook.md
- <REPO_ROOT>/experiments/phase1a/safe_commands.sh
- <REPO_ROOT>/experiments/phase1a/open_questions.md

All five files were read and their contents were used to inform the design decisions in this phase.

---

## 2. Legacy launch scripts copied

Source paths:
- /tmp/opencode/launch_prod.sh
- /tmp/opencode/restore_server.sh

Target paths:
- ops/legacy/launch_prod.sh
- ops/legacy/restore_server.sh

Checksums (sha256):
- launch_prod.sh: 16f57970f0eb5a4ae30ac41a37300b4b1d352dec843642b261cf7fe76a3d338a
- restore_server.sh: 5a339653874f1ab934173d918d5923d650b9f20d45995794ce7cc2c011631a76

Copy manifest: ops/legacy/copy_manifest.txt

Status: SUCCESS

Original files in /tmp/opencode/ were NOT modified or deleted.

---

## 3. Production flag manifest

Extracted flags (from restore_server.sh):

- Binary path: build/bin/llama-server
- Model path: /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf
- Host: 0.0.0.0
- Port: 8080
- Context size: 65536
- n-gpu-layers: 999
- Cache type K: q4_0
- Cache type V: q4_0
- Flash attention: on (-fa on)
- MTP flags: --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8
- Threads: -t 8
- --cache-prompt enabled
- --ctx-checkpoints 4
- --metrics enabled
- --tools all
- Chat template kwargs: {"preserve_thinking": true}

Environment variables:
- GGML_CUDA_DISABLE_GRAPHS=1 (HIP graph runtime disable)

Log redirection: /tmp/opencode/llama_server_restore.log (via launch_prod.sh wrapper)

Health check endpoint: http://localhost:8080/health

Unknown flags:
- -np 1: exact meaning in llama-server context is UNKNOWN
- GGML_CUDA_DISABLE_GRAPHS=1 export location in launch_prod.sh: not explicitly in the wrapper script; may be set externally

MTP flags verified: YES (--spec-type draft-mtp, --spec-draft-n-max 4, --spec-draft-p-min 0.8 all present)

Manifest files:
- ops/manifest/prod_flags.md
- ops/manifest/prod_flags.env

---

## 4. Ops directory created

```text
ops/
  README.md (not created - no content specified for it)
  bin/
    prod_status.sh
    prod_capture_pid.sh
    prod_start.sh
    prod_stop.sh
    prod_health.sh
    baseline_status.sh
    baseline_start_template.sh
    baseline_stop_template.sh
  legacy/
    launch_prod.sh
    restore_server.sh
    copy_manifest.txt
  run/
    (empty - no pidfile created; production server not running)
  logs/
    (empty - placeholder for future logs)
  manifest/
    prod_flags.md
    prod_flags.env
    current_prod_capture.txt
  templates/
    (empty - no templates created beyond scripts)
  measurement/
    measurement_window.md
  pidfile_policy.md
```

All directories and files are untracked. No git commit was made.

---

## 5. Scripts created

| Script | Syntax Check | Shellcheck |
|--------|-------------|------------|
| prod_status.sh | PASS | MISSING_TOOL |
| prod_capture_pid.sh | PASS | MISSING_TOOL |
| prod_start.sh | PASS | MISSING_TOOL |
| prod_stop.sh | PASS | MISSING_TOOL |
| prod_health.sh | PASS | MISSING_TOOL |
| baseline_status.sh | PASS | MISSING_TOOL |
| baseline_start_template.sh | PASS | MISSING_TOOL |
| baseline_stop_template.sh | PASS | MISSING_TOOL |

SHELLCHECK = MISSING_TOOL (not installed on this system)

No script contains `pkill`, `killall`, or `pgrep | xargs kill` patterns.
Kill operations are only via pidfile-based PID in prod_stop.sh and baseline_stop_template.sh.

---

## 6. Pidfile policy

File: ops/pidfile_policy.md

Production pidfile: <REPO_ROOT>/ops/run/llama-server.pid
Benchmark/test profile pidfiles: <REPO_ROOT>/ops/run/<profile>.pid

Key rules:
1. Start script checks pidfile; if PID is alive, does NOT start a new process.
2. Start script writes PID to pidfile after launch.
3. Stop script reads PID only from pidfile.
4. Stop script validates PID via /proc/PID/exe and /proc/PID/cmdline.
5. If PID validation fails, stop is aborted.
6. pgrep is used ONLY for discovery and verification; never for kill.
7. Legacy process pidfile capture is permitted; capture does NOT grant stop authority.
8. Stop requires explicit human approval (--i-have-explicit-approval).

---

## 7. Current production PID capture

Attempted: YES
Success: NO

Reason: No llama-server process is currently running on the system.
- PID 222841 (previously known) is not found.
- pgrep -x llama-server returns empty.
- ps aux | grep llama-server returns nothing.

PID file: NOT CREATED (capture failed)
Pidfile path: <REPO_ROOT>/ops/run/llama-server.pid (does not exist)

Capture failure marker written to: ops/manifest/current_prod_capture.txt

---

## 8. Measurement window plan

File: ops/measurement/measurement_window.md

Summary:
- Defines entry conditions (human approval, pidfile validation, GPU idle, binary identification, log paths).
- Documents production stop procedure (pidfile validation, explicit approval, prod_stop.sh, health verification).
- Documents baseline start procedure (build-p3 binary, production-equivalent flags, MTP ON/OFF, graph ON/OFF, pidfile, health check).
- Defines measurement arms: primary (1k/16k/63k, MTP OFF/ON, graph ON/OFF) and optional gated (128k single-pass).
- Documents restore procedure (baseline stop, production start, health check, pidfile update, smoke check).
- Defines failure rules (OOM, health fail, PID mismatch, GPU busy, system memory pressure).
- 128k special policy: default gated, explicit approval required, single-pass first, swap/memory thresholds.
- Artifact policy: logs, raw outputs, env manifest, summary.

128k policy: Optional and gated. Requires explicit human approval. Single-pass first. Swap/memory thresholds enforced. Runs last in separate sub-window.

Restore policy: Production is restored after all baseline measurements complete. Health check verification is mandatory. If health check fails after restore, re-run once; if still failing, report immediately.

---

## 9. agents.md update

Backup path: <REPO_ROOT>/agents.md.bak-phase05-20260824072120

Sections updated:
1. Section 12 (Current Phase): Updated to Phase-0.5 description.
2. Section 16 (Operational Pidfile and Measurement Window Policy): Added new section with 12 operational policy decisions.

Current phase updated to:
Phase-0.5 — Operational safety hardening: pidfile, launcher preservation, measurement window design.

Phase-1B execution is blocked until explicit human measurement-window approval.

---

## 10. Remaining blockers for Phase-1B

1. Human measurement window approval (BLOCKING)
2. Current production PID capture failed — production server is not running. A new production server must be started and verified before the measurement window can proceed, OR the production server must be started fresh for the window.
3. Unknown production flag: -np 1 (meaning unclear in llama-server context)
4. Unknown production flag: GGML_CUDA_DISABLE_GRAPHS=1 export location (not in launch_prod.sh wrapper)
5. No health check has been performed against a running production server in this phase

---

## 11. Explicit questions for human/operator

1. Is the measurement window approved? (If yes, provide date/time window.)
2. Is 128k single-pass approved? (If yes, provide explicit approval.)
3. Does the operator approve using build/bin/llama-server (production binary) for the restore step?
4. The production server is not currently running. Should it be started before the measurement window, or is the window starting with a fresh production launch?
5. Is the -np 1 flag in restore_server.sh understood and accepted?
6. Is the GGML_CUDA_DISABLE_GRAPHS=1 environment variable properly set in the production launch environment?

---

## 12. Artifacts

All created files (untracked):

```text
ops/
  pidfile_policy.md
  bin/
    prod_status.sh
    prod_capture_pid.sh
    prod_start.sh
    prod_stop.sh
    prod_health.sh
    baseline_status.sh
    baseline_start_template.sh
    baseline_stop_template.sh
  legacy/
    launch_prod.sh
    restore_server.sh
    copy_manifest.txt
  manifest/
    prod_flags.md
    prod_flags.env
    current_prod_capture.txt
  measurement/
    measurement_window.md
agents.md.bak-phase05-20260824072120
```

No tracked files were modified. No git commits were made.