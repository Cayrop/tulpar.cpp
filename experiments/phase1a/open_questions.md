# Phase-1A Open Questions (for human/operator)

Status legend: [BLOCKING] = blocks Phase-1B execution; [NON-BLOCKING] = can be
resolved later without stopping the design.

1. [BLOCKING] Measurement window approval.
   Baseline requires stopping the running production server (PID changes over
   time; currently build/bin/llama-server, health ok). Who approves, and when?
   Procedure: baseline_runbook.md sections 2-5.

2. [BLOCKING-ish] pidfile convention.
   agents.md section 10 says kill only via explicit pidfile, but no pidfile has
   ever existed; all historical stops are pgrep-based (p1_campaign.stop_prod,
   window_runner). Decision needed:
   a) adopt pidfile in a launcher copy stored in repo (recommended), or
   b) formally accept documented pgrep-based stop as the sanctioned procedure.
   Until decided, runbook uses "our own per-window pidfiles + pgrep -x only for
   production stop with explicit approval logging".

3. [NON-BLOCKING] Launcher volatility.
   /tmp/opencode/launch_prod.sh + restore_server.sh are outside any version
   control and die with /tmp cleaning. Recommend copying into results2/ops/ or
   experiments/ops/ with a pidfile addition. Approve?

4. [NON-BLOCKING] Production binary provenance.
   build/bin/llama-server mtime Aug 20 predates tulpar/main; exact source commit
   of the RUNNING production binary is UNKNOWN (era suggests upstream 849798132).
   Does anyone know/confirm? Needed only for prod-vs-base comparisons, not for
   tulpar baseline.

5. [DECISION] Sanctioned baseline binary.
   Proposal: build-p3/bin/llama-server == tulpar/main content (per PLAN.md
   verification), used by perf_tulpar_base_* campaign. Confirm so Phase-1B does
   not re-litigate binary choice.

6. [DEFERRED] llama-bench cross-check needs a bench binary matching tulpar/main
   (build-p3 ships server only; build/bin/llama-bench is old content). Options:
   a) approve one ccache build of llama-bench into a new dir in a later phase,
   b) drop the cross-check. Not needed for primary baseline.

7. [CONFIRM] 128k arm swap behavior.
   Historical 128k windows ran with ~4.7 GB swap used and MemAvailable ~18-20 GB;
   system stayed healthy. Accept repeating this profile, or restrict 128k to
   fresh-greedy single pass?

8. [NON-BLOCKING] LLAMA_CURL absent from all CMake caches. Harmless locally;
   confirm no curl-dependent feature is expected from these binaries.

9. [NOTE] Graph-OFF arms use GGML_CUDA_DISABLE_GRAPHS=1 (verified in
   ggml/src/ggml-cuda/common.cuh:1257). No code change planned. If a future
   phase needs per-graph introspection beyond `-v` stderr lines, that would be a
   new debug env var -> separate phase with its own design.

Resolved during Phase-1A (no action needed):
- MTP activation path: KNOWN (--spec-type draft-mtp; same-model nextn context;
  no separate draft file). Metrics via /completion timings draft_n/draft_n_accepted
  and /metrics spec_decode_* counters.
- HIP graph runtime toggle: FOUND (GGML_CUDA_DISABLE_GRAPHS).
- -ctg absence workaround: designed (llama-bench -p/-n depth trick as secondary;
  server windows primary).
