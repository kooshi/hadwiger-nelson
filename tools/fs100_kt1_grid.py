#!/usr/bin/env python3
"""J49 (FS-100 KT-1), part 1 of 2: export J26's H4 covering grid and exact data for the ball-arithmetic checker.

Runs under the SYSTEM python3 (it needs numpy, scipy, sympy, mpmath, which build/venv-flint lacks). It imports
tools/j26_ambrus_check.py READ-ONLY and rebuilds J26's evaluation grid with J26's own expressions (the lines are quoted
from j26_ambrus_check.py run(), lines 269-281 and 314-316), then writes data/fs100/kt1/j26-grid.json:

  sel          the 2,629 k with W(k*0.001) < 0.99995 + 0.001 (scipy j0, double precision) -- WHERE J26's grid is fine.
               This is a grid-shaping step, not a certification step: any grid gives a sound covering.
  n_points, points_sha256   of the sorted unique float64 point list (little-endian bytes), which the checker
               regenerates in pure Python floats and must reproduce bit for bit.
  d2           the exact squared distances of the 26 w2 pairs in Q(sqrt3, sqrt11), as (a, b, c, d) = a + b sqrt3 +
               c sqrt11 + d sqrt33 with rational strings -- computed by J26's own read_points and sqdist.
  j26_float    J26's float constants (supJ1, C, S1, Sh, L_a, L_b, L_c) and its float covering's worst cell, recomputed
               here by J26's formulas, for comparison only (the checker derives its own enclosures).

Run: python3 tools/fs100_kt1_grid.py [--out PATH]   (seconds; exit 0 iff J26's recorded numbers reproduce)
Plant: --plant sel_drop (drops one selected k) must make the checker's sha256 comparison fail (the checker's self-test
uses it; this script only writes the planted file where told).
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path

import mpmath
import numpy as np
import scipy.special as sp

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
import j26_ambrus_check as j26  # noqa: E402  (read-only import; never edited)

OUT = ROOT / "data/fs100/kt1/j26-grid.json"


def frac_str(q):
    return f"{q.numerator}/{q.denominator}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=str(OUT))
    ap.add_argument("--plant", choices=["sel_drop"])
    a = ap.parse_args()

    mpmath.mp.dps = 40
    pts = j26.read_points(j26.NB)
    w0, wT, w1, w2, wc = j26.read_coeffs(j26.CSV)
    D2 = [[j26.sqdist(pts[i], pts[j]) for j in range(j26.N)] for i in range(j26.N)]

    # --- J26 run(), lines 269-275, verbatim in substance ---
    dists = np.array([float(mpmath.sqrt(j26.ffloat(D2[i - 1][j - 1]))) for _, i, j in w2])
    w2f = np.array([float(v) for v, _, _ in w2])
    w0f, w1f = float(w0), float(w1)

    def fi(t):
        t = np.asarray(t, dtype=float)
        return w0f * sp.j0(t) + w1f + (w2f[None, :] * sp.j0(np.outer(t, dists))).sum(axis=1)

    # --- lines 278-281 ---
    tk = np.arange(1, 100001)
    f1 = fi(tk * 0.001)
    sel = tk[f1 < 0.99995 + 0.001]
    # --- lines 314-316 ---
    pts_ = np.concatenate([[0.0], tk * 0.001, np.concatenate([(k - 1) * 0.001 + np.arange(0, 201) * 0.00001 for k in sel]),
                           100 + np.arange(1, 9001) * 0.1, 1000 + np.arange(1, 9001) * 1.0])
    pts_ = np.unique(pts_)
    digest = hashlib.sha256(pts_.astype("<f8").tobytes()).hexdigest()

    # --- J26's float constants, lines 288-298 ---
    supJ1 = mpmath.findroot(lambda x: mpmath.besselj(0, x) - mpmath.besselj(1, x) / x, 1.84)
    supJ1 = abs(mpmath.besselj(1, supJ1)) * (1 + mpmath.mpf(10) ** -12)
    u0 = mpmath.mpf(10)
    C = mpmath.sqrt(u0 * (mpmath.besselj(1, u0) ** 2 + mpmath.bessely(1, u0) ** 2))
    ds = [mpmath.sqrt(j26.ffloat(D2[i - 1][j - 1])) for _, i, j in w2]
    S1 = abs(w0) + sum(abs(v) * d for (v, _, _), d in zip(w2, ds))
    Sh = abs(w0) + sum(abs(v) * mpmath.sqrt(d) for (v, _, _), d in zip(w2, ds))
    L_a = supJ1 * float(S1)
    L_b = C / mpmath.sqrt(100) * float(Sh)
    L_c = C / mpmath.sqrt(1000) * float(Sh)
    # --- lines 317-321: J26's float covering ---
    vals = fi(pts_)
    a_, b_ = pts_[:-1], pts_[1:]
    Lr = np.where(a_ < 100, float(L_a), np.where(a_ < 1000, float(L_b), float(L_c)))
    lb = (vals[:-1] + vals[1:]) / 2 - Lr * (b_ - a_) / 2
    worst = int(np.argmin(lb))

    sel_list = [int(k) for k in sel]
    if a.plant == "sel_drop":
        sel_list = sel_list[:100] + sel_list[101:]

    checks = {  # every value coerced to a Python bool below
        "len(sel) == 2629 (J26 and the notebook)": len(sel) == 2629,
        "first point 0, last 10000": pts_[0] == 0.0 and pts_[-1] == 10000.0,
        "J26 worst lb 0.999942348 reproduced (|diff| < 5e-10)": abs(lb[worst] - 0.999942348) < 5e-10,
        "J26 worst cell [3.77488, 3.77489] reproduced": abs(a_[worst] - 3.77488) < 5e-6 and abs(b_[worst] - 3.77489) < 5e-6,
        "26 w2 pairs": len(w2) == 26,
    }
    checks = {k: bool(v) for k, v in checks.items()}
    out = {
        "producer": "tools/fs100_kt1_grid.py (imports tools/j26_ambrus_check.py read-only)",
        "sel": sel_list,
        "n_points": int(len(pts_)),
        "points_sha256": digest,
        "w2_pairs": [[i, j] for _, i, j in w2],
        "d2": {f"{i},{j}": [frac_str(x) for x in D2[i - 1][j - 1]] for _, i, j in w2},
        "j26_float": {
            "supJ1": str(supJ1), "C": str(C), "S1": str(S1), "Sh": str(Sh),
            "L_a": str(L_a), "L_b": str(L_b), "L_c": str(L_c),
            "worst_lb": float(lb[worst]), "worst_cell": [float(a_[worst]), float(b_[worst])],
            "min_W_on_grid": float(vals.min()), "argmin_W_on_grid": float(pts_[int(np.argmin(vals))]),
        },
        "checks": checks,
    }
    Path(a.out).parent.mkdir(parents=True, exist_ok=True)
    Path(a.out).write_text(json.dumps(out, indent=1) + "\n")
    for k, v in checks.items():
        print(f"{'ok  ' if v else 'FAIL'} {k}")
    print(f"n_points = {len(pts_)}, sha256 = {digest}; J26 float: L_a = {mpmath.nstr(L_a, 12)}, L_b = {mpmath.nstr(L_b, 12)}, "
          f"L_c = {mpmath.nstr(L_c, 12)}, worst lb = {lb[worst]:.12f} on [{a_[worst]!r}, {b_[worst]!r}]; wrote {a.out}")
    if not all(checks.values()):
        print("!!! J26's recorded grid or numbers did NOT reproduce -- the export is not J26's covering", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
