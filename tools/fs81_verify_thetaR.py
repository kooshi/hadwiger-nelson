#!/usr/bin/env python3
"""FS-81 stage C (the verifier's second code path): the rotation set Θ_R of the rational pattern, and the
exact facts the proof of L2 consumes.

Written blind by the stage-C verifier, independently of `tools/fs73v2_thetaR.py` (V2's vertex enumeration) and of
every FS-81 phase-0 tool, none of which was opened.

Objects.
  L   = (1/5)Z[i], the span of the 12 rational unit vectors U_R = {(a+bi)/5 : a^2 + b^2 = 25}.
  A character of L is x -> <mu, x> mod 1, mu in R^2, <mu, x> = mu1*x1 + mu2*x2; mu is defined modulo the dual
  lattice 5Z^2 (the dual of (1/5)Z[i] under the dot product).  mu = (theta(1), theta(i)) lifted.
  Theta_R = { mu : <mu, u> in [1/3, 2/3] + Z for every u in U_R }.

Method (not V2's): half-plane clipping.  Start from a window W = [-2, 7]^2 (larger than one period 5), and for each of
the six directions (one per +- pair) replace every convex piece P by the non-empty pieces P ∩ {m + lo <= <mu,u> <= m + hi}
for the finitely many integers m the range of <mu,u> on P allows.  Every surviving piece is a convex polygon (possibly a
segment or a point), computed in exact Fractions by Sutherland–Hodgman clipping with closed half-planes.  Distinct
pieces are distinct cells: two bands of one direction are separated by a gap of width 1/3 (for the true band), so
pieces never touch.  Cells whose vertex-average lies in [0,5)^2 are the cells of one period; each is checked not to
touch W's boundary (so none was truncated).

Expected (FS73-T40): exactly five cells per period — one 12-vertex cell c0 + D0, c0 = (5/2, 5/2),
D0 = {d : |<d,u>| <= 1/6 on U_R}, and four single points c0 + (+-5/6, +-5/6).

Also checked exactly (the facts L2's proof consumes):
  (T1) 4 * R_D^2 < 5, R_D the circumradius of D0: two D0 points differ by less than the shortest vector of pi-bar*Z[i]
       (norm^2 5), pi = 2 + i.
  (T2) R_D^2 < min |f + pi-bar*z|^2 and R_D^2 < min |f + pi*z|^2 over f in F4, z in Z[i]: no D0 <-> F4 transition.
  (T3) F4 is injective modulo pi-bar*Z[i] and modulo pi*Z[i].
  (T4) the four order-3 characters of R5 = Z[i][1/5] nonzero on 1 and i restrict to L as c0 + F4.

Planted faults (each must change the verdict):  --plant drop-dir  (drop the direction (3+4i)/5),
--plant band-hi (band [1/3, 3/5]),  --plant band-lo (band [2/5, 2/3]).
"""
from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction as Fr
from itertools import product

THIRD = Fr(1, 3)
TWO_THIRDS = Fr(2, 3)


def rational_units() -> list[tuple[Fr, Fr]]:
    """All (a/5, b/5) with a^2 + b^2 = 25, enumerated from the norm equation."""
    out = []
    for a in range(-5, 6):
        for b in range(-5, 6):
            if a * a + b * b == 25:
                out.append((Fr(a, 5), Fr(b, 5)))
    return out


def directions(units: list[tuple[Fr, Fr]]) -> list[tuple[Fr, Fr]]:
    """One representative per +- pair (the band is symmetric under negation mod 1)."""
    reps = []
    for u in units:
        if (-u[0], -u[1]) not in reps:
            reps.append(u)
    return reps


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def clip(poly: list[tuple[Fr, Fr]], a: tuple[Fr, Fr], b: Fr) -> list[tuple[Fr, Fr]]:
    """poly ∩ {x : a.x <= b}, exact, closed half-plane; poly is a list of vertices of a convex polygon
    (a point or a segment allowed)."""
    if not poly:
        return []
    out: list[tuple[Fr, Fr]] = []
    n = len(poly)
    for k in range(n):
        p = poly[k]
        q = poly[(k + 1) % n]
        sp = dot(a, p) - b
        sq = dot(a, q) - b
        if sp <= 0:
            out.append(p)
        if (sp < 0 < sq) or (sq < 0 < sp):
            t = sp / (sp - sq)
            out.append((p[0] + t * (q[0] - p[0]), p[1] + t * (q[1] - p[1])))
    return normalise(out)


