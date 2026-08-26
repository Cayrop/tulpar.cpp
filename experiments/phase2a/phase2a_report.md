# Phase-2A Full MTP-OFF Attribution Design Report

Date: 2026-08-24
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Mode: full Phase-2A run (read-only audit + design + manifest correction).
Constraints honored: no source/kernel/build changes, no new build, no
profiling executed, no inference or benchmarks run, production process
untouched (PID 397813 verified read-only only), no git operations.

## Summary verdict

READY_FOR_PROFILING_DESIGN = YES
NEEDS_HUMAN_APPROVAL = YES

All Phase-2A artifacts now exist (evidence_ledger.md, code_audit.md,
hypothesis_matrix.md, open_questions.md, this report) plus
experiments/phase2b/profiling_design.md. Phase-2B execution is blocked
only on the operator answers in open_questions.md.

## 1. Addendum state consumed

Completed by the addendum and reused without rework:
- GGML_CUDA_DISABLE_GRAPHS=1 manifest correction with evidence trail and
  backup (bak-addendum-20260824-160030).
- Target formalization in agents.md Section 0: primary = 40 tok/s TG MTP
  OFF; MTP ON secondary; English-language rule.
- Confirmation that zero prior Phase-2A artifacts existed.

What was missing and is delivered by this run:
- All five Phase-2A analysis/design documents.
- The BINARY_PATH decision the addendum had to defer (now applied as
  Correction 2).
- Integration of legacy results2/reports/final_report_phase2.md evidence
  (VEC-vs-TILE, graph churn) into the ledger with explicit
  revalidation status instead of treating old numbers as facts.

## 2. Target clarification

Primary target: 40 tok/s token generation with MTP OFF.
Current measured gaps: 22.06 @1k (-45%), 20.45 @16k (-49%), 15.74 @63k
(-61%), 11.98 @128k (-70%) relative to 40.
MTP ON data is used only as comparison/validation context; no MTP parameter
tuning is in scope anywhere in Phase-2A/2B design. User-reported 70-80 tok/s
MTP coding speeds remain observational. This report and all Phase-2A
documents are written in English per the recorded language rule.

## 3. Ops manifest corrections

1. Graph env entry: corrected by the addendum (verified intact this run;
   prod_flags.env lines 46-50 keep the explanatory comment).
2. Binary path: CORRECTED THIS RUN.
   - Old: BINARY_PATH="build/bin/llama-server"
   - New: BINARY_PATH="<REPO_ROOT>/build-p3/bin/llama-server"
   - Comment added in-file; record in prod_flags_correction.md section
     "Correction 2" (old path, new path, reason, RESTORE_OK/health/
     semantic-match evidence, no-restart note).
   - Backups: ops/manifest/prod_flags.env.bak-binarypath-20260824-163257
     (this run); prod_flags.env.bak-addendum-20260824-160030 (addendum).

## 4. Evidence ledger summary

(experiments/phase2a/evidence_ledger.md)

Measured facts: full Phase-1B baseline tables (TG OFF/ON, PP), acceptance
0.79-0.97, VRAM peaks 13.39-15.50 GiB, swap deltas +45/+102 MiB at 128k,
spread <1%, graphs active in production, correctness gate passed,
build-p3 restore validated.

New facts established this run (read-only):
- The model is HYBRID: 48 GDN linear-attention layers + 16 dense
  full-attention layers + 1 MTP block (GGUF header verified). KV exists
  for 17 blocks max; 128k q4_0 KV ~= 2.36 GiB; weight stream ~10.25 GB
  per decode step.
- rocprofv3/rocprof present on host (permissions untested).

Weakened/rejected: massive-swap-at-128k (q4_0 fixed it), big graph-off
loss (measured -2.6% at 16k), binary uncertainty (resolved), forced-VEC
bottleneck (already fixed by fork commit 66dcba5eb).

Unknowns: all kernel-level ms/token shares for the current build,
effective IQ3_XXS GEMV bandwidth, quantize_q8_1 true cost, PP breakdown,
GDN decode share, long-context binding classification.

Historical claims (~213/~259 GB/s GEMV, 7.7 ms bubble, ~430 launches,
old staging estimates) are quarantined for revalidation, not used.

