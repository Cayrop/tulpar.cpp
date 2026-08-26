#!/usr/bin/env python3
"""rocprofv3 trace analyzer: kernel shares, phase segmentation, gap analysis."""
import csv, sys, statistics, json, re
from collections import defaultdict

def classify(name):
    n = name.lower()
    if "vecdot" in n or "vec_dot" in n: return "mmvq_vecdot"
    if "mul_mat_vec" in n or "mul_mat_vec_q" in n: return "mmvq"
    if "quantize_row" in n or "quantize" in n: return "quantize_act"
    if "flash_attn" in n or "fattn" in n: return "flash_attn"
    if "rms_norm" in n: return "rms_norm"
    if "rope" in n: return "rope"
    if "soft_max" in n or "softmax" in n: return "softmax"
    if "set_rows" in n: return "kv_write_setrows"
    if "gemm" in n or "wgmma" in n or "wmma" in n or "mma" in n: return "gemm_mma"
    if "mul_mat" in n: return "mulmat_other"
    if "ssm" in n or "conv" in n or "delta" in n or "rwkv" in n: return "ssm_gdn"
    if "argsort" in n or "topk" in n or "top_k" in n or "sample" in n or "argmax" in n: return "sampling"
    if "add" in n and "rms" not in n: return "elementwise_add"
    if "mul" in n and "mat" not in n: return "elementwise_mul"
    if "glu" in n or "silu" in n: return "glu_silu"
    if "cpy" in n or "copy" in n or "cont" in n or "cast" in n or "convert" in n or "to_fp" in n or "_f32" in n and "acc" in n: return "copy_cast"
    if "sum_rows" in n or "sum" in n: return "reduce"
    if "norm" in n: return "other_norm"
    if "hadamard" in n or "hadacore" in n: return "hadamard"
    if "diag" in n or "mask" in n: return "mask_misc"
    if "get_rows" in n: return "get_rows"
    if "dup" in n or "concat" in n or "view" in n or "reshape" in n: return "view_dup"
    if "saxpy" in n or "elementwise" in n: return "elementwise"
    return "unclassified"

