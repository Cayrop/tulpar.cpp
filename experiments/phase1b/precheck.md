# Phase-1B Pre-Check Report

Date: 2026-08-24 14:17 +03 (local)
Operator approval context:
- HUMAN_APPROVAL_MEASUREMENT_WINDOW = YES
- HUMAN_APPROVAL_128K = YES
- GPU_IDLE_CONFIRMED_BY_USER = YES
- PRODUCTION_SERVER_STOPPED_BY_USER = YES

## Verdict: PASS (with 2 flags, non-blocking)

| # | Check | Result | Detail |
|---|-------|--------|--------|
| 1 | Git HEAD | PASS | 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (branch tulpar/main) |
| 2 | Working tree tracked files | PASS | clean; untracked only: agents.md, agents.md.bak*, experiments/, ops/, results/, results2/ (acceptable) |
| 3 | Model file | PASS | /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf, 10,676,423,744 bytes, mtime Aug 14 19:00 |
| 4 | Baseline binary | PASS | build-p3/bin/llama-server exists, executable, mtime Aug 24 00:20, sha256 280556cc... |
| 5 | Fallback binary | PASS | build/bin/llama-server exists, executable, mtime Aug 20 12:58, sha256 d5b26a65... |
| 6a | No llama processes | PASS | pgrep -af "[l]lama-server/cli/bench" empty (self-match excluded by bracket pattern) |
| 6b | GPU idle | FLAG+PASS | rocm-smi: no KFD processes, SCLK 93MHz, power 52W (idle). VRAM used 665 MB > 500 MB doc threshold; attributable to desktop graphics session, not compute. User confirmed GPU idle. Proceeding. |
| 7 | Port 8080 free | PASS | not present in ss -tlnp |
| 8 | Disk space | PASS | /home has 15 GB free (99% used overall - flagged for awareness; artifacts are text/JSON, few hundred MB max) |
| 9 | RAM/swap | FLAG | Mem 31Gi total, 27Gi available. Swap: 2.6 Gi already used BEFORE window start (recorded as baseline reference; 128k guard thresholds still apply relative to this) |
| 10 | Ops files | PASS | ops/manifest/prod_flags.env, ops/measurement/measurement_window.md, ops/pidfile_policy.md all exist |

## Flags detail

### FLAG-1: VRAM 665 MB used at start
measurement_window.md entry condition targeted < 500 MB after production stop.
rocm-smi --showpids reports ZERO KFD (compute) processes. The ~665 MB is desktop
session graphics allocation. Per prompt instruction, abort condition is a running
llama-* process or critical GPU consumer; neither is present. Non-blocking.

### FLAG-2: swap 2.6 GiB in use before window
Not caused by this window (no compute jobs were running). Recorded as the
pre-window reference point. 128k arm guards remain: abort if swap > 5 GB total
or MemAvailable < 18 GB or health fail.

## Binary identity

```
280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13  build-p3/bin/llama-server
6293e1b5af8092cf417f42be4f930030d79c6391058a001d97937b6148fe9535  build-p3/bin/libllama-server-impl.so
d5b26a656a4b283c0e469bee2ab9015b84cd2d26e430e85c6a847290922b6f5e  build/bin/llama-server
```

Both binaries are small dynamically-linked ELF launchers linked against libs in
their own bin/ directories (expected layout).

## Decision

PROCEED to environment manifest and correctness gate.
