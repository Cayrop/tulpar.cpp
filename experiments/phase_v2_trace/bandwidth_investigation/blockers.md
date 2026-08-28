# Blockers

- Layer mapping unavailable: CSV `Kernel_Name` does not include layer index. Exact layer for systematic stalls (token 0, 2) is UNCERTAIN. Needs kernel-level parsing or server-side layer logging.
- HIP-level memory trace unavailable: No `rocm-smi` or HIP profiler output in `trace_artifacts/`. Cannot confirm whether 15-17 ms stalls are `cuMemCreate`/`cuMemMap` (VMM pool) or `cudaMalloc` (legacy pool) or another memory event.
- User claim discrepancy: User states stalls account for ~70% of total gap time. Data shows gaps >1 ms account for only 3-4% of total gap time. The ~70% figure aligns with gaps >0.09 ms. Additional clarification needed: is the stall threshold >1 ms (as instructed) or >0.09 ms?
- No code modifications allowed: Cannot instrument pool or graph code to confirm root cause.
- No commit/push allowed: Only analysis files produced.
- Stochastic stall at 63k token 38 (9.98 ms): Unexplained. Could be a second pool growth event, a VRAM page fault, or a scheduling outlier. Needs additional measurement (HIP memory tracing or repeated runs with same payload) to classify.