def normalise(poly):
    """Drop duplicate vertices and vertices lying on the segment between their neighbours."""
    pts = []
    for p in poly:
        if p not in pts:
            pts.append(p)
    changed = True
    while changed and len(pts) > 2:
        changed = False
        for k in range(len(pts)):
            p, q, r = pts[k - 1], pts[k], pts[(k + 1) % len(pts)]
            cross = (q[0] - p[0]) * (r[1] - p[1]) - (q[1] - p[1]) * (r[0] - p[0])
            if cross == 0:
                pts.pop(k)
                changed = True
                break
    if len(pts) == 2 and pts[0] == pts[1]:
        pts = pts[:1]
    return pts


def floor_fr(x: Fr) -> int:
    return x.numerator // x.denominator


def arrangement(dirs, lo: Fr, hi: Fr, window=(Fr(-2), Fr(7))):
    w0, w1 = window
    pieces = [[(w0, w0), (w1, w0), (w1, w1), (w0, w1)]]
    for u in dirs:
        new = []
        for P in pieces:
            vals = [dot(u, p) for p in P]
            vmin, vmax = min(vals), max(vals)
            # integers m with [m+lo, m+hi] meeting [vmin, vmax]
            for m in range(floor_fr(vmin - hi) - 1, floor_fr(vmax - lo) + 2):
                Q = clip(P, u, m + hi)
                Q = clip(Q, (-u[0], -u[1]), -(m + lo))
                if Q:
                    new.append(Q)
        pieces = new
    return pieces


def cells_of_one_period(pieces, window=(Fr(-2), Fr(7))):
    w0, w1 = window
    kept = []
    for P in pieces:
        cx = sum(p[0] for p in P) / len(P)
        cy = sum(p[1] for p in P) / len(P)
        if 0 <= cx < 5 and 0 <= cy < 5:
            if any(p[0] in (w0, w1) or p[1] in (w0, w1) for p in P):
                raise SystemExit("WINDOW TOO SMALL: a kept cell touches the window boundary")
            kept.append(((cx, cy), P))
    return kept


def d0(dirs, r=Fr(1, 6)):
    P = [(Fr(-1), Fr(-1)), (Fr(1), Fr(-1)), (Fr(1), Fr(1)), (Fr(-1), Fr(1))]
    for u in dirs:
        P = clip(P, u, r)
        P = clip(P, (-u[0], -u[1]), r)
    return P


def canon(P):
    return sorted(P)


