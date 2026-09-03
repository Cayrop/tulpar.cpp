# Theoretical Ceiling — IQ3_XXS GEMV on gfx1101

## 3.1 Bandwidth-Bound Ceiling

Formula: `time = bytes / bandwidth`
Bytes per token (IQ3_XXS weights): 8,092,385,280 B (from `bytes_per_step.json`)

| Scenario | Bandwidth | Time (ms) | vs Actual (23.08 ms) |
|----------|----------:|----------:|----------------------:|
| Measured VRAM ceiling (1 GB sequential) | 525 GB/s | **15.41** | 66.8 % of actual |
| Measured IC (32 MB working set) | 719 GB/s | **11.25** | 48.7 % of actual |
| Random gather with 4 KB hot data | 787 GB/s | 10.28 | 44.5 % of actual |
| Tiny table (1 KB, all in L1) | 5,500 GB/s | 1.47 | 6.4 % of actual |
| Nominal VRAM spec | 624 GB/s | 12.97 | 56.2 % of actual |
| **Current production** | **350.7 GB/s** | **23.08** | **100 %** |

For comparison — Q3_K:
- Bytes per token: 546,304,000 B
- At measured VRAM ceiling (525 GB/s): 1.041 ms
- Current: 1.085 ms (96.0 % of measured ceiling, 104 % of nominal)

**IQ3_XXS achieves 350.7 / 525 = 66.8 % of the measured VRAM ceiling. Q3_K achieves 96 %.** The gap (1.5×) is the candidate for optimization.

## 3.2 Compute-Bound Ceiling

Arithmetic intensity:
- IQ3_XXS vec_dot: 8 dp4a ops per call = 32 INT8 mul-adds.
- Per-token compute (6 IQ3_XXS GEMV × 36 layers × 4096 K × 32 ops/elem): 6 × 36 × 4096 × 32 = 28,311,552 INT8 ops/token (rough — using 4096 as typical hidden dim).
- arith intensity ≈ 28 M / 8.09 GB ≈ **3.5 × 10⁻³ FLOP/byte** (load-bound by a factor of ~150 vs the ridge point of 0.5 FLOP/byte).

DP4A peak (RX 7800 XT, RDNA3):
- 60 CUs × 2 SIMDs × 32 lanes × 2.254 GHz = **8,655 GINT8 ops/s** (DP4A counts as 8 INT8 ops per instruction in some accounting, but each dp4a is one mul-add so peak is 8,655 G mul-adds/s = 17,310 GOPS).
- Effective compute: 28.3 M ops / 23.08 ms = 1.23 G mul-adds/s = **0.014 % of peak**.

**Compute is utterly irrelevant. The kernel is not compute-bound by any measure.**

## 3.3 Latency-Bound Ceiling

The critical path per inner iter (vecdotq.cuh:1166-1182):
1. Load `q3[l0]` (1 byte, already in `q3_packed` register) — **0 cycles, register access**
2. Dependent global load `iq3xxs_grid[q3[l0]]` — **L1 hit: ~30 cycles, L2 hit: ~80 cycles, VRAM: ~300+ cycles** (RDNA3 estimates)
3. Apply sign mask → `grid_l` (register) — 0 cycles
4. Load `u0` (Q8_1, L1 hit) — ~30 cycles, parallel with step 2
5. dp4a — 4 cycles (RDNA3 INT8 dp4a latency)
6. Accumulate into `sumi` — 0 cycles

Per-iter latency ≈ max(step2, step4) + step5 = **30-80 cycles for the table gather + 4 cycles for dp4a**.

For the 4-iter unrolled loop, total serial latency: 4 × (30-80) + final = **120-320 cycles** for the chain if no ILP across iters. With 4-way unroll, the compiler can pipeline 1-2 iters in flight, so effective chain is closer to 2× → **60-160 cycles per vec_dot**.

At 2.254 GHz, 100 cycles = 44 ns. Across 12 active vec_dots per warp (ncols_x=1536), serially that's 12 × 44 = 528 ns/warp.

But warps in different blocks run in parallel (60 CUs × 1 block each). Total useful work per token ≈ 4096 rows × 6 blocks/row × ... → no, the dominant cost is the **bytes loaded per token**, not the per-vec-dot latency.

### Can latency be hidden?
Yes, in principle. With 60 CUs each running 1 warp, the GPU has 60 warps in flight. Each warp is independent (different rows). The dependent-load chain in one warp's vec_dot can overlap with another warp's compute. **Hardware-level latency hiding works fine** — the issue is not the per-vec-dot chain, it's that each vec_dot still has to load its own bytes, and the bandwidth is finite.

