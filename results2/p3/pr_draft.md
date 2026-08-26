# PR DRAFT - NOT SUBMITTED

## Title
cuda : use tile flash attention for quantized KV decode on RDNA3 with head size 256

## Commit
80cf14ff5 on branch fattn-rdna3-quant-tile (rebased onto origin/master c060ca974)

```
cuda : use tile flash attention for quantized KV decode on RDNA3 with head size 256

The no-tensor-core fallback forces flash_attn_ext_vec for quantized KV
when Q->ne[1] <= 2. On RDNA3 with head size 256 the vector kernel uses
256 VGPRs per thread and is slower than the tile kernel even though the
tile path stages the whole KV cache to F16.

Measured on RX 7800 XT (gfx1101), ROCm 7.2.4, Qwen3.8-27B with q4_0 KV,
speculative decoding off: decode tok/s +5% at 1k ctx, +17% at 16k,
+40% at 63k ctx. Kernel traces show flash_attn_ext_vec fully replaced
by flash_attn_tile<256,256,1,2> at 128 VGPRs per thread.

Add decode-shaped test cases for quantized KV at head size 256 (nb 1
and 2), which are not covered by the existing test matrix.
```

## PR Body

For quantized KV caches the fallback dispatch (GPUs without tensor cores)
forces `flash_attn_ext_vec` whenever `Q->ne[1] <= 2`. On RDNA3 at head size
256 this is counterproductive:

- the vector kernel compiles to 256 VGPRs/thread (occupancy-limited);
  measured effective KV bandwidth ~33 GB/s of 624 GB/s peak at long context
- the tile kernel reaches 128 VGPRs/thread for ncols=1 and wins even while
  staging the whole q4_0 cache to F16 each call (draft FA 2477us -> 547us,
  ncols=2 verify 4318us -> 594us at 63k)
- tuning inside the VEC kernel (KQ thread cooperation 2->4, block 128->256)
  was neutral or negative; the loss is structural

This skips the forced VEC selection only when running on RDNA3 with
`Q->ne[0] == 256` and quantized KV. All other architectures, head sizes,
f16 KV behavior and prefill shapes keep the current dispatch.

### Benchmark (RX 7800 XT / gfx1101, ROCm 7.2.4, Qwen3.8-27B UD-Q2_K_XL,
GQA 24/4, DKQ=DV=256, KV q4_0/q4_0, -fa on, paired same-day windows,
medians of 3-4 cached-prefix runs, spread < +/-1%)

| ctx | before | after | delta |
|------|--------|--------|--------|
| 1k | 21.54 | 22.09 | +2.6% |
| 16k | 17.88 | 20.47 | +14.5% |
| 63k | 11.76 | 15.84 | +34.7% |
| 128k | 7.76 | 11.97 | +54% |

decode tok/s, speculative decoding off. Rebased build revalidated:
20.1 tok/s @16k, 12.0 tok/s @128k (within run variance of the table).

With draft-MTP speculative decoding (n_max=4, p_min=0.8):

| ctx | before band | after band |
|-------|-------------|-------------|
| 63k | 21.7-35.6 (median ~26) | 33.6-37.6 (median 36.6) |
| 128k | ~9.1 | ~14.7 (+61%) |

draft acceptance unchanged at 63k (99-100%); improved at 128k
(68% -> 76%, small sample). Prefill unchanged by design and measurement
(231.5 vs 231.6 tok/s @128k pp).

### Memory footprint (measured at 131072 ctx)

The tile path stages K/V to F16 per call:

- steady-state decode VRAM: unchanged (+10 MB, within noise), MTP on or off
- transient peak during first fresh full-context prefill: +~250 MB
  (one layer's staging); returns to baseline after warm-up
- no OOM observed with 0.8-1.8 GB free VRAM

On cards where a long-context MTP session leaves <~250 MB headroom, the
first prefill could OOM where the vector path would not.

### Correctness

- Added decode-shaped cases (hsk=hsv=256, nh=4, nr23={6,1}, kv=512, nb=1/2,
  type_KV=q4_0). The existing matrix covers quantized KV only at head sizes
  64/72 for small batches, and head size 256 only prefill-shaped or f16.
  Both new cases pass on ROCm against CPU reference.
- End-to-end gate (greedy, deterministic): 12/12 objective checks pass in
  baseline and patched builds, speculative on/off (factual recall,
  arithmetic, reasoning, code gen, non-English prompt, structured listing,
  single+multi needle retrieval at ~25k and ~129k tokens, open-ended
  generation with degeneration metrics).
- Short-context greedy outputs byte-identical for most prompts; occasional
  equally-valid rephrasings from different FP accumulation order. Long-context
  divergence matches the established cross-kernel noise floor. Degeneration
  behavior on adversarial random-word prompts is byte-for-byte unchanged.

### Not established

- Other RDNA3 SKUs (gfx1100/1102/1103, RDNA3.5): same ISA family, untested
- RDNA4, CDNA, NVIDIA, Vulkan/SYCL/CPU backends (dispatch untouched there)
- Head sizes other than 256 with quantized KV (VEC kept for those)
- Quant formats other than q4_0 end-to-end
- Output-quality equivalence beyond the stated gate suite

### Test plan

./build-p3/bin/test-backend-ops -o FLASH_ATTN_EXT \
  -p 'hsk=256,hsv=256,nh=4,nr23=\[6,1\],kv=512,nb=[12],'
