#!/usr/bin/env python3
"""Tulpar.cpp Phase 1: comprehensive baseline + profiling campaign on tulpar/main.

Phases (sequential, single 8080 server at a time):
  1. stop production server
  2. environment manifest
  3. perf matrix tulpar_base_off  : ctx 1k/16k/63k/128k, fresh+2 cached reps
  4. perf matrix tulpar_base_on   : same + draft-MTP spec args
  5. traced sessions t16k/t63k/t128k (rocprofv3 wrapped server, one
     prefill + 96 decode steps each) for time-share breakdown
  6. restore production server (finally)

Artifacts land in results2/tulpar/.
"""
import json, os, signal, subprocess, sys, time, hashlib

sys.path.insert(0, str(ROOT / "results"))
from orchestrate import COMMON, wait_health, post
from bench import make_text

from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
RES = f"{ROOT}/results2/tulpar"
BIN = f"{ROOT}/build-p3/bin/llama-server"   # built from tulpar/main content (66dcba5eb == 80cf14ff5)
MODEL = "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
SPEC_ARGS = ["--spec-type", "draft-mtp", "--spec-draft-n-max", "4",
             "--spec-draft-p-min", "0.8"]
LOG = open(f"{RES}/campaign.log", "a", buffering=1)

def log(*a):
    msg = " ".join(str(x) for x in a)
    print(msg, flush=True); LOG.write(msg + "\n")

def stop_prod():
    pids = subprocess.run(["pgrep", "-x", "llama-server"],
                          capture_output=True, text=True).stdout.split()
    for pid in pids:
        try:
            os.kill(int(pid), signal.SIGINT)
            log("stopped prod pid", pid)
        except ProcessLookupError:
            pass
    for _ in range(60):
        if not subprocess.run(["pgrep", "-x", "llama-server"],
                              capture_output=True).stdout: return
        time.sleep(1)
    for pid in subprocess.run(["pgrep", "-x", "llama-server"],
                              capture_output=True, text=True).stdout.split():
        os.kill(int(pid), signal.SIGKILL)
    log("prod force-killed")

def server_args(spec):
    args, skip = [], False
    for i, a in enumerate(COMMON):
        if skip: skip = False; continue
        if a == "-c": args += ["-c", "131072"]; skip = True; continue
        args.append(a)
    return [BIN] + args + (SPEC_ARGS if spec else [])

def start_server(spec, logfile):
    lf = open(logfile, "w")
    proc = subprocess.Popen(server_args(spec), cwd=os.path.dirname(BIN),
                            stdout=lf, stderr=subprocess.STDOUT,
                            preexec_fn=os.setsid)
    assert wait_health(900), f"server failed ({logfile})"
    log("server up pid", proc.pid, "spec" if spec else "off")
    return proc

def stop_server(proc):
    os.killpg(proc.pid, signal.SIGINT)
    try: proc.wait(timeout=180)
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)

def prompt_for(target_words):
    return make_text(target_words, seed=555001) + \
        "\n\nQ: Summarize the topic of the text above in one sentence.\nA:"

def bench_once(prompt, npred, cache, greedy=False, seed=4242):
    payload = {"prompt": prompt, "n_predict": npred, "cache_prompt": cache,
               "ignore_eos": True, "seed": seed}
    if greedy:
        payload.update({"temperature": 0.0, "top_k": 1})
    else:
        payload.update({"temperature": 0.6, "top_k": 20, "top_p": 0.95, "min_p": 0.0})
    body = post("/completion", payload)
    t = body["timings"]
    acc = None
    if t.get("draft_n"):
        acc = round(t["draft_n_accepted"] / t["draft_n"], 4)
    return {"prompt_n": t.get("prompt_n"),
            "prefill_tok_s": round(t.get("prompt_per_second") or 0, 2),
            "decode_tok_s": round(t["predicted_per_second"], 3),
            "draft_acc": acc}

