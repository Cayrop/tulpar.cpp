# Phase-1B Baseline Runbook (design output of Phase-1A; NOT yet approved to run)

Precondition: operator has explicitly approved a measurement window.
Until then: DO NOT EXECUTE sections 3+.

Conventions:
- {{BIN}}      = <REPO_ROOT>/build-p3/bin/llama-server  (tulpar/main content)
- {{MODEL}}    = /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf
- {{ROOT}}     = <REPO_ROOT>
- {{OUT}}      = {{ROOT}}/experiments/phase1b
- All server starts MUST use setsid + log file, exactly like prior harnesses.
- Never kill by PPID guess. Kill only the PID recorded at start (pidfile we
  write ourselves per window) - see section 0 rule.

## 1. Pre-checks (all read-only)

```bash
# repo state
git -C {{ROOT}} rev-parse HEAD          # must be 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
git -C {{ROOT}} status --porcelain      # no tracked-file modifications expected

# binary identity
ls --time-style=long-iso -la {{BIN}}
sha256sum {{ROOT}}/build-p3/bin/libllama-server-impl.so   # record in manifest

# model present
ls -la {{MODEL}}

# GPU idle check: FAIL -> ABORT window
rocm-smi --showmeminfo vram             # used must be < 500 MB after prod stop (step 2)
pgrep -ax llama-server                  # must be empty before our first start

# port free
ss -ltn | grep 8080                     # must be empty before our first start
```

