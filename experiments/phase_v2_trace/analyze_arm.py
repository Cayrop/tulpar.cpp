#!/usr/bin/env python3
"""Analyze one V2 trace arm produced by run_arm.sh.

P trace: model load + prefill of 1591 tokens + 1 decode token.
D trace: model load + prefill of 1591 tokens + 64 decode tokens.

Strategy: use the D trace for both prefill and decode attribution.
- Model load boundary: largest gap (excluding very-early gaps < idx 100).
- Prefill boundary: last `mul_mat_q` (MMQ) dispatch in the inference segment.
  MMQ is prefill-only; decode uses `mul_mat_vec_q` (GEMV).
- Prefill: dispatches [load_end+5, last_mmq]
- Decode:  dispatches [last_mmq+1, end]

P trace is used as a cross-check: P's inference span and total kernel count
should match D's prefill + 1 decode step.
"""
import argparse
import collections
import csv
import json
import os
import re
import statistics
import sys
from pathlib import Path

GGML_TYPE_NAMES = {
    0: "F32", 1: "F16",
    2: "Q4_0", 3: "Q4_1", 6: "Q5_0", 7: "Q5_1",
    8: "Q8_0", 9: "Q8_1",
    10: "Q2_K", 11: "Q3_K", 12: "Q4_K", 13: "Q5_K", 14: "Q6_K", 15: "Q8_K",
    16: "IQ2_XXS", 17: "IQ2_XS", 18: "IQ3_XXS", 19: "IQ1_S", 20: "IQ4_NL",
    21: "IQ3_S", 22: "IQ2_S", 23: "IQ4_XS", 29: "IQ1_M",
}

BYTES_PER_STEP = {}


