# Tulpar.cpp Phase 2A Interim Report

Date: 2026-08-24. Branch tulpar/main 66dcba5eb (no source changes made).
Artifacts: results2/tulpar/experiments/{e1_gemv,e2_hostgap,e3_staging}/
Production server restored (original binary, health OK).

## E1: GEMV bandwidth envelope

Machine ceilings (standalone HIP kernels, 2 GB working set):

- pure read: 602.7 GB/s (96.6% of 624 nominal peak)
- copy read+write: ~486 GB/s

Real-shape GEMV through ggml batch=1 (same libs as server; shapes.txt has
exact model tensors; bench totals reconcile with trace):

| shape (type ne0 x ne1, count)      | ms/call | GB/s  | note                          |
|------------------------------------|---------|-------|-------------------------------|
| IQ3_XXS 17408x5120 / 5120x17408    | 0.161   | 213   | dominant class, 192 launches/tok |
| IQ3_S   5120x12288 (attn_q)        | 0.125   | 217   |                               |
| IQ3_S   6144x5120 (attn_output)    | 0.075   | 180   |                               |
| Q3_K    5120x248320 (output)       | 1.500   | 365   | matches trace 1467 us         |
| IQ3_S/IQ4_XS 5120x1024 (attn_k/v)  | 0.033   | 60-85 | launch-overhead bound (small) |

Predicted model GEMV total from bench: 37.47 ms/token.
Trace-measured decode window GEMV: 35.0 / 35.4 / 37.5 ms/token at
16k/63k/128k. Validated: bench represents model reality.

Interpretation: the dominant IQ3_XXS vec_dot path runs at ~211 GB/s
equivalent = 35% of pure-read ceiling, 43% of copy ceiling. This is an
ALU/dequant-throughput limit of the kernel (grid-table lookups, byte
shuffling), not a DRAM limit. Headroom if dequant cost approaches memory
speed: up to ~2.3x on this class.

Not yet established: how much of that headroom is reachable. Next step
E1b: standalone vec_dot IQ3_XXS kernel sweep on the real shapes (workgroup,
ILP/unroll, load width, grid-decode strategy, occupancy), mirroring the E3
methodology. No llama.cpp source touched yet.

## E2: host/runtime gap decomposition

Gap structure inside the 64-step decode windows (rocpd regions + dispatches):

| metric                       | 16k     | 63k     | 128k    |
|------------------------------|---------|---------|---------|
| wall gap                     | 7.4 ms  | 7.5 ms  | 7.7 ms  |
| share of wall                | 15.0%   | 11.7%   | 9.4%    |
| micro-bubbles <10 us         | ~84%    | 84.4%   | ~84%    |
| bubbles per step             | ~1780   | ~1828   | ~1940   |
| avg bubble                   | ~3.5 us | 3.45 us | ~3.5 us |
| end-of-step drain 0.1-1.1 ms | ~1/step | ~1/step | ~1/step |

Findings:

1. The gap is NOT one big sampling stall. It is ~1800 tiny GPU-idle bubbles
   between kernels inside graph execution, ~3.5 us each, constant across
   context lengths. Absolute cost ~6.3 ms/step at every ctx.
2. Bubble pair census (t63k): dominated by transitions around small kernels:
   quantize_q8_1 <-> mul_mat_vec_q, rms_norm -> quantize_q8_1,
   k_get_rows/ssm_conv/gated_delta_net chains (GDN blocks), concat, bin_bcast.
   Top 12 pairs explain ~40% of bubble time. quantize_q8_1 alone: 406
   launches/step -> ~2.4 ms/step including its two bubbles.
3. End-of-step drain: after lm_head GEMV there is a D2H rocclr_copyBuffer
   (logits) preceded/followed by hipStreamSynchronize; ~0.75-1.1 ms per
   step where GPU idles while host receives logits and samples.
4. hipStreamSynchronize spans cover ~96% of gap time but only because they
   wrap whole-step waits; mechanism attribution above uses gap position and
   adjacent kernels, not just span coverage.

Decision rule met: single mechanism >=50% of gap (node-transition bubbles).
Optimization lever = fewer kernels per step (fusion of quantize into norm /
GEMV prologue; GDN chain fusion) and cheaper graph execution, not sampler
changes. Secondary lever: end-of-step logits drain (~0.9 ms/step) via GPU
sampling or async copy overlap (Phase 4, later).

