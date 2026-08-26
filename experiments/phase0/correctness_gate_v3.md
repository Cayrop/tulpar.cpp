# Phase-0 Correctness Gate (V3 weights)

Date: 2026-08-25 22:40 - 23:15 +03
Binary: build-p3/bin/llama-server (sha256 280556cc..., unchanged)
Model: Qwen3.8-27B-UD-Q2_K_XL.gguf, sha256 fd4730dd... (CURRENT bytes, ctime 22:28:09)
Suite: results2/p3_quality_suite.py, unmodified. Greedy: temperature 0, top_k 1,
seed 1234, ignore_eos, cache_prompt=False.

## Verdict

GATE_FAIL - STOP before baselines (per phase rule "if ANY correctness gate
fails, STOP and report").

Two deterministic tests fail in BOTH MTP configurations, the semantic
spot-check is 2/6 char-exact against the stored baseline, and the stored
baseline itself is proven stale for the current weights (forensics in
model_swap_verification.md). All failures are consistent with genuine
behavior changes from the new quantization distribution, not with harness,
cache, or server-config artifacts (checked explicitly; see section 4).

## 1. Deterministic suite results

| config | server | ctx | det pass | sampled sanity |
|--------|--------|-----|----------|----------------|
| MTP ON | prod flags (spec draft-mtp n-max 4) | 65536 | 10/12 | 9/9 |
| MTP OFF| no spec flags | 131072 | 10/12 | 8/9 |

Failing deterministic tests (identical in both configs):

1. puzzle - FAIL. Prompt: "A farmer has 17 sheep. All but 9 run away..."
   V2-era behavior answered "9" (correct). V3 answers:
   `  8  **Explanation:** The phrase "All but 9" means that everyone except 9 sheep ...`
   i.e. a WRONG answer ("8"), stable across reps and configs.
2. degen_trap_p1k - FAIL by the suite's own definition ("KNOWN baseline
   degeneration ... must be unchanged"). The greedy "and where and where..."
   loop head is no longer produced; instead V3 generates different text
   (bigram_rep_rate 0.9789, last50_uniq 2 - still degenerate, but a DIFFERENT
   loop surface).

Passing highlights (both configs): factual_en (Paris), arith_simple (391),
arith_multistep (quirk-tolerant), code_func, code_oneliner, turkish (Ankara),
list_struct (1..20 ordered), needle16k_single (SILVER-COMPASS-93 at ~24.8k),
needle_multi (both codes at 33%/66% depth), longgen_story (degeneration
thresholds OK).

Sampled sanity: OFF failed only turkish seed=777 (bigram_rep 0.5091 vs <0.5
threshold) - the same known quirk documented since earlier phases (Phase-1B:
8/9 with seed=7; same family). ON passed 9/9.

## 2. Long-context needle (gate item "128k needle")

Single-needle retrieval at 124,119 prompt tokens (~50% depth), MTP OFF,
fresh prefill, ctx 131072: PASS (SILVER-COMPASS-93 retrieved verbatim).
Observational timings (NOT baseline numbers): pp 240.66 tok/s,
tg 12.776 tok/s over 192 predicted tokens.
Artifact: correctness/needle_128k_off.json

## 3. Semantic spot-check vs results2/correctness/baseline_ON_prod_v3.json

Criterion as written: 6/6 character-identical output-head matches.

Result: 2/6 char-exact, identical pattern under MTP ON and MTP OFF:

| test | match |
|------|-------|
| math   (391 + echo)          | MATCH |
| code2  (<think> one-liner)   | MATCH |
| math2  (train speed)         | MISMATCH - V2 head: "  40  **Step-by-step Deduction:**..." ; V3: "  480/45 = 10.666666666666667 ..." (repetition loop on a wrong path) |
| puzzle (sheep)               | MISMATCH - V2 head: "  9  The phrase..." ; V3: "  8  **Explanation:**..." |
| factual (capital of France)  | MISMATCH - stored head embeds "...capital of Germany?..." echo from its recording session (see forensics); V3 echoes France then continues |
| code   (reverse_string)      | MISMATCH - function body identical; continuation after it differs ("This uses Python's slice notation." -> next-question echo) |

Why the criterion is structurally impossible right now:
a) The baseline heads were recorded Aug-22 against the OLD quantization;
   tonight's pre-swap file reproduced them 6/6 precisely because it was
   behaviorally V2-equivalent. The CURRENT V3 bytes cannot be expected to.
b) The baseline heads themselves contain foreign KV-cache context (Germany
   echo under a France prompt), so even V2 reproduction depended on
   replicating that evening's request history, not just model+prompt.

Artifacts: correctness/semantic_on_v3.json, correctness/semantic_off_v3.json

## 4. Alternative explanations checked and ruled out

- Cache/slot effects: re-ran all six probes with cache_prompt=False and True -
  identical outputs either way; within-instance determinism verified (3 reps
  byte-stable per prompt).
- MTP interference: ON and OFF produce IDENTICAL mismatch/match patterns ->
  speculative decoding is output-preserving here; divergence is weight-driven.
- Wrong binary / flags: exe validated via pidfile+/proc; flags verbatim from
  ops/manifest/prod_flags.env; binary sha256 matches Phase-1B fingerprint.
- Stale GGUF being served: server mmaps resolved to path inode 30986567 ==
  current file (sha fd4730dd); ctime evidence shows an EARLIER instance
  served pre-22:28 bytes (explains tonight's void 6/6 artifact).

## 5. Gate decision

Per phase instructions ("If ANY correctness gate fails, STOP and report. Do
not proceed to baseline"): Phase-1B-style baselines were NOT measured.

Substantive reading for the human decider:
- Retrieval/structure/long-context behavior is intact at both short and
  ~124k depth (all needle tests PASS).
- Two small-probe regressions are real: arithmetic-ish trick reasoning
  (puzzle answers 8 instead of 9) and changed degeneration surfaces
  (math2 now loops "480/45 = 10.66...", degen trap moved to a new trigger).
  These are plausible consequences of the more aggressive IQ2/IQ3-heavy
  dynamic quant mix (streamed bytes/step dropped 9.7% vs V2).
- Decision needed whether these probe deltas are acceptable for V3 or
  whether a higher-rank UD variant should be evaluated instead. Baselines
  should run only after that call.
