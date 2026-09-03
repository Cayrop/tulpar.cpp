#!/usr/bin/env python3
"""Benchmark campaign: context scaling x MTP mode, with per-run spec stats."""
import json, os, sys, time, subprocess, threading
sys.path.insert(0, os.path.dirname(__file__))
from bench import make_text, run_one, summarize, metrics

EXPDIR = os.path.join(os.path.dirname(__file__), "..", "experiments")
os.makedirs(EXPDIR, exist_ok=True)
NPRED = 128

clock_stop = threading.Event()
def clock_logger(path):
    with open(path, "w") as f:
        f.write("ts,sclk_mhz,mclk_mhz,power_w,temp_c,use_pct,vram_used\n")
        while not clock_stop.is_set():
            try:
                out = subprocess.run(["rocm-smi","--showclocks","--showpower","--showtemp",
                                      "--showuse","--showmeminfo","vram"],
                                     capture_output=True, text=True, timeout=10).stdout
                import re
                sclk=re.search(r"sclk clock level: \w+: \((\d+)Mhz\)",out)
                mclk=re.search(r"mclk clock level: \d+: \((\d+)Mhz\)",out)
                pw=re.search(r"Power \(W\): ([\d.]+)",out)
                tp=re.search(r"Sensor edge\) \(C\): ([\d.]+)",out)
                us=re.search(r"GPU use \(%\): (\d+)",out)
                vr=re.search(r"VRAM Total Used Memory \(B\): (\d+)",out)
                f.write(f"{time.time():.0f},{sclk.group(1) if sclk else ''},{mclk.group(1) if mclk else ''},"
                        f"{pw.group(1) if pw else ''},{tp.group(1) if tp else ''},"
                        f"{us.group(1) if us else ''},{vr.group(1) if vr else ''}\n")
                f.flush()
            except Exception as e:
                f.write(f"{time.time():.0f},ERR,{e}\n"); f.flush()
            time.sleep(3)

def spec_delta(m_before, m_after):
    d={}
    for k in ("spec_decode_num_draft_tokens_total","spec_decode_num_accepted_tokens_total",
              "spec_decode_num_drafts_total","tokens_predicted_total"):
        d[k]=m_after.get(k,0)-m_before.get(k,0)
    drafts=d.get("spec_decode_num_drafts_total",0)
    if drafts>0:
        d["acc_per_round"]=d["spec_decode_num_accepted_tokens_total"]/drafts
        d["draft_per_round"]=d["spec_decode_num_draft_tokens_total"]/drafts
        d["tok_per_round"]=d["tokens_predicted_total"]/drafts
    return d

def main():
    tlog = os.path.join(EXPDIR, "gpu_clocks.csv")
    th = threading.Thread(target=clock_logger, args=(tlog,), daemon=True); th.start()

    results=[]
    # warmup both modes (graph rebuild after type switch)
    print("== warmup ON ==", flush=True)
    run_one("Warmup request alpha.", 24, spec_type="draft-mtp", seed=1234, tag="warmup_on")
    print("== warmup OFF ==", flush=True)
    run_one("Warmup request beta.", 24, spec_type="none", seed=1234, tag="warmup_off")
    # restore ON state
    run_one("Warmup restore.", 8, spec_type="draft-mtp", seed=1234, tag="warmup_restore")

    ctx_targets=[1024,4096,8192,16384,32768,49152,65536]
    prompts={}
    for i,c in enumerate(ctx_targets):
        prompts[c]=make_text(c-64, seed=9000+i)

    for c in ctx_targets:
        ck=f"{c//1024}k"
        # run 1: full re-prefill (unique-ish content already, cache_prompt False)
        exp=f"ctx_{ck}_mtp_on_run_1"
        mb=metrics()
        r=run_one(prompts[c], NPRED, spec_type="draft-mtp", seed=555+c, cache_prompt=False,
                  tag=exp); ma=metrics()
        r["exp_id"]=exp; r["ctx_target"]=c; r["spec_delta"]=spec_delta(mb,ma)
        results.append(r); print(json.dumps({k:r[k] for k in ("exp_id","prompt_n","prompt_ms",
              "prefill_tok_s","predicted_n","predicted_ms","decode_tok_s")}), flush=True)
        # runs 2-4: cached prefix -> decode-only
        for run in range(2,5):
            exp=f"ctx_{ck}_mtp_on_run_{run}"
            mb=metrics()
            r=run_one(prompts[c], NPRED, spec_type="draft-mtp", seed=777+c*10+run,
                      cache_prompt=True, tag=exp); ma=metrics()
            r["exp_id"]=exp; r["ctx_target"]=c; r["spec_delta"]=spec_delta(mb,ma)
            results.append(r); print(json.dumps({k:r[k] for k in ("exp_id","prompt_n",
                  "predicted_n","predicted_ms","decode_tok_s")}), flush=True)

    # MTP OFF comparison at 1k, 16k, 65k using cached prefixes
    for c in [1024,16384,65536]:
        ck=f"{c//1024}k"
        # one uncached sanity run is unnecessary; prefix already cached from ON phase
        for run in range(1,4):
            exp=f"ctx_{ck}_mtp_off_run_{run}"
            mb=metrics()
            r=run_one(prompts[c], NPRED, spec_type="none", seed=888+c+run,
                      cache_prompt=True, tag=exp); ma=metrics()
            r["exp_id"]=exp; r["ctx_target"]=c; r["spec_delta"]=spec_delta(mb,ma)
            results.append(r); print(json.dumps({k:r[k] for k in ("exp_id","prompt_n",
                  "predicted_n","predicted_ms","decode_tok_s")}), flush=True)
        # leave server back in ON default state
        run_one("restore mtp on", 8, spec_type="draft-mtp", seed=99, tag="restore_on")

    clock_stop.set(); time.sleep(0.5)
    with open(os.path.join(EXPDIR,"campaign_results.json"),"w") as f:
        json.dump(results,f,indent=1)
    print("\n=== SUMMARY ===")
    by={}
    for r in results:
        key=r["tag"].rsplit("_run_",1)[0]
        by.setdefault(key,[]).append(r)
    for key,rs in sorted(by.items()):
        s=summarize(rs)
        acc=[x["spec_delta"].get("acc_per_round") for x in rs if x.get("spec_delta")]
        dr=[x["spec_delta"].get("tok_per_round") for x in rs if x.get("spec_delta")]
        acc=[a for a in acc if a]; dr=[d for d in dr if d]
        print(key, json.dumps(s), "acc/round:",
              round(sum(acc)/len(acc),3) if acc else None,
              "tok/round:", round(sum(dr)/len(dr),3) if dr else None)

if __name__=="__main__":
    main()
