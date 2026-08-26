#!/usr/bin/env python3
import os
import re

dirs = [
    "rocprof/V0_down", "rocprof/C1_down", "rocprof/C2_down", "rocprof/C3_down", "rocprof/C4_down",
    "rocprof/V0_gateup", "rocprof/C1_gateup", "rocprof/C2_gateup", "rocprof/C3_gateup", "rocprof/C4_gateup",
]
print(f"{'variant':<25} {'stall':<8} {'cyc/wave':<10} {'valu/wave':<10} {'lds_insts':<12} {'lds_waits':<10} {'tex_loads':<10}")
for d in dirs:
    fn = f"{d}/averages.txt"
    if not os.path.exists(fn):
        continue
    metrics = {}
    with open(fn) as f:
        for line in f:
            k, v = line.strip().split("|")
            metrics[k] = float(v)
    stall = metrics["SQ_WAIT_INST_ANY"] / metrics["SQ_WAVE_CYCLES"]
    cyc_wave = metrics["SQ_WAVE_CYCLES"] / metrics["SQ_WAVES"]
    valu_wave = metrics["SQ_INSTS_VALU"] / metrics["SQ_WAVES"]
    print(f"{d:<25} {stall:.4f}   {cyc_wave:<10.1f} {valu_wave:<10.1f} {metrics['SQ_INSTS_LDS']:<12.0f} {metrics['SQ_WAIT_INST_LDS']:<10.0f} {metrics['SQ_INSTS_TEX_LOAD']:<10.2f}")
