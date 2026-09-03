# Stall Pattern Analysis

Data: decode gaps from `results_trace_D.csv` for 1k/16k/63k/128k.
Split: inference start = index after largest gap (>1e8 after idx 100); decode start = index after last `mul_mat_q` (MMQ) in inference segment.

## 1. Systematic vs Stochastic

- Systematic (same index across tokens): Gaps at decode index 2 (token ~0) and ~4124-4127 (token ~2) appear in ALL arms (1k, 16k, 63k, 128k) with duration 15-17 ms. Repeatability = 100% for these positions.
- Systematic (same relative token): Gap at index ~2220 (token ~1, GEMV -> copyBuffer) appears in ALL arms (2-3.5 ms). Repeatability = 100%.
- Stochastic: Gaps at index >50000 (token >30) vary by arm. Example: 63k shows 9.98 ms at idx 70591 (~token 38); 1k shows 1.37 ms at idx 55393 (~token 30). These are NOT consistent across arms or tokens.

## 2. Correlation with Kernel Types

- Largest stalls (15-17 ms) always occur at a boundary involving `rms_norm_f32` and `__amd_rocclr_copyBuffer.kd`. This is a norm-to-system-copy transition.
- Medium stalls (2-3.5 ms) always occur at GEMV (`mul_mat_vec_q`) to `__amd_rocclr_copyBuffer.kd` boundary.
- Small scattered stalls (1-2 ms) also occur at GEMV -> `__amd_rocclr_copyBuffer.kd`.
- No stalls occur after `FA_tile`, `GDN`, `Norm_L2`, or `Quantize_q8_1` (except at token 0 boundary).
- The stalls do NOT occur at graph boundaries; the decode phase uses a single reused graph (`graphs reused = 63` from server log). The stalls are intra-graph.

## 3. First-Token vs Subsequent Tokens

- The 15-17 ms stalls occur at token ~0 and token ~2 (first decode tokens after prefill). This suggests a warm-up/allocation effect, not a per-layer systematic overhead.
- The 2-3.5 ms stall at token ~1 is also early in the decode sequence.
- Later stalls (token >30) are stochastic and do not show a clear warm-up pattern.

## 4. Context Size Correlation

- Systematic stalls (token 0, 1, 2) are present for ALL context sizes (1k, 16k, 63k, 128k) with similar durations (15-17 ms, 2-3.5 ms). Duration does NOT grow with context size.
- Stochastic stalls vary: 63k shows a larger 9.98 ms stall at token ~38; 128k shows no stall >1 ms beyond token ~2. Number of stalls per token does NOT scale with context.
- This indicates the stalls are NOT related to KV cache size or attention computation (which scales with context), but rather to initial pool/state setup or scheduling.

UNCERTAIN: Whether the 9.98 ms stall at token ~38 in 63k is a stochastic outlier or a systematic layer-boundary effect requires mapping kernel indices to exact layer numbers (not available in CSV).
