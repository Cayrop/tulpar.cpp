# Tulpar.cpp Optimization Roadmap v2

Date: 2026-08-24. Supersedes roadmap decisions inside p2a_interim.md.
Base: tulpar/main @ 66dcba5eb (untouched). Production server runs the
original binary. No push, no PR, no release.

## Phase status

### PHASE 1 - COMPLETE
Profiling and baseline characterization.

### PHASE 2A - COMPLETE
GEMV/staging/attention decomposition; E3.0 staging tuning closed at
practical roofline (~553-604 GB/s traffic-equivalent at 128k).

### E1b - COMPLETE
Standalone IQ3_XXS vec_dot/kernel scheduling sweep (11 variants).
Decision:
- HARD PARK: current-algorithm IQ3_XXS scheduling/micro-tuning.
- DEFER: algorithmic IQ3_XXS vec_dot redesign (see backlog below).
- No source integration.
Evidence: results2/tulpar/experiments/e1b_gemv/report.md
Scope note: E1b tested scheduling/load-width/ILP/prefetch/table-placement
only. It does NOT prove that all IQ3_XXS redesigns fail, nor that
~260 GB/s is a universal ceiling.

### PHASE 2B - SKIPPED
Reason: E1b produced no integration candidate.

### PHASE 5A - GO / NEXT PRIORITY
Goal: reduce micro-bubbles measured in E2 via kernel fusion and launch
reduction.

Measured evidence:
- ~7.4-7.7 ms/token wall gap between GPU busy and step wall.
- ~84% of the gap is micro-bubbles.
- ~1800-1940 bubbles per step (trace census: 1930 launches/step,
  1867 gaps/step summing 7.55 ms in the t16k rocpd trace).
- Average bubble ~3.5 us.
- quantize_q8_1 <-> GEMV transitions measured directly: 433 quantize_q8_1
  launches per step, each surrounded by median 3.36 us before + 3.44 us
  after gap = ~2.88 ms/step of bubble time adjacent to these transitions
  alone (37% of the total bubble budget). Successor of quantize_q8_1 is
  always mul_mat_vec_q; predecessors are silu-gated ops / rms_norm<1024> /
  previous GEMV / get_rows.

First work item:
- Fusion feasibility + exact launch census for the
  Quantize/RMSNorm/GEMV sandwich (census done for t16k, see
  experiments/e5a_fusion/).
- Identify the most expensive real chain first.
- Change ONE mechanism.
- A/B measure.
- Correctness check.

Candidate approaches:
A) RMSNorm + quantize_q8_1 fusion (~81 of 433 instances/step follow an
   rms_norm directly).
B) Move quantization into GEMV prologue (covers all 433 instances but
   touches every GEMV call path).
C) Produce activation format directly in suitable chains (epilogue of
   producing kernel writes q8_1).

First KEEP gate:
- >= 1.0 ms/token net model-level improvement: KEEP.
- 0.5-1.0 ms/token: evaluate complexity vs correctness risk.
- < 0.5 ms/token: PARK or switch to a different fusion approach.

Notes:
- Do NOT redesign all 406+ launches at once.
- First experiment = single-chain minimum viable fusion.
- Do not modify production binary.
- No direct commit/push to tulpar/main.

### PHASE 5B - GO
Goal: decompose the model-context 213 GB/s vs standalone 259 GB/s gap.

Measure the same IQ3_XXS workload at as many of these levels as possible:
A. Raw standalone kernel duration.            [DONE: e1b_gemv]
B. Same kernel raw device duration inside a HIP graph replay. [e5b]
C. Effective duration including adjacent-node transition intervals,
   real ggml graph context.                   [pending]
D. Full model context effective duration.     [partial: trace exists]

Decompose the gap into: actual kernel execution difference, launch/node
transition overhead, graph scheduling, cache/state effect, adjacent
dependency, measurement methodology difference.

Output format (attribution budget):
- kernel execution: X ms/token
- node transition / launch: X ms/token
- cache/state/context: X ms/token
- other/unknown: X ms/token

