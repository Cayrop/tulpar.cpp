# Phase-1B Restore Overrides & Decisions

Date: 2026-08-24

## RESTORE_BINARY decision: build-p3/bin/llama-server

Per prompt decision matrix:
- correctness gate PASSED (deterministic 12/12 OFF; MTP ON smoke 4/4 with
  readable draft counters)
- 16k baseline arms measured successfully (A2/A5 plus full ladder)
- build-p3 health stable across 10 measurement windows (no crash, no health
  fail, clean stops)

All three conditions met -> RESTORE_BINARY = build-p3/bin/llama-server.

## Flag overrides vs ops/manifest/prod_flags.env

| Item | prod_flags.env | Restore | Note |
|------|----------------|---------|------|
| BINARY_PATH | build/bin/llama-server | build-p3/bin/llama-server | OVERRIDE per restore decision matrix (gate passed) |
| SPEC_DRAFT_N_MAX | 4 | 4 | no override needed (already 4) |
| MTP flags | draft-mtp / 4 / 0.8 | same | verbatim |
| CTX_SIZE | 65536 | 65536 | verbatim |
| KV cache | q4_0/q4_0 | q4_0/q4_0 | verbatim |
| HOST:PORT | 0.0.0.0:8080 | 0.0.0.0:8080 | verbatim |
| sampling/temp/tools/chat-template-kwargs | - | same | verbatim |
| GGML_CUDA_DISABLE_GRAPHS=1 | listed under Environment | NOT SET | see evidence below |

## GGML_CUDA_DISABLE_GRAPHS evidence and decision

prod_flags.env lists GGML_CUDA_DISABLE_GRAPHS=1, but Phase-0.5 report already
flagged its "export location unknown; may be set externally" as an open
question (ops/phase05_report.md sections 3/10/11).

Direct evidence from the ACTUAL pre-window production process:
/tmp/opencode/llama_server_restore.log (last written Aug 24 09:46, the session
the user stopped) contains repeated lines like:

    slot print_timing: ... graphs reused = 3291

"graphs reused" is only logged when CUDA/HIP graphs are ACTIVE. The real
production process therefore ran WITH graphs enabled; the env var documented in
the manifest was never effectively applied.

Decision: restore reproduces the REAL pre-window state -> the variable is NOT
set. ops/bin/prod_start.sh (Phase-0.5 sanctioned tool) agrees with this choice;
only prod_flags.env disagrees, and that disagreement is now resolved with
process-log evidence.

## Pidfile

PID written to ops/run/llama-server.pid after launch, validated via
/proc/PID/exe == build-p3/bin/llama-server and cmdline containing model path
and port.
