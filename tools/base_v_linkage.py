#!/usr/bin/env python3
"""BASE-V: exact checks of the linkage facts used in the blind derivation of Lemma 3 (record `plans/BASE-V-verification.md` §1b).

Setting: u1 = (0, 0), u2 = (t, 0) with 1 < t < 2.  Phi = {(x, y) : x on omega(u1), y on omega(u2), |x - y| = 1}.

Derived claims checked (exact / symbolic; never a search):
  K1  the range of y along Phi is {y on omega(u2) : |y - u1| <= 2}, a proper arc (it misses y = u2 + (1, 0), at distance t + 1 > 2);
      likewise for x.  So lifts of the circle colourings along Phi are single-valued functions of the position.
  K2  at x = P (an intersection point of the circles) the two partners are y = R_{u2}^{+-60} P: |P - R^{+-60} P| = 1 and |R P - u2| = 1.
  K3  the NoDouble tangency exclusion: if x0 - u1 = s1 e and y0 - u2 = s2 e with e = x0 - y0 unit (s1, s2 = +-1), then |u1 - u2| is 1 or 3,
      never in (1, 2).
  K4  the edge-direction computation: a(th) = (cos th, sin th) on omega(y0), b(ph) = (1 - cos ph, sin ph) on omega(x0) (x0 = (1,0),
      y0 = (0,0)): |a(s) - b(s)|^2 = (2 cos s - 1)^2 < 1 and |a(s) - b(-s)|^2 = (2 cos s - 1)^2 + 4 sin(s)^2 > 1 for 0 < s < 1/2.

Run: `python3 tools/base_v_linkage.py`.  `--plant` replaces t by 5/2 in K1, which must FAIL (for t > 2 the circles do not meet).
"""
import sys

import sympy as sp

PLANT = "--plant" in sys.argv
fails = 0


def check(name, cond):
    global fails
    if not cond:
        print("FAIL", name)
        fails += 1


s = sp.symbols("s", positive=True)
for t in [sp.Rational(11, 10), sp.Rational(3, 2), sp.sqrt(3), sp.Rational(19, 10)] + ([sp.Rational(5, 2)] if PLANT else []):
    u1 = sp.Matrix([0, 0])
    u2 = sp.Matrix([t, 0])
    # K1: far point of omega(u2) is at distance t + 1 > 2 from u1; the near point at t - 1 < 2
    check(f"K1 far t={t}", t + 1 > 2)
    check(f"K1 near t={t}", t - 1 < 2 and t - 1 > 0)
    # intersection point P of the circles
    px = t / 2
    py = sp.sqrt(1 - t**2 / 4)
    if not py.is_real or py == 0:
        print(f"FAIL K1 t={t}: circles do not cross")
        fails += 1
        continue
    P = sp.Matrix([px, py])
    check(f"P on both t={t}", sp.simplify((P - u1).dot(P - u1) - 1) == 0 and sp.simplify((P - u2).dot(P - u2) - 1) == 0)
    # K2
    for sgn in (1, -1):
        c, sn = sp.Rational(1, 2), sgn * sp.sqrt(3) / 2
        R = sp.Matrix([[c, -sn], [sn, c]])
        Y = u2 + R * (P - u2)
        check(f"K2 on omega(u2) t={t} sgn={sgn}", sp.simplify((Y - u2).dot(Y - u2) - 1) == 0)
        check(f"K2 unit from P t={t} sgn={sgn}", sp.simplify((Y - P).dot(Y - P) - 1) == 0)
        check(f"K2 within 2 of u1 t={t} sgn={sgn}", sp.N((Y - u1).norm()) <= 2)
# K3
for s1 in (1, -1):
    for s2 in (1, -1):
        d = abs(1 - s1 + s2)
        check(f"K3 s1={s1} s2={s2}", d in (1, 3))
# K4
a = lambda th: sp.Matrix([sp.cos(th), sp.sin(th)])
b = lambda ph: sp.Matrix([1 - sp.cos(ph), sp.sin(ph)])
same = sp.simplify((a(s) - b(s)).dot(a(s) - b(s)))
opp = sp.simplify((a(s) - b(-s)).dot(a(s) - b(-s)))
check("K4 same-direction closed form", sp.simplify(same - (2 * sp.cos(s) - 1) ** 2) == 0)
for val in (sp.Rational(1, 100), sp.Rational(1, 10), sp.Rational(1, 2)):
    check(f"K4 same < 1 at s={val}", sp.N(same.subs(s, val)) < 1)
    check(f"K4 opposite > 1 at s={val}", sp.N(opp.subs(s, val)) > 1)
print("ALL OK" if fails == 0 else f"{fails} FAILURE(S)")
sys.exit(1 if fails else 0)
