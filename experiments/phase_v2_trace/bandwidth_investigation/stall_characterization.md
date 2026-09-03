# Stall Characterization (Gaps > 1 ms in Decode)

Source: `D/results_trace_D.csv` split at `d_load_end_idx` and last `mul_mat_q` (MMQ).
Timestamp units: differences divided by 1e6 yield ms (matches analysis.json).

| Arm | Gap # | Preceding Kernel | Following Kernel | Gap ms | Decode Idx | Approx Token | Layer | Repeatable? |
|-----|-------|------------------|------------------|--------|------------|--------------|-------|-------------|
| 1k | 1 | `rms_norm_f32<...>` | `__amd_rocclr_copyBuffer.kd` | 17.27 | 2 | ~0 | UNCERTAIN (needs layer mapping) | Systematic (same idx across tokens) |
| 1k | 2 | `__amd_rocclr_copyBuffer.kd` | `rms_norm_f32<...>` | 12.65 | 4127 | ~2 | UNCERTAIN | Systematic |
| 1k | 3 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 2.13 | 2221 | ~1 | UNCERTAIN | Systematic |
| 1k | 4 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.37 | 55393 | ~30 | UNCERTAIN | Stochastic (scattered) |
| 1k | 5 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.17 | 62989 | ~34 | UNCERTAIN | Stochastic |
| 1k | 6 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.00 | 57292 | ~31 | UNCERTAIN | Stochastic |
| 16k | 1 | `rms_norm_f32<...>` | `__amd_rocclr_copyBuffer.kd` | 15.37 | 2 | ~0 | UNCERTAIN | Systematic |
| 16k | 2 | `__amd_rocclr_copyBuffer.kd` | `rms_norm_f32<...>` | 13.53 | 4127 | ~2 | UNCERTAIN | Systematic |
| 16k | 3 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 2.92 | 2221 | ~1 | UNCERTAIN | Systematic |
| 16k | 4 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.16 | 87676 | ~47 | UNCERTAIN | Stochastic |
| 16k | 5 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.10 | 64888 | ~34 | UNCERTAIN | Stochastic |
| 16k | 6 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.03 | 17413 | ~9 | UNCERTAIN | Stochastic |
| 63k | 1 | `__amd_rocclr_copyBuffer.kd` | `rms_norm_f32<...>` | 16.28 | 4126 | ~2 | UNCERTAIN | Systematic |
| 63k | 2 | `rms_norm_f32<...>` | `__amd_rocclr_copyBuffer.kd` | 16.05 | 2 | ~0 | UNCERTAIN | Systematic |
| 63k | 3 | `__amd_rocclr_copyBuffer.kd` | `rms_norm_f32<...>` | 9.98 | 70591 | ~38 | UNCERTAIN | Stochastic |
| 63k | 4 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 2.83 | 2220 | ~1 | UNCERTAIN | Systematic |
| 63k | 5 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 1.98 | 68685 | ~37 | UNCERTAIN | Stochastic |
| 128k | 1 | `__amd_rocclr_copyBuffer.kd` | `rms_norm_f32<...>` | 15.95 | 4124 | ~2 | UNCERTAIN | Systematic |
| 128k | 2 | `rms_norm_f32<...>` | `__amd_rocclr_copyBuffer.kd` | 15.76 | 2 | ~0 | UNCERTAIN | Systematic |
| 128k | 3 | `mul_mat_vec_q<...>` (GEMV) | `__amd_rocclr_copyBuffer.kd` | 3.54 | 2220 | ~1 | UNCERTAIN | Systematic |

Notes:
- Systematic stalls occur at decode index 2 (token ~0) and index ~4124-4127 (token ~2). All arms show these.
- Additional stalls occur at decode index ~2220 (token ~1) across all arms, preceded by GEMV.
- Stochastic stalls (index >50000, token >30) appear only in some arms (e.g., 63k at token ~38 with 9.98 ms gap). These are not consistent across arms.
- Layer mapping requires parsing the layer index embedded in some kernel names (e.g., `flash_attn_tile`) but is not directly available in CSV; marked UNCERTAIN.
