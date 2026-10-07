#!/usr/bin/env python3
"""FS133-E1: exact control for the density-point step of C133-DP and of C133-PAIR's converse (stage 6).

The step: for density points x and y = x + u (|u| = 1), a point x' of B(x, h) plus a unit vector u' with |u' - u| < h lands
in B(y, 2h) -- so the law of x' + u' is carried by B(y, 2h), where y has density 1.  Here x = 0, u = (1, 0), h = 1/8; x' runs
over the rational grid (a/64, b/64) inside B(0, h); u' over the rational points of the unit circle with parameter t = k/200,
|k| <= 200, kept when |u' - u| < F*h.  Prints whether EVERY such x' + u' is in B(y, 2h), in exact rationals.
F = 1 is the step as derived (must print True); F = 3 is the fault (an arc three times too long: prints False).
Usage: converse_support.py <F>
"""
import sys
from fractions import Fraction as Fr
F = Fr(sys.argv[1]); h = Fr(1, 8)
xs = [(Fr(a, 64), Fr(b, 64)) for a in range(-8, 9) for b in range(-8, 9) if a * a + b * b < 64]
us = []
for k in range(-200, 201):
    t = Fr(k, 200)
    u = ((1 - t * t) / (1 + t * t), 2 * t / (1 + t * t))
    if (u[0] - 1) ** 2 + u[1] ** 2 < (F * h) ** 2:
        us.append(u)
assert xs and us
print(all((x[0] + u[0] - 1) ** 2 + (x[1] + u[1]) ** 2 < (2 * h) ** 2 for x in xs for u in us))
