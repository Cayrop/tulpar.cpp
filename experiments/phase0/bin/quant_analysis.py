import json, sys
from collections import defaultdict
from gguf import GGUFReader
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]

path = "/home/gencer/models/qwen38/Qwen3.8-27B-UD-Q2_K_XL.gguf"
r = GGUFReader(path)

meta = {}
for k in r.fields.values():
    try:
        v = k.contents()
        if isinstance(v, list) and len(v) > 8:
            v = v[:4] + ["..."]
        meta[k.name] = v
    except Exception as e:
        meta[k.name] = f"<unreadable: {e}>"

tensors = []
for t in r.tensors:
    tensors.append({
        "name": t.name,
        "type": t.tensor_type.name,
        "n_bytes": int(t.n_bytes),
        "shape": [int(x) for x in t.shape],
        "n_elems": int(t.n_elements),
    })

total_bytes = sum(t["n_bytes"] for t in tensors)

# category assignment
def cat(name):
    if name == "token_embd.weight": return "token_embd"
    if name == "output.weight": return "output_head"
    if name == "output_norm.weight": return "norm_final"
    if ".ffn_gate." in name: return "ffn_gate"
    if ".ffn_up." in name: return "ffn_up"
    if ".ffn_down." in name: return "ffn_down"
    if ".attn_qkv." in name or name.endswith(".attn_q.weight") or name.endswith(".attn_k.weight") or name.endswith(".attn_v.weight"): return "attention_qkv"
    if ".attn_gate." in name: return "attention_gate"
    if ".attn_output." in name: return "attention_output"
    if ".ssm_out." in name: return "gdn_ssm_out"
    if ".ssm_conv." in name: return "gdn_ssm_conv"
    if ".ssm_" in name: return "gdn_ssm_other"
    if "nextn" in name or ".blk.64" in name or "blk.64" in name: return "nextn_blk64"
    if ".ffn_gate_inp." in name or ".exp_probs_b." in name: return "moe_router"
    if "norm" in name or ".bias" in name: return "norm_misc"
    return "other"

by_cat = defaultdict(lambda: {"bytes": 0, "count": 0})
for t in tensors:
    c = cat(t["name"])
    by_cat[c]["bytes"] += t["n_bytes"]
    by_cat[c]["count"] += 1

# weight stream per decode step, MTP OFF:
# - exclude token_embd (get_rows only)
# - exclude blk.64 / nextn (draft block unused when MTP OFF)
stream = [t for t in tensors if cat(t["name"]) not in ("token_embd",) and "blk.64" not in t["name"]]
stream_total = sum(t["n_bytes"] for t in stream)
by_type_stream = defaultdict(int)
for t in stream:
    by_type_stream[t["type"]] += t["n_bytes"]

out = {
    "model_file": path.split("/")[-1],
    "sha256": open(str(ROOT / "experiments/phase0/env/model_sha256.txt")).read().split()[0],
    "file_size_bytes": total_bytes,
    "file_size_gb_dec": round(total_bytes / 1e9, 3),
    "tensor_count": len(tensors),
    "quant_types_all_tensors": {},
    "categories": {c: v for c, v in sorted(by_cat.items())},
    "weight_stream_per_decode_step_mtp_off": {
        "total_bytes": stream_total,
        "total_gib": round(stream_total / 2**30, 4),
        "by_type": dict(sorted(by_type_stream.items(), key=lambda kv: -kv[1])),
        "excluded": ["token_embd (get_rows)", "blk.64 nextn tensors (unused MTP OFF)"],
    },
}
qt = defaultdict(lambda: {"bytes": 0, "count": 0, "layers": []})
for t in tensors:
    q = qt[t["type"]]
    q["bytes"] += t["n_bytes"]
    q["count"] += 1
out["quant_types_all_tensors"] = {k: {"bytes": v["bytes"], "count": v["count"]} for k, v in sorted(qt.items(), key=lambda kv: -kv[1]["bytes"])}

json.dump({"summary": out, "meta": meta,
           "tensors": tensors},
          open(str(ROOT / "experiments/phase0/env/gguf_dump_full.json"), "w"), indent=1)
print(json.dumps(out, indent=1))
