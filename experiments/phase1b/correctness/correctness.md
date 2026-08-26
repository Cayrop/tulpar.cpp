# Phase-1B Correctness Gate Results

Date: 2026-08-24
Binary: build-p3/bin/llama-server (280556cc...)
Server config: -c 131072 -ngl 999 -fa on -ctk q4_0 -ctv q4_0, graph ON, host 127.0.0.1:8080

## Verdict: GATE_PASS

## MTP OFF (full quality suite)

Command: `python3 results2/p3_quality_suite.py phase1b_gate_off suite_off.json`
Result rc=0.

- deterministic tests: 12/12 PASS
  (factual_en, arith_simple, arith_multistep[known baseline quirk], puzzle,
   code_func, code_oneliner, turkish, list_struct, needle16k_single,
   needle_multi, longgen_story, degen_trap_p1k)
- needle16k_single: PASS
- degen_trap_p1k: PASS (documented "and where..." loop unchanged)
- sampled sanity (temp 0.7): 8/9
  - single fail: turkish seed=7 -> "Ankara." repetition loop under sampling.
    Sampling variance, not a regression target; the DETERMINISTIC turkish test
    passes. Runbook pass criteria are deterministic-12/12 + needle + degen_trap:
    all met.

## MTP ON (quick smoke)

Config: --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8

| test | pass | draft_n | accepted | rate |
|------|------|---------|----------|------|
| en_factual_paris | PASS | 30 | 19 | 0.633 |
| tr_factual_ankara | PASS | 23 | 20 | 0.870 |
| math_391 | PASS | 23 | 18 | 0.783 |
| json_shape | PASS | 236 | 209 | 0.886 |

- MTP acceptance counters readable in per-request timings (draft_n,
  draft_n_accepted) and /metrics exposes spec_decode_* counters:
  spec_decode_num_drafts_total, spec_decode_num_draft_tokens_total,
  spec_decode_num_accepted_tokens_total,
  spec_decode_num_accepted_tokens_per_pos_total

## Notes / incidents during gate

1. json_shape first two runs reported FAIL. Diagnosis: model output was valid
   JSON (verified raw dump); failure was a harness parser bug (slice from first
   '{' to last '}' spanned multiple JSON objects). Fixed extraction regex;
   clean rerun PASS. Model behavior itself was coherent throughout; not an
   MTP correctness issue.
2. Server start/stop for each phase used pidfile policy scripts only.
   No stray llama processes at any point (verified via pgrep discovery).

## Artifacts

- experiments/phase1b/correctness/suite_off.json
- experiments/phase1b/correctness/smoke_on.json
- experiments/phase1b/correctness/json_diag_raw.txt (parser bug diagnosis)
- experiments/phase1b/correctness/gate_console.log
- experiments/phase1b/correctness/gate_on_rerun.log
- server logs: experiments/phase1b/logs/srv_gate-off.log, srv_gate-on.log, srv_jsondiag.log
