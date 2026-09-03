#!/usr/bin/env python3
# Phase-0 single-needle retrieval at ~126k context (gate item "128k needle").
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from bench import post
from correctness_suite import build_needle_prompt, NEEDLE

TARGET_TOKENS = int(sys.argv[1]) if len(sys.argv) > 1 else 126000
OUTJSON = sys.argv[2] if len(sys.argv) > 2 else str(ROOT / "experiments/phase0/raw/needle_128k.json")

p = build_needle_prompt(TARGET_TOKENS)
n = len(post("/tokenize", {"content": p})[0]["tokens"])
body, wall = post("/completion", {"prompt": p, "n_predict": 192,
                                  "temperature": 0.0, "top_k": 1,
                                  "cache_prompt": False, "ignore_eos": True,
                                  "seed": 1234, "stream": False})
t = body["timings"]
text = body.get("content", "")
out = {
    "tag": "needle_128k_single",
    "ts": time.strftime("%F %T"),
    "prompt_tokens": n,
    "pass": NEEDLE.lower() in text.lower(),
    "expect": NEEDLE,
    "head": text[:200].replace("\n", " "),
    "prompt_ms": t.get("prompt_ms"), "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
    "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
    "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
    "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted"),
    "wall_s": round(wall, 2),
}
json.dump(out, open(OUTJSON, "w"), indent=1)
print(json.dumps(out, indent=1))
