#!/usr/bin/env bash
# Phase-1A safe command set.
# Sections marked READ-ONLY are safe to run anytime.
# Sections marked EXEC are commented out on purpose: they require an
# explicitly approved measurement window (ALLOW_FULL_BENCHMARK=YES by operator)
# AND completion of pre-checks in baseline_runbook.md section 1-2.
# This script never kills, never starts, and never modifies anything as shipped.

ROOT="$(git rev-parse --show-toplevel)"
BIN_TULPAR=$ROOT/build-p3/bin/llama-server
BIN_PROD=$ROOT/build/bin/llama-server
MODEL=/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf
BASE_COMMIT=66dcba5eb7dd92cd460cfc040c7cae42f1254e20

read_only_checks() {
  echo "== git state =="
  git -C "$ROOT" rev-parse HEAD
  git -C "$ROOT" branch --show-current
  git -C "$ROOT" status --porcelain | head

  echo "== binaries =="
  for b in "$BIN_TULPAR" "$BIN_PROD"; do
    ls --time-style=long-iso -la "$b" 2>/dev/null || echo "MISSING: $b"
  done

  echo "== model =="
  ls -la "$MODEL"

  echo "== gpu (read-only) =="
  rocm-smi --showmeminfo vram 2>/dev/null | grep -E "Total|Used"
  rocm-smi --showuse --showtemp --showpower 2>/dev/null | grep -E "GPU use|Temperature \(Sensor edge\)|Package Power"

  echo "== llama processes (report only, NEVER kill) =="
  pgrep -ax llama-server || echo "no llama-server"
  pgrep -af "llama-cli|llama-bench|llama-speculative" || echo "no cli/bench/spec procs"

  echo "== production health =="
  if pid=$(pgrep -x llama-server | head -1); [ -n "$pid" ]; then
    readlink /proc/$pid/exe
    curl -s -m 3 http://localhost:8080/health; echo
  fi

  echo "== verdict helper =="
  if pgrep -x llama-server >/dev/null; then
    echo "SAFE_TO_BENCHMARK=NO (production server running)"
  else
    echo "production not running; still requires VRAM idle + operator approval to benchmark"
  fi
}

exec_arms_commented() {
  cat <<'EOF'
### EXEC ARMS - uncomment only with approved window (see baseline_runbook.md)

# --- Window A/B/C server start template ---
# COMMON=(-m /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf \
#   --alias Qwen3.8-27b -c 131072 -ngl 999 --load-mode mmap -fa on \
#   -ctk q4_0 -ctv q4_0 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
#   --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --host 127.0.0.1 --port 8080 --metrics)
# SPEC_ON=(--spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8)
#
# MTP OFF start:
#   setsid "${COMMON[@]}" > logs/srv_A_off.log 2>&1 & echo $! > commands/srv_A.pid
# MTP ON start:
#   setsid "${COMMON[@]}" "${SPEC_ON[@]}" > logs/srv_B_on.log 2>&1 & echo $! > commands/srv_B.pid
# GRAPHS OFF + MTP OFF start:
#   GGML_CUDA_DISABLE_GRAPHS=1 setsid "${COMMON[@]}" -v > logs/srv_C_nograph.log 2>&1 \
#     & echo $! > commands/srv_C.pid
#
# Stop (pidfile ONLY):
#   kill -INT "$(cat commands/srv_X.pid)"
EOF
}

case "${1:-ro}" in
  ro) read_only_checks ;;
  arms) exec_arms_commented ;;
  *) echo "usage: $0 [ro|arms]" ;;
esac
