#!/usr/bin/env python3
# Phase-2B arm driver: runs greedy reps against an ALREADY RUNNING server,
# records raw artifacts under experiments/phase2b/raw/<arm>/.
# MTP OFF only. No speculative flags anywhere.
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
from bench import post, metrics  # noqa: E402

SUFFIX = "\n\nQ: Summarize the topic of the text above in one sentence.\nA:"


def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def vram_used_bytes():
    out = run(["rocm-smi", "--showmeminfo", "vram"]).stdout
    m = re.search(r"VRAM Total Used Memory \(B\):\s*(\d+)", out)
    return int(m.group(1)) if m else None


def mem_snapshot():
    out = run(["free", "-b"]).stdout
    lines = out.splitlines()
    mem = lines[1].split()
    swap = lines[2].split()
    return {
        "mem_total_b": int(mem[1]), "mem_used_b": int(mem[2]),
        "mem_avail_b": int(mem[6]),
        "swap_total_b": int(swap[2]), "swap_used_b": int(swap[3]),
        "ts": time.strftime("%F %T"),
    }


class VramMonitor(threading.Thread):
    def __init__(self, interval=0.5):
        super().__init__(daemon=True)
        self.interval = interval
        self.samples = []
        self.peak = 0
        self._stop = threading.Event()

    def run(self):
        while not self._stop.is_set():
            u = vram_used_bytes()
            if u is not None:
                self.samples.append((round(time.time(), 3), u))
                self.peak = max(self.peak, u)
            self._stop.wait(self.interval)

    def halt(self):
        self._stop.set()
        self.join(timeout=5)


def health_ok(timeout_s=60):
    deadline = time.time() + timeout_s
    while time.time() < deadline:
        try:
            r = run(["curl", "-sf", "-m", "3", "http://127.0.0.1:8080/health"])
            if '"status":"ok"' in r.stdout:
                return True
        except Exception:
            pass
        time.sleep(5)
    return False


def build_prompt(prompt_tokens, seed):
    text = __import__("bench").make_text(prompt_tokens, seed) + SUFFIX
    body, _ = post("/tokenize", {"content": text})
    return text, len(body["tokens"])


def do_reps(args, outdir):
    prompt_text, prompt_n = build_prompt(args.prompt_tokens, args.seed)
    rec = {
        "arm_id": args.arm, "mode": args.mode, "mtp": "off",
        "binary": f"{ROOT}/build-p3/bin/llama-server",
        "cache_k": "q4_0", "cache_v": "q4_0", "ctx_size": 131072,
        "sampling": {"temperature": 0.0, "top_k": 1, "seed": 1234, "greedy": True},
        "prompt_seed": args.seed, "prompt_n": prompt_n,
        "n_predict": args.npred, "reps_planned": args.reps,
        "started_ts": time.strftime("%F %T"),
    }
    os.makedirs(outdir, exist_ok=True)

    mem_before = mem_snapshot()
    gpu_before = vram_used_bytes()
    rec["mem_before"] = mem_before
    rec["gpu_vram_before_b"] = gpu_before

    mon = VramMonitor()
    mon.start()
    m_before = metrics()
    reps = []
    status = "OK"
    try:
        for i in range(1, args.reps + 1):
            payload = {
                "prompt": prompt_text,
                "n_predict": args.npred,
                "temperature": 0.0,
                "top_k": 1,
                "cache_prompt": (i > 1) if args.fresh_first else False,
                "ignore_eos": True,
                "stream": False,
                "seed": 1234,
            }
            t0 = time.perf_counter()
            body, wall = post("/completion", payload, timeout=7200)
            wall = round(time.perf_counter() - t0, 3)
            with open(f"{outdir}/resp_r{i}.json", "w") as f:
                json.dump({"wall_s": wall, "body": body}, f, indent=1)
            t = body.get("timings", {})
            rep = {
                "rep": i, "cache_prompt": payload["cache_prompt"], "wall_s": wall,
                "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
                "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
                "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
                "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
                "e2e_tok_s": round(t.get("predicted_n", 0) / wall, 3) if wall else None,
                "stop_reason": body.get("stop_reason"),
                "truncated": body.get("truncated"),
                "content_head": (body.get("content") or "")[:160],
            }
            reps.append(rep)
            print(json.dumps(rep), flush=True)
            with open(f"{outdir}/arm_record_partial.json", "w") as f:
                json.dump(reps, f, indent=1)
    except Exception as e:
        status = "REP_FAIL"
        rec["error"] = str(e)

    m_after = metrics()
    mon.halt()
    rec["metrics_delta_keys"] = sorted(set(m_after) - set(m_before))
    rec["vram_peak_b"] = mon.peak
    rec["vram_samples_n"] = len(mon.samples)
    with open(f"{outdir}/vram_samples.json", "w") as f:
        json.dump(mon.samples, f)
    rec["mem_after"] = mem_snapshot()
    rec["swap_delta_b"] = rec["mem_after"]["swap_used_b"] - mem_before["swap_used_b"]
    rec["status"] = status
    rec["finished_ts"] = time.strftime("%F %T")

    ok = [r for r in reps if r.get("tg_tok_s")]
    tg = sorted(r["tg_tok_s"] for r in ok)

    def median(v):
        n = len(v)
        return None if not n else (v[n // 2] if n % 2 else (v[n // 2 - 1] + v[n // 2]) / 2)

    rec["summary"] = {
        "tg_tok_s_median": median(tg),
        "tg_tok_s_min": tg[0] if tg else None,
        "tg_tok_s_max": tg[-1] if tg else None,
        "pp_tok_s_fresh": next((r["pp_tok_s"] for r in reps if not r["cache_prompt"] and r.get("pp_tok_s")), None),
        "reps_measured": len(ok),
    }
    with open(f"{outdir}/arm_record.json", "w") as f:
        json.dump(rec, f, indent=1)
    print("ARM_DONE " + json.dumps(rec["summary"]), flush=True)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arm", required=True)
    ap.add_argument("--mode", default="untraced", choices=["untraced", "traced"])
    ap.add_argument("--prompt-tokens", type=int, required=True)
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--npred", type=int, required=True)
    ap.add_argument("--reps", type=int, default=1)
    ap.add_argument("--fresh-first", action="store_true",
                    help="rep1 cache_prompt=false, rest cached (Phase-1B rep structure)")
    ap.add_argument("--outdir", default=None)
    args = ap.parse_args()
    outdir = args.outdir or f"{P2B}/raw/{args.arm}"
    do_reps(args, outdir)


if __name__ == "__main__":
    main()
