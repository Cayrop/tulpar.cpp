# PHASE 2 REPORT: Decode Optimization - RX 7800 XT / Qwen3.8-27B (MTP OFF & ON)
Date: 2026-08-23 | Base commit: 849798132 (unchanged) | ROCm 7.2.4 | gfx1101
Hard rule honored: every change passed the correctness/quality gate BEFORE being judged on speed.

# 1. Executive Summary
- CONFIRMED ROOT CAUSE (MTP OFF, long ctx): llama.cpp forces quantized-KV decode onto the
  flash_attn_ext_vec kernel (fattn.cu "Q->ne[1] <= 2 -> VEC" rule). On gfx1101 this kernel runs
  at 256 VGPR/thread with 2-thread cooperative dots and achieves only ~33GB/s effective KV
  bandwidth. The generic TILE kernel - even when forced to dequantize the WHOLE q4_0 cache to
  F16 per call - is far faster.
- WINNING CHANGE (v5): remove the forced-VEC rule so quantized KV may use the TILE path.
  One-line experiment patch, fully reverted after validation. MTP-OFF decode:
  +5.0% @1k, +17.1% @16k, **+39.5% @63k** (11.29 -> 15.76 tok/s). Correctness gate PASSED.
- Combined with existing MTP (original spec flags): 63k decode goes 33.6-37.5 tok/s
  (median 37.1) vs phase-1 production band 21.7-35.6 (median ~25.9) => **~+43% vs median,
  variance collapsed**.
- REJECTED by measurement: nthreads_KQ_q 2->4 (neutral/-2%), block 128->256 threads (noise),
  fixshape drafting ON TOP of v5 (acceptance collapses to 48%, throughput drops),
  n_max=1 (phase 1, harmful).
- DIAGNOSTIC: f16 KV @16k (fits VRAM only at short ctx) = +22% vs q4_0 and selects TILE -
  proves the loss is the quantized VEC kernel itself, not q4_0 bandwidth cost.
- Graph-churn mystery PARTIALLY solved: resets are NOT caused by node property changes
  (instrumented build logged ZERO mismatches during decode while 154 resets occurred);
  shape-fixing does not stop them. Exact trigger (suspect: unstable graph key =
  cgraph->nodes[0] pointer aliasing across plan allocations) remains UNKNOWN.
- Production server RESTORED and VERIFIED (original unpatched binary, original flags,
  semantic outputs byte-identical to pre-experiment baseline).

# 2. Baseline Verification
- Production config re-verified at phase start: health OK, cmdline identical to manifest,
  binary mtime Aug 20 (predates all work), libggml-hip.so contains ONLY gfx1101 code objects
  (358 refs) -> "native build" experiment A1 resolved: baseline was ALREADY native; nothing to compare.
- Fresh baseline windows (untraced, same prompts/seeds as phase 1):
  MTP OFF: 1k 20.95 | 16k 17.43 | 63k 11.29 tok/s (medians; spread < +/-1%)
  MTP ON (prod flags): 63k cached 21.7-30.0 in traced session; phase-1 long-run band 21.7-35.6.
- Numerical noise floor established: MTP ON vs OFF greedy @1k = byte-identical;
  @16k first divergence char 231/~236 (batched-matmul rounding class), both outputs coherent.
  This floor is the acceptance threshold for candidates.

# 3. MTP OFF Findings
| Variant | Change (single hypothesis each) | 1k | 16k | 63k | Verdict |
|---|---|---|---|---|---|
| W1 baseline | - | 20.95 | 17.43 | 11.29 | reference |
| W2 (v1) | nthreads_KQ_q 2->4 (fattn-vec.cuh:76) | 20.75 | 17.41 | 11.05 | REJECT (all deltas <= noise, 63k -2.1%) |
| W3 (v2) | block 128->256 threads (host+device) | 21.21 | 17.37 | 11.20 | REJECT (noise) |
| W4 (v5) | allow TILE for quantized KV at ne11<=2 (fattn.cu else-branch disabled) | 21.99 | 20.40 | **15.76** | **ACCEPT** |
| C-test | KV f16 instead of q4_0 @16k only | - | 21.30 | n/a (VRAM) | diagnostic: kernel selection flips to TILE, +22.2% |
Repeat counts: 1k x4, 16k x3, 63k x3 per variant (cached-prefix decodes; medians reported;
spreads in results2/window_*.json). A/B ordering not interleaved across variants - noted limitation;
however per-window spreads are ~10x smaller than the v5 effect, so the conclusion is robust.

