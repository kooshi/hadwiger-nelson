#!/usr/bin/env python3
"""FS111-V0 — exact check of the counterexample to C-HULL's second clause (data/fs111/claims.md §3).

The object: the hexagonal seven-colouring of the plane by regular hexagons of circumradius a = 1/2 (diameter exactly 1),
coloured by the index-7 sublattice: centre m*u + n*v, u = (sqrt3*a, 0), v = (sqrt3*a/2, 3a/2), gets colour (m + 3n) mod 7.

What is checked, in exact arithmetic (squared lengths are rational multiples of a^2):
  A. PROPER-ACROSS: two distinct hexagons of one colour are more than 1 apart. Sufficient test: every nonzero same-colour
     centre vector has squared length D2 with D2 > (2a + 1)^2 (then the gap D - 2a exceeds 1).
  B. PROPER-WITHIN: the closed hexagon has diameter 2a <= 1, so two points of one OPEN hexagon are less than 1 apart.
  C. TIGHT: the diameter is exactly 1 (2a = 1): pairs near two opposite vertices have distances filling (1 - r, 1), so the
     colouring has slack at no epsilon > 0 (D-SLACK form (a)).
  D. THE CLAUSE FAILS: x = vertex v0 of a hexagon H (x lies in the essential closure A*_j, upper density 1/3), C = int H
     (path-connected, inside the density-1 set). The squared distances from v0 to the six vertices are 0, a^2, 3a^2, 4a^2,
     3a^2, a^2: the maximum 4a^2 = 1 is attained only at the opposite vertex v3, which is not in C. Since |p - v0|^2 is
     strictly convex, its maximum over the closed hexagon is attained only at vertices, so sup_{c in C}|x - c| = 1 (not
     < 1) and dist(x, C) = 0 (not > 1): x lies in neither set of the clause's union.

Planted faults (--plant NAME), each must fail at its own named assertion:
  diameter : a = 11/20 (diameter 1.1)             -> fails PROPER-WITHIN
  colour   : colour (m + 2n) mod 7 (a sublattice with a short vector) -> fails PROPER-ACROSS
  vertex   : read the vertex list with v3 dropped  -> fails THE-CLAUSE-FAILS (the sup would read < 1)
Exit status 0 iff every assertion holds; 1 with the failed assertion's name otherwise.
"""
from fractions import Fraction as F
import sys


def check(a: F, col_coeff: int, drop_v3: bool) -> list:
    failures = []
    a2 = a * a
    # A. same-colour centre vectors m*u + n*v with m + col_coeff*n = 0 mod 7; |m u + n v|^2 = 3 a^2 (m^2 + m n + n^2).
    min_d2 = None
    for m in range(-30, 31):
        for n in range(-30, 31):
            if (m, n) == (0, 0) or (m + col_coeff * n) % 7 != 0:
                continue
            d2 = 3 * a2 * (m * m + m * n + n * n)
            if min_d2 is None or d2 < min_d2:
                min_d2 = d2
    bound = (2 * a + 1) ** 2
    if not (min_d2 > bound):
        failures.append(f"PROPER-ACROSS: min same-colour centre D^2 = {min_d2} not > (2a+1)^2 = {bound}")
    # B. diameter of the closed hexagon is 2a.
    if not (2 * a <= 1):
        failures.append(f"PROPER-WITHIN: diameter 2a = {2 * a} > 1")
    # C. tight: diameter exactly 1.
    if not (2 * a == 1):
        failures.append(f"TIGHT: diameter 2a = {2 * a} is not exactly 1")
    # D. squared distances from v0 to the vertices v0..v5 (regular hexagon, circumradius a): chord^2 = 2a^2(1 - cos(k*60deg)).
    cos_k = [F(1), F(1, 2), F(-1, 2), F(-1), F(-1, 2), F(1, 2)]
    d2_to_vertices = {k: 2 * a2 * (1 - c) for k, c in enumerate(cos_k)}
    if drop_v3:
        del d2_to_vertices[3]
    sup2 = max(d2_to_vertices.values())
    argmax = [k for k, d in d2_to_vertices.items() if d == sup2]
    # The clause's first set needs sup < 1; the second needs dist > 1 (dist(v0, int H) = 0 since v0 is in the closure).
    clause_first_set = sup2 < 1
    clause_second_set = False
    if not (sup2 == 1 and argmax == [3] and not clause_first_set and not clause_second_set):
        failures.append(f"THE-CLAUSE-FAILS: sup^2 = {sup2} at vertices {argmax}; expected exactly 1, attained only at v3")
    return failures, min_d2, d2_to_vertices


def main() -> int:
    plant = None
    if len(sys.argv) == 3 and sys.argv[1] == "--plant":
        plant = sys.argv[2]
    elif len(sys.argv) != 1:
        print("usage: fs111_v0_hex.py [--plant diameter|colour|vertex]")
        return 2
    a = F(11, 20) if plant == "diameter" else F(1, 2)
    coeff = 2 if plant == "colour" else 3
    failures, min_d2, d2v = check(a, coeff, plant == "vertex")
    print(f"a = {a}; colour (m + {coeff} n) mod 7; min same-colour centre D^2 = {min_d2}; "
          f"(2a+1)^2 = {(2 * a + 1) ** 2}; squared distances v0->vk = {[str(d2v[k]) for k in sorted(d2v)]}")
    if failures:
        for f in failures:
            print("FAIL", f)
        return 1
    print("ALL HOLD: proper across and within, tight, and C-HULL's second clause fails at x = v0, C = int H")
    return 0


if __name__ == "__main__":
    sys.exit(main())
