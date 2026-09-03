# Verdict — IQ3_XXS Bandwidth Limit Investigation

## Summary

The IQ3_XXS GEMV kernel achieves 350.7 GB/s effective bandwidth on gfx1101. The **practical VRAM ceiling is 525 GB/s** (measured by a 1 GB sequential microbenchmark). The kernel is at 66.8 % of the VRAM ceiling and 56.2 % of the nominal 624 GB/s spec. The Q3_K kernel (503.6 GB/s) hits 96 % of the same VRAM ceiling, confirming the ceiling is real and reachable.

## Classification: **MIXED — Bandwidth-underutilized, root cause is per-thread latency of the gather chain**

| Metric | Value |
|--------|------:|
| IQ3_XXS measured bandwidth | 350.7 GB/s |
| Measured VRAM ceiling (1 GB read) | 525 GB/s |
| Measured IC ceiling (32 MB) | 719 GB/s |
| Gap to VRAM ceiling | **1.50× (kernel is 33 % below ceiling)** |
| Gap to IC ceiling | 2.05× |
| Q3_K reference bandwidth | 503.6 GB/s (96 % of ceiling) |
| Compute utilization (DP4A) | < 0.001 % (compute is irrelevant) |
| Per-vec-dot dependent load count (IQ3_XXS) | 8 |
| Per-vec-dot dependent load count (Q3_K) | 0 |

## Key Findings

1. **350 GB/s is NOT at the hardware limit.** The measured VRAM ceiling is 525 GB/s. The kernel is 33 % below it.

2. **Q3_K achieves 96 % of the same ceiling** (503 GB/s out of 525 GB/s). This proves the hardware can deliver more than IQ3_XXS extracts.

3. **Compute is utterly irrelevant.** The kernel uses < 0.001 % of DP4A peak. The bottleneck is not arithmetic.

4. **The lookup table is not the bandwidth bottleneck** (1 KB, all in L1). The bottleneck is the **dependent-load chain** in the vec_dot inner loop:
   - 8 dependent global loads to `iq3xxs_grid[]` per vec_dot
   - 8 dp4a per vec_dot (vs 2 for Q3_K)
   - Each gather load is on the critical path of an inner iter

5. **Q3_K is faster per byte by 43 %** (1.99 vs 2.85 ns/kB) because it has zero dependent loads in the inner loop (dequant is register-only). The 1.43× per-byte ratio matches the 1.43× bandwidth ratio (350/503), confirming the per-call overhead translates directly to bandwidth underutilization.

6. **Lane utilization is similar** for both kernels (~12/32 active for ncols_x=1536). The 43 % gap is **not** explained by occupancy — both kernels have the same launch geometry (1 warp per block, `__launch_bounds__(32, 1)`).

## What This Means for Hypothesis Phase

- "IQ3_XXS is at hardware limit" → **REFUTED.** It is 33 % below the measured ceiling.
- "IQ3_XXS has N % headroom" → **CONFIRMED.** N ≈ 33-50 % depending on how aggressive the ceiling is (VRAM vs IC vs gather).
- The headroom comes from **per-thread latency hiding, not from VRAM-side changes**. The bytes still need to be read; the question is whether the kernel can keep the pipe full.

## Hypotheses (for next phase, not implemented here)

The 1.5× gap can be closed by:
- **Reducing dependent loads in the chain** (e.g. cache iq3xxs_grid in shared memory or constant memory and use broadcast loads; or unroll the table into per-thread constants).
- **Increasing in-flight warps** (currently 1 warp per CU on RDNA3; could be raised by reducing per-thread register pressure or accepting the contention cost).
- **Reordering loads** to overlap more independent Q8_1 fetches with the table gather.

These are hypothesis topics. No kernel change is proposed in this report.

## UNCERTAIN Items
- Exact VGPR count of the real `vec_dot_iq3_xxs_q8_1` (not measured; estimated 20-30 from manual inspection).
- Whether the 1.5× gap is the same across all 60 CUs or whether a few CUs are slower.
- Real-world benefit of moving `iq3xxs_grid` to shared memory (the L1 hit rate is already high; explicit sharing would only help across warps).

## End Condition
**BANDWIDTH_INVESTIGATION_OK**
