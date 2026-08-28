#!/usr/bin/env bash
# V2 Kernel Attribution Trace Runner - Attach Mode
# Attaches rocprofv3 to the already-running llama-server on port 8080
set -euo pipefail

ARM_NAME="${1:?Usage: $0 <arm_name> [n_predict] [prompt_tokens]}"
N_PREDICT="${2:-32}"
PROMPT_TOKENS="${3:-512}"
SERVER_PORT=8080
OUTDIR="experiments/phase_v2_trace/${ARM_NAME}"
DURATION_SEC="${4:-120}"

echo "=== ARM: ${ARM_NAME} | n_predict: ${N_PREDICT} | prompt_tokens: ~${PROMPT_TOKENS} | duration: ${DURATION_SEC}s ==="

# Get server PID
SERVER_PID=$(pgrep -x llama-server | head -1)
if [ -z "${SERVER_PID}" ]; then
    echo "ERROR: No llama-server process found"
    exit 1
fi
echo "Server PID: ${SERVER_PID}"

# Verify server is healthy
if ! curl -sf "http://127.0.0.1:${SERVER_PORT}/health" >/dev/null 2>&1; then
    echo "ERROR: Server not healthy"
    exit 1
fi

# Create output directory
mkdir -p "${OUTDIR}"

# Record VRAM before
echo "--- VRAM Before ---"
rocm-smi --showmeminfo vram 2>&1 | grep -E "GPU|Total|Used" || true

# Generate prompt (repeat a base phrase to approximate desired token count)
BASE_PROMPT="The quick brown fox jumps over the lazy dog. "
# Approximate: ~1.3 tokens per word, ~6 words per repetition
REPS=$(( (PROMPT_TOKENS * 2) / 6 ))
if [ "${REPS}" -lt 1 ]; then REPS=1; fi
PROMPT=$(printf '%0.s'"${BASE_PROMPT}" $(seq 1 ${REPS}))

# Build completion payload
PAYLOAD=$(python3 -c "
import json
prompt = '''${PROMPT}'''
print(json.dumps({
    'prompt': prompt,
    'n_predict': ${N_PREDICT},
    'temperature': 0,
    'stream': False
}))
")

echo "Prompt length (chars): $(echo -n "${PROMPT}" | wc -c)"

# Start rocprofv3 attach in background
echo "--- Starting rocprofv3 attach (${DURATION_SEC}s duration) ---"
DURATION_MSEC=$(( DURATION_SEC * 1000 ))
rocprofv3 \
    --attach "${SERVER_PID}" \
    --attach-duration-msec "${DURATION_MSEC}" \
    --kernel-trace \
    --stats \
    --output-format csv \
    --output-directory "${OUTDIR}" \
    --output-file "trace" \
    2>"${OUTDIR}/rocprofv3_stderr.log" &
ROC_PID=$!
echo "rocprofv3 PID: ${ROC_PID}"

# Wait for rocprofv3 to attach (poll for attach indicator)
echo "Waiting for profiler attachment..."
sleep 3

# Check if rocprofv3 is still running
if ! kill -0 ${ROC_PID} 2>/dev/null; then
    echo "ERROR: rocprofv3 exited before we could send request"
    cat "${OUTDIR}/rocprofv3_stderr.log" 2>&1 | tail -20
    exit 1
fi

# Send completion request
echo "--- Sending completion request ---"
REQ_START=$(date +%s%3N)
RESPONSE=$(curl -sf -w "\n%{http_code}" \
    "http://127.0.0.1:${SERVER_PORT}/completion" \
    -H "Content-Type: application/json" \
    -d "${PAYLOAD}" \
    --max-time $(( DURATION_SEC - 10 )) 2>&1) || true
REQ_END=$(date +%s%3N)
REQ_MS=$(( REQ_END - REQ_START ))

HTTP_CODE=$(echo "${RESPONSE}" | tail -1)
BODY=$(echo "${RESPONSE}" | sed '$d')

echo "HTTP Code: ${HTTP_CODE}"
echo "Request time: ${REQ_MS}ms"
echo "Response preview: $(echo "${BODY}" | python3 -c "import sys,json; d=json.load(sys.stdin); print('tokens:', d.get('tokens_evaluated','?'), 'predicted:', d.get('content','')[:100])" 2>/dev/null || echo "${BODY}" | head -c 200)"

# Save response
echo "${BODY}" > "${OUTDIR}/response.json" 2>/dev/null || echo "${BODY}" > "${OUTDIR}/response.txt"

# Wait for rocprofv3 to complete (or timeout)
echo "--- Waiting for rocprofv3 to complete ---"
if kill -0 ${ROC_PID} 2>/dev/null; then
    echo "Profiler still running, waiting up to 60s..."
    wait ${ROC_PID} 2>/dev/null &
    WAIT_PID=$!
    timeout 60 tail --pid=${WAIT_PID} -f /dev/null 2>/dev/null || true
    kill ${WAIT_PID} 2>/dev/null || true
    # If still running, let it finish naturally
    if kill -0 ${ROC_PID} 2>/dev/null; then
        echo "Profiler still running, waiting for attach duration to expire..."
        wait ${ROC_PID} 2>/dev/null || true
    fi
fi

# Record VRAM after
echo "--- VRAM After ---"
rocm-smi --showmeminfo vram 2>&1 | grep -E "GPU|Total|Used" || true

# Check trace output
echo "--- Trace Output Files ---"
ls -la "${OUTDIR}/" 2>&1
echo "--- CSV Files ---"
for f in "${OUTDIR}"/*.csv; do
    if [ -f "$f" ]; then
        echo "=== $(basename ${f}) ==="
        echo "Lines: $(wc -l < "${f}")"
        head -3 "${f}" 2>&1
        echo "..."
    fi
done

# Save metadata
cat > "${OUTDIR}/metadata.json" << EOF
{
    "arm": "${ARM_NAME}",
    "n_predict": ${N_PREDICT},
    "prompt_tokens_approx": ${PROMPT_TOKENS},
    "server_pid": ${SERVER_PID},
    "request_time_ms": ${REQ_MS},
    "http_code": "${HTTP_CODE}",
    "timestamp": "$(date -Iseconds)",
    "duration_sec": ${DURATION_SEC}
}
EOF

echo "=== ARM ${ARM_NAME} COMPLETE ==="
