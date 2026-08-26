#!/usr/bin/env python3
"""Aggregate rocprofv3 kernel/API traces into time-share classes.

Usage:
  agg_trace.py <kernel_trace.csv> [hip_api_trace.csv] [--window-steps N]

Steady-state window detection: uses median gap between consecutive launches
of the most frequent flash_attn_ext kernel as the decode step period, takes
the last N steps as the analysis window. Without window mode aggregates the
whole trace (diluted by model load).
"""
import csv, sys, json, statistics, re
from collections import defaultdict

def classify(name):
    n = name.lower()
    if "flash_attn_ext" in n or "flash_attn_tile" in n: return "attention"
    if "mmq" in n: return "matmul_mmq"
    if "mul_mat_vec" in n or "dequantize_mul_mat_vec" in n: return "matmul_gemv"
    if "gemm" in n or "rocblas" in n or "hipblaslt" in n or "cutlass" in n \
       or "trsm" in n or n.startswith("cijk_") or "gemm_" in n: return "matmul_blas"
    if n.startswith("dequantize_block") or "quantize_mmq" in n or "quantize_row" in n \
       or "convert_unary" in n: return "dequant_quant"
    if "cpy" in n or "copybuffer" in n or "fillbuffer" in n or "concat" in n \
       or "set_rows" in n or "get_rows" in n or "setrows" in n or "getrows" in n: return "copy_kv_io"
    if "rms_norm" in n or "norm" in n or "rope" in n or "silu" in n or "gelu" in n \
       or "relu" in n or "soft_max" in n or "softmax" in n or "argsort" in n: return "norm_rope_act"
    if any(k in n for k in ("ssm", "delta", "rwkv", "gdn", "conv")): return "gdn_ssm_conv"
    if "argmax" in n or "sample" in n or "topk" in n or "top_k" in n or "softmax" in n: return "sampling"
    return "other"

def load_kernel_rows(path, t0=None, t1=None):
    per_kernel = defaultdict(lambda: [0.0, 0])   # name -> [sum_us, count]
    cls_sum = defaultdict(float); cls_cnt = defaultdict(int)
    gmax = 0.0; gmin = float("inf"); total = 0.0
    fa_starts = defaultdict(list)                # base name -> [start_ts]
    with open(path, newline="") as f:
        r = csv.reader(f, quotechar='"')
        hdr = next(r)
        iN, iS, iE = hdr.index("Kernel_Name"), hdr.index("Start_Timestamp"), hdr.index("End_Timestamp")
        iVG = hdr.index("VGPR_Count") if "VGPR_Count" in hdr else None
        for row in r:
            if row[iN] == "": continue
            s, e = int(row[iS]), int(row[iE])
            if t0 is not None and (e < t0 or s > t1): continue
            d = e - s
            name = row[iN]
            per_kernel[name][0] += d; per_kernel[name][1] += 1
            c = classify(name)
            cls_sum[c] += d; cls_cnt[c] += 1
            total += d
            if e > gmax: gmax = e
            if s < gmin: gmin = s
            if "flash_attn_tile" in name.replace(" ", "") and re.search(
                    r"flash_attn_tile<\d+,\s*\d+,\s*1,", name.replace(" ", "")):
                fa_starts[name].append(s)
    return per_kernel, cls_sum, cls_cnt, gmin, gmax, total, fa_starts

def detect_window(fa_starts, steps):
    # most frequent tile<...,1> kernel = one launch per decode step
    best = max(fa_starts.values(), key=len) if fa_starts else []
    if len(best) < steps + 1: return None, None
    best = sorted(best)[-int(steps * 1.5):]
    gaps = [b - a for a, b in zip(best, best[1:])]
    step_ns = statistics.median(gaps)
    t1 = best[-1]
    t0 = t1 - int(step_ns * steps)
    return t0, t1

def detect_decode_run(fa_starts, min_launches=32,
                      gmin_ms=20.0, gmax_ms=400.0):
    """Longest contiguous run of decode-step attention launches with
    plausible step-period gaps (filters out unit-test tails)."""
    best = max(fa_starts.values(), key=len) if fa_starts else []
    if len(best) < min_launches: return None, None
    s = sorted(best)
    lo, hi = int(gmin_ms * 1e6), int(gmax_ms * 1e6)
    runs, start_i = [], 0
    for i in range(1, len(s)):
        if not (lo <= s[i] - s[i - 1] <= hi):
            if i - start_i >= min_launches: runs.append((start_i, i))
            start_i = i
    if len(s) - start_i >= min_launches: runs.append((start_i, len(s)))
    if not runs: return None, None
    a, b = max(runs, key=lambda r: r[1] - r[0])
    return s[a], s[b - 1]

def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    steps = 64
    for a in sys.argv[1:]:
        if a.startswith("--window-steps"): steps = int(a.split("=")[1]) if "=" in a else steps
    kp, ap = args[0], (args[1] if len(args) > 1 else None)
    per_k, cs, cc, gmin, gmax, tot, fa = load_kernel_rows(kp)
    win = detect_window(fa, steps)
    mode = "whole_trace"
    if None not in win:
        mode = f"last_{steps}_steps"
        per_k, cs, cc, gmin, gmax, tot, fa = load_kernel_rows(kp, *win)
    run = detect_decode_run(fa)
    if None not in run:
        r_per_k, r_cs, r_cc, r_gmin, r_gmax, r_tot, _ = load_kernel_rows(kp, *run)
        if r_tot > tot * 0.5 or mode == "whole_trace":
            mode = "decode_run"
            per_k, cs, cc, gmin, gmax, tot = r_per_k, r_cs, r_cc, r_gmin, r_gmax, r_tot
    span = gmax - gmin
    out = {"mode": mode, "window": {"t0": gmin, "t1": gmax, "span_ms": round(span / 1e6, 2)},
           "gpu_busy_pct": round(100.0 * tot / span, 2),
           "classes": sorted(
               [{"class": c, "time_ms": round(cs[c] / 1e6, 2), "count": cc[c],
                 "pct_of_gpu_busy": round(100.0 * cs[c] / tot, 2)} for c in cs],
               key=lambda x: -x["time_ms"]),
           "top_kernels": sorted(
               [{"name": n[:90], "class": classify(n), "time_ms": round(v[0] / 1e6, 2),
                 "count": v[1], "avg_us": round(v[0] / v[1] / 1e3, 1)} for n, v in per_k.items()],
               key=lambda x: -x["time_ms"])[:30]}
    if ap:
        apisum = defaultdict(lambda: [0.0, 0]); amax = 0.0
        with open(ap, newline="") as f:
            r = csv.reader(f, quotechar='"'); hdr = next(r)
            iF, iS, iE = hdr.index("Function"), hdr.index("Start_Timestamp"), hdr.index("End_Timestamp")
            for row in r:
                s, e = int(row[iS]), int(row[iE])
                if None not in win and (e < gmin or s > gmax): continue
                apisum[row[iF]][0] += e - s; apisum[row[iF]][1] += 1
                if e > amax: amax = e
        out["hip_api"] = sorted(
            [{"fn": f, "host_ms": round(v[0] / 1e6, 2), "count": v[1],
              "avg_us": round(v[0] / v[1] / 1e3, 1)} for f, v in apisum.items()],
            key=lambda x: -x["host_ms"])[:15]
        lk = next((x for x in out["hip_api"] if x["fn"] == "hipLaunchKernel"), None)
        if lk: out["launch_overhead_pct_of_span"] = round(100.0 * lk["host_ms"] / out["window"]["span_ms"], 2)
    print(json.dumps(out, indent=1))

if __name__ == "__main__":
    main()
