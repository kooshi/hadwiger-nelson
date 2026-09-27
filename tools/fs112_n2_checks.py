#!/usr/bin/env python3
"""FS112-N2: exact checks (sympy / rationals, seconds) of the identities behind plans/FS112-N-proof.md's R2, END and L60, rebuilt so that
each check can go RED, and does under its planted fault, for a named reason (FS112-NB divergence 15: the frozen tools/fs112_n_arcs.py's
plants r2_outside and end_half are twins that exit 0, and no plant turned R2, END or L60 red).  tools/fs112_n_arcs.py stays frozen.

Every check returns (ok, reason, detail).  `reason` is one code from REASONS; a check is GREEN iff ok.  A planted fault must turn exactly
its own check RED, with exactly its expected reason code (so a plant that dies of the scaffolding -- an index error, an assert -- is a
DEFECT, not a firing).  `--self-test` runs every plant and the faithful run.

Frame: P = 0 the unit-arc centre, w = e_0 = (1, 0) interior to the arc alpha of omega(P); T_out beyond alpha (|p| > 1 near w), T_in
inside (|p| < 1 near w).

  R2OUT  (N112-LOCK, outer colour at Q = P + 2e_w): T_out near w has points p = (1 + t)e_phi at squared distance
         (1 - t)^2 + 4(1 + t)(1 - cos phi) from Q: below 1 at phi = 0, above 1 once 1 - cos phi > (2t - t^2)/(4 + 4t).  So T_out straddles omega(Q) near w and N-E2 forbids ANY tile of colour s_out
         at Q (inside or outside B(P, 2)).  Expected: STRADDLE.
         plant r2_inner: hand the check T_in's points (1 - t)e_phi instead: both farther than 1 from Q -> RED, NO_STRADDLE.
  R2IN   (N112-LOCK, inner colour near Q): a point Y = (2 - eta, 0) inside B(P, 2) near Q is shadowed by T_in: (1 - t)e_0 is within
         1 - eta + t < 1 of Y (t < eta) and (1 - t)e_phi, at a small angle phi, farther than 1.  Expected: STRADDLE (Y cannot be in an s_in tile).
         plant r2in_outside: Y = (2 + eta, 0): every point of the closed unit disc is >= |Y| - 1 > 1 from Y (triangle inequality,
         checked as an exact bound) -> RED, UNSHADOWED.
  END    (N112-END's contradiction at P_k = 0, n = (0, 1), P_{k+1} = (0, 1)): the a_{k+1}-horn at P_{k+1} along +a lies just above its
         lower arc, of upward curvature lam at P_{k+1} (centre c = (0, 1 + 1/lam), radius R = -1/lam for lam < 0).  With lam = -1 the lower
         arc is an arc of omega(P_k); a point z = (1/100, -1/1000) of the -n half-plane at P_k (a_{k+1}'s sector by N4-STUCK (ii); its
         direction is 5.7 deg below +a) has lower-arc points (hence horn points) at squared distance > 1 (next to P_{k+1}) and < 1 (11.4 deg
         along the arc): N112-U1's facing cone of width pi + l.  Named values: the arc runs at least 12 deg.  Expected: STRADDLE.
         plant end_half: lam = -1/2 at the same z: the exact bound R - |z - c| > 1 shows every horn point farther than 1 (z lies below the
         shadow circle of curvature f(-1/2) = -1) -> RED, UNSHADOWED.
  L60    (N112-L60): the two ends of an arc of angular length l carry outer-tile points (1 + eps)e_1, (1 + eps)e_2 at squared distance
         (1 + eps)^2 * 4 sin^2(l/2); at l = 60 deg that exceeds 1, so diam T_out > 1 (TS-C).  Expected: DIAM_OVER.
         plant l60_fifty: l = 50 deg: the same points are within 1 -> RED, DIAM_OK.

Exit 0 iff the requested run behaves as expected (faithful: all GREEN; --plant X: exactly X RED with its reason; --self-test: all of it).
"""
from __future__ import annotations

import argparse
import sys
from fractions import Fraction as F

import sympy as sp

REASONS = ("STRADDLE", "NO_STRADDLE", "UNSHADOWED", "DIAM_OVER", "DIAM_OK")
PLANTS = {"r2_inner": ("R2OUT", "NO_STRADDLE"), "r2in_outside": ("R2IN", "UNSHADOWED"),
          "end_half": ("END", "UNSHADOWED"), "l60_fifty": ("L60", "DIAM_OK")}


