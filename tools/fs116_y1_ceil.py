#!/usr/bin/env python3
"""FS116-Y1 stage 2: the exact facts FS116-Y1-STRIPCEIL rests on (the ceiling of Y-SAT for fragments agreeing with the capped strip on B(P_0, 1)).

  (1) the wedge W above V_-1 = (-1/2, sqrt3/2): the named point z = V_-1 + (0, 1/100) lies outside the closed unit discs about P_-2 = (-1, 0) and
      P_0 = (0, 0) (so outside U_-2 and U_-1), and its colour is forced: for each of the five colours G, B, P, R, O a tile of the strip meeting the open
      unit disc about p (U_-2, U_-1, U_0, D_-2, D_-1) holds two named points, both in the open unit disc about p and in the closed tile (exact ray
      test), one at distance < 1 from z and one at distance > 1 -- the tile's interior points inside B(p, 1) straddle z;  M is the sixth colour;
  (2) D_0's closed tile is within distance < 1 of the edge point (x, 0) for x = 1/4 and x = 1/100 (every candidate distance < 1, none equal):
      so D_0 supplies no M partner there and the M partner of (x, 0) sits at (x, 1) (the hand argument, § 2.2);
  (3) x* = sqrt(sqrt3 - 3/4) - 1/2 satisfies |V_-1 - (x*, 1)| = 1 exactly, and 0.49 < x* < 0.4911;
  (4) the ceiling's two sides at named abscissae: |V_-1 - (49/100, 1)| < 1 < |V_-1 - (1/2, 1)|.
Plant (--plant inside): z moved to V_-1 + (0, -1/100), inside U_-2's and U_-1's closures' reach: fact (1)'s "outside both discs" fails.
Run: python3 tools/fs116_y1_ceil.py [--plant inside]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402  (unedited)
import fs114_yb_objects as O    # noqa: E402  (unedited)

vadd, vsub, n2 = X.vadd, X.vsub, X.n2


def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    S = O.Strip(capped=True)
    T = S.T
    q = S.q
    tiles = {t.name: t for t in S.tiles(-4, 3)}
    h = S.h
    V = S.V(-1)
    dz = Fr(-1, 100) if plant == "inside" else Fr(1, 100)
    z = (V[0], V[1] + dz)
    ok = True
    out1 = (n2(vsub(z, S.P(-2))) - 1).sign() > 0 and (n2(vsub(z, S.P(0))) - 1).sign() > 0
    print(f"(1) z = V_-1 + (0, {dz}): outside the unit discs about P_-2 and P_0: {out1}")
    ok &= out1
    # named witness pairs (w_near, w_far) per colour; every point in the open unit disc about p
    W = {
        "U-2": ((q(Fr(-51, 100)), q(Fr(85, 100))), (q(Fr(-99, 100)), q(Fr(1, 1000)))),
        "U-1": ((q(Fr(-49, 100)), q(Fr(85, 100))), (q(Fr(-1, 100)), q(Fr(1, 1000)))),
        "U0": ((q(Fr(1, 100)), q(Fr(85, 100))), (q(Fr(49, 100)), q(Fr(1, 100)))),
        "D-2": ((q(Fr(-51, 100)), q(Fr(-1, 100))), (q(Fr(-9, 10)), q(Fr(-4, 10)))),
        "D-1": ((q(Fr(-49, 100)), q(Fr(-1, 100))), (q(Fr(-1, 10)), q(Fr(-9, 10)))),
    }
    cols = set()
    for nm, (wn, wf) in W.items():
        t = tiles[nm]
        inn = X.inside(wn, t) >= 0 and X.inside(wf, t) >= 0
        ind = (n2(wn) - 1).sign() < 0 and (n2(wf) - 1).sign() < 0
        lt = (n2(vsub(z, wn)) - 1).sign() < 0
        gt = (n2(vsub(z, wf)) - 1).sign() > 0
        good = inn and ind and lt and gt
        cols.add(t.colour)
        print(f"    {nm} ({t.colour}): witnesses in the closed tile {inn}, in B(p,1) {ind}, near < 1 {lt}, far > 1 {gt} -> {'blocks' if good else 'DOES NOT BLOCK'}")
        ok &= good
    print(f"    colours blocked at z: {sorted(cols)}; the sixth: {sorted({'M', 'R', 'O', 'P', 'G', 'B'} - cols)}")
    ok &= cols == {"G", "B", "P", "R", "O"}
    # (2) D_0 within < 1 of (x, 0)
    for x in (Fr(1, 4), Fr(1, 100)):
        lt, gt, eq, ins = X.point_tile((q(x), q(0)), tiles["D0"])
        good = (not gt) and (not eq)
        print(f"(2) D_0 against ({x}, 0): some distance > 1: {gt}; some = 1: {eq} -> {'within < 1' if good else 'NOT within < 1'}")
        ok &= good
    # (3) x*
    T2 = T.extend(T.gen(1) - Fr(3, 4), "sqrt3-3/4")
    xs = T2.gen(3) - Fr(1, 2)
    Vt = (T2(Fr(-1, 2)), T2(S.h))
    d = n2(vsub(Vt, (xs, T2(1)))) - 1
    b = (xs - Fr(49, 100)).sign() > 0 and (xs - Fr(4911, 10000)).sign() < 0
    print(f"(3) x* = sqrt(sqrt3 - 3/4) - 1/2 = {float(xs):.6f}: |V_-1 - (x*, 1)|^2 - 1 = 0 exactly: {d.is0()}; 0.49 < x* < 0.4911: {b}")
    ok &= d.is0() and b
    # (4)
    a1 = (n2(vsub(V, (q(Fr(49, 100)), q(1)))) - 1).sign() < 0
    a2 = (n2(vsub(V, (q(Fr(1, 2)), q(1)))) - 1).sign() > 0
    print(f"(4) |V_-1 - (49/100, 1)| < 1: {a1}; |V_-1 - (1/2, 1)| > 1: {a2}")
    ok &= a1 and a2
    print(f"=> {'ALL HOLD' if ok else 'FAILS'}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
