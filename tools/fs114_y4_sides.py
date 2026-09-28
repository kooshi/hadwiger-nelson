#!/usr/bin/env python3
"""FS114-Y4 stage 2: FS114-Y4-SIDES, checked exactly at named values (the proof is the derivation in plans/FS114-Y4-construction.md §2.1).

THE LEMMA.  Let t1 = Reul(p, q1, q2) be a tile of a valid map (p = 0, q1 = e(30), q2 = e(-30)); X1 the tile along t1's side p-q1 (an arc of
w(q2)) at q1, X2 the tile along t1's side p-q2 (an arc of w(q1)) at q2, both outside t1.  The side points x1 = q2 + e(90 + eps) and
x2 = q1 + e(270 - eps) are 2 cos(eps) - 1 < 1 apart, and X1, X2 have points more than 1 apart (near q1 upward, near q2 downward); so X1, X2
are distinct and of different colours, Siamese pairs allowed.

THE CHECKS (FS114-YB's checker `tools/fs114_yb_exact.py`, and Y2's bowtie builder `tools/fs114_y2_k1.py`, both imported and never edited):
  S1  |x1 - x2|^2 = (2 cos eps - 1)^2 at the rational side points eps = atan(20/99): exact.
  S2  X1 = the region between t1's side p-q1 and the horizontal lift 1/10 above it, from m = q2 + (-20/101, 99/101) to q1; X2 = its mirror in
      y = 0.  pair(X1, X2): REJECT (min < 1 < max)                                                                    (registered)
  C1  control: X2 moved down by 1/5 (no longer along t1's side): pair(X1, X2 - (0, 1/5)): ACCEPT, min >= 1               (registered)
  P1  plant on the real object: FS114-Y2-BOWTIE recoloured by y -> -y acting as (2 4) with 5, 6 fixed (L2 := 5, L3 := 6, V' := 6,
      V''' := 5; every other tile as built): the checker's check_finite REJECTs exactly (L1, L2) and (L4, L3)          (registered)
      beside its faithful twin (Y2's colouring): ACCEPT.
Run: python3 tools/fs114_y4_sides.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)
import fs114_yb_run as RUN   # noqa: E402  (its driver, unedited)
import fs114_y2_k1 as K      # noqa: E402  (FS114-Y2's bowtie, unedited)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub = X.vadd, X.vsub
P, q1, q2, ONE = K.P, K.q1, K.q2, K.ONE


def lifted(pt, h):
    return vadd(pt, P(0, h))


def main():
    bad = 0
    # S1: the side points
    c, s = Fr(99, 101), Fr(20, 101)                 # cos eps, sin eps
    x1 = vadd(q2, P(-s, c))                          # q2 + e(90 + eps)
    x2 = vadd(q1, P(-s, -c))                         # q1 + e(270 - eps)
    d2 = X.n2(vsub(x1, x2))
    ok = (d2 - (2 * c - 1) ** 2).is0() and (d2 - 1).sign() < 0
    bad += not ok
    print(f"{'ok ' if ok else 'BAD'} S1: |x1 - x2|^2 = {d2} = (2 cos eps - 1)^2 = {(2 * c - 1) ** 2}; < 1: {(d2 - 1).sign() < 0}")
    # S2: the hugging tiles
    m = x1
    h = Fr(1, 10)
    X1 = Tile("X1", 5, [Arc(q2, ONE, m, q1, False), Seg(q1, lifted(q1, h)), Seg(lifted(q1, h), lifted(m, h)), Seg(lifted(m, h), m)])
    X2 = K.refl(X1, K.sy, {5: 5}, "X2")
    for label, A, B, exp in (("S2: X1 vs its mirror X2 (both along t1's sides)", X1, X2, "REJECT"),):
        r = X.pair(A, B)
        v = "REJECT" if r.reject else "ACCEPT"
        bad += v != exp
        print(f"{'ok ' if v == exp else 'BAD'} {label}: {v} (registered {exp}; min<1 {r.min_lt1}, max>1 {r.max_gt1}; {r.n} candidate pairs)")
    # C1: the control, X2 moved off t1's side
    sh = P(0, Fr(-1, 5))
    X2s = Tile("X2s", 5, [Arc(vadd(pc.C, sh), pc.rho, vadd(pc.P, sh), vadd(pc.Q, sh), pc.ccw) if pc.kind == "A"
                          else Seg(vadd(pc.P, sh), vadd(pc.Q, sh)) for pc in X2.pieces])
    r = X.pair(X1, X2s)
    v = "REJECT" if r.reject else "ACCEPT"
    okc = v == "ACCEPT" and not r.min_lt1
    bad += not okc
    print(f"{'ok ' if okc else 'BAD'} C1: X1 vs X2 moved down 1/5: {v}, min<1 {r.min_lt1} (registered ACCEPT with min >= 1)")
    # P1: the real object under the colour action (2 4) with 5, 6 fixed
    faithful = K.build()
    rej, _, _ = RUN.check_finite(faithful, "P1 faithful twin: FS114-Y2-BOWTIE as built")
    bad += bool(rej)
    recol = {"L2": 5, "L3": 6, "V'": 6, "V'''": 5}
    planted = [Tile(t.name, recol.get(t.name, t.colour), t.pieces) for t in K.build()]
    rej, _, _ = RUN.check_finite(planted, "P1 plant: y -> -y acting as (2 4), 5 and 6 fixed")
    got = sorted(tuple(sorted((r_.A.name, r_.B.name))) for r_ in rej)
    want = sorted([("L1", "L2"), ("L3", "L4")])
    okp = got == want
    bad += not okp
    print(f"{'ok ' if okp else 'BAD'} P1: rejected {got}; registered {want}")
    print(f"{'ALL AS REGISTERED' if not bad else str(bad) + ' NOT AS REGISTERED'}")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