Only after this experiment state "recoverable dispatch cost = X ms/token".
Do NOT reuse the old ~4.6 ms/token figure as a confirmed result; it was an
upper-bound hypothesis.

### After 5A and 5B: RE-TRACE GATE
ctx: 1k / 16k / 63k / 128k. MTP: OFF minimum; ON only if the affected
mechanism interacts with MTP.
Report: GEMV, attention, staging, other GPU, micro-bubble count,
micro-bubble time, end-step drain, total wall ms/token, traced-vs-untraced
difference. Purpose: new bottleneck ranking.

### PHASE E3B - GO / PARALLEL DESIGN
E3A persistent f16 KV mirror REJECTED for long context (VRAM budget).
E3B goal: q4_0 KV -> direct tiled attention -> on-the-fly dequant inside
the tile -> no full f16 KV staging write.

E3B.0: independent correctness-oriented prototype. Measure max abs error,
relative error, attention output error if needed, tile runtime, register
usage, occupancy, estimated traffic. NO big llama.cpp integration yet.
Prototype gate: correctness PASS; analytic or measured meaningful potential
vs current staging+attention path; VRAM-safe.

E3B.1: real context sweep 1k/16k/32k/63k/96k/128k comparing current
q4_0->f16 staging + attention VS direct q4_0 tiled attention. Find the
measured hybrid dispatch threshold. Do not assume the threshold.

### PHASE Q2 - DEFERRED, NOT CANCELLED
When reopened:
Q2.0 exact tensor/type census, weight bytes/token, dominant GEMV classes,
launch count, trace contribution, vec_dot/dequant structure.
Q2.1 bottleneck attribution: DRAM / specific instruction throughput /
dependency chain / reduction / dispatch / format-decode complexity. Never
conclude "not ALU bound" from total theoretical TOPS alone.
Q2.2 enter only the optimization space the attribution points to:
micro-tuning, algorithmic redesign, or format-aware redesign.

## IQ3_XXS algorithmic redesign backlog - DEFERRED
Do not repeat what E1b already refuted:
- WG64/WG128 sweeps, rows-per-block variants, 2-way ILP, LDS grid-table,
  funnel-shift loads, nontemporal loads, simple software prefetch,
  uint4 packing.

Still open (future):
- alternative super-block ownership
- alternative 8-slice to thread mapping
- wave-cooperative decode
- decode sharing across output rows
- grid decode reorganization
- alternative reduction topology
- cooperative processing of multiple super-blocks
- instruction-level bottleneck profiling
- ISA/compiler scheduling study

Reopen conditions (all three):
1. A specific bottleneck is identified.
2. The proposed mapping directly attacks that bottleneck.
3. An analytical model predicts >= 15% kernel-level improvement.

## PHASE 4 - PARK
Logits drain / GPU sampling: ~0.75-1.1 ms/token secondary lever.
Re-evaluate after fusion and E3B.

## Work sequence
1. Fix E1b report and decision scope.                [DONE]
2. Write updated roadmap artifact (this file).       [DONE]
3. Phase 5A: quantize_q8_1 sandwich fusion feasibility + launch census.
4. Phase 5B: 213 -> 259 GB/s attribution experiment.
5. Re-trace and reorder bottlenecks.
6. E3B.0 direct q4_0 attention correctness prototype/design.
7. Q2.0 census and Q2.1 bottleneck attribution.
8. Update E3B / Q2 priority from measured results.
9. Phase 6 full validation after any integrated change.

## Working discipline
- Each experiment isolates ONE mechanism.
- Same commit base, same model, same GPU state.
- Median >= 3 reps; >= 5 for small gains.
- Keep raw artifacts.
- Never force unknown attribution into a known category.
- Separate hypothesis from proven result explicitly.
- Limit negative-result scope to what the experiment actually tested.
- Source-change-free attribution/design work comes first.
- tulpar/main stays untouched.
- Production server keeps running the original binary.
- Every sub-experiment ends with an explicit GO / PARK / INVESTIGATE.
