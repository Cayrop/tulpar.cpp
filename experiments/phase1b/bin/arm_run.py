#!/usr/bin/env python3
# Phase-1B baseline measurement arm driver.
# Starts one dedicated build-p3 server via srv_ctl.sh (pidfile policy),
# runs deterministic greedy reps, records raw artifacts, stops server.
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
PHASE1B = f"{ROOT}/experiments/phase1b"
SRV_CTL = f"{PHASE1B}/bin/srv_ctl.sh"
PIDFILE_DIR = f"{ROOT}/ops/run"
sys.path.insert(0, f"{ROOT}/results")
from bench import post, metrics  # noqa: E402

SUFFIX = "\n\nQ: Summarize the topic of the text above in one sentence.\nA:"


def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def vram_used_bytes():
    out = run(["rocm-smi", "--showmeminfo", "vram"]).stdout
    m = re.search(r"GPU\[0\]\s*:\s*VRAM Total Used Memory \(B\):\s*(\d+)", out)
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


def health_ok(timeout_s):
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


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arm", required=True)
    ap.add_argument("--mtp", choices=["on", "off"], required=True)
    ap.add_argument("--graph", choices=["on", "off"], default="on")
    ap.add_argument("--prompt-tokens", type=int, required=True)
    ap.add_argument("--seed-text", type=int, required=True)
    ap.add_argument("--reps", type=int, required=True)
    ap.add_argument("--npred", type=int, required=True)
    args = ap.parse_args()

    outdir = f"{PHASE1B}/raw/{args.arm}"
    os.makedirs(outdir, exist_ok=True)
    rec = {
        "arm_id": args.arm, "mtp": args.mtp, "graph": args.graph,
        "binary": f"{ROOT}/build-p3/bin/llama-server",
        "cache_k": "q4_0", "cache_v": "q4_0",
        "ctx_size": 131072,
        "sampling": {"temperature": 0.0, "top_k": 1, "greedy": True},
        "started_ts": time.strftime("%F %T"),
    }

    mem_before = mem_snapshot()
    gpu_before = vram_used_bytes()

    r = run([SRV_CTL, "start", "--profile", args.arm,
             "--mtp", args.mtp, "--graph", args.graph])
    with open(f"{outdir}/start.log", "w") as f:
        f.write(r.stdout + "\n---STDERR---\n" + r.stderr)
    if r.returncode != 0:
        rec["status"] = "START_FAIL"
        rec["start_rc"] = r.returncode
        json.dump(rec, open(f"{outdir}/arm_record.json", "w"), indent=1)
        print(json.dumps(rec, indent=1))
        sys.exit(2)

    rec["pid"] = int(open(f"{PIDFILE_DIR}/baseline-{args.arm}.pid").read().strip())
    rec["server_log"] = f"{PHASE1B}/logs/srv_{args.arm}.log"
    rec["health"] = "ok" if health_ok(60) else "fail"

    prompt_text = ""
    prompt_n = None
    try:
        prompt_text = __import__("bench").make_text(args.prompt_tokens, args.seed_text) + SUFFIX
        body, _ = post("/tokenize", {"content": prompt_text})
        prompt_n = len(body["tokens"])
    except Exception as e:
        rec["status"] = "PROMPT_BUILD_FAIL"
        rec["error"] = str(e)
        json.dump(rec, open(f"{outdir}/arm_record.json", "w"), indent=1)
        run([SRV_CTL, "stop", "--profile", args.arm])
        sys.exit(3)

    rec["prompt_n"] = prompt_n
    rec["n_predict"] = args.npred
    rec["reps_planned"] = args.reps
    rec["prompt_seed"] = args.seed_text
    rec["prompt_text_head"] = prompt_text[:300]
    rec["prompt_text_tail"] = prompt_text[-200:]

    mon = VramMonitor()
    mon.start()
    m_before = metrics()
    reps = []
    overall_status = "OK"
    try:
        for i in range(1, args.reps + 1):
            payload = {
                "prompt": prompt_text,
                "n_predict": args.npred,
                "temperature": 0.0,
                "top_k": 1,
                "cache_prompt": i > 1,
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
                "rep": i, "cache_prompt": i > 1, "wall_s": wall,
                "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
                "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
                "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
                "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
                "e2e_tok_s": round(t.get("predicted_n", 0) / wall, 3) if wall else None,
                "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted"),
                "draft_per_token_ms": t.get("draft_per_token_ms"),
                "stop_reason": body.get("stop_reason"),
                "truncated": body.get("truncated"),
                "content_head": (body.get("content") or "")[:160],
            }
            reps.append(rep)
            print(json.dumps(rep), flush=True)
            with open(f"{outdir}/arm_record_partial.json", "w") as f:
                json.dump(reps, f, indent=1)
    except Exception as e:
        overall_status = "REP_FAIL"
        rec["error"] = str(e)

    m_after = metrics()
    mon.halt()
    rec["metrics_before"] = m_before
    rec["metrics_after"] = m_after
    spec_keys = {k: v for k, v in m_after.items() if "spec" in k.lower()}
    rec["spec_metrics_final"] = spec_keys
    rec["vram_peak_b"] = mon.peak
    rec["vram_samples_n"] = len(mon.samples)
    with open(f"{outdir}/vram_samples.json", "w") as f:
        json.dump(mon.samples, f)

    rec["mem_before"] = mem_before
    rec["mem_after"] = mem_snapshot()
    rec["gpu_vram_before_b"] = gpu_before

    stop_r = run([SRV_CTL, "stop", "--profile", args.arm])
    with open(f"{outdir}/stop.log", "w") as f:
        f.write(stop_r.stdout + "\n---STDERR---\n" + stop_r.stderr)
    rec["stop_rc"] = stop_r.returncode
    time.sleep(3)
    rec["gpu_vram_after_b"] = vram_used_bytes()
    if overall_status == "OK" and stop_r.returncode == 0:
        overall_status = "OK"
    elif stop_r.returncode != 0:
        overall_status = "STOP_FAIL"
    rec["status"] = overall_status
    rec["finished_ts"] = time.strftime("%F %T")

    ok_reps = [r_ for r_ in reps if r_.get("tg_tok_s")]
    tg_vals = sorted(r_["tg_tok_s"] for r_ in ok_reps)
    pp_fresh = [r_["pp_tok_s"] for r_ in ok_reps if not r_["cache_prompt"]]
    def median(v):
        n = len(v)
        return None if not n else (v[n // 2] if n % 2 else (v[n // 2 - 1] + v[n // 2]) / 2)
    rec["summary"] = {
        "tg_tok_s_median_all": median(tg_vals),
        "tg_tok_s_min": tg_vals[0] if tg_vals else None,
        "tg_tok_s_max": tg_vals[-1] if tg_vals else None,
        "tg_tok_s_median_cached": median(sorted(r_["tg_tok_s"] for r_ in ok_reps if r_["cache_prompt"])),
        "pp_tok_s_median_fresh": median(sorted(pp_fresh)),
        "reps_measured": len(ok_reps),
    }
    acc_d = sum(r_["draft_n_accepted"] or 0 for r_ in reps)
    acc_n = sum(r_["draft_n"] or 0 for r_ in reps)
    rec["acceptance"] = {
        "draft_n_total": acc_n, "draft_n_accepted_total": acc_d,
        "rate": round(acc_d / acc_n, 4) if acc_n else None,
    }
    json.dump(rec, open(f"{outdir}/arm_record.json", "w"), indent=1)
    print("ARM_DONE " + json.dumps(rec["summary"]), flush=True)


if __name__ == "__main__":
    main()
