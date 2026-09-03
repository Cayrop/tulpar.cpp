#!/usr/bin/env python3
# Compose phase2b_attribution.json from derived_rerun artifacts.
import json

from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
P2B = str(ROOT / "experiments/phase2b")
DR = f"{P2B}/derived_rerun"

arms = ["T2_O1-off-1k", "T2_P1-off-16k", "T2_P2-off-63k", "T2_P3-off-128k"]
ctx_of = {"T2_O1-off-1k": 1024, "T2_P1-off-16k": 16384,
          "T2_P2-off-63k": 64512, "T2_P3-off-128k": 131072}

untraced = {  # server timings; per-token ms from cached reps where present
    "R_U-off-1k": {"tg_med": 22.243, "ms_per_tok": 5745.424 / 128},
    "R_U-off-16k": {"tg_med": 20.643, "ms_per_tok": 6199.207 / 128},
    "R_U-off-63k": {"tg_med": 15.645, "ms_per_tok": 24303.249 / 380},
    "R_U-off-128k": {"tg_med": 12.242, "ms_per_tok": 7842.169 / 96},
}
arm_of_ctx = {1024: "R_U-off-1k", 16384: "R_U-off-16k",
              64512: "R_U-off-63k", 131072: "R_U-off-128k"}

# corrected MTP-OFF streamed weight bytes (GGUF totals minus blk.64 nextn)
BYTES = {
    "IQ3_XXS": 8092385280,
    "IQ3_S": 1376460800 - 42803200,
    "Q3_K": 546304000,
    "IQ4_XS": 217251840 - 172687360,
    "IQ1_M": 5160960,
}
NOMINAL_GBPS = 624.0

walls = json.load(open(f"{DR}/step_wall_medians.json"))
gguf = json.load(open(f"{DR}/gguf_bytes_check.json"))

out = {
    "meta": {
        "date": "2026-08-25",
        "binary_sha256": "280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13",
        "git_head": "66dcba5eb7dd92cd460cfc040c7cae42f1254e20",
        "gpu": "AMD Radeon RX 7800 XT (gfx1101), ROCm 7.2.4, rocprofv3 1.1.0",
        "server_flags": ("-c 131072 -ngl 999 --load-mode mmap -fa on -ctk q4_0 "
                         "-ctv q4_0 --cache-prompt --ctx-checkpoints 4 -t 8 -np 1 "
                         "--metrics; greedy temp0 top_k1 seed1234"),
        "method_note": ("decode step period = lm_head-GEMV marker-to-marker time "
                        "from kernel_trace timestamps; per-step stats over clean "
                        "steps (wall <= median*1.25/1.30); profiler buffer-flush "
                        "stall events excluded and listed separately"),
        "gguf_streamed_bytes_correction": {
            "blk64_nextn_not_streamed_mtp_off": gguf["nextn"],
            "corrected_total_streamed_B": sum(BYTES.values()),
            "ledger_total_B": 10237562880},
    },
    "untraced_arms": {},
    "traced_arms": {},
    "overhead_gate": {},
    "effective_gemv_bandwidth": {},
    "attention_staging": {},
    "verdicts": {
        "H-P2B-1_GEMV_BW": "CONFIRMED (in-model IQ3_XXS 265.7 GB/s = 42.6% of 624; far below 450 refutation line)",
        "H-P2B-2_QUANT_GAPS": "REFUTED-as-dominant (quantize kernels 0.61 ms/tok = 1.2% wall; quantize-adjacent idle ~3.0 ms/tok of 7.5 ms/tok total GPU idle; no single dominant gap source)",
        "H-P2B-3_GDN_share": "MEASURED LOW (0.52 ms/tok = ~1.0% of step at 16k; far below 20% flag threshold)",
        "H-P2B-4_ATTN_STAGING": "CONFIRMED (staging 1.43->19.63 ms/tok 16k->128k, superlinear; #2 cost at 128k at 25.3% of busy; linear-with-L traffic model refuted by cache-capacity interpretation)",
        "H-P2B-5_GRAPHS": "CONFIRMED ACTIVE (all traced decode steps graph-replayed; zero warmup resets)"
    },
}

for a, r in untraced.items():
    out["untraced_arms"][a] = r

