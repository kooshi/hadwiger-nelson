#!/usr/bin/env python3
"""FS121-V3 control for FS121-V2-SECTOR, case (iii): a positive sector R1 of colour a and a zero-angle region R2 of colour a
tangent to R1's edge direction at z = 0.  Exact rational arithmetic (fractions), no floats.

Configuration (by formula):
  R1 contains the ray segment {rho * e : 0 < rho <= 1/8}, e = (4/5, 3/5) (a direction strictly inside R1's sector (0, 60 deg));
  R2 is the cusp {(t, h) : 0 < t <= 1/8, t^2/8 < h < t^2/4}, tangent to direction 0 and inside the lens between the unit circles
  about (0, 1) and (0, -1) (t^2/4 < 1 - sqrt(1 - t^2)); a polygonal path q_0 .. q_K on h = 3 t^2 / 16 lies in R2 (checked below).
Lemma (Fact 1 of plans/FS121-V3-verification.md): for y near u = (0, 1) with |y| > 1 the unit circle about y meets R1 (sign change
of |p - y|^2 - 1 along the ray); with |y| < 1 it meets R2 (sign change along the path).  So every sample y off the circle |y| = 1
is in the shadow of R1 or R2.  Output: the number of samples covered by neither (expected 0).
Fault (--drop-cusp): R2 is removed; the samples with |y| < 1 are then uncovered, so the count is positive.
"""
import sys
from fractions import Fraction as F

drop_cusp = "--drop-cusp" in sys.argv[1:]

def d2(p, y):
    return (p[0] - y[0]) ** 2 + (p[1] - y[1]) ** 2

# R1: points of the ray at rho = 2^-60 (near z) and at rho = 1/8, 1/16, 1/32 (a fixed small distance)
e = (F(4, 5), F(3, 5))
ray = [(e[0] * r, e[1] * r) for r in [F(1, 2 ** 60), F(1, 32), F(1, 16), F(1, 8)]]

# R2: the path q_k = (t_k, 3 t_k^2 / 16), t_k = 2^-k / 8, k = 0..K
K = 60
path = [(F(1, 8 * 2 ** k), F(3, 16) * F(1, 8 * 2 ** k) ** 2) for k in range(K + 1)]
# the path lies in R2: each chord between consecutive points stays strictly between t^2/8 and t^2/4 on [t_{k+1}, t_k]
for k in range(K):
    t0, t1 = path[k + 1][0], path[k][0]
    # chord of the convex parabola 3t^2/16 lies above it, by at most (3/16) (t1 - t0)^2 / 4 at the midpoint
    assert F(3, 16) * t0 ** 2 > t0 ** 2 / 8                                  # above t^2/8 at its left end (the chord is above the parabola)
    assert F(3, 16) * t0 ** 2 + F(3, 16) * (t1 - t0) ** 2 / 4 < t0 ** 2 / 4   # below t^2/4 even at the left end, with the chord's excess
# and the cusp lies strictly below the lower arc of the unit circle about (0, 1), inside the lens: t^2/4 < 1 - sqrt(1 - t^2)
# (equivalently (1 - t^2/4)^2 > 1 - t^2), checked at every path abscissa
for (t, _) in path:
    assert (1 - t ** 2 / 4) ** 2 > 1 - t ** 2

def crosses(points, y):
    vals = [d2(p, y) - 1 for p in points]
    return any(vals[i] * vals[i + 1] < 0 for i in range(len(vals) - 1))

uncovered, total = 0, 0
N = 60
for a in range(-N, N + 1):
    for b in range(-N, N + 1):
        y = (F(a, 10 ** 5), 1 + F(b, 10 ** 5))
        if y[0] ** 2 + y[1] ** 2 == 1:
            continue  # the null circle |y - z| = 1 is not claimed
        total += 1
        covered = crosses(ray, y) or ((not drop_cusp) and crosses(path, y))
        if not covered:
            uncovered += 1
print(uncovered)
