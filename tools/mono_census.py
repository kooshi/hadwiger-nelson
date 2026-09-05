#!/usr/bin/env python3
"""mono_census — how many pairs of a K-point object sit at the distances the residue colouring makes
MONOCHROMATIC (squared distance of positive 𝔭-adic valuation at both primes above 2), per exact class;
the denominator of the rigidity dial (Q10): the four-colour forced-equal sweep's count over the same
class is the numerator. Float screen, exact K verification.

    python3 tools/mono_census.py --object <label> [--classes 4,16,12,4/3,16/3,64/9,64/3]
"""
from __future__ import annotations
import argparse, json, sys, time
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True)
    ap.add_argument("--classes", default="4,16,12,4/3,16/3,64/9,64/3,1,3,1/3,25")
    a = ap.parse_args()
    import batchkill as BK
    from pool_field_restrict import exact_points
    from copy_exact_field import K
    from residue_colouring import sqrt33_2adic
    from wall_break_test import q2_val_unit
    obj, _ = BK.load_object(a.object); pts = exact_points(a.object)
    live = sorted(pts); P = np.array([obj.pts[i] for i in live]); n = len(live)
    S = sqrt33_2adic(17)
    targets = [Fr(c) for c in a.classes.split(",")]
    out = {}
    t0 = time.time()
    from scipy.spatial import cKDTree
    tree = cKDTree(P)
    for tq in targets:
        d = float(tq) ** 0.5
        cand = tree.query_pairs(d + 1e-6) - tree.query_pairs(max(d - 1e-6, 0.0))
        exact = 0
        for i, j in cand:
            u, v = live[i], live[j]
            dx, dy = pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]
            d2 = dx * dx + dy * dy
            if d2 == K(tq):
                exact += 1
        # the 2-adic valuation of the class at both primes (a rational class: both embeddings equal)
        v, _ = q2_val_unit(tq)
        out[str(tq)] = {"pairs_exact": exact, "candidates": len(cand), "v2": v, "mono_under_residue": v > 0}
        print(f"[mono] d² = {tq}: {exact:,} exact pairs (screen {len(cand):,}); v₂ = {v} → {'MONO' if v > 0 else 'distinct'} under the residue colouring", flush=True)
    print(f"[mono] {n} live points, {time.time()-t0:.0f}s")
    Path("build/m54") .mkdir(exist_ok=True)
    Path(f"build/m54/mono-census-{a.object}.json").write_text(json.dumps({"kind": "mono-census", "object": a.object, "classes": out}, indent=1))


if __name__ == "__main__":
    main()
