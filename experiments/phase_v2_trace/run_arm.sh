#!/usr/bin/env bash
# Run one V2 trace arm: captures prefill + decode as two separate server
# instances (each wrapped by rocprofv2) so the two phases never mix in one
# CSV. After both phases finish, the analyzer strips the prefill segment from
# the decode trace by matching kernel signatures with the prefill trace.
#
# Usage: ./run_arm.sh <arm_name> <ctx_size> <prompt_tokens> [n_predict]
#
# Required env:
#   MODEL_PATH   - path to GGUF (default: V2 model)
#   SERVER_BIN   - path to llama-server binary
set -uo pipefail

ARM="${1:?Usage: $0 <arm_name> <ctx_size> <prompt_tokens> [n_predict]}"
CTX_SIZE="${2:?Usage: $0 <arm_name> <ctx_size> <prompt_tokens> [n_predict]}"
PROMPT_TOKENS="${3:?Usage: $0 <arm_name> <ctx_size> <prompt_tokens> [n_predict]}"
N_PREDICT="${4:-64}"

MODEL_PATH="${MODEL_PATH:-/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf}"
SERVER_BIN="${SERVER_BIN:-/home/gencer/llama.cpp/build-p3/bin/llama-server}"

OUTDIR_BASE="experiments/phase_v2_trace/trace_artifacts/${ARM}"
P_DIR="${OUTDIR_BASE}/P"
D_DIR="${OUTDIR_BASE}/D"
PORT_P=8080
PORT_D=8081
LOG_PREFIX="[${ARM}]"

mkdir -p "${P_DIR}" "${D_DIR}"

PIDFILE="/tmp/opencode/v2reset/${ARM}.pid"

# Server timeout (per task: 600s, up from 300s)
CURL_TIMEOUT=600

# Approx 4 chars per token; "The quick brown fox jumps over the lazy dog. " is
# 46 chars (~12 tokens).
BASE_STR='Once upon a time, in a small village by the sea, there lived a curious child who loved to explore the rocky shoreline and collect interesting seashells, driftwood pieces, and colorful stones. Each morning the child would wake before sunrise, eat a quick breakfast of fresh bread and warm milk, and run down the winding path to the beach to watch the waves crash against the ancient stone breakwater while seabirds circled overhead crying out in their distinctive calls. The villagers said the shoreline held many secrets waiting to be discovered by anyone patient enough to search carefully among the tide pools and hidden coves scattered along the coast for miles in both directions. One day, while exploring a cave that was only accessible during low tide, the child discovered a small wooden chest half-buried in the sand behind a curtain of hanging seaweed, and inside the chest there was '
TOKEN_PER_REP=120
REPS=$(( (PROMPT_TOKENS + TOKEN_PER_REP - 1) / TOKEN_PER_REP ))

echo "${LOG_PREFIX} === ARM ${ARM} ==="
echo "${LOG_PREFIX} CTX=${CTX_SIZE}  prompt_tokens~${PROMPT_TOKENS}  n_predict=${N_PREDICT}"
echo "${LOG_PREFIX} P_DIR=${P_DIR}"
echo "${LOG_PREFIX} D_DIR=${D_DIR}"
echo "${LOG_PREFIX} MODEL=${MODEL_PATH}"
echo "${LOG_PREFIX} BIN  =${SERVER_BIN}"

# ---- Sanity checks ----
if [ ! -f "${MODEL_PATH}" ]; then
    echo "${LOG_PREFIX} FATAL: model not found at ${MODEL_PATH}"
    exit 1
fi
if [ ! -x "${SERVER_BIN}" ]; then
    echo "${LOG_PREFIX} FATAL: binary not found at ${SERVER_BIN}"
    exit 1
fi
if ! command -v rocprofv2 >/dev/null; then
    echo "${LOG_PREFIX} FATAL: rocprofv2 not in PATH"
    exit 1
fi

kill_existing() {
    if [ -f "${PIDFILE}" ]; then
        local opid; opid=$(cat "${PIDFILE}" 2>/dev/null || true)
        if [ -n "${opid}" ] && kill -0 "${opid}" 2>/dev/null; then
            echo "${LOG_PREFIX} Killing previous server PID ${opid}"
            kill -9 "${opid}" 2>/dev/null || true
            sleep 1
        fi
        rm -f "${PIDFILE}"
    fi
    pkill -9 -f "llama-server" 2>/dev/null || true
    sleep 1
}

