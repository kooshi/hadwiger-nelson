#!/usr/bin/env python3
"""FS114-N4: exact checks (sympy) of the metric facts used by plans/FS114-N4-proof.md stage 2 (the Reuleaux bowtie, the card's frame).

Frame: p = 0; t1 = Reul(p, q1, q2), t3 = Reul(p, q3, q4) with q1 = e(30), q2 = e(-30), q3 = e(150), q4 = e(210) (degrees); the top lune
(cone [60, 120] at p) holds t2, the bottom lune t4; top = e(90) is the top lune's ring midpoint; P90 = q1 + e(90) = top + e(30).
Each check is an identity or a sign at named values, never a scan.
  geo    : the unit distances the record uses (q1-top, q1-P90, top-P90, q1-q2, q1 = -q4) and |q1 - q3| = sqrt3.
  own    : omega(q1) and omega(q4) are tangent at p (direction 120); the point q1 + e(195) of omega(q1) lies inside B(p,1), outside t1
           and t3 (so in the top lune), within 30 degrees of the lune's axis e(90) as seen from p  (N4-OWN).
  arc    : for phi = 105, 120, 135 the point q1 + e(phi) lies outside the closed unit disc about p and inside the open one about top
           (N4-ARC: omega(q1) between P90 and top is boundary at a five-colour corner).
  horn   : z = q1 + t e(60) + u e(150) with t = 1/10, u = 1/1000 lies outside the closed unit disc about top; its translate by top - q1
           lies outside the closed unit disc about q1, at a direction from top strictly between 60 and 120 degrees; the two are exactly
           1 apart  (N3-DR0's horn step, in this frame: it fires only when the partner z4 borders the ring tile at q1).
  cones  : the half-plane boundaries used for the cones at top and q1 (dot products zero or positive at the named directions).
  l60    : FS112-L60 at exactly 60 degrees: P = 0, A = e(0), B = e(60), C = A + B; the point r e(6) with r = (1 + 2cos54)/2 lies outside
           B(P,1) and inside B(A,1), B(B,1), B(C,1) (so the Reuleaux cap region reaches the arc's interior next to A); the radial point
           (1 + 1/10) A beyond the end lies outside B(B,1): the proof's step "T_out contains points (1+eps)e beside each end direction"
           fails, and the cap region, of diameter at most 1, is an outer tile along the whole 60-degree arc.
Plant (--plant): top moved to e(80); geo's |q1 - top|, horn (three of its four lines) and the two top cones must fail, the rest hold
(arc does not see a 10-degree move: its points stay inside B(top,1)). Plant (--plant-arc): the arc's angles moved by +60 (165, 180, 195),
onto omega(q1)'s lune arc; arc's |y| > 1 must fail at all three, for its own reason (those points lie inside B(p,1)).
Run: python3 tools/fs114_n4_bowtie.py [--plant | --plant-arc]"""
import sys
from sympy import sqrt, Rational as Q, cos, sin, pi, simplify, nsimplify

PLANT = '--plant' in sys.argv
def e(deg):
    return (cos(pi * Q(deg, 180)), sin(pi * Q(deg, 180)))
def sub(u, v): return (u[0] - v[0], u[1] - v[1])
def add(u, v): return (u[0] + v[0], u[1] + v[1])
def mul(t, u): return (t * u[0], t * u[1])
def dot(u, v): return simplify(u[0] * v[0] + u[1] * v[1])
def n2(u): return dot(u, u)
def pos(x): return bool(simplify(x) > 0)

p = (0, 0)
q1, q2, q3, q4 = e(30), e(-30), e(150), e(210)
top = e(80) if PLANT else e(90)
P90 = add(q1, e(90))
bad = 0
def chk(name, ok):
    global bad
    print(('OK   ' if ok else 'FAIL ') + name)
    bad += not ok

