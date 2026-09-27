#!/usr/bin/env python3
"""FS112-NB exact checks of derived identities (blind verification of FS-112's proof side).

Each check verifies, in exact symbolic arithmetic (sympy), one identity that a verdict in
plans/FS112-NB-verification.md rests on.  No search: every check is a closed-form identity or a
finite list of named cases fixed by the derivation.  Each check has a planted fault (--plant NAME)
that must make exactly that check fail, for its own named reason.

  U1     the closed cone of directions d with d.e_theta >= 0 for all theta in [0, l] is
         [l - 90deg, 90deg]: width pi - l (the facing cone of a unit arc of angular length l).
  L60    at an interior point w of a unit arc (w = e_0, arc through angles near 0), the squared distance
         from the inner / outer tile points (1 -+ t)e_phi to w' = e_60 is 1 -+ t + t^2 at phi = 0 and has
         nonzero phi-derivative -(1 -+ t)sqrt3 there: the side tiles meet both sides of omega(w'), so
         neither is Siamese nor outer with a same-colour tile at w' (N-E2).
  LOCK   for q on omega(w) (w = e_0, P = 0), omega(q) is tangent to the arc omega(P) at w iff q is P or
         P + 2e_w: the tangent of omega(q) at w is parallel to the arc's tangent only there.
  HP60   (NB-4's budget) three closed half-planes whose boundary lines are perpendicular to directions
         0, 120, 240 deg, each facing or facing away: the intersection is an arc of at most 60 deg
         (8 named sign choices).
  FLAT   (N4-SHADOW/N4-SHAVE) f(l) = l/(1+l): f(-1/2) = -1, i.e. an h-tile at N beyond an arc of
         upward curvature -1/2 (the radius-2 circle about S') shadows v's side of omega(S') exactly.
  CUSP   (CUSP-BASE) |u + s n - x(m)|^2 - 1 = 4R(R - s)m^2/(1+m^2) for the circle of radius R tangent to a
         at u, s = +-1; it vanishes identically exactly at R = s (the arc is a unit arc centred at u + s n).
"""
import argparse
import sys

import sympy as sp

PLANTS = ("U1", "L60", "LOCK", "HP60", "FLAT", "CUSP")


def check_U1(plant):
    l = sp.symbols("l", positive=True)
    # extreme admissible directions: d.e_theta >= 0 for all theta in [0, l]  <=>  d in [l - pi/2, pi/2]
    lo, hi = l - sp.pi / 2, sp.pi / 2
    if plant:
        lo = l - sp.pi / 3          # planted: a wrong lower edge
    th = sp.symbols("th")
    # at the lower edge, the constraint from theta = l is tight: cos(lo - l) = 0; at the upper edge, theta = 0
    ok = sp.simplify(sp.cos(lo - l)) == 0 and sp.simplify(sp.cos(hi - 0)) == 0
    width = sp.simplify(hi - lo)
    ok = ok and sp.simplify(width - (sp.pi - l)) == 0
    return ok, f"width = {width}"


def check_L60(plant):
    t, phi = sp.symbols("t phi", real=True)
    wp = sp.Matrix([sp.Rational(1, 2), sp.sqrt(3) / 2])        # w' = e_60, |w - w'| = 1
    res = []
    for s in (+1, -1):                                         # +1 outer tile, -1 inner tile
        z = (1 + s * t) * sp.Matrix([sp.cos(phi), sp.sin(phi)])
        D = sp.expand((z - wp).dot(z - wp))
        v0 = sp.simplify(D.subs(phi, 0))
        d0 = sp.simplify(sp.diff(D, phi).subs(phi, 0))
        want_v0 = 1 + s * t + t**2
        want_d0 = -(1 + s * t) * sp.sqrt(3)
        if plant:
            want_d0 = 0                                        # planted: a tangent (non-crossing) contact
        res.append(sp.simplify(v0 - want_v0) == 0 and sp.simplify(d0 - want_d0) == 0)
    return all(res), "value 1 -+ t + t^2, slope -(1 -+ t)sqrt3 at phi = 0"


