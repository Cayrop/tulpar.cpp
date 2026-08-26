# E1b Hypothesis: IQ3_XXS standalone vec_dot/kernel sweep

Date: 2026-08-24. No llama.cpp source changes. Artifacts only under results2/tulpar/experiments/e1b_gemv/.

## Context (measured in Phase 2A)

- Dominant decode cost: GEMV over 8.01 GB weights/token; IQ3_XXS class alone
  6.55 GB/token at ~211-213 GB/s effective (bench) matching trace.
- Machine ceilings (standalone): pure read 602.7 GB/s, copy R+W ~486 GB/s.
- Gap is ALU/dequant-bound, not proven DRAM-bound.

## Production kernel facts (read from source, tulpar/main 66dcba5eb)

- Kernel: mul_mat_vec_q<IQ3_XXS, ncols_dst=1> in ggml/src/ggml-cuda/mmvq.cu,
  vec_dot_iq3_xxs_q8_1 in vecdotq.cuh.
- gfx1101 resolves to MMVQ_PARAMETERS_RDNA3_0; IQ3_XXS is NOT in its
  nwarps whitelist -> nwarps=1: blockDim=(32,1), one output element per
  block, grid.x = N rows (17408 or 5120 blocks).
- qi=QK_K/(4*QR)=2, vdr=2 -> kqs = 2*(tid % 1) = 0 for every thread;
  blocks_per_iter = 2*1*32/2 = 32; each thread walks kbx = tid, tid+32, ...
- Each block_iq3_xxs is 14 B (fp16 d + qs[12]); per 32-element dot:
  3 misaligned dword assemblies via get_int_b2 (byte-by-byte),
  4 grid-table lookups (iq3xxs_grid, 1 KB), unpack_ksigns + 2 __vcmpne4 +
  xor/sub sign application, 8 dp4a.
- Row byte lengths are multiples of 16 B (ffn_down 2240 B, ffn_gate/up
  7616 B), so an entire row is a 16B-aligned stream: vector-loadable.
- ffn_gate/up run as has_fusion=true GLU-fused launches in production
  (2x weight reads per launch); E1b measures the pure GEMV inner loop,
  fusion is orthogonal and multiplies the same win.

## Round 1 variants (one mechanism each)

| id | mechanism | hypothesis | expected | risk |
|----|-----------|------------|----------|------|
| V0 | verbatim production copy (nwarps=1) | reproduces ~200-215 GB/s cold | baseline anchor | none |
| V1 | nwarps=2 (64 thr/block) | more parallelism per row helps latency-bound loop | +/-10% | table contention, reduction overhead |
| V2 | nwarps=4 (128 thr/block) | same, stronger | <=V1 (RDNA3 whitelist excludes complex types for a reason) | reg pressure |
| V3 | rows_per_block=2, wg=32 | amortize y + fewer blocks, ILP across rows | +5-15% | reg pressure |
| V4 | rows_per_block=4, wg=128 | same idea, wider | ? | reg pressure |
| V5 | aligned dword stream loads + funnel shift (2 blocks/iter) | kill 12 byte-assembly loads -> 8 aligned dwords; biggest insn-count drop | +20-50% | implementation bugs; boundary handling |
| V6 | iq3xxs_grid preloaded to LDS | avoid L1 latency variance on scattered lookups | 0-10% | LDS bank conflicts |
| V7 | 2-way ILP split accumulator (independent sumi chains) | hide dp4a latency without more threads | +5-20% | none |
| V8 | nontemporal weight loads | never-reused weights should not pollute caches | 0-5% (isolated bench may show ~0) | NT load throughput quirks |

## Measurement discipline

- Working set defeat of Infinity Cache (64 MB): rotate across >=16 distinct
  weight buffer copies (~940 MB pool per shape). y stays hot (matches model).
- Warmup separated from measurement; 7 reps, median reported; raw CSV kept.
- rocm-smi clock/power sampled in background during measurement.
- Correctness: host reference dequant (same tables, exact integer semantics
  replication) vs every variant; tolerance distribution recorded; baseline
  vs reference validates the harness itself.
- Any result above pure-read ceiling (602.7 GB/s) triggers methodology audit
  before acceptance (cache effect suspected).

## Success criteria

- Decision threshold (standalone, cold-weight effective GB/s on dominant
  real shape, median): <350 PARK GEMV rewrite; 350-400 minimal integration
  candidate; 400+ GO; 450+ high priority.
- Winning variant must hold advantage across BOTH real shapes and across
  reps (no single-shot flukes).

## Corrections discovered during the experiment (recorded for honesty)

1. Initial layout assumption was WRONG: I first modeled IQ3_XXS as 14 B /
   32-element blocks. Actual type (ggml-common.h): 98 B / 256-element
   super-block (fp16 d + qs[96], 3.0625 bpw). The harness was rebuilt around
   the correct semantics; E1's byte accounting (34.12 MB/call) is confirmed
   correct under the true layout.
2. HIP-mode ggml_half is __half. Casting to uint16_t before __half2float
   performs a VALUE conversion, silently corrupting three variants until
   fixed. Production code uses typed access and is unaffected.
3. Host reference required exact per-byte saturated subtraction (__vsub4)
   and contiguous 8-byte grid indexing to match device bit-for-bit;
   both discrepancies were found via independent python replication.

These corrections consumed most of the debugging effort but the final
harness is validated three ways: device baseline vs host reference
(rel_max <= 7.7e-7), vs python replication, and vs production trace times.
