#!/usr/bin/env python3
"""Campaign 2: proper 1k and 65k contexts, MTP ON. Fixed tokenizer calibration."""
import json, os, sys, time
sys.path.insert(0, os.path.dirname(__file__))
from bench import make_text, run_one, summarize, metrics
from campaign import spec_delta

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXPDIR = str(ROOT / "results/experiments")
NPRED = 128

def main():
    results = []
    # warmup (server already in draft-mtp default)
    run_one("Warmup gamma.", 16, spec_type=None, seed=1234, tag="warmup")

    for c in [1024, 65536]:
        ck = f"{c//1024}k"
        prompt = make_text(c - 64, seed=4200 + c)
        body, _ = __import__("bench").post("/tokenize", {"content": prompt})
        print(f"target {c}, actual tokens: {len(body['tokens'])}", flush=True)
        exp = f"ctx_{ck}_mtp_on_run_1_v2"
        mb = metrics()
        r = run_one(prompt, NPRED, spec_type=None, seed=555 + c, cache_prompt=False, tag=exp)
        ma = metrics()
        r.update(exp_id=exp, ctx_target=c, prompt_tokens_actual=len(body["tokens"]),
                 spec_delta=spec_delta(mb, ma))
        results.append(r)
        print(json.dumps({k: r[k] for k in ("exp_id","prompt_n","prompt_ms","prefill_tok_s",
              "predicted_n","predicted_ms","decode_tok_s")}), flush=True)
        for run in range(2, 6):
            exp = f"ctx_{ck}_mtp_on_run_{run}_v2"
            mb = metrics()
            r = run_one(prompt, NPRED, spec_type=None, seed=777 + c*10 + run,
                        cache_prompt=True, tag=exp)
            ma = metrics()
            r.update(exp_id=exp, ctx_target=c, spec_delta=spec_delta(mb, ma))
            results.append(r)
            print(json.dumps({k: r[k] for k in ("exp_id","predicted_n","predicted_ms",
                  "decode_tok_s")}), flush=True)

    with open(os.path.join(EXPDIR, "campaign2_results.json"), "w") as f:
        json.dump(results, f, indent=1)
    print("DONE", flush=True)

if __name__ == "__main__":
    main()
