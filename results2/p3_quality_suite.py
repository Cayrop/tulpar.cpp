#!/usr/bin/env python3
"""P3-C: compact quality/regression suite for VEC-vs-TILE FA dispatch changes.
All deterministic gens run with cache_prompt=False to remove cache-state dependence.
Usage: p3_quality_suite.py <tag> <outjson>
"""
import json, re, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from bench import make_text, post
from correctness_suite import gen, build_needle_prompt, NEEDLE
from p3_degen_probe import degen_metrics

def common_prefix(a, b):
    i = 0
    while i < min(len(a), len(b)) and a[i] == b[i]:
        i += 1
    return i

def run_suite(tag, outj):
    out = {"tag": tag, "ts": time.strftime("%F %T"), "tests": [], "sampled": []}
    def rec(name, r, purpose, check, note=""):
        m = degen_metrics(r["text"])
        out["tests"].append({"test": name, "purpose": purpose, "check": check,
                             "pass": bool(check["ok"]), "text": r["text"],
                             "tok_s": r["tok_s"], "prompt_n": r["prompt_n"],
                             "metrics": m, "note": note})
        return bool(check["ok"])

    # 1 factual EN
    r = gen("Q: What is the capital of France? Answer with the city name only.\nA:", 48)
    rec("factual_en", r, "short factual coherence", {"ok": "Paris" in r["text"], "expect": "Paris"})
    # 2 simple arithmetic
    r = gen("Q: What is 17 * 23? Answer with the number only.\nA:", 48)
    rec("arith_simple", r, "simple arithmetic", {"ok": "391" in r["text"], "expect": "391"})
    # 3 multi-step arithmetic (known baseline quirk: says 40; gate = matches quirk, not ideal answer)
    r = gen("Q: A train travels 60 km in 45 minutes. What is its average speed in km/h? Answer with the number only.\nA:", 64)
    ok = ("40" in r["text"][:20]) or ("80" in r["text"][:20])
    rec("arith_multistep", r, "multi-step arithmetic; baseline answers 40 (known quirk)",
        {"ok": ok, "expect": "80 ideally, 40 matches baseline quirk"})
    # 4 puzzle
    r = gen("Q: A farmer has 17 sheep. All but 9 run away. How many sheep does he have left? Answer with the number only.\nA:", 64)
    rec("puzzle", r, "trick reasoning", {"ok": "9" in r["text"][:12], "expect": "9"})
    # 5 code function
    r = gen("Write a Python function named reverse_string that takes s and returns s reversed.", 96)
    rec("code_func", r, "code generation",
        {"ok": "def reverse_string" in r["text"] and "s[::-1]" in r["text"], "expect": "def reverse_string + slice"})
    # 6 code one-liner
    r = gen("Write a Python one-liner that computes the sum of squares of numbers 1 to 10. Use sum().", 96)
    rec("code_oneliner", r, "code generation", {"ok": "sum(" in r["text"], "expect": "sum("})
    # 7 Turkish
    r = gen("Soru: Türkiye'nin başkenti hangisidir? Yalnızca şehir adını yaz.\nCevap:", 48)
    rec("turkish", r, "non-English coherence", {"ok": "Ankara" in r["text"], "expect": "Ankara"})
    # 8 structured listing (loop detector)
    r = gen("List the numbers from 1 to 20 separated by commas. Do not skip any number.", 160)
    nums = [int(x) for x in re.findall(r"\d+", r["text"])]
    ordered = nums[:20] == list(range(1, 21))
    rec("list_struct", r, "structured output; breaks under repetition loops",
        {"ok": ordered, "expect": "first 20 numbers are 1..20 in order", "found": nums[:25]})
    # 9 long-context single needle (~24.8k tokens), fresh prefill
    p16 = build_needle_prompt(16000)
    n16 = len(post("/tokenize", {"content": p16})[0]["tokens"])
    r = gen(p16, 192)
    rec("needle16k_single", r, "long-context retrieval",
        {"ok": NEEDLE.lower() in r["text"].lower(), "expect": NEEDLE})
    out["prompt16_n"] = n16
    # 10 multi-needle at two depths
    nd1, nd2 = "RED-LANTERN-41", "BLUE-FALCON-87"
    filler = make_text(24000, seed=90210)
    third = len(filler)//3
    pmulti = (filler[:third] + f" Keep this code in mind: {nd1}. " +
              filler[third:2*third] + f" Also remember this code: {nd2}. " +
              filler[2*third:] +
              "\n\nQ: What are the two codes mentioned in the story? Answer with both codes.\nA:")
    npm = len(post("/tokenize", {"content": pmulti})[0]["tokens"])
    r = gen(pmulti, 256)
    both = nd1.lower() in r["text"].lower() and nd2.lower() in r["text"].lower()
    rec("needle_multi", r, "two needles at 33%/66% depth",
        {"ok": both, "expect": [nd1, nd2]})
    out["prompt_multi_n"] = npm
    # 11 long open-ended generation + degeneration thresholds
    r = gen("Write a short story about a lighthouse keeper.", 320)
    m = degen_metrics(r["text"])
    ok = m["bigram_rep_rate"] < 0.5 and m["last50_uniq"] >= 15 and m["uniq_ratio"] > 0.3
    rec("longgen_story", r, "open-ended generation; degeneration thresholds",
        {"ok": ok, "thresholds": "bigram_rep<0.5, last50_uniq>=15, uniq>0.3"})
    # 12 recovered regression case: random-word prompt, EXPECTED degenerate loop
    p1k = make_text(960, seed=4242)
    r = gen(p1k, 96)
    ref_head = " and where and where and where and where and where and where"
    rec("degen_trap_p1k", r,
        "KNOWN baseline degeneration on random-word prompt under greedy; must be unchanged",
        {"ok": r["text"].startswith(ref_head), "expect": ref_head[:40]})

    # sampled sanity: 3 prompts x 3 seeds, temp 0.7 top_k 40
    for name, pr in [("turkish", "Soru: Türkiye'nin başkenti hangisidir? Yalnızca şehir adını yaz.\nCevap:"),
                     ("story", "Write a short story about a lighthouse keeper."),
                     ("arith", "Q: A train travels 60 km in 45 minutes. What is its average speed in km/h?\nA:")]:
        for seed in (7, 77, 777):
            r = gen(pr, 96, greedy=False, seed=seed)
            m = degen_metrics(r["text"])
            hit = m["bigram_rep_rate"] < 0.5 and len(r["text"].strip()) > 20
            out["sampled"].append({"test": name, "seed": seed, "pass": bool(hit),
                                   "bigram_rep": m["bigram_rep_rate"],
                                   "last50_uniq": m["last50_uniq"], "head": r["text"][:60]})

    out["summary"] = {
        "det_pass": sum(1 for t in out["tests"] if t["pass"]),
        "det_total": len(out["tests"]),
        "samp_pass": sum(1 for s in out["sampled"] if s["pass"]),
        "samp_total": len(out["sampled"]),
    }
    json.dump(out, open(outj, "w"), indent=1)
    print(json.dumps(out["summary"], indent=1))
    for t in out["tests"]:
        print(f"  {t['test']:18s} {'PASS' if t['pass'] else 'FAIL'}")

if __name__ == "__main__":
    run_suite(sys.argv[1], sys.argv[2])
