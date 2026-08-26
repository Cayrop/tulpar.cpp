# Phase-4A V1 LDS Table Variant Report

Date: 2026-08-25 00:30 - 01:20 +03
Repo: <REPO_ROOT> @ tulpar/main (no source/model/build changes; experiments/ untracked)
GPU: RX 7800 XT gfx1101, ROCm 7.2.4, rocprofv3 1.1.0
Scope: measurement only. llama.cpp sources untouched, no new llama.cpp build,
production server NOT stopped (PID 5521 resident throughout, health {"status":"ok"}
checked after all runs). Harness runs were standalone processes alongside production.

## Final verdict

V1_BIT_EXACT_BUT_SLOW

V1 is bit-exact against V0 but does not reduce the stall ratio and does not
improve GB/s on either shape. The LDS bank-conflict risk was measured, not
assumed: it materialized at a 62-66% conflict rate on index-active LDS cycles.
This is a clean NEGATIVE RESULT under the Task-4 criteria -> recommend V3/V4.

## 1. Implementation

File changed: `experiments/phase3/synthetic/mmvq_bench.hip` (harness only;
experiments/ is not git-tracked, so no patch file - changes summarized here).

Diff summary:
1. Added `vec_dot_iq3_xxs_q8_1_lds()`: verbatim copy of
   `vec_dot_iq3_xxs_q8_1` except grid lookups read through a
   `const uint32_t * grid` parameter instead of the global `iq3xxs_grid`.
   All arithmetic identical (same sign-expansion ops, same v_dot4 order).
2. Kernel template extended: `mul_mat_vec_q<type, ncols_dst, has_fusion,
   nwarps_tbl = calc_nwarps<type>(ncols_dst), lds_grid = false>`.
   Defaults reproduce V0 exactly. `nwarps_tbl` exists only for the calibration
   sweep (simulates an RDNA3 table change; vec_dot internals untouched).
3. V1 prologue: cooperative stage of iq3xxs_grid (256 u32 = 1 KB) into
   `__shared__ uint32_t s_grid[256]` before the K-loop
   (`for i=tid; i<256; i+=nwarps*warp_size`, fully unrolled), then one
   __syncthreads(). All threads reach the barrier (it precedes any return).
4. Loop body: IQ3_XXS branch calls the _lds vec_dot when lds_grid=true,
   else the original. Everything else (load widths, accumulation, reduction,
   fused GLU path) untouched.
5. Dispatch/bench plumbing: variant + nwarps_ovr parameters, per-rep spread
   (min/p10/p90/max), and a `verify` CLI mode that runs V0 and V1 on the same
   seeded buffers and compares dst byte-for-byte.

### ISA diff (gfx1101, main K-loop back-edge span, archived in raw/)

| kernel | inst/trip | global loads | ds_load | v_dot4 | waitcnt pattern |
|---|---|---|---|---|---|
| V0 down <18,1,f=0,nw=1,lds=0> | 414 | 14 total: 10x b32 (8 = grid gathers), 2x b128, b64+d16hi | 0 | 8 | lgkmcnt(0) -> vmcnt(2) staged drain vmcnt(9)..vmcnt(0) |
| V1 down <18,1,f=0,nw=1,lds=1> | 413 | 6 total: 2x b32, 2x b128, b64+d16hi | **8x ds_load_b32** | 8 | vmcnt(5),(4) then staged lgkmcnt(7)..lgkmcnt(0), vmcnt(3),(1),(0) |
| V0 gateup <18,1,f=1> | 918 | 25 total (19x b32 incl. 16 gathers) | 0 | 16 | vmcnt(1),(2),(0) |
| V1 gateup <18,1,f=1,lds=1> | 781 | 9 total (3x b32) | **16x ds_load_b32** | 16 | vmcnt(5..0) + lgkmcnt(11..0) |

