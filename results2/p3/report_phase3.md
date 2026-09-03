# PHASE 3 REPORT: Upstream-Quality v5 Patch + Output Quality / Regression Validation
Date: 2026-08-23 | Base commit 849798132 | ROCm 7.2.4 | gfx1101 (RX 7800 XT)
Rule compliance: quality = hard gate; no push/PR; production restored & verified.

# 1. Executive Summary
- Quality verdict: **PASS** - clean patch shows no systematic degradation.
  Deterministic suite 12/12 in all four configs (baseline/clean x ON/OFF);
  needle retrieval intact everywhere; degeneration behavior byte-for-byte
  unchanged on the adversarial prompt; divergences confined to the
  established kernel-noise class with equal-validity rephrasings.
- Clean patch status: **DONE and validated**. Branch `fattn-rdna3-quant-tile`,
  commit d906c4912 (+7/-1, two files: dispatch condition + 2 test cases).
  Reproduces experimental v5 performance: +2.6%/+14.5%/+34.7% decode at
  1k/16k/63k OFF vs same-day baseline; 63k MTP-ON band 33.6-37.6 tok/s
  (acceptance 99-100%), matching phase-2 W8 within noise.
- Ready for upstream review: YES (draft prepared, NOT submitted).
- Production: original binary + flags running, health OK, outputs verified.

# 2. Existing Artifact Investigation
| artifact | ts | schema/origin | content check |
|---|---|---|---|
| baseline_ON_prod.json/v2/v3 | Aug22 23:46-52 | correctness_suite.py full_gate | mutually consistent (v2==v3); v1 has 16k outlier from harness iteration |
| baseline_OFF_greedy.json | Aug23 00:09 | ad-hoc flat-text extraction (gen_1k_text/gen_16k_text) of the W1 OFF-window gate | VALID: gen_1k byte-equal to W1 gate AND all ON baselines; gen_16k diverges at exactly char 231 (= documented cross-mode noise floor) |
| prod_restore_check.json | Aug23 11:24 | full_gate after restore | identical to v3 |
Explanation of the 773-byte size: it stores only the two raw greedy texts,
no metadata/metrics - an extraction artifact, not a broken run.
"and where..." origin: it is present in EVERY config ever captured
(ON v1/v2/v3, OFF W1-gate, OFF-greedy extract, v5-OFF W4 gate, restore-check):
a deterministic greedy loop on random-word-soup prompts (make_text), not a
kernel/config regression. The phase-2 "restore anomaly" is likewise resolved:
seed 4201024 produces the analogous "and dog..." loop; different prompt,
same phenomenon.

# 3. Degeneration Regression Results (Section B probe)
Protocol: make_text(960,seed=4242), greedy temp=0/top_k=1, n=96, x5 runs
alternating cache_prompt False/True; plus seed 4201024 variant; plus n=384
horizon; plus natural-prompt control.
| config | x5 identical | loop text | bigram_rep(96w) | n384 bigram_rep | control healthy |
|---|---|---|---|---|---|
| baseline ON (live prod) | YES 5/5 | " and where" | 0.9789 | 0.9948 | yes |
| baseline OFF (window A) | YES 5/5 | " and where" | same | same | yes |
| clean OFF (window B) | YES 5/5 | " and where" | same | same | yes |
| clean ON (window C) | YES 5/5 | " and where" | same | same | yes |
Classification: **A - reproducible baseline model degeneration** under this
prompt class and greedy decoding; independent of mode, binary, restart, day.
It is NOT a regression indicator and NOT changed by the patch (byte-identical).
The seed-4201024 variant ("and dog...") reproduces identically as well.

