#!/usr/bin/env python3
"""FS114-Y3 stage 2: the stop of FS114-Y2-BOWTIE at r = q1 + e(330 deg) = (sqrt3, 0), checked exactly at a named ring point.

THE DERIVATION (plans/FS114-Y3-construction.md stage 2, Y3-RSTOP).  At q1 the bowtie's tiles are t1 [180,300], W (3) [300,330], T1 (4)
[330, 53.13], V (6) [53.13, 60], L1 (5) [60, 180] (sectors in degrees, directions from q1); P_cl(q1) = {1,3,4,5,6}.  Take the ring point
y = q1 + e(phi), phi just above 330.  Either y is interior to a tile (S), whose colour is not in P_cl(q1) (N-E1), so 2 -- and then that tile
straddles T2, since T2 has directions at q2 within 90 deg of the direction to y and |y - q2| > 1; or y is interior to a unit arc about q1 (G),
whose outer tile Z has a colour c: c = 2 straddles T2 the same way, and each c in P_cl(q1) straddles its q1-tile, which has a direction at q1
within 90 deg of phi (t1 at 280, W at 315, T1 at 0, V at 55, L1 at 60 + eta for eta < phi - 330).  No state is left.

THE CHECK (FS114-YB's checker `tools/fs114_yb_exact.py`, imported and never edited; the bowtie from `tools/fs114_y2_k1.py` build(), unedited):
the named ring point y = q1 + e(330)(c + i s), (c, s) = (399/401, 40/401) (phi - 330 = 5.72 deg), every coordinate in Q(sqrt3).
  S-probe:  a triangle of size 1/100 with y inside, coloured 2       vs T2                      -> REJECT (registered)
  O-probe:  a triangle just outside the unit circle about q1 at y (distance 1/1000 to 3/1000, width 2/100), coloured c:
            c = 1 vs t1, 3 vs W, 4 vs T1, 6 vs V, 5 vs L1, 2 vs T2                               -> REJECT, all six (registered)
CONTROLS AND PLANTS (each beside the faithful twin; predictions registered before the first run):
  C-sector  the O-probe's shape moved to r + e(16.26)/100 (direction (24/25, 7/25)), strictly inside the sector (330, 60) at r, off the ring, coloured 5 vs L1
            -> ACCEPT (L1's exclusion needs the ring: at second order |z - q1 - s e(60+)|^2 - 1 has no real root in s there);
            the same probe coloured 4 vs T1 -> REJECT (T1 points at r).
  P-E1      a colour-2 wedge at q2 with sector [240, 300], radius 1/5, vs the S-probe -> ACCEPT (the escape E1: nothing of colour 2 at q2
            points within 90 deg of the direction to y); the faithful T2 -> REJECT above.
  P-E2      a colour-5 wedge at q1 with sector [90, 150], radius 1/5, vs the O-probe coloured 5 -> ACCEPT (the escape E2: a colour at q1 whose
            sector starts after 60 + (phi - 330)); the faithful L1 -> REJECT above.
Run: python3 tools/fs114_y3_rstop.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)
import fs114_y2_k1 as K      # noqa: E402  (FS114-Y2's bowtie, unedited)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub, vmul = X.vadd, X.vsub, X.vmul
P, r3, q1, q2 = K.P, K.r3, K.q1, K.q2


def rot(v, c, s):
    return (v[0] * c - v[1] * s, v[0] * s + v[1] * c)


E330 = P(r3 / 2, Fr(-1, 2))
U = rot(E330, Fr(399, 401), Fr(40, 401))          # e(phi), phi = 330 + 5.72 deg
Y = vadd(q1, U)                                     # the named ring point
T = (-U[1], U[0])                                   # the tangent at y (counter-clockwise about q1)
R = vadd(q1, E330)                                  # r = (sqrt3, 0)


def tri(name, colour, a, b, c):
    return Tile(name, colour, [Seg(a, b), Seg(b, c), Seg(c, a)])


def s_probe(colour):
    rho = Fr(1, 100)
    return tri("S", colour, vadd(Y, vmul(rho, U)), vadd(Y, vadd(vmul(-rho, U), vmul(rho, T))),
               vadd(Y, vadd(vmul(-rho, U), vmul(-rho, T))))


def o_probe(colour, at=None, u=None, t=None):
    at, u, t = (Y, U, T) if at is None else (at, u, t)
    r1, r2 = Fr(1, 1000), Fr(1, 100)
    return tri("O", colour, vadd(at, vadd(vmul(r1, u), vmul(-r2, t))), vadd(at, vmul(3 * r1, u)),
               vadd(at, vadd(vmul(r1, u), vmul(r2, t))))


def wedge(name, colour, q, d1, d2, rad=None):
    rad = K.T(Fr(1, 5)) if rad is None else rad
    a, b = vadd(q, vmul(rad, d1)), vadd(q, vmul(rad, d2))
    return Tile(name, colour, [Seg(q, a), Arc(q, rad, a, b, True), Seg(b, q)])


def verdict(A, B):
    r = X.pair(A, B)
    return ("REJECT" if r.reject else "ACCEPT"), r


def main():
    tiles = {t.name: t for t in K.build()}
    print("== FS114-Y3 r-stop: the named ring point y = q1 + e(330)(399/401 + i 40/401)")
    print(f"   |y - q1|^2 = {X.n2(vsub(Y, q1))} (exactly 1); |y - q2|^2 = {X.n2(vsub(Y, q2))} = {float(X.n2(vsub(Y, q2))):.6f} (> 1: "
          f"{(X.n2(vsub(Y, q2)) - 1).sign() > 0}); |y|^2 = {float(X.n2(Y)):.6f} (|r|^2 = {X.n2(R)})")
    at_q1 = [t for t in tiles.values() if any(X.veq(pc.P, q1) for pc in t.pieces)]
    print(f"   tiles at q1: {sorted((t.name, t.colour) for t in at_q1)}")
    out, bad = [], 0
    want = [("S-probe colour 2 vs T2", s_probe(2), tiles["T2"], "REJECT")]
    for c, nm in ((1, "t1"), (3, "W"), (4, "T1"), (6, "V"), (5, "L1"), (2, "T2")):
        want.append((f"O-probe colour {c} vs {nm}", o_probe(c), tiles[nm], "REJECT"))
    # controls and plants
    d = (Fr(24, 25), Fr(7, 25))                     # direction 16.26 deg from r, strictly inside the sector (330, 60) at r
    zc = vadd(R, P(d[0] / 100, d[1] / 100))
    dd = P(d[0], d[1])
    want.append(("C-sector: probe off the ring at r + e(16.26)/100, colour 5 vs L1", o_probe(5, zc, dd, (-dd[1], dd[0])), tiles["L1"], "ACCEPT"))
    want.append(("C-sector: the same probe colour 4 vs T1", o_probe(4, zc, dd, (-dd[1], dd[0])), tiles["T1"], "REJECT"))
    want.append(("P-E1: colour-2 wedge at q2, sector [240,300], vs the S-probe", s_probe(2),
                 wedge("Q2", 2, q2, P(Fr(-1, 2), -r3 / 2), P(Fr(1, 2), -r3 / 2)), "ACCEPT"))
    want.append(("P-E2: colour-5 wedge at q1, sector [90,150], vs the O-probe colour 5", o_probe(5),
                 wedge("Q5", 5, q1, P(Fr(0), Fr(1)), P(-r3 / 2, Fr(1, 2))), "ACCEPT"))
    for label, A, B, exp in want:
        v, r = verdict(A, B)
        ok = v == exp
        bad += not ok
        print(f"{'ok ' if ok else 'BAD'} {label}: {v} (registered {exp}; {r.n} candidate pairs"
              f"{'; min<1' if r.min_lt1 else ''}{'; max>1' if r.max_gt1 else ''})")
    print(f"{len(want) - bad} of {len(want)} as registered")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
