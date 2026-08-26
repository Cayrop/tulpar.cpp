#!/usr/bin/env python3
# Phase-1 report composer: reads untraced arm records + traced analyses,
# produces experiments/phase1/phase1_attribution.json (machine-readable)
# and prints the table block consumed by phase1_attribution.md.
import json
import os
import sys

from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
P1 = f"{ROOT}/experiments/phase1"
RAW = f"{P1}/phase1_raw"

CTXS = ["1k", "16k", "63k", "128k", "131k"]
ARM_CTX = {"1k": 991, "16k": 16390, "63k": 63528, "128k": 129487, "131k": 131032}

STREAM_BYTES = {
    "IQ3_XXS": 2480701440, "IQ2_S": 1534935040, "IQ3_S": 1297612800,
    "IQ2_XXS": 919142400, "Q4_K": 803635200, "IQ2_XS": 668344320,
    "IQ4_XS": 551485440, "IQ1_S": 348160000, "Q2_K": 285573120,
    "Q3_K": 105881600, "Q8_0": 25067520, "IQ1_M": 11468800,
    "F32": 10582016, "Q5_K": 7208960, "Q6_K": 0,
}
TOTAL_STREAM_B = 9049798656


def jload(p):
    with open(p) as f:
        return json.load(f)


def untraced_summary(arm):
    return jload(f"{RAW}/{arm}/arm_record.json")["summary"]


def traced_analysis(arm):
    return jload(f"{RAW}/T_{arm}/analysis.json")


def gemv_time_by_type(cat):
    out = {}
    for k, v in cat.items():
        if k.startswith("GEMV_"):
            t = k[len("GEMV_"):]
            out[t] = {"ms_per_token": v["ms_per_step"],
                      "calls_per_token": v["calls_per_step"]}
    return out


