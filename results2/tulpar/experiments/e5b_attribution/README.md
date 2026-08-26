# E5B: 213 -> 259 GB/s attribution experiment

Status: IN PROGRESS. Levels A and B measured; C/D pending.
No source changes. Production binary untouched.

## Framework

Decompose the model-context 213 GB/s vs standalone 259 GB/s gap into:
actual kernel execution difference / launch-node transition overhead /
graph scheduling / cache-state effect / adjacent dependency / methodology
difference.

Attribution budget template (to fill after C/D):
- kernel execution: X ms/token
- node transition / launch: X ms/token
- cache/state/context: X ms/token
- other/unknown: X ms/token

recoverable dispatch cost: UNKNOWN until C/D complete. The old
~4.6 ms/token figure remains an upper-bound hypothesis only.

## Measured so far

### Level A - standalone raw kernel duration [DONE, e1b_gemv]
v0 baseline: 259.3 / 259.9 GB/s (shape0/shape1), 131 us/call.

### Level B - same kernel inside HIP graph replay [DONE]
Harness mode `graph` (e1b_bench.hip), rotation captured as a 24-node
graph, replayed:

| test | stream | graph | delta |
|------|--------|-------|-------|
| v0 real kernel us/call (shape0) | 131.15 | 131.11 | none |
| v0 real kernel eff_gbps         | 260.1  | 260.2  | none |
| dependent tiny-kernel chain us/node | 2.96 | 2.61 | -0.35 (-12%) |

Conclusions:
- For a 131 us kernel, launch API cost is fully hidden either way.
- On this ROCm stack, graph replay does NOT eliminate inter-node cost:
  dependent nodes still cost ~2.6 us each device-side. Graphs are not a
  magic fix for micro-bubbles; they shave at most ~12% off one class.

### Level B/C bridge - are ggml HIP graphs even active in production? [ANSWERED, nuanced]
Method: rocprofv3 --hip-runtime-trace around a short wrapped-server run
(prod args incl. MTP), plus static reading of ggml-cuda.cu.

API counts in the last flushed 5 s window (end of generation):
hipLaunchKernel=10766, hipGraphLaunch=46, BeginCapture/EndCapture/
Instantiate=2 each. Mixed signal.

Static explanation found (source read, tulpar/main):
- ggml_cuda_graph_check_compability() disables CUDA graphs for an entire
  ggml cgraph if ANY node is GGML_OP_MUL_MAT_ID that needs a stream sync
  (ggml_cuda.cu:2548-2578, TAG_MUL_MAT_ID_CUDA_GRAPHS).
- ggml_cuda_mul_mat_id_needs_sync() returns false (sync-free, graph-safe)
  only while batch <= get_mmvq_mmid_max_batch(type, cc)
  (ggml-cuda.cu:1874-1890).
- On RDNA3, get_mmvq_mmid_max_batch_rdna3(): IQ3_XXS -> 4, most other
  quant types -> 4..6 (mmvq.cu:211-227).

Therefore:
- Non-MTP decode (batch=1): expert MUL_MAT_ID nodes are graph-safe ->
  HIP graphs ACTIVE. Observed ~3.4 us gaps in the t16k census are then
  mostly DEVICE-SIDE per-node cost inside replayed graphs (matches the
  measured 2.61 us/node chain number).
- Production decode WITH MTP (--spec-draft-n-max 4): verify evals run at
  batch up to 5 > 4 -> graphs DISABLED for those whole steps -> every
  kernel launched individually through hipLaunchKernel -> full host-side
  gap cost per boundary.

NEW ATTRIBUTION HYPOTHESIS (to verify by experiment before claiming):
an MTP-vs-graphs interaction exists. Enabling MTP with draft-n-max=4
pushes verify batch past the RDNA3 MMVQ-MMID graph-safety limit, silently
disabling HIP graphs during verify and adding thousands of launch-path
micro-bubbles per second of generation.

Config-only candidate experiment (NO source change, SAFE):
A/B decode with --spec-draft-n-max 3 (verify batch <= 4 -> graphs stay
captured) versus 4 (current). Predicts fewer bubbles per accepted token
with 3; net tok/s sign unknown (fewer draft tokens vs cheaper verify).
Gate: measure first, decide by median>=5 A/B.

## Incident log (2026-08-24)

While collecting the wrapped-server API trace, the agent killed PID 1455
believing it was the rocprofv3 wrapper (inferred via ppid of a detached,
reparented server process). PID 1455 was actually a session-critical
process of the user's Plasma login; the session logged out.

Root cause: killing a process by inferred parentage instead of an
explicitly recorded PID; launching long-lived wrapped servers detached
from a shell that later timed out.

Safety protocol going forward (binding):
1. Every background process gets its PID written to a pidfile at launch;
   kills target ONLY that file's PID.
2. No profiler-wrapped server restarts without explicit user approval.
3. Prod stop/start cycles use the existing launch script only, with
   health verification after.

## Remaining work

C. Adjacent-node transition intervals in real ggml context: derive from a
   fully flushed trace (graceful shutdown required) OR infer from census +
   level-B numbers already collected.
D. Full-model effective duration: reuse existing traces; separate MTP ON
   and OFF datasets explicitly (the interaction above makes them differ).
Then fill the attribution budget and only afterwards state recoverable
dispatch cost.

Decision: INVESTIGATE (levels C/D pending; no GO/PARK yet).
