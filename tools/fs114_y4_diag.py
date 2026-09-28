#!/usr/bin/env python3
"""FS114-Y4 stage 4: exact checks at named values of the inequalities FS114-Y4-LUNE and FS114-Y4-DIAG rest on
(plans/FS114-Y4-construction.md §3.1-3.2).  The proofs are the derivations (for every small germ); these checks confirm the inequalities at named
points with germ WEDGES: a wedge at a vertex q with sector [d1, d2] and radius 1/5 is the region q -> q + d1/5 -> (arc about q) -> q + d2/5 -> q.
A probe is a triangle of size 1/1000 at a named point.  Every verdict is FS114-YB's pair() (min < 1 < max -> REJECT), imported unedited; the real
t1, t3 are FS114-Y2-BOWTIE's (tools/fs114_y2_k1.py, unedited).  Predictions registered here before the first run:

LUNE (the colour c(X2) is blocked just outside S1):
  L1  probe at q2 + (1001/1000) e(120) vs an X2-wedge at q2, sector [192.68, 196.26] (below S2)            -> REJECT
  L2  control: the same probe vs a wedge at q2, sector [226.40, 240] (no direction within 90 deg of 120)     -> ACCEPT
DIAG step 1 (top; sector (60,120) outside B(p), B(q1), B(q4); sector (0,60) inside B(q1) only):
  T1  probe at top + e(90)/100 vs t1                                       -> REJECT
  T2  the same probe vs t3                                                  -> REJECT
  T3  the same probe vs a t2-wedge at p, sector [60, 120]                   -> REJECT
  T4  the same probe vs an X1-wedge at q1, sector [150, 167.32]            -> REJECT   (colour a blocked outside B(q1))
  T5  the same probe vs an X4-wedge at q4, sector [12.68, 30]              -> REJECT   (colour a-bar blocked outside B(q4))
  T6  control: the same probe vs a T4-wedge at q4, sector [126.87, 163.74] (away from top) -> ACCEPT (colour 4 free there)
  T7  probe at top + e(30)/100 (inside B(q1) only) vs the X4-wedge          -> REJECT
  T8  the same probe vs a T1-wedge at q1, sector [0, 53.13] (away from top) -> REJECT   (colour 4 blocked inside B(q1))
  T9  control: the same probe vs the X1-wedge                               -> ACCEPT (colour a allowed inside B(q1), as X1 itself)
DIAG step 3: V's point q1 + e(61.93)/100 is within < 1 of top: |.|^2 < 1 exact                   (V1)
DIAG step 5 (bot; sector (240,300) outside B(p), B(q2), B(q3)):
  B1..B3  probe at bot + e(270)/100 vs t1, t3, and a t4-wedge at p [240, 300]                     -> REJECT each
  B4  the same probe vs an E1 T2-wedge at q2, sector [253.74, 286.26]                              -> REJECT
  B5  the same probe vs the X2-wedge                                                               -> REJECT
  B6  the same probe vs an X3-wedge at q3, sector [343.74, 347.32]                                 -> REJECT
  B7  control: the same probe vs a T2-wedge toward r, sector [306.87, 343.74] (not E1)             -> ACCEPT (colour 2 free: Y2's N')
Run: python3 tools/fs114_y4_diag.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)
import fs114_y2_k1 as K      # noqa: E402  (FS114-Y2's bowtie, unedited)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vmul, vsub = X.vadd, X.vmul, X.vsub
P, r3 = K.P, K.r3
h = r3 / 2
p, q1, q2, q3, q4, top, bot = K.p, K.q1, K.q2, K.q3, K.q4, K.top, K.bot


def d(x, y):
    return P(x, y)


def wedge(name, q, d1, d2, rad=Fr(1, 5)):
    R = K.T(rad)
    a, b = vadd(q, vmul(R, d1)), vadd(q, vmul(R, d2))
    return Tile(name, 0, [Seg(q, a), Arc(q, R, a, b, True), Seg(b, q)])


def probe(at, s=Fr(1, 1000)):
    return Tile("probe", 0, [Seg(vadd(at, d(s, 0)), vadd(at, d(0, s))), Seg(vadd(at, d(0, s)), vadd(at, d(-s, -s))),
                             Seg(vadd(at, d(-s, -s)), vadd(at, d(s, 0)))])


def main():
    tiles = {t.name: t for t in K.build()}
    t1, t3 = tiles["t1"], tiles["t3"]
    X2w = wedge("X2", q2, d(Fr(-40, 41), Fr(-9, 41)), d(Fr(-24, 25), Fr(-7, 25)))
    far = wedge("far", q2, d(Fr(-20, 29), Fr(-21, 29)), d(Fr(-1, 2), -h))
    t2w = wedge("t2w", p, d(Fr(1, 2), h), d(Fr(-1, 2), h))
    X1w = wedge("X1w", q1, d(-h, Fr(1, 2)), d(Fr(-40, 41), Fr(9, 41)))
    X4w = wedge("X4w", q4, d(Fr(40, 41), Fr(9, 41)), d(h, Fr(1, 2)))
    T4w = wedge("T4w", q4, d(Fr(-3, 5), Fr(4, 5)), d(Fr(-24, 25), Fr(7, 25)))
    T1w = wedge("T1w", q1, d(1, 0), d(Fr(3, 5), Fr(4, 5)))
    t4w = wedge("t4w", p, d(Fr(-1, 2), -h), d(Fr(1, 2), -h))
    T2e1 = wedge("T2e1", q2, d(Fr(-7, 25), Fr(-24, 25)), d(Fr(7, 25), Fr(-24, 25)))
    X3w = wedge("X3w", q3, d(Fr(24, 25), Fr(-7, 25)), d(Fr(40, 41), Fr(-9, 41)))
    T2r = wedge("T2r", q2, d(Fr(3, 5), Fr(-4, 5)), d(Fr(24, 25), Fr(-7, 25)))
    pL = probe(vadd(q2, vmul(K.T(Fr(1001, 1000)), d(Fr(-1, 2), h))))
    pT = probe(vadd(top, d(0, Fr(1, 100))))
    pT30 = probe(vadd(top, d(h / 100, Fr(1, 200))))
    pB = probe(vadd(bot, d(0, Fr(-1, 100))))
    cases = [("L1", pL, X2w, "REJECT"), ("L2", pL, far, "ACCEPT"),
             ("T1", pT, t1, "REJECT"), ("T2", pT, t3, "REJECT"), ("T3", pT, t2w, "REJECT"), ("T4", pT, X1w, "REJECT"),
             ("T5", pT, X4w, "REJECT"), ("T6", pT, T4w, "ACCEPT"), ("T7", pT30, X4w, "REJECT"), ("T8", pT30, T1w, "REJECT"),
             ("T9", pT30, X1w, "ACCEPT"),
             ("B1", pB, t1, "REJECT"), ("B2", pB, t3, "REJECT"), ("B3", pB, t4w, "REJECT"), ("B4", pB, T2e1, "REJECT"),
             ("B5", pB, X2w, "REJECT"), ("B6", pB, X3w, "REJECT"), ("B7", pB, T2r, "ACCEPT")]
    bad = 0
    for lab, A, B, exp in cases:
        r = X.pair(A, B)
        v = "REJECT" if r.reject else "ACCEPT"
        bad += v != exp
        print(f"{'ok ' if v == exp else 'BAD'} {lab}: probe vs {B.name}: {v} (registered {exp}; min<1 {r.min_lt1}, max>1 {r.max_gt1})")
    v1 = vadd(q1, vmul(K.T(Fr(1, 100)), d(Fr(8, 17), Fr(15, 17))))
    dv = X.n2(vsub(v1, top))
    ok = (dv - 1).sign() < 0
    bad += not ok
    print(f"{'ok ' if ok else 'BAD'} V1: |q1 + e(61.93)/100 - top|^2 = {float(dv):.8f} < 1: {ok}")
    print("ALL AS REGISTERED" if not bad else f"{bad} NOT AS REGISTERED")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
