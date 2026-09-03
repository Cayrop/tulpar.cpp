#!/usr/bin/env bash
# Run one V2 trace arm using rocprofv2 wrapper
# Usage: ./run_arm_v2.sh <arm_name> <prompt_tokens> <n_predict>
set -uo pipefail

ARM="${1:?Usage: $0 <arm_name> <prompt_tokens> <n_predict>}"
PROMPT_TOKENS="${2:?Missing prompt_tokens}"
N_PREDICT="${3:-32}"
PORT=8080
OUTDIR="experiments/phase_v2_trace/${ARM}"
SERVER_LOGS="${OUTDIR}"

echo "=== ARM: ${ARM} | prompt_tokens: ~${PROMPT_TOKENS} | n_predict: ${N_PREDICT} ==="

# Kill any existing
pkill -9 -f llama-server 2>/dev/null || true
sleep 2

mkdir -p "${OUTDIR}"

# Start server under rocprofv2
cd /home/gencer/llama.cpp
nohup rocprofv2 --kernel-trace \
    /home/gencer/llama.cpp/build-p3/bin/llama-server \
    -m /home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf \
    --alias Qwen3.8-27b \
    -c 131072 -ngl 999 \
    --load-mode mmap -fa on \
    -ctk q4_0 -ctv q4_0 \
    --temp 0 --top-p 0.95 --top-k 20 --min-p 0.0 \
    --cache-prompt --ctx-checkpoints 4 \
    -t 8 -np 1 --host 0.0.0.0 --port ${PORT} \
    --metrics --tools all \
    --chat-template-kwargs '{"preserve_thinking": true}' \
    >"${OUTDIR}/server_stdout.log" 2>"${OUTDIR}/server_stderr.log" &
BG_PID=$!
disown ${BG_PID}
echo "[${ARM}] Server PID: ${BG_PID}"

# Wait for health
echo "[${ARM}] Waiting for server..."
for i in $(seq 1 180); do
    if curl -sf "http://127.0.0.1:${PORT}/health" >/dev/null 2>&1; then
        echo "[${ARM}] Server ready after ${i}s"
        break
    fi
    if ! kill -0 ${BG_PID} 2>/dev/null; then
        echo "[${ARM}] ERROR: Server died after ${i}s"
        tail -20 "${OUTDIR}/server_stderr.log" 2>&1
        exit 1
    fi
    sleep 1
done

# Check readiness
if ! curl -sf "http://127.0.0.1:${PORT}/health" >/dev/null 2>&1; then
    echo "[${ARM}] ERROR: Server not ready"
    exit 1
fi

# Generate prompt to file (avoid ARG_TOO_LONG)
python3 -c "
import json
base = 'The quick brown fox jumps over the lazy dog. '
tokens = ${PROMPT_TOKENS}
reps = max(1, (tokens * 2) // 12)
prompt = (base * reps).strip()
with open('${OUTDIR}/payload.json', 'w') as f:
    json.dump({'prompt': prompt, 'n_predict': ${N_PREDICT}, 'temperature': 0, 'stream': False}, f)
"
echo "[${ARM}] Payload written, sending request..."

# Send request
REQ_START=$(date +%s%3N)
HTTP_CODE=$(curl -s -o "${OUTDIR}/response.json" -w "%{http_code}" \
    "http://127.0.0.1:${PORT}/completion" \
    -H "Content-Type: application/json" \
    -d @"${OUTDIR}/payload.json" \
    --max-time 300)
REQ_END=$(date +%s%3N)
REQ_MS=$(( REQ_END - REQ_START ))
echo "[${ARM}] Request: HTTP ${HTTP_CODE} in ${REQ_MS}ms"

# Parse response
python3 -c "
import json
try:
    d = json.load(open('${OUTDIR}/response.json'))
    print(f'  tokens_evaluated: {d.get(\"tokens_evaluated\", \"?\")}')
    print(f'  tokens_predicted: {d.get(\"tokens_predicted\", \"?\")}')
    t = d.get('timings', {})
    if t:
        print(f'  prompt_per_second: {t.get(\"prompt_per_second\", \"?\")}')
        print(f'  predicted_per_second: {t.get(\"predicted_per_second\", \"?\")}')
except Exception as e:
    print(f'  parse error: {e}')
" 2>&1 || true

# Server will die after request (rocprofv2 behavior)
echo "[${ARM}] Waiting for server to exit and trace to flush..."
wait ${BG_PID} 2>/dev/null || true
sleep 3

# Check trace output
echo "[${ARM}] Trace output:"
ls -la "${OUTDIR}/" 2>&1
DISPATCH_COUNT=$(grep -c "Dispatch_ID" "${OUTDIR}/server_stdout.log" 2>/dev/null || echo 0)
echo "[${ARM}] Total dispatches: ${DISPATCH_COUNT}"

# Run analysis
echo "[${ARM}] Running analysis..."
python3 experiments/phase_v2_trace/analyze_trace.py "${OUTDIR}/server_stdout.log" 2>&1 | grep -v "SyntaxWarning" || true

echo "[${ARM}] === COMPLETE ==="
