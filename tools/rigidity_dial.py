#!/usr/bin/env python3
"""rigidity_dial — the four-colour forced-equal sweep of a K-point object's UNIT PART, joined to the
exact distance classes: for each class of positive 2-adic valuation (monochromatic under the residue
colouring) the fraction of pairs already forced equal in every proper 4-colouring of the finite
object — the rigidity dial of Q10 (`plans/STANDING-QUESTIONS.md`). Complete sweep (`rigidity.Rigidity`,
M30's lattice: every pair observed both ways or settled by a batch query); exact K distances.

    python3 tools/rigidity_dial.py --object <label> [--cap 600] [--result build/m54/rigidity-dial-<label>.json]
"""
from __future__ import annotations
import argparse, json, sys, time
from collections import defaultdict
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--cap", type=float, default=600.0)
    ap.add_argument("--result", default=None)
    a = ap.parse_args()
    import batchkill as BK, rigidity
    from pool_field_restrict import exact_points
    from wall_break_test import q2_val_unit
    t0 = time.time()
    obj, _ = BK.load_object(a.object); pts = exact_points(a.object)
    live = sorted(pts); idx = {v: i for i, v in enumerate(live)}
    ue = [(idx[u], idx[v]) for u, v in obj.unit_edges()]
    print(f"[dial] {a.object}: {len(live)} live points, {len(ue)} unit edges; sweeping forced-equal pairs at k = 4 …", flush=True)
    R = rigidity.Rigidity(len(live), ue, 4, timeout=a.cap)
    R.run()
    print(f"[dial] sweep status {R.status}: eq_confirmed {len(R.eq_confirmed)}, eq_unsettled {len(R.eq_unsettled)}, "
          f"ne_confirmed {len(R.ne_confirmed)}, ne_unsettled {len(R.ne_unsettled)}, calls {R.calls} [{time.time()-t0:.0f}s]", flush=True)
    def d2_of(u, v):
        dx, dy = pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]
        return (dx * dx + dy * dy)
    def key(k):
        c = k.c
        return "+".join(f"{str(x)}{s}" for x, s in zip(c, ("", "√3", "√11", "√33")) if x != 0) or "0"
    forced = defaultdict(int); unsettled = defaultdict(int); forced_pairs = []
    for i, j in R.eq_confirmed:
        d2 = d2_of(live[i], live[j]); forced[key(d2)] += 1; forced_pairs.append([live[i], live[j], key(d2)])
    for i, j in R.eq_unsettled:
        unsettled[key(d2_of(live[i], live[j]))] += 1
    # class totals for every class that appears among forced/unsettled pairs, plus the named mono classes
    named = [Fr(4), Fr(16), Fr(12), Fr(4, 3), Fr(16, 3), Fr(64, 9), Fr(64, 3)]
    from copy_exact_field import K
    want = set(forced) | set(unsettled) | {key(K(q)) for q in named}
    totals = defaultdict(int)
    import numpy as np
    from scipy.spatial import cKDTree
    P = np.array([obj.pts[v] for v in live]); tree = cKDTree(P)
    # float screen per wanted class value
    vals = {}
    for k in want:
        # recover the K value from a forced pair or the named list
        pass
    for q in named:
        vals[key(K(q))] = K(q)
    for u, v, k in forced_pairs:
        if k not in vals:
            vals[k] = d2_of(u, v)
    for k, kv in vals.items():
        d = float(kv.mp()) ** 0.5 if hasattr(kv, "mp") else None
        import mpmath as mp
        mp.mp.dps = 30
        d = float(mp.sqrt(kv.mp()))
        cand = tree.query_pairs(d + 1e-6) - tree.query_pairs(max(d - 1e-6, 0.0))
        totals[k] = sum(1 for i, j in cand if d2_of(live[i], live[j]) == kv)
    rows = []
    for k in sorted(vals, key=lambda k: -totals[k]):
        kv = vals[k]
        rat = kv.c[0] if all(x == 0 for x in kv.c[1:]) else None
        v2 = q2_val_unit(rat)[0] if rat not in (None, 0) else None
        rows.append({"d2": k, "v2": v2, "pairs": totals[k], "forced_equal": forced[k], "unsettled": unsettled[k],
                     "fraction": (forced[k] / totals[k]) if totals[k] else None})
        print(f"[dial] d² = {k:>14}  v₂ = {str(v2):>4}  pairs {totals[k]:>6,}  forced {forced[k]:>5,}  unsettled {unsettled[k]:>4}  → {100*forced[k]/totals[k] if totals[k] else 0:5.1f} %")
    out = {"kind": "rigidity-dial", "object": a.object, "k": 4, "status": R.status, "calls": R.calls,
           "eq_confirmed": len(R.eq_confirmed), "eq_unsettled": len(R.eq_unsettled), "ne_confirmed": len(R.ne_confirmed),
           "ne_unsettled": len(R.ne_unsettled), "classes": rows, "forced_pairs": forced_pairs, "seconds": round(time.time() - t0, 1),
           "claim_scope": "complete forced-equal sweep of the unit part at four colours (Rigidity lattice); classes by exact squared distance in K; v2 = 2-adic valuation of a rational class"}
    if a.result:
        Path(a.result).write_text(json.dumps(out, indent=1)); print(f"[dial] wrote {a.result}")


if __name__ == "__main__":
    main()
