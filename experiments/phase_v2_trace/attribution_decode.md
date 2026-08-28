# Decode Kernel Attribution (per arm, MTP=off)

**Source:** `experiments/phase_v2_trace/attribution.json`
**Build:** `build-p3/bin/llama-server` HEAD `4f72448eb` (Phase-2 fused q4_0 only, Phase-3 reverted)
**Capture:** `rocprofv2 --kernel-trace -d <out> -o trace_<P|D> <bin>` (CSV per server instance)
**n_predict:** 64 per arm; same prompt base (`Once upon a time...there was `) repeated to fill ctx.

## Per-arm summary

| Arm | ctx | prompt_n | decode_total_ms | ms/token (trace) | ms/token (wall) |
|-----|----:|--------:|----------------:|-----------------:|----------------:|
| T-V2-1k-OFF | 2048 | 161 | 2554.4 | 39.91 | 57.61 |
| T-V2-16k-OFF | 17408 | 1421 | 2592.2 | 40.50 | 57.83 |
| T-V2-63k-OFF | 64512 | 5341 | 2602.1 | 40.66 | 58.68 |
| T-V2-128k-OFF | 131072 | 10671 | 2653.7 | 41.46 | 59.37 |

wall = server-reported `predicted_ms / predicted_n`. trace = sum of kernel durations in decode segment / 64.

## Decode kernel category attribution (%, sorted by T-V2-1k-OFF total ms)

| Category | T-V2-1k-OFF | T-V2-16k-OFF | T-V2-63k-OFF | T-V2-128k-OFF |
|----------|:-----------:|:-----------:|:-----------:|:-------------:|
| GEMV_IQ3_XXS | 74.1% | 73.7% | 72.8% | 71.5% |
| GEMV_IQ3_S | 11.6% | 11.6% | 11.5% | 11.2% |
| GEMV_Q3_K | 3.5% | 3.5% | 3.4% | 3.4% |
| Norm_RMS | 1.6% | 1.7% | 1.6% | 1.6% |
| Quantize_q8_1 | 1.5% | 1.5% | 1.5% | 1.5% |
| Get_Rows | 1.3% | 1.3% | 1.3% | 1.2% |
| GEMV_IQ1_M | 0.9% | 0.9% | 0.8% | 0.8% |
| GDN | 0.7% | 0.8% | 0.7% | 0.7% |
| Activation | 0.7% | 0.7% | 0.7% | 0.7% |
| FA_tile | 0.6% | 0.9% | 2.2% | 3.9% |
| Copy | 0.6% | 0.6% | 0.6% | 0.6% |
| Broadcast | 0.5% | 0.5% | 0.5% | 0.5% |
| Norm_L2 | 0.5% | 0.5% | 0.5% | 0.5% |
| RoPE | 0.5% | 0.4% | 0.4% | 0.4% |
| KV_Store | 0.3% | 0.3% | 0.3% | 0.3% |
| GEMV_IQ4_XS | 0.3% | 0.3% | 0.3% | 0.3% |
| GDN_FWHT | 0.3% | 0.3% | 0.3% | 0.3% |
| Other | 0.3% | 0.3% | 0.3% | 0.2% |
| GDN_SSM_Conv | 0.2% | 0.2% | 0.2% | 0.2% |
| FA_combine | 0.1% | 0.2% | 0.2% | 0.2% |

## Decode kernel count per arm