for arm in arms:
    d = json.load(open(f"{DR}/{arm}_analysis.json"))
    w = walls[arm]
    ctx = ctx_of[arm]
    u = untraced[arm_of_ctx[ctx]]
    wall_med = w["clean_median_ms"]
    cats = d["categories_over_clean"]
    busy_sum = sum(c["ms_per_step"] for c in cats.values())
    out["traced_arms"][arm] = {
        "context_target": ctx,
        "clean_steps": d["clean_steps_used"],
        "steps_found": d["steps_found"],
        "excluded_steps": d["excluded_steps"],
        "step_period_median_ms": round(wall_med, 3),
        "step_period_min_max_ms": [w["clean_min"], w["clean_max"]],
        "kernel_busy_ms_per_step": round(busy_sum, 3),
        "inter_kernel_gap_nonstall_ms_per_step":
            d["per_step_means_over_clean"]["gap_nonstall_ms"],
        "sampling_tail_ms_median": d["gap_distribution"]["sampling_tail_ms_median"],
        "quantize_row_launches_per_step":
            d["per_step_means_over_clean"]["quantize_row_launches"],
        "categories": cats,
        "top_gap_transitions": d["top_gap_transitions"][:10],
        "gap_distribution": {k: v for k, v in d["gap_distribution"].items()
                             if k != "stall_events_ge5ms"},
        "stall_events_ge5ms": d["gap_distribution"]["stall_events_ge5ms"],
        "pp_probe_phase": d["pp_probe_phase"],
        "server_reported_traced": None,
    }
    # overhead gate on steady-state medians
    ovh = (wall_med - u["ms_per_tok"]) / u["ms_per_tok"]
    out["overhead_gate"][arm] = {
        "untraced_ms_per_tok": round(u["ms_per_tok"], 3),
        "traced_step_period_ms": round(wall_med, 3),
        "overhead_pct": round(ovh * 100, 2),
        "gate_25pct": "PASS" if ovh < 0.25 else "FAIL",
    }

# effective bandwidth table at 16k (+ constancy check across arms)
ref = json.load(open(f"{DR}/T2_P1-off-16k_analysis.json"))
cats16 = ref["categories_over_clean"]
per_arm_gemm = {}
for arm in arms:
    dd = json.load(open(f"{DR}/{arm}_analysis.json"))["categories_over_clean"]
    per_arm_gemm[arm] = {c: dd[c]["ms_per_step"] for c in dd if c.startswith("GEMV")}
for t, b in BYTES.items():
    cat = f"GEMV_{t}"
    if cat not in cats16:
        continue
    ms16 = cats16[cat]["ms_per_step"]
    vals = {arm: per_arm_gemm[arm].get(cat) for arm in arms}
    bw = b / (ms16 / 1e3) / 1e9
    entry = {
        "bytes_per_step_MTP_OFF": b,
        "ms_per_token_16k": round(ms16, 4),
        "ms_per_token_by_arm": {a: round(v, 4) for a, v in vals.items() if v},
        "eff_GBs_16k": round(bw, 1),
        "pct_of_nominal_624": round(bw / NOMINAL_GBPS * 100, 1),
    }
    out["effective_gemv_bandwidth"][t] = entry

tot_b = sum(BYTES.values())
tot_ms = sum(cats16[c]["ms_per_step"] for c in cats16 if c.startswith("GEMV"))
out["effective_gemv_bandwidth"]["TOTAL_streamed"] = {
    "bytes_per_step_MTP_OFF": tot_b,
    "gemv_ms_per_token_16k": round(tot_ms, 3),
    "aggregate_eff_GBs": round(tot_b / (tot_ms / 1e3) / 1e9, 1),
    "pct_of_nominal_624": round(tot_b / (tot_ms / 1e3) / 1e9 / NOMINAL_GBPS * 100, 1)}

# attention staging model (corrected byte math) + measured times
staging = {}
for arm in arms:
    dd = json.load(open(f"{DR}/{arm}_analysis.json"))
    c = dd["categories_over_clean"]
    L = ctx_of[arm]
    st = c.get("STAGING_dequant", {}).get("ms_per_step")
    tl = c.get("ATTN_FA_TILE", {}).get("ms_per_step")
    kv = c.get("KV_STORE_COPY", {}).get("ms_per_step")
    staging[arm] = {
        "context_tokens_approx": L,
        "staging_dequant_ms_per_tok": st,
        "attn_tile_ms_per_tok": tl,
        "kv_store_ms_per_tok": kv,
        "staging_traffic_model_bytes_per_tok": {
            "q4_read": L * 18432, "f16_write": L * 65536,
            "tile_f16_reread": L * 65536},
        "staging_eff_GBs_rw_model": round(
            (L * (18432 + 65536)) / (st / 1e3) / 1e9, 1) if st else None,
        "tile_eff_GBs_reread_model": round(
            (L * 65536) / (tl / 1e3) / 1e9, 1) if tl else None,
    }
out["attention_staging"] = staging

json.dump(out, open(f"{P2B}/phase2b_attribution.json", "w"), indent=1)
print("wrote phase2b_attribution.json")
print(json.dumps(out["overhead_gate"], indent=1))
print(json.dumps(out["effective_gemv_bandwidth"], indent=1))
print(json.dumps(out["attention_staging"], indent=1))
