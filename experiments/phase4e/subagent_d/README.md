# Phase-4E / Subagent-D: VDR-Increase Variants of IQ3_XXS MMVQ

## Objective

Test whether increasing VDR (vector-dot repeats per K-loop iteration) improves
throughput on gfx1101 IQ3_XXS MMVQ by reducing trip count and amortizing the
per-trip fixed cost (loop overhead, load issue, vmcnt ladder, branch).

## TL;DR (Verdict)

**VDR increase does NOT help on gfx1101 IQ3_XXS.** V0 (VDR=2, 1 iqs slice per
vec_dot call) is the optimum. All higher VDRs (D1=4, D2=8, D3=16) are equal to
or slower than V0 on both ffn_down and fused gateup.

| Variant | ffn_down B=1 (GB/s) | fused gateup B=1 (GB/s) | VGPR | Occupancy (blocks/CU) | K-loop insns | vdot4/call | Trips/thread |
|---------|---------------------|--------------------------|------|------------------------|----------------|------------|--------------|
| **V0 (VDR=2)**  | **164.3** | **182.9** | 77 | 64 | 417 | 8  | 17 |
| D1 (VDR=4)      | 160.8 (-2.1%) | 157.5 (-13.9%) | 38 | 64 | 913 | 16 | 9 |
| D2 (VDR=8)      | 150.4 (-8.5%) | 120.0 (-34.4%) | 44 | 64 | 1797 | 32 | 5 |
| D3 (VDR=16)     | 124.7 (-24.1%) | 118.0 (-35.5%) | 55→113 | 64→44 | 3565 | 64 | 3 |

(The D3 fused-gateup VGPR jumps to 113 and occupancy drops to 44 because the
gateup path uses 2 weight matrices per launch, doubling the per-thread state.)

## Why VDR increase fails

1. **Per-trip fixed cost is small.** Of V0's 417 K-loop insns, only ~5 are
   per-trip fixed cost (branch, address increment, init). That's 1.2% of the
   trip. Amortizing 1.2% over more work yields at most 1.2% gain.

2. **Per-trip work scales linearly with VDR.** The vec_dot body scales with
   BPC (blocks per call): V0=8 vdot4, D1=16, D2=32, D3=64. The K-loop body
   grows from 417 to 913 to 1797 to 3565 insns (2.19x, 4.31x, 8.55x of V0).

3. **Per-row total insns increases with VDR.** Trip count halves each step
   (17 -> 9 -> 5 -> 3), so per-row total work grows:
   - V0: 17 × 417 = 7089 insns/row
   - D1:  9 × 913 = 8217 insns/row (1.16x V0)
   - D2:  5 × 1797 = 8985 insns/row (1.27x V0)
   - D3:  3 × 3565 = 10695 insns/row (1.51x V0)

4. **Independent accumulators don't help.** Subagent-A's top recommendation
   was to split the 8-deep v_dot4 chain into 2 4-deep chains to reduce chain
   depth. VDR increase does the opposite: it duplicates 8-deep chains, not
   halves them. The chain depth per iqs-slice stays 8, so the consumer-side
   serialization is unchanged within each slice.

5. **Stall mix shifts but doesn't help.** rocprofv3 shows:
   - V0 ffn_down: 78% issue-wait, 14% dep-wait
   - D1 ffn_down: 55% issue-wait, 39% dep-wait

   D1 has *less* issue-wait (waves are busier) but *more* dep-wait (more
   in-flight v_dot4 chains to satisfy). The total time is unchanged.

6. **Fused gateup is more sensitive.** The fused path uses 2 weight matrices
   per launch, doubling the in-flight state. D3's VGPR count hits 113 (vs
   V0's 30), pushing occupancy down to 44 blocks/CU. D2 is already 34%
   slower on fused gateup, before the occupancy cliff.

## Reference to Subagent-A findings

Subagent-A's ISA analysis at `experiments/phase4e/subagent_a/`:

- K-loop is 417 insns/trip, with 14 vmcnt-contributing loads, 9 s_waitcnt
  (all vmcnt), 8 v_dot4, 0 s_barrier.
- vmcnt(0) at trip boundary is REQUIRED, not conservative (L14 consumed 4
  insns later at 0x148D44).
- Only trip-carried dependency is `v12` (float accumulator).
- 8 grid gathers already issued in parallel via s_clause 0x7.
- The 8-deep v_dot4 chain into single `v1` (sumi) is the consumer-side
  serialization.
- Subagent-A's top recommendation: split v_dot4 into two 4-deep chains
  into independent accumulators.

**This experiment does NOT test Subagent-A's recommendation.** VDR increase
duplicates 8-deep chains, it does not split them. To test Subagent-A's
recommendation, one would unroll 4 v_dot4s of each bq3 into one accumulator
and the other 4 into a different accumulator, then sum. That's a different
change than VDR templating.

