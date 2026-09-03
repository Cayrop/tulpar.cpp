# Dependency Chain Analysis — `vec_dot_iq3_xxs_q8_1`

## Source
`ggml/src/ggml-cuda/vecdotq.cuh:1155-1188` (called from `ggml/src/ggml-cuda/mmvq.cu`).

## Per-iter dependency graph (per inner iter `l0`)

```
L1: q3_packed  (1× 8B global load)         <-- at function entry
L2: aux32      (1× 4B global load)         <-- at function entry
L3..L4: iq3xxs_grid[q3[l0+0]]  (4B dep on L1, via q3[l0+0] index)
L5..L6: iq3xxs_grid[q3[l0+1]]  (4B dep on L1, via q3[l0+1] index)
                       ^^^ L5..L6 and L3..L4 are independent of each other
R1: signs      = unpack_ksigns(aux32 >> (7*l0/2))  (dep on L2, register)
R2: signs0     = __vcmpne4(signs & 0x08040201, 0)  (dep on R1)
R3: grid_l     = __vsub4(grid_pos.x ^ signs0, signs0)  (dep on L3..L4, R2)
R4: signs1     = __vcmpne4(signs & 0x80402010, 0)  (dep on R1)
R5: grid_h     = __vsub4(grid_pos.y ^ signs1, signs1)  (dep on L5..L6, R4)
L7..L8: u0, u1 = get_int_b4(bq8_1[iqs/2].qs, l0+{0,1})  (dep on iqs, no inter-iter dep)
A1: dp4a(grid_l, u0, sumi_prev) -> sumi'    (dep on R3, L7, prior iter's A2)
A2: dp4a(grid_h, u1, sumi') -> sumi_next    (dep on R5, L8, A1)
```

## What depends on what (table)

| Load | Index source | Latency (worst case, L1 hit) | Serial dep on prior iters? |
|------|--------------|-----------------------------:|----------------------------|
| `iq3xxs_grid[q3[l0+0]]` | `q3_packed[l0+0]` (register) | ~30 cycles | No (independent) |
| `iq3xxs_grid[q3[l0+1]]` | `q3_packed[l0+1]` (register) | ~30 cycles | No (independent) |
| `u0 = Q8_1[l0+0]` | `l0+0` (loop var) | ~30 cycles (cached) | No |
| `u1 = Q8_1[l0+1]` | `l0+1` (loop var) | ~30 cycles (cached) | No |
| `dp4a(grid_l, u0)` | computed | 4 cycles | Yes (on prior iter's `sumi` accumulator) |

The only inter-iter serial chain is the **`sumi` accumulator** (4 sequential dp4a per call, each depends on the previous dp4a's output). The two `iq3xxs_grid` loads per iter and the two `u0/u1` loads are independent between iters (different indices/offsets).

## Why is the current code slow?

The 4-iter loop is `#pragma unroll`'d, so the compiler sees the 8 distinct grid loads and 8 distinct u0/u1 loads. The compiler can in principle interleave them. However, **the dp4a chain forces the iterations to be linearly scheduled**: the 4-iter `sumi` chain has 4 sequential dp4a operations, each needing 1 of the 8 grid values and 1 of the 8 Q8_1 values. The compiler cannot start iter `l0=2`'s dp4a until iter `l0=0`'s dp4a completes (because of the `sumi` accumulator).

The current code is:
```cpp
for (int l0 = 0; l0 < 8; l0 += 2) {
    // 1. Two grid lookups (parallel)
    const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
    // 2. Compute signs
    const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));
    const int signs0 = __vcmpne4(signs & 0x08040201, 0);
    const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
    // 3. Load u0
    const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);
    // 4. Compute grid_h
    const int signs1 = __vcmpne4(signs & 0x80402010, 0);
    const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
    // 5. Load u1
    const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);
    // 6. Two dp4a (serial)
    sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
    sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
}
```

The grid lookups and Q8_1 lookups can be issued at the top of the loop body. But the compiler is conservative: it likely cannot prove that reordering the `u0`/`u1` loads above the `signs*`/`grid_l`/`grid_h` computation is safe, because the order of `u0` and `u1` vs `grid_l` and `grid_h` interleaving depends on `l0`.

## Can the chain be reordered / parallelized?

YES. All 8 indices `q3[0..7]` are available in registers at function entry (they come from `q3_packed`). All 4 `signs` values can be precomputed from `aux32` (also in registers). All 8 Q8_1 values can be pre-loaded before the loop. The ONLY serial chain is the `sumi` accumulator.

**Optimal schedule:**
1. **Phase 1 (load issuance)**: issue all 8 `iq3xxs_grid[...]` loads + all 8 `get_int_b4(Q8_1, ...)` loads. Total: 16 independent 4B loads.
2. **Phase 2 (compute prep)**: compute all 4 `signs` (from `aux32`); compute all 8 `signs0`/`signs1` masks; compute all 8 `grid_l`/`grid_h` values from the table lookups.
3. **Phase 3 (dot product)**: do 4 sequential dp4a pairs, each using pre-loaded values.

The two phases of dp4a pairs can still be split: the 8 dp4a values can be computed into 8 partial sums, then reduced at the end. But the simpler approach is to keep the 4-iter sequential chain (since the dp4a throughput is so high that the chain is not the bottleneck — see `theoretical_ceiling.md` §3.2).

## Can the chain be prefetched?

The 8 dependent loads in the current code are already as parallel as the compiler can make them **within a single iter**. The key remaining serialization is the `sumi` accumulator across iters, which the compiler cannot break without algorithmic changes.

## Where the 8 dependent loads are in the code

`vecdotq.cuh:1167` — the `make_int2(iq3xxs_grid[...], iq3xxs_grid[...])` is 2 dependent loads; ×4 iters = 8 total dependent loads per vec_dot call.

## Conclusion

**Strategy 1 (Parallel Table Load) is viable.** All 8 indices are available in registers (`q3_packed` is loaded once at function entry). Hoisting all 8 table lookups out of the loop, alongside all 8 Q8_1 loads, will let the compiler/issue logic schedule all 16 loads in parallel. The 4 sequential dp4a pairs remain, but they are the post-load compute and don't depend on each other per dp4a — only on the sumi accumulator.

The arithmetic remains identical (same `__vsub4(grid_pos.x ^ signs0, signs0)` formula, same `dp4a` calls, same accumulation order).

## Risk

- **Register pressure**: pre-loading 8 table values + 8 Q8_1 values + 8 sign masks increases live registers. With `#pragma unroll`, the compiler will manage this. Worst case: register spilling, which would hurt performance but not correctness.
- **Numerical equivalence**: 100% bit-exact. All operations are in the same order, just hoisted out of the loop.
