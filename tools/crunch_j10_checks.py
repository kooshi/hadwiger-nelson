#!/usr/bin/env python3
"""Crunch J10 (FS-91 S1V): exact checks of the blind verifier's derived claims.  Seconds; no search.

Each check verifies a statement the derivation in `plans/FS91-S1V-character.md` fixed first, over a finite set the derivation
fixed first (logged there as at the edge of the finite-witness ban: a complete exact enumeration of a derivation-fixed set).

(A) The descent lemma (V3's new step), at level two over Q_p, p = 3 (mod 4): the residue target
    T_2 = Cay(Z[i]/p^2, S_2), S_2 = {x : x * conj(x) = 1 mod p^2} (the image of the local norm-one group, by Hensel: the norm-one
    torus is smooth over Z_p), has |S_2| = p(p+1), every fibre over S_1 of size p, and -- the claim -- when 2p > k every band
    k-character of T_2 (a character with all values on S_2 in [1/k, 1 - 1/k]) is trivial on p*Z[i]/p^2, i.e. comes from level one.
    For 2p <= k the count of band characters NOT from level one is printed (information only: the exception clause of CLG-g).
    PLANT A: replace S_2 by one lift per point of S_1 (the fibres deleted).  The descent's reason is the fibre, so the plant must
    produce a non-descending band character at some (p, k) with 2p > k, and the unplanted run must produce none.
(B) C9's value set (row 94): theta = (2x + 3y)/7 on the eight points of the circle over F_7 lies in [2/7, 5/7], inside B_4; and 7 splits
    in Q(sqrt 11) with 7 = 3 (mod 4), so both places above 7 are stable with level-one target Gamma_7.
    PLANT B: theta' = (x + y)/7 must fail the band (it reads 1/7 at (1, 0)).
(C) The residue arithmetic the controls use (Legendre symbols and 2-adic square classes), each an assert.

Exit status 0 only if every unplanted check passes AND every plant fires.
"""
import sys
from fractions import Fraction

import numpy as np


def circle(p, m):
    """All x = a + bi in Z[i]/p^m with a^2 + b^2 = 1 (mod p^m), as integer pairs."""
    n = p ** m
    a = np.arange(n).reshape(-1, 1)
    b = np.arange(n).reshape(1, -1)
    mask = (a * a + b * b) % n == 1
    ia, ib = np.nonzero(mask)
    return np.stack([ia, ib], axis=1)


def band_mask(vals_num, n, k):
    """vals_num: integers v; value v/n in R/Z; band iff k*min(v, n - v) >= n (i.e. ||v/n|| >= 1/k), exactly."""
    v = vals_num % n
    d = np.minimum(v, n - v)
    return k * d >= n


def band_characters_level2(p, S2, k):
    """All characters (a, b) of (Z/p^2)^2 = Z[i]/p^2, x + iy -> (a x + b y)/p^2; return the (a, b) with every value on S2 in B_k."""
    n = p * p
    A = np.arange(n)
    a = np.repeat(A, n)
    b = np.tile(A, n)
    ok = np.ones(n * n, dtype=bool)
    for (x, y) in S2:
        ok &= band_mask(a * int(x) + b * int(y), n, k)
    return a[ok], b[ok]


def check_A(plant=False):
    """Returns (failures, plant_fired)."""
    failures = []
    fired = False
    for p in (3, 7, 11):
        S1 = circle(p, 1)
        S2 = circle(p, 2)
        if len(S1) != p + 1:
            failures.append(f"|S_1| = {len(S1)} != p+1 at p={p}")
        if len(S2) != p * (p + 1):
            failures.append(f"|S_2| = {len(S2)} != p(p+1) at p={p}")
        # fibre sizes
        fib = {}
        for (x, y) in S2:
            fib.setdefault((x % p, y % p), []).append((x, y))
        if sorted(len(v) for v in fib.values()) != [p] * (p + 1):
            failures.append(f"fibres of S_2 -> S_1 not all of size p at p={p}")
        if plant:
            # one lift per level-one point (the fibres deleted): the smallest representative
            S2 = np.array([min(v) for v in fib.values()])
        for k in range(3, 10):
            a, b = band_characters_level2(p, S2, k)
            nondesc = int(np.sum((a % p != 0) | (b % p != 0)))
            total = len(a)
            if 2 * p > k:
                if nondesc != 0:
                    if plant:
                        fired = True
                    else:
                        failures.append(f"p={p} k={k}: {nondesc} band characters not from level one (2p > k)")
                elif not plant:
                    print(f"  A p={p:2d} k={k}: band characters {total:5d}, all from level one (2p > k)  OK")
            else:
                if not plant:
                    print(f"  A p={p:2d} k={k}: band characters {total:5d}, not from level one {nondesc:4d} (2p <= k: exception clause, info)")
    return failures, fired


