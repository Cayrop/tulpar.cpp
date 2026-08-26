#!/usr/bin/env bash
# Phase-1B: optional graph-off diagnostics + gated 128k single-pass arms.
set -uo pipefail
ROOT="$(git rev-parse --show-toplevel)"
CTL="${ROOT}/experiments/phase1b/bin/srv_ctl.sh"
ARM="${ROOT}/experiments/phase1b/bin/arm_run.py"
RAW="${ROOT}/experiments/phase1b/raw"
mkdir -p "$RAW"

run_arm() { # id mtp ctx_target seed reps npred [graph]
    local id="$1" mtp="$2" ptk="$3" seed="$4" reps="$5" npred="$6" graph="${7:-on}"
    echo "=== ARM $id start $(date -Is) ==="
    python3 -u "$ARM" --arm "$id" --mtp "$mtp" --graph "$graph" \
        --prompt-tokens "$ptk" --seed-text "$seed" \
        --reps "$reps" --npred "$npred" > "$RAW/${id}.console.log" 2>&1
    echo "=== ARM $id rc=$? end $(date -Is) ==="
}

# Optional graph-OFF diagnostics at 16k
run_arm D1 off 16320 555001 3 128 off ; echo "D1_status=$?" | tee -a "$RAW/ladder_status.txt"
run_arm D2 on  16320 555001 3 128 off ; echo "D2_status=$?" | tee -a "$RAW/ladder_status.txt"

# 128k gate: memory preconditions
AVAIL=$(free -b | awk 'NR==2{print $7}')
SWAP=$(free -b | awk 'NR==3{print $3}')
if (( AVAIL < 18*1024*1024*1024 )); then
    echo "A7_status=ABORT_MEMAVAILABLE_${AVAIL}" | tee -a "$RAW/ladder_status.txt"
else
    run_arm A7 off 129400 888111 1 96 on
    rc=$?
    echo "A7_status=$rc" | tee -a "$RAW/ladder_status.txt"
    if (( rc == 0 )); then
        AVAIL=$(free -b | awk 'NR==2{print $7}')
        SWAP=$(free -b | awk 'NR==3{print $3}')
        if (( AVAIL >= 18*1024*1024*1024 && SWAP <= 5*1024*1024*1024 )); then
            run_arm A8 on 129400 888111 1 96 on
            echo "A8_status=$?" | tee -a "$RAW/ladder_status.txt"
        else
            echo "A8_status=ABORT_MEM_GUARD_avail=${AVAIL}_swap=${SWAP}" | tee -a "$RAW/ladder_status.txt"
        fi
    else
        echo "A8_status=SKIPPED_A7_FAIL" | tee -a "$RAW/ladder_status.txt"
    fi
fi
echo "DIAG_DONE $(date -Is)" | tee -a "$RAW/ladder_status.txt"
