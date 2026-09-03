#!/usr/bin/env python3
"""Optimization experiments: fixed-shape MTP variants vs baseline."""
import json, os, signal, subprocess, sys, time, urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
from orchestrate import BASE, BIN, MODEL, COMMON, wait_health, post, metrics, make_text

RES = str(ROOT / "results")

def run_variant(tag, spec_args, npred_short=128):
    os.makedirs(f"{RES}/traces/{tag}", exist_ok=True)
    args = [BIN] + COMMON + spec_args
    cmd = ["rocprofv3", "-r", "-d", f"{RES}/traces/{tag}", "-f", "csv", "--"] + args
    print(f"[{tag}] launching", flush=True)
    proc = subprocess.Popen(cmd, cwd=os.path.dirname(BIN),
                            stdout=open(f"{RES}/traces/{tag}/stdout.log", "w"),
                            stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(), f"{tag}: server failed"
    results = []
    def bench(exp, prompt, npred, seed, cache):
        body = post("/completion", {"prompt": prompt, "n_predict": npred,
                                    "temperature": 0.6, "top_k": 20, "top_p": 0.95,
                                    "min_p": 0.0, "cache_prompt": cache,
                                    "ignore_eos": True, "seed": seed})
        t = body["timings"]
        rec = {"exp_id": exp, "variant": tag,
               "prompt_n": t.get("prompt_n"), "predicted_n": t.get("predicted_n"),
               "decode_tok_s": t["predicted_per_second"],
               "per_token_ms": t.get("predicted_per_token_ms"),
               "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted")}
        results.append(rec); print(json.dumps(rec), flush=True)
    p1k = make_text(960, seed=4201024)
    p63k = make_text(63500, seed=777001)
    bench(f"{tag}_warmup", "Warmup eps.", 16, 1234, False)
    for i, cache in [(1, False), (2, True), (3, True)]:
        bench(f"{tag}_1k_run{i}", p1k, npred_short, 5500+i, cache)
    for i, cache in [(1, False), (2, True)]:
        print(f"[{tag}] 63k run{i}", flush=True)
        bench(f"{tag}_63k_run{i}", p63k, 380, 99100+i, cache)
    srv = subprocess.run(["pgrep", "-f", "llama-server.*8080"], capture_output=True, text=True).stdout.split()
    for pid in srv: os.kill(int(pid), signal.SIGINT)
    try: proc.wait(timeout=180)
    except subprocess.TimeoutExpired: os.killpg(proc.pid, signal.SIGKILL)
    return results

if __name__ == "__main__":
    which = sys.argv[1]
    if which == "fixshape":
        spec = ["--spec-type", "draft-mtp", "--spec-draft-n-max", "4",
                "--spec-draft-n-min", "4", "--spec-draft-p-min", "0"]
    elif which == "nmax1":
        spec = ["--spec-type", "draft-mtp", "--spec-draft-n-max", "1",
                "--spec-draft-n-min", "1", "--spec-draft-p-min", "0"]
    else:
        raise SystemExit("unknown")
    res = run_variant(f"X_{which}", spec)
    with open(f"{RES}/experiments/opt_{which}.json", "w") as f:
        json.dump(res, f, indent=1)
