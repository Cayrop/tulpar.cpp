# Phase-3 GEMV Root-Cause Diagnosis Report

Date: 2026-08-24 22:00 - 23:59 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb (no source/model/build changes)
Production binary: build-p3/bin/llama-server
GPU: RX 7800 XT gfx1101 (30 WGP / 60 CU), ROCm 7.2.4, rocprofv3 1.1.0
Scope: diagnosis only. No kernel, CMake, flag, model or quantization changes.
Raw artifacts: experiments/phase3/raw/ (synthetic results, ISA disassembly,
rocprofv3 counter CSVs), experiments/phase3/synthetic/ (standalone harness).

## Final Verdict

DIAGNOSIS_COMPLETE

Root cause identified: IQ3_XXS MMVQ GEMV is memory-LATENCY bound by the
serialized gather-heavy dequant dependency chain of vec_dot_iq3_xxs_q8_1,
executed at only ~6 co-resident wavefronts per SIMD. It is NOT
DRAM-bandwidth bound and NOT directly occupancy-starved.

## 1. Workstream 3A Findings (Source & ISA)

### 1.1 Launch config (source)

- mmvq.cu:452-472 RDNA3_0 table confirmed. ncols_dst==1:
  Q4_0/Q4_1/Q5_0/Q5_1/Q8_0/IQ4_NL -> nwarps=8; Q6_K -> 2;
  everything else including IQ3_XXS -> nwarps=1 (default branch).
  ncols_dst>1 -> nwarps=1 for ALL types.
- common.cuh:374: physical warp size = 32 on gfx11 (wave64 only GFX8/9).
- So IQ3_XXS decode runs 32-thread blocks; Q4_0/Q8_0 run 256-thread blocks.
- Type constants: IQ3_XXS qk=256 qi=16 vdr=2 -> blocks_per_iter=4 K-blocks
  per wave-trip; K=17408 gives ~17 serial trips/thread.
  Q4_0 qk=32 qi=4 vdr=2 nwarps=8 -> blocks_per_iter=128; ~4.25 trips/thread.
- rows_per_cuda_block=1 for both (RDNA table path).
- small_k/halve_iters variants not used on RDNA for these shapes
  (mmvq.cu:962-966 forces use=false on RDNA).

### 1.2 Compiled kernel metadata (obj_mmvq.elf carved from libggml-hip.so fatbin)

| instantiation | workgroup | VGPR | SGPR | LDS |
|---|---|---|---|---|
| mul_mat_vec_q<type18 IQ3_XXS,1,false,false,false> | 32 | **76** | 24 | ~0* |
| mul_mat_vec_q<type2 Q4_0,1,...> | 256 | **18** | 25 | 896 B |
| mul_mat_vec_q<type8 Q8_0,1,...> | 256 | 18 | 25 | 896 B |

*IQ3_XXS LDS is dead-code-eliminated because with nwarps=1 the
threadIdx.y>0 cross-warp reduction can never execute.
No spills anywhere (vgpr_spill_count=0).

VGPR-limited occupancy estimate: 76 VGPRs allocate to 80 (granularity);
80 x 32 lanes = 2560 lane-regs/wave against ~16K VGPRs/SIMD -> max ~6
waves32/SIMD. Q4_0 (18->24 alloc) would allow >10 but is tail/grid limited
in practice. Measured residency confirms this below (5.44 vs 5.64).

IMPORTANT: hipOccupancyMaxActiveBlocksPerMultiprocessor returned an
implausible 64 blocks/CU for the 76-VGPR kernel on this stack (HIP 7.2);
do NOT trust that API here. Use SQ_WAVES-based measured residency.

### 1.3 ISA analysis (disassembly archived in raw/isa/type{18,2,8}.s)

Main K-loop bodies:

| metric | IQ3_XXS loop trip | Q4_0 loop trip | Q8_0 loop trip |
|---|---|---|---|
| instructions/trip | **452** | 76 | ~46 |
| global loads/trip | 14 | 5 | 4 |
| load widths | 2x b128, 1x b64, 2x b32, 1x d16_hi_b16, **8x b32 gathers** | 3x b64, 1x b32, d16_b16 | similar |
| v_dot4_i32_iu8 | 8 | 4 | 2 |
| shifts/xor/sub/cmp (dequant bit ops) | ~104/~17/~32/~17 | ~11/5/0/10 | few |

Load width verdict: the weight-stream loads are adequately wide and
aligned (b128 pairs cover the qs stream; offsets -32/-16 are 16B-aligned).
The problem is NOT narrow or unaligned streaming loads.

