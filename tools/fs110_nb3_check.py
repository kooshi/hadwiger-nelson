#!/usr/bin/env python3
"""FS110-NB3 exact checks (sympy, seconds). They check identities that the blind verifier's hand derivations
use; they decide nothing on their own and search nothing (no enumeration of colourings or configurations).

Setting: v = 0, n = (0, 1), a = (1, 0), w = v + n; x = v + p near v.
  C1  lens: the height of omega(x) above w at X = 0, g0 = p_y - 1 + sqrt(1 - p_x^2), is >= 0 exactly on
      the lens |p|^2 <= 2 p_y (|p_x| < 1, p_y < 1).  This is the set {w in closed B(x, 1)}.
  C2  horn sign: for a horn point p = (s, kappa s^2 / 2), sign(g0) = sign(kappa - 1) at s = 1/100
      (kappa != 1): the curvature-1 threshold behind N3-DEG's (-1, 1) and W-MERGE's sandwich.
  C3  N3-P17's cone geometry, exact in Q(sqrt 3): change points x_i = e(60 i) on omega(0);
      the outer cone at x_1 is {d : d.(x_1 - x_2) > 0, d.(x_1 - x_0) > 0} = directions within 30 deg of e_1;
      (x_1 - x_2).e_2 = -1/2; and outer-cone points p near x_1, q near x_2 have |p - q| > 1.
  C4  bracketing: every boundary direction b has two consecutive change points (60 deg apart) both
      strictly within 90 deg of b (integer degrees, all b).
Planted faults (env FS110_NB3_PLANT): 'lens' reverses C1's inequality; 'cone' uses x_3 for x_2 in C3;
'bracket' uses a 100-degree spacing in C4.  Each must make its own check fail, and only its own.
"""
import os
import sys
from fractions import Fraction as Fr

import sympy as sp

PLANT = os.environ.get("FS110_NB3_PLANT", "")
fails = []


def check(name, ok, detail=""):
    print(f"{name}: {'PASS' if ok else 'FAIL'} {detail}")
    if not ok:
        fails.append(name)


# C1 -- lens identity, exact on a rational grid
bad = 0
count = 0
for i in range(-9, 10):
    for j in range(-9, 10):
        px, py = sp.Rational(i, 10), sp.Rational(j, 10)
        g0 = py - 1 + sp.sqrt(1 - px**2)
        lens = (px**2 + py**2 >= 2 * py) if PLANT == "lens" else (px**2 + py**2 <= 2 * py)
        count += 1
        if bool(g0 >= 0) != bool(lens):
            bad += 1
check("C1 lens", bad == 0, f"({count} grid points, {bad} mismatches)")

# C2 -- horn sign at s = 1/100
s = sp.Rational(1, 100)
bad = 0
for kappa in [sp.Rational(-3), sp.Rational(1, 2), sp.Rational(99, 100), sp.Rational(101, 100), sp.Rational(2)]:
    px, py = s, kappa * s**2 / 2
    g0 = py - 1 + sp.sqrt(1 - px**2)
    if sp.sign(sp.nsimplify(g0)) != sp.sign(kappa - 1):
        # exact comparison: g0 > 0 iff (1 - py)^2 < 1 - px^2 (py < 1)
        bad += 1
check("C2 horn sign", bad == 0, f"({bad} mismatches)")

# C3 -- P17 cone geometry, exact
r3 = sp.sqrt(3)
def e(k):  # unit vector at 60k degrees, exact
    table = [(1, 0), (sp.Rational(1, 2), r3 / 2), (-sp.Rational(1, 2), r3 / 2), (-1, 0),
             (-sp.Rational(1, 2), -r3 / 2), (sp.Rational(1, 2), -r3 / 2)]
    return sp.Matrix(table[k % 6])
x1, x2, x0 = e(1), e(3 if PLANT == "cone" else 2), e(0)
dot = lambda A, B: sp.simplify((A.T * B)[0])
c3a = dot(e(1), x1 - x2) > 0 and dot(e(1), x1 - x0) > 0          # the mid-direction e_1 is in the cone
rot = lambda A, ang: sp.Matrix([[sp.cos(ang), -sp.sin(ang)], [sp.sin(ang), sp.cos(ang)]]) * A
edge_p, edge_m = rot(e(1), sp.pi / 6), rot(e(1), -sp.pi / 6)
c3b = sp.simplify(dot(edge_p, x1 - x2)) == 0 or sp.simplify(dot(edge_p, x1 - x0)) == 0  # 30 deg is the edge
c3c = sp.simplify(dot(edge_m, x1 - x2)) == 0 or sp.simplify(dot(edge_m, x1 - x0)) == 0
c3d = sp.simplify(dot(x1 - x2, e(2))) == -sp.Rational(1, 2)
t = sp.Rational(1, 100)
p, q = x1 + t * e(1), x2 + t * e(2)
c3e = sp.simplify(dot(p - q, p - q) - 1) > 0
check("C3 P17 cone", all([c3a, c3b, c3c, c3d, c3e]), f"(parts {[c3a, c3b, c3c, c3d, c3e]})")

# C4 -- bracketing pair, integer degrees
spacing = 100 if PLANT == "bracket" else 60
def angdist(a, b):
    d = abs(a - b) % 360
    return min(d, 360 - d)
ok4 = True
for b in range(360):
    pts = list(range(0, 360, spacing))
    found = any(angdist(pts[k], b) < 90 and angdist(pts[(k + 1) % len(pts)], b) < 90
                and angdist(pts[k], pts[(k + 1) % len(pts)]) == 60 for k in range(len(pts)))
    ok4 = ok4 and found
check("C4 bracketing", ok4)

print("ALL PASS" if not fails else f"FAILED: {fails}")
sys.exit(1 if fails else 0)
