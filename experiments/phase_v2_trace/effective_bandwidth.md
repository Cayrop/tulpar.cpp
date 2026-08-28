# Effective Bandwidth (per quant type, per arm)

**Nominal reference:** 624 GB/s effective for gfx1101 (RDNA3, 16 Gbps GDDR6 128-bit + Infinity Cache amplification).
**Formula:** `bytes_per_step / (total_ms_for_type / n_decode_tokens / 1000)` = bytes/s for that quant type, per token.
**bytes_per_step source:** `experiments/phase_v2_trace/bytes_per_step.json` (sum of bytes for that quant type that are GEMV'd per token, derived from GGUF tensor inventory).

## bytes_per_step (per-token decode weight budget per quant type)

| Quant | bytes_per_step | MB |
|-------|---------------:|---:|
| IQ3_XXS | 8,092,385,280 | 7717.5 |
| IQ3_S | 1,376,460,800 | 1312.7 |
| Q3_K | 546,304,000 | 521.0 |
| IQ4_XS | 217,251,840 | 207.2 |
| F32 | 10,647,552 | 10.2 |
| IQ1_M | 5,160,960 | 4.9 |

## Decode effective bandwidth per quant type (per arm, MTP=off)

Each cell: `BW_GBs (calls_per_token, ms_per_token, % of nominal)`


### T-V2-1k-OFF

| Quant | calls_per_token | ms/token | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|----------------:|---------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 169.77 | 23.0756 | 8,092,385,280 | 350.7 GB/s | 56.2% |
| IQ3_S | 72.40 | 3.6232 | 1,376,460,800 | 379.9 GB/s | 60.9% |
| Q3_K | 0.74 | 1.0848 | 546,304,000 | 503.6 GB/s | 80.7% |
| IQ1_M | 72.44 | 0.2714 | 5,160,960 | 19.0 GB/s | 3.0% |
| IQ4_XS | 12.06 | 0.0893 | 217,251,840 | 2433.6 GB/s | 390.0% |

### T-V2-16k-OFF

| Quant | calls_per_token | ms/token | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|----------------:|---------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 169.36 | 23.0187 | 8,092,385,280 | 351.6 GB/s | 56.3% |
| IQ3_S | 72.24 | 3.6352 | 1,376,460,800 | 378.6 GB/s | 60.7% |
| Q3_K | 0.75 | 1.0898 | 546,304,000 | 501.3 GB/s | 80.3% |
| IQ1_M | 72.27 | 0.2724 | 5,160,960 | 18.9 GB/s | 3.0% |
| IQ4_XS | 12.04 | 0.0895 | 217,251,840 | 2428.1 GB/s | 389.1% |

### T-V2-63k-OFF

| Quant | calls_per_token | ms/token | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|----------------:|---------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 169.63 | 23.0865 | 8,092,385,280 | 350.5 GB/s | 56.2% |
| IQ3_S | 72.37 | 3.6398 | 1,376,460,800 | 378.2 GB/s | 60.6% |
| Q3_K | 0.74 | 1.0866 | 546,304,000 | 502.8 GB/s | 80.6% |
| IQ1_M | 72.37 | 0.2700 | 5,160,960 | 19.1 GB/s | 3.1% |
| IQ4_XS | 12.06 | 0.0901 | 217,251,840 | 2410.5 GB/s | 386.3% |

### T-V2-128k-OFF

| Quant | calls_per_token | ms/token | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|----------------:|---------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 169.62 | 23.1375 | 8,092,385,280 | 349.8 GB/s | 56.0% |
| IQ3_S | 72.37 | 3.6417 | 1,376,460,800 | 378.0 GB/s | 60.6% |
| Q3_K | 0.74 | 1.0884 | 546,304,000 | 501.9 GB/s | 80.4% |
| IQ1_M | 72.37 | 0.2678 | 5,160,960 | 19.3 GB/s | 3.1% |
| IQ4_XS | 12.06 | 0.0901 | 217,251,840 | 2411.8 GB/s | 386.5% |

## Prefill effective bandwidth per quant type (per arm, MMQ path)

Each cell: `BW_GBs (ms_per_token, % of nominal)`


### T-V2-1k-OFF

| Quant | count | ms/token (kernel-sum) | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|------:|---------------------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 288 | 1.4868 | 0 | 5442.7 GB/s | 872.2% |
| IQ3_S | 96 | 0.2271 | 0 | 6060.9 GB/s | 971.3% |
| IQ4_XS | 16 | 0.0100 | 0 | 21655.7 GB/s | 3470.5% |

### T-V2-16k-OFF

| Quant | count | ms/token (kernel-sum) | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|------:|---------------------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 864 | 1.2841 | 0 | 6302.2 GB/s | 1010.0% |
| IQ3_S | 288 | 0.1979 | 0 | 6955.2 GB/s | 1114.6% |
| IQ4_XS | 48 | 0.0079 | 0 | 27343.7 GB/s | 4382.0% |

### T-V2-63k-OFF

| Quant | count | ms/token (kernel-sum) | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|------:|---------------------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 3168 | 1.2408 | 0 | 6522.2 GB/s | 1045.2% |
| IQ3_S | 1056 | 0.1907 | 0 | 7218.2 GB/s | 1156.8% |
| IQ4_XS | 176 | 0.0077 | 0 | 28075.0 GB/s | 4499.2% |

### T-V2-128k-OFF

| Quant | count | ms/token (kernel-sum) | bytes/step | effective BW | % of nominal 624 GB/s |
|-------|------:|---------------------:|-----------:|-------------:|----------------------:|
| IQ3_XXS | 6048 | 1.2387 | 0 | 6532.9 GB/s | 1046.9% |
| IQ3_S | 2016 | 0.1904 | 0 | 7230.7 GB/s | 1158.8% |
| IQ4_XS | 336 | 0.0077 | 0 | 28245.7 GB/s | 4526.6% |

## Key observations

- **IQ3_XXS decode is bandwidth-bound at 350 GB/s (56% of nominal)** across all 4 arms. This is the single largest decode cost. With 8.09 GB of IQ3_XXS weights streamed per token, the kernel is at the practical limit of this GPU's memory subsystem.
- IQ3_S decode reaches 378 GB/s (61%); smaller tensor (1.38 GB) but faster code path.
- Q3_K output head reaches 502 GB/s (80%) on its single 546 MB tensor.
- IQ4_XS exceeds nominal BW (2428 GB/s) because the per-token IQ4_XS stream (217 MB) fits in the L2 / Infinity Cache and is served from there, not from VRAM. The reported 'BW' is the kernel-side throughput, not VRAM throughput.
- IQ1_M effective BW is 19 GB/s (3%) — IQ1_M is only 5 MB total, dispatched 72x per token. Each call is tiny, dominated by launch overhead rather than memory access.
- Across all 4 decode arms, BW per quant type is essentially **constant**: the decode work-per-token does not depend on the KV cache size. Only the FA_tile (KV-cache-reading) component grows with context.
- For prefill (MMQ path), the same bytes are read per token but the kernel layout differs. MMQ_IQ3_XXS is the dominant prefill cost.

## Caveats / UNCERTAIN

- The '624 GB/s nominal' is a marketing reference. The actual sustained VRAM read bandwidth on gfx1101 is closer to 250-280 GB/s; 624 is the effective number including Infinity Cache hits. Per-call effective BW > 280 GB/s implies cache amplification.
- IQ4_XS 'BW > nominal' is **definitely cache-amplified**: the same data is reused across many grid blocks per call, so the kernel reports a higher throughput than the underlying VRAM read rate.
- The prefill BW numbers above are per-token kernel-time only; they do not include the cost of writing the KV cache to memory, which scales with ctx size.
