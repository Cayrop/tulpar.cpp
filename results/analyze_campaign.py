#!/usr/bin/env python3
"""Analyze campaign results: variance, acceptance correlation."""
import json, sys, csv
import statistics
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def load(paths):
    recs=[]
    for p in paths:
        recs += json.load(open(p))
    return recs

def main():
    import glob
    paths = sorted(glob.glob(str(ROOT / "results/experiments/campaign*_results.json")))
    recs = load(paths)
    print(f"{'exp_id':34s} {'ctx':>6s} {'dec_t/s':>8s} {'acc/rd':>7s} {'dft/rd':>7s} {'tok/rd':>7s}")
    rows=[]
    for r in recs:
        d = r.get("spec_delta") or {}
        acc=d.get("acc_per_round"); drf=d.get("draft_per_round"); tk=d.get("tok_per_round")
        dec=r.get("decode_tok_s")
        if not dec: continue
        ctx=r.get("prompt_tokens_actual") or r.get("ctx_target") or r.get("prompt_n")
        print(f"{r['exp_id']:34s} {str(ctx):>6s} {dec:8.2f} "
              f"{('%0.2f'%acc) if acc else '-':>7s} {('%0.2f'%drf) if drf else '-':>7s} {('%0.2f'%tk) if tk else '-':>7s}")
        rows.append((r["exp_id"], ctx, dec, acc, drf, tk))
    # correlate decode speed vs tokens-per-round across ALL runs
    xs=[tk for _,_,_,_,_,tk in rows if tk]; ys=[dec for _,_,dec,_,_,tk in rows if tk]
    if len(xs)>3:
        mx,my=statistics.mean(xs),statistics.mean(ys)
        cov=sum((x-mx)*(y-my) for x,y in zip(xs,ys))
        sx=(sum((x-mx)**2 for x in xs))**.5; sy=(sum((y-my)**2 for y in ys))**.5
        print(f"\nPearson r (tok/round vs decode_tok_s), n={len(xs)}: {cov/(sx*sy):+.3f}")
    xs=[a for _,_,_,a,_,_ in rows if a]; ys=[dec for _,_,dec,a,_,_ in rows if a]
    if len(xs)>3:
        mx,my=statistics.mean(xs),statistics.mean(ys)
        cov=sum((x-mx)*(y-my) for x,y in zip(xs,ys))
        sx=(sum((x-mx)**2 for x in xs))**.5; sy=(sum((y-my)**2 for y in ys))**.5
        print(f"Pearson r (acc/round  vs decode_tok_s), n={len(xs)}: {cov/(sx*sy):+.3f}")

if __name__=="__main__":
    main()
