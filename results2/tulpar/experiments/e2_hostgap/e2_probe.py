#!/usr/bin/env python3
# E2 follow-up: gap structure probe. Sizes, positions, kernel-pair census.
import sqlite3, os, sys, argparse, bisect
from collections import Counter

ap = argparse.ArgumentParser()
ap.add_argument("db")
ap.add_argument("--hint-step-ms", type=float, required=True)
ap.add_argument("--steps", type=int, default=64)
a = ap.parse_args()

con = sqlite3.connect(a.db)
tabs = {}
for (t,) in con.execute("SELECT name FROM sqlite_master WHERE type='table'"):
    for pref in ("kernel_dispatch", "info_kernel_symbol", "region", "string"):
        if t.startswith("rocpd_" + pref):
            tabs[pref] = t

kd = con.execute(f"""SELECT d.start, d.end, s.kernel_name FROM {tabs['kernel_dispatch']} d
JOIN {tabs['info_kernel_symbol']} s ON s.id=d.kernel_id ORDER BY d.start""").fetchall()
wend = kd[-1][1]
step_ns = int(a.hint_step_ms * 1e6)
wstart = wend - a.steps * step_ns
K = [(s, e, n) for s, e, n in kd if e > wstart and s < wend]

merged = []
for s, e in sorted((x[0], x[1]) for x in K):
    if merged and s <= merged[-1][1]: merged[-1][1] = max(merged[-1][1], e)
    else: merged.append([s, e])

gaps, prev = [], wstart
for s, e in merged:
    if s > prev: gaps.append((prev, s))
    prev = max(prev, e)
if wend > prev: gaps.append((prev, wend))
gtot = sum(e - s for s, e in gaps)

def cls(d):
    return "<10us" if d < 10000 else "10-100us" if d < 100000 else "100us-1ms" if d < 1000000 else ">1ms"
sz = Counter(); szt = {}
for gs, ge in gaps:
    c = cls(ge - gs)
    sz[c] += 1; szt[c] = szt.get(c, 0) + ge - gs
print(f"window {a.steps} steps, gap total {gtot/1e6:.1f} ms ({100*gtot/(wend-wstart):.1f}% of wall)")
for c in ("<10us", "10-100us", "100us-1ms", ">1ms"):
    print(f"  {c:10s} n={sz.get(c,0):6d} tot={szt.get(c,0)/1e6:8.1f} ms ({100*szt.get(c,0)/gtot:.1f}% of gap)")

# kernel pair census for micro gaps (<10us)
pair_n = Counter(); pair_t = Counter()
starts = [k[0] for k in K]
for gs, ge in gaps:
    if ge - gs >= 10000: continue
    i = bisect.bisect_right(starts, gs) - 1
    if i < 0 or i + 1 >= len(K): continue
    pk, nk = K[i][2], K[i + 1][2]
    key = (short(pk), short(nk)) if False else None

def short(n):
    n = n.split("(")[0]
    return n.replace("_ZL", "").split("ILi")[0][:44]

pair_n = Counter(); pair_t = Counter()
for gs, ge in gaps:
    if ge - gs >= 10000: continue
    i = bisect.bisect_right(starts, gs) - 1
    if i < 0 or i + 1 >= len(K): continue
    key = (short(K[i][2]), short(K[i + 1][2]))
    pair_n[key] += 1; pair_t[key] += ge - gs
print("\ntop micro-gap pairs (<10us), by total time:")
for (pk, nk), t in pair_t.most_common(12):
    print(f"  {t/1e3:8.1f} ms n={pair_n[(pk,nk)]:6d}  {pk} -> {nk}")

# biggest gaps detail with covering host regions
regs = con.execute(f"""SELECT r.start, r.end, st.string FROM {tabs['region']} r
JOIN {tabs['string']} st ON st.id=r.name_id WHERE r.end>{wstart} AND r.start<{wend}
ORDER BY r.start""").fetchall()
rstarts = [r[0] for r in regs]
print("\ntop 12 gaps:")
for gs, ge in sorted(gaps, key=lambda g: -(g[1] - g[0]))[:12]:
    i = bisect.bisect_right(starts, gs) - 1
    pk = K[i][2].replace("_ZL", "").split("ILi")[0][:40] if i >= 0 else "-"
    nk = K[i + 1][2].replace("_ZL", "").split("ILi")[0][:40] if i + 1 < len(K) else "-"
    cov = []
    j = max(bisect.bisect_left(rstarts, gs) - 6, 0)
    while j < len(regs) and regs[j][0] < ge:
        rs, re_, nm = regs[j]
        if min(ge, re_) - max(gs, rs) > 0: cov.append(f"{nm}({(min(ge,re_)-max(gs,rs))/1e3:.0f}us)")
        j += 1
    print(f"  {(ge-gs)/1e3:8.1f} ms  after[{pk}] before[{nk}] cov={cov[:3]}")
