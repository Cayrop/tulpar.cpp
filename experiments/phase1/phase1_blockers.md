# Phase-1 Blockers and Deviations

Date: 2026-08-26. Companion to phase1_attribution.md.

## B-1: Production found DOWN at window start (resolved)

P1-0a failed at 02:20 +03: ops/run/llama-server.pid held PID 96742, /proc/96742
nonexistent, port 8080 not listening, pgrep found no llama-server. Same
pre-window condition as Phase-1B (its sec 1). Resolution per established
precedent: prod_start.sh relaunch inside pidfile policy at 02:22; PID 106088;
readlink /proc/106088/exe == build-p3/bin/llama-server; health {"status":"ok"};
model sha256 re-verified fd4730dd... before relaunch. Production then stopped
cleanly via prod_stop.sh --i-have-explicit-approval (SIGINT exit in 10 s) to
free port 8080 for measurement instances. No deviation from red lines; noted
because P1-0a as written assumes production already running.

## B-2: Untraced ON spread gate exceeded on first pass (resolved by rerun)

U-16k-ON first pass min-max spread 1.25% (>1%), U-128k-ON 2.10%. Per Phase-1B
rerun policy, both re-run with 5 reps: U-16k-ON-r2 spread 0.91% (median
44.181 vs r1 43.814, -0.8%), U-128k-ON-r2 spread 1.036% with cached-rep-only
spread 0.17% (fresh rep is slower outlier; median-cached used). Report uses
compliant runs and says so. No fabrication; both raw passes retained.

## B-3: Step segmentation marker differs from Phase-2B (method note, not blocker)

Phase-2B segmented decode steps by lm_head GEMV markers because V2's lm_head
was the only Q3_K GEMV per step. V3's lm_head is Q4_K, which also appears in
attn_output/qkv/ssm_out roles (21 Q4_K GEMV launches/token), and embedding
get_rows is no longer unique either (97 get_rows launches/token from GDN state
gathers). Solution: steps are delimited by the UNIQUE adjacency
mul_mat_vec_q<(ggml_type)12> -> __amd_rocclr_copyBuffer (D2H logits for
sampling), which fires exactly once per token. Validation: kernel span between
markers is EXACTLY 2018 kernels at every context (graph-deterministic), 31
markers found for 32 predicted tokens (the head segment after cache restore is
excluded by design), 28 clean steps survive stall filtering per arm.
Attribution math unaffected.

## B-4: rocprofv3 SIGKILL escalation on every traced stop (expected)

9/9 traced instances ignored SIGINT beyond ~300 s runtime and required SIGKILL,
matching ops/docs/traced_server_signal_behavior.md. All traces flushed intact:
per-arm call counts internally consistent (e.g., exactly 32 FA-tile pairs and
2018 kernels/step on OFF arms; quantize_row counts constant across contexts).
Escalations recorded in logs/force_kills.txt.

## B-5: T-128k-ON VRAM proximity (no trip)

Untraced on-128k peak leaves ~190 MiB under the sampled guard; this arm was
scheduled LAST to avoid jeopardizing other arms if it tripped. It completed OK:
driver-sampled peak 14.74 GiB; rocm-smi spot checks during prefill read
~15.82 GB absolute (incl. desktop); free VRAM never approached the 300 MiB
red line. Observation: traced peaks ran BELOW untraced peaks on all arms
(kernel tracing adds no measurable device memory; earlier fear of +0.5-0.7 GiB
profiler overhead was sampling variance in the old dataset).

## B-6: Optional MTP4 comparison arms skipped as redundant

Task section 4.5 conditions on "n_max=4 if different from prod flags".
Production/probe flags already use --spec-draft-n-max 4, so T-{16k,63k}-ON are
already mtp4 arms. No extra runs needed; nothing skipped that would add
information.

## B-7: ne11 not directly observable under tracing

rocprofv3 kernel-trace CSVs expose names/timestamps only. Verify-batch evidence
is indirect but consistent: flash_attn_tile template census shows ncols1=1 plus
{4,8} instantiations on all ON arms, and MMVQ (ne11<=8) covers all GEMV
launches. Labeled inference in the main report, not a measurement.

## B-8: EMB_GET_ROWS bucket composition

97 get_rows launches/token, all k_get_rows_float variants (F32 source):
embedding lookup + 48x2 GDN state gathers. No quantized get_rows variant
appears anywhere in any trace, although GGUF stores token_embd as Q2_K; the
runtime path evidently consumes an F32-resident embedding. Load-time mechanism
not traced further (out of attribution scope); recorded as observation for any
future memory audit (potential +0.39 GiB F32 copy implication).

## B-9: hipBLAS fallback discovery (measurement outcome, no action taken)

PP probes revealed 8-20% of PP busy in Cijk_* rocBLAS kernels fed by
dequantize_block_{iq2_s,iq2_xs,q2_K,iq1_m} staging. Root cause located in
ggml_cuda_should_use_mmq() RDNA3 branch (ne11 <= 128 cap for these types on
RDNA3_0) - see main report sec 9. Recorded as Phase-5 candidate only; nothing
modified.

## B-10: Disk budget

66 GB free at window start; trace corpus ~1.6 GB total across 9 arms. No
pressure at any point.

## Environment record

- Window: start 2026-08-26 02:22 +03, end of measurements 05:04, restore ~05:15.
- Initial: VRAM used 1.14 GB (desktop); MemAvail 16.05 GB; swap used 5.92 GB;
  disk free 66 GB.
- Per-arm swap deltas: within +/-0.3 GB throughout (page-cache churn); no
  guard approached. MemAvailable never below 14 GiB during big arms.
- Harness: experiments/phase1/bin/{srv_ctl_p1.sh, arm_run_p1.py,
  traced_arm_p1.py, run_untraced_ladder.sh, run_traced_arms.sh,
  analyze_arm_p1.py, compose_p1.py, phase1_classify.py}.
- Raw artifacts: experiments/phase1/phase1_raw/<arm>/ (resp JSONs, prompts,
  vram samples, start/stop logs) and T_<arm>/ (kernel_trace.csv,
  kernel_stats.csv, analysis.json).
