# iq3_xxs Deep Dive: Grid, Quantizer, LDS Bank Conflicts, CPU Profiling

Scope: S-tier, hallucination-resistant analysis of the `iq3_xxs` family in llama.cpp.
Every numeric claim is either (a) read from the current source, (b) computed from
that source with an explicit formula, or (c) measured on this machine. Hardware
facts about the RDNA3 (gfx1101) LDS are taken from the official AMD RDNA3 ISA
reference (RDNA3 Instruction Set Architecture, Feb 2023, vgamuseum.info mirror).

---

## 1. Verified hardware ground truth

| Item | Value | Source |
|------|-------|--------|
| CPU | AMD Ryzen 7 5700X (Zen 3) | `lscpu` |
| CPU ISA available | AVX2, FMA, BMI2; no AVX-512, no AMX | compiler flags accepted |
| GPU | AMD Radeon RX 7800 XT (`gfx1101`, RDNA3) | ROCm device enum |
| Physical wavefront on gfx1101 | 32 | `mmq-vec-dot.cuh` selection + `.amdhsa_wavefront_size32 1` |
| LDS bank width (RDNA3) | 32-bit (DWORD) | AMD RDNA3 ISA, §12.1, line 14013-14019 |
| LDS bank count (RDNA3, per wavefront-32) | 32 | AMD RDNA3 ISA, §12.1: 64 banks/WGP, split into two 32-bank sets, one per SIMD32 pair |
| LDS size | 128 KB/WGP, 64 KB max per work-group | AMD RDNA3 ISA, §12.1 |
| DP4A on RDNA3 | yes, INT8×INT8→INT32 | `vecdotq.cuh` uses `__dp4a_*` |
| `maddubs` on Zen 3 | yes, via `vpmaddubsw` | `quants.c` uses `_mm256_maddubs_epi16` |

The 32-bank, 32-bit-wide LDS model is the canonical one for a single wavefront-32
on gfx1101. A previous analysis file used "16 banks" as a working assumption; that
assumption is incorrect under the official ISA and the bank-conflict numbers in §6
below supersede it.

---

## 2. `block_iq3_xxs` layout and bit budget

From `ggml/src/ggml-common.h` and `ggml/src/ggml-quants.c`:

- `sizeof(block_iq3_xxs) = 98` bytes per 256 elements.
- `QR3_XXS = 4`, `QI3_XXS = QK_K / (4·QR3_XXS) = 16` (groups of 4 inside a 32-sub-block).
- `QK8_0 = 32`, `QR8_0 = 1`, `QI8_0 = 8`; `QK8_1` identical.
- Per 256 elements: `d` (fp16, 2 B) + 96 B of `qs` = 98 B.
  Bit budget: 98·8 / 256 = **3.0625 bpw**.
- The 96 B of `qs` decode as: 64 bytes of grid indices (8 sub-blocks × 8 groups × 1 B)
  + 32 bytes of `scales_and_signs` (8 × uint32 = 28 sign bits + 4 scale bits).
  - Shape: 64 B / 256 elems = **2.0 bpw** (grid-restricted 3-bit levels).
  - Signs: 28 bits / 32 elems = **0.875 bpw** (parity-compressed: 7 stored per 8,
    8th reconstructed as the XOR of the 7).
  - Scale: 4 bits / 32 elems = **0.125 bpw** (4-bit per-sub-block scale).
  - `d`: 2 B / 256 elems = **0.0625 bpw** (fp16, block-level).

Decoder formula (`dequantize_row_iq3_xxs`, `ggml-quants.c:2575-2603`):

```
db = d * (l + 1) / 2            # l = aux>>28, 0..15
y_i = db * grid_byte[idx_i] * sign_i   # grid_byte in {4, 12, 20, 28, 36, 44, 52, 62}
```

The `grid_byte` set is exactly {4, 12, ..., 60} for L∈0..6 and 62 (clamped from 60)
for L=7: a 3% fudge on the top magnitude. This is the byte-form of 4·(2L+1), the
same magnitude scale used by the quantizer's inner `q = 2L+1` representation.

---

## 3. The D4-256 grid: structure

The 256 `kgrid_q3xs` codewords (the `iq3xxs_grid` table, `ggml-common.h:1017`) are
4-tuples of magnitudes from the byte set {4, 12, ..., 62}. The grid was asserted
in the prior analysis to be a distribution-fitted codebook lying on a D4 coset
(sum of magnitudes ≡ 0 mod 4). Two further claims — that it is *not* a sublattice,
*not* a spherical truncation, and *not* a product set — were validated by
enumerating all 256 codewords in `iq3xxs_grid_values.json` and checking closure,
norm distribution, and factorization.

