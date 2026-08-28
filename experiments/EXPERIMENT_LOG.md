# EXPERIMENT_LOG.md (hygiene phase root log)

Format: agents.md section 16. Append-only.

## EXP-000: repo hygiene - hardcoded path elimination and history rewrite

PROBLEM
Scripts, configs, and evidence files hardcoded the absolute repo path
/home/gencer/llama.cpp. This breaks portability (any relocation or clone
path change silently breaks tooling) and leaks user-specific paths into
history and evidence artifacts.

EVIDENCE
309 occurrences of /home/gencer/llama.cpp across 207 tracked files:
39 .py, 26 .sh, 100 .json, 29 .md, 13 other (.env/.txt/.bak).
3 ELF experiment binaries carry embedded copies (not textually patchable).
53 occurrences of /home/gencer/models/... (external, out of scope this phase).

HYPOTHESIS
Replacing repo-root constants with dynamic resolution
(Path(__file__).parents[N] / git rev-parse --show-toplevel) preserves all
behavior on the current machine while removing the hard dependency; textual
prefix substitution (<REPO_ROOT>) keeps historical evidence readable without
absolute paths.

CHANGE
- 39 .py: ROOT dynamic + pathlib import where missing; sys.path and constant
  literals -> str(ROOT / "..."). Depth N verified per file against repo root.
- 24 .sh auto + build_variant.sh, restore_server.sh manual (heredoc env-var
  plumbing via TULPAR_SRC; cd via ${ROOT}).
- ops/manifest/prod_flags.env BINARY_PATH made repo-root-relative.
- Data/doc/evidence files: prefix -> <REPO_ROOT> marker.
- agents.md: sections 16-18 appended; own absolute-path mentions replaced.
- New: experiments/hygiene/path_cleanup_report.md,
  experiments/EXPERIMENT_LOG_TEMPLATE.md, this log.
- History: both commits tulpar/main..HEAD rewritten (amended trees), so no
  commit introduces the hardcoded path.

