#!/usr/bin/env bash
# Phase-2B profiling server lifecycle control (MTP OFF everywhere).
# Pidfile-policy compliant: start/stop ONLY via ops/run/<profile>.pid.
# pgrep is used for discovery/verification only, never for kill.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
BIN="${ROOT}/build-p3/bin/llama-server"
MODEL="/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
RUN_DIR="${ROOT}/ops/run"
LOG_DIR="${ROOT}/experiments/phase2b/logs"
TRACE_DIR="${ROOT}/experiments/phase2b/traces"
HEALTH_URL="http://127.0.0.1:8080/health"

COMMON=(-m "${MODEL}" --alias Qwen3.8-27b -c 131072 -ngl 999 --load-mode mmap \
  -fa on -ctk q4_0 -ctv q4_0 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
  --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --host 127.0.0.1 --port 8080 --metrics)

usage() {
    echo "Usage:"
    echo "  $0 start --profile NAME [--trace-name TAG]"
    echo "      (--trace-name wraps launch in rocprofv3 --kernel-trace --stats,"
    echo "       output under experiments/phase2b/traces/TAG)"
    echo "  $0 stop  --profile"
    echo "  $0 status --profile"
}

die() { echo "ERROR: $*" >&2; exit 1; }

assert_no_llama_server() {
    if pgrep -x llama-server >/dev/null 2>&1; then
        pgrep -ax llama-server || true
        die "a llama-server process is already running; refusing to start"
    fi
}

validate_pid_is_ours() { # $1 pid -> 0 if it is our build-p3 server with our model
    local pid="$1"
    local exe cmdline
    exe=$(readlink "/proc/${pid}/exe" 2>/dev/null || echo "")
    cmdline=$(tr '\0' ' ' < "/proc/${pid}/cmdline" 2>/dev/null || echo "")
    [[ "$exe" == "${BIN}" ]] || return 1
    [[ "$cmdline" == *"${MODEL}"* ]] || return 1
    return 0
}

wait_health() {
    local deadline=$((SECONDS + 900))
    while (( SECONDS < deadline )); do
        if curl -sf -m 3 "${HEALTH_URL}" 2>/dev/null | grep -q '"status":"ok"'; then
            return 0
        fi
        sleep 5
    done
    return 1
}

cmd_start() {
    local profile="" trace_name=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --profile) profile="$2"; shift 2 ;;
            --trace-name) trace_name="$2"; shift 2 ;;
            *) die "unknown arg $1" ;;
        esac
    done
    [[ -n "$profile" ]] || die "--profile required"

    local pidfile="${RUN_DIR}/${profile}.pid"
    mkdir -p "${RUN_DIR}" "${LOG_DIR}" "${TRACE_DIR}"

    if [[ -f "$pidfile" ]]; then
        local old; old=$(cat "$pidfile" 2>/dev/null || echo "")
        if [[ -n "$old" ]] && kill -0 "$old" 2>/dev/null; then
            die "pidfile ${pidfile} holds alive PID ${old}; refusing to start"
        fi
        rm -f "$pidfile"
    fi

    assert_no_llama_server

    local log
    if [[ -n "$trace_name" ]]; then
        log="${LOG_DIR}/srv_${profile}_${trace_name}.log"
    else
        log="${LOG_DIR}/srv_${profile}.log"
    fi
    : > "$log"

    if [[ -n "$trace_name" ]]; then
        local tdir="${TRACE_DIR}/${trace_name}"
        rm -rf "$tdir"; mkdir -p "$tdir"
        echo "starting TRACED profile=${profile} tag=${trace_name} bin=${BIN}"
        setsid /opt/rocm/bin/rocprofv3 --kernel-trace --stats \
            -d "$tdir" -o "p2b_${trace_name}" -f csv --summary-units usec \
            -- "${BIN}" "${COMMON[@]}" >> "$log" 2>&1 &
    else
        echo "starting profile=${profile} bin=${BIN}"
        setsid "${BIN}" "${COMMON[@]}" >> "$log" 2>&1 &
    fi
    local wrapper=$!
    echo "$wrapper" > "$pidfile"
    echo "wrapper pid=${wrapper} pidfile=${pidfile}"

    # Discover the actual llama-server child (direct child of wrapper),
    # validate identity, and store ITS pid as authoritative in the pidfile.
    local srv_pid=""
    for i in $(seq 1 30); do
        srv_pid=$(pgrep -P "$wrapper" -x llama-server 2>/dev/null | head -1 || true)
        [[ -n "$srv_pid" ]] && break
        kill -0 "$wrapper" 2>/dev/null || break
        sleep 1
    done
    if [[ -z "$srv_pid" ]]; then
        # untranced path: wrapper IS the server
        if validate_pid_is_ours "$wrapper"; then srv_pid="$wrapper"; fi
    fi
    if [[ -n "$srv_pid" ]] && validate_pid_is_ours "$srv_pid"; then
        echo "$srv_pid" > "$pidfile"
        echo "server pid=${srv_pid} (validated) -> pidfile"
    else
        echo "WARNING: could not yet validate server child pid; wrapper pid kept"
    fi

    if wait_health; then
        echo "health OK"
        return 0
    fi
    echo "health FAILED after 900s" >&2
    tail -40 "$log" >&2 || true
    exit 3
}

