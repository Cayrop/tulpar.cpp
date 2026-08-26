# Phase-2B Profiling Design (DESIGN ONLY - NOT EXECUTED)

Date: 2026-08-24
Status: awaiting human approval answers in experiments/phase2a/open_questions.md.
Primary objective: MTP OFF ms/token attribution at 16k / 63k / 128k on
build-p3/bin/llama-server, answering H-2A-GEMV, H-2A-QUANT, H-2A-ATTN-STAGING,
H-2A-KV-READ, H-2A-PP from the hypothesis matrix.

## 1. Profiling arms

Primary (all MTP OFF, no speculative flags):

| Arm | Context | pred_n | Passes | Purpose |
|-----|---------|--------|--------|---------|
| P1-off-16k | 16384 | 128 | 3 untraced + 1 traced | GEMV/quant/staging shares at mid ctx |
| P2-off-63k | 64512 | 380 | 3 untraced + 1 traced | long-ctx scaling, staging curve |
| P3-off-128k | 131072 | 96 | 1 untraced + 1 traced (GATED) | 128k attribution; single-pass rule |

Optional comparison (run only if approved and time allows):

| Arm | Context | Mode | Purpose |
|-----|---------|------|---------|
| O1-off-1k | 1024 | off | cheap short-ctx reference point |
| O2-on-16k | 16384 | on (prod spec flags) | verify-batch kernel-path check for H-2A-MTP-SECONDARY |

No MTP parameter sweeps. No draft-n-max experiments. No speculative tuning.

## 2. Binary and config

- Binary: <REPO_ROOT>/build-p3/bin/llama-server (sha256 recorded
  before start; must match Phase-1B fingerprint 280556cc...).
- Server flags: identical to Phase-1B arms: -c 131072 -ngl 999 --load-mode
  mmap -fa on -ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8
  -np 1 --metrics. NO speculative flags on primary arms.
- Sampling: greedy (temperature 0, top_k 1), seed 1234, ignore_eos, same
  prompt family as Phase-1B (make_text seeds 4201024/555001/777001/888111
  + summarize suffix) so numbers stay comparable.

## 3. Production safety

- Requires separate explicit human approval of the profiling window BEFORE
  any stop (open question Q1/Q2). This design does not authorize anything.
- Stop/start only through the validated pidfile procedure:
  ops/run/<profile>.pid lifecycle; production pidfile
  ops/run/llama-server.pid; kill only by pidfile PID; pgrep only for
  verification; health check after every start and after final restore.
- Restore target: build-p3/bin/llama-server with prod_flags.env verbatim
  (binary path now corrected there). Fallback to build/bin only if build-p3
  fails health, per Phase-1B restore discipline.
- VRAM guards: abort any arm if rocm-smi shows VRAM > 15.6 GiB; MTP ON
  optional arm inherits the 15.5 GiB boundary rule.
- 128k arm: single pass per mode, gated on prior arms' success, exactly like
  Phase-1B A7/A8 handling.

## 4. Traced/untraced separation

- Untraced runs give all headline tok/s numbers (comparable to Phase-1B).
- Traced runs give kernel attribution ONLY; their tok/s is reported but
  never compared against untraced numbers or Phase-1B medians.
- Trace overhead estimation: run P1-off-16k as 3 untraced reps then 1
  traced rep under identical prompts; overhead % = 1 - tg_traced/tg_untraced;
  report it next to every traced-derived share. If overhead > 25%, halve
  trace verbosity (fewer counters) and retry once; if still > 25%, mark
  BLOCKER and stop traced work.
- Never mix traced medians into untraced tables.

## 5. Tooling (available binaries verified present)

- rocprofv3 (/opt/rocm/bin/rocprofv3): primary kernel tracer.
  Pre-check: run a trivial `rocprofv3 --version` and a 1-second hip app or
  server warmup capture in a scratch dir under /tmp/opencode. If it fails
  from permissions (e.g. perf counters need CAP_SYS_ADMIN / amdgpu
  inst_counter settings), record BLOCKER-PERMISSIONS and ask the operator
  (open question Q4). Do not attempt sudo without approval.
- roctracer: fallback if rocprofv3 unusable; needs LD_PRELOAD harness -
  higher integration cost, use only if rocprofv3 blocked.
- HIP events: not available without code changes; NOT used (no source mods).
- Server logs: "graphs reused"/"warmup reset" counters per arm (grep),
  prompt/predicted timings lines.
- /metrics: spec_decode_* counters (comparison arm only), slot timers,
  KV usage.
- rocm-smi 0.5 s sampling for VRAM/power; free -b for RAM/swap deltas
  before/after each arm.

## 6. Metrics to collect

Per arm:
- kernel name, total duration, call count (traced arms)
- step wall time distribution (untraced: predicted_ms/n; traced: reported
  separately)
- host gap estimate = step wall - sum(kernel busy time) per traced step
- prompt_n, prompt_ms, predicted_n, predicted_ms (server response JSON)
- VRAM peak (rocm-smi samples), RAM/swap delta (free -b)
- graph evidence: reused/reset counts from server log
- MTP counters only for O2 comparison arm (drafts, accepted, per-pos)

