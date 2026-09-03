#!/usr/bin/env bash
# Phase-1B primary performance ladder. Fresh server per arm.
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
    local rc=$?
    echo "=== ARM $id rc=$rc end $(date -Is) ==="
    return $rc
}

# Window A: MTP OFF baseline
run_arm A1 off   960   4201024 4 128 ; echo "A1_status=$?" | tee -a "$RAW/ladder_status.txt"
run_arm A2 off  16320  555001  3 128 ; echo "A2_status=$?" | tee -a "$RAW/ladder_status.txt"

# Window B: MTP ON
# resumed after session-kill incident: A1/A2 already complete
run_arm A3 off  63500  777001  3 380 ; echo "A3_status=$?" | tee -a "$RAW/ladder_status.txt"
run_arm A4 on    960   4201024 4 128 ; echo "A4_status=$?" | tee -a "$RAW/ladder_status.txt"
run_arm A5 on  16320  555001  3 128 ; echo "A5_status=$?" | tee -a "$RAW/ladder_status.txt"
run_arm A6 on  63500  777001  3 380 ; echo "A6_status=$?" | tee -a "$RAW/ladder_status.txt"
echo "LADDER_DONE $(date -Is)" | tee -a "$RAW/ladder_status.txt"
