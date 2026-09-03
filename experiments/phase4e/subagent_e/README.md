# Phase-4E / Subagent-E: Independent Accumulator Variants (E1/E2/E3)

## Objective

Test whether breaking the 8-deep `v_dot4_i32_iu8` serial chain in the IQ3_XXS MMVQ kernel
by using independent accumulators (E1: 4 accumulators, E2: 8 accumulators, E3: 8 accumulators
+ hoisted gathers) improves throughput, given that the kernel is memory-latency bound.

## Hypothesis

The V0 kernel has an 8-deep `v_dot4_i32_iu8` dependency chain (all 8 dp4a operations feed
into a single `sumi` accumulator). On RDNA3, each `v_dot4_i32_iu8` has ~4-cycle latency,
so the chain adds ~32 cycles of dependency wait per trip. By using independent accumulators,
we can break this chain and potentially improve throughput.

## Variants

| Variant | Description | Expected Chain Depth |
|---------|-------------|----------------------|
| V0 | Single `sumi` accumulator, 8 chained dp4a | 8 |
| E1 | 4 independent accumulators (one per `l0` iteration), pairwise combine | 2 |
| E2 | 8 independent accumulators (one per dp4a), reduction-tree combine | 1 |
| E3 | E2 + hoisted gathers (all grid values and `u` loads computed before any dp4a) | 1 |

## Bit-Exactness

**Status: PASS**

All E variants produce bit-identical results to V0 across:
- All 256 `iq3xxs_grid` entries (via `sweep_shift` 0-3)
- 6 random seeds (42, 1, 2, 3, 12345, 99999)
- Both unfused (ffn_down) and fused (ffn_gateup) cases

This is expected because integer addition is associative/commutative, and the E variants
only regroup the dp4a accumulation without changing the mathematical result.

## SASS Chain Depth Analysis

The SASS confirms the expected chain depth reduction:

| Variant | v_dot4 Pattern | Max Chain Depth |
|---------|----------------|-----------------|
| V0 | `v1 = dot(..., v1)` x8 (all feed v1) | 8 |
| E1 | 4 independent `vN = dot(..., 0)` + 4 dependent `vN = dot(..., vN)` | 2 |
| E2 | 8 independent `vN = dot(..., 0)` | 1 |
| E3 | 8 independent `vN = dot(..., 0)` | 1 |

## Performance Results

### ffn_down (unfused, K=17408, N=5120)

| Variant | GB/s (weight) | GB/s (total) | Regs | Occ | Delta vs V0 |
|---------|---------------|--------------|------|-----|-------------|
| V0 | 161.457 | 161.738 | 76 | 64 | - |
| E1 | 162.506 | 162.79 | 76 | 64 | +1.049 (+0.65%) |
| E2 | 162.003 | 162.286 | 76 | 64 | +0.546 (+0.34%) |
| E3 | 162.552 | 162.836 | 76 | 64 | +1.095 (+0.68%) |

### ffn_gateup (fused, K=5120, N=17408)

| Variant | GB/s (weight) | GB/s (total) | Regs | Occ | Delta vs V0 |
|---------|---------------|--------------|------|-----|-------------|
| V0 | 182.426 | 182.725 | 33 | 64 | - |
| E1 | 183.299 | 183.6 | 33 | 64 | +0.873 (+0.48%) |
| E2 | 180.647 | 180.943 | 35 | 64 | -1.779 (-0.98%) |
| E3 | 180.79 | 181.086 | 37 | 64 | -1.636 (-0.90%) |

## Analysis

The E variants show only marginal improvement (~0.3-0.7% on ffn_down, ~0.5% on ffn_gateup
for E1). E2/E3 show slight regression on ffn_gateup due to increased register usage
(35-37 vs 33 for V0).

**Key finding**: The 8-deep `v_dot4_i32_iu8` chain is NOT the primary bottleneck. The kernel
remains memory-latency bound, and breaking the dp4a chain does not significantly improve
throughput. The marginal improvement is within noise range.

## Verdict

**MARGINAL** - Do NOT adopt E variants.

The E variants:
1. Are bit-exact (PASS)
2. Break the 8-deep v_dot4 chain (confirmed in SASS)
3. Show only marginal performance improvement (~0.3-0.7%)
4. Increase register usage for E2/E3 on fused kernels (35-37 vs 33)
5. Add code complexity without meaningful benefit

The dp4a chain is not the limiting factor for this memory-bound kernel. The marginal
improvement does not justify the code complexity.

## Files

- `mmvq_bench_accum.hip` - Harness with V0/E1/E2/E3 variants
- `build.sh` - Build script
- `raw_measurements.csv` - Raw benchmark data
- `bit_exact_check.log` - Bit-exact verification log
- `results.json` - Structured results
- `mmvq_bench_accum.s` - SASS disassembly

## Build & Run

```bash
./build.sh
./mmvq_bench_accum verify
./mmvq_bench_accum bench raw_measurements.csv
```
