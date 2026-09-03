# FINAL REPORT: Qwen3.8-27B (UD-Q2_K_XL) Decode Performance on RX 7800 XT
Investigator: ox-alpha research agent | 2026-08-22 | All claims evidence-linked in Evidence Index.

# Executive Summary
- Baseline (user config, MTP draft-mtp n_max=4 p_min=0.8): effective decode 21.7-35.6 tok/s
  @63k ctx; 23.5-47.2 @1k ctx. The reported 29.34 tok/s (@6.3k prompt) sits inside this band;
  it is a mid-low acceptance sample of a HIGH-VARIANCE system, not a distinct anomaly.
- Primary confirmed bottleneck at long context: flash-attention kernel inefficiency on RDNA3.
  flash_attn_ext_vec<256,1,q4_0,q4_0> = 49% of GPU time @63k non-spec decode, running at ~5%
  of achievable VRAM bandwidth (~33GB/s vs 624GB/s peak). NOT a bandwidth limit - a kernel
  efficiency problem specific to D=256 + q4_0 KV + gfx1101 code paths.
- Second confirmed bottleneck (MTP mode): CUDA-graph churn from variable verify batch sizes:
  105k eager kernel launches per 25s vs 9.8k in non-spec mode; causes the huge latency
  variance and the low speed floor at short context (GPU only 75% busy).
- MTP itself is net-positive: 2.0-2.7x median over non-spec (11.2 -> 21.7-30 @63k), but far
  from the theoretical ~5x because verification rounds carry heavy fixed costs (tile FA +
  full-cache KV dequant + catch-up + d draft passes).
- No code was changed. Two zero-risk config experiments run: fixed-shape drafting removed the
  variance entirely (37-41 tok/s tight band @1k) and lifted the floor; n_max=1 proved harmful.
- Production instance restored to exact original configuration.

# System Manifest
- GPU: AMD Radeon RX 7800 XT (gfx1101, Navi 32), 60 CU, 17.16GB VRAM; peak usage 15.39GB.
- ROCm 7.2.4, rocprofv3 1.1.0 (rocprofiler-sdk), rocm-smi 4.0.0.
- OS: CachyOS, kernel 7.1.8-1-cachyos, single NUMA node, 16 threads Ryzen 7 5700X, 32GB RAM.
- llama.cpp: build/bin/llama-server v0.1.2-dev (build 10530, commit 849798132 = b10524-6),
  Clang 22.0.0, CUDA/HIP graphs ON by default (GGML_CUDA_USE_GRAPHS).
- Model: /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf (10.67GB,
  md5 9cecae1d6d66aa79559b807252404192), arch qwen35: 65 blocks = 48 GDN linear-attn layers
  + 17 full-attention layers + blk64 with MTP nextn head. head_count 24, kv_heads 4 (GQA 6),
  head_dim 256, embd 5120, ffn 17408, native ctx 262144, IMROPE sections [11,11,10,0].
  Weight mix (by tensor count): FFN=IQ3_XXS, attn proj+ssm_out=IQ3_S, attn_v=IQ4_XS,
  lm_head=Q3_K - i.e., "Q2_K_XL" label notwithstanding, no Q2_K tensors dominate compute.
- Server flags (production, restored): -c 65536 -ngl 999 --load-mode mmap -fa on
  -ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --metrics
  --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8
