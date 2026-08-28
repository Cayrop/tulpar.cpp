# Project Understanding Report - Phase V2 Trace

Scope: `experiments/phase_v2_trace/`. Read-only analysis; no source changes, no commits.
Full per-file table: `file_inventory.md` (same directory).

Context (verified):
- Build: `build-p3/bin/llama-server`, HEAD `4f72448eb` (EXP-002: V2 model swap + baseline). Phase-2 fused q4_0 FA tile only; Phase-3 commits reverted (confirmed: staging dequant dispatches = 0 in all traces; hipBLAS at 0.3-0.9% prefill is the expected Phase-2 fallback).
- Model: `/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf`, SHA-256 `46151b52...86b3c8`, 10,676,423,744 bytes, 65 blocks. Qwen3.8-27B arch: 24 heads / 4 KV heads (6:1 GQA), key/value_length 256, vocab 248320, embedding 5120, 17 attention + 48 GDN layers.
- GPU: RX 7800 XT (gfx1101, RDNA3), 16 GB GDDR6, nominal 624 GB/s.
- Arms: `T-V2-1k-OFF` (ctx 2048), `T-V2-16k-OFF` (ctx 17408), `T-V2-63k-OFF` (ctx 64512), `T-V2-128k-OFF` (ctx 131072). MTP off. `n_predict = 64` per arm (ground truth from `D/response.json` `predicted_n`). Arm names refer to context size, not prompt size.
- Peak VRAM at 128k: 14.29 GiB (below 15.5 GiB guard).

## File Inventory

49 files under `experiments/phase_v2_trace/` (incl. build artifacts `mb.s`, `microbench_iq3xxs`) plus per-arm trace trees. See `file_inventory.md` for the full table with sizes and mtimes. Categories:

- Top-level: runner (`run_arm.sh`), analyzer (`analyze_arm.py`), attribution outputs, `bytes_per_step.json`, `gap_analysis.md`, `effective_bandwidth.md`, `model_verification.md`, `blockers.md`, grid analysis (`iq3xxs_grid_*`), Lloyd experiment (`lloyd_iq3xxs.py{,.out}`), AVX2 microbench (`microbench_iq3xxs.c`, `mb.s`, binary), `verification_results.json`.
- `bandwidth_investigation/` (16 files): ceiling + verdict + EXP-006 (hoist) results + stall characterization.
- `mmq_analysis/` (8 files): dispatch path, ISA, WMMA, occupancy, tile size.
- `trace_artifacts/<arm>/{P,D}/`: rocprofv2 CSVs (1.9-59 MB each), payloads, responses, server logs per arm.
- `trace_artifacts/pre_reset/`: historical EXP-005 (different binary/gfx1100/timeout on 128k; not comparable).

## Decode (TG) Summary

Source: `attribution_decode.md`, `attribution.json`, `gap_analysis.md`, `stall_budget.md`. All values verified against `analysis.json` and `D/response.json`.

| Arm | ctx | prompt_n | decode total (trace) | ms/token (trace) | ms/token (wall, server) |
|-----|----:|---------:|---------------------:|-----------------:|------------------------:|
| T-V2-1k-OFF | 2048 | 161 | 2554.4 ms | 39.91 | 57.61 |
| T-V2-16k-OFF | 17408 | 1421 | 2592.2 ms | 40.50 | 57.83 |
| T-V2-63k-OFF | 64512 | 5341 | 2602.1 ms | 40.66 | 58.68 |
| T-V2-128k-OFF | 131072 | 10671 | 2653.7 ms | 41.46 | 59.37 |

wall = `predicted_ms / predicted_n` from `D/response.json`. Decode kernel time is nearly context-independent (2554 -> 2654 ms, +4%); the growth is FA_tile (15.26 -> 104.62 ms, 0.6% -> 3.9% of decode).

Category share of decode kernel time (1k -> 128k):

| Category | 1k | 16k | 63k | 128k |
|----------|---:|----:|----:|-----:|
| GEMV_IQ3_XXS | 74.1% | 73.7% | 72.8% | 71.5% |
| GEMV_IQ3_S | 11.6% | 11.6% | 11.5% | 11.2% |
| GEMV_Q3_K | 3.5% | 3.5% | 3.4% | 3.4% |
| Norm_RMS | 1.6% | 1.7% | 1.6% | 1.6% |
| Quantize_q8_1 | 1.5% | 1.5% | 1.5% | 1.5% |
| Get_Rows | 1.3% | 1.3% | 1.3% | 1.2% |
| GEMV_IQ1_M | 0.9% | 0.9% | 0.8% | 0.8% |
| FA_tile | 0.6% | 0.9% | 2.2% | 3.9% |

