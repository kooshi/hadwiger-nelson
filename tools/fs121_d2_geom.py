#!/usr/bin/env python3
"""FS121-D2 exact checks (sympy, exact rationals). Two modes, each printing one line.

ext:       FS121-D2-EXT's geometric core. Put the junction at a = (0,0) with J's normal along the y-axis. The piece gamma lies on
           x^2 + y^2 - 2 n y = 0 (radius n, centre (0,n)); the neighbour gamma' lies on x^2 + y^2 - 2 s m y = 0 (radius m, centre (0, s m),
           s = +1 or -1) or on the line y = 0. For every n in 2..12, every m in 1..12, s in {+1,-1}, and the line, with gamma' a different curve
           from gamma, solve the two equations exactly and count the configurations whose common set is not exactly {a}. Prints that count.
           --plant adds the configuration n = m, s = +1 (gamma' on gamma's own circle), which the lemma's hypothesis excludes: its common
           set is the whole circle, so the count becomes 1.
transport: window transport. For every Pythagorean direction pair on a piece of radius n about z (n in 2..9), the rung at level k
           (1 <= k <= n-1), i.e. each endpoint moved by k toward z, subtends at z an angle with the same cosine as the piece. Prints the
           number of (n, k, pair) where the cosines differ. --plant moves the rung toward a centre shifted by (1/7, 0), so cosines differ."""
import sys
from sympy import symbols, solve, Rational, sqrt, simplify
x, y = symbols('x y', real=True)
def ext(plant):
    bad = 0
    cfgs = []
    for n in range(2, 13):
        for m in range(1, 13):
            for s in (1, -1):
                if s * m != n: cfgs.append((n, ('circle', s * m)))
        cfgs.append((n, ('line', 0)))
    if plant: cfgs.append((5, ('circle', 5)))
    for n, (kind, c) in cfgs:
        e1 = x**2 + y**2 - 2*n*y
        e2 = (x**2 + y**2 - 2*c*y) if kind == 'circle' else y
        if simplify(e1 - e2) == 0 or (kind == 'circle' and c == n):
            bad += 1; continue            # the same curve: infinitely many common points
        sol = solve([e1, e2], [x, y], dict=True)
        pts = {(simplify(d[x]), simplify(d[y])) for d in sol}
        if pts != {(0, 0)}: bad += 1
    print(bad)
def transport(plant):
    trip = [(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25), (20, 21, 29)]
    dirs = [(Rational(a, c), Rational(b, c)) for a, b, c in trip] + [(Rational(b, c), Rational(a, c)) for a, b, c in trip]
    bad = 0
    for n in range(2, 10):
        z = (Rational(0), Rational(n))
        zc = (z[0] + Rational(1, 7), z[1]) if plant else z
        for i in range(len(dirs)):
            for j in range(i + 1, len(dirs)):
                u, v = dirs[i], dirs[j]
                p = (z[0] - n*u[0], z[1] - n*u[1]); q = (z[0] - n*v[0], z[1] - n*v[1])     # the piece's endpoints
                cos0 = u[0]*v[0] + u[1]*v[1]
                for k in range(1, n):
                    pk = (p[0] + Rational(k, n)*(zc[0] - p[0]), p[1] + Rational(k, n)*(zc[1] - p[1]))
                    qk = (q[0] + Rational(k, n)*(zc[0] - q[0]), q[1] + Rational(k, n)*(zc[1] - q[1]))
                    a = (pk[0] - z[0], pk[1] - z[1]); b = (qk[0] - z[0], qk[1] - z[1])
                    cosk = (a[0]*b[0] + a[1]*b[1]) / sqrt((a[0]**2 + a[1]**2) * (b[0]**2 + b[1]**2))
                    if simplify(cosk - cos0) != 0: bad += 1
    print(bad)
mode = sys.argv[1] if len(sys.argv) > 1 else ''
plant = '--plant' in sys.argv
if mode == 'ext': ext(plant)
elif mode == 'transport': transport(plant)
else: print('usage: fs121_d2_geom.py ext|transport [--plant]'); sys.exit(2)
