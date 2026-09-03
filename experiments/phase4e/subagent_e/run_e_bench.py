#!/usr/bin/env python3
"""
Phase-4E / Subagent-E: manual re-run of the independent-accumulator benchmark.

Run this AFTER stopping llama-server so the GPU is idle.

Usage:
    python3 run_e_bench.py                 # 100 reps/variant, 8 interleaved rounds
    python3 run_e_bench.py 200 12           # 200 reps/variant, 12 rounds
    python3 run_e_bench.py --no-rebuild     # skip hipcc rebuild (use existing binary)

What it does:
  1. Checks GPU is idle (rocm-smi). Warns if busy.
  2. Rebuilds the variant harness (mmvq_bench.hip) unless --no-rebuild.
  3. Runs interleaved round-robin: V0/E1/E2/E3 x {ffn_down, ffn_gateup}.
     Interleaving averages out GPU-state drift between variants.
  4. Prints a clean summary table (median GB/s per variant per shape)
     and writes raw per-round data to raw/interleaved_manual.csv.
"""
import subprocess
import statistics
import sys
import os

HERE = os.path.dirname(os.path.abspath(__file__))
BIN = os.path.join(HERE, "mmvq_bench")
SRC = os.path.join(HERE, "mmvq_bench.hip")
RAW = os.path.join(HERE, "raw")

VARIANTS = [("V0", 0), ("E1", 1), ("E2", 2), ("E3", 3)]
# shape name -> (shape_idx, fused)
SHAPES = [("ffn_down", 0, 0), ("ffn_gateup", 1, 1)]
TYPE_IQ3_XXS = 18
BATCH = 1


def gpu_busy_pct():
    try:
        out = subprocess.check_output(
            ["rocm-smi", "--showuse"], stderr=subprocess.DEVNULL, text=True
        )
        for line in out.splitlines():
            if "GPU use" in line:
                # e.g. "GPU[0]		: GPU use (%): 81"
                try:
                    return int(line.split(":")[-1].strip().split()[0])
                except Exception:
                    return None
    except Exception:
        return None
    return None


def rebuild():
    print("=== rebuild variant harness ===")
    cmd = ["hipcc", "-O3", "-std=c++17", "--offload-arch=gfx1101",
           "-o", BIN, SRC]
    subprocess.check_call(cmd, cwd=HERE)
    print("built", BIN)


def run_one(reps, shape_idx, fused, variant):
    out = subprocess.check_output(
        [BIN, str(reps), str(TYPE_IQ3_XXS), str(shape_idx), str(BATCH),
         str(fused), str(variant)],
        cwd=HERE, text=True,
    )
    d = {}
    for tok in out.strip().split():
        if "=" in tok:
            k, v = tok.split("=", 1)
            d[k] = v
    return float(d["ms"]), float(d["GBps_weight"])


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    flags = [a for a in sys.argv[1:] if a.startswith("--")]
    reps = int(args[0]) if len(args) > 0 else 100
    rounds = int(args[1]) if len(args) > 1 else 8
    no_rebuild = "--no-rebuild" in flags

    print("=== GPU idle check ===")
    busy = gpu_busy_pct()
    if busy is None:
        print("could not read GPU use (rocm-smi unavailable?)")
    else:
        print(f"GPU use: {busy}%")
        if busy > 5:
            print("WARNING: GPU is busy. Stop llama-server for clean numbers.")

    if not no_rebuild:
        rebuild()
    else:
        print("skipping rebuild (--no-rebuild)")

    os.makedirs(RAW, exist_ok=True)
    csv_path = os.path.join(RAW, "interleaved_manual.csv")
    with open(csv_path, "w") as f:
        f.write("round,shape,variant,ms,gbps_weight\n")

    # interleaved round-robin
    data = {name: {sname: [] for sname, _, _ in SHAPES} for name, _ in VARIANTS}
    for r in range(rounds):
        for sname, sidx, fused in SHAPES:
            for name, variant in VARIANTS:
                ms, gbps = run_one(reps, sidx, fused, variant)
                data[name][sname].append((ms, gbps))
                with open(csv_path, "a") as f:
                    f.write(f"{r},{sname},{name},{ms:.4f},{gbps:.2f}\n")

    # summary
    print(f"\n=== summary: {rounds} rounds x {reps} reps/variant ===")
    for sname, _, _ in SHAPES:
        print(f"\n--- shape {sname} ---")
        print(f"{'variant':<8} {'ms_med':<10} {'gbps_med':<10} {'gbps_min':<10} {'gbps_max':<10} {'n'}")
        for name, _ in VARIANTS:
            lst = data[name][sname]
            ms_med = statistics.median(m for m, _ in lst)
            g = [g for _, g in lst]
            print(f"{name:<8} {ms_med:<10.4f} {statistics.median(g):<10.2f} "
                  f"{min(g):<10.2f} {max(g):<10.2f} {len(lst)}")

    print(f"\nraw data -> {csv_path}")


if __name__ == "__main__":
    main()
