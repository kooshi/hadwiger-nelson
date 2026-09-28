#!/usr/bin/env python3
"""FS111-M2: the body K of DISCK7 — exact / symbolic checks (sympy + Fractions).

K is the convex body with support function h(t) = 1/2 + delta * sin(3t)^3, delta = 1/200.
DISCK7's class a is the union of translates of K centred at hex7's colour-a centres.
Checked here (each claim of M2-DISCK7 that is about K itself):

  CW   constant width 1:           h(t) + h(t + pi) == 1                      (symbolic)
  CONV strictly convex, C^oo:      rho = h + h'' > 0; with s = sin 3t,
                                   rho = 1/2 + delta*(54 s - 80 s^3)          (symbolic identity),
                                   min over s in [-1, 1] computed exactly (rational critical points)
  NONC not a circle:               rho is not constant                          (exact: rho(s=1) != rho(s=0))
  HEX  contains the regular hexagon of circumradius 1/2 (vertices at angles 60k degrees):
       h(t) >= (1/2) cos(t - 60k deg) for the nearest vertex.  Since sin^3(3(t + pi/3)) =
       -sin^3(3t), both signs of the perturbation occur, and it suffices that
       (1 - cos u)/2 >= delta * |sin 3u|^3 for |u| <= pi/6; with |sin 3u| <= 3|u| and
       1 - cos u >= u^2/2 - u^4/24 this follows from 1/4 - u^2/48 - 27 delta |u| >= 0,
       decreasing in |u|, checked exactly at u = 11/20 > pi/6.
  RAD  every boundary point within sqrt(max h^2 + max h'^2) <= 0.51 of the centre, and the
       disc of radius min h >= 0.49 inside K (support numbers, exact bounds).
  LAT  with hex7's colour lattice (min distance sqrt(21)/2, covering radius sqrt(7)/2):
       copies of one class are more than 1 apart: sqrt(21)/2 - 2*0.51 > 1   (exact, squared)
       every point is within < 1 of a copy: sqrt(7)/2 - 0.49 < 1            (exact, squared)
       each centre is exclusive: sqrt(3)/2 > 0.51                           (exact, squared)

Plants: delta*sin(3t)^2 (not constant width -> CW fails), delta = 1/30 (rho < 0 somewhere ->
CONV fails), delta = 0 (a circle -> NONC fails).  Output data/fs111/fs111-m2/disck7.out.
"""
from fractions import Fraction as Fr
import sys
import sympy as sp

OUT = "data/fs111/fs111-m2/disck7.out"
lines = []


def log(s=""):
    print(s)
    lines.append(s)


def check(name, delta, power, want_fail):
    t = sp.symbols("t", real=True)
    h = sp.Rational(1, 2) + delta * sp.sin(3 * t) ** power
    fails = set()
    # CW
    if sp.simplify(sp.expand_trig(h + h.subs(t, t + sp.pi) - 1)) != 0:
        fails.add("CW")
    # CONV and NONC: rho as a polynomial in s = sin 3t (power 3 only; power 2 is a plant for CW)
    rho = sp.simplify(h + sp.diff(h, t, 2))
    s = sp.symbols("s", real=True)
    if power == 3:
        target = sp.Rational(1, 2) + delta * (54 * s - 80 * s ** 3)
        # verify the identity at the substitution s = sin 3t, cos^2 3t = 1 - s^2
        diff = sp.simplify(sp.expand(rho - target.subs(s, sp.sin(3 * t))).rewrite(sp.sin))
        diff = sp.simplify(sp.expand_trig(diff))
        if diff != 0:
            fails.add("RHO-IDENTITY")
        poly = sp.Poly(target, s)
        crit = [r for r in sp.solve(sp.diff(target, s), s) if r.is_real and -1 <= r <= 1] + [-1, 1]
        vals = [target.subs(s, r) for r in crit]
        rmin, rmax = min(vals), max(vals)
        if not rmin > 0:
            fails.add("CONV")
        if rmin == rmax:
            fails.add("NONC")
        log(f"[{name}] rho = 1/2 + delta*(54 s - 80 s^3); exact range over s in [-1,1]: [{sp.nsimplify(rmin)}, {sp.nsimplify(rmax)}]"
            f" ~ [{float(rmin):.4f}, {float(rmax):.4f}]")
    else:
        # power 2: rho = 1/2 + delta*(sin^2 u + 9*(2cos 2u)) — not needed for the plant's own failure
        pass
    # HEX (only meaningful for power 3; exact sufficient condition)
    d = Fr(delta.p, delta.q) if isinstance(delta, sp.Rational) else Fr(delta)
    u = Fr(11, 20)
    if power == 3 and not (Fr(1, 4) - u * u / 48 - 27 * d * u >= 0):
        fails.add("HEX")
    # RAD and LAT (power 3): max h <= 1/2 + d, |h'| <= 9d, min h >= 1/2 - d
    if power == 3:
        R2 = (Fr(1, 2) + d) ** 2 + (9 * d) ** 2          # squared outer radius bound
        rin = Fr(1, 2) - d
        # copies > 1 apart: sqrt(21)/2 - 2R > 1  <=>  21/4 > (1 + 2R)^2 ; use R <= 51/100 if R2 <= (51/100)^2
        R = Fr(51, 100)
        if not R2 <= R * R:
            fails.add("RAD")
        if not Fr(21, 4) > (1 + 2 * R) ** 2:
            fails.add("LAT-sep")
        # covering: sqrt(7)/2 - rin < 1  <=>  7/4 < (1 + rin)^2
        if not Fr(7, 4) < (1 + rin) ** 2:
            fails.add("LAT-cover")
        # exclusive centres: sqrt(3)/2 > R  <=>  3/4 > R^2
        if not Fr(3, 4) > R * R:
            fails.add("LAT-excl")
    got = fails
    ok = (got == want_fail)
    log(f"   -> {name}: expected failures {sorted(want_fail) or 'none'}, got {sorted(got) or 'none'}: {'PASS' if ok else 'FAIL'}")
    return ok


def main():
    log("FS111-M2: DISCK7's body K (tools/fs111_m2_disck7.py)")
    ok = True
    ok &= check("K (faithful): h = 1/2 + sin(3t)^3/200", sp.Rational(1, 200), 3, set())
    ok &= check("plant: h = 1/2 + sin(3t)^2/200", sp.Rational(1, 200), 2, {"CW"})
    ok &= check("plant: h = 1/2 + sin(3t)^3/30", sp.Rational(1, 30), 3, {"CONV", "HEX", "RAD"})
    ok &= check("plant: h = 1/2 (a circle)", sp.Rational(0), 3, {"NONC"})
    log("ALL PASS" if ok else "SOME CHECK FAILED")
    with open(OUT, "w") as fh:
        fh.write("\n".join(lines) + "\n")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
