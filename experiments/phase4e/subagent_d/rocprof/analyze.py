#!/usr/bin/env python3
"""Compute stall metrics from rocprofv3 CSV output."""

import csv
import os
import sys
import json
from collections import defaultdict
import statistics


def load_csv(path):
    rows_per_dispatch = defaultdict(dict)
    with open(path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            cid = row['Correlation_Id']
            counter = row['Counter_Name']
            value = float(row['Counter_Value'])
            rows_per_dispatch[cid][counter] = value
    return rows_per_dispatch


def compute_stall_metrics(rows):
    issue_wait = []
    dep_wait = []
    for cid, c in rows.items():
        wc = c.get('SQ_WAVE_CYCLES', 0)
        if wc == 0:
            continue
        issue_wait.append(100.0 * c.get('SQ_WAIT_INST_ANY', 0) / wc)
        dep_wait.append(100.0 * c.get('SQ_WAIT_ANY', 0) / wc)
    if not issue_wait:
        return None
    return {
        'wave_issue_wait_pct': statistics.median(issue_wait),
        'wave_dep_wait_pct': statistics.median(dep_wait),
        'wave_issue_wait_p10': statistics.quantiles(issue_wait, n=10)[0] if len(issue_wait) > 1 else issue_wait[0],
        'wave_issue_wait_p90': statistics.quantiles(issue_wait, n=10)[8] if len(issue_wait) > 1 else issue_wait[0],
        'wave_dep_wait_p10': statistics.quantiles(dep_wait, n=10)[0] if len(dep_wait) > 1 else dep_wait[0],
        'wave_dep_wait_p90': statistics.quantiles(dep_wait, n=10)[8] if len(dep_wait) > 1 else dep_wait[0],
        'wave_cycles': statistics.median([c.get('SQ_WAVE_CYCLES', 0) for c in rows.values()]),
        'wait_inst_any': statistics.median([c.get('SQ_WAIT_INST_ANY', 0) for c in rows.values()]),
        'wait_any': statistics.median([c.get('SQ_WAIT_ANY', 0) for c in rows.values()]),
        'n_dispatches': len(rows),
    }


def main():
    outdir = sys.argv[1] if len(sys.argv) > 1 else 'rocprof/pmc_1'
    results = {}
    for fname in sorted(os.listdir(outdir)):
        if not fname.endswith('_counter_collection.csv'):
            continue
        if not fname.startswith(('V0_', 'D1_', 'D2_', 'D3_')):
            continue
        label = fname.replace('_counter_collection.csv', '')
        path = os.path.join(outdir, fname)
        rows = load_csv(path)
        metrics = compute_stall_metrics(rows)
        if metrics:
            results[label] = metrics
            print(f"{label}:")
            for k, v in metrics.items():
                if isinstance(v, float):
                    print(f"  {k}: {v:.3f}")
                else:
                    print(f"  {k}: {v}")
    # Save JSON
    with open(os.path.join(outdir, '..', 'stall_results.json'), 'w') as f:
        json.dump(results, f, indent=2)
    return results


if __name__ == '__main__':
    main()
