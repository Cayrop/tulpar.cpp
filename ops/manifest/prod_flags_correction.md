# prod_flags.env Correction: GGML_CUDA_DISABLE_GRAPHS

Date: 2026-08-24 (Phase-2A addendum run)
Changed by: Phase-2A addendum agent, under explicit addendum authorization.
Production process: NOT touched (no stop/start/restart/signal). Running server
(PID 397813 at correction time) keeps its current environment; the manifest is
documentation only and takes effect at next human-approved launch.

## Correction 2: BINARY_PATH (Phase-2A full run)

Date: 2026-08-24
Changed by: Phase-2A full attribution design and read-only code audit agent,
under explicit Phase-2A authorization ("Decision: production binary is
build-p3/bin/llama-server; fallback is build/bin/llama-server").

| Field | Value |
|-------|-------|
| Old binary path | `build/bin/llama-server` |
| New binary path | `<REPO_ROOT>/build-p3/bin/llama-server` |
| Reason | Manifest pointed at the fallback binary while actual restored production runs build-p3. The Phase-1B restore decision matrix selected build-p3 as RESTORE_BINARY. |
| Evidence | Phase-1B report section 8: RESTORE_OK on build-p3/bin/llama-server; /health returned {"status":"ok"}; greedy semantic spot-check 6/6 token-prefix MATCH against baseline_ON_prod_v3.json; PID 397813 identity validated via pidfile + /proc. |
| Backup | ops/manifest/prod_flags.env.bak-binarypath-20260824-163257 |
| Production impact | None. No production stop/start/restart performed for this manifest correction; the running server keeps its current process state and already executes build-p3. Takes formal effect at next human-approved launch. |

## What changed

ops/manifest/prod_flags.env line:

    GGML_CUDA_DISABLE_GRAPHS=1

was commented out with a correction note. No other line modified.

Pre-correction copy: ops/manifest/prod_flags.env.bak-addendum-20260824-160030

## Why (evidence trail)

1. The real pre-window production process ran WITH graphs enabled:
   /tmp/opencode/llama_server_restore.log contains repeated
   "graphs reused = 3291" lines; that message only appears when CUDA/HIP
   graphs are active. Evidence recorded in
   experiments/phase1b/restore/restore_overrides.md.
2. Phase-1B restore intentionally did NOT set the variable when relaunching
   production (restore_overrides.md flag table), reproducing the real state.
3. Phase-1B report section 10 open issue #1 explicitly requested this manifest
   correction.
4. Phase-1B graph diagnostic (A2 vs D1, 16k MTP OFF): graphs OFF measured
   -2.6% tg. Graphs-enabled is also the faster configuration for the primary
   MTP OFF target at 16k.

## Scope note

The BINARY_PATH discrepancy (manifest said build/bin/llama-server; actual
restored production runs build-p3/bin/llama-server per the Phase-1B restore
decision matrix) was NOT changed by the addendum: it was outside that
addendum's mandate. It is now corrected above (Correction 2) by the
Phase-2A full run, per the operator's decision.

## Verification after next launch (human action)

At the next production restart, confirm:
1. The process executable resolves to build-p3/bin/llama-server.
2. The log shows "graphs reused" lines, proving graphs are active without the
   GGML_CUDA_DISABLE_GRAPHS env var set.