### Per-vec_dot chain vs bandwidth
For IQ3_XXS per vec_dot (24-56 B + 32 cycles latency), the chain bandwidth is:
- 24 B / 100 cycles = 0.24 B/cycle = **0.54 TB/s per warp**.
- 60 warps in parallel: 60 × 0.54 = **32.4 TB/s** of "chain" bandwidth.

But the data has to come from VRAM at 525 GB/s. The 32 TB/s chain capacity vastly exceeds the 525 GB/s source. So **latency is not the bottleneck — bandwidth is**. The chain completes well within the bandwidth-limited schedule, as long as enough warps are in flight.

## 3.4 Verdict Classification

| Bound | Limit | Achieved | Headroom |
|-------|------:|---------:|---------:|
| Bandwidth (VRAM) | 15.41 ms | 23.08 ms | 1.50× gap (kernel 33 % below ceiling) |
| Bandwidth (IC) | 11.25 ms | 23.08 ms | 2.05× gap (kernel 51 % below ceiling) |
| Bandwidth (Random gather w/ hot data) | 10.28 ms | 23.08 ms | 2.24× gap |
| Compute (DP4A) | ~0.001 ms | 23.08 ms | 23,000× headroom (irrelevant) |
| Latency (gather chain) | 0.4 ms (est) | 23.08 ms | 57× headroom (irrelevant) |

## Classification: **MIXED — but primarily LATENCY-BOUND at the per-thread level, masquerading as bandwidth underutilization**

The aggregate 350 GB/s is well below the 525 GB/s VRAM ceiling (1.5× gap). This is not because the bytes don't fit in the pipe — they do, in principle. The reason Q3_K hits 96 % of the ceiling while IQ3_XXS hits 67 % is **per-vec-dot work imbalance**:

- Q3_K vec_dot: 0 dependent global loads, 2 dp4a → very short kernel, can saturate VRAM with many in-flight warps.
- IQ3_XXS vec_dot: 8 dependent global loads (gather chain), 8 dp4a → long per-call latency, fewer warps make progress per cycle.

The gather chain lengthens the per-call latency, which reduces the rate at which a single warp can issue new VRAM requests. To hit the VRAM ceiling, the kernel would need to issue more outstanding loads per cycle — i.e. **more parallel work per warp or more warps per CU**. Both are software-tunable.

## Per-byte Cost Ratio (IQ3_XXS vs Q3_K)
- IQ3_XXS: 23.08 ms / 8.09 GB = **2.85 ns/kB**
- Q3_K: 1.085 ms / 0.546 GB = **1.99 ns/kB**
- Ratio: 1.43× (IQ3_XXS is 43 % slower per byte).

Q3_K is bandwidth-bound (1.99 ns/kB ≈ 1/525 GB/s). IQ3_XXS is 43 % worse than that, which corresponds to the per-vec-dot gather overhead eating into effective bandwidth.

## Final Classification

**MIXED → BANDWIDTH-UNDERUTILIZED, with the per-thread latency of the gather chain being the root cause.**

- The hardware VRAM ceiling is 15.4 ms (525 GB/s); the kernel is at 23.1 ms (350 GB/s). The 1.5× gap is software-addressable.
- This is not "BANDWIDTH-BOUND" (which would be at the ceiling).
- This is not pure "LATENCY-BOUND" in the sense that latency alone is the limit (latency can be hidden).
- It's a **mixed case where the gather chain creates enough per-call latency that the aggregate VRAM pipe is not fully saturated**. Optimizations that reduce dependent-load chain length or increase in-flight warps could close the gap.

## Recommendation for Hypothesis Phase
There is real headroom (1.5× potential speedup → 23.1 ms → ~15.4 ms, saving ~7.7 ms/token or ~18 % of total decode time if achievable). A kernel optimization hypothesis is justified.

The headroom is **not** a "5 % polish" — it's 33 % of the IQ3_XXS time. The optimization could be:
- Increase warps per block (currently 1 for RDNA3, may hit register pressure).
- Cache iq3xxs_grid in shared memory (1024 B fits in 32 KB L1, but a per-block broadcast could reduce L1 traffic from 60×8 to 60×1).
- Reorder operations to overlap more loads.
- Use a different dequantization strategy (e.g. fully or partially unroll the 256-entry table into the kernel).

These are hypothesis-phase topics, not implementation topics.
