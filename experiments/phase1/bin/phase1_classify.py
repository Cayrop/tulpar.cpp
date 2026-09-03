#!/usr/bin/env python3
# Phase-1 kernel classifier (V3-aware clone of phase2b/bin/analyze_trace.py
# classifier with the new quant types added).

TYPE_NAMES = {
    "2": "Q4_0", "8": "Q8_0", "10": "Q2_K", "11": "Q3_K", "12": "Q4_K",
    "13": "Q5_K", "14": "Q6_K", "16": "IQ2_XXS", "17": "IQ2_XS",
    "18": "IQ3_XXS", "19": "IQ1_S", "21": "IQ3_S", "22": "IQ2_S",
    "23": "IQ4_XS", "29": "IQ1_M",
}


def base_name(full):
    return full.replace("void ", "", 1)


def classify(name):
    n = base_name(name)
    m = n.startswith("mul_mat_vec_q<") and None
    import re
    m = re.match(r"mul_mat_vec_q<\(ggml_type\)(\d+)", n)
    if m:
        t = TYPE_NAMES.get(m.group(1), f"type{m.group(1)}")
        return f"GEMV_{t}"
    if n.startswith("mul_mat_vec_q<"):
        return "GEMV_other"
    if n.startswith("mul_mat_q<"):
        m = re.match(r"mul_mat_q<\(ggml_type\)(\d+)", n)
        t = TYPE_NAMES.get(m.group(1), f"type{m.group(1)}") if m else "?"
        return f"MMQ_GEMM_{t}"
    if n.startswith("quantize_mmq_q8_1"):
        return "QUANT_MMQ_prefill"
    if n.startswith("quantize_q8_1") or n.startswith("quantize_scatter"):
        return "QUANT_ROW_decode"
    if n.startswith(("dequantize_block_",)) or "_to_fp16" in n.split("<")[0]:
        return "STAGING_dequant"
    if n.startswith("convert_unary<float, __half>"):
        return "STAGING_f32_to_f16"
    if n.startswith("convert_unary<__half, float>"):
        return "STAGING_f16_to_f32"
    if n.startswith("flash_attn_tile") or n.startswith("flash_attn_combine_results"):
        return "ATTN_FA_TILE"
    if n.startswith("flash_attn_ext_vec"):
        return "ATTN_VEC_surprise"
    if n.startswith("k_set_rows_quant") or n.startswith("cpy_scalar") or \
       n.startswith("cpy_q_f32") or n.startswith("cpy_f32"):
        return "KV_STORE_COPY"
    if n.startswith(("rms_norm", "l2_norm", "rope_", "unary_gated_op",
                     "unary_op_kernel", "k_bin_bcast", "scale_f32", "concat_")):
        return "NORM_ROPE_ACT"
    if n.startswith(("gated_delta_net_cuda", "ssm_conv", "fwht_cuda")):
        return "GDN"
    if n.startswith("k_get_rows"):
        return "EMB_GET_ROWS"
    if n.startswith("Cijk_Alik"):
        return "ROCBLAS_GEMM"
    if n.startswith(("topk", "argsort", "softmax", "argmax", "sync",
                     "sampling", "dist_", "cumsum")):
        return "SAMPLING_GLUE"
    return "OTHER"
