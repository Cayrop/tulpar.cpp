#!/usr/bin/env python3
# Build a deterministic prompt that FITS the 131072 ctx (with decode headroom)
# using the Phase-1B make_text family, then save exact text for reuse.
import sys
import json
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, f"{ROOT}/results")
from bench import post, make_text

TARGET_FIT = 130800   # <= 131072 - npred(96..64) - margin
text = make_text(129000, 888111) + "\n\nQ: Summarize the topic of the text above in one sentence.\nA:"
for _ in range(40):
    body, _w = post("/tokenize", {"content": text})
    n = len(body["tokens"])
    if n <= TARGET_FIT:
        break
    # trim ~1.5% of words each pass until it fits
    words = text.split()
    keep = max(16, int(len(words) * (TARGET_FIT / n) * 0.99))
    text = " ".join(words[:keep])
body, _w = post("/tokenize", {"content": text})
print(json.dumps({"prompt_n": len(body["tokens"]), "chars": len(text)}))
with open(f"{ROOT}/experiments/phase2b/raw2/prompt_128k_fit.txt", "w") as f:
    f.write(text)
