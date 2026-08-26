#!/usr/bin/env python3
# Phase-2B re-run per-arm trace analysis.
# Outputs derived_rerun/<arm>_analysis.json with:
#   phases (probe=PP / main=decode), per-clean-step category busy,
#   quantize counts, GDN share, staging vs tile, inter-kernel gap
#   distribution + transition attribution, effective GEMV bandwidth inputs.
import csv
import statistics
import json
import re
import sys
from collections import defaultdict

from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "experiments/phase2b/bin"))
from analyze_trace import classify, TYPE_NAMES  # noqa: E402

STALL_GAP_NS = 5_000_000  # > 5 ms idle = profiler buffer-flush stall event


def short_name(nm):
    n = nm.replace("void ", "", 1)
    return n.split("<")[0].split("(")[0][:60]


def load(path):
    rows = []
    with open(path) as f:
        r = csv.DictReader(f)
        for row in r:
            if row["Kind"] != "KERNEL_DISPATCH":
                continue
            rows.append((int(row["Start_Timestamp"]), int(row["End_Timestamp"]),
                         row["Kernel_Name"]))
    rows.sort()
    return rows


def main():
    arm, path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
    rows = load(path)
    n_all = len(rows)

    # request boundaries: gaps > 0.5 s. Expected layout:
    #   [load] B0 [startup warmup] B1 [probe request] B2 [main request]
    # fall back to last-two-region assignment for any layout
    bnds = [i for i in range(n_all - 1) if rows[i + 1][0] - rows[i][1] > 5e8]
    if len(bnds) >= 3:
        probe_rows = rows[bnds[-2] + 1:bnds[-1] + 1]
    elif len(bnds) == 2:
        probe_rows = rows[bnds[0] + 1:bnds[1] + 1]
    else:
        probe_rows = []
    dec_rows = rows[bnds[-1] + 1:] if bnds else []

    # segment decode steps by per-step lm_head GEMV marker
    marker = "mul_mat_vec_q<(ggml_type)11,"
    step_idx = [i for i, (s, e, nm) in enumerate(dec_rows) if marker in nm]
    steps = []
    prev_end = dec_rows[0][0] if dec_rows else 0
    for k, i in enumerate(step_idx):
        nxt = dec_rows[step_idx[k + 1]][0] if k + 1 < len(step_idx) else dec_rows[-1][1]
        steps.append({"i0": prev_i if False else (step_idx[k - 1] + 1 if k else 0),
                      "i1": i, "t0": prev_start if False else None})
        prev_end = nxt
    # simpler: rebuild with explicit bounds
    # segment k spans [prev_marker+1 .. marker_k]; wall ends at THIS marker
    steps = []
    lo = 0
    for k, i in enumerate(step_idx):
        hi = i
        t0 = dec_rows[lo][0]
        t_end = dec_rows[hi][1]
        wall_ms = (dec_rows[i][0] - t0) / 1e6
        steps.append({"lo": lo, "hi": hi, "wall_ms": wall_ms,
                      "busy_ms": (t_end - t0) / 1e6})
        lo = hi + 1

    walls = sorted(s["wall_ms"] for s in steps if s["wall_ms"])
    med_wall = walls[len(walls) // 2] if walls else 0
    clean = [k for k, s in enumerate(steps) if s["wall_ms"] and s["wall_ms"] <= med_wall * 1.3]

    # per-step category aggregates over clean steps
    cat_calls = defaultdict(int)
    cat_busy_ms = defaultdict(float)
    cat_gap_before_ms = defaultdict(float)
    trans_gap_ms = defaultdict(float)
    trans_cnt = defaultdict(int)
    gap_list_ns = []
    stall_events = []       # (step_no, gap_ms, prev->next)
    overlaps_ns = 0
    quant_per_step = []
    gdn_per_step = []
    stage_per_step = []
    tile_per_step = []
    gemv_xxs_per_step = []
    busy_total_per_step = []
    smalltail_per_step = []

    SMALL = {"NORM_ROPE_ACT", "KV_STORE_COPY", "QUANT_ROW_decode"}

    for k in clean:
        s = steps[k]
        seg = dec_rows[s["lo"]:s["hi"] + 1]
        qb = defaultdict(float)
        qn = defaultdict(int)
        for j in range(len(seg)):
            st, en, nm = seg[j]
            c = classify(nm)
            qn[c] += 1
            qb[c] += (en - st) / 1e6
            if j > 0:
                pst, pen, pnm = seg[j - 1]
                g = st - pen
                if g < 0:
                    overlaps_ns += -g
                    g = 0
                pc = classify(pnm)
                cat_gap_before_ms[c] += g / 1e6
                key = f"{short_name(pnm)} -> {short_name(nm)}"
                trans_gap_ms[key] += g / 1e6
                trans_cnt[key] += 1
                if g >= STALL_GAP_NS:
                    stall_events.append({"step": k, "gap_ms": round(g / 1e6, 3),
                                         "after": short_name(pnm), "before": short_name(nm)})
                elif g > 0:
                    gap_list_ns.append(g)
        for c, v in qb.items():
            cat_calls[c] += qn[c]
            cat_busy_ms[c] += v
        n_steps = len(clean)
        quant_per_step.append(qn.get("QUANT_ROW_decode", 0))
        gdn_per_step.append(qb.get("GDN", 0.0))
        stage_per_step.append(qb.get("STAGING_dequant", 0.0))
        tile_per_step.append(qb.get("ATTN_FA_TILE", 0.0))
        gemv_xxs_per_step.append(qb.get("GEMV_IQ3_XXS", 0.0))
        bt = sum(qb.values())
        busy_total_per_step.append(bt)
        smalltail_per_step.append(sum(v for c, v in qb.items() if c in SMALL))

    ns = len(clean)
    gap_list_ns.sort()

    # sampling tail: marker END -> next step's FIRST kernel start (intersegment)
    tails_ms = []
    for k in clean:
        if k + 1 >= len(steps):
            continue
        nxt_lo = steps[k + 1]["lo"]
        m_end = dec_rows[steps[k]["hi"]][1]
        f_next = dec_rows[nxt_lo][0]
        g = f_next - m_end
        if 0 < g < STALL_GAP_NS:
            tails_ms.append(g / 1e6)
    tails_ms.sort()

    def pct(arr, p):
        if not arr:
            return None
        i = min(len(arr) - 1, int(len(arr) * p))
        return round(arr[i] / 1e6, 4)

    total_gap_ms = sum(gap_list_ns) / 1e6
    top_trans = sorted(trans_gap_ms.items(), key=lambda kv: -kv[1])[:15]

    res = {
        "arm": arm,
        "trace_csv": path,
        "dispatches_total": n_all,
        "request_boundary_idxs": bnds,
        "probe_kernels": len(probe_rows),
        "decode_kernels": len(dec_rows),
        "steps_found": len(steps),
        "median_step_wall_ms": round(med_wall, 3),
        "clean_steps_used": ns,
        "clean_step_indices": clean,
        "excluded_steps": [k for k in range(len(steps)) if k not in set(clean)],
        "per_step_means_over_clean": {
            "step_wall_ms": round(sum(steps[k]["wall_ms"] for k in clean) / ns, 3),
            "kernel_busy_ms": round(sum(busy_total_per_step) / ns, 3),
            "gap_nonstall_ms": round(total_gap_ms / ns, 4),
            "quantize_row_launches": round(sum(quant_per_step) / ns, 2),
            "quantize_row_ms": round(sum(cat_busy_ms[c] for c in ["QUANT_ROW_decode"]) / ns, 4),
            "gdn_ms": round(sum(gdn_per_step) / ns, 4),
            "staging_dequant_ms": round(sum(stage_per_step) / ns, 4),
            "attn_tile_ms": round(sum(tile_per_step) / ns, 4),
            "gemv_iq3_xxs_ms": round(sum(gemv_xxs_per_step) / ns, 4),
            "small_kernel_tail_ms": round(sum(smalltail_per_step) / ns, 4),
        },
        "categories_over_clean": {
            c: {
                "calls_per_step": round(cat_calls[c] / ns, 2),
                "ms_per_step": round(cat_busy_ms[c] / ns, 4),
                "gap_before_ms_per_step": round(cat_gap_before_ms[c] / ns, 4),
                "pct_of_busy": round(cat_busy_ms[c] / sum(cat_busy_ms.values()) * 100, 2),
            }
            for c in sorted(cat_busy_ms, key=lambda c: -cat_busy_ms[c])
        },
        "gap_distribution": {
            "count": len(gap_list_ns),
            "total_ms": round(total_gap_ms, 2),
            "mean_ns": round(sum(gap_list_ns) / len(gap_list_ns)) if gap_list_ns else 0,
            "median_ms": pct(gap_list_ns, 0.50),
            "p90_ms": pct(gap_list_ns, 0.90),
            "p95_ms": pct(gap_list_ns, 0.95),
            "p99_ms": pct(gap_list_ns, 0.99),
            "max_ms": round(gap_list_ns[-1] / 1e6, 4) if gap_list_ns else None,
            "overlaps_sum_ms": round(overlaps_ns / 1e6, 3),
            "sampling_tail_ms_median": round(statistics.median(tails_ms), 4) if tails_ms else None,
            "sampling_tail_ms_mean": round(sum(tails_ms) / len(tails_ms), 4) if tails_ms else None,
            "stall_events_ge5ms": stall_events,
            "stalls_total_ms": round(sum(e["gap_ms"] for e in stall_events), 2),
        },
        "top_gap_transitions": [
            {"transition": k, "total_ms": round(v, 3), "count": trans_cnt[k],
             "mean_ms": round(v / trans_cnt[k], 5)}
            for k, v in top_trans
        ],
        "pp_probe_phase": None,
    }

    # prefill-phase category split (probe request)
    if probe_rows:
        agg = defaultdict(lambda: [0, 0])
        for st, en, nm in probe_rows:
            c = classify(nm)
            agg[c][0] += 1
            agg[c][1] += en - st
        busy = sum(v[1] for v in agg.values())
        res["pp_probe_phase"] = {
            "kernels": len(probe_rows),
            "busy_s": round(busy / 1e9, 3),
            "span_s": round((probe_rows[-1][1] - probe_rows[0][0]) / 1e9, 3),
            "categories_pct": {
                c: round(v[1] / busy * 100, 2)
                for c, v in sorted(agg.items(), key=lambda kv: -kv[1][1])
            },
            "calls": {c: agg[c][0] for c in sorted(agg, key=lambda c: -agg[c][1])},
        }

    with open(out_path, "w") as f:
        json.dump(res, f, indent=1)
    print(json.dumps({k: res[k] for k in
                      ("arm", "steps_found", "median_step_wall_ms",
                       "clean_steps_used")}, indent=1))
    print(json.dumps(res["per_step_means_over_clean"], indent=1))


if __name__ == "__main__":
    main()
