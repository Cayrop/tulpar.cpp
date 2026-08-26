#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BASELINE_BIN="${ROOT}/build-p3/bin/llama-server"
BASELINE_PIDFILE="${ROOT}/ops/run/baseline-<profile>.pid"
MODEL="/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
LOG_DIR="${ROOT}/ops/logs"

usage() {
    echo "Usage: $0 --profile <profile-name> [--dry-run]"
    echo "Start baseline llama-server (template for Phase-1B)."
    echo ""
    echo "This script is a TEMPLATE and is NOT executed in Phase-0.5."
    echo "It is generated for Phase-1B measurement window use."
    echo ""
    echo "Profiles:"
    echo "  tg-off-1k, tg-off-16k, tg-off-63k, tg-off-128k"
    echo "  tg-on-1k, tg-on-16k, tg-on-63k, tg-on-128k"
    echo "  graph-off variants (with GGML_CUDA_DISABLE_GRAPHS=1)"
    echo ""
    echo "Safety:"
    echo "  - Checks pidfile first; if PID is alive, does NOT start."
    echo "  - Uses build-p3/bin/llama-server (baseline binary)."
    echo "  - Writes PID to profile-specific pidfile."
    echo "  - Performs health check after start."
}

PROFILE=""
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile) PROFILE="$2"; shift 2 ;;
        --dry-run) DRY_RUN=true; shift ;;
        *) echo "Unknown argument: $1"; usage; exit 1 ;;
    esac
done

if [[ -z "$PROFILE" ]]; then
    echo "ERROR: --profile <profile-name> is required."
    usage
    exit 1
fi

echo "=== Baseline Start Template ==="
echo "Profile: $PROFILE"
echo ""

PIDFILE="${ROOT}/ops/run/baseline-${PROFILE}.pid"

if [[ -f "$PIDFILE" ]]; then
    PID_IN_FILE=$(cat "$PIDFILE" 2>/dev/null || echo "")
    if [[ -n "$PID_IN_FILE" ]] && kill -0 "$PID_IN_FILE" 2>/dev/null; then
        echo "ERROR: pidfile exists and PID $PID_IN_FILE is alive."
        echo "Baseline server for profile '$PROFILE' is already running."
        exit 1
    else
        echo "pidfile exists but PID $PID_IN_FILE is not alive (stale). Removing."
        rm -f "$PIDFILE"
    fi
fi

if [[ ! -x "$BASELINE_BIN" ]]; then
    echo "ERROR: Baseline binary not found or not executable: $BASELINE_BIN"
    exit 1
fi

if [[ "$DRY_RUN" == "true" ]]; then
    echo "[DRY-RUN] Would start baseline server for profile '$PROFILE'"
    echo "[DRY-RUN] Binary: $BASELINE_BIN"
    echo "[DRY-RUN] Model: $MODEL"
    echo "[DRY-RUN] Pidfile: $PIDFILE"
    echo "[DRY-RUN] Would perform health check on http://localhost:8080/health"
    exit 0
fi

echo "This is a template script. Uncomment and customize the start command for your measurement window."
echo "See ops/measurement/measurement_window.md for the full procedure."
echo ""
echo "Template start command structure:"
echo "  setsid ${BASELINE_BIN} -m ${MODEL} --alias Qwen3.8-27b -c <ctx> -ngl 999 --load-mode mmap -fa on -ctk q4_0 -ctv q4_0 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --host 127.0.0.1 --port 8080 --metrics [--spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8] > ${LOG_DIR}/srv_${PROFILE}.log 2>&1 &"
echo "  echo \$! > ${PIDFILE}"
echo ""
echo "=== Template ready ==="