Structural evidence: the 8 dependent global gathers per trip became 8
ds_load_b32 per trip (x2 for fused). Trip instruction count unchanged (~414),
so the change is storage-level only, as intended. Note V1's waitcnt chain now
tracks LDS dependencies via lgkmcnt staging - the dependency STRUCTURE is
unchanged, only the transport changed.

Kernel metadata: VGPR 76->75 (down), 33->92 (gateup fused, occupancy cap
64->51 blocks/CU by API estimate). No spills in either variant.

## 2. Bit-exact verification

IDENTICAL on both shapes (raw/verify_final.txt):

| shape | result | max abs diff | differing elements | checksum V0 | checksum V1 |
|---|---|---|---|---|---|
| ffn_down K17408 N5120 unfused | IDENTICAL | 0 | 0 | 00000af897815461 | 00000af897815461 |
| gateup K5120 N17408 fused pair | IDENTICAL | 0 | 0 | 00000bbf8a603eb7 | 00000bbf8a603eb7 |

Fixed seed (42+type+K), same buffers, byte-for-byte float compare of all N outputs.

## 3. Timing table

batch=1, median of 100 reps (min/p10/p90/max in raw/timing_batch1.txt):

| variant | shape | ms | GB/s | delta vs V0 |
|---|---|---|---|---|
| V0 | ffn_down 17408x5120 | 0.1396 | 164.7 | - |
| V1 | ffn_down 17408x5120 | 0.1400 | 164.1 | -0.4% |
| V0 | gateup 5120x17408 fused | 0.2493 | 184.3 | - |
| V1 | gateup 5120x17408 fused | 0.2588 | 177.6 | -3.7% |

V0 baselines reproduce Phase-3 (165 / 184 GB/s) within run-to-run noise.
The gateup p90 ranges do not overlap (0.2530 vs 0.2582): the regression is real.
Reproduced across three separate invocations during smoke testing.

## 4. HW counter table

