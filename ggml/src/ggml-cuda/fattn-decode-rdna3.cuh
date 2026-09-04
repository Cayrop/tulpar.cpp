#pragma once

#include "common.cuh"

// Fused decode attention for RDNA3 (gfx1101) with Q4_0 KV cache, head_dim 256.
// Returns true when the op was handled, false to fall back to the tile kernel.
bool ggml_cuda_flash_attn_ext_decode_rdna3(ggml_backend_cuda_context & ctx, ggml_tensor * dst);
