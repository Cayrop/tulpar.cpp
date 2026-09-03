#!/usr/bin/env python3
# EXP-002 V2-specific quality probes: SVG generation + multi-step reasoning.
# Greedy deterministic; run against whichever server is on :8080.
# Config label expected as argv[1]; outfile argv[2].
import json
import sys
import time
import xml.etree.ElementTree as ET

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from bench import post
from p3_degen_probe import degen_metrics

CFG = sys.argv[1]
OUT = sys.argv[2]

RED_MARKERS = ('fill="red"', "fill='red'", "#ff0000", "#f00", "rgb(255", "red")

def gen(prompt, n_predict):
    payload = {"prompt": prompt, "n_predict": n_predict, "temperature": 0.0,
               "top_k": 1, "seed": 1234, "stream": False, "cache_prompt": False,
               "ignore_eos": True}
    body, wall = post("/completion", payload)
    t = body["timings"]
    return {"text": body.get("content") or "", "tok_s": t.get("predicted_per_second"),
            "prompt_n": t.get("prompt_n"), "predicted_n": t.get("predicted_n")}

def svg_checks(text):
    low = text.lower()
    c = {
        "has_svg_open": "<svg" in low,
        "has_svg_close": "</svg>" in low,
        "has_circle": "<circle" in low,
        "red_marker": any(m in low for m in RED_MARKERS),
        "xml_well_formed": None,
    }
    if c["has_svg_open"]:
        seg = text[text.lower().index("<svg"):]
        if "</svg>" in seg.lower():
            seg = seg[:seg.lower().index("</svg>") + 6]
        try:
            ET.fromstring(seg)
            c["xml_well_formed"] = True
        except Exception as e:
            c["xml_well_formed"] = False
            c["xml_error"] = str(e)[:120]
    return c

tests = []

# 1) SVG generation
r = gen("Create SVG code for a simple red circle", 256)
tests.append({"test": "svg_red_circle", "prompt": "Create SVG code for a simple red circle",
              **r, "checks": svg_checks(r["text"]), "degen": degen_metrics(r["text"])})

# 2) reasoning depth: classic CRT (correct ball price 0.05)
r = gen("Q: A bat and a ball cost $1.10 in total. The bat costs $1.00 more than the "
        "ball. How much does the ball cost? Think step by step, then give the final "
        "answer as a number in dollars.\nA:", 384)
low = r["text"].lower()
ans_ok = ("0.05" in low) and ("$0.10" not in low.split("final")[0][:40] if "final" in low else True)
tests.append({"test": "reasoning_crt_bat_ball", "expect": "0.05",
              "pass_expected": ans_ok, **r})

# 3) reasoning depth: multi-step rate problem (80 vs 100 -> difference 20)
r = gen("Q: A train travels 60 km in 45 minutes. A car travels the same distance in "
        "36 minutes. By how many km/h is the car faster than the train? Think step "
        "by step and end with 'Answer: N'.\nA:", 384)
tests.append({"test": "reasoning_rate_diff", "expect": "20",
              "pass_expected": "20" in r["text"].lower(), **r})

out = {"tag": f"v2_quality_{CFG}", "ts": time.strftime("%F %T"), "mtp": CFG,
       "server_base": "http://localhost:8080", "tests": tests}
json.dump(out, open(OUT, "w"), indent=1)
summary = {}
for t in tests:
    if t["test"] == "svg_red_circle":
        summary[t["test"]] = t["checks"]
    else:
        summary[t["test"]] = {"pass_expected": t["pass_expected"],
                              "len_chars": len(t["text"])}
print(json.dumps(summary, indent=1))
