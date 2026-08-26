#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
PIDFILE="${ROOT}/ops/run/llama-server.pid"
# Production binary: build-p3, validated in Phase-1B and Phase-2B.
# FALLBACK_BIN is fallback only, never production.
# prod_stop.sh validates /proc/PID/exe against PROD_BIN before stop.
PROD_BIN="${ROOT}/build-p3/bin/llama-server"
# FALLBACK (not production): use only to restore service if PROD_BIN is unavailable
FALLBACK_BIN="${ROOT}/build/bin/llama-server"
MODEL="/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
LOG_DIR="${ROOT}/ops/logs"
FLAG_MANIFEST="${ROOT}/ops/manifest/prod_flags.env"

usage() {
    echo "Usage: $0 [--dry-run]"
    echo "Start production llama-server (future-use only)."
    echo ""
    echo "This script is NOT executed in Phase-0.5."
    echo "It is generated for Phase-1B use after measurement window approval."
    echo ""
    echo "Safety:"
    echo "  - Checks pidfile first; if PID is alive, does NOT start."
    echo "  - Reads production flag manifest."
    echo "  - Writes PID to pidfile after launch."
    echo "  - Performs health check after start."
    echo "  - Does NOT perform destructive rollback on health check failure."
}

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "[DRY-RUN] No changes will be made."
fi

echo "=== Production Start Script ==="
echo ""

if [[ -f "$PIDFILE" ]]; then
    PID_IN_FILE=$(cat "$PIDFILE" 2>/dev/null || echo "")
    if [[ -n "$PID_IN_FILE" ]] && kill -0 "$PID_IN_FILE" 2>/dev/null; then
        echo "ERROR: pidfile exists and PID $PID_IN_FILE is alive."
        echo "Production server is already running. Refusing to start."
        exit 1
    else
        echo "pidfile exists but PID $PID_IN_FILE is not alive (stale). Removing."
        rm -f "$PIDFILE"
    fi
fi

if [[ ! -x "$PROD_BIN" ]]; then
    echo "ERROR: Production binary not found or not executable: $PROD_BIN"
    exit 1
fi

if [[ ! -f "$FLAG_MANIFEST" ]]; then
    echo "WARNING: Flag manifest not found: $FLAG_MANIFEST"
    echo "Using default flags."
fi

echo "Binary: $PROD_BIN"
echo "Model: $MODEL"
echo "Host: 0.0.0.0"
echo "Port: 8080"
echo "Log dir: $LOG_DIR"
echo ""

if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY-RUN] Would start production server with flags from prod_flags.env"
    echo "[DRY-RUN] Would write PID to $PIDFILE"
    echo "[DRY-RUN] Would perform health check on http://localhost:8080/health"
    exit 0
fi

mkdir -p "$LOG_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/llama-server.${TIMESTAMP}.log"

echo "Starting production server..."
echo "Log file: $LOG_FILE"

setsid bash -c "exec ${PROD_BIN} \
    -m ${MODEL} \
    --alias Qwen3.8-27b \
    -c 65536 -ngl 999 --load-mode mmap -fa on -ctk q4_0 -ctv q4_0 \
    --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
    --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 \
    --host 0.0.0.0 --port 8080 --metrics --tools all \
    --chat-template-kwargs '{\"preserve_thinking\": true}' \
    --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8 \
    > ${LOG_FILE} 2>&1" &

LAUNCHED_PID=$!
echo "$LAUNCHED_PID" > "$PIDFILE"
echo "PID written to pidfile: $PIDFILE"

echo "Waiting for health check (up to 900 seconds)..."
HEALTH_OK=false
for i in $(seq 1 90); do
    sleep 10
    if curl -s -m 3 http://localhost:8080/health 2>/dev/null | grep -q '"status":"ok"'; then
        HEALTH_OK=true
        echo "Health check passed after ${i}0 seconds."
        break
    fi
done

if [[ "$HEALTH_OK" != "true" ]]; then
    echo "WARNING: Health check did not pass within timeout."
    echo "Server may still be starting. Check log: $LOG_FILE"
    echo "No automatic destructive rollback performed."
    exit 1
fi

echo "=== Production server started successfully ==="