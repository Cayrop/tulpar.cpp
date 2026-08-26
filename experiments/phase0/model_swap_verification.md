# Phase-0 Model Swap Verification Record

Date: 2026-08-25 22:28 - 23:20 +03
Repo: <REPO_ROOT> @ tulpar/main 66dcba5eb7dd92cd460cfc040c7cae42f1254e20 (unchanged)
Binary: build-p3/bin/llama-server, sha256 280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13
(matches Phase-1B fingerprint 280556cc..., mtime Aug 24 00:20)

## Verdict

SWAP_VERIFIED_WITH_CAVEATS. The V3 file is in place and loads cleanly under the
production flags on build-p3, but file-replacement forensics show the swap
landed in two steps tonight, which voids one earlier validation artifact
(semantic_check_rerun.json). Correctness gate FAILED (see
correctness_gate_v3.md); per phase rules baselines were NOT run.

## Pre-flight results

- P0-0a: FAIL as stated. Production was NOT running at phase start.
  ops/run/llama-server.pid held PID 51668; /proc/51668 did not exist
  (stale pidfile, no cleanup by whoever stopped it earlier tonight).
  pgrep -x llama-server: empty. Port 8080: no response. No pkill used;
  stale pidfile removed via prod_stop.sh --i-have-explicit-approval.
- P0-0b: PASS. No KFD compute processes (rocm-smi --showpidgpus: none);
  VRAM used 1,326,481,408 B (~1.24 GiB desktop only); momentary GPU use 4-8%.
- P0-0c: PASS. /home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf,
  9,828,981,664 B = 9.83 GB decimal (9.15 GiB), matches expected ~9.83 GB.
- P0-0d: sha256 fd4730dd8aad070517978752b63d530aeb1740d2283cab9fa24f1e404032ddb0
  (experiments/phase0/env/model_sha256.txt).

## File replacement forensics (important)

Timeline reconstructed from mtimes/ctimes + server logs:

| time (+03) | event |
|------------|-------|
| Aug 25 ~21:22-21:47 | Phase-2B rerun arms finish on OLD weights (blockers written 21:47:39) |
| 21:48:47 | model file mtime (preserved by timestamp-keeping copy tool) |
| 21:49:53 | server started (ops/logs/llama-server.20260825_214953.log), loads the path |
| 21:52:51 | semantic_check_rerun.json: 6/6 char-exact vs baseline_ON_prod_v3.json |
| 22:28:09 | model file ctime -> inode data replaced again (mtime-preserving copy) |
| ~22:28+  | that server exited without pidfile cleanup (found dead at phase start) |
| 22:36:54 | this phase started prod via prod_start.sh (PID 59290) - runs CURRENT bytes |

Implication: the 6/6 match recorded at 21:52:51 was produced against the
PRE-22:28 bytes. Those bytes reproduced the V2-era baseline heads exactly
(character-identical over 480-char heads x 6 prompts), which is only possible
if they were behaviorally equivalent to the old V2 quantization. The CURRENT
bytes are a different quantization (see v3_quant_distribution.json) and do not
reproduce those heads (2/6). Therefore:
- current bytes = the real V3 placement (9.83 GB, Unsloth metadata,
  IQ2/IQ3-heavy dynamic scheme),
- experiments/phase2b/restore/semantic_check_rerun.json is VOID as evidence
  for the current file.

Additional finding: baseline_ON_prod_v3.json itself embeds foreign cache
context - its "factual" out_head echoes "What is the capital of Germany?"
although the check prompt asks about France (KV/LCP slot reuse during its
Aug-22 recording session). Character-exact comparison against it can never be
a pure model-behavior criterion.

## Swap execution (pidfile lifecycle throughout)

1. prod_stop.sh --i-have-explicit-approval: validated pidfile PID, removed
   stale pidfile (no live process).
2. prod_start.sh: launched build-p3/bin/llama-server with prod_flags.env
   flags verbatim; health {"status":"ok"} after 10 s; PID 59290 written to
   ops/run/llama-server.pid; /proc/59290/exe == build-p3/bin/llama-server
   (validated); cmdline contains the qwen38 model path (validated).
   VRAM after load (prod ctx 65536, MTP ON flags): 13,866,852,352 B total-used
   (~12.92 GiB incl ~1.24 GiB desktop).
3. Two later stop/start cycles for the correctness gate instances
   (baseline-gate-off-v3 via srv_ctl_p0.sh, ctx 131072 MTP OFF); all stops
   clean SIGINT, no SIGKILL needed; VRAM released to ~1.36 GiB between runs.

## Final state (restore)

- PID 65019 in ops/run/llama-server.pid; /proc/65019/exe ==
  <REPO_ROOT>/build-p3/bin/llama-server; health {"status":"ok"}.
- VRAM total-used after load: 13,947,310,080 B (~12.99 GiB incl desktop).
- Swap used 13,669,343,232 B of 33,564,913,664 B (high pre-existing system
  swap pressure from earlier phases' mmap churn; MemAvailable 20.19 GB).
- Model loaded: current V3 bytes, sha256 fd4730dd...

RESTORE_OK (production serving V3 on build-p3 with health ok)
