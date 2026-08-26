# Phase-2 Implementation: Fused q4_0 Flash Attention Tile (PATH A)

Date: 2026-08-26 (+03). Branch `phase-2-staging-elimination` @ baseline 091aec112.

## Path selection

PATH A chosen (fused dequantization inside the tile kernel); PATH B rejected.

Decision math against task section 4:

- PATH B VRAM cost: an F16 shadow of the full K/V cache at 135168 tokens is
  2.36 GiB on top of the existing q4_0 cache. Untraced OFF peaks were already
  13.30-13.33 GiB (Phase-1 sec 1); adding 2.36 GiB lands at ~15.66 GiB,
  above the hard 15.5 GiB guard. Per the task's own criterion this forces
  PATH A.
- PATH A numerics: the fused loader reproduces the exact arithmetic of the
  staging kernel (`dequantize_block_q4_0` in ggml-cuda/convert.cu):
  per element, fp32 `d * nibble + (-8*d)` rounded once to half via
  `ggml_cuda_cast<half>`. The values written into shared memory are therefore
  bit-identical to what staging produced; every downstream op sees identical
  inputs in identical order. Expected drift: 0.0 (token-identical outputs).
- PATH A scope control: fused variants are instantiated ONLY for DKQ == DV ==
  256 (the RDNA3 tile-dispatch case from HEAD). All other head sizes and all
  mixed K/V type combos keep the staged path unchanged.

## What changed

Three files under `ggml/src/ggml-cuda/`:

1. `fattn-common.cuh`
   - New predicate `ggml_cuda_fattn_tile_fuses_quantized_kv(dst)`: true iff
     K/V head width is 256, both types are q4_0, block-strided layout is dense
     (nb0 == sizeof(block_q4_0), nb1 % 18 == 0) and fast fp16 is available.
     Single source of truth used by BOTH alloc sizing and launch so the
     persistent f16_extra buffer decision can never diverge from the kernels
     actually launched.

2. `fattn-tile.cuh`
   - New device function `flash_attn_tile_load_tile_q4_0`: warp-cooperative
     twin of `flash_attn_tile_load_tile` with identical loop skeleton, shared
     memory layout and OOB zero-fill semantics. Instead of copying half2 it
     reads q4_0 blocks (18 B per 32 dims, planar nibbles: low plane = dims
     0..15, high plane = dims 16..31 of each block) and writes the same
     half2 tile the F16 loader would produce. One thread chunk (16 B out =
     8 dims) always stays inside one block and one nibble plane; two int
     loads with alignment 2 handle the 18 B block stride misalignment.
   - `flash_attn_tile_iter_KQ`, `flash_attn_tile_iter`, `flash_attn_tile`
     gain a `ggml_type type_KV` template parameter placed before the deduced
     typename parameters. Under `if constexpr (type_KV == GGML_TYPE_Q4_0)`
     they call the q4_0 loader with byte strides; otherwise the original
     half2 path compiles exactly as before.
   - Kernel strides: `stride_K2/stride_V2` are computed as row-bytes divided
     by the per-type unit (18 B blocks vs 4 B half2).
   - `launch_fattn_tile_switch_ncols1/2` pass `type_KV` through and set
     `need_f16_K/need_f16_V = (type_KV == GGML_TYPE_F16)` so `launch_fattn`
     skips whole-cache staging when fused.
   - `ggml_cuda_flash_attn_ext_tile_case` dispatches under
     `if constexpr (DKQ == 256 && DV == 256)` to a Q4_0 instantiation when
     the predicate holds; everything else falls through to the F16-typed
     (staged) instantiations. Compile-time guard keeps the Q4_0 template
     tree limited to the one (256,256) case.

3. `fattn.cu`
   - `ggml_cuda_flash_attn_ext_get_alloc_size`: TILE case now requests no
     f16 extra space when the predicate holds (was unconditional true/true).

No changes to: model loading, KV cache quantization, graph capture, vec/MMA
FA paths, CPU backend, non-q4_0 KV types, mixed K/V types (they keep full
staging), MTP/speculative logic.

## Why results are bit-exact by construction

Staged path today: global q4_0 -> `dequantize_block_q4_0` -> persistent F16
buffer -> tile kernel loads half2 tiles from that buffer into shared memory.

Fused path: tile kernel loads the same half2 VALUES into shared memory,
computing each element with the identical expression
`ggml_cuda_cast<half>(d * n + dm)` (fp32 d, dm = -8*d, n = raw nibble).
Identical input bits + identical downstream instruction sequence => identical
KQ, softmax and VKQ results. Verified empirically: greedy generations are
character-exact against stored baseline heads and degeneration metrics match
to all recorded digits (see phase2_correctness.json).

## Build

    cmake --build build-p3 --target llama-server      # HIP, GPU_TARGETS=gfx1101
    # artifact chain: build-p3/bin/llama-server + libggml-hip.so.0.21.0 (rebuilt)

Pre-gate validation: `test-backend-ops -o FLASH_ATTN_EXT -p "q4_0"` ->
354/354 OK; full `-o FLASH_ATTN_EXT` -> 3951/3951 OK on ROCm0 (covers fused
256/q4_0/q4_0 decode shapes incl. those added at HEAD, plus every staged and
F16 path as regression net).

## Diff summary

    ggml/src/ggml-cuda/fattn-common.cuh |  15 +++
    ggml/src/ggml-cuda/fattn-tile.cuh   | 194 ++++++++++++++++------
    ggml/src/ggml-cuda/fattn.cu         |   6 ++
    3 files changed, 174 insertions(+), 41 deletions(-)
