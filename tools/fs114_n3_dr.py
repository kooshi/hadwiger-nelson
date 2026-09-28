#!/usr/bin/env python3
"""FS114-N3: exact checks (sympy) of the metric facts the record's DR analysis uses (plans/FS114-N3-proof.md stage 2).

DR is the degree-4 vertex p = 0 with two opposite Reuleaux triangles R1 = Reul(0, a, b), R3 = Reul(0, -a, -b), a = e^{i60}, b = e^{i120};
the lunes' change points are y' = e^{i s'}, y'' = e^{i(s'+60)}; the degenerate member (N3-DR0) has s' = 0, so y' = y0' = 1 and y'' = a.
Checked (each a named identity or sign at named values, never a scan):
  dr0   : |a - y0'| = 1; e^{i30} is orthogonal to a - y0' (both tangent rays at 30 degrees); for small t, s > 0 the point
          z = a + t e^{i30} - s e^{i120} lies outside B(y0', 1) and its translate z + (y0' - a) lies in the open wedge (330, 30) at y0',
          outside B(a, 1) and outside B(-b, 1), at distance exactly 1 from z  (the conflict of N3-DR0);
  cones : the cone facts used for the colour eliminations (a direction of each named cone within 90 degrees of the named target);
  cont  : for s' in (-60, 0) the ring point y'' is within distance < 1 of a (N3-CONT's Siamese step), at s' = -30 exactly;
  p1    : p1' = omega(v0') cap omega(a) with v0' = (1/2, 0): the point (1/2 - sqrt13/4, sqrt3/4) lies on both circles and on R1's left arc.
Plant (--plant): y0' moved to e^{i10}; dr0 must fail at its first identity, the rest unchanged.
Run: python3 tools/fs114_n3_dr.py [--plant]"""
import sys
from sympy import sqrt, Rational as Q, cos, sin, pi, simplify, nsimplify, atan2, symbols, expand

PLANT = '--plant' in sys.argv
h = Q(1, 2)
s3 = sqrt(3)
def e(deg):
    return (cos(pi * Q(deg, 180)), sin(pi * Q(deg, 180)))
def sub(u, v): return (u[0] - v[0], u[1] - v[1])
def add(u, v): return (u[0] + v[0], u[1] + v[1])
def mul(t, u): return (t * u[0], t * u[1])
def dot(u, v): return simplify(u[0] * v[0] + u[1] * v[1])
def n2(u): return dot(u, u)

a, b = e(60), e(120)
ma, mb = mul(-1, a), mul(-1, b)
y0p = e(10) if PLANT else (1, 0)
bad = 0
def chk(name, ok):
    global bad
    print(('OK   ' if ok else 'FAIL ') + name)
    bad += not ok

# dr0
chk('dr0: |a - y0\'|^2 = 1', simplify(n2(sub(a, y0p)) - 1) == 0)
chk('dr0: e^{i30} . (a - y0\') = 0', dot(e(30), sub(a, y0p)) == 0)
t, s = Q(1, 100), Q(1, 100000)          # small t, s with 0 < s < t^2/2: z strictly between the tangent ray and omega(y0')
z = sub(add(a, mul(t, e(30))), mul(s, e(120)))
w = add(z, sub(y0p, a))
chk('dr0: z outside B(y0\', 1)', simplify(n2(sub(z, y0p)) - 1) > 0)
dw = sub(w, y0p)
ang = float(atan2(dw[1], dw[0])) * 180 / float(pi)
chk('dr0: translate w in the open wedge (330, 30) at y0\'', -30 < ang < 30)
chk('dr0: w outside B(a, 1)', simplify(n2(sub(w, a)) - 1) > 0)
chk('dr0: w outside B(-b, 1)', simplify(n2(sub(w, mb)) - 1) > 0)
chk('dr0: |z - w| = 1', simplify(n2(sub(z, w)) - 1) == 0)
chk('dr0: z - a is on the cw side of the 30-degree ray (inside z_a when its cone reaches 30)',
    simplify((sub(z, a)[0]) * e(30)[1] - (sub(z, a)[1]) * e(30)[0]) > 0)

# cones (direction u in cone, target direction g: u . g > 0 means the cone points within 90 degrees of g)
def within90(u_deg, g):
    return dot(e(u_deg), g) > 0
chk('cones: R1 at p (cone [30,150]) points toward y0\' (u = 45)', within90(45, (1, 0)))
chk('cones: R3 at p (cone [210,330]) points toward y0\' (u = 300)', within90(300, (1, 0)))
chk('cones: t4 at p (cone [330,30]) points toward y0\' and toward a (u = 0)', within90(0, (1, 0)) and within90(0, a))
chk('cones: T_C at y0\' (cone (180,330)) points toward a (u = 200)', within90(200, sub(a, (1, 0))))
chk('cones: t2 at p (cone [150,210]) points toward b (u = 150)', within90(150, b))
chk('cones: t2 at p does not point toward y0\' side ring points in (-60, 60) beyond 90 deg (u = 150 vs e(0))', not within90(150, e(0)))

# cont
sp = -30
ypp = e(sp + 60)
chk('cont: |a - y\'\'| < 1 at s\' = -30', simplify(n2(sub(a, ypp)) - 1) < 0)
chk('cont: |a - y\'| > 1 at s\' = -30', simplify(n2(sub(a, e(sp))) - 1) > 0)
chk('cont: |b - e^{i150}| < 1 (left middle tile within 1 of b)', simplify(n2(sub(b, e(150))) - 1) < 0)

# p1
p1 = (h - sqrt(13) / 4, s3 / 4)
chk('p1: |p1 - v0\'| = 1', simplify(n2(sub(p1, (h, 0))) - 1) == 0)
chk('p1: |p1 - a| = 1', simplify(n2(sub(p1, a)) - 1) == 0)
d = sub(p1, a)
angp = float(atan2(d[1], d[0])) * 180 / float(pi) % 360
chk('p1: on R1\'s left arc (direction from a in (180, 240))', 180 < angp < 240)
print(f'  (direction a -> p1\' = {angp:.4f} deg)')

print('RESULT', 'ALL OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
