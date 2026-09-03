#!/usr/bin/env python3
"""Window-focused trace analysis: top kernels within [t0,t1] seconds."""
import csv, sys, json, statistics
from collections import defaultdict

def main(csvf, t0_s, t1_s, out):
    agg=defaultdict(lambda:[0,0.0,[]])
    grids={}
    with open(csvf,newline="") as f:
        rd=csv.DictReader(f)
        kn=[c for c in rd.fieldnames if "Kernel_Name" in c][0]
        t_base=None
        for r in rd:
            s=int(r["Start_Timestamp"]); e=int(r["End_Timestamp"])
            if t_base is None: t_base=s
            ts=(s-t_base)/1e9
            if ts<t0_s or ts>t1_s: continue
            n=r[kn].strip('"')
            d=(e-s)/1e3
            a=agg[n]; a[0]+=1; a[1]+=d; a[2].append(d)
            grids[n]=(r.get("Grid_Size_X"),r.get("Grid_Size_Y"),r.get("Grid_Size_Z"),
                      r.get("Workgroup_Size_X"))
    tot=sum(a[1] for a in agg.values())
    span=t1_s-t0_s
    busy=sum(sum(e-s for s,e in zip([x],[x]))for x in [])  # placeholder
    print(f"== window [{t0_s},{t1_s}]s total_gpu={tot/1e3:.2f}s")
    res=[]
    for n,a in sorted(agg.items(), key=lambda kv:-kv[1][1])[:25]:
        med=statistics.median(a[2]) if len(a[2])>3 else a[2][0]
        print(f"{100*a[1]/tot:5.2f}% n={a[0]:6d} tot={a[1]/1e3:8.3f}s mean={a[1]/a[0]:8.1f}us med={med:8.1f}us grid={grids.get(n)} {n[:95]}")
        res.append({"name":n[:150],"n":a[0],"total_ms":a[1]/1e3,"share":100*a[1]/tot,
                    "mean_us":a[1]/a[0],"median_us":med,"grid":grids.get(n)})
    json.dump(res, open(out,"w"), indent=1)

if __name__=="__main__":
    main(sys.argv[1], float(sys.argv[2]), float(sys.argv[3]), sys.argv[4])