Kernel-level mechanism (rocprofv3, 63k):
| Kernel | baseline mean | v5 mean | role |
|---|---|---|---|
| flash_attn_ext_vec<256,1,q4_0,q4_0> | 2474us | GONE | draft/single-token FA |
| flash_attn_ext_vec<256,2,...> | 4318us | GONE | verify ncols=2 |
| flash_attn_tile<256,256,1,2> (q4_0->f16 staged) | - | **547us** | draft FA: **4.5x faster** |
| flash_attn_tile<256,256,2,2> | - | **594us** | verify ncols=2: **7x faster** |
| flash_attn_tile<256,256,8,2> | 1885us | 1860us | verify ncols>2 (unchanged) |
| dequantize_block_q4_0<__half> | 273.8us (verify only) | 208.6us x9440 (~1.97s/session total) | full-cache F16 staging, now everywhere but cheap relative to gain |
VGPR evidence (trace): VEC<256,1> = 256 VGPR/thread vs mul_mat_vec_q = 88 -> occupancy-limited;
yet raising thread cooperation (v1) or block size (v2) did NOT help, pointing at the VEC kernel's
memory pipeline for scattered quantized blocks rather than a single tunable knob.

# 4. MTP ON Findings
| Config | 63k decode tok/s | acceptance | verdict |
|---|---|---|---|
| phase-1 production (VEC paths live) | 21.7-35.6, median ~25.9, HIGH variance | 53-100%/round variable | reference |
| W8 = v5 + ORIGINAL spec flags | **33.57 / 37.50 / 37.11** (tight) | 99-100% | **ACCEPT candidate** |
| W9 = v5 + fixshape (n_min=4,p_min=0) | 23.91 / 28.70 / 33.47 | 48-62% | REJECT: forced drafts waste verify work once rounds are cheap |
Note: W8 acceptance similarity to phase-1 (drafts ~285/380 tok) shows the gain is purely from
faster per-round GPU work (both target AND draft-context attention now TILE).
fixshape value existed only pre-v5 (variance suppression); post-v5 it is counterproductive.

# 5. Per-Change Records
CHANGE 1 (v1): hip fattn-vec RDNA nthreads_KQ_q 2->4
  Hypothesis: VGPR pressure (256/thread measured) limits occupancy.
  Result: no VGPR-linked win; perf flat-to-worse. Correctness: outputs identical @1k,
  16k divergence exactly at baseline floor (231).
  VERDICT: REJECT. Patch reverted (git checkout); binary kept in build-v1 (unused).
CHANGE 2 (v2): block 128->256 threads
  Hypothesis: more warps/block improve latency hiding.
  Result: noise-level changes. Correctness gates pass.
  VERDICT: REJECT. Reverted; build-v2 kept (unused).
CHANGE 3 (v5): fattn.cu selection - drop forced VEC for quantized KV (ne11<=2 && false guard)
  Hypothesis: quantized VEC kernel is slower than TILE even paying whole-cache dequant.
  Performance: +5.0/+17.1/+39.5% (OFF); ON@63k 33.6-37.5 vs 21.7-35.6 baseline band.
  Correctness gate: determinism self-identical; smoke 5/6 with IDENTICAL failure pattern
  to baseline (greedy math2 quirk: model answers 40 for the 60km/45min item - pre-existing);
  16k needle PASS (SILVER-COMPASS-93 found); greedy @1k byte-identical to baseline;
  @16k first-divergence at the SAME char 231 as the established ON-vs-OFF noise floor (OFF path);
  ON path diverges at char 117 - verified benign (both texts find the needle; wording differs,
  i.e., implementation-noise class, not quality loss).
  Numerical sanity: no NaN/degenerate loops observed in any output; lengths normal.
  VERDICT: **ACCEPT (as experiment)**. Source reverted; build-v5/bin/llama-server retained
  as the validated artifact. NOT deployed to production (see section 11).
CHANGE 4 (C-test, diagnostic only): -ctk f16 -ctv f16 @16k
  Purpose: isolate "quantized path loss" vs "D=256 kernel loss". Answer: f16 selects TILE and
  wins +22% -> loss IS the quantized VEC kernel. f16 KV at 64k needs ~+9GB (two contexts):
  DOES NOT FIT 17GB card. Not pursued further. VERDICT: diagnostic complete.