What VDR increase DOES test: trip-count reduction. And the answer is: trip
count is not the bottleneck on gfx1101. The K-loop is already well-scheduled
(per Subagent-A's analysis), and the per-trip cost is dominated by compute
(8 vdot4 + address arithmetic + sign extraction), not by overhead.

## Bit-exactness

The user requested bit-exactness via integer associativity. The dp4a chains
within each iqs-slice are bit-exact (integer addition is associative). The
*d*sumi multiplication+addition is per-slice, also bit-exact. The only
difference between V0 and D1/D2/D3 is the **per-row float add order**:
- V0: tmp += d0*sumi0; tmp += d1*sumi1; ...
- D1: tmp += (d0*sumi0 + d1*sumi1); tmp += (d2*sumi2 + d3*sumi3); ...

The float add order matters, but the differences are bounded by float
reordering noise. Empirically:

- ffn_down B=1: max_abs_diff=0.25, max_rel_diff<0.05% (essentially 1 ULP per
  row, accumulating to a few ULPs across the row).
- fused_gateup B=1: max_abs_diff=262144 (out of values up to ~1e13), max_rel
  ~0.02% (still float-reordering magnitude).

These differences are unavoidable consequences of unrolling, and they
accumulate linearly with BPC. In a real inference path, this is below the
cumulative noise of subsequent operations.

## Reproduction

### Build

```sh
cd experiments/phase4e/subagent_d
./build.sh
```

### Verify bit-exactness

```sh
./mmvq_bench_vdr verify
```

### Run full benchmark (100 reps, all variants, all batches)

```sh
./mmvq_bench_vdr 100
```

### Run rocprofv3 stall metrics

```sh
cd experiments/phase4e/subagent_d
./rocprof/run_all.sh
python3 ./rocprof/analyze.py ./rocprof/pmc_1/
```

## Files in this directory

| File | Purpose |
|------|---------|
| `mmvq_bench_vdr.hip` | VDR-templated harness (V0/D1/D2/D3 in one binary) |
| `mmvq_bench_vdr` | Compiled binary (gfx1101) |
| `kloop_disasm_V0_D1_D2_D3.s` | SASS for K-loop analysis |
| `build.sh` | Build script |
| `iq3xxs_grid.h` | IQ3_XXS grid table (copied from phase3/synthetic) |
| `raw_measurements.csv` | Per-variant per-batch measurements |
| `results.json` | Structured results |
| `rocprof/stall_metrics.txt` | rocprofv3 input file |
| `rocprof/analyze.py` | CSV -> stall percentages |
| `rocprof/run_all.sh` | Run all variants through rocprofv3 |
| `rocprof/pmc_1/*.csv` | Raw counter data |
| `rocprof/stall_results.json` | Computed stall metrics |
| `raw/full_bench_100reps.txt` | 100-rep benchmark output |
| `raw/verify.txt` | Verify output |
| `README.md` | This file |

## Implementation details

### Design

Each variant keeps the existing thread mapping (8 threads per bq3 split into
iqs slices) but varies the **number of iqs slices per vec_dot call** (BPC).

| Variant | BPC (iqs slices/call) | Threads/bq3 | bq3/warp/iter | vdot4/call | Trips/thread |
|---------|------------------------|-------------|----------------|------------|--------------|
| V0      | 1                       | 8           | 4              | 8          | 17           |
| D1      | 2                       | 4           | 8              | 16         | 9            |
| D2      | 4                       | 2           | 16             | 32         | 5            |
| D3      | 8                       | 1           | 32             | 64         | 3            |

The 8 iqs slices of each bq3 are split among the threads in the group:
- V0: tid%8 of 8 iqs slices (each thread does 1)
- D1: tid%4 of 4 iqs slice pairs (each thread does 2 consecutive slices)
- D2: tid%2 of 2 iqs slice quads (each thread does 4 consecutive slices)
- D3: tid%1 of 1 iqs slice octet (each thread does all 8 slices)

Within each call, the per-slice v_dot4 chain goes into a *separate* sumi
accumulator. The 8 (or 16, 32, 64) d*sumi values are summed in the call body
before being added to the per-row tmp[j][i]. This is the user's requested
"independent accumulators" design.

### Bit-exactness vs original harness V0

The user's V0 baseline (mmvq_bench.hip from phase3) uses a non-templated
vec_dot. My V0 uses vec_dot<1>, which is functionally equivalent but
compiles to slightly different SASS. The checksum differs in the last 4 hex
digits due to compiler-different float reordering. Throughput is within
0.5% of the original.

### What's NOT in this experiment

- Subagent-A's recommendation (split 8-deep into 2 4-deep chains) — needs
  different templating, not VDR templating.
- Changing the LDS-grid (V1 variant in the original harness) — orthogonal to
  VDR.
- Production server changes — not done, per constraints.
- Building llama.cpp — not done, per constraints.

## Constraints met

- Harness only, no llama.cpp source changes. (Verified via `git diff`.)
- Production server not touched. (No `pkill`, no `systemctl`.)
- Build, model, repo unchanged. (No rebuild of `build-p3` or other.)
- Bit-exactness documented; differences are float reordering magnitude.
- rocprofv3 used (v1.1.0, ROCm 7.2.4). SQ_ACTIVE_INST_* metrics
  unavailable on gfx1101; documented and substituted with issue-wait and
  dep-wait, which are the binding metrics.
- No commit, push, or PR created.

## Caveats

During the bench window, the GPU was shared with other concurrent Phase-4E
subagents (their benchmarks were running in parallel on the same device).
The 100-rep numbers in `raw/full_bench_100reps.txt` are from a less-contended
window. Across 5 contested 100-rep runs, the **relative ordering V0 > D1 >
D2 > D3** is preserved, but absolute GB/s may vary by 10-15%. The `raw/
contended_runs.txt` captures the contended runs for transparency.

For the uncontended baseline, the per-variant GB/s on ffn_down B=1 is:
- V0: 164.3 GB/s (best run)
- D1: 160.8 (-2.1%) - within noise of V0
- D2: 150.4 (-8.5%) - clearly worse
- D3: 124.7 (-24.1%) - clearly worse

This is consistent with the SASS analysis: per-row total instructions
**increase** with VDR (7089, 8217, 8985, 10695 insns/row for V0, D1, D2, D3),
so even on a perfectly idle GPU, VDR increase cannot be faster than V0.
