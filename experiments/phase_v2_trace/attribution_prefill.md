# Prefill Kernel Attribution (per arm, MTP=off)

**Source:** `experiments/phase_v2_trace/attribution.json`
**Capture:** D-trace (n_predict=64 request). Prefill segment = dispatches [load_end, last_mmq_idx].
**Prefill duration in trace** = sum of kernel durations within segment, NOT wall-clock (kernel timestamps are GPU monotonic clock).

## Per-arm prefill summary

| Arm | ctx | prompt_n | prefill_total_ms (trace) | server_prompt_ms | ms/token (trace) |
|-----|----:|---------:|-------------------------:|-----------------:|-----------------:|
| T-V2-1k-OFF | 2048 | 161 | 321.9 | 492.9 | 2.000 |
| T-V2-16k-OFF | 17408 | 1421 | 2535.0 | 2782.7 | 1.784 |
| T-V2-63k-OFF | 64512 | 5341 | 9692.7 | 10167.6 | 1.815 |
| T-V2-128k-OFF | 131072 | 10671 | 20514.6 | 21280.1 | 1.922 |

## Prefill kernel category attribution (%, sorted by T-V2-1k-OFF total ms)

| Category | T-V2-1k-OFF | T-V2-16k-OFF | T-V2-63k-OFF | T-V2-128k-OFF |
|----------|:-----------:|:-----------:|:-----------:|:-------------:|
| MMQ_IQ3_XXS | 74.4% | 72.0% | 68.4% | 64.4% |
| MMQ_IQ3_S | 11.4% | 11.1% | 10.5% | 9.9% |
| GDN | 5.4% | 6.2% | 6.1% | 5.8% |
| Copy | 1.2% | 1.2% | 1.2% | 1.2% |
| Activation | 1.1% | 1.5% | 1.6% | 1.5% |
| Norm_RMS | 1.1% | 1.2% | 1.2% | 1.1% |
| Quantize_q8_1_MMQ | 1.0% | 1.5% | 1.5% | 1.4% |
| hipBLAS_GEMM | 0.9% | 0.3% | 0.3% | 0.3% |
| FA_tile | 0.7% | 2.4% | 6.7% | 12.1% |
| Broadcast | 0.6% | 0.5% | 0.5% | 0.5% |
| MMQ_IQ4_XS | 0.5% | 0.5% | 0.4% | 0.4% |
| Convert | 0.4% | 0.4% | 0.4% | 0.4% |
| GDN_SSM_Conv | 0.4% | 0.4% | 0.4% | 0.4% |
| RoPE | 0.3% | 0.3% | 0.3% | 0.3% |
| Scale | 0.2% | 0.0% | 0.0% | 0.0% |
| Get_Rows | 0.2% | 0.1% | 0.1% | 0.1% |
| Norm_L2 | 0.2% | 0.1% | 0.1% | 0.1% |
| GDN_FWHT | 0.1% | 0.1% | 0.1% | 0.1% |
| Dequant_block | 0.1% | 0.0% | 0.0% | 0.0% |
| KV_Store | 0.1% | 0.0% | 0.0% | 0.0% |
| FA_combine | - | - | 0.0% | - |

## Prefill total ms per arm (kernel-sum)

| Category | T-V2-1k-OFF | T-V2-16k-OFF | T-V2-63k-OFF | T-V2-128k-OFF |
|----------|------------:|-------------:|-------------:|--------------:|
| MMQ_IQ3_XXS | 239.38 | 1824.64 | 6626.86 | 13218.39 |
| MMQ_IQ3_S | 36.56 | 281.22 | 1018.49 | 2031.37 |
| GDN | 17.26 | 157.83 | 594.55 | 1189.16 |
| Copy | 3.88 | 30.95 | 119.66 | 244.64 |
| Activation | 3.67 | 39.03 | 151.81 | 303.09 |
| Norm_RMS | 3.48 | 29.66 | 112.79 | 223.92 |
| Quantize_q8_1_MMQ | 3.14 | 37.86 | 145.90 | 295.14 |
| hipBLAS_GEMM | 2.75 | 8.53 | 31.43 | 60.24 |
| FA_tile | 2.09 | 61.59 | 653.67 | 2478.33 |
| Broadcast | 1.83 | 13.40 | 50.18 | 100.07 |
| MMQ_IQ4_XS | 1.61 | 11.29 | 41.33 | 82.08 |
| Convert | 1.42 | 10.71 | 40.26 | 80.10 |
| GDN_SSM_Conv | 1.33 | 10.24 | 39.04 | 77.59 |
| RoPE | 0.94 | 8.01 | 30.19 | 60.23 |
| Scale | 0.65 | 0.57 | 0.57 | 0.56 |
| Get_Rows | 0.58 | 2.00 | 7.72 | 15.00 |
| Norm_L2 | 0.55 | 3.17 | 11.83 | 23.37 |
| GDN_FWHT | 0.37 | 2.49 | 9.30 | 18.43 |
| Dequant_block | 0.23 | 0.69 | 2.54 | 4.84 |
| KV_Store | 0.18 | 1.06 | 4.04 | 8.02 |
| FA_combine | - | - | 0.51 | - |

## Observations

- **MMQ_IQ3_XXS dominates prefill** at every ctx (64-74%). MMQ = quantized matrix-matrix (prefill-only path), GEMV is the decode path.
- **FA_tile grows with ctx**: 0.7% (1k, 161 tok) -> 2.4% (16k, 1421 tok) -> 6.7% (63k, 5341 tok) -> 12.1% (128k, 10671 tok). At 128k, FA is the second-largest prefill category and is the bottleneck on long contexts.
- GDN share stays 5-6% across all ctx, indicating the 48 GDN blocks contribute a fixed per-token cost (not ctx-dependent).
- Staging dequant (dequantize_block_q4_0) count = 0 in prefill, same as decode. Phase-2 fused q4_0 active.
- hipBLAS_GEMM (Cijk_...) shows up at ~0.3-0.9% in prefill only. This is the Phase-2 fallback path that the reverted Phase-3 commit (`raise RDNA3 MMQ threshold`) was trying to eliminate. With Phase-3 reverted, the threshold returns to its lower Phase-2 value and hipBLAS still appears for some shapes.
