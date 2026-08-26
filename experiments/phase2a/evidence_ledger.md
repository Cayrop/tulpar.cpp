# Phase-2A Evidence Ledger

Date: 2026-08-24
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Scope: consolidated evidence state after Phase-1B and the Phase-2A addendum,
plus new read-only facts established by this Phase-2A full run.
Rule: historical numbers are listed separately and are NOT treated as facts
for the current build until re-measured.

## 1. Measured Phase-1B baseline (current validated truth)

Binary: build-p3/bin/llama-server, flags: -c 131072 -ngl 999 --load-mode mmap
-fa on -ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1
--metrics. Greedy sampling, fixed prompts, fresh process per arm.

### 1a. TG MTP OFF (primary target)

| Context | tg tok/s median | spread | reps |
|---------|-----------------|--------|------|
| 1k      | 22.055          | 0.16%  | 4    |
| 16k     | 20.451          | 0.09%  | 3    |
| 63k     | 15.740          | 0.69%  | 3    |
| 128k    | 11.981          | single | 1    |

Gap to the 40 tok/s target: +81% (1k), +96% (16k), +154% (63k), +234% (128k).

### 1b. TG MTP ON (comparison context only)

| Context | tg tok/s median | acc_rate |
|---------|-----------------|----------|
| 1k      | 25.788          | 0.79     |
| 16k     | 30.626          | 0.85     |
| 63k     | 31.276          | 0.97     |
| 128k    | 20.977          | 0.95     |

### 1c. PP fresh prefill (MTP OFF)

| Context | pp tok/s |
|---------|----------|
| 1k      | 507.3    |
| 16k     | 484.8    |
| 63k     | 332.9    |
| 128k    | 230.7    |

### 1d. Acceptance rates

Greedy: 0.79 @1k, 0.85 @16k, 0.97 @63k, 0.95 @128k (Phase-1B report sec 6).

### 1e. VRAM peaks

13.41 GiB @1k OFF, 13.39 @16k OFF, 13.71 @63k OFF, 13.92 @128k OFF;
15.24 GiB MTP ON short/mid, 15.50 @128k ON (guard boundary, ~600 MiB free).

### 1f. Swap deltas

Historical "~4.7 GB swap at 128k" did NOT reproduce under q4_0 KV:
A7 swap delta +45 MiB, A8 +102 MiB, MemAvailable >= 22 GiB throughout
(Phase-1B report sec 5).

### 1g. Repeat stability

Spread < 1% on every multi-rep arm; medians stable. Graph diagnostic deltas
(-2.6% tg OFF, +3.3% tg ON at 16k) exceed spread and are likely real but minor.

## 2. Validated facts

1. q4_0 KV eliminated the historical massive-swap failure at 128k single-pass;
   both A7 and A8 completed with negligible swap (Phase-1B sec 5).
2. build-p3/bin/llama-server is production-safe: RESTORE_OK, health ok,
   6/6 semantic match against pre-window baseline, PID 397813 identity
   validated via pidfile+/proc (Phase-1B sec 8).
3. Correctness gate passed on the current binary: deterministic 12/12,
   sampled sanity 8/9 (known quirk), MTP smoke 4/4 (Phase-1B sec 3).
4. MTP ON acceptance is high (0.79-0.97 greedy) and rises with context.
5. Production restore succeeded and remains running (PID 397813 verified
   read-only during this phase).
6. CUDA/HIP graphs are active in production: restore log shows repeated
   "graphs reused" lines (3291 reuses).
7. GGML_CUDA_DISABLE_GRAPHS manifest entry corrected by the Phase-2A
   addendum (commented out with evidence trail; backup bak-addendum-
   20260824-160030).
8. Binary path corrected by this Phase-2A full run: production =
   <REPO_ROOT>/build-p3/bin/llama-server; fallback =
   build/bin/llama-server. Backup: prod_flags.env.bak-binarypath-
   20260824-163257. No production restart required or performed.
