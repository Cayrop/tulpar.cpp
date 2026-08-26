#!/usr/bin/env python3
"""Extract per-decode-step kernel launch census from a rocprofv3 rocpd DB.

Usage: python3 census_from_rocpd.py <results.db> <out.json> [--prefill-marker 'mul_mat_q%']

Method:
- dispatch rows are in ns; decode phase = rows after the last big MMQ kernel.
- sessions are split at >20 ms holes; the largest session is steady decode.
- step structure found by minimal exact period of the kernel-id sequence.
- gap census and quantize_q8_1 sandwich adjacency computed over full steps.
"""
import sqlite3, sys, json, statistics, bisect
from collections import Counter, defaultdict

db, out = sys.argv[1], sys.argv[2]
marker = sys.argv[4] if len(sys.argv) > 4 else 'void mul_mat_q%'
con = sqlite3.connect(db)
p = [r[0] for r in con.execute("select name from sqlite_master where name like 'rocpd_kernel_dispatch%'")][0]
ks = [r[0] for r in con.execute("select name from sqlite_master where name like 'rocpd_info_kernel_symbol%'")][0]

names = dict(con.execute(f"select id, display_name from {ks}"))
T0 = con.execute(f"select max(d.end) from {p} d join {ks} k on k.id=d.kernel_id where k.display_name like ?", (marker,)).fetchone()[0]
rows = con.execute(f"select d.start, d.end, d.kernel_id from {p} d where d.start>{T0} order by d.start").fetchall()

sess = [[rows[0]]]
for r in rows[1:]:
    if r[0] - sess[-1][-1][1] > 20_000_000:
        sess.append([r])
    else:
        sess[-1].append(r)
S_rows = max(sess, key=len)

seq = [r[2] for r in S_rows]
def period_ok(period, arr):
    n = min(len(arr) - period, 20000)
    return all(arr[i] == arr[i + period] for i in range(n))
P = next(per for per in range(100, 4000) if period_ok(per, seq))
nsteps = len(seq) // P

def short(n):
    return n.replace('void ', '').split('(')[0][:46]

gaps_all, busy_cls, cnt_cls = [], defaultdict(int), defaultdict(int)
qb, qa, qd = [], [], []
adj_before, adj_after = Counter(), Counter()
for i in range(2, nsteps - 1):
    seg = S_rows[i*P:(i+1)*P]
    for j in range(len(seg)):
        n = short(names[seg[j][2]])
        busy_cls[n] += seg[j][1] - seg[j][0]
        cnt_cls[n] += 1
        if j + 1 < len(seg):
            g = seg[j+1][0] - seg[j][1]
            if g > 0:
                gaps_all.append(g)
        if 'quantize_q8_1' in names[seg[j][2]] and 0 < j < len(seg) - 1:
            adj_before[short(names[seg[j-1][2]])] += 1
            adj_after[short(names[seg[j+1][2]])] += 1
            qb.append(seg[j][0] - seg[j-1][1])
            qa.append(seg[j+1][0] - seg[j][1])
            qd.append(seg[j][1] - seg[j][0])

gaps_all.sort()
wall = [ (S_rows[(i+1)*P][0] - S_rows[i*P][0]) / 1e6 for i in range(nsteps - 1) ]
busy_total = sum(r[1] - r[0] for r in S_rows[:nsteps*P]) / 1e6 / nsteps

res = {
    "source_db": db,
    "units": "ns in rocpd; converted to us/ms here",
    "kernels_per_step": P,
    "full_steps_analyzed": nsteps - 4,
    "step_wall_ms_median": round(statistics.median(wall), 3),
    "gpu_busy_ms_per_step": round(busy_total, 3),
    "bubble_ms_per_step": round(statistics.median(wall) - busy_total, 3),
    "gap_census": {
        "gaps_per_step": round(len(gaps_all) / nsteps, 1),
        "gap_sum_ms_per_step": round(sum(gaps_all) / 1e6 / nsteps, 3),
        "buckets_us": {},
    },
    "quantize_q8_1_sandwich": {
        "launches_per_step": round(cnt_cls['quantize_q8_1'] / nsteps, 1),
        "median_duration_us": round(statistics.median(qd) / 1e3, 2),
        "median_gap_before_us": round(statistics.median(qb) / 1e3, 2),
        "median_gap_after_us": round(statistics.median(qa) / 1e3, 2),
        "adjacent_bubble_ms_per_step": round((sum(qb) + sum(qa)) / 1e6 / nsteps, 3),
        "successors": adj_after.most_common(5),
        "predecessors": adj_before.most_common(6),
    },
    "per_class": {
        n: {"launches_per_step": round(c / nsteps, 1),
            "busy_ms_per_step": round(busy_cls[n] / 1e6 / nsteps, 3)}
        for n, c in sorted(cnt_cls.items(), key=lambda x: -x[1])
    },
}
for th in (1, 2, 5, 10, 50, 1000):
    k = bisect.bisect_left(gaps_all, th * 1000)
    res["gap_census"]["buckets_us"][f">={th}"] = {
        "n_per_step": round((len(gaps_all) - k) / nsteps, 1),
        "ms_per_step": round(sum(gaps_all[k:]) / 1e6 / nsteps, 3),
    }
json.dump(res, open(out, 'w'), indent=1)
print("wrote", out, "| kernels/step:", P, "| steps:", nsteps)
