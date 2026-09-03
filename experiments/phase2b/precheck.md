# Phase-2B Pre-check Report

Date: 2026-08-24 (window start ~17:10 +03)
Operator approvals: OPERATOR_PROFILING_WINDOW_APPROVAL=YES,
OPERATOR_PRODUCTION_STOP_APPROVAL=YES, TRACED_128K_APPROVAL=YES
(SINGLE_PASS_GATED), INCLUDE_O1_OFF_1K=YES, INCLUDE_O2_MTP_ON=NO.

Verdict: ALL CRITICAL PRE-CHECKS PASS. Proceeding to production stop.

## 1. Git state

- HEAD: 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (REQUIRED MATCH)
- Branch: tulpar/main
- Tracked files: clean (`git status --porcelain` shows untracked only:
  agents.md*, experiments/, ops/, results/, results2/, model_sha256.txt)
- PASS

## 2. Binary fingerprint

- build-p3/bin/llama-server exists, executable.
- sha256: 280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13
- Expected Phase-1B prefix 280556cc: MATCH.
- size: 16000 bytes; mtime: 2026-08-24 00:20:25 +0300 (identical to Phase-1B).
- Fallback present: build/bin/llama-server (mtime Aug 20).
- PASS

## 3. Model presence

- /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf exists,
  10,676,423,744 bytes (matches Phase-1B record).
- PASS

## 4. Disk and memory (before production stop)

- Disk /home: 16 GB free of 930G (>= 10 GB required). NOTE: tight; trace
  artifacts are text/JSON only but disk usage will be watched during traced
  arms.
- free -h at precheck: Mem total 31Gi, used 16Gi, available 14Gi;
  Swap 31Gi total, 4.1Gi already used BEFORE window (pre-existing baseline,
  consistent with Phase-1B observation of 2.4-2.6 GiB plus later drift;
  deltas will be computed per arm from this reference).
- NOTE: profiling_design.md runbook mentions MemAvailable >= 20 GiB as a
  runbook target while production (which owns GPU-resident weights and
  page cache) is still running. Current 14 GiB is expected to rise after the
  production stop. Hard gates that WILL be enforced: MemAvailable > 18 GB
  before the P3-off-128k arm (measurement window policy); abort if
  MemAvailable < 8 GiB during any arm.
- PASS (with 128k gate to be re-evaluated immediately before that arm)

## 5. Profiler availability

- /opt/rocm/bin/rocprofv3 --version: version 1.1.0, rocm_version 7.2.4,
  git 97f5574fe2fdc7bef44fb01545347912ee9f1779. Runs WITHOUT sudo, no
  permission errors at CLI level. BLOCKER-PERMISSIONS not triggered so far;
  a real capture test happens on the first traced arm.
- rocm-smi present (/opt/rocm/bin/rocm-smi).
- PASS

## 6. Ops files

- ops/manifest/prod_flags.env: present (binary path corrected to build-p3,
  GGML_CUDA_DISABLE_GRAPHS commented out - both per Phase-2A corrections).
- ops/pidfile_policy.md: present.
- ops/measurement/measurement_window.md: present.
- PASS

## 7. Production state (pre-stop)

- Pidfile ops/run/llama-server.pid contains PID 397813.
- PID alive; /proc/397813/exe -> <REPO_ROOT>/build-p3/bin/llama-server
  (MATCHES production binary).
- cmdline contains model path and production flags (-c 65536 ... --spec-type
  draft-mtp ... --host 0.0.0.0 --port 8080 --metrics).
- Health endpoint: {"status":"ok"}.
- GPU: VRAM total used 14,824,615,936 B (~13.81 GiB) by the production server;
  GPU use 8% (idle-ish). RX 7800 XT, 16 GiB total.
- Production is RUNNING and validated; not stopped yet at this point in time.
- PASS
