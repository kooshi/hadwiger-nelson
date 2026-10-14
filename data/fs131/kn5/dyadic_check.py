#!/usr/bin/env python3
"""FS131-KN5 stage 5: the three parity lemmas behind the dyadic leaves, checked exactly.

A unit vector of Q(sqrt m)^2 is u = (a + b sqrt m + c i + d i sqrt m)/N with integers, and |u| = 1 reads
    Q1: a^2 + c^2 + m (b^2 + d^2) = N^2        Q2: a b + c d = 0.
Claim, for a solution that is primitive at 2 (not all of a, b, c, d, N even), by the class of m:
  A (m = 1 mod 4): N odd and a+b+c+d odd;  or N = 2 mod 4, a = b, c = d (mod 2) and (a-b+c-d)/2 odd.
  B (m = 2 mod 4): N odd and a+c odd;      or N = 2 mod 4, a, c even, b, d odd and a/2 + c/2 + d odd.
  C (m = 3 mod 8): N odd and a+b+c+d odd;  or N = 2 mod 4, a = d, b = c (mod 2) and b+d odd.
(The last clause of each alternative is 'the additive map psi is not 0 at u'.)

Two checks, each with a positive signal:
  box:     every integer solution with |a|,|b|,|c|,|d| <= R, for every m of the class up to MMAX;
           reports how many solutions fell in each alternative (both must be exercised somewhere).
  residue: every (a, b, c, d, N) mod 16 with Q1 = 0 and Q2 = 0 (mod 16), not all even, for every residue of m mod 16
           in the class - the form a proof by cases on residues uses.
--plant K: test class K's claim on a class where it is false (A at m = 3 mod 4, B at m = 0 mod 4, C at m = 7 mod 8);
           the run must report failures and exit 1.
"""
import sys
from math import gcd, isqrt


def claim(cls, a, b, c, d, N):
    if N % 2 == 1:
        return (a + c) % 2 == 1 if cls == "B" else (a + b + c + d) % 2 == 1
    if N % 4 != 2:
        return False
    if cls == "A":
        return (a - b) % 2 == 0 and (c - d) % 2 == 0 and ((a - b + c - d) // 2) % 2 == 1
    if cls == "B":
        return a % 2 == 0 and c % 2 == 0 and b % 2 == 1 and d % 2 == 1 and (a // 2 + c // 2 + d) % 2 == 1
    return (a - d) % 2 == 0 and (b - c) % 2 == 0 and (b + d) % 2 == 1


CLASSES = {"A": (4, [1]), "B": (4, [2]), "C": (8, [3])}
PLANTS = {"A": (4, [3]), "B": (4, [0]), "C": (8, [7])}


def box(cls, mod, residues, R, mmax):
    odd = even = bad = 0
    first_bad = None
    for m in range(2, mmax + 1):
        if m % mod not in residues or isqrt(m) ** 2 == m:
            continue
        for a in range(-R, R + 1):
            for b in range(-R, R + 1):
                for c in range(-R, R + 1):
                    for d in range(-R, R + 1):
                        if a * b + c * d != 0:
                            continue
                        s = a * a + c * c + m * (b * b + d * d)
                        N = isqrt(s)
                        if N == 0 or N * N != s:
                            continue
                        if gcd(gcd(gcd(a, b), gcd(c, d)), N) % 2 == 0:
                            continue
                        if claim(cls, a, b, c, d, N):
                            if N % 2:
                                odd += 1
                            else:
                                even += 1
                        else:
                            bad += 1
                            first_bad = first_bad or (m, a, b, c, d, N)
    return odd, even, bad, first_bad


def residue(cls, mod, residues):
    seen = bad = 0
    first_bad = None
    for m in range(16):
        if m % mod not in residues:
            continue
        for a in range(16):
            for b in range(16):
                for c in range(16):
                    for d in range(16):
                        if (a * b + c * d) % 16:
                            continue
                        s = a * a + c * c + m * (b * b + d * d)
                        for N in range(16):
                            if (s - N * N) % 16:
                                continue
                            if a % 2 == 0 and b % 2 == 0 and c % 2 == 0 and d % 2 == 0 and N % 2 == 0:
                                continue
                            seen += 1
                            if not claim(cls, a, b, c, d, N):
                                bad += 1
                                first_bad = first_bad or (m, a, b, c, d, N)
    return seen, bad, first_bad


def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    table = {plant: PLANTS[plant]} if plant else CLASSES
    total_bad = 0
    for cls, (mod, residues) in table.items():
        odd, even, bad, fb = box(cls, mod, residues, R=9, mmax=45)
        print(f"box     class {cls} m%{mod} in {residues}: odd-N {odd}  even-N {even}  failures {bad}  first {fb}")
        seen, rbad, rfb = residue(cls, mod, residues)
        print(f"residue class {cls} m%{mod} in {residues}: cases {seen}  failures {rbad}  first {rfb}")
        total_bad += bad + rbad
        if not plant and (odd == 0 or even == 0 or seen == 0):
            print(f"NO POSITIVE SIGNAL for class {cls}: an alternative was never exercised")
            sys.exit(2)
    print(f"plant={plant} failures={total_bad}")
    sys.exit(1 if total_bad else 0)


if __name__ == "__main__":
    main()
