# Phase-1A Baseline Measurement Design Report

Date: 2026-08-24
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (verified: HEAD == base commit, working tree has only untracked experiments/, results/, results2/, agents.md)
Model: /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf (sha256 46151b52...b3c8, 10.68 GB, qwen35 arch, 65+1 nextn layers)

## Summary verdict

```text
READY_FOR_DESIGN_ONLY = YES
READY_FOR_EXECUTION   = NO

SAFE_TO_BENCHMARK     = NO   (production server RUNNING right now; VRAM 14.98/17.16 GB used)
MTP_ACTIVATION        = KNOWN (--spec-type draft-mtp)
HIP_GRAPH_TOGGLE      = KNOWN (GGML_CUDA_DISABLE_GRAPHS env var)
BASELINE_BINARY       = build-p3/bin/llama-server (tulpar/main content)
PRODUCTION_BINARY     = build/bin/llama-server (older upstream content, Aug 20)
BLOCKER               = measurement window needs explicit human approval:
                        stop production -> run matrix -> restore -> verify health.
```

Bu fazda hicbir olcum calistirilmadi. Cikti = guvenli olcum tasarimi.

## 1. Consumed evidence

- agents.md (Phase-0 inventory, rules, open questions)
- results2/tulpar/PLAN.md (phase-1 method: windows, ctx targets, repeats)
- results2/tulpar/reports/p1_profiling.md (baseline table + decode time shares)
- results2/tulpar/reports/p2a_interim.md (E1/E2/E3 decomposition)
- results2/tulpar/reports/roadmap_v2.md (current roadmap state)
- results2/reports/final_report_phase2.md (W1-W9 windows, v5 patch, launch script, restore protocol)
- results2/p3/report_phase3.md (clean patch d906c4912 on fattn-rdna3-quant-tile branch; quality suites)
- results2/tulpar/perf_tulpar_base_off.json, perf_tulpar_base_on.json (historical baselines, build-p3 binary)
- results2/window_W*.json (phase-2 historical windows)
- Harnesses: results/orchestrate.py, results/bench.py, results2/correctness_suite.py,
  results2/window_runner.py, results2/p3_window.py, results2/p3_128k.py, results2/p3_quality_suite.py,
  results2/p3_degen_probe.py, results2/tulpar/p1_campaign.py
- results2/build_variant.sh + build_*.log
- /tmp/opencode/launch_prod.sh, /tmp/opencode/restore_server.sh (read-only inspection)
- Code: common/arg.cpp, common/common.cpp, common/speculative.cpp, common/log.cpp,
  src/llama-hparams.h, tools/server/server-task.cpp (metrics),
  ggml/src/ggml-cuda/ggml-cuda.cu, ggml/src/ggml-cuda/common.cuh,
  examples/speculative-simple/README.md, tools/server/README.md
- Live system (read-only): rocm-smi, pgrep, /proc/222841/exe, git status

Historical numeric results are NOT treated as new evidence. They define the
comparison targets and the fixed prompt/seed protocol for reproducibility only.

## 2. Production launch audit

Launch script: FOUND (outside repo, in volatile /tmp).

```bash
/tmp/opencode/launch_prod.sh      # wrapper: setsid nohup -> restore_server.sh
/tmp/opencode/restore_server.sh   # real launcher, exec ./llama-server with full flags
```

restore_server.sh flags (= orchestrate.py COMMON + SPEC + extras):
```
cd <REPO_ROOT>/build/bin
exec ./llama-server -m <model> --alias Qwen3.8-27b \
  -c 65536 -ngl 999 --load-mode mmap -fa on -ctk q4_0 -ctv q4_0 \
  --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
  --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 \
  --host 0.0.0.0 --port 8080 --metrics --tools all \
  --chat-template-kwargs '{"preserve_thinking": true}' \
  --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8
```

pidfile convention: NONE.
- No pidfile written by the launcher.
- Historical stop procedure is pgrep-based (`pgrep -x llama-server` then SIGINT,
  SIGKILL fallback), see p1_campaign.py:stop_prod and window_runner.py.
- CONFLICT: agents.md section 10 rule 2 says kill only via explicit pidfile.
  Current practice predates/violates that rule. This is a documented gap.

Production binary: `<REPO_ROOT>/build/bin/llama-server`
- Verified live right now: PID 222841, exe readlink == build/bin/llama-server,
  cwd == build/bin, uptime ~2h10m, health {"status":"ok"}, cmdline matches manifest.
