#!/usr/bin/env python3
"""Analyze rocprofv2 kernel trace output for V2 kernel attribution."""
import re, json, sys
from collections import defaultdict
from pathlib import Path

# Kernel name -> category mapping
KERNEL_CATEGORIES = {
    # GEMV / GEMM by quant type
    "mul_mat_vec_q.*ggml_type\)11": "GEMV_Q4_0",         # Q4_0
    "mul_mat_vec_q.*ggml_type\)12": "GEMV_Q4_1",         # Q4_1
    "mul_mat_vec_q.*ggml_type\)10": "GEMV_Q3_K",         # Q3_K
    "mul_mat_vec_q.*ggml_type\)8":  "GEMV_Q2_K",         # Q2_K
    "mul_mat_vec_q.*ggml_type\)7":  "GEMV_IQ2_XXS",      # IQ2_XXS
    "mul_mat_vec_q.*ggml_type\)1":  "GEMV_IQ3_XXS",      # IQ3_XXS
    "mul_mat_vec_q.*ggml_type\)2":  "GEMV_IQ3_XS",       # IQ3_XS
    "mul_mat_vec_q.*ggml_type\)3":  "GEMV_IQ3_S",        # IQ3_S
    "mul_mat_vec_q.*ggml_type\)4":  "GEMV_IQ2_S",        # IQ2_S
    "mul_mat_vec_q.*ggml_type\)5":  "GEMV_IQ1_S",        # IQ1_S
    "mul_mat_vec_q.*ggml_type\)6":  "GEMV_IQ1_M",        # IQ1_M
    "mul_mat_vec_q": "GEMV_other",
    # MMQ (matrix multiply quantized)
    "mul_mat_q": "MMQ",
    "mmq": "MMQ",
    # Flash attention
    "flash_attn_fwd": "FA_Tile",
    "flash_attn": "FA",
    "fwd_hdm_": "FA",
    # KV store
    "k_kv_store": "KV_Store",
    "k_copy": "KV_Copy",
    "copy_kernel": "KV_Copy",
    # Norm/RoPE/Act
    "rms_norm": "Norm_RMS",
    "norm_": "Norm",
    "rope": "RoPE",
    "k_rope": "RoPE",
    "k_alibi": "Alibi",
    # Quantize
    "quantize_q8_1": "Quantize_Q8_1",
    "dequantize": "Dequant",
    # GDN (Gated Delta Net / SSM)
    "gated_delta_net": "GDN",
    "ssm_conv": "GDN_SSM_Conv",
    "ssm_scan": "GDN_SSM_Scan",
    "gdn_": "GDN",
    # Softmax / activation
    "softmax": "Softmax",
    "k_softmax": "Softmax",
    # Copy / util
    "copy": "Copy",
    "fill": "Fill",
    "bin_bcast": "Broadcast",
    "k_bin_bcast": "Broadcast",
    "get_rows": "Get_Rows",
    "k_get_rows": "Get_Rows",
    "arange": "Arange",
    "argsort": "Argsort",
    # System
    "__amd_rocclr": "System",
}

def classify_kernel(name: str) -> str:
    """Classify a kernel name into a category."""
    # Normalize
    n = name.lower()
    
    # Try pattern matches in order
    for pattern, cat in KERNEL_CATEGORIES.items():
        if re.search(pattern.lower(), n):
            return cat
    
    return "Other"

def parse_dispatch(line: str) -> dict:
    """Parse a single dispatch line."""
    m = {
        "dispatch_id": int(re.search(r"Dispatch_ID\((\d+)\)", line).group(1)),
        "gpu_id": int(re.search(r"GPU_ID\((\d+)\)", line).group(1)),
        "grid_size": int(re.search(r"Grid_Size\((\d+)\)", line).group(1)),
        "workgroup_size": int(re.search(r"Workgroup_Size\((\d+)\)", line).group(1)),
        "arch_vgpr": int(re.search(r"Arch_VGPR\((\d+)\)", line).group(1)),
        "sgpr": int(re.search(r"SGPR\((\d+)\)", line).group(1)),
        "wave_size": int(re.search(r"Wave_Size\((\d+)\)", line).group(1)),
        "kernel_name": re.search(r'Kernel_Name\("(.+?)"\)', line).group(1),
        "begin_ts": int(re.search(r"Begin_Timestamp\((\d+)\)", line).group(1)),
        "end_ts": int(re.search(r"End_Timestamp\((\d+)\)", line).group(1)),
    }
    m["duration_ns"] = m["end_ts"] - m["begin_ts"]
    m["duration_ms"] = m["duration_ns"] / 1e6
    m["category"] = classify_kernel(m["kernel_name"])
    m["num_wavefronts"] = (m["grid_size"] + m["wave_size"] - 1) // m["wave_size"]
    return m

