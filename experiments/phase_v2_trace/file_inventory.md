# Phase V2 Trace - File Inventory

Root: `experiments/phase_v2_trace/`
Sizes in bytes. mtimes from filesystem.

## Top level

| Path | Bytes | Mtime | Description |
|------|------:|-------|-------------|
| `analyze_arm.py` | 15735 | 2026-08-27 10:54 | Arm analysis script. Parses rocprofv2 dispatch CSVs, classifies kernels into categories, computes per-category totals, gaps, effective BW. Contains the `tokens_estimated` denominator bug (uses `max(FA_tile//17, GDN_FWHT//48)` = 82..83 instead of `n_predict = 64`). |
| `attribution.json` | 39429 | 2026-08-27 11:41 | Machine-readable aggregation of all 4 arms; source for `attribution_decode.md` / `attribution_prefill.md`. |
| `attribution_decode.md` | 4935 | 2026-08-27 11:47 | Per-arm decode summary: totals, ms/token (trace + wall), category %, counts, total ms. |
| `attribution_prefill.md` | 3908 | 2026-08-27 11:48 | Per-arm prefill summary: totals, ms/token (trace + server), category %, counts, total ms. |
| `blockers.md` | 4308 | 2026-08-27 11:50 | Reset-run blockers/notes B-1..B-8 (rocprofv2 CSV output, server kill, prompt/EOS fix, VRAM guard, Phase-3 revert check, hipBLAS note, token estimate, server linger). |
| `bytes_per_step.json` | 134 | 2026-08-27 10:30 | Per-quant bytes streamed per decode step (IQ3_XXS 8,092,385,280; IQ3_S 1,376,460,800; Q3_K 546,304,000; IQ4_XS 217,251,840; F32 10,647,552; IQ1_M 5,160,960). |
| `effective_bandwidth.md` | 6361 | 2026-08-27 11:48 | Per-quant decode/prefill effective BW table. Decode table uses the buggy 82..83 denominator; prefill table is not a meaningful quantity (see report DEVILS-3). |
| `gap_analysis.md` | 3660 | 2026-08-27 11:49 | Per-arm gap stats (median 8.4-8.7 us, p99 180-187 us decode, max 15-17 ms decode / 38-40 ms prefill) and per-token gap budget (~17.3 ms). |
| `iq3xxs_grid_analysis.md` | 9719 | 2026-08-28 00:31 | `iq3xxs_grid` value extraction and byte histogram (8 distinct byte values). |
| `iq3xxs_grid_deep_dive.md` | 18615 | 2026-08-28 00:11 | Grid structure, LDS bank-conflict analysis, CPU-side profiling of table access. |
| `iq3xxs_grid_values.json` | 10191 | 2026-08-27 18:34 | The 256 uint32 codewords of `iq3xxs_grid`. |
| `lloyd_iq3xxs.py` | 2823 | 2026-08-27 20:53 | Lloyd quantization distortion experiment for the IQ3_XXS grid. |
| `lloyd_iq3xxs.py.out` | 933 | 2026-08-28 00:31 | Output of `lloyd_iq3xxs.py`. |
| `mb.s` | 39422 | 2026-08-27 20:33 | Build artifact: intermediate assembly of the AVX2 microbenchmark. |
| `microbench_iq3xxs` | 20776 | 2026-08-27 20:39 | Build artifact: compiled AVX2 table-vs-arithmetic microbenchmark. |
| `microbench_iq3xxs.c` | 12146 | 2026-08-27 20:39 | AVX2 microbenchmark source (table lookup vs arithmetic dequant). |
| `model_verification.md` | 3632 | 2026-08-27 11:46 | Model/build identity: Qwen3.8-27B-UD-Q2_K_XL, SHA-256, tensor inventory, arch params (24 heads / 4 KV heads, vocab 248320, embedding 5120). |
| `run_arm.sh` | 10045 | 2026-08-27 11:03 | Per-arm runner: rocprofv2 + llama-server + curl, wait/kill, P and D trace capture. |
| `verification_results.json` | 16266 | 2026-08-28 04:35 | Numeric verification: 4 arms x 20 checks, 8 failed (all from the denominator bug), `all_ok: false`, `known_discrepancies` populated. |

## `bandwidth_investigation/`

