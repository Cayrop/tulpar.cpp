# Production Flag Manifest
# Extracted from /tmp/opencode/launch_prod.sh and /tmp/opencode/restore_server.sh
# Extracted by Phase-0.5 Operational Safety Hardening

## Binary

- Binary path: `build/bin/llama-server` (relative to repo root `<REPO_ROOT>`)
- Absolute path: `<REPO_ROOT>/build/bin/llama-server`
- mtime: Aug 20 12:58 (older upstream content, pre-tulpar/main tile patch)
- Source commit: UNKNOWN

## Model

- Model path: `/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf`
- Model name alias: `Qwen3.8-27b`

## Host / Port

- Host: `0.0.0.0` (all interfaces)
- Port: `8080`

## Context

- Context size: `-c 65536`

## GPU Layers

- `-ngl 999` (offload all layers to GPU)

## Memory / Cache

- `--load-mode mmap`
- Flash attention: `-fa on`
- Cache type K: `-ctk q4_0`
- Cache type V: `-ctv q4_0`
- `--cache-prompt` (enable prompt caching)
- `--ctx-checkpoints 4`

## Sampling

- `--temp 0.6`
- `--top-p 0.95`
- `--top-k 20`
- `--min-p 0.0`

## MTP / Speculative Decoding

- `--spec-type draft-mtp`
- `--spec-draft-n-max 4`
- `--spec-draft-p-min 0.8`

## Threads

- `-t 8` (threads)
- `-np 1` (number of processes? or numa policy — UNKNOWN exact meaning in this context)

## Server Features

- `--metrics` (enable Prometheus metrics endpoint)
- `--tools all` (enable all tool calling features)
- `--chat-template-kwargs '{"preserve_thinking": true}'`

## Environment Variables

- `GGML_CUDA_DISABLE_GRAPHS=1` (set in launch_prod.sh wrapper context; HIP graph runtime disable)
  NOTE: The launch_prod.sh wrapper does not explicitly export this; it may be set in the environment or by the process supervisor. Flag is KNOWN from Phase-1A audit.

## Log Redirection

- launch_prod.sh redirects stdout/stderr to `/tmp/opencode/llama_server_restore.log`
- Uses `setsid nohup` for process detachment

## Health Check

- Endpoint: `http://localhost:8080/health`
- Expected response: `{"status":"ok"}`
- Timeout: 3 seconds (per safe_commands.sh convention)

## Unknown / Unclear Flags

- `-np 1`: exact meaning in llama-server context is UNKNOWN (possibly numa policy or number of prefill threads)
- `GGML_CUDA_DISABLE_GRAPHS=1` export location: not explicitly in launch_prod.sh; may be set externally or in process supervisor environment