## 7. Kernel category mapping

Map traced kernel names (mangled names demangled via c++filt or rocprof's
Name column) to categories:

| Category | Name patterns |
|----------|---------------|
| IQ3_XXS GEMV | mul_mat_vec_iq3_xxs* |
| other quantized GEMV | mul_mat_vec_(iq3_s|iq4_xs|q3_k|q2_k)* |
| quantize_q8_1 | quantize_row_q8_1*, quantize_mmq_q8_1*, quantize_scatter* |
| dequant/staging | *_to_fp16*, dequantize_block_q*, ggml_get_to_fp16 targets |
| attention FA tile | flash_attn_tile<256,256,*> |
| attention vec | flash_attn_ext_vec* (expect ZERO on this build; presence = dispatch surprise) |
| KV store/copy | cpy_q_f32*, cpy_f32_q*, cpy_f32_f32* |
| norm/rope/act | rms_norm*, rope*, silu*, mul/add/glue elementwise |
| GEMM/PP kernels | mmq kernels (kernel_mmq*), gated_delta_net_cuda*, ssm_conv*, flash_attn_mask_to_KV_max* during prefill phase |
| sampling/other | everything else |

Phase tagging: prefill-phase vs decode-phase attribution comes from
separate requests: fresh prefill request (cache_prompt=false) vs cached
decode-only continuation (cache_prompt=true), mirroring Phase-1B rep
structure; traces are split on that boundary by timestamp.

## 8. Derived metrics

- effective GEMV GB/s per type = weight bytes / summed GEMV kernel time
  (weights bytes fixed: ~10.25 GB total; per-type table in
  evidence_ledger sec 2.10)
- ms/token per kernel category (decode arms)
- attention ms/token split: staging vs tile-kernel vs KV-store
- quantize_q8_1 ms/token and launch count/token
- host-gap ms/token
- PP breakdown by category at 16k vs 128k (prompt-phase traces)
- scaling curves: category ms/token vs context length; classify 16k/63k/
  128k as GEMV-bound / staging-bound / gap-bound / mixed using >40%
  share threshold

## 9. Runbook structure

1. Pre-checks: git HEAD == 66dcba5eb clean; binary sha256; model sha256
   spot check; ops manifests present; disk >= 10 GB free; MemAvailable
   >= 20 GiB; record baseline swap.
2. Production stop approval: EXPLICIT human go (Q1+Q2 answered yes); stop
   production strictly via its pidfile; verify GPU idle (no KFD processes,
   SCLK low); record VRAM/RAM state.
3. Pidfile validation: create ops/run/prof-p2b.pid for every started
   process; identity check via /proc/<pid>/exe after start.
4. GPU idle validation: zero compute processes besides desktop (< ~700 MB);
   clocks settled.
5. Baseline server start: launch build-p3 server per sec 2 config; wait
   /health ok; load model; record load time + VRAM after load.
6. Warmup: one 1k generation discarded.
7. Untraced performance check: per arm, Phase-1B rep structure (rep1 fresh,
   rest cached), 3 reps for 16k/63k; verify medians within noise of
   Phase-1B (sanity gate: 16k OFF median within +/-5% of 20.45; if not,
   STOP and investigate environment before tracing).
8. Traced attribution run: restart-free if possible - prefer attaching
   profiler around dedicated traced reps on a freshly restarted profiled
   instance (separate pidfile prof-p2b-traced.pid); collect CSV/JSON trace
   into experiments/phase2b/traces/.
9. Artifact collection: response JSONs, trace files, rocm-smi series,
   logs, metrics snapshots, env snapshot; all under experiments/phase2b/
   raw/<arm>/.
10. Profiled server stop via its pidfile; verify GPU released.
11. Optional arms (O1/O2) only if approved.
12. Production restore: relaunch build-p3 via standard procedure; health
    check; greedy semantic spot-check vs results2/correctness/
    baseline_ON_prod_v3.json heads (expect 6/6 match).
13. Post-run report skeleton written to experiments/phase2b/results.md.

## 10. Abort rules

Abort the current arm (and skip downstream gating arms) if any of:

- GPU busy at start (non-desktop KFD processes or SCLK high without our
  process)
- pidfile mismatch at any stop/restart step (expected PID != actual exe)
- OOM or VRAM guard breach (> 15.6 GiB sampled)
- swap growth > 512 MiB within an arm or MemAvailable < 8 GiB
- server crash, hang > 120 s on a request, or health check failure
- trace overhead > 25% after one retry (mark BLOCKER, finish untraced only)
- missing profiler permissions (BLOCKER-PERMISSIONS -> ask operator)

Any abort: restore production first, then document the abort in
experiments/phase2b/abort_log.md.

## Deliverables when executed

experiments/phase2b/: results.md, raw/<arm>/..., traces/, derived metric
tables filling the "Phase-2B measurement needed" fields of
hypothesis_matrix.md, and a verdict per hypothesis
(CONFIRMED / REFUTED / INCONCLUSIVE).
