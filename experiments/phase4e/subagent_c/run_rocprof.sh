#!/bin/bash
# Run rocprofv3 on all variants and extract stall metrics.
# Output: rocprof/<variant>_<shape>/results_results.db
set -e
cd "$(dirname "$0")"

COUNTERS="SQ_WAIT_INST_ANY SQ_WAIT_INST_LDS SQ_WAVE_CYCLES SQ_WAVES SQ_INSTS_LDS SQ_INSTS_VALU SQ_INSTS_TEX_LOAD"

mkdir -p rocprof

for shape in 0 1; do
  for variant in 0 1 2 4 -1; do
    name=$(case $variant in
      0) echo V0 ;;
      1) echo C1 ;;
      2) echo C2 ;;
      4) echo C3 ;;
      -1) echo C4 ;;
    esac)
    shape_name=$(case $shape in
      0) echo down ;;
      1) echo gateup ;;
    esac)
    fused=$(case $shape in
      0) echo 0 ;;
      1) echo 1 ;;
    esac)
    out_dir="rocprof/${name}_${shape_name}"
    echo "=== Running ${name} on ${shape_name} ==="
    rm -rf "${out_dir}"
    mkdir -p "${out_dir}"
    rocprofv3 --pmc "${COUNTERS}" -o results -d "${out_dir}" -- \
        ./mmvq_prefetch_bench 30 18 ${shape} 1 ${fused} ${variant} 2>&1 | tail -3
    # Extract metrics
    sqlite3 "${out_dir}/results_results.db" "SELECT counter_name, AVG(counter_value) FROM pmc_events GROUP BY counter_name" > "${out_dir}/averages.txt" 2>&1
    cat "${out_dir}/averages.txt"
    echo ""
  done
done