The structural difference inside the loop:
1. 8 of the 14 IQ3_XXS loads are scalar b32 GATHERS into the 1 KB
   iq3xxs_grid[256] constant table in GLOBAL memory. Their addresses depend
   on freshly loaded q3 bytes, so they sit IN the critical chain:
   load q3 -> shift/mask -> address -> gather -> xor/sub sign-expand ->
   v_dot4. Eight such dependent chains per trip.
2. The outer K-loop bound is runtime (blocks_per_row_x), so the compiler
   cannot unroll across trips; each trip ends in a staged drain ending at
   s_waitcnt vmcnt(0) before the next trip's loads issue. There is no
   software pipelining across trips. (Q4_0 has the same no-cross-trip
   overlap property, but its chains are short enough that it does not care.)
3. Per-byte instruction density: IQ3_XXS moves ~264 B of weights per
   wave-trip at ~452 instructions = ~1.7 inst/B. Q4_0 covers ~288 B per
   wave at 76 instructions = ~0.26 inst/B. ~6.5x denser statically;
   measured dynamically 13x (section 2.3).

### 1.4 Replica validation

experiments/phase3/synthetic/mmvq_bench.hip replicates the kernel +
RDNA3 launch table + vec_dot functions outside llama.cpp sources. Its
gfx1101 disassembly was diffed against production obj_mmvq.elf: hot-loop
op counts match exactly (14 loads same widths, identical VALU mix incl.
48x v_lshlrev_b16, 32x v_and_b16, 32x v_sub_nc_i16, 8x v_dot4); only the
scalar prologue differs (kernarg loading/fastdiv setup). Timing conclusions
therefore transfer to the production kernel.

## 2. Workstream 3B Findings (Synthetic & Counters)

Window note: operator approved downtime; production was stopped via
ops/bin/prod_stop.sh (validated pidfile PID 579238). A desktop session
crash (hyprland) then killed the first benchmark pass mid-run; operator
switched to KDE Plasma 6 and instructed restart-server-then-rerun. Final
runs executed with production resident-but-idle (verified
requests_processing=0 before and after); numbers reproduced the pre-crash
pass within ~1.5%, so the deviation does not affect conclusions.

Harness bug found during rerun: the fused-GLU path originally dispatched
vec_dot_iq3_xxs_q8_1 regardless of tensor type; on Q4_0/Q8_0 buffers that
reads out of bounds (18/34 B block stride treated as 66 B) and page-faults
the GPU. Fixed with proper type dispatch. Operator independently suspected
a benchmark-side indexing/memory error; confirmed. Production kernels are
NOT affected (they dispatch via vec_dot_q_cuda).

Launch-count evidence: production decode executes the FUSED gate+up MMVQ
variant: GGUF inventory gives 48 GDN layers x 5 + 17 dense layers x 3 = 288
possible IQ3_XXS launches/token if unfused, but phase-2B traced 224.5/token
which matches fused gate+up exactly (48x4 + 17x2 = 226 minus blk.64 whose
FFN is IQ4_XS -> 224). Hence the harness benchmarks both unfused down and
fused gate/up configurations.

### 2.1 Synthetic GB/s at batch=1 (median of 100 reps, full log raw/synthetic_results_rerun.txt)

| config | ms | weight-only GB/s |
|---|---|---|
| ffn_down K17408 N5120 IQ3_XXS (nwarps=1) | 0.1392 | **165** |
| ffn_down K17408 N5120 Q4_0 (nwarps=8) | 0.0470 | 1068 |
| ffn_down K17408 N5120 Q8_0 (nwarps=8) | 0.1717 | 552 |
| gateup K5120 N17408 IQ3_XXS FUSED pair | 0.2492 | 184 |
| gateup K5120 N17408 Q4_0 FUSED pair | 0.0924 | 1085 |
| gateup K5120 N17408 Q8_0 FUSED pair | 0.1704 | 1112 |

CAVEAT (methodology): repeated back-to-back launches re-read the SAME
tensor; Q4_0/Q8_0 tensors (50/95 MB) partially fit the 64 MB Infinity
Cache, so their >624 GB/s numbers are cache-inflated and must not be read
as DRAM capability. This inflation is itself diagnostic: even with
cache-resident data available, IQ3_XXS cannot exceed 165-184 GB/s - it
cannot even spend cache bandwidth. Isolated absolute times also carry
launch/event overhead (~10-20us on 130us) and do not benefit from HIP-graph
back-to-back boosting, which explains why production shows 262 GB/s while
the isolated harness shows 165-184 GB/s. Direction and ratios are the
reliable signals here.

### 2.2 Batch scaling 1/2/4/8

ffn_down shape (weight-only GB/s):

