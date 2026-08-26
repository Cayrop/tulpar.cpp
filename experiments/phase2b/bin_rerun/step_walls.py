#!/usr/bin/env python3
# Per-decode-step wall times from a kernel_trace.csv.
# Steps segmented by the per-step lm_head GEMV marker (mul_mat_vec_q Q3_K)
# or, fallback, fixed kernels-per-step periodicity. Prints step wall ms list.
import csv
import sys

path = sys.argv[1]
rows = []  # (start_ns, end_ns, name)
with open(path) as f:
    r = csv.DictReader(f)
    for row in r:
        if row["Kind"] != "KERNEL_DISPATCH":
            continue
        rows.append((int(row["Start_Timestamp"]), int(row["End_Timestamp"]),
                     row["Kernel_Name"]))
rows.sort()
n = len(rows)

# find request boundaries: gaps > 0.5 s
bounds = [i for i in range(n - 1) if rows[i + 1][0] - rows[i][1] > 5e8]
print(f"dispatches={n} big_gaps_at={[(rows[i][0]) for i in bounds]!r}", file=sys.stderr)

# decode region = after last big gap (main request)
start_i = (bounds[-1] + 1) if bounds else 0
dec = rows[start_i:]

# per-step marker: mul_mat_vec_q<(ggml_type)11 (Q3_K lm_head) appears 1x/step
step_idx = []
for i, (s, e, nm) in enumerate(dec):
    if "mul_mat_vec_q<(ggml_type)11," in nm:
        step_idx.append(i)
print(f"decode_kernels={len(dec)} steps_found={len(step_idx)}", file=sys.stderr)

walls = []
for a, b in zip(step_idx, step_idx[1:]):
    walls.append((dec[b][0] - dec[a][0]) / 1e6)
# first partial step from region start
if step_idx:
    walls.insert(0, (dec[step_idx[0]][0] - dec[0][0]) / 1e6)
for i, w in enumerate(walls):
    print(f"step {i:03d} wall_ms {w:.3f}")
