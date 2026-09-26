#!/usr/bin/env python3
"""J51D exact check: the conjugate-pair dichotomy behind the refutations of KS-1 and KS-3 (FS-100, Kronecker selection).

Derived claim (plans/FS100-J51D-derivation.md, stage 2):  over F = Q, R = Z[U] = Z[i][1/p : p = 1 mod 4], p = 5, pi = 2 + i.
For every rational unit vector u = (a + b i)/c:
  (D1) v_pi(u) = -v_pibar(u), so psi_pi(u) and psi_pibar(u) are never both non-zero   (the "OR" fibre);
  (D2) tau(u) = 1/2 for the parity character tau(x) = (x mod (1+i))/2;
  (D3) hence Theta(u) = (tau + psi_pi, tau + psi_pibar)(u) has a coordinate exactly 1/2, and
       W(t1, t2) = 2[t1 >= 1/2] + [t2 >= 1/2] satisfies W(t) != W(t + Theta(u)) for EVERY t in T^2;
  (D4) end to end: the colouring x -> W(Theta(x) + t) is proper on sampled edges {x, x + u}, x in R, t random rational.
The set checked is fixed in advance: every rational unit vector of height c <= H (a complete enumeration of a finite set whose extent the
derivation fixes; standing rule 3's edge).  Also checked: C9's values on the circle over F_7 (KS-4).

Plants (each must make the check FAIL, and the run reports that it did):
  P1  psi at the prime 3 + 2i (above 13) in place of pibar: then both coordinates are non-zero together for some u  -> (D1) fires.
  P2  a wrong parity (a mod 2)/2 in place of tau                                                                  -> (D2) fires.
  P3  C9 read as (2x + 2y)/7                                                                                      -> the C9 check fires.
Usage: python3 tools/j51d_or_check.py [H]      (exit 0 iff every unplanted check passes and every plant fires)
"""
from fractions import Fraction
from math import gcd, isqrt
import random
import sys

P = 5
N = 30  # 5-adic precision; heights <= 10^5 give valuations < 8


def sqrt_minus1_mod(p, n, r0):
    """Hensel-lift r0 (r0^2 = -1 mod p) to r (r^2 = -1 mod p^n)."""
    r, m = r0, p
    for _ in range(n):
        m2 = m * p
        # Newton step for f(r) = r^2 + 1
        r = (r - (r * r + 1) * pow(2 * r, -1, m2)) % m2
        m = m2
    assert (r * r + 1) % (p ** n) == 0
    return r % (p ** n)


R_PI = sqrt_minus1_mod(5, N, 3)     # at pi = 2 + i : i = -2 = 3 (mod pi)
R_PIBAR = sqrt_minus1_mod(5, N, 2)  # at pibar = 2 - i : i = 2 (mod pibar)
R_13 = sqrt_minus1_mod(13, N, 8)    # a place above 13 (3 + 2i: i = -3*2^{-1} = 5 mod 13 ... any root is a place above 13)


def v_p(n, p):
    if n == 0:
        return 10 ** 9
    k = 0
    while n % p == 0:
        n //= p
        k += 1
    return k


def psi_local(A, B, D, r, p):
    """p-adic fractional part of iota(x), x = (A + B i)/D in Z[i][1/D], iota(i) = r (a root of -1 mod p^N)."""
    e = v_p(D, p)
    if e == 0:
        return Fraction(0)
    Dp = D // p ** e
    num = (A + B * r) % (p ** N)
    y = (num * pow(Dp, -1, p ** N)) % (p ** e)
    return Fraction(y, p ** e)


def val_local(A, B, D, r, p):
    num = (A + B * r) % (p ** N)
    return v_p(num, p) - v_p(D, p)


def parity(A, B, D, wrong=False):
    """tau(x) = (x mod (1+i))/2 for x = (A + Bi)/D with D odd; x mod (1+i) = (A + B) * D^{-1} mod 2 = (A + B) mod 2."""
    assert D % 2 == 1
    if wrong:
        return Fraction(A % 2, 2)
    return Fraction((A + B) % 2, 2)


def unit_vectors(H):
    """All rational unit vectors (a + bi)/c, gcd = 1, c <= H (Euclid's parametrisation plus signs, swaps and the four axis points)."""
    out = {(1, 0, 1), (-1, 0, 1), (0, 1, 1), (0, -1, 1)}
    for m in range(1, isqrt(H) + 2):
        for n in range(1, m):
            if (m - n) % 2 == 1 and gcd(m, n) == 1:
                a, b, c = m * m - n * n, 2 * m * n, m * m + n * n
                if c > H:
                    continue
                for (x, y) in ((a, b), (b, a)):
                    for sx in (1, -1):
                        for sy in (1, -1):
                            out.add((sx * x, sy * y, c))
    return sorted(out)