| batch | IQ3_XXS | Q4_0 | Q8_0 |
|---|---|---|---|
| 1 | 165 | 1068 | 552 |
| 2 | 152 | 867 | 531 |
| 4 | 130 | 539 | 527 |
| 8 | 100 | 313 | 413 |

Fused gateup IQ3_XXS: b1 184 -> b2 304 -> b4 260 -> b8 210 GB/s.
Note the clean natural experiment: IQ3_XXS uses nwarps=1 at every batch, so
its b1->b2 jump (+65% throughput at DOUBLE the work) is attributable purely
to adding one more independent dependency chain per thread - better latency
hiding, not more bandwidth. Beyond b2 the extra VALU work per byte wins and
throughput decays again. Q4_0 b1->b2 conflates the nwarps 8->1 table change
and is not directly comparable.

Interpretation: latency hiding works when independent chains exist and
fails when bytes-per-chain is fixed. Consistent with latency-bound, not
access-pattern-bound.

### 2.3 HW counters (rocprofv3 --pmc, batch=1, avg over 25 dispatches; CSVs in raw/rocprof/)

gfx1101 substitutes: TCC_* -> GL2C_*; SQ_INSTS_VMEM -> SQ_INST_CYCLES_VMEM;
SQ_WAIT_INST_VMEM covered by SQ_WAIT_INST_ANY. Available-name list archived
(raw/isa/avail_metrics.txt).

| derived metric | IQ3_XXS down | Q4_0 down | IQ3_XXS fused gateup |
|---|---|---|---|
| kernel duration | 129.3 us | 49.0 us | 241.7 us |
| waves launched | 5120 | 40960 | 19720 |
| avg resident waves/SIMD | **5.44** | **5.64** | 6.33 |
| VALU issue utilization | 35.7% | 14.7% | 35.4% |
| wave-cycles per VALU inst | 15.2 | 38.4 | 17.9 |
| L2 hit rate (GL2C_HIT/(HIT+MISS)) | 6.1% | 3.5% | 22.4% |
| SQ_WAIT_INST_ANY / SQ_WAVE_CYCLES | **76.7%** | **2.0%** | 54.2% |
| GL2C_MC_RDREQ x 128B vs tensor size | 23.4 MB / 23.0 MB | 50.2 MB / 50.3 MB | 23.1 MB / 45.9 MB(2 mats, y shared) |

Reading:
- Occupancy parity: despite 76 vs 18 VGPRs and 1 vs 8 warps/block, BOTH
  kernels keep ~5.5 waves resident per SIMD. The machine is equally full.
  Raw occupancy is not what separates 129us from 49us.
- Stall signature: 76.7% of all IQ3_XXS wave-cycles sit in instruction-
  wait stalls vs 2.0% for Q4_0. That is the smoking gun. Waves issue a
  burst of loads+gathers, then idle waiting on the serialized
  gather->expand->dp4a chains, then drain to vmcnt(0) per trip.
- VALU is NOT throughput-saturated (~36%), yet delivers only ~35% of peak
  because its operands arrive late. The dequant chain length, not ALU
  count per se, sets the pace.
- L2 hit ~6% on both confirms pure streaming access (compulsory misses
  only); GL2C_MC_RDREQ volume equals one cold read of the tensor per
  dispatch. No pathological L2 thrashing, no redundant DRAM traffic.
  Memory traffic volume is optimal; time-to-consume it is not.

## 3. Root-Cause Conclusion

Why is IQ3_XXS GEMV only ~262 GB/s in production?

Each wavefront spends ~77% of its lifetime stalled on dependent
instruction waits: the vec_dot_iq3_xxs_q8_1 algorithm requires 8
address-dependent gathers into a global-memory lookup table plus sign
expansion before any dp4a can run, repeated across ~17 un-pipelined K-loop
trips per thread, at ~13x the instruction density per byte of Q4_0, while
76 VGPRs cap co-residency at ~6 waves/SIMD which is too few to hide the
chain latencies. The DRAM traffic itself is minimal and well-formed
(cold stream, ~6% L2 hits, no waste): even when data sits in cache the
kernel still runs at 165-184 GB/s, proving bandwidth is not the limiter.

Explicit answers:

- Is it Occupancy (nwarps=1)? **PARTIAL (indirect only).**
  Measured residency parity (5.44 vs 5.64 waves/SIMD) shows the GPU is NOT
  starved of wavefronts, so nwarps=1 is not the direct mechanism. But it
  contributes structurally: 32-thread blocks force ~17 serial trips/thread
  with zero cross-trip overlap, and 76 VGPRs cap max concurrency at ~6/SIMD
  which leaves too little slack to hide the long chains.
