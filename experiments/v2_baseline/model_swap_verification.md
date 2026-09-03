# EXP-002: V2 Model Swap Verification Record

Date: 2026-08-26 16:35 - 18:16 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (unchanged)
Binary: build-p3/bin/llama-server, sha256 280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13
(matches Phase-1B fingerprint 280556cc..., mtime Aug 24 00:20)

## Verdict

SWAP_VERIFIED. The V2 file is in place and loads cleanly under the production flags on build-p3.

## Pre-flight results

- P0-0a: Production WAS running at phase start (V3 model). PID 2052535 /proc/2052535/exe == build-p3/bin/llama-server; cmdline contained qwen38 path. Port 8080: health {"status":"ok"}.
- P0-0b: No KFD compute processes (rocm-smi --showpidgpus: none); VRAM used ~1.3 GiB desktop only; momentary GPU use 4-8%.
- P0-0c: /home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf, 10,676,423,744 B = 10.68 GB decimal (9.94 GiB), does NOT match expected ~9.83 GB.
  Note: The expected ~9.83 GB in the task description matches the V3 file size (9,828,981,664 B). The actual V2 file is the larger model used in Phase-1B baseline.
- P0-0d: sha256 46151b52a5cad673d90a00222103254864326c251130b8fc4381d6f34386b3c8 (matches Phase-1B-era V2 fingerprint recorded in experiments/phase1b/env/model_sha256.txt).

## File verification

The V2 file matches exactly the model used during Phase-1B baseline measurements:
- Size: 10,676,423,744 bytes (matches Phase-1B report)
- SHA256: 46151b52... (matches Phase-1B env/model_sha256.txt)
- This confirms the V2 model is the same quantization that produced the Phase-1B baseline numbers.

## Swap execution (pidfile lifecycle throughout)

1. prod_stop.sh --i-have-explicit-approval: validated pidfile PID 2052535 (V3), removed pidfile after clean SIGTERM.
2. Updated ops/manifest/prod_flags.env MODEL_PATH to qwen-v2 path.
3. Updated ops/bin/prod_start.sh MODEL variable to qwen-v2 path.
4. Updated ops/bin/prod_stop.sh validation string to qwen-v2 path.
5. Updated ops/bin/prod_capture_pid.sh MODEL variable to qwen-v2 path.
6. prod_start.sh: launched build-p3/bin/llama-server with prod_flags.env flags verbatim; health {"status":"ok"} after 10 s; PID 2079573 written to pidfile; /proc/2079573/exe == build-p3/bin/llama-server (validated); cmdline contains the qwen-v2 model path (validated). VRAM after load (prod ctx 65536, MTP ON flags): 14,494,896,128 B total-used (~13.51 GiB incl ~1.24 GiB desktop).
- Two later stop/start cycles for correctness gate instances (baseline-gate-off-v2 via srv_ctl_v2.sh, ctx 131072 MTP OFF); all stops clean SIGINT, no SIGKILL needed; VRAM released to ~1.36 GiB between runs.

## Final state (restore)

- PID 2106419 in ops/run/llama-server.pid; /proc/2106419/exe == <REPO_ROOT>/build-p3/bin/llama-server; health {"status":"ok"}.
- VRAM total-used after load: 14,606,872,576 B (~13.60 GiB incl desktop).
- Swap used 13,014,261,760 B of 33,564,913,664 B (high pre-existing system swap pressure from earlier phases' mmap churn; MemAvailable 18.08 GB).
- Model loaded: current V2 bytes, sha256 46151b52...

## Additional notes

- The V2 model is identical to the one used in Phase-1B baseline measurements (confirmed by SHA256 and file size).
- The "~9.83 GB" expected size in the task description corresponds to the V3 model (9,828,981,664 B), not the V2 model.
- All validation checks pass: binary path correct, model path in cmdline, health OK.

RESTORE_OK (production serving V2 on build-p3 with health ok)