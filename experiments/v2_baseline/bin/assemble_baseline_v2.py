#!/usr/bin/env python3
# Assemble the V2 stored baseline from this window's gate artifacts.
import json, subprocess, time, os

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
R2 = f"{ROOT}/results2/correctness"
VB = f"{ROOT}/experiments/v2_baseline"

def load(p):
    try:
        return json.load(open(p))
    except Exception as e:
        return {"error": str(e), "path": p}

def sha(path):
    return subprocess.run(["sha256sum", path], capture_output=True, text=True).stdout.split()[0]

def testmap(s):
    return {t["test"]: t for t in s.get("tests", [])}

# V2 artifacts (this window)
suite_on = load(f"{R2}/suite_on_v2.json")
suite_off = load(f"{R2}/suite_off_v2.json")
sem_on = load(f"{R2}/semantic_v2_on.json")
sem_off = load(f"{R2}/semantic_v2_off.json")

known_changes = []
for name in ("puzzle", "degen_trap_p1k", "arith_multistep"):
    entry = {
        "test": name,
        "mtp_on_pass": testmap(suite_on).get(name, {}).get("pass"),
        "mtp_off_pass": testmap(suite_off).get(name, {}).get("pass"),
        "head_mtp_off": (testmap(suite_off).get(name, {}).get("text") or "")[:160],
        "metrics_mtp_off": testmap(suite_off).get(name, {}).get("metrics"),
    }
    known_changes.append(entry)

# Model detection: current V2 path vs V3 path
v2_path = "/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf"
v3_path = "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
v2_exists = os.path.isfile(v2_path)
v3_exists = os.path.isfile(v3_path)

model_path = v2_path if v2_exists else v3_path
v2_sha = sha(v2_path) if v2_exists else ""
v3_sha = sha(v3_path) if v3_exists else ""

baseline = {
    "tag": "baseline_v2",
    "ts_recorded": time.strftime("%F %T"),
    "window": "phase-1b V2 model swap + baseline (EXP-002)",
    "supersedes": ["baseline_ON_prod_v3.json (V3) and baseline_ON_prod_v2.json (pre-window)"],
    "model": {
        "path": model_path,
        "version_label": "V2" if v2_exists else "V3",
        "sha256": v2_sha if v2_exists else v3_sha,
        "file_size_bytes": 10676423744 if v2_exists else 9828981664,
        "note": "V2 path: qwen-v2/, V3 path: qwen38/. Detection based on file existence.",
    },
    "binary": {
        "path": f"{ROOT}/build-p3/bin/llama-server",
        "sha256": sha(f"{ROOT}/build-p3/bin/llama-server"),
    },
    "git_head": subprocess.run(["git", "-C", ROOT, "rev-parse", "--short", "HEAD"],
                               capture_output=True, text=True).stdout.strip(),
    "gate_context": "EXP-002 V2 model swap + baseline measurement; fused q4_0 optimization active.",
    "expected_v2_signature": {
        "deterministic_passes": [t for t in ("factual_en", "arith_simple", "puzzle", "code_func", "code_oneliner", "turkish", "list_struct", "needle16k_single", "needle_multi", "longgen_story") if testmap(suite_on).get(t, {}).get("pass")],
        "note": "V2 expected to match V2 baseline: puzzle '9' (not V3 anomaly '8'); arith_multistep quirk-tolerant (accepts '40' as baseline); degen_trap_p1k returns 'and where...' loop surface (V2 pattern).",
    },
    "suite_mtp_on_ctx65536_prod_flags": {
        "summary": suite_on.get("summary"),
        "tests": [{"test": t["test"], "pass": t["pass"], "tok_s": t["tok_s"],
                   "prompt_n": t["prompt_n"]} for t in suite_on.get("tests", [])],
        "sampled": suite_on.get("sampled"),
        "raw": "results2/correctness/suite_on_v2.json",
    },
    "suite_mtp_off_ctx131072_no_spec": {
        "summary": suite_off.get("summary"),
        "tests": [{"test": t["test"], "pass": t["pass"], "tok_s": t["tok_s"],
                   "prompt_n": t["prompt_n"]} for t in suite_off.get("tests", [])],
        "sampled": suite_off.get("sampled"),
        "raw": "results2/correctness/suite_off_v2.json",
    },
    "semantic_smoke_mtp_on": sem_on,
    "semantic_smoke_mtp_off": sem_off,
    "v2_quality_svg_reasoning": load(f"{VB}/raw/v2_quality_off.json"),
    "usage_as_restore_target": "Compare future restore checks against V2 semantic smoke heads (recorded with cache_prompt=False).",
}

os.makedirs(VB, exist_ok=True)
os.makedirs(f"{R2}", exist_ok=True)

for p in (f"{R2}/baseline_v2.json", f"{VB}/baseline_v2.json"):
    json.dump(baseline, open(p, "w"), indent=1)

print(json.dumps({
    "on_summary": suite_on.get("summary"), "off_summary": suite_off.get("summary"),
    "model_detected": baseline["model"]["version_label"],
    "written": ["results2/correctness/baseline_v2.json", f"{VB}/baseline_v2.json"]}, indent=1))
