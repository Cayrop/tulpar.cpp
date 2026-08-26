#!/usr/bin/env python3
"""P3-H window runner: perf (1k/16k/63k) + quality suite + degen probe in one server window.
Usage: p3_window.py <tag> [--bin=PATH] [--off] [--no63k]
"""
import json, os, signal, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
import orchestrate
from orchestrate import BIN as PROD_BIN, wait_health, post
from correctness_suite import make_text  # noqa: F401 (via bench)
from bench import make_text
from p3_quality_suite import run_suite
from p3_degen_probe import main as degen_main

RES2 = str(ROOT / "results2")

def stop_server():
    out = subprocess.run(["pgrep", "-f", "llama-server"], capture_output=True, text=True).stdout.split()
    for pid in out:
        try:
            os.kill(int(pid), signal.SIGINT)
        except ProcessLookupError:
            pass

def main():
    tag = sys.argv[1]
    binary = PROD_BIN
    spec = "--off" not in sys.argv
    do63 = "--no63k" not in sys.argv
    for a in sys.argv[2:]:
        if a.startswith("--bin="):
            binary = a.split("=", 1)[1]
    args = [binary] + orchestrate.COMMON + (orchestrate.SPEC if spec else [])
    logf = open(f"{RES2}/p3/win_{tag}.log", "w")
    proc = subprocess.Popen(args, cwd=os.path.dirname(binary),
                            stdout=logf, stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(600), f"{tag}: server failed"
    print(f"[{tag}] up pid={proc.pid} bin={binary} spec={spec}", flush=True)
    res = {"tag": tag, "binary": binary, "spec": spec, "perf": []}
    p1k = make_text(960, seed=4201024)
    p16 = make_text(16320, seed=555001)
    p63 = make_text(63500, seed=777001)

    def bench(exp, prompt, np_, seed, cache):
        body = post("/completion", {"prompt": prompt, "n_predict": np_,
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
    # perf first (clean timing), then quality artifacts
    for i in range(1, 5):
        bench(f"{tag}_1k_r{i}", p1k, 128, 5500 + i, i > 1)
    for i in range(1, 4):
        bench(f"{tag}_16k_r{i}", p16, 128, 6600 + i, i > 1)
    if do63:
        for i in range(1, 4):
            bench(f"{tag}_63k_r{i}", p63, 380, 99100 + i, i > 1)
    # quality suite
    run_suite(tag, f"{RES2}/p3/suite_{tag}.json")
    # degen probe
    sys.argv = ["p3_degen_probe", tag, f"{RES2}/p3/degen_{tag}.json"]
    degen_main()
    stop_server()
    try:
        proc.wait(timeout=120)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
    with open(f"{RES2}/p3/window_{tag}.json", "w") as f:
        json.dump(res, f, indent=1)
    print(f"[{tag}] DONE", flush=True)

if __name__ == "__main__":
    main()
