#!/usr/bin/env python3
"""FS-54 D4 at 47: read the ADMM trajectories on record (q = 11, 19, 23 calibration runs from zero; q = 27's early
re-run, pricing and continuation logs; q = 47's lean runs) and print, per plane, when the UPPER reading (1 + <C, Pi_K X>)
first fell below the triple level by a given fraction, and when the climb ended (upper reading first >= 90 % of the
triple level).  Readings, not bounds; the crossing iteration is the first REPORT at or past it (reports are spaced)."""
import json, re, sys
from pathlib import Path

D = Path("data/fs54/d4")
TRIPLE = {11: 29.17680, 19: 85.66507, 23: 108.54667, 27: 147.57744, 47: 371.40910}
SOURCES = {11: [D / "q47/calib-q11-fine.log"], 19: [D / "q47/calib-q19.log"], 23: [D / "q47/calib-q23.log"],
           27: [D / "q47/early-q27-calibration.log", D / "runs/admm-q27-pricing.log", D / "runs/admm-q27-converge.log"],
           47: [D / "q47/solve-q47.log"]}
PAT = re.compile(r"\] it (\d+):.*?upper reading ([\d.]+) lower reading ([\d.]+)")
FRACS = (0.0, 0.0065, 0.01, 0.02, 0.03, 0.04)
out = {}
for q, files in SOURCES.items():
    rows = {}
    for f in files:
        if f.exists():
            for line in f.read_text().splitlines():
                m = PAT.search(line)
                if m:
                    rows[int(m[1])] = (float(m[2]), float(m[3]))
    ks = sorted(rows)
    T = TRIPLE[q]
    rec = dict(reports=len(ks), last_iteration=ks[-1] if ks else None,
               last_upper=rows[ks[-1]][0] if ks else None, last_lower=rows[ks[-1]][1] if ks else None)
    rec["climb_end"] = next((k for k in ks if rows[k][0] >= 0.9 * T), None)
    if rec["climb_end"] is not None:
        # the descent phase starts at the largest upper reading after the climb; a crossing is the first report past it
        kpk = max((k for k in ks if k >= rec["climb_end"]), key=lambda k: rows[k][0])
        rec["peak"] = [kpk, rows[kpk][0]]
        for fr in FRACS:
            rec[f"upper_below_{fr}"] = next((k for k in ks if k >= kpk and rows[k][0] <= T * (1 - fr)), None)
        rec["best_upper_drop_pct"] = 100 * (T - min(rows[k][0] for k in ks if k >= kpk)) / T
    out[q] = rec
    print(q, rec)
if len(sys.argv) > 1:
    Path(sys.argv[1]).write_text(json.dumps(out, indent=1))
