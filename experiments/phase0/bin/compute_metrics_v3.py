#!/usr/bin/env python3
# Aggregate V3 baseline ladder arm_record.json files -> summary tables.
import json, os

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
RAW = f"{ROOT}/experiments/phase0/raw"
OUT = f"{ROOT}/experiments/phase0/summary"
os.makedirs(OUT, exist_ok=True)

ARMS = [
    ("off-1k", 1024), ("off-16k", 16384), ("off-63k", 64512),
    ("off-128k", 131072), ("off-131k", 135168),
    ("on-1k", 1024), ("on-16k", 16384), ("on-63k", 64512),
    ("on-128k", 131072), ("on-131k", 135168),
    ("on-16k-r2", 16384), ("on-63k-r2", 64512),
]

def median(v):
    v = sorted(v); n = len(v)
    return None if not n else float(v[n // 2] if n % 2 else (v[n // 2 - 1] + v[n // 2]) / 2)

rows, table = [], {}
for name, ctx_t in ARMS:
    path = f"{RAW}/{name}/arm_record.json"
    if not os.path.exists(path):
        rows.append({"arm": name, "status": "NOT_MEASURED"}); continue
    r = json.load(open(path))
    recs = []
    rep_files = sorted((x for x in os.listdir(f"{RAW}/{name}")
                        if x.startswith("resp_r") and x.endswith(".json")),
                       key=lambda x: int(x.replace("resp_r", "").split(".")[0]))
    for i, f in enumerate(rep_files, 1):
        t = json.load(open(f"{RAW}/{name}/{f}"))["body"]["timings"]
        recs.append({
            "rep": i, "cache_prompt": i > 1,
            "prompt_n": t.get("prompt_n"), "prompt_ms": t.get("prompt_ms"),
            "predicted_n": t.get("predicted_n"), "predicted_ms": t.get("predicted_ms"),
            "pp_tok_s": round(t["prompt_n"] / t["prompt_ms"] * 1000, 2) if t.get("prompt_ms") else None,
            "tg_tok_s": round(t["predicted_n"] / t["predicted_ms"] * 1000, 3) if t.get("predicted_ms") else None,
            "draft_n": t.get("draft_n"), "draft_n_accepted": t.get("draft_n_accepted"),
            "wall_s": None,
        })
    tg_all = [x["tg_tok_s"] for x in recs if x["tg_tok_s"]]
    pp_fresh = [x["pp_tok_s"] for x in recs if not x["cache_prompt"] and x["pp_tok_s"]]
    spread = round((max(tg_all) - min(tg_all)) / max(tg_all) * 100, 2) if len(tg_all) > 1 else None
    dn = sum(x["draft_n"] or 0 for x in recs)
    da = sum(x["draft_n_accepted"] or 0 for x in recs)
    row = {
        "arm": name, "ctx_target": ctx_t, "ctx_size_used": r["ctx_size"],
        "mtp": r["mtp"], "graph": r["graph"], "kv_cache": "q4_0/q4_0",
        "status": r["status"], "health_after_reps": r.get("health_after_reps"),
        "reps": len(recs),
        "prompt_n_rep1": recs[0]["prompt_n"], "npred": r["n_predict"],
        "tg_med": median(tg_all), "tg_min": min(tg_all) if tg_all else None,
        "tg_max": max(tg_all) if tg_all else None, "tg_spread_pct": spread,
        "pp_fresh_med": median(pp_fresh), "pp_fresh_rep1": pp_fresh[0] if pp_fresh else None,
        "vram_peak_gib": r.get("vram_peak_gib"),
        "swap_delta_gb": round((r["mem_after"]["swap_used_b"] - r["mem_before"]["swap_used_b"]) / 1e9, 3)
            if r.get("mem_after") else None,
        "acceptance_rate": round(da / dn, 4) if dn else None,
        "wall_s_total": round(sum(x.get("wall_s") or json.load(open(f"{RAW}/{name}/resp_r{x['rep']}.json"))["wall_s"] for x in recs), 1),
        "finished_ts": r.get("finished_ts"),
    }
    rows.append(row)
    table[name] = row

json.dump({"rows": rows}, open(f"{OUT}/table_v3.json", "w"), indent=1)

hdr = "| arm | ctx used | prompt_n | npred | reps | tg med | spread% | pp fresh | acc | vram peak GiB | swap dGB | status |"
print(hdr)
print("|" + "---|" * 12)
for row in rows:
    if row.get("status") == "NOT_MEASURED":
        print(f"| {row['arm']} | - | - | - | - | - | - | - | - | - | - | NOT_MEASURED |"); continue
    print("| {arm} | {ctx_size_used} | {prompt_n_rep1} | {npred} | {reps} "
          "| {tg_med} | {tg_spread_pct} | {pp_fresh_rep1} | {acceptance_rate} "
          "| {vram_peak_gib} | {swap_delta_gb} | {status} |".format(**row))

# MTP speedup summary
by_key = {r["arm"]: r for r in rows}
for ctxl in ("1k", "16k", "63k", "128k", "131k"):
    o, n = by_key.get(f"off-{ctxl}"), by_key.get(f"on-{ctxl}")
    if o and n and o.get("tg_med") and n.get("tg_med"):
        print(f"SPEEDUP {ctxl}: +{round((n['tg_med']/o['tg_med']-1)*100,1)}% "
              f"(off {o['tg_med']} vs on {n['tg_med']}; acc {n.get('acceptance_rate')})")
