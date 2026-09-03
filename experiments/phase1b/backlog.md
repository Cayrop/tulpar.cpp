# Phase-1B Backlog Notes

## Observation (user-reported, NOT a controlled measurement)

- draft-n-max 8/16 showed a serious speed increase during code generation.
- Observed range: 40-60 tok/s.
- These speeds were observed with spec KV cache at q4.
- Source: user observation during interactive use. Not measured under the
  Phase-1B controlled protocol (fixed prompts, greedy sampling, fixed npred,
  fresh-process windows). No artifacts exist for it in this phase.

Context from Phase-1B baseline (controlled, draft-n-max 4, q4_0 spec KV):
effective MTP ON tg was 25.8 / 30.6 / 31.3 / 21.0 tok/s at 1k / 16k / 63k /
128k with greedy sampling and summarize-style prompts. The user's 40-60 tok/s
claim exceeds all of these, which is plausible if code-generation content has
much higher draft acceptance than prose summarization, and/or n-max 8/16 lifts
the accepted-length ceiling. Both effects are unmeasured here.

## Backlog hypothesis

H-MTP-NMAX:
draft-n-max 8/16 with q4_0 spec KV may increase EFFECTIVE user-visible
throughput beyond the draft-n-max 4 baseline, especially on high-acceptance
workloads (code generation).

Evaluation plan sketch (for a future dedicated experiment, NOT Phase-1B):
- arms: n-max in {4, 8, 16} x workload in {prose summarize, code gen} at 16k
- same greedy protocol as Phase-1B for comparability; report effective tok/s
  (wall-based) AND predicted_ms-based tg side by side
- watch VRAM: draft-n-max raises draft KV/compute buffer peak (Phase-1B MTP ON
  arms already peaked at ~15.5 GiB of 16 GiB at 128k)

## Priority note

Excluded from Phase-1B by design: this phase optimizes nothing; it measures the
n-max 4 baseline only. Parameter optimization belongs to a later phase after
this baseline is reviewed.
