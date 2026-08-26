#!/usr/bin/env bash
# Correctness gate: MTP OFF full quality suite, then MTP ON smoke.
set -uo pipefail
ROOT="$(git rev-parse --show-toplevel)"
CTL="${ROOT}/experiments/phase1b/bin/srv_ctl.sh"
OUT="${ROOT}/experiments/phase1b/correctness"
mkdir -p "$OUT"

echo "=== [gate] MTP OFF: full quality suite ==="
if ! "$CTL" start --profile gate-off --mtp off --graph on; then
    echo "GATE_OFF_START_FAIL" | tee "$OUT/gate_result.txt"
    exit 2
fi
python3 "${ROOT}/results2/p3_quality_suite.py" phase1b_gate_off "${OUT}/suite_off.json"
RC_OFF=$?
"$CTL" stop --profile gate-off
echo "gate_off_suite_rc=${RC_OFF}" >> "$OUT/gate_result.txt"

echo "=== [gate] MTP ON: smoke ==="
if ! "$CTL" start --profile gate-on --mtp on --graph on; then
    echo "GATE_ON_START_FAIL" | tee -a "$OUT/gate_result.txt"
    exit 3
fi
python3 "${ROOT}/experiments/phase1b/bin/mtp_smoke.py" "${OUT}/smoke_on.json"
RC_ON=$?
"$CTL" stop --profile gate-on
echo "gate_on_smoke_rc=${RC_ON}" >> "$OUT/gate_result.txt"

if [[ $RC_OFF -eq 0 && $RC_ON -eq 0 ]]; then
    echo "GATE_PASS" | tee -a "$OUT/gate_result.txt"
else
    echo "GATE_FAIL" | tee -a "$OUT/gate_result.txt"
fi
