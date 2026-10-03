#!/usr/bin/env python3
"""FS121-V5: exact checks for the attack on FS121-D4-FACE (standard library, exact rationals).

Frame: x = (0, 0), e = (1, 0), e_perp = (0, 1).  H = (-eps, 0) x (-eps, eps) (the half-box), B = (g, g + eps') x (-rho, rho)
(the far box).  The statement assumes 0 < 2g < rho^2.

  cex [--fault]   The margin dropped.  With g = 1/10, rho = 2/5 (so 2g >= rho^2 and (1 - g)^2 + rho^2 < 1), eps = 1/10,
                  eps' = 1/20, and Q = (1, 1 + 1/200) x (-1/200, 1/200), the class S_c = H u B u Q has no two points at distance
                  exactly 1, and the rest of the plane is coloured by squares of side 1/4 in 36 colours (i mod 6, j mod 6) with
                  no unit pairs in any class; x + e = (1, 0) lies in cl Q, so in supp S_c, at distance 1 from x.  Prints True
                  when every exact inequality holds.  --fault restores the margin (rho = 9/20, rho^2 > 2g): prints False.
  thin [--fault]  A parameter pair outside the statement's hypothesis (2g >= rho^2) that still meets the sharp condition
                  (1 - g)^2 + rho^2 > 1 under which the record's argument runs: g = 1/10, rho = 11/25.  Prints the two
                  booleans.  --fault uses rho = 2/5, outside the sharp condition.

Every box is open; for the maximum (minimum) of |p - q|^2 over a product of closed boxes the extreme is at a pair of
vertices (a convex function on a polytope), which is what the corner enumerations use.
"""
import itertools
import sys
from fractions import Fraction as F


def corners(box):
    (x0, x1), (y0, y1) = box
    return [(a, b) for a in (x0, x1) for b in (y0, y1)]


def d2(p, q):
    return (p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2


def maxd2(b1, b2):
    return max(d2(p, q) for p in corners(b1) for q in corners(b2))


def cex(fault):
    g, rho = F(1, 10), (F(9, 20) if fault else F(2, 5))
    eps, epsp, a0 = F(1, 10), F(1, 20), F(1, 200)
    H = ((-eps, F(0)), (-eps, eps))
    B = ((g, g + epsp), (-rho, rho))
    Q = ((F(1), 1 + a0), (-a0, a0))
    checks = {
        "outside the hypothesis: 2g >= rho^2": 2 * g >= rho ** 2,
        "circle about x+e misses B: (1-g)^2 + rho^2 < 1": (1 - g) ** 2 + rho ** 2 < 1,
        "H u B has diameter < 1 (no unit pair inside H u B)": max(maxd2(H, H), maxd2(B, B), maxd2(H, B)) < 1,
        "every point of Q has all of B strictly within distance 1": maxd2(Q, B) < 1,
        "every point of Q is at distance > 1 from H (Q starts at x = 1, H ends at x = 0, both open)": Q[0][0] - H[0][1] >= 1,
        "Q has diameter < 1": maxd2(Q, Q) < 1,
        "background squares (side 1/4, colours mod 6): diameter < 1, same-colour gap 5/4 > 1": F(1, 16) * 2 < 1 and 6 * F(1, 4) - F(1, 4) > 1,
        "x + e = (1, 0) is in cl Q and at distance 1 from x": Q[0][0] <= 1 <= Q[0][1] and Q[1][0] <= 0 <= Q[1][1] and d2((1, 0), (0, 0)) == 1,
    }
    if "--verbose" in sys.argv:
        for k, v in checks.items():
            print(("ok   " if v else "FAIL ") + k)
    print(all(checks.values()))


def thin(fault):
    g, rho = F(1, 10), (F(2, 5) if fault else F(11, 25))
    print(f"outside the hypothesis (2g >= rho^2): {2 * g >= rho ** 2}; sharp condition ((1-g)^2 + rho^2 > 1): {(1 - g) ** 2 + rho ** 2 > 1}")


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    fault = "--fault" in sys.argv[1:]
    if args == ["cex"]:
        cex(fault)
    elif args == ["thin"]:
        thin(fault)
    else:
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
