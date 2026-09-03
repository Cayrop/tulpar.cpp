#!/usr/bin/env bash
# Kill existing llama-server and restart under rocprofv3 wrapper
# Usage: ./start_server.sh [arm_suffix]
# Each arm gets its own rocprofv3 output directory
set -uo pipefail

ARM="${1:-server}"
OUTDIR="experiments/phase_v2_trace/${ARM}"

echo "=== Restarting server under rocprofv3 (arm: ${ARM}) ==="

# Kill existing server
OLD_PID=$(pgrep -x llama-server 2>/dev/null | head -1)
if [ -n "${OLD_PID}" ]; then
    echo "Killing old server PID ${OLD_PID}..."
    kill -9 ${OLD_PID} 2>/dev/null || true
    sleep 2
fi

# Verify dead
if pgrep -x llama-server >/dev/null 2>&1; then
    echo "ERROR: old server still alive"
    exit 1
fi
echo "Old server dead"

# Create output directory
mkdir -p "${OUTDIR}"

# Start under rocprofv3
echo "Starting rocprofv3 + llama-server..."
cd /home/gencer/llama.cpp
nohup rocprofv3 \
    --kernel-trace \
    --stats \
    --output-format csv \
    --output-directory "${OUTDIR}" \
    --output-file "trace" \
    -- \
    ./llama-server \
    -m /home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf \
    --alias Qwen3.8-27b \
    -c 131072 \
    -ngl 999 \
    --load-mode mmap \
    -fa on \
    -ctk q4_0 \
    -ctv q4_0 \
    --temp 0 \
    --top-p 0.95 \
    --top-k 20 \
    --min-p 0.0 \
    --cache-prompt \
    --ctx-checkpoints 4 \
    -t 8 \
    -np 1 \
    --host 0.0.0.0 \
    --port 8080 \
    --metrics \
    --tools all \
    --chat-template-kwargs '{"preserve_thinking": true}' \
    >"${OUTDIR}/server_stdout.log" 2>"${OUTDIR}/server_stderr.log" &

echo "Background PID: $!"
sleep 2

# Check if process is alive
if ! kill -0 $! 2>/dev/null; then
    echo "ERROR: Server failed to start"
    cat "${OUTDIR}/server_stderr.log" | tail -30
    exit 1
fi

echo "Server starting... waiting for health check"
