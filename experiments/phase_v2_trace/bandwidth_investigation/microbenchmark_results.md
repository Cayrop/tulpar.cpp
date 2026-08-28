# Microbenchmark Results — gfx1101 VRAM Bandwidth

## Hardware
- GPU: AMD Radeon RX 7800 XT (gfx1101, RDNA3, 60 CUs @ 2.254 GHz, 64 MB Infinity Cache)
- VRAM: 16 GB GDDR6, 128-bit, 16 Gbps → **nominal 624 GB/s**
- Infinity Cache (L3): 64 MB

## Test Harness
Standalone HIP program (`/tmp/opencode/bw_micro.hip`, deleted after run), compiled with `hipcc -O3 --offload-arch=gfx1101`. 20-iter loop, 1 warmup, hipEvent timing. Grid = 480 blocks (60 CU × 8), block = 256 threads.

## Results

### Pure sequential read (coalesced)
Coalesced float reads, varying working set:

| Working set | Fits in IC? | Achieved GB/s | % of 624 nominal |
|------------:|:-----------:|--------------:|-----------------:|
| 32 MB       | yes         | 719.3         | 115.3 %          |
| 128 MB      | no          | 529.5         | 84.9 %           |
| 1 GB        | no          | 524.9         | 84.2 %           |

The Infinity Cache cliff is between 32 MB and 128 MB. Working set > 64 MB falls off IC. At 1 GB the kernel hits 525 GB/s = 84% of nominal — this is the practical VRAM ceiling for the test. (Slight overage at 32 MB because the read pattern is regular and predictable to the prefetcher.)

### Random gather read
Random uint32 indices into a 4 KB source (worst-case L1 miss on every access):

| Working set (idx buffer) | Achieved GB/s | Notes |
|-------------------------:|--------------:|-------|
| 32 MB (8 M indices)      | 1031          | idx hits VRAM (32 MB > L1), data fits in L1 |
| 128 MB (32 M indices)    | 828           | idx mostly in L2, data in L1 |
| 1 GB (256 M indices)     | 787           | idx in VRAM, data in L1 |

Effective bandwidth exceeds 624 because the data is in cache; the index stream itself is the only VRAM traffic. This shows that **random gather to a small, hot dataset is not the bottleneck** — the limit is VRAM throughput on the main read.

### Small repeated read (1 KB table)
Simulates iq3xxs_grid access pattern: each lane reads 1 of 256 uint32_t entries. Same L1/L2 hit every time.

| Reads per kernel | Achieved GB/s |
|-----------------:|--------------:|
| 67 M             | 5267          |
| 1.07 B           | 5523          |

Pure L1/L2 traffic; VRAM not touched once. Even a 1 KB static table hit 5 TB/s.

## Comparison to Current IQ3_XXS Bandwidth

| Source                              | Bandwidth      | Notes                                   |
|-------------------------------------|---------------:|-----------------------------------------|
| Nominal VRAM                        | 624 GB/s       | GDDR6 spec                              |
| Measured VRAM ceiling (1 GB read)   | 525 GB/s       | 84 % of nominal (sustained)             |
| Measured with IC (32 MB)            | 719 GB/s       | 115 % of nominal                        |
| Random gather (1 GB idx, hot data)  | 787 GB/s       | data-side effectively in cache          |
| **IQ3_XXS measured (production)**   | **350.7 GB/s** | 56 % of nominal                         |
| Q3_K measured (production)          | 503.6 GB/s     | 80.7 % of nominal                       |

## Interpretation

1. **350 GB/s is NOT at the raw VRAM ceiling.** Pure sequential 1 GB reads hit 525 GB/s. Random gather with a 4 KB hot dataset hits 787 GB/s. Even IC-amplified reads only reach 719 GB/s — the GEMV kernel gets neither benefit.
2. **350 GB/s is significantly below what a hot-data gather can sustain.** The kernel is not bandwidth-saturated.
3. **Q3_K hits 503 GB/s = 96 % of the measured VRAM ceiling.** Q3_K is bandwidth-bound. This is the practical upper bound for any kernel on this hardware.

## Infinity Cache Cliff
The 32 MB → 128 MB drop (719 → 529 GB/s) is the IC cliff. IQ3_XXS model is 8.09 GB → 99 % of accesses miss IC. The kernel cannot rely on IC for weight data; it only sees the 525 GB/s VRAM ceiling.

## Caveats
- Microbenchmarks are power-state sensitive. RX 7800 XT runs at variable clocks; measurements taken at idle boost state (2254 MHz max). The 525 GB/s ceiling is the real-world sustained rate, not peak.
- The 525 GB/s is for an idealized 100 %-utilization pattern. The GEMV kernel has a different access pattern (each warp reads ~32 KB of non-contiguous data per row), so even Q3_K achieves only 96 % of this.