Decode ms per category (1k -> 128k): GEMV_IQ3_XXS 1892.20 -> 1897.28; GEMV_IQ3_S 297.11 -> 298.62; GEMV_Q3_K 88.95 -> 89.25; Norm_RMS 42.23 -> 43.05; Quantize_q8_1 37.81 -> 38.62; FA_tile 15.26 -> 104.62.

Dispatches: ~1840/token constant across arms (e.g. GEMV_IQ3_XXS 13921-14057 per 64 tokens; FA_tile 989-999; Quantize_q8_1 26828-27112). Graph reuse: `graphs reused = 63` for 64-token generation (server log).

Gap budget (decode): total gap 1099.6-1116.8 ms per arm, ~17.2-17.5 ms/token = ~30% of wall time, constant across ctx sizes. Median gap 8.4 us (steady-state graph dispatch latency); p99 180-187 us; max 15-17 ms (systematic stalls at token 0/1/2 at rms_norm/copyBuffer boundaries, present in all arms, independent of context size).

## Prefill (PP) Summary

Source: `attribution_prefill.md`. Prefill segment = dispatches `[load_end, last_mmq_idx]`; totals are kernel-sum (GPU monotonic), not wall.

| Arm | prompt_n | prefill total (trace) | server prompt_ms | ms/token (trace) |
|-----|---------:|----------------------:|-----------------:|-----------------:|
| T-V2-1k-OFF | 161 | 321.9 ms | 492.9 | 2.000 |
| T-V2-16k-OFF | 1421 | 2535.0 ms | 2782.7 | 1.784 |
| T-V2-63k-OFF | 5341 | 9692.7 ms | 10167.6 | 1.815 |
| T-V2-128k-OFF | 10671 | 20514.6 ms | 21280.1 | 1.922 |

Category share of prefill kernel time (1k -> 128k):

| Category | 1k | 16k | 63k | 128k |
|----------|---:|----:|----:|-----:|
| MMQ_IQ3_XXS | 74.4% | 72.0% | 68.4% | 64.4% |
| MMQ_IQ3_S | 11.4% | 11.1% | 10.5% | 9.9% |
| GDN | 5.4% | 6.2% | 6.1% | 5.8% |
| FA_tile | 0.7% | 2.4% | 6.7% | 12.1% |
| hipBLAS_GEMM | 0.9% | 0.3% | 0.3% | 0.3% |

Prefill ms per category (1k -> 128k): MMQ_IQ3_XXS 239.38 -> 13218.39; MMQ_IQ3_S 36.56 -> 2031.37; GDN 17.26 -> 1189.16; FA_tile 2.09 -> 2478.33; hipBLAS_GEMM 2.75 -> 60.24.

Observations:
- MMQ_IQ3_XXS dominates prefill at every ctx (64-74%).
- FA_tile is the only ctx-scaling category: 12.1% at 128k, second-largest; it is the long-context prefill bottleneck.
- GDN is a fixed ~5-6% (per-token cost, not ctx-dependent).
- hipBLAS_GEMM at 0.3-0.9% is the expected Phase-2 fallback (Phase-3 threshold-raise commit is reverted in this baseline).
- Prefill gap share: 18.9% (1k) -> 3.1% (128k) of kernel time; prefill p99 gap ~22 us vs decode ~180 us.

## Bandwidth Summary

Reference points (`microbenchmark_results.md`, gfx1101):
- Nominal VRAM: 624 GB/s (GDDR6 spec, marketing/effective figure incl. Infinity Cache).
- Measured sustained sequential ceiling (1 GB read): **524.9 GB/s** (84% of nominal). IC cliff between 32 MB (719.3 GB/s) and 128 MB (529.5 GB/s).
- Random gather (hot data, index stream in VRAM): 787-1031 GB/s (cache-amplified, not VRAM).
- 1 KB table reads: ~5.3-5.5 TB/s (pure L1/L2).

