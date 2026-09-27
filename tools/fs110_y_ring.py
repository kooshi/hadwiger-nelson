#!/usr/bin/env python3
"""FS110-Y3: exact check of Y3-GP on named rings (plans/FS110-Y-construction.md §8.2).

A ring is a cyclic list of change points (degrees, exact rationals) with the colour (in Z/3) of the arc that starts at each.
Checks, exactly: (a) validity c(t) != c(t + 60) at every point off the change points and their -60 translates (one test point per cell of
the refined partition); (b) W, the lift's turn count over 3; (c) general position (no two change points at angular distance = 0 mod 60);
(d) Y3-GP: valid and general => W = 3 (mod 6).  Nothing is searched: the rings are the named formulas below.
Plants (--plant): 'nogp' drops the general-position hypothesis from (d); 'nolift' counts |changes|/3 instead of the signed lift.
"""
from fractions import Fraction as Fr
import sys

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None


def colour_at(ring, t):
    t %= 360
    best = None
    for b, c in ring:
        if b <= t:
            best = c
    return ring[-1][1] if best is None else best


def check(name, ring, want_W, want_general):
    ring = sorted((Fr(b) % 360, c % 3) for b, c in ring)
    pts = sorted({b for b, _ in ring} | {(b - 60) % 360 for b, _ in ring})
    cells = [(pts[i] + (pts[(i + 1) % len(pts)] + (360 if i + 1 == len(pts) else 0))) / 2 for i in range(len(pts))]
    valid = all(colour_at(ring, t) != colour_at(ring, t + 60) for t in cells)
    steps = [(ring[(i + 1) % len(ring)][1] - ring[i][1]) % 3 for i in range(len(ring))]
    if PLANT == "nolift":
        W = sum(1 for s in steps if s) // 3
    else:
        lift = sum(1 if s == 1 else -1 for s in steps if s)
        assert lift % 3 == 0
        W = lift // 3
    bs = [b for b, _ in ring]
    general = all((bs[i] - bs[j]) % 60 != 0 for i in range(len(bs)) for j in range(i))
    hyp = valid and (general or PLANT == "nogp")
    gp_ok = (not hyp) or W % 6 == 3
    ok = valid and W == want_W and general == want_general and gp_ok
    print(f"{name:34s} arcs={len(ring):2d} valid={valid} W={W:+d} general={general} Y3-GP={'holds' if gp_ok else 'FAILS'}"
          f"  {'OK' if ok else 'MISMATCH (want W=%+d general=%s)' % (want_W, want_general)}")
    return ok


RINGS = [
    ("alternating two-colour, 6 x 60", [(60 * k, k % 2) for k in range(6)], 0, False),
    ("r0 r1 r2 twice, 6 x 60", [(60 * k, k % 3) for k in range(6)], 2, False),
    ("r0 r1 r2 thrice, 9 x 40", [(40 * k, k % 3) for k in range(9)], 3, False),
    ("generic, change points 41k (k<9)", [(41 * k, k % 3) for k in range(9)], 3, True),
    ("generic mirror, change points 41k", [(41 * k, -k % 3) for k in range(9)], -3, True),
    ("generic, 27 arcs, 40k/3 + k/1000", [(Fr(40 * k, 3) + Fr(k, 1000), k % 3) for k in range(27)], 9, True),
]

if __name__ == "__main__":
    print(f"plant = {PLANT}")
    results = [check(*r) for r in RINGS]
    print("ALL OK" if all(results) else "SOME MISMATCH")
    sys.exit(0 if all(results) else 1)
