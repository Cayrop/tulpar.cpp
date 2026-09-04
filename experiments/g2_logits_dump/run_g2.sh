#!/usr/bin/env bash
set -u

ROOT="$(git rev-parse --show-toplevel)"
BUILD="$ROOT/build-p3"
EXP_DIR="$ROOT/experiments/g2_logits_dump"
BIN="$EXP_DIR/g2_logits_dump"
COMPARE="$EXP_DIR/compare_g2.py"
MODEL_PATH="${MODEL_PATH:-/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf}"
PROMPT="${PROMPT:-The quick brown fox jumps over the lazy dog. }"
N_PREDICT="${N_PREDICT:-128}"
SEED="${SEED:-42}"
NGl="${NGl:-999}"
PORT="${PORT:-8080}"
OUT="$EXP_DIR/g2_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUT"

log() {
    echo "$@" | tee -a "$OUT/run.log"
}

build_binary() {
    g++ -O2 -std=c++17 \
        -I"$ROOT/include" \
        -I"$ROOT/ggml/include" \
        "$EXP_DIR/g2_logits_dump.cpp" \
        -o "$BIN" \
        "$BUILD/bin/libllama.so" \
        "$BUILD/bin/libggml-hip.so" \
        "$BUILD/bin/libggml-base.so" \
        "$BUILD/bin/libggml.so"
}

server_running() {
    pgrep -f "llama-server -m" >/dev/null 2>&1
}

stop_server() {
    systemctl --user stop llama-server.service 2>"$OUT/stop.log" || true
    local i=0
    while [ "$i" -lt 60 ]; do
        if ! server_running; then
            return 0
        fi
        sleep 1
        i=$((i + 1))
    done
    if server_running; then
        pkill -f "llama-server -m" 2>/dev/null || true
        sleep 5
    fi
}

wait_for_stop() {
    local i=0
    while [ "$i" -lt 60 ]; do
        if ! server_running; then
            return 0
        fi
        sleep 1
        i=$((i + 1))
    done
    return 1
}

gpu_mem_percent() {
    rocm-smi --showmemuse 2>/dev/null \
        | awk '/VRAM%\):/{print $7}' \
        | tr -d '%' \
        | head -n 1
}

wait_gpu_low() {
    local i=0
    while [ "$i" -lt 60 ]; do
        local mem="$(gpu_mem_percent)"
        if [ -n "$mem" ] && [ "$mem" -lt 5 ]; then
            return 0
        fi
        sleep 2
        i=$((i + 2))
    done
    log "warning: GPU memory did not drop below 5% in 60s"
}

start_server() {
    systemctl --user start llama-server.service 2>"$OUT/start.log" || true
    local i=0
    while [ "$i" -lt 600 ]; do
        if curl -fsS "http://127.0.0.1:$PORT/health" >/dev/null 2>&1; then
            return 0
        fi
        sleep 2
        i=$((i + 2))
    done
    return 1
}

ensure_server_started() {
    if ! systemctl --user is-active llama-server.service >/dev/null 2>&1; then
        start_server || log "error: llama-server did not become healthy"
    fi
}

trap ensure_server_started EXIT

log "ROOT=$ROOT"
log "MODEL_PATH=$MODEL_PATH"
log "PROMPT=$PROMPT"
log "N_PREDICT=$N_PREDICT SEED=$SEED NGl=$NGl PORT=$PORT"

build_binary || {
    log "error: build failed"
    exit 1
}

stop_server
if ! wait_for_stop; then
    log "error: llama-server is still running"
    exit 1
fi
log "server stopped"

wait_gpu_low

status=0

log "running ON"
if ! env LD_LIBRARY_PATH="$BUILD/bin" \
    "$BIN" \
    -m "$MODEL_PATH" \
    -o "$OUT/on.bin" \
    -t "$OUT/on.toks" \
    -x "$OUT/on.txt" \
    -p "$PROMPT" \
    -n "$N_PREDICT" \
    -s "$SEED" \
    -ngl "$NGl" \
    >"$OUT/on.log" 2>&1; then
    log "error: ON dump failed"
    status=1
fi

log "running OFF"
if ! env GGML_FA_DECODE_RDNA3_OFF=1 \
    LD_LIBRARY_PATH="$BUILD/bin" \
    "$BIN" \
    -m "$MODEL_PATH" \
    -o "$OUT/off.bin" \
    -t "$OUT/off.toks" \
    -x "$OUT/off.txt" \
    -p "$PROMPT" \
    -n "$N_PREDICT" \
    -s "$SEED" \
    -ngl "$NGl" \
    >"$OUT/off.log" 2>&1; then
    log "error: OFF dump failed"
    status=1
fi

if [ "$status" -eq 0 ]; then
    log "comparing"
    python3 "$COMPARE" "$OUT/on.bin" "$OUT/off.bin" --threshold 0.01 >"$OUT/compare.log" 2>&1
    compare_rc=$?
    cat "$OUT/compare.log" >>"$OUT/run.log"
    if [ "$compare_rc" -ne 0 ]; then
        log "error: compare failed"
        status=1
    fi
    if [ -f "$OUT/on.txt" ] && [ -f "$OUT/off.txt" ]; then
        if ! cmp -s "$OUT/on.txt" "$OUT/off.txt"; then
            log "error: generated text files differ"
            status=1
        fi
    fi
fi

log "status=$status"
if [ "$status" -ne 0 ]; then
    exit 1
fi