9. NEW (this phase, read-only GGUF header inspection): the model is a HYBRID
   architecture. Of 64 trunk layers, 48 are gated-delta-net linear-attention
   layers (fused attn_qkv + attn_gate + ssm_* tensors) and 16 are dense
   full-attention layers (every 4th layer, full_attention_interval=4 fallback
   in src/models/qwen35.cpp:21-27). blk.64 is the MTP/nextn block (dense-type
   attention). Consequences: full-attention KV exists for 17 blocks max
   (16 trunk + 1 draft ctx when MTP ON); per-token KV cost is 18,432 B
   (q4_0, K+V, 16 layers), so 128k KV ~= 2.36 GiB, consistent with the
   measured 13.39 GiB VRAM peak (weights ~10.7 GB + KV 2.36 GiB + overhead).
10. NEW: weight streams per decode step total = 10,237,562,880 B (9.530 GiB).
    Type totals from env/model_bytes_by_type.json: IQ3_XXS 8,092,385,280 B
    (7.537 GiB), IQ3_S 1,376,460,800 B (1.282 GiB), Q3_K 546,304,000 B
    (0.509 GiB), IQ4_XS 217,251,840 B (0.202 GiB), IQ1_M 5,160,960 B
    (0.005 GiB); token_embd Q2_K 417,177,600 B (0.389 GiB) is not part of the
    streamed total. Measured from tensor n_bytes via gguf-py.
    Corrected by Phase-2C from env/model_bytes_by_type.json. token_embd (Q2_K) is consumed by get_rows, never by GEMV, and is excluded from the streamed-weight total.
11. NEW: profiler binaries exist on host: /opt/rocm/bin/rocprof, rocprofv3,
    rocm-smi (presence only; permissions untested).

## 3. Weakened or rejected hypotheses

1. 128k massive-swap failure: WEAKENED to near-zero under q4_0 KV (fact 2.1);
   memory-bound risk is replaced by bandwidth/traffic questions.
2. "Graphs off causes 10-15% decode loss": NOT CONFIRMED at 16k. Measured
   -2.6% tg OFF / +3.3% tg ON when graphs disabled (Phase-1B sec 7). Graph
   overhead is minor at 16k; behavior beyond 16k unknown.
3. Old production-binary uncertainty (build/bin vs build-p3): RESOLVED for
   current work; manifest now records build-p3 as production, build/bin as
   fallback.
4. Legacy forced-VEC attention bottleneck: RESOLVED in the current fork.
   Commit 66dcba5eb routes quantized-KV decode at head size 256 to the TILE
   kernel; legacy +39.5% @63k gain is already merged into tulpar/main and is
   reflected in the Phase-1B baseline (15.74 vs legacy 11.29 @63k).

## 4. Still unknown (Phase-2B targets)

1. Kernel-level ms/token attribution for MTP OFF at 16k/63k/128k (no trace
   exists for the CURRENT build; legacy traces predate the merge).
2. Effective IQ3_XXS GEMV bandwidth in the current build (weights ~10.25 GB
   per step vs 624 GB/s nominal leaves a wide uncertainty band).
3. True cost share and launch count of quantize_row_q8_1 per decode step.
4. Attention/TILE-staging ms/token at 16k, 63k, 128k (incl. dequant-to-F16
   staging kernels vs flash_attn_tile itself).
5. PP kernel-level breakdown; why PP drops 485 -> 231 tok/s from 16k to 128k.
6. Whether long-context decode is GEMV-bound, staging/KV-read-bound, GDN-bound,
   or launch-gap-bound (no classification exists yet).
7. GDN (gated_delta_net + ssm_conv) ms/token across contexts (48 layers/step).
8. Graph behavior beyond 16k and under MTP verify-batch shapes.

## 5. Historical claims requiring revalidation (NOT facts for this build)

| Claim | Source era | Status |
|-------|-----------|--------|
| in-model IQ3_XXS GEMV ~213 GB/s | older base commit | revalidate |
| standalone IQ3_XXS ~259 GB/s | microbench, older build | revalidate |
| ~7.7 ms/step host bubble | pre-graph-fix era | revalidate |
| ~430 quantize_q8_1 launches/step | older model/graph | revalidate; this phase estimates ~500 matmul ops/step (sec 2.10 arithmetic), unverified |
| 128k staging ~20.4 ms/token | analytic, pre-hybrid understanding | recompute: KV applies to 16 layers only; see code_audit sec D/C |
| 128k attention ~17.1 ms/token | analytic, pre-hybrid understanding | recompute likewise |

These must be re-derived or re-measured on build-p3 before any decision uses
them. None of them is load-bearing for the Phase-2B design, which measures
them directly.
