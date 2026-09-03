#!/usr/bin/env python3
# Phase-1 per-arm trace analysis (analyze_arm.py rework, V3-aware).
# Outputs <out_json> with phases (probe=PP / main=decode), per-clean-step
# category busy, quantize counts, GDN share, staging vs tile, inter-kernel
# gap distribution + transition attribution, effective GEMV bandwidth inputs,
# FA-tile template instantiation census (verify-batch evidence).
import csv
import json
import re
import statistics
import sys
from collections import Counter, defaultdict

from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "experiments/phase1/bin"))
from phase1_classify import classify, TYPE_NAMES  # noqa: E402

STALL_GAP_NS = 5_000_000  # > 5 ms idle = profiler buffer-flush stall event

# streamed weight bytes per decode step, MTP OFF, V3
# source: experiments/phase0/v3_quant_distribution.json weight_stream_per_decode_step_mtp_off
STREAM_BYTES = {
    "IQ3_XXS": 2480701440, "IQ2_S": 1534935040, "IQ3_S": 1297612800,
    "IQ2_XXS": 919142400, "Q4_K": 803635200, "IQ2_XS": 668344320,
    "IQ4_XS": 551485440, "IQ1_S": 348160000, "Q2_K": 285573120,
    "Q3_K": 105881600, "Q8_0": 25067520, "IQ1_M": 11468800,
    "F32": 10582016, "Q5_K": 7208960,
}


def short_name(nm):
    n = nm.replace("void ", "", 1)
    return n.split("<")[0].split("(")[0][:60]


def load(path):
    rows = []
    with open(path) as f:
        r = csv.DictReader(f)
        for row in r:
            if row.get("Kind") not in (None, "KERNEL_DISPATCH"):
                continue
            try:
                rows.append((int(row["Start_Timestamp"]), int(row["End_Timestamp"]),
                             row["Kernel_Name"]))
            except (KeyError, ValueError):
                continue
    rows.sort()
    return rows


def split_regions(rows, n_big=2):
    """Split on gaps > 0.5 s; return list of regions after the first big gap."""
    ts = [r[0] for r in rows]
    idxs = [i for i in range(len(ts) - 1) if ts[i + 1] - ts[i] > 5e8]
    if not idxs:
        return [rows]
    # regions between consecutive boundaries, excluding load region
    regs = []
    prev = idxs[0]
    for b in idxs[1:]:
        regs.append(rows[prev + 1:b + 1])
        prev = b
    regs.append(rows[prev + 1:])
    # drop empty warmup regions
    return [r for r in regs if r]


COPY_BUF = "__amd_rocclr_copyBuffer"


def segment_steps_off(dec_rows):
    """MTP OFF decode steps via the lm_head GEMV marker.

    Per-token structure observed on V3 traces (graph-replayed, deterministic):
      [... step kernels ...] mul_mat_vec_q<(ggml_type)12> (lm_head)
      -> idle -> copyBuffer (D2H logits for CPU sampling) -> next step
    Step k spans from just after the previous lm_head through its own
    lm_head; the trailing sampling tail is measured separately.
    """
    marks = [i for i in range(len(dec_rows) - 1)
             if "(ggml_type)12," in dec_rows[i][2]
             and COPY_BUF in dec_rows[i + 1][2]]
    if len(marks) < 3:
        return []
    steps = []
    for k in range(1, len(marks)):
        lo = marks[k - 1] + 1
        hi = marks[k]
        steps.append({"lo": lo, "hi": hi,
                      "t_start": dec_rows[lo][0],
                      "n_kernels": hi - lo + 1})
    return steps


