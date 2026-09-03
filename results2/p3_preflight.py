#!/usr/bin/env python3
"""P3 preflight validation window on rebased build: 16k + 128k perf + quality suite."""
import json, os, signal, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from orchestrate import BIN as PROD_BIN, wait_health, post
from bench import make_text

RES = str(ROOT / "results2/p3")
NEEDLE128 = "AMBER-KEY-7241"

def build_prompt128():
    filler = make_text(129400, seed=888111)
    half = len(filler)//2
    text = (filler[:half] + f" By the way, the magic word of this story is {NEEDLE128}. " +
            filler[half:] +
            "\n\nQ: What is the magic word of the story above? Answer with the magic word only.\nA:")
    return text

def main():
    binary = sys.argv[2]
    args = [binary]
    skip = False
    import orchestrate
    for a in orchestrate.COMMON:
        if skip:
            skip = False; continue
        if a == "-c":
            args += ["-c", "131072"]; skip = True; continue
        args.append(a)
    logf = open(f"{RES}/win_preflight.log", "w")
    proc = subprocess.Popen(args, cwd=os.path.dirname(binary),
                            stdout=logf, stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(900), "server failed"
    print(f"[preflight] up pid={proc.pid} bin={binary}", flush=True)
    res = {"tag": "preflight_rebased", "binary": binary, "perf": []}

    def bench(exp, prompt, npred, greedy, cache):
        payload = {"prompt": prompt, "n_predict": npred, "cache_prompt": cache,
                   "ignore_eos": True, "seed": 4242}
        if greedy:
            payload.update({"temperature": 0.0, "top_k": 1})
        else:
            payload.update({"temperature": 0.6, "top_k": 20, "top_p": 0.95, "min_p": 0.0})
        body = post("/completion", payload)
        t = body["timings"]
        rec = {"exp_id": exp, "prompt_n": t.get("prompt_n"),
               "decode_tok_s": round(t["predicted_per_second"], 3),
               "draft_acc": t.get("draft_n_accepted"), "draft_n": t.get("draft_n")}
        res["perf"].append(rec)
        print(json.dumps(rec), flush=True)
        return body

    p16 = make_text(16320, seed=555001)
    post("/completion", {"prompt": "Warmup zeta.", "n_predict": 8, "temperature": 0.6,
                         "top_k": 20, "cache_prompt": False, "ignore_eos": True, "seed": 1})
    for i in range(1, 4):
        bench(f"pf_16k_r{i}", p16, 128, False, i > 1)
    # 128k: fresh prefill + cached decode
    p128 = build_prompt128()
    b = bench("pf_128k_r1_fresh", p128, 96, True, False)
    res["needle128"] = NEEDLE128.lower() in b.get("content", "").lower()
    bench("pf_128k_r2_cached", p128, 96, True, True)

    os.killpg(proc.pid, signal.SIGINT)
    try:
        proc.wait(timeout=120)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
    with open(f"{RES}/window_preflight.json", "w") as f:
        json.dump(res, f, indent=1)
    print("[preflight] PERF DONE - starting suite needs server; exiting", flush=True)

if __name__ == "__main__":
    main()
