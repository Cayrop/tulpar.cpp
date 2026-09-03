# IQ3XXS_GRID VALUE ANALYSIS

Analysis only. No code changes.

## 1. LOCATE THE TABLE

- File/line: `ggml/src/ggml-common.h:1017`
- Declaration: `GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)`
- Expansion per backend (macro branches at `ggml-common.h:470-501`):
  - C/C++ (CPU, SYCL): `static const uint32_t iq3xxs_grid[256] = { ... }`
  - CUDA/HIP/MUSA: `static const __device__ uint32_t iq3xxs_grid[256] = { ... }`
  - Metal: `static const constant uint32_t iq3xxs_grid[256] = { ... }`
- Array size: 256 (uint32_t each)
- IMPORTANT: each uint32_t is NOT a single scalar value. It packs 4 magnitude
  bytes (little-endian, one per weight). Usage examples:
  - CPU vecdot: `const uint8_t * grid1 = (const uint8_t *)(iq3xxs_grid + q3[2*l+0]);`
    then `grid1[j] * q8[j]` for j = 0..3 (`ggml-cpu/quants.c:1077`)
  - CUDA: `const int2 grid_pos = make_int2(iq3xxs_grid[q3[...]], iq3xxs_grid[q3[...]]);`
    (`ggml-cuda/vecdotq.cuh:1167`)
  - AVX2 loads 8 rows as 8 x uint32 into a `__m256i` of bytes
    (`ggml-cpu/arch/x86/quants.c:3290`)
- The 8-bit index `q3[...]` is produced by the quantizer
  (`ggml-quants.c:4139`), a grid index into a 256-point VQ codebook built at
  runtime from `kgrid_256[256]` (`ggml-quants.c:3703`, 4 x 3-bit levels packed
  per uint16).

## 2. EXTRACTED VALUES

Saved to `experiments/phase_v2_trace/iq3xxs_grid_values.json`.

- 256 x uint32_t rows, values 0x04040404 .. 0x3e341c04
  (min 0x04040404 = 67372036, max 0x3e341c04 = 1043602436)
- All 256 rows unique (unique_count = 256)
- Byte decomposition: only 8 distinct byte values occur:
  0x04, 0x0c, 0x14, 0x1c, 0x24, 0x2c, 0x34, 0x3e  (= 4, 12, 20, 28, 36, 44, 52, 62)
- Byte histogram over all 1024 bytes:
  4: 231, 12: 161, 20: 175, 28: 127, 36: 99, 44: 92, 52: 55, 62: 84
- Cross-check vs runtime quantizer codebook: for EVERY byte in the table,
  static_byte = 4 * (2*l+1) for l = 0..6, and static_byte = 62 for l = 7,
  where l is the 3-bit level of the corresponding `kgrid_256` entry.
  Verified: the 4 levels decoded from each static row exactly equal the
  levels of `kgrid_256[i]` for all i (codebook identity confirmed).

## 3. PATTERN ANALYSIS

### 3.1 Symmetry: FAIL

- `grid[i] == -grid[255-i]`: FAIL. All 256 entries are strictly positive
  uint32 (min 0x04040404 > 0), so no negation identity can hold.
- `grid[i] == -grid[128+i]`: FAIL, same reason.
- Byte-level complement `byte_i + byte_{255-i} == const` per position: FAIL
  for all 4 byte positions (e.g. row 0 bytes {4,4,4,4} vs row 255 bytes
  {4,36,52,62}: sums {8,40,56,66}, not constant).
- The table is NOT symmetric around zero. Sign is not part of the table:
  each element sign is stored separately as a 7-bit nibble per 8 elements
  (`ksigns_iq2xs`, `aux32` scale+sign words).

### 3.2 Sign-Magnitude Structure: PARTIAL (sign separate, magnitude in table)

- No index bit encodes sign: all values positive, no zero entries, so no
  candidate sign bit (MSB, bit 0, or any other split) can satisfy
  `value(i) == -value(i ^ signbit)`.
