#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
PIDFILE="${ROOT}/ops/run/llama-server.pid"
HEALTH_URL="http://localhost:8080/health"
HEALTH_TIMEOUT=3

usage() {
    echo "Usage: $0"
    echo "Read-only production server health check."
    echo ""
    echo "Performs HTTP GET to health endpoint."
    echo "Uses curl if available, falls back to python3 urllib."
    echo "No state changes."
}

if [[ -f "$PIDFILE" ]]; then
    PID_IN_FILE=$(cat "$PIDFILE" 2>/dev/null || echo "")
    if [[ -n "$PID_IN_FILE" ]] && kill -0 "$PID_IN_FILE" 2>/dev/null; then
        echo "Production server PID $PID_IN_FILE is alive."
    else
        echo "WARNING: pidfile exists but PID $PID_IN_FILE is not alive."
    fi
else
    echo "WARNING: pidfile not found at $PIDFILE"
fi

echo ""
echo "--- Health Check ---"
echo "URL: $HEALTH_URL"
echo "Timeout: ${HEALTH_TIMEOUT}s"
echo ""

if command -v curl &>/dev/null; then
    RESPONSE=$(curl -s -m "$HEALTH_TIMEOUT" "$HEALTH_URL" 2>/dev/null || echo "CURL_FAILED")
    if [[ "$RESPONSE" == "CURL_FAILED" ]]; then
        echo "curl request failed or timed out."
        echo "Server may be down or unreachable."
        exit 1
    fi
    echo "Response: $RESPONSE"
    if echo "$RESPONSE" | grep -q '"status":"ok"'; then
        echo "Health status: OK"
    else
        echo "Health status: UNEXPECTED RESPONSE"
        exit 1
    fi
elif command -v python3 &>/dev/null; then
    RESPONSE=$(python3 -c "
import urllib.request, sys
try:
    req = urllib.request.urlopen('$HEALTH_URL', timeout=$HEALTH_TIMEOUT)
    print(req.read().decode('utf-8'))
except Exception as e:
    print(f'PYTHON_FALLBACK_FAILED: {e}', file=sys.stderr)
    sys.exit(1)
" 2>&1) || {
        echo "python3 fallback health check failed."
        exit 1
    }
    echo "Response: $RESPONSE"
    if echo "$RESPONSE" | grep -q '"status":"ok"'; then
        echo "Health status: OK"
    else
        echo "Health status: UNEXPECTED RESPONSE"
        exit 1
    fi
else
    echo "ERROR: Neither curl nor python3 available for health check."
    exit 1
fi

echo ""
echo "=== Health check complete ==="