| Category | T-V2-1k-OFF | T-V2-16k-OFF | T-V2-63k-OFF | T-V2-128k-OFF |
|----------|------------:|-------------:|-------------:|--------------:|
| GEMV_IQ3_XXS | 13921 | 14057 | 13910 | 13909 |
| GEMV_IQ3_S | 5937 | 5996 | 5934 | 5934 |
| GEMV_Q3_K | 61 | 62 | 61 | 61 |
| Norm_RMS | 12928 | 13056 | 12920 | 12919 |
| Quantize_q8_1 | 26849 | 27112 | 26829 | 26828 |
| Get_Rows | 6001 | 6060 | 5997 | 5995 |
| GEMV_IQ1_M | 5940 | 5998 | 5934 | 5934 |
| GDN | 2970 | 2999 | 2967 | 2967 |
| Activation | 9963 | 10060 | 9954 | 9954 |
| FA_tile | 989 | 999 | 989 | 989 |
| Copy | 4441 | 4487 | 4438 | 4376 |
| Broadcast | 6069 | 6127 | 6063 | 6063 |
| Norm_L2 | 5940 | 5998 | 5934 | 5934 |
| RoPE | 1978 | 1998 | 1978 | 1978 |
| KV_Store | 1978 | 1998 | 1978 | 1978 |
| GEMV_IQ4_XS | 989 | 999 | 989 | 989 |
| GDN_FWHT | 3956 | 3996 | 3956 | 3956 |
| Other | 2922 | 2951 | 2919 | 2919 |
| GDN_SSM_Conv | 2970 | 2999 | 2967 | 2967 |
| FA_combine | 989 | 999 | 989 | 989 |

## Total ms per arm (decode segment)

| Category | T-V2-1k-OFF | T-V2-16k-OFF | T-V2-63k-OFF | T-V2-128k-OFF |
|----------|------------:|-------------:|-------------:|--------------:|
| GEMV_IQ3_XXS | 1892.20 | 1910.55 | 1893.09 | 1897.28 |
| GEMV_IQ3_S | 297.11 | 301.72 | 298.47 | 298.62 |
| GEMV_Q3_K | 88.95 | 90.45 | 89.10 | 89.25 |
| Norm_RMS | 42.23 | 43.39 | 42.41 | 43.05 |
| Quantize_q8_1 | 37.81 | 39.12 | 38.34 | 38.62 |
| Get_Rows | 32.80 | 32.95 | 32.80 | 33.06 |
| GEMV_IQ1_M | 22.26 | 22.61 | 22.14 | 21.96 |
| GDN | 18.88 | 19.38 | 18.93 | 18.82 |
| Activation | 17.98 | 18.19 | 18.22 | 17.68 |
| FA_tile | 15.26 | 23.49 | 58.35 | 104.62 |
| Copy | 15.21 | 14.61 | 14.68 | 14.86 |
| Broadcast | 12.96 | 12.79 | 12.90 | 13.40 |
| Norm_L2 | 11.46 | 12.03 | 12.00 | 11.90 |
| RoPE | 11.43 | 11.53 | 11.45 | 11.48 |
| KV_Store | 7.48 | 7.56 | 7.55 | 7.53 |
| GEMV_IQ4_XS | 7.32 | 7.43 | 7.39 | 7.39 |
| GDN_FWHT | 6.79 | 7.03 | 6.87 | 6.87 |
| Other | 6.61 | 6.72 | 6.75 | 6.70 |
| GDN_SSM_Conv | 6.32 | 6.36 | 6.38 | 6.36 |
| FA_combine | 3.35 | 4.30 | 4.33 | 4.31 |

## Observations

- **IQ3_XXS dominates decode at every context size**, 71-74% of decode kernel time.
- IQ3_S is the second-largest (11-12%), primarily ssm_out + attn_q/output/k.
- Q3_K is the output head (61-62 dispatches / 64 tokens, one per generated token).
- **Staging dequant (dequantize_block_q4_0) count = 0** across all 4 arms: Phase-2 fused q4_0 path is active.
- FA_tile grows with context: 0.6% (1k) -> 0.9% (16k) -> 2.2% (63k) -> 3.9% (128k). The 17 attention layers each run FA once per token; bigger KV cache -> more time per call.
- Decode kernel total is stable (2554 -> 2654 ms) across all 4 arms because decode only touches the per-token weight budget, not the cache. The slight growth (4%) comes from FA_tile.
- Dispatches-per-token is constant at ~1840 across all 4 arms: graphs are fully reused (server log: `graphs reused = 63` for 64-token generation).