- Magnitude IS sign-magnitude factored, but one level up:
  row(i) = 4 packed bytes, byte_j = 4 * (2*l_j + 1) for l_j < 7,
  byte_j = 62 for l_j = 7. The 3-bit level l_j carries the magnitude; the
  byte is a near-arithmetic expansion of it.
- Direct-product test (does byte position j depend only on 3-bit window
  [3j .. 3j+2] of the index i?): FAIL for all 4 positions. The index is an
  arbitrary codebook label, not a bit split.

### 3.3 Arithmetic Relationship: FAIL (no f(index) reproduces the table)

Fits against index i (0..255), target = table entry:

| candidate    | max_error     | mean_error    |
|--------------|---------------|---------------|
| byte0(i), linear   | 38.9          | 15.3          |
| byte0(i), quadratic | 39.5        | 15.3          |
| byte0(i), piecewise linear (4 segments) | 44.2 | n/a |
| u32 row, linear    | 1.88e+08      | 6.11e+07      |
| u32 row, quadratic | 1.09e+08      | 3.35e+07      |

Byte range is 4..62, so any max_error above a few units is already
"random-looking". No linear, quadratic, piecewise-linear, or exponential
form of the index reproduces the rows.

The ONLY exact arithmetic relationship found (byte level, given the level):

    byte(l) = 8*l + 4   for l in 0..6
    byte(l) = 62        for l = 7

i.e. byte = (2*l+1) * 4, except the top level 15 is dequantized as 15.5
(62/4) instead of 15. This +2 bump on the top level is deliberate and
cannot be absorbed into 8*l+4.

### 3.4 Unique Values and Distribution

- Unique uint32 rows: 256 / 256 (all distinct).
- Value range (u32): [0x04040404, 0x3e341c04].
- Byte values: 8 unique, clustered into 8 levels {4, 12, 20, 28, 36, 44, 52,
  62}; spacing 8 except last gap 10 (52 -> 62).
- Effective dequant levels (byte / 4, see scaling below):
  {1, 3, 5, 7, 9, 11, 13, 15.5}
- Byte histogram: 4: 231, 12: 161, 20: 175, 28: 127, 36: 99, 44: 92,
  52: 55, 62: 84 (over 1024 bytes). Level 7 (byte 62) occurs in 83 of 256 rows.

### 3.5 Bit-Level Pattern

- Each row decodes to a 12-bit codeword (4 x 3-bit levels). The 256
  codewords are the sorted VQ codebook `kgrid_256`:
  - strictly increasing (table is in ascending codeword order)
  - cover 256 of 4096 possible 4x3-bit tuples (6.25%), range [0, 3992]
  - NOT a GF(2)-linear code (xor of two rows is not in general a row)
  - NOT a Gray-code sequence (adjacent rows differ in multiple bits)
  - no level l_j equals any 3-bit window of the index (no don't-care bits,
    no direct bit mapping)
- Bit 1 and bit 0 of each byte: bit 0 is always 0; bit 1 is always 1
  (because byte = 4*(odd) for l < 7). Bits 2..7 carry the level.
- The x4 byte scaling (bytes are multiples of 4, bit 1..0 fixed pattern)
  exists so the 15.5 top level is exactly representable: 15.5 * 4 = 62.

### 3.6 Block Structure (32-element groups)

- Usage is per-element: each 32-element group (ib32) has 8 independent
  8-bit indices `q3[0..7]`; each index selects a row = magnitudes for 4
  consecutive elements. Indices are chosen independently by the quantizer,
  so intra-block indices are uncorrelated.
- The table itself has no sub-structure (no 4 x 64 grouping, no complement
  symmetry, no direct product). It is a flat 256-row codebook.
- Table size: 1024 bytes. It fits easily in L1 (CPU) / __device__ L1 (CUDA);
  the CUDA MMQ path already pre-loads selected rows into shared memory
  (LDS) per tile (`ggml-cuda/mmq-load-tiles.cuh:1323`).

