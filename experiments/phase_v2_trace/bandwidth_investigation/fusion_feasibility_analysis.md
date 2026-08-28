# Fusion Feasibility Analysis — RMSNorm + Quantize_q8_1 + GEMV_IQ3_XXS

## Evidence Summary (from prior traces)

From `experiments/phase_v2_trace/attribution_decode.md` (1k arm, 64 tokens, MTP OFF):

| Category | calls/64 tok | calls/tok | kernel ms total | share |
|----------|-------------:|----------:|----------------:|------:|
| GEMV_IQ3_XXS | 13921 | 217.5 | 1892.2 | 74.1 % |
| Quantize_q8_1 | 26849 | 419.5 | 37.8 | 1.5 % |
| Norm_RMS | 12928 | 202.0 | 42.2 | 1.6 % |

Sum of these three categories: 53 698 calls / 64 tok = 838.6 calls / token.
Total dispatches/token = 1840.
These three categories = 45.5 % of all decode dispatches.

From `experiments/phase_v2_trace/gap_analysis.md`:
- Median gap = 8.4 µs
- p99 gap = 180 µs
- max gap = 17.3 ms (single long tail stall)
- per-token gap_ms = 17.18 ms
- per-token kernel_ms = 39.91 ms
- gap_share of total wall = 30 % (gap_ms / total_kernel_ms); 43 % of wall (kernel + gap)

The hypothesis claim is that fusing these three categories reduces dispatch count, and therefore reduces gap time.

## Sequential Adjacency Check — Is RMSNorm→Quantize→GEMV a Real Pattern?

The pattern is well-known in the Qwen3-style / DeepSeek-style MoE blocks. In `llama-model.cpp` every quantized `MUL_MAT` (GEMV) for Q8_1 operands is preceded by a `ggml_quantize_q8_1` of the activation. The activation coming into the quantize op is the post-RMSNorm hidden state.

In Qwen3-Next (the V2 model) the per-layer compute is roughly:
- input_layernorm -> RMSNorm
- attn: Q/K/V linear (GEMV) — quantized
- ...
- post_attention_layernorm -> RMSNorm
- MoE gate + experts (GEMV) — quantized

So the canonical 3-op sequence in the graph is:
    RMSNorm(hidden) -> fp32_act -> Quantize_q8_1(fp32_act) -> q8_1 -> GEMV_IQ3_XXS(weight, q8_1) -> fp16_out

This sequence repeats for every linear in the layer that uses quantized weights (Q, K, V, O, gate, up, down, expert_w1/w2/w3, shared expert, output norm).

## Fusion Feasibility — At the Graph Level

The standard llama.cpp compute graph is materialized as a `ggml_cgraph` (see `ggml/src/ggml.c`, `ggml_build_forward`). The graph nodes are visited in topological order and dispatched as separate `cudaLaunchKernel` calls (or graph captures once `ggml_cuda_capture` is active — it IS active: `graphs reused = 63` per server log).

Each of RMSNorm, Quantize_q8_1, and GEMV is its own `ggml_tensor` op in the graph. The fused kernel would have to be inserted as a NEW op node that takes (input, weight, rms_weight) and produces output.

**There is NO existing fusion infrastructure in llama.cpp for RMSNorm+Quantize+GEMV as a single op.** The closest analog is `ggml_cuda_mm_fusion_args_device` in `ggml/src/ggml-cuda/mmvq.cu:599-649`, but that fuses only post-MMV ops (bias / GLU gates / NVFP4 scales). It does NOT fuse pre-MMV ops (RMSNorm, Quantize).

**To make this fusion work, the build code (`src/llama-model.cpp` or `src/llama-graph.cpp`) would have to detect a 3-op chain and replace it with a single fused op.** That means modifying the graph construction in BOTH:
1. The CUDA backend (new kernel + new op type)
2. The model graph builder (chain detection + replacement)

This is an invasive change touching many files and would require coordination with the existing `ggml_cuda_mm_fusion_args_device` extension. It is NOT a single-kernel change.