def check_LOCK(plant):
    a = sp.symbols("a", real=True)                             # q = w + e_a, a point of omega(w), w = e_0
    w = sp.Matrix([1, 0])
    q = w + sp.Matrix([sp.cos(a), sp.sin(a)])
    # tangent of omega(q) at w is perpendicular to (w - q); the arc's tangent at w is (0, 1)
    rad = w - q
    cross = sp.simplify(rad[1])        # (w - q) parallel to (1, 0) <=> its y-component vanishes: tangent parallel to (0,1)
    sols = sp.solveset(sp.Eq(cross, 0), a, sp.Interval.Ropen(0, 2 * sp.pi))
    pts = sorted({tuple(sp.simplify(q.subs(a, s))) for s in sols})
    want = sorted({(0, 0), (2, 0)})
    if plant:
        want = sorted({(0, 0)})                                # planted: forgets P + 2e_w
    return pts == want, f"tangent at q in {pts}"


def check_HP60(plant):
    # half-plane facing (s = +1) or away (s = -1) from y_k at angle 120k deg: centre angle 120k + (0 or 180)
    import itertools
    worst = 0
    for signs in itertools.product((0, 180), repeat=3):
        centres = [(120 * k + signs[k]) % 360 for k in range(3)]
        # intersection of three closed 180-deg arcs centred at c_i: length = max(0, 180 - spread),
        # spread = the least arc containing all centres
        cs = sorted(centres)
        gaps = [(cs[(i + 1) % 3] - cs[i]) % 360 for i in range(3)]
        spread = 360 - max(gaps)
        length = max(0, 180 - spread)
        worst = max(worst, length)
    bound = 60 if not plant else 50                            # planted: a bound one step too tight
    return worst <= bound and worst == 60, f"largest intersection = {worst} deg"


def check_FLAT(plant):
    lam = sp.symbols("lam")
    f = lam / (1 + lam)
    val = f.subs(lam, sp.Rational(-1, 2) if not plant else sp.Rational(-1, 3))
    # centre of the arc at N of upward curvature -1/2: 1/(C - 1) = -1/2  =>  C = -1, i.e. S' = v - n, radius |C - 1| = 2
    C = sp.solve(sp.Eq(1 / (sp.Symbol("C") - 1), sp.Rational(-1, 2)), sp.Symbol("C"))
    return val == -1 and C == [-1], f"f(-1/2) = {val}, centre C = {C}"


def check_CUSP(plant):
    R, m = sp.symbols("R m", real=True)
    res = []
    for s in (+1, -1):
        # circle of radius |R| centred at u + R n (u = 0, n = (0,1)), tangent to a = (1,0) at u;
        # rational parametrisation by the slope m of the chord from u
        x = sp.Matrix([2 * R * m / (1 + m**2), 2 * R * m**2 / (1 + m**2)])
        lhs = sp.simplify((sp.Matrix([0, s]) - x).dot(sp.Matrix([0, s]) - x) - 1)
        rhs = 4 * R * (R - s) * m**2 / (1 + m**2)
        if plant:
            rhs = 4 * R * (R + s) * m**2 / (1 + m**2)          # planted: the wrong sign
        res.append(sp.simplify(lhs - rhs) == 0 and sp.simplify(lhs.subs(R, s)) == 0)
    return all(res), "4R(R - s)m^2/(1+m^2), zero at R = s"


CHECKS = {"U1": check_U1, "L60": check_L60, "LOCK": check_LOCK, "HP60": check_HP60, "FLAT": check_FLAT,
          "CUSP": check_CUSP}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=PLANTS)
    ap.add_argument("--self-test", action="store_true", help="run every plant; each must fail its own check only")
    args = ap.parse_args()
    if args.self_test:
        bad = 0
        for p in PLANTS:
            fails = [n for n, fn in CHECKS.items() if not fn(n == p)[0]]
            status = "FIRES" if fails == [p] else "DEFECT"
            bad += status != "FIRES"
            print(f"plant {p:5s}: failing checks {fails} -> {status}")
        clean = [n for n, fn in CHECKS.items() if not fn(False)[0]]
        print(f"faithful run: failing checks {clean} -> {'PASS' if not clean else 'DEFECT'}")
        return 1 if (bad or clean) else 0
    rc = 0
    for n, fn in CHECKS.items():
        ok, msg = fn(args.plant == n)
        print(f"{n:5s}: {'OK  ' if ok else 'FAIL'}  {msg}")
        rc |= not ok
    return rc


if __name__ == "__main__":
    sys.exit(main())
