#!/usr/bin/env python3
"""Phase-2 isolated benchmark window runner."""
import json, os, signal, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
import orchestrate
from orchestrate import BIN as PROD_BIN, COMMON, wait_health, post, metrics, make_text
from correctness_suite import full_gate

RES2 = str(ROOT / "results2")

def run_window(tag, binary=None, spec=True, do_63k=True, npred=(128,128,380),
               repeats=(4,3,3)):
    binary = binary or PROD_BIN
    args = [binary] + COMMON + (orchestrate.SPEC if spec else [])
    proc = subprocess.Popen(args, cwd=os.path.dirname(binary),
                            stdout=open(f"{RES2}/windows_{tag}.log","w"),
                            stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(600), f"{tag}: server failed"
    print(f"[{tag}] server up pid={proc.pid}", flush=True)
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
               "decode_tok_s": round(t["predicted_per_second"],3),
               "per_token_ms": t.get("predicted_per_token_ms"),
               "prefill_tok_s": round(t.get("prompt_per_second") or 0,2),
               "draft_n": t.get("draft_n"), "draft_acc": t.get("draft_n_accepted")}
        res["perf"].append(rec); print(json.dumps(rec), flush=True)
    # warmup
    bench(f"{tag}_warmup", "Warmup zeta.", 16, 1234, False)
    # correctness gate (greedy records + semantic)
    res["gate"] = full_gate(tag+"_g", do_63k=False)
    # perf: 1k
    for i in range(1, repeats[0]+1):
        bench(f"{tag}_1k_r{i}", p1k, npred[0], 5500+i, i>1)
    # perf: 16k
    for i in range(1, repeats[1]+1):
        bench(f"{tag}_16k_r{i}", p16, npred[1], 6600+i, i>1)
    # perf: 63k
    if do_63k:
        for i in range(1, repeats[2]+1):
            bench(f"{tag}_63k_r{i}", p63, npred[2], 99100+i, i>1)
    srv = subprocess.run(["pgrep","-f","llama-server"], capture_output=True, text=True).stdout.split()
    for pid in srv:
        try: os.kill(int(pid), signal.SIGINT)
        except ProcessLookupError: pass
    try: proc.wait(timeout=180)
    except subprocess.TimeoutExpired: os.killpg(proc.pid, signal.SIGKILL)
    with open(f"{RES2}/window_{tag}.json","w") as f: json.dump(res,f,indent=1)
    print(f"[{tag}] DONE", flush=True)

if __name__ == "__main__":
    tag = sys.argv[1]
    binary = None
    spec = "--off" not in sys.argv
    do63 = "--no63k" not in sys.argv
    for a in sys.argv[2:]:
        if a.startswith("--bin="): binary = a.split("=",1)[1]
    import orchestrate
    if "--fixshape" in sys.argv:
        orchestrate.SPEC = ["--spec-type","draft-mtp","--spec-draft-n-max","4",
                            "--spec-draft-n-min","4","--spec-draft-p-min","0"]
        from orchestrate import SPEC  # rebind name used in run_window
    run_window(tag, binary=binary, spec=spec, do_63k=do63)
