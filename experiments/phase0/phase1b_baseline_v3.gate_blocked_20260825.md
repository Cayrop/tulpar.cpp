# Phase-1B Baseline (V3) - NOT MEASURED

Status: BLOCKED BY CORRECTNESS GATE.

The phase-0 prompt mandates: "If ANY correctness gate fails, STOP and report.
Do not proceed to baseline." The gate failed (details:
experiments/phase0/correctness_gate_v3.md):

- deterministic suite 10/12 in BOTH MTP configs
  (puzzle wrong answer; degen_trap_p1k expected-loop no longer produced)
- semantic spot-check vs stored baseline: 2/6 char-exact (criterion also
  structurally stale - see model_swap_verification.md forensics)

Therefore NO performance ladder was run for V3. No tg/pp tok/s, acceptance,
VRAM-peak or swap numbers exist from this phase. Nothing was fabricated.
The only long-generation datapoint captured (gate context, single pass,
MTP OFF, 124,119-token needle prompt): pp 240.66 tok/s fresh prefill,
tg 12.776 tok/s over 192 tokens - recorded as observational evidence that
the V3 weights run and scale to ~124k on this GPU, NOT as a baseline number.

## How to unblock (for the human decider)

1. Adjudicate the gate findings:
   - accept the two probe regressions as expected weight-swap behavior, or
   - reject the V3 quant (try a higher-rank UD variant).
2. If accepted: re-issue the Phase-0/1B measurement window; the harness is
   ready (experiments/phase0/bin/srv_ctl_p0.sh + arm_run_p0.py mirror the
   Phase-1B drivers with pidfile policy, VRAM guard at 15.6 GiB sampled,
   per-arm fresh instances). Recommended arms unchanged:
   1k/16k/63k/128k x MTP OFF/ON (+ optional 131k ctx), >=3 reps,
   spread <1%, greedy, fixed prompts, pp from fresh rep1.
3. Replace results2/correctness/baseline_ON_prod_v3.json heads with a NEW
   post-swap semantic baseline recorded against the adjudicated weights;
   the current file provably embeds foreign cache context and pre-V3
   behavior, so it cannot serve as a comparison target anymore.
