#!/usr/bin/env bash
# Phase-1 untraced baseline ladder (V3). Sequential fresh-instance arms via
# arm_run_p1.py (pidfile policy). Production must already be stopped.
set -uo pipefail

ROOT="$(git rev-parse --show-toplevel)"
PH1="${ROOT}/experiments/phase1"
RAW="${PH1}/phase1_raw"
LOG="${PH1}/logs/untraced_ladder.log"
STATUS="${RAW}/untraced_status.txt"
mkdir -p "${RAW}"

log() { echo "$(date '+%F %T') $*" >> "${LOG}"; }

mem_swap_b() { free -b | awk 'NR==3{print $3}'; }
mem_avail_b() { free -b | awk 'NR==2{print $7}'; }

SWAP_START=$(mem_swap_b)
log "LADDER_START swap_start_b=${SWAP_START}"
echo "RUNNING $(date '+%F %T')" > "${STATUS}"

ARM_OK=1
run_arm() {
    local arm="$1"; shift
    if [[ "${ARM_OK}" != "1" ]]; then
        log "SKIP ${arm} (previous failure)"
        echo "SKIPPED ${arm}" >> "${STATUS}"
        return
    fi
    if pgrep -x llama-server >/dev/null 2>&1; then
        log "ABORT ${arm}: unexpected llama-server running"
        echo "ABORT_UNEXPECTED_SERVER ${arm}" >> "${STATUS}"; ARM_OK=0; return
    fi
    local pre_avail=$(mem_avail_b)
    log "ARM_START ${arm} avail_b=${pre_avail}"
    python3 "${PH1}/bin/arm_run_p1.py" --arm "${arm}" "$@" >> "${LOG}" 2>&1
    local rc=$?
    local rec="${RAW}/${arm}/arm_record.json"
    local st="NO_RECORD" peak="?" health="?"; local swap_now=$(mem_swap_b)
    local dswap=$((swap_now - SWAP_START))
    if [[ -f "${rec}" ]]; then
        st=$(python3 -c "import json;r=json.load(open('${rec}'));print(r.get('status','?'))")
        peak=$(python3 -c "import json;r=json.load(open('${rec}'));print(r.get('vram_peak_gib','?'))")
        health=$(python3 -c "import json;r=json.load(open('${rec}'));print(r.get('health_after_reps',r.get('health','?')))")
    fi
    log "ARM_END ${arm} rc=${rc} status=${st} vram_peak_gib=${peak} health_after_reps=${health} swap_delta_gb=$(python3 -c "print(round(${dswap}/1e9,2))") avail_gb=$(python3 -c "print(round($(mem_avail_b)/1e9,2))")"
    echo "${arm} rc=${rc} status=${st} peak=${peak} health=${health}" >> "${STATUS}"
    if [[ "${rc}" != "0" || "${st}" != "OK" ]]; then ARM_OK=0; fi
    if (( dswap > 5000000000 )); then
        log "GUARD_TRIP swap_delta>${dswap}; aborting remaining arms"
        echo "GUARD_TRIP_SWAP ${arm}" >> "${STATUS}"; ARM_OK=0
    fi
}

# ---- MTP OFF group ----
run_arm U-1k-OFF   --mtp off --graph on --ctx-size 2048   --prompt-tokens 974    --seed-text 4201024 --reps 4 --npred 128
run_arm U-16k-OFF  --mtp off --graph on --ctx-size 17408  --prompt-tokens 16356  --seed-text 555001  --reps 3 --npred 128
run_arm U-63k-OFF  --mtp off --graph on --ctx-size 64512  --prompt-tokens 63514  --seed-text 777001  --reps 3 --npred 380
run_arm U-128k-OFF --mtp off --graph on --ctx-size 131072 --prompt-tokens 129443 --seed-text 888111  --reps 3 --npred 96
run_arm U-131k-OFF --mtp off --graph on --ctx-size 135168 --prompt-tokens 131000 --seed-text 888112  --reps 3 --npred 96

# ---- MTP ON group (no 131k) ----
run_arm U-1k-ON   --mtp on --graph on --ctx-size 2048   --prompt-tokens 974    --seed-text 4201024 --reps 4 --npred 128
run_arm U-16k-ON  --mtp on --graph on --ctx-size 17408  --prompt-tokens 16356  --seed-text 555001  --reps 3 --npred 128
run_arm U-63k-ON  --mtp on --graph on --ctx-size 64512  --prompt-tokens 63514  --seed-text 777001  --reps 3 --npred 380
run_arm U-128k-ON --mtp on --graph on --ctx-size 131072 --prompt-tokens 129443 --seed-text 888111  --reps 3 --npred 96

log "LADDER_END ok_flag=${ARM_OK}"
echo "DONE ok=${ARM_OK} $(date '+%F %T')" >> "${STATUS}"