- mtime Aug 20 12:58 -> built from older upstream content (pre-tulpar/main;
  exact commit UNKNOWN from mtime alone; final_report_phase2 era base was 849798132).
- IMPORTANT: production does NOT contain the tile-FA cherry-pick content that
  defines tulpar/main. The tile patch content lives in build-p3.

Safety verdict:

```text
PRODUCTION_LAUNCH_SCRIPT = FOUND (/tmp/opencode/, volatile location)
PIDFILE_CONVENTION       = MISSING (pgrep-based stops; conflicts with agents.md rule)
PRODUCTION_BINARY        = VERIFIED (build/bin, running now)
SAFE_TO_BENCHMARK        = NO while production runs; requires approved stop window
RISK                     = launcher not version-controlled; a reboot or /tmp cleaner
                           loses it. Copy into repo (results2/ops/) recommended.
```

## 3. Build variant audit

All six caches share identical key flags; only LLAMA_BUILD_TESTS differs.

| build dir | purpose | flags (diff vs common) | binaries | timestamp | production candidate? | notes |
|---|---|---|---|---|---|---|
| build/ | old upstream-era full build | TESTS=ON | full set: cli/bench/server/quantize/perplexity/gguf/speculative(+simple) | Aug 20 12:58 | YES (IS production, verified via /proc) | content predates tulpar/main tile patch |
| build-p3/ | tulpar/main content baseline + phase-3 clean patch validation | TESTS=ON | llama-server only (+impl lib, test-backend-ops per report_phase3) | Aug 24 00:20 | NO | == tulpar/main content per PLAN.md (byte-identical suite claim); used for perf_tulpar_base_* |
| build-v1/ | exp: nthreads_KQ_q 2->4 | TESTS=OFF | llama-server | Aug 23 00:11 | NO | REJECTED experiment artifact |
| build-v2/ | exp: block 128->256 | TESTS=OFF | llama-server | Aug 23 00:17 | NO | REJECTED |
| build-v5/ | exp: allow TILE for quantized KV (fattn.cu forced-VEC removed) | TESTS=OFF | llama-server | Aug 23 00:48 | NO | validated candidate; content later upstreamed as branch commit d906c4912 and now IN tulpar/main as 66dcba5eb |
| build-v6/ | diag: instrumented graph churn logging (v6diag) | TESTS=OFF | llama-server | Aug 23 01:47 | NO | temporary GGML_LOG_DEBUG build for graph reset investigation |

build_variant.sh: generates v1/v2/v3/v5 by sed/patching source, ccache cmake
build into build-vN, then `git checkout` restores pristine source. Flags:
Release, GGML_HIP=ON, GPU_TARGETS=gfx1101, FA_ALL_QUANTS=ON, HIP_GRAPHS=ON,
TESTS=OFF, CCACHE=ON.

Common cache flags (all dirs): Release, GGML_HIP=ON, GGML_CUDA=OFF,
GGML_HIP_GRAPHS=ON, GGML_HIP_MMQ_MFMA=ON, GGML_HIP_NO_VMM=ON,
GGML_CUDA_FA_ALL_QUANTS=ON, GGML_HIP_RCCL=OFF, GGML_BLAS=OFF,
GPU_TARGETS=gfx1101, EXAMPLES/SERVER=ON. LLAMA_CURL: not found in cache (UNKNOWN).

Recommended baseline binary: **build-p3/bin/llama-server**.
Confidence: HIGH for "matches tulpar/main behavior" (documented test+suite
verification in PLAN.md); MEDIUM-HIGH overall because it is an Aug 24 build and
no fresh hash-vs-source recheck exists in this phase.

Verification methods for next phase:
1. `git rev-parse HEAD` == 66dcba5eb at run time.
2. build-p3/bin/llama-server mtime >= Aug 24 00:20 and no rebuild since.
3. Optional strong check: rebuild-free identity probe - run
   `build-p3/bin/test-backend-ops` subset or compare srv log startup lines vs
   stored srv_tulpar_base_off.log (same model/ctx lines).
4. Record sha256 of libllama-server-impl.so in env manifest (cheap, one file ~7 MB).

## 4. MTP activation audit

Mechanism: FOUND, code-level verified.

- Flag: `--spec-type` accepts comma-separated list (common/arg.cpp:4173):
  none, draft-simple, draft-eagle3, draft-mtp, draft-dflash, draft-dspark,
  ngram-simple, ngram-map-k, ngram-map-k4v, ngram-mod, ngram-cache.
  Default: none. Env: LLAMA_ARG_SPEC_TYPE.