Environment manifest (reuse generator):
run results2/tulpar/p1_campaign.py-style manifest into {{OUT}}/env/
(uname/cpu/mem/rocm/gpu/smi/power_profile/git_rev/model sha256/binary sha256/
exported env vars). Copy results2/tulpar/env/* as prior reference alongside.

## 2. Approved production stop (ONLY with explicit human approval logged in commands/)

Current documented reality: NO pidfile exists. The historical procedure is:

```bash
mkdir -p {{OUT}}/{commands,logs,raw,summary,env}
date > {{OUT}}/commands/window_start.txt
# record who approved:
echo "approved-by: <OPERATOR> ; window: <start-end>" >> {{OUT}}/commands/window_start.txt

# stop production: exact-name match only, SIGINT first, wait, then escalate
for pid in $(pgrep -x llama-server); do
  echo "$pid" >> {{OUT}}/commands/stopped_prod_pids.txt
  kill -INT "$pid"
done
sleep 60
pgrep -x llama-server && { echo "still alive - STOP and ask human"; exit 1; }
```

RULES for this step:
- If pgrep matches MORE than the known production PID pattern or anything is
  ambiguous -> STOP, report, do nothing else.
- SIGKILL escalation allowed ONLY after >=120 s and recorded in stopped_prod_pids.txt.
- After restore (section 5) verify health BEFORE declaring window closed.

## 3. Baseline matrix (primary protocol)

Server arg blocks (identical to orchestrate.py):

```bash
COMMON=(-m {{MODEL}} --alias Qwen3.8-27b -c 131072 -ngl 999 --load-mode mmap \
  -fa on -ctk q4_0 -ctv q4_0 --temp 0.6 --top-p 0.95 --top-k 20 --min-p 0.0 \
  --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 --host 127.0.0.1 --port 8080 --metrics)
SPEC_ON=(--spec-type draft-mtp --spec-draft-n-max 4 --spec-draft-p-min 0.8)
```

NOTE: p1 campaign used -c 131072 (needed for 128k arm); phase-2/3 windows used
-c 65536. For comparability with perf_tulpar_base_* use -c 131072 and run the
full ctx ladder in ONE server process per mode, ascending order.

Start helper (writes pidfile THIS time):

```bash
start_srv () { # $1 tag, $2 "on"|"off", extra env via prefix
  local log={{OUT}}/logs/srv_$1.log
  env "$@" bash -c 'exec "${@:0}"' _ "{{BIN}}" "${COMMON[@]}" \
    $([ "$2" = on ] && echo "${SPEC_ON[@]}") > "$log" 2>&1 &
  echo $! > {{OUT}}/commands/srv_$1.pid
  # wait health up to 900 s (curl loop), fail -> dump tail of $log and ABORT
}
stop_srv () { # $1 tag : kill ONLY pidfile pid
  local pid=$(cat {{OUT}}/commands/srv_$1.pid)
  kill -INT "$pid"; for i in $(seq 60); do kill -0 "$pid" 2>/dev/null || break; sleep 2; done
  kill -0 "$pid" 2>/dev/null && kill -9 "$pid"
}
```

Per-window bench requests (payload template, from p1_campaign.bench_once):

```json
{"prompt": "<make_text prompt>", "n_predict": 128, "cache_prompt": <bool>,
 "ignore_eos": true, "seed": <fixed>,
 "temperature": 0.6, "top_k": 20, "top_p": 0.95, "min_p": 0.0}
```

Prompts: reuse make_text(960|16320|64512|129400, seed=555001 / 777001) +
"\n\nQ: Summarize the topic of the text above in one sentence.\nA:".
Record tokenized counts from response timings.prompt_n.

Matrix execution order (VRAM-safe ladder; OOM anywhere -> skip larger ctx, continue smaller? NO: abort escalation, keep collected data, mark BLOCKED cells):

Window A (MTP OFF): reps: 1k x4 (rep1 fresh, rep2+ cached), 16k x3, 63k x3 (npred 380), 128k (1 fresh greedy npred 96 + needle check + 2 cached).
Window B (MTP ON): same shape; capture draft_n/draft_n_accepted per request AND metrics deltas:
  curl -s localhost:8080/metrics | grep -E 'spec_decode'   # before+after each rep
Window C (GRAPHS OFF, MTP OFF): GGML_CUDA_DISABLE_GRAPHS=1 prefix;
  arms: 16k TG x5, 63k TG x5 (npred 128 cached-decode protocol), 16k/63k PP x3 (fresh prefill, npred 1... keep npred small but nonzero);
  verify graphs actually off: first launch with `-v`, confirm stderr contains
  NO "warmup complete"/"id reused" lines during decode; save that log segment.

llama-bench cross-check: DEFERRED (no matching binary; see report section 7).

## 4. Correctness gates (same window, AFTER perf to keep timing clean)

```bash
python3 {{ROOT}}/results2/correctness_suite.py base_off_gate_{{DATE}}        # while OFF-mode server logic... 
```
NOTE: suites hit :8080 whatever server is live; run full_gate once per mode
(OFF server up, then ON server up) plus p3_quality_suite.py once per mode:

```bash
python3 {{ROOT}}/results2/p3_quality_suite.py q_off_{{DATE}} {{OUT}}/raw/suite_off.json
python3 {{ROOT}}/results2/p3_quality_suite.py q_on_{{DATE}}  {{OUT}}/raw/suite_on.json
```

Pass requirement: deterministic 12/12 per mode; needle PASS; degen_trap unchanged
("and where..." loop = documented baseline behavior); any new failure -> mark
whole window SUSPECT, re-run gate once before escalating to human.

## 5. Restore production (mandatory)

```bash
setsid bash /tmp/opencode/launch_prod.sh &
sleep 90
curl -s -m 3 http://localhost:8080/health            # expect {"status":"ok"}
readlink /proc/$(pgrep -x llama-server | head -1)/exe # expect .../build/bin/llama-server
# semantic spot-check vs stored baseline:
python3 - <<'EOF'
import sys, json; sys.path.insert(0,'{{ROOT}}/results'); sys.path.insert(0,'{{ROOT}}/results2')
from correctness_suite import gen, SMOKE
base=json.load(open('{{ROOT}}/results2/correctness/baseline_ON_prod_v3.json'))
ok=True
for name,prompt,_ in SMOKE:
    r=gen(prompt,64); ref=[s['out_head'] for s in base['semantic_1k'] if s['test']==name][0]
    same=r['text'][:80].replace("\n"," ")==ref; ok&=same; print(name,same)
print("RESTORE_OK" if ok else "RESTORE_FAIL")
EOF
```

## 6. Expected artifacts

```text
{{OUT}}/env/*                       environment manifest (+prior env copies)
{{OUT}}/commands/*.txt *.pid        approval note, pidfiles, stop list
{{OUT}}/logs/srv_*.log              full stdout/stderr per window
{{OUT}}/raw/perf_<tag>.json         every rep record (prompt_n, tok_s, ms/tok,
                                    draft_n, draft_acc, seed, cache flag)
{{OUT}}/raw/metrics_delta_*.txt     spec_decode counters before/after each rep
{{OUT}}/raw/vram_<tag>.csv          50 ms VRAM/busy monitor samples
{{OUT}}/raw/suite_*.json            correctness outputs
{{OUT}}/summary/medians.md          medians + min/max spread per cell vs anchors
```

## 7. Failure rules

- OOM or vram_peak > 15.5 GB -> stop escalating contexts; cell BLOCKED.
- GPU busy by unknown process -> STOP whole window; report; never touch foreign processes.
- Server fails health within 900 s -> dump log tail, stop_srv via pidfile, ABORT.
- Unknown binary path requested -> STOP (binary identity gate failed).
- Correctness suite missing/broken -> perf data still valid; correctness PHASE blocked.
- Health fail after restore -> highest priority incident; re-run restore once;
  if still failing, report immediately; do NOT improvise flags.

## 8. Post-run validation

- median per cell over fresh-vs-cached groups SEPARATELY (never mix).
- raw spread reported as min/max; flag cells with spread > 5% for rerun.
- outlier check: any rep deviating > 10% from its group median -> rerun that cell.
- context coverage: all four ctx targets present or explicitly BLOCKED.
- MTP sanity: acceptance band vs history (~0.74 @1k, ~0.92 @16k, ~0.88 @63k,
  ~0.98 @128k); effective ON tok/s = predicted_per_second (wall-clock based).
- graph-OFF delta direction: decode wall should INCREASE vs Window A at same ctx
  (historical expectation: host-gap share 10-15% is graph-related); record actual.
- traced runs: none in Phase-1B baseline; if added later they are separate artifacts.

## 9. Rollback / safety

Measurement-only phase: nothing to roll back in repo/source/builds.
Accidental extra server: do NOT kill unless OUR pidfile contains it; report for
human decision. Production restore procedure above is the only sanctioned
mutation, and it restores pre-window state.
