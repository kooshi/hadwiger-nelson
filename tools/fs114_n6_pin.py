#!/usr/bin/env python3
"""FS114-N6 exact checks for the pinwheel (K1-PIN) at radius 1 + eps: every metric fact the record's stage 2 cites at named
points, in exact arithmetic (sympy over Q(sqrt 3)), and the cone-interval algebra of N6-QOUT as rational interval arithmetic in
degrees at four named cone triples and three named arcs (a check of a derived identity at named values, not a search: the
derivation is by hand).
Frame: p = 0, centre q_j = e(phi_j) with phi_j = 0 unless said; directions in degrees.
Run: python3 tools/fs114_n6_pin.py [--plant]
Plant: moves the centre q_{j+1} of the alpha = 60 case to e(70 deg), so exactly the two lines resting on
|q_j - q_{j+1}| = 1 and its direction (N6-P60's T_{j+1} cone bound) must fail, and nothing else."""
import sys
from fractions import Fraction as Fr
import sympy as sp

PLANT = '--plant' in sys.argv
def e(deg):
    r = sp.rad(sp.Integer(deg) if not isinstance(deg, sp.Basic) else deg)
    return sp.Matrix([sp.cos(r), sp.sin(r)])
def d2(a, b):
    v = a - b
    return sp.nsimplify(sp.simplify(v.dot(v)))
def dot(a, b):
    return sp.simplify(a.dot(b))
out, bad = [], 0
def check(name, cond):
    global bad
    ok = bool(cond)
    out.append(('OK   ' if ok else 'FAIL ') + name)
    bad += not ok

p = sp.Matrix([0, 0])
# --- N6-PIN180: alpha_{j+1} = 180 is impossible. Frame theta_j = 0: q_j = e(90), q_{j+1} = e(270) = -q_j.
qj, qj1 = e(90), e(270)
t = sp.Rational(1, 10)
# a point of T_{j+1}'s sector just above e_{j+1} (e_{j+1} on omega(q_{j+1}) leaving p leftward): (-t, -t^2/2 + t^3) lies above
# omega(q_{j+1}) near p but outside the closed unit disc about q_j
x = sp.Matrix([-t, -t**2/2 + t**3])
check('PIN180: sample point is outside B(q_{j+1},1) (on T_{j+1} side of e_{j+1})', d2(x, qj1) > 1)
check('PIN180: sample point is outside closed B(q_j,1)', d2(x, qj) > 1)

# --- N6-P60 (alpha_{j+1} = 60): q_j = e(0), q_{j+1} = e(60) (plant: e(70)); T_{j+1} far from q_{j+1} puts its cone at q_j
# in the closed half-plane facing away from q_{j+1}; the boundary directions are dir(q_{j+1}-q_j) +- 90.
qj = e(0); qj1 = e(70) if PLANT else e(60)
check('P60: |q_j - q_{j+1}| = 1', d2(qj, qj1) == 1)
v = qj1 - qj
ang = sp.nsimplify(sp.atan2(v[1], v[0]) * 180 / sp.pi)
check('P60: direction q_j -> q_{j+1} is 120 deg (so facing-away half-plane is [210, 390])', ang == 120)
# T_{j+2} containing p, q_j, q_{j+1} lies in the Reuleaux triangle; its cone at p is [dir q_j, dir q_{j+1}] = [0, 60];
# T_{j+2}'s cone at p starts at theta_{j+1} = phi_{j+1} - 90 = -30, outside [0, 60]
w = e(-30) * sp.Rational(1, 100)          # a point of T_{j+2} near p in direction -30
check('P60: point near p in direction -30 is outside closed B(q_{j+1},1) (so outside the Reuleaux triangle)', d2(w, qj1) > 1)

# --- N6-RCONE (Gamma-free / Q-free window tiles at q_j = e(0)): R_+ lies in closed B(w_+,1) and misses B(w_-,1),
# w_+ = e(60), w_- = e(-60): boundary directions of the allowed cone [30, 150] at q_j
wp, wm = e(60), e(-60)
for name, dirn, other, sign in [('R+ cone lower end 30 (facing w_+ boundary)', 30, wp, 0),
                                ('R+ cone upper end 150 (facing-away-from-w_- boundary)', 150, wm, 0)]:
    check('RCONE: ' + name + ' is perpendicular to q_j->target', dot(e(dirn), other - qj) == 0)
check('RCONE: direction 90 (tangent) inside the cone: faces w_+ strictly', dot(e(90), wp - qj) > 0)
check('RCONE: direction 90 faces away from w_- strictly', dot(e(90), wm - qj) < 0)
check('RCONE: direction 180 (toward p) faces w_- strictly (so R_+ cannot hold it)', dot(e(180), wm - qj) > 0)
check('RCONE: direction 180 faces w_+ strictly (so R_- cannot hold it)', dot(e(180), wp - qj) > 0)
check('RCONE: |q_j - w_+| = |q_j - w_-| = 1', d2(qj, wp) == 1 and d2(qj, wm) == 1)

# --- N6-QOUT: cone-interval algebra (degrees, relative to phi_j). A (Q) arc [b1, b2] with -60 <= b1 < b2 <= 0 and inner
# T_{j+1}; outer colour c_m needs T_m's cone inside [b2 + 90, b1 + 270]; T_{j+1}'s cone [-90, -90 + a1] inside [b2 - 90, b1 + 90].
def inside(cone, box):
    return box[0] <= cone[0] and cone[1] <= box[1]
viol_j, viol_j2, ok_j3 = 0, 0, 0
# named values only (standing rule 3: no parameter scan): four cone triples and three arcs
NAMED = [(90, 90, 90), (60, 120, 120), (120, 60, 120), (80, 100, 110)]
ARCS = [(-60, 0), (-30, -10), (-60, -40)]
for a0, a1, a2 in NAMED:
    a0, a1, a2 = Fr(a0), Fr(a1), Fr(a2)
    for b1, b2 in ARCS:
        b1f, b2f = Fr(b1), Fr(b2)
        if not inside((Fr(-90), -90 + a1), (b2f - 90, b1f + 90)):
            continue     # T_{j+1} cannot be the inner tile of this arc
        box = (b2f + 90, b1f + 270)
        cj = (270 - a0, Fr(270))                      # T_j's cone, relative, unwrapped
        cj2 = (a1 - 90, a1 + a2 - 90)                  # T_{j+2}
        cj3 = (a1 + a2 - 90, 270 - a0)                 # T_{j+3}
        viol_j += inside(cj, box)
        viol_j2 += inside(cj2, box)
        if inside(cj3, box):
            ok_j3 += 1
            if not (a1 + a2 >= 180 + b2f):
                viol_j2 += 1000   # the stated condition for c_{j+3} must hold
check(f'QOUT: outer colour c_j never admissible at the named values ({viol_j} admissible)', viol_j == 0)
check(f'QOUT: outer colour c_(j+2) never admissible at the named values ({viol_j2} admissible)', viol_j2 == 0)
check(f'QOUT: outer colour c_(j+3) admissible at some named value, always with a1 + a2 >= 180 + b2 ({ok_j3} cases)', ok_j3 > 0)

print('\n'.join(out))
print('RESULT', 'OK' if bad == 0 else f'{bad} FAIL')
sys.exit(1 if bad else 0)