- MTP activation: `--spec-type draft-mtp`.
- Extra draft model NOT required when the GGUF carries nextn tensors:
  - load_mtp set when draft-mtp selected (common/common.cpp:1713) so blk.64.nextn.* load.
  - If no --spec-draft-model given, common_speculative_init_result creates
    ctx_dft from the SAME target model with ctx_type=LLAMA_CONTEXT_TYPE_MTP
    (common/speculative.cpp ~2386-2420). So `-m <gguf> --spec-type draft-mtp` suffices.
- Works in: llama-server (set_examples SERVER), llama-cli, speculative-simple example
  (README shows draft-mtp usage). NOT in llama-bench (no spec args there).
- Production tuning: --spec-draft-n-max 4 --spec-draft-p-min 0.8.
  fixshape variant (n_min=4 p_min=0) measured HARMFUL post-tile-patch
  (final_report_phase2 W9: acceptance collapse to 48%). Do not use in baseline.
- Acceptance metrics sources:
  1. /completion timings: draft_n, draft_n_accepted (per request; used by all harnesses).
  2. /metrics prometheus: llamacpp:spec_decode_num_draft_tokens_total,
     llamacpp:spec_decode_num_accepted_tokens_total,
     llamacpp:spec_decode_num_drafts_total,
     llamacpp:spec_decode_num_accepted_tokens_per_pos_total{position="i"}
     (tools/server/server-task.cpp:1554-1611). Delta-sampling before/after each rep
     gives exact accepted/drafted counts independent of response JSON.
  3. Server stderr shows draft init lines when spec args active.
- Effective tok/s: reported predicted_per_second already reflects user-visible
  wall time including verify overhead under ignore_eos + fixed n_predict.
  Report both raw tg-equivalence (predicted_n / predicted_ms) and
  mean accepted length (accepted_total / drafts_total).

Verdict:

```text
MTP_ACTIVATION = KNOWN
ON  : --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8
OFF : omit --spec-type entirely (default none)
NO BLOCKER for MTP ON/OFF baseline design.
```

## 5. HIP graph runtime audit

Code location (ggml/src/ggml-cuda/ggml-cuda.cu, compiled as HIP here):
- USE_CUDA_GRAPH guarded blocks; capture end/instantiate/launch ~4194-4226.
- ggml_backend_cuda_graph_compute warmup/state machine ~4247-4300
  (warmup complete / warmup reset / properties changed logic).
- Compatibility gate: ggml_cuda_graph_check_compability ~2548-2578
  (MUL_MAT_ID sync fallback disables graphs; log is NDEBUG-gated).
- Update detection: ggml_cuda_graph_update_required ~2585+ (uid reuse,
  size change, node property compare; logs "CUDA Graph id N reused").
- Struct + enable check: ggml/src/ggml-cuda/common.cuh:1240-1262.

Runtime toggle: FOUND.

```text
GGML_CUDA_DISABLE_GRAPHS=1    # any value present disables graphs (common.cuh:1258)
```
is_enabled() returns false for every graph when env var is set; execution goes
through direct kernel launches. No CLI flag exists; compile-time switch is
GGML_HIP_GRAPHS (already ON in all builds).

Fallback/disable reasons logged (GGML_LOG_DEBUG):
- "disabling CUDA graphs due to GPU architecture" (< Volta; n/a on gfx1101)
- "disabling CUDA graphs due to unsupported node type" (release build: compiled out)
- "CUDA graph warmup complete" / "CUDA graph warmup reset" (state machine)
- "CUDA Graph id %zu reused"

Debug visibility: debug logs are filtered by verbosity threshold
(common/log.cpp:85). Server flag `-v` / `--log-verbose` sets threshold to INT_MAX
(common/arg.cpp:3876-3881) -> graph state lines appear on stderr.
Related but separate: GGML_CUDA_GRAPH_OPT=1 enables an optional graph
optimization pass (default off; keep OFF for baseline).

Recommendation for next phases:
- Graph OFF arm: prefix server command with GGML_CUDA_DISABLE_GRAPHS=1.
- Confirm effect: run with `-v`, grep stderr for "warmup complete"/"id reused"
  (present = graphs live, absent during decode = disabled), plus expected
  wall-time delta direction.
- No code patch required.

## 6. Benchmark methodology