start_server_under_rocprofv2() {
    local outdir="$1"
    local port="$2"
    local label="$3"
    echo "${LOG_PREFIX} [${label}] Starting server (port=${port}) under rocprofv2..."
    cd /home/gencer/llama.cpp
    nohup rocprofv2 --kernel-trace \
        -d "${outdir}" \
        -o "trace_${label}" \
        "${SERVER_BIN}" \
        -m "${MODEL_PATH}" \
        --alias "Qwen3.8-27b-${ARM}-${label}" \
        -c "${CTX_SIZE}" -ngl 999 \
        --load-mode mmap -fa on \
        -ctk q4_0 -ctv q4_0 \
        --temp 0 --top-p 0.95 --top-k 20 --min-p 0.0 \
        --cache-prompt --ctx-checkpoints 4 \
        -t 8 -np 1 --host 0.0.0.0 --port "${port}" \
        --metrics --tools all \
        --chat-template-kwargs '{"preserve_thinking": true}' \
        >"${outdir}/server_stdout.log" 2>"${outdir}/server_stderr.log" &
    local bg_pid=$!
    disown "${bg_pid}" 2>/dev/null || true
    echo "${bg_pid}" > "${PIDFILE}"
    echo "${LOG_PREFIX} [${label}] PID=${bg_pid}"
}

wait_for_health() {
    local outdir="$1"
    local port="$2"
    local label="$3"
    local deadline=$((SECONDS + 240))
    while [ "${SECONDS}" -lt "${deadline}" ]; do
        if curl -sf "http://127.0.0.1:${port}/health" >/dev/null 2>&1; then
            echo "${LOG_PREFIX} [${label}] server ready on port ${port}"
            return 0
        fi
        local pid; pid=$(cat "${PIDFILE}" 2>/dev/null || true)
        if [ -z "${pid}" ] || ! kill -0 "${pid}" 2>/dev/null; then
            echo "${LOG_PREFIX} [${label}] FATAL: server died during startup"
            tail -30 "${outdir}/server_stderr.log" 2>&1 || true
            return 1
        fi
        sleep 1
    done
    echo "${LOG_PREFIX} [${label}] FATAL: server not ready after 240s"
    return 1
}

send_request() {
    local port="$1"
    local n_predict="$2"
    local payload="$3"
    local outfile="$4"
    local label="$5"
    local req_start_ms req_end_ms req_ms http_code
    req_start_ms=$(date +%s%3N)
    http_code=$(curl -s -o "${outfile}" -w "%{http_code}" \
        "http://127.0.0.1:${port}/completion" \
        -H "Content-Type: application/json" \
        -d @"${payload}" \
        --max-time "${CURL_TIMEOUT}")
    req_end_ms=$(date +%s%3N)
    req_ms=$(( req_end_ms - req_start_ms ))
    echo "${LOG_PREFIX} [${label}] HTTP=${http_code} elapsed=${req_ms}ms"
    if [ "${http_code}" != "200" ]; then
        echo "${LOG_PREFIX} [${label}] FATAL: non-200 response (see ${outfile})"
        return 1
    fi
    return 0
}

# ---- Phase P: prefill-only request (n_predict=1) ----
kill_existing
start_server_under_rocprofv2 "${P_DIR}" "${PORT_P}" "P" || exit 1
wait_for_health "${P_DIR}" "${PORT_P}" "P" || exit 1
echo "${LOG_PREFIX} [P] Pre-trace VRAM:"
rocm-smi --showmeminfo vram 2>/dev/null | grep -E "GPU\[0\]" | head -2

# Build payload sized to requested prompt tokens. cap at ctx_size-256 to leave
# room for the single generated token + a safety margin.
PROMPT_TOKENS_PAYLOAD=$PROMPT_TOKENS
MAX_PROMPT_CTX=$(( CTX_SIZE - 256 ))
if [ "${PROMPT_TOKENS_PAYLOAD}" -gt "${MAX_PROMPT_CTX}" ]; then
    PROMPT_TOKENS_PAYLOAD="${MAX_PROMPT_CTX}"
fi
python3 - <<PYEOF
import json
base = 'The quick brown fox jumps over the lazy dog. '
reps = ${REPS}
prompt = (base * reps)[: ${PROMPT_TOKENS_PAYLOAD} * 4 + 64]
payload = {'prompt': prompt, 'n_predict': 1, 'temperature': 0,
           'stream': False, 'cache_prompt': True}
