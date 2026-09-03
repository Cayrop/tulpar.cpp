# Measurement Window Plan

## Phase-1B Execution Plan

This document defines the safe procedure for running the Phase-1B measurement window.
It requires explicit human approval before any execution.

---

## 1. Entry Conditions

All of the following must be satisfied before starting:

1. Human approval for measurement window (logged with operator name and time window).
2. Production pidfile validated (ops/run/llama-server.pid contains a verified, alive PID).
3. GPU idle plan confirmed (VRAM < 500 MB after production stop).
4. Backup/restore binary identified (build/bin/llama-server).
5. Baseline binary identified (build-p3/bin/llama-server).
6. Log paths prepared (ops/logs/ directory exists and has space).
7. ALLOW_FULL_BENCHMARK=YES set by operator.
8. ALLOW_PRODUCTION_SERVER=YES set for restore phase only.

---

## 2. Production Stop Procedure

1. Verify pidfile exists and PID is alive.
2. Validate PID via /proc/PID/exe == build/bin/llama-server.
3. Validate PID via /proc/PID/cmdline contains model path.
4. Log operator approval in commands/window_start.txt.
5. Run ops/bin/prod_stop.sh --i-have-explicit-approval.
6. Wait for process to exit (SIGTERM, up to 120s).
7. Verify production server is down: curl -s -m 3 http://localhost:8080/health must fail.
8. Verify no llama-server processes remain: pgrep -x llama-server must return empty.
9. Verify GPU VRAM is idle: rocm-smi --showmeminfo vram used < 500 MB.
10. If any step fails, ABORT window and report.

---

## 3. Baseline Start Procedure

1. Verify build-p3/bin/llama-server exists and is executable.
2. Verify no llama-server processes are running.
3. Verify port 8080 is free.
4. Start baseline server with production-equivalent flags.
5. Write PID to ops/run/baseline-<profile>.pid.
6. Wait for health check (up to 900s): curl -s -m 3 http://localhost:8080/health.
7. If health check fails, dump log tail and ABORT.
8. Record baseline binary identity (sha256 of libllama-server-impl.so).

### Baseline flags (from restore_server.sh)

```
COMMON=(-m /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf \
  --alias Qwen3.8-27b -c 131072 -ngl 999 --load-mode mmap \
  -fa on -ctk q4_0 -ctv q4_0 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
  --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --host 127.0.0.1 --port 8080 --metrics)
SPEC_ON=(--spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8)
```

### MTP OFF arms

- Omit --spec-type entirely (default none).

### MTP ON arms

- Append ${SPEC_ON[@]} to COMMON.

### Graph OFF arms

- Prefix command with GGML_CUDA_DISABLE_GRAPHS=1.

---

## 4. Measurement Arms

### Primary Arms (always run)

| Arm | Context | MTP | Graph | Notes |
|-----|---------|-----|-------|-------|
| A1 | 1k | OFF | ON | 4 reps (1 fresh + 3 cached) |
| A2 | 16k | OFF | ON | 3 reps |
| A3 | 63k | OFF | ON | 3 reps, npred 380 |
| A4 | 1k | ON | ON | 4 reps |
| A5 | 16k | ON | ON | 3 reps |
| A6 | 63k | ON | ON | 3 reps |
| A7 | 16k | OFF | OFF | 5 reps TG only |
| A8 | 63k | OFF | OFF | 5 reps TG only |
| A9 | 16k | OFF | OFF | 3 reps PP only |
| A10 | 63k | OFF | OFF | 3 reps PP only |

### Optional Gated Arms

| Arm | Context | MTP | Graph | Approval Required |
|-----|---------|-----|-------|-------------------|
| B1 | 128k | OFF | ON | Yes (single-pass, fresh process, memory guard) |
| B2 | 128k | ON | ON | Yes (single-pass, fresh process, memory guard) |
| B3 | 128k | OFF | OFF | Yes (single-pass, fresh process, memory guard) |

### 128k Special Policy

- Default: OPTIONAL (gated).
- Requires explicit human approval.
- Single-pass first (1 fresh greedy, no cached reps).
- Monitor swap usage closely (historical ~4.7 GB swap during 128k windows).
- If MemAvailable drops below 18 GB or swap grows beyond 5 GB, abort the 128k arm.
- 128k arms must run LAST (after all smaller ctx arms complete).
- 128k arms must be in a separate sub-window to allow isolation.

### MTP Policy

- MTP OFF arms run first (baseline).
- MTP ON arms run after all OFF arms complete.
- MTP activation flags must be verified in command line before each ON arm start.

### Graph Policy

- Graph ON is default (all arms unless explicitly marked GRAPHS OFF).
- Graph OFF arms use GGML_CUDA_DISABLE_GRAPHS=1 prefix.
- Verify graphs are actually off: launch with -v, confirm stderr has no "warmup complete"/"id reused" lines during decode.

---

## 5. Restore Procedure

1. Stop baseline server: ops/bin/baseline_stop_template.sh --profile <tag> --i-have-explicit-approval.
2. Verify baseline server is down.
3. Start production server: setsid bash <REPO_ROOT>/ops/legacy/launch_prod.sh.
4. Wait 90 seconds for production server to start.
5. Verify production health: curl -s -m 3 http://localhost:8080/health must return {"status":"ok"}.
6. Verify production binary identity: readlink /proc/$(pgrep -x llama-server | head -1)/exe must match build/bin/llama-server.
7. Update ops/run/llama-server.pid with current production PID.
8. Run semantic smoke check against stored baseline (results2/correctness/baseline_ON_prod_v3.json).
9. Record final health log.
10. If health check fails after restore: re-run restore once. If still failing, report immediately and do NOT improvise flags.

---

## 6. Failure Rules

| Condition | Action |
|-----------|--------|
| OOM or vram_peak > 15.5 GB | Stop escalating contexts; mark cell BLOCKED |
| Health check fails | Dump log tail, stop server via pidfile, ABORT |
| PID mismatch | ABORT immediately |
| GPU busy by unknown process | STOP whole window; report; never touch foreign processes |
| System memory pressure | ABORT window |
| Swap usage > 5 GB | ABORT 128k arm; continue smaller ctx arms if safe |
| Unknown binary path | STOP (binary identity gate failed) |
| Correctness suite broken | Perf data still valid; correctness phase blocked |
| Health fail after restore | Highest priority; re-run restore once; if still failing, report immediately |

---

## 7. Artifact Policy

All artifacts must be stored in ops/ or experiments/phase1b/ directories:

- logs: ops/logs/llama-server.<timestamp>.log and baseline logs
- raw outputs: per-rep JSON records, metrics deltas, vram monitors
- env manifest: os.uname, rocm-smi, git rev, binary sha256, model sha256, exported env vars
- summary: medians, spreads, matrix table
- commands: exact commands used, approval notes, pidfiles

---

## 8. 128k Single-Pass Policy

- Default: OPTIONAL and gated.
- Requires explicit human approval separate from the main window approval.
- Single-pass first (fresh process, no cached reps).
- Swap/memory thresholds:
  - MemAvailable must be > 18 GB before starting.
  - If swap usage exceeds 5 GB during the arm, abort immediately.
  - Historical swap usage during 128k windows was ~4.7 GB; this is NOT automatically accepted.
- 128k arms must run in a separate sub-window after all other arms complete.
- Only one 128k arm per window (OFF or ON, not both in the same window).