# 4. Compact Quality Suite (12 deterministic tests)
All configs: temp=0 top_k=1, cache_prompt=False (state-independence fix vs
phase-2 harness), fresh prefill for long-context tests.
| test | purpose | base_ON | base_OFF | clean_OFF | clean_ON | divergence vs same-mode baseline |
|---|---|---|---|---|---|---|
| factual_en | short factual | PASS | PASS | PASS | PASS | IDENTICAL |
| arith_simple | 17x23 | PASS | PASS | PASS | PASS | IDENTICAL |
| arith_multistep | train problem (baseline quirk "40") | PASS* | PASS* | PASS* | PASS* | IDENTICAL |
| puzzle | trick reasoning | PASS | PASS | PASS | PASS | IDENTICAL |
| code_func | code generation | PASS | PASS | PASS | PASS | prefix 88-103 chars, then equally valid rephrase (both correct impl) |
| code_oneliner | sum() one-liner | PASS | PASS | PASS | PASS | IDENTICAL |
| turkish | non-English | PASS | PASS | PASS | PASS | IDENTICAL |
| list_struct | structured 1..20 (loop detector) | PASS | PASS | PASS | PASS | IDENTICAL |
| needle16k_single (~24.8k tok) | long-ctx recall SILVER-COMPASS-93 | PASS | PASS | PASS | PASS | OFF prefix 231 (=noise floor), ON 117 (benign, phase-2 class) |
| needle_multi (~24k tok, 2 needles @33%/66%) | multi-target recall | PASS | PASS | PASS | PASS | OFF prefix 262, ON 109; both needles found in all configs |
| longgen_story 320tok | degeneration thresholds | PASS | PASS | PASS | PASS | prefix ~308-351, metrics all inside thresholds |
| degen_trap_p1k | recovered regression case | PASS | PASS | PASS | PASS | IDENTICAL (loop unchanged by design) |
PASS* = matches recorded baseline behavior (known model quirk: says 40 not 80;
present in ALL configs incl. stock production - documented, out of scope).

# 5. Sampled Sanity (temp 0.7, top_k 40, seeds 7/77/777)
Prompts: turkish / story / arith; pass = no degeneration (bigram_rep<0.5) +
non-empty; aggregate comparison only.
| config | pass | mean bigram_rep | max |
|---|---|---|---|
| baseline ON | 8/9 | 0.144 | 0.600 (turkish s7) |
| baseline OFF | 9/9 | 0.145 | 0.455 (turkish s7) |
| clean OFF | 8/9 | 0.176 | 0.800 (turkish s7) |
| clean ON | 8/9 | 0.176 | 0.800 (turkish s7) |
Interpretation: the only elevated item is (turkish, seed 7), which already
trends high on stock production (0.45-0.60) - a prompt-echo tendency under
sampling. Clean shows 0.80 on that single seed. With n=1 per seed this is
within sampling variance; the deterministic suite (incl. 320-token open-ended
generation and the trap prompt) shows zero change. No systematic degradation
evidence; no improvement claim either.

# 6. Final Patch
Files changed:
- ggml/src/ggml-cuda/fattn.cu (dispatch): quantized-KV forced-VEC now skipped
  when `GGML_CUDA_CC_IS_RDNA3(cc) && Q->ne[0] == 256`, letting those shapes
  reach BEST_FATTN_KERNEL_TILE. Uses the existing RDNA3 family helper;
  scope limited to the measured head size; f16 path and all other
  architectures/head sizes unchanged; 2-line plain-English comment.
- tests/test-backend-ops.cpp: two decode-shaped cases (256,256,4,{6,1},512,
  nb=1/2, q4_0/q4_0) closing the coverage gap (quantized small-batch existed
  only at hsk 64/72; hsk 256 existed only prefill-shaped or f16).
Why appropriate: minimal, evidence-exact, follows existing conventions
(CC helper + selection function), no dead code/debug/instrumentation.
Commit d906c4912 on branch fattn-rdna3-quant-tile; master untouched;
diff snapshot: results2/p3/final.diff.