def main():
    trace_file = Path(sys.argv[1]) if len(sys.argv) > 1 else \
        Path("experiments/phase_v2_trace/T-V2-1k-OFF/server_stdout.log")
    
    dispatches = []
    with open(trace_file) as f:
        for line in f:
            if line.strip().startswith("Dispatch_ID("):
                try:
                    dispatches.append(parse_dispatch(line))
                except Exception as e:
                    print(f"WARN: parse error: {e}", file=sys.stderr)
    
    if not dispatches:
        print("ERROR: No dispatches found")
        sys.exit(1)
    
    print(f"Total dispatches: {len(dispatches)}")
    
    # Find timestamp boundaries
    first_ts = dispatches[0]["begin_ts"]
    last_ts = dispatches[-1]["end_ts"]
    total_gpu_time_s = (last_ts - first_ts) / 1e9
    
    # Separate model loading from inference
    # Look for the largest gap between consecutive dispatches
    gaps = []
    for i in range(1, len(dispatches)):
        gap = dispatches[i]["begin_ts"] - dispatches[i-1]["end_ts"]
        gaps.append((gap, i))
    gaps.sort(reverse=True)
    
    # The largest gap likely separates model loading from inference
    if gaps:
        largest_gap = gaps[0][0]
        split_idx = gaps[0][1]
        print(f"Largest gap: {largest_gap/1e6:.2f}ms at dispatch {split_idx}")
        
        loading_dispatches = dispatches[:split_idx]
        inference_dispatches = dispatches[split_idx:]
        
        print(f"\nModel loading: {len(loading_dispatches)} dispatches")
        print(f"Inference: {len(inference_dispatches)} dispatches")
    else:
        inference_dispatches = dispatches
        loading_dispatches = []
    
    # === Category attribution for inference ===
    print("\n" + "="*80)
    print("INFERENCE KERNEL ATTRIBUTION")
    print("="*80)
    
    cat_stats = defaultdict(lambda: {"count": 0, "total_ms": 0.0, "min_ms": float('inf'), "max_ms": 0.0, "grid_sizes": []})
    total_inference_ms = sum(d["duration_ms"] for d in inference_dispatches)
    
    for d in inference_dispatches:
        cat = d["category"]
        cat_stats[cat]["count"] += 1
        cat_stats[cat]["total_ms"] += d["duration_ms"]
        cat_stats[cat]["min_ms"] = min(cat_stats[cat]["min_ms"], d["duration_ms"])
        cat_stats[cat]["max_ms"] = max(cat_stats[cat]["max_ms"], d["duration_ms"])
        cat_stats[cat]["grid_sizes"].append(d["grid_size"])
    
    # Sort by total time
    sorted_cats = sorted(cat_stats.items(), key=lambda x: x[1]["total_ms"], reverse=True)
    
    print(f"\n{'Category':<25} {'Count':>6} {'Total ms':>10} {'% Total':>8} {'Avg ms':>10} {'Min ms':>10} {'Max ms':>10} {'Avg Grid':>10}")
    print("-"*100)
    for cat, stats in sorted_cats:
        avg_ms = stats["total_ms"] / stats["count"]
        avg_grid = sum(stats["grid_sizes"]) / len(stats["grid_sizes"])
        pct = (stats["total_ms"] / total_inference_ms * 100) if total_inference_ms > 0 else 0
        print(f"{cat:<25} {stats['count']:>6} {stats['total_ms']:>10.3f} {pct:>7.1f}% {avg_ms:>10.3f} {stats['min_ms']:>10.3f} {stats['max_ms']:>10.3f} {avg_grid:>10.0f}")
    
    print(f"\n{'TOTAL':<25} {len(inference_dispatches):>6} {total_inference_ms:>10.3f} {'100.0':>7}%")
    
    # === GEMV quant type breakdown ===
    print("\n" + "="*80)
    print("GEMV BY QUANT TYPE (decode phase)")
    print("="*80)
    
    gemv_dispatches = [d for d in inference_dispatches if d["category"].startswith("GEMV")]
    gemv_by_type = defaultdict(lambda: {"count": 0, "total_ms": 0.0, "grid_sizes": []})
    
    for d in gemv_dispatches:
        cat = d["category"]
        gemv_by_type[cat]["count"] += 1
        gemv_by_type[cat]["total_ms"] += d["duration_ms"]
        gemv_by_type[cat]["grid_sizes"].append(d["grid_size"])
    
    total_gemv_ms = sum(v["total_ms"] for v in gemv_by_type.values())
    sorted_gemv = sorted(gemv_by_type.items(), key=lambda x: x[1]["total_ms"], reverse=True)
    
    print(f"\n{'Quant Type':<25} {'Count':>6} {'Total ms':>10} {'% GEMV':>8} {'Avg Grid':>10}")
    print("-"*60)
    for cat, stats in sorted_gemv:
        avg_grid = sum(stats["grid_sizes"]) / len(stats["grid_sizes"])
        pct = (stats["total_ms"] / total_gemv_ms * 100) if total_gemv_ms > 0 else 0
        print(f"{cat:<25} {stats['count']:>6} {stats['total_ms']:>10.3f} {pct:>7.1f}% {avg_grid:>10.0f}")
    print(f"\n{'TOTAL GEMV':<25} {len(gemv_dispatches):>6} {total_gemv_ms:>10.3f}")
    
    # === Inter-kernel gaps ===
    print("\n" + "="*80)
    print("INTER-KERNEL GAPS (inference phase)")
    print("="*80)
    
    if len(inference_dispatches) > 1:
        inf_gaps = []
        for i in range(1, len(inference_dispatches)):
            gap_ns = inference_dispatches[i]["begin_ts"] - inference_dispatches[i-1]["end_ts"]
            inf_gaps.append(gap_ns / 1e6)  # ms
        
        inf_gaps.sort()
        total_gap_ms = sum(inf_gaps)
        avg_gap = total_gap_ms / len(inf_gaps)
        med_gap = inf_gaps[len(inf_gaps)//2]
        p99_gap = inf_gaps[int(len(inf_gaps)*0.99)]
        
        print(f"Total gap: {total_gap_ms:.3f}ms")
        print(f"Avg gap: {avg_gap:.3f}ms")
        print(f"Median gap: {med_gap:.3f}ms")
        print(f"P99 gap: {p99_gap:.3f}ms")
        print(f"Gap count: {len(inf_gaps)}")
    else:
        print("Not enough dispatches for gap analysis")
    
    # === Per-token breakdown ===
    print("\n" + "="*80)
    print("PER-TOKEN BREAKDOWN (if multi-token decode)")
    print("="*80)
    
    # Find decode token boundaries by looking for repeated patterns
    # In decode, each token produces a similar sequence of kernels
    # Look for rms_norm as token boundary
    norm_indices = [i for i, d in enumerate(inference_dispatches) if d["category"] == "Norm_RMS"]
    print(f"Token boundaries (by Norm_RMS): {len(norm_indices)} found")
    if len(norm_indices) > 1:
        token_durations = []
        for i in range(len(norm_indices)-1):
            start = inference_dispatches[norm_indices[i]]["begin_ts"]
            end = inference_dispatches[norm_indices[i+1]]["begin_ts"]
            token_durations.append((end - start) / 1e6)
        
        if token_durations:
            print(f"Avg time per token: {sum(token_durations)/len(token_durations):.3f}ms")
            print(f"Min token: {min(token_durations):.3f}ms")
            print(f"Max token: {max(token_durations):.3f}ms")
            print(f"Tokens estimated: {len(norm_indices)}")
    
    # Save JSON
    json_out = {
        "total_dispatches": len(dispatches),
        "model_loading_dispatches": len(loading_dispatches),
        "inference_dispatches": len(inference_dispatches),
        "total_gpu_time_ms": total_gpu_time_s * 1000,
        "total_inference_ms": total_inference_ms,
        "category_attribution": {cat: {
            "count": s["count"],
            "total_ms": round(s["total_ms"], 3),
            "pct": round(s["total_ms"] / total_inference_ms * 100, 1) if total_inference_ms > 0 else 0,
            "avg_grid": int(sum(s["grid_sizes"]) / len(s["grid_sizes"])) if s["grid_sizes"] else 0,
        } for cat, s in sorted_cats},
        "gemv_by_quant": {cat: {
            "count": s["count"],
            "total_ms": round(s["total_ms"], 3),
        } for cat, s in sorted_gemv},
    }
    
    json_path = trace_file.parent / "trace_analysis.json"
    with open(json_path, "w") as f:
        json.dump(json_out, f, indent=2)
    print(f"\nJSON saved to {json_path}")

if __name__ == "__main__":
    main()