Chosen method: PRIMARY = server-window protocol (existing harness family);
SECONDARY = llama-bench cross-check.

Why primary server windows:
- Identical to ALL prior measurements (perf_tulpar_base_*, window_W*, win128_M*)
  -> only method comparable with historical reference numbers.
- Only method that covers MTP ON/OFF and acceptance metrics (llama-bench cannot).
- Measures prefill and decode separately per request (/completion timings).
- Reuses proven scripts (p1_campaign.py pattern: stop prod -> matrix -> traces -> restore prod).

Why secondary llama-bench:
- Cleaner isolation (fresh process per config, no slot/cache state), json output (-o json),
  built-in repetitions (-r). Good as sanity cross-check of OFF numbers.
- Limits: no -ctg in this build (confirmed: tools/llama-bench/llama-bench.cpp has
  -p/-n/-b/-ub/-ctk/-ctv/-t/-fa/-r/-o only); no speculative support; single
  process measures pp at depth p and tg AFTER processing p tokens.

Context handling WITHOUT -ctg:
- TG@depth D: `llama-bench -p <D_tokens> -n 128 ...` -> tg number is decode speed
  with KV filled to D tokens (first token decodes at depth D).
- PP@depth D: same command, read the pp number (-n small keeps runtime bounded).
- Depth fidelity note: llama-bench pp processes exactly p tokens in ubatch chunks;
  server-window prefill includes tokenizer + queueing; expect small systematic
  offsets between methods. Do NOT mix numbers across methods; report separately.

Prompt set (fixed, mirrors p1_campaign):
- make_text(words, seed) synthetic word-soup filler + summarize question:
  960w seed 555001 (~1k tok), 16320w seed 555001 (16k), 64512w seed 777001 (63k),
  129400w seed 888111 or campaign default (128k). Token counts verified via /tokenize.
- Correctness prompts: separate suite (TR+EN factual/arith/code/needle/degen trap).
- Rationale for synthetic: deterministic, length-controllable, matches every
  prior artifact. Known property: greedy degeneration loop on this prompt class
  is a DOCUMENTED baseline behavior (report_phase3 section 3), not a regression signal.

Sampling determinism:
- Perf protocol (comparability): temp 0.6, top_k 20, top_p 0.95, min_p 0.0,
  ignore_eos true, fixed seeds per rep (5500+i / 6600+i / 99100+i pattern),
  cache_prompt false for rep1 (fresh prefill), true for cached reps.
- Determinism gates (correctness only): temperature 0, top_k 1.
- Note: greedy determinism is asserted ONLY within identical binaries/configs;
  cross-binary divergence floor char 231@16k is the established noise class.

Repeats:
- Minimum 3 per cell (historical standard), prefer 5 for cells where expected
  deltas < 5% (graph ON/OFF, short-ctx arms).
- Report median; store every raw record; spread = min/max of reps.
- Fresh-prefill rep vs cached-decode reps recorded SEPARATELY (never averaged together).

Traced/untraced separation:
- Primary perf numbers: UNtraced only.
- rocprofv3 sessions are separate artifacts; traced/untraced delta historically
  within 3%; if tracing again, label trace_*_meta.json and never merge with untraced medians.

VRAM/OOM guard (16 GB card, model 10.68 GB weights):
- Measured peaks: 14.5 GB at 128k with -c 131072 q4_0 KV (win128_M1: peak 14.547 GB).
  63k fits comfortably; 128k leaves <1 GB headroom -> strict ordering mandatory:
  1k -> 16k -> 63k -> 128k, abort chain on first OOM.
- f16 KV arms allowed ONLY at <=16k (phase-2 C-test precedent; VRAM-infeasible beyond).
- Monitor: poll /sys/class/drm/card*/device/mem_info_vram_used at 50 ms
  (reuse p3_128k.py Mon class) + rocm-smi snapshot before/after each window.
- OOM rule: first OOM or vram_peak > 15.5 GB -> STOP escalating contexts, mark cell BLOCKED.

Environment pinning (template exists: results2/tulpar/env/):
- uname (7.1.8-1-cachyos), ROCm 7.2.4, clang 22.1.8 (from Phase-0 record),
  CPU Ryzen 7 5700X, power_profile, smi clocks/temp snapshot pre+post,
  git rev, binary path+mtime+sha256(libggml*), model sha256 (already recorded),
  env vars actually exported (incl. GGML_CUDA_DISABLE_GRAPHS state per arm).
