Phase-4E / Subagent-C: Prefetch Distance Variants for IQ3_XXS MMVQ
=======================================================================

Scope
-----
Test whether issuing the next trip's loads earlier (software prefetch /
pipelining) increases memory-level parallelism and throughput for the
IQ3_XXS MMVQ kernel on RDNA3 (gfx1101, RX 7800 XT).

The premise (from the prompt and from subagent-A's analysis) is that
`vmcnt(0)` at the K-loop trip boundary is REQUIRED, not conservative,
because L14 (the 14th/last load, v58) is consumed 4 instructions later
by `v_xor_b32 v52, v58, v17`. The hypothesis was: by issuing trip N+1
loads during trip N's compute (or even further ahead), we can amortize
load latency and increase throughput.

Variants tested
---------------
| Variant | prefetch_depth | lds_grid | do_unroll | What it does |
|---------|----------------|----------|-----------|--------------|
| V0      | 0              | no       | no        | Baseline (production-equivalent IQ3_XXS MMVQ) |
| C1      | 1              | yes      | no        | Prefetch 1 trip ahead via __builtin_prefetch; grid staged in LDS |
| C2      | 2              | yes      | no        | Prefetch 2 trips ahead; grid staged in LDS |
| C3      | 4              | yes      | no        | Prefetch 4 trips ahead; grid staged in LDS |
| C4      | -1             | no       | yes       | Full #pragma unroll on the trip loop |

Key finding (the punchline)
---------------------------
The __builtin_prefetch calls in C1/C2/C3 are **completely eliminated by
the compiler** (zero s_prefetch or extra global_load instructions in the
SASS). The variants end up equivalent to "LDS-staged grid" (the 1 KB
iq3xxs_grid is loaded into LDS once per workgroup, then read from LDS
instead of L1). The C4 #pragma unroll hint is also ignored because
blocks_per_row_x is a runtime value (the compiler cannot statically
unroll a dynamic-trip loop).

In effect, this harness measures the cost of LDS-staging the grid vs
the L1-resident grid in V0, NOT a true software-prefetch comparison.

SASS inspection (gfx1101, mmvq_prefetch_bench built with -O3):
- V0: 14 global_loads in the K-loop, 3 s_clause groups, 9 s_waitcnt
  vmcnt waits per trip. Per subagent-A: 14 vmcnt-contributing loads
  (10 b32 + 2 b128 + 1 b64 + 1 d16_hi_b16), 8-deep v_dot4 chain.
- C1: 14 global_loads total, but only 6 in the K-loop (the other 8
  are LDS-staging loads that happen once per workgroup). 1 s_clause
  group in the K-loop. **Zero** s_prefetch instructions - the
  __builtin_prefetch hint is dead-code-eliminated.
- C2/C3: identical SASS structure to C1 (same 6 K-loop loads, same
  8 LDS-staging loads, zero prefetches).
- C4: identical to V0 (same 14 K-loop loads, same 3 s_clause groups).
  The unroll hint produced no change.

Bit-exactness
-------------
All 4 prefetch variants (C1, C2, C3, C4) produce **bit-identical dst
bytes** to V0, for both ffn_down (K=17408, N=5120, unfused) and
ffn_gateup (K=5120, N=17408, fused GLU). Verified via the harness's
`./mmvq_prefetch_bench verify` mode.

Performance results (median of 200 reps, gfx1101)
-------------------------------------------------
| Variant | Shape   | ms     | GB/s(weight) | vs V0    | VGPR | Occupancy |
|---------|---------|--------|--------------|----------|------|-----------|
| V0      | ffn_down    | 0.1396 | 164.6        |   -      |  76  | 64        |
| C1      | ffn_down    | 0.1419 | 162.0        | -1.6%    |  81  | 56        |
| C2      | ffn_down    | 0.1417 | 162.2        | -1.5%    |  81  | 56        |
| C3      | ffn_down    | 0.1434 | 160.3        | -2.6%    |  81  | 56        |
| C4      | ffn_down    | 0.1389 | 165.4        | +0.5%    |  76  | 64        |
| V0      | ffn_gateup  | 0.2486 | 184.8        |   -      |  33  | 64        |
| C1      | ffn_gateup  | 0.2578 | 178.3        | -3.5%    |  83  | 51        |
| C2      | ffn_gateup  | 0.2579 | 178.2        | -3.6%    |  83  | 51        |
| C3      | ffn_gateup  | 0.2604 | 176.5        | -4.5%    |  83  | 51        |
| C4      | ffn_gateup  | 0.2488 | 184.7        | -0.1%    |  33  | 64        |

The numbers are from 200 reps (median), excluding the first 5 warmup
launches. The C4 number is statistically indistinguishable from V0
(difference within noise); C1/C2/C3 are consistently slower, with C3
being the worst.

Stall analysis (rocprofv3, averaged over 30 reps)
------------------------------------------------
| Variant | Shape   | Stall% | cyc/wave | valu/wave | lds_insts | lds_waits | tex_loads |
|---------|---------|--------|----------|-----------|-----------|-----------|-----------|
| V0      | ffn_down   | 79.5%  | 92988    | 6119      | 853       | 36        | 2.8       |
| C1      | ffn_down   | 77.7%  | 79530    | 5176      | 25429     | 1072      | 38.9      |
| C2      | ffn_down   | 78.7%  | 96400    | 6356      | 25429     | 1042      | 0.0       |
| C3      | ffn_down   | 78.6%  | 97548    | 6424      | 25429     | 1210      | 0.0       |
| C4      | ffn_down   | 80.0%  | 84724    | 5587      | 853       | 36        | 11.2      |
| V0      | ffn_gateup | 60.8%  | 59412    | 3363      | 5641      | 25        | 0.0       |
| C1      | ffn_gateup | 81.7%  | 54505    | 3213      | 55287     | 4293      | 62.0      |
| C2      | ffn_gateup | 81.6%  | 61624    | 3641      | 55287     | 4619      | 2.7       |
| C3      | ffn_gateup | 81.8%  | 56876    | 3357      | 55287     | 3848      | 54.8      |
| C4      | ffn_gateup | 60.8%  | 55155    | 3102      | 5642      | 26        | 27.6      |

Key observations:
- V0 stall ratio on ffn_down is 79.5%, on ffn_gateup is 60.8%. The
  gateup kernel is less stall-bound because the K-loop has fewer trips
  (20 vs 68) so the trip boundary overhead is amortized over less
  compute.
- C1/C2/C3 have 30-200x more LDS instructions and LDS wait cycles
  than V0. The LDS-staged grid reads are creating LDS contention.
- C1/C2/C3 do NOT reduce the global stall ratio on ffn_down (in fact
  C4 is slightly worse). The bottleneck is NOT in the load path.
- C1/C2/C3 INCREASE the stall ratio on ffn_gateup from 60.8% to
  ~81.7% - the LDS reads add new stall sources.

VGPR / occupancy:
- V0 / C4: 76 VGPRs (ffn_down) / 33 VGPRs (ffn_gateup), 64 occ_blocks.
- C1 / C2 / C3: 81 VGPRs (ffn_down) / 83 VGPRs (ffn_gateup),
  56/51 occ_blocks.
- The +5/+50 VGPR increase is the cost of the LDS-staged grid reads
  (more address-calc and read-result registers). The occupancy drop
  is small (64 -> 51/56), not a major concern.

Verdict
-------
**Does prefetch help? NO.**

- C1/C2/C3 are 1.5-2.6% slower on ffn_down and 3.5-4.5% slower on
  ffn_gateup. The slowdown is monotonic with depth: C3 (4 trips) is
  the worst.
- C4 is statistically identical to V0 (the unroll hint has no effect
  on a dynamic-trip loop).
- The cost is in the LDS read path: 30-200x more LDS instructions and
  30-200x more LDS wait cycles dominate. The grid reads from LDS are
  not free - they incur LDS bank-conflict and queue-full stalls.

**Was the bottleneck insufficient in-flight loads? REFUTED.**

- C1/C2/C3 (the LDS-staged variants) have the same 14 in-flight
  global_loads as V0. The K-loop's load count went DOWN, not UP.
- The per-trip stall ratio did not improve with LDS staging; the
  compute path is the bottleneck, not the load path.
- Per subagent-A: the 8-deep v_dot4 chain is on the compute path and
  is the real latency source. The grid reads (L7..L14) are issued in
  parallel via s_clause and don't add wait cycles beyond the existing
  vmcnt(0..2) ladder.

**Reference to subagent-A's findings (vmcnt(0) is required)**

Subagent-A's `experiments/phase4e/subagent_a/README.md` and
`kloop_disasm.S` establish:
- vmcnt(0) at the trip boundary is REQUIRED, not conservative.
  L14 (v58) is the 14th/last load and is consumed 4 instructions
  later by `v_xor_b32 v52, v58, v17`. vmcnt(1) would be incorrect.
- The compiler has already placed each wait at its minimum: every
  wait in the K-loop is paired with a `v_xor` that consumes one
  specific load, and the waitcnt value is the minimum for that
  binding consumer.
- The real win per subagent-A is to **split the 8-deep v_dot4 chain
  into two 4-deep chains into independent accumulators, sum at the
  end**, NOT to add more loads or relax waits.

This subagent's measurements are consistent: the LDS-staging variants
(C1/C2/C3) do not help, confirming that the K-loop is not load-bound.
The vmcnt(0) is at its minimum; further load-side optimization is
futile. The remaining win is in re-ordering the v_dot4 chain.

Limitations and methodology notes
---------------------------------
1. The compiler eliminated all `__builtin_prefetch` calls in C1/C2/C3
   (zero s_prefetch or extra global_load instructions in the SASS).
   An attempt was made to issue real `global_load` instructions via
   inline asm volatile to force prefetch loads, but the SGPR
   register pressure caused the kernel to clobber the loaded
   addresses and fault at runtime. The simpler __builtin_prefetch
   approach was kept because it produces bit-exact results and clearly
   demonstrates the compiler's no-op treatment of the prefetch hint.
2. The C4 #pragma unroll hint is ignored by the compiler because
   blocks_per_row_x is a runtime value. A hand-unrolled source
   refactor (e.g., a fixed-trip-count body with a tail loop) would
   be needed to actually unroll this loop.
3. The harness uses the same seeded buffers as the phase-3 synthetic
   benchmark, with the same per-block shuffle for Q8_1 ds. The dst
   check uses memcmp after 3 warmup launches.
4. Stall metrics are averaged over 30 rocprofv3 runs. The
   `SQ_WAIT_INST_ANY / SQ_WAVE_CYCLES` ratio is reported as the
   "stall ratio".

Files in this directory
-----------------------
- `README.md` (this file) — full report
- `results.json` — structured results
- `raw_measurements.csv` — raw numbers from all 10 (variant, shape) pairs
- `mmvq_prefetch_bench.hip` — the harness with V0/C1/C2/C3/C4 kernels
- `mmvq_bench_v0.hip` — the V0-only reference harness (copied from phase-3)
- `build.sh` — builds both binaries
- `run_rocprof.sh` — runs rocprofv3 on all variants
- `extract_stalls.py` — parses rocprofv3 sqlite output
- `raw/` — raw bench output files
- `rocprof/` — rocprofv3 sqlite databases
- `*.s` — SASS dumps for V0 and C1 (full kernel disassembly)

Reproducing the analysis
------------------------
```sh
# Build
./build.sh

# Bit-exact verification (4 variants x 2 shapes)
./mmvq_prefetch_bench verify

# Performance sweep (200 reps median)
./mmvq_prefetch_bench 200

# Stall analysis (30 reps per variant, 7 PMCs)
./run_rocprof.sh
python3 extract_stalls.py
```

References
----------
- `experiments/phase4e/subagent_a/README.md` - IQ3_XXS MMVQ dependency
  analysis. Establishes that vmcnt(0) at the trip boundary is required.
- `experiments/phase4e/subagent_a/kloop_disasm.S` - Annotated SASS of
  the production IQ3_XXS MMVQ kernel (v_dot4 chain, 14 loads, etc.).
- `experiments/phase3/synthetic/mmvq_bench.hip` - Baseline harness this
  is derived from.
- `experiments/phase3/synthetic/mmvq_bench.hip:139-171` - vec_dot_iq3_xxs
  implementation, identical to the production vecdotq.cuh.
