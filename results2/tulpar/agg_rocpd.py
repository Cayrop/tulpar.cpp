#!/usr/bin/env python3
"""Aggregate rocprofv3 rocpd (.db) traces into time-share classes.

Usage: agg_rocpd.py <results.db> [--window-steps N]
Detects the steady-state model-decode run via flash-attn ncols=1 launch
gaps (filters model load / prefill / non-uniform sections), then reports
per-class GPU time share within that window.
"""
import sqlite3, sys, json, re, statistics

def classify(name):
    n = name.lower()
    if "flash_attn_ext" in n or "flash_attn_tile" in n: return "attention"
    if "mmq" in n: return "matmul_mmq"
    if "mul_mat_vec" in n or "dequantize_mul_mat_vec" in n: return "matmul_gemv"
    if "gemm" in n or "rocblas" in n or "hipblaslt" in n or "cutlass" in n \
       or "trsm" in n or n.startswith("cijk_") or "gemm_" in n: return "matmul_blas"
    if n.startswith("dequantize_block") or "dequantize_block" in n \
       or "quantize_mmq" in n or "quantize_row" in n or "convert_unary" in n \
       or "quantize_q8_1" in n: return "dequant_quant"
    if "cpy" in n or "copybuffer" in n or "fillbuffer" in n or "concat" in n \
       or "set_rows" in n or "get_rows" in n or "streamops" in n: return "copy_kv_io"
    if "rms_norm" in n or "norm" in n or "rope" in n or "silu" in n \
       or "gelu" in n or "relu" in n or "soft_max" in n or "argsort" in n: return "norm_rope_act"
    if any(k in n for k in ("ssm", "delta", "rwkv", "gdn", "conv")): return "gdn_ssm_conv"
    return "other"

def main():
    db = sys.argv[1]
    hint = None
    for a in sys.argv[2:]:
        if a.startswith("--hint-step-ms"): hint = float(a.split("=")[1])
    con = sqlite3.connect(db)
    tabs = {r[0].split("_")[1]: r[0] for r in con.execute(
        "SELECT name FROM sqlite_master WHERE type='table' AND name LIKE 'rocpd_%'")}
    disp = [t for t in tabs.values() if "kernel_dispatch" in t][0]
    sym = [t for t in tabs.values() if "info_kernel_symbol" in t][0]
    rows = con.execute(
        f"SELECT s.kernel_name, d.start, d.end FROM {disp} d "
        f"JOIN {sym} s ON d.kernel_id = s.id ORDER BY d.start").fetchall()
    per_k, cls_sum, cls_cnt = {}, {}, {}
    fa1 = []
    for name, s, e in rows:
        v = per_k.setdefault(name, [0.0, 0]); v[0] += e - s; v[1] += 1
        c = classify(name)
        cls_sum[c] = cls_sum.get(c, 0) + e - s
        cls_cnt[c] = cls_cnt.get(c, 0) + 1
        nm = name.replace(" ", "")
        ncols = None
        if "<" in name:
            m = re.search(r"flash_attn_(?:tile|ext)<\d+,\s?\d+,\s?(\d+),", nm)
            if m: ncols = int(m.group(1))
        else:
            m = re.search(r"flash_attn_(?:tile|ext)ILi\d+ELi\d+ELi(\d+)E", nm)
            if m: ncols = int(m.group(1))
        if ncols == 1: fa1.append(s)

    # deterministic window: sessions contain exactly one completion
    # [load][prefill][decode]. Take the tail covering the last 64 decode
    # steps using the measured step period (from trace bench or hint).
    mode, win, n_steps = "whole_trace", None, None
    if fa1 and hint:
        last = max(e for _, s, e in rows if s <= fa1[-1])
        win = (fa1[-1] - int(hint * 64 * 1e6), last)
        n_steps = 64
        mode = f"tail_{int(hint*64)}ms"

    out = {"mode": mode}
    src = rows
    if win:
        src = [r for r in rows if r[1] >= win[0] and r[1] <= win[1]]
    tot = sum(e - s for _, s, e in src)
    span = max(e for _, s, e in src) - min(s for _, s, e in src)
    cs, cc, pk = {}, {}, {}
    for name, s, e in src:
        d = e - s
        cs[classify(name)] = cs.get(classify(name), 0) + d
        cc[classify(name)] = cc.get(classify(name), 0) + 1
        v = pk.setdefault(name, [0.0, 0]); v[0] += d; v[1] += 1
    steps = n_steps
    out.update({"steps_in_run": steps,
                "step_period_ms": hint if win else None,
                "window_span_ms": round(span / 1e6, 2),
                "gpu_busy_pct_of_window": round(100 * tot / span, 2),
                "host_gap_pct_of_window": round(100 - 100 * tot / span, 2)})
    out["classes"] = sorted(
        [{"class": c, "time_ms": round(cs[c] / 1e6, 2), "count": cc[c],
          "pct_gpu_busy": round(100 * cs[c] / tot, 2)} for c in cs],
        key=lambda x: -x["time_ms"])
    out["top_kernels"] = sorted(
        [{"name": n[:80], "class": classify(n), "time_ms": round(v[0] / 1e6, 2),
          "count": v[1], "avg_us": round(v[0] / v[1] / 1e3, 1)} for n, v in pk.items()],
        key=lambda x: -x["time_ms"])[:25]
    print(json.dumps(out, indent=1))

if __name__ == "__main__":
    main()
