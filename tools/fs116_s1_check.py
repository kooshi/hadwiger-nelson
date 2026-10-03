#!/usr/bin/env python3
"""FS116-S1 exact checks (sympy), each a control with a planted fault.

  ceil   FS116-S1-RUNG at the strip's contact V = r(120°): the rung (s, 1) leaves B̄(V, 1) exactly at
         x* = −1/2 + √(√3 − 3/4) (FS116-Y1-STRIPCEIL's number); F(1/5)'s 1/5 is inside, the strip's 1/2 outside.
         --plant moves the contact to r(110°).
  exit   FS116-S1-EXIT's two identities, symbolic in the change-point angles a, b and the side point's angle:
         on the lower side ω(y_b) with heading τ (the side's tangent away from p), P = x + ν equals y_b and
         |y_b − y_3| = 1 for y_3 = r(b + 60°); d|P − y_3|²/dβ at τ equals −2cos(φ − b + 150°); and the mirror
         identities on the upper side ω(y_a) with y_5 = r(a − 60°). The signs are then read on the parameter
         ranges (b ∈ (30°, 90°), a ∈ (−90°, −30°), the side point between the lens tips) at 3,675 rational points a side.
         --plant puts y_3 at r(b − 60°): the identities hold but the sign flips.
  sq9    the step where six is spent: in FS111-W-SQ9 (side 1/2, colour (i mod 3, j mod 3)), about the grid point p = 0,
         the ring points r(45°) and r(225°) carry the same colour (1, 1), so the antipodal clause of FS116-S1-KAPPA
         fails at k = 9; r(45°) and r(105°) differ (N-E1). --plant reads r(225°) as r(255°).
Run from anywhere: python3 tools/fs116_s1_check.py {ceil|exit|sq9} [--plant]
"""
import math
import sys
from fractions import Fraction as Fr

import sympy as sp

PLANT = "--plant" in sys.argv


def ceil():
    s3 = sp.sqrt(3)
    ang = 110 if PLANT else 120
    V = sp.Matrix([sp.cos(sp.rad(ang)), sp.sin(sp.rad(ang))])
    xs = -sp.Rational(1, 2) + sp.sqrt(s3 - sp.Rational(3, 4))
    d2 = lambda x: sp.nsimplify(sp.simplify((x - V[0]) ** 2 + (1 - V[1]) ** 2))
    exact = sp.simplify(d2(xs) - 1) == 0
    inside = sp.N(d2(sp.Rational(1, 5)) - 1, 30) < 0
    outside = sp.N(d2(sp.Rational(1, 2)) - 1, 30) > 0
    print(f"RUNG-CEIL: |V-(x*,1)|=1 {exact}; 1/5 inside {inside}; 1/2 outside {outside}; x*={sp.N(xs, 8)}")


def e(t):
    return sp.Matrix([sp.cos(t), sp.sin(t)])


def exit_():
    a, b, f = sp.symbols("a b f", real=True)
    d60 = sp.pi / 3
    yb, ya = e(b), e(a)
    y3 = e(b - d60) if PLANT else e(b + d60)
    y5 = e(a - d60)
    # lower side: x = y_b + e(f), heading tau = f + 90°, left normal nu = e(tau + 90°) = e(f + 180°)
    x = yb + e(f)
    tau = f + sp.pi / 2
    beta = sp.symbols("beta", real=True)
    P = x + e(beta + sp.pi / 2)
    id1 = sp.simplify((P.subs(beta, tau) - yb).norm()) == 0
    id2 = sp.simplify(sp.expand_trig(((yb - y3).T * (yb - y3))[0] - 1)) == 0
    der = sp.diff(((P - y3).T * (P - y3))[0], beta).subs(beta, tau)
    id3 = sp.simplify(sp.expand_trig(der + 2 * sp.cos(f - b + 5 * sp.pi / 6))) == 0
    # upper side: x = y_a + e(g), heading tau' = g − 90°, left normal e(g); Q = x − nu
    g = sp.symbols("g", real=True)
    xu = ya + e(g)
    tu = g - sp.pi / 2
    Q = xu - e(beta + sp.pi / 2)
    id4 = sp.simplify((Q.subs(beta, tu) - ya).norm()) == 0
    id5 = sp.simplify(sp.expand_trig(((ya - y5).T * (ya - y5))[0] - 1)) == 0
    deru = sp.diff(((Q - y5).T * (Q - y5))[0], beta).subs(beta, tu)
    id6 = sp.simplify(sp.expand_trig(deru - 2 * sp.cos(g - a - 5 * sp.pi / 6))) == 0
    # signs on the ranges, at rational sample points (degrees)
    fl = sp.lambdify((a, b, f), der)
    gl = sp.lambdify((a, g), deru)
    neg = pos = 0
    n = 0
    for i in range(1, 36):
        bd = 30 + Fr(60 * i, 36)
        for j in range(1, 36):
            ad = -90 + Fr(60 * j, 36)
            if bd - ad >= 180:
                continue
            for k in range(1, 4):
                # lower side point angle phi in (b + 180°, a + 360°); upper side angle g in (b, a + 180°)
                ph = bd + 180 + (ad + 180 - bd) * Fr(k, 4)
                gg = bd + (ad + 180 - bd) * Fr(k, 4)
                n += 1
                if fl(math.radians(ad), math.radians(bd), math.radians(ph)) < 0:
                    neg += 1
                if gl(math.radians(ad), math.radians(gg)) > 0:
                    pos += 1
    print(f"EXIT: P=y_b {id1}; |y_b-y_3|=1 {id2}; dP-form {id3}; Q=y_a {id4}; |y_a-y_5|=1 {id5}; dQ-form {id6}; "
          f"lower d<0 at {neg}/{n}; upper d>0 at {pos}/{n}")


def sq9():
    def col(pt):
        i = math.floor(pt[0] / Fr(1, 2))
        j = math.floor(pt[1] / Fr(1, 2))
        return (i % 3, j % 3)
    r2 = Fr(7071, 10000)  # r(45°) = (√2/2, √2/2) lies inside square (1, 1): 1/2 < √2/2 < 1
    c45 = col((r2, r2))
    c225 = col((-r2, -r2)) if not PLANT else col((Fr(-2588, 10000), Fr(-9659, 10000)))
    c105 = col((Fr(-2588, 10000), Fr(9659, 10000)))
    print(f"SQ9 k=9: r(45)={c45} r(225)={c225} same {c45 == c225}; r(105)={c105} differs from r(45) {c105 != c45}")


if __name__ == "__main__":
    {"ceil": ceil, "exit": exit_, "sq9": sq9}[sys.argv[1]]()
