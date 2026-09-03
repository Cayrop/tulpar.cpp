# Phase-2 Staging Verification (Step 5.4)

Single rocprofv3 --kernel-trace --stats wrapped instance, MTP OFF, ctx 131072,
probe prefill (n_predict=1) + cached main decode (n_predict=32), same protocol
as Phase-1 T-128k-OFF. Artifacts: experiments/phase2/raw/T_P2-128k-OFF/.

## Headline

    dequantize_block_q4_0 launches: 0   (Phase-1 baseline: 32 per decode token)

The staging kernel is GONE from every phase of the trace: not launched during
prefill ubatches, cache restore, or any decode step.

## Kernel census, flash_attn_tile variants (P2 vs P1 baseline trace)

Template census is IDENTICAL between the two traces - dispatch behavior is
unchanged by the modification:

| variant <DKQ,DV,ncols1,ncols2> | P2 calls | P1 calls |
|-------------------------------|----------|----------|
| 256,256,16,2 (prefill tiles)  | 4048     | 4048     |
| 256,256,1,2  (decode)         | 496      | 496      |
| 256,256,4,2  (restore/probe)  | 32       | 32       |
| 256,256,2,2  (restore)        | 32       | 32       |

Remaining dequantize_* kernels in the P2 trace (iq2_s / iq2_xs / q2_K / iq1_m)
are the prefill hipBLAS weight-staging fallback documented in Phase-1 sec 9
(MMQ ne11 threshold on RDNA3); they are unrelated to KV caching and were not
touched.

## Decode-window attention cost per token (last 31 clean steps, both traces)

| metric                        | P1 baseline | P2 fused | delta |
|-------------------------------|-------------|----------|-------|
| tile ms/launch (<1,2>)        | 1.060       | 1.181    | +0.121 |
| flash_attn_tile ms/token      | 16.960      | 18.903   | +1.94  |
| staging dequant ms/token      | ~19.65      | 0        | -19.65 |
| net attention ms/token        | ~36.61      | 18.90    | -17.71 |

The fused kernel reads the q4_0 blocks directly (1152 B/token/layer instead
of 4096 B F16 re-read), so its per-launch cost rises modestly from nibble
unpacking while the entire write+re-read round trip disappears.

## New staging ms/tok

0.00 ms/tok at every context (kernel no longer exists in the launch stream).

## Cross-check vs end-to-end

Removing ~17.7 ms/tok of attention work from the Phase-1 step period of
82.8 ms predicts ~15.4 tok/s; measured untraced tg at 128k is 16.108 tok/s.
Consistent within the traced-overhead uncertainty (+ secondary effects:
lower DRAM pressure, no f16_extra allocation).
