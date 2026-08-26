#!/bin/bash
# Run rocprofv3 on all VDR variants and collect stall metrics.
set -e
cd "$(dirname "$0")/.."

ROCPROF=rocprofv3
HARNESS=./mmvq_bench_vdr
METRICS=rocprof/stall_metrics.txt
OUTDIR=rocprof

# Warm-up once
$HARNESS 5 > /dev/null

mkdir -p $OUTDIR

run_one() {
    local label=$1
    local shape=$2
    local batch=$3
    local bpc=$4
    local fused=$5
    local fused_flag=$6  # 0 or 1
    
    $ROCPROF -i $METRICS \
        --kernel-include-regex "mul_mat_vec_q" \
        --output-file ${label} -d $OUTDIR/ -f csv -- \
        $HARNESS 30 $shape $batch $bpc $fused_flag 2>&1 | tail -1
}

# ffn_down (shape=0, batch=1)
run_one V0_down   0 1 0 0 0
run_one D1_down   0 1 1 0 0
run_one D2_down   0 1 2 0 0
run_one D3_down   0 1 3 0 0

# fused gateup (shape=1, batch=1, fused=1)
run_one V0_gateup 1 1 0 1 1
run_one D1_gateup 1 1 1 1 1
run_one D2_gateup 1 1 2 1 1
run_one D3_gateup 1 1 3 1 1

echo "DONE"