cmd_stop() {
    local profile=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --profile) profile="$2"; shift 2 ;;
            *) die "unknown arg $1" ;;
        esac
    done
    [[ -n "$profile" ]] || die "--profile required"
    local pidfile="${RUN_DIR}/${profile}.pid"
    [[ -f "$pidfile" ]] || die "pidfile not found: ${pidfile}"

    local pid; pid=$(cat "$pidfile")
    [[ "$pid" =~ ^[0-9]+$ ]] || die "invalid PID in pidfile: '${pid}'"

    if ! kill -0 "$pid" 2>/dev/null; then
        echo "PID ${pid} not alive; removing stale pidfile"
        rm -f "$pidfile"
        return 0
    fi

    validate_pid_is_ours "$pid" || die "PID ${pid} validation FAILED (not our build-p3 llama-server); aborting stop"

    echo "SIGINT -> PID ${pid}"
    kill -INT "$pid"
    local i
    # profiler instances need extra time to flush trace buffers on exit
    for i in $(seq 1 100); do
        kill -0 "$pid" 2>/dev/null || break
        sleep 3
    done
    if kill -0 "$pid" 2>/dev/null; then
        echo "still alive after 120s; escalating SIGKILL (recorded)"
        echo "$(date -Is) SIGKILL escalation for pid ${pid} profile ${profile}" >> "${ROOT}/experiments/phase2b/logs/force_kills.txt"
        kill -KILL "$pid"
        sleep 3
        kill -0 "$pid" 2>/dev/null && die "PID ${pid} survived SIGKILL"
    fi
    rm -f "$pidfile"
    echo "stopped; pidfile removed"

    # wait briefly for the profiler wrapper (if any) to flush and exit
    sleep 10
    if pgrep -x llama-server >/dev/null 2>&1; then
        echo "WARNING: an unexpected llama-server still detected:" >&2
        pgrep -ax llama-server >&2 || true
        return 4
    fi
    return 0
}

cmd_status() {
    local profile=""
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --profile) profile="$2"; shift 2 ;;
            *) die "unknown arg $1" ;;
        esac
    done
    local pidfile="${RUN_DIR}/${profile}.pid"
    if [[ -f "$pidfile" ]]; then
        local pid; pid=$(cat "$pidfile")
        if kill -0 "$pid" 2>/dev/null && validate_pid_is_ours "$pid"; then
            echo "RUNNING pid=${pid}"
            return 0
        fi
        echo "STALE pidfile pid=${pid}"
        return 1
    fi
    echo "NO pidfile"
    return 1
}

case "${1:-}" in
    start) shift; cmd_start "$@" ;;
    stop) shift; cmd_stop "$@" ;;
    status) shift; cmd_status "$@" ;;
    *) usage; exit 1 ;;
esac
