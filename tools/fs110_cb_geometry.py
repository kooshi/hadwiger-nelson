#!/usr/bin/env python3
"""FS110-CB exact/float checks of the two-circle geometry behind S-V Lemma 3 (Fig. 5) and Voronov's bicycle.

Frame: u1 = (0,0), u2 = (d,0), 1 < d < 2; p0 = (d/2, h) upper intersection of the unit circles; theta0 = arccos(d/2).
Claims checked (each a derived statement, checked on formulas; nothing is searched):
 C1 |q3-u1|^2 = 2 + 2cos(2 theta0 - 60deg) (q3 = p0 rotated -60deg about u2): equals 4 iff d = sqrt3, < 4 otherwise.
 C2 the unit segment whose near end runs u2's arc q3 -> p0 has its far end on u1's circle ending at q1 for d < sqrt3,
    at q2 for d > sqrt3 (the printed 3-cycle q1'p~pq2', q2'p~pq3', q3'p~pq1' breaks beyond sqrt3).
 C3 bicycle: x runs u1's circle from x0 (|x0-u2| = 2) to x1 = p0; partners on u2's circle.  The branch ending at z1
    has an interior turning point iff d > sqrt3 (at cos theta* = (3+d^2)/(4d)), so it reaches z1 from OUTSIDE the
    120-degree arc [y1 .. z1] through x1 exactly when d > sqrt3; the other branch is monotone; y0 lies in that arc.
Plant: PLANT=1 flips the rotation direction defining q3; C2 must then fail for its own reason.
"""
import math, os, sys
import sympy as sp

PLANT = os.environ.get("PLANT") == "1"
fails = []

# ---- C1 exact identity ----
d = sp.symbols('d', positive=True)
c0 = d/2; s0 = sp.sqrt(1 - d**2/4)
# q3 = u2 + rot(-60)(p0-u2)
def rot(v, ang):
    ca, sa = sp.cos(ang), sp.sin(ang)
    return (ca*v[0]-sa*v[1], sa*v[0]+ca*v[1])
p0 = (c0, s0); u2 = (d, 0)
v = rot((p0[0]-d, p0[1]), -sp.pi/3)
q3 = (d+v[0], v[1])
lhs = sp.simplify(sp.expand(q3[0]**2 + q3[1]**2))
th = sp.symbols('th')
target = 2 + 2*sp.cos(2*th - sp.pi/3)
diff = sp.simplify(sp.expand_trig(target.subs(th, sp.acos(d/2))) - lhs)
if diff != 0:
    fails.append(f"C1 identity residue {diff}")
at_r3 = sp.nsimplify(lhs.subs(d, sp.sqrt(3)))
if at_r3 != 4:
    fails.append(f"C1 |q3-u1|^2 at d=sqrt3 is {at_r3}, not 4")
print("C1 |q3-u1|^2 =", lhs, "; at sqrt3 ->", at_r3)

# ---- float helpers ----
def pt(a): return (math.cos(a), math.sin(a))
def cross(a, b): return a[0]*b[1]-a[1]*b[0]
def sub(a, b): return (a[0]-b[0], a[1]-b[1])
def partners(x, c):
    """the two points of the unit circle about c at distance 1 from x, as angles about c (lower, upper)."""
    dx, dy = x[0]-c[0], x[1]-c[1]; rho = math.hypot(dx, dy)
    psi = math.atan2(dy, dx); beta = math.acos(min(1.0, rho/2))
    return psi-beta, psi+beta

def pairing(dv):
    """C2: follow the far end (on u1's circle) of the unit segment whose near end runs u2's circle from q3 to p0."""
    th0 = math.acos(dv/2); P0 = (dv/2, math.sin(th0)); U2 = (dv, 0.0)
    a_p0 = math.atan2(P0[1], P0[0]-dv)
    a_q3 = a_p0 + (math.pi/3 if PLANT else -math.pi/3)
    N = 4000; prev = None
    for k in range(N+1):
        a = a_q3 + (a_p0-a_q3)*k/N
        x = (dv+math.cos(a), math.sin(a))
        lo, hi = partners(x, (0.0, 0.0))
        cand = [pt(lo), pt(hi)]
        if prev is None:   # start: the partner equal to p0
            cur = min(cand, key=lambda w: math.hypot(w[0]-P0[0], w[1]-P0[1]))
        else:
            cur = min(cand, key=lambda w: math.hypot(w[0]-prev[0], w[1]-prev[1]))
        prev = cur
    q1 = pt(th0+math.pi/3); q2 = pt(th0-math.pi/3)
    return 'q1' if math.hypot(prev[0]-q1[0], prev[1]-q1[1]) < math.hypot(prev[0]-q2[0], prev[1]-q2[1]) else 'q2'

r3 = math.sqrt(3)
for dv in (1.05, 1.3, 1.5, 1.7, 1.72, 1.74, 1.8, 1.9, 1.99):
    got = pairing(dv); want = 'q1' if dv < r3 else 'q2'
    print(f"C2 d={dv}: q3-arc partner ends at {got} (expected {want})")
    if got != want: fails.append(f"C2 d={dv}: {got} != {want}")

def bicycle(dv):
    th0 = math.acos(dv/2); al = math.acos((dv*dv-3)/(2*dv))
    U2 = (dv, 0.0); N = 20000
    ang_x1 = math.atan2(math.sin(th0), math.cos(th0)-dv)
    y1, z1 = ang_x1+math.pi/3, ang_x1-math.pi/3      # y1 upper-angle end, z1 lower-angle end (as angles about u2)
    lo_tr, hi_tr = [], []
    for k in range(1, N+1):
        th = al + (th0-al)*k/N
        lo, hi = partners(pt(th), U2)
        lo_tr.append(lo); hi_tr.append(hi)
    def turns(tr):
        s = [math.copysign(1, tr[i+1]-tr[i]) for i in range(len(tr)-1) if abs(tr[i+1]-tr[i]) > 1e-15]
        return sum(1 for i in range(len(s)-1) if s[i] != s[i+1])
    y0 = math.atan2(math.sin(al)/2, (math.cos(al)+dv)/2-dv)
    return dict(turns_lo=turns(lo_tr), turns_hi=turns(hi_tr), min_lo=min(lo_tr), z1=z1, y1=y1,
                y0_in=(z1 < y0 < y1), span=max(hi_tr)-min(lo_tr))

for dv in (1.1, 1.3, 1.5, 1.7, 1.73, 1.74, 1.8, 1.9, 1.99):
    b = bicycle(dv)
    over = b['min_lo'] < b['z1'] - 1e-9
    want_over = dv > r3
    cs = (3+dv*dv)/(4*dv)
    interior = (dv*dv-3)/(2*dv) < cs < dv/2
    print(f"C3 d={dv}: turns lo/hi={b['turns_lo']}/{b['turns_hi']}, z-branch overshoots z1: {over}, "
          f"theta* interior: {interior}, y0 in arc: {b['y0_in']}, swept span deg={math.degrees(b['span']):.1f}")
    if over != want_over or interior != want_over or not b['y0_in'] or b['turns_hi'] != 0 or b['span'] >= 2*math.pi:
        fails.append(f"C3 d={dv}")
if fails:
    print("FAIL:", *fails, sep="\n  "); sys.exit(1)
print("ALL CHECKS PASS")