rocprofv3 --pmc, avg over 35 dispatches (down) / 36 (gateup) incl. warmups;
two counter sets because gfx1101 rejects >~9 PMCs in one group (raw/counters_derived.txt,
CSVs raw/rocprof/*/). Overlapping counters deduped by max; set-to-set agreement <2%.

| variant | stall ratio (SQ_WAIT_INST_ANY/SQ_WAVE_CYCLES) | VMEM cycles | LDS insts (SQ_INSTS_LDS) | SQ_WAIT_INST_LDS | bank conflicts | waves/SIMD | L2 hit |
|---|---|---|---|---|---|---|---|
| V0 down | 73.9% | 1.81M | 25.6K (reduction only) | ~1.1K | 0 | 5.30 | 6.1% |
| V1 down | **78.7%** (+6.5% rel) | 1.97M (+8.6%) | 763K | 97.7K | **1,498,260** | 5.20 | 6.4% |
| V0 gateup | 61.3% | 3.27M | 169K | 0.7K | 0 | 6.17 | 19.5% |
| V1 gateup | **82.1%** (+33.9% rel) | 3.79M | 1.66M | 189.7K | **2,913,033** | 6.17 | 15.9% |

Note: SQ_INST_CYCLES_LDS does not exist on this stack (archived list
experiments/phase3/raw/isa/avail_metrics.txt); SQ_INSTS_LDS +
SQ_WAIT_INST_LDS are the available substitutes and are reported instead.
Phase-3 baseline cross-check with identical method/formulas: V0 down stall
73.9% vs their 76.7%, waves/SIMD 5.30 vs 5.44, L2 hit 6.1% vs 6.1%, VMEM
cycles 1.81M vs 1.81M - consistent within clock-state variance (sclk idles at
26 MHz between our short kernels; identical conditions for both variants).

## 5. Bank conflict analysis

Measured, not assumed (SQC_LDS_BANK_CONFLICT):

| variant | conflicts/dispatch | rate per LDS inst | rate per idx-active cycle |
|---|---|---|---|
| V0 down | 0 | 0% | 0% |
| V1 down | 1,498,260 | 196% | **65.5%** |
| V0 gateup | 0 | 0% | 0% |
| V1 gateup | 2,913,033 | 176% | **61.4%** |

Does it erase the gain? YES - worse: there is no gain to erase. The random
per-lane grid indices (byte values from q3) scatter across all 32 banks, so
~62-66% of index-active LDS cycles stall on conflicts. Combined with the fact
that the original gathers already hit L1 (~LDS-comparable latency for a hot
1 KB table), the chain got LONGER, not shorter: stall ratio rose on both
shapes and duration followed (-0.4% / -3.7%).

Root reading: Phase-3 diagnosed the chain as latency-bound by DEPENDENCY
STRUCTURE. V1 changed only the storage of one link (global->LDS) without
shortening the dependency distance, and paid bank-conflict serialization on
top. The diagnosis survives falsification - which is what this variant was for.

## 6. nwarps calibration (ffn_down batch=1, V0 arithmetic, 100 reps median)

| nwarps | ms | GB/s |
|---|---|---|
| 1 (RDNA3 table default) | 0.1396 | 164.7 |
| 2 | 0.1460 | 157.4 (-4.4%) |
| 4 | 0.1602 | 143.4 (-12.9%) |

Calibration only: the nwarps=1 default is optimal at batch=1 on RDNA3 for
this shape; increasing block size hurts (more trips coalesced into fewer
threads-worth of independent chains per wave, plus larger blocks reduce
co-residency: occ 64->32->16 blocks/CU). Confirms Phase-3 item 4 was rightly
deprioritized. Do not pursue nwarps changes further.

## 7. Decision against criteria

- Condition 1 (bit-exact IDENTICAL): PASS (both shapes, max diff 0)
- Condition 2 (stall ratio reduced >= 20% rel): FAIL - increased:
  down +6.5% rel (73.9% -> 78.7%), gateup +33.9% rel (61.3% -> 82.1%)
- Condition 3 (bank conflicts erase <= 50% of gain): FAIL - measured conflict
  rate 62-66%; added LDS time exceeds any gain (net effect negative)
- Condition 4 (>= 25% GB/s improvement on >= 1 shape): FAIL -
  best delta is -0.4% (down), worst -3.7% (gateup)

## 8. Recommendation

NEGATIVE RESULT. Record V1 as falsified and move to:

1. V4 (two-chain ILP) - strongest prior evidence: the phase-3 b1->b2 natural
   experiment (+65% throughput from one extra independent chain) directly
   predicts its upside without touching the numerical path of any dot product.
2. V3 (software pipelining) - attacks the vmcnt(0)-per-trip drain; harder,
   keep second.
Do NOT pursue V2 (arithmetic table replacement) as a latency fix on the same
theory as V1 unless it also SHORTENS the dependency distance (e.g. removing
the lookup entirely rather than relocating it); note V1 shows the gather link
itself is not the dominant cost - L1-resident global gathers behave like LDS.
Any future candidate must still pass agents.md section 15 gates before integration.

## 9. Artifacts

- Harness source: experiments/phase3/synthetic/mmvq_bench.hip (modified; see
  section 1; binary rebuilt in place via ./build.sh)
- Timing log: raw/timing_batch1.txt (100 reps, medians + min/p10/p90/max)
- Verify log: raw/verify_final.txt
- ISA: raw/isa_full.s (full disassembly), raw/isa_v{0,1}_{down,gateup}.s
  (per-kernel), raw/isa_loop_analysis.txt (per-trip counts)
- Counters: raw/rocprof/{v0,v1}_{down,gateup}/set{A,B}_counter_collection.csv
  (+ agent_info, stdout/stderr), derived metrics raw/counters_derived.txt
- Production discipline: server never stopped (PID 5521, build-p3 binary);
  VRAM 84-85% allocated by production, harness peak < 0.5 GB, no contention
  events; GPU compute idle between kernels (rocm-smi GPU use 1-6%);
  health endpoint {"status":"ok"} verified after all measurements.
