#!/usr/bin/env bash
# EXP-002 V2 baseline ladder. Sequential fresh-instance arms via arm_run_v2.py
# (pidfile policy). 131k arms gated on preceding 128k VRAM peaks.
# Task spec: OFF group 3 reps at every context (incl 128k/131k); ON group
# 1k/16k/63k/128k, on-131k gated on on-128k peak < 15.3 GiB.
set -uo pipefail

ROOT="$(git rev-parse --show-toplevel)"
VB="${ROOT}/experiments/v2_baseline"
RAW="${VB}/raw"
LOG="${VB}/logs/ladder_v2.log"
STATUS="${RAW}/ladder_status_v2.txt"
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
    python3 "${VB}/bin/arm_run_v2.py" --arm "${arm}" "$@" >> "${LOG}" 2>&1
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
run_arm off-1k   --mtp off --graph on --ctx-size 2048   --prompt-tokens 974    --seed-text 4201024 --reps 4 --npred 128
run_arm off-16k  --mtp off --graph on --ctx-size 17408  --prompt-tokens 16356  --seed-text 555001  --reps 3 --npred 128
run_arm off-63k  --mtp off --graph on --ctx-size 64512  --prompt-tokens 63514  --seed-text 777001  --reps 3 --npred 380
run_arm off-128k --mtp off --graph on --ctx-size 131072 --prompt-tokens 129443 --seed-text 888111  --reps 3 --npred 96

OFF128_PEAK=$(python3 -c "import json;print(json.load(open('${RAW}/off-128k/arm_record.json')).get('vram_peak_gib',99))" 2>/dev/null || echo 99)
if [[ "${ARM_OK}" == "1" && "$(python3 -c "print(1 if ${OFF128_PEAK:-99} < 15.0 else 0)")" == "1" ]]; then
    run_arm off-131k --mtp off --graph on --ctx-size 135168 --prompt-tokens 131000 --seed-text 888112 --reps 3 --npred 96
else
    log "SKIP off-131k (off-128k status=${ARM_OK} peak=${OFF128_PEAK}; gate requires OK and peak<15.0)"
    echo "SKIPPED-GATE off-131k (128k peak=${OFF128_PEAK})" >> "${STATUS}"
fi

# ---- MTP ON group ----
run_arm on-1k   --mtp on --graph on --ctx-size 2048   --prompt-tokens 974    --seed-text 4201024 --reps 4 --npred 128
run_arm on-16k  --mtp on --graph on --ctx-size 17408  --prompt-tokens 16356  --seed-text 555001  --reps 3 --npred 128
run_arm on-63k  --mtp on --graph on --ctx-size 64512  --prompt-tokens 63514  --seed-text 777001  --reps 3 --npred 380
run_arm on-128k --mtp on --graph on --ctx-size 131072 --prompt-tokens 129443 --seed-text 888111  --reps 3 --npred 96

ON128_PEAK=$(python3 -c "import json;print(json.load(open('${RAW}/on-128k/arm_record.json')).get('vram_peak_gib',99))" 2>/dev/null || echo 99)
if [[ "${ARM_OK}" == "1" && "$(python3 -c "print(1 if ${ON128_PEAK:-99} < 15.3 else 0)")" == "1" ]]; then
    run_arm on-131k --mtp on --graph on --ctx-size 135168 --prompt-tokens 131000 --seed-text 888112 --reps 3 --npred 96
else
    log "SKIP on-131k (on-128k status=${ARM_OK} peak=${ON128_PEAK}; gate requires OK and peak<15.3)"
    echo "SKIPPED-GATE on-131k (128k peak=${ON128_PEAK})" >> "${STATUS}"
fi

log "LADDER_END ok_flag=${ARM_OK}"
echo "DONE ok=${ARM_OK} $(date '+%F %T')" >> "${STATUS}"
