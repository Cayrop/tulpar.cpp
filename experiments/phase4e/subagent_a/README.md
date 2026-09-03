Phase-4E / Subagent-A: IQ3_XXS MMVQ ISA Dependency Analysis
==========================================================

This document is the read-only dependency analysis of the IQ3_XXS MMVQ
matrix-vector kernel for the RDNA3 (gfx1101) target.  All conclusions are
based on actual disassembly of the production binary
`build-p3/bin/libggml-hip.so.0.21.0`.

The binary was not modified, the build was not re-run, no kernel was
executed, and the production server was not touched.

---

1. How the analysis was performed
---------------------------------

1. The `.hip_fatbin` section (0x127000, 75 MB) was extracted with
   `objcopy --dump-section .hip_fatbin=...` and was identified as a
   Clang offload bundle (`__CLANG_OFFLOAD_BUNDLE__` magic, target
   `hipv4-amdgcn-amd-amdhsa--gfx1101`).
2. The 180 inner ELF objects were split out; object `co_033.o` was the
   only one containing the IQ3_XXS MMVQ kernel symbols
   (matches `mul_mat_vec_qIL9ggml_type18...`, where `ggml_type18 ==
   GGML_TYPE_IQ3_XXS`).
3. The most common variant
   `_ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0E...`
   (ncols_dst=1, no fusion, no small_k, no halve_iters) is at
   `0x148400..0x149248` (size `0xe48`).
4. The kernel was disassembled with
   `llvm-objdump -d --disassemble-symbols=...` (RDNA3 SASS).
5. The K-loop was identified as
   `s_cbranch_execnz 64808` at `0x149118` (backward by -728
   instructions) targeting `0x1485BC`, spanning 417 instructions.

The full annotated SASS is in `kloop_disasm.S`.  The textual
dependency graph is in `dependency_graph.txt`.  The structured findings
are in `findings.json`.

---

2. K-loop inventory (one trip)
------------------------------

| Category                           | Count |
|------------------------------------|------:|
| Instructions in trip               |   417 |
| `global_load_b32`                  |    10 |
| `global_load_b128`                 |     2 |
| `global_load_b64`                  |     1 |
| `global_load_d16_hi_b16`           |     1 |
| **Total vmcnt contributors**       |  **14** |
| `s_waitcnt` (all vmcnt variants)   |     9 |
| `v_dot4_i32_iu8`                   |     8 |
| `s_barrier`                        |     0 |
| `ds_*`                             |     0 |
| `s_waitcnt lgkmcnt` inside loop    |     0 |

The 14 loads per trip are:

```
L1   v16        b32    [v[8:9]+0]            bq3 partial
L2   v[0:3]     b128   [v[8:9]-32]           bq8_1 qs[0:15]
L3   v[4:7]     b128   [v[8:9]-16]           bq8_1 qs[16:31]
L4   v[23:24]   b64    [v[23:24]+2]          bq3 sign payload (aux32)
L5   v50        b32    [v[25:26]+66]         bq8_1 ds (d, sum)
L6   v0 (.h)    d16_hi [v[21:22]]            bq3->d
L7   v51        b32    s[8:9]+v21*4          iq3xxs_grid[q3[0]]
L8   v52        b32    s[8:9]+v22*4          iq3xxs_grid[q3[1]]
L9   v53        b32    s[8:9]+v26*4          iq3xxs_grid[q3[2]]
L10  v54        b32    s[8:9]+v23*4          iq3xxs_grid[q3[3]]
L11  v55        b32    s[8:9]+v28*4          iq3xxs_grid[q3[4]]
L12  v56        b32    s[8:9]+v29*4          iq3xxs_grid[q3[5]]
L13  v57        b32    s[8:9]+v31*4          iq3xxs_grid[q3[6]]
L14  v58        b32    s[8:9]+v24*4          iq3xxs_grid[q3[7]]
```

---

3. List of every `s_waitcnt` in the trip and what it guards
-----------------------------------------------------------

```
0x148678  vmcnt(2)   L1..L4 done; L5, L6 may still be in flight.
                     Needed for v[23:24] (sign extraction) consumed at 0x14867C.
0x148720  vmcnt(9)   L1..L5 done; L6..L14 may still be in flight.
                     Needed for v[0:3], v[4:7] (v_dot4 inputs) and v50 (sign bits).
0x148D04  vmcnt(7)   L1..L7 done. v51 is the 1st grid gather; consumed by v_xor at 0x148D08.
0x148D0C  vmcnt(6)   L1..L8 done. v52 is the 2nd grid gather; consumed at 0x148D10.
0x148D14  vmcnt(5)   L1..L9 done. v53 consumed at 0x148D18.
0x148D1C  vmcnt(4)   L1..L10 done. v54 consumed at 0x148D20.
0x148D24  vmcnt(3)   L1..L11 done. v55 consumed at 0x148D28.
0x148D2C  vmcnt(2)   L1..L12 done. v56 consumed at 0x148D30.
0x148D40  vmcnt(0)   L1..L14 done. v58 consumed at 0x148D44; v57 at 0x148EE4; v0 at 0x1490F4.
```