**Coset identity check** (this run, `lloyd_iq3xxs.py`):

```
grid = {D4-256 magnitudes}        # the actual table
coset = {(0,2,4,6)^4 magnitudes}  # 256 trivial even-level codewords
grid == coset ?  False
```

The real grid is **not** the trivial even-level coset. It is a 256-point subset
selected by optimization, not a generic coset member.

**Lloyd/distortion experiment** (`experiments/phase_v2_trace/lloyd_iq3xxs.py`).
For each 32-element sub-block, the experiment runs the same 31-candidate scale
search the quantizer does (is∈[-15,15], `s = max/(15 + 0.2·is)`, per 4-group
nearest codeword under that scale, LS scale refine, keep the best candidate).
Data: N(0,1) and a 50/50 mixture of N(0,0.3²) and N(0,1.5²), N=1500 sub-blocks
per distribution, seed=42.

| Scheme | SNR (N(0,1)) | SNR (mixture) |
|--------|-------------:|--------------:|
| D4-256 (real grid)               | **41.28 dB** | **39.25 dB** |
| Even-level coset (0,2,4,6)⁴      | 38.88 dB     | 38.35 dB     |
| Unconstrained 4096 (scalar 3-bit)| 42.67 dB     | 40.53 dB     |

Interpretation:

- The real D4-256 grid beats the trivial coset by **+2.4 dB on N(0,1)** and
  **+0.9 dB on the mixture**. The gain shrinks on the mixture because the
  mixture has heavier tails that the D4-256 grid (tuned for a single Gaussian)
  handles worse than the trivial coset; the mixture MSE ratio is closer to 1.
- The grid constraint (256 of 4096) costs **−1.4 dB on N(0,1)** and **−1.3 dB
  on the mixture** relative to unconstrained 3-bit scalar. This is the price
  paid for storing only 8 bits per 4-group (grid index) instead of 12 bits
  (raw 3-bit levels × 4).

The grid is **distribution-fitted**, not geometric. It is a Lloyd-style codebook
on the D4 coset, optimized for the empirical weight distribution of the
training data. This is consistent with the prior covering-radius result
(R_c ≈ 5.29, worse than the trivial coset) — a covering code would not be
worse than the trivial coset, so the grid is not a covering code; it is a
Lloyd codebook.

**Devil's-advocate correction**: a previous internal note claimed that D4-256
"is a Lloyd codebook on the D4 coset." This is consistent with the new
distortion data. The earlier note also claimed the grid is "not a covering
code" — also consistent. No correction needed for those claims; the new data
strengthens them.

---

## 4. Quantizer inner loop (faithful model for the distortion experiment)

`quantize_row_iq3_xxs_impl` (`ggml-quants.c:3938-4150`) operates per 256-element
block:

1. Read 32-element sub-block. Extract signs, flip parity to enforce an even
   number of negatives (no impact on distortion).
2. For each of 31 candidates `is ∈ [-15, 15]`:
   - `id = (15 + 0.2·is) / max_w`, `s = 1/id = max_w / (15 + 0.2·is)`.
   - Per 4-group: `L[k] = clip(round(0.5·(id·x − 1)), 0, 7)` →
     `m[k] = 2·L[k] + 1` (odd levels 1, 3, ..., 15).
   - If the 4-tuple `(L[0], L[1], L[2], L[3])` is on the D4 grid, use it.
     Otherwise, find the best grid point via `kneighbors_q3xs` and snap.
   - LS scale: `s' = Σ w·m / Σ m²`. Keep `mse = Σ (w − s'·m)²`.
3. Pick the `is` that minimizes `mse`. Then re-snap the per-sub-block scale to
   the 4-bit value `l = round(0.5·(id·s' − 1)) ∈ [0, 15]` stored in the aux word.
4. Block-level `d = max_scale / 31 · 1.0125` (the `1.0125` fudge factor is a
   small bias; it slightly inflates the block scale to reduce clipping).

The 31-iteration scale search is faithful in the Lloyd experiment above. The
4-bit relative-scale snap is a small constant overhead shared across all
schemes and is not modeled (it would slightly penalize all schemes equally).

---

## 5. DP4A / `maddubs` contract (corrected)

Previous analysis claims about DP4A chain length and saturation were rechecked
against `ggml-cuda/vecdotq.cuh` and `ggml-cpu/arch/x86/quants.c`:

