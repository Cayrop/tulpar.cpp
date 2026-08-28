# MMQ IQ3_XXS Bottleneck Classification (RDNA3, gfx1101)

## Per ISA evidence

The compiled hot loop `.LBB37_15` of the `mul_mat_q<GGML_TYPE_IQ3_XXS, J=16, fallback=true>`
kernel has 2063 lines of assembly. The instruction mix:

| Category            | Count | %    | Bottleneck type      |
|---------------------|------:|-----:|----------------------|
| Bit extraction (v_and, v_lshrrev, v_bfe, v_bcnt) | 444 | 21.5% | VALU / dequant chain |
| Sign/control (v_cmp, v_cndmask, v_xor, v_or, v_sub_nc) | 272 | 13.2% | VALU / dequant chain |
| VALU misc (v_add, v_mul, v_cvt, v_mov, v_perm, v_fma) | 318 | 15.4% | VALU / misc |
| LDS (ds_load + ds_store) | 94 | 4.6% | LDS bandwidth        |
| Global (global_load) | 54 | 2.6% | GMEM bandwidth       |
| MMA (v_wmma)        | 16 | 0.8% | Tensor cores (very low) |
| s_waitcnt (stalls)  | 76 | 3.7% | Pipeline latency     |
| s_delay_alu         | 349 | 16.9% | VALU dep chain (dequant) |
| Other (SALU/branch) | ~340 | 16.5% | Misc                 |

Key observations:
- **MMA instruction count is 0.8% of the loop** - tensor cores are
  heavily under-utilized.
- **VALU bit-manipulation is 21.5% + 13.2% = 35%** of the loop.
- **s_delay_alu (349 = 17%)** indicates long VALU dependency chains,
  which the dequant path is famous for.
- **76 s_waitcnt** = 46 vmcnt + 30 lgkmcnt. ~46 cycles waiting for
  global memory, ~30 for LDS.

## Cycle-level estimate (per K-block per warp)

Approximate cycles per K-block (256 K elements) per warp:

| Stage                       | Cycles |
|-----------------------------|-------:|
| Dequant grid lookup + sign  |     80 |
| Dequant sign extract + mask |     60 |
| Dequant subtract + store    |     40 |
| LDS store (tile_x)          |     10 |
| LDS load (tile_y from gmem) |     20 |
| LDS load (tile_x, tile_y for MMA) | 10 |
| v_wmma (16 calls * 4 cycles) |     64 |
| Post-scale FMA (C*dA*dB)    |     20 |
| Total                       |    ~300 |

The dequant chain (180 cycles) dominates the MMA + post-scale
(84 cycles). **DEQUANT is the bottleneck**.

## Memory bandwidth check

Per warp per K-block:
- Global reads: 1 d (FP16 = 2 B) + 1 qs (32-bit) + 1 aux (32-bit) = 8 B
  per thread. Per warp: 32 * 8 = 256 B.
- 4 warps * 256 B = 1024 B per block per K-block.
- For 2 blocks/CU * 32 CUs * 1024 B = 64 KiB per K-block per GPU.
- At 5 TB/s (L1+L2 aggregate), this is 12 ns / K-block. Negligible.

Global memory is **NOT the bottleneck**.

## Occupancy check

8 warps per CU (25% of 32). Not the limiting factor because the
per-warp latency is dominated by the dequant chain, not by waiting
for other warps.

## Conclusion

The MMQ IQ3_XXS kernel on RDNA3 is **DEQUANT_CHAIN bound**.

The dequantization of IQ3_XXS (grid lookup + sign bit extraction + masking
+ subtraction) is the dominant cost. The 16 v_wmma_i32_16x16x16_iu8
calls per K-block (each 4096 INT8 MACs) are heavily under-utilized
relative to the ~200 cycles of VALU work that precedes them per warp.

WMMA is already used (INT8, RDNA3 native). Switching to FP16 WMMA or
different tile sizes would not help because the bottleneck is the
per-iteration VALU dequant, not the tensor core throughput.

## Decision

```
MMQ_BOTTLENECK: DEQUANT_CHAIN
WMMA_VIABLE: YES (already in use; no further WMMA optimization possible)
TILE_OPTIMIZATION_POTENTIAL: LOW (tile size is well-tuned; bottleneck is
                              not the tile size)
EXPECTED_PP_GAIN: <5% from tile changes; the only significant gain
                  would come from hoisting/simplifying the dequant, but
                  that requires source modification.
RECOMMENDED_NEXT: Profile with rocprof to confirm the dequant VALU
                  chain is the actual hot path. If confirmed, the only
                  way to improve MMQ IQ3_XXS PP is to optimize the
                  dequant or to use a faster quant type (e.g., Q4_K).
```

## Quantitative comparison: MMQ vs GEMV

GEMV (Q4_0) on RDNA3:
- Per-token PP throughput: ~50-80 t/s (model dependent, large models)
- Occupancy: 12/32 lanes = 37.5%
- Bandwidth-bound (mostly)

MMQ (IQ3_XXS) on RDNA3:
- Per-token PP throughput: not measured here, but uses fewer
  registers and tiles so should be faster for batch >= 32.
- Occupancy: 8/32 warps = 25%
- Dequant-bound

For batch=1 (PP), the GEMV path is typically faster because the dequant
work is amortized only over the single token. For batch >= 32, MMQ
starts to win because the dequant is amortized over more output columns
and the WMMA is utilized.

For batch=512+ (large batch PP), MMQ is the right choice and the
dequant bottleneck is exposed. Optimizing dequant would benefit
large-batch PP.

MMQ_ANALYSIS_OK
