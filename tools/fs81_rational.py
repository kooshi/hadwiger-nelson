#!/usr/bin/env python3
"""FS-81 P0.1: the exact cells of the rational layer's rotation set, level by level.

U^(5^K) = the rational unit vectors (p + iq)/5^K, p² + q² = 25^K; their span is (1/5^K)ℤ[i].  A homomorphism θ on it is
μ = (θ(1), θ(i)) ∈ ℝ², with θ((p+iq)/5^K) = (p μ₁ + q μ₂)/5^K, and its rotation set is

    Θ_K = {μ : (p μ₁ + q μ₂)/5^K mod 1 ∈ [1/3, 2/3] for every (p, q)},  periodic under 5^K ℤ².

Lifting: U^(5^(K−1)) ⊆ U^(5^K), so Θ_K ⊆ Θ_(K−1).  The cells of Θ_(K−1) in one period, translated by 5^(K−1)ℤ² to cover
[0, 5^K)², are clipped by each NEW direction's bands; every cell is a closed convex polygon (possibly a segment or a point),
clipped exactly in Fractions by closed half-planes, so degenerate cells survive.  K = 1 must reproduce FS73-T40/V2-T8:
one 12-vertex cell and four isolated points per period, centred at (5/2, 5/2) and (5/2 ± 5/6, 5/2 ± 5/6).

A measurement of a finite shadow (brief P0.1): it aims the verification stage; extra cells at finite K refute nothing.
Usage: fs81_rational.py KMAX [--out DIR]
"""
from __future__ import annotations

import argparse
import json
import math
import os
from fractions import Fraction as F

THIRD, TWOTHIRD = F(1, 3), F(2, 3)


def dirs(K):
    m = 5 ** K
    out = set()
    for p in range(-m, m + 1):
        q2 = m * m - p * p
        q = math.isqrt(q2)
        if q * q == q2:
            for qq in {q, -q}:
                u = (p, qq)
                out.add(max(u, (-p, -qq)))
    return sorted(out)


def clip(poly, a, b, c):
    """poly ∩ {a·x + b·y ≤ c}; poly a list of vertices in cyclic order (a point or a segment allowed)."""
    def val(v):
        return a * v[0] + b * v[1] - c
    if not poly:
        return []
    if len(poly) == 1:
        return poly if val(poly[0]) <= 0 else []
    out = []
    n = len(poly)
    for i in range(n):
        P, Q = poly[i], poly[(i + 1) % n]
        vp, vq = val(P), val(Q)
        if vp <= 0:
            out.append(P)
        if (vp < 0 < vq) or (vq < 0 < vp):
            t = vp / (vp - vq)
            out.append((P[0] + t * (Q[0] - P[0]), P[1] + t * (Q[1] - P[1])))
    # remove consecutive duplicates
    res = []
    for v in out:
        if not res or res[-1] != v:
            res.append(v)
    if len(res) > 1 and res[0] == res[-1]:
        res.pop()
    return res


def dim(poly):
    if len(poly) == 1:
        return 0
    if len(poly) == 2:
        return 1
    area = area2(poly)
    return 2 if area != 0 else 1


def area2(poly):
    return sum(poly[i][0] * poly[(i + 1) % len(poly)][1] - poly[(i + 1) % len(poly)][0] * poly[i][1]
               for i in range(len(poly)))


def refine(cells, newdirs, m):
    """Clip every cell by the bands of each new direction (p, q): (p μ₁ + q μ₂)/m ∈ [k+1/3, k+2/3]."""
    for (p, q) in newdirs:
        nxt = []
        for poly in cells:
            vals = [(p * v[0] + q * v[1]) / m for v in poly]
            lo, hi = min(vals), max(vals)
            for k in range(math.floor(lo - TWOTHIRD), math.ceil(hi - THIRD) + 1):
                piece = clip(poly, F(-p, m), F(-q, m), -(k + THIRD))       # ≥ k + 1/3
                piece = clip(piece, F(p, m), F(q, m), k + TWOTHIRD)        # ≤ k + 2/3
                if piece:
                    nxt.append(piece)
        cells = nxt
    return cells


def canon(poly, period):
    """A cell reduced modulo the period, as a sorted vertex tuple (for de-duplication)."""
    cx = min(v[0] for v in poly)
    cy = min(v[1] for v in poly)
    sx = (cx // period) * period
    sy = (cy // period) * period
    return tuple(sorted((v[0] - sx, v[1] - sy) for v in poly))


def level(KMAX):
    # K = 0: the four vectors ±1, ±i; one square per unit period
    cells = [[(THIRD, THIRD), (TWOTHIRD, THIRD), (TWOTHIRD, TWOTHIRD), (THIRD, TWOTHIRD)]]
    prev = {(1, 0), (0, 1)}
    results = []
    for K in range(1, KMAX + 1):
        m, pm = 5 ** K, 5 ** (K - 1)
        lifted = [[(v[0] + i * pm, v[1] + j * pm) for v in poly] for poly in cells for i in range(5) for j in range(5)]
        D = dirs(K)
        new = [u for u in D if (u[0] % 5 or u[1] % 5)]          # primitive at this level
        cells = refine(lifted, new, m)
        # de-duplicate modulo the period m (cells touching the window boundary appear once per translate)
        seen = {}
        for poly in cells:
            seen.setdefault(canon(poly, m), poly)
        cells = list(seen.values())
        # exact membership check of every vertex against ALL directions of level K
        for poly in cells:
            for v in poly:
                for (p, q) in D:
                    t = (p * v[0] + q * v[1]) / m
                    assert THIRD <= t - math.floor(t) <= TWOTHIRD, (K, v, p, q)
        by_dim = {0: 0, 1: 0, 2: 0}
        areas = []
        for poly in cells:
            dm = dim(poly)
            by_dim[dm] += 1
            if dm == 2:
                areas.append(abs(area2(poly)) / 2)
        total = sum(areas, F(0))
        rec = {"K": K, "period": m, "directions": len(D), "new_directions": len(new), "cells": len(cells),
               "points": by_dim[0], "segments": by_dim[1], "polygons": by_dim[2],
               "area_fraction": str(total / (m * m)), "area_fraction_float": float(total / (m * m)),
               "largest_cell_area": str(max(areas)) if areas else "0",
               "vertex_counts": sorted({len(p) for p in cells if dim(p) == 2}),
               "cells_exact": [[[str(x), str(y)] for x, y in poly] for poly in cells]}
        results.append(rec)
        print(f"K={K}: period {m}, {len(D)} direction pairs ({len(new)} new); cells per period {len(cells)} = "
              f"{by_dim[2]} polygons + {by_dim[1]} segments + {by_dim[0]} points; area fraction {float(total / (m * m)):.6g}; "
              f"largest cell area {float(max(areas)) if areas else 0:.4g}", flush=True)
        prev = set(D)
    return results


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("KMAX", type=int)
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    res = level(a.KMAX)
    if a.out:
        os.makedirs(a.out, exist_ok=True)
        for r in res:
            with open(os.path.join(a.out, f"rational-layer-K{r['K']}.json"), "w") as fh:
                json.dump(r, fh)


if __name__ == "__main__":
    main()
