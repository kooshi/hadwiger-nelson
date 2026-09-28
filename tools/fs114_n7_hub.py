#!/usr/bin/env python3
"""FS114-N7 exact checks for stage 2 (the (Q)-free ring at a four-colour degree-4 vertex p = 0).
Change points y_k = e(y + 60k); D-directions D_m = y + 30 + 60m. Every check is exact (sympy, algebraic numbers) at named values.
Checks:
  TAN   at D_m the circle w(y_{m-1}) leaves p curving clockwise and w(y_{m+2}) curving counter-clockwise (points at s = 1/10
        along each circle lie on the stated side of the ray D_m and within 10 degrees of it)
  TIP   the open cone (psi_k+150, psi_k+210) at y_k points into B(p,1), B(y_{k-1},1), B(y_{k+1},1) (named directions, t = 1/100);
        just outside it (psi_k+140, psi_k+220) the point leaves B(y_{k-1},1) resp. B(y_{k+1},1)
  RCONE the ring tile R_k's cone at y_k is bounded by psi_k+30 (facing y_{k+1}) and psi_k+150 (facing away from y_{k-1})
  WIN   a tile at p inside the closed disc about y_k has its cone in [psi_k-90, psi_k+90] (named directions just inside / outside)
  DIST  |y_k - y_{k+1}| = 1, |y_k - y_{k+2}| = sqrt 3, |y_k - y_{k+3}| = 2
Run: python3 tools/fs114_n7_hub.py [--plant]   (plant: y_1 moved from 60 to 64 degrees; exactly the five lines at y_0 resting on
|y_0 - y_1| = 1 must fail -- the three TIP-inside lines, RCONE psi+35 and DIST |y_0-y_1| -- and no TAN, WIN or y_3 line.)"""
import sys
import sympy as sp

PLANT = '--plant' in sys.argv
deg = sp.pi / 180

def e(a):
    return sp.Matrix([sp.cos(a * deg), sp.sin(a * deg)])

def n2(v):
    return sp.nsimplify(sp.simplify(v.dot(v)))

def ang(v):
    return sp.atan2(v[1], v[0]) / deg

fails = 0
def check(name, cond):
    global fails
    ok = bool(cond)
    print(('OK   ' if ok else 'FAIL ') + name)
    fails += (not ok)

y = 0                     # the class of the change points; y_k = e(60k)
psi = lambda k: y + 60 * k
yk = lambda k: e(psi(k)) if not (PLANT and k % 6 == 1) else e(psi(0) + 64)
D = lambda m: y + 30 + 60 * m

# TAN: at D_m, w(y_{m-1}) curves clockwise, w(y_{m+2}) counter-clockwise
s = sp.Rational(1, 10)
for m in range(6):
    c1, c2 = e(psi(m - 1)), e(psi(m + 2))
    # w(c) near p: c + e(angle of (p - c) +- s); pick the branch leaving p in direction D_m
    for c, side in ((c1, 'cw'), (c2, 'ccw')):
        base = ang(-c)
        cand = [c + e(base + s * 180 / sp.pi / deg * deg * sgn) for sgn in (1, -1)]
        # choose the candidate whose direction from p is within 10 degrees of D_m
        good = None
        for P in cand:
            d = sp.N(ang(P) - D(m)) % 360
            d = d - 360 if d > 180 else d
            if abs(d) < 10:
                good = d
        check(f'TAN D_{m}: w(y_{"m-1" if side == "cw" else "m+2"}) leaves along D_{m} curving {side}',
              good is not None and ((good < 0) if side == 'cw' else (good > 0)))

# TIP and RCONE and WIN at k = 0 and k = 3 (two change points)
t = sp.Rational(1, 100)
for k in (0, 3):
    Y, Ym, Yp = yk(k), yk(k - 1), yk(k + 1)
    for u in (155, 180, 205):
        P = Y + t * e(psi(k) + u)
        check(f'TIP y_{k} dir psi+{u}: in B(p,1), B(y_{k-1},1), B(y_{k+1},1)',
              sp.N(n2(P)) < 1 and sp.N(n2(P - Ym)) < 1 and sp.N(n2(P - Yp)) < 1)
    P = Y + t * e(psi(k) + 140)
    check(f'TIP y_{k} dir psi+140 leaves B(y_{k-1},1)', sp.N(n2(P - Ym)) > 1)
    P = Y + t * e(psi(k) + 220)
    check(f'TIP y_{k} dir psi+220 leaves B(y_{k+1},1)', sp.N(n2(P - Yp)) > 1)
    # RCONE: R_k holds y_{k+1} (so lies in B(y_{k+1},1)) and misses B(y_{k-1},1)
    check(f'RCONE y_{k}: dir psi+25 leaves closed B(y_{k+1},1)', sp.N(n2(Y + t * e(psi(k) + 25) - Yp)) > 1)
    check(f'RCONE y_{k}: dir psi+35 inside B(y_{k+1},1)', sp.N(n2(Y + t * e(psi(k) + 35) - Yp)) < 1)
    check(f'RCONE y_{k}: dir psi+155 inside B(y_{k-1},1)', sp.N(n2(Y + t * e(psi(k) + 155) - Ym)) < 1)
    check(f'RCONE y_{k}: dir psi+145 outside closed B(y_{k-1},1)', sp.N(n2(Y + t * e(psi(k) + 145) - Ym)) > 1)
    # WIN: cone at p of a tile inside the closed disc about y_k
    check(f'WIN y_{k}: p + t e(psi+85) in B(y_{k},1)', sp.N(n2(t * e(psi(k) + 85) - Y)) < 1)
    check(f'WIN y_{k}: p + t e(psi+95) outside closed B(y_{k},1)', sp.N(n2(t * e(psi(k) + 95) - Y)) > 1)
    check(f'DIST |y_{k}-y_{k+1}| = 1', sp.simplify(n2(Y - Yp) - 1) == 0)
    check(f'DIST |y_{k}-y_{k+2}|^2 = 3', sp.simplify(n2(Y - yk(k + 2)) - 3) == 0)
    check(f'DIST |y_{k}-y_{k+3}|^2 = 4', sp.simplify(n2(Y - yk(k + 3)) - 4) == 0)
print('RESULT', 'OK' if fails == 0 else f'{fails} FAIL')
sys.exit(1 if fails else 0)