- Clock/power discipline: no clock/power changes in this project ever; record
  smi before and after each window; discard window if thermal/power anomaly noted.

Artifact layout proposal (next phase):

```text
experiments/phase1b/
  env/            # fresh manifest copies
  commands/       # exact commands + harness diffs (if any)
  logs/           # srv_*.log stdout/stderr per window
  raw/            # per-rep JSON records, metrics deltas, vram monitors
  summary/        # medians, spreads, matrix table
```

## 7. Measurement matrix

Server-window primary protocol. Binary column = B1 unless noted.

| # | ctx target | mode | PP/TG | metric captured | binary | notes |
|---|---|---|---|---|---|---|
| 1 | 1k | MTP OFF | both | decode tok/s, prefill tok/s, ms/tok | build-p3 | 4 reps (1 fresh + 3 cached) |
| 2 | 16k | MTP OFF | both | same | build-p3 | 3 reps |
| 3 | 63k | MTP OFF | both | same | build-p3 | 3 reps, npred 380 |
| 4 | 128k | MTP OFF | both | same + VRAM peak | build-p3 | 1 fresh greedy + 2 cached; needle check |
| 5 | 1k | MTP ON | both | + draft_n, draft_acc | build-p3 | prod spec flags |
| 6 | 16k | MTP ON | both | same | build-p3 | known variance dip; median |
| 7 | 63k | MTP ON | both | same | build-p3 | acceptance 0.88 expected band |
| 8 | 128k | MTP ON | both | same | build-p3 | highest VRAM risk arm |
| 9 | 16k | MTP OFF, GRAPHS OFF | TG | decode tok/s | build-p3 | GGML_CUDA_DISABLE_GRAPHS=1; 5 reps |
| 10 | 63k | MTP OFF, GRAPHS OFF | TG | decode tok/s | build-p3 | 5 reps |
| 11 | 16k | MTP OFF, GRAPHS OFF | PP | prefill tok/s | build-p3 | 3 reps |
| 12 | 63k | MTP OFF, GRAPHS OFF | PP | prefill tok/s | build-p3 | 3 reps |
| 13 | 1k/16k/63k | MTP OFF | pp+tg | bench json | llama-bench (build-p3? see below) | cross-check only |

llama-bench binary availability problem: build-p3 contains ONLY llama-server.
Cross-check must either use build/bin/llama-bench (OLD content, acceptable for
method-comparison purposes ONLY IF labeled) or skip until a matching bench
binary exists. DECISION: do NOT use build/bin/llama-bench against build-p3
server numbers as a like-for-like comparison; treat as OPTIONAL future item
(requires building bench from tulpar/main = code-change-adjacent action needing
its own approval). Matrix row 13 marked DEFERRED.

Historical reference anchors (NOT evidence, comparability targets):
- OFF decode medians (build-p3, Aug 24): 21.40 / 20.32 / 15.67 / 12.15 tok/s @1k/16k/63k/128k.
- ON decode medians (build-p3, Aug 24): 26.03 / 37.66 / 24.98 / 23.16 tok/s.
- OFF prefill: 499 / 486 / 332 / 232 tok/s.
- Old-content references (different base!): W1 OFF 20.95/17.43/11.29 (Aug 23).

## 8. Safety/readiness gates

Live checks performed this phase (all read-only):

```text
GPU visible            : YES  (RX 7800 XT gfx1101, rocminfo/rocm-smi OK)
GPU idle               : NO   (VRAM 14.98/17.16 GB used; GPU use 3%, idle clocks)
production server      : YES, RUNNING (PID 222841, exe=build/bin/llama-server,
                         health ok, uptime ~2h10m, cmdline == manifest)
llama-cli/bench procs  : NONE
ALLOW_MICRO_SMOKE      : NO (operator did not set YES)
ALLOW_FULL_BENCHMARK   : NO
ALLOW_PRODUCTION_SERVER: NO (nothing started/stopped this phase)
VRAM free headroom     : ~2.2 GB -> insufficient for a second instance;
                         concurrent measurement FORBIDDEN
```

Consequence: any execution requires an APPROVED WINDOW:
1. Human approves start time.
2. Stop production using documented procedure (see blocker below).
3. Run matrix.
4. Restore production via /tmp/opencode/launch_prod.sh.
5. Verify: health ok + exe readlink == build/bin + smoke heads byte-identical
   to results2/correctness/baseline_ON_prod_v3.json.

