#!/usr/bin/env python3
"""FS129-SR3-OUTERADJ: two adjacent change points cannot share their only outer colour (FS116-V6-ADJ widened, DOUBLETIP's mirror).

Frame: p = 0, y = e(0), y' = e(60 deg), mirror apex p' = y + y' = sqrt(3) e(30 deg).
Checks:
  1. cones (interval arithmetic, mpmath.iv, on a grid of step 1/2 degree, open ends excluded):
     a. at y, every direction of the outer cone (-30, 30) leaves B(y') to first order (so the outer tiles at y and y' differ);
     b. at y, every direction 30 + eta, 0 < eta < 60, enters B(y') and leaves B(p) (the tile N after O is in B(y'), not a tile of p);
     c. at y', every direction of the outer cone (30, 90) leaves B(y); every direction 30 - eta enters B(y) and leaves B(p).
  2. colour: with six colours, P = {1,2,3,4} at p, absent {X, Xbar}: N's colour is not o (one tile per colour), not in P \\ {o} (the
     only outer colour), not Xbar (FS116-N1-GERM-R / V6-GERM: Xbar-tiles at y avoid B(y')): it is X, whose tiles at y lie in closed B(y').
  3. the mirror arcs (FS129-SR1-TWOCIRC at the apex p'): a(s) = y + e(120 - s) on omega(y) from y' toward p', b(t) = y' + e(-60 + t) on
     omega(y') from y toward p': |a - b|^2 - 1 == -8 sin(s/2) sin(t/2) cos((s+t)/2) (sympy), and |a - b| < 1 on the grid s, t in 1..60
     degrees (interval arithmetic).
Faults: --fault-tangent (the pinned arcs replaced by the tangent segments from y and y' in direction 30: never below 1);
        --fault-seven (seven colours: N may carry a third absent colour, so the colour step does not force X).
Prints 'outeradj: cones ok; colour ok; arcs ok' on success, else what failed.
"""
import sys
import sympy as sp
from mpmath import iv

iv.dps = 40


def e(th):  # th in degrees, an iv interval or number
    r = iv.mpf(th) * iv.pi / 180
    return (iv.cos(r), iv.sin(r))


def dot(u, v):
    return u[0] * v[0] + u[1] * v[1]


def pos(x):
    return x.a > 0


def neg(x):
    return x.b < 0


def cones_ok():
    y, yp = e(0), e(60)
    d_y_yp = (yp[0] - y[0], yp[1] - y[1])     # y' - y = e(120)
    d_yp_y = (y[0] - yp[0], y[1] - yp[1])     # y - y' = e(-60)
    ok = True
    for k in range(1, 120):                  # theta = -30 + k/2, open interval (-30, 30)
        th = -30 + k / 2
        ok &= neg(dot(e(th), d_y_yp))         # d/ds |y + s e - y'|^2 = -2 e.(y' - y) > 0
    for k in range(1, 120):                  # eta in (0, 60)
        th = 30 + k / 2
        ok &= pos(dot(e(th), d_y_yp))         # enters B(y')
        ok &= pos(dot(e(th), y))              # leaves B(p): d/ds |y + s e|^2 = 2 e.y > 0
    for k in range(1, 120):                  # theta in (30, 90) at y'
        th = 30 + k / 2
        ok &= neg(dot(e(th), d_yp_y))
    for k in range(1, 120):                  # theta = 30 - eta at y'
        th = 30 - k / 2
        ok &= pos(dot(e(th), d_yp_y))
        ok &= pos(dot(e(th), yp))
    return ok


def colour_ok(k):
    P = {1, 2, 3, 4}
    absent = set(range(5, k + 1))
    X, Xbar = 5, 6
    o = 1
    allowed = (P | absent) - {o} - (P - {o}) - {Xbar}
    return allowed == {X}


def arcs_ok(tangent):
    s, t = sp.symbols('s t', real=True)
    deg = sp.pi / 180
    def E(th):
        return sp.Matrix([sp.cos(th), sp.sin(th)])
    y, yp = E(0), E(60 * deg)
    a = y + E(120 * deg - s)
    b = yp + E(-60 * deg + t)
    lhs = sp.expand((a - b).dot(a - b)) - 1
    rhs = -8 * sp.sin(s / 2) * sp.sin(t / 2) * sp.cos((s + t) / 2)
    ident = sp.simplify(sp.expand_trig(lhs - rhs)) == 0
    below = True
    for i in range(1, 61):
        for j in range(1, 61):
            if tangent:  # tangent segments at arc length matching the angle (radians)
                A = (iv.mpf(1) / 2 + e(30)[0] * (iv.mpf(i) * iv.pi / 180), iv.sqrt(3) / 2 + e(30)[1] * (iv.mpf(i) * iv.pi / 180))
                B = (1 + e(30)[0] * (iv.mpf(j) * iv.pi / 180), e(30)[1] * (iv.mpf(j) * iv.pi / 180))
            else:
                ea, eb = e(120 - i), e(-60 + j)
                A = (1 + ea[0], 0 + ea[1])
                B = (iv.mpf(1) / 2 + eb[0], iv.sqrt(3) / 2 + eb[1])
            d2 = (A[0] - B[0]) ** 2 + (A[1] - B[1]) ** 2
            below &= d2.b < 1
    return ident and below


def main():
    c = cones_ok()
    col = colour_ok(7 if '--fault-seven' in sys.argv else 6)
    arc = arcs_ok('--fault-tangent' in sys.argv)
    if c and col and arc:
        print('outeradj: cones ok; colour ok; arcs ok')
    else:
        print(f'outeradj: cones {c}; colour {col}; arcs {arc}')


main()
