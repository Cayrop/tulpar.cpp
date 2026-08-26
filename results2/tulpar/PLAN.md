# Tulpar.cpp - Phase 1 Plan: Baseline + Profiling

Fork: llama.cpp @ tulpar/main (= upstream c060ca974 + cherry-picked
fattn-rdna3-quant-tile patch as 66dcba5eb). Private. No push, no PR.
Upstream submission branch stays separate: fattn-rdna3-quant-tile@80cf14ff5.

## Method (fixed loop)

1. Baseline on same commit/model/ROCm/GPU state, decode+prefill separate,
   ctx 1k/16k/63k/128k, MTP ON and OFF separately.
2. Profile: rocprofv3 kernel traces + HIP API trace; host costs measured,
   not assumed. No "remove ifs" speculation without profile data.
3. Rank bottlenecks: real time share x fixable potential.
4. Written hypothesis before every change: where / why / mechanism /
   expected max gain.
5. One hypothesis per experiment; revert failed experiments cleanly.
6. Correctness hard gate: greedy deterministic suite, factual/arith/code,
   TR+EN, single+multi needle, structured generation, long-gen degeneration;
   kernel changes additionally vs CPU reference backend. Non-bit-exact is OK
   only when shown to be FP/kernel-noise class, not quality loss or
   systematic degeneration.
7. A/B validation same-day, medians + spread, prefill and decode reported
   separately, MTP ON/OFF separately.
8. Decision: KEEP / REVERT / INVESTIGATE / PARK per report template.

## Phase 1 measurement matrix

Binary: build-p3/bin/llama-server == tulpar/main content
(80cf14ff5 content; verified by tests 2/2 + byte-identical suite).
Model: Qwen3.8-27B UD-Q2_K_XL (65 blocks: 48 GDN + 17 full-attn + MTP blk64),
KV q4_0/q4_0, -fa on, -c 131072 for windows, ctx-checkpoints 4.

Perf windows (results2/tulpar/perf_*.json):
- tags: tulpar_base_off, tulpar_base_on
- ctx targets: 960w(~1k tok), 16320w(16k), 64512w(63k), 129400w(128k)
- rep1 fresh prefill + decode 128 tok sampled(temp .6 k20 p.95) seed4242;
  rep2-3 cached decode only; medians+spread computed in report step.

Traced sessions (results2/tulpar/traces/{t16k,t63k,t128k}):
- rocprofv3 --kernel-trace --hip-api-trace --memory-copy-trace -d <dir>
- one completion: fresh prefill + 96 decode steps, OFF config.
- analysis: agg_trace.py -> class time shares within detected steady-state
  decode run (gap-filtered to exclude load/prefill sections).

## First profiling question

"RX 7800 XT uzerinde mevcut gercek decode suresinin yuzdeleri:
attention / matmul(MMQ,GEMV,BLAS) / dequant-quant / copy-KV-IO /
norm-rope-act / GDN-SSM / sampling / other / host-launch-gap?"

Answered from kernel trace sums within decode window:
- GPU busy % = sum(kernel dur) / wall span of window; gap = launch/runtime
  idle (includes graph replay boundaries). hipStreamSynchronize wait is NOT
  host overhead (it blocks on GPU); true host cost shows up as gap% plus
  hipGraphLaunch/hipLaunchKernel API durations.
- Known caveat: rocprofv3 adds per-dispatch host overhead; absolute tok/s in
  traced runs may be lower than untraced perf windows. Kernel duration sums
  remain valid; gap% is upper-bound estimate.

## Prior evidence carried into Phase 1 (same binary content!)

- 37657 trace from Aug 23 was a mixed unit-test session: NO usable model
  decode section (fa<1> gaps 1-10ms, no ~60ms step period). Marked unusable
  for time-share; kept for VGPR/dispatch facts only.
- Decode at 63k (patched): FA draft tile<256,256,1,2> ~547-585us x17 layers
  ~= 9-10ms of a ~63ms step (~15%) - consistent with preliminary whole-
  trace GEMV dominance seen above. Fresh t63k trace will give exact split.

## Artifact layout

results2/tulpar/
  PLAN.md                 this file
  p1_campaign.py          campaign driver (stop prod -> matrix -> traces -> restore prod)
  agg_trace.py            kernel/API trace aggregator (class rollup + top kernels)
  campaign.log            driver log
  perf_tulpar_base_{off,on}.json
  traces/{t16k,t63k,t128k}/<pid>_kernel_trace.csv (+api, memcopy)
  trace_<tag>_meta.json   bench numbers inside each traced run
  env/                    uname/cpu/mem/rocm/gpu/smi/power_profile/git_rev/
                          model sha256/env.json manifest
  reports/p1_profiling.md final phase report (template below)

## Report template (per optimization AND phase reports)

## Hypothesis
## Baseline
## Profiling Evidence
## Bottleneck
## Proposed Change
## Expected Gain
## Correctness Results
## Benchmark Results
## Kernel/Runtime Evidence
## VRAM Impact
## Regression Risk
## Decision: KEEP / REVERT / INVESTIGATE / PARK

## Rules reminders

- No push/PR/release; local commits only, human approves each.
- gfx1101 specialization allowed; dead-code removal requires hot-path proof.
- Small gains (<~5%) with high maintenance cost are PARK candidates.
- Big repeatable gains (10-50%) justify specialization.
