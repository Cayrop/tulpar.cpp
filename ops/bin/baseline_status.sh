#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BASELINE_BIN="${ROOT}/build-p3/bin/llama-server"
BASELINE_PIDFILE="${ROOT}/ops/run/baseline-*.pid"

usage() {
    echo "Usage: $0 [--profile <profile-name>]"
    echo "Read-only baseline server status report."
    echo ""
    echo "Checks baseline binary existence and any running baseline processes."
    echo "Profile pidfile pattern: ops/run/baseline-<profile>.pid"
}

PROFILE="${2:-}"

echo "=== Baseline Server Status ==="
echo ""

echo "--- Baseline binary ---"
if [[ -x "$BASELINE_BIN" ]]; then
    echo "Baseline binary exists: YES"
    ls -la "$BASELINE_BIN"
else
    echo "Baseline binary exists: NO"
fi
echo ""

echo "--- Baseline pidfiles ---"
if [[ -n "$PROFILE" ]]; then
    PROFILE_PIDFILE="${ROOT}/ops/run/baseline-${PROFILE}.pid"
    if [[ -f "$PROFILE_PIDFILE" ]]; then
        PID_IN_FILE=$(cat "$PROFILE_PIDFILE" 2>/dev/null || echo "")
        echo "Profile pidfile: $PROFILE_PIDFILE"
        echo "PID in file: $PID_IN_FILE"
        if [[ -n "$PID_IN_FILE" ]] && kill -0 "$PID_IN_FILE" 2>/dev/null; then
            echo "PID alive: YES"
        else
            echo "PID alive: NO (stale pidfile)"
        fi
    else
        echo "Profile pidfile not found: $PROFILE_PIDFILE"
    fi
else
    shopt -s nullglob
    for pidfile in "${ROOT}/ops/run"/baseline-*.pid; do
        if [[ -f "$pidfile" ]]; then
            PID_IN_FILE=$(cat "$pidfile" 2>/dev/null || echo "")
            echo "Pidfile: $pidfile"
            echo "PID: $PID_IN_FILE"
            if [[ -n "$PID_IN_FILE" ]] && kill -0 "$PID_IN_FILE" 2>/dev/null; then
                echo "  PID alive: YES"
            else
                echo "  PID alive: NO (stale)"
            fi
        fi
    done
    shopt -u nullglob
    echo "(No baseline pidfiles found or no profile specified)"
fi
echo ""

echo "--- Baseline llama-server processes (discovery only) ---"
pgrep -ax llama-server 2>/dev/null || echo "No llama-server processes found"
echo ""

echo "=== Baseline status report complete ==="