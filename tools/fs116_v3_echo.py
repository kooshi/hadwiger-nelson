#!/usr/bin/env python3
"""FS116-V3: FS116-N1-ECHO under reading (A) — a counterexample by formula, the hexagonal seven-colouring (k = 7).

Object: hexagons of circumradius a = 0.45 (the Voronoi cells of the triangular lattice L = Z b1 + Z b2, b1 = d(1, 0),
b2 = d(1/2, sqrt3/2), d = a sqrt3), the hexagon about m b1 + n b2 coloured (m + 3n) mod 7.
Validity certificate (by hand, record § 3.4): same-colour centres differ by a vector of the index-7 sublattice {m + 3n = 0 mod 7}, whose
least length is sqrt7 d = sqrt21 a (checked here over |m|, |n| <= 6); two points of one hexagon are < 2a < 1 apart, of two same-colour
hexagons > sqrt21 a - 2a > 1 apart. So the colouring is valid for every a with 2a < 1 < (sqrt21 - 2)a, and a = 0.45 is one.
p = the origin (a hexagon centre), w = r(psi), psi fixed below. The tool checks: p, w and 2w - p each interior to a hexagon (margin to
the cell boundary printed); the colour X of w's hexagon is not p's (so X is absent at p, and both ring germs at w lie in one X-tile);
the colour of 2w - p's hexagon is not X, so 2w - p lies in the closure of no X-tile. Under reading (A) saturation at w holds with
nothing to check (P(w) = {X}, w is no essential boundary point) and X is in P(w): the hypotheses hold and the conclusion fails.
--plant: the colouring (m - n) mod 3 is used instead (a planted fault); its certificate fails and the tool must say so.
"""
import itertools
import math
import sys

A = 0.45
D = A * math.sqrt(3)
B1 = (D, 0.0)
B2 = (D / 2, D * math.sqrt(3) / 2)
PSI_DEG = 20.0


def centre(m, n):
    return (m * B1[0] + n * B2[0], m * B1[1] + n * B2[1])


def cell(pt):
    """Nearest lattice point and the margin: half the gap between nearest and second-nearest distance along their bisector."""
    # solve approximately for lattice coordinates, then search the 3x3 neighbourhood
    det = B1[0] * B2[1] - B1[1] * B2[0]
    n0 = (pt[1] * B1[0] - pt[0] * B1[1]) / det
    m0 = (pt[0] - n0 * B2[0]) / B1[0]
    cands = []
    for dm, dn in itertools.product(range(-2, 3), repeat=2):
        m, n = math.floor(m0) + dm, math.floor(n0) + dn
        c = centre(m, n)
        cands.append((math.dist(pt, c), m, n, c))
    cands.sort()
    d1, m, n, c1 = cands[0]
    # distance from pt to the cell boundary = min over neighbours of (|pt-c2|^2 - |pt-c1|^2) / (2|c2-c1|)
    margin = min((cc[0] ** 2 - d1 ** 2) / (2 * math.dist(c1, cc[3])) for cc in cands[1:])
    return (m, n), margin


def main(plant):
    colour = (lambda m, n: (m - n) % 3) if plant else (lambda m, n: (m + 3 * n) % 7)
    # certificate: least same-colour centre distance over |m|, |n| <= 6 (the sublattice's minimum lies well inside)
    least = min(math.dist((0, 0), centre(m, n)) for m in range(-6, 7) for n in range(-6, 7)
                if (m, n) != (0, 0) and colour(m, n) == colour(0, 0))
    valid = 2 * A < 1 and least - 2 * A > 1
    print(f"colouring certified valid: {valid} (least same-colour centre distance {least:.4f}, minus 2a = {least - 2 * A:.4f})")
    if not valid:
        print("ECHO-A: no verdict (the colouring is not certified)")
        return
    psi = math.radians(PSI_DEG)
    p = (0.0, 0.0)
    w = (math.cos(psi), math.sin(psi))
    q = (2 * w[0], 2 * w[1])
    (cp, mp), (cw, mw), (cq, mq) = cell(p), cell(w), cell(q)
    X = colour(*cw)
    hyp = mp > 0 and mw > 1e-6 and colour(*cp) != X
    concl = mq > 1e-6 and colour(*cq) == X
    print(f"p: colour {colour(*cp)} (margin {mp:.4f}); w: colour X = {X} (margin {mw:.4f}); 2w - p: colour {colour(*cq)} (margin {mq:.4f})")
    if hyp and not concl and mq > 1e-6:
        print("ECHO-A: hypotheses hold and 2w - p lies in the closure of no X-tile")
    else:
        print(f"ECHO-A: no counterexample here (hypotheses {hyp}, conclusion {concl})")


if __name__ == "__main__":
    main("--plant" in sys.argv)
