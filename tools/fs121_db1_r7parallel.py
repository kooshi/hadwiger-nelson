#!/usr/bin/env python3
"""FS121-DB1 control: C121-OUT needs its tangent-type hypothesis. On R7 (k = 7), exact in Q(√3) with sympy.

The arc of the up U(0, 0) opposite the lattice point v = (0, 0) is a unit arc of kind both centred at v (split type; window 0° to 60°).
Its unit parallel away from v is the arc of radius R = 2 about v. At the window's midpoint, P = R·(cos 30°, sin 30°) = (√3, 1).
Checked exactly: (i) P is at distance different from 1 from every lattice point within distance 4 of it, so P lies on no interface of
R7 (every interface of R7 is a unit arc centred at a lattice point); (ii) P is strictly inside the three unit discs about the vertices
of the up U(1, 1), i.e. an interior point of that tile. So the outer unit parallel of a split arc is not an interface there.

Usage: python3 tools/fs121_db1_r7parallel.py [--plant]   (--plant takes R = 1, the arc itself; the check must then read otherwise)
Prints one line; exits 0 either way.
"""
import sys
import sympy as sp

R = 1 if '--plant' in sys.argv else 2
s3 = sp.sqrt(3)
P = (R * s3 / 2, sp.Rational(R, 2))


def pt(a, b):
    return (a + sp.Rational(b, 2), b * s3 / 2)


def d2(p, q):
    return sp.expand((p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2)


near = [(a, b) for a in range(-6, 7) for b in range(-6, 7) if float(d2(P, pt(a, b))) < 16]
on_interface = any(sp.simplify(d2(P, pt(a, b)) - 1) == 0 for (a, b) in near)
verts = [pt(1, 1), pt(2, 1), pt(1, 2)]
interior = all((1 - d2(P, q)).is_positive for q in verts)
print(f'radius {R}: lattice points checked {len(near)}; on an interface {on_interface}; interior of U(1,1) {interior}')
