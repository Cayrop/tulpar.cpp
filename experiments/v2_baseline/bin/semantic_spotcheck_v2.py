#!/usr/bin/env python3
# EXP-002 semantic spot-check: character-exact output-head match vs the V2
# stored baseline (results2/correctness/baseline_v2.json, MTP ON heads).
import json
import sys
import time

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, f"{ROOT}/results")
from bench import post

BASE = json.load(open(f"{ROOT}/results2/correctness/baseline_v2.json"))
base = {t["test"]: t for t in BASE["semantic_smoke_mtp_on"]["semantic_smoke"]}

tests = {
    "math": ("Q: What is 17 * 23? Answer with the number only.\nA:", 64),
    "math2": ("Q: A train travels 60 km in 45 minutes. What is its average speed in km/h? Answer with the number only.\nA:", 96),
    "puzzle": ("Q: A farmer has 17 sheep. All but 9 run away. How many sheep does he have left? Answer with the number only.\nA:", 96),
    "factual": ("Q: What is the capital of France? Answer with the city name only.\nA:", 64),
    "code": ("Write a Python function named reverse_string that takes s and returns s reversed.", 128),
    "code2": ("Write a Python one-liner that computes the sum of squares of numbers 1 to 10. Use sum().", 128),
}

results = []
for test, (prompt, npred) in tests.items():
    want = base[test]["out_head"]
    body, _w = post("/completion", {"prompt": prompt, "n_predict": npred,
                                    "temperature": 0.0, "top_k": 1,
                                    "seed": 1234, "stream": False,
                                    "ignore_eos": True})
    text = body.get("content") or ""
    flat = text.replace("\n", " ")
    head = flat[:len(want)]
    results.append({"test": test, "match": head == want,
                    "head": head[:110], "want": want[:110],
                    "prompt_n": len(post("/tokenize", {"content": prompt})[0]["tokens"])})

ok = sum(1 for r in results if r["match"])
out = {"tag": sys.argv[1] if len(sys.argv) > 1 else "v2_semantic_check",
       "ts": time.strftime("%F %T"), "matches": ok, "n": len(results),
       "results": results}
json.dump(out, open(sys.argv[2], "w"), indent=1)
print(json.dumps(out, indent=1))