def analyze_decode_region(dec_rows, mtp, npred_main):
    res = {}
    fa_templates = Counter()
    gemv_type_counts = Counter()
    mmq_type_counts = Counter()
    for _s, _e, nm in dec_rows:
        n = nm.replace("void ", "", 1)
        m = re.match(r"mul_mat_vec_q<\(ggml_type\)(\d+)", n)
        if m:
            gemv_type_counts[TYPE_NAMES.get(m.group(1), m.group(1))] += 1
        m = re.match(r"mul_mat_q<\(ggml_type\)(\d+)", n)
        if m:
            mmq_type_counts[TYPE_NAMES.get(m.group(1), m.group(1))] += 1
        if n.startswith("flash_attn_tile") or n.startswith("flash_attn_ext_vec"):
            fa_templates[n[:120]] += 1

    if mtp == "off":
        steps = segment_steps_off(dec_rows)
        if not steps:
            return {"error": "no_step_marker", "aggregate": None}, None
        # wall = next-step start - this-step start; last step has no successor
        for k in range(len(steps) - 1):
            steps[k]["wall_ms"] = (steps[k + 1]["t_start"] - steps[k]["t_start"]) / 1e6
        steps[-1]["wall_ms"] = None
        walls_all = sorted(s["wall_ms"] for s in steps[:-1] if s["wall_ms"])
        med_wall0 = walls_all[len(walls_all) // 2] if walls_all else 0
        med_kern = statistics.median(s["n_kernels"] for s in steps[:-1])
        clean = [k for k, s in enumerate(steps[:-1])
                 if s["wall_ms"] and 0.7 * med_wall0 <= s["wall_ms"] <= 1.3 * med_wall0
                 and s["n_kernels"] >= 0.8 * med_kern]
        excluded = [k for k in range(len(steps)) if k not in set(clean)]

        cat_calls = defaultdict(int)
        cat_busy_ms = defaultdict(float)
        cat_gap_before_ms = defaultdict(float)
        trans_gap_ms = defaultdict(float)
        trans_cnt = defaultdict(int)
        gap_list_ns = []
        stall_events = []
        overlaps_ns = 0
        per_step_cat_busy = defaultdict(list)

        for k in clean:
            s = steps[k]
            seg = dec_rows[s["lo"]:s["hi"] + 1]
            qb = defaultdict(float)
            qn = defaultdict(int)
            for j, (st, en, nm) in enumerate(seg):
                c = classify(nm)
                qn[c] += 1
                dur = (en - st) / 1e6
                qb[c] += dur
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
                                             "after": short_name(pnm),
                                             "before": short_name(nm)})
                    elif g > 0:
                        gap_list_ns.append(g)
            for c in qb:
                cat_calls[c] += qn[c]
                cat_busy_ms[c] += qb[c]
                per_step_cat_busy[c].append(qb[c])
            # force presence of key categories even when zero in a step
            for c in ("GEMV_IQ3_XXS", "STAGING_dequant", "ATTN_FA_TILE",
                      "QUANT_ROW_decode", "GDN", "KV_STORE_COPY"):
                per_step_cat_busy[c].append(qb.get(c, 0.0))

        ns = len(clean)
        gap_list_ns.sort()

        def pct(arr, p):
            if not arr:
                return None
            return round(arr[min(len(arr) - 1, int(len(arr) * p))] / 1e6, 4)

        total_gap_ms = sum(gap_list_ns) / 1e6
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

        busy_all = sum(cat_busy_ms.values())
        cats = {}
        for c in sorted(cat_busy_ms, key=lambda c: -cat_busy_ms[c]):
            v = cat_busy_ms[c]
            series = per_step_cat_busy[c]
            cats[c] = {
                "calls_per_step": round(cat_calls[c] / ns, 2),
                "ms_per_step": round(v / ns, 4),
                "pct_of_busy": round(v / busy_all * 100, 2),
                "gap_before_ms_per_step": round(cat_gap_before_ms[c] / ns, 4),
                "ms_per_step_std": round(statistics.pstdev(series), 4) if len(series) > 1 else 0.0,
            }

        top_trans = sorted(trans_gap_ms.items(), key=lambda kv: -kv[1])[:20]
        agg = {
            "steps_found": len(steps),
            "clean_steps_used": ns,
            "excluded_steps": excluded,
            "median_step_wall_ms": round(med_wall0, 4),
            "mean_clean_wall_ms": round(sum(steps[k]["wall_ms"] for k in clean) / ns, 4),
            "kernel_busy_ms_per_token": round(busy_all / ns, 4),
            "gap_nonstall_ms_per_token": round(total_gap_ms / ns, 4),
            "sampling_tail_ms_median": round(statistics.median(tails_ms), 4) if tails_ms else None,
            "sampling_tail_ms_mean": round(sum(tails_ms) / len(tails_ms), 4) if tails_ms else None,
            "gpu_idle_ms_per_token": round(total_gap_ms / ns +
                                           (sum(tails_ms) / len(tails_ms) if tails_ms else 0.0), 4),
            "categories": cats,
            "gemv_launches_per_token_by_type": {t: round(c / ns, 2) for t, c in gemv_type_counts.items()},
            "fa_tile_templates": dict(fa_templates.most_common(10)),
            "gap_distribution": {
                "count": len(gap_list_ns),
                "gaps_per_step": round(len(gap_list_ns) / ns, 1),
                "total_nonstall_ms": round(total_gap_ms, 2),
                "median_ms": pct(gap_list_ns, 0.50),
                "p90_ms": pct(gap_list_ns, 0.90),
                "p95_ms": pct(gap_list_ns, 0.95),
                "p99_ms": pct(gap_list_ns, 0.99),
                "max_ms": round(gap_list_ns[-1] / 1e6, 4) if gap_list_ns else None,
                "overlaps_sum_ms": round(overlaps_ns / 1e6, 3),
            },
            "top_gap_transitions": [
                {"transition": k, "total_ms": round(v, 3), "count": trans_cnt[k],
                 "mean_us": round(v / trans_cnt[k] * 1000, 2)}
                for k, v in top_trans],
            "stall_events_ge5ms": stall_events[:40],
            "stalls_total_ms": round(sum(e["gap_ms"] for e in stall_events), 2),
        }
        res = {"decode_mode": "per_step", "aggregate": agg}
        return res, agg

    # MTP ON: aggregate attribution over the request, normalized by tokens
    agg_by_cat = defaultdict(lambda: [0, 0])
    for st, en, nm in dec_rows:
        c = classify(nm)
        agg_by_cat[c][0] += 1
        agg_by_cat[c][1] += en - st
    span_s = (dec_rows[-1][1] - dec_rows[0][0]) / 1e9
    busy_ms = sum(v[1] for v in agg_by_cat.values()) / 1e6
    cats = {}
    for c, (calls, dns) in sorted(agg_by_cat.items(), key=lambda kv: -kv[1][1]):
        cats[c] = {
            "calls_total": calls,
            "total_ms": round(dns / 1e6, 3),
            "ms_per_generated_token": round(dns / 1e6 / npred_main, 4),
            "pct_of_busy": round(dns / 1e6 / busy_ms * 100, 2),
        }
    agg = {
        "mode": "aggregate_mtp_on",
        "generated_tokens": npred_main,
        "span_s": round(span_s, 3),
        "busy_ms": round(busy_ms, 1),
        "avg_span_ms_per_token": round(span_s * 1000 / npred_main, 4),
        "kernel_busy_ms_per_generated_token": round(busy_ms / npred_main, 4),
        "categories": cats,
        "gemv_launches_per_generated_token_by_type":
            {t: round(c / npred_main, 2) for t, c in gemv_type_counts.items()},
        "fa_tile_templates": dict(fa_templates.most_common(10)),
        "note": "per-token segmentation not valid under MTP drafting; "
                "attribution normalized by server-predicted_n",
    }
    return {"decode_mode": "aggregate", "aggregate": agg}, None