## 5. Read-only code audit

(experiments/phase2a/code_audit.md)

- IQ3_XXS GEMV: vecdotq.cuh:1155 vec_dot; dispatch mmvq for ne11<=8;
  RDNA3 table gives IQ3_XXS nwarps=1 at decode while simple quants get
  nwarps=8 (mmvq.cu:452-472) - top suspect for short/mid-ctx decode cost.
- quantize_q8_1: one launch per matmul op (mmvq.cu:1332), ~497 ops/step
  estimate; fusion plumbing already exists upstream-style in mmvq.cu but
  measurement must come first.
- Attention/q4 KV/head 256: no tensor-core FA reachable at DK=256 on
  gfx1101 (MFMA CDNA-only, WMMA <=128); TILE serves ALL shapes after fork
  guard fattn.cu:527; TILE pays whole-cache F16 staging every call
  (fattn-common.cuh:1022-1084): ~11.8 GiB/token attention-side traffic
  at 128k across 16 dense layers.
- KV cache/staging: direct q4_0 management, store via cpy quantize kernels,
  checkpoints via state_write/read; fresh/cached methodology matters for
  comparability.
- MTP (secondary): draft-mtp in common/speculative.cpp:1281+, hidden-state
  handoff via nextn embedding API, separate draft ctx (llama-model.cpp:
  2172-2282), metrics exist (server-task.cpp:1554-1612); verify batches
  stay inside MMVQ/TILE paths.
- PP/prefill: MMQ with RDNA3 IQ3_XXS configs; prefill FA staging aggregate
  small (~1.5 s of 561 s at 128k) so it does NOT explain the 485->231 drop;
  real cause open, measurable.
- Graphs: key = nodes[0] pointer, uid fast-path logs "graphs reused",
  warmup-reset mechanics understood; production reuse stable (3291).

Each area carries evidence strength, expected MTP OFF impact, and the exact
Phase-2B measurement required (audit sec H summary table).

## 6. Hypothesis matrix

(experiments/phase2a/hypothesis_matrix.md)

P0: H-2A-GEMV (effective bandwidth + nwarps=1 config),
    H-2A-QUANT (staging/gap overhead),
    H-2A-ATTN-STAGING (whole-cache F16 staging dominates long ctx).
P1: H-2A-KV-READ, H-2A-PP.
P2: H-2A-GRAPH, H-2A-MTP-SECONDARY.
GDN share explicitly reserved: if > ~20% of step at 16k in traces, a
dedicated H-2A-GDN gets promoted before any optimization planning.

## 7. Phase-2B profiling design

(experiments/phase2b/profiling_design.md - design only, NOT executed)

- Primary arms: MTP OFF 16k / 63k / gated single-pass 128k; optional 1k
  reference and single MTP ON 16k comparison.
- Binary/config locked to Phase-1B equivalents (build-p3, q4_0 KV, FA on,
  greedy, same prompts); primary arms carry no speculative flags.
- Safety: human window approval required; pidfile-only lifecycle; VRAM
  guards; restore to build-p3; health + semantic check after restore.
- Traced/untraced strictly separated with overhead estimation gate (>25%
  => BLOCKER).
- Tooling: rocprofv3 primary; fallback roctracer; server logs + /metrics
  counters; permission failure => BLOCKER-PERMISSIONS to operator.
- Metrics, kernel->category mapping, derived metrics (effective GB/s,
  ms/token shares, host gaps, scaling curves), full runbook structure and
  abort rules are specified.

## 8. Human approval questions

(experiments/phase2a/open_questions.md)

Q1 profiling window approval; Q2 production stop permission; Q3 traced
128k yes/no; Q4 profiler permissions if elevated access needed; Q5 include
MTP ON comparison arm or MTP OFF only; Q6 confirm binary path correction
(build-p3 production, build/bin fallback). Phase-2B waits on all six.

## 9. Recommended next action

Operator answers Q1-Q6 in experiments/phase2a/open_questions.md; if the
window is approved, execute experiments/phase2b/profiling_design.md
starting with the rocprofv3 permission pre-check, then untraced sanity
arms, then traced attribution arms.
