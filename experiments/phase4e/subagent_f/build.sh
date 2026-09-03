#!/bin/bash
# Phase-4E / Subagent-F: build the MLP sweep harness (gfx1101).
set -e
cd "$(dirname "$0")"
hipcc -O3 -std=c++17 --offload-arch=gfx1101 -o mlp_sweep mlp_sweep.hip
echo "built mlp_sweep"
