#!/bin/bash
# Phase-4E / Subagent-C synthetic MMVQ benchmark build script (gfx1101).
# Builds the prefetch variants harness + the V0 baseline harness.
set -e
cd "$(dirname "$0")"
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_prefetch_bench mmvq_prefetch_bench.hip
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_bench_v0 mmvq_bench_v0.hip
echo "built mmvq_prefetch_bench mmvq_bench_v0"
