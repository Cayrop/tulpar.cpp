#!/usr/bin/env bash
# V2 Kernel Attribution Trace Runner
# Usage: ./run_arm.sh <arm_name> <ctx_size> [n_predict]
set -euo pipefail

ARM_NAME="${1:?Usage: $0 <arm_name> <ctx_size> [n_predict]}"
CTX_SIZE="${2:?Usage: $0 <arm_name> <ctx_size> [n_predict]}"
N_PREDICT="${3:-32}"
MODEL_PATH="/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf"
BINARY="build-p3/bin/llama-server"
OUTDIR="experiments/phase_v2_trace/${ARM_NAME}"
PORT=8190
PROMPT="The quick brown fox jumps over the lazy dog. This is a test prompt for measuring kernel dispatch times during both prefill and decode phases of inference with the Qwen3.8-27B model quantized to Q2_K."

# Safety check
echo "=== ARM: ${ARM_NAME} | CTX: ${CTX_SIZE} | N_PREDICT: ${N_PREDICT} ==="
echo "Model: ${MODEL_PATH}"
echo "Binary: ${BINARY}"
echo "Output: ${OUTDIR}"

# Verify model exists
if [ ! -f "${MODEL_PATH}" ]; then
    echo "ERROR: Model not found at ${MODEL_PATH}"
    exit 1
fi

# Verify binary exists
if [ ! -f "${BINARY}" ]; then
    echo "ERROR: Binary not found at ${BINARY}"
    exit 1
fi

# Create output directory
mkdir -p "${OUTDIR}"

# Record pre-trace VRAM
echo "--- Pre-trace VRAM ---"
rocm-smi --showmeminfo vram 2>&1 | grep -E "GPU|Total" || true

# Kill any existing instances
pkill -f "llama-server.*port.*${PORT}" 2>/dev/null || true
sleep 1

# Launch server under rocprofv3
echo "--- Launching server under rocprofv3 ---"
rocprofv3 \
    --kernel-trace \
    --stats \
    --output-format csv \
    --output-directory "${OUTDIR}" \
    --output-file "trace" \
    -- \
    "${BINARY}" \
    -m "${MODEL_PATH}" \
    --ctx-size "${CTX_SIZE}" \
    --port "${PORT}" \
    -fa on \
    --log-disable \
    2>"${OUTDIR}/server_stderr.log" &
SERVER_PID=$!
echo "Server PID: ${SERVER_PID}"

# Wait for server to be ready
echo "--- Waiting for server readiness ---"
READY=0
for i in $(seq 1 120); do
    if curl -sf "http://127.0.0.1:${PORT}/health" >/dev/null 2>&1; then
        READY=1
        echo "Server ready after ${i}s"
        break
    fi
    # Check if server is still alive
    if ! kill -0 ${SERVER_PID} 2>/dev/null; then
        echo "ERROR: Server died during startup after ${i}s"
        cat "${OUTDIR}/server_stderr.log" | tail -50
        exit 1
    fi
    sleep 1
done

if [ ${READY} -eq 0 ]; then
    echo "ERROR: Server not ready after 120s"
    kill ${SERVER_PID} 2>/dev/null || true
    exit 1
fi

# Wait extra 5s for model loading to stabilize (so model loading kernels are separated)
echo "Waiting 5s for kernel activity to stabilize..."
sleep 5

# Run prefill probe (send large prompt, n_predict=1)
echo "--- Prefill probe ---"
PREFILL_START=$(date +%s%N)
PREFILL_RESP=$(curl -sf "http://127.0.0.1:${PORT}/completion" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": \"${PROMPT}\", \"n_predict\": 1, \"temperature\": 0}" 2>&1) || true
PREFILL_END=$(date +%s%N)
echo "Prefill response: ${PREFILL_RESP}" | head -3
PREFILL_MS=$(( (PREFILL_END - PREFILL_START) / 1000000 ))
echo "Prefill time: ${PREFILL_MS}ms"

# Brief pause between phases
sleep 2

# Run decode probe (reuse KV cache, n_predict=N_PREDICT)
echo "--- Decode probe (${N_PREDICT} tokens) ---"
DECODE_START=$(date +%s%N)
DECODE_RESP=$(curl -sf "http://127.0.0.1:${PORT}/completion" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": \"${PROMPT}\", \"n_predict\": ${N_PREDICT}, \"temperature\": 0}" 2>&1) || true
DECODE_END=$(date +%s%N)
echo "Decode response: ${DECODE_RESP}" | head -3
DECODE_MS=$(( (DECODE_END - DECODE_START) / 1000000 ))
echo "Decode time: ${DECODE_MS}ms"

# Record post-inference VRAM
echo "--- Post-inference VRAM ---"
rocm-smi --showmeminfo vram 2>&1 | grep -E "GPU|Total" || true

# Check VRAM safety (15.5 GiB = 16642975744 bytes)
VRAM_USED=$(rocm-smi --showmeminfo vram 2>&1 | grep "Used" | awk '{print $NF}')
echo "VRAM used: ${VRAM_USED} bytes"
if [ "${VRAM_USED:-0}" -gt 16642975744 ] 2>/dev/null; then
    echo "WARNING: VRAM exceeded 15.5 GiB safety limit!"
fi

# Kill server with SIGKILL (per established rocprofv3 behavior)
echo "--- Stopping server via SIGKILL ---"
kill -9 ${SERVER_PID} 2>/dev/null || true
wait ${SERVER_PID} 2>/dev/null || true

# Wait for rocprofv3 to flush output
sleep 5

# Verify trace file integrity
echo "--- Trace output ---"
ls -la "${OUTDIR}/" 2>&1
echo "--- Checking for kernel trace data ---"
if ls "${OUTDIR}"/*.csv 2>/dev/null; then
    for csv in "${OUTDIR}"/*.csv; do
        echo "=== $(basename ${csv}) ==="
        head -5 "${csv}" 2>&1
        echo "..."
        wc -l "${csv}" 2>&1
    done
fi

# Save metadata
cat > "${OUTDIR}/metadata.json" << METADATA
{
    "arm": "${ARM_NAME}",
    "ctx_size": ${CTX_SIZE},
    "n_predict": ${N_PREDICT},
    "model": "${MODEL_PATH}",
    "binary": "${BINARY}",
    "prefill_ms": ${PREFILL_MS},
    "decode_ms": ${DECODE_MS},
    "timestamp": "$(date -Iseconds)",
    "server_pid": ${SERVER_PID}
}
METADATA

echo "=== ARM ${ARM_NAME} COMPLETE ==="
