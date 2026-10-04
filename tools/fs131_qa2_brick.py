#!/usr/bin/env python3
"""FS131-QA2: exact checks that `sevenBrickMap` (the brick seven-colouring, `Instances/Seven`) is a non-degenerate model of
the hypotheses the Woodall chain and wave 4's cubic-trichromatic lemmas assume, at k = 7 on a plane map.

Facts checked with `fractions.Fraction`, over a window of cells (|c|, |r| <= 6), from the library's own data:
cells `4/5 x 3/5`, row shear `2/5`, colour `(column + 3 row) mod 7`, corner `brickCorner c r = ((2/5) r + (4/5) c, (3/5) r)`.
  1. every vertex of the edge graph is a T-junction: exactly three cells meet, two on one side of the horizontal line, one
     on the other (no vertical edges of adjacent rows align), so the degree is 3 and the three angles are pi/2, pi/2, pi
     (each >= pi/3);
  2. the three cells at every vertex carry three distinct colours (so `coloursAt` has three elements, the picture's colours
     are injective: `NiceAt`, `WoodallNormal` at that vertex, `IsCubicTrichromatic`);
  3. at the corner u = brickCorner c r, the opposite corner of each upper cell is at distance exactly 1 (an M-in point x of
     `anti`), the two such points are 8/5 apart (not antipodal), and the lower cell's far corners are at distance^2 13/25 < 1.
Usage: fs131_qa2_brick.py [--shear S]   (default 2/5; a planted fault: --shear 0 must fail check 1)
"""
import sys
from fractions import Fraction as Q

W, H = Q(4, 5), Q(3, 5)


def corner(c, r, s):
    return (s * r + W * c, H * r)


def cell_at(x, y, s):
    """The (c, r) of the half-open cell holding the point (x, y)."""
    import math
    r = math.floor(y / H)
    c = math.floor((x - s * r) / W)
    return c, r


def colour(c, r):
    return (c + 3 * r) % 7


def main(s):
    fails = []
    for c in range(-6, 7):
        for r in range(-6, 7):
            # the two vertex types: bottom-left corners of row r, top-left corners of row r-1 on the line y = (3/5) r
            for vx, vy in (corner(c, r, s), (corner(c, r - 1, s)[0], H * r)):
                eps = Q(1, 1000)
                around = {cell_at(vx + dx * eps, vy + dy * eps, s) for dx in (-1, 1) for dy in (-1, 1)}
                if len(around) != 3:
                    fails.append(f"vertex ({vx},{vy}): {len(around)} cells meet, not 3 (not a T-junction)")
                    continue
                cols = {colour(*cc) for cc in around}
                if len(cols) != 3:
                    fails.append(f"vertex ({vx},{vy}): colours {cols} not distinct")
            ux, uy = corner(c, r, s)
            x1 = (ux + W, uy + H)          # opposite corner of the upper-right cell (c, r)
            x2 = (ux - W, uy + H)          # opposite corner of the upper-left cell (c - 1, r)
            d1 = (x1[0] - ux) ** 2 + (x1[1] - uy) ** 2
            d12 = (x1[0] - x2[0]) ** 2 + (x1[1] - x2[1]) ** 2
            if d1 != 1:
                fails.append(f"corner ({ux},{uy}): opposite corner at distance^2 {d1}, not 1")
            if d12 == 4:
                fails.append("the two M-in corners are antipodal")
            lc, lr = cell_at(ux, uy - eps, s)
            lx0, ly0 = corner(lc, lr, s)
            for fx in (lx0, lx0 + W):
                dd = (fx - ux) ** 2 + (ly0 - uy) ** 2
                if not dd < 1:
                    fails.append(f"lower cell far corner at distance^2 {dd} >= 1")
    for f in fails[:10]:
        print("FAIL", f)
    print("brick check:", "FAIL" if fails else "OK", f"({len(fails)} failures; shear {s})")
    return 1 if fails else 0


if __name__ == "__main__":
    s = Q(2, 5)
    if "--shear" in sys.argv:
        s = Q(sys.argv[sys.argv.index("--shear") + 1])
    sys.exit(main(s))