def analyze_pp_region(pp_rows, prompt_n=None):
    if not pp_rows:
        return None
    agg = defaultdict(lambda: [0, 0])
    for st, en, nm in pp_rows:
        c = classify(nm)
        agg[c][0] += 1
        agg[c][1] += en - st
    busy = sum(v[1] for v in agg.values())
    out = {
        "kernels": len(pp_rows),
        "busy_s": round(busy / 1e9, 3),
        "span_s": round((pp_rows[-1][1] - pp_rows[0][0]) / 1e9, 3),
        "categories_pct": {c: round(v[1] / busy * 100, 2)
                           for c, v in sorted(agg.items(), key=lambda kv: -kv[1][1])},
        "categories_ms_abs": {c: round(v[1] / 1e6, 1)
                              for c, v in sorted(agg.items(), key=lambda kv: -kv[1][1])},
        "calls": {c: agg[c][0] for c in sorted(agg, key=lambda c: -agg[c][1])},
    }
    if prompt_n:
        out["ms_per_prompt_token_busy"] = round(busy / 1e6 / prompt_n, 4)
    return out


def main():
    arm, path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
    mtp = sys.argv[4] if len(sys.argv) > 4 else "off"
    npred_main = int(sys.argv[5]) if len(sys.argv) > 5 else 0
    prompt_n = int(sys.argv[6]) if len(sys.argv) > 6 else 0
    skip_probe = (len(sys.argv) > 7 and sys.argv[7] == "skip_probe")

    rows = load(path)
    regs = split_regions(rows)
    # expected layout after load gap: [probe][main]; with skip_probe: [main]
    probe_rows = [] if skip_probe or len(regs) < 2 else regs[-2]
    dec_rows = regs[-1]

    dec_res, agg = analyze_decode_region(dec_rows, mtp, npred_main)
    res = {
        "arm": arm,
        "mtp": mtp,
        "trace_csv": path,
        "dispatches_total": len(rows),
        "regions_after_load": len(regs),
        "probe_kernels": len(probe_rows),
        "decode_kernels": len(dec_rows),
        "decode": dec_res,
        "pp_probe_phase": analyze_pp_region(probe_rows, prompt_n),
    }
    with open(out_path, "w") as f:
        json.dump(res, f, indent=1)
    brief = {"arm": arm, "decode_kernels": len(dec_rows)}
    if agg:
        brief["median_step_wall_ms"] = agg.get("median_step_wall_ms")
        brief["clean_steps_used"] = agg.get("clean_steps_used")
        brief["kernel_busy_ms_per_token"] = agg.get("kernel_busy_ms_per_token")
        brief["gap_nonstall_ms_per_token"] = agg.get("gap_nonstall_ms_per_token")
    print(json.dumps(brief, indent=1))


if __name__ == "__main__":
    main()