### Scaling (context for "value" interpretation)

All vecdot paths multiply by 0.25 (or use (ls*d + d/2)/2 on CUDA) and the
block decode is (2*ls+1)/4 * d, so the effective weight level is byte/4 =
{1, 3, 5, 7, 9, 11, 13, 15.5}. The row-dequant paths
(`dequantize_row_iq3_xxs`, CUDA `dequantize_iq3_xxs`) use the same
(2*ls+1)/4 * d * byte formula and are consistent. Note the quantizer's
internal search uses levels {1..15} (`2*l+1`, `ggml-quants.c:4063`) while the
dequant returns 15.5 for the top level: a deliberate small asymmetry.

## 4. VERDICT

    GRID_PATTERN: NO_PATTERN
    LOOKUP_REMOVABLE: NO
    DEQUANT_FORMULA: none at index level; byte level only:
                     byte(l) = (l == 7) ? 62 : 8*l + 4
    EXPECTED_IMPACT: removing the table is not possible and would be a loss

Rationale:

- The 8-bit index is an arbitrary VQ codebook label into a 256-point
  subset of a 4x3-bit lattice. No arithmetic, bit-split, symmetry, or
  Gray-code structure maps index -> row. The lookup IS the codebook.
- The only removable arithmetic is the byte expansion (3-bit level -> byte),
  but the 12 bits of level data per row must be stored anyway. The table is
  exactly that 12-bit codebook, inflated 4x per byte so that (a) the 15.5
  top level is exact (62 = 4 * 15.5) and (b) rows align to SIMD registers
  (4 x uint8 per uint32, direct byte loads into __m256i / int2 / vuint32m2).

If the table were (hypothetically) replaced by arithmetic:

- Store compressed 12-bit codewords: 1024 B -> 384 B (table 2.67x smaller).
- Cost per row at dequant: 4 x (extract 3 bits + shift + add + compare for
  the l == 7 special case) ~ 12-16 VALU ops vs 1 table load + 0 ALU today.
- Net: MORE VALU, WORSE SIMD alignment (loses the clean 4-byte-per-row
  packing that AVX2/NEON/RISC-V/CUDA all rely on). Not a win.

Most promising optimization paths instead (no table removal):

1. Table is 1 KB and already L1/constant-resident on all backends; on CUDA
   MMQ it is already pre-loaded into shared memory (LDS) per tile
   (`mmq-load-tiles.cuh`), which is the right pattern. Keep it.
2. The one structural irregularity is the 62 special case. If the top
   dequant level were 15 (byte 60) instead of 15.5, every byte would be
   exactly (2*l+1) * 4 and expansion would be a pure shift+add with no
   compare. That changes model numerics (PPL), so it is a format change,
   not a free optimization.
3. Sign handling is already cheap (7-bit nibble -> 128-entry ksigns LUT,
   or the __vsub4 XOR trick on CUDA); no precompute gain left there.

## 5. OUTPUTS

- experiments/phase_v2_trace/iq3xxs_grid_values.json (256 values + stats)
- experiments/phase_v2_trace/iq3xxs_grid_analysis.md (this file)

## Related: consolidated deep dive

For the S-tier, hallucination-resistant synthesis (verified RDNA3 LDS bank
model, D4-256 distortion experiment, corrected DP4A/maddubs contract,
corrected bank-conflict numbers, CPU profiling on Zen 3, devil's-advocate
self-refutation), see:

- experiments/phase_v2_trace/iq3xxs_grid_deep_dive.md
- experiments/phase_v2_trace/lloyd_iq3xxs.py (distortion experiment)
- experiments/phase_v2_trace/lloyd_iq3xxs.py.out (distortion results)
- experiments/phase_v2_trace/microbench_iq3xxs.c (CPU microbench)
- experiments/phase_v2_trace/mmq_analysis/isa_analysis.md (hot-loop ISA mix)

GRID_ANALYSIS_OK
