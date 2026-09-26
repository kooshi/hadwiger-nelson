#!/usr/bin/env python3
"""J48 (FS-100 stage 1 blind check): the exact arithmetic behind two of the brief's controls.

(C7) Seven colours.  The hexagonal seven-colouring of R^2 by the index-7 sublattice: hexagons of side s, centres on a triangular lattice
     of spacing sqrt(3)*s, same-coloured centres at distance sqrt(21)*s.  With CLOSED hexagons (a boundary point takes any adjacent
     hexagon's colour) the colouring is proper at every unit edge iff two points of one closed hexagon are never at distance 1
     (diameter 2s < 1) and two points of distinct same-coloured closed hexagons are never at distance 1; the second holds when
     sqrt(21)*s - 2s > 1 (centre distance minus two circumradii).  Checked exactly (squaring rationals) at s = 9/20.
     A uniformly random translation over the period lattice makes it translation-invariant, and it is continuous in probability
     (boundaries are null), so UD(R^2) carries a CP 7-colouring -- deterministic properness makes "a.s. at each fixed edge" free.

(C9) Four colours over Q(sqrt 11) (row 94's C9).  theta_7(x, y) = (2x + 3y)/7 at a stable place above 7 (residue F_7, i not in F_7):
     every point (a, b) of a^2 + b^2 = 1 over F_7 has (2a + 3b mod 7)/7 in [2/7, 5/7]; with an archimedean term of absolute value
     <= 1/28 on unit vectors the phase difference along an edge lies in [1/4, 3/4]; and floor(4s) != floor(4(s + delta)) (mod 4) for every
     s in [0, 1) and delta in [1/4, 3/4].  The last is checked exactly on the rationals s in (1/(4N))Z and delta in (1/(4N))Z with N = 60,
     plus the argument that floor(4 .) is constant on [j/4, (j+1)/4) (so a counterexample would have to be one at a grid point: both ends of
     each constancy interval of s -> (floor 4s, floor 4(s+delta)) are grid points when delta is).  For delta off the grid the pair
     (floor 4s, floor 4(s + delta)) changes only when s or s + delta crosses a quarter; a violation needs s and s + delta (mod 1) in one
     half-open quarter, i.e. delta mod 1 in (-1/4, 1/4), impossible for delta in [1/4, 3/4].  The grid check is the planted-fault surface.

Plants (--plant NAME), each must FAIL at its own check:
  coeff-11   use theta = (x + y)/7 instead of (2x + 3y)/7            -> C9's circle check fails
  wide-arch  allow the archimedean term up to 1/14 instead of 1/28   -> C9's band check fails
  big-hex    s = 1/2 (diameter exactly 1)                            -> C7's diameter check fails
Exit status 0 iff every check passes.  Run: python3 tools/crunch_j48_controls.py [--plant NAME]
"""
import sys
from fractions import Fraction as Fr
from math import floor

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None


def check_c7():
    s = Fr(1, 2) if PLANT == "big-hex" else Fr(9, 20)
    ok = True
    if not (2 * s < 1):
        print(f"C7 FAIL: hexagon diameter 2s = {2*s} is not < 1")
        ok = False
    # sqrt(21)*s - 2s > 1  <=>  sqrt(21) > (1 + 2s)/s  <=>  21 > ((1 + 2s)/s)^2  (both sides positive)
    rhs = ((1 + 2 * s) / s) ** 2
    if not (Fr(21) > rhs):
        print(f"C7 FAIL: same-colour separation: 21 > {rhs} is false")
        ok = False
    if ok:
        print(f"C7 pass: s = {s}: diameter {2*s} < 1 and sqrt(21)s - 2s > 1 (21 > {rhs} = {float(rhs):.4f})")
    return ok


def check_c9():
    ok = True
    ca, cb = (1, 1) if PLANT == "coeff-11" else (2, 3)
    pts = [(a, b) for a in range(7) for b in range(7) if (a * a + b * b) % 7 == 1]
    assert len(pts) == 8
    vals = sorted(Fr((ca * a + cb * b) % 7, 7) for (a, b) in pts)
    if not all(Fr(2, 7) <= v <= Fr(5, 7) for v in vals):
        print(f"C9 FAIL: circle values {vals} leave [2/7, 5/7]")
        ok = False
    arch = Fr(1, 14) if PLANT == "wide-arch" else Fr(1, 28)
    lo, hi = min(vals) - arch, max(vals) + arch
    if not (Fr(1, 4) <= lo and hi <= Fr(3, 4)):
        print(f"C9 FAIL: phase band [{lo}, {hi}] leaves [1/4, 3/4]")
        ok = False
    N = 60
    for i in range(4 * N):
        s = Fr(i, 4 * N)
        for j in range(N, 3 * N + 1):  # delta in [1/4, 3/4] on the grid
            dl = Fr(j, 4 * N)
            if floor(4 * s) % 4 == floor(4 * ((s + dl) % 1)) % 4:
                print(f"C9 FAIL: floor(4s) = floor(4(s+delta)) at s = {s}, delta = {dl}")
                return False
    if ok:
        print(f"C9 pass: circle values over F_7 {[str(v) for v in vals]} in [2/7, 5/7]; with |arch| <= 1/28 the band is "
              f"[{lo}, {hi}] within [1/4, 3/4]; floor(4.) separates every grid pair")
    return ok


def main():
    ok = check_c7() & check_c9()
    print("ALL CHECKS PASS" if ok else "SOME CHECK FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