# geo
chk('geo: |q1 - top| = 1', simplify(n2(sub(q1, top)) - 1) == 0)
chk('geo: |q1 - P90| = 1', simplify(n2(sub(q1, P90)) - 1) == 0)
chk('geo: |e(90) + e(30) - P90| = 0 (P90 = e(90) + e(30))', simplify(n2(sub(add(e(90), e(30)), P90))) == 0)
chk('geo: |q1 - q2| = 1', simplify(n2(sub(q1, q2)) - 1) == 0)
chk('geo: q1 + q4 = 0', simplify(n2(add(q1, q4))) == 0)
chk('geo: |q1 - q3|^2 = 3', simplify(n2(sub(q1, q3)) - 3) == 0)
# own
chk('own: e(120) . (p - q1) = 0 and e(120) . (p - q4) = 0', dot(e(120), sub(p, q1)) == 0 and dot(e(120), sub(p, q4)) == 0)
x = add(q1, e(195))
chk('own: |x|^2 < 1', pos(1 - n2(x)))
chk('own: |x - q2|^2 > 1 (outside t1)', pos(n2(sub(x, q2)) - 1))
chk('own: |x - q4|^2 > 1 (outside t3)', pos(n2(sub(x, q4)) - 1))
chk('own: x within 30 deg of e(90) seen from p', pos(dot(x, e(90))**2 - Q(3, 4) * n2(x)) and pos(dot(x, e(90))))
# arc
for ph in ((165, 180, 195) if '--plant-arc' in sys.argv else (105, 120, 135)):
    y = add(q1, e(ph))
    chk(f'arc: phi={ph}: |y|^2 > 1', pos(n2(y) - 1))
    chk(f'arc: phi={ph}: |y - top|^2 < 1', pos(1 - n2(sub(y, top))))
# horn
t, u = Q(1, 10), Q(1, 1000)
z = add(add(q1, mul(t, e(60))), mul(u, e(150)))
zz = add(z, sub(top, q1))
chk('horn: |z - top|^2 > 1', pos(n2(sub(z, top)) - 1))
chk('horn: |z\' - q1|^2 > 1', pos(n2(sub(zz, q1)) - 1))
d = sub(zz, top)
chk('horn: direction of z\' from top strictly inside (60, 120)', pos(dot(d, e(90))) and pos(dot(d, e(90))**2 - Q(1, 4) * n2(d)))
chk('horn: |z - z\'| = 1', simplify(n2(sub(z, zz)) - 1) == 0)
# cones
chk('cones: q1 - top is e(-30)', simplify(n2(sub(sub(q1, top), e(-30)))) == 0)
chk('cones: q3 - top is e(210)', simplify(n2(sub(sub(q3, top), e(210)))) == 0)
chk('cones: e(240), e(60) orthogonal to e(-30); e(300), e(120) orthogonal to e(210)',
    all(dot(e(a), e(b)) == 0 for a, b in ((240, -30), (60, -30), (300, 210), (120, 210))))
chk('cones: t1 cone at p is [300, 60]: e(60) . (p - q2) = 0, e(300) . (p - q1) = 0',
    dot(e(60), sub(p, q2)) == 0 and dot(e(300), sub(p, q1)) == 0)
# l60
A, B = e(0), e(60)
C = add(A, B)
r = (1 + 2 * cos(pi * Q(54, 180))) / 2
w = mul(r, e(6))
chk('l60: |w| > 1', pos(n2(w) - 1))
chk('l60: w in B(A,1), B(B,1), B(C,1)', pos(1 - n2(sub(w, A))) and pos(1 - n2(sub(w, B))) and pos(1 - n2(sub(w, C))))
chk('l60: |(11/10)A - B| > 1', pos(n2(sub(mul(Q(11, 10), A), B)) - 1))
chk('l60: |A - C| = |B - C| = |A - B| = 1', all(simplify(n2(sub(U, V)) - 1) == 0 for U, V in ((A, C), (B, C), (A, B))))
print('RESULT', 'OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