- Is it Memory-Level Parallelism? **YES (dominant proximate cause).**
  76.7% stall share vs Q4_0's 2.0%; adding one independent chain per thread
  (fused b1->b2) raises throughput +65%, proving unhidden latency is the
  binding constraint.
- Is it Load Pattern (narrow/unaligned)? **NO for width/alignment**
  (streams are b128/b64, aligned; traffic volume is exactly one tensor
  read). **PARTIAL for pattern**: the 8 dependent b32 table-gathers per
  trip inside the critical chain are the harmful part - they are
  L1-friendly individually but serialize the whole trip.
- Is it VALU/Dequant overhead? **PARTIAL (structural amplifier).**
  VALU pipes are only ~36% utilized, so raw ALU throughput is not the wall;
  but the 6.5-13x instruction density of grid-lookup + sign-expansion
  dequant is precisely WHAT makes the chains long and the trips 452
  instructions deep. Latency and instruction volume compound.

One-sentence root cause: the IQ3_XXS MMVQ kernel converts a pure
bandwidth problem into a latency problem - serialized lookup-table-driven
dequant chains per wavefront, insufficiently overlapped at ~6 waves/SIMD -
so the GPU idles waiting on dependencies instead of on DRAM.

## 4. Next Steps Recommendation (Phase-4 design study, no code yet)

Ranked by expected leverage against the diagnosed cause. Every candidate
must pass agents.md section 15 gates (correctness suite, deterministic
greedy logits identity, MTP acceptance unchanged):

1. Break the gather dependency chain. Move iq3xxs_grid (1 KB) into LDS or
   replace table lookups with arithmetic/perm selection (the codebase
   already has the v_perm_b32 get_int_from_table_16 pattern for 16-entry
   tables). Directly attacks the 76.7% stall share.
2. Software-pipeline the K-loop: hoist next-trip X/Y loads ahead of
   current-trip consumption. Requires making the trip structure
   compiler-friendly (e.g., template bucketing of blocks_per_row or manual
   double-buffering). Attacks vmcnt(0)-per-trip serialization.
3. Exploit the proven ILP effect: process two kbx groups (or two output
   rows) per thread to create two independent chains. The b1->b2 fused data
  (+65%) demonstrates multi-hundred-GB/s upside without touching the
   numerical path of any single dot product.
4. Cheap empirical sweep: nwarps=2/4 for IQ3_XXS on RDNA3 (table change),
   watching VGPR pressure/spills. Lowest effort, uncertain gain given
   measured occupancy parity; treat as calibration, not primary fix.
5. Weight-layout repack (swizzle) to make grid indices contiguous -
   largest engineering cost, defer unless 1-3 under-deliver.

Recommended Phase-4 scope: items 1-3 as separate measurable variants on
the synthetic harness first (it now exists and its ISA matches production),
then the winning variant through the full correctness/MTP gates.

## 5. Production Restore Status

Sequence deviation documented above (crash mid-window; operator-directed
restart before the rerun). End-state:

- Server: ops/bin/prod_start.sh from prod_flags.env verbatim.
  PID 5521 in ops/run/llama-server.pid; /proc/PID/exe validated =
  build-p3/bin/llama-server. Log: ops/logs/llama-server.20260824_231923.log.
- Health: {"status":"ok"}.
- Semantic spot-check (results2/correctness_suite.py semantic_suite,
  exact phase-1B/2B prompts): **5/6 strict pass; math2 answers "40"** which
  reproduces the stored baseline quirk character-for-character ("  40
  **Step-by-step Deduction:**...", documented since phase-1B where the test
  passes as "matches baseline quirk"). Baseline-equivalent: effectively 6/6.
  Result file: experiments/phase3/results/semantic_check.json.
- MTP/spec flags active (draft-mtp, n-max 4, p-min 0.8); graphs enabled as
  in production manifest.

## Appendix: Evidence Index

- raw/synthetic_results_rerun.txt : full timing matrix (3 types x 2 shapes
  x batches 1/2/4/8, fused/unfused), post-bugfix rerun.
- raw/synthetic_results.txt : pre-crash partial pass (agrees within 1.5%).
- raw/isa/type18.s, type2.s, type8.s : production disassembly (carved from
  build-p3 libggml-hip.so fatbin, obj_mmvq.elf).
- raw/isa/notes.txt : amdhsa kernel metadata (VGPR/SGPR/LDS/workgroup).
- raw/rocprof/cachyos-x8664/*_counter_collection.csv : PMCs for IQ3_XXS
  down, Q4_0 down, IQ3_XXS fused gateup (25 dispatches each).
- synthetic/mmvq_bench.hip, build.sh, iq3xxs_grid.h : standalone harness
  (ISA-diffed against production kernel).
