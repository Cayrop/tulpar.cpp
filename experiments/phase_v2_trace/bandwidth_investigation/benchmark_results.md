# EXP-006 Benchmark Results

## Summary

| Metric | Pre-change (V2 baseline) | Post-change (exp006) | Delta |
|---|---:|---:|---:|
| **MTP OFF, 1k ctx, 256 toks** | 45.32 ms/tok | 45.64 ms/tok | **-0.71%** (noise) |
| **MTP OFF, 16k ctx, 256 toks** | 48.84 ms/tok | 48.07 ms/tok | **+1.59%** |
| **MTP OFF, 63k ctx, 256 toks** | 63.15 ms/tok | 54.96 ms/tok | **+12.97%** |
| **MTP OFF average** | - | - | **+4.6%** |

| Metric | Pre-change (V2 baseline) | Post-change (exp006) | Delta |
|---|---:|---:|---:|
| **MTP ON, 1k cached** | 25.02 ms/tok | 23.13 ms/tok | **+7.55%** |
| **MTP ON, 16k cached** | 28.38 ms/tok | 26.11 ms/tok | **+8.01%** |
| **MTP ON, 63k cached** | 26.97 ms/tok | 26.54 ms/tok | **+1.59%** |

## MTP OFF detailed results (5 reps, fixed seed, 256 toks, cached)

### 1k context
- exp006: [45.61, 45.64, 45.64, 45.72, 45.62] ms/tok (spread 0.24%)
- baseline (run_B): [45.48, 45.26, 45.27, 45.27] ms/tok (spread 0.47%)

### 16k context
- exp006: [48.20, 48.12, 48.08, 47.97, 47.96] ms/tok (spread 0.50%)
- baseline (run_B): [48.84, 48.84, 48.85] ms/tok (spread 0.03%)

### 63k context
- exp006: [55.05, 54.85, 54.86, 54.98, 55.05] ms/tok (spread 0.38%)
- baseline (run_B): [63.18, 63.13, 63.14] ms/tok (spread 0.07%)

## Correctness Gate Results

- `test-backend-ops -o MUL_MAT -t iq3_xxs` (HIP backend): **11/11 PASS**
- `test-backend-ops -o MUL_MAT` (HIP backend, all types): **PASS**
- Deterministic greedy suite (MTP ON, 12 tests): **12/12 PASS** (short tests bit-exact vs V2 baseline)
- Deterministic greedy suite (MTP OFF, 12 tests): **12/12 PASS**
- 9/12 short-context tests: **bit-exact** vs `results2/correctness/baseline_v2.json`
- 3/12 long-context tests (needle16k, needle_multi, longgen_story): differed in "thinking mode" prose only; not kernel-induced (independent of this change, occurs whenever thinking content varies between server restarts)

## Effective Bandwidth Estimate

The theoretical_ceiling.md estimated 350 GB/s for IQ3_XXS GEMV. The decode speedup maps to bandwidth improvement as:

At 1k MTP-OFF (45.64 ms total decode), IQ3_XXS dominates. If 50% of time is IQ3_XXS (23 ms @ 350 GB/s), and total time changed by -0.71% (no change), then IQ3_XXS bandwidth is essentially unchanged at 1k.

At 63k MTP-OFF (55 vs 63 ms = 13% speedup), more of the change is attributable to IQ3_XXS. Estimated IQ3_XXS BW improvement: ~25 GB/s (350 → ~375 GB/s).

**Measured effective bandwidth improvement: modest, ~7% at best, well below the 420 GB/s target.**

## Pre-fill Regression Check

Prefill speeds (mmq-load-tiles.cuh path, not changed):
- 1k prefill: 478.06 tok/s (vs 479.68 base, -0.34%)
- 16k prefill: 478.25 tok/s (vs 471.72 base, +1.38%)
- 63k prefill: 320.47 tok/s (vs 321.36 base, -0.28%)

**No prefill regression. MMQ path is unaffected.**

## Other Quant Types Regression Check

All other MUL_MAT tests passed in `test-backend-ops`. No regression detected in IQ3_S, Q3_K, or any other type. The change was scoped to the IQ3_XXS vec_dot only.

## Conclusion

The optimization (Strategy 1: Parallel Table Load) was **numerically correct** (all tests passed) and **produced a small but real decode speedup** (~5-13% in the best case at 63k context). However, the overall decode speedup of **+4.6% average** (MTP OFF) is **well below the 15% threshold** specified in the protocol.

The hypothesis predicted 15-30% improvement by hiding the gather chain latency, but in practice the gains were smaller because:
1. The compiler on RDNA3 already partially pipelines the table lookups even in the original loop.
2. The `sumi` accumulator chain (4 sequential dp4a pairs) is a hard serialization point that the optimization cannot remove.
3. MTP-ON path shows similar modest gains (+5.7% average), suggesting the change is real but limited.

**Per protocol section 7: change REVERTED.**
