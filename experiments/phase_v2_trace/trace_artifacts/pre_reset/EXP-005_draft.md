## EXP-005: V2 Kernel Attribution Baseline

PROBLEM
V2 model (Qwen3.8-27B Q2_K_XL) bottleneck profile unknown after model swap.
No kernel-level attribution data exists to guide optimization priorities.
Expected IQ3_XXS dominance but needed quantification.

EVIDENCE
rocprofv2 kernel-trace capture: 4,879 dispatches (1 model load + 4,878 inference).
Single-arm profile (T-V2-1k-OFF) with small prompt + 32 decode tokens.

HYPOTHESIS
IQ3_XXS expected dominant in V2 model. GEMV bandwidth-bound decode.
Flash attention minimal overhead. GDN layers contribute <5%.

CHANGE
Measurement only. No code changes.
Tools: rocprofv2 --kernel-trace (rocprofv3 unusable due to assertion failure).

RESULT
**Decode attribution (single-token average):**

| Category | % Inference | ms/call |
|----------|------------:|--------:|
| GEMV_IQ3_XXS | 56.8% | 0.131 |
| Fill (KV cache) | 19.6% | 3.242 |
| GEMV_IQ3_XS | 9.8% | 0.031 |
| Other | 4.3% | 0.005 |
| GEMV_Q4_0 (output) | 2.2% | 1.458 |
| Quantize_Q8_1 | 1.5% | 0.002 |
| Norm_RMS | 1.4% | 0.005 |
| Broadcast | 0.9% | 0.003 |
| Get_Rows | 0.8% | 0.006 |
| GDN (gated_delta_net) | 0.8% | 0.011 |
| FA (flash_attn) | 0.4% | 0.009 |
| RoPE | 0.3% | 0.005 |

**GEMV by quant type:**
- IQ3_XXS: 82.5% of GEMV (576 calls, 75.24 ms total)
- IQ3_XS: 14.3% of GEMV (416 calls, 13.05 ms total)
- Q4_0: 3.2% of GEMV (2 calls, output head only)

**Phase-2 verification:** Staging dequant launches = 0. Fused kernel active.

**Inter-kernel gaps:** Median 0.009 ms, P99 10.55 ms.

WHY IT WORKED
Qwen3.8-27B uses IQ3_XXS as the dominant weight quantization (75.9% of parameters).
GEMV with IQ3_XXS (2.5 bits/weight) is bandwidth-bound on RDNA3.
Flash attention reduces attention overhead to <1% of inference.
GDN layers (49 of 65) contribute only 1% — SSM scan is lightweight.

CAVEAT
- Only 1 of 4 arms captured (T-V2-1k-OFF). Context-size-dependent behavior not measured.
- rocprofv2 killed the server after first request; multi-arm profiling requires restarts.
- rocprofv3 unusable (assertion failure on ROCm 7.2.4).
- VRAM at 92% utilization (14.9/16 GiB) with ctx=131072 q4_0 KV cache.
- Fill operations (19.6%) are KV cache zeroing — may be different at other context sizes.
- Effective bandwidth for IQ3_XXS: ~23 GB/s (vs 624 GB/s nominal) — bandwidth-limited.
