# RDNA3 (gfx1101) MMQ Config for IQ3_XXS

## File
`ggml/src/ggml-cuda/mmq-config-rdna3.cuh`

## Constants (from mmq.cuh)
- `MMQ_TILE_NE_K = 32` (K element count per sub-tile)
- `MMQ_ITER_K = 256` (K elements loaded per outer K iteration)
- `MMQ_NWARPS = 8` (default, but templates use 4 warps for IQ3_XXS J<=32)
- `MMQ_WARP_SIZE = 32` (RDNA3 native)

## Active CASE for IQ3_XXS

`mmq-config-rdna3.cuh:209-220` enumerates 12 valid (J, fallback) combinations
for IQ3_XXS. The on-device active variant (J=16, fallback=true) at
line 211:

```
CASE(GGML_TYPE_IQ3_XXS, 128, 2,  64,  16, GGML_CUDA_MMQ_SRAM_LAYOUT_Q8_0, MMQ_ITER_K, false, true);
```

Expands to (mmq.cuh:206-214):
- `type          = GGML_TYPE_IQ3_XXS`
- `nthreads      = 128`
- `occupancy     = 2`
- `I             = 64`
- `J             = 16`
- `sram_layout   = GGML_CUDA_MMQ_SRAM_LAYOUT_Q8_0`
- `K_vram        = 256` (MMQ_ITER_K)
- `stream_k      = false`
- `fallback      = true`

## Full IQ3_XXS CASE table (RDNA3)

| J   | fallback | nthreads | I   | J  | nwarps | wsize |
|-----|----------|----------|-----|----|--------|-------|
| 16  | true     | 128      | 64  | 16 | 4      | 32    |
| 32  | true     | 128      | 64  | 32 | 4      | 32    |
| 64  | true     | 256      | 128 | 64 | 8      | 32    |
| 128 | true     | 256      | 128 | 128| 8      | 32    |
| 16  | false    | 128      | 64  | 16 | 4      | 32    |
| 32  | false    | 128      | 64  | 32 | 4      | 32    |
| 48  | false    | 256      | 128 | 48 | 8      | 32    |
| 64  | false    | 256      | 128 | 64 | 8      | 32    |
| 80  | false    | 256      | 128 | 80 | 8      | 32    |
| 96  | false    | 256      | 128 | 96 | 8      | 32    |
| 112 | false    | 256      | 128 | 112| 8      | 32    |
| 128 | false    | 256      | 128 | 128| 8      | 32    |

(J=8 cases are missing for IQ3_XXS; J=8 + fb=true is a no_device_code stub.
J=24 cases are also no_device_code stubs since IQ3_XXS does not have a
J=24 CASE in the RDNA3 config.)

## SRAM Layout (Q8_0)

From `ggml_cuda_mmq_get_sram_stride` (mmq.cuh:132-150):
```
Sram_layout Q8_0 stride = 2*MMQ_TILE_NE_K + 2*MMQ_TILE_NE_K/QI8_0 + 4
                       = 2*32 + 2*32/8 + 4
                       = 64 + 8 + 4
                       = 76  (in 4-byte elements)
```

## LDS usage per block (J=16, fallback=true)

`ggml_cuda_mmq_get_nbytes_shared_x` (mmq.cuh:415-421) for `use_mma_data_layout()`:
```
nbytes_x = I * sram_stride * 4 = 64 * 76 * 4 = 19,456 bytes
```

Plus the Y tile and `ids_dst_shared` from `mul_mat_q_process_tile` (mmq.cuh:883-886):
- `tile_y` (J ints) = 16 * 4 = 64 bytes
- Y tile padded to nwarps*warp_size ints: `GGML_PAD(J*MMQ_TILE_Y_K, nwarps*warp_size)*4`
  = pad(16*36, 128) * 4 = 128 * 4 = 512 bytes
- `tile_x` (above)
- `ids_dst_shared`: J ints = 64 bytes (used at process_tile:973-983)

Approximate total LDS per block:
- `tile_x`        = 19,456 B
- `tile_y` padded =    512 B
- `ids_dst`       =     64 B
- `data_mul_mat_q` header = small

Total ~ 20,032 B (~ 19.6 KiB) per block.

For comparison, the nbytes for `fallback=false` (non-fallback) with the same
J=16 is the same as fallback=true because the tile config is the same.

## RDNA3-specific #ifdef guards

The config file has no `RDNA3`-specific guards beyond using
`ggml_cuda_mmq_get_config_rdna3` (mmq.cuh:239-241) when `GGML_CUDA_CC_IS_RDNA3(cc)`
is true. All CASE entries are plain.

At compile time, the `RDNA3` macro is set, which makes the HIP toolchain
define `AMD_WMMA_AVAILABLE` (common.cuh:269-271). This enables the MMA
codepath in mma.cuh and the `ggml_cuda_mmq_get_config().use_mma_data_layout()`
returns true.