STOP conditions during execution: OOM; vram_peak > 15.5 GB; unknown binary path;
health fail after restore; swap_used growth (win128 showed ~4.7 GB swap used -
watch MemAvailable); any unexpected process on port 8080.

## 9. Correctness suite readiness

Scripts audited: results2/correctness_suite.py, results2/p3_quality_suite.py,
(results2/p3_degen_probe.py imported by quality suite).

How they work:
- correctness_suite.full_gate(): needs LIVE server on localhost:8080
  (/completion, /tokenize). Determinism self-check (greedy x2, cached second),
  SMOKE semantic set (math/math2/puzzle/factual/code/code2), 16k needle
  (SILVER-COMPASS-93 at 50% depth), stores gen_1k/gen_16k records. Output:
  results2/correctness/<tag>.json.
- p3_quality_suite.run_suite(): 12 deterministic tests (factual_en, arith_simple,
  arith_multistep [known "40" quirk], puzzle, code_func, code_oneliner, turkish,
  list_struct loop detector, needle16k_single, needle_multi, longgen_story,
  degen_trap_p1k) + 9 sampled sanity gens. Output: JSON with pass counts.

Expectations: binary = whatever llama-server serves :8080 (harness-agnostic);
model = whatever -m was passed (they hardcode no path). Endpoints: POST
/completion, /tokenize; GET /metrics unused by suites themselves.

Dependencies: python3 stdlib ONLY (json/os/sys/time/re/random/urllib/threading).
No pip installs needed. Python environment: works with system python3 (verified
by reading imports only; these scripts ran successfully in prior phases on this host).

Should they run THIS phase? NO. They require a loaded model (GPU inference).
Readiness verdict:

```text
CORRECTNESS_SUITE_READY = YES  (code-level, zero missing deps)
MISSING_DEPS            = none (stdlib only)
REQUIRED_ENV            = running llama-server on localhost:8080
EXECUTION_DEFERRED      = to Phase-1B (inside approved window, after perf matrix)
REFERENCE_BASELINE      = results2/correctness/baseline_ON_prod_v3.json (prod ON)
                          + results2/p3/suite_*.json (clean OFF/ON)
```

TG/PP split inside suites: suites produce tok_s incidentally; TG/PP numbers come
from the perf harness, not the suites. Suites are correctness-only gates.

## 10. Open questions for human/operator

See open_questions.md (same directory). Summary:
1. Approve measurement window date/time (stop-prod period).
2. pidfile convention decision: adopt pidfile in launcher (recommended patch to
   restore_server.sh copy stored in repo) or formally accept pgrep-based stops?
3. Confirm build-p3/bin/llama-server as the sanctioned baseline binary for tulpar/main.
4. Is build/bin (production) content commit identifiable? (needed for prod-vs-base
   comparisons; currently only "Aug 20, older than tulpar/main").
5. Preserve launcher in repo? /tmp is volatile.
6. llama-bench cross-check: approve building llama-bench from tulpar/main into a
   NEW build dir (e.g., build-p3bench) in a later phase, or drop the cross-check?
7. 128k arm: confirm acceptance of ~4.7 GB observed swap usage during 128k windows
   (system stayed healthy in prior runs) or restrict 128k to greedy-fresh only?

## 11. Recommended next phase

Order proposed:
1. Phase-0.5 (small, ops-only): document + harden production ops.
   - Copy launcher into repo (results2/ops/launch_prod.sh), add pidfile write
     + health-wait, define THE kill procedure (pidfile-first, pgrep fallback with
     explicit human note), record production binary provenance.
   - No kernel/source changes; low risk; unblocks safe windows forever.
2. Phase-1B (execution): run the runbook in experiments/phase1a/baseline_runbook.md
   inside ONE approved window: env manifest -> OFF matrix -> ON matrix ->
   graph-OFF arms -> correctness suites -> restore -> post-validation report.
3. Defer: llama-bench cross-check build; traced re-runs (only after any code change lands).

Rationale: pidfile gap is the only safety-critical unknown left; everything else
(MTP, graph toggle, binary choice) is resolved at code level in this phase.

## 12. Artifacts

Created (untracked, no commits made):

```text
experiments/phase1a/phase1a_report.md    (this file)
experiments/phase1a/baseline_runbook.md  (Phase-1B execution runbook)
experiments/phase1a/safe_commands.sh     (gated helper: read-only checks; exec arms commented out)
experiments/phase1a/open_questions.md    (operator decisions needed)
```

No source files modified. No builds. No servers started/stopped. No processes killed.