The pattern in the second half of the trip is a ladder of
`vmcnt(7)`-`vmcnt(2)` followed by a final `vmcnt(0)`.  Each wait is
paired with the very next `v_xor_b32` that consumes one specific grid
load.  The waits are *exactly* the minimum for each paired consumer;
they cannot be relaxed.

---

4. Loop-carried data flow (trip boundary)
-----------------------------------------

The only register that must be live across the trip boundary is `v12`,
the float partial-sum accumulator:

```
trip end  (0x149110)  v_fmac_f32_e32 v12, v0, v1
                       v0 = bq3->d (f32 of half)
                       v1 = sumi (f32, int -> f32 via v_cvt_f32_i32 at 0x14910C)
trip start (0x1485BC) v12 read by the next trip's fmac.
                       (Initial value 0 set OUTSIDE the loop at 0x148518.)
```

Every other register (the 8 grid lookups `v51..v58`, the q3 bytes
`v[0:3]`, the q8 bytes `v[4:7]`, the sign payload `v[23:24]`, the
scale `v50`, the d scale `v0`, all xor/perm/sub intermediates, the 8
`v_dot4` results, and the int sumi `v1`) is dead by the time the loop
back-branch at `0x149118` fires.  This means **the 8 `v_dot4` chain
inside the trip has no trip-to-trip data dependency** - the entire
computation from grid load through `v_dot4` chain to sumi is bounded
within a single trip.

There is **no compiler barrier stricter than necessary** in the loop:

- `s_barrier` count: 0
- `ds_*` count: 0
- `lgkmcnt` waitcnts inside the trip: 0 (all `lgkmcnt(0)` in the
  binary are at pre-loop constant loads and the post-loop shared
  reduction, which are not relevant to the per-trip latency)
- `buffer_gl0_inv` count inside the trip: 0 (only one `buffer_gl0_inv`
  at `0x14912C` which is *between* blocks, not within the K-loop)

---

5. Verdict on `s_waitcnt vmcnt(0)` at `0x148D40`
------------------------------------------------

**Required, not conservative.**

- It is the minimum wait for `L14` (the `v58` global load), which is
  consumed 4 instructions later at `0x148D44`:
  `v_xor_b32_e32 v52, v58, v17`.
- `L14` is the 14th and last load issued, so `vmcnt(0)` here is exactly
  "`L14` done".  A `vmcnt(1)` would still allow `L14` to be in flight
  and is therefore incorrect.
- The wait is also sufficient for `L13` (`v57`, consumed at `0x148EE4`)
  and `L6` (`v0`, consumed at `0x1490F4`), but those are not the
  binding consumers - `L14` is.

The same logic applies to every other wait in the loop:

| Wait              | Tightest consumer            | Tightest wait  |
|-------------------|------------------------------|---------------:|
| `vmcnt(2) 0x148678` | L4 (v[23:24]) at 0x14867C    | `vmcnt(2)`     |
| `vmcnt(9) 0x148720` | L5 (v50) at 0x148724         | `vmcnt(9)`     |
| `vmcnt(7) 0x148D04` | L7 (v51) at 0x148D08         | `vmcnt(7)`     |
| `vmcnt(6) 0x148D0C` | L8 (v52) at 0x148D10         | `vmcnt(6)`     |
| `vmcnt(5) 0x148D14` | L9 (v53) at 0x148D18         | `vmcnt(5)`     |
| `vmcnt(4) 0x148D1C` | L10 (v54) at 0x148D20        | `vmcnt(4)`     |
| `vmcnt(3) 0x148D24` | L11 (v55) at 0x148D28        | `vmcnt(3)`     |
| `vmcnt(2) 0x148D2C` | L12 (v56) at 0x148D30        | `vmcnt(2)`     |
| `vmcnt(0) 0x148D40` | L14 (v58) at 0x148D44        | `vmcnt(0)`     |

In every case, the wait is the **minimum** for the binding consumer.
The compiler has already issued each wait at the optimal point
(immediately before its paired `v_xor`).

---

6. Verdict on the 8 grid gathers
--------------------------------

**Mutually independent and already issued in parallel.**

The 8 grid lookups are:

- Index bytes: 8 different bytes of `q3` (`q3[0]`..`q3[7]`), loaded as
  part of `v[0:3]` (L2).  They are mutually independent of each other.
- Table base: `s[8:9]` is constant for the whole kernel.
- Issue: a single `s_clause 0x7` at `0x1486DC` issues all 8 `b32`
  loads back-to-back.  The hardware will issue them to up to 8 LDS/L1
  channels in parallel.

The 8 *consumers* are serialized because the 8 `v_dot4` instances are
written into a single accumulator `v1` (sumi).  This is an
intra-accumulator dependency on the *compute* side, not a load-side
dependency.  All 8 grid values are *available* in parallel; only their
use is sequential.

---

7. Concrete recommendation
--------------------------

