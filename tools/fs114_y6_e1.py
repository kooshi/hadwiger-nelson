#!/usr/bin/env python3
"""FS114-Y6 stage 2: exact checks at named values of the inequalities FS114-Y6-E1CAP and the k = 1 kill rest on
(plans/FS114-Y6-construction.md §2).  The proofs are the derivations (for every small germ); these checks confirm the inequalities at named
points with germ WEDGES (a sector of radius 1/5 at a vertex), PROBES (a triangle of size 1/1000) and thin ARC SLIVERS.  Every verdict is
FS114-YB3's checker (`tools/fs114_yb3_check.py`, imported unedited): `minmax` (is min < 1, is max > 1) and `verdict` (REJECT iff min < 1 < max).
Before any check, the five controls are re-run through FS114-YB3's own calibration (`fs114_yb3_run.calib`, unedited) and must all ACCEPT.

Frame (E1 at edge 1): p = 0, q4 = e(0) = (1, 0), q1 = e(60), C = e(-60), r = q1 + q4; for the k = 1 kill the member with alpha_2 = 90:
v2 = e(120) (so v2 = q1 + e(180)).

Predictions registered here before the first run:
  A  (alpha_2 < 120 at the boundary phi_2 = 180) the edge-2 point q2 + e(tau), q2 = (-1, 0), e(tau) = (4/5, 3/5), is farther than 1 from q4
     (|.|^2 = 9/5)                                                                                                        -> TRUE
  B  (Omega misses q1) q4 + (1/100)(3/5, -4/5) (direction 306.87 at q4) is farther than 1 from q1                           -> TRUE
  C1 (UPDOWN, Y points at q4) a wedge [330, 0] at q1 against a probe at q4 + (1/1000)(1, 0): min < 1                       -> TRUE
  C2 control: a wedge [30, 60] at q1 against the same probe: min < 1                                                       -> FALSE
  D1 (no H) a wedge [90, 120] at q4 against a probe at q1 + (1/1000)(0, 1): min < 1                                          -> TRUE
  D2 control: a wedge [300, 330] at q4 (inside the outer gap) against the same probe: min < 1                                  -> FALSE
  E1 (phi_3 = 240, the tangent case: t4 misses q1) q3 + (99/100) e(60 + tau), q3 = e(240), e(tau) = (24/25, 7/25), is farther than 1
     from q1                                                                                                               -> TRUE
  E2 control (phi_3 = 210: t4 starts at 120 and points at q1) p + (1/100) e(120) is nearer than 1 to q1                      -> TRUE
  F1 (the k = 1 straddle) a colour-1 sliver outside omega(v2) along its arc from q1 to v2 + (4/5, 3/5), and a colour-1 sliver outside
     omega(q1) along its arc from q1 + (-4/5, 3/5) to v2: verdict                                                            -> REJECT
  F2 control: the second sliver taken inside omega(q1) (the arc turned inward): verdict                                        -> ACCEPT
SECOND REGISTRATION (after run 1, `data/fs114/fs114-y6/e1-run1-misses.out`, which read C2 TRUE and F2 REJECT; both are registration misses
of mine, explained by hand before this edit): C2's probe at q4 + (1/1000)(1, 0) is a triangle with a vertex at q4 + (1/1000, 1/1000), which
itself points at q1, so the probe (not the wedge) came within 1 of q1; F2 moved the second sliver to the inside of the SAME arc, which still
straddles.  Corrected, registered before run 2: the probes of C and D sit at q4 + (1/100) e(300) and q1 + (1/100) e(120), pointing away from the
other vertex (C1 TRUE, C2 FALSE, D1 TRUE, D2 FALSE as before); F2 is Y5's control: the second sliver along the arc of omega(q1) from v2
counter-clockwise INTO the disc (to q1 + (-4/5, -3/5)), outside omega(q1)                                                   -> ACCEPT (min exactly 1).
PLANT (beside the faithful twin), second registration: the first registration (the first sliver inside omega(v2)) read REJECT for a reason I
named after run 1 (`e1-plant-run1-miss.out`): a tile inside B(v2, 1) near q1 is within 1 of the other sliver's points near v2 -- the
derivation's step 1, not the arcs' directions.  Registered now: F1 with the FIRST ARC REVERSED (the sliver outside omega(v2) along its arc from
q1 CLOCKWISE, to v2 + (4/5, -3/5)) reads ACCEPT: by YB2-DE's formula the tt' term changes sign, so the arcs' directions are what fire.
Run: python3 tools/fs114_y6_e1.py [--plant]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr
import sympy as sp

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb3_check as X   # noqa: E402  (FS114-YB3's checker, unedited)
import fs114_yb3_run as XR    # noqa: E402  (its calibration driver, unedited)

P, Seg, Arc, add, sub, smul, nn = X.P, X.Seg, X.Arc, X.add, X.sub, X.smul, X.nn
S3 = sp.sqrt(3)
H = Fr(1, 2)


def E(deg):
    t = {0: (1, 0), 30: (S3 / 2, H), 60: (H, S3 / 2), 90: (0, 1), 120: (-H, S3 / 2), 150: (-S3 / 2, H), 180: (-1, 0),
         210: (-S3 / 2, -H), 240: (-H, -S3 / 2), 270: (0, -1), 300: (H, -S3 / 2), 330: (S3 / 2, -H)}[deg % 360]
    return P(*t)


def V(x, y):
    return P(x, y)


def wedge(q, d1, d2, rad=Fr(1, 5)):
    a, b = add(q, smul(X.R.of(rad), d1)), add(q, smul(X.R.of(rad), d2))
    return [Seg(q, a), Arc(q, X.R.of(rad), a, b, True), Seg(b, q)]


def probe(at, s=Fr(1, 1000)):
    s = X.R.of(s)
    a, b, c = add(at, (s, X.R.of(0))), add(at, (X.R.of(0), s)), add(at, (-s, -s))
    return [Seg(a, b), Seg(b, c), Seg(c, a)]


def sliver(C, S, Eend, out=True, w=Fr(1, 10)):
    """the thin region along the unit arc of omega(C) from S counter-clockwise to Eend, on the outside (out=True) or the inside."""
    k = X.R.of(1 + w) if out else X.R.of(1 - w)
    S2, E2 = add(C, smul(k, sub(S, C))), add(C, smul(k, sub(Eend, C)))
    return [Arc(C, 1, S, Eend, True), Seg(Eend, E2), X.arc(C, k, E2, S2, ccw=False), Seg(S2, S)]


def lt1(A, B):
    return X.minmax(A, B, False)[0]


def main(plant=False):
    out, ok_all = [], True

    def rec(tag, got, want):
        nonlocal ok_all
        ok = got == want
        ok_all &= ok
        out.append(f"{tag}: {got} (registered {want}) {'as registered' if ok else '*** NOT AS REGISTERED ***'}")

    p, q4, q1 = V(0, 0), E(0), E(60)
    # A
    x = V(Fr(-1, 5), Fr(3, 5))
    d = nn(sub(x, q4))
    rec(f"A  |q2 + e(tau) - q4|^2 = {d.e} > 1", "TRUE" if (d - 1).sign() > 0 else "FALSE", "TRUE")
    # B
    z = add(q4, V(Fr(3, 500), Fr(-4, 500)))
    d = nn(sub(z, q1))
    rec(f"B  |q4 + e(306.87)/100 - q1|^2 = {float(d):.6f} > 1", "TRUE" if (d - 1).sign() > 0 else "FALSE", "TRUE")
    # C
    pr4 = probe(add(q4, smul(X.R.of(Fr(1, 100)), E(300))))
    rec("C1 wedge [330,0] at q1 vs probe at q4: min < 1", "TRUE" if lt1(wedge(q1, E(330), E(0)), pr4) else "FALSE", "TRUE")
    rec("C2 control: wedge [30,60] at q1 vs the probe: min < 1", "TRUE" if lt1(wedge(q1, E(30), E(60)), pr4) else "FALSE", "FALSE")
    # D
    pr1 = probe(add(q1, smul(X.R.of(Fr(1, 100)), E(120))))
    rec("D1 wedge [90,120] at q4 vs probe at q1: min < 1", "TRUE" if lt1(wedge(q4, E(90), E(120)), pr1) else "FALSE", "TRUE")
    rec("D2 control: wedge [300,330] at q4 vs the probe: min < 1", "TRUE" if lt1(wedge(q4, E(300), E(330)), pr1) else "FALSE", "FALSE")
    # E
    q3 = E(240)
    c60, s60 = H, S3 / 2
    ct, st = Fr(24, 25), Fr(7, 25)
    e60t = V(c60 * ct - s60 * st, s60 * ct + c60 * st)
    y = add(q3, smul(X.R.of(Fr(99, 100)), e60t))
    d = nn(sub(y, q1))
    rec(f"E1 |q3 + (99/100)e(60+tau) - q1|^2 = {float(d):.6f} > 1", "TRUE" if (d - 1).sign() > 0 else "FALSE", "TRUE")
    y = smul(X.R.of(Fr(1, 100)), E(120))
    d = nn(sub(y, q1))
    rec(f"E2 control |e(120)/100 - q1|^2 = {float(d):.6f} < 1", "TRUE" if (d - 1).sign() < 0 else "FALSE", "TRUE")
    # F: the k = 1 straddle at alpha_2 = 90 (v2 = e(120) = q1 + e(180))
    v2 = E(120)
    a = add(v2, V(Fr(4, 5), Fr(3, 5)))          # v2 + e(36.87)
    b = add(q1, V(Fr(-4, 5), Fr(3, 5)))         # q1 + e(143.13)
    a_cw = add(v2, V(Fr(4, 5), Fr(-3, 5)))       # v2 + e(-36.87)
    A_out = sliver(v2, a_cw, q1, out=True) if plant else sliver(v2, q1, a, out=True)   # T1's side: outside omega(v2)
    B_out = sliver(q1, b, v2, out=True)          # O2's side: outside omega(q1), from b counter-clockwise to v2
    c = add(q1, V(Fr(-4, 5), Fr(-3, 5)))        # q1 + e(216.87): the arc from v2 into the disc
    B_into = sliver(q1, v2, c, out=True)
    rec(f"F1 {'(PLANT: first arc reversed) ' if plant else ''}straddle verdict", X.verdict(A_out, B_out, False)[0],
        "ACCEPT" if plant else "REJECT")
    rec("F2 control: second sliver along the arc from v2 into the disc", X.verdict(A_out, B_into, False)[0], "ACCEPT")
    return out, ok_all


if __name__ == "__main__":
    plant = "--plant" in sys.argv
    print("calibration first (FS114-YB3's controls, unedited):")
    XR.calib()
    print("E1 checks:")
    lines, ok = main(plant)
    for ln in lines:
        print(" ", ln)
    print("ALL AS REGISTERED" if ok else "*** SOME NOT AS REGISTERED ***")
    sys.exit(0 if ok else 1)
