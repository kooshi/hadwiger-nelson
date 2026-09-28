#!/usr/bin/env python3
"""FS114-NB5: exact checks of the metric facts in the blind derivations (stage 1).

Frame (FS114-N4's): p = 0, e(a) = (cos a, sin a), q1 = e(30), q2 = e(-30), q3 = e(150), q4 = e(210),
top = e(90), P90 = q1 + e(90), P90p = q3 + e(90). All arithmetic in Q(sqrt3) with sympy; small angles
are exact Pythagorean rotations where a first-order claim needs a named point.
Each line prints OK or FAIL; exit 0 iff all OK. --plant moves the gap point of the R-V kill (G*)
from direction 60 deg to 70 deg about top, where the derivation says it lies inside B(P90p, 1):
exactly the G* lines must fail, for that reason.
"""
import sys
import sympy as sp

s3 = sp.sqrt(3)
def e(deg):
    r = sp.rad(deg)
    return sp.Matrix([sp.nsimplify(sp.cos(r)), sp.nsimplify(sp.sin(r))])
def d2(u, v):
    w = u - v
    return sp.simplify(w.dot(w))
p = sp.Matrix([0, 0]); q1, q2, q3, q4, top = e(30), e(-30), e(150), e(210), e(90)
P90, P90p = q1 + e(90), q3 + e(90)
PLANT = "--plant" in sys.argv
bad = 0
def check(tag, cond, info=""):
    global bad
    ok = bool(cond)
    bad += (not ok)
    print(f"{'OK  ' if ok else 'FAIL'} {tag} {info}")

# D: named distances
check("D1 |top-q1|=|top-q3|=1", d2(top, q1) == 1 and d2(top, q3) == 1)
check("D2 P90, P90p unit from their corners and top", all(d2(a, b) == 1 for a, b in [(P90, q1), (P90, top), (P90p, q3), (P90p, top)]))
check("D3 |P90|^2 = |P90p|^2 = 3", d2(P90, p) == 3 and d2(P90p, p) == 3)
check("D4 |P90p - q4| = 2 and |P90 - q2| = 2", d2(P90p, q4) == 4 and d2(P90, q2) == 4)
check("D5 |q1 - P90p| = 2: omega(q1), omega(P90p) externally tangent at top", d2(q1, P90p) == 4 and sp.simplify((q1 + P90p) / 2 - top) == sp.zeros(2, 1))

# G: the R-V kill at top (the gap between omega(q1) and omega(P90p) in direction 60 deg)
t = sp.symbols('t', positive=True)
gdir = 70 if PLANT else 60
x = top + t * e(gdir)
gq1, gP = sp.expand(d2(x, q1)), sp.expand(d2(x, P90p))
check("G1 |x - q1|^2 = 1 + t^2 (x outside cl z4, z4 in B(q1,1))", sp.simplify(gq1 - 1 - t**2) == 0, f"[dir {gdir}] {gq1}")
check("G2 |x - P90p|^2 = 1 + t^2 (x outside B(P90p,1), so not in T)", sp.simplify(gP - 1 - t**2) == 0, f"[dir {gdir}] {gP}")
tv = sp.Rational(1, 100)
check("G3 at t = 1/100 the point is outside both closed discs", gq1.subs(t, tv) > 1 and gP.subs(t, tv) > 1, f"[dir {gdir}]")

# H: half-planes at top used by N5-UP / N5-SIGHT (90 deg not in the closed half-plane facing p, q1, q3)
u90 = e(90)
check("H1 e(90).(p-top) < 0, e(90).(q1-top) < 0, e(90).(q3-top) < 0", all(sp.simplify(u90.dot(v - top)) < 0 for v in [p, q1, q3]))
check("H2 t1, t2, t3 meet B(top,1): p + d e(45), e(90), e(135) at d = 1/10", all(d2(sp.Rational(1, 10) * e(a), top) < 1 for a in [45, 90, 135]))

# C: q3's cap tile C' (cone contains directions just below 240 deg) is not at P90p; its points there leave B(P90p,1)
y = q3 + sp.Rational(1, 10) * e(235)
check("C1 q3 + e(235)/10 outside B(p,1) and outside B(P90p,1)", d2(y, p) > 1 and d2(y, P90p) > 1)
check("C2 e(235).(P90p - q3) < 0 (C' not in B(P90p,1): cone would have to lie in [0,180])", sp.simplify(e(235).dot(P90p - q3)) < 0)

# T: TANG at q3 (U3 borders t3 along omega(q4) at q3): a point just outside omega(q4) near q3 is > 1 from P90p
z = q4 + sp.Rational(1001, 1000) * sp.Matrix([sp.Rational(20, 101), sp.Rational(99, 101)])  # radius 1.001 about q4, direction atan(99/20) ~ 78.6 deg (between p at 30 and q3 at 90)
check("T1 point just outside omega(q4) near q3 is outside B(P90p,1)", d2(z, q4) > 1 and d2(z, P90p) > 1, f"|z-q3|^2={sp.N(d2(z, q3), 6)}")

# R0: with C in B(q2,1), z4 starts at <= 0 deg at q1; a direction in [300,360] at q1 points away from every ring point e(th), 30 < th <= 90
check("R1 e(d).(e(th) - q1) < 0 for d in {300,330,359}, th in {31,60,90}", all(sp.N(e(dd).dot(e(tt) - q1)) < 0 for dd in [300, 330, 359] for tt in [31, 60, 90]))
check("R2 z4's cone at q1 within facing-top [60,240] and away-from-p [300,120]: 60,120 on both boundaries", sp.simplify(e(60).dot(top - q1)) == 0 and sp.simplify(e(120).dot(p - q1)) == 0)

# K: KAPPA's outer-colour-4 overlap: |(1+a)e(th) - (1+b)e(th+60+g)|^2 < 1 for g < 0 small, a, b small positive
a_, b_ = sp.Rational(1, 1000), sp.Rational(1, 1000)
lhs = d2((1 + a_) * e(40), (1 + b_) * e(99))
check("K1 overlap of 60-shifted outer tiles gives distance < 1 (th=40, shift 59)", lhs < 1, f"{sp.N(lhs, 8)}")
lhs2 = d2((1 + a_) * e(40), (1 + b_) * e(100))
check("K2 at shift exactly 60 the same points are > 1 apart (endpoint case not excluded)", lhs2 > 1, f"{sp.N(lhs2, 8)}")

# B: the (R2) length bound: chord of the radius-2 witness arc = 1 at 2 arcsin(1/4)
ell = 2 * sp.asin(sp.Rational(1, 4))
check("B1 4 sin(ell/2) = 1 at ell = 2 arcsin(1/4) ~ 28.955 deg", sp.simplify(4 * sp.sin(ell / 2) - 1) == 0, f"{sp.N(sp.deg(ell), 6)}")

# P: pinwheel: |q_{j-1} - q_{j+1}| = 2 sin((a_j + a_{j+1})/2) >= sqrt3 > 1 when a_j + a_{j+1} >= 120
check("P1 2 sin(60) = sqrt3 > 1", sp.simplify(2 * sp.sin(sp.pi / 3) - s3) == 0)

print(f"RESULT {'OK' if bad == 0 else f'{bad} FAIL'} plant={'on' if PLANT else 'off'}")
sys.exit(1 if bad else 0)
