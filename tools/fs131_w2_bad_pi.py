#!/usr/bin/env python3
"""fs131_w2_bad_pi.py — FS131-W2: a sector of angle π with two exceptional points of E1-BAD's second kind, checked exactly.

E1-BAD (plans/FS131-E1-derivation.md § 3.5) counts "at most one per sector of angle exactly π", arguing that both branches of
ω(Y) can fall inside the π-sector s only for the one of the two normals Y = P + e(a ± π/2) lying on s's side ("the branches lie on
Y's side of the line through the two edges"). The configuration: P = 0; the two edges of s are the two arc-ends at P of the circle C
of radius r centred at (0, −r) (tangent to the x-axis at P, curving downward); s is the side of P outside C's disc (angle π, its
directions [0, π]). With r = 1/2 (curvature 2 > 1), the branches of ω(Y₋), Y₋ = (0, −1), near P lie OUTSIDE C's disc, hence in s;
so do those of ω(Y₊), Y₊ = (0, 1) (they lie in y > 0). Both normals are exceptional of the second kind, and neither is of the first
kind (C is not a unit circle).

Exact arithmetic: points of ω(Y) by the rational parametrization sin t = 2u/(1+u²), cos t = (1−u²)/(1+u²), u = ±1/10^j.
--fault takes r = 2 (curvature 1/2 < 1): ω(Y₋)'s branches then fall inside C's disc (not in s), and the check must fail.
"""
import sys
from fractions import Fraction as Q

R = Q(2) if "--fault" in sys.argv else Q(1, 2)
CENTRE = (Q(0), -R)


def branch_points(Y):
    """Points of ω(Y) near P = 0 (Y = (0, ±1)): Y + (sin t, ∓cos t), exactly."""
    sgn = Y[1]
    for j in range(1, 6):
        for u in (Q(1, 10 ** j), -Q(1, 10 ** j)):
            s, c = 2 * u / (1 + u * u), (1 - u * u) / (1 + u * u)
            yield (Y[0] + s, Y[1] - sgn * c)


def main():
    ok = True
    report = []
    for name, Y in (("Y+", (Q(0), Q(1))), ("Y-", (Q(0), Q(-1)))):
        n_out = 0
        for w in branch_points(Y):
            assert (w[0] - Y[0]) ** 2 + (w[1] - Y[1]) ** 2 == 1          # on ω(Y), exactly
            assert w != (0, 0)
            d2 = (w[0] - CENTRE[0]) ** 2 + (w[1] - CENTRE[1]) ** 2
            if d2 > R * R:                                                # outside C's disc: in s
                n_out += 1
        report.append(f"{name}: in_s={n_out}/10")
        ok = ok and n_out == 10
    print(" ".join(report) + f" both_exceptional={ok}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
