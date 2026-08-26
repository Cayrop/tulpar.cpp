#!/usr/bin/env python3
"""C-test: f16 KV vs q4_0 KV isolation at 16k context, MTP OFF."""
import json, os, signal, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from orchestrate import BIN as PROD_BIN, wait_health, post, make_text

RES2 = str(ROOT / "results2")

def run(tag, kv_type="f16", binary=None):
    binary = binary or PROD_BIN
    args = [binary, "-m", "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf",
            "--alias", "Qwen3.8-27b", "-c", "24576", "-ngl", "999", "--load-mode", "mmap",
            "-fa", "on", "-ctk", kv_type, "-ctv", kv_type,
            "--cache-prompt", "--ctx-checkpoints", "4", "-t", "8", "-np", "1",
            "--host", "0.0.0.0", "--port", "8080", "--metrics"]
    proc = subprocess.Popen(args, cwd=os.path.dirname(binary),
                            stdout=open(f"{RES2}/ctest_{tag}.log","w"),
                            stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(600)
    res = {"tag": tag, "kv": kv_type, "perf": []}
    p16 = make_text(16320, seed=555001)
    def bench(exp, prompt, np_, seed, cache):
        body = post("/completion", {"prompt": prompt, "n_predict": np_,
                    "temperature": 0.6, "top_k": 20, "top_p": 0.95, "min_p": 0.0,
                    "cache_prompt": cache, "ignore_eos": True, "seed": seed})
        t = body["timings"]
        rec = {"exp_id": exp, "decode_tok_s": round(t["predicted_per_second"],3),
               "per_token_ms": t.get("predicted_per_token_ms")}
        res["perf"].append(rec); print(json.dumps(rec), flush=True)
    bench(f"{tag}_warmup", "Warmup eta.", 16, 1234, False)
    for i in range(1, 5):
        bench(f"{tag}_16k_r{i}", p16, 128, 6600+i, i>1)
    srv = subprocess.run(["pgrep","-f","llama-server"], capture_output=True, text=True).stdout.split()
    for pid in srv:
        try: os.kill(int(pid), signal.SIGINT)
        except ProcessLookupError: pass
    try: proc.wait(timeout=180)
    except subprocess.TimeoutExpired: os.killpg(proc.pid, signal.SIGKILL)
    return res

if __name__ == "__main__":
    tag = sys.argv[1]; kv = sys.argv[2] if len(sys.argv)>2 else "f16"
    res = run(tag, kv)
    json.dump(res, open(f"{RES2}/ctest_{tag}.json","w"), indent=1)
