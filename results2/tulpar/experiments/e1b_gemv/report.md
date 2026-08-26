# E1b Final Report: IQ3_XXS standalone vec_dot/kernel sweep

Date: 2026-08-24. Branch tulpar/main 66dcba5eb. No source changes, no push,
no production binary change. All artifacts under results2/tulpar/experiments/e1b_gemv/.

# Hypothesis

The dominant decode cost is IQ3_XXS GEMV at ~213 GB/s effective (in-model)
vs machine pure-read ceiling 602.7 GB/s. If kernel-level work (workgroup
size, ILP, load width, table placement, prefetch, vectorization) can push a
standalone cold-weight kernel past 350-400 GB/s, a llama.cpp integration is
worth pursuing; below 350 the GEMV rewrite path should be parked.

# Baseline

Faithful standalone copy of mul_mat_vec_q<IQ3_XXS, ncols_dst=1> +
vec_dot_iq3_xxs_q8_1 (production config on gfx1101: nwarps=1, 32 threads per
block, one output element per block; kbx = tid/8 step 4, kqs = 2*(tid%8)).
Cold weights via 24-buffer rotation (~819 MB pool defeats the 64 MB Infinity
Cache); y kept hot as in the model.

- shape0 ffn_down (17408x5120): 259.3 GB/s, 0.1316 ms/call
- shape1 gate/up (5120x17408): 259.9 GB/s, 0.1313 ms/call
- Stability across three separate runs: +-0.5%
- vs ceilings: 43% of pure read (602.7), 53% of copy R+W (486)

Note: E1 measured 212.8 GB/s for the same tensors through full ggml graph
dispatch; standalone cold baseline here is ~259 GB/s. The ~46 GB/s (~18%)
gap is an ATTRIBUTION HYPOTHESIS at this point. It may include node
transition/launch overhead, graph scheduling, cache/state differences,
adjacent-node dependencies, or other model-context effects. Decomposing it
is Phase-5B scope; no recoverable-dispatch-savings claim is made here.

# Real Model Shape Coverage

Both dominant IQ3_XXS shapes from the real model are covered
(results2/tulpar/experiments/e1_gemv/shapes.txt):
ffn_down 17408x5120 (64 layers) and ffn_gate/up 5120x17408 (128 launches).
Together they carry 6.55 GB of the 8.01 GB per-token GEMV stream.
Bench bytes per call: 34.12 MB for both shapes (identical totals).

Layout fact established during this experiment: IQ3_XXS is a 256-element
super-block type (fp16 d + qs[96] = 98 B = 3.0625 bpw), not a 32-element
block type. Production thread mapping decomposes each super-block into
8 slices of 32 elements across 8 threads.

# Variant Matrix

Round 1 (one mechanism each) and round 2 (latency-targeted), all validated
for correctness before timing:

| id | mechanism | s0 GB/s | s1 GB/s | d_s0 | verdict |
|----|-----------|---------|---------|------|---------|
| V0 | baseline wg32 | 259.3 | 259.9 | - | BASELINE |
| V1 | wg64 | 215.3 | 244.4 | -17.0% | REGRESS |
| V2 | wg128 | 161.0 | 222.1 | -37.9% | REGRESS |
| V3 | rows2 wg32 | 259.8 | 231.4 | +0.2% | neutral/regress |
| V4 | rows4 wg128 | 171.4 | 219.8 | -33.9% | REGRESS |
| V5 | funnel-shift dword loads | 234.9 | 232.3 | -9.4% | REGRESS |
| V6 | LDS grid table | 246.4 | 252.0 | -5.0% | REGRESS |
| V7 | 2-way ILP accumulators | 260.5 | 257.0 | +0.5% | noise-level |
| V8 | V5 + nontemporal | 234.7 | 233.6 | -9.5% | REGRESS |
| V9 | software-pipeline prefetch | 220.7 | 220.6 | -14.7% | REGRESS |
| V10 | uint4 q8 loads | 231.4 | 228.3 | -10.7% | REGRESS |

# Profiling / Compiler Evidence

hipFuncGetAttributes / occupancy (compiler_kernel_info.json):

| variant | VGPRs | shared B | occ blocks @32thr |
|---------|-------|----------|-------------------|
| V0 baseline | 78 | 0 | 64 (max) |
| V1/V2 | 80 | 128/384 | 64 |
| V3 | 38 | 0 | 64 |
| V4 | 49 | 1536 | 42 |
| V5/V8 | 75 | 0 | 64 |
| V6 | 79 | 1024 | 64 |
| V7 | 69 | 0 | 64 |

Occupancy is already at the hardware block limit in all variants except
V4. VGPR counts are moderate; spills zero everywhere (local_bytes=0).

Throughput math: total theoretical INT8/packed arithmetic throughput
(>18 T ops/s) is NOT saturated by the measured dot-product rate (~0.68 T
int-MAC/s needed). However this does NOT establish "ALU is not limiting":
a bottleneck may still exist in the specific instruction mix (unpack/decode,
packed integer transforms, compares, shuffles/permutes), in dependency
chains, cross-thread reduction topology, or architecture-specific issue
throughput. Empirically, explicit MLP doubling (V9) and load-width reduction
(V10) both regressed, so latency and instruction-count are ruled out AS
PRIMARY LIMITERS FOR THIS IMPLEMENTATION FAMILY only. What remains is the
algorithm shape itself: 98 B super-blocks straddling
128 B cache lines, an 8-way slice decomposition with cross-thread reduction,
and grid-table decode - a combination that saturates around 260 GB/s cold
on this part regardless of scheduling.

Clocks sampled during runs: stable, no thermal throttling observed
(reps vary +-0.5%).

# Correctness Results