def perf_window(tag, spec):
    proc = start_server(spec, f"{RES}/srv_{tag}.log")
    post("/completion", {"prompt": "Warmup zeta.", "n_predict": 8,
                         "temperature": 0.6, "cache_prompt": False,
                         "seed": 1})
    out = {"tag": tag, "spec": spec, "binary": BIN, "ctxs": {}}
    for words, name in [(960, "1k"), (16320, "16k"), (64512, "63k"), (129400, "128k")]:
        p = prompt_for(words)
        recs = []
        for rep in range(3):
            r = bench_once(p, 128, cache=(rep > 1))
            r["rep"] = rep + 1
            recs.append(r); log(tag, name, json.dumps(r))
        out["ctxs"][name] = recs
    stop_server(proc)
    with open(f"{RES}/perf_{tag}.json", "w") as f:
        json.dump(out, f, indent=1)
    log("perf window done:", tag)

def traced_session(tag, words, spec=False):
    outdir = f"{RES}/traces/{tag}"
    os.makedirs(outdir, exist_ok=True)
    cmd = ["rocprofv3", "--kernel-trace", "--hip-runtime-trace",
           "--memory-copy-trace", "-d", outdir, "--"] + server_args(spec)
    lf = open(f"{RES}/srv_{tag}.log", "w")
    proc = subprocess.Popen(cmd, cwd=os.path.dirname(BIN),
                            stdout=lf, stderr=subprocess.STDOUT,
                            preexec_fn=os.setsid)
    try:
        assert wait_health(900), f"traced server failed ({tag})"
        log("traced server up:", tag)
        p = prompt_for(words)
        r = bench_once(p, 96, cache=False)
        log(tag, json.dumps(r))
        with open(f"{RES}/trace_{tag}_meta.json", "w") as f:
            json.dump({"tag": tag, "words": words, "bench": r}, f, indent=1)
    finally:
        stop_server(proc)
        subprocess.run(["pkill", "-INT", "-f", "rocprofv3"], capture_output=True)
        time.sleep(10)
    log("traced session done:", tag)

def manifest():
    d = f"{RES}/env"; os.makedirs(d, exist_ok=True)
    def sh(out, *cmd):
        with open(f"{d}/{out}", "w") as f:
            subprocess.run(cmd, stdout=f, stderr=subprocess.STDOUT)
    sh("uname.txt", "uname", "-a")
    sh("cpu.txt", "bash", "-c", "lscpu | grep -E 'Model name|CPU\\(s\\)|MHz'")
    sh("mem.txt", "free", "-g")
    sh("rocm.txt", "cat", "/opt/rocm/.info/version")
    sh("gpu.txt", "bash", "-c",
       "rocminfo | grep -E 'Marketing Name|Device Type|Global Memory Size|Chip ID'")
    sh("smi.txt", "rocm-smi", "--showclocks", "--showpower", "--showtemp",
       "--showmemuse", "--showdriverversion")
    sh("power_profile.txt", "cat",
       "/sys/class/drm/card1/device/pp_power_profile_mode")
    rev = subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT,
                         capture_output=True, text=True).stdout.strip()
    msize = os.path.getsize(MODEL)
    mh = hashlib.sha256()
    with open(MODEL, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 24), b""): mh.update(chunk)
    info = {"git_rev": rev, "branch": "tulpar/main", "model_sha256": mh.hexdigest(),
            "model_bytes": msize, "binary": BIN,
            "binary_mtime": os.path.getmtime(BIN),
            "note": "binary built from commit 80cf14ff5 content "
                    "(rebased cherry-pick 66dcba5eb), ROCm 7.2.4 gfx1101"}
    with open(f"{d}/env.json", "w") as f: json.dump(info, f, indent=1)
    log("manifest written")

def restore_prod():
    subprocess.Popen(["setsid", "bash", "/tmp/opencode/launch_prod.sh"],
                     stdout=open(f"{RES}/restore.log", "w"),
                     stderr=subprocess.STDOUT, start_new_session=True)
    ok = False
    for _ in range(120):
        time.sleep(3)
        r = subprocess.run(["curl", "-s", "-m", "3", "http://localhost:8080/health"],
                           capture_output=True, text=True)
        if '"ok"' in r.stdout: ok = True; break
    log("prod restored:", ok)

def main():
    log("=== campaign start ===")
    stop_prod()
    try:
        manifest()
        perf_window("tulpar_base_off", spec=False)
        perf_window("tulpar_base_on", spec=True)
        traced_session("t16k", 16320)
        traced_session("t63k", 64512)
        traced_session("t128k", 129400)
    except Exception as e:
        log("CAMPAIGN ERROR:", repr(e))
    finally:
        restore_prod()
        log("=== campaign end ===")

if __name__ == "__main__":
    main()
