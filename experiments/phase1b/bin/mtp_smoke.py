#!/usr/bin/env python3
# MTP ON quick smoke: TR/EN greedy, JSON shape output, draft counters present.
import json
import re
import subprocess
import sys

from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "results"))
from bench import post, metrics  # noqa: E402


def gen(prompt, n):
    body, wall = post("/completion", {
        "prompt": prompt, "n_predict": n, "temperature": 0.0, "top_k": 1,
        "cache_prompt": False, "ignore_eos": True, "stream": False, "seed": 1234,
    })
    t = body.get("timings", {})
    return {
        "text": body.get("content", ""),
        "wall_s": round(wall, 2),
        "prompt_n": t.get("prompt_n"),
        "predicted_n": t.get("predicted_n"),
        "tg_tok_s": round(t["predicted_per_second"], 2) if t.get("predicted_per_second") else None,
        "draft_n": t.get("draft_n"),
        "draft_n_accepted": t.get("draft_n_accepted"),
    }


def main(outjson):
    out = {"tag": "mtp_on_smoke", "tests": []}

    def rec(name, r, check, expect=""):
        ok = bool(check)
        out["tests"].append({"test": name, "pass": ok, "expect": expect,
                             "head": r["text"][:120].replace("\n", " "),
                             "draft_n": r["draft_n"],
                             "draft_n_accepted": r["draft_n_accepted"],
                             "tg_tok_s": r["tg_tok_s"]})
        return ok

    all_ok = True

    r = gen("Q: What is the capital of France? Answer with the city name only.\nA:", 32)
    all_ok &= rec("en_factual_paris", r, "Paris" in r["text"], "Paris")

    r = gen("Soru: Turkiye'nin baskenti hangisidir? Yalnizca sehir adini yaz.\nCevap:", 32)
    all_ok &= rec("tr_factual_ankara", r, "Ankara" in r["text"], "Ankara")

    r = gen("Q: What is 17 * 23? Answer with the number only.\nA:", 32)
    all_ok &= rec("math_391", r, "391" in r["text"], "391")

    r = gen('Return a JSON object with keys "name" (string "tulpar") and "year" (number 2026). Output only JSON.', 320)
    txt = r["text"]
    if "</think>" in txt:
        txt = txt.split("</think>", 1)[1]
    mobj = re.search(r"\{[^{}]*\}", txt)
    try:
        obj = json.loads(mobj.group(0)) if mobj else None
        jok = bool(obj) and obj.get("name") == "tulpar" and int(obj.get("year", 0)) == 2026
    except Exception:
        jok = False
    all_ok &= rec("json_shape", r, jok, '{"name":"tulpar","year":2026}')

    m = metrics()
    spec_lines = {k: v for k, v in m.items() if "spec" in k.lower()}
    draft_fields_present = any(
        (t["draft_n"] or 0) > 0 and (t["draft_n_accepted"] or 0) > 0
        for t in out["tests"])
    out["spec_metrics"] = spec_lines
    out["draft_counters_in_timings"] = draft_fields_present
    out["spec_metrics_nonempty"] = len(spec_lines) > 0
    out["all_pass"] = bool(all_ok and draft_fields_present)

    json.dump(out, open(outjson, "w"), indent=1)
    print(json.dumps({"all_pass": out["all_pass"],
                      "n_tests": len(out["tests"]),
                      "passes": sum(1 for t in out["tests"] if t["pass"]),
                      "spec_metric_keys": sorted(spec_lines.keys())[:8],
                      "draft_counters": draft_fields_present}, indent=1))
    sys.exit(0 if out["all_pass"] else 1)


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "/tmp/opencode/smoke_on.json")
