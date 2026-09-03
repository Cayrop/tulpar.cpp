#!/bin/bash
# Phase-4E / Subagent-E: independent-accumulator IQ3_XXS harness build (gfx1101).
set -e
cd "$(dirname "$0")"
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_bench_accum mmvq_bench_accum.hip
echo "built mmvq_bench_accum"
