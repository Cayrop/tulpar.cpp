#!/usr/bin/env bash
# Phase-1 TRACED arms runner. One rocprofv3-wrapped instance PER ARM.
# Per instance: probe request (n_predict=1, fresh PP trace) then main decode
# (n_predict=32, cached prompt). Stop requires SIGKILL escalation per
# ops/docs/traced_server_signal_behavior.md; traces flush intact.
# Production must already be stopped.
set -uo pipefail

ROOT="$(git rev-parse --show-toplevel)"
PH1="${ROOT}/experiments/phase1"
RAW="${PH1}/phase1_raw"
LOG="${PH1}/logs/traced_arms.log"
STATUS="${RAW}/traced_status.txt"
CTL="${PH1}/bin/srv_ctl_p1.sh"
mkdir -p "${RAW}"

log() { echo "$(date '+%F %T') $*" >> "${LOG}"; }
echo "RUNNING $(date '+%F %T')" > "${STATUS}"

ARM_OK=1

run_traced_arm() {
    local arm="$1"; shift
    local mtp="$1"; shift
    local ctx="$1"; shift
    local pfile="$1"; shift
    local ptok="$1"; shift
    local seed="$1"; shift

    if [[ "${ARM_OK}" != "1" ]]; then
        log "SKIP ${arm} (previous failure)"
        echo "SKIPPED ${arm}" >> "${STATUS}"
        return
    fi
    if pgrep -x llama-server >/dev/null 2>&1; then
        log "ABORT ${arm}: unexpected llama-server running"
        echo "ABORT_UNEXPECTED_SERVER ${arm}" >> "${STATUS}"; ARM_OK=0; return
    fi
    local free_gb=$(df --output=avail -BG /home | tail -1 | tr -dc '0-9')
    if (( free_gb < 20 )); then
        log "ABORT ${arm}: only ${free_gb}G disk free"
        echo "ABORT_DISK ${arm}" >> "${STATUS}"; ARM_OK=0; return
    fi

    log "ARM_START ${arm} mtp=${mtp} ctx=${ctx}"
    if ! "${CTL}" start --profile "${arm}" --mtp "${mtp}" --ctx "${ctx}" \
            --trace-name "T_${arm}" >> "${LOG}" 2>&1; then
        log "ARM_START_FAIL ${arm}"
        echo "START_FAIL ${arm}" >> "${STATUS}"; ARM_OK=0; return
    fi

    python3 "${PH1}/bin/traced_arm_p1.py" --arm "${arm}" --mtp "${mtp}" \
        --ctx-size "${ctx}" --prompt-file "${pfile}" \
        --prompt-tokens "${ptok}" --seed "${seed}" \
        --npred-probe 1 --npred-main 32 \
        --outdir "${RAW}/T_${arm}" >> "${LOG}" 2>&1
    local rc=$?

    "${CTL}" stop --profile "${arm}" >> "${LOG}" 2>&1
    local src="${RAW}/T_${arm}/arm_record.json"
    local st="NO_RECORD" peak="?"
    if [[ -f "${src}" ]]; then
        st=$(python3 -c "import json;r=json.load(open('${src}'));print(r.get('status','?'))")
        peak=$(python3 -c "import json;r=json.load(open('${src}'));print(r.get('vram_peak_gib','?'))")
    fi
    log "ARM_END ${arm} rc=${rc} status=${st} vram_peak_gib=${peak}"
    echo "${arm} rc=${rc} status=${st} peak=${peak}" >> "${STATUS}"
}

PF="${RAW}"

# ---- MTP OFF decode arms (probe doubles as the PP arm) ----
run_traced_arm T-1k-OFF   off 2048   "${PF}/U-1k-OFF/prompt.txt"   974    4201024
run_traced_arm T-16k-OFF  off 17408  "${PF}/U-16k-OFF/prompt.txt"  16356  555001
run_traced_arm T-63k-OFF  off 64512  "${PF}/U-63k-OFF/prompt.txt"  63514  777001
run_traced_arm T-128k-OFF off 131072 "${PF}/U-128k-OFF/prompt.txt" 129443 888111
run_traced_arm T-131k-OFF off 135168 "${PF}/U-131k-OFF/prompt.txt" 131000 888112

# ---- MTP ON decode arms (skip 131k ON) ----
run_traced_arm T-1k-ON   on 2048   "${PF}/U-1k-ON/prompt.txt"   974    4201024
run_traced_arm T-16k-ON  on 17408  "${PF}/U-16k-ON/prompt.txt"  16356  555001
run_traced_arm T-63k-ON  on 64512  "${PF}/U-63k-ON/prompt.txt"  63514  777001
run_traced_arm T-128k-ON on 131072 "${PF}/U-128k-ON/prompt.txt" 129443 888111

log "TRACED_ARMS_END ok_flag=${ARM_OK}"
echo "DONE ok=${ARM_OK} $(date '+%F %T')" >> "${STATUS}"
