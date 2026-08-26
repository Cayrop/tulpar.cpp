#!/usr/bin/env python3
"""B2: measure CUDA graph warmup-reset churn via GGML_LOG_DEBUG under -lv."""
import json, os, signal, subprocess, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from orchestrate import BIN as PROD_BIN, COMMON, wait_health, post, make_text

RES2 = str(ROOT / "results2")

def run(tag, spec_args):
    args = [PROD_BIN] + COMMON + spec_args + ["-lv", "5"]
    logf = f"{RES2}/b2_{tag}.log"
    proc = subprocess.Popen(args, cwd=os.path.dirname(PROD_BIN),
                            stdout=open(logf,"w"), stderr=subprocess.STDOUT,
                            preexec_fn=os.setsid)
    assert wait_health(600)
    print(f"[{tag}] up", flush=True)
    p16 = make_text(16320, seed=555001)
    post("/completion", {"prompt": "Warm.", "n_predict": 8, "cache_prompt": False})
    post("/completion", {"prompt": p16, "n_predict": 8, "cache_prompt": False})
    # mark position in log, then run pure decode rounds
    marker = f"===DECODE_START_{tag}==="
    with open(logf, "a") as f: f.write(marker+"\n")
    for i in range(6):
        post("/completion", {"prompt": p16, "n_predict": 96,
             "temperature": 0.6, "cache_prompt": True, "ignore_eos": True,
             "seed": 7700+i})
    srv = subprocess.run(["pgrep","-f","llama-server"], capture_output=True,text=True).stdout.split()
    for pid in srv:
        try: os.kill(int(pid), signal.SIGINT)
        except ProcessLookupError: pass
    try: proc.wait(timeout=180)
    except subprocess.TimeoutExpired: os.killpg(proc.pid, signal.SIGKILL)
    # analyze
    data = open(logf, errors="replace").read()
    seg = data[data.index(marker):]
    counts = {"warmup_complete": seg.count("CUDA graph warmup complete"),
              "warmup_reset": seg.count("CUDA graph warmup reset"),
              "graph_reused": seg.count("CUDA Graph id"),
              "capture_fail": seg.count("failed to capture")}
    print(f"[{tag}] {json.dumps(counts)}", flush=True)
    return counts

if __name__ == "__main__":
    tag = sys.argv[1]
    if tag == "base":
        c = run("b2_base", ["--spec-type","draft-mtp","--spec-draft-n-max","4","--spec-draft-p-min","0.8"])
    else:
        c = run("b2_fixshape", ["--spec-type","draft-mtp","--spec-draft-n-max","4",
                                "--spec-draft-n-min","4","--spec-draft-p-min","0"])
