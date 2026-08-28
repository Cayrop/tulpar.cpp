# V2 Kernel Attribution Baseline (EXP-005)

**Date:** 2026-08-26
**Model:** Qwen3.8-27B-UD-Q2_K_XL (GGUF, Q2_K/Q3_XXS/Q3_XS/Q4_0 hybrid)
**Binary:** build-p3/bin/llama-server (Phase-2 fused q4_0 + Phase-3 shape-gated/MMQ)
**GPU:** AMD RDNA3 (gfx1100), 16 GiB VRAM, ROCm 7.2.4
**Server config:** ctx=131072, -fa on, -ctk q4_0, -ctv q4_0, -ngl 999

## 1. Executive Summary

| Arm | Tokens | PP tok/s | Decode tok/s | Dominant Kernel | Dominant % |
|-----|-------:|---------:|-------------:|-----------------|-----------:|
| T-V2-1k-OFF | ~850 | — | 21.6 | GEMV_IQ3_XXS | 56.8% |
| T-V2-16k-OFF | 33,330 | 412 | 15.4 | MMQ (prefill) | 61.0% |
| T-V2-63k-OFF | 63,330 | 331 | 14.5 | MMQ (prefill) | 49.2% |
| T-V2-128k-OFF | 88,064* | ~290 | — | FA (prefill) | 50.2% |

*T-V2-128k-OFF timed out during prefill; decode not captured.

**Key insight:** As context grows, attention transitions from <1% to 50%+ of kernel time. At 128k, flash attention becomes the dominant bottleneck, overtaking MMQ GEMM.

## 2. Decode Attribution (T-V2-1k-OFF)

Single-token decode profile (small prompt, no prefill overhead):

| Category | Count | Total ms | % Decode | Avg ms |
|----------|------:|---------:|---------:|-------:|
| **GEMV_IQ3_XXS** | 576 | 75.24 | **56.8%** | 0.131 |
| Fill (KV cache) | 8 | 25.94 | 19.6% | 3.242 |
| **GEMV_IQ3_XS** | 416 | 13.05 | **9.8%** | 0.031 |
| Other | 1,056 | 5.71 | 4.3% | 0.005 |
| GEMV_Q4_0 (output) | 2 | 2.92 | 2.2% | 1.458 |
| Quantize_Q8_1 | 994 | 1.99 | 1.5% | 0.002 |
| Norm_RMS | 418 | 1.89 | 1.4% | 0.005 |
| Broadcast | 448 | 1.19 | 0.9% | 0.003 |
| Get_Rows | 194 | 1.10 | 0.8% | 0.006 |
| GDN | 96 | 1.03 | 0.8% | 0.011 |
| Copy | 190 | 0.62 | 0.5% | 0.003 |
| **FA (flash_attn)** | 64 | 0.57 | **0.4%** | 0.009 |
| Norm | 192 | 0.51 | 0.4% | 0.003 |
| RoPE | 64 | 0.33 | 0.3% | 0.005 |
| GDN_SSM_Conv | 96 | 0.28 | 0.2% | 0.003 |
| Dequant | 64 | 0.17 | 0.1% | 0.003 |

### GEMV by Quant Type (Decode)

| Quant Type | Count | Total ms | % GEMV | Avg Grid |
|------------|------:|---------:|-------:|---------:|
| **IQ3_XXS** | 576 | 75.24 | **82.5%** | 371,371 |
| IQ3_XS | 416 | 13.05 | 14.3% | 86,410 |
| Q4_0 | 2 | 2.92 | 3.2% | 7,946,240 |

## 3. Prefill Attribution Across Context Sizes

### 3.1 Category Breakdown by Arm

