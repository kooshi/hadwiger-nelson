#!/usr/bin/env python3
"""FS112-N: exact checks (rational arithmetic, seconds) of the inequalities behind four derived statements of
plans/FS112-N-proof.md.  Each check exhibits named points whose squared distances straddle 1, or stay on one side, exactly;
the derivations are in the record, the checks only confirm the arithmetic at named values.

  R2      a tile of the OUTER side colour inside B(P, 2) touching the radius-2 circle beyond the arc: its points and the outer tile's
          points have squared distances on both sides of 1 (N-E2 forbids it); the faithful twin (a tile OUTSIDE B(P, 2)) is at
          distance > 1 from every point of the closed unit disc by the triangle inequality, checked at the same points.
  END     N112-END: with the lower arc of the a_{k+1}-horn at P_{k+1} an arc of omega(P_k) (curvature -1), a point z of the -n
          half-plane at P_k has horn points at squared distance < 1 and > 1 (so, the horn being connected, exactly 1).
          Twin: with that lower arc of curvature -1/2 (centre (0,-1), radius 2), a -n point below the shadow circle is farther
          than 1 from the whole region beyond that arc.
  BAND    row 7: with the horn's upper arc an arc of omega(N), a horn point z has points of an in-type g-tile at N (a disc of radius
          1/5 about N intersected with B(v,1)) at squared distance < 1 and > 1.
  L60     N112-L60: an outer tile beside a unit arc of angular length 60 deg has diameter > 1 (chord of the two ends is 1, outer
          points at radius 1+eps are (1+eps) apart); a 50 deg arc's outer points at the same eps stay within 1.

Planted faults (--plant NAME) must turn their check's verdict for their own reason:
  r2_outside   run R2 with the tile moved outside B(P,2): the straddle must DISAPPEAR (both sampled distances > 1)
  end_half     run END with the lower curvature -1/2: the chosen z must NOT straddle the region (the wedge is gone)
  band_below   run BAND with z moved below the horn's lower arc into h's sector: z is then not a horn point, the check must refuse
Exit 0 iff every check gives its expected verdict.
"""
from __future__ import annotations
import sys
from fractions import Fraction as F

try:
    import sympy as sp
except ImportError:  # L60 needs one square root; everything else is rational
    sp = None

PLANT = None


