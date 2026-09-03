#!/usr/bin/env python3
# Record semantic smoke heads + determinism self-check for the V3 stored baseline.
import json, sys, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "results"))
sys.path.insert(0, str(ROOT / "results2"))
from bench import make_text, post
from correctness_suite import gen, semantic_suite, compare_tokens

out_path = sys.argv[1]
mtp_label = sys.argv[2]  # "on" | "off"

p1k = make_text(960, seed=4242)
g1 = gen(p1k, 96)
g2 = gen(p1k, 96, cache=True)
rec = {
    "ts": time.strftime("%F %T"),
    "mtp": mtp_label,
    "server_base": "http://localhost:8080",
    "semantic_smoke": semantic_suite(),
    "determinism_self_1k_seed4242": compare_tokens(g1, g2),
    "gen_1k_head": g1["text"][:200],
}
json.dump(rec, open(out_path, "w"), indent=1)
ok = sum(1 for x in rec["semantic_smoke"] if x["pass"])
print(json.dumps({"smoke_pass": ok, "smoke_total": len(rec["semantic_smoke"]),
                  "det_self_identical": rec["determinism_self_1k_seed4242"]["identical"],
                  "det_mode": rec["determinism_self_1k_seed4242"]["mode"]}))
