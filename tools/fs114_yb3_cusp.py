#!/usr/bin/env python3
"""FS114-YB3 stage 2: FS114-Y4-DIAG step 5's written reason at a degenerate T2, checked exactly at named values with my checker.

DIAG step 5 (Y4 §3.2) blocks colour 2 in bot's sector (240, 300) because "T2 in [240, 300] has directions within 90 deg of 210 deg". A T2 whose sector at
q2 is the single direction 300 (a cusp) is inside [240, 300] (E1) but its direction is exactly 90 deg from 210: first order says nothing.  The object: a
horn H at q2 between the tangent line q2 + s u (u = e(300)) and the unit circle about r (which touches that line at q2), on r's side -- bounded by
q2 -> q2 + (3/5)u -> C = q2 + (3/5)u + (1/5)nu -> (arc about r, clockwise) -> q2, nu = e(30).  Probes are triangles of size 1/1000, colour 2.

Predictions, registered before the first run:
  C1  H vs a probe at bot + e(270)/100 (bot's sector (240, 300))                        -> ACCEPT  (the written reason does not block colour 2 there)
  C2  H vs a probe just outside omega(q1) above r, at q1 + (1001/1000) e(330 + eta), cos eta = 399/401 -> ACCEPT  (the cusp is an E1 member: it leaves
      colour 2 free at the ring above r, second order included, at this point)
  C3  H vs a probe just outside omega(q2) at q2 + (1001/1000) e(210 + phi), cos phi = 399/401 -- where N' (colour 2) lies beyond the X2 | N' unit arc
      that DIAG's own steps 1-2, mirrored at bot, force                                   -> REJECT  (the repair: the arc, not bot, blocks the cusp)
  C4  control: a wedge at q2 with sector [270, 300], radius 1/5, vs the bot probe            -> REJECT  (the written reason works for a sector of positive width)
  C5  H with itself                                                                          -> ACCEPT  (a tile of diameter below 1)
Run: python3 tools/fs114_yb3_cusp.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr
import sympy as sp

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb3_check as X   # noqa: E402

P, Seg, arc, add, smul, sub, nn = X.P, X.Seg, X.arc, X.add, X.smul, X.sub, X.nn
S3 = sp.sqrt(3)
q1, q2, bot = P(S3 / 2, Fr(1, 2)), P(S3 / 2, Fr(-1, 2)), P(0, -1)
u, nu = P(Fr(1, 2), -S3 / 2), P(S3 / 2, Fr(1, 2))
r = add(q2, nu)


def e_rot(c, s, base_c, base_s):
    """the unit vector at (base angle + angle), cos/sin given exactly."""
    return P(c * base_c - s * base_s, s * base_c + c * base_s)


def tri(z, h=Fr(1, 1000)):
    return [Seg(z, add(z, P(h, 0))), Seg(add(z, P(h, 0)), add(z, P(0, h))), Seg(add(z, P(0, h)), z)]


def horn():
    Q = add(q2, smul(X.R.of(Fr(3, 5)), u))
    C = add(Q, smul(X.R.of(Fr(1, 5)), nu))
    assert (nn(sub(C, r)) - 1).sign() == 0
    return [Seg(q2, Q), Seg(Q, C), arc(r, 1, C, q2, ccw=False)]


def main():
    H = horn()
    pb = tri(add(bot, P(0, Fr(-1, 100))))
    ce, se = Fr(399, 401), Fr(40, 401)
    e330 = (S3 / 2, sp.Rational(-1, 2))
    ring = add(q1, smul(X.R.of(Fr(1001, 1000)), e_rot(ce, se, *e330)))
    e210 = (-S3 / 2, sp.Rational(-1, 2))
    arcpt = add(q2, smul(X.R.of(Fr(1001, 1000)), e_rot(ce, se, *e210)))
    wedge = [Seg(q2, add(q2, P(0, Fr(-1, 5)))), arc(q2, Fr(1, 5), add(q2, P(0, Fr(-1, 5))), add(q2, smul(X.R.of(Fr(1, 5)), u))),
             Seg(add(q2, smul(X.R.of(Fr(1, 5)), u)), q2)]
    cases = [("C1", "H vs the bot probe", H, pb, False, "ACCEPT"),
             ("C2", "H vs the ring probe above r", H, tri(ring), False, "ACCEPT"),
             ("C3", "H vs the probe beyond the X2 | N' arc", H, tri(arcpt), False, "REJECT"),
             ("C4", "wedge [270, 300] at q2 vs the bot probe", wedge, pb, False, "REJECT"),
             ("C5", "H with itself", H, H, True, "ACCEPT")]
    ok = True
    for cid, lab, A, B, same, want in cases:
        v, lt, gt, tight = X.verdict(A, B, same)
        good = v == want
        ok &= good
        print(f"{'ok ' if good else 'BAD'} {cid}: {lab}: {v} (registered {want}; min<1 {lt}, max>1 {gt}, tight {tight})")
    print("ALL AS REGISTERED" if ok else "NOT ALL AS REGISTERED")
    return ok


if __name__ == "__main__":
    sys.exit(0 if main() else 1)