def check_B(plant=False):
    failures = []
    q = 7
    pts = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    if len(pts) != q + 1:
        failures.append("circle over F_7 does not have 8 points")
    ca, cb = (1, 1) if plant else (2, 3)
    vals = sorted({Fraction((ca * x + cb * y) % q, q) for (x, y) in pts})
    inband = all(Fraction(1, 4) <= v <= Fraction(3, 4) for v in vals)
    if not plant:
        print(f"  B values of (2x+3y)/7 on the F_7 circle: {[str(v) for v in vals]}; inside [1/4, 3/4]: {inband}")
        if vals != [Fraction(j, 7) for j in (2, 3, 4, 5)] or not inband:
            failures.append("C9's value set is not {2,3,4,5}/7 inside B_4")
        # 7 splits in Q(sqrt 11): 11 is a square mod 7; 7 = 3 mod 4 so each place above 7 (residue F_7) is inert in F(i)
        if pow(11 % 7, (7 - 1) // 2, 7) != 1 or 7 % 4 != 3:
            failures.append("7 is not split in Q(sqrt11) with stable places above it")
        return failures, False
    return failures, (not inband)


def legendre(a, p):
    r = pow(a % p, (p - 1) // 2, p)
    return -1 if r == p - 1 else r


def check_C():
    failures = []
    # dyadic behaviour: Q(sqrt d) with d = 7 (mod 8): -d = 1 (mod 8) is a 2-adic square, so Q_2(sqrt d) = Q_2(i), split in F(i): no stable
    # dyadic place.  d = 3 (mod 8): 3d = 1 (mod 8), Q_2(sqrt d) = Q_2(sqrt 3), and F(i)_v = Q_2(sqrt3, sqrt-3) unramified: inert, stable.
    for d in (47, 167):
        if (-d) % 8 != 1:
            failures.append(f"{d}: dyadic place not split")
    for d in (59, 83, 131, 11):
        if (3 * d) % 8 != 1:
            failures.append(f"{d}: dyadic completion is not Q_2(sqrt 3)")
    # odd stable places of Q(sqrt d): primes q = 3 (mod 4) split in F (legendre(d, q) = 1) or q = d; 3 and 7 must be unusable
    for d in (47, 59, 83, 131):
        for q in (3, 7):
            if legendre(d, q) != -1:
                failures.append(f"{q} is usable for Q(sqrt {d})")
        if d % 4 != 3:
            failures.append(f"{d} != 3 mod 4")
    usable = {d: [q for q in range(3, 60) if q % 4 == 3 and all(q % r for r in range(2, q)) and legendre(d, q) == 1]
              for d in (47, 59, 83, 131, 167)}
    print(f"  C usable primes q < 60, q = 3 (mod 4), split in Q(sqrt d): {usable}")
    if usable[167][:2] != [23, 43]:
        failures.append("the first usable primes of Q(sqrt167) are not 23, 43")
    return failures


def main():
    fails = []
    print("(A) descent at level two")
    f, _ = check_A(plant=False)
    fails += f
    f, firedA = check_A(plant=True)
    fails += f
    print(f"  PLANT A (fibres deleted): fired = {firedA}")
    print("(B) C9's value set")
    f, _ = check_B(plant=False)
    fails += f
    _, firedB = check_B(plant=True)
    print(f"  PLANT B ((x+y)/7): fired = {firedB}")
    print("(C) residue arithmetic")
    fails += check_C()
    if not firedA:
        fails.append("PLANT A did not fire: the descent check cannot see a deleted fibre")
    if not firedB:
        fails.append("PLANT B did not fire")
    if fails:
        print("FAIL:")
        for x in fails:
            print("   ", x)
        sys.exit(1)
    print("ALL CHECKS PASS; both plants fired")


if __name__ == "__main__":
    main()