CHANGE 5 (B1/B2): fixshape re-evaluation + graph churn instrumentation
  fixshape wide bench: see table above -> REJECT on v5.
  Instrumented build (v6diag, temporary GGML_LOG_DEBUG in ggml_cuda_graph_update_required):
  during pure decode under baseline spec args: 154 "warmup complete" vs 154 "warmup reset",
  467 uid-reuses, ZERO node-property mismatches, ZERO size-changes after init. Under fixshape:
  264/264/972 with zero mismatches as well. Conclusion: replay failure is NOT driven by tensor
  property drift; most plausible remaining cause is unstable graph keying (key = nodes[0]
  pointer) colliding/re-allocating across the two contexts' plans. Exact trigger: UNKNOWN
  (would require allocator-level tracing; machine power-loss interrupted the final diag pass).

# 6. Kernel-Level Before/After
See tables in sections 3-4. Prefill unaffected by v5: 322 tok/s @63k before AND after
(FA prefill kernel tile<16> 78.7ms/call unchanged; #26419-class MMA would target this but its
dispatch condition Q->ne[1]*gqa_ratio_eff > 64 excludes decode batches - verified from PR diff).

# 7. Context Scaling (MTP OFF, v5 vs baseline)
| ctx | baseline | v5 | delta |
|---|---|---|---|
| 1k | 20.95 | 21.99 | +5.0% |
| 16k | 17.43 | 20.40 | +17.1% |
| 63.5k | 11.29 | 15.76 | +39.5% |
Gain grows with context because VEC degradation is KV-length-dependent while TILE scales better.

# 8. Regression / Divergence Table
| Comparison | ctx | first divergence | assessment |
|---|---|---|---|
| prod-ON vs OFF (baseline) | 1k | none | equivalence holds |
| prod-ON vs OFF (baseline) | 16k | ch.231 | noise floor definition |
| v5-OFF vs baseline-OFF | 1k | none | identical |
| v5-OFF vs baseline-OFF | 16k | ch.231 | AT noise floor -> numerically equivalent |
| v5-ON vs baseline-OFF | 1k | none | identical |
| v5-ON vs baseline-OFF | 16k | ch.117 | benign rephrase; needle found; semantics intact |
| v5-ON vs v5-OFF | 16k | ch.117 | same benign pair |
| restored-prod vs baseline smoke heads | 1k x6 | none | ALL byte-identical |

# 9. Best Safe Configuration
- Binary: stock llama.cpp @849798132 PLUS the v5 one-line selection change (candidate for
  upstream PR; locally validated). Artifact: build-v5/bin/llama-server.
- Spec flags: keep PRODUCTION defaults (--spec-type draft-mtp --spec-draft-n-max 4
  --spec-draft-p-min 0.8). Do NOT add n_min/p_min=0.
- Expected user-visible result @63k: ~33-38 tok/s effective decode (vs 21.7-35.6 before,
  median ~+43%), prefill unchanged, output quality unchanged within measured noise class.

# 10. Experimental But Promising Patches (not applied here)
- Upstream PR #26419 (WMMA MMA at DKQ=256 for RDNA): helps PREFILL (pp) only under current
  dispatch (>64 ratio gate); decode unaffected. Worth tracking; do not expect tg gains.