| Path | Bytes | Mtime | Description |
|------|------:|-------|-------------|
| `benchmark_results.md` | 3829 | 2026-08-27 14:44 | EXP-006 (hoisted parallel table load) benchmark: MTP OFF avg +4.6%, 63k +12.97%; MTP ON +7.55%/+8.01%/+1.59%. |
| `blockers.md` | 1104 | 2026-08-27 16:55 | Stall-investigation blockers (layer mapping unavailable, no HIP memory trace, 70% claim discrepancy). |
| `correctness_results.json` | 1130 | 2026-08-27 14:44 | EXP-006 correctness gate: 11/11 backend ops, 12/12 greedy determinism, 9/9 bit-exact; verdict `CORRECTNESS_PASS` but `decision: REVERT_PER_PROTOCOL_THRESHOLD`; `binary_sha256_post_change: to_be_filled`. |
| `dependency_chain_analysis.md` | 6130 | 2026-08-27 13:13 | Per-iteration load dependency graph of `vec_dot_iq3_xxs_q8_1`: 8 dependent global loads per vec_dot vs 0 for Q3_K. |
| `fusion_feasibility_analysis.md` | 6999 | 2026-08-27 15:37 | RMSNorm + Quantize + GEMV fusion feasibility: 838.6 fused dispatches/token (45.5% of decode dispatches). |
| `kernel_analysis.md` | 9482 | 2026-08-27 12:58 | IQ3_XXS vs Q3_K GEMV kernel comparison (lane utilization, per-byte cost). |
| `lookup_table_analysis.md` | 3706 | 2026-08-27 12:58 | `iq3xxs_grid` is a 1 KB device global; all accesses L1-hit; not the bottleneck. |
| `microbenchmark_results.md` | 4259 | 2026-08-27 12:57 | gfx1101 VRAM ceiling measurements: 524.9 GB/s sustained 1 GB sequential (84% of nominal 624); IC cliff between 32 MB (719.3) and 128 MB (529.5); random gather 787-1031 GB/s (cache-amplified); 1 KB table reads ~5.3-5.5 TB/s. |
| `occupancy_analysis.md` | 4781 | 2026-08-27 12:58 | GEMV launch geometry and register pressure (1 warp per block, `__launch_bounds__(32, 1)`). |
| `stall_budget.md` | 3245 | 2026-08-27 16:55 | Per-arm decode gap budget: ~17.2-17.5 ms/token = ~30% of wall; gaps >1 ms are only 3-4% of total gap time. |
| `stall_characterization.md` | 3300 | 2026-08-27 16:54 | Table of decode gaps >1 ms per arm (max 15-17 ms). |
| `stall_pattern_analysis.md` | 2584 | 2026-08-27 16:54 | Systematic stalls at token 0/1/2 (rms_norm/copyBuffer boundary, 15-17 ms, all arms, context-independent) vs stochastic tail. |
| `stall_root_cause.md` | 5819 | 2026-08-27 16:54 | Candidate root causes for the long-tail stalls (memory pool allocation hypothesis). |
| `strategy_selection.md` | 3685 | 2026-08-27 13:13 | EXP-006 candidate strategies: parallel table load hoist = HIGH viability / zero numerical impact; LDS pre-load = REJECTED. |
| `theoretical_ceiling.md` | 7340 | 2026-08-27 12:59 | Decode/prefill bandwidth and compute ceilings per quant type. |
| `verdict.md` | 3700 | 2026-08-27 12:59 | Final BW verdict. Qualitative conclusion holds, but the numeric figures (350.7 GB/s, 66.8% of ceiling) use the inflated denominator (see report DEVILS-1). |

## `mmq_analysis/`

| Path | Bytes | Mtime | Description |
|------|------:|-------|-------------|
| `bottleneck_classification.md` | 4659 | 2026-08-27 17:33 | ISA-level classification: MMA 0.8% of hot loop, dequant bit manipulation ~35%, s_delay_alu ~17%. |
| `dispatch_path.md` | 4196 | 2026-08-27 17:25 | MMQ dispatch path: entry -> type switch -> tile/J selection. |
| `isa_analysis.md` | 6654 | 2026-08-27 17:27 | Compiled ISA of active J=16 kernel: 214 VGPR / 36 SGPR, 2063-line hot loop. |
| `kernel_implementation.md` | 6289 | 2026-08-27 17:26 | Kernel flow: load_tiles -> vec_dot -> write_back. |
| `occupancy_analysis.md` | 5445 | 2026-08-27 17:28 | Occupancy estimate (register-limited, 2 blocks/CU). |
| `rdna3_config.md` | 3606 | 2026-08-27 17:26 | Active RDNA3 MMQ config for IQ3_XXS: I=64, J=16, fallback=true, nthreads=128, nwarps=4. |
| `tile_size_calculation.md` | 4246 | 2026-08-27 17:30 | Tile-size options analysis; conclusion: I=64/J=16 is well-tuned, bottleneck is per-K-iteration dequant, not tile size. |
| `wmma_analysis.md` | 5214 | 2026-08-27 17:31 | WMMA is used (`v_wmma_i32_16x16x16_iu8_w32`, INT8 path); MMA is a small fraction of the loop. |

