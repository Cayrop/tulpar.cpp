# KERNEL-TO-SOURCE MAPPING (llama.cpp @ 849798132)
Trace: rocprofv3 runtime-trace | Model: qwen35 arch, 65 blocks (48 GDN + 17 full-attn + MTP nextn)

| Trace Kernel | Source Function | Location | Confidence |
|---|---|---|---|
| `mul_mat_vec_q<18,N,...>` (IQ3_XXS; FFN gate/up/down) | ggml_cuda_mul_mat_vec_q -> mul_mat_vec_q_switch_type<GGML_TYPE_IQ3_XXS, N> -> vec_dot type IQ3_XXS | ggml/src/ggml-cuda/mmvq.cu:967-998, vecdotq.cuh | Confirmed |
| `mul_mat_vec_q<18,1,true,...>` fused GLU | fused gate+up+swiglu path: ggml_cuda_should_fuse_mul_mat_vec_q (dst->ne[1]==1) | ggml/src/ggml-cuda/ggml-cuda.cu:1786-1813, :3595-3600 | Confirmed |
| `mul_mat_vec_q<21,N>` (IQ3_S; attn q/k/v/o, ssm_out) | same MMVQ dispatch, ne11<=8 rule | mmvq.cu:289-337; ggml-cuda.cu:1860-1862 | Confirmed |
| `mul_mat_vec_q<11,1>` grid=7.9M (lm_head Q3_K) | MMVQ on output.weight (vocab x 5120) | mmvq.cu + src/models/qwen35.cpp output head | Strongly supported |
| `quantize_q8_1` | quantize_row_q8_1_cuda (MMVQ activation prep) | ggml/src/ggml-cuda/quantize.cu:558; mmvq.cu:1290-1297 | Confirmed |
| `flash_attn_ext_vec<256,1,Q4_0,Q4_0>` | BEST_FATTN_KERNEL_VEC selection (Q->ne[1]<=2) -> flash_attn_ext_vec<D=256> | fattn.cu:527-530, :570-585; fattn-vec.cuh:18-21 | Confirmed |
| `flash_attn_tile<256,256,C,2>` (verify/prefill) | TILE selection for ncols>2 or big batch; need_f16_K/V | fattn.cu:533, :550-559; fattn-tile.cuh | Confirmed |
| `dequantize_block_q4_0<__half>` full-cache | to_fp16 conversion for tile FA inputs | fattn-common.cuh:1022-1084 (ggml_get_to_fp16_cuda) | Confirmed |
| `flash_attn_combine_results<256>` | split-K combine of tile/vec partials | fattn-common.cuh | Strongly supported |
| `convert_unary<float,__half>` / reverse | KV f16 staging around tile kernels | fattn-common.cuh:1041-1084 | Tentative |
| `rms_norm_f32<1024,true,false>` (+fused mul) | rms_norm+mul fusion pattern | norm.cu:502-562; ggml-cuda.cu:3114-3134 | Confirmed |
| `rope_multi` / rope kernels (IMROPE mode 40) | ggml_rope_multi launch; fusion with set_rows NOT applied (mode!=NEOX/NORMAL) | rope.cu:200-260,469-488; ggml-cuda.cu:2677-2680 | Confirmed |
| `set_rows` quantizing KV writes (q4_0) | set_rows_cuda_quant<block_q4_0> via cpy_k/cpy_v | set-rows.cu:213,260-262; llama-kv-cache.cpp:1301-1334 | Confirmed |
| `gated_delta_net_cuda<128,false,true>` | GDN/linear-attention layer kernel (48 layers) | ggml/src/ggml-cuda (ssm/gdn kernels) | Strongly supported (exact file not opened) |
| `mul_mat_q<18/21,128>` (prefill) | MMQ path (RDNA3 WMMA pipeline) for ubatch GEMM | mmq.cu:259-383 (RDNA3 switch :347-369) | Confirmed |
| CUDA graph capture/replay | ggml_backend_cuda_graph_compute; 2-stable-call warmup; GGML_CUDA_USE_GRAPHS ON | ggml-cuda.cu:4243-4300; common.cuh:1227-1229; CMake defaults | Confirmed |
| hipStreamSynchronize storms per round | llama_synchronize after decode w/ outputs; spec process(); draft sampling syncs | server-context.cpp:3612-3614; llama-context.cpp:705-737; speculative.cpp:1434-1550 | Confirmed |

## Per-MTP-iteration structure (measured + source):
1 target verify decode (batch 1+d, d~1..4) -> common_speculative_process catch-up decode
(ctx_dft, batch 1+d) -> d single-token draft decodes (ctx_dft graph_mtp: eh_proj + 1 attn block +
shared LM head). Source: common/speculative.cpp:1552-1716, src/models/qwen35.cpp:489-645,
server-context.cpp:2927-2977, 3610-3685, 3826-3947.

## Graph-churn mechanism (measured):
Verify batch size varies with drafts accepted/proposed (p_min early-stop) -> node properties change
per iteration -> "2 consecutive identical calls" warmup never stabilizes -> eager hipLaunchKernel
fallback (~1000/round) + periodic re-instantiate. Fixing shapes (n_min=n_max, p_min=0) reduces eager
launches ~40% and eliminates latency variance but does not fully restore replay (remaining eagerness:
interleaved multi-context captures and/or op-level exclusions - NOT conclusively determined).
