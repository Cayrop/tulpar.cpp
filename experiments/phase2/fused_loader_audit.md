# Fused q4_0 Tile Loader Audit (commit 2e033a696)

Scope: line-level review of fattn-tile.cuh, fattn-common.cuh, fattn.cu
as changed by 2e033a696 ("eliminate staging dequant for q4_0 KV cache").
Reviewer request: nibble order, signed conversion order, K/V strides,
planar layout, block boundary, last partial block/padding, non-contiguous
nb[] handling, dispatch scope.

## 1. Reference arithmetic

Reference staged value (dequantize_block_q4_0 -> F16 buffer):
    half( (n - 8) * d ),  n in [0,15], d = half->float.

Fused value (fattn-tile.cuh, flash_attn_tile_load_tile_q4_0):
    half( d * n + (-8.0f * d) )

Equivalence proof:
- d is a half promoted to float: 11-bit significand, exact in fp32.
- (n-8)*d: n-8 is an exact integer in [-8, 7]; the product needs at most
  11+4 = 15 significant bits with no cancellation, and its binade stays far
  inside the fp32 normal range for any finite half d, so the product is
  exactly representable in fp32.
- t1 = d*n is exact for the same reason. t2 = 8*d only shifts the exponent
  (power-of-two scaling changes no significand bits), so dm = -t2 is exact.
- t1 + dm: both operands are integer multiples of the same value d with
  small integer coefficients, so their exact sum is (n-8)*d. That sum is the
  representable value shown above; IEEE 754 round-to-nearest addition
  returns the exact result whenever the true sum is representable, and
  exponent alignment here cannot drop significand bits because both
  addends carry the same factor d. Hence the fp32 sum equals (n-8)*d
  exactly, with no intermediate rounding anywhere in the chain.
- Staged and fused therefore feed bit-identical fp32 inputs into the single
  final half conversion (ggml_cuda_cast<half> / __float2half, RN).
Conclusion: bit-exact vs staged path. VERIFIED.

## 2. Nibble order and plane mapping

Per chunk (out[t], t in [0, 2*cpy_ne)):
- byte index used = (db % 16) + t  (v0 covers first cpy_ne bytes, v1 next)
- shift = 8*(t % cpy_ne) + (hi ? 4 : 0), hi = (db >= QK4_0/2) constant
Expected reference mapping for element e = db + t:
- byte = e % 16, low nibble if e < 16 else high nibble.
These agree iff the chunk never straddles the low/high planes, i.e.
(db % 16) + 2*cpy_ne <= QK4_0/2 for every chunk start db.

Alignment invariant check (gfx1101, all instantiations):
- cpy_ne = ggml_cuda_get_max_cpy_bytes()/4 = 4 -> chunk = 8 elements.
- j advances in units of cpy_ne => 2*j is a multiple of 8 =>
  dim_b = dim0 + 2*j preserves dim0 mod 8.
- K-side dim0 = k_KQ_0, a multiple of nbatch_K. For DKQ=DV=256 on RDNA3 the
  config table gives nbatch_K in {64, 256, 128} (all multiples of 16).
  DKQ % nbatch_K == 0 for these values => no partial K-tail batch exists.
- Therefore db % 16 in {0, 8} and (db % 16) + 8 <= 16 holds. No plane
  crossing. VERIFIED.
- V-side dim0 = 0 always; same argument. VERIFIED.

LATENT NOTE (not a bug today): the loader has no static_assert capturing this
invariant. If a future config table entry introduced an odd-multiple-of-2
nbatch_K, or a target with max copy bytes 4 made cpy_ne == 1 (chunk = 2),
chunks starting at db % 16 == 14 would silently cross planes. Suggested
hardening (requires separate approved kernel change):
static_assert(nbatch_K % (QK4_0/4) == 0) in flash_attn_tile_iter_KQ, or an
equivalent comment contract on the config table.

## 3. Block addressing and strides

- blk = row_base + (dim_b / QK4_0) * sizeof(block_q4_0); row_base =
  KV + (row0 + i) * stride_bytes where stride_bytes = stride_K2 *
  sizeof(block_q4_0) and stride_K2 = nb11 / kv_unit. With kv_unit =
  sizeof(block_q4_0), stride_bytes reconstructs nb11 exactly. VERIFIED.
- Predicate (fattn-common.cuh ggml_cuda_fattn_tile_fuses_quantized_kv)
  enforces the "block-dense" precondition: nb[0] == sizeof(block_q4_0) and
  nb[1] % sizeof(block_q4_0) == 0 for both K and V. Non-dense rows cannot
  reach the fused loader. VERIFIED.
- ne[0] == 256 == 8 full blocks => no partial trailing block inside a head
  row; the qs window can only run past qs[15] if a chunk crossed planes,
  which section 2 excludes. VERIFIED.
- nb[2]/nb[3] (token/sequence strides) are untouched by the fused path;
  kernel iterates tokens through the same stride math as the F16 twin.
  Behavior equal to pre-change staging path. VERIFIED (no change).

## 4. Out-of-bounds and padding

- oob_check=true tail iteration: zero-fill branch writes make_half2(0,0)
  over the same [cpy_ne]-half2 footprint the F16 loader uses; SRAM layout,
  J_padding (=cpy_ne for K, 0 for V), and nbytes_shared unchanged. Matches
  staged-path zero semantics. VERIFIED.
- i_sup semantics copied verbatim from F16 loader call sites
  (k_VKQ_sup, and k_VKQ_sup - k0 for the V sub-tile loop). VERIFIED.

## 5. Dispatch scope

- Template gate: fused instantiation only under
  `if constexpr (DKQ == 256 && DV == 256)` inside
  ggml_cuda_flash_attn_ext_tile_case, then runtime predicate:
  K->ne[0]==256 && V->ne[0]==256 && both GGML_TYPE_Q4_0 && block-dense &&
  fast_fp16_available(cc). Mixed K/V types, non-256 heads, sparse layouts
  fall through to the legacy staging switch_ncols2 default (type_KV=F16).
  VERIFIED.
- logit_softcap split replicated identically for the fused pair. VERIFIED.
- Alloc sizing vs launch sync: fattn.cu BEST_FATTN_KERNEL_TILE case consults
  the SAME predicate before requesting F16 staging; launch_fattn receives
  need_f16_K/V = (type_KV == GGML_TYPE_F16). When fused, K_data/V_data keep
  the original quantized pointers and strides (verified in
  fattn-common.cuh launch flow); no third staging site exists. VERIFIED.
- stream_k remains false; occupancy/nthreads from the unchanged config
  table; shared memory budget identical (same tile footprint). VERIFIED.

## 6. Residual items reviewer could not close without hardware

- On-device evidence (phase2 records): deterministic greedy outputs
  character-exact vs baseline in MTP ON/OFF; dequantize_block_q4_0 launch
  count drops to zero during decode. Consistent with sections 1-5.
- Not covered by static review alone: cross-adapter behavior on non-RDNA3
  targets (fused path compiles wherever fast_fp16_available && tile selected
  && 256-head q4_0 KV; only tested here on gfx1101).

VERDICT: no indexing, dispatch, stride, or rounding defect found. Two
hardening suggestions: (a) capture the no-plane-crossing invariant with a
static_assert or contract comment; (b) consider extending test coverage for
mixed batch shapes at 131k boundary (oob tail with gridDim.y > 1).
