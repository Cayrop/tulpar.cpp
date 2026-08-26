#!/usr/bin/env python3
# Single-pass untraced 128k runner using the saved fitting prompt.
# Correct swap accounting (used = column 3 of free -b).
import json
import sys
import time
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, f"{ROOT}/results")
sys.path.insert(0, f"{ROOT}/experiments/phase2b/bin")
sys.path.insert(0, f"{ROOT}/experiments/phase2b/bin_rerun")
from bench import post, metrics  # noqa: E402
from p2b_run import VramMonitor  # noqa: E402


def mem_snap():
    out = open("/proc/meminfo").read()
    mi = {}
    for line in out.splitlines():
        k, v = line.split(":")
        mi[k] = int(v.strip().split()[0]) * 1024
    sw_t = int(open("/proc/swaps").readlines()[2].split()[3]) * 1024 if len(open("/proc/swaps").readlines()) > 2 else 0
    return {"mem_avail_b": mi["MemAvailable"], "swap_total_b": mi["SwapTotal"], "swap_used_b": mi["SwapTotal"] - mi["SwapFree"]}


prompt = open(f"{ROOT}/experiments/phase2b/raw2/prompt_128k_fit.txt").read()
outdir = f"{ROOT}/experiments/phase2b/raw2/R_U-off-128k"
rec = {"arm_id": "R_U-off-128k", "mode": "untraced", "mtp": "off",
       "binary": f"{ROOT}/build-p3/bin/llama-server", "ctx_size": 131072,
       "sampling": {"temperature": 0.0, "top_k": 1, "seed": 1234},
       "prompt_source": "raw2/prompt_128k_fit.txt", "reps_planned": 1,
       "started_ts": time.strftime("%F %T")}
mon = VramMonitor()
mon.start()
payload = {"prompt": prompt, "n_predict": 96, "temperature": 0.0, "top_k": 1,
           "cache_prompt": False, "ignore_eos": True, "stream": False, "seed": 1234}
t0 = time.perf_counter()
body, _ = post("/completion", payload, timeout=7200)
wall = round(time.perf_counter() - t0, 3)
mon.halt()
t = body.get("timings", {})
rep = {"rep": 1, "cache_prompt": False, "wall_s": wall,
       "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
       "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
       "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2),
       "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3)}
rec["vram_peak_b"] = mon.peak
rec["mem_after"] = mem_snap()
rec["status"] = "OK"
rec["reps"] = [rep]
rec["finished_ts"] = time.strftime("%F %T")
with open(f"{outdir}/arm_record.json", "w") as f:
    json.dump(rec, f, indent=1)
with open(f"{outdir}/resp_r1.json", "w") as f:
    json.dump({"wall_s": wall, "body": body}, f, indent=1)
print(json.dumps(rep), flush=True)
print("ARM_DONE " + json.dumps({"tg_tok_s_median": rep["tg_tok_s"]}), flush=True)