Host reference (ref_cpu.cpp) replicates production integer semantics
exactly (dp4a signed bytes, __vsub4 per-byte saturation, ksigns parity bit,
(ls*sumi + sumi/2)/2 scaling). Cross-validated against an independent
python replication and against device baseline.

All 11 variants x 2 shapes: rel_max <= 7.7e-7 vs reference
(max_abs <= 3.1e-2 on |values| up to 4.5e4) - pure fp accumulation-order
noise. No variant loosens accuracy. Three harness bugs found and fixed
during bring-up (documented in hypothesis.md); none affect final numbers.

# Benchmark Results

See variants.json and raw/bench_round2.txt. Medians of 7 reps x 192 calls,
30-call warmup, rotating buffers. Baseline reproduced three times within
+-0.5%.

# Achievable Bandwidth Envelope

Best measured: 260.5 GB/s (V7, shape0) - statistically equal to baseline.
~260 GB/s is the MEASURED envelope of the tested implementation family
(production vec_dot semantics) and the scheduling / load-width / ILP /
table-placement / prefetch optimization space. The experiment does NOT
establish this as a universal upper bound for all possible IQ3_XXS
algorithmic redesigns (alternative super-block ownership, wave-cooperative
decode, alternative slice-to-thread mapping, reduction topology changes,
decode sharing across rows are untested). The 350 GB/s decision threshold
is not reached by any of the 10 mechanisms; within the tested space the
spread indicates it is not reachable by scheduling changes.

# Why the Winning Variant Wins

There is no winning variant. V7's +0.5% on shape0 reverses to -1..-2% on
shape1 and is within run-to-run noise; its two independent accumulator
chains marginally help issue packing on the short shape only.

# Why Failed Variants Failed

- wg64/wg128/rows4-wg128: more threads per row multiply reduction traffic
  and table contention while halving/quartering per-thread work; consistent
  with the RDNA3_0 parameter-table comment in mmvq.cu that complex vec_dot
  types regress at higher thread counts.
- funnel-shift loads: two aligned dwords + funnel shift replace four byte
  loads but add register pressure and boundary-line splits; net loss ~10%.
- nontemporal: same as V5 plus NT overhead; weights are streamed once so
  cache pollution is not a factor at this occupancy.
- LDS table: L1 already services the 1 KB grid table adequately; LDS adds
  capacity pressure and bank conflicts on scattered indices.
- software pipeline: doubling MLP regressed 15%, showing latency was not
  the binding constraint at max occupancy.
- uint4 q8: fewer load instructions but wider registers and worse latency
  hiding; net -11%.

# Model Integration Projection

Moot given no integration candidate, but for completeness: even if a
redesign reached 350 GB/s, model-level gain would be bounded by Amdahl:
IQ3_XXS GEMV is 25.2 ms/token at ~260 GB/s (6.55 GB); at 350 it would be
18.7 ms (-6.5 ms per token). At the measured ~260 GB/s ceiling of the
tested family there is no kernel-rewrite gain to project. Separately, the
213-vs-259 GB/s model-context gap is an UNATTRIBUTED hypothesis; IF it were
fully recoverable dispatch cost (unproven), it would be worth up to
~4.6 ms/token - treat as an upper-bound hypothesis only, to be decomposed
by Phase 5B before any claim.

# Regression / Maintenance Risk

None materialized: no source changes were made. For the future, the
experiment leaves reusable infrastructure: exact host reference, validated
harness methodology (cache-defeating rotation), and negative results that
protect maintainer time (the RDNA3_0 whitelist heuristics are confirmed
correct for IQ3_XXS).

# Decision: GO / PARK / INVESTIGATE

Decision: HARD PARK current-algorithm scheduling optimization.
Decision: DEFER algorithmic IQ3_XXS vec_dot redesign.
No source integration.

Scope of the HARD PARK (exactly what this experiment tested and exhausted):
- workgroup size / threads-per-row (V1, V2, V4)
- rows-per-block changes (V3, V4)
- simple 2-way ILP accumulator splitting (V7)
- LDS-resident grid table (V6)
- load packing via aligned dword + funnel shift (V5, V8)
- nontemporal loads (V8)
- simple software-pipelined prefetch (V9)
- uint4 vectorized q8 loads (V10)

What was NOT tested (stays open under DEFER, reopen only when a specific
bottleneck is identified, the proposed mapping attacks it directly, and an
analytical model predicts >=15% kernel-level gain):
- alternative super-block ownership
- alternative 8-slice to thread mapping
- wave-cooperative decode
- decode sharing across output rows
- grid decode reorganization
- alternative reduction topology
- cooperative processing of multiple super-blocks
- instruction-level bottleneck profiling / ISA study

Answers to the mandated questions:
1. 350 GB/s threshold passed? NO within the tested space. Best 260.5 GB/s =
   baseline within noise.
2. Best result: 260.5 GB/s / 0.1310 ms per call (V7, shape0); baseline
   259.3 GB/s / 0.1316 ms.
3. Repeatable? Yes: three runs, medians within +-0.5%; all reps recorded.
4. Winning mechanism: none; every mechanism regressed or was neutral.
5. Portable to real kernel? Moot; nothing to port beyond what exists.
6. Model-level potential: ~0 from scheduling changes. The 213-vs-259 GB/s
   gap is an unattributed hypothesis (Phase 5B); its recoverable part,
   if any, is UNKNOWN until decomposed.
7. Integration risk: N/A (no integration).
8. Next decision: HARD PARK scheduling path; DEFER algorithmic redesign to
   backlog; proceed with Phase 5A fusion feasibility + Phase 5B attribution;
   Q2_K research deferred not cancelled; E3A rejected by VRAM budget.