def main():
    res = {"meta": {
        "window_start": "2026-08-26T02:22+03", "window_end": None,
        "binary_sha256": "280556cca0310ac80d145336fde7f89da1e43610d935bff8f4514392ad070c13",
        "model_sha256": "fd4730dd8aad070517978752b63d530aeb1740d2283cab9fa24f1e404032ddb0",
        "gpu": "AMD Radeon RX 7800 XT (gfx1101)", "rocprofv3": "1.1.0",
        "nominal_bw_gbs": 624,
    }}

    # ---- untraced baselines ----
    unt = {}
    for ctx in CTXS:
        unt[f"U-{ctx}-OFF"] = untraced_summary(f"U-{ctx}-OFF")
    for ctx in ["1k", "16k", "63k", "128k"]:
        a = untraced_summary(f"U-{ctx}-ON")
        r2p = f"{RAW}/U-{ctx}-ON-r2/arm_record.json"
        if os.path.exists(r2p):
            a["r2"] = untraced_summary(f"U-{ctx}-ON-r2")
        unt[f"U-{ctx}-ON"] = a
    res["untraced"] = unt

    # ---- traced decode OFF ----
    dec_off = {}
    for ctx in CTXS:
        arm = f"T-{ctx}-OFF"
        ta = traced_analysis(arm)
        agg = ta["decode"]["aggregate"]
        rec = jload(f"{RAW}/T_{arm}/arm_record.json")
        main_resp = jload(f"{RAW}/T_{arm}/resp_main.json")["body"]["timings"]
        cats = agg["categories"]
        gemv = gemv_time_by_type(cats)
        gemv_sum_ms = sum(v["ms_per_token"] for v in gemv.values())
        bw = {}
        for t, v in gemv.items():
            b = STREAM_BYTES.get(t, 0)
            bw[t] = {
                "bytes_per_step": b,
                "ms_per_token": v["ms_per_token"],
                "calls_per_token": v["calls_per_token"],
                "eff_GBps": round(b / v["ms_per_token"] / 1e6, 1) if v["ms_per_token"] > 0.05 and b else None,
                "pct_of_nominal": round(b / v["ms_per_token"] / 1e6 / 624 * 100, 1)
                                  if v["ms_per_token"] > 0.05 and b else None,
                "launch_bound": bool(t in ("Q8_0", "IQ1_M")),
            }
        att = {
            "staging_dequant_ms_per_token": cats.get("STAGING_dequant", {}).get("ms_per_step"),
            "staging_calls_per_token": cats.get("STAGING_dequant", {}).get("calls_per_step"),
            "fa_tile_ms_per_token": cats.get("ATTN_FA_TILE", {}).get("ms_per_step"),
            "fa_tile_calls_per_token": cats.get("ATTN_FA_TILE", {}).get("calls_per_step"),
            "attn_vec_present": "ATTN_VEC_surprise" in cats,
            "kv_store_ms_per_token": cats.get("KV_STORE_COPY", {}).get("ms_per_step"),
        }
        L = ARM_CTX[ctx]
        s_ms = att["staging_dequant_ms_per_token"]
        t_ms = att["fa_tile_ms_per_token"]
        att["staging_eff_GBps_rw_model"] = round(L * (18432 + 65536) / (s_ms * 1e6), 0) if s_ms else None
        att["tile_eff_GBps_reread_model"] = round(L * 65536 / (t_ms * 1e6), 0) if t_ms else None
        dec_off[ctx] = {
            "clean_steps": agg["clean_steps_used"],
            "steps_found": agg["steps_found"],
            "excluded_steps": agg["excluded_steps"],
            "median_step_wall_ms": agg["median_step_wall_ms"],
            "kernel_busy_ms_per_token": agg["kernel_busy_ms_per_token"],
            "gap_nonstall_ms_per_token": agg["gap_nonstall_ms_per_token"],
            "sampling_tail_ms_median": agg["sampling_tail_ms_median"],
            "gpu_idle_ms_per_token": agg["gpu_idle_ms_per_token"],
            "server_tg_tok_s": round(main_resp["predicted_n"] / main_resp["predicted_ms"] * 1000, 3),
            "categories": cats,
            "gemv_bw": bw,
            "gemv_aggregate_GBps": round(TOTAL_STREAM_B / gemv_sum_ms / 1e6, 1),
            "attention": att,
            "gdn_ms_per_token": cats.get("GDN", {}).get("ms_per_step"),
            "quant_row_launches_per_token": cats.get("QUANT_ROW_decode", {}).get("calls_per_step"),
            "quant_row_ms_per_token": cats.get("QUANT_ROW_decode", {}).get("ms_per_step"),
            "gap_distribution": agg["gap_distribution"],
            "top_gap_transitions": [
                {**tr, "ms_per_token": round(tr["total_ms"] / agg["clean_steps_used"], 4)}
                for tr in agg["top_gap_transitions"][:12]],
            "gap_before_by_category": {
                c: v.get("gap_before_ms_per_step") for c, v in cats.items()},
            "stall_events_ge5ms_count": len(agg["stall_events_ge5ms"]),
            "stalls_total_ms": agg["stalls_total_ms"],
        }
    res["decode_off"] = dec_off

    # ---- traced decode ON (aggregate) ----
    dec_on = {}
    for ctx in ["1k", "16k", "63k", "128k"]:
        arm = f"T-{ctx}-ON"
        ta = traced_analysis(arm)
        agg = ta["decode"]["aggregate"]
        rec = jload(f"{RAW}/T_{arm}/arm_record.json")
        dec_on[ctx] = {
            "acceptance_rate_traced": rec["acceptance"]["rate"],
            "draft_n": rec["reps"][-1]["draft_n"],
            "draft_n_accepted": rec["reps"][-1]["draft_n_accepted"],
            "generated_tokens": agg["generated_tokens"],
            "avg_span_ms_per_gen_token": agg["avg_span_ms_per_token"],
            "kernel_busy_ms_per_gen_token": agg["kernel_busy_ms_per_generated_token"],
            "categories": agg["categories"],
            "gemv_launches_per_gen_token_by_type": agg["gemv_launches_per_generated_token_by_type"],
            "fa_tile_templates": agg["fa_tile_templates"],
            "draft_q6k_ms_per_gen_token": agg["categories"].get("GEMV_Q6_K", {}).get("ms_per_generated_token"),
        }
    res["decode_on"] = dec_on

    # ---- PP probe phases ----
    pp = {}
    for ctx in CTXS:
        arm = f"T-{ctx}-OFF"
        ta = traced_analysis(arm)
        p = ta["pp_probe_phase"]
        unt_pp = unt[f"U-{ctx}-OFF"]["pp_tok_s_median_fresh"]
        # hipBLAS fallback census: dequantize_block_<t> feeding Cijk kernels
        import csv as _csv
        import re as _re
        from collections import Counter as _Counter
        sys.path.insert(0, f"{P1}/bin")
        from analyze_arm_p1 import load, split_regions
        trows = load(f"{RAW}/T_{arm}/" +
                     [f for f in os.listdir(f"{RAW}/T_{arm}") if f.endswith("_kernel_trace.csv")][0])
        tregs = split_regions(trows)
        probe_rows = [] if len(tregs) < 2 else tregs[-2]
        feeds = _Counter()
        wstaging_ms = 0.0
        for i, r in enumerate(probe_rows):
            if "Cijk" not in r[2]:
                continue
            src = None
            for jx in range(i - 1, max(0, i - 12), -1):
                m = _re.match(r"(?:void )?dequantize_block_(\w+)", probe_rows[jx][2])
                if m:
                    src = m.group(1)
                    break
            feeds[src or "unknown"] += 1
        dd = _Counter()
        dn = _Counter()
        for s, e, nm in probe_rows:
            m = _re.match(r"(?:void )?dequantize_block_(\w+)", nm)
            if m and m.group(1) != "q4_0":  # q4_0 = FA KV staging, counted separately
                dd[m.group(1)] += e - s
                dn[m.group(1)] += 1
        wstaging_ms = {t: round(v / 1e6, 1) for t, v in dd.most_common()}
        pp[ctx] = {
            "prompt_n": ARM_CTX[ctx],
            "kernels": p["kernels"],
            "busy_s": p["busy_s"],
            "span_s": p["span_s"],
            "ms_per_prompt_token_busy": p.get("ms_per_prompt_token_busy"),
            "categories_pct": p["categories_pct"],
            "categories_ms_abs": p["categories_ms_abs"],
            "calls": p["calls"],
            "untraced_pp_tok_s_fresh": unt_pp,
            "hipblas_fallback_feeds": dict(feeds),
            "weight_dequant_to_f16_ms_by_type": wstaging_ms,
        }
    res["prefill_off"] = pp

    # ---- overhead gate ----
    gate = {}
    for ctx in CTXS:
        u = unt[f"U-{ctx}-OFF"]
        t = dec_off[ctx]
        u_ms = u.get("ms_per_token_cached")
        t_ms = t["median_step_wall_ms"]
        gate[f"T-{ctx}-OFF"] = {
            "untraced_ms_per_token_cached": u_ms,
            "untraced_tg_med": u["tg_tok_s_median_all"],
            "traced_step_period_ms": t_ms,
            "traced_server_tg": t["server_tg_tok_s"],
            "overhead_pct_stepperiod": round((t_ms - u_ms) / u_ms * 100, 1),
            "overhead_pct_server": round((u["tg_tok_s_median_all"] - t["server_tg_tok_s"])
                                         / u["tg_tok_s_median_all"] * 100, 1),
        }
    for ctx in ["1k", "16k", "63k", "128k"]:
        u = unt[f"U-{ctx}-ON"]
        u_use = u.get("r2") or u
        u_ms = u_use.get("ms_per_token_cached")
        u_tg = u_use.get("tg_tok_s_median_cached") or u_use.get("tg_tok_s_median_all")
        rec = jload(f"{RAW}/T-{ctx}-ON/resp_main.json".replace("T-", "T_").replace("/resp", "/resp")) \
            if False else jload(f"{RAW}/T_T-{ctx}-ON/resp_main.json")
        tm = rec["body"]["timings"]
        t_tg = tm["predicted_n"] / tm["predicted_ms"] * 1000
        gate[f"T-{ctx}-ON"] = {
            "untraced_ms_per_token_cached": u_ms,
            "untraced_tg_used": round(u_tg, 3),
            "untraced_source": "r2_5rep" if u.get("r2") else "r1",
            "traced_server_tg": round(t_tg, 3),
            "overhead_pct_server": round((u_tg - t_tg) / u_tg * 100, 1),
        }
    res["overhead_gate"] = gate

    # ---- graph evidence (collected from instance logs) ----
    res["graph_evidence"] = {
        "warmup_resets_total_all_instances": 0,
        "off_arms_reused_equals_decode_steps": True,
        "per_instance_last_counters": {
            "T-1k-OFF": 32, "T-16k-OFF": 32, "T-63k-OFF": 32, "T-128k-OFF": 32,
            "T-131k-OFF": 32, "T-1k-ON": 5, "T-16k-ON": 5, "T-63k-ON": 4,
            "T-128k-ON": 5,
        },
        "note": "OFF arms: last 'graphs reused' counter equals generated token "
                "count exactly (32) => every decode step replayed a graph under "
                "rocprofv3. ON arms: counter semantics differ under the "
                "speculative multi-plan flow (values 4-5 recorded); zero warmup "
                "resets everywhere.",
    }

    with open(f"{P1}/phase1_attribution.json", "w") as f:
        json.dump(res, f, indent=1)
    print("WROTE", f"{P1}/phase1_attribution.json")

    # console digest used for the md authoring
    print("\n=== OVERHEAD GATE ===")
    for k, v in gate.items():
        print(k, json.dumps(v))
    print("\n=== DECODE OFF CATEGORY TABLES ===")
    for ctx in CTXS:
        print(f"\n-- {ctx} -- step {dec_off[ctx]['median_step_wall_ms']} ms,"
              f" busy {dec_off[ctx]['kernel_busy_ms_per_token']},"
              f" gaps {dec_off[ctx]['gap_nonstall_ms_per_token']},"
              f" tail {dec_off[ctx]['sampling_tail_ms_median']}")
        for c, v in dec_off[ctx]["categories"].items():
            print(f"   {c:20s} {v['calls_per_step']:8.2f} calls/tok {v['ms_per_step']:9.4f} ms/tok {v['pct_of_busy']:6.2f}%")
    print("\n=== EFFECTIVE BW (decode OFF) ===")
    for ctx in CTXS:
        print(f"-- {ctx} -- aggregate {dec_off[ctx]['gemv_aggregate_GBps']} GB/s")
        for t, v in dec_off[ctx]["gemv_bw"].items():
            print(f"   {t:8s} {str(v['eff_GBps']):>8s} GB/s ({str(v['pct_of_nominal']):>5s}% nom)"
                  f" {v['ms_per_token']:9.4f} ms/tok {v['calls_per_token']:6.1f} launches"
                  f" {'LB' if v['launch_bound'] else ''}")
    print("\n=== ATTENTION ===")
    for ctx in CTXS:
        print(ctx, json.dumps(dec_off[ctx]["attention"]))
    print("\n=== GAP DIST ===")
    for ctx in CTXS:
        print(ctx, json.dumps(dec_off[ctx]["gap_distribution"]))
    print("\n=== TOP TRANSITIONS 16k ===")
    for tr in dec_off["16k"]["top_gap_transitions"]:
        print(f"   {tr['total_ms']:8.3f} ms/tok n={tr['count']:6d} mean={tr['mean_us']:7.2f}us {tr['transition'][:70]}")
    print("\n=== PP ===")
    for ctx in CTXS:
        print(ctx, "busy_s", pp[ctx]["busy_s"], "ms/ptok", pp[ctx]["ms_per_prompt_token_busy"])
        for c, v in list(pp[ctx]["categories_pct"].items())[:10]:
            print(f"   {c:22s} {v:6.2f}%  abs {pp[ctx]['categories_ms_abs'][c]:10.1f} ms")


if __name__ == "__main__":
    main()
