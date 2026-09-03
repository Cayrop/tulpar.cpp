#!/usr/bin/env python3
"""Correctness/quality gate harness: deterministic greedy generation + semantic suite."""
import json, os, sys, time, urllib.request

BASE = "http://localhost:8080"
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RES2 = str(ROOT / "results2")
sys.path.insert(0, str(ROOT / "results"))
from bench import make_text, post  # reuse text generator + poster

def gen(prompt, n_predict, greedy=True, seed=1234, cache=False):
    payload = {"prompt": prompt, "n_predict": n_predict, "cache_prompt": cache,
               "ignore_eos": True, "seed": seed, "stream": False,
               "top_k": 1 if greedy else 40}
    if greedy:
        payload["temperature"] = 0.0
    body, wall = post("/completion", payload)
    t = body["timings"]
    return {"text": body.get("content",""),
            "tokens": body.get("tokens",[]),
            "tok_s": t.get("predicted_per_second"),
            "per_token_ms": t.get("predicted_per_token_ms"),
            "draft_n": t.get("draft_n"), "draft_acc": t.get("draft_n_accepted"),
            "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
            "wall_s": round(wall,2)}

def tok_seq(r):
    t = r.get("tokens")
    if t and isinstance(t[0], (int,)):
        return t
    return None  # strings -> compare text instead

def compare_tokens(a, b):
    """Return divergence stats between two generation records."""
    ta, tb = tok_seq(a), tok_seq(b)
    if ta is None or tb is None or not ta or not tb:
        # text-level fallback: common prefix in tokens via re-tokenize not available; use char prefix
        ca, cb = a["text"], b["text"]
        i = 0
        while i < min(len(ca), len(cb)) and ca[i] == cb[i]:
            i += 1
        return {"mode": "text-prefix", "match_chars": i, "len_a": len(ca), "len_b": len(cb),
                "identical": ca == cb}
    n = min(len(ta), len(tb))
    div = next((i for i in range(n) if ta[i] != tb[i]), None)
    match = sum(1 for i in range(n) if ta[i] == tb[i])
    return {"mode": "token-ids", "n": n, "match": match,
            "top1_match_rate": round(match / n, 4) if n else None,
            "first_divergence": div, "identical": ta == tb}

SMOKE = [
    ("math", "Q: What is 17 * 23? Answer with the number only.\nA:", ["391"]),
    ("math2", "Q: A train travels 60 km in 45 minutes. What is its average speed in km/h? Answer with the number only.\nA:", ["80"]),
    ("puzzle", "Q: A farmer has 17 sheep. All but 9 run away. How many sheep does he have left? Answer with the number only.\nA:", ["9"]),
    ("factual", "Q: What is the capital of France? Answer with the city name only.\nA:", ["Paris"]),
    ("code", "Write a Python function named reverse_string that takes s and returns s reversed.", ["def reverse_string"]),
    ("code2", "Write a Python one-liner that computes the sum of squares of numbers 1 to 10. Use sum().", ["sum("]),
]

def semantic_suite(needles_ctx=None):
    """Run smoke tests; needles_ctx = (prompt_with_needle, expected_code)."""
    results = []
    for name, prompt, expects in SMOKE:
        r = gen(prompt, 48)
        ok = any(e.lower() in r["text"].lower() for e in expects)
        results.append({"test": name, "pass": ok, "expect": expects,
                        "out_head": r["text"][:80].replace("\n"," ")})
    if needles_ctx:
        p, code = needles_ctx
        r = gen(p, 24)
        ok = code.lower() in r["text"].lower()
        results.append({"test": "longctx_recall", "pass": ok, "expect": [code],
                        "out_head": r["text"][:80].replace("\n"," ")})
    return results

NEEDLE = "SILVER-COMPASS-93"

def build_needle_prompt(n_tokens=16000, needle=NEEDLE):
    """16k context with planted magic word at ~50% depth, question appended."""
    filler = make_text(int(n_tokens*1.55), seed=31337)
    half = len(filler)//2
    text = (filler[:half] +
            " By the way, the magic word of this story is " + needle + ". " +
            filler[half:] +
            "\n\nQ: What is the magic word of the story above? Answer with the magic word only.\nA:")
    return text

def full_gate(tag, ctxs=(1024, 16384), do_63k=False, seed_base=4242):
    """Full correctness gate for current server. Returns dict."""
    out = {"tag": tag, "ts": time.strftime("%F %T")}
    # 1) determinism: same prompt twice (greedy, OFF or ON as server is)
    p1k = make_text(960, seed=seed_base)
    g1 = gen(p1k, 96)
    g2 = gen(p1k, 96, cache=True)
    out["determinism_self"] = compare_tokens(g1, g2)
    # 2) semantic suite at 1k
    out["semantic_1k"] = semantic_suite()
    # 3) medium context correctness (16k needle) + greedy record
    p16 = build_needle_prompt(16000)
    body, _ = post("/tokenize", {"content": p16})
    n16 = len(body["tokens"])
    g16 = gen(p16, 64)
    out["semantic_16k"] = semantic_suite(needles_ctx=None)
    # follow-up includes full context (cache hit makes it cheap) so model sees the needle
    r16 = gen(p16, 192, cache=True)
    out["needle_16k"] = {"pass": NEEDLE.lower() in r16["text"].lower(),
                          "out": r16["text"][:60]}
    out["gen_16k"] = g16
    out["prompt16_n"] = n16
    # 4) store 1k greedy record for cross-variant comparison
    out["gen_1k"] = g1
    # 5) optional 63k
    if do_63k:
        p63 = make_text(63500, seed=777001)
        g63 = gen(p63, 96)
        out["gen_63k"] = g63
    return out

if __name__ == "__main__":
    tag = sys.argv[1] if len(sys.argv) > 1 else "run"
    do63 = "--63k" in sys.argv
    res = full_gate(tag, do_63k=do63)
    os.makedirs(f"{RES2}/correctness", exist_ok=True)
    with open(f"{RES2}/correctness/{tag}.json", "w") as f:
        json.dump(res, f, indent=1)
    print(json.dumps({"tag": tag,
                      "det_self": res["determinism_self"],
                      "smoke_pass": sum(1 for x in res["semantic_1k"] if x["pass"]),
                      "smoke_total": len(res["semantic_1k"]),
                      "needle16k": res["needle_16k"],
                      "tok_s_1k": res["gen_1k"]["tok_s"],
                      "tok_s_16k": res["gen_16k"]["tok_s"]}, indent=1))
