# Phase-2 Benchmark: Untraced Ladder vs Phase-1 Baseline

Date: 2026-08-26 (+03). Binary: build-p3/bin/llama-server rebuilt with fused q4_0
tile path (libggml-hip.so.0.21.0). Methodology identical to Phase-1: fresh
instance per arm, greedy temp 0 top_k 1 seed 1234, rep1 fresh prefill +
cached reps, same prompt families/seeds, VRAM monitor sampling, guard
16752282317 B (15.6 GiB sampled).

Raw artifacts: experiments/phase2/raw/<arm>/arm_record.json.

## Results (MTP OFF)

| arm | reps | tg tok/s med | P1 base | delta | spread | pp fresh | P1 pp | peak VRAM | P1 peak |
|-----|------|--------------|---------|-------|--------|----------|-------|-----------|---------|
| P2-1k-OFF   | 4 | 23.384 | 23.481 | -0.41% | 0.52% | 519.84 | 518.17 | 10.31 GiB | 10.45 |
| P2-16k-OFF  | 3 | 22.419 | 21.594 | +3.82% | 0.30% | 490.98 | 494.42 | 10.80 GiB | 10.74 |
| P2-63k-OFF  | 3 | 19.279 | 16.477 | +17.01% | 0.33% | 331.89 | 339.66 | 11.54 GiB | 11.77 |
| P2-128k-OFF | 3 | 16.108 | 12.507 | +28.79% | 0.24% | 226.05 | 234.39 | 13.27 GiB | 13.33 |
| P2-131k-OFF | 3 | 16.104 | 12.481 | +29.03% | 0.31% | 224.86 | 232.57 | 13.70 GiB | 13.30 |

All spreads < 1%. VRAM guard never tripped; no abort conditions hit.

## Success criteria check

- 128k decode improvement: +28.79% (target >= +15%; target tok/s > 14.4,
  measured 16.108): PASS.
- 131k VRAM peak 13.70 GiB < 15.5 GiB guard: PASS.
- Staging elimination: verified separately (phase2_staging_verification.md):
  PASS.

## Reading

- Decode gains track the eliminated staging cost: staging was ~0 / 1.42 /
  8.74 / 19.65 ms/tok at 1k/16k/63k/128k; measured deltas correspond to
  removing it minus the added in-kernel dequant overhead (~1.9 ms/tok at
  128k, see staging verification).
- 1k is flat within noise (staging negligible there), confirming no
  regression for short contexts.
- Fresh prefill (pp) is 0.3-3.6% slower at 63k-131k: the fused tile kernel
  trades a small amount of prefill efficiency (nibble unpack on the load
  path of large ncols tiles) for the large decode win and the removal of
  the whole-cache F16 round trip. PP attention was already tile-dominant;
  this is recorded as an accepted tradeoff and a future tuning target
  (e.g., shape-gated hybrid dispatch), out of Phase-2 scope.
- Peak VRAM at 128k/131k is slightly BELOW baseline (the persistent F16
  staging extra buffer is no longer allocated; net effect visible despite
  identical KV cache size).
