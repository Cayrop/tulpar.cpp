#!/usr/bin/env python3
# E2: attribute GPU-idle gaps in the decode window to host-side API spans.
# Usage: e2_gapattr.py <rocpd.db> --hint-step-ms=X [--steps=64]
import sqlite3, os, sys, json, argparse

ap = argparse.ArgumentParser()
ap.add_argument("db")
ap.add_argument("--hint-step-ms", type=float, required=True)
ap.add_argument("--steps", type=int, default=64)
args = ap.parse_args()

con = sqlite3.connect(args.db)
tabs = {}
for (t,) in con.execute("SELECT name FROM sqlite_master WHERE type='table'"):
    for pref in ("kernel_dispatch", "info_kernel_symbol", "region", "string", "memory_copy"):
        if t.startswith("rocpd_" + pref):
            tabs[pref] = t
            break

def q(sql):
    return con.execute(sql).fetchall()

# kernel dispatches with names
rows = q(f"""
SELECT d.start, d.end, s.kernel_name
FROM {tabs['kernel_dispatch']} d
JOIN {tabs['info_kernel_symbol']} s ON s.id = d.kernel_id
ORDER BY d.start
""")
if rows is None:
    cols = [c[1] for c in con.execute(f"PRAGMA table_info({tabs['kernel_dispatch']})")]
    print("dispatch cols:", cols)
    sys.exit(1)

wend = max(r[1] for r in rows)
step_ns = int(args.hint_step_ms * 1e6)
wstart = wend - args.steps * step_ns

kern = [(s, e, n) for s, e, n in rows if e > wstart and s < wend]

# merge busy intervals
busy = sorted((s, e) for s, e, _ in kern)
merged = []
for s, e in busy:
    if merged and s <= merged[-1][1]:
        merged[-1][1] = max(merged[-1][1], e)
    else:
        merged.append([s, e])
wall = wend - wstart
busy_t = sum(e - s for s, e in merged)
gaps = []
prev = wstart
for s, e in merged:
    if s - prev > 0:
        gaps.append([prev, s])
    prev = max(prev, e)
if wend - prev > 0:
    gaps.append([prev, wend])
gap_t = sum(e - s for s, e in gaps)

# host api regions in window
regs = q(f"SELECT r.start, r.end, st.string FROM {tabs['region']} r "
         f"JOIN {tabs['string']} st ON st.id = r.name_id "
         f"WHERE r.end > {wstart} AND r.start < {wend} ORDER BY r.start")
regs = [(s, e, n) for s, e, n in regs]

import bisect
starts = [r[0] for r in regs]

def overlap_class(gs, ge):
    best = ("none", 0)
    i = bisect.bisect_left(starts, gs) - 4
    if i < 0: i = 0
    while i < len(regs) and regs[i][0] < ge:
        rs, re_, nm = regs[i]
        ov = min(ge, re_) - max(gs, rs)
        if ov > 0 and ov > best[1]:
            best = (nm.split("(")[0].strip(), ov)
        if regs[i][0] > ge + 10_000_000:
            break
        i += 1
    return best[0]

attr = {}
histo = {"<5us": 0, "5-50us": 0, "50-500us": 0, "0.5-2ms": 0, ">2ms": 0}
big_gaps = []
for gs, ge in gaps:
    dur = ge - gs
    c = overlap_class(gs, ge)
    attr[c] = attr.get(c, 0) + dur
    if dur < 5000: histo["<5us"] += 1
    elif dur < 50000: histo["5-50us"] += 1
    elif dur < 500000: histo["50-500us"] += 1
    elif dur < 2_000_000: histo["0.5-2ms"] += 1
    else:
        histo[">2ms"] += 1
        big_gaps.append({"ms": round(dur / 1e6, 3), "class": c})

# memcpy stats in window
mc = q(f"SELECT COUNT(*), SUM(size), SUM(end-start) FROM {tabs['memory_copy']} WHERE end > {wstart} AND start < {wend}")
mc_n, mc_bytes, mc_time = mc[0] if mc[0] else (0, 0, 0)

# per-step boundary structure: classify gap position relative to step starts
step_starts = [wend - step_ns * k for k in range(args.steps, 0, -1)]
inter_step = intra_step = 0
for gs, ge in gaps:
    mid = (gs + ge) / 2
    near = min(abs(mid - ss) for ss in step_starts)
    if near < 0.3 * step_ns:
        inter_step += ge - gs
    else:
        intra_step += ge - gs

res = {
    "db": os.path.basename(args.db),
    "window_ms": round(wall / 1e6, 2),
    "busy_pct": round(100 * busy_t / wall, 2),
    "gap_pct": round(100 * gap_t / wall, 2),
    "n_gaps": len(gaps),
    "gap_by_class_pct_of_gap": {k: round(100 * v / gap_t, 1) for k, v in sorted(attr.items(), key=lambda x: -x[1])},
    "gap_histo_count": histo,
    "inter_step_gap_pct": round(100 * inter_step / max(gap_t, 1), 1),
    "intra_step_gap_pct": round(100 * intra_step / max(gap_t, 1), 1),
    "memcpy_in_window": {"n": mc_n, "MB": round(mc_bytes / 1e6, 1), "time_ms": round(mc_time / 1e6, 2)},
    "top_big_gaps": sorted(big_gaps, key=lambda g: -g["ms"])[:8],
}
outp = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.path.basename(args.db).replace(".db", "") + "_e2.json")
json.dump(res, open(outp, "w"), indent=1)
print(json.dumps(res, indent=1))