with open('${P_DIR}/payload.json', 'w') as f:
    json.dump(payload, f)
print('  payload chars:', len(prompt), 'n_predict: 1')
PYEOF

echo "${LOG_PREFIX} [P] sleeping 5s after warmup"
sleep 5
P_REQ_START=$(date +%s%3N)
send_request "${PORT_P}" 1 "${P_DIR}/payload.json" "${P_DIR}/response.json" "P" || exit 1
P_REQ_END=$(date +%s%3N)
P_REQ_MS=$(( P_REQ_END - P_REQ_START ))

echo "${LOG_PREFIX} [P] Peak VRAM after prefill:"
rocm-smi --showmeminfo vram 2>/dev/null | grep -E "GPU\[0\]" | head -2

# Server may exit after first request (rocprofv2 behavior). Wait for it to die
# cleanly so rocprofv2 flushes the CSV. If it lingers, force-kill.
WAIT_DEADLINE=$((SECONDS + 30))
while [ "${SECONDS}" -lt "${WAIT_DEADLINE}" ]; do
    if ! kill -0 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null; then
        break
    fi
    sleep 1
done
if kill -0 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null; then
    echo "${LOG_PREFIX} [P] server still alive after 30s, killing"
    kill -9 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null || true
fi
sleep 5

# ---- Phase D: decode request (n_predict=64) ----
kill_existing
sleep 1
start_server_under_rocprofv2 "${D_DIR}" "${PORT_D}" "D" || exit 1
wait_for_health "${D_DIR}" "${PORT_D}" "D" || exit 1
echo "${LOG_PREFIX} [D] Pre-trace VRAM:"
rocm-smi --showmeminfo vram 2>/dev/null | grep -E "GPU\[0\]" | head -2

# Same prompt as P so prefill kernel sequence is identical
python3 - <<PYEOF
import json
base = 'The quick brown fox jumps over the lazy dog. '
reps = ${REPS}
prompt = (base * reps)[: ${PROMPT_TOKENS_PAYLOAD} * 4 + 64]
payload = {'prompt': prompt, 'n_predict': ${N_PREDICT}, 'temperature': 0,
           'stream': False, 'cache_prompt': True}
with open('${D_DIR}/payload.json', 'w') as f:
    json.dump(payload, f)
print('  payload chars:', len(prompt), 'n_predict: ${N_PREDICT}')
PYEOF

echo "${LOG_PREFIX} [D] sleeping 5s after warmup"
sleep 5
D_REQ_START=$(date +%s%3N)
send_request "${PORT_D}" "${N_PREDICT}" "${D_DIR}/payload.json" "${D_DIR}/response.json" "D" || exit 1
D_REQ_END=$(date +%s%3N)
D_REQ_MS=$(( D_REQ_END - D_REQ_START ))

echo "${LOG_PREFIX} [D] Peak VRAM after decode:"
rocm-smi --showmeminfo vram 2>/dev/null | grep -E "GPU\[0\]" | head -2

WAIT_DEADLINE=$((SECONDS + 30))
while [ "${SECONDS}" -lt "${WAIT_DEADLINE}" ]; do
    if ! kill -0 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null; then
        break
    fi
    sleep 1
done
if kill -0 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null; then
    echo "${LOG_PREFIX} [D] server still alive after 30s, killing"
    kill -9 "$(cat "${PIDFILE}" 2>/dev/null)" 2>/dev/null || true
fi
sleep 5
rm -f "${PIDFILE}"

# ---- Summary ----
cat > "${OUTDIR_BASE}/summary.json" <<JSONEOF
{
    "arm": "${ARM}",
    "ctx_size": ${CTX_SIZE},
    "prompt_tokens_target": ${PROMPT_TOKENS},
    "prompt_tokens_payload": ${PROMPT_TOKENS_PAYLOAD},
    "n_predict": ${N_PREDICT},
    "p_request_ms": ${P_REQ_MS},
    "d_request_ms": ${D_REQ_MS},
    "model": "${MODEL_PATH}",
    "binary": "${SERVER_BIN}",
    "timestamp": "$(date -Iseconds)"
}
JSONEOF

echo "${LOG_PREFIX} === ARM ${ARM} COMPLETE ==="
echo "${LOG_PREFIX} P: ${P_REQ_MS}ms   D: ${D_REQ_MS}ms"
echo "${LOG_PREFIX} P trace: ${P_DIR}/"
echo "${LOG_PREFIX} D trace: ${D_DIR}/"