def parse_dispatches(csv_path: Path) -> list:
    out = []
    if not csv_path.exists():
        return out
    with open(csv_path, newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                bts = int(row["Start_Timestamp"])
                ets = int(row["End_Timestamp"])
            except (KeyError, ValueError):
                continue
            out.append({
                "dispatch_id": int(row["Dispatch_ID"]),
                "grid_size": int(row["Grid_Size"]),
                "workgroup_size": int(row["Workgroup_Size"]),
                "wave_size": int(row["Wave_Size"]),
                "kernel_name": row["Kernel_Name"],
                "begin_ts": bts,
                "end_ts": ets,
                "duration_ns": ets - bts,
            })
    return out


def find_model_load_boundary(disp: list) -> int:
    """Return the index of the first dispatch AFTER model load (i.e., the
    first inference dispatch). Largest gap after idx 100 is the boundary."""
    if len(disp) < 2:
        return 0
    gaps = []
    for i in range(100, len(disp) - 1):
        g = disp[i+1]["begin_ts"] - disp[i]["end_ts"]
        if g > 1e8:  # > 100ms
            gaps.append((g, i))
    if not gaps:
        return 0
    return max(gaps, key=lambda x: x[0])[1] + 1


def find_prefill_boundary(disp: list, inf_start: int) -> int:
    """Return the index of the last MMQ dispatch in the inference segment.
    Prefill uses MMQ; decode uses GEMV. So the last MMQ is the last prefill
    dispatch."""
    last = inf_start - 1
    for i in range(inf_start, len(disp)):
        n = disp[i]["kernel_name"].lower()
        if "mul_mat_q" in n and "mul_mat_vec_q" not in n:
            last = i
    return last


def ggml_type_in_name(name: str):
    m = re.search(r"\(ggml_type\)(\d+)", name)
    return int(m.group(1)) if m else None


def classify(d: dict) -> str:
    name = d["kernel_name"]
    low = name.lower()
    if name.startswith("__amd_rocclr_fillBufferAligned"):
        return "KV_Fill"
    if name.startswith("__amd_rocclr_copyBuffer"):
        return "Copy"
    if "dequantize_block_q4_0" in name or "dequantize_row_q4_0" in name:
        return "Staging_dequant"
    if "quantize_q8_1" in name:
        return "Quantize_q8_1"
    if "quantize_mmq_q8_1" in name:
        return "Quantize_q8_1_MMQ"
    if "quantize_row_q" in name or "quantize_block_q" in name:
        return "Quantize_other"
    if "flash_attn_tile" in low:
        return "FA_tile"
    if "flash_attn_combine" in low:
        return "FA_combine"
    if "gated_delta_net" in low:
        return "GDN"
    if "ssm_conv" in low:
        return "GDN_SSM_Conv"
    if "fwht" in low:
        return "GDN_FWHT"
    if "mul_mat_vec_q" in low:
        gt = ggml_type_in_name(name)
        if gt is None:
            return "GEMV_other"
        return f"GEMV_{GGML_TYPE_NAMES.get(gt, f'TYPE{gt}')}"
    if "mul_mat_q" in low:
        gt = ggml_type_in_name(name)
        if gt is None:
            return "MMQ_other"
        return f"MMQ_{GGML_TYPE_NAMES.get(gt, f'TYPE{gt}')}"
    if "rms_norm" in low:
        return "Norm_RMS"
    if "l2_norm" in low:
        return "Norm_L2"
    if "rope" in low:
        return "RoPE"
    if "k_set_rows_quant" in low or "set_rows_quant" in low:
        return "KV_Store"
    if "k_get_rows" in low or "get_rows" in low:
        return "Get_Rows"
    if "k_bin_bcast" in low or "bin_bcast" in low:
        return "Broadcast"
    if "scale_f32" in low:
        return "Scale"
    if "unary_gated" in low or "unary_op" in low:
        return "Activation"
    if "concat_non_cont" in low or "cpy_" in low:
        return "Copy"
    if "Cijk_" in name:
        return "hipBLAS_GEMM"
    if "convert_unary" in low:
        return "Convert"
    if "dequantize_block" in low:
        return "Dequant_block"
    return "Other"


def aggregate(dispatches: list) -> dict:
    by_cat = collections.defaultdict(lambda: {
        "count": 0, "total_ms": 0.0, "durations_ms": [], "grid_sizes": [],
    })
    for d in dispatches:
        cat = classify(d)
        s = by_cat[cat]
        ms = d["duration_ns"] / 1e6
        s["count"] += 1
        s["total_ms"] += ms
        s["durations_ms"].append(ms)
        s["grid_sizes"].append(d["grid_size"])
    return by_cat


def gap_stats(dispatches: list) -> dict:
    if len(dispatches) < 2:
        return {"count": 0, "total_ms": 0.0, "median_ms": 0.0,
                "p95_ms": 0.0, "p99_ms": 0.0, "max_ms": 0.0}
    gaps = []
    for i in range(1, len(dispatches)):
        g = (dispatches[i]["begin_ts"] - dispatches[i-1]["end_ts"]) / 1e6
        gaps.append(g)
    gaps_sorted = sorted(gaps)
    return {
        "count": len(gaps),
        "total_ms": round(sum(gaps), 3),
        "median_ms": round(gaps_sorted[len(gaps_sorted)//2], 4),
        "p95_ms": round(gaps_sorted[int(len(gaps_sorted)*0.95)], 4),
        "p99_ms": round(gaps_sorted[int(len(gaps_sorted)*0.99)], 4),
        "max_ms": round(max(gaps), 4),
    }


def gemv_bw(dispatches: list, n_decode_tokens: int = 64) -> dict:
    by_type = collections.defaultdict(lambda: {"count": 0, "total_ms": 0.0,
                                              "grid_sizes": []})
    for d in dispatches:
        name = d["kernel_name"]
        if "mul_mat_vec_q" not in name.lower():
            continue
        gt = ggml_type_in_name(name)
        if gt is None:
            continue
        qname = GGML_TYPE_NAMES.get(gt, f"TYPE{gt}")
        s = by_type[qname]
        s["count"] += 1
        s["total_ms"] += d["duration_ns"] / 1e6
        s["grid_sizes"].append(d["grid_size"])
    out = {}
    for q, s in by_type.items():
        bytes_per_step = BYTES_PER_STEP.get(q, 0)
        avg_grid = sum(s["grid_sizes"]) / len(s["grid_sizes"]) if s["grid_sizes"] else 0
        out[q] = {
            "count": s["count"],
            "total_ms": round(s["total_ms"], 3),
            "calls_per_token": round(s["count"] / max(1, n_decode_tokens), 2),
            "avg_grid": int(avg_grid),
            "bytes_per_step": bytes_per_step,
        }
        if bytes_per_step > 0 and s["count"] > 0 and n_decode_tokens > 0:
            ms_per_token = s["total_ms"] / n_decode_tokens
            bytes_per_s = bytes_per_step / (ms_per_token / 1000.0)
            out[q]["effective_BW_GBs"] = round(bytes_per_s / 1e9, 2)
            out[q]["ms_per_token"] = round(ms_per_token, 4)
    return out


def mmq_bw(dispatches: list, n_prefill_tokens: int = 1591) -> dict:
    """BW for MMQ per quant type. Per-token basis."""
    by_type = collections.defaultdict(lambda: {"count": 0, "total_ms": 0.0,
                                              "grid_sizes": []})
    for d in dispatches:
        name = d["kernel_name"]
        if "mul_mat_q" not in name.lower() or "mul_mat_vec_q" in name.lower():
            continue
        gt = ggml_type_in_name(name)
        if gt is None:
            continue
        qname = GGML_TYPE_NAMES.get(gt, f"TYPE{gt}")
        s = by_type[qname]
        s["count"] += 1
        s["total_ms"] += d["duration_ns"] / 1e6
        s["grid_sizes"].append(d["grid_size"])
    out = {}
    for q, s in by_type.items():
        bytes_per_step = BYTES_PER_STEP.get(q, 0)
        out[q] = {
            "count": s["count"],
            "total_ms": round(s["total_ms"], 3),
        }
        if bytes_per_step > 0 and s["count"] > 0 and n_prefill_tokens > 0:
            ms_per_token = s["total_ms"] / n_prefill_tokens
            bytes_per_s = bytes_per_step / (ms_per_token / 1000.0)
            out[q]["effective_BW_GBs"] = round(bytes_per_s / 1e9, 2)
            out[q]["ms_per_token"] = round(ms_per_token, 4)
    return out


def fmt_cat_table(by_cat, total_ms) -> str:
    rows = []
    for cat, s in sorted(by_cat.items(), key=lambda x: -x[1]["total_ms"]):
        pct = 100.0 * s["total_ms"] / total_ms if total_ms else 0.0
        rows.append(f"{cat:<22} {s['count']:>6} {s['total_ms']:>12.3f} {pct:>6.2f}%")
    return "\n".join(rows)


def load_bytes_per_step(path: str | None) -> dict:
    if not path:
        return {}
    with open(path) as f:
        d = json.load(f)
    return {k: int(v) for k, v in d.items()}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("arm")
    ap.add_argument("--bytes-per-step", default=None)
    ap.add_argument("--base-dir", default="experiments/phase_v2_trace/trace_artifacts")
    ap.add_argument("--global-json", default="experiments/phase_v2_trace/attribution.json")
    args = ap.parse_args()

    global BYTES_PER_STEP
    BYTES_PER_STEP = load_bytes_per_step(args.bytes_per_step)

    base = Path(args.base_dir) / args.arm
    p_log = base / "P" / "results_trace_P.csv"
    d_log = base / "D" / "results_trace_D.csv"
    p_resp = base / "P" / "response.json"
    d_resp = base / "D" / "response.json"

    p_disp = parse_dispatches(p_log)
    d_disp = parse_dispatches(d_log)

    # Parse server-reported timings
    p_t = json.load(open(p_resp)).get("timings", {}) if p_resp.exists() else {}
    d_t = json.load(open(d_resp)).get("timings", {}) if d_resp.exists() else {}

    # --- D trace: split into prefill + decode ---
    d_load_end = find_model_load_boundary(d_disp)
    d_inference = d_disp[d_load_end:]
    d_last_mmq = find_prefill_boundary(d_disp, d_load_end)
    d_prefill = d_disp[d_load_end:d_last_mmq + 1]
    d_decode = d_disp[d_last_mmq + 1:]

    # --- P trace: model load + (prefill + 1 decode) ---
    p_load_end = find_model_load_boundary(p_disp)
    p_inference = p_disp[p_load_end:]

    # Aggregate
    p_cat = aggregate(p_inference)
    p_total_ms = sum(s["total_ms"] for s in p_cat.values())
    d_prefill_cat = aggregate(d_prefill)
    d_prefill_total_ms = sum(s["total_ms"] for s in d_prefill_cat.values())
    d_decode_cat = aggregate(d_decode)
    d_decode_total_ms = sum(s["total_ms"] for s in d_decode_cat.values())

    # Token estimate: count FA_tile in decode / 17 attn layers, count GDN_FWHT / 48 GDN layers
    fa_count = d_decode_cat.get("FA_tile", {"count": 0})["count"]
    fwht_count = d_decode_cat.get("GDN_FWHT", {"count": 0})["count"]
    tokens_from_fa = fa_count // 17 if fa_count else 0
    tokens_from_fwht = fwht_count // 48 if fwht_count else 0
    tokens_estimated = max(tokens_from_fa, tokens_from_fwht)
    n_predict = int(d_t.get("predicted_n", 64))

    # BW
    d_decode_bw = gemv_bw(d_decode, n_decode_tokens=tokens_estimated if tokens_estimated else n_predict)
    d_prefill_bw = mmq_bw(d_prefill, n_prefill_tokens=int(d_t.get("prompt_n", 0)) or len(d_prefill))
    d_decode_gaps = gap_stats(d_decode)
    d_prefill_gaps = gap_stats(d_prefill)
    p_inference_gaps = gap_stats(p_inference)

    # VRAM (if available)
    p_vram_peak_b = None
    d_vram_peak_b = None

    result = {
        "arm": args.arm,
        "server_timings": {
            "p_prompt_ms": p_t.get("prompt_ms"),
            "p_prompt_n": p_t.get("prompt_n"),
            "p_predicted_ms": p_t.get("predicted_ms"),
            "p_predicted_n": p_t.get("predicted_n"),
            "d_prompt_ms": d_t.get("prompt_ms"),
            "d_prompt_n": d_t.get("prompt_n"),
            "d_predicted_ms": d_t.get("predicted_ms"),
            "d_predicted_n": d_t.get("predicted_n"),
        },
        "trace_counts": {
            "p_total_dispatches": len(p_disp),
            "p_inference_dispatches": len(p_inference),
            "d_total_dispatches": len(d_disp),
            "d_load_end_idx": d_load_end,
            "d_prefill_dispatches": len(d_prefill),
            "d_decode_dispatches": len(d_decode),
            "d_last_mmq_idx": d_last_mmq,
        },
        "tokens_estimated": tokens_estimated,
        "tokens_from_fa": tokens_from_fa,
        "tokens_from_fwht": tokens_from_fwht,
        "n_predict": n_predict,
        "prefill": {
            "total_ms": round(d_prefill_total_ms, 3),
            "category": {cat: {"count": s["count"], "total_ms": round(s["total_ms"], 3),
                                "pct": round(100.0 * s["total_ms"] / d_prefill_total_ms, 2) if d_prefill_total_ms else 0}
                          for cat, s in sorted(d_prefill_cat.items(), key=lambda x: -x[1]["total_ms"])},
            "mmq_bw": d_prefill_bw,
            "gaps_ms": d_prefill_gaps,
        },
        "decode": {
            "total_ms": round(d_decode_total_ms, 3),
            "category": {cat: {"count": s["count"], "total_ms": round(s["total_ms"], 3),
                                "pct": round(100.0 * s["total_ms"] / d_decode_total_ms, 2) if d_decode_total_ms else 0,
                                "avg_ms": round(s["total_ms"]/s["count"], 4) if s["count"] else 0}
                          for cat, s in sorted(d_decode_cat.items(), key=lambda x: -x[1]["total_ms"])},
            "gemv_bw": d_decode_bw,
            "gaps_ms": d_decode_gaps,
        },
        "p_inference_for_reference": {
            "total_ms": round(p_total_ms, 3),
            "category": {cat: {"count": s["count"], "total_ms": round(s["total_ms"], 3)}
                          for cat, s in sorted(p_cat.items(), key=lambda x: -x[1]["total_ms"])},
        },
    }

    out_json = base / "analysis.json"
    with open(out_json, "w") as f:
        json.dump(result, f, indent=2)

    # Append to global JSON
    global_path = Path(args.global_json)
    global_path.parent.mkdir(parents=True, exist_ok=True)
    if global_path.exists():
        with open(global_path) as f:
            existing = json.load(f)
    else:
        existing = []
    existing = [x for x in existing if x.get("arm") != args.arm]
    existing.append(result)
    with open(global_path, "w") as f:
        json.dump(existing, f, indent=2)

    # Console summary
    print(f"== ARM {args.arm} ==")
    print(f"P dispatches: total={len(p_disp)}  inference={len(p_inference)}")
    print(f"D dispatches: total={len(d_disp)}  load_end={d_load_end}  "
          f"prefill={len(d_prefill)}  decode={len(d_decode)}  "
          f"last_mmq_idx={d_last_mmq}")
    print(f"Tokens: estimated={tokens_estimated}  "
          f"(fa={tokens_from_fa} fwht={tokens_from_fwht})  n_predict={n_predict}")
    print(f"\nP inference ({p_total_ms:.1f}ms):")
    print(fmt_cat_table(p_cat, p_total_ms))
    print(f"\nD PREFILL ({d_prefill_total_ms:.1f}ms):")
    print(fmt_cat_table(d_prefill_cat, d_prefill_total_ms))
    print(f"\nD DECODE ({d_decode_total_ms:.1f}ms):")
    print(fmt_cat_table(d_decode_cat, d_decode_total_ms))
    print(f"\nJSON: {out_json}")
    print(f"Global: {global_path}")


if __name__ == "__main__":
    main()
