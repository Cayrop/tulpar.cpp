# Occupancy Analysis — IQ3_XXS vs Q3_K vec_dot

## Hardware Limits (gfx1101 / RX 7800 XT)
- 60 CUs, 2 SIMDs per CU, wavefront = 32 lanes
- 1024 max threads/CU, 32 max waves/CU
- Per-thread VGPR file: 256 max (RDNA3)
- Per-thread SGPR file: 256 max
- Per-CU total VGPR file: 65,536 (256 × 256)
- L1 / scalar: 32 KB per CU
- L2: 4 MB shared
- Shared memory per workgroup: 64 KB max (rarely used in vec_dot kernels)

## Launch Geometry (from `mmvq.cu:452-471, 524-541`)
For RDNA3_0 (gfx1101) and `ncols_dst = 1` (decode single-token GEMV):

| Param | IQ3_XXS | Q3_K |
|-------|--------:|-----:|
| nwarps | 1 | 1 |
| rows_per_block | 1 | 1 |
| block_dims | (32, 1, 1) | (32, 1, 1) |
| `__launch_bounds__` | (32, 1) | (32, 1) |
| shared memory | 0 (no `__shared__` declared in `vec_dot_*`) | 0 |
| vdr | 2 | 1 |
| qi | 4 | 4 |
| blocks_per_iter | 16 | 8 |

Both kernels are `__launch_bounds__(32, 1)` → 1 block per CU target.

## Register Pressure
Direct measurement of the actual built kernels is **UNCERTAIN** — the device object files in `build-p3/` are host-side stubs, and no `--save-temps` artifact was preserved. A minimal reconstruction of the IQ3_XXS inner loop compiled with `--save-temps` (`/tmp/opencode/reg_check.hip` → `reg_check-hip-amdgcn-amd-amdhsa-gfx1101.s`) reports `vgpr_count: 3, sgpr_count: 21` — but this is the trivial stand-in, not the real kernel.

### Estimated VGPR for real kernel
The real `vec_dot_iq3_xxs_q8_1` body needs to hold:
- `q3_packed` (2 int = 8 B → 2 vgprs)
- `aux32` (1 vgpr)
- per-iter temporaries: `grid_pos.x`, `grid_pos.y`, `signs`, `signs0`, `signs1`, `grid_l`, `grid_h` (≈ 7 vgprs, partially unrolled)
- `u0`, `u1` (2 vgprs)
- `sumi` (1 vgpr)
- Plus Q8_1 ds (1 vgpr), d (1 vgpr), `ls` (1 vgpr)

Estimated: **20-30 VGPRs/thread**. Q3_K body is shorter (no `grid_pos` or signs):
- `vl`, `vh` (2 vgprs)
- per-iter: `vil`, `vih`, `vi`, `sc` ≈ 4 vgprs
- `u[i]`, `d8[i]`, `sumf` ≈ 4-5 vgprs

Estimated: **15-20 VGPRs/thread**.

These are estimates, **not measured**. The exact number matters less for occupancy because both are well under the 256-VGPR limit and the launch bounds are already 1 block per CU (32 threads).

## Occupancy (theoretical)

| Metric | IQ3_XXS | Q3_K |
|--------|--------:|-----:|
| Threads per block | 32 | 32 |
| `__launch_bounds__` blocks/CU | 1 | 1 |
| Theoretical waves/CU | 1 | 1 |
| Achieved wave fraction (decode) | 1/32 (only 1 of 32 max waves active) | 1/32 |
| SMs occupied per kernel launch | 60 CUs × 1 block = 60 active blocks | 60 CUs × 1 block = 60 active blocks |

For ncols_x=1536 row count: nrows_x ≈ 32 (typical attention output projection). 60 active blocks for one row of 32 → only 60 blocks, each with 12 active lanes = **720 active lanes total**. The GPU has 60 × 32 = 1920 lanes. **Effective lane utilization ≈ 37.5 %** for the active kernel, and **kernel launch utilization ≈ 60/60 CUs = 100 % but only 1 block each**.

For a larger row count (e.g. nrows_x = 4096 = MLP gate up): 4096 blocks, 60 CUs × 1 block per CU = 60 in flight, 4096/60 ≈ 68 waves per CU. Each wave processes 12 active lanes. So total useful work = 4096 blocks × 12 lanes = 49,152 vec_dots, but only 60 × 32 = 1920 lanes run at any moment → **throughput-limited by the per-active-thread cost, not by launch occupancy**.

## Why occupancy is low and why it doesn't help

The kernel is launched with `__launch_bounds__(32, 1)`. This means the compiler is told to optimize for ≤ 1 block per CU (32 threads). With 60 CUs, peak concurrent threads = 1920. For a 4096-row GEMV, only 60/60 = 100 % of CUs are active but each only has 1 block (1/32 of max waves). The hardware is **mostly idle** on the lane dimension.

If we doubled the block size to 64 threads (2 warps), the compiler could pack 2 rows per block, doubling lane utilization to 24/32. But `calc_nwarps` for RDNA3_0 explicitly returns 1 for IQ3_XXS, citing "register pressure and lookup table contention at higher thread counts" (line 430-431, referring to RDNA4 but the same whitelist pattern applies).

## Whether occupancy is the bottleneck
**No.** The kernel is single-warp-per-CU, which is fine because:
- Each warp does substantial work (one full row of vec_dots).
- More warps per CU would not help VRAM bandwidth — they would compete for the same 525 GB/s pipe.
- The per-active-thread work (8 dp4a + 8 dep global loads) is the cost, not the lane count.

## UNCERTAIN Items
- Exact VGPR count of the real kernel (not measured).
- Whether the AMD compiler respects the `__launch_bounds__(32, 1)` and stays within 1 block per CU, or spills to 2 blocks.
- Shared memory usage in the parent `mul_mat_vec_q` (there is a `__shared__ float tmp_shared` for the warp reduction, but with nwarps=1 it degenerates to size 1).
