#!/usr/bin/env python3
"""SEARCH-2026-10-03: the exact spectrum of U_Q = Cay(F_{Q^2}, mu_{Q+1}), Q = 2^m, and its Hoffman sign at four colours.

Exact integer arithmetic, no search: the eigenvalue at the additive character x -> (-1)^Tr(a x) is the integer
lambda_a = sum over u in mu_{Q+1} of (-1)^Tr(a u), Tr the absolute trace F_{Q^2} -> F_2. Hoffman's bound at k colours is tight iff
lambda_min = -d/(k-1) (G54); slack iff lambda_min < -d/(k-1). Prints, per m: d, the distinct eigenvalues with multiplicities,
lambda_min, the Hoffman floor 1 - d/lambda_min, and the sign of lambda_min + d/3.

Control: m = 2 must give the Clebsch graph's spectrum {5^1, 1^10, -3^5}; m = 1 gives K_4's {3^1, -1^3}.
Usage: python3 tools/search_20261003_spectrum.py [m ...]     (default 1 2 3 4 5)
"""
import sys
from fractions import Fraction

PRIM = {2: 0b111, 4: 0b10011, 6: 0b1000011, 8: 0b100011101, 10: 0b10000001001}


def mul(a, b, p, deg):
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> deg & 1:
            a ^= p
    return r


def spectrum(m):
    deg = 2 * m
    p = PRIM[deg]
    size = 1 << deg
    Q = 1 << m

    def power(z, e):
        r = 1
        while e:
            if e & 1:
                r = mul(r, z, p, deg)
            z = mul(z, z, p, deg)
            e >>= 1
        return r

    def tr(z):
        t, s = 0, z
        for _ in range(deg):
            t ^= s
            s = mul(s, s, p, deg)
        assert t in (0, 1)
        return t

    mu = [z for z in range(1, size) if power(z, Q + 1) == 1]
    assert len(mu) == Q + 1
    ev = {}
    for a in range(size):
        lam = sum(1 - 2 * tr(mul(a, u, p, deg)) for u in mu)
        ev[lam] = ev.get(lam, 0) + 1
    d = Q + 1
    lmin = min(ev)
    return d, dict(sorted(ev.items())), lmin, 1 - Fraction(d, lmin), Fraction(lmin) + Fraction(d, 3)


if __name__ == "__main__":
    ms = [int(x) for x in sys.argv[1:]] or [1, 2, 3, 4, 5]
    for m in ms:
        d, ev, lmin, floor, sign = spectrum(m)
        verdict = "TIGHT" if sign == 0 else ("SLACK" if sign < 0 else "NOT 4-COLOURABLE (floor > 4)")
        print(f"U_{1 << m}: d = {d}; spectrum {ev}; lambda_min = {lmin}; Hoffman floor 1 - d/lambda_min = {floor} "
              f"= {float(floor):.4f}; lambda_min + d/3 = {sign}: {verdict} at four colours")
