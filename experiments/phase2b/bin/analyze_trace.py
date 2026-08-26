#!/usr/bin/env python3
# Phase-2B trace analyzer: phases, categories, derived metrics.
# Phase split discriminator: quantize_mmq_q8_1 (prefill-only) vs
# quantize_q8_1 row kernel (decode-only, modulo 1 lm_head-input quantize
# per prefill, noted as minor contamination).
import csv
import json
import re
import sys
from collections import defaultdict

TYPE_NAMES = {"18": "IQ3_XXS", "21": "IQ3_S", "23": "IQ4_XS", "29": "IQ1_M",
              "11": "Q3_K", "8": "Q8_0", "2": "Q4_0"}


def base_name(full):
    return full.replace("void ", "", 1)


def classify(name):
    n = base_name(name)
    m = re.match(r"mul_mat_vec_q<\(ggml_type\)(\d+)", n)
    if m:
        t = TYPE_NAMES.get(m.group(1), f"type{m.group(1)}")
        return f"GEMV_{t}"
    if n.startswith("mul_mat_q<"):
        m = re.match(r"mul_mat_q<\(ggml_type\)(\d+)", n)
        t = TYPE_NAMES.get(m.group(1), f"type{m.group(1)}") if m else "?"
        return f"MMQ_GEMM_{t}"
    if n.startswith("quantize_mmq_q8_1"):
        return "QUANT_MMQ_prefill"
    if n.startswith("quantize_q8_1") or n.startswith("quantize_scatter"):
        return "QUANT_ROW_decode"
    if n.startswith(("dequantize_block_",)) or "_to_fp16" in n.split("<")[0]:
        return "STAGING_dequant"
    if n.startswith("convert_unary<float, __half>"):
        return "STAGING_f32_to_f16"
    if n.startswith("convert_unary<__half, float>"):
        return "STAGING_f16_to_f32"
    if n.startswith("flash_attn_tile") or n.startswith("flash_attn_combine_results"):
        return "ATTN_FA_TILE"
    if n.startswith("flash_attn_ext_vec"):
        return "ATTN_VEC_surprise"
    if n.startswith("k_set_rows_quant") or n.startswith("cpy_scalar") or \
       n.startswith("cpy_q_f32") or n.startswith("cpy_f32"):
        return "KV_STORE_COPY"
    if n.startswith(("rms_norm", "l2_norm", "rope_", "unary_gated_op",
                     "unary_op_kernel", "k_bin_bcast", "scale_f32", "concat_")):
        return "NORM_ROPE_ACT"
    if n.startswith(("gated_delta_net_cuda", "ssm_conv", "fwht_cuda")):
        return "GDN"
    if n.startswith("Cijk_Alik"):
        return "ROCBLAS_GEMM"
    return "OTHER"


def load_trace(path):
    rows = []
    with open(path) as f:
        r = csv.DictReader(f)
        for row in r:
            rows.append((int(row["Start_Timestamp"]), int(row["End_Timestamp"]),
                         row["Kernel_Name"]))
    rows.sort()
    return rows


def split_phases(rows):
    """Returns dict phase -> list of rows.
    Structure: [load+warmup] BIGGAP [request work]. If a second big gap
    exists (multi-request instance), decode-only region = after it.
    Prefill region ends at last quantize_mmq dispatch."""
    ts = [r[0] for r in rows]
    gaps = sorted(((ts[i + 1] - ts[i], i) for i in range(len(ts) - 1)), reverse=True)
    load_gap, load_idx = gaps[0]
    # second big gap = inter-request boundary (>1s)
    req_gap_idx = None
    for g, i in gaps[1:]:
        if g > 1e9 and i > load_idx:
            req_gap_idx = i
            break
    post_load = rows[load_idx + 1:]
    if req_gap_idx is not None:
        pre_rows = rows[load_idx + 1:req_gap_idx + 1]
        dec_rows = rows[req_gap_idx + 1:]
    else:
        # single request: prefill ends at last mmq dispatch
        prefill_end = None
        for s, e, nm in post_load:
            if base_name(nm).startswith("quantize_mmq_q8_1"):
                prefill_end = e
        if prefill_end is None:
            prefill_end = ts[load_idx]
        pre_rows = [r for r in post_load if r[1] <= prefill_end]
        dec_rows = [r for r in post_load if r[0] > prefill_end]
    return {
        "load": rows[:load_idx + 1],
        "prefill": pre_rows,
        "decode": dec_rows,
    }, load_gap / 1e9


def aggregate(rows):
    agg = defaultdict(lambda: [0, 0])
    for s, e, nm in rows:
        cat = classify(nm)
        agg[cat][0] += 1
        agg[cat][1] += (e - s)
    return {k: {"calls": v[0], "total_ms": round(v[1] / 1e6, 3)}
            for k, v in sorted(agg.items(), key=lambda kv: -kv[1][1])}


def main():
    tag, trace_path, out_json = sys.argv[1], sys.argv[2], sys.argv[3]
    npred = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    rows = load_trace(trace_path)
    phases, load_gap_s = split_phases(rows)
    res = {"tag": tag, "n_dispatch_total": len(rows),
           "load_gap_s": round(load_gap_s, 3), "phases": {}}
    for ph, prows in phases.items():
        if not prows:
            continue
        span_s = (prows[-1][1] - prows[0][0]) / 1e9
        busy_ns = sum(e - s for s, e, _ in prows)
        entry = {
            "span_s": round(span_s, 3),
            "busy_s": round(busy_ns / 1e9, 3),
            "host_gap_s": round(span_s - busy_ns / 1e9, 3),
            "categories": aggregate(prows),
        }
        if ph == "decode" and npred:
            entry["per_token"] = {
                "step_wall_ms": round(span_s * 1000 / npred, 3),
                "kernel_busy_ms": round(busy_ns / 1e6 / npred, 3),
                "host_gap_ms_per_token": round(
                    (span_s * 1000 - busy_ns / 1e6) / npred, 3),
            }
            for k, v in entry["categories"].items():
                v["ms_per_token"] = round(v["total_ms"] / npred, 4)
                v["pct_of_busy"] = round(v["total_ms"] / (busy_ns / 1e6) * 100, 2)
        res["phases"][ph] = entry
    with open(out_json, "w") as f:
        json.dump(res, f, indent=1)
    print(json.dumps({ph: {k: v for k, v in e.items() if k != "categories"}
                      for ph, e in res["phases"].items()}, indent=1))


if __name__ == "__main__":
    main()
