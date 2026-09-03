#!/usr/bin/env python3
# Assemble the V3 stored baseline from this window's gate artifacts.
import json, subprocess, time

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
R2 = f"{ROOT}/results2/correctness"

def load(p):
    try:
        return json.load(open(p))
    except Exception as e:
        return {"error": str(e), "path": p}

suite_on = load(f"{R2}/suite_on_v3_completion.json")
suite_off = load(f"{R2}/suite_off_v3_completion.json")
sem_on = load(f"{R2}/semantic_v3_completion_on.json")
sem_off = load(f"{R2}/semantic_v3_completion_off.json")

def sha(path):
    return subprocess.run(["sha256sum", path], capture_output=True, text=True).stdout.split()[0]

def testmap(s):
    return {t["test"]: t for t in s.get("tests", [])}

mo, mf = testmap(suite_on), testmap(suite_off)

known_changes = []
for name in ("puzzle", "degen_trap_p1k"):
    entry = {
        "test": name,
        "mtp_on_pass": mo.get(name, {}).get("pass"),
        "mtp_off_pass": mf.get(name, {}).get("pass"),
        "head_mtp_off": (mf.get(name, {}).get("text") or "")[:160],
        "metrics_mtp_off": mf.get(name, {}).get("metrics"),
    }
    known_changes.append(entry)

baseline = {
    "tag": "baseline_v3",
    "ts_recorded": time.strftime("%F %T"),
    "window": "phase-0 completion (V3 baseline establishment), started 2026-08-25 ~23:55 +03",
    "supersedes": ["baseline_ON_prod_v3.json (proven contaminated: foreign KV echo in "
                   "'factual' head + recorded against pre-swap V2-equivalent bytes; see "
                   "experiments/phase0/model_swap_verification.md and phase0_blockers.md B0-4)"],
    "model": {
        "path": "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf",
        "version_label": "V3",
        "sha256": sha(f"{ROOT}/../models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"),
        "file_size_bytes": 9828981664,
        "note": "sha256 recomputed at record time; matches fd4730dd... fingerprint of "
                "v3_quant_distribution.json. That JSON's file_size field (9817985024) is "
                "misrecorded; actual size is 9828981664 B.",
    },
    "binary": {
        "path": f"{ROOT}/build-p3/bin/llama-server",
        "sha256": sha(f"{ROOT}/build-p3/bin/llama-server"),
    },
    "git_head": subprocess.run(["git", "-C", ROOT, "rev-parse", "--short", "HEAD"],
                               capture_output=True, text=True).stdout.strip(),
    "gate_context": "correctness_gate_v3.md GATE_FAIL adjudicated by human: probe deltas "
                    "accepted as known V3 behavior changes; baselines mandated by "
                    "'PHASE-0 COMPLETION' task.",
    "known_v3_behavior_changes": known_changes,
    "expected_gate_signature": {
        "deterministic_fails": ["puzzle", "degen_trap_p1k"],
        "note": "puzzle answers 8 instead of 9; degen_trap_p1k produces a different "
                "degenerate loop surface instead of the V2 'and where...' head. Both "
                "stable across MTP ON/OFF and reps. All other deterministic tests and "
                "sampled sanity are expected to pass.",
    },
    "suite_mtp_on_ctx65536_prod_flags": {
        "summary": suite_on.get("summary"),
        "tests": [{"test": t["test"], "pass": t["pass"], "tok_s": t["tok_s"],
                   "prompt_n": t["prompt_n"]} for t in suite_on.get("tests", [])],
        "sampled": suite_on.get("sampled"),
        "raw": "results2/correctness/suite_on_v3_completion.json",
    },
    "suite_mtp_off_ctx131072_no_spec": {
        "summary": suite_off.get("summary"),
        "tests": [{"test": t["test"], "pass": t["pass"], "tok_s": t["tok_s"],
                   "prompt_n": t["prompt_n"]} for t in suite_off.get("tests", [])],
        "sampled": suite_off.get("sampled"),
        "raw": "results2/correctness/suite_off_v3_completion.json",
    },
    "semantic_smoke_mtp_on": sem_on,
    "semantic_smoke_mtp_off": sem_off,
    "usage_as_restore_target": "Compare future restore checks against "
        "semantic_smoke_mtp_on.semantic_smoke out_heads (recorded with cache_prompt=False "
        "per request; determinism self-check identical=true). Character-exact match "
        "required only for heads marked pass=true here.",
}

for p in (f"{R2}/baseline_v3.json", f"{ROOT}/experiments/phase0/baseline_v3.json"):
    json.dump(baseline, open(p, "w"), indent=1)

print(json.dumps({
    "on_summary": suite_on.get("summary"), "off_summary": suite_off.get("summary"),
    "model_sha_ok": baseline["model"]["sha256"].startswith("fd4730dd"),
    "bin_sha_ok": baseline["binary"]["sha256"].startswith("280556cc"),
    "written": ["results2/correctness/baseline_v3.json",
                "experiments/phase0/baseline_v3.json"]}, indent=1))
