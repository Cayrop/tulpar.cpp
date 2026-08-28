# Strategy Selection — EXP-006

## Candidate Strategies

### Strategy 1: Parallel Table Load (Hoist)
Extract all 8 indices `q3[0..7]` from `q3_packed` (already in registers at function entry).
Issue all 8 `iq3xxs_grid[...]` loads and all 8 `Q8_1` loads **before** the dp4a chain.
Pre-compute all 4 `signs` masks from `aux32` (already in registers).
Do the 4 sequential dp4a pairs after all data is ready.

**Viability**: HIGH. All 8 indices and all 4 sign-mask sources are available in registers at function entry. The compiler, with `#pragma unroll`, will be able to issue all 16 loads in parallel (no inter-load dependency on the lookups themselves — only on the register-resident index/aux32 values, which are already resolved).

**Numerical impact**: ZERO. The dp4a chain has the same number of operations, same order, same operands. The `__vsub4` formula is unchanged. The `ls` post-scaling is unchanged.

**Risk**: Register pressure. With 8 grid values (uint32 each) + 8 Q8_1 values (int) + 8 sign masks (int) live simultaneously, plus the working set, we may push VGPR usage up. The current estimate is ~20-30 VGPRs. If we go above ~48 VGPRs, occupancy may drop. Mitigation: the compiler will spill to local memory in the worst case, which only hurts performance, not correctness.

### Strategy 2: LDS Pre-load with Conflict-Free Layout
Pre-load `iq3xxs_grid` (1 KB) into shared memory. Use padding to avoid bank conflicts.

**Why rejected**: The investigation (`lookup_table_analysis.md`) concluded the table is *already* in L1 (1 KB fits in 32 KB L1) and the per-call gather is an L1 hit, not a VRAM access. Moving it to LDS would not reduce latency (LDS and L1 hit latency are similar on RDNA3) and would consume shared memory that could be used for other things. Phase-4A already attempted this with bank conflicts.

### Strategy 3: Software Pipelining
Prefetch the next iteration's indices while computing the current iteration.

**Why rejected**: The indices are already loaded at function entry (one `q3_packed` load gives all 8). Prefetching across iterations is meaningless when the source data is already in registers. The bottleneck is the `sumi` accumulator chain, not the index loads.

## Selected Strategy

**Strategy 1: Parallel Table Load (Hoist)**

## Expected Improvement

- **Pre-change**: 8 dependent loads are issued in 4 groups of 2 (paired by `make_int2`). The compiler can interleave some of these, but the `sumi` accumulator forces a serial schedule across iters.
- **Post-change**: All 8 grid lookups and all 8 Q8_1 lookups are issued in parallel (no inter-load dependency). The 4 dp4a pairs run sequentially on the ready data.
- **Target**: increase effective bandwidth from 350 GB/s toward 420 GB/s (closing ~50% of the 1.5× gap to the 525 GB/s ceiling).
- **Estimated decode speedup**: ~15-20% on IQ3_XXS-heavy layers.

## Risk Assessment

- **Correctness**: Bit-exact. All operations preserved.
- **Performance risk**: Low. Worst case is no improvement if the compiler already optimally scheduled the current code.
- **Build risk**: Low. Single-file change, no header dependency changes.

## Implementation Plan

1. Modify only `vec_dot_iq3_xxs_q8_1` in `ggml/src/ggml-cuda/vecdotq.cuh`.
2. Hoist all 8 `iq3xxs_grid` lookups to the top of the function.
3. Hoist all 8 `get_int_b4` Q8_1 reads to the top.
4. Pre-compute all 4 `signs` and the 8 `signs0`/`signs1` masks.
5. Keep the 4-iter dp4a loop identical to the current code.
6. The post-loop `ls` scaling and `d * sumi` return remain unchanged.

## Validation

- `test-backend-ops -o MUL_MAT -t iq3_xxs` must pass.
- Deterministic greedy output must be bit-exact.
- Numerical drift < 1e-6.
