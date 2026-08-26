# E1b: IQ3_XXS standalone vec_dot/kernel sweep

Question: how much of the gap between the production IQ3_XXS GEMV path
(~213-260 GB/s effective) and the machine pure-read ceiling (602.7 GB/s)
is reachable with kernel-level work, before touching llama.cpp source?

Files:
- hypothesis.md            pre-registered hypotheses + measured-fact corrections
- shapes.json              real model tensor shapes + production launch config
- e1b_bench.hip            harness: baseline (verbatim production semantics) + 10 variants
- ref_cpu.cpp              host reference replicating production integer semantics exactly
- baseline.json            cold-weight baseline numbers + methodology
- variants.json            all variants, both rounds, results and verdicts
- correctness.json         tolerance distribution vs reference (18 checks, all pass)
- compiler_kernel_info.json VGPR/shared/occupancy per kernel
- report.md                final report + GO/PARK decision
- raw/                     all runs, debug traces, clock samples
- analysis/                summary tables

Build: hipcc --offload-arch=gfx1101 -O3 -I <repo>/ggml/src e1b_bench.hip ref_cpu.cpp -o e1b_bench
Run:   ./e1b_bench check|bench|info [single_variant_id]

No llama.cpp source was modified. Production binary untouched.
