# iq3xxs_grid Structural Analysis Report

Phase: 4-GRID (read-only decisive gate)
Date: 2026-08-25
Scope: structure of `iq3xxs_grid` and viability of gather-free dequant paths.
No llama.cpp source, build, model, or server was touched.

## Final verdict

NEITHER_VIABLE

- PATH A (arithmetic dequant): NOT_VIABLE
- PATH B (v_perm_b32 permute lookup): NOT_VIABLE
- Recommend falling back to Path C (VDR / trip reduction) and/or Path D
  (software pipelining), consistent with the Phase-4A conclusion that the
  bottleneck is dependency structure, not table storage or footprint.

## 1. Table location and declaration

- Definition: `ggml/src/ggml-common.h:1017`
  `GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)`, data at lines 1018-1049,
  terminated by `GGML_TABLE_END()` at line 1050.
- Macro expansion depends on backend (`ggml-common.h:472-502`):
  - CUDA/HIP: `static const __device__ uint32_t iq3xxs_grid[256]` (line 493)
  - Metal:    `static const constant uint32_t ...`        (line 486)
  - CPU/generic: `static const uint32_t ...`              (line 472)
- Element type: `uint32_t`. Count: 256 (verified). Size: 1 KB.
- All 256 values are distinct.

## 2. Indexing mechanism

Consumer: `vec_dot_iq3_xxs_q8_1`, `ggml/src/ggml-cuda/vecdotq.cuh:1155-1188`.
Block layout: `ggml/src/ggml-common.h:407-411`:
`{ ggml_half d; uint8_t qs[3*QK_K/8]; }` (96 bytes for QK_K=256).

Exact code path (vecdotq.cuh:1160-1181):

```cpp
const int2 q3_packed = make_int2(get_int_b2(bq3->qs, iqs), get_int_b2(bq3->qs, iqs+1));
const uint8_t * q3 = (const uint8_t *) &q3_packed;
const uint32_t aux32 = get_int_b2(bq3->qs, QK_K/16 + iqs/2);

for (int l0 = 0; l0 < 8; l0 += 2) {
    const int2 grid_pos = make_int2(iq3xxs_grid[q3[l0 + 0]], iq3xxs_grid[q3[l0 + 1]]);
    const uint32_t signs = unpack_ksigns(aux32 >> (7*l0/2));

    const int signs0 = __vcmpne4(signs & 0x08040201, 0);
    const int grid_l = __vsub4(grid_pos.x ^ signs0, signs0);
    const int u0 = get_int_b4(bq8_1[iqs/2].qs, l0 + 0);

    const int signs1 = __vcmpne4(signs & 0x80402010, 0);
    const int grid_h = __vsub4(grid_pos.y ^ signs1, signs1);
    const int u1 = get_int_b4(bq8_1[iqs/2].qs, l0 + 1);

    sumi = ggml_cuda_dp4a(grid_l, u0, sumi);
    sumi = ggml_cuda_dp4a(grid_h, u1, sumi);
}
```

Key mechanics:

- Grid index: each raw byte `q3[l]` of words `iqs`, `iqs+1` is used directly
  as a full 8-bit index into the 256-entry table. One entry supplies 4 weight
  values (the 4 bytes of the u32).
- Signs: `aux32` is word `QK_K/16 + iqs/2` of `qs`. Its low 28 bits hold four
  7-bit sign fields (one per l0 pair, shift `7*l0/2` in {0,7,14,21}); its top
  4 bits are the scale `ls = aux32 >> 28` (line 1184).
  `unpack_ksigns` (vecdotq.cuh:97-104) expands 7 stored bits to 8 signs using
  a popcount parity bit and broadcasts via `* 0x01010101`.
- Sign application: `__vcmpne4(signs & sel, 0)` produces per-lane 0xFF/0x00,
  then `__vsub4(grid ^ s, s)` negates the lane where the sign bit is set
  ((g ^ 0xFF) - 0xFF == -g on int8 lanes; identity otherwise).
- Accumulation: 8 x `ggml_cuda_dp4a` per call; final scaling
  `sumi = (ls*sumi + sumi/2)/2`, then `d * ds * sumi` (lines 1184-1187).

Reference pattern for Path B: `get_int_from_table_16`,
`ggml/src/ggml-cuda/vecdotq.cuh:34-95` (used for kvalues_iq4nl /
kvalues_mxfp4, e.g. lines 1327, 1349).