`bytes_per_step` (per-token decode weight stream, `bytes_per_step.json`): IQ3_XXS 8,092,385,280 B (7.72 GB); IQ3_S 1,376,460,800 B; Q3_K 546,304,000 B; IQ4_XS 217,251,840 B; F32 10,647,552 B; IQ1_M 5,160,960 B.

Decode effective BW as reported in `effective_bandwidth.md` / `verdict.md` (denominator = `tokens_estimated` = 82..83, INCORRECT, see Devil's Advocate D-1):

| Quant | 1k | 16k | 63k | 128k |
|-------|---:|----:|----:|-----:|
| IQ3_XXS (GB/s) | 350.7 | 351.6 | 350.5 | 349.8 |
| IQ3_S (GB/s) | 379.9 | 378.6 | 378.2 | 378.0 |
| Q3_K (GB/s) | 503.6 | 501.3 | 502.8 | 501.9 |
| IQ1_M (GB/s) | 19.0 | 18.9 | 19.1 | 19.3 |
| IQ4_XS (GB/s) | 2433.6 | 2428.1 | 2410.5 | 2411.8 |

Corrected decode BW (denominator = `n_predict = 64`, from `verification_results.json` `corrected_decode_BW`):

| Quant | 1k | 16k | 63k | 128k |
|-------|---:|----:|----:|-----:|
| IQ3_XXS (GB/s) | 273.71 | 271.08 | 273.58 | 272.98 |
| IQ3_S (GB/s) | 296.51 | 291.97 | 295.15 | 295.00 |
| Q3_K (GB/s) | 393.05 | 386.55 | 392.39 | 391.73 |
| IQ1_M (GB/s) | 14.84 | 14.61 | 14.92 | 15.04 |
| IQ4_XS (GB/s) | 1899.47 | 1872.36 | 1881.48 | 1882.50 |

Interpretation (corrected):
- IQ3_XXS: 271-274 GB/s = 43.6-43.9% of nominal 624, **51.6-52.1% of the measured 525 GB/s ceiling**. Not at the hardware limit; headroom ~1.9x.
- Q3_K: 387-393 GB/s = ~63% nominal, **73.6-74.9% of ceiling**. Q3_K is near the ceiling (no dependent gather loads); IQ3_XXS is ~43% slower per byte (1.99 vs 2.85 ns/kB as reported; ratio holds after correction).
- IQ1_M: launch-overhead bound (15 GB/s, 5 MB total weights, 72 dispatches/token).
- IQ4_XS "1.9 TB/s": cache artifact (217 MB fits in L2/IC), not a VRAM stream. Not meaningful as VRAM bandwidth.
- Prefill "BW" table in `effective_bandwidth.md` is not a meaningful quantity: weights are read once per prefill, not per token; the table divides decode `bytes_per_step` by prefill ms/token and yields 5-28 TB/s values. See D-3.

## Bottleneck Analysis

Decode (TG):
1. GEMV_IQ3_XXS is the dominant decode cost (71-74%) and is bandwidth-underutilized: ~273 GB/s corrected (~52% of measured ceiling). Root cause per `dependency_chain_analysis.md` + `verdict.md`: 8 dependent global loads per vec_dot (L1 table gather on the inner-loop critical path) vs 0 for Q3_K. Compute is <0.001% of DP4A peak (irrelevant). `microbenchmark_results.md` confirms the limit is per-thread latency hiding, not VRAM-side: hot-data gather reaches 787 GB/s.
2. Gaps are ~30% of decode wall time (17.2-17.5 ms/token, constant across ctx): median 8.4 us x ~1840 dispatches/token of baseline graph dispatch overhead, plus a long tail (p99 180 us; max 15-17 ms systematic stalls at token 0/1/2, rms_norm/copyBuffer boundary, context-independent). The ">1 ms stalls are only 3-4% of total gap time"; the ~70%-of-gap claim corresponds to a >0.09 ms threshold (~73%).
3. FA_tile grows with ctx (0.6% -> 3.9% decode) but is small at 128k.
4. EXP-006 (hoisted parallel table load, `strategy_selection.md` + `benchmark_results.md`): MTP OFF avg +4.6% (1k -0.71%, 16k +1.59%, 63k +12.97%), MTP ON +7.55%/+8.01%/+1.59%; correctness 11/11 backend ops, 12/12 greedy determinism, 9/9 bit-exact short-context. Correctness verdict PASS but `decision: REVERT_PER_PROTOCOL_THRESHOLD` and `binary_sha256_post_change: to_be_filled` (artifact incomplete; see D-9).

Prefill (PP):
1. MMQ_IQ3_XXS dominates (64-74%). Per `isa_analysis.md` + `bottleneck_classification.md`: active variant is I=64/J=16 with `fallback=true`, 214 VGPR, 36 SGPR, 2063-line hot loop. WMMA IS used (`v_wmma_i32_16x16x16_iu8_w32`, INT8 path) but MMA is ~0.8% of the loop; dequant bit manipulation ~35%, s_delay_alu ~17% -> **dequant-ALU-bound, not MMA-bound**. `tile_size_calculation.md` concludes I=64/J=16 is well-tuned; the cost is per-K-iteration dequant.
2. FA_tile is the ctx-scaling prefill cost (0.7% -> 12.1%); at 128k it is the second category and the long-context prefill bottleneck.
3. hipBLAS_GEMM 0.3-0.9% prefill: expected Phase-2 fallback (Phase-3 revert baseline), not a regression.

## Devil's Advocate Results

D-1 (HIGH) - Decode BW denominator bug inflates every reported decode bandwidth figure.
`analyze_arm.py` computes `tokens_estimated = max(FA_tile_count//17, GDN_FWHT_count//48) = 82..83` and uses it to divide GEMV totals. Ground truth is `predicted_n = 64` from `D/response.json`. This inflates ms-per-token and effective BW by ~1.28x in `analysis.json`, `effective_bandwidth.md`, and `verdict.md`. Corrected: IQ3_XXS 350.7 -> 273.7 GB/s (56.2% -> 43.9% of nominal; 66.8% -> 52.0% of the measured 525 GB/s ceiling); Q3_K 503.6 -> 393.1 GB/s (96% -> 74.9% of ceiling); reported `calls_per_token` (e.g. IQ3_XXS 169.77) is also understated (true: 13921/64 = 217.5/token). Qualitative conclusions survive (not at ceiling; Q3_K faster due to zero dependent loads), but magnitudes change. 4 of the 8 failed checks in `verification_results.json` (2 per arm x 4 arms... exactly 2 failing checks per arm, 8 total) trace to this.

D-2 (MEDIUM) - "% of nominal 624 GB/s" double-inflates.
The 624 GB/s reference already includes Infinity Cache effects (32 MB reads measure 719 GB/s = 115%). The honest denominator for this model (8.09 GB IQ3_XXS stream, 99% IC miss) is the measured 525 GB/s sustained ceiling. Even the inflated 350.7 GB/s is only 66.8% of 525; corrected 273 GB/s is ~52%. Any headroom claim should be stated against 525 GB/s.

D-3 (MEDIUM) - Prefill "effective bandwidth" table is not meaningful.
`effective_bandwidth.md` prefill table divides decode `bytes_per_step` by prefill ms/token (weights read once per prefill, not per token), producing 5-28 TB/s and a literal `bytes/step: 0` column. These numbers should not be cited. A meaningful prefill BW metric would be total weight bytes / prefill duration.

D-4 (LOW) - IQ4_XS "2.4 TB/s (390% of nominal)" is a cache artifact (217 MB resident in L2/IC); the "effective BW" label overstates. Flagged UNCERTAIN in-source; agreed.

D-5 (MEDIUM) - `gap_analysis.md` line 48 states "gap time is a significant fraction of decode wall time (43%)". The table (line 24: `gap_share` 30.1%) is gap/kernel. The true wall share is gap/(kernel+gap) = 29.5-30.1%. The 43% figure is mislabeled. (Note: pre-reset `attribution.md` had a similar "total gap" table; reset-run numbers are consistent after correction.)

D-6 (LOW) - "Stalls are ~70% of gap time" (user claim, per `stall_budget.md`) is threshold-dependent: gaps >1 ms are only 3-4% of total gap time; gaps >0.09 ms are ~73%. Both statements are true under different thresholds; the report does not state which.

D-7 (MEDIUM) - pre_reset/ artifacts are NOT comparable to the reset run.
Pre-reset EXP-005 used the Phase-2+3 binary on gfx1100, single-token decode profiles (576 GEMV dispatches), and a 128k prefill that timed out. Its headline numbers (GEMV_IQ3_XXS 56.8% of decode, FA 0.4%) differ structurally from the reset run (71-74%, 0.6-3.9%) for reasons of build, capture method, and token count, not measurement error. Treat as historical context only; do not blend with reset-run numbers.

D-8 (LOW) - Arm naming vs prompt size. Arm names denote ctx size (2048/17408/64512/131072); actual `prompt_n` is 161/1421/5341/10671, and `summary.json` `prompt_tokens_payload` is 1792/17000/64000/128000. The analysis tables use `prompt_n`; the reason `prompt_n < prompt_tokens_payload` is undocumented (UNCERTAIN per `verification_results.json known_discrepancies`).

D-9 (LOW) - EXP-006 artifacts are internally inconsistent. `correctness_results.json` has `verdict: CORRECTNESS_PASS` but `decision: REVERT_PER_PROTOCOL_THRESHOLD` and `binary_sha256_post_change: "to_be_filled"`. Whether the hoist change is present in HEAD `4f72448eb` is UNCERTAIN from these artifacts alone; `benchmark_results.md` numbers (+4.6% avg) should be treated as experimental results on a since-reverted branch until confirmed.

D-10 (LOW) - Kernel-count-based token estimates are upper bounds, not exact (B-7): FA_tile 989-999 per 64 tokens (expected ~15.5-17/token), GDN_FWHT 3956-3996 (expected ~48-62/token). `n_predict = 64` is the only reliable decode token count.

Verification status: `verification_results.json` - 4 arms x 20 checks = 80 checks, 8 failed (all D-1: `gemv_iq3xxs_ms_per_token_vs_n_predict`, `decode_tokens_denominator`), `all_ok: false`. All totals, ms/token, wall times, category shares, and `bytes_per_step` values cross-checked OK.

## [DECISION TICKET]

Denominator correction must be applied before any further BW-based decision-making.

- Decision needed: accept the corrected decode numbers as the official Phase V2 baseline (IQ3_XXS 271-274 GB/s = ~44% of nominal / ~52% of measured ceiling; Q3_K 387-393 GB/s = ~75% of ceiling) and re-issue `verdict.md` / `effective_bandwidth.md` figures, or explicitly keep the 82..83-based numbers with a caveat.
- Impact: the "33% below ceiling" headline becomes "48% below ceiling"; the EXP-006 +4.6% result and the gather-chain-latency root-cause story are unchanged in kind, only in magnitude.
- No qualitative conclusion is invalidated: decode is latency-bound on the dependent gather chain, not at the VRAM limit; prefill is dequant-ALU-bound.
- Secondary cleanup (no decision required, cosmetic): relabel `gap_analysis.md` 43% -> 30% wall share; mark prefill BW table as not-meaningful.

## Sources

- `attribution_decode.md`, `attribution_prefill.md`, `attribution.json` (decode/prefill totals, categories)
- `trace_artifacts/<arm>/D/response.json`, `trace_artifacts/<arm>/summary.json` (n_predict, prompt_n, wall times)
- `effective_bandwidth.md`, `bytes_per_step.json` (BW inputs and tables)
- `gap_analysis.md`, `stall_budget.md`, `stall_characterization.md`, `stall_pattern_analysis.md`, `stall_root_cause.md` (gap and stall stats)
- `bandwidth_investigation/`: `microbenchmark_results.md`, `verdict.md`, `theoretical_ceiling.md`, `dependency_chain_analysis.md`, `kernel_analysis.md`, `lookup_table_analysis.md`, `occupancy_analysis.md`, `strategy_selection.md`, `benchmark_results.md`, `correctness_results.json`, `fusion_feasibility_analysis.md`
- `mmq_analysis/`: `dispatch_path.md`, `isa_analysis.md`, `kernel_implementation.md`, `wmma_analysis.md`, `rdna3_config.md`, `bottleneck_classification.md`, `tile_size_calculation.md`
- `model_verification.md`, `blockers.md`, `file_inventory.md`, `verification_results.json`
- `trace_artifacts/pre_reset/attribution.md` (historical, D-7)

PROJECT_UNDERSTANDING_OK
