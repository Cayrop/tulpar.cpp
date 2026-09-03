#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BASELINE_PIDFILE="${ROOT}/ops/run/baseline-<profile>.pid"

usage() {
    echo "Usage: $0 --profile <profile-name> --i-have-explicit-approval [--allow-force-kill]"
    echo "Stop baseline llama-server (template for Phase-1B)."
    echo ""
    echo "This script is a TEMPLATE and is NOT executed in Phase-0.5."
    echo "It is generated for Phase-1B measurement window use."
    echo ""
    echo "Safety:"
    echo "  - Reads PID only from profile-specific pidfile."
    echo "  - Validates PID via /proc/PID/exe and /proc/PID/cmdline."
    echo "  - Requires --i-have-explicit-approval flag."
    echo "  - Sends SIGTERM first, waits, then reports if still alive."
    echo "  - SIGKILL requires --allow-force-kill (not default)."
    echo "  - Cleans pidfile after stop; preserves logs/manifest."
}

PROFILE=""
EXPLICIT_APPROVAL=false
ALLOW_FORCE_KILL=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile) PROFILE="$2"; shift 2 ;;
        --i-have-explicit-approval) EXPLICIT_APPROVAL=true ;;
        --allow-force-kill) ALLOW_FORCE_KILL=true ;;
        *) echo "Unknown argument: $1"; usage; exit 1 ;;
    esac
done

if [[ -z "$PROFILE" ]]; then
    echo "ERROR: --profile <profile-name> is required."
    usage
    exit 1
fi

if [[ "$EXPLICIT_APPROVAL" != "true" ]]; then
    echo "ERROR: Explicit human approval required (--i-have-explicit-approval)."
    exit 1
fi

PIDFILE="${ROOT}/ops/run/baseline-${PROFILE}.pid"

echo "=== Baseline Stop Template ==="
echo "Profile: $PROFILE"
echo ""

if [[ ! -f "$PIDFILE" ]]; then
    echo "ERROR: pidfile not found: $PIDFILE"
    echo "Cannot stop: no PID recorded for profile '$PROFILE'."
    exit 1
fi

PID_IN_FILE=$(cat "$PIDFILE" 2>/dev/null || echo "")
if [[ -z "$PID_IN_FILE" ]] || ! [[ "$PID_IN_FILE" =~ ^[0-9]+$ ]]; then
    echo "ERROR: pidfile contains invalid PID: $PID_IN_FILE"
    exit 1
fi

echo "Pidfile PID: $PID_IN_FILE"

if ! kill -0 "$PID_IN_FILE" 2>/dev/null; then
    echo "PID $PID_IN_FILE is not alive."
    echo "Removing stale pidfile."
    rm -f "$PIDFILE"
    exit 0
fi

EXE_PATH=$(readlink /proc/$PID_IN_FILE/exe 2>/dev/null || echo "")
CMDLINE=$(cat /proc/$PID_IN_FILE/cmdline 2>/dev/null | tr '\0' ' ' || echo "")

echo "Validating PID $PID_IN_FILE..."
echo "  /proc/PID/exe: $EXE_PATH"
echo "  /proc/PID/cmdline: $CMDLINE"

VALIDATION_FAILED=false

BASELINE_BIN="${ROOT}/build-p3/bin/llama-server"
if [[ "$EXE_PATH" != *"$BASELINE_BIN" ]]; then
    echo "WARNING: exe path does not match baseline binary."
    echo "  expected: $BASELINE_BIN"
    echo "  actual:   $EXE_PATH"
    echo "  Continuing with stop (PID may be a different process)."
fi

echo "Sending SIGTERM to PID $PID_IN_FILE..."
kill -INT "$PID_IN_FILE"

echo "Waiting up to 120 seconds for process to exit..."
STOPPED=false
for i in $(seq 1 12); do
    sleep 10
    if ! kill -0 "$PID_IN_FILE" 2>/dev/null; then
        STOPPED=true
        echo "Process exited after $((i * 10)) seconds."
        break
    fi
done

if [[ "$STOPPED" != "true" ]]; then
    echo "WARNING: Process still alive after 120 seconds."
    if [[ "$ALLOW_FORCE_KILL" == "true" ]]; then
        echo "Sending SIGKILL (force kill allowed)..."
        kill -KILL "$PID_IN_FILE"
        sleep 2
        if ! kill -0 "$PID_IN_FILE" 2>/dev/null; then
            echo "Process killed with SIGKILL."
        else
            echo "ERROR: Process still alive after SIGKILL."
            exit 1
        fi
    else
        echo "Process still alive. Use --allow-force-kill for SIGKILL."
        echo "pidfile preserved for manual intervention."
        exit 1
    fi
fi

rm -f "$PIDFILE"
echo "pidfile removed."
echo ""
echo "=== Baseline server stopped ==="