# GPU Idle Validation (before profiling, after production stop)

Time: 2026-08-24 17:39-17:41 +03

## Production stop record

- Production pidfile PID 397813 validated before stop:
  /proc/397813/exe -> <REPO_ROOT>/build-p3/bin/llama-server
  cmdline contained model path Qwen3.8-27B-UD-Q2_K_XL.gguf and production flags.
- SIGINT sent at 2026-08-24T17:38:23+03:00 (graceful; operator stop approval YES).
- Process exited ~5 s later. Port 8080 free (curl fails). No llama-server,
  llama-cli or llama-bench processes remain (pgrep used for verification only).
- Stale production pidfile removed per policy; will be rewritten at restore.
- NOTE: ops/bin/prod_stop.sh was NOT used because its hardcoded PROD_BIN still
  points to build/bin/llama-server (stale pre-correction path); the identical
  validated-pidfile procedure from that script was executed manually instead.

## GPU idle state

- VRAM total used: 1,324,867,584 B (~1.23 GiB) - desktop graphics session only;
  no compute process owns VRAM. Phase-1B recorded ~665 MB desktop usage; current
  value is the same class of small desktop footprint (acceptable per prompt:
  "desktop session VRAM around known small usage is acceptable").
- GPU use: ~8-10% (desktop compositing noise).
- Clocks settled: SCLK 190 MHz (level S / low), MCLK 456 MHz, SOCCLK 600 MHz.
- Temps: edge 39 C, junction 47 C, memory 59 C. Idle-class power state
  ("low-power state" runtime warning present = device mostly idle).

Verdict: GPU IDLE VALIDATION PASSED. Safe to start profiling server.

## RAM/swap after production stop

- MemAvailable: 17 GiB; swap used 3.2 GiB (baseline drift noted in precheck.md;
  per-arm deltas computed against fresh snapshots).
