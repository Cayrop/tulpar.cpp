#!/usr/bin/env python3
"""P3-B: degeneration reproduction probe. Usage: degen_probe.py <tag> <outjson>"""
import json, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from bench import make_text, post
from correctness_suite import gen, build_needle_prompt

def degen_metrics(text):
    words = text.split()
    n = len(words)
    if n == 0:
        return {"n_words": 0}
    uniq = len(set(words))
    # max consecutive repeat of any single word
    max_run = cur = 1
    for i in range(1, n):
        cur = cur + 1 if words[i] == words[i-1] else 1
        max_run = max(max_run, cur)
    # repeated bigram/trigram rates (non-overlapping occurrences beyond first)
    def rep_rate(k):
        grams = [tuple(words[i:i+k]) for i in range(n-k+1)]
        return round(1 - len(set(grams)) / len(grams), 4) if grams else 0.0
    # longest repeated word n-gram (up to 12)
    longest = 0
    for k in range(1, min(13, n//2 + 1)):
        seen = {}
        for i in range(n - k + 1):
            g = tuple(words[i:i+k])
            if g in seen:
                longest = max(longest, k)
            seen.setdefault(g, i)
    last50 = words[-50:]
    return {"n_words": n, "uniq_ratio": round(uniq/n, 4),
            "max_consec_repeat": max_run,
            "bigram_rep_rate": rep_rate(2), "trigram_rep_rate": rep_rate(3),
            "longest_repeated_ngram": longest,
            "last50_uniq": len(set(last50))}

def main():
    tag, outj = sys.argv[1], sys.argv[2]
    out = {"tag": tag, "ts": time.strftime("%F %T")}
    p1k = make_text(960, seed=4242)          # exact full_gate prompt
    runs = []
    for i in range(5):
        r = gen(p1k, 96, cache=(i % 2 == 1))  # alternate fresh/cached paths
        runs.append({"i": i, "cache": i % 2 == 1, "text": r["text"],
                     "tok_s": r["tok_s"], "prompt_n": r["prompt_n"],
                     "metrics": degen_metrics(r["text"])})
    out["p1k_seed4242_x5"] = runs
    out["all_identical"] = all(r["text"] == runs[0]["text"] for r in runs)
    # seed 4201024 variant (the phase-2 anomaly prompt)
    pa = make_text(960, seed=4201024)
    ra = gen(pa, 96)
    out["p1k_seed4201024"] = {"text": ra["text"], "metrics": degen_metrics(ra["text"])}
    # longer horizon on the trap prompt: does the loop persist/break?
    rl = gen(p1k, 384)
    out["p1k_seed4242_n384"] = {"text_head": rl["text"][:160],
                                "text_tail": rl["text"][-160:],
                                "metrics": degen_metrics(rl["text"])}
    # non-trap control: natural prompt, greedy 96
    rc = gen("Write a short story about a lighthouse keeper.", 96)
    out["control_story_greedy"] = {"text_head": rc["text"][:120],
                                   "metrics": degen_metrics(rc["text"])}
    json.dump(out, open(outj, "w"), indent=1)
    print(json.dumps({"tag": tag, "all_x5_identical": out["all_identical"],
                      "x5_head": runs[0]["text"][:80],
                      "seed4201024_head": out["p1k_seed4201024"]["text"][:80],
                      "n384_maxrun": out["p1k_seed4242_n384"]["metrics"]["max_consec_repeat"],
                      "control_maxrun": out["control_story_greedy"]["metrics"]["max_consec_repeat"]}, indent=1))

if __name__ == "__main__":
    main()
