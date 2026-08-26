#!/usr/bin/env python3
# Post-restore semantic spot-check vs results2/correctness/baseline_ON_prod_v3.json
import json
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, f"{ROOT}/results")
from bench import post

BASE = json.load(open(f"{ROOT}/results2/correctness/baseline_ON_prod_v3.json"))
base = {t["test"]: t for t in BASE["semantic_1k"]}

candidates = {
    "math": ["Q: What is 17 * 23? Answer with the number only.\nA:"],
    "math2": ["Q: A car travels 60 km in 45 minutes. What is its average speed in km/h? Answer with the number only.\nA:",
              "Q: A car travels 60 km in 45 minutes. What is its average speed? Answer with the number only.\nA:"],
    "puzzle": ["Q: A farmer has 17 sheep. All but 9 run away. How many are left? Answer with the number only.\nA:",
               "Q: A farmer has 17 sheep and all but 9 run away. How many are left? Answer with the number only.\nA:"],
    "factual": ["Q: What is the capital of France? Answer with the city name only.\nA:"],
    "code": ["Q: Write a Python function that reverses a string.\nA:",
             "Q: Write a Python function to reverse a string.\nA:"],
    "code2": ["Q: Write a Python one-liner that computes the sum of squares of numbers 1 to 10 using sum().\nA:",
              "Q: Write a Python one-liner computing the sum of squares of numbers from 1 to 10.\nA:"],
}

results = []
for test, cands in candidates.items():
    want_head = base[test]["out_head"]
    matched = None
    for p in cands:
        n_tok = len(post("/tokenize", {"content": p})[0]["tokens"])
        body, _w = post("/completion", {"prompt": p, "n_predict": 64,
                                        "temperature": 0.0, "top_k": 1,
                                        "seed": 1234, "stream": False,
                                        "ignore_eos": True})
        head = (body.get("content") or "")[:len(want_head)]
        if head == want_head:
            matched = {"test": test, "prompt_n": n_tok, "match": True,
                       "head": head.replace("\n", " ")[:120]}
            break
        cand = {"test": test, "prompt_n": n_tok, "match": False,
                "head": head.replace("\n", " ")[:120], "prompt": p}
        if matched is None or not matched.get("match"):
            matched = cand
    results.append(matched)

ok = sum(1 for r in results if r["match"])
out = {"tag": "phase2b_rerun_semantic_check", "ts": __import__("time").strftime("%F %T"),
       "matches": ok, "n": len(results), "results": results}
json.dump(out, open(f"{ROOT}/experiments/phase2b/restore/semantic_check_rerun.json", "w"), indent=1)
print(json.dumps(out, indent=1))
