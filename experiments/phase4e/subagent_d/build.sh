#!/bin/bash
# Phase-4E / Subagent-D: VDR-templated IQ3_XXS harness build (gfx1101).
set -e
cd "$(dirname "$0")"
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_bench_vdr mmvq_bench_vdr.hip
echo "built mmvq_bench_vdr"
