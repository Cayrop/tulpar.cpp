# E5A: quantize_q8_1 sandwich fusion feasibility + launch census

Status: census DONE (t16k trace), fusion experiment NOT started.
Discipline: one mechanism at a time, no production binary change,
no tulpar/main commit.

## Hypothesis

A large share of the ~7.5-7.7 ms/token micro-bubble time is spent at
kernel boundaries around activation quantization. Fusing the most frequent
chain (producer -> quantize_q8_1 -> mul_mat_vec_q) reduces wall ms/token
by removing whole boundaries, not by making any kernel faster.

## Measured launch census (ctx=16k, traced decode window)

Source: traces/t16k/cachyos-x8664/184165_results.db (rocprofv3 rocpd).
Extractor: census_from_rocpd.py -> launch_census_t16k.json.
93 full steps analyzed; step structure found by exact period detection
(1930 kernel launches per step).

| metric | value |
|--------|-------|
| step wall median | 52.52 ms |
| GPU busy | 44.80 ms |
| bubbles | 7.72 ms |
| total gaps | 1867/step summing 7.55 ms |
| gaps >= 5 us | only 9.1/step (1.14 ms) |
| gaps >= 50 us | 2.2/step (1.00 ms, incl. end-step drain) |
| micro gaps 1-5 us | ~1858/step (~6.4 ms) |

Interpretation: the bubble budget is almost entirely thousands of tiny
~3-4 us inter-kernel intervals, not a few big stalls.

## The quantize_q8_1 sandwich

| metric | value |
|--------|-------|
| quantize_q8_1 launches/step | ~419-433 (22% of all launches) |
| median duration | 1.36 us |
| median gap before | 3.36 us |
| median gap after | 3.44 us |
| adjacent bubble time | **2.88 ms/step = 37% of bubble budget** |
| successor | mul_mat_vec_q (100% of instances) |
| predecessors | unary_gated(silu) ~26%, rms_norm<1024> ~18%, previous GEMV ~15%, get_rows ~11% |

Upper-bound recoveries if a fusion removes both gaps of a boundary
(~6.8 us each):
- Approach A (rms_norm + quantize): ~81 instances/step x 6.8 us
  ~= 0.55 ms/step. Below the 1.0 ms KEEP gate alone.
- Approach B (quantize into GEMV prologue): all ~430 instances/step
  x 6.8 us ~= 2.9 ms/step upper bound (= measured adjacent bubble sum).
- Approach C (producer epilogue writes q8_1 directly): same theoretical
  ceiling as B, coverage depends on how many producers are fusible.

These are UPPER BOUNDS assuming gaps vanish completely. Real recovery will
be smaller; measure before claiming.

## Open questions (must answer during feasibility)

OQ1: why ~430 quantize_q8_1 but only ~400 vec_q GEMV launches per step?
     Find the extra consumers (MMQ tail? attention path?) from graph dump.
OQ2: are ggml HIP graphs actually active in the production build
     (GGML_HIP_GRAPHS=ON)? ANSWERED in experiments/e5b_attribution/README.md:
     - non-MTP decode (batch=1): ACTIVE (gaps are device-side per-node cost
       ~2.6 us inside replayed graphs; only true node-count fusion helps).
     - MTP verify steps with batch>4: graphs DISABLED by the RDNA3
       MMVQ-MMID sync limit (IQ3_XXS limit=4) -> host-side launch gaps.
     Consequence for E5A: on graphed steps, ONLY real fusion (fewer nodes)
     removes boundaries; on ungraphed MTP-verify steps, either re-enabling
     graphs (config: draft-n-max<=3, or later source: raise the RDNA3 mmid
     batch limits) or fusion helps. Re-census separately for MTP ON/OFF
     before picking chains.
OQ3: which producers dominate by bubble TIME not count (silu-gated chains
     may be longer than rms chains)?

## Planned first experiment (single mechanism)

After OQ2 resolves:
- If graphs inactive: quantify graph-enabled decode first (config-only
  change if possible), THEN re-census.
- If graphs active: implement approach A on ONE chain (rms_norm<1024> ->
  quantize_q8_1 feeding the following IQ3_XXS GEMV) as a standalone
  prototype mirroring e1b methodology; A/B against unfused pair; correctness
  vs reference; only then consider wider coverage.

KEEP gate (model-level, untraced, median>=5):
- >= 1.0 ms/token net improvement: KEEP candidate.
- 0.5-1.0: complexity/correctness evaluation.
- < 0.5: PARK this approach, move to next candidate.

## Caveats

- Trace was captured under rocprofv3; absolute gap sizes could be slightly
  inflated by profiling overhead, but totals match E2's UNtraced wall-gap
  measurements (7.4-7.7 ms/token), so the structure is trusted.
- Census is from ctx=16k only; re-run extractor on t63k/t128k DBs before
  finalizing chain priorities (GDN/attention mix changes with ctx).