## `trace_artifacts/<arm>/` (per arm: `T-V2-1k-OFF`, `T-V2-16k-OFF`, `T-V2-63k-OFF`, `T-V2-128k-OFF`)

| Path | Bytes | Mtime | Description |
|------|------:|-------|-------------|
| `analysis.json` | 8879-9166 | 2026-08-27 11:11-11:34 | Raw per-arm analysis (category totals, counts, gaps, gemv_bw with the buggy denominator). |
| `summary.json` | 376-387 | 2026-08-27 11:09-11:41 | Arm metadata (ctx, prompt_tokens_payload, n_predict). |
| `P/payload.json` | 807-48103 | 2026-08-27 | Prefill request payload. |
| `P/response.json` | 2334-49960 | 2026-08-27 | Prefill server response (prompt_n, prompt_ms, timings). |
| `P/results_trace_P.csv` | 1989628-18781560 | 2026-08-27 | rocprofv2 dispatch trace, prefill segment. |
| `P/server_stderr.log` | 3508-4242 | 2026-08-27 | Server stderr (model load, graph compile). |
| `P/server_stdout.log` | 537-539 | 2026-08-27 | Server stdout (request log). |
| `D/payload.json` | 808-48103 | 2026-08-27 | Decode request payload (same prompt, `n_predict = 64`). |
| `D/response.json` | 2674-49960 | 2026-08-27 | Decode server response (predicted_n = 64, predicted_ms, predicted_per_token). |
| `D/results_trace_D.csv` | 42268647-59141541 | 2026-08-27 | rocprofv2 dispatch trace, decode segment (117638-118950 dispatches). |
| `D/server_stderr.log` | 3305-4039 | 2026-08-27 | Server stderr. |
| `D/server_stdout.log` | 537-539 | 2026-08-27 | Server stdout. |

## `trace_artifacts/pre_reset/` (historical, pre-reset EXP-005 run)

| Path | Bytes | Mtime | Description |
|------|------:|-------|-------------|
| `analyze_trace.py` | 10896 | 2026-08-26 23:37 | Pre-reset trace analyzer (stdout-based, superseded by `analyze_arm.py`). |
| `attribution.json` | 8342 | 2026-08-26 23:56 | Pre-reset per-arm aggregation. |
| `attribution.md` | 5248 | 2026-08-26 23:55 | Pre-reset attribution (different binary/GPU: Phase-2+3, gfx1100; 128k prefill timed out; not comparable to reset run). |
| `blockers.md` | 1009 | 2026-08-26 23:56 | Pre-reset blockers. |
| `EXP-005_draft.md` | 2299 | 2026-08-26 23:40 | EXP-005 draft notes. |
| `make_payload.py` | 860 | 2026-08-26 23:26 | Payload generator (repetitive-prompt version, superseded). |
| `run_arm.sh` | 4945 | 2026-08-26 23:18 | Pre-reset arm runner. |
| `run_arm_v2.sh` | 3664 | 2026-08-26 23:41 | Pre-reset arm runner v2. |
| `run_one_arm.sh` | 3762 | 2026-08-26 23:26 | Pre-reset single-arm runner. |
| `start_rocprofv2.sh` | 1756 | 2026-08-26 23:33 | Pre-reset rocprofv2 launcher. |
| `start_server.sh` | 1775 | 2026-08-26 23:32 | Pre-reset server launcher. |
| `trace_attach.sh` | 4613 | 2026-08-26 23:25 | Pre-reset trace attach helper. |
| `T-V2-1k-OFF/*` | - | 2026-08-26 23:30-23:37 | 1k arm pre-reset artifacts (response, logs, trace_analysis). |
| `T-V2-16k-OFF/*` | - | 2026-08-26 23:42-23:43 | 16k arm pre-reset artifacts (payload, response, logs, 133 MB stdout). |
| `T-V2-63k-OFF/*` | - | 2026-08-26 23:45-23:48 | 63k arm pre-reset artifacts (payload, response, logs, 217 MB stdout). |
| `T-V2-128k-OFF/*` | - | 2026-08-26 23:48-23:54 | 128k arm pre-reset artifacts (prefill only, timed out; 250 MB stdout). |
