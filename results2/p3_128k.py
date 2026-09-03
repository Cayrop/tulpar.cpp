#!/usr/bin/env python3
"""P3-128K matrix runner: VRAM/stability A/B for stock vs clean patch, MTP OFF/ON.
Usage: p3_128k.py <tag> [--bin=PATH] [--off]
Protocol per window: fresh 128k prefill+greedy decode (needle check) + 2 cached decodes.
Monitors: VRAM used, gpu_busy_percent, MemAvailable, SwapUsed, sleep-drift stalls.
"""
import json, os, signal, subprocess, sys, threading, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "results"))
import orchestrate
from orchestrate import wait_health, post
from bench import make_text

RES = str(ROOT / "results2/p3")
NEEDLE = "AMBER-KEY-7241"

def find_card():
    for c in sorted(os.listdir("/sys/class/drm")):
        p = f"/sys/class/drm/{c}/device/mem_info_vram_used"
        if c.startswith("card") and os.path.exists(p):
            return c
    return None

class Mon:
    def __init__(self):
        self.card = find_card()
        self.samples = []          # (t, vram_b, gpu_busy, memavail_mb, swap_mb, drift_s)
        self.marks = {}            # name -> (t0, t1)
        self.stop = False
        self.max_drift = 0.0
        self.n_stalls = 0
        self.thread = threading.Thread(target=self._loop, daemon=True)

    def _read(self, path):
        try:
            return open(path).read().strip()
        except Exception:
            return None

    def _loop(self):
        while not self.stop:
            t = time.time()
            vram = int(self._read(f"/sys/class/drm/{self.card}/device/mem_info_vram_used") or 0)
            busy = float(self._read(f"/sys/class/drm/{self.card}/device/gpu_busy_percent") or 0)
            mi = {}
            for line in self._read("/proc/meminfo").splitlines():
                k = line.split(":")
                if k[0] in ("MemAvailable", "SwapTotal", "SwapFree"):
                    mi[k[0]] = int(k[1].split()[0]) // 1024
            swap = mi.get("SwapTotal", 0) - mi.get("SwapFree", 0)
            self.samples.append((t, vram, busy, mi.get("MemAvailable", 0), swap))
            time.sleep(0.05)
            drift = time.time() - t - 0.05
            if drift > self.max_drift:
                self.max_drift = drift
            if drift > 0.5:
                self.n_stalls += 1

    def start(self):
        self.thread.start()

    def halt(self):
        self.stop = True
        self.thread.join(timeout=2)

    def stats(self, t0=None, t1=None):
        rows = [r for r in self.samples
                if (t0 is None or r[0] >= t0) and (t1 is None or r[0] <= t1)]
        if not rows:
            return None
        v = [r[1] for r in rows]
        b = [r[2] for r in rows]
        return {"vram_peak_gb": round(max(v)/2**30, 3),
                "vram_min_gb": round(min(v)/2**30, 3),
                "gpu_busy_mean": round(sum(b)/len(b), 1),
                "gpu_busy_max": max(b),
                "memavail_min_mb": min(r[3] for r in rows),
                "swap_used_max_mb": max(r[4] for r in rows)}

def build_prompt():
    filler = make_text(129400, seed=888111)
    half = len(filler)//2
    text = (filler[:half] +
            f" By the way, the magic word of this story is {NEEDLE}. " +
            filler[half:] +
            "\n\nQ: What is the magic word of the story above? Answer with the magic word only.\nA:")
    n = len(post("/tokenize", {"content": text})["tokens"])
    return text, n

def server_args(binary, spec_on):
    args = [binary]
    skip = False
    for i, a in enumerate(orchestrate.COMMON):
        if skip:
            skip = False
            continue
        if a == "-c":
            args += ["-c", "131072"]
            skip = True
            continue
        args.append(a)
    return args + (orchestrate.SPEC if spec_on else [])

def main():
    tag = sys.argv[1]
    binary = orchestrate.BIN
    spec_on = "--off" not in sys.argv
    for a in sys.argv[2:]:
        if a.startswith("--bin="):
            binary = a.split("=", 1)[1]
    os.makedirs(RES, exist_ok=True)
    logf = open(f"{RES}/win128_{tag}.log", "w")
    args = server_args(binary, spec_on)
    proc = subprocess.Popen(args, cwd=os.path.dirname(binary),
                            stdout=logf, stderr=subprocess.STDOUT, preexec_fn=os.setsid)
    assert wait_health(900), f"{tag}: server failed to start"
    print(f"[{tag}] up pid={proc.pid} bin={binary} spec={spec_on} ctx=131072", flush=True)
    res = {"tag": tag, "binary": binary, "spec": spec_on, "runs": []}
    mon = Mon()
    prompt, ptok = build_prompt()
    res["prompt_tokens"] = ptok
    print(f"[{tag}] prompt tokens={ptok}", flush=True)

    def scan_errors():
        hits = []
        try:
            log = open(f"{RES}/win128_{tag}.log").read()
        except Exception:
            return hits
        for pat in ("out of memory", "hipErrorOutOfMemory", "ROCm error",
                    "failed to allocate", "ggml_backend_alloc", "error"):
            if pat.lower() in log.lower():
                hits.append(pat)
        return sorted(set(hits))

    # warmup (small ctx)
    post("/completion", {"prompt": "Warmup epsilon.", "n_predict": 8,
                         "temperature": 0.0, "top_k": 1, "cache_prompt": False,
                         "ignore_eos": True, "seed": 1})
    mon.start()
    plans = [("r1_fresh_greedy", False, {"temperature": 0.0, "top_k": 1}, 96),
             ("r2_cached_sampled", True, {"temperature": 0.6, "top_k": 20,
                                          "top_p": 0.95, "min_p": 0.0}, 96),
             ("r3_cached_sampled", True, {"temperature": 0.6, "top_k": 20,
                                          "top_p": 0.95, "min_p": 0.0}, 96)]
    for name, cache, samp, npred in plans:
        payload = {"prompt": prompt, "n_predict": npred, "cache_prompt": cache,
                   "ignore_eos": True, "seed": 12345}
        payload.update(samp)
        t0 = time.time()
        body = post("/completion", payload)
        dt = time.time() - t0
        t = body["timings"]
        rec = {"run": name, "cache": cache,
               "prompt_n": t.get("prompt_n"), "predicted_n": t.get("predicted_n"),
               "decode_tok_s": round(t["predicted_per_second"], 3),
               "prefill_tok_s": round(t.get("prompt_per_second") or 0, 2),
               "draft_n": t.get("draft_n"), "draft_acc": t.get("draft_n_accepted"),
               "wall_s": round(dt, 1)}
        st = mon.stats(t0, dt + t0)
        rec.update(st or {})
        rec["needle_found"] = NEEDLE.lower() in body.get("content", "").lower()
        res["runs"].append(rec)
        print(json.dumps(rec), flush=True)
    res["max_sleep_drift_s"] = round(mon.max_drift, 3)
    res["stalls_over_500ms"] = mon.n_stalls
    res["vram_overall_peak_gb"] = round(max(r[1] for r in mon.samples)/2**30, 3)
    mon.halt()
    time.sleep(1)
    res["server_log_error_patterns"] = scan_errors()
    # graceful stop
    os.killpg(proc.pid, signal.SIGINT)
    try:
        proc.wait(timeout=120)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
    with open(f"{RES}/win128_{tag}.json", "w") as f:
        json.dump(res, f, indent=1)
    print(f"[{tag}] DONE errors={res['server_log_error_patterns']}", flush=True)

if __name__ == "__main__":
    main()