def d2(p, q):
    return (p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2


def upt(tau):
    """rational point of the unit circle at angle phi, tan(phi/2) = tau."""
    tau = F(tau)
    return ((1 - tau * tau) / (1 + tau * tau), 2 * tau / (1 + tau * tau))


def scaled(r, u):
    return (r * u[0], r * u[1])


def check_R2OUT(plant: bool):
    Q = (F(2), F(0))
    t, tau = F(1, 10 ** 5), F(1, 200)                  # radial offset from alpha; angular offset from w (about 0.57 deg)
    side = -1 if plant else 1                          # plant: the inner tile's points instead of the outer tile's
    p1, p2 = scaled(1 + side * t, upt(0)), scaled(1 + side * t, upt(tau))
    for p in (p1, p2):                                 # the points are on the claimed side of alpha, near w
        assert (d2(p, (0, 0)) > 1) == (side == 1) and abs(p[1]) < F(1, 50)
    a, b = d2(p1, Q), d2(p2, Q)
    if (a < 1) != (b < 1):
        return True, "STRADDLE", f"|p1-Q|^2 = {float(a):.10f}, |p2-Q|^2 = {float(b):.10f}"
    return False, "NO_STRADDLE", f"|p1-Q|^2 = {float(a):.10f}, |p2-Q|^2 = {float(b):.10f}: both on one side of 1"


def check_R2IN(plant: bool):
    eta, t, tau = F(1, 10 ** 4), F(1, 10 ** 5), F(1, 100)
    Y = (2 + eta, F(0)) if plant else (2 - eta, F(0))
    if d2(Y, (0, 0)) > 4:
        # exact bound: every point p of the closed unit disc has |Y - p| >= |Y| - 1; |Y| - 1 > 1 iff |Y|^2 > 4
        return False, "UNSHADOWED", f"|Y|^2 = {d2(Y, (0, 0))} > 4: all of B(P,1) farther than 1"
    p1, p2 = scaled(1 - t, upt(0)), scaled(1 - t, upt(tau))   # T_in's points near w (angular offset about 1.15 deg)
    for p in (p1, p2):
        assert d2(p, (0, 0)) < 1
    a, b = d2(p1, Y), d2(p2, Y)
    if (a < 1) != (b < 1):
        return True, "STRADDLE", f"|p1-Y|^2 = {float(a):.10f}, |p2-Y|^2 = {float(b):.10f}"
    return False, "NO_STRADDLE", f"{float(a):.6f}, {float(b):.6f}"


def check_END(plant: bool):
    lam = sp.Rational(-1, 2) if plant else sp.Integer(-1)
    z = sp.Matrix([sp.Rational(1, 100), -sp.Rational(1, 1000)])  # the -n half-plane at P_k, direction 5.7 deg below +a, |z| ~ 1/100
    c = sp.Matrix([0, 1 + 1 / lam])
    R = -1 / lam
    # exact lower bound on the distance from z to the region beyond the lower arc: R - |z - c| (z inside that circle)
    zc = sp.sqrt((z - c).dot(z - c))
    assert sp.simplify(zc - R) < 0, "z not inside the lower arc's circle"
    bound = sp.nsimplify(R - zc)
    if sp.simplify(bound - 1) > 0:
        return False, "UNSHADOWED", f"lam = {lam}: every horn point at distance >= R - |z - c| = {sp.N(bound, 8)} > 1"
    # lam = -1: witnesses on the lower arc (an arc of omega(P_k)) near P_{k+1}: points at upward angle phi from n, rational
    def arc_pt(tt):                                    # (sin phi, cos phi) with tan(phi/2) = tt, on the circle of radius R about c
        tt = sp.Rational(tt)
        return c + R * sp.Matrix([2 * tt / (1 + tt ** 2), (1 - tt ** 2) / (1 + tt ** 2)])
    near_pk1, further = arc_pt(sp.Rational(1, 1000)), arc_pt(sp.Rational(1, 10))   # phi ~ 0.1 deg and ~ 11.4 deg past n
    a = sp.nsimplify((z - near_pk1).dot(z - near_pk1))
    b = sp.nsimplify((z - further).dot(z - further))
    # horn points are just beyond the lower arc; strict inequalities at the arc points survive a small push beyond it
    if (a > 1) and (b < 1):
        return True, "STRADDLE", f"lam = -1: arc points at squared distance {sp.N(a, 8)} and {sp.N(b, 8)} from z"
    return False, "NO_STRADDLE", f"{sp.N(a, 8)}, {sp.N(b, 8)}"


def check_L60(plant: bool):
    l = sp.pi * (sp.Rational(50, 180) if plant else sp.Rational(60, 180))
    eps = sp.Rational(1, 100)
    dist2 = sp.nsimplify(sp.expand_trig((1 + eps) ** 2 * 4 * sp.sin(l / 2) ** 2))
    over = bool(sp.simplify(dist2 - 1) > 0)
    return (True, "DIAM_OVER", f"l = {l}: squared distance {dist2} > 1") if over else \
        (False, "DIAM_OK", f"l = {l}: squared distance {sp.N(dist2, 8)} <= 1")


CHECKS = {"R2OUT": check_R2OUT, "R2IN": check_R2IN, "END": check_END, "L60": check_L60}


def run(plant: str | None):
    out = {}
    for name, fn in CHECKS.items():
        is_planted = plant is not None and PLANTS[plant][0] == name
        out[name] = fn(is_planted)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=sorted(PLANTS))
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        bad = 0
        for p, (target, reason) in PLANTS.items():
            res = run(p)
            red = [n for n, r in res.items() if not r[0]]
            fired = red == [target] and res[target][1] == reason
            bad += not fired
            print(f"plant {p:13s}: red {red}, reason {res[target][1]} -> {'FIRES' if fired else 'DEFECT'}")
        res = run(None)
        red = [n for n, r in res.items() if not r[0]]
        print(f"faithful run: red {red} -> {'PASS' if not red else 'DEFECT'}")
        return 1 if (bad or red) else 0
    res = run(args.plant)
    for n, (ok, reason, detail) in res.items():
        print(f"{n:5s}: {'GREEN' if ok else 'RED  '} {reason:11s} {detail}")
    red = [n for n, r in res.items() if not r[0]]
    if args.plant is None:
        return 0 if not red else 1
    target, reason = PLANTS[args.plant]
    return 0 if (red == [target] and res[target][1] == reason) else 1


if __name__ == "__main__":
    sys.exit(main())
