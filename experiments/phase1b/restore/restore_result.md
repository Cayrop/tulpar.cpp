# Phase-1B Production Restore Result

Date: 2026-08-24 15:30 +03

## Verdict: RESTORE_OK

## Procedure log

1. Pre-checks: no llama-server process (pgrep discovery), port 8080 free,
   no stale pidfile.
2. Launched: setsid build-p3/bin/llama-server with prod_flags.env flags
   (see restore_overrides.md; GGML_CUDA_DISABLE_GRAPHS intentionally not set,
   evidence-based).
   Log: ops/logs/llama-server.20260824_153021.log
3. PID 397813 written to ops/run/llama-server.pid
4. Health OK after 5 s (model page cache warm from measurement window)
5. Identity validated:
   /proc/397813/exe = <REPO_ROOT>/build-p3/bin/llama-server
   cmdline contains model path and port 8080
6. Evidence captured: final_health.json, final_metrics.txt (in this dir)

## Semantic spot-check vs stored baseline (baseline_ON_prod_v3.json)

| test | result |
|------|--------|
| math | MATCH |
| math2 | MATCH |
| puzzle | MATCH |
| factual | MATCH |
| code | MATCH |
| code2 | MATCH |

6/6 token-prefix identical with the pre-window production baseline.

## Final production state

- BINARY: build-p3/bin/llama-server @ tulpar/main 66dcba5eb7dd...
- FLAGS: ctx 65536, q4_0 KV, MTP ON (draft-mtp, n-max 4, p-min 0.8),
  graphs ACTIVE, host 0.0.0.0:8080, metrics+tools on, preserve_thinking
- HEALTH: {"status":"ok"}
- PIDFILE: ops/run/llama-server.pid (397813)