| Category | T-V2-1k | T-V2-16k | T-V2-63k | T-V2-128k |
|----------|--------:|---------:|---------:|----------:|
| **MMQ** | — | **61.0%** | **49.2%** | **42.8%** |
| **FA** | 0.4% | **27.8%** | **42.2%** | **50.2%** |
| GDN | 0.8% | 4.7% | 3.8% | 3.3% |
| GEMV_IQ3_XXS | 56.8% | 1.1% | 0.5% | 0% |
| Norm_RMS | 1.4% | 0.9% | 0.7% | 0.6% |
| Broadcast | 0.9% | 0.4% | 0.3% | 0.3% |
| Dequant | 0.1% | 0.2% | 0.3% | 0.4% |
| Other | 4.3% | 2.9% | 2.3% | 2.0% |

### 3.2 FA Growth Trend

| Arm | FA Count | FA Total ms | FA Avg ms | FA % |
|-----|---------:|------------:|----------:|-----:|
| T-V2-1k | 64 | 0.57 | 0.009 | 0.4% |
| T-V2-16k | 2,002 | 22,274 | 11.13 | 27.8% |
| T-V2-63k | 2,956 | 79,827 | 27.01 | 42.2% |
| T-V2-128k | 2,721 | 150,141 | 55.18 | 50.2% |

FA avg time grows 6x from 16k→128k (11ms→55ms per call).

### 3.3 MMQ Trend

| Arm | MMQ Count | MMQ Total ms | MMQ Avg ms | MMQ % |
|-----|----------:|-------------:|-----------:|------:|
| T-V2-16k | 52,800 | 48,948 | 0.93 | 61.0% |
| T-V2-63k | 99,200 | 93,112 | 0.94 | 49.2% |
| T-V2-128k | 136,087 | 128,153 | 0.94 | 42.8% |

MMQ avg time stable at ~0.94ms per call regardless of context. Total MMQ grows linearly with token count.

## 4. Phase-2/3 Verification

| Check | Result |
|-------|--------|
| Staging dequant launches | **0** (fused kernel active) ✅ |
| Phase-3 MMQ threshold | Active (no hipBLAS fallback) ✅ |
| GEMV_IQ3_XXS dominance | Confirmed (82.5% of decode GEMV) ✅ |
| FA overhead at decode | Minimal (0.4% at 1k context) ✅ |

## 5. Effective Bandwidth (Decode)

| Quant | Avg GEMV ms | Grid Size | Effective BW | vs Nominal 624 GB/s |
|-------|------------:|----------:|-------------:|--------------------:|
| IQ3_XXS | 0.131 | 371K | ~23 GB/s | 3.7% |
| IQ3_XS | 0.031 | 86K | ~20 GB/s | 3.2% |
| Q4_0 | 1.458 | 7.9M | ~263 GB/s | 42.1% |

IQ3_XXS is severely bandwidth-limited due to 2.5 bits/weight (low arithmetic intensity).

## 6. Inter-Kernel Gaps

| Arm | Median Gap | P99 Gap | Total Gap |
|-----|-----------:|--------:|----------:|
| T-V2-1k | 0.009 ms | 10.55 ms | 1,105 ms |
| T-V2-16k | 0.009 ms | 0.099 ms | 2,527 ms |
| T-V2-63k | 0.009 ms | 0.066 ms | 4,238 ms |
| T-V2-128k | 0.009 ms | 0.022 ms | 5,076 ms |

Median gap consistently 0.009ms across all arms. P99 gap decreases with context (more batching).

## 7. Trace Data

| Arm | Dispatches | Trace Size | Status |
|-----|----------:|----------:|--------|
| T-V2-1k-OFF | 4,879 | 2.8 MB | ✅ Complete |
| T-V2-16k-OFF | 220,409 | 130 MB | ✅ Complete |
| T-V2-63k-OFF | 363,377 | 215 MB | ✅ Complete |
| T-V2-128k-OFF | 411,033 | 244 MB | ⚠️ Prefill only (timeout) |

## 8. Verification

- Model path verified: `/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf` (10G)
- Binary verified: build-p3/bin/llama-server (HIP backend, Phase-2/3 commits)
- VRAM guard: 14.9 GiB / 16 GiB (below 15.5 GiB limit)
- Phase-2 staging dequant: 0 launches (fused kernel active)

**STATUS: TRACE_OK**