def analyze(kernel_csv, out_prefix, gap_thresh_us=20000):
    agg = defaultdict(lambda: {"n":0,"tot":0.0,"durs":[], "grids":set()})
    rows_all = 0
    timeline = []  # (start_us, end_us) relative to t0
    t0 = None
    with open(kernel_csv, newline="") as f:
        rd = csv.DictReader(f)
        key_name = [c for c in rd.fieldnames if "Kernel_Name" in c or "Kernel Name" in c][0]
        for r in rd:
            try:
                s = int(r["Start_Timestamp"]); e = int(r["End_Timestamp"])
            except (KeyError, ValueError):
                continue
            nm = r[key_name].strip('"')
            d_us = (e - s) / 1e3
            if t0 is None: t0 = s
            rs = (s - t0)/1e3; re_ = (e - t0)/1e3
            a = agg[nm]
            a["n"] += 1; a["tot"] += d_us; a["durs"].append(d_us)
            a["grids"].add((r.get("Grid_Size_X",""),r.get("Grid_Size_Y",""),r.get("Grid_Size_Z","")))
            timeline.append((rs, re_))
            rows_all += 1
    total_gpu_us = sum(e-s for s,e in timeline)
    span_us = (timeline[-1][1] - timeline[0][0]) if timeline else 0
    # phase segmentation on gaps
    phases = []
    cur_start = timeline[0][0]; prev_end = timeline[0][1]; cur_n=1
    for s,e in timeline[1:]:
        if s - prev_end > gap_thresh_us:
            phases.append([cur_start, prev_end, cur_n])
            cur_start = s; cur_n = 0
        prev_end = e; cur_n += 1
    phases.append([cur_start, prev_end, cur_n])
    # per-phase aggregation
    def phase_of(ts):
        for i,(ps,pe,pn) in enumerate(phases):
            if ps <= ts <= pe: return i
        return -1
    ph_agg = [defaultdict(float) for _ in phases]
    ph_tot = [0.0 for _ in phases]
    idx = 0
    with open(kernel_csv, newline="") as f:  # second pass (streaming, cheap)
        pass
    # instead of second pass over file, use stored timeline only for busy/gap stats;
    # per-phase kernel detail requires names -> do lightweight second pass
    ph_kernel = defaultdict(lambda: defaultdict(lambda: [0,0.0]))
    with open(kernel_csv, newline="") as f:
        rd = csv.DictReader(f)
        key_name = [c for c in rd.fieldnames if "Kernel_Name" in c or "Kernel Name" in c][0]
        for r in rd:
            try: s=int(r["Start_Timestamp"])
            except: continue
            rs=(s-t0)/1e3
            pi=phase_of(rs)
            if pi<0: continue
            d=(int(r["End_Timestamp"])-s)/1e3
            nm=r[key_name].strip('"')
            ph_kernel[pi][nm][0]+=1; ph_kernel[pi][nm][1]+=d
            ph_tot[pi]+=d
    report = {
        "file": kernel_csv, "kernel_rows": rows_all,
        "unique_kernels": len(agg),
        "total_gpu_time_s": total_gpu_us/1e6,
        "wall_span_s": span_us/1e6,
        "gpu_busy_pct": 100*total_gpu_us/span_us if span_us else 0,
        "n_phases": len(phases),
        "phases": [{"i":i,"start_s":p[0]/1e6,"end_s":p[1]/1e6,"dur_s":(p[1]-p[0])/1e6,
                    "n_kernels":p[2],"gpu_time_s":ph_tot[i]/1e6} for i,p in enumerate(phases)],
    }
    # global top kernels
    top=[]
    grand=sum(a["tot"] for a in agg.values())
    for nm,a in sorted(agg.items(), key=lambda kv:-kv[1]["tot"])[:40]:
        d=a["durs"]
        top.append({"name":nm[:120],"cat":classify(nm),"n":a["n"],
                    "total_ms":round(a["tot"]/1e3,2),
                    "share_pct":round(100*a["tot"]/grand,2),
                    "mean_us":round(a["tot"]/a["n"],2),
                    "median_us":round(statistics.median(d),2),
                    "max_us":round(max(d),2)})
    report["top_kernels"]=top
    cat_tot=defaultdict(float); cat_n=defaultdict(int)
    for nm,a in agg.items():
        c=classify(nm); cat_tot[c]+=a["tot"]; cat_n[c]+=a["n"]
    report["categories"]={c:{"total_ms":round(t/1e3,2),"share_pct":round(100*t/grand,2),"n":cat_n[c]}
                          for c,t in sorted(cat_tot.items(),key=lambda kv:-kv[1])}
    # top kernels per significant phase (phases with gpu_time > 1s)
    sig=[i for i in range(len(phases)) if ph_tot[i]>1e6]
    report["phase_top"]={}
    for i in sig:
        tot=ph_tot[i]
        tops=[]
        for nm,(n,d) in sorted(ph_kernel[i].items(), key=lambda kv:-kv[1][1])[:15]:
            tops.append({"name":nm[:110],"n":n,"total_ms":round(d/1e3,2),
                         "share_pct":round(100*d/tot,2),"mean_us":round(d/n,2)})
        report["phase_top"][i]={"dur_s":round(phases[i][0]/1e6,2),"tops":tops}
    with open(f"{out_prefix}_kernel_report.json","w") as f:
        json.dump(report,f,indent=1)
    print(f"== {kernel_csv}")
    print(f"rows={rows_all} unique={len(agg)} gpu_busy={report['gpu_busy_pct']:.1f}% "
          f"span={report['wall_span_s']:.1f}s phases={len(phases)}")
    print("TOP CATEGORIES:")
    for c,v in list(report["categories"].items())[:14]:
        print(f"  {c:18s} {v['total_ms']:10.1f}ms {v['share_pct']:5.2f}% n={v['n']}")
    return report

if __name__=="__main__":
    analyze(sys.argv[1], sys.argv[2])
