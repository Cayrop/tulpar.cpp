# Stall Budget (Decode Phase)

Computed from `results_trace_D.csv` split at `last_mmq` (MMQ boundary). Gaps = `next.begin_ts - prev.end_ts` / 1e6.

## Per-Arm Decode Gap Stats (from analysis.json / computed)

| Arm | Decode Rows | Total Gap ms | Median Gap ms | Avg Gap ms | Max Gap ms | Gaps >1 ms | Sum >1 ms ms | % of Total Gap |
|-----|------------:|-------------:|--------------:|-----------:|-----------:|-----------:|-------------:|----------------:|
| 1k | 117,791 | 1099.62 | 0.0084 | 0.00934 | 17.27 | 6 | 35.60 | 3.2% |
| 16k | 118,951 | 1110.94 | 0.0084 | 0.00934 | 15.37 | 6 | 35.12 | 3.2% |
| 63k | 117,706 | 1116.80 | 0.0084 | 0.00949 | 16.28 | 5 | 47.12 | 4.2% |
| 128k | 117,639 | 1109.24 | 0.0085 | 0.00943 | 15.95 | 3 | 35.26 | 3.2% |

Note: The user's claim that stalls account for ~70% of total gap time does NOT match gaps >1 ms (only 3-4%). The ~70% figure aligns with gaps >0.09 ms (~810 ms, 73% of total gap). The >1 ms stalls are the extreme tail (max 15-17 ms) and represent the systematic front-loaded stalls (token 0/2) plus scattered stochastic stalls.

## Per-Token Gap Budget

Assuming `n_predict = 64` (from `response.json`):

| Arm | Total Gap ms / Token | Kernel ms / Token | Wall ms / Token (kernel+gap) | Gap Share of Wall Time |
|-----|---------------------:|------------------:|-----------------------------:|-----------------------:|
| 1k | 17.18 | 39.91 | 57.09 | 30.1% |
| 16k | 17.36 | 40.50 | 57.86 | 30.0% |
| 63k | 17.45 | 40.66 | 58.11 | 30.0% |
| 128k | 17.33 | 41.46 | 58.79 | 29.5% |

The gap per token is almost constant (~17.3 ms) regardless of context size. This confirms the stalls are NOT proportional to dispatch count or context size.

## Stall Category Distribution (Approximate, >1 ms only)

Based on gap patterns and kernel pairs:

| Arm | Allocation / Pool (est.) | Graph Boundary | Synchronization | Scheduling | Unknown |
|-----|--------------------------:|---------------:|----------------:|-----------:|--------:|
| 1k | 17.27 + 12.65 + 2.13 = 32.05 (90%) | 0 | 0 | 3.55 (10%) | 0 |
| 16k | 15.37 + 13.53 + 2.92 = 31.82 (91%) | 0 | 0 | 3.30 (9%) | 0 |
| 63k | 16.28 + 16.05 + 9.98 + 2.83 = 45.14 (96%) | 0 | 0 | 1.98 (4%) | 0 |
| 128k | 15.95 + 15.76 + 3.54 = 35.25 (100%) | 0 | 0 | 0 (0%) | 0 |

Allocation / Pool estimated for stalls involving `rms_norm` / `GEMV` -> `copyBuffer` (systematic stalls at token 0/1/2) and the 9.98 ms stall at token 38 (63k, likely pool growth). Scheduling estimated for scattered small stalls (<2 ms) with random positions.
UNCERTAIN: The exact split between allocation and synchronization for the 9.98 ms stall in 63k requires HIP-level memory trace (not available).

## Key Observation

- The systematic stalls (token 0/2, 15-17 ms) account for ~2.7% of total gap time per arm (29.9-32.3 ms / 64 tokens = 0.47 ms/token). This is a small fraction of the 17.3 ms/token total gap budget.
- The remaining ~16.8 ms/token gap budget is distributed across ~1840 dispatches/token (median 8.4 µs). This is the baseline scheduling overhead.
- The user's focus on the 17.3 ms/token gap is justified (it is 30% of wall time), but the root cause of the extreme tail stalls (>1 ms) is different from the root cause of the baseline 8.4 µs dispatch overhead.
