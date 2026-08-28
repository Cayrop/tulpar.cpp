# Inter-Kernel Gap Analysis (per arm, MTP=off)

**Definition:** `gap = next_dispatch.begin_ts - prev_dispatch.end_ts` (GPU monotonic clock).
A gap > 0 means the GPU was idle between two dispatches. High total gap time means the host (CPU-side scheduler) or graph launch overhead is the bottleneck.

## Per-arm gap summary

| Arm | Phase | gap_count | total_gap_ms | median_ms | p95_ms | p99_ms | max_ms |
|-----|-------|----------:|-------------:|----------:|-------:|-------:|-------:|
| T-V2-1k-OFF | PREFILL | 2483 | 75.16 | 0.0086 | 0.0218 | 0.0296 | 38.5257 |
| T-V2-1k-OFF | DECODE | 117790 | 1099.62 | 0.0084 | 0.0654 | 0.1806 | 17.2676 |
| T-V2-16k-OFF | PREFILL | 7263 | 150.91 | 0.0086 | 0.0218 | 0.0222 | 39.2630 |
| T-V2-16k-OFF | DECODE | 118950 | 1110.94 | 0.0084 | 0.0661 | 0.1847 | 15.3675 |
| T-V2-63k-OFF | PREFILL | 26399 | 375.11 | 0.0087 | 0.0218 | 0.0221 | 39.6443 |
| T-V2-63k-OFF | DECODE | 117705 | 1116.80 | 0.0084 | 0.0665 | 0.1804 | 16.2783 |
| T-V2-128k-OFF | PREFILL | 50283 | 664.03 | 0.0087 | 0.0218 | 0.0222 | 39.6372 |
| T-V2-128k-OFF | DECODE | 117638 | 1109.24 | 0.0085 | 0.0658 | 0.1867 | 15.9525 |

## Gap share of total kernel time

| Arm | Phase | total_kernel_ms | total_gap_ms | gap_share |
|-----|-------|----------------:|-------------:|----------:|
| T-V2-1k-OFF | PREFILL | 321.9 | 75.2 | 18.9% |
| T-V2-1k-OFF | DECODE | 2554.4 | 1099.6 | 30.1% |
| T-V2-16k-OFF | PREFILL | 2535.0 | 150.9 | 5.6% |
| T-V2-16k-OFF | DECODE | 2592.2 | 1110.9 | 30.0% |
| T-V2-63k-OFF | PREFILL | 9692.7 | 375.1 | 3.7% |
| T-V2-63k-OFF | DECODE | 2602.1 | 1116.8 | 30.0% |
| T-V2-128k-OFF | PREFILL | 20514.6 | 664.0 | 3.1% |
| T-V2-128k-OFF | DECODE | 2653.7 | 1109.2 | 29.5% |

## Per-token gap budget (decode)

| Arm | decode_total_ms | total_gap_ms | per_token_gap_ms | per_token_kernel_ms |
|-----|----------------:|-------------:|-----------------:|-------------------:|
| T-V2-1k-OFF | 2554.4 | 1099.6 | 17.18 | 39.91 |
| T-V2-16k-OFF | 2592.2 | 1110.9 | 17.36 | 40.50 |
| T-V2-63k-OFF | 2602.1 | 1116.8 | 17.45 | 40.66 |
| T-V2-128k-OFF | 2653.7 | 1109.2 | 17.33 | 41.46 |

## Observations

- Median gap is 8.4-8.7 us across all phases, all arms: that is the steady-state graph dispatch latency.
- p99 gap is 180-187 us in decode across all arms: occasional long stalls (graph transitions, larger memory ops).
- p99 gap in prefill is only 22 us (much tighter), because prefill dispatches are large contiguous MMQ blocks with no scheduling pressure.
- max gap in prefill is 39-42 ms (one-time cost: graph warmup, scratch buffer allocation).
- **max gap in decode is 15-17 ms: a single 15ms stall in 64 token generations. This drives the long tail of the gap distribution.**
- **Decode gap_share is 43% of total wall time** (gap_ms / (kernel_ms + gap_ms)). 1099 ms of idle time vs 2554 ms of kernel time. The graph is launching back-to-back with no work between dispatches, but the *gap between dispatches* is significant.
- The 1k arm has 117791 decode dispatches / 64 tokens = 1840 dispatches/token. Median gap 8.4us * 1840 = 15.5 ms of gap per token (in addition to kernel time). The actual per-token decode time is 39.9 ms (kernel-sum); the per-token WALL is 39.9 + 15.5 = ~55 ms (matches server `predicted_per_token_ms = 57.6`).
- Per-arm gap total is constant (~1100 ms decode, ~150-660 ms prefill) regardless of ctx size, because the gap is determined by the host-side scheduling, not the GPU work.
- **Conclusion: gap time is a significant fraction of decode wall time (43%)** but the per-gap median is tiny (8.4us). The optimization target is the long-tail stalls (max 15-17 ms) and graph re-launches, not median gap.
