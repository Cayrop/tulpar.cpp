# E1b result summary

Baseline (cold weights, median of 7x192): 259.3 / 259.9 GB/s (shape0/shape1).
Best variant across 10 mechanisms: V7 ilp2 = 260.5 GB/s on shape0 (+0.5%),
253-257 on shape1 (-1 to -2%). Everything else regresses.

Key regressions and what they imply:
- wg64/wg128 (-17%/-38%): more threads per row hurts; matches the RDNA3_0
  whitelist comment in mmvq.cu (complex vec_dot types kept at nwarps=1).
- fastld/funnel (-9..-10%): replacing byte assembly with aligned dword pairs +
  funnel shift does not help; likely extra register pressure + boundary lines.
- LDS grid table (-5%/0%): L1 already handles the 1 KB table fine.
- software prefetch pipeline (-15%): explicit MLP doubling does not help ->
  latency is NOT the dominant limiter at this occupancy.
- uint4 q8 loads (-11%): fewer load instructions do not help either.

Combined with dp4a throughput math (needed ~0.68 T int-MAC/s vs ~18+ T
available), the limiter is not raw ALU issue or DRAM bandwidth or MLP.
The practical envelope of THIS algorithm shape (98 B super-blocks straddling
128 B lines, 8-way slice decomposition, grid-table decode) on gfx1101 is
~260 GB/s cold. The 350 GB/s decision threshold is not reached by any variant.

Dispatch overhead note: standalone baseline 259 vs in-model 213 GB/s implies
~46 GB/s (~18%) is lost to graph/dispatch overhead, addressable separately by
Phase-5 fusion work without touching the kernel.
