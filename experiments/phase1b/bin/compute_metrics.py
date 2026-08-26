#!/usr/bin/env python3
# Phase-1B metric computation -> summary/performance_summary.md + summary/table.json
import json
import os

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
RAW = f"{ROOT}/experiments/phase1b/raw"
OUT = f"{ROOT}/experiments/phase1b/summary"
os.makedirs(OUT, exist_ok=True)

ARMS = {
    "A1": ("tg-off-1k", 1024), "A2": ("tg-off-16k", 16384),
    "A3": ("tg-off-63k", 64512), "A4": ("tg-on-1k", 1024),
    "A5": ("tg-on-16k", 16384), "A6": ("tg-on-63k", 64512),
    "D1": ("diag-tg-off-16k-goff", 16384), "D2": ("diag-tg-on-16k-goff", 16384),
    "A7": ("tg-off-128k", 131072), "A8": ("tg-on-128k", 131072),
}


def median(v):
    v = sorted(v)
    n = len(v)
    return None if not n else float(v[n // 2] if n % 2 else (v[n // 2 - 1] + v[n // 2]) / 2)


rows = []
table = {}
for aid, (name, ctx) in ARMS.items():
    path = f"{RAW}/{aid}/arm_record.json"
    if not os.path.exists(path):
        continue
    r = json.load(open(path))
    rep_files = sorted((x for x in os.listdir(f"{RAW}/{aid}")
                        if x.startswith("resp_r") and x.endswith(".json")),
                       key=lambda x: int(x.replace("resp_r", "").split(".")[0]))
    reps = [json.load(open(f"{RAW}/{aid}/{f}")) for f in rep_files]
    recs = []
    for i, rr in enumerate(reps, 1):
        t = rr["body"]["timings"]
        recs.append({
            "rep": i, "cache_prompt": i > 1,
            "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
            "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
            "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
            "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
            "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted"),
            "wall_s": rr["wall_s"],
        })
    tg = [x["tg_tok_s"] for x in recs if x["tg_tok_s"]]
    pp_fresh = [x["pp_tok_s"] for x in recs if not x["cache_prompt"] and x["pp_tok_s"]]
    pp_all = [x["pp_tok_s"] for x in recs if x["pp_tok_s"]]
    dn = sum(x["draft_n"] or 0 for x in recs)
    da = sum(x["draft_n_accepted"] or 0 for x in recs)
    row = {
        "arm_id": aid, "name": name, "ctx_target": ctx,
        "mtp": r["mtp"], "graph": r["graph"], "cache": "q4_0",
        "prompt_tokens_median": recs[0]["prompt_n"],
        "predicted_tokens_median": median([x["predicted_n"] for x in recs]),
        "reps": len(recs),
        "tg_med": median(tg), "tg_min": min(tg) if tg else None, "tg_max": max(tg) if tg else None,
        "spread_pct": round((max(tg) - min(tg)) / median(tg) * 100, 2) if tg else None,
        "pp_fresh": median(pp_fresh), "pp_all_med": median(pp_all),
        "acceptance_rate": round(da / dn, 4) if dn else None,
        "draft_n_total": dn, "draft_accepted_total": da,
        "vram_peak_gib": round(r["vram_peak_b"] / 2**30, 2),
        "wall_total_s": round(sum(x["wall_s"] for x in recs), 1),
        "status": r["status"],
        "swap_delta_mib": (r["mem_after"]["swap_used_b"] - r["mem_before"]["swap_used_b"]) // 2**20,
    }
    rows.append(row)
    table[aid] = {"row": row, "reps_raw": recs}

json.dump(table, open(f"{OUT}/table.json", "w"), indent=1)

hdr = ("| arm | context | mtp | graph | cache | prompt_n | pred_n | tg_tok/s med | spread% | pp_tok/s fresh | acc_rate | VRAM peak GiB | wall s | reps | status |\n"
       "|-----|---------|-----|-------|-------|----------|--------|--------------|---------|----------------|----------|---------------|--------|------|--------|\n")
lines = [hdr]
for row in rows:
    lines.append(
        f"| {row['arm_id']} {row['name']} | {row['ctx_target']} | {row['mtp']} | {row['graph']} "
        f"| {row['cache']} | {row['prompt_tokens_median']} | {row['predicted_tokens_median']} "
        f"| {row['tg_med']} | {row['spread_pct']} | {row['pp_fresh']} | {row['acceptance_rate']} "
        f"| {row['vram_peak_gib']} | {row['wall_total_s']} | {row['reps']} | {row['status']} |\n")

with open(f"{OUT}/performance_summary.md", "w") as f:
    f.write("# Phase-1B Performance Summary\n\n")
    f.write("Binary: build-p3/bin/llama-server @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20\n")
    f.write("Server: -c 131072 -ngl 999 -fa on -ctk q4_0 -ctv q4_0 --cache-prompt -t 8 -np 1, host 127.0.0.1:8080\n")
    f.write("Sampling: greedy (temperature 0, top_k 1), seed 1234, ignore_eos, fixed prompts per ctx target.\n")
    f.write("tg = predicted_ms based; pp = fresh-rep prefill (cached reps excluded); e2e wall per rep in raw JSON.\n")
    f.write("Fresh-vs-cached: rep1 cache_prompt=false, reps 2+ cache_prompt=true (identical prompt).\n\n")
    f.writelines(lines)
    f.write("\n## Per-rep raw values\n\n")
    for aid in ARMS:
        if aid not in table:
            continue
        f.write(f"### {aid}\n\n")
        f.write("| rep | cache | prompt_n | prompt_ms | pred_n | pred_ms | pp_tok/s | tg_tok/s | draft_n | draft_acc |\n")
        f.write("|-----|-------|----------|-----------|--------|---------|----------|----------|---------|-----------|\n")
        for x in table[aid]["reps_raw"]:
            f.write(f"| {x['rep']} | {x['cache_prompt']} | {x['prompt_n']} | {round(x['prompt_ms'] or 0,1)} "
                    f"| {x['predicted_n']} | {round(x['predicted_ms'] or 0,1)} | {x['pp_tok_s']} "
                    f"| {x['tg_tok_s']} | {x['draft_n']} | {x['draft_n_accepted']} |\n")
        f.write("\n")

print(open(f"{OUT}/performance_summary.md").read())
