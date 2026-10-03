#!/usr/bin/env python3
"""FS116-V6 — the k = 9 control: the square colouring of side 1/2 (FS111-W-SQ9) meets every hypothesis of FS116-Y4-EMPTY
except "six-coloured", and its conclusion fails there.

Squares Q(i, j) = [i/2, (i+1)/2] x [j/2, (j+1)/2], colour (i mod n, j mod n), n given on the command line (n = 3: nine colours).
Checks, exactly (integers in units of 1/2): the least distance between distinct same-coloured closed squares (validity and
non-Siamese need it >= 1, i.e. squared gap >= 4 in half-units); the colours at p = 0; the number of points of Gamma (the grid
lines) on the unit circle about p (finite: the ring carries no arc of Gamma); the colours the ring carries off Gamma.

Usage: fs116_v6_sq9.py 3     the control (expect a valid nine-colouring, four colours at p, a Gamma-free ring of five colours)
       fs116_v6_sq9.py 2     the planted fault: period 2 (four colours); same-coloured squares then touch and validity fails
"""
import math
import sys
from fractions import Fraction


def main() -> int:
    n = int(sys.argv[1]) if len(sys.argv) > 1 else 3
    # least squared gap (half-units) between distinct same-coloured squares: offsets (n a, n b) != (0, 0)
    best = None
    for a in range(-3, 4):
        for b in range(-3, 4):
            if a == 0 and b == 0:
                continue
            gx = max(0, abs(n * a) - 1)
            gy = max(0, abs(n * b) - 1)
            g2 = gx * gx + gy * gy
            best = g2 if best is None else min(best, g2)
    valid = best >= 4  # distance >= 1, i.e. gap >= 2 half-units
    col = lambda i, j: (i % n, j % n)  # noqa: E731
    at_p = {col(i, j) for i in (-1, 0) for j in (-1, 0)}
    # Gamma on the unit circle: lines x = i/2 and y = j/2 meet x^2 + y^2 = 1 in finitely many points (exact count)
    pts = set()
    for i in range(-2, 3):
        x = Fraction(i, 2)
        r2 = 1 - x * x
        if r2 < 0:
            continue
        ys = [Fraction(0)] if r2 == 0 else None
        if ys is None:
            # y = +- sqrt(r2); represent symbolically by (x, sign, r2)
            pts.add((x, 1, r2))
            pts.add((x, -1, r2))
        else:
            pts.add((x, 0, Fraction(0)))
    for j in range(-2, 3):
        y = Fraction(j, 2)
        r2 = 1 - y * y
        if r2 < 0:
            continue
        if r2 == 0:
            pts.add((Fraction(0), 0, Fraction(0), "y", y))
        else:
            pts.add(("x", 1, r2, y))
            pts.add(("x", -1, r2, y))
    # dedupe by numeric value (all coordinates are of the form m/2 or +-sqrt(r2))
    num = set()
    for q in pts:
        if q[0] == "x":
            _, sg, r2, y = q
            num.add((round(sg * math.sqrt(r2), 12), round(float(y), 12)))
        elif len(q) == 5:
            num.add((0.0, round(float(q[4]), 12)))
        else:
            x, sg, r2 = q
            num.add((round(float(x), 12), round(sg * math.sqrt(r2), 12)))
    # ring colours off Gamma: the crossing angles are multiples of 30 degrees, so sample the arc midpoints 15 + 30k
    ring = []
    for k in range(12):
        th = math.radians(15 + 30 * k)
        u, v = 2 * math.cos(th), 2 * math.sin(th)
        assert min(abs(u - round(u)), abs(v - round(v))) > 0.01, "sample too near a grid line"
        ring.append(col(math.floor(u), math.floor(v)))
    on_p = [c for c in ring if c in at_p]
    print(f"period {n}: {n*n} colours; least same-colour squared gap {best} half-units^2 (valid and non-Siamese: {valid}); "
          f"colours at p: {len(at_p)}; Gamma on the ring: {len(num)} points; ring colours: {len(set(ring))}; "
          f"ring colours of p: {len(on_p)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
