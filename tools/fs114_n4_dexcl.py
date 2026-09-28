#!/usr/bin/env python3
"""FS114-N4: exact checks (sympy) of the metric facts used by plans/FS114-N4-proof.md stage 3 (N4-D: the degenerate lune excluded at
radius sqrt3). Frame as tools/fs114_n4_bowtie.py: p = 0, q1 = e(30), q2 = e(-30), q3 = e(150), q4 = e(210), top = e(90),
P90 = q1 + e(90), P90' = q3 + e(90). Each check is an identity or a sign at named values, never a scan.
  tang  : the point x = q2 + (1001/1000) e(96), just outside t1's arc from q1 to p (on omega(q2)) and 0.105 from q1, lies outside
          omega(q2)'s disc, inside B(p,1), outside B(q4,1) (so in the top lune's sliver at q1), and OUTSIDE the closed unit disc about
          P90: a tile bordering t1 along that arc near q1 cannot reach P90 (N4-TANG).
  outer : for phi = 100, 120, 140 the point x = q1 + (1001/1000) e(phi), just outside omega(q1)'s arc from P90 to top, lies inside
          B(top,1) and B(P90,1), outside B(p,1) and B(q3,1); and within distance < 1 of the point y = q1 + (1/10) e(185) of t1
          (y inside all three discs defining Reul(p, q1, q2)).
  far   : |P90 - P90'|^2 = 3, |P90|^2 = 3, |P90 - top| = |P90 - q1| = 1.
Plant (--plant): the tang point taken just INSIDE omega(q2) (radius 999/1000) must fail tang's first line, and P90' moved to P90 + (9/10)
e(180) must fail far's first line, each for its own reason; nothing else changes.
Run: python3 tools/fs114_n4_dexcl.py [--plant]"""
import sys
from sympy import Rational as Q, cos, sin, pi, simplify

PLANT = '--plant' in sys.argv
def e(deg): return (cos(pi * Q(deg, 180)), sin(pi * Q(deg, 180)))
def sub(u, v): return (u[0] - v[0], u[1] - v[1])
def add(u, v): return (u[0] + v[0], u[1] + v[1])
def mul(t, u): return (t * u[0], t * u[1])
def n2(u): return simplify(u[0] ** 2 + u[1] ** 2)
def pos(x): return bool(simplify(x) > 0)
q1, q2, q3, q4, top = e(30), e(-30), e(150), e(210), e(90)
P90 = add(q1, e(90))
P90p = add(P90, mul(Q(9, 10), e(180))) if PLANT else add(q3, e(90))
bad = 0
def chk(name, ok):
    global bad
    print(('OK   ' if ok else 'FAIL ') + name)
    bad += not ok
x = add(q2, mul(Q(999, 1000) if PLANT else Q(1001, 1000), e(96)))
chk('tang: |x - q2|^2 > 1', pos(n2(sub(x, q2)) - 1))
chk('tang: |x|^2 < 1', pos(1 - n2(x)))
chk('tang: |x - q4|^2 > 1', pos(n2(sub(x, q4)) - 1))
chk('tang: |x - q1|^2 < 1/64', pos(Q(1, 64) - n2(sub(x, q1))))
chk('tang: |x - P90|^2 > 1', pos(n2(sub(x, P90)) - 1))
y = add(q1, mul(Q(1, 10), e(185)))
chk('outer: y in Reul(p, q1, q2)', pos(1 - n2(sub(y, q2))) and pos(1 - n2(y)) and pos(1 - n2(sub(y, q1))))
for ph in (100, 120, 140):
    xo = add(q1, mul(Q(1001, 1000), e(ph)))
    chk(f'outer: phi={ph}: in B(top,1) and B(P90,1)', pos(1 - n2(sub(xo, top))) and pos(1 - n2(sub(xo, P90))))
    chk(f'outer: phi={ph}: outside B(p,1) and B(q3,1)', pos(n2(xo) - 1) and pos(n2(sub(xo, q3)) - 1))
    chk(f'outer: phi={ph}: |x - y|^2 < 1', pos(1 - n2(sub(xo, y))))
chk('far: |P90 - P90\'|^2 = 3', simplify(n2(sub(P90, P90p)) - 3) == 0)
chk('far: |P90|^2 = 3', simplify(n2(P90) - 3) == 0)
chk('far: |P90 - top| = |P90 - q1| = 1', simplify(n2(sub(P90, top)) - 1) == 0 and simplify(n2(sub(P90, q1)) - 1) == 0)
print('RESULT', 'OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