**No waitcnt relaxation is safe.**  The kernel is already optimally
scheduled with respect to wait placement.  The `vmcnt(0)` at the
bottom of the trip is the tight minimum for the last-issued load.

The latency is therefore not from over-conservative waits.  Other
potential optimizations, in priority order:

1. **Re-order the 8 `v_dot4` chain to expose more ILP within the
   trip.**  Currently the chain reads/writes `v1` at every step
   (D1..D8 all touch `v1`).  If the 8 grid lookups were paired
   differently - 4 dot4s into `v1` and 4 dot4s into a different
   accumulator, then summed at the end - the trip would expose ~4x
   more dot4 ILP.  This is the most likely real win, *not* a waitcnt
   relaxation.

2. **Hoist the address computation** (`v_mad_i64_i32 v[21:22], null,
   0x62, v18, s[16:17]` at `0x1485FC`) earlier so the L1..L3 loads
   can be issued in parallel with the v_mad, hiding their latency
   better.  Currently L1..L3 are issued, then the address for L4..L6 is
   computed, then L4..L6 are issued.

3. **Move the 8 ladder waits earlier.**  The waits at `0x148D04..0x148D2C`
   are placed *after* the sign-extraction chain (which takes ~500
   insns).  The waits could be moved to immediately after the
   `s_clause 0x7` at `0x1486DC` and the sign work would overlap with
   the load latency.  This would not change correctness because each
   wait is paired with its own consumer, but it would shift the wait
   to where it costs less.

4. **Issue L1..L3 and L4..L6 in one s_clause.**  Currently they are
   two separate `s_clause 0x2` groups.  RDNA3 hw limit is 8 loads per
   clause; combining them would let the hardware schedule the
   6 wide loads with no inter-clause gap.

5. **Reduce the number of separate loads** by issuing a single
   `global_load_b128` for `v[23:24]` + `v50` + part of `v[4:7]`
   (impossible at the source level, but a source refactor could pack
   the data more tightly).  This is a kernel-level change, not a
   scheduling change.

None of these involve weakening the `vmcnt(0)`.

---

8. What the "vmcnt(0) is required" answer means for Phase-4E
-----------------------------------------------------------

The Phase-3/4A observation that the kernel is "latency-bound" with a
`s_waitcnt vmcnt(0)` at the end of each trip is, in this specific
kernel, *correct* and *necessary*.  Weakening the wait to `vmcnt(N)` for
`N>0` would produce a wrong result for the 8th grid gather (because
`v58` is the 14th and last load and is consumed 4 instructions later).

The latency is therefore not an artifact of an over-cautious compiler.
The win is in *scheduling* the per-trip work to expose more
intra-trip ILP, particularly:

- allowing the 8 grid lookups to issue earlier so the wait is
  back-pressured into compute, not the other way around;
- using two independent accumulators (split the 8 v_dot4s into two
  chains of 4, sum at the end) so the chain depth is 4 instead of 8.

These are the only available wins; the `vmcnt(0)` cannot be relaxed
without breaking the kernel.

---

9. Files in this directory
--------------------------

- `README.md`           - this file
- `kloop_disasm.S`      - raw SASS of the whole kernel, K-loop and
                          pre/post-loop.  ~575 lines, ~54 KB.
- `dependency_graph.txt` - textual / ASCII dependency graph
- `findings.json`       - machine-readable structured findings

All evidence cited by file:line refers to `kloop_disasm.S`.

---

10. Reproducing this analysis
-----------------------------

```sh
# Extract the HIP fatbin section
objcopy --dump-section .hip_fatbin=hip_fatbin.bin \
        <REPO_ROOT>/build-p3/bin/libggml-hip.so.0.21.0

# Unbundle the gfx1101 (RDNA3) entry
clang-offload-bundler --type=o --input=hip_fatbin.bin \
  --targets=hipv4-amdgcn-amd-amdhsa--gfx1101 --output=hip_fatbin.gfx1101.o

# Locate the code object with IQ3_XXS MMVQ symbols
python3 -c "
data = open('hip_fatbin.gfx1101.o', 'rb').read()
i, pos = 0, []
while i < len(data) - 4:
    if data[i:i+4] == b'\x7fELF':
        pos.append(i)
    i += 1
import os
os.makedirs('cobjs', exist_ok=True)
for k, p in enumerate(pos):
    end = pos[k+1] if k+1 < len(pos) else len(data)
    open(f'cobjs/co_{k:03d}.o', 'wb').write(data[p:end])
"

# Find the IQ3_XXS object and disassemble the right symbol
for f in cobjs/co_*.o; do
  if llvm-objdump --syms "$f" 2>/dev/null | grep -q "mul_mat_vec_q.*ggml_type18"; then
    llvm-objdump -d --disassemble-symbols=\
      _ZL13mul_mat_vec_qIL9ggml_type18ELi1ELb0ELb0ELb0EEvPKvS2_PKi31ggml_cuda_mm_fusion_args_devicePfj15HIP_vector_typeIjLj3EEjjjS8_jjjS8_jjjj \
      "$f"
  fi
done
```
