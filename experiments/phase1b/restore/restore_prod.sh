#!/usr/bin/env bash
# Phase-1B production restore.
# Restores production server using build-p3 binary per prompt decision matrix.
# Flags: ops/manifest/prod_flags.env as base; GGML_CUDA_DISABLE_GRAPHS NOT set
# (real pre-window production process had graphs active, see restore_overrides.md).
set -uo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BIN="${ROOT}/build-p3/bin/llama-server"
MODEL="/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
PIDFILE="${ROOT}/ops/run/llama-server.pid"
LOG_DIR="${ROOT}/ops/logs"
OUT="${ROOT}/experiments/phase1b/restore"
mkdir -p "${LOG_DIR}" "${OUT}"

die() { echo "RESTORE_ABORT: $*" >&2; exit 1; }

echo "=== Phase-1B production restore $(date -Is) ==="

# 1) no measurement servers remain
if pgrep -x llama-server >/dev/null 2>&1; then
    pgrep -ax llama-server || true
    die "llama-server process detected before restore start"
fi

# 2) port 8080 free
if ss -ltn | grep -q ":8080 "; then
    die "port 8080 is occupied"
fi

# 3) pidfile must be absent or stale
if [[ -f "$PIDFILE" ]]; then
    old=$(cat "$PIDFILE" 2>/dev/null || echo "")
    if [[ -n "$old" ]] && kill -0 "$old" 2>/dev/null; then
        die "pidfile holds alive PID ${old}"
    fi
    echo "removing stale pidfile (pid ${old:-empty})"
    rm -f "$PIDFILE"
fi

[[ -x "$BIN" ]] || die "binary not executable: ${BIN}"

# 4) launch production-equivalent server (flags per prod_flags.env)
TS=$(date +%Y%m%d_%H%M%S)
LOG_FILE="${LOG_DIR}/llama-server.${TS}.log"
setsid "${BIN}" \
    -m "${MODEL}" \
    --alias Qwen3.8-27b \
    -c 65536 -ngl 999 --load-mode mmap -fa on -ctk q4_0 -ctv q4_0 \
    --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
    --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 \
    --host 0.0.0.0 --port 8080 --metrics --tools all \
    --chat-template-kwargs '{"preserve_thinking": true}' \
    --spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8 \
    > "${LOG_FILE}" 2>&1 &
PID=$!
echo "$PID" > "$PIDFILE"
echo "launched pid=${PID} pidfile=${PIDFILE} log=${LOG_FILE}"

# 5) health wait up to 900 s
HEALTH_OK=false
for i in $(seq 1 180); do
    sleep 5
    if curl -sf -m 3 http://localhost:8080/health 2>/dev/null | grep -q '"status":"ok"'; then
        HEALTH_OK=true
        echo "health OK after $((i * 5)) s"
        break
    fi
    kill -0 "$PID" 2>/dev/null || { echo "process died during startup"; tail -40 "$LOG_FILE"; die "server exited early"; }
done
"$HEALTH_OK" || { tail -40 "$LOG_FILE"; die "health check failed within 900 s"; }

# 6) validate identity
EXE=$(readlink "/proc/${PID}/exe" 2>/dev/null || echo "")
CMDLINE=$(tr '\0' ' ' < "/proc/${PID}/cmdline" 2>/dev/null || echo "")
echo "exe=${EXE}"
[[ "$EXE" == "$BIN" ]] || die "PID identity mismatch: ${EXE}"
[[ "$CMDLINE" == *"${MODEL}"* ]] || die "cmdline missing model path"
[[ "$CMDLINE" == *"8080"* ]] || die "cmdline missing port 8080"

# 7) capture health + metrics evidence
curl -s -m 5 http://localhost:8080/health > "${OUT}/final_health.json"
curl -s -m 10 http://localhost:8080/metrics > "${OUT}/final_metrics.txt"
head -c 400 "${OUT}/final_health.json"; echo

echo "=== RESTORE_LAUNCH_OK pid=${PID} ==="
