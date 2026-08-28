# V2 Model Verification

**Date:** 2026-08-27
**Binary:** `build-p3/bin/llama-server` (Phase-2 only, Phase-3 reverted)
**Git HEAD:** `4f72448eb810da13c47f870933da6bb919b3ca72`

## 1. File Identity

| Field | Value |
|-------|-------|
| Path | `/home/gencer/models/qwen-v2/Qwen3.8-27B-UD-Q2_K_XL.gguf` |
| Size | 10,676,423,744 bytes (10.66 GiB) |
| SHA-256 | `46151b52a5cad673d90a00222103254864326c251130b8fc4381d6f34386b3c8` |
| mtime | 2026-08-26 12:51:01 +0300 |
| Inode | 31083395 |

## 2. Architecture Metadata

| Key | Value |
|-----|-------|
| general.architecture | qwen35 |
| general.name | Qwen3.8-27B |
| general.file_type | 14 (MOSTLY_IQ3_XXS) |
| qwen35.block_count | **65** |
| qwen35.context_length | 262144 |
| qwen35.embedding_length | 5120 |
| qwen35.attention.head_count | 24 |
| qwen35.attention.head_count_kv | 4 (GQA, 6:1 ratio) |
| qwen35.attention.key_length | **256** |
| qwen35.attention.value_length | **256** |
| vocab_size | 248320 |

## 3. Quant Type Distribution (Tensor Bytes)

| Quant | Count | Bytes | % of Total |
|-------|------:|------:|----------:|
| **IQ3_XXS** | 288 | 8,092,385,280 | **75.87%** |
| IQ3_S | 99 | 1,376,460,800 | 12.91% |
| Q3_K | 1 | 546,304,000 | 5.12% |
| Q2_K | 1 | 417,177,600 | 3.91% |
| IQ4_XS | 21 | 217,251,840 | 2.04% |
| F32 | 360 | 10,686,464 | 0.10% |
| IQ1_M | 96 | 5,160,960 | 0.05% |
| **TOTAL** | 866 | 10,665,426,944 | 100% |

## 4. Key Tensor Inventory

| Tensor | Quant | Shape (n_embd, n_tokens) | Bytes |
|--------|-------|------------------------|------:|
| `token_embd.weight` | **Q2_K** | (5120, 248320) | 417,177,600 |
| `output.weight` | **Q3_K** | (5120, 248320) | 546,304,000 |

## 5. Per-Family (block weight) Distribution

| Family | Count | Bytes | Quants |
|--------|------:|------:|--------|
| ffn_down | 65 | 2,231,009,280 | IQ3_XXS, IQ4_XS |
| ffn_gate | 65 | 2,231,009,280 | IQ3_XXS, IQ4_XS |
| ffn_up | 65 | 2,231,009,280 | IQ3_XXS, IQ4_XS |
| attn_qkv | 48 | 963,379,200 | IQ3_XXS |
| ssm_out | 48 | 648,806,400 | IQ3_S |
| attn_gate | 48 | 578,027,520 | IQ3_XXS |
| attn_q | 17 | 459,571,200 | IQ3_S |
| attn_output | 17 | 229,785,600 | IQ3_S |
| attn_v | 17 | 47,349,760 | IQ4_XS |
| attn_k | 17 | 38,297,600 | IQ3_S |
| nextn.* (MTP head) | 6 | 27,852,800 + small | IQ4_XS, F32 |
| ssm_conv1d | 48 | 7,864,320 | F32 |
| ssm_alpha | 48 | 2,580,480 | IQ1_M |
| ssm_beta | 48 | 2,580,480 | IQ1_M |
| norms (RMS, L2) | 196+ | 1.4 MB total | F32 |
| ssm_a / ssm_dt | 96 | 18,432 | F32 |

## 6. Hybrid Block Topology

V2 is a **hybrid** model: 65 blocks total, mix of standard attention (17 blocks)
and GDN / linear-attention (48 blocks). MTP head (nextn.*) is present but
**disabled** per the arm naming (`-OFF` suffix). The trace captures MTP=off
code paths only.

Standard-attention blocks carry: attn_q, attn_k, attn_v, attn_output,
attn_q_norm, attn_k_norm, attn_norm, post_attention_norm, ffn_*.

GDN / linear-attention blocks carry: attn_qkv (fused QKV), attn_gate,
ssm_out, ssm_conv1d, ssm_alpha, ssm_beta, ssm_a, ssm_dt, ssm_norm, plus
shared attn_norm / post_attention_norm / ffn_*.

## 7. PASS/FAIL Verdict

| Check | Expected | Actual | Verdict |
|-------|----------|--------|:-------:|
| Architecture | qwen35 | qwen35 | PASS |
| block_count | 65 | 65 | PASS |
| key_length | 256 | 256 | PASS |
| value_length | 256 | 256 | PASS |
| IQ3_XXS share | ~75% | 75.87% | PASS |
| Q2_K present (token_embd) | yes | yes (417 MB) | PASS |
| Hybrid (attn + GDN) | yes | 17 attn + 48 GDN | PASS |
| File size | ~10.6 GiB | 10.66 GiB | PASS |
| File readable | yes | yes | PASS |

**VERDICT: PASS** - V2 model confirmed. Proceed to trace.