- Quantized-KV TILE without full-cache staging (persistent F16 sidecar updated incrementally
  by set_rows, Metal-precedent #23114 pattern): would remove the 208us-per-tensor staging cost
  and likely push 63k OFF decode toward ~18-20 tok/s. Medium effort, backend-specific.
- Fixing graph key stability (nodes[0] pointer) to restore replay under MTP: targets the
  remaining CPU-side gap at short ctx (~25% idle pre-v5; smaller post-v5 but nonzero).

# 11. Changes That Must NOT Go To Production
- fixshape drafting (n_min=n_max, p_min=0): throughput regression on v5 (23.9 best-case round
  hit 48% acceptance); also inflates draft KV writes.
- n_max=1 speculation: 14.6 tok/s @63k (worse than OFF-on-v5).
- f16 KV at 64k context: does not fit VRAM (needs ~+9GB over current 15.4GB peak).
- v1/v2 fattn-vec tuning knobs: neutral; dead code risk.

# 12. Remaining Unknowns
1. Graph-reset trigger identity (see 5/CHANGE 5): property-independent; pointer-key instability
   is the leading suspect but unproven.
2. Why FA-VEC<256,q4_0> is intrinsically slow on RDNA3 (256 VGPR, dp4a nibble path): needs
   ATT/PC-sampling; our two knob experiments rule out simple occupancy fixes.
3. Sampling-chain CPU share at short ctx (backend_sampling=false): unmeasured; bounded above
   by the idle fraction which v5 did not change materially at 1k.
4. Upstream disposition of the v5 selection change (must be proposed/discussed; not submitted).

# 13. Reproduction Commands
# Baseline OFF window (isolated restart; restores nothing - run prod launcher after):
python3 results2/window_runner.py W1_baseline_OFF --off
# v5 candidate OFF window:
python3 results2/window_runner.py W4_v5_tile --bin=$PWD/build-v5/bin/llama-server --off
# v5 + production spec flags ON window:
python3 results2/window_runner.py W8_v5_ON_base --bin=$PWD/build-v5/bin/llama-server
# v5 + fixshape ON window:
python3 results2/window_runner.py W9_v5_fixshape --bin=$PWD/build-v5/bin/llama-server --fixshape
# f16 KV isolation @16k:
python3 results2/ctest_kv.py C_f16kv f16
# Build a variant (applies patch, ccache build, reverts source):
bash results2/build_variant.sh v5
# Graph churn logging:
python3 results2/b2_graph_churn.py base        # then analyze counts in results2/b2_b2_base.log
# Production restore + verify (after ALL windows):
/tmp/opencode/launch_prod.sh ; curl localhost:8080/health
readlink /proc/$(pgrep -f 'llama-server -m' | head -1)/exe     # must be .../build/bin/llama-server
python3 - <<'EOF'  # greedy spot-check vs stored baseline
import sys, json; sys.path.insert(0,'results'); sys.path.insert(0,'results2')
from correctness_suite import gen, SMOKE
base=json.load(open('results2/correctness/baseline_ON_prod_v3.json'))
for name,prompt,_ in SMOKE:
    r=gen(prompt,64); ref=[s['out_head'] for s in base['semantic_1k'] if s['test']==name][0]
    print(name, r['text'][:80].replace("\n"," ")==ref)
EOF

# 14. Evidence Index
| Claim | Evidence |
|---|---|
| Baseline native gfx1101 build | strings libggml-hip.so -> 358x gfx1101, 0 others |
| OFF baselines 20.95/17.43/11.29 | results2/window_W1_baseline_OFF.json |
| v1 neutral | results2/window_W2_v1.json (REJECT) |
| v2 neutral | results2/window_W3_v2.json (REJECT) |
| v5 +39.5% @63k OFF | results2/window_W4_v5_tile.json |
| v5 ON 33.6-37.5 @63k | results2/window_W8_v5_ON_base.json |
| fixshape-on-v5 regression | results2/window_W9_v5_fixshape.json |
| f16 KV +22% & TILE selection | results2/ctest_C_f16kv.json; traces_v5/11638_kernel_trace.csv |
| VEC 256 VGPR | phase-1 T3 trace CSV col VGPR_Count (flash_attn_ext_vec row) |
| v5 kernel means (547/594/1860us) | results2/traces_v5/cachyos-x8664/11638_kernel_trace.csv |
| Churn: 154/154 resets, 0 mismatches | results2/b2_b2_base.log, results2/b2_diag.log (v6diag) |
| fixshape churn 264/264 | results2/b2_b2_fixshape.log |
| Correctness gates all windows | results2/correctness/*.json, window_*gate records |
| PR #26419 status/dispatch scope | github fetch (open, d76c0046, applies cleanly, pp-only) |
| Issue #27009 status | github fetch (open, no implementing PR) |
| Production restored+verified | exe readlink build/bin; smoke-heads 6/6 byte-identical; needle PASS |
| Interruption note | host power-loss between b2 diag passes; processes recovered cleanly |

POSTSCRIPT - production state at report time:
PID $(pgrep -f 'llama-server -m'), binary build/bin/llama-server (mtime Aug 20, untouched),
original flags incl --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8,
health OK, greedy semantic suite byte-identical to pre-phase-2 baseline.