- HIP branch (lines 35-56): a 16-entry BYTE table held as 4 u32 registers;
  4 x `__builtin_amdgcn_perm` (= `v_perm_b32`): two lookups into the low-half
  pool `{values[1]:values[0]}` and high-half pool `{values[3]:values[2]}`
  with selectors masked to 3 bits (`& 0x07070707`), then one final mux perm
  per output with selector `0x03020100 | ((nibble & 0x08) >> 1)` routing by
  index-bit 3.
- CUDA branch (lines 57-80): equivalent `__byte_perm` sequence.
- Scope note: this primitive addresses 16 entries x 1 byte. `v_perm_b32`
  itself selects 4 output bytes from an 8-byte pool ({src0:src1}) using 4-bit
  selectors - it cannot span more than 8 source bytes per instruction.

## 3. The 256 values

Full extraction: `experiments/phase4grid/iq3xxs_grid_values.txt`
(index, hex u32, decimal, per-plane bytes), generated verbatim from
`ggml-common.h` by `experiments/phase4grid/analyze_grid.py`.

Patterns visible by inspection:

- Every byte of every entry belongs to exactly one 8-symbol alphabet,
  shared by all 4 byte planes:
  {4, 12, 20, 28, 36, 44, 52, 62} = {0x04, 0x0c, 0x14, 0x1c, 0x24, 0x2c, 0x34, 0x3e}
  i.e. 4 x {1,3,5,7,9,11,13} plus the outlier 62 (note: NOT 4*15=60).
- Each entry is therefore a 4-tuple over this alphabet: an all-positive
  magnitude quadruple. Sign lives entirely in the separate ksigns bits.
- The table is strictly increasing as u32 (lexicographic enumeration order),
  but the selected tuple SET is arbitrary-looking (see 4C).

## 4. Structural analysis results

All numbers below are programmatic results over all 256 entries
(experiments/phase4grid/analyze_grid.py output).

### A. Symmetry: NONE

| test | matches / 256 |
|---|---|
| grid[i] == grid[i^0xFF] | 0 |
| grid[i] == grid[255-i] | 0 |
| grid[i] == ~grid[i^0xFF] (bytewise complement) | 0 |
| entries whose signed negation exists anywhere in table | 0 |

No sign-pair structure. This is consistent with the design: signs are carried
outside the table (unpack_ksigns), so the table stores magnitudes only - but
there is no exploitable +/- pairing either.

### B. Nibble decomposability: FAILS

Tested grid[i] = combine(T_hi[i>>4], T_lo[i&0xF]):

| combine | result |
|---|---|
| xor | fail (interaction term not l-independent) |
| add mod 2^32 | fail |
| sub | fail |
| or (bit-plane separability) | fail |
| add per byte lane (mod 256) | fail |

OR-separability detail - driver of each output bit position (H = hi nibble
only, L = lo nibble only, - = mixed):

```
bit31..bit0: H-H---HHH-H---HHH-H---HHH-H---HH
```

many mixed-driver bits -> no OR split.

Stronger negative result: for EVERY byte plane p in {0..3}, the minimal
index-bit mask m such that plane_p(i) = f(i & m) has popcount 8 (m = 0xFF).
Every byte lane depends on ALL 8 index bits. So there is also no
"small sub-table per byte plane" collapse, and no constant-pool perm shortcut.

### C. Arithmetic structure: NO FORMULA EXISTS

- linear a*i+b: 95 distinct first differences (linear requires exactly 1).
- grid[i] determined by popcount(i): false.
- grid[i] == grid[bitrev8(i)]: 16/256 (chance level).
- Adjacent entries differing in exactly 1 byte lane: 75/255 (no walk structure).
- Table IS strictly increasing as u32 and rank tuples are non-decreasing
  lexicographically, but only 25 of the 330 possible sorted rank tuples are
  present (and only 5 of 70 strictly-sorted ones). The selected subset is
  k-means-arbitrary, so even a combinatorial-number-system unranking cannot work.
- Lineage vs iq3s_grid (512-entry sibling table): grid[i] == 4*iq3s_grid[i]
  for 1/256; == 4*iq3s_grid[j] for some j for 23/256. Unrelated.

Conclusion: the table is 256 tuned centroid quadruples over an 8-symbol
alphabet with no closed-form generation rule recoverable from the data.

### D. Value representation

- All values are u32 whose 4 bytes lie in [4, 62], all non-negative,
  trivially inside int8/u8 range. Byte-representable: YES (they ARE bytes).
