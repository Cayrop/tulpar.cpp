#!/usr/bin/env python3
# Phase-1 TRACED arm driver against an already-running rocprofv3-wrapped
# server. Two requests per instance:
#   probe: cache_prompt=false n_predict=1   -> clean prefill-phase trace
#   main : cache_prompt=true  n_predict=N   -> decode-phase trace (cached prompt)
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
PHASE2 = f"{ROOT}/experiments/phase2"
sys.path.insert(0, f"{ROOT}/results")
from bench import post, metrics  # noqa: E402

SUFFIX = "\n\nQ: Summarize the topic of the text above in one sentence.\nA:"
VRAM_GUARD_B = 16752282317  # 15.6 GiB sampled


def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def vram_used_bytes():
    try:
        r_ = run(["rocm-smi", "--showmeminfo", "vram"])
    except OSError:
        return None
    if r_.returncode != 0:
        return None
    m = re.search(r"VRAM Total Used Memory \(B\):\s*(\d+)", r_.stdout)
    return int(m.group(1)) if m else None


def mem_snapshot():
    out = run(["free", "-b"]).stdout
    lines = out.splitlines()
    mem = lines[1].split()
    swap = lines[2].split()
    return {
        "mem_total_b": int(mem[1]), "mem_used_b": int(mem[2]),
        "mem_avail_b": int(mem[6]),
        "swap_total_b": int(swap[1]), "swap_used_b": int(swap[2]),
        "ts": time.strftime("%F %T"),
    }


class VramMonitor(threading.Thread):
    def __init__(self, interval=0.5):
        super().__init__(daemon=True)
        self.interval = interval
        self.samples = []
        self.peak = 0
        self.failed_reads = 0
        self._stop = threading.Event()

    def run(self):
        while not self._stop.is_set():
            u = vram_used_bytes()
            if u is not None:
                self.samples.append((round(time.time(), 3), u))
                self.peak = max(self.peak, u)
            else:
                self.failed_reads += 1
            self._stop.wait(self.interval)

    def first_sample(self, timeout_s=10):
        deadline = time.time() + timeout_s
        while time.time() < deadline and not self.samples:
            time.sleep(0.25)
        return bool(self.samples)

    def halt(self):
        self._stop.set()
        self.join(timeout=5)


def build_prompt(prompt_tokens, seed):
    text = __import__("bench").make_text(prompt_tokens, seed) + SUFFIX
    body, _ = post("/tokenize", {"content": text})
    return text, len(body["tokens"])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arm", required=True)
    ap.add_argument("--mtp", choices=["on", "off"], default="off")
    ap.add_argument("--ctx-size", type=int, default=131072)
    ap.add_argument("--prompt-file", default=None,
                    help="reuse a saved prompt instead of regenerating")
    ap.add_argument("--prompt-tokens", type=int, required=True)
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--npred-probe", type=int, default=1)
    ap.add_argument("--npred-main", type=int, default=32)
    ap.add_argument("--skip-probe", action="store_true")
    ap.add_argument("--outdir", required=True)
    args = ap.parse_args()
    outdir = args.outdir
    os.makedirs(outdir, exist_ok=True)

    if args.prompt_file and os.path.exists(args.prompt_file):
        prompt_text = open(args.prompt_file).read()
        _t, prompt_n = None, len(post("/tokenize", {"content": prompt_text})[0]["tokens"])
    else:
        prompt_text, prompt_n = build_prompt(args.prompt_tokens, args.seed)
        with open(f"{outdir}/prompt.txt", "w") as f:
            f.write(prompt_text)
    rec = {
        "arm_id": args.arm, "mode": "traced", "mtp": args.mtp,
        "binary": f"{ROOT}/build-p3/bin/llama-server",
        "cache_k": "q4_0", "cache_v": "q4_0", "ctx_size": args.ctx_size,
        "sampling": {"temperature": 0.0, "top_k": 1, "seed": 1234, "greedy": True},
        "prompt_seed": args.seed, "prompt_n": prompt_n,
        "npred_probe": args.npred_probe, "npred_main": args.npred_main,
        "vram_guard_b": VRAM_GUARD_B,
        "started_ts": time.strftime("%F %T"),
    }
    with open(f"{outdir}/arm_record.json", "w") as f:
        json.dump(rec, f, indent=1)

    mem_before = mem_snapshot()
    rec["mem_before"] = mem_before
    rec["gpu_vram_before_b"] = vram_used_bytes()

    mon = VramMonitor()
    mon.start()
    if not mon.first_sample():
        mon.halt()
        rec["status"] = "VRAM_MONITOR_FAIL"
        rec["error"] = "rocm-smi sampling produced no valid read"
        with open(f"{outdir}/arm_record.json", "w") as f:
            json.dump(rec, f, indent=1)
        sys.exit(6)

    reps = []
    status = "OK"
    try:
        plans = []
        if not args.skip_probe:
            plans.append(("probe", {"cache_prompt": False, "n_predict": args.npred_probe}))
        plans.append(("main", {"cache_prompt": True, "n_predict": args.npred_main}))
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
                "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted"),
                "stop_reason": body.get("stop_reason"),
                "content_head": (body.get("content") or "")[:120],
            }
            reps.append(rep)
            print(json.dumps(rep), flush=True)
            with open(f"{outdir}/arm_record_partial.json", "w") as f:
                json.dump(reps, f, indent=1)
            if mon.peak > VRAM_GUARD_B:
                status = "VRAM_GUARD_TRIP"
                rec["error"] = f"peak {mon.peak} > guard {VRAM_GUARD_B}"
                break
            if name == "probe":
                # let the server settle so the inter-request gap is unambiguous
                time.sleep(3)
    except Exception as e:
        status = "REP_FAIL"
        rec["error"] = str(e)

    rec["metrics_after"] = metrics()
    mon.halt()
    rec["vram_peak_b"] = mon.peak
    rec["vram_peak_gib"] = round(mon.peak / 2**30, 3)
    rec["vram_samples_n"] = len(mon.samples)
    rec["vram_failed_reads"] = mon.failed_reads
    rec["vram_peak_note"] = "sampled every 0.5 s; true transient peak can exceed this value"
    with open(f"{outdir}/vram_samples.json", "w") as f:
        json.dump(mon.samples, f)
    rec["mem_after"] = mem_snapshot()
    rec["swap_delta_b"] = rec["mem_after"]["swap_used_b"] - mem_before["swap_used_b"]
    acc_d = sum(r_["draft_n_accepted"] or 0 for r_ in reps)
    acc_n = sum(r_["draft_n"] or 0 for r_ in reps)
    rec["acceptance"] = {
        "draft_n_total": acc_n, "draft_n_accepted_total": acc_d,
        "rate": round(acc_d / acc_n, 4) if acc_n else None,
    }
    rec["status"] = status
    rec["reps"] = reps
    rec["finished_ts"] = time.strftime("%F %T")
    with open(f"{outdir}/arm_record.json", "w") as f:
        json.dump(rec, f, indent=1)
    print("TRACED_ARM_DONE " + json.dumps({"status": status, "arm": args.arm}), flush=True)


if __name__ == "__main__":
    main()
