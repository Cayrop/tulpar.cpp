# Phase-2A Open Questions for the Human Operator

Date: 2026-08-24
Phase-2B must NOT run until these are answered. Phase-2A artifacts
(evidence ledger, code audit, hypothesis matrix, profiling design) are
complete and do not depend on the answers.

Q1. Is a Phase-2B profiling window approved in principle?
    (design: experiments/phase2b/profiling_design.md)

Q2. May production be stopped for the window, using the validated pidfile
    procedure and Phase-1B restore discipline (restore target remains
    build-p3/bin/llama-server)?

Q3. Is traced 128k profiling approved, or should Phase-2B limit tracing to
    16k and 63k with only an untraced 128k sanity pass?
    Note: A7/A8 precedent shows single-pass 128k is safe on this hardware,
    but a traced run adds profiler memory pressure on top of the 13.92 GiB
    peak.

Q4. rocprofv3 exists at /opt/rocm/bin. If it needs elevated permissions
    (perf counter access) when actually executed, can the operator provide
    them, or should Phase-2B fall back to log/metrics-only attribution?

Q5. Should MTP ON comparison arms be included at all, or should Phase-2B be
    MTP OFF only? Design currently includes one optional O2-on-16k arm for
    hypothesis H-2A-MTP-SECONDARY; it can be dropped without loss to the
    primary objective.

Q6. Confirm the manifest binary path correction applied this phase:
    production binary = <REPO_ROOT>/build-p3/bin/llama-server
    fallback binary = <REPO_ROOT>/build/bin/llama-server
    Recorded in ops/manifest/prod_flags.env (backup
    prod_flags.env.bak-binarypath-20260824-163257) and
    ops/manifest/prod_flags_correction.md (Correction 2). No action needed
    unless the operator disagrees.

Answer format: Q1..Q6 with yes/no plus any conditions.