- So v_perm_b32 can physically produce these values - the blocker for
  Path B is addressing (see 6), not representation.

### E. Index distribution (secondary)

The index space is fully covered: all 256 distinct entries, every possible q3
byte maps to a unique valid entry. Indices are encoder-chosen centroid ids;
distribution is data-dependent and approximately uniform for typical weights.
No skew is guaranteed across models, so no frequency-adaptive shortcut is safe.
Not a decision factor here.

## 5. Path A viability: NOT_VIABLE

An arithmetic f(index) reproducing all 256 values does not exist in any tested
family (linear, piecewise-lane, popcount, bit-reversal, Gray-order,
combinatorial-ranking), and the per-plane mask analysis proves every output
byte depends on all 8 index bits non-decomposably. There is no formula to
state. Evidence: sections 4B and 4C.

## 6. Path B viability: NOT_VIABLE

- As specified (T_hi[16]/T_lo[16] + simple combine): no decomposition exists
  for any candidate combine op (xor/add/sub/or/per-lane add). Section 4B.
- Generalized register-permute lookup: the full table is 256 bytes = 64
  32-bit registers of source data. v_perm_b32 addresses only 8 source bytes
  per op; dynamically selecting across 64 registers requires multi-stage mux
  trees costing far more ALU ops and chain depth than the current single
  L1-resident global load that Phase-4A measured as storage-cheap already.
- Per-plane shortcut (each plane takes only 8 distinct VALUES): dead, because
  the selector would need to be computed from all 8 index bits (section 4B),
  which is itself a 256-entry problem.
- The existing get_int_from_table_16 pattern works because IQ4_NL/MXFP4
  tables are 16 ENTRIES x 1 BYTE. iq3xxs_grid is 256 entries x 4 bytes:
  128x the data volume per lookup, outside what permutes can address.

## 7. Bit-exactness precondition

Moot for both paths: neither is viable, so nothing will be integrated and no
NUMERICAL_PATH_CHANGED flag applies.

For the record, the acceptance condition had a path been viable would be:
replacement F satisfies F(i) == iq3xxs_grid[i] for all 256 i (exact u32
equality, checkable exhaustively as done in analyze_grid.py), substituted
only at vecdotq.cuh:1167; sign handling (1168-1176), dp4a accumulation
(1180-1181), and scale order (1184-1187) untouched.

## 8. Recommendation

Pursue neither A nor B. Fall back to:

- Path C (VDR / trip reduction): fewer redundant grid lookups per thread -
  directly shortens the dependent chain identified by Phase-4A.
- Path D (software pipelining): overlap the gather/sign/dp4a stages of
  iteration l0 with loads/compute of l0+2, since grid gathers for different
  l0 are independent (distinct q3 bytes); this attacks chain latency without
  touching numerics.

One structural observation worth archiving (NOT recommended for integration):
because every byte comes from the 8-symbol alphabet, an entry could be stored
as a 12-bit quad of 3-bit symbol ids (u16[256] = 512 B or 384 B packed).
Expansion after the gather needs an affine step plus an s==7 fixup
(62 breaks the otherwise exact byte = 8*s+4 relation), adding several VALU
ops INTO the critical chain while Phase-4A proved footprint was never the
bottleneck. Strictly worse than status quo; recorded only to close the branch.

## 9. Artifacts

- experiments/phase4grid/iq3xxs_grid_values.txt - all 256 values, verbatim
  from ggml-common.h (index, hex, dec, per-plane bytes).
- experiments/phase4grid/analyze_grid.py - standalone read-only analyzer:
  parses the header, verifies count/uniqueness, runs symmetry, nibble
  decomposition, bit-mask dependence, arithmetic-structure, and lineage tests.
- Source excerpts referenced:
  - ggml/src/ggml-common.h:407-411 (block_iq3_xxs)
  - ggml/src/ggml-common.h:1017-1050 (iq3xxs_grid)
  - ggml/src/ggml-common.h:472-502 (GGML_TABLE_BEGIN backend variants)
  - ggml/src/ggml-cuda/vecdotq.cuh:34-95 (get_int_from_table_16)
  - ggml/src/ggml-cuda/vecdotq.cuh:97-104 (unpack_ksigns)
  - ggml/src/ggml-cuda/vecdotq.cuh:1152-1188 (vec_dot_iq3_xxs_q8_1)
