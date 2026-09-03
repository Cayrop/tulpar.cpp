#!/usr/bin/env bash
# Phase-2B production restore. build-p3 binary + prod_flags.env verbatim
# (binary path per corrected manifest; GGML_CUDA_DISABLE_GRAPHS not set,
# matching the actual pre-window production process).
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
BIN="${ROOT}/build-p3/bin/llama-server"
MODEL="/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
PIDFILE="${ROOT}/ops/run/llama-server.pid"

if pgrep -x llama-server >/dev/null 2>&1; then
    echo "ERROR: llama-server already running"; pgrep -ax llama-server; exit 1
fi
LOG="${ROOT}/ops/logs/llama-server.$(date +%Y%m%d_%H%M%S).log"
setsid bash -c "exec ${BIN} \
    -m ${MODEL} \
    --alias Qwen3.8-27b \
    -c 65536 -ngl 999 --load-mode mmap -fa on -ctk q4_0 -ctv q4_0 \
    --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
    --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 \
    --host 0.0.0.0 --port 8080 --metrics --tools all \
    --chat-template-kwargs '{\"preserve_thinking\": true}' \
    --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8 \
    > ${LOG} 2>&1" &
LPID=$!
echo "$LPID" > "$PIDFILE"
echo "launched wrapper pid ${LPID}, log ${LOG}"
for i in $(seq 1 90); do
    sleep 5
    if curl -s -m 3 http://localhost:8080/health 2>/dev/null | grep -q '"status":"ok"'; then
        echo "health OK after ~$((i*5))s"
        SRV=$(pgrep -P "$LPID" -x llama-server | head -1)
        [[ -z "$SRV" ]] && SRV="$LPID"
        echo "$SRV" > "$PIDFILE"
        echo "server pid ${SRV} -> ${PIDFILE}"
        readlink /proc/${SRV}/exe
        exit 0
    fi
done
echo "HEALTH FAILED"; tail -30 "$LOG"; exit 2
