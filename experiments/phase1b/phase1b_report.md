# Phase-1B Baseline Measurement Report

Date: 2026-08-24 14:17 - 15:35 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20
Approvals: measurement window YES, 128k YES, GPU idle confirmed by user, production stopped by user.

## Final verdict

SUCCESS

Correctness gate passed, all 10 planned arms measured (8 primary + 2 optional
graph-off diagnostics), 128k single-pass completed for both MTP states with no
OOM and negligible swap, production restored on build-p3 with health OK and
6/6 semantic match against the pre-window baseline. No tracked file modified,
no commits made.

## 1. Pre-check results

- git: HEAD matches required commit; branch tulpar/main; tracked files clean;
  untracked ops/, experiments/, results/, results2/, agents.md* only.
- GPU idle at start: zero KFD processes, SCLK 93 MHz, 52 W. FLAG: ~665 MB VRAM
  used by desktop graphics session (> the doc's 500 MB target); compute idle;
  non-blocking, user had confirmed idle.
- Binaries present+executable: build-p3/bin/llama-server (baseline,
  sha256 280556cc..., mtime Aug 24 00:20), build/bin/llama-server (fallback,
  sha256 d5b26a65...). libllama-server-impl.so sha256 6293e1b5...
- Model present: Qwen3.8-27B-UD-Q2_K_XL.gguf, 10,676,423,744 bytes.
- Flags: ops/manifest/prod_flags.env, ops/measurement/measurement_window.md,
  ops/pidfile_policy.md all present. prod port 8080 free at window start.
- Disk: /home had 15 GB free (artifacts written are text/JSON only).
- RAM/swap at start: MemAvailable 27 GiB; swap already 2.4-2.6 GiB used BEFORE
  window (pre-existing, recorded as reference).
- Ops files check: PASS. Full detail: precheck.md.

## 2. Environment manifest

- GPU: AMD Radeon RX 7800 XT, gfx1101, 60 CU, 16 GiB VRAM (17,163,091,968 B)
- CPU: AMD Ryzen 7 5700X 8-Core (16 threads), ROCm/HIP: 7.2.53211
- Toolchain: clang 22.1.8 (amd-flang/newAMDclang 22.0.0git in hipcc), cmake 4.4.2, python 3.14.7
- Kernel: Linux cachyos-x8664 7.1.8-1-cachyos
- Relevant env: ROCM_PATH=/opt/rocm; no GGML_* vars set in shell
- Model sha256: computing was started; large file; see env/model_sha256.txt
- Binary fingerprints: see env/binaries.txt (sha256 + sizes + mtimes recorded)
- prod_flags.env content copied verbatim into env/prod_flags.env copy below.

## 3. Correctness gate

MTP OFF full suite (results2/p3_quality_suite.py):
- deterministic tests 12/12 PASS including needle16k_single, needle_multi,
  list_struct, degen_trap_p1k (documented loop unchanged)
- sampled sanity 8/9 (single fail: turkish seed=7 sampling repetition; the
  DETERMINISTIC turkish test passes; runbook criteria met)

MTP ON smoke:
- TR/EN/math/json tests 4/4 PASS after fixing a harness parser bug (model JSON
  output was valid from the start; first FAIL was our regex slicing multiple
  JSON objects - documented in correctness.md, raw dump kept)
- draft counters readable per request (draft_n/draft_n_accepted) AND via
  /metrics spec_decode_* counters (drafts, draft_tokens, accepted_tokens,
  accepted_per_pos)
- acceptance rates during smoke: 0.63-0.89 per short prompt

Verdict: GATE_PASS. Artifacts: correctness/.

## 4. Performance matrix

Server per arm: build-p3/bin/llama-server -c 131072 -ngl 999 --load-mode mmap
-fa on -ctk q4_0 -ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1
--metrics; MTP ON adds --spec-type draft-mtp --spec-draft-n-max 4
--spec-draft-p-min 0.8. Fresh process per arm; pidfile lifecycle throughout.
Sampling greedy (temp 0, top_k 1, seed 1234, ignore_eos); fixed prompts
(make_text seeds 4201024 / 555001 / 777001 / 888111 + summarize suffix).

| arm | context | mtp | graph | cache | prompt_n | pred_n | tg_tok/s med | spread% | pp_tok/s fresh | acc_rate | vram peak GiB | wall s | reps | status |
|-----|---------|-----|-------|-------|----------|--------|--------------|---------|----------------|----------|---------------|--------|------|--------|
| A1 tg-off-1k | 1024 | off | on | q4_0 | 974 | 128 | 22.055 | 0.16 | 507.3 | - | 13.41 | 25.5 | 4 | OK |
| A2 tg-off-16k | 16384 | off | on | q4_0 | 16356 | 128 | 20.451 | 0.09 | 484.8 | - | 13.39 | 52.8 | 3 | OK |
| A3 tg-off-63k | 64512 | off | on | q4_0 | 63514 | 380 | 15.740 | 0.69 | 332.9 | - | 13.71 | 264.4 | 3 | OK |
| A4 tg-on-1k | 1024 | on | on | q4_0 | 974 | 128 | 25.788 | 0.84 | 453.2 | 0.7895 | 15.24 | 22.6 | 4 | OK |
| A5 tg-on-16k | 16384 | on | on | q4_0 | 16356 | 128 | 30.626 | 0.73 | 466.9 | 0.8500 | 15.24 | 48.1 | 3 | OK |
| A6 tg-on-63k | 64512 | on | on | q4_0 | 63514 | 380 | 31.276 | 0.54 | 319.8 | 0.9710 | 15.24 | 236.1 | 3 | OK |
| D1 diag-off-16k-gOFF | 16384 | off | OFF | q4_0 | 16356 | 128 | 19.925 | 0.22 | 485.3 | - | 13.67 | 53.3 | 3 | OK |
| D2 diag-on-16k-gOFF | 16384 | on | OFF | q4_0 | 16356 | 128 | 31.628 | 0.51 | 470.8 | 0.8500 | 15.15 | 47.4 | 3 | OK |
| A7 tg-off-128k | 131072 | off | on | q4_0 | 129443 | 96 | 11.981 | single | 230.7 | - | 13.92 | 569.3 | 1 | OK |
| A8 tg-on-128k | 131072 | on | on | q4_0 | 129443 | 96 | 20.977 | single | 220.0 | 0.9516 | 15.50 | 593.1 | 1 | OK |

tg = predicted_n/predicted_ms; pp from rep1 (fresh prefill; cached reps show
only suffix re-prefill). Effective wall-based tok/s (cached reps): 21.6 @1k,
20.0 @16k, 15.4-15.6 @63k OFF; 24.9 @1k, 28.8-28.9 @16k, 30.1-30.2 @63k ON.

MTP speedup (median tg, graph ON): +17% @1k, +50% @16k, +99% @63k, +75% @128k.
Repeats spread is tiny everywhere (<1%), so medians are stable.

## 5. 128k special section

- A7 (OFF): single-pass OK. Prefill 129,443 tok in 561 s (230.7 tok/s);
  decode 96 tok at 11.98 tok/s; output coherent (think block + summary of the
  random-word filler). vram peak 13.92 GiB. swap delta +45 MiB. MemAvailable
  stayed >= 22 GiB throughout. Health OK; clean stop; VRAM released.
- A8 (ON): run only because A7 succeeded (per prompt rule) and memory guard
  passed. Single-pass OK. decode 96 tok at 20.98 tok/s, acceptance 0.9516.
  vram peak 15.50 GiB (= guard boundary, total GPU 16 GiB, ~600 MiB headroom).
  swap delta +102 MiB.
- Historical "~4.7 GB swap" did NOT reproduce: with q4_0 KV the whole 128k KV
  fits in VRAM; swap stayed flat.
- Repeat decision: NOT repeated. Rationale: A8 peaked exactly at the 15.5 GiB
  runbook guard; measurement_window.md default is one 128k pass per window;
  marginal info from a second pass does not justify pushing against the VRAM
  ceiling. (Prompt allows but does not require extra repeats.)
- Note: both 128k arms ran in this window; older measurement_window.md said
  "only one 128k arm per window"; the Phase-1B prompt supersedes it (A8 gated
  explicitly on A7 success) and both completed safely.

## 6. MTP analysis

- Acceptance (greedy): 0.79 @1k, 0.85 @16k, 0.97 @63k, 0.95 @128k.
  Historical bands (temp 0.6 windows) were ~0.74/~0.92/~0.88/~0.98; same order
  of magnitude, different sampling regime explains shifts.
- Effective throughput rises with context because acceptance rises: MTP ON is
  nearly 2x OFF at 63k while only +17% at 1k (short answers give drafts less
  room; also relative overhead higher at small ctx).
- PP cost of MTP ON: fresh prefill 453 vs 507 tok/s @1k (-11%), 467 vs 485
  @16k (-4%), 320 vs 333 @63k (-4%): draft-model prefill overhead is modest.
- Graph behavior: MTP ON arms reused CUDA graphs normally (srv logs show
  "graphs reused"); no graph-related anomalies observed in ON mode.
- Anomalies: none affecting measurements. One operational incident early on:
  the first ladder launch died with a harness session kill mid-A3 (leftover
  server cleaned via its own pidfile; A1/A2 rerun cleanly in the resumed
  ladder). All reported numbers come from the clean resumed ladder.

## 7. Graph diagnostic (optional section)

| pair | graph ON | graph OFF | delta |
|------|----------|-----------|-------|
| 16k OFF (A2 vs D1) | 20.451 | 19.925 | -2.6% tg when graphs disabled |
| 16k ON (A5 vs D2) | 30.626 | 31.628 | +3.3% tg when graphs disabled |

Direction differs by mode and both effects are small (repeats spread <1%, so
the deltas are likely real but minor at 16k). Historical expectation was that
disabling graphs increases decode wall (10-15% host-gap share hypothesis);
that is NOT confirmed at 16k here. Do not over-conclude from a single ctx
point; if graph behavior matters for tuning, a dedicated multi-ctx diagnostic
phase should revisit it.

## 8. Restore result

RESTORE_OK.
- Decision matrix conditions all met -> RESTORE_BINARY = build-p3/bin/llama-server
- Flags: prod_flags.env verbatim EXCEPT binary path (build-p3) and
  GGML_CUDA_DISABLE_GRAPHS intentionally not set: the actual pre-window
  production process logged "graphs reused = 3291", proving graphs were active
  despite the manifest listing the env var (Phase-0.5 open question now
  resolved with process-log evidence). Details: restore/restore_overrides.md
- spec-draft-n-max: manifest already 4; no override needed.
- PID 397813 written to ops/run/llama-server.pid; /proc identity validated;
  health {"status":"ok"}; health+metrics snapshots saved.
- Semantic spot-check vs results2/correctness/baseline_ON_prod_v3.json:
  6/6 token-prefix MATCH ("RESTORE_OK").

## 9. Evidence quality

Measured (direct artifacts): all tg/pp numbers above (per-rep response JSON),
acceptance counters (timings + /metrics deltas), VRAM peaks (0.5 s rocm-smi
sampling), swap/RAM before-after (free -b), wall times, health statuses,
binary/model sha256, restore identity + semantic match.

Estimated/derived: speedup percentages and spreads computed from measured
values; e2e wall-based tok/s derived from wall clock around HTTP calls.

Missing/not collected:
- llama-bench cross-check: deferred since Phase-1A (no matching binary; would
  need a new build - prohibited in this phase)
- 128k repeats: single-pass only (decision above)
- no per-token latency traces, no power/thermals logging beyond spot checks
- user-observed 40-60 tok/s code-gen numbers: NOT reproduced or verified here
  (no controlled code-gen workload in Phase-1B) -> backlog H-MTP-NMAX

## 10. Open issues

1. prod_flags.env still lists GGML_CUDA_DISABLE_GRAPHS=1 although production
   demonstrably runs graphs-enabled; manifest should be corrected by a human.
2. VRAM headroom at 128k MTP ON is ~600 MiB; any future n-max increase or
   larger draft buffers will not fit 128k on this GPU (see backlog note).
3. First ladder attempt lost to a session-kill (operational, harness-side);
   resolved; consider adding setsid detachment guidance to ops docs.
4. Sampled-sanity turkish seed=7 repetition under temp 0.7 persists from prior
   phases (known quirk, deterministic path unaffected).

## 11. Backlog observations

See backlog.md: H-MTP-NMAX (draft-n-max 8/16 with q4_0 spec KV may raise
effective throughput, motivated by user's 40-60 tok/s code-generation
observation; explicitly out of scope for Phase-1B which optimizes nothing).

## 12. Artifact paths

- precheck: experiments/phase1b/precheck.md
- env: experiments/phase1b/env/ (system.txt, toolchain.txt, binaries.txt, model_sha256.txt, prod_flags copy)
- correctness: experiments/phase1b/correctness/ (suite_off.json, smoke_on.json, json_diag_raw.txt, correctness.md, gate_result.txt, console logs)
- raw: experiments/phase1b/raw/<arm>/ (resp_r*.json, arm_record.json, vram_samples.json, start/stop logs, console logs) + ladder_status.txt
- summary: experiments/phase1b/summary/performance_summary.md, table.json
- restore: experiments/phase1b/restore/ (restore_prod.sh, restore_overrides.md, restore_result.md, final_health.json, final_metrics.txt)
- scripts: experiments/phase1b/bin/ (srv_ctl.sh, arm_run.py, run_gate.sh, mtp_smoke.py, run_ladder.sh, run_diag_128k.sh, compute_metrics.py)
- server logs: experiments/phase1b/logs/srv_*.log ; production restore log: ops/logs/llama-server.20260824_153021.log
- pidfiles used: ops/run/baseline-<ARM>.pid (all removed after stops); production: ops/run/llama-server.pid (ACTIVE, PID 397813)

Post-conditions verified: no tracked source changes (`git status --porcelain`
clean apart from pre-existing untracked dirs), no commits made, production
server healthy at report time.