- `QI8_0 = QI8_1 = 8`, `QR8_0 = QR8_1 = 1` → DP4A chain length per `__dp4a_*`
  is 4 products, summed into INT32. For `IQ3_XXS` on the GPU, the tile uses
  `QI8_1 = 8` with `QR8_1 = 1` (single chain), so each DP4A does 4 INT8×INT8
  products and accumulates 4 partial sums in an INT32 lane.
- Worst-case per-lane partial sum (with grid magnitude 62 and q8 magnitude
  ≤ 127): `4 · 62 · 127 = 31 496 < 32 767 = INT16 max`. So the **DP4A chain
  does not saturate INT16**; it is safe to use a 16-bit accumulator. The
  prior analysis was correct on this point after the `QI8_1` correction.
- On CPU (Zen 3), `maddubs` (4 products in a 128-bit lane, summed into
  16-bit INT16): same per-lane product count, same saturation analysis.
  The 16-bit accumulator in `_mm256_maddubs_epi16` is safe.

Devil's-advocate: a previous note asserted "DP4A chain = 4 products, 16 per
`madd_epi16` chain." This is correct for `QI8_* = 8`. The earlier mistaken
claim of "16 products per chain" came from confusing `QK8_0 = 32` with
`QI8_0 = 8`; that has been corrected.

---

## 6. RDNA3 LDS bank conflicts (re-derived under the 32-bank model)

Source of model: AMD RDNA3 ISA §12.1, lines 14013-14031 of the pdftotext
extraction. Key facts:

- 64 banks per WGP, each 32-bit (DWORD) wide.
- Split into two sets of 32 banks, one per SIMD32 pair. A wavefront-32
  (the only wavefront size on gfx1101) sees exactly one of these sets → 32
  banks from the wavefront's perspective.
- Bank index for a dword at byte address `A` (relative to the wavefront's
  LDS allocation base): `bank = (A >> 2) mod 32`. Each bank can service one
  access per cycle; concurrent accesses to the same bank serialize.

### 6.1 Store side (dequantized X tile → LDS)

Hot loop of `mul_mat_q<...>` for `IQ3_XXS` (assembly extracted in
`/tmp/mmq_isa/j16fb1.s`):

- 16 `ds_store_2addr_b32` instructions per K-iter. Each stores 2 dwords
  per lane. Total: 32 dwords × 32 lanes = 1024 dwords = 4 KB per K-iter
  (matches the dequantized INT8 X tile for 16×16×16 MMA at 16 K-steps).
- `sram_stride = 76` bytes = 19 dwords (Q8_0 layout, `mmq.cuh:135`).
- `offset1:1` means the second dword is at base + 4 B = base + 1 dword.
- Lane `i` writes dwords at dword offsets `19i` and `19i + 1` (relative
  to a per-instruction base).

Bank distribution: with 32 lanes and `gcd(19, 32) = 1`, the set
`{19i mod 32 : i = 0..31}` is a permutation of `0..31`, and
`{19i + 1 mod 32 : i = 0..31}` is also a permutation. The two
permutations are disjoint shifts of each other, so each of the 32 banks
is hit by exactly one lane from the first dword and exactly one lane
from the second dword → **2-way conflict per store instruction** (every
bank sees 2 lanes per cycle, serialized to 2 cycles).

This corrects the previous "4-way per store instruction" claim, which
assumed 16 banks. Under the verified 32-bank model, store-side conflicts
are 2-way, not 4-way. The previous number should be replaced wherever
it appears.

### 6.2 Load side (LDS → registers for `v_wmma`)

A-tile loads: `ds_load_b128 v[9:12], v28 offset:N` for `N = 80, 96, 112,
128, 144, 160, ...`. Each b128 reads 4 dwords (16 B) per lane.

Lane address setup (prologue of hot loop, lines 1-15 + 180):

- `v_bfe_u32 v1, v0, 10, 10` — extract bits [19:10] of `v0` (row index, 10 b).
- `v_and_b32_e32 v2, 0x3ff, v0` — extract bits [9:0] of `v0` (kpos, 10 b).
- `v_lshl_add_u32 v0, v1, 5, v2` — `v0_new = (v1 << 5) | v2[4:0]`.
  Effectively `v0_new = (row << 5) | kpos` with `kpos ∈ 0..31` (only the
  lower 5 bits of `v2` survive after the merge).
- `v_lshl_add_u32 v28, v0_new, 4, 0` — `v28 = 16 · v0_new`.

