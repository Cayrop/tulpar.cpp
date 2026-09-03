#!/usr/bin/env python3
"""Orchestrator: restart llama-server under rocprofv3, run paired ON/OFF benchmarks."""
import json, os, signal, subprocess, sys, time, urllib.request

BASE = "http://localhost:8080"
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BIN = str(ROOT / "build/bin/llama-server")
MODEL = "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
RES = str(ROOT / "results")
COMMON = ["-m", MODEL, "--alias", "Qwen3.8-27b", "-c", "65536", "-ngl", "999",
          "--load-mode", "mmap", "-fa", "on", "-ctk", "q4_0", "-ctv", "q4_0",
          "--temp", "0.6", "--top-p", "0.95", "--top-k", "20", "--min-p", "0.0",
          "--cache-prompt", "--ctx-checkpoints", "4", "-t", "8", "-np", "1",
          "--host", "0.0.0.0", "--port", "8080", "--metrics"]
SPEC = ["--spec-type", "draft-mtp", "--spec-draft-n-max", "4", "--spec-draft-p-min", "0.8"]

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

def post(path, payload, timeout=3600):
    req = urllib.request.Request(BASE + path, data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read())

def metrics():
    out = {}
    with urllib.request.urlopen(BASE + "/metrics", timeout=10) as r:
        for line in r.read().decode().splitlines():
            if line.startswith("llamacpp:"):
                p = line.split()
                try: out[p[0].split(":", 1)[1].split("{")[0]] = float(p[1])
                except: pass
    return out

def make_text(n_target_tokens, seed):
    sys.path.insert(0, RES)
    from bench import make_text as mt
    return mt(n_target_tokens, seed)

def run_session(mode, tag_dir, log):
    """mode: 'off' or 'on'"""
    os.makedirs(f"{RES}/traces/{tag_dir}", exist_ok=True)
    args = [BIN] + COMMON + (SPEC if mode == "on" else [])
    cmd = ["rocprofv3", "-r", "-d", f"{RES}/traces/{tag_dir}", "-f", "csv", "--"] + args
    print(f"[{tag_dir}] launching: {' '.join(cmd)[:160]}...", flush=True)
    proc = subprocess.Popen(cmd, cwd=os.path.dirname(BIN),
                            stdout=open(f"{RES}/traces/{tag_dir}/rocprofv3_stdout.log", "w"),
                            stderr=subprocess.STDOUT,
                            preexec_fn=os.setsid)
    ok = wait_health()
    print(f"[{tag_dir}] health ok: {ok}, pid={proc.pid}", flush=True)
    if not ok:
        os.killpg(proc.pid, signal.SIGTERM); return []

    results = []
    def bench(exp, prompt, npred, seed, cache):
        mb = metrics()
        body = post("/completion", {"prompt": prompt, "n_predict": npred,
                                    "temperature": 0.6, "top_k": 20, "top_p": 0.95,
                                    "min_p": 0.0, "cache_prompt": cache,
                                    "ignore_eos": True, "seed": seed})
        ma = metrics()
        t = body["timings"]
        rec = {"exp_id": exp, "mode": mode,
               "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
               "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
               "decode_tok_s": t["predicted_per_second"], "prefill_tok_s": t.get("prompt_per_second"),
               "per_token_ms": t.get("predicted_per_token_ms"),
               "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted")}
        results.append(rec)
        print(json.dumps(rec), flush=True)

    p1k = make_text(960, seed=4201024)
    p63k = make_text(63500, seed=777001)
    n63 = len(post("/tokenize", {"content": p63k})["tokens"])
    print(f"[{tag_dir}] 63k prompt tokens={n63}", flush=True)

    # warmup both paths
    bench(f"{tag_dir}_warmup", "Warmup delta.", 16, 1234, False)
    # short context
    for i, cache in [(1, False), (2, True), (3, True)]:
        st = time.time(); bench(f"{tag_dir}_1k_run{i}", p1k, 128, 5500+i, cache)
    # long context
    for i, cache in [(1, False), (2, True)]:
        st = time.time(); print(f"[{tag_dir}] 63k run{i} starting", flush=True)
        bench(f"{tag_dir}_63k_run{i}", p63k, 380, 99100+i, cache)
    # graceful shutdown -> profiler flushes
    srv = subprocess.run(["pgrep", "-f", "llama-server.*8080"], capture_output=True, text=True).stdout.split()
    for pid in srv:
        os.kill(int(pid), signal.SIGINT)
    try:
        proc.wait(timeout=180)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
    print(f"[{tag_dir}] session complete", flush=True)
    return results

if __name__ == "__main__":
    mode = sys.argv[1]; tag = sys.argv[2]
    res = run_session(mode, tag, None)
    with open(f"{RES}/experiments/session_{tag}.json", "w") as f:
        json.dump(res, f, indent=1)
