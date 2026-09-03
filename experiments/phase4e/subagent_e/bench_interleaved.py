#!/usr/bin/env python3
"""
Interleaved bench: launch V0/E1/E2/E3 in round-robin so all variants
see similar GPU state. This averages out contention spikes from
other subagents.
"""
import subprocess
import statistics
import os
import sys

# Variants: name, ffn_down args, ffn_gateup args
# Usage: ./mmvq_bench <reps> <type> <shape> <batch> <fused> <variant>
# shape=0 -> K=17408, N=5120 (ffn_down)
# shape=1 -> K=5120,  N=17408 (ffn_gateup)
VARIANTS = [
    ("V0", 0),
    ("E1", 1),
    ("E2", 2),
    ("E3", 3),
]
REPS = 500
ROUNDS = 8
BIN = "./mmvq_bench"

def run(args):
    out = subprocess.check_output([BIN] + [str(a) for a in args]).decode()
    # line: type=18 shape=0 batch=1 fused=0 variant=0 ms=0.2014 ...
    parts = out.strip().split()
    d = {k: v for k, v in (p.split("=") for p in parts if "=" in p)}
    return float(d["ms"]), float(d["GBps_weight"])

def bench_all(shape, fused):
    """Run ROUNDS round-robin cycles of all 4 variants."""
    cycle_results = {n: [] for n, _ in VARIANTS}
    for r in range(ROUNDS):
        for name, variant in VARIANTS:
            ms, gbps = run([REPS, 18, shape, 1, fused, variant])
            cycle_results[name].append((ms, gbps))
    return cycle_results

def summarize(name, lst):
    ms_list = [m for m, _ in lst]
    gbps_list = [g for _, g in lst]
    return {
        "n": len(lst),
        "ms_min": min(ms_list),
        "ms_med": statistics.median(ms_list),
        "ms_max": max(ms_list),
        "gbps_min": min(gbps_list),
        "gbps_med": statistics.median(gbps_list),
        "gbps_max": max(gbps_list),
    }

if __name__ == "__main__":
    out = []
    out.append(f"=== Interleaved bench: {ROUNDS} rounds x {REPS} reps/variant ===")
    for shape_name, shape_idx, fused in [("ffn_down", 0, 0), ("ffn_gateup", 1, 1)]:
        out.append(f"\n=== shape {shape_name} (fused={fused}) ===")
        out.append(f"{'variant':<8} {'ms_min':<9} {'ms_med':<9} {'ms_max':<9} {'gbps_min':<10} {'gbps_med':<10} {'gbps_max':<10} {'samples'}")
        results = bench_all(shape_idx, fused)
        for name, _ in VARIANTS:
            s = summarize(name, results[name])
            out.append(f"{name:<8} {s['ms_min']:<9.4f} {s['ms_med']:<9.4f} {s['ms_max']:<9.4f} {s['gbps_min']:<10.2f} {s['gbps_med']:<10.2f} {s['gbps_max']:<10.2f} {s['n']}")
    text = "\n".join(out)
    print(text)
    with open("raw/interleaved_bench.txt", "w") as f:
        f.write(text + "\n")