- Runtime facts: MTP uses a SECOND llama_context over the same model (MTP graph = eh_proj +
  1 decoder block + shared LM head) with its own KV cache (also q4_0, same size as target's).
- No container (host namespaces); ptrace_scope=1 blocks rocprofv3 --pid attach
  (PTRACE_SEIZE EPERM, error captured); traces collected via child-process launch instead.
- Server restarts performed (documented): 20:40 by user before campaign; by agent for
  T3/T1/X sessions; final restore verified identical cmdline + health + smoke test.
- GPU clocks during all benchmarks: sclk 2300-2451MHz, mclk up to 1218MHz, power <=211W
  (TBP 263W), temp edge <=52C. NO thermal/power throttling.

# Benchmark Results (decode tok/s, server-reported predicted_per_second)
| Config | ctx | n | median | min | max | stdev-ish |
|---|---|---|---|---|---|---|
| MTP OFF | 1k | 3 | 19.81 | 19.64 | 19.81 | ~0.1 |
| MTP OFF | 63k | 2 | 11.21 | 11.15 | 11.27 | ~0.1 |
| MTP ON (baseline) | 1k | 5+3 | 38.5 / 28.7 | 28.1 / 23.5 | 47.2 / 40.8 | high |
| MTP ON (baseline) | 63k | 6 | 25.4 | 21.7 | 35.6 | high |
| MTP ON fixshape (n_min=4,p_min=0) | 1k | 3 | 40.27 | 37.25 | 40.68 | LOW |
| MTP ON fixshape | 63k | 2 | 23.71 | 21.85 | 25.57 | low |
| MTP ON nmax1 | 1k | 3 | 27.07 | 22.42 | 28.97 | med |
| MTP ON nmax1 | 63k | 2 | 14.63 | 14.56 | 14.70 | LOW |
Prefill (fresh): 450-511 tok/s @~1-7k -> 484 @13.9k -> 422 @27.8k -> 333-337 @56-63k ->
315 @65.5k (17 full-attn layers keep prefill nearly linear to ~30k, then mild decay).
MTP acceptance (per-request timings.draft_n_accepted/draft_n): highly variable 51%-100%;
acceptance correlates with speed r=+0.54 (n=10).

# Context Scaling Analysis
- Prefill degrades gracefully (-35% from 13.9k to 65.5k) thanks to 48/65 GDN layers.
- Decode cost/token: OFF 50.5ms @1k -> 89.2ms @63k (+77%). Of the +38.7ms, trace attributes
  ~+37ms to flash_attn_ext_vec alone (0.081->2.474ms x 16 layers). Everything else is flat.
- MTP-ON decode is bimodal, not smoothly scaling: acceptance quality decides which mode.

# ROCm Trace Analysis (rocprofv3 runtime-trace, CSV)
- T3 (OFF) @63k decode window: GPU busy 91%; FA-VEC 49.2%, MMVQ ~34%, GDN 3.2%, rest small.
- T1 (ON) @63k decode window [225-250s]: GPU busy 84.5%.
  FA family total 39.0% = tile<8,2> verify 23.4% + full-cache q4_0->f16 dequant 6.8%
  + vec<256,1> draft ctx 4.3% + vec<256,2> 2.9% + tile<1> catch-up 1.6%.
  MMVQ ~45% dominated by IQ3_XXS ncols=5 verify FFN (31.5%).
- T1 @1k window: GPU busy 74.8% -> 25% CPU-side gaps (launch+sync+sampling chain).
- API counts @63k ON window: hipLaunchKernel 104,967 vs hipGraphLaunch 662;
  hipStreamSynchronize 27,369 calls / 22.09s cumulative (CPU waits on GPU);
  hipGraphInstantiate 5 x 20ms. OFF equivalent: 9,812 eager / 253 graphs.
- Memory copies: <1% of wall time in all windows (D2H logits traffic exonerated).

# Top Kernels (63k decode)
See results/traces/w_63k_decode_on_clean.json (ON) and T3_off_kernel_report.json phases 18/19 (OFF).

# Kernel-to-Source Mapping
See results/source_mapping/mapping.md (20 mappings, confidence levels included).
Key chain example (highest-confidence):
flash_attn_ext_vec<256,1,Q4_0,Q4_0> -> BEST_FATTN_KERNEL_VEC (fattn.cu:527-530, rule Q->ne[1]<=2)
-> flash_attn_ext_vec<D=256> template (fattn-vec.cuh:18-21) -> RDNA3 nthreads_KQ_q=2 hardcoded
(fattn-vec.cuh:74-79) -> measured 2.47ms/call @63k, 33GB/s effective.

# Hypothesis Ledger
Full ledger with predictions, for/against, alternatives, falsification tests:
results/hypotheses/ledger.md. Verdict summary:
- H3 attention/KV @long ctx: STRONGLY SUPPORTED (as kernel inefficiency, not BW saturation).
- H5 VRAM BW underuse: STRONGLY SUPPORTED (FA 5.3%; matvec 24-48%).
- H7 ROCm/gfx-specific path: SUPPORTED (RDNA3 hardcoded cooperative-thread=2, WMMA excluded D>128).
- H8 suboptimal kernel selection: SUPPORTED (>2-col verify forced to TILE+full-cache-dequant).
- H6 launch/sync/graph-churn: SUPPORTED (dominant at short ctx & all MTP modes).
- H4 MTP verification limits speedup: SUPPORTED (fixed round costs; but MTP still net 2x win).
- H12 compound bottleneck: STRONGLY SUPPORTED.
- H1 Q2-GEMV primary: REJECTED (weights are IQ3/IQ4 mix; spread cost; FA dominates @long ctx).
- H2 weight-dequant primary: REJECTED (fused; only KV-dequant matters, via H8).
- H9 VRAM capacity: REJECTED (no spill; clocks healthy).
- H11 spec-length-3 pipeline flaw: REJECTED in this form (nmax1 test: shorter = worse).
- H10 sampling/CPU loss: TENTATIVE (25% idle @1k includes it; magnitude unmeasured).

# Rejected Explanations
- Thermal/power throttling (clocks logged stable 2300-2451MHz, 211W max).
- VRAM spilling (peak 15.39/17.16GB; no GTT growth).
- Logits D2H copies (<1% wall).
- Weight dequantization overhead (fused into MMVQ/MMA; quantize_q8_1 = 0.9% GPU).
- "29.34 tok/s anomaly" - within normal band for its acceptance draw.
- KV cache q4_0 read cost being bandwidth-bound (it is kernel-bound).

# Confirmed Bottlenecks (ranked by wall-clock impact)
1. FA-VEC/TILE kernel efficiency on gfx1101 @long ctx: ~44% of wall @63k OFF, ~33% @63k ON.
   Amdahl: perfect FA -> max 1.79x (OFF 11.2->20.1); realistic 3x FA gain -> 1.41x (->15.8).
2. MTP graph churn + launch path: 25% idle wall @1k ON; Amdahl ceiling 1.33x if eliminated;
   empirically demonstrated by X_fixshape variance collapse (floor 23.5->37.3 @1k).
3. Matvec efficiency ceiling (IQ3_XXS fused FFN at ~300GB/s = 48% peak): broad, no single fix.

# Optimization Opportunities (evidence-ranked; none applied to production)
| Opportunity | Expected max (Amdahl) | Realistic | Evidence | Risk |
|---|---|---|---|---|
| Adopt/cherry-pick PR #26419 (WMMA FA for D=256 RDNA) | 1.79x @63k | 1.2-1.4x | [REPORTED] PR data +13-22% pp | medium (open PR) |
| Fixed-shape drafting (n_min=n_max, p_min=0) | removes variance; floor lift @short ctx | DONE as experiment: floor +59% @1k | CONFIRMED here | zero (flag change); tradeoff: lower acceptance ceiling |
| Upstream #27009 padded-ubatch graphs | structural fix for churn | unknown | [REPORTED] open issue | - |
| nthreads_KQ_q bump / occupancy tuning fattn-vec RDNA3 | part of #1 | needs ATT profiling | CONFIRMED loc (fattn-vec.cuh:74-79) | medium (kernel patch) |
| Build with -DGPU_TARGETS=gfx1101 native | correctness/occ | unknown | [REPORTED] #25620 | low |
| f16 KV to skip tile dequant | 1.06x @63k ON only | - | CONFIRMED cost (6.8%) | DOES NOT FIT VRAM at 64k |

# Changes Made
NONE to source or production configuration. Production server running with user's original
flags (verified). Experiments ran in dedicated restart windows and were restored afterwards.
Artifacts: results/{bench,campaign,campaign2,analyze_campaign,analyze_trace,window_analysis,
orchestrate,opt_experiment}.py, results/experiments/*.json+logs, results/traces/* (raw CSVs kept).

# Before vs After (experiment-level, not production changes)
- Baseline ON @1k: 23.5-47.2 (median 28.7-38.5 across sessions) -> X_fixshape: 37.3-40.7.
  Variance collapsed; worst-case improved +59%. Median roughly unchanged vs best draws.
- @63k: baseline 21.7-35.6 vs fixshape 21.9-25.6: neutral (FA-bound regime unchanged).
- X_nmax1 rejected: 14.6 @63k (vs 11.2 OFF / 21.7+ baseline ON).
Devil's advocate checks applied: identical prompts/seeds across variants; clocks verified;
server-reported timings cross-checked against trace GPU time (within ~10%); profiler-overhead
caveat: traced sessions may understate tok/s slightly; clean untraced numbers used for headline
comparisons where available (campaign2 vs T1 agree within noise).

# Devil's Advocate Review
- Could FA slowness be an artifact of tracing overhead? No: untraced runs show the same
  context-scaling of decode cost (+77%/token 1k->63k OFF), and FA share comes from kernel
  durations, not API overhead.
- Could the acceptance-speed correlation be reversed causation (fast rounds draft more)? The
  X_fixshape intervention (forced constant drafts) broke the correlation AND the variance -
  supports shape-stability mechanism, not reverse causation.
- Could model file be mislabeled (not really "Q2")? Verified from GGUF metadata directly;
  the label mismatch is real and documented; conclusions use actual types.
- Remaining alternative not fully excluded: sampling-chain CPU cost inside the 25% idle @1k
  (would need CPU-side profiling; backend_sampling=false default).

# Remaining Unknowns
1. Exact reason full graph replay is not restored under fixed-shape MTP (interleaved captures
   across two contexts vs op-level exclusions) - requires instrumented capture-path logging.
2. FA-VEC internal stall reasons on gfx1101 (occupancy? dp4a throughput?) - needs
   rocprofv3 PC-sampling/ATT, GGML_HIP_EXPORT_METRICS build.
3. Sampling-chain share of the 1k idle gap.
4. Whether PR #26419 numbers transfer to gfx1101 (PR tested on gfx1201/RDNA4).

# Reproduction Commands
# Environment/clocks monitor during any run:
rocm-smi --showclocks --showpower --showtemp --showuse --showmeminfo vram   # every ~3s
# Clean benchmark request (MTP ON baseline):
curl -s localhost:8080/completion -d '{"prompt":"...","n_predict":128,"cache_prompt":false,
"ignore_eos":true,"seed":555}'   # read .timings.predicted_per_second, .draft_n*
# Non-spec comparison requires server restart WITHOUT --spec-type* flags (request-level
# speculative.type is ignored by slot loop - server-context.cpp:2927).
# Traced session (attach is blocked by yama; use wrapper):
rocprofv3 -r -d <dir> -f csv -- ./llama-server <flags>
# Window analysis:
python3 results/window_analysis.py results/traces/<id>/cachyos-x8664/*_kernel_trace.csv T0 T1 out.json

# Evidence Index
| Claim | Evidence |
|---|---|
| Attach impossible (yama) | traces/attach_test_0 stdout: PTRACE_SEIZE errno 1 |
| MTP request-toggle ignored | smoke ON/OFF metrics deltas; server-context.cpp:2927 |
| Weights are IQ3/IQ4 mix, not Q2 | GGUF header census (this report, System Manifest) |
| OFF decode 19.8 / 11.2 tok/s | experiments/session_T3_mtpoff.json |
| ON baseline bands | experiments/campaign2_results.json, session_T1_mtpon.json, ctx63k_long_log.txt |
| FA 49% GPU @63k OFF | traces/T3_off_kernel_report.json phases 18-19 |
| FA family 39% + dequant 6.8% @63k ON | traces/w_63k_decode_on_clean.json |
| Graph churn numbers | hip_api_trace.csv windows [225,250]s (T1) vs [245,268]s (T3) |
| fixshape variance collapse | experiments/opt_fixshape.json |
| nmax1 harmful | experiments/opt_nmax1.json |
| Clocks/throttling clean | experiments/gpu_clocks.csv (129 samples) |
| Kernel-source mappings | source_mapping/mapping.md |
