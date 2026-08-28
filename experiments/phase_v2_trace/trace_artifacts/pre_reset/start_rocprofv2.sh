#!/usr/bin/env bash
# Start llama-server wrapped by rocprofv2 for kernel-trace + stats
# Usage: ./start_rocprofv2.sh <arm_name>
set -uo pipefail

ARM="${1:?Usage: $0 <arm_name>}"
OUTDIR="experiments/phase_v2_trace/${ARM}"
PORT=8080

echo "=== Starting server under rocprofv2 (arm: ${ARM}) ==="

# Kill any existing
pkill -9 -f "llama-server" 2>/dev/null || true
sleep 2

mkdir -p "${OUTDIR}"

cd /home/gencer/llama.cpp

# rocprofv2 wraps the executable, captures kernel dispatch data
nohup rocprofv2 \
    --kernel-trace \
    --stats \
    --output-file "trace" \
    -d "${OUTDIR}" \
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
    --port ${PORT} \
    --metrics \
    --tools all \
    --chat-template-kwargs '{"preserve_thinking": true}' \
    >"${OUTDIR}/server_stdout.log" 2>"${OUTDIR}/server_stderr.log" &
BG_PID=$!
disown ${BG_PID}
echo "Background PID: ${BG_PID}"
echo "Waiting for health check..."

# Poll health
for i in $(seq 1 180); do
    if curl -sf "http://127.0.0.1:${PORT}/health" >/dev/null 2>&1; then
        echo "Server ready after ${i}s"
        echo "${BG_PID}" > "${OUTDIR}/rocprofv2.pid"
        exit 0
    fi
    if ! kill -0 ${BG_PID} 2>/dev/null; then
        echo "ERROR: Process died after ${i}s"
        tail -50 "${OUTDIR}/server_stderr.log" 2>&1
        tail -50 "${OUTDIR}/server_stdout.log" 2>&1
        exit 1
    fi
    sleep 1
done
echo "ERROR: Server not ready after 180s"
exit 1