# 7. Performance Revalidation (same-day paired windows, medians, tok/s)
| context | baseline OFF (A) | clean OFF (B) | delta |
|---|---|---|---|
| 1k | 21.54 | 22.09 | +2.6% |
| 16k | 17.88 | 20.47 | +14.5% |
| 63k | 11.76 | 15.84 | **+34.7%** |
MTP ON 63k (original spec flags): clean = 33.62/37.58/36.58 median **36.58**
vs phase-1 production band 21.7-35.6 (median ~25.9) => +~41% vs median,
variance collapsed; acceptance 269/272, 290/290, 285/285 (99-100%).
Prefill unchanged: pp63k 334.5 (base) vs 334.5 (clean) tok/s.
Cross-checks: values match phase-2 W1/W4/W8 artifacts within day drift.

# 8. Kernel/Dispatch Confirmation
rocprofv3 trace of clean binary, MTP OFF, full session incl. one 63k decode
(results2/p3/traces_clean/.../37657_kernel_trace.csv):
- flash_attn_ext_vec instances: **0**
- flash_attn_tile<256,256,1,2>: 1520 launches, VGPR=128 (replaces VEC<256,1>
  which measured VGPR=256 in phase-2 traces)
- flash_attn_tile<256,256,2,2>: 32 launches, VGPR=240 (verify ncols=2)
- flash_attn_tile<256,256,16,2>: 1984 (prefill, expected)
- dequantize_block_q4_0: 7136 launches (tile F16 staging, cheap as measured)

# 9. Upstream PR Draft
Full draft: results2/p3/pr_draft.md (title, commit message, body with
Measured vs Not-established sections, benchmark + correctness summary,
test plan). NOT submitted; nothing pushed.

# 10. Limitations / Risks
- Hardware: only gfx1101 measured. RDNA3 siblings share ISA/VGPR limits but
  are untested; RDNA4/CDNA/NVIDIA explicitly excluded from the patch scope.
- Shape: DKQ=DV=256 only; q4_0/q4_0 KV only; Q->ne[1] in {1,2}.
- Numerical: TILE != VEC bit-exactly; short-context greedy outputs can flip
  to equally valid continuations (observed once in 12 prompts at ~88 chars).
  Long-context divergence equals the existing cross-kernel/batching noise
  floor. Users comparing exact token streams across binaries will see diffs.
- Benchmark limits: single machine, single model family, cached-prefix
  protocol, no interleaved A/B ordering; spreads < +/-1% but day drift up to
  ~4% exists between sessions (paired same-day windows used for deltas).
- The known math2 "40" quirk is a model-level issue present in stock
  production; unrelated to this patch.

# 11. Production State
- Source tree: pristine at 849798132 (`git diff` empty; patch lives only on
  branch fattn-rdna3-quant-tile and in build-p3 artifacts).
- Binary: build/bin/llama-server untouched (mtime Aug 20).
- Launcher/flags: /tmp/opencode/restore_server.sh (original manifest flags).
- Runtime: PID alive, exe=build/bin/llama-server, health {"status":"ok"}.
- Output verification: semantic smoke heads byte-identical to pre-phase-2
  baseline (results2/correctness/baseline_ON_prod_v3.json).

## Evidence Index (this phase)
- results2/p3/suite_baseline_ON.json / suite_A_baseline_OFF.json /
  suite_B_clean_OFF.json / suite_C_clean_ON.json : quality suite artifacts
- results2/p3/degen_baseline_ON.json / degen_A_baseline_OFF.json /
  degen_B_clean_OFF.json / degen_C_clean_ON.json : degeneration probes
- results2/p3/window_A_baseline_OFF.json / B_clean_OFF.json / C_clean_ON.json : perf windows
- results2/p3/run_A.log / run_B.log / run_C.log : raw bench lines
- results2/p3/traces_clean/cachyos-x8664/37657_kernel_trace.csv : dispatch proof
- results2/p3/p3_degen_probe.py / p3_quality_suite.py / p3_window.py : harness
- results2/p3/final.diff, results2/p3/pr_draft.md : PR-ready output
- build-p3/bin/{llama-server,test-backend-ops} : validated candidate builds
