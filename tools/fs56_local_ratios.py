#!/usr/bin/env python3
"""fs56_local_ratios -- FS-56 §2: the least mean of a nontrivial character over the unit circle at each kind of compact place,
and what it says about a field's planes.  READINGS (floats), not bounds: the ratio floor 1 - 1/m is the Hoffman-type bound of
the local graph, and the §2 reading about the ratio bound on pieces of F^2 is a heuristic, not a theorem.

  finite plane UD(F_q, 2), q prime = 3 (mod 4):  m_q = min over a != 0 of (1/(q+1)) sum_{u on the circle} cos(2 pi <a,u>/q)
  the real place:                                m_R = min_r J_0(r)
  the hard fractional ceiling of a field:        chi_f(F^2) <= chi_f(UD(F_q, 2)) = q^2/alpha(q) at every usable q

usage: python3 tools/fs56_local_ratios.py > data/fs56/local-ratios.out
"""
import math

from scipy.optimize import minimize_scalar
from scipy.special import j0

# alpha known exactly (level-3 certificates matching found sets): 3 -> 3, 7 -> 14, 11 -> 28
ALPHA_EXACT = {3: 3, 7: 14, 11: 28}
# certified upper bounds on alpha where alpha is open (FS-50, FS-53, FS-54, FS-56)
ALPHA_UPPER = {19: 81, 23: 105, 31: 200, 43: 365, 47: 371}
ALPHA_FOUND = {19: 76, 23: 87, 31: 146, 43: 258, 47: 265}


def plane_min_mean(q):
    circ = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    best = 1.0
    for a in range(q):
        for b in range(q):
            if (a, b) != (0, 0):
                s = sum(math.cos(2 * math.pi * (a * x + b * y) / q) for x, y in circ) / len(circ)
                best = min(best, s)
    return len(circ), best


def legendre(a, p):
    a %= p
    return 0 if a == 0 else (1 if pow(a, (p - 1) // 2, p) == 1 else -1)


def main():
    r = minimize_scalar(j0, bounds=(3, 5), method="bounded")
    print("# FS-56 local character means (readings, floats)")
    print(f"real place: min J0 = {r.fun:.6f} at r = {r.x:.5f}; ratio floor {1 - 1 / r.fun:.4f}")
    table = {}
    for q in (3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83):
        d, m = plane_min_mean(q)
        table[q] = m
        chi_f = (f"{q * q}/{ALPHA_EXACT[q]} = {q * q / ALPHA_EXACT[q]:.4f} (exact)" if q in ALPHA_EXACT else
                 f"in [{q * q / ALPHA_UPPER[q]:.3f}, {q * q / ALPHA_FOUND[q]:.3f}]" if q in ALPHA_UPPER else "—")
        print(f"F_{q}: circle {d}, least mean {m:.4f}, ratio floor {1 - 1 / m:.3f}, chi_f {chi_f}")
    print("dyadic place ramified in F(i)/F: least mean -1 (the plane two-colours); split places: no fixed obstruction")
    print()
    print("# fields Q(sqrt d): usable odd primes q < 100 (q = 3 mod 4, d a nonzero square mod q, or q | d), 2-adic type,")
    print("# the least compact-place mean (real place included), and the hard fractional ceiling from usable planes")
    for dd in (3, 7, 11, 23, 167, 887, 1055, 2351, 4703):
        usable = [q for q in table if q % 4 == 3 and (dd % q == 0 or legendre(dd, q) == 1)]
        two = "split in F(i) (wall broken)" if dd % 8 == 7 else "not split (wall stands)"
        least = min([r.fun] + [table[q] for q in usable])
        ceil = min([4.3599] + [q * q / ALPHA_EXACT[q] for q in usable if q in ALPHA_EXACT])
        print(f"Q(sqrt {dd}): 2-adic {two}; usable {usable}; least compact mean {least:.4f} "
              f"({'> -1/2' if least > -0.5 else '<= -1/2'}); fractional ceiling {ceil:.3f}")


if __name__ == "__main__":
    main()
