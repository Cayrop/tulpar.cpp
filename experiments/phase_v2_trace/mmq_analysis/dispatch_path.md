# MMQ IQ3_XXS Dispatch Path (gfx1101)

## Entry Point

`ggml_cuda_mul_mat_q` (ggml/src/ggml-cuda/mmq.cu:85) is called from
`ggml-backend-impl` with `src0->type = GGML_TYPE_IQ3_XXS`.

The function:
1. Quantizes `src1` (F32) to Q8_1 via `quantize_mmq_q8_1_cuda` (mmq.cu:156)
2. Builds an `mmq_args` struct with the K-stride, batch, etc.
3. Calls `ggml_cuda_mul_mat_q_switch_type` (mmq.cu:175)

## Type Dispatch

`ggml_cuda_mul_mat_q_switch_type` (mmq.cu:8) selects the kernel via a switch on
`args.type_x`. For `GGML_TYPE_IQ3_XXS` (mmq.cu:60-62) it dispatches to:
```
mul_mat_q_case<GGML_TYPE_IQ3_XXS>(ctx, args, stream)
```

## `should_use_mmq` Decision

`ggml_cuda_should_use_mmq` (mmq.cu:259) returns true for IQ3_XXS on RDNA3
because:
1. IQ3_XXS is in the supported `mmq_supported` list (mmq.cu:285)
2. Shared memory per-block >= 48 KiB (RDNA3 has 64 KiB) (mmq.cu:303-310)
3. `amd_wmma_available(cc)` is true on gfx1101 (mmq.cu:347-369)
4. RDNA3 branch (mmq.cu:348) returns true for IQ3_XXS via the `default: return true;`
   fallthrough (mmq.cu:367) - the per-type restrictions in the switch only apply
   to Q2_K, Q6_K, IQ2_XS, IQ2_S. IQ3_XXS is unrestricted.

## Template Instantiation

`mul_mat_q_case<type>` launches the actual kernel through a J-templated
dispatch (12 J values from 8..128 in steps of 8). The active config is
selected by `ggml_cuda_mmq_get_J_max` (mmq.cuh:360), which picks the largest
J that matches a `CASE` for the current `ne11`.

For IQ3_XXS on RDNA3 with the typical batch sizes (ne11=512 or similar), the
largest matching J is used. The active `mul_mat_q` template instantiation:

```
_ZL9mul_mat_qIL9ggml_type18ELi16ELb1EEvPKcPKiS4_S4_PfS5_PKf...
```

That is: `GGML_TYPE_IQ3_XXS`, `J=16`, `fallback=true`. (Other sizes like
J=24, J=32 etc. are also compiled but only the matching J at dispatch time
is used.)

For `J=8, fallback=true` the kernel reduces to `no_device_code` because
`ggml_cuda_mmq_get_config_rdna3(IQ3_XXS, 8, true)` returns `GGML_TYPE_COUNT`
(no CASE for J=8 with fallback=true at IQ3_XXS). Config table:

- `J=16, fallback=true` => 128 threads, 2 occ, I=64, J=16, layout Q8_0
- `J=24, fallback=true` => NO_DEVICE_CODE (not in config)
- `J=32, fallback=true` => 128 threads, 2 occ, I=64, J=32
- `J=48, fallback=true` => 256 threads, 2 occ, I=128, J=48
- `J=64, fallback=true` => 256 threads, 2 occ, I=128, J=64
- `J=80, fallback=true` => 256 threads, 2 occ, I=128, J=80
- `J=96, fallback=true` => 256 threads, 2 occ, I=128, J=96
- `J=112, fallback=true` => 256 threads, 2 occ, I=128, J=112
- `J=128, fallback=true` => 256 threads, 2 occ, I=128, J=128

J=8 is not configured with fallback=true; the J=8 fallback=false variant
is the stub used to compile other templates.

The actual on-device binary for IQ3_XXS MMQ is the `J=16, fallback=true`
specialization (J=8 is a stub) up to whichever J matches the largest ne11
that fits.

## Util Funcs Selection (post-dispatch)

Inside the template, `ggml_cuda_mmq_get_util_funcs` (mmq.cuh:535) checks
`use_mma_data_layout()`. Because `AMD_WMMA_AVAILABLE` is defined on RDNA3
(common.cuh:269-271), the function selects the `mma` path. For IQ3_XXS
(mmq.cuh:803-808):

```cpp
case GGML_TYPE_IQ3_XXS:
    return ggml_cuda_mmq_util_funcs(
        -1,                                  // vdr (unused for mma path)
        ggml_cuda_mmq_load_tiles_iq3_xxs<...>,
        ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma<..., MMQ_Q8_1_DS_LAYOUT_D4>,
        ggml_cuda_mmq_write_back_mma<...>);
```

The selected MMA vec-dot function is `ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma`
with `ds_layout=MMQ_Q8_1_DS_LAYOUT_D4`.

## Summary

| Item | Value |
|------|-------|
| Entry | `ggml_cuda_mul_mat_q` (mmq.cu:85) |
| Switch | `ggml_cuda_mul_mat_q_switch_type` (mmq.cu:8) |
| Type case | `mul_mat_q_case<GGML_TYPE_IQ3_XXS>` (mmq.cu:60-62) |
| should_use_mmq | true (RDNA3 default) |
| Active kernel | `mul_mat_q<GGML_TYPE_IQ3_XXS, J=16, fallback=true>` |
| Util path | MMA (`use_mma_data_layout()` true on RDNA3) |
| Load tiles | `ggml_cuda_mmq_load_tiles_iq3_xxs` |
| Vec dot | `ggml_cuda_mmq_vec_dot_q8_0_q8_1_mma<D4>` |
| Write back | `ggml_cuda_mmq_write_back_mma` |
| Actual WMMA | `v_wmma_i32_16x16x16_iu8_w32` (RDNA3 INT8) |
