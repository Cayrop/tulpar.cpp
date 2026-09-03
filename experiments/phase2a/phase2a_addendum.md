# Phase-2A Addendum Report: MTP-OFF Target Correction

Date: 2026-08-24
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Mode: addendum to a presumed prior Phase-2A run.

## Summary verdict

NEEDS_FULL_PHASE2A

The expected Phase-2A outputs do not exist anywhere in the repo. No prior
Phase-2A audit content was found to revise, so no Phase-2A analysis was
invented. Independent mechanical tasks that this addendum was explicitly
authorized to perform (ops manifest correction, minimal agents.md update)
were completed truthfully and are documented below. Production was not
touched; nothing was profiled; no source, kernel, or build file changed;
no git operations performed.

## 1. Existing Phase-2A state

Files checked (Task 1 list):

| File | Status |
|------|--------|
| experiments/phase2a/phase2a_report.md | MISSING (directory did not exist) |
| experiments/phase2a/evidence_ledger.md | MISSING |
| experiments/phase2a/hypothesis_matrix.md | MISSING |
| experiments/phase2a/open_questions.md | MISSING |
| experiments/phase2b/profiling_design.md | MISSING |

Repo-wide search for phase2a/evidence_ledger/hypothesis_matrix/profiling_design
content: no match under any path.

Completeness assessment: 0/5 present. A full Phase-2A run is required.
This addendum creates only its own report file; all five artifacts above must
be produced by the full Phase-2A audit with the corrected MTP OFF target.

Existing related material that full Phase-2A should build on (NOT a substitute):

- experiments/phase1b/phase1b_report.md: measured baselines used by this
  addendum (MTP OFF tg medians 22.055 @1k, 20.451 @16k, 15.740 @63k,
  11.981 @128k; graph diagnostic A2 vs D1).
- agents.md Section 2 tensor inventory: IQ3_XXS = 75.87% of model bytes
  (dominant decode GEMV load), measured via gguf-py.
- results2/reports/final_report_phase2.md: legacy "Phase 2" report from an
  earlier workflow (different schema, dated 2026-08-23). Contains directly
  relevant prior evidence: forced flash_attn_ext_vec dispatch on quantized KV,
  TILE-path one-line patch giving +17.1% @16k / +39.5% @63k MTP OFF (patch
  reverted after validation), f16-KV diagnostic isolating the quantized VEC
  kernel, unresolved CUDA-graph churn resets. Full Phase-2A should fold these
  into the evidence ledger as prior evidence, re-validated where needed.

## 2. Target correction applied

Applied where state allowed:

- Primary optimization target: 40 tok/s TG (decode) with MTP OFF.
- MTP ON is secondary; it is comparison/validation context only. No MTP
  parameter tuning is in scope.
- User-reported 70-80 tok/s MTP coding speeds are observational, not measured
  evidence.
- Language convention added: future agent prompts and technical reports in
  English unless the operator requests otherwise.
- Recorded in agents.md Section 0 (see section 3 below). The Phase-2A
  documents themselves could not receive the statement because they do not
  exist; the requirement is recorded here so the full Phase-2A run embeds it.

MTP OFF baseline gaps vs the 40 tok/s target (Phase-1B measured medians):

| Context | MTP OFF tg med | Gap to 40 |
|---------|----------------|-----------|
| 1k      | 22.06          | -17.9     |
| 16k     | 20.45          | -19.6     |
| 63k     | 15.74          | -24.3     |
| 128k    | 11.98          | -28.0     |

These gaps (up to 3.3x at 128k) require major code-level improvements
(kernels, dispatch, memory path), not runtime parameter tuning.

## 3. Files updated

| File | Action |
|------|--------|
| ops/manifest/prod_flags.env | Corrected: GGML_CUDA_DISABLE_GRAPHS=1 commented out with note. Backup: prod_flags.env.bak-addendum-20260824-160030 |
| ops/manifest/prod_flags_correction.md | Created (correction record + evidence) |
| agents.md | Minimal update: Document Status block, Section 0 target + language rule, Section 10 item 10 annotation, Section 14 phase status. Backup: agents.md.bak-addendum-20260824-160114 |
| experiments/phase2a/phase2a_addendum.md | Created (this file) |
| evidence_ledger.md | NOT updated: does not exist (would require inventing audit work) |
| hypothesis_matrix.md | NOT updated: does not exist |
| experiments/phase2b/profiling_design.md | NOT updated: does not exist |

