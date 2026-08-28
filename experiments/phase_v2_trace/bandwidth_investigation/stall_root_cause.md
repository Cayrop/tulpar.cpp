# Candidate Root Cause Analysis

Constraints: NO source modifications. Evidence from code read only.

## 2.1 Q8_1 Scratch Buffer Pool Allocation

Evidence:
- `ggml/src/ggml-cuda/mmvq.cu:1327`: `ggml_cuda_pool_alloc<char> src1_q8_1(ctx.pool(), ...)` allocates from `ctx.pool()` for EVERY GEMV (`mul_mat_vec_q`) call.
- Pool implementation (`ggml/src/ggml-cuda/ggml-cuda.cu:420-694`):
  - `ggml_cuda_pool_leg`: custom buffer pool (MAX_BUFFERS=256). If no free buffer matches size, calls `ggml_cuda_device_malloc` (wraps `cudaMalloc` / `hipMalloc`).
  - `ggml_cuda_pool_vmm`: uses `cuMemCreate`/`cuMemMap`. If `pool_size - pool_used < size`, reserves more virtual memory and maps new physical memory (`cuMemCreate` + `cuMemMap`).
- The allocation is NOT using `hipMallocAsync`; it uses synchronous pool growth (`cuMemCreate`/`cuMemMap` or `cudaMalloc`).
- Pool growth can trigger a device-side memory map or host-side `cudaMalloc`, which can cause multi-ms stalls (especially on first use or after exhaustion).
- The largest stalls (15-17 ms) occur at token 0 and token 2, exactly where the decode sequence first exercises GEMV heavily (after prefill MMQ). This aligns with pool warm-up/growth.
- The medium stall (2-3.5 ms) at token 1 (GEMV -> copyBuffer) also aligns with a GEMV-triggered pool allocation.

Conclusion: HIGHLY LIKELY contributor. The stalls occur at GEMV/norm boundaries and match the timing of pool growth.
UNCERTAIN: Whether the stall is from VMM map (`cuMemMap`) or legacy pool (`cudaMalloc`) requires runtime profiling of `cuMemCreate`/`cudaMalloc` events (not available in current CSV).

## 2.2 HIP Graph Node Transition Overhead

Evidence:
- `ggml-cuda.cu:2585-2624`: Graph update checks `graph_key` (first node pointer), `uid`, and node properties. If `uid` matches and node props match, graph is reused (`graphs reused = 63` from server log).
- Decode phase uses a single graph instance (no graph capture/re-capture observed in server log). The stalls occur INSIDE the graph execution, not at graph boundaries.
- Graph node transition overhead is expected to be ~1-2 µs (median gap 8.4 µs confirms this). The 15-17 ms stalls are 1000x larger than graph transition overhead.

Conclusion: UNLIKELY. Stalls are intra-graph, not at graph launch/re-launch boundaries.

## 2.3 VRAM Allocator Stalls

Evidence:
- The pool (`ggml_cuda_pool_leg`/`vmm`) handles runtime allocations; there is no direct `hipMalloc` call in decode path except through pool growth (`ggml_cuda_device_malloc` at line 496/504).
- `DEBUG_CUDA_MALLOC` is disabled in build (line 417: `#define DEBUG_CUDA_MALLOC` is commented out). No runtime logging of allocations.
- If the pool grows during decode, `cudaMalloc`/`cuMemCreate` can block the stream for multi-ms.
- The stalls are not constant across all tokens; they cluster at the beginning (token 0-2) and occasionally later (token 30-40 in 63k). This matches a pool that grows initially and occasionally when a new buffer size is needed.

Conclusion: LIKELY (same mechanism as 2.1). Additional measurement needed: `rocm-smi` or HIP trace to detect runtime `hipMalloc`/`cuMemCreate` calls during decode.

## 2.4 CPU-Side Scheduling

Evidence:
- Server log (`server_stdout.log`): CPU is idle except for server thread (`llama_server` only thread running). No other processes mentioned.
- `start_server.sh` or `run_arm.sh` does not show CPU-bound work during decode.
- The stalls are deterministic at token 0/2 (same index across arms), which is inconsistent with random OS scheduler jitter.
- CPU-side delay would be stochastic, not systematic at exact decode index.

Conclusion: UNLIKELY for systematic stalls. Possible minor contributor to stochastic stalls (e.g., OS timer interrupt), but cannot explain 15-17 ms systematic stalls.

## 2.5 Specific Kernel Boundary Effects

Evidence:
- Stalls always occur at specific kernel pairs:
  - `rms_norm_f32` -> `__amd_rocclr_copyBuffer.kd` (15-17 ms, token 0/2)
  - `__amd_rocclr_copyBuffer.kd` -> `rms_norm_f32` (12-16 ms, token 2)
  - `mul_mat_vec_q` (GEMV) -> `__amd_rocclr_copyBuffer.kd` (2-3.5 ms, token 1; 1-2 ms scattered)
- These pairs involve system copy kernels (`__amd_rocclr_copyBuffer`) that may trigger implicit stream synchronization or memory flush.
- The `__amd_rocclr_copyBuffer` kernel writes to a buffer that is then read by the next kernel; this may trigger a memory barrier or cache flush in the HIP runtime.
- However, the duration (15 ms) is too large for a simple memory barrier; it is consistent with a device-side memory allocation (pool growth) that is triggered by the memory pressure from the previous kernel.

Conclusion: PARTIAL. The kernel pair defines the boundary, but the stall duration points to pool/allocation rather than a pure synchronization delay. The `copyBuffer` kernel may be the trigger that causes the pool to grow for the next GEMV/norm.

## 2.6 Additional Evidence from Trace Data

- `graphs reused = 63` (server log) confirms no graph capture overhead per decode step.
- Median gap 8.4 µs (analysis.json) confirms baseline dispatch overhead is small. The 15-17 ms stalls are outliers (~2000x median).
- The stalls are NOT proportional to dispatch count: per-token gap is ~17.3 ms regardless of context size (1k: 1099.6 ms / 64 = 17.18 ms; 16k: 1110.9 / 64 = 17.36 ms; 63k: 1116.8 / 64 = 17.45 ms; 128k: 1109.2 / 64 = 17.33 ms). This supports that the stalls are fixed overhead per decode sequence, not scaling with work.
- The large stalls occur only in the first few tokens (0, 1, 2). Later tokens have only small scattered gaps (<2 ms). This suggests the main stall budget is front-loaded.

UNCERTAIN: Whether the 9.98 ms stall at token 38 in 63k is a second pool growth event or a different root cause (e.g., VRAM page fault) requires HIP-level memory tracing (not available).