def W(t1, t2):
    return 2 * (1 if (t1 % 1) >= Fraction(1, 2) else 0) + (1 if (t2 % 1) >= Fraction(1, 2) else 0)


def run(H, plant=None):
    us = unit_vectors(H)
    r2 = R_13 if plant == "P1" else R_PIBAR
    p2 = 13 if plant == "P1" else 5
    both_nonzero = 0
    n1 = n2 = 0
    val_mismatch = 0
    bad_parity = 0
    bad_flip = 0
    for (a, b, c) in us:
        assert a * a + b * b == c * c
        s1 = psi_local(a, b, c, R_PI, 5)
        s2 = psi_local(a, b, c, r2, p2)
        n1 += (s1 != 0)
        n2 += (s2 != 0)
        if s1 != 0 and s2 != 0:
            both_nonzero += 1
        if plant is None and val_local(a, b, c, R_PI, 5) != -val_local(a, b, c, R_PIBAR, 5):
            val_mismatch += 1
        tau = parity(a, b, c, wrong=(plant == "P2"))
        if tau != Fraction(1, 2):
            bad_parity += 1
        th = ((tau + s1) % 1, (tau + s2) % 1)
        if th[0] != Fraction(1, 2) and th[1] != Fraction(1, 2):
            bad_flip += 1
    # end-to-end: x = sum of k unit vectors, edge {x, x+u}, t random rational
    rng = random.Random(51)
    bad_edges = 0
    sample = [u for u in us if u[2] <= 400]
    for _ in range(4000):
        k = rng.randint(1, 4)
        pts = [rng.choice(us) for _ in range(k)]
        u = rng.choice(sample)
        t = (Fraction(rng.randint(0, 10 ** 6), 10 ** 6), Fraction(rng.randint(0, 10 ** 6), 10 ** 6))

        def theta(vecs):
            s = [Fraction(0), Fraction(0)]
            for (a, b, c) in vecs:
                tau = parity(a, b, c, wrong=(plant == "P2"))
                s[0] += tau + psi_local(a, b, c, R_PI, 5)
                s[1] += tau + psi_local(a, b, c, r2, p2)
            return s

        x = theta(pts)
        y = theta(pts + [u])
        if W(x[0] + t[0], x[1] + t[1]) == W(y[0] + t[0], y[1] + t[1]):
            bad_edges += 1
    return dict(n_units=len(us), psi_pi_nonzero=n1, psi_2_nonzero=n2, both_nonzero=both_nonzero, val_mismatch=val_mismatch, bad_parity=bad_parity,
                bad_flip=bad_flip, bad_edges=bad_edges)


def c9_check(plant=False):
    pts = [(x, y) for x in range(7) for y in range(7) if (x * x + y * y) % 7 == 1]
    vals = sorted({((2 * x + (2 if plant else 3) * y) % 7) for (x, y) in pts})
    return len(pts), vals, all(v in (2, 3, 4, 5) for v in vals)


def main():
    H = int(sys.argv[1]) if len(sys.argv) > 1 else 20000
    ok = True
    res = run(H)
    print(f"H={H}: {res}")
    # positive signal: the dichotomy is not vacuous (each coordinate is non-zero on many unit vectors)
    clean = res["psi_pi_nonzero"] > 1000 and res["psi_2_nonzero"] > 1000 and res["both_nonzero"] == 0 and res["val_mismatch"] == 0 and res["bad_parity"] == 0 and res["bad_flip"] == 0 \
        and res["bad_edges"] == 0
    print("D1-D4 (unplanted):", "PASS" if clean else "FAIL")
    ok &= clean
    n, vals, good = c9_check()
    print(f"C9 over F_7: {n} circle points, values of 2x+3y mod 7 = {vals}:", "PASS" if (n == 8 and good) else "FAIL")
    ok &= (n == 8 and good)
    # plants
    r1 = run(min(H, 3000), plant="P1")
    fired1 = r1["both_nonzero"] > 0 and r1["bad_flip"] > 0
    print(f"plant P1 (13 in place of pibar): {r1} ->", "FIRED" if fired1 else "DID NOT FIRE")
    r2 = run(min(H, 3000), plant="P2")
    fired2 = r2["bad_parity"] > 0
    print(f"plant P2 (wrong parity): {r2} ->", "FIRED" if fired2 else "DID NOT FIRE")
    _, _, g3 = c9_check(plant=True)
    fired3 = not g3
    print("plant P3 (C9 as 2x+2y):", "FIRED" if fired3 else "DID NOT FIRE")
    ok &= fired1 and fired2 and fired3
    print("OVERALL:", "PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
