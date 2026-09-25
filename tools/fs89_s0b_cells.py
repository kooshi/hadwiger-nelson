#!/usr/bin/env python3
"""FS-89 Stage 0B, step 1: the cells of the rational pattern's band set at band [lo, hi] (exact, Fractions).

Theta_R(lo, hi) = { mu in C / 5Z[i] : <mu, u> in [lo, hi] + Z for every u in U_R },
U_R the 12 rational unit vectors (a+bi)/5, a^2+b^2 = 25; <mu, x> = Re(conj(mu) x) = mu1 x1 + mu2 x2.
mu parametrises the characters of L = (1/5)Z[i]; the dual lattice is 5Z[i].

Reuses the half-plane-clipping arrangement of the frozen FS-81 verifier (`tools/fs81_verify_thetaR.py`, imported, never
edited), with a larger window, because the four-colour cells are larger.

Usage:  fs89_s0b_cells.py --band 1/3 2/3 [--plant drop-dir] [--json out.json]
Exit 0 always after printing; the control mode (--expect-t40) exits 1 unless FS73-T40's five cells are reproduced.
"""
from __future__ import annotations

import argparse
import json
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs81_verify_thetaR as T40  # frozen; imported only

WINDOW = (Fr(-4), Fr(9))


def cells(lo: Fr, hi: Fr, dirs=None, window=WINDOW):
    """All cells (convex polygons, exact) of Theta_R whose vertex-average lies in [0,5)^2; each checked not to touch the
    window boundary.  Returns a sorted list of vertex lists."""
    units = T40.rational_units()
    if dirs is None:
        dirs = T40.directions(units)
    pieces = T40.arrangement(dirs, lo, hi, window=window)
    w0, w1 = window
    kept = []
    for P in pieces:
        cx = sum(p[0] for p in P) / len(P)
        cy = sum(p[1] for p in P) / len(P)
        if 0 <= cx < 5 and 0 <= cy < 5:
            if any(p[0] in (w0, w1) or p[1] in (w0, w1) for p in P):
                raise SystemExit("WINDOW TOO SMALL")
            kept.append(sorted(P))
    return sorted(kept)


def area2(P):
    """Twice the signed area of a polygon given in cyclic order (0 for a point or segment)."""
    if len(P) < 3:
        return Fr(0)
    s = Fr(0)
    for k in range(len(P)):
        x0, y0 = P[k]
        x1, y1 = P[(k + 1) % len(P)]
        s += x0 * y1 - x1 * y0
    return abs(s)


def cyclic(P):
    """Order the vertices of a convex polygon counter-clockwise (exact, by angle-free comparison around the centroid)."""
    if len(P) < 3:
        return list(P)
    cx = sum(p[0] for p in P) / len(P)
    cy = sum(p[1] for p in P) / len(P)

    def half(p):
        x, y = p[0] - cx, p[1] - cy
        return 0 if (y > 0 or (y == 0 and x > 0)) else 1

    import functools

    def cmp(p, q):
        hp, hq = half(p), half(q)
        if hp != hq:
            return hp - hq
        cr = (p[0] - cx) * (q[1] - cy) - (p[1] - cy) * (q[0] - cx)
        return -1 if cr > 0 else (1 if cr < 0 else 0)

    return sorted(P, key=functools.cmp_to_key(cmp))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--band", nargs=2, default=["1/4", "3/4"])
    ap.add_argument("--plant", choices=["none", "drop-dir", "band-hi"], default="none")
    ap.add_argument("--expect-t40", action="store_true")
    ap.add_argument("--json")
    a = ap.parse_args()
    lo, hi = Fr(a.band[0]), Fr(a.band[1])
    dirs = T40.directions(T40.rational_units())
    if a.plant == "drop-dir":
        dirs = [u for u in dirs if u not in ((Fr(3, 5), Fr(4, 5)), (Fr(-3, 5), Fr(-4, 5)))]
    elif a.plant == "band-hi":
        hi = hi - Fr(1, 15)
    cs = [cyclic(P) for P in cells(lo, hi, dirs)]
    tot = sum(area2(P) for P in cs) / 2
    print(f"band [{lo}, {hi}]  plant={a.plant}  cells per period: {len(cs)}  total area {tot} "
          f"(= {float(tot):.6f} of 25; fraction {float(tot / 25):.6f})")
    kinds = {}
    for P in cs:
        kinds[len(P)] = kinds.get(len(P), 0) + 1
    print("  by vertex count:", dict(sorted(kinds.items())))
    for P in cs:
        cx = sum(p[0] for p in P) / len(P)
        cy = sum(p[1] for p in P) / len(P)
        print(f"  {len(P):2d}-vertex  centre-avg ({cx}, {cy})  area {area2(P) / 2}")
    if a.json:
        with open(a.json, "w") as fh:
            json.dump({"band": [str(lo), str(hi)], "plant": a.plant,
                       "cells": [[[str(x), str(y)] for x, y in P] for P in cs]}, fh, indent=1)
    if a.expect_t40:
        c0 = (Fr(5, 2), Fr(5, 2))
        D0 = T40.d0(T40.directions(T40.rational_units()))
        exp = sorted([sorted((c0[0] + p[0], c0[1] + p[1]) for p in D0)]
                     + [[(c0[0] + s * Fr(5, 6), c0[1] + t * Fr(5, 6))] for s in (1, -1) for t in (1, -1)])
        got = sorted(sorted(P) for P in cs)
        ok = got == exp
        print("CONTROL:", "FS73-T40 reproduced (D0 + four points)" if ok else "DIFFERENT from FS73-T40")
        return 0 if ok else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
