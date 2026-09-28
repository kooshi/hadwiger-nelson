#!/usr/bin/env python3
"""FS111-W — exact check of FS111-W-DECO-B: the tight hexagonal seven-colouring with two small squares added to every
hexagon's colour class is a.e.-proper and tight, and no class has tight block structure.

Object (by formula; coordinates in Q(sqrt3), exact): hex7 of ``tools/fs111_w_check.py`` (regular hexagons of circumradius
1/2, centres m(sqrt3/2, 0) + n(sqrt3/4, 3/4), colour (m + 3n) mod 7).  Each hexagon H of colour c also gives colour c to
the squares S1 = H's centre + [1/2, 13/25] x [-1/50, 1/50] and S2 = H's centre + [-13/25, -1/2] x [-1/50, 1/50]; they
lie inside the hexagons across H's two vertical edges (colours c + 1 and c - 1), which lose those points.

Checked (via fs111_w_check's exact P and T on the three-tile periodic family; removing points from the neighbours only
helps their properness, so P on the full tiles is sufficient):
  P   a.e.-proper: every same-coloured pair among {hexagons, S1s, S2s} has dist >= 1 or maxdist <= 1.
  T   tight: a hexagon has diameter exactly 1.
  NB  no tight block structure: dist(H, S1) < 1 and dist(H, S2) < 1 (so S1, H, S2 lie in one block, blocks being at
      mutual distance >= 1), while maxdist(S1, S2) > 1 (so that block has diameter > 1).
Planted faults: --plant bigsq (S1 = [1/2, 3/5] x [-1/10, 1/10]: maxdist to H exceeds 1) must fail P, and nothing else;
--plant near (S2 moved to [-12/25, -1/2 + 1/100]... i.e. dist(S1, S2) < 1 and maxdist > 1) must fail P;
--plant far (S1, S2 far from H: dist(H, S1) > 1) must fail NB.
Exit 0 iff the expected assertions hold (control) or the planted one fails for its own reason.
"""
import sys
sys.path.insert(0, __import__("os").path.dirname(__file__))
from fs111_w_check import (Q3, R3, Fr, pt, add, scale, Tiling, check_P, check_T, poly_dist2, poly_maxdist2)


def square(x0, x1, y0, y1):
    return [pt(x0, y0), pt(x1, y0), pt(x1, y1), pt(x0, y1)]


def build(s1, s2):
    a = Q3(Fr(1, 2))
    half = a * Fr(1, 2)
    rt = R3 * a * Fr(1, 2)
    H = [(rt, half), (Q3(0), a), (-rt, half), (-rt, -half), (Q3(0), -a), (rt, -half)]
    col = lambda m, n: (m + 3 * n) % 7
    L1 = (R3 * a, Q3(0))
    L2 = (R3 * a * Fr(1, 2), a * Fr(3, 2))
    return Tiling("hex7 + squares", [("H", H, col), ("S1", s1, col), ("S2", s2, col)], L1, L2, reach=6), H


def check(s1, s2):
    T, H = build(s1, s2)
    fails = set()
    pf = check_P(T)
    print("  P:", "HOLDS" if not pf else "FAILS: " + pf[0])
    if pf:
        fails.add("P")
    tf, tw = check_T(T)
    print("  T:", "HOLDS: " + tw if tf is None else "FAILS: " + tf)
    if tf is not None:
        fails.add("T")
    d1, d2 = poly_dist2(H, s1), poly_dist2(H, s2)
    m12 = poly_maxdist2(s1, s2)
    nb = d1 < 1 and d2 < 1 and m12 > 1
    print(f"  NB: dist^2(H,S1) = {d1}, dist^2(H,S2) = {d2}, maxdist^2(S1,S2) = {m12} ->",
          "no tight block structure" if nb else "FAILS")
    if not nb:
        fails.add("NB")
    return fails


CONTROL = (square(Fr(1, 2), Fr(13, 25), -Fr(1, 50), Fr(1, 50)), square(-Fr(13, 25), -Fr(1, 2), -Fr(1, 50), Fr(1, 50)))
PLANTS = {
    "bigsq": ((square(Fr(1, 2), Fr(3, 5), -Fr(1, 10), Fr(1, 10)), CONTROL[1]), {"P"}),
    "near": ((CONTROL[0], square(-Fr(12, 25), -Fr(47, 100), -Fr(1, 50), Fr(1, 50))), {"P"}),
    "far": ((square(Fr(3, 2), Fr(38, 25), -Fr(1, 50), Fr(1, 50)), CONTROL[1]), {"P", "NB"}),
}

if __name__ == "__main__":
    if len(sys.argv) > 2 and sys.argv[1] == "--plant":
        (s1, s2), want = PLANTS[sys.argv[2]]
        print(f"### plant {sys.argv[2]} (must fail exactly {sorted(want)})")
        f = check(s1, s2)
        print("  fails", sorted(f), "->", "FIRES FOR ITS OWN REASON" if f == want else "PLANT MISBEHAVES")
        sys.exit(0 if f == want else 1)
    print("### control: hex7 with S1, S2 on every hexagon")
    f = check(*CONTROL)
    print("  =>", "ALL HOLD" if not f else "UNEXPECTED " + str(sorted(f)))
    sys.exit(0 if not f else 1)