## Quantitative Re-Examination of the Hypothesis

The hypothesis claims:
- 838 dispatches -> 217 (limited by GEMV)
- gap reduction = 621 dispatches * 8.4 µs = 5.2 ms/token
- wall-time improvement = 5.2 / 57.6 = 9 %

But the trace data also shows:
- max gap per token = 17.3 ms (long tail; ONE stall per token, not 621)
- p99 gap = 180 µs (still small)
- The 17.3 ms is a SINGLE long-tail stall per token, not the median gap accumulated

**Removing 621 dispatches of 8.4 µs each does NOT simply subtract 5.2 ms.** The gap is dominated by:
- A few large stalls (17.3 ms max) that are not proportional to dispatch count
- CPU graph re-launch / scheduling (one per dispatch, but with variable cost)

Even if every eliminated dispatch saved 8.4 µs, the per-token savings would be 621 * 8.4 µs = 5.2 ms. But the gap is also driven by other operations (Copy, Broadcast, Get_Rows, etc.) that we are NOT fusing.

**Predicted upper bound for the proposed fusion: 5-9 % decode wall-time improvement.** This is the lower bound of the success threshold (10 %).

## Single-Op-Only Feasibility (RMSNorm + Quantize_q8_1)

A simpler alternative is to fuse ONLY RMSNorm + Quantize_q8_1 into a single kernel. This:
- Eliminates 1 intermediate write (fp32 normalized) and 1 intermediate read
- Saves 202 dispatches/token (the RMSNorm count)
- Saves 202 * 8.4 µs = 1.7 ms/token (~3 %)
- Does not touch the GEMV kernel — no risk of breaking vec_dot
- Can be inserted as a new ggml op OR as a fused variant of the quantize op

**Single-op fusion is more conservative but only buys ~3 %.** This is well below the 10 % success threshold.

## Conclusion: REJECT PROPOSED FUSION

The proposed RMSNorm+Quantize+GEMV fusion is **infeasible as a single low-risk change**:

1. **No existing infrastructure** for pre-MM fusion in the CUDA backend. The `ggml_cuda_mm_fusion_args_device` machinery handles only post-MM (bias, GLU, scales). Adding a new pre-MM fusion path requires touching `ggml-cuda/mmvq.cu`, `ggml-cuda/quantize.cu`, `ggml-cuda/norm.cu`, `src/llama-model.cpp` (or `src/llama-graph.cpp`), and possibly the CPU/MUDA backends for parity. This is the opposite of "single change, single commit".

2. **Quantize is the data producer for many GEMV consumers, not just one.** Each RMSNorm output flows into ONE Quantize (per linear), but the Quantize output flows into many GEMV kernels (gate, up, down, Q, K, V, O, expert). Even if we fuse RMSNorm+Quantize, we still write Q8_1 to VRAM because multiple GEMV consumers read it. We CANNOT fuse further into the GEMV without either (a) making the GEMV re-read FP32 and re-quantize per call (REGRESSION), or (b) using a graph-level "data dependency kill" that no current backend supports.

3. **Predicted gain is at best 5-9 %**, below the 10 % success threshold. The long-tail gap (17.3 ms/token max) is the real cost driver and is not addressed by reducing dispatch count alone.

4. **Risk of correctness regression is non-trivial.** Any change to the quantize or RMSNorm path must be bit-exact, and the new code lives in the hot path of every linear in every layer.

## Recommendation

**Do NOT proceed with the proposed fusion in its current form.** The cost of infrastructure (multi-file, multi-backend) outweighs the predicted 5-9 % gain. The experiment would not meet the 10 % success threshold even in the best case.

A follow-up EXP should instead target the long-tail 17.3 ms gap stalls, which dominate per-token idle time and are NOT proportional to dispatch count. That is a different problem (graph re-launch, GPU scheduler, page faults in scratch buffer, etc.) and is not addressable by kernel fusion.
