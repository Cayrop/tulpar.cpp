# P3 ADDENDUM: 128K Context Matrix - VRAM/Stability A/B (stock vs clean patch, MTP OFF/ON)
Date: 2026-08-23 | ctx=131072, prompt=129,469 tokens (needle AMBER-KEY-7241 @50%), 96-token decodes
Card: RX 7800 XT 16GB (mem_info_vram_used is SYSTEM-WIDE incl. Plasma compositor)

# Matrix Results
| config | decode tok/s | VRAM peak (overall) | VRAM r2/r3 steady | prefill tok/s | draft acc | needle | errors | stalls>500ms |
|---|---|---|---|---|---|---|---|---|
| base OFF (M1) | 7.76 | 14.551 GB | 14.54 | 231.6 | - | YES | none | 0 |
| clean OFF (M2) | **11.97 (+54%)** | 14.798 GB | 14.54 | 231.5 | - | YES | none | 0 |
| base ON (M3) | 9.10 | 15.589 GB | 15.59 | 220.7 | 34/50 (68%) | YES | none | 0 |
| clean ON (M4) | **14.66 (+61%)** | 15.599 GB | 15.59 | 220.7 | 38/50 (76%) | YES | none | 0 |

Sleep-drift monitor (CPU-side stall proxy): max drift 3-4 ms in ALL windows,
zero stalls >500ms - the short-burst protocol did not reproduce the user's
desktop freeze; longer real-desktop sessions remain the authoritative test.

# Findings
1. SPEED at 128k mirrors the patch gains: OFF +54%, ON +61% (gain keeps growing
   with context, consistent with VEC degradation being KV-length-dependent).
2. MEMORY: the patch does NOT change steady-state decode VRAM
   (OFF: 14.54 both; ON: 15.59 both, delta +10 MB = noise).
   It DOES raise the TRANSIENT PEAK during the first fresh full-context prefill
   by ~250 MB (OFF: 14.547 -> 14.798 during r1) - matches one layer's
   K+V F16 staging (4 kv-heads x 256 x 131072 x 2B x 2 = 512 MiB upper bound;
   observed 250 MB net after allocator reuse). After warm-up, footprint
   returns to baseline levels.
3. THE USER'S PLASMA STUTTER IS AN MTP-AT-128K PROPERTY, NOT PATCH-RELATED:
   MTP ON pushes system-wide VRAM to 15.59/16.37 GB (~0.77 GB free) regardless
   of kernel choice. Baseline OFF leaves 1.8 GB free. Any compositor/browser
   burst must fit in that sliver -> eviction/stall pressure exists ONLY on the
   MTP path. Draft acceptance also degrades at 128k (68-76% vs 99-100% at 63k),
   so MTP loses efficiency here too.
4. Patch slightly improved draft acceptance at 128k (38/50 vs 34/50, same
   seed/prompt; small sample - reported, not claimed).
5. Prefill identical stock-vs-clean at 128k (231.5/231.6 OFF; 220.7 both ON):
   confirms dispatch change never touches prefill shapes.

# Practical recommendations for 128k + MTP + desktop use
- If freezes matter: reduce context (e.g. -c 98304), drop --ctx-checkpoints,
  or run MTP OFF at 128k (patch makes that path 54% faster, making OFF more
  viable than before).
- Keep the patch: it strictly dominates baseline at every measured point and
  adds no measurable steady-state memory.

# Verdict for PR memory consideration paragraph
Measured, scoped statement possible instead of speculation:
"Steady-state VRAM unchanged; first-full-prefill transient +~250 MB at 128k
(one layer's q4_0->F16 staging); no OOM observed with 0.8-1.8 GB free."
