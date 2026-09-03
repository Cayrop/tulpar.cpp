#!/bin/bash
# Phase-3 synthetic MMVQ benchmark build script (gfx1101).
set -e
cd "$(dirname "$0")"
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mmvq_bench mmvq_bench.hip
echo "built mmvq_bench"
