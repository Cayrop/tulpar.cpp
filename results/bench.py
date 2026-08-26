#!/usr/bin/env python3
"""Controlled benchmark harness for llama-server performance investigation."""
import json, time, urllib.request, urllib.error, sys, os, random, statistics, argparse

BASE = "http://localhost:8080"
OUTDIR = os.path.join(os.path.dirname(__file__), "..", "experiments")

def post(path, payload, timeout=3600):
    req = urllib.request.Request(BASE + path, data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json"})
    t0 = time.perf_counter()
    with urllib.request.urlopen(req, timeout=timeout) as r:
        body = json.loads(r.read())
    wall = time.perf_counter() - t0
    return body, wall

def get(path):
    with urllib.request.urlopen(BASE + path, timeout=30) as r:
        return json.loads(r.read())

def metrics():
    out = {}
    with urllib.request.urlopen(BASE + "/metrics", timeout=10) as r:
        for line in r.read().decode().splitlines():
            if line.startswith("llamacpp:"):
                parts = line.split()
                key = parts[0].split(":", 1)[1].split("{")[0]
                try: out[key] = float(parts[1])
                except: pass
    return out

WORDS = ("the quick brown fox jumps over lazy dog while mountains echo silent rivers "
         "flow through ancient valleys where forgotten kings once ruled golden cities "
         "beneath starlit skies and wandering clouds drift across endless horizons "
         "carrying whispers of distant shores and timeless stories yet untold").split()

def make_text(n_target_tokens, seed, tokenizer_check=True):
    """Generate text; verify token count via /tokenize; adjust."""
    rng = random.Random(seed)
    words = [rng.choice(WORDS) for _ in range(int(n_target_tokens * 1.6))]
    text = " ".join(words)
    if not tokenizer_check:
        return text
    for _ in range(12):
        body, _ = post("/tokenize", {"content": text})
        n = len(body["tokens"])
        if abs(n - n_target_tokens) <= max(8, int(n_target_tokens * 0.01)):
            break
        keep = max(8, int(len(words) * n_target_tokens / n))
        words = words[:keep]
        text = " ".join(words)
    return text

def run_one(prompt, n_predict, spec_type=None, seed=None, cache_prompt=False,
            ignore_eos=True, tag=""):
    payload = {
        "prompt": prompt, "n_predict": n_predict, "temperature": 0.6,
        "top_k": 20, "top_p": 0.95, "min_p": 0.0, "cache_prompt": cache_prompt,
        "ignore_eos": ignore_eos, "stream": False, "seed": seed,
    }
    if spec_type is not None:
        payload["speculative.type"] = spec_type
    body, wall = post("/completion", payload)
    t = body.get("timings", {})
    rec = {
        "tag": tag,
        "wall_s": round(wall, 3),
        "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
        "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
        "prefill_tok_s": (t.get("prompt_n") / t["prompt_ms"] * 1000) if t.get("prompt_ms") else None,
        "decode_tok_s": (t.get("predicted_n") / t["predicted_ms"] * 1000) if t.get("predicted_ms") else None,
        "e2e_tok_s": (t.get("predicted_n") / wall) if wall else None,
        "tokens_predicted_field": body.get("tokens_predicted"),
        "stop_reason": body.get("stop_reason"),
        "truncated": body.get("truncated"),
    }
    return rec

def summarize(recs):
    def stat(key):
        vals = [r[key] for r in recs if r.get(key) is not None]
        if not vals: return {}
        return {"n": len(vals), "mean": round(statistics.mean(vals),3),
                "median": round(statistics.median(vals),3),
                "min": round(min(vals),3), "max": round(max(vals),3),
                "stdev": round(statistics.stdev(vals),4) if len(vals)>1 else 0}
    return {"decode": stat("decode_tok_s"), "prefill": stat("prefill_tok_s"),
            "e2e": stat("e2e_tok_s")}

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--smoke", action="store_true")
    args = ap.parse_args()
    if args.smoke:
        print(json.dumps(run_one("Hello, explain GPU memory bandwidth in one paragraph.", 16), indent=1))
