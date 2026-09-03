#!/usr/bin/env bash
# Phase-2 Step 5.4: single traced arm T-P2-128k-OFF.
# One rocprofv3 --kernel-trace --stats wrapped instance; probe (n_predict=1,
# fresh prefill trace) then main decode (n_predict=32, cached prompt).
set -uo pipefail
ROOT="$(git rev-parse --show-toplevel)"
PH2="${ROOT}/experiments/phase2"
RAW="${PH2}/raw"
LOG="${PH2}/logs/traced_arm.log"
STATUS="${RAW}/traced_status.txt"
CTL="${PH2}/bin/srv_ctl_p2.sh"
mkdir -p "${RAW}"
log() { echo "$(date '+%F %T') $*" >> "${LOG}"; }
echo "RUNNING $(date '+%F %T')" > "${STATUS}"

ARM="P2-128k-OFF"
if pgrep -x llama-server >/dev/null 2>&1; then
    log "ABORT ${ARM}: unexpected llama-server running"
    echo "ABORT_UNEXPECTED_SERVER ${ARM}" >> "${STATUS}"; exit 1
fi
free_gb=$(df --output=avail -BG /home | tail -1 | tr -dc '0-9')
if (( free_gb < 20 )); then
    log "ABORT ${ARM}: only ${free_gb}G disk free"
    echo "ABORT_DISK ${ARM}" >> "${STATUS}"; exit 1
fi

log "ARM_START ${ARM} mtp=off ctx=131072"
if ! "${CTL}" start --profile "${ARM}" --mtp off --ctx 131072 \
        --trace-name "T_${ARM}" >> "${LOG}" 2>&1; then
    log "ARM_START_FAIL ${ARM}"
    echo "START_FAIL ${ARM}" >> "${STATUS}"; exit 2
fi

python3 "${PH2}/bin/traced_arm_p2.py" --arm "${ARM}" --mtp off \
    --ctx-size 131072 \
    --prompt-file "${RAW}/P2-128k-OFF/prompt.txt" \
    --prompt-tokens 129443 --seed 888111 \
    --npred-probe 1 --npred-main 32 \
    --outdir "${RAW}/T_${ARM}" >> "${LOG}" 2>&1
rc=$?

"${CTL}" stop --profile "${ARM}" >> "${LOG}" 2>&1
local_st="NO_RECORD"; peak="?"
src="${RAW}/T_${ARM}/arm_record.json"
if [[ -f "${src}" ]]; then
    st=$(python3 -c "import json;r=json.load(open('${src}'));print(r.get('status','?'))")
    peak=$(python3 -c "import json;r=json.load(open('${src}'));print(r.get('vram_peak_gib','?'))")
fi
log "ARM_END ${ARM} rc=${rc} status=${st} vram_peak_gib=${peak}"
echo "${ARM} rc=${rc} status=${st} peak=${peak}" >> "${STATUS}"
echo "DONE ok=${rc} $(date '+%F %T')" >> "${STATUS}"