## 4. Hypothesis priority changes

NOT PERFORMED: hypothesis_matrix.md does not exist, so there is nothing to
reprioritize and no attribution analysis to revise. Inventing a matrix here
would violate the no-invention rule.

Carried forward unchanged from this addendum's instructions, as requirements
the full Phase-2A matrix MUST address with MTP OFF priority:

- IQ3_XXS GEMV effective bandwidth (dominant quant, 75.9% of bytes)
- quantize_q8_1 overhead around GEMV
- attention / q4_0 KV cost at long context
- KV read/write traffic
- long-context decode scaling
- PP/prefill kernel efficiency
- graph overhead only if evidence supports it (Phase-1B D1 showed graphs OFF
  costs -2.6% tg at 16k MTP OFF; low prior)

MTP-specific hypotheses are secondary unless they affect the base MTP OFF
execution path. Relevant existing prior evidence for the full run: legacy
final_report_phase2.md fattn VEC-vs-TILE findings above.

## 5. Phase-2B design changes

NOT PERFORMED: experiments/phase2b/ does not exist. Requirements carried
forward for the future profiling design (to be written by full Phase-2A or a
dedicated design pass):

- Primary arms: MTP OFF 16k, MTP OFF 63k, MTP OFF 128k optional gated
  single-pass.
- Optional comparison arms: MTP OFF 1k if cheap; MTP ON 16k or 63k only if
  needed to explain MTP OFF behavior.
- NO MTP parameter sweeps, NO draft-n-max experiments, NO speculative tuning.
- Design must answer: decode time breakdown at 16k / 63k / 128k; effective
  IQ3_XXS GEMV bandwidth in the current build; time in quantize_q8_1 and
  adjacent transitions; attention/KV path share; GEMV-bound vs
  attention-bound vs KV-read-bound classification per context; PP/prefill
  kernel breakdown for MTP OFF.
- All production safety rules from Phase-1B remain in force (pidfile
  lifecycle, human window approval, VRAM guards, single-pass 128k).

## 6. Ops manifest status

CORRECTED (this addendum).

- GGML_CUDA_DISABLE_GRAPHS=1 found still active in ops/manifest/prod_flags.env
  (line 43); no prior correction existed.
- Evidence for removal: real pre-window production log shows "graphs reused =
  3291" (graphs active); Phase-1B restore intentionally did not set the var;
  Phase-1B report open issue #1 requested exactly this correction; Phase-1B
  diagnostic shows graphs OFF costs -2.6% tg at 16k MTP OFF.
- Backup created before edit; correction note added in-file; full record in
  ops/manifest/prod_flags_correction.md.
- Production process NOT touched: running server (PID 397813, verified
  read-only via pidfile + ps) keeps its current environment until the next
  human-approved launch.

## 7. Remaining open questions

1. Full Phase-2A execution approval: the audit itself needs an operator go.
2. Profiling-window approval for Phase-2B (still blocked; unchanged).
3. 128k tracing approval for the gated 128k arm.
4. Profiler permissions (rocprof/roctracer or equivalent) on this host.
5. MTP ON comparison arms yes/no in Phase-2B (operator decision).
6. BINARY_PATH discrepancy (human decision): manifest says
   build/bin/llama-server but actual restored production runs
   build-p3/bin/llama-server per the Phase-1B restore decision matrix. Left
   untouched here as out of mandate.
7. Whether legacy results2/reports/final_report_phase2.md findings should be
   re-validated inside full Phase-2A or accepted as prior evidence.

## 8. Recommended next action

Run the full Phase-2A audit (report, evidence ledger, hypothesis matrix,
open questions) with the corrected primary target: 40 tok/s MTP OFF,
incorporating Phase-1B measurements and the legacy fattn VEC/TILE evidence.
No profiling until the human profiling-window approval for Phase-2B.