## E3.0: q4_0 -> f16 staging ceiling

Standalone dequant sweep on real KV shapes (feats=1024):

| tokens | best dequant       | copy ref (R+W) |
|--------|--------------------|----------------|
| 16384  | 1225 GB/s (cached) | 766 (cached)   |
| 65536  | 385 GB/s           | 486 GB/s       |
| 131072 | 336 GB/s           | 486 GB/s       |

The production staging kernel measured in traces runs FASTER than the
naive standalone version: ~553-604 GB/s traffic-equivalent at 128k
(344 MB moved in 614 us). It is already at practical memory-system limits.

Conclusion: staging kernel tuning is a dead end. The cost is architectural:
the full KV is re-staged every token. At 128k that tax (20.4 ms/token)
exceeds attention itself (17.1 ms/token).

VRAM budget kills the persistent-f16-mirror idea (E3A) at long ctx:
f16 K+V costs 8192 B/token/layer; x17 full-attn layers = 69.6 KB/token
=> +4.85 GB at 63k, +9.13 GB at 128k on top of weights (10.67 GB) and
existing q4_0 KV (1.22/2.57 GB) and workspaces on a 16 GB card.
Infeasible. Direct quantized-KV tile attention (E3B) is the strategic
path, with hybrid dispatch by measured threshold if short ctx prefers
current staging (its tax is only 1.9 ms at 16k).

## Updated budget table (Phase 6 loop)

OFF baseline ms/token and remaining budget for targets:

16k (now 49.2 ms -> 33.3 ms at 30 tok/s; 25.0 at 40):

| component   | now  | notes                        |
|-------------|------|------------------------------|
| GEMV        | 35.0 | E1b target: -12 to -18 ms    |
| attention   | 2.1  |                              |
| staging     | 1.9  | leave as is at short ctx     |
| other gpu   | 2.8  | fusion candidates here       |
| host gap    | 7.4  | fusion target: -3 to -4 ms   |

63k (now 63.8 ms; 25.0 needed for 40 tok/s):

| component   | now  | notes                            |
|-------------|------|----------------------------------|
| GEMV        | 35.4 | same lever as 16k                |
| attention   | 9.0  |                                  |
| staging     | 9.0  | E3B removes most                 |
| other gpu   | 2.9  |                                  |
| host gap    | 7.5  | fusion target                    |

Honest scenario math (all components landing perfectly):
- 16k: 49.2 - 18(GEMV) - 4(gap) = 27 ms -> ~37 tok/s; conservative half:
  49.2 - 9 - 2 = 38 ms -> ~26 tok/s. Band: 26-37 OFF.
- 63k: 63.8 - 18 - 9(staging) - 5(gap) = 31.8 -> ~31 tok/s; adding
  attention gain from E3B (-3) -> ~29 ms -> ~35 tok/s. 40 OFF needs
  everything at maximum plus more; with MTP ON (acc ~0.88) the same wall
  time yields ~45-60 tok/s effective.
- 128k: 82.3 - 18 - 18(staging) - 5 - 6(attn direct-read) = 35 ms ->
  ~28 tok/s upper estimate; conservative: 82.3 - 9 - 14 - 2 - 3 = 54 ->
  ~18.5 tok/s. Band: 19-28 OFF.

These are estimates, not promises; each gate measured separately.

## Decisions

1. E1: GO to E1b (bounded kernel sweep, no integration yet). Achievability
   threshold before touching llama.cpp: tuned standalone vec_dot must show
   >=350 GB/s on IQ3_XXS real shape; else PARK GEMV rewrite.
2. E2: mechanism identified. Queue fusion candidates (Phase 5 pulls ahead):
   fuse activation quantize into preceding norm/GEMV; count GDN-chain
   reduction as second candidate. Logits-drain fix stays parked until
   fusion lands.
3. E3.0: kernel tuning CLOSED (already at limits). Proceed to E3B design
   (direct q4_0 tile FA) with VRAM-safe incremental prototype; E3A mirror
   REJECTED by VRAM budget except possibly short-ctx-only (not needed).
4. Order: E1b -> (if GO) Phase 2B GEMV integration -> E3B prototype ->
   re-trace -> fusion. One mechanism at a time; correctness gates unchanged.
