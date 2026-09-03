#!/usr/bin/env python3
# Phase-2B re-run driver for TRACED arms against an already-running
# rocprofv3-wrapped server. Two requests per instance:
#   rep1: cache_prompt=false n_predict=1   -> clean prefill-phase trace
#   rep2: cache_prompt=true  n_predict=N   -> decode-phase trace (cached prompt)
# Records raw artifacts + VRAM monitor samples under --outdir.
import argparse
import json
import os
import re
import subprocess
import sys
import threading
import time

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
P2B = f"{ROOT}/experiments/phase2b"
sys.path.insert(0, f"{ROOT}/results")
sys.path.insert(0, f"{P2B}/bin")
from bench import post, metrics  # noqa: E402
from p2b_run import build_prompt, mem_snapshot, VramMonitor, health_ok  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arm", required=True)
    ap.add_argument("--prompt-tokens", type=int, required=True)
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--npred-probe", type=int, default=1)
    ap.add_argument("--npred-main", type=int, default=40)
    ap.add_argument("--outdir", required=True)
    args = ap.parse_args()
    outdir = args.outdir
    os.makedirs(outdir, exist_ok=True)

    prompt_text, prompt_n = build_prompt(args.prompt_tokens, args.seed)
    rec = {
        "arm_id": args.arm, "mode": "traced", "mtp": "off",
        "binary": f"{ROOT}/build-p3/bin/llama-server",
        "cache_k": "q4_0", "cache_v": "q4_0", "ctx_size": 131072,
        "sampling": {"temperature": 0.0, "top_k": 1, "seed": 1234, "greedy": True},
        "prompt_seed": args.seed, "prompt_n": prompt_n,
        "npred_probe": args.npred_probe, "npred_main": args.npred_main,
        "started_ts": time.strftime("%F %T"),
    }
    with open(f"{outdir}/arm_record.json", "w") as f:
        json.dump(rec, f, indent=1)

    mem_before = mem_snapshot()
    rec["mem_before"] = mem_before
    rec["gpu_vram_before_b"] = subprocess.run(
        ["rocm-smi", "--showmeminfo", "vram"], capture_output=True, text=True
    ).stdout[-400:]

    mon = VramMonitor()
    mon.start()

    reps = []
    status = "OK"
    try:
        plans = [
            ("probe", {"cache_prompt": False, "n_predict": args.npred_probe}),
            ("main", {"cache_prompt": True, "n_predict": args.npred_main}),
        ]
        for name, over in plans:
            payload = {
                "prompt": prompt_text,
                "temperature": 0.0, "top_k": 1, "seed": 1234,
                "ignore_eos": True, "stream": False,
            }
            payload.update(over)
            t0 = time.perf_counter()
            body, _wall = post("/completion", payload, timeout=7200)
            wall = round(time.perf_counter() - t0, 3)
            with open(f"{outdir}/resp_{name}.json", "w") as f:
                json.dump({"wall_s": wall, "body": body}, f, indent=1)
            t = body.get("timings", {})
            rep = {
                "req": name, "cache_prompt": payload["cache_prompt"],
                "wall_s": wall,
                "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
                "predicted_n": t.get("predicted_n"),
                "predicted_ms": t.get("predicted_ms"),
                "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
                "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
                "stop_reason": body.get("stop_reason"),
                "content_head": (body.get("content") or "")[:120],
            }
            reps.append(rep)
            print(json.dumps(rep), flush=True)
            if name == "probe":
                # let the server settle so the inter-request gap is unambiguous
                time.sleep(3)
    except Exception as e:
        status = "REP_FAIL"
        rec["error"] = str(e)

    rec["metrics_after"] = {k: v for k, v in metrics().items() if "spec" not in k}
    mon.halt()
    rec["vram_peak_b"] = mon.peak
    rec["vram_samples_n"] = len(mon.samples)
    with open(f"{outdir}/vram_samples.json", "w") as f:
        json.dump(mon.samples, f)
    rec["mem_after"] = mem_snapshot()
    rec["swap_delta_b"] = rec["mem_after"]["swap_used_b"] - mem_before["swap_used_b"]
    rec["status"] = status
    rec["reps"] = reps
    rec["finished_ts"] = time.strftime("%F %T")
    with open(f"{outdir}/arm_record.json", "w") as f:
        json.dump(rec, f, indent=1)
    print("TRACED_ARM_DONE " + json.dumps({"status": status, "arm": args.arm}), flush=True)


if __name__ == "__main__":
    main()
