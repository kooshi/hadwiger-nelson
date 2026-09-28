#!/usr/bin/env python3
"""FS114-N4: exact checks (sympy) of the metric facts used by plans/FS114-N4-proof.md stage 5 (N4-G: the general lune excluded at
radius sqrt3). Frame as tools/fs114_n4_bowtie.py; the change points of the top lune's ring are y' = e(s), y'' = e(s + 60) with
s in (30, 90); checked at the named values s = 40, 60, 80 (the general inequality is the identity |P90 - e(t)|^2 = 4 - 2 sqrt3 cos(t - 60),
checked symbolically). Each check is an identity or a sign at named values, never a scan.
  lens   : |P90 - y'|^2 < 1 (P90 lies in B(y',1)) and |P90 - y''|^2 > 1, at each named s; |P90 - q2|^2 = 4; the identity above.
  region : the point w = q1 + (999/1000) e(95) lies in B(q1,1) and B(top,1), outside the closed unit disc about p, and within 1/10 of P90
           (so in the part of the lens B(q1,1) cap B(top,1) outside B(p,1) near P90, which the proof shows is z4's).
  diam   : w and v = q1 + (1/10) e(5) (a point of z4 near q1 once z4's sector there starts at 0 degrees) are more than 1 apart.
Plant (--plant): w taken at 85 degrees instead of 95 (before P90 along omega(q1)); diam must fail, for its own reason (the two points are
then less than 1 apart), and region's B(top,1) line with it.
Run: python3 tools/fs114_n4_gexcl.py [--plant]"""
import sys
from sympy import Rational as Q, cos, sin, pi, simplify, sqrt, symbols, expand, trigsimp

PLANT = '--plant' in sys.argv
def e(deg): return (cos(pi * Q(deg, 180)), sin(pi * Q(deg, 180)))
def sub(u, v): return (u[0] - v[0], u[1] - v[1])
def add(u, v): return (u[0] + v[0], u[1] + v[1])
def mul(t, u): return (t * u[0], t * u[1])
def n2(u): return simplify(u[0] ** 2 + u[1] ** 2)
def pos(x): return bool(simplify(x) > 0)
q1, q2, top = e(30), e(-30), e(90)
P90 = add(q1, e(90))
bad = 0
def chk(name, ok):
    global bad
    print(('OK   ' if ok else 'FAIL ') + name)
    bad += not ok
t = symbols('t', real=True)
gen = (P90[0] - cos(t)) ** 2 + (P90[1] - sin(t)) ** 2 - (4 - 2 * sqrt(3) * cos(t - pi / 3))
chk('lens: |P90 - e(t)|^2 = 4 - 2 sqrt3 cos(t - 60) (symbolic)', simplify(expand(trigsimp(gen))) == 0)
for s in (40, 60, 80):
    chk(f'lens: s={s}: |P90 - y\'|^2 < 1', pos(1 - n2(sub(P90, e(s)))))
    chk(f'lens: s={s}: |P90 - y\'\'|^2 > 1', pos(n2(sub(P90, e(s + 60))) - 1))
chk('lens: |P90 - q2|^2 = 4', simplify(n2(sub(P90, q2)) - 4) == 0)
w = add(q1, mul(Q(999, 1000), e(85 if PLANT else 95)))
chk('region: |w - q1| < 1', pos(1 - n2(sub(w, q1))))
chk('region: |w - top| < 1', pos(1 - n2(sub(w, top))))
chk('region: |w| > 1', pos(n2(w) - 1))
chk('region: |w - P90|^2 < 1/100', pos(Q(1, 100) - n2(sub(w, P90))))
v = add(q1, mul(Q(1, 10), e(5)))
chk('diam: |w - v|^2 > 1', pos(n2(sub(w, v)) - 1))
print('RESULT', 'OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
