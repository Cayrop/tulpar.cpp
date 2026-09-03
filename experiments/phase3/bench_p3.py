#!/usr/bin/env python3
"""Phase-3 benchmark: V2 model, build-p3 binary, MTP ON/OFF."""
import json, os, signal, subprocess, sys, time, urllib.request, random, statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BASE = "http://localhost:8080"

# ---- helpers -----------------------------------------------------------

def post(path, payload, timeout=3600):
    req = urllib.request.Request(BASE + path, data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read())

WORDS = ("the quick brown fox jumps over lazy dog while mountains echo silent rivers "
         "flow through ancient valleys where forgotten kings once ruled golden cities "
         "beneath starlit skies and wandering clouds drift across endless horizons "
         "carrying whispers of distant shores and timeless stories yet untold").split()

def make_text(n_target_tokens, seed, tokenizer_check=True):
    rng = random.Random(seed)
    words = [rng.choice(WORDS) for _ in range(int(n_target_tokens * 1.6))]
    text = " ".join(words)
    if not tokenizer_check:
        return text
    for _ in range(12):
        body = post("/tokenize", {"content": text})
        n = len(body["tokens"])
        if abs(n - n_target_tokens) <= max(8, int(n_target_tokens * 0.01)):
            break
        keep = max(8, int(len(words) * n_target_tokens / n))
        words = words[:keep]
        text = " ".join(words)
    return text

def wait_health(timeout=600):
    t0 = time.time()
    while time.time() - t0 < timeout:
        try:
            with urllib.request.urlopen(BASE + "/health", timeout=5) as r:
                if json.loads(r.read()).get("status") == "ok":
                    return True
        except Exception:
            pass
        time.sleep(3)
    return False

# ---- benchmark config --------------------------------------------------

RES = str(ROOT / "experiments/phase3/results")
BIN = str(ROOT / "build-p3/bin/llama-server")
MODEL = "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"

COMMON_ARGS = [
    "-m", MODEL, "--alias", "Qwen3.8-27b", "-c", "131072", "-ngl", "999",
    "--load-mode", "mmap", "-fa", "on", "-ctk", "q4_0", "-ctv", "q4_0",
    "--temp", "0.6", "--top-p", "0.95", "--top-k", "20", "--min-p", "0.0",
    "--cache-prompt", "--ctx-checkpoints", "4", "-t", "8", "-np", "1",
    "--host", "0.0.0.0", "--port", "8080", "--metrics",
    "--spec-type", "draft-mtp", "--spec-draft-n-max", "4", "--spec-draft-p-min", "0.8",
]

def main():
    tag = sys.argv[1]
    spec_on = "--off" not in sys.argv
    args = [BIN] + COMMON_ARGS
    if not spec_on:
        # Filter out only the spec args, not the value "4" that belongs to other args
        filtered = []
        skip_next = False
        for i, a in enumerate(args):
            if skip_next:
                skip_next = False
                continue
            if a == "--spec-type":
                skip_next = True  # skip "draft-mtp"
                continue
            if a == "--spec-draft-n-max":
                skip_next = True  # skip "4"
                continue
            if a == "--spec-draft-p-min":
                skip_next = True  # skip "0.8"
                continue
            filtered.append(a)
        args = [a for a in filtered if a != "draft-mtp"]
    os.makedirs(RES, exist_ok=True)
    logf = open(f"{RES}/bench_{tag}.log", "w")
    proc = subprocess.Popen(args, cwd=os.path.dirname(BIN),
                            stdout=logf, stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(900), f"{tag}: server failed"
    print(f"[{tag}] up pid={proc.pid} spec={spec_on}", flush=True)
    res = {"tag": tag, "spec": spec_on, "perf": []}
    p1k = make_text(960, seed=4201024)
    p16 = make_text(16320, seed=555001)
    p63 = make_text(63500, seed=777001)
    p128 = make_text(129400, seed=888111)

    def bench(exp, prompt, npred, seed, cache):
        body = post("/completion", {"prompt": prompt, "n_predict": npred,
                    "temperature": 0.6, "top_k": 20, "top_p": 0.95, "min_p": 0.0,
                    "cache_prompt": cache, "ignore_eos": True, "seed": seed})
        t = body["timings"]
        rec = {"exp_id": exp, "prompt_n": t.get("prompt_n"), "predicted_n": t.get("predicted_n"),
               "decode_tok_s": round(t["predicted_per_second"], 3),
               "per_token_ms": t.get("predicted_per_token_ms"),
               "prefill_tok_s": round(t.get("prompt_per_second") or 0, 2),
               "draft_n": t.get("draft_n"), "draft_acc": t.get("draft_n_accepted")}
        res["perf"].append(rec)
        print(json.dumps(rec), flush=True)

    bench(f"{tag}_warmup", "Warmup zeta.", 16, 1234, False)
    for i in range(1, 5):
        bench(f"{tag}_1k_r{i}", p1k, 128, 5500 + i, i > 1)
    for i in range(1, 4):
        bench(f"{tag}_16k_r{i}", p16, 128, 6600 + i, i > 1)
    for i in range(1, 4):
        bench(f"{tag}_63k_r{i}", p63, 380, 99100 + i, i > 1)
    # 128k fresh + cached
    # Only 131k fresh + cached
    bench(f"{tag}_131k_r1_fresh", p128, 96, 12345, False)
    bench(f"{tag}_131k_r2_cached", p128, 96, 55000, True)

    os.killpg(proc.pid, signal.SIGINT)
    try:
        proc.wait(timeout=120)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
    with open(f"{RES}/bench_{tag}.json", "w") as f:
        json.dump(res, f, indent=1)
    print(f"[{tag}] DONE", flush=True)

if __name__ == "__main__":
    main()