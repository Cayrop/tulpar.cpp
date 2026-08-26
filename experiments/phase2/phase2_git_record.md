# Phase-2 Git Record

Date: 2026-08-26 (+03). Created during the PHASE-2 window per task section 1.

## Fork

- Fork URL: https://github.com/Cayrop/tulpar.cpp
- Created with: `gh repo fork --remote --remote-name fork`
- Repository renamed from `Cayrop/llama.cpp` to `Cayrop/tulpar.cpp`
- Upstream parent: ggml-org/llama.cpp

## Branch

- Name: `phase-2-staging-elimination`
- Created from local `tulpar/main` @ `66dcba5eb7dd92cd460cfc040c7cae42f1254e20`
  ("cuda : use tile flash attention for quantized KV decode on RDNA3 with head size 256",
  the Phase-0/1 production source state).
- Tracking: `fork/phase-2-staging-elimination`

## Commits

| hash | message | note |
|------|---------|------|
| 091aec112 | chore: Phase-1 full profiling trace baseline (V3 Q2_K_XL) | Baseline state commit (Step 1.3); includes experiment, report, and tooling state. |
| (implementation commit appended here after Step 5.5) | | |

## Remote configuration

```
fork      https://github.com/Cayrop/tulpar.cpp.git    (fetch/push)  <- user fork
upstream  https://github.com/ggml-org/llama.cpp.git   (fetch/push)  <- upstream repository
```

## Deviations from task text

1. Remote naming: `gh repo fork --remote --remote-name fork` created the fork as the
   `fork` remote and left `origin` pointing to the upstream repository. `origin` was
   then renamed to `upstream`. Final state: `fork` is the push target and `upstream`
   points to ggml-org/llama.cpp.
2. Payload exclusion: A literal `git add -A` would have included approximately 8 GB of
   ROCm profiler artifacts, including a largest file of 881 MB, exceeding GitHub's
   100 MB per-file limit. The following were therefore excluded:
   - `*_kernel_trace.csv`
   - `*_hip_api_trace.csv`
   - `*_results.db`
   - `.rocprofv3/`
   - `mlp_sweep*`
   - `agents.md.bak*`

   The committed payload is approximately 78 MB across 984 paths. The largest committed
   file is approximately 2.5 MB. Reports, JSON files, scripts, harness code, and small
   logs are included.
3. Commit metadata: No `Assisted-by` trailer or similar attribution trailer is used.
4. Pull requests: No pull request is created during this phase.

## Push verification

- Baseline branch successfully pushed to:
  `fork/phase-2-staging-elimination`
- Remote tracking is configured for the branch.
