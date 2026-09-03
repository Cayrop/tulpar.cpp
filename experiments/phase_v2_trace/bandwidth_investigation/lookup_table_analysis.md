# Lookup Table Analysis — iq3xxs_grid

## Definition
`ggml/src/ggml-common.h:1017-1050`:
```cpp
GGML_TABLE_BEGIN(uint32_t, iq3xxs_grid, 256)
    0x04040404, 0x04040414, 0x04040424, ...  (256 entries)
GGML_TABLE_END()
```

For the CUDA/HIP build (`ggml-common.h:490-494`):
```cpp
#define GGML_TABLE_BEGIN(type, name, size) static const __device__ type name[size] = {
```

So `iq3xxs_grid` is a **1024-byte static array in device global memory** (`__device__` qualifier → not constant memory, not shared memory).

## Size
- 256 entries × 4 bytes = **1024 bytes** (1 KB).
- Fits trivially in L1 (32 KB per CU) and L2 (4 MB shared).

## Access Pattern
Used in 3 places:
1. `ggml/src/ggml-cuda/vecdotq.cuh:1167` — `vec_dot_iq3_xxs_q8_1` (decode path)
2. `ggml/src/ggml-cuda/dequantize.cuh:335-336` — dequant kernel
3. `ggml/src/ggml-cuda/mmq-load-tiles.cuh:1323` — MMQ load (prefill)

All three use it identically:
```cpp
iq3xxs_grid[q3[l]]  // uint8 index → uint32 value, 4-byte load
```

The indices come from the per-block `qs[]` (random 8-bit values, no structure). After the dequantize/mmq-load paths, the values are typically cached or pre-loaded; in the MMVQ path they're loaded on demand.

## Distinct Entries per Dispatch

For one vec_dot call (one warp, one block, one kqs, inner 4-iter loop):
- 4 iter × 2 indices/iter = **8 distinct 4-byte loads** into `iq3xxs_grid[]`.
- Each index is a uint8 → 256 possible entries.
- Across 32 lanes in a warp, each lane accesses 8 indices, so up to 256 distinct 4-byte cachelines can be touched per warp (worst case 1 KB total).

## Threads Accessing Same Entry Simultaneously
- Within a warp: lanes have **different** indices (kqs is the lane-dependent parameter, but the per-block `qs[]` is shared). So all 32 lanes access the *same* `qs[]` block but different `q3[l]` indices within that block.
- Probability of 2 lanes hitting the same `iq3xxs_grid[]` entry is 1/256 (if indices were uniform random).
- Effectively **no within-warp sharing** of the table. Each lane does its own gather.
- Across warps (different blocks): may share entries, but blocks are scheduled independently and there is no shared-memory caching of the table.

## "Cost" per Access in IQ3_XXS
The 1024-byte table is hot in L1, so a 4-byte access costs:
- ~4-8 cycles of L1 latency (RDNA3 L1 latency is ~30-50 cycles for a miss, but the table will stay resident).
- The first access in a vec_dot stalls the warp's dependent chain.
- Subsequent 3 iters reuse the same `iq3xxs_grid[]` value only if the index is identical; in practice different, so the warp issues 4-8 dependent global loads per vec_dot.

## Why Not Constant Memory?
On AMD GPUs there is no separate "constant cache" wired like NVIDIA's. `__constant__` arrays still go through L1/L2. The `static const __device__` storage here behaves identically to `__constant__` for caching, but consumes a global memory address range. With 1024 B and L1=32 KB, this is fine — **the table is not the bandwidth bottleneck**, it lives in L1 across all CUs after the first wave.

## Verdict on the Lookup Table
- **Size**: trivially small (1 KB), always in L1/L2.
- **Per-call loads**: 8 dependent global loads (one per `q3[l]` pair across 4 inner iter).
- **Per-warp loads**: 8 × 32 lanes = 256 random 4-byte L1 accesses per vec_dot (mostly L1 hits, no VRAM traffic).
- **Latency contribution**: the dependent-load chain is the **per-iter critical path**. Each grid lookup must complete before the dp4a can use the value.
- The table is **not** the bandwidth bottleneck (microbenchmark 1.1 shows 5 TB/s for 1 KB hot-data read). The bottleneck is the **dependent-load latency** of the gather chain, not the bytes moved.