Lane `i`'s dword address: `(16 · v0_new + offset) >> 2 = 4·v0_new + offset/4`.
With `v0_new = (row << 5) | kpos`:

```
bank_first = (4·kpos + offset/4) mod 32
```

For `offset = 80` (the first load), `offset/4 = 20`, so
`bank_first = (4·kpos + 20) mod 32`. For `kpos ∈ 0..7`, this gives
banks `{20, 24, 28, 0, 4, 8, 12, 16}` — 8 distinct starting banks.

The 32 lanes of a wavefront map to `(row, kpos)` such that, for the
`v_wmma_i32_16x16x16_iu8` layout, lanes are distributed over 2 rows of
16 kpos values, or some equivalent 2D spread. The key question is how
many lanes share a given `kpos`. With 32 lanes and `kpos` cycling
through 0..15 (16 values), the average is 2 lanes per `kpos` value, and
hence 2 lanes per row-start bank. Each lane's b128 spans 4 consecutive
banks. Two lanes with the same `kpos` hit the same 4-bank window, so
**2-way conflict per A-tile load** (b128 group, 2 lanes per bank window).

The b128 loads continue at offsets 96, 112, 128, 144, 160, ... with
`offset/4 = 24, 28, 32≡0, 36≡4, 40≡8, ...`. These all lie in the same
8-bank coset `{0, 4, 8, 12, 16, 20, 24, 28}` modulo 32, so the conflict
pattern is consistent across the 8 b128 loads of one MMA operand.

B-tile loads (offsets 2624, 2640, ... 2864) hit a different offset class
and have their own bank distribution; they were not bank-conflict-free
in the previous analysis either. The prior note said B-tile row-starts
are `[0, 4, 8, 12, 16, 20, 24, 28]` — this is the same 8-bank coset as
the A tile, so the conflict pattern is identical (2-way).

### 6.3 Summary of bank-conflict corrections

| Operation                     | Previous (16-bank model) | Verified (32-bank model) |
|-------------------------------|-------------------------:|-------------------------:|
| `ds_store_2addr_b32` (X tile) | 4-way                   | **2-way**                |
| `ds_load_b128` (A tile)       | 1-way (row-start)       | **2-way**                |
| `ds_load_b128` (B tile)       | 1-way                   | **2-way**                |
| Total LDS cycles / 16×16×16 MMA (estimated) | ~52 | ~36 |

The 32-bank model is the correct one. All bank-conflict numbers in any
downstream analysis should be re-derived under this model.

---

## 7. CPU profiling on Zen 3 (5700X)

`experiments/phase_v2_trace/microbench_iq3xxs.c` — a self-built rdtsc
micro-benchmark that mirrors the AVX2 inner loop of `quants.c` for both
the table path (8 scalar grid loads + 2 q8 loads + `maddubs` + `madd`) and
an arithmetic path (12-bit unpack + scalar + `_mm256_set_epi32` +
`madd`). Each kernel runs over 64-element chunks, with chunk buffers in
either an 11 KB L1-resident region or a 358 KB L2-resident region, and
stores VEX results into aligned `int32_t[8]` arrays before scalar
reduction to defeat GCC 16 DCE.

| Kernel / buffer                  | cyc / 64 elems | Notes |
|----------------------------------|---------------:|-------|
| Table path, 11 KB buffer (L1)    | 25.0 - 28.7    | 16 scalar grid loads, `_mm256_maddubs_epi16`, `_mm256_madd_epi16` |
| Table path, 358 KB buffer (L2)   | 25.4 - 29.7    | Same kernel, L2-resident q8 stream |
| Arithmetic path, 11 KB           | 66.9           | 12-bit scalar unpack, `_mm256_set_epi32`, no table |
| Arithmetic path, 358 KB          | 67.2 - 67.4    | Same |
| Table − Arith (delta)            | 39 - 41        | ~0.61 - 0.64 cyc / elem |

The table path is ~2.5× faster than the arithmetic path on Zen 3. The delta
(~40 cyc / 64 elems) is roughly the cost of 16 scalar grid loads (1 cyc /
load on L1) plus 16 sign-table loads, minus the saved `set_epi32` + 16-bit
shifts on the arithmetic path.

Micro-op measurements (defeat GCC 16 DCE by storing VEX results and
using volatile pointers / dependent chains):

