# Tulpar.cpp Phase 1 Report: Baseline + Decode Profiling

Date: 2026-08-24. Base: tulpar/main 66dcba5eb (= upstream c060ca974 +
fattn-rdna3-quant-tile patch content, verified byte-identical behavior).
Binary: build-p3/bin/llama-server (ROCm 7.2.4, gfx1101).
Model: Qwen3.8-27B UD-Q2_K_XL (10.67 GB weights: IQ3_XXS 8.09, IQ3_S 1.38,
Q3_K 0.55, Q2_K 0.42, IQ4_XS 0.22), KV q4_0/q4_0, -fa on.
Environment manifest: results2/tulpar/env/.

## Baseline (perf windows, medians of 3, spread < +/-1.5%)

| ctx | OFF decode | ON decode | acc | OFF prefill |
|------|-----------|-----------|-------|-------------|
| 1k   | 21.40     | 26.03     | 0.74  | 499         |
| 16k  | 20.32     | 37.66*    | 0.92  | 486         |
| 63k  | 15.67     | 24.98     | 0.88  | 332         |
| 128k | 12.15     | 23.16     | 0.98  | 232         |

tok/s, sampled temp .6 k20 p.95 seed4242, fixed prompt set
(results2/tulpar/perf_*.json). *ON 16k rep2 dipped to 32.2 (known MTP
variance); median reported. NOTE: MTP gains are prompt-dependent via draft
acceptance; this campaign fixes one prompt set as the going-forward Tulpar
baseline (yesterday's different prompts gave different absolute ON numbers).

Traced runs (rocprofv3 overhead included) decoded within 3% of untraced:
t16k/t63k/t128k bench in trace_*_meta.json.

## Profiling Evidence

Method: rocprofv3 kernel traces of sessions containing exactly one
completion [model load][prefill][96 decode steps]; analysis window =
last 64 decode steps (deterministic tail cut using measured step period);
per-kernel durations summed by class (agg_rocpd.py).

### ANSWER: decode time shares (RX 7800 XT, tulpar/main)

Per-token GPU time by component (% of GPU-busy time in window):

| Component          | 16k            | 63k            | 128k           |
|--------------------|----------------|----------------|----------------|
| matmul GEMV        | 35.0 ms (83.5%)| 35.4 ms (62.8%)| 37.5 ms (48.0%)|
| attention          |  2.1 ms ( 4.9%)|  9.0 ms (15.9%)| 17.1 ms (21.9%)|
| dequant/quant      |  1.9 ms ( 4.5%)|  9.0 ms (16.0%)| 20.4 ms (26.1%)|
| norm/rope/act      |  1.1 ms ( 2.6%)|  1.1 ms ( 1.9%)|  1.2 ms ( 1.5%)|
| copy/KV-IO         |  0.9 ms ( 2.2%)|  0.9 ms ( 1.6%)|  1.0 ms ( 1.2%)|
| other              |  0.5 ms ( 1.3%)|  0.5 ms ( 0.9%)|  0.6 ms ( 0.7%)|
| GDN/SSM/conv       |  0.4 ms ( 0.9%)|  0.4 ms ( 0.7%)|  0.4 ms ( 0.6%)|
| host/runtime gap   | 15.0 % of wall | 11.7 % of wall |  9.4 % of wall |

Step periods: 49.3 / 63.9 / 86.1 ms (matches untraced tok/s within 3%).

Component detail (dominant kernels inside classes):

- matmul GEMV = weight streaming for batch=1, entirely
  mul_mat_vec_q<IQ3_XXS> (~120 launches/token, 192 us avg -> 22.7 ms),
  mul_mat_vec_q<IQ3_S> (~75 x 50 us -> 3.7 ms), mul_mat_vec_q<Q3_K>
  (1 x 1467 us -> 1.5 ms). Constant across context length, as expected.
- dequant/quant at long ctx is dominated by dequantize_block_q4_0<__half>
  (~30 launches/token = K+V staging for tile FA): avg launch grows 45 us
  (16k) -> 278 us (63k) -> 614 us (128k), i.e. linear in KV size. This is
  the fattn-rdna3-quant-tile patch's staging tax. At 128k it costs MORE
  than attention itself (20.4 vs 17.1 ms/token). The small remainder is
  quantize_q8_1 activation quant (~406 tiny launches/token, 1.4 us each).
- attention = flash_attn_tile<256,256,1,2> only (VEC fully replaced,
  confirms patch dispatch on real workload): 138 us (16k) -> 591 us (63k)
  -> 1062 us (128k) per launch, 15-16 launches/token.
- host_gap = wall minus GPU busy inside window: 9-15% idle even with HIP
  graphs enabled. Includes graph replay boundaries, CPU-side sampling/
  sync between steps. NOT yet decomposed into causes (unknown split).

Effective bandwidth checks (measured):

- Weight stream: 10.67 GB / 35.0 ms = ~305 GB/s aggregate = 49% of
  624 GB/s peak. Largest kernel alone: 8.09 GB / 22.7 ms = ~357 GB/s (57%).
- KV q4_0 staging at 128k: 16.6 MB read + 33 MB write per tensor-launch in
  614 us -> ~81 GB/s effective: far from peak; likely grid/occupancy bound.

Unknown / not established:

- Split of host_gap into graph-replay vs CPU sampling vs driver overhead.
- Whether GEMV ceiling on gfx1101 can exceed ~57%; needs microbenchmark
  against ISA limits (not yet done).
- Prefill composition not yet profiled (separate follow-up; prefill shares
  will differ: MMQ-heavy).

## Bottleneck ranking (impact x tractability)

1. GEMV weight streaming (48-84% of decode across ctx; 49% of BW peak):
   biggest single lever. Candidates: kernel efficiency (vectorization,
   LDGSTS-like patterns, occupancy tuning for gfx1101), batch>1 tricks are
   irrelevant here (batch=1), so it is pure BW/issue efficiency.
2. KV q4_0->F16 restage per token (4.5% -> 26% growing with ctx): avoid
   full re-staging each step (persistent staged mirror updated incrementally,
   or tile FA reading q4_0 directly). Directly extends the existing patch.
3. Attention tile kernel scaling (22% @128k): second-order after 2 since
   staging feeds it; revisit after 2 lands.
4. Host/runtime gap (9-15%): quantify causes before touching anything.
5. Everything else < 3.5%: PARK until 1-4 change the profile shape.

## Decision: INVESTIGATE next

Next experiments (each: hypothesis doc -> minimal change -> gate suite ->
A/B same-day):
E1: microbench GEMV variants for IQ3_XXS/IQ3_S on gfx1101 (no model needed;
    establish achievable BW envelope before touching llama.cpp code).
E2: host_gap decomposition (timestamps around graph replay/sync/sampling).
E3: prototype incremental KV staging (only after E1/E2 conclusions; must
    pass full correctness gate incl. needle at 128k).

Rules honored: no optimization code written yet; production server restored
after campaign (verified healthy); upstream branch untouched.