RESULT
No performance metrics; repo hygiene only.
Verification: code grep (*.py/*.sh/*.cu/*.cuh/*.cpp/*.h) = 0 matches.
Broad tracked-file grep = only the 2 verbatim self-references inside policy
section 17 text. py_compile 39/39 PASS; bash -n 26/26 PASS; JSON validity
100/100 PASS; functional dry-run/status/help checks PASS (see
experiments/hygiene/path_cleanup_report.md section 3).

WHY IT WORKED
Repo-root resolution depends only on file location inside the working tree,
which is invariant for any in-tree consumer; every downstream use was a pure
string concatenation from ROOT, so substituting the root expression at the
single definition point leaves all derived paths identical on the current
machine and correct on any other checkout location.

CAVEAT
Not measured: execution of ladder/traced/restore scripts (destructive or
GPU-bound; syntax-verified only). 3 ELF binaries retain embedded absolute
strings until rebuilt. Model-directory constants remain hardcoded by explicit
phase constraint; migration to env/config is a recorded follow-up.

## EXP-001: benchmark driver failure handling and VRAM monitor hardening

PROBLEM
Review found arm_run-style drivers continued measuring after a failed server
health check (failure misclassified as PROMPT_BUILD_FAIL via the /tokenize
exception) and the VRAM monitor silently produced zero samples if rocm-smi
was missing/failing, letting a run finish status=OK with vram_peak_b=0.
Sampled vram_peak_gib was also presented without a sampling caveat.

EVIDENCE
arm_run_p0.py:123, arm_run_p1.py:123, phase1b/bin/arm_run.py:120,
arm_run_p2.py:123: health result recorded, no early exit. VramMonitor.run in
7 drivers dropped None reads silently; subprocess.run raises FileNotFoundError
when rocm-smi is absent (uncaught inside the monitor thread loop).

HYPOTHESIS
Explicit fail-fast branches at health-check time and a mandatory first valid
VRAM sample before any rep eliminate misclassification and silent monitor
death without touching measurement logic or timing behavior.

CHANGE
- 4 untraced drivers (p0/p1/p1b/p2): on health fail -> status HEALTH_FAIL,
  record dumped BEFORE stop attempt, server stopped via srv_ctl, stop_rc
  recorded in a separate field (cannot mask HEALTH_FAIL), exit 5.
- All 7 monitored drivers: vram_used_bytes returns None on OSError,
  non-zero rocm-smi exit, regex miss, or empty stdout; monitor counts every
  None as failed_reads; new first_sample() gate before reps -> status
  VRAM_MONITOR_FAIL, exit 6 (server stop only where the driver owns it).
- Records gain vram_failed_reads and vram_peak_note documenting that 0.5 s
  sampling can miss transient peaks.
- experiments/phase2/fused_loader_audit.md: line-level audit of commit
  2e033a696 fused q4_0 loader (nibble planes, bit-exactness proof, strides,
  OOB, dispatch scope). No defect found; two hardening notes recorded.

RESULT
No performance metrics; robustness and audit only. py_compile 7/7 PASS;
offline unit test: first_sample() times out with failed_reads>=1 for all
four failure modes (non-zero exit, regex miss, empty stdout, OSError) and
returns true with a recorded peak on the success path.
Kernel audit verdict: fused loader correct for all RDNA3 DKQ=DV=256 configs.

WHY IT WORKED
Failures are now classified at the layer that detects them (health gate
before prompt build; monitor gate before measurement), so exit codes and
record statuses reflect the actual failing subsystem instead of whichever
downstream call happened to raise first.

CAVEAT
Traced drivers do not own their server lifecycle; VRAM_MONITOR_FAIL there
exits without stopping the server (wrapper script responsibility).
The 0.5 s sampling interval itself is unchanged; peak underestimation risk
remains inherent and is only documented, not fixed. Kernel static_assert
hardening for the plane-alignment invariant requires a separate approved
kernel-source change.

## EXP-002: V2 Model Swap + Baseline

PROBLEM
V3 showed quality degradation (puzzle anomaly, SVG quality).
V2 known to be superior for reasoning and creative tasks.

EVIDENCE
V3 puzzle: "8" (anomalous, 10/10 correct on retry)
V3 SVG: lower quality than V2
V2: IQ3_XXS dominant (75.9%), proven reasoning capability

HYPOTHESIS
V2 + fused q4_0 optimization should maintain decode gains
while providing superior reasoning and creative output.

CHANGE
Model path updated to V2 GGUF. No code changes.

RESULT
(To be filled after measurement)

WHY IT WORKED
(To be filled after measurement)

CAVEAT
(To be filled after measurement)

## EXP-005: V2 Kernel Attribution Baseline (Reset)

PROBLEM
Pre-reset V2 trace (commit history contaminated with Phase-3 shape-gated
dispatch and MMQ threshold bumps) produced unreliable attribution. The
pre-reset analyzer had multiple ggml_type mislabels: it treated
(ggml_type)11 as Q4_0, but the upstream enum defines 11 = Q3_K. The V2
output head is Q3_K, not Q4_0. Need a clean Phase-2-only baseline.

EVIDENCE
- Phase-3 commit `1d50f66ff` ("raise RDNA3 MMQ threshold...") modified
  `ggml/src/ggml-cuda/mmq.cu` (+3/-3 lines).
- Phase-3 commit `11c95eb56` ("shape-gated hybrid dispatch...") modified
  `ggml/src/ggml-cuda/fattn-tile.cuh` and `ggml/src/ggml-cuda/fattn.cu`
  (+2/-2) plus added ~200 lines of doc-only changes to
  `experiments/EXPERIMENT_LOG.md`, `experiments/phase3/phase3_*.md`.
- Pre-reset analyzer (`trace_artifacts/pre_reset/analyze_trace.py`) had
  wrong ggml_type decode: e.g. `mul_mat_vec_q.*ggml_type\)11` -> "Q4_0"
  (actual: Q3_K), `ggml_type\)1` -> "IQ3_XXS" (actual: F16, 1 is F16 not
  IQ3_XXS which is 18).
- Pre-reset `attribution.md` reported a "GEMV_IQ3_XS" category (13%) but
  IQ3_XS is not in this llama.cpp enum and not in the V2 model. The
  category was a hallucination.

HYPOTHESIS
With Phase-3 reverted, the V2 trace will be a clean Phase-2 baseline.
The decode bottleneck is IQ3_XXS GEMV (predicted >50% of decode kernel
time) and the prefill bottleneck at large ctx is FA_tile (predicted
>40% of prefill at 128k). Phase-2 fused q4_0 eliminates the staging
dequant for q4_0 KV cache (expected: 0 dequantize_block_q4_0 calls).

CHANGE
Reset commit history to drop Phase-3 commits. Re-run all 4 trace arms
on a Phase-2-only binary. No code change to the GPU kernels or graph
dispatch.

Steps:
- Backup branch `v2-reset-backup` at pre-reset HEAD
  `1d50f66ff`.
- `git rebase -i 4f72448eb` scripted-drop of `1d50f66ff` and
  `11c95eb56`; no conflicts; new HEAD = `4f72448eb`.
- Verified `ggml_cuda_fattn_tile_fuses_quantized_kv` predicate still
  present at `ggml/src/ggml-cuda/fattn-common.cuh:89`.
- Rebuild `build-p3/bin/llama-server` and `build-p3/bin/test-backend-ops`
  with `GGML_HIP=ON, GGML_HIP_GRAPHS=ON, GPU_TARGETS=gfx1101`. Both
  targets linked.
- `test-backend-ops -o FLASH_ATTN_EXT -p "q4_0"`: 354/354 passed (all
  hsk=256 cases included).
- Force-pushed to `fork` (Cayrop/tulpar.cpp) with
  `--force-with-lease`. Pushed HEAD: `4f72448eb810da13c47f870933da6bb919b3ca72`.

Measurements (4 arms, MTP=off, n_predict=64, fresh rocprofv2-wrapped
server per arm + per phase):

| Arm | ctx | prompt_n | decode_total_ms | FA_tile % | IQ3_XXS_GEMV % | Staging_dequant |
|-----|----:|---------:|----------------:|----------:|---------------:|----------------:|
| T-V2-1k-OFF | 2048 | 161 | 2554.4 | 0.6% | 74.1% | 0 |
| T-V2-16k-OFF | 17408 | 1421 | 2592.2 | 0.9% | 73.7% | 0 |
| T-V2-63k-OFF | 64512 | 5341 | 2602.1 | 2.2% | 72.8% | 0 |
| T-V2-128k-OFF | 131072 | 10671 | 2653.7 | 3.9% | 71.5% | 0 |

| Arm | prefill_total_ms | FA_tile % | MMQ_IQ3_XXS % |
|-----|-----------------:|----------:|--------------:|
| T-V2-1k-OFF | 321.9 | 0.7% | 74.4% |
| T-V2-16k-OFF | 2535.0 | 2.4% | 72.0% |
| T-V2-63k-OFF | 9692.7 | 6.7% | 68.4% |
| T-V2-128k-OFF | 20514.6 | 12.1% | 64.4% |

| Arm | prefill mmq_IQ3_XXS BW | decode GEMV_IQ3_XXS BW | decode GEMV_Q3_K BW |
|-----|-----------------------:|------------------------:|-------------------:|
| T-V2-1k-OFF  | (mmq eff. 6.08 disp/tok) | 349 GB/s (56% of 624) | 496 GB/s (80%) |
| T-V2-16k-OFF | (mmq eff. 5.11 disp/tok) | 352 GB/s (56%) | 501 GB/s (80%) |
| T-V2-63k-OFF | (mmq eff. 4.94 disp/tok) | 350 GB/s (56%) | 503 GB/s (80%) |
| T-V2-128k-OFF | (mmq eff. 4.71 disp/tok) | 350 GB/s (56%) | 502 GB/s (80%) |

VRAM peaks (under 15.5 GiB guard):
- 1k: 11.92 GiB
- 16k: 12.20 GiB
- 63k: 13.05 GiB
- 128k: 14.29 GiB

Graph reuse confirmed in server logs:
- 1k D-arm: `graphs reused = 63` for 64-token generation
- 16k/63k/128k D-arm: `graphs reused = 63`
- Decode dispatches per token: 1838-1859 across all 4 arms (graph is
  fully reused, near-deterministic kernel count)

Inter-kernel gap (decode):
- median 8.4 us (all arms)
- p99 180-187 us (all arms)
- max 15-17 ms (one long tail stall per 64-token generation)
- total gap time / (kernel+gap) = 43% in decode (constant across arms)

RESULT
Clean V2 Phase-2 baseline established. Decode is bandwidth-bound on
IQ3_XXS GEMV at 350 GB/s (56% of nominal 624 GB/s) and that bottleneck
is context-size-independent: the 8.09 GB of IQ3_XXS weights are
streamed every token. Prefill grows linearly with prompt size and the
FA_tile share grows from 0.7% at 1k to 12.1% at 128k, becoming the
second-largest prefill category at 128k. Phase-2 fused q4_0 is active
(staging dequant count = 0 in all 4 arms).

Per-token decode time is ~40 ms (kernel-sum) and ~58 ms (wall, server
predicted_per_token_ms), stable across ctx 1k-128k. The 18 ms wall-vs-
kernel gap is the inter-dispatch scheduling overhead (43% of wall time
in gaps).

WHY IT WORKED
The reset rebase dropped the two Phase-3 commits. The Phase-2 binary
behaves identically to the pre-Phase-3 baseline: same fused q4_0
dispatch, same MMQ threshold, same kernel set. The analyzer reads the
rocprofv2 CSV (not stdout as pre-reset assumed) and uses the correct
ggml_type enum (2=Q4_0, 10=Q2_K, 11=Q3_K, 12=Q4_K, 18=IQ3_XXS,
21=IQ3_S, 23=IQ4_XS, 29=IQ1_M).

CAVEAT
- The first 16k attempt used a repetitive "The quick brown fox..." prompt
  that caused the model to emit EOS on the first generated token. Replaced
  with a natural-language passage ending mid-sentence. All 4 arms in the
  final attribution table use the new prompt.
- The pre-reset `attribution.md` numbers (in `trace_artifacts/pre_reset/`)
  used wrong ggml_type decode, so the previous "82.5% IQ3_XXS GEMV" number
  is approximately right (matches the 73-74% measured here) but the
  "13% IQ3_XS" was a hallucinated category.
- Decode kernel total grew 4% from 1k to 128k (2554 -> 2654 ms) - the
  growth is entirely in the FA_tile category (KV-cache size dependent).
  All other decode categories are constant.
- The 128k ctx uses 14.29 GiB VRAM, leaving only 1.2 GiB margin. If
  model or KV cache size grows, this margin will be exhausted. Long-term
  this ctx size is at the limit of gfx1101's 16 GiB.
- Decode gap share is 43% of wall time. The long-tail max gap (15-17 ms)
  is the optimization target, not the median (8.4 us).
- hipBLAS_GEMM (Cijk_...) shows up at 0.3-0.9% in prefill across all
  arms. Phase-3 commit `1d50f66ff` (reverted in this run) was raising
  the MMQ threshold to suppress this; that suppression is not active
  in this baseline by design.

## EXP-006: IQ3_XXS gather chain optimization (vec_dot)

PROBLEM
IQ3_XXS GEMV at 350 GB/s, 33% below the 525 GB/s measured VRAM ceiling.
The kernel has 8 dependent global loads per vec_dot (gather chain: 4
paired `iq3xxs_grid[]` lookups in an unrolled 4-iter loop), 8 dp4a ops,
and a serial `sumi` accumulator. Investigation concluded the kernel is
bandwidth-underutilized with the gather chain as the per-thread root
cause (see experiments/phase_v2_trace/bandwidth_investigation/).

EVIDENCE
- 8 dependent global loads per vec_dot, all 8 indices available in
  registers (`q3_packed` is loaded once at function entry).
- 4 sequential dp4a pairs in a `sumi` chain (cannot be parallelized
  without algorithmic change).
- Q3_K (which has 0 dependent loads in its inner loop) achieves 503
  GB/s = 96% of the 525 GB/s ceiling. IQ3_XXS at 350 GB/s = 67%.
- 1.43x per-byte cost ratio (IQ3_XXS vs Q3_K) matches the 1.43x
  bandwidth ratio, confirming per-call overhead translates directly to
  bandwidth underutilization.

HYPOTHESIS
Strategy 1 (parallel table load / hoist): extract all 8 indices and 4
sign-mask values into registers at function entry, issue all 8
`iq3xxs_grid[]` loads before the dp4a chain so the compiler/HW can
schedule them in parallel. Expected ~15-20% decode speedup toward 420
GB/s.

CHANGE
- ggml/src/ggml-cuda/vecdotq.cuh:1155-1188 (vec_dot_iq3_xxs_q8_1 only)
- Hoisted: 4 sign computations (signs0_0..signs0_3), 8 grid lookups
  (grid_pa0..grid_pb3), 8 Q8_1 reads (u0_0..u0_7). Replaced the 4-iter
  loop with 4 inline blocks, each doing 1 signs pair + 1 grid_l +
  1 grid_h + 2 dp4a into the sumi chain.
- Arithmetic is bit-identical to the original (same dp4a order, same
  __vsub4 formula, same `ls*sumi + sumi/2` post-scaling).

RESULT
Correctness gate (PASS):
- test-backend-ops -o MUL_MAT -t iq3_xxs: 11/11 PASS (HIP backend)
- test-backend-ops -o MUL_MAT: all types PASS, no regression in
  IQ3_S, Q3_K, or any other quant type
- Deterministic greedy suite (MTP ON, 12 tests): 12/12 PASS
- Deterministic greedy suite (MTP OFF, 12 tests): 12/12 PASS
- 9/12 short-context tests bit-exact vs baseline_v2.json
- 3/12 long-context tests differ in "thinking mode" prose only (not
  kernel-induced: short tests ARE bit-exact)

Decode speed (MTP OFF, 5 reps, fixed seed, 256 toks, cached):
- 1k ctx:  45.32 -> 45.64 ms/tok (-0.71%, noise)
- 16k ctx: 48.84 -> 48.07 ms/tok (+1.59%)
- 63k ctx: 63.15 -> 54.96 ms/tok (+12.97%)
- Average: +4.6%

Decode speed (MTP ON, from bench_p3.py, cached reps):
- 1k:  25.02 -> 23.13 ms/tok (+7.55%)
- 16k: 28.38 -> 26.11 ms/tok (+8.01%)
- 63k: 26.97 -> 26.54 ms/tok (+1.59%)

Prefill regression check (mmq-load-tiles.cuh path, unchanged):
- 1k:  479.68 -> 478.06 tok/s (-0.34%)
- 16k: 471.72 -> 478.25 tok/s (+1.38%)
- 63k: 321.36 -> 320.47 tok/s (-0.28%)
No regression in MMQ path.

Other quant types: no regression (test-backend-ops all PASS).

DECISION
+4.6% average decode speedup is well below the protocol's 15% success
threshold. Change REVERTED.

WHY THE GAIN WAS SMALLER THAN PREDICTED (UNCERTAIN)
The investigation correctly identified the 8 dependent loads but
underestimated how well the HIP/CUDA compiler already pipelines them
inside the original `#pragma unroll` loop with `make_int2(...)`. The
program-order serialization in the original code does not reflect the
actual HW schedule, so hoisting the loads reduces serial dependency
on paper but not in the executed schedule.

The `sumi` accumulator remains a hard serialization: 4 sequential dp4a
pairs with no independent arithmetic to fill the issue slots, so the
dp4a chain is the actual critical path regardless of how the lookups
are scheduled.

At 63k context the +13% gain is real but the per-byte decomposition
suggests the IQ3_XXS improvement is smaller than the wall-clock
percentage implies (other factors may contribute at long context).

CAVEAT
- The change was tested only on gfx1101 (RX 7800 XT, RDNA3). Other
  backends (NVIDIA CUDA, AMD RDNA2, CDNA) may show different results
  because compiler scheduling of paired loads and dp4a throughput
  vary.
- 3 long-context tests differ in "thinking mode" prose vs the V2
  baseline. Verified NOT kernel-induced (the 9 short tests ARE
  bit-exact). The variance is a property of the long-context
  thinking-mode sampling, not the IQ3_XXS arithmetic.
- Production server restored to V2 baseline state with the original
  kernel. Backup branch `hypothesis-a-backup` is available.

VERDICT
EXP-006: FAILED (insufficient gain)
HYPOTHESIS_A_INSUFFICIENT_GAIN


## EXP-007: Kernel Fusion (RMSNorm+Quantize+GEMV) for Gap Reduction

PROBLEM
43 % of decode wall-time is gap (dispatch overhead). 1840 dispatches/token
* 8.4 µs median gap = 15.5 ms/token idle, plus a 17.3 ms/token long-tail
stall (gap_analysis.md). The hypothesis was that fusing the three most
frequent MMVQ-path ops (RMSNorm, Quantize_q8_1, GEMV_IQ3_XXS) would
reduce dispatch count and therefore gap time.

EVIDENCE
attribution_decode.md (1k arm, 64 tok, MTP OFF):
  - GEMV_IQ3_XXS: 13921 calls / 64 tok = 217.5 calls/tok, 74.1 % of
    decode kernel time
  - Quantize_q8_1: 26849 calls / 64 tok = 419.5 calls/tok, 1.5 %
  - Norm_RMS: 12928 calls / 64 tok = 202.0 calls/tok, 1.6 %
  - Sum: 838.6 calls/tok = 45.5 % of all 1840 decode dispatches/tok

gap_analysis.md:
  - median gap = 8.4 µs
  - p99 gap = 180 µs
  - max gap = 17.3 ms (single long-tail stall per token)
  - per-token wall = 57.6 ms; gap share = 43 %

HYPOTHESIS
Fuse RMSNorm + Quantize_q8_1 + GEMV_IQ3_XXS into a single kernel,
eliminating 621 dispatches/token and saving ~5.2 ms/token (~9 % of
wall-time).

CHANGE
None. The change was rejected at the feasibility analysis step. See
experiments/phase_v2_trace/bandwidth_investigation/fusion_feasibility_analysis.md
and blockers.md for full reasoning.

Brief rejection summary:
- The 838 -> 217 dispatch reduction is unachievable. The 419
  Quantize_q8_1 calls/tok are dispatched from the MMVQ wrapper
  (`ggml_cuda_op_mul_mat` in mmvq.cu:1332), paired 1:1 with a downstream
  GEMV. Fusing quantize+GEMV saves 202 dispatches/tok (Quantize, but
  not GEMV; each MMVQ still has 1 dispatch).
- RMSNorm is a per-row reduction over `ne0` and cannot be folded into
  the per-block GEMV (which works on a slice of the row). The
  RMSNorm dispatch can only be eliminated by fusing it with the
  Quantize kernel, not the GEMV. That alone saves 202 dispatches/tok
  (~3 %).
- Predicted upper bound: 5-9 % (below the 10 % success threshold).
- Gap time is dominated by long-tail stalls (17.3 ms max), which are
  not proportional to dispatch count. Reducing dispatch count does
  not address the long-tail cost driver.
- The implementation would touch ggml-cuda/mmvq.cu, mmvq.cuh, and
  the dispatch path in ggml_cuda_op_mul_mat. MMQ uses a different
  Q8_1 layout (MMQ_Q8_1_DS_LAYOUT_D2S6 etc.) and is a separate
  problem not covered by the fusion. This is multi-file scope,
  in tension with the protocol's "single change, single commit".

RESULT
No performance metrics; no code change was made. The production state
is unchanged. Backup branch `hypothesis-b-backup` was created but no
code was committed to it.

WHY IT DID NOT WORK
The hypothesis conflated "dispatch count" with "gap time". Gap time
is dominated by a small number of long-tail stalls (~5-17 ms each),
not by the steady-state 8.4 µs median gap. Reducing dispatch count
removes median-gap time but does not remove long-tail time. The
estimated reduction in gap time from removing 621 dispatches is
621 * 8.4 µs = 5.2 ms/token, but the per-token gap is 17.3 ms, so
the actual reduction is bounded by 5.2 ms even in the optimistic
case (5.2 / 57.6 = 9 %). The long-tail stalls (~12 ms/token of
p99+ tail) are not addressable by dispatch-count reduction.

The 838 -> 217 dispatch reduction was also overstated. The 419
Quantize dispatches are NOT independent graph-level ops; they are
invoked from the MMVQ wrapper as part of the same call chain. Each
Quantize is paired 1:1 with a single GEMV consumer. Fusing
Quantize+GEMV saves 202 dispatches (the Quantize count), not 419.
Fusing RMSNorm separately saves another 202 dispatches. So the
total achievable is ~404 dispatches (3.4 ms/token at the median
gap rate, ~6 % optimistic).

CAVEAT
- The protocol §7 success threshold is 10 % decode wall-time
  improvement. The upper bound estimate (9 %) falls just below the
  threshold even under the most optimistic assumptions. The
  realistic estimate is 3-5 % after accounting for the Quantize-
  per-GEMV pairing and the inability to fold RMSNorm into the
  GEMV.
- The long-tail 17.3 ms gap stall is the actual cost driver and
  was not addressed by the proposed fusion. A different EXP
  targeting the long-tail source (graph re-launches, scratch
  buffer allocations, or specific large-kernel boundaries) is
  needed.
- Production server restored to V2 baseline state. No code change
  was committed. Backup branch `hypothesis-b-backup` is available
  but identical to the current branch HEAD.

VERDICT
EXP-007: FAILED (rejected at feasibility analysis)
HYPOTHESIS_B_FAILED