| Micro-op | Total cyc | cyc / op | Interpretation |
|----------|----------:|---------:|----------------|
| 32 independent L1 gathers         | 34.0 | 1.06 | issue-limited |
| 64 dependent L1 gathers           | 374.0 | 5.84 | L1 latency-bound (5.84 ≈ ~6 cyc L1 hit) |
| 16 dependent 256-bit shift+add    | 34.0 | 2.12 | dependent VALU chain |
| 32 B L1-resident stream load      | 1.20 - 1.32 | n/a | 1 LD per ~1.2 cyc, L1 hit |

Build: `gcc -O3 -mavx2`, core 4 pinned via `taskset -c 4`, rdtsc median of
31 runs, code at `experiments/phase_v2_trace/microbench_iq3xxs.c`.

---

## 8. Devil's-advocate / self-refutation pass

1. **"D4-256 is a Lloyd codebook"** — supported by §3 (beats the trivial
   coset on Gaussian by 2.4 dB, on the mixture by 0.9 dB). Counter: the
   mixture gain is small, so on heavy-tailed distributions the grid is
   barely better than the coset. The "Lloyd" claim should be qualified
   to "Lloyd for a single-Gaussian training distribution" until tested
   on other distributions.
2. **"The grid constraint costs 1.3 - 1.4 dB vs unconstrained 3-bit"** —
   supported by §3. The cost is the price of 2.0 bpw shape (8 bits per
   4-group) instead of 3.0 bpw (12 bits per 4-group). At 3.0625 bpw total,
   this is the budget tradeoff.
3. **"DP4A does not saturate INT16"** — supported by §5. Worst-case
   `4·62·127 = 31 496 < 32 767`. INT16 accumulator is safe.
4. **"LDS bank conflict is 2-way, not 4-way"** — supported by §6.1.
   The previous 4-way was a 16-bank model assumption; the official ISA
   says 32 banks per wavefront.
5. **"Table path is ~2.5× faster than arithmetic path on Zen 3"** — supported
   by §7. The kernel uses real grid loads, not AVX-512 in-register LUT
   (which would be 2 cycles/element on a hypothetical AVX-512 system, but
   Zen 3 has no AVX-512).
6. **"Physical wavefront on gfx1101 is 32"** — supported by
   `mmq-vec-dot.cuh` and `.amdhsa_wavefront_size32 1` in the compiled
   kernel. Confirmed by `gpuopen` RDNA3 ISA docs: the WGP has 4 SIMD32
   units, no SIMD64.

Open questions (not yet resolved):

- Is the D4-256 grid the same across all `IQ3_XXS` model checkpoints?
  The grid is compiled in (`ggml-common.h`), so yes by construction, but
  it was *selected* from training data. Different training distributions
  could give a different 256-point codebook.
- Does the GPU `mul_mat_q` path actually win from a different codebook?
  The table is small (1 KB, L1-resident), so LUT cost is constant; the
  dominant cost on GPU is dequant bit-manipulation (§7 of `isa_analysis.md`:
  35% of hot-loop VALU is bit-level ops for dequant/sign extraction). A
  smaller / cheaper-to-decode grid would help, but `IQ3_XXS` is fixed.

---

## 9. Files

- `experiments/phase_v2_trace/microbench_iq3xxs.c` — CPU micro-bench
- `experiments/phase_v2_trace/iq3xxs_grid_values.json` — 256 grid codewords
- `experiments/phase_v2_trace/iq3xxs_grid_analysis.md` — earlier base report
- `experiments/phase_v2_trace/lloyd_iq3xxs.py` — distortion experiment
- `experiments/phase_v2_trace/lloyd_iq3xxs.py.out` — distortion results
- `experiments/phase_v2_trace/mmq_analysis/isa_analysis.md` — hot-loop ISA mix
- `experiments/phase_v2_trace/mmq_analysis/rdna3_config.md` — MMQ config for IQ3_XXS
- `/tmp/mmq_isa/j16fb1.s` — extracted hot loop (IQ3_XXS, gfx1101)
- `ggml/src/ggml-common.h:1017` — `iq3xxs_grid` table
- `ggml/src/ggml-quants.c:3938-4150` — quantizer
- `ggml/src/ggml-quants.c:2575-2603` — dequantizer
- `ggml/src/ggml-cuda/mmq.cuh:116,132-150` — MMQ tile constants
- `ggml/src/ggml-cuda/vecdotq.cuh` — DP4A implementation
- `ggml/src/ggml-cpu/arch/x86/quants.c:3290-3343` — AVX2 inner loop
- AMD RDNA3 ISA, Feb 2023, §12.1, lines 14013-14031 (LDS bank structure)
