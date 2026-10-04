#!/usr/bin/env python3
"""FS129-SR3-E2ONE: E2 at exactly one blade of a pinwheel restores ALT's conclusion at the broken pair by parity.

Setting (FS114-Y5's pinwheel, no E1): four pockets mu_1..mu_4 around p, each of colour m_j in {5, 6} (the two colours absent at p).
FS114-Y5-ALT gives m_j != m_{j+1} unless E2 holds at blade t_{j+2}. With E2 at exactly one blade t_{c+1}, ALT is unavailable only for the
pair (mu_{c-1}, mu_c); it holds for the three pairs (c, c+1), (c+1, c+2), (c+2, c+3).

Checks (exact, finite):
  1. parity: for every c in 0..3 and every m in {5,6}^4 obeying the three ALT conclusions, m_{c-1} != m_c. Count of failures: 0.
  2. S6 / F2 dies once CASE holds at q_c: cones (a_c, a_{c+1}, a_{c+2}, a_{c+3}) = (180 - b, b, 60, 120), b rational in (60, 120) on a
     grid of step 1/4 degree; CASE at q_c needs a_c == 60 or a_{c-1} + a_c <= 180, with a_{c-1} = a_{c+3}. Survivors: 0.
Faults: --fault-two (only two ALT pairs imposed, as with E2 at two blades: parity failures appear);
        --fault-case (CASE read with the wrong neighbour a_{c+1} in place of a_{c-1}: F2 survives).
Prints 'e2one: parity ok; F2 ok' on success, else the failing counts.
"""
import sys
from fractions import Fraction
from itertools import product


def parity_failures(n_pairs):
    bad = 0
    for c in range(4):
        pairs = [(c + i) % 4 for i in range(n_pairs)]  # j for the pairs (j, j+1) with ALT available
        for m in product((5, 6), repeat=4):
            if all(m[j] != m[(j + 1) % 4] for j in pairs):
                if m[(c - 1) % 4] == m[c]:
                    bad += 1
    return bad


def f2_survivors(wrong_neighbour):
    surv = 0
    b = Fraction(60) + Fraction(1, 4)
    while b < 120:
        cones = [180 - b, b, Fraction(60), Fraction(120)]  # indices c, c+1, c+2, c+3
        a_c = cones[0]
        a_nb = cones[1] if wrong_neighbour else cones[3]  # a_{c-1} = a_{c+3}
        if a_c == 60 or a_nb + a_c <= 180:
            surv += 1
        b += Fraction(1, 4)
    return surv


def main():
    n_pairs = 2 if '--fault-two' in sys.argv else 3
    pf = parity_failures(n_pairs)
    fs = f2_survivors('--fault-case' in sys.argv)
    if pf == 0 and fs == 0:
        print('e2one: parity ok; F2 ok')
    else:
        print(f'e2one: parity failures {pf}; F2 survivors {fs}')


main()
