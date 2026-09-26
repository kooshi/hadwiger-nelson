#!/usr/bin/env python3
"""J28V exact checks of seconds (crunch 2026-09-25): facts the blind T-C / T-C(A) route uses.

(1) Which small odd primes are STABLE places of F = Q(sqrt d) (p odd, p = 3 mod 4, p unramified: stable iff p splits in F,
    i.e. (d/p) = +1; the residue field is then F_p; p | d ramified is stable when p = 3 mod 4).  Expected: 3, 7 never stable at
    d in {59, 83, 131, 47}; 11 stable only at 59 and 47; 19 stable at 83, 131, 47, not at 59.
(2) The tail's normalised least eigenvalue a_v < 1/3: from a Hoffman ratio r, a = r/(1-r); at 31 r = 1/4 - 2.745e-6 gives
    a < 1/3; Weil's a <= 2 sqrt(p)/(p+1) < 1/3 for every p >= 37 (exact: 36 p < (p+1)^2 ... i.e. 4p*9 < (p+1)^2).
(3) Split place at q = 2 (C14.2(c)'s integrals): I(b) = mean over units e mod 2^M of exp(2 pi i b e) for b = u/2^k:
    k = 0 -> 1, k = 1 -> -1 (= -1/(q-1)), k >= 2 -> 0.  FLOAT complex exponential sums over the units mod 2^12, compared
    with those exact target values at tolerance 1e-9 (the targets are exact by symmetry: e -> e + 2^(k-1) negates each term
    for k >= 2).  Grade: tools float with exact targets, not exact arithmetic.
Planted faults: --plant flips the expectation in (1) at (59, 11), and in (3) at k = 2; each must make the script exit non-zero.
"""
import sys
from fractions import Fraction
import cmath, math

PLANT = "--plant" in sys.argv

def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1

def stable_odd(d, p):
    # p odd prime, p = 3 mod 4
    if d % p == 0:
        return True           # ramified; residue field F_p with p = 3 mod 4 -> -1 not a square -> stable
    return legendre(d, p) == 1  # split in F -> residue F_p, stable; inert -> F_{p^2}, split in F(i)

fail = 0
expected = {
    59: {3: False, 7: False, 11: True, 19: False, 23: True, 31: True, 43: True, 47: True, 59: True},
    83: {3: False, 7: False, 11: False, 19: True, 43: True, 47: True, 83: True},
    131: {3: False, 7: False, 11: False, 19: True, 23: True, 31: True, 47: True, 131: True},
    47: {3: False, 7: False, 11: True, 19: True, 23: True, 31: True, 47: True},
}
if PLANT:
    expected[59][11] = False
for d, tab in expected.items():
    for p, want in tab.items():
        got = stable_odd(d, p)
        if got != want:
            print(f"FAIL (1): d={d} p={p} stable={got}, expected {want}")
            fail += 1
# the complete list of stable p = 3 mod 4 below 60, for the record
for d in (59, 83, 131, 47):
    lst = [p for p in range(3, 60) if all(p % q for q in range(2, p)) and p % 4 == 3 and stable_odd(d, p)]
    print(f"(1) d={d}: stable odd places p<60: {lst}")

# (2)
r31 = Fraction(1, 4) - Fraction(2745, 10**9)
a31 = r31 / (1 - r31)
print(f"(2) a_31 = {float(a31):.9f}  (1/3 - a_31 = {float(Fraction(1,3) - a31):.3e})")
if not a31 < Fraction(1, 3):
    print("FAIL (2): a_31 >= 1/3"); fail += 1
# Weil: 2 sqrt(p)/(p+1) < 1/3  <=>  36 p < (p+1)^2   (both sides positive)
bad = [p for p in range(37, 100000) if all(p % q for q in range(2, int(p**0.5) + 1)) and not (36 * p < (p + 1) ** 2)]
print(f"(2) primes 37 <= p < 1e5 failing Weil's a < 1/3: {bad}")
if bad:
    fail += 1
# the boundary: 36 p < (p+1)^2 fails exactly for p in a finite interval; show where
roots = [p for p in range(2, 40) if not (36 * p < (p + 1) ** 2)]
print(f"(2) integers p < 40 where Weil does not give a < 1/3: {roots[0]}..{roots[-1]}")

# (3)
def unit_mean(k, M=12):
    # b = 1/2^k (any unit numerator behaves the same: multiplication by a unit permutes the units)
    s = 0j
    n = 0
    for e in range(1, 2 ** M, 2):
        s += cmath.exp(2j * math.pi * e / 2 ** k)
        n += 1
    return s / n
want3 = {0: 1.0, 1: -1.0, 2: 0.0, 3: 0.0, 4: 0.0, 5: 0.0}
if PLANT:
    want3[2] = -1.0
for k, w in want3.items():
    v = unit_mean(k)
    ok = abs(v - w) < 1e-9
    print(f"(3) q=2, v(b)=-{k}: mean over units = {v.real:+.12f}{v.imag:+.12f}i  expected {w:+.1f}  {'ok' if ok else 'FAIL'}")
    if not ok:
        fail += 1
print("RESULT:", "FAIL" if fail else "PASS", f"({fail} failures)")
sys.exit(1 if fail else 0)