def d2(p, q):
    return (p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2


def upt(t):
    """rational point of the unit circle, t = tan(phi/2)."""
    t = F(t)
    return ((1 - t * t) / (1 + t * t), 2 * t / (1 + t * t))


def check_R2():
    P = (F(0), F(0))
    ew = (F(0), F(1))                    # the arc through w = (0,1), P's arc runs about +90 deg
    eps, dl = F(1, 100), F(1, 100)
    rad_X = 2 + dl if PLANT == "r2_outside" else 2 - dl
    x_tile = (rad_X * ew[0], rad_X * ew[1])          # a point of the s_out tile X near Q = P + 2 e_w
    # the side tile tested against X: T_out (radius 1+eps) for the outer colour inside B(P,2); for the twin, the INNER colour
    # outside B(P,2) is tested against T_in (radius 1-eps) -- the pair N-E2 actually constrains (a first version of this twin
    # used T_out, whose points reach distance exactly 1 from X along a ray: the plant exposed it)
    r_side = 1 - eps if PLANT == "r2_outside" else 1 + eps
    near = (r_side * ew[0], r_side * ew[1])           # the side tile beside w
    u = upt(F(3, 4))                                 # a point of alpha about 16 deg from w (t = 3/4: phi = 73.7 deg)
    far = (r_side * u[0], r_side * u[1])             # the side tile beside that point
    a, b = d2(near, x_tile), d2(far, x_tile)
    straddle = (a < 1) != (b < 1)
    print(f"R2: side tile {'T_in' if PLANT == 'r2_outside' else 'T_out'}: |side(w) - X|^2 = {float(a):.6f}, |side(w') - X|^2 = {float(b):.6f}, straddle = {straddle}")
    if PLANT == "r2_outside":
        # twin: every point of the closed unit disc is >= 1 + dl from X's points (triangle inequality); sampled here
        ok = a > 1 and b > 1 and not straddle
        print("  twin (X outside B(P,2)): both > 1:", ok)
        return ok
    return straddle


def check_END():
    z = (F(1, 10), -F(1, 1000))          # a point of the -n half-plane at P_k = (0,0), a_{k+1}'s sector
    if PLANT == "end_half":
        # lower arc at P_{k+1} = (0,1) of upward curvature -1/2: centre (0,-1), radius 2; the region beyond it is |h - c| > 2.
        c = (F(0), F(-1))
        zz = (F(1, 10), -F(1, 100))       # below the shadow circle (curvature f(-1/2) = -1 at P_k: y = -x^2/2 = -1/200)
        dist_in = d2(zz, c)               # zz inside the radius-2 circle iff dist_in < 4; nearest point beyond is at 2 - |zz - c|
        escapes = dist_in < 1             # 2 - |zz - c| > 1  <=>  |zz - c| < 1
        print(f"END twin: |z - c|^2 = {float(dist_in):.6f}; region beyond the arc farther than 1 from z: {escapes}")
        return escapes
    h1 = tuple(F(1001, 1000) * x for x in upt(F(9, 10)))      # just outside omega(P_k), below y = 1 (upper arc: straight, y = 1)
    h2 = (F(1, 1000), 1 - F(1, 10 ** 7))                        # just outside omega(P_k) near P_{k+1}
    for h in (h1, h2):
        assert h[0] > 0 and h[1] < 1 and d2(h, (0, 0)) > 1, "horn point outside the horn"
    a, b = d2(z, h1), d2(z, h2)
    straddle = (a < 1) != (b < 1)
    print(f"END: |z - h1|^2 = {float(a):.6f}, |z - h2|^2 = {float(b):.6f}, straddle = {straddle}")
    return straddle


def check_BAND():
    N = (F(0), F(1))
    z = (F(1, 10), F(1, 200))             # just below omega(N) at x = 1/10 (omega(N) there at y = 0.0050126), above y = 0
    if PLANT == "band_below":
        z = (F(1, 10), -F(1, 100))        # below the horn's lower arc (curvature 0): h's sector, not the horn
    in_horn = d2(z, N) > 1 and z[1] > 0
    p1 = (F(0), F(9, 10))
    p2 = (-F(1, 100), F(9999, 10000))
    for p in (p1, p2):
        assert d2(p, (0, 0)) < 1 and d2(p, N) < F(1, 25), "g-tile point outside the in-type tile"
    a, b = d2(z, p1), d2(z, p2)
    straddle = (a < 1) != (b < 1)
    print(f"BAND: z in horn = {in_horn}; |z - p1|^2 = {float(a):.6f}, |z - p2|^2 = {float(b):.6f}, straddle = {straddle}")
    return in_horn and straddle


def check_L60():
    if sp is None:
        print("L60: sympy missing; skipped (not a pass)")
        return False
    eps = sp.Rational(1, 100)
    ok = True
    for deg, expect_over in ((60, True), (50, False)):
        e1 = sp.Matrix([sp.cos(sp.pi / 2), sp.sin(sp.pi / 2)])
        e2 = sp.Matrix([sp.cos(sp.pi / 2 - sp.pi * deg / 180), sp.sin(sp.pi / 2 - sp.pi * deg / 180)])
        dist2 = sp.nsimplify(((1 + eps) * (e1 - e2)).dot((1 + eps) * (e1 - e2)))
        over = sp.simplify(dist2 - 1) > 0
        print(f"L60: arc {deg} deg, outer points at radius 1+1/100 at its ends: squared distance {sp.N(dist2, 8)}, > 1: {over}")
        ok &= (bool(over) == expect_over)
    return ok


def main(argv):
    global PLANT
    if "--plant" in argv:
        PLANT = argv[argv.index("--plant") + 1]
    checks = {"R2": check_R2, "END": check_END, "BAND": check_BAND, "L60": check_L60}
    if PLANT == "r2_outside":
        checks = {"R2": check_R2}
    elif PLANT == "end_half":
        checks = {"END": check_END}
    elif PLANT == "band_below":
        checks = {"BAND": check_BAND}
    results = {k: f() for k, f in checks.items()}
    if PLANT == "band_below":
        good = results["BAND"] is False
        print("PLANT band_below:", "fired (refused)" if good else "DID NOT FIRE")
        return 0 if good else 1
    if PLANT in ("r2_outside", "end_half"):
        good = all(results.values())
        print(f"PLANT {PLANT}: twin behaves as derived" if good else f"PLANT {PLANT}: twin FAILED")
        return 0 if good else 1
    bad = [k for k, v in results.items() if not v]
    print("ALL CHECKS PASS" if not bad else f"FAILED: {bad}")
    return 0 if not bad else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
