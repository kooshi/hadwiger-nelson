#!/usr/bin/env python3
"""X03D stage 4 check: the Weyl average of chi_{P'} over the Pythagorean points of height <= N, against the derived limit prod (1 - 1/p).

chi_{P'}(r) = prod_{p in P'} e({iota_pibar(r)}_p), pibar = x - y i with x^2 + y^2 = p, iota_pibar(i) = the p-adic sqrt(-1) that is
= x/y (mod p). U_N = {(a + b i)/c : a^2 + b^2 = c^2, gcd = 1, c <= N} (c = H(u), plans/FS100-X03D-derivation.md §4). Exact integer
arithmetic for the character values; the average is a float of exact roots of unity (tolerance stated).
Derived (stage 4): lim_N avg_{U_N} chi_{P'} = prod_{p in P'} (1 - 1/p).
Plants: --plant-root uses a residue that is not sqrt(-1) (chi is then no character); --plant-pred predicts 1 - 1/(p+1). Both must fail.
"""
import sys, math, cmath
from math import gcd

def sqrtm1(p, K):
    x = next(x for x in range(1, math.isqrt(p) + 1) if math.isqrt(p - x * x) ** 2 == p - x * x)
    y = math.isqrt(p - x * x)
    r = x * pow(y, -1, p) % p            # iota_pibar(i) mod p, pibar = x - y i
    assert (r * r + 1) % p == 0
    mod = p
    for _ in range(K):                   # Hensel lift
        mod2 = mod * p
        r = (r - (r * r + 1) * pow(2 * r, -1, mod2)) % mod2
        mod = mod2
    assert (r * r + 1) % mod == 0
    return r, mod

def points(N):
    pts = [(1, 0, 1), (-1, 0, 1), (0, 1, 1), (0, -1, 1)]
    m = 2
    while m * m + 1 <= N:
        for n in range(1, m):
            if (m - n) % 2 == 1 and gcd(m, n) == 1:
                A, B, C = m * m - n * n, 2 * m * n, m * m + n * n
                if C > N:
                    break
                for (a, b) in [(A, B), (B, A)]:
                    for sa in (1, -1):
                        for sb in (1, -1):
                            pts.append((sa * a, sb * b, C))
        m += 1
    return pts

def chi_value(a, b, c, roots):
    phase = 0.0
    for p, (r, mod) in roots.items():
        k = 0
        cc = c
        while cc % p == 0:
            cc //= p; k += 1
        if k == 0:
            continue
        pk = p ** k
        num = ((a + b * r) * pow(cc, -1, pk)) % pk
        phase += num / pk
    return cmath.exp(2j * math.pi * phase)

def run(N, Pp, plant_root=False, plant_pred=False):
    roots = {}
    for p in Pp:
        r, mod = sqrtm1(p, 12)
        if plant_root:
            r = (r + 1) % mod
        roots[p] = (r, mod)
    pts = points(N)
    s = sum(chi_value(a, b, c, roots) for (a, b, c) in pts)
    avg = s / len(pts)
    pred = 1.0
    for p in Pp:
        pred *= (1 - 1 / (p + 1)) if plant_pred else (1 - 1 / p)
    return len(pts), avg, pred

def main():
    pr = "--plant-root" in sys.argv
    pp = "--plant-pred" in sys.argv
    N = 400000
    isprime = lambda q: q > 1 and all(q % d for d in range(2, math.isqrt(q) + 1))
    sparse = []                                                       # least prime = 1 (mod 4) above 4^k, k = 1..9
    for k in range(1, 10):
        q = 4 ** k + 1
        while not (q % 4 == 1 and isprime(q)):
            q += 1
        sparse.append(q)
    ok = True
    for Pp in ([5], [13], [5, 13], sparse):
        n, avg, pred = run(N, Pp, pr, pp)
        err = abs(avg - pred)
        print(f"P' = {Pp}: #U_N = {n}, avg = {avg.real:+.5f}{avg.imag:+.5f}i, predicted {pred:.5f}, |diff| = {err:.2e}")
        ok &= err < 5e-3
    print("ALL CHECKS PASS" if ok else "CHECK FAILED")
    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
