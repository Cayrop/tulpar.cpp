# V2 Kernel Attribution - Blockers / Notes (Reset Run)

## B-1: rocprofv2 Output Destination

**Severity:** RESOLVED (was BLOCKER in pre-reset run)
**Symptom (pre-reset):** Pre-reset scripts assumed rocprofv2 wrote dispatch
lines to stdout. In the installed rocprofv2 1.1.0, dispatch lines are written
to a CSV file in the output directory (default name `results_trace_<pid>.csv`).
**Resolution:** `analyze_arm.py` now reads the CSV via `csv.DictReader`.
The runner no longer relies on `server_stdout.log` for dispatch data.

## B-2: rocprofv2 Process Termination

**Severity:** RESOLVED (was HIGH in pre-reset run)
**Symptom:** Server wrapped by rocprofv2 lingers after the first request
completes. With the curl approach used here, the server does not die
spontaneously; the runner must kill it after the request returns. In the
pre-reset run, the server exit was used as a signal to flush the trace; in
the reset, we explicitly kill and wait.
**Resolution:** `run_arm.sh` waits for the curl HTTP code 200 response, then
waits up to 30s for the server PID to exit, then SIGKILLs it if it still
lingers. After kill, 5s sleep for rocprofv2 to flush the CSV.

## B-3: Prompt Causing 1-Token EOS

**Severity:** RESOLVED
**Symptom (first 16k attempt):** The original repetitive prompt
`"The quick brown fox jumps over the lazy dog. " * N` caused the model to
emit EOS on the first generated token at large prompt sizes (16k+). The
response returned `predicted_n: 1, stop_type: eos`, leaving the decode
trace with only ~15 dispatches.
**Resolution:** Replaced the base string with a natural-language passage
ending mid-sentence:

```
Once upon a time, in a small village by the sea, there lived a curious
child who loved to explore the rocky shoreline ... inside the chest there
was
```

This produces 64-token generations at all ctx sizes (1k/16k/63k/128k).
The 1k arm was re-run with the new prompt for consistency.

## B-4: VRAM at 128k ctx

**Severity:** NONE
**Peak VRAM observed (T-V2-128k-OFF):** 14.29 GiB
**Guard limit:** 15.5 GiB
With server flags `-c 131072 -ngl 999 -ctk q4_0 -ctv q4_0`, the 128k ctx
fits within 15.5 GiB. The server does NOT auto-reduce ctx in this build.

## B-5: Phase-3 revert verification

**Status:** Confirmed clean
- Phase-3 commit `1d50f66ff` ("raise RDNA3 MMQ threshold"): dropped.
- Phase-3 commit `11c95eb56` ("shape-gated hybrid dispatch for fused q4_0 FA tile"): dropped.
- HEAD after rebase: `4f72448eb` (EXP-002: V2 model swap + baseline measurement).
- Phase-2 predicate `ggml_cuda_fattn_tile_fuses_quantized_kv` still present at `ggml/src/ggml-cuda/fattn-common.cuh:89`.
- Backend ops sanity (`test-backend-ops -o FLASH_ATTN_EXT -p "q4_0"`): 354/354 passed.
- Staging dequant (`dequantize_block_q4_0`) count in traces: **0** (Phase-2 fused q4_0 path active).

## B-6: hipBLAS_GEMM reappearing in prefill

**Severity:** NOTE (not blocker)
**Observation:** `Cijk_Alik_Bljk_HB_MT32x32x32_MI16x16x16x1_SN_1LDSB...` (hipBLAS
GEMM) shows up in prefill at 0.3-0.9% across arms. With Phase-3 reverted,
the MMQ threshold is at the Phase-2 value, so some shapes (likely the
output projection or small linear projections) still fall through to
hipBLAS instead of MMQ. The reverted Phase-3 commit
(`raise RDNA3 MMQ threshold to eliminate hipBLAS fallback in PP`) was
intended to suppress this; that work is NOT included in this baseline.
This is **not a regression** in this run (the run is on Phase-2 only);
it is a baseline measurement showing what Phase-2 looks like.

## B-7: GDN_FWHT / FA_tile token estimate

**Severity:** NOTE
The decode kernel count is NOT exactly divisible by 17 (attn layers) or
48 (GDN layers) for token estimation. Empirical counts: 989 FA_tile per
64 tokens (= 58.2 expected, off by 7%), 3916 GDN_FWHT per 64 tokens (=
81.6 expected, off by 28%). The actual n_predict from server response
(64) is the only reliable token count. The "tokens_estimated" field in
analysis.json is reported but is an upper bound, not exact.

## B-8: Server alive after request

**Severity:** NOTE
After the curl request returns, the server PID often stays alive past the
30s grace window. The runner SIGKILLs it. This is benign for trace
integrity (CSV is flushed before the kill) but means the wall-time of
each arm includes ~30-35s of waiting for the server to die.
