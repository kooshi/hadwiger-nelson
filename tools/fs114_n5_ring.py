#!/usr/bin/env python3
"""FS114-N5 exact checks for stage 2 (K1-GAMMARING): the metric facts at named points that N5-UP, N5-DEG, N5-W, N5-R0 and N5-RV
use, in N4's frame (p = 0, q1 = e(30), q2 = e(-30), q3 = e(150), q4 = e(210), top = e(90), P90 = q1 + e(90), P90' = q3 + e(90)).
Exact arithmetic in sympy (sqrt(3), cos/sin of multiples of 15 degrees); each line prints OK or FAIL.
Run: python3 tools/fs114_n5_ring.py [--plant]
The plant moves `top` to e(80): the unit distances q1-top, q3-top and the sliver/ring facts that rest on them must FAIL, for
their own reason (a distance no longer exactly 1, or a strict inequality turned)."""
import sys
import sympy as sp

def e(deg):
    a = sp.pi * sp.Rational(deg, 180)
    return sp.Matrix([sp.cos(a), sp.sin(a)])

def d2(u, v):
    w = u - v
    return sp.nsimplify(sp.simplify(w.dot(w)))

PLANT = '--plant' in sys.argv
p = sp.Matrix([0, 0])
q1, q2, q3, q4 = e(30), e(-30), e(150), e(210)
top = e(80) if PLANT else e(90)
P90, P90p = q1 + e(90), q3 + e(90)
bad = 0

def check(name, cond):
    global bad
    ok = bool(cond)
    bad += not ok
    print(('OK   ' if ok else 'FAIL ') + name)

# unit distances the N3-FACE / N-E2 steps at top need
check('|q1 - top| = 1', sp.simplify(d2(q1, top) - 1) == 0)
check('|q3 - top| = 1', sp.simplify(d2(q3, top) - 1) == 0)
check('|p - top| = 1', sp.simplify(d2(p, top) - 1) == 0)
check('|P90 - q1| = 1 and |P90 - top| = 1', sp.simplify(d2(P90, q1) - 1) == 0 and sp.simplify(d2(P90, top) - 1) == 0)
check('|P90 - P90\'| = sqrt(3)', sp.simplify(d2(P90, P90p) - 3) == 0)
# half-planes at top: facing away from q1 is {v : v.(q1 - top) <= 0}; q1 - top = e(-30) exactly
check('q1 - top = e(-30)', sp.simplify((q1 - top) - e(-30)) == sp.zeros(2, 1))
check('q3 - top = e(210)', sp.simplify((q3 - top) - e(210)) == sp.zeros(2, 1))
# N5-UP: direction 90 at top is outside the cones [240,60] (tiles in B(q1,1)) and [120,300] (tiles in B(q3,1))
check('e(90).(q1 - top) > 0 is false (90 not facing q1 strictly): value', sp.simplify(e(90).dot(q1 - top)) < 0)
check('e(90).(q3 - top) < 0', sp.simplify(e(90).dot(q3 - top)) < 0)
# ring points strictly between q1 and top are within < 1 of top and of q1 (theta = 45, 60, 75)
for th in (45, 60, 75):
    check(f'|e({th}) - top| < 1', sp.N(d2(e(th), top)) < 1)
    check(f'|e({th}) - q1| < 1', sp.N(d2(e(th), q1)) < 1)
# a ring point just past 90 is more than 1 from q1 (theta = 95) and more than 1 from P90
check('|e(95) - q1| > 1', sp.N(d2(e(95), q1)) > 1)
check('|e(95) - P90| > 1', sp.N(d2(e(95), P90)) > 1)
check('|e(85) - P90\'| > 1', sp.N(d2(e(85), P90p)) > 1)
# |P90 - e(t)|^2 = 4 - 2 sqrt3 cos(t - 60): < 1 exactly for t in (30, 90) (named t = 45, 75), = 1 at 30, 90
for t, rel in ((30, 0), (45, -1), (75, -1), (90, 0), (120, 1)):
    v = sp.simplify(d2(P90, e(t)) - 1)
    check(f'sign(|P90 - e({t})|^2 - 1) = {rel}', sp.sign(sp.N(v, 30)) == rel if rel else v == 0)
# sliver points q1 + delta e(phi), phi in (120, 180), are within < 1 of top (delta = 1/10, phi = 130, 150, 170)
for ph in (130, 150, 170):
    check(f'|q1 + e({ph})/10 - top| < 1', sp.N(d2(q1 + e(ph) / 10, top)) < 1)
# the cap tile inside B(q2,1): |P90 - q2| = 2, so it misses P90
check('|P90 - q2| = 2', sp.simplify(d2(P90, q2) - 4) == 0)
# N5-RV at P90: the colour-2 exclusion needs a point of t2 near the ring on (a, 90) within < 1 of P90 (theta = 80)
check('|e(80) - P90| < 1', sp.N(d2(e(80), P90)) < 1)
# B(q1,1) n B(top,1) minus B(p,1) near top is the wedge (0, 60) at top: directions 30 in it, 90 not
for ang, inside in ((30, True), (90, False)):
    x = top + e(ang) / 100
    ok = (sp.N(d2(x, q1)) < 1) and (sp.N(d2(x, p)) > 1)
    check(f'top + e({ang})/100 in B(q1,1) minus B(p,1): {inside}', ok == inside)
print('RESULT', 'OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