def gauss_mul(p, q):
    return (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def min_norm2_coset(f, g, box=6):
    """min |f + g*z|^2 over z in Z[i] with |Re z|, |Im z| <= box (exact; box is ample for the norms involved)."""
    best = None
    for x in range(-box, box + 1):
        for y in range(-box, box + 1):
            gz = gauss_mul(g, (Fr(x), Fr(y)))
            v = (f[0] + gz[0], f[1] + gz[1])
            n2 = v[0] ** 2 + v[1] ** 2
            if best is None or n2 < best:
                best = n2
    return best


def in_lattice(v, g):
    """Is v in g*Z[i]?  v/g = v*conj(g)/|g|^2 must be a Gaussian integer."""
    n = g[0] ** 2 + g[1] ** 2
    q = gauss_mul(v, (g[0], -g[1]))
    return (q[0] / n).denominator == 1 and (q[1] / n).denominator == 1


def order3_restrictions():
    """The order-3 characters of R5 = Z[i][1/5] nonzero on 1 and i: chi(x) = (a*x1 + b*x2 mod 3)/3 on Z[i],
    a, b in {1, 2}.  On L: chi(1/5) = chi(2) because 1/5 = 2 (mod 3R5) (5*2 = 10 = 1 mod 3).  So in mu-coordinates
    mu = (5*chi(1/5), 5*chi(i/5)) mod 5."""
    out = []
    for a, b in product((1, 2), repeat=2):
        mu1 = (5 * Fr(2 * a, 3)) % 5
        mu2 = (5 * Fr(2 * b, 3)) % 5
        out.append((mu1, mu2))
    return sorted(out)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=["none", "drop-dir", "band-hi", "band-lo"], default="none")
    ap.add_argument("--json", help="write the cell list here")
    args = ap.parse_args()

    units = rational_units()
    assert len(units) == 12, units
    dirs = directions(units)
    assert len(dirs) == 6
    lo, hi = THIRD, TWO_THIRDS
    if args.plant == "drop-dir":
        dirs = [u for u in dirs if u not in ((Fr(3, 5), Fr(4, 5)), (Fr(-3, 5), Fr(-4, 5)))]
    elif args.plant == "band-hi":
        hi = Fr(3, 5)
    elif args.plant == "band-lo":
        lo = Fr(2, 5)

    pieces = arrangement(dirs, lo, hi)
    cells = cells_of_one_period(pieces)
    c0 = (Fr(5, 2), Fr(5, 2))
    D0 = d0(directions(units))  # the true D0, from the true directions and radius 1/6
    expected = sorted(
        [canon([(c0[0] + p[0], c0[1] + p[1]) for p in D0])]
        + [[(c0[0] + s * Fr(5, 6), c0[1] + t * Fr(5, 6))] for s in (1, -1) for t in (1, -1)]
    )
    got = sorted(canon(P) for _, P in cells)

    print(f"plant={args.plant}  band=[{lo}, {hi}]  directions={len(dirs)}")
    print(f"cells in one period: {len(got)}")
    for P in got:
        if len(P) == 1:
            print(f"  point  {tuple(str(x) for x in P[0])}")
        else:
            cx = sum(p[0] for p in P) / len(P)
            cy = sum(p[1] for p in P) / len(P)
            print(f"  {len(P)}-gon  vertex-average ({cx}, {cy})")
    match = got == expected
    print(f"D0: {len(D0)} vertices: {[tuple(str(x) for x in p) for p in canon(D0)]}")

    # --- the exact facts L2's proof consumes (always on the true objects) ---
    RD2 = max(p[0] ** 2 + p[1] ** 2 for p in D0)
    pi = (Fr(2), Fr(1))
    pib = (Fr(2), Fr(-1))
    F4 = [(s * Fr(5, 6), t * Fr(5, 6)) for s in (1, -1) for t in (1, -1)]
    t1 = 4 * RD2 < 5
    m_pib = min(min_norm2_coset(f, pib) for f in F4)
    m_pi = min(min_norm2_coset(f, pi) for f in F4)
    t2 = RD2 < m_pib and RD2 < m_pi
    t3 = all(
        not in_lattice((f[0] - g[0], f[1] - g[1]), lat)
        for f in F4 for g in F4 if f != g for lat in (pi, pib)
    )
    o3 = order3_restrictions()
    t4 = o3 == sorted((c0[0] + f[0], c0[1] + f[1]) for f in F4)
    print(f"(T1) R_D^2 = {RD2} (= {float(RD2):.6f});  4 R_D^2 < 5: {t1}")
    print(f"(T2) min |F4 + pibar Z[i]|^2 = {m_pib} ({float(m_pib):.4f}),  min |F4 + pi Z[i]|^2 = {m_pi};  > R_D^2: {t2}")
    print(f"(T3) F4 injective mod pibar Z[i] and mod pi Z[i]: {t3}")
    print(f"(T4) order-3 characters restrict to c0 + F4: {t4}  {[tuple(str(x) for x in p) for p in o3]}")

    if args.json:
        with open(args.json, "w") as fh:
            json.dump({"plant": args.plant, "band": [str(lo), str(hi)],
                       "cells": [[[str(x), str(y)] for x, y in P] for P in got],
                       "D0": [[str(x), str(y)] for x, y in canon(D0)],
                       "matches_T40": match, "T1": t1, "T2": t2, "T3": t3, "T4": t4,
                       "RD2": str(RD2), "min_F4_pibar": str(m_pib), "min_F4_pi": str(m_pi)}, fh, indent=1)
    if match and t1 and t2 and t3 and t4:
        print("VERDICT: Theta_R = c0 + (D0 ∪ F4) + 5Z^2  (FS73-T40 reproduced); T1-T4 hold")
        return 0
    print("VERDICT: DIFFERENT ARRANGEMENT from FS73-T40" if not match else "VERDICT: a transition fact FAILED")
    return 1


if __name__ == "__main__":
    sys.exit(main())
