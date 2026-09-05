#!/usr/bin/env python3
"""wall_pool — export the depth-one pool restricted to the WALL-BREAKING glue points (the parent
pair's radicand r has −r a square in ℚ₂(√3) at both 2-adic primes; `tools/wall_break_test.py`),
named `depth1-wallfield`, and optionally the `depth1-partnerfield` pool (breakers ∪ every radicand
whose class is nontrivial at some prime — the material that can break the wall in combination).

    python3 tools/wall_pool.py --object <label> --base build/m51-pool-<fp>-depth1 [--partner]

Reuses `pool_field_restrict.restrict` (the export machinery) with a class map computed here.
"""
from __future__ import annotations
import argparse, json, sys, time
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
ROOT = Path(__file__).resolve().parent.parent


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", required=True); ap.add_argument("--base", required=True)
    ap.add_argument("--partner", action="store_true")
    a = ap.parse_args()
    t0 = time.time()
    import batchkill as BK, pool_field_restrict as PFR
    from copy_exact_field import K
    from pool_field_census import k_inv
    obj, _ = BK.load_object(a.object); PFR._LABEL[id(obj)] = a.object
    pts = PFR.exact_points(a.object); pairs = PFR.object_pairs(obj)
    wb = json.loads((ROOT / "data" / "m53" / "wallbreak-it4.json").read_text())
    assert wb["object"] == a.object
    cls_of = {}
    for row in wb["table"]:
        key = tuple(__import__("fractions").Fraction(n, d) for n, d in row["radicand"])
        cls_of[key] = ("wall" if row["breaks_alone"] else ("partner" if any(b != 0 for b in row["bits"]) and not row["in_field"] else "other"))
    four, one = K(4), K(1)
    cls = {}
    for u, v in pairs:
        dx, dy = pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]
        r = four * k_inv(dx * dx + dy * dy) - one
        cls[(u, v)] = cls_of[r.c]
    cnt = {c: sum(1 for x in cls.values() if x == c) for c in ("wall", "partner", "other")}
    print(f"[wallpool] pairs by class: {cnt} [{time.time()-t0:.0f}s]", flush=True)
    meta = {"classifier": "tools/wall_break_test.py", "census": "data/m53/wallbreak-it4.json",
            "rule": "wall = -r a square in Q2(sqrt3) at both 2-adic primes; partner = a nontrivial 2-adic class at some prime, out-of-field"}
    PFR.restrict(Path(a.base), obj, cls, "wall", meta)
    if a.partner:
        cls2 = {k: ("partner" if v in ("wall", "partner") else "other") for k, v in cls.items()}
        PFR.restrict(Path(a.base), obj, cls2, "partner", meta)


if __name__ == "__main__":
    main()
