#!/usr/bin/env bash
# Run one trace arm against the already-running server
# Usage: ./run_one_arm.sh <arm_name> <prompt_tokens> <n_predict> [duration_sec]
set -uo pipefail

ARM_NAME="${1:?Usage: $0 <arm_name> <prompt_tokens> <n_predict> [duration_sec]}"
PROMPT_TOKENS="${2:?Missing prompt_tokens}"
N_PREDICT="${3:?Missing n_predict}"
DURATION_SEC="${4:-90}"
SERVER_PORT=8080
OUTDIR="experiments/phase_v2_trace/${ARM_NAME}"

# Get server PID
SERVER_PID=$(pgrep -x llama-server | head -1)
if [ -z "${SERVER_PID}" ]; then
    echo "ERROR: No llama-server process found"
    exit 1
fi
echo "[${ARM_NAME}] Server PID: ${SERVER_PID}"

# Verify server health
if ! curl -sf "http://127.0.0.1:${SERVER_PORT}/health" >/dev/null 2>&1; then
    echo "ERROR: Server not healthy"
    exit 1
fi
echo "[${ARM_NAME}] Server healthy"

# Create output
mkdir -p "${OUTDIR}"

# Generate prompt via python
PAYLOAD=$(python3 experiments/phase_v2_trace/make_payload.py ${PROMPT_TOKENS} ${N_PREDICT})
echo "[${ARM_NAME}] Payload size: $(echo "${PAYLOAD}" | wc -c) bytes"

# Start rocprofv3 attach
DURATION_MSEC=$(( DURATION_SEC * 1000 ))
echo "[${ARM_NAME}] Starting rocprofv3 attach (${DURATION_SEC}s)..."
rocprofv3 \
    --attach "${SERVER_PID}" \
    --attach-duration-msec "${DURATION_MSEC}" \
    --kernel-trace \
    --stats \
    --output-format csv \
    --output-directory "${OUTDIR}" \
    --output-file "trace" \
    >"${OUTDIR}/rocprofv3_stdout.log" 2>"${OUTDIR}/rocprofv3_stderr.log" &
ROC_PID=$!
echo "[${ARM_NAME}] rocprofv3 PID: ${ROC_PID}"

# Wait for profiler to attach
echo "[${ARM_NAME}] Waiting for attachment..."
sleep 4

# Verify profiler is attached
if ! kill -0 ${ROC_PID} 2>/dev/null; then
    echo "[${ARM_NAME}] ERROR: rocprofv3 exited"
    cat "${OUTDIR}/rocprofv3_stderr.log" | tail -30
    exit 1
fi
echo "[${ARM_NAME}] Profiler attached, sending request..."

# Send completion request
REQ_START=$(date +%s%3N)
HTTP_CODE=$(curl -s -o "${OUTDIR}/response.json" -w "%{http_code}" \
    "http://127.0.0.1:${SERVER_PORT}/completion" \
    -H "Content-Type: application/json" \
    -d "${PAYLOAD}" \
    --max-time $(( DURATION_SEC - 5 )))
REQ_END=$(date +%s%3N)
REQ_MS=$(( REQ_END - REQ_START ))
echo "[${ARM_NAME}] Request completed: HTTP ${HTTP_CODE} in ${REQ_MS}ms"

# Parse response
if [ -f "${OUTDIR}/response.json" ]; then
    python3 -c "
import json, sys
try:
    d = json.load(open('${OUTDIR}/response.json'))
    print(f'  tokens_evaluated: {d.get(\"tokens_evaluated\", \"?\")}')
    print(f'  tokens_predicted: {d.get(\"tokens_predicted\", \"?\")}')
    print(f'  prompt_tokens: {d.get(\"prompt_tokens\", \"?\")}')
    content = d.get('content', '')[:100]
    print(f'  content: {content}...')
    timings = d.get('timings', {})
    if timings:
        print(f'  prompt_per_second: {timings.get(\"prompt_per_second\", \"?\")}')
        print(f'  predicted_per_second: {timings.get(\"predicted_per_second\", \"?\")}')
except Exception as e:
    print(f'  parse error: {e}')
" 2>&1 || true
fi

# Wait for rocprofv3 to finish
echo "[${ARM_NAME}] Waiting for rocprofv3 to complete..."
wait ${ROC_PID} 2>/dev/null || true
echo "[${ARM_NAME}] Profiler finished"

# Check output
echo "[${ARM_NAME}] Output files:"
ls -la "${OUTDIR}/" 2>&1

# Show CSV stats summary
for f in "${OUTDIR}"/*.csv; do
    if [ -f "$f" ]; then
        FNAME=$(basename "${f}")
        LINES=$(wc -l < "${f}")
        echo "[${ARM_NAME}] ${FNAME}: ${LINES} lines"
        # Show kernel names if this is the stats file
        if echo "${FNAME}" | grep -q "stats"; then
            echo "  Top kernels by time:"
            head -1 "${f}"
            sort -t',' -k1 -rn "${f}" 2>/dev/null | head -10 || tail -10 "${f}"
        fi
    fi
done

echo "[${ARM_NAME}] === COMPLETE ==="
