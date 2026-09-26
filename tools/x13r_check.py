#!/usr/bin/env python3
"""X13R: two exact checks of X03D-ED2's ingredients (plans/FS100-X03D-derivation.md §4.2-4.3), independent of tools/x03d_weyl.py.

(A) The classical input of §4.3, directly: the points u = (a+bi)/c of U_N (primitive a^2+b^2=c^2, c <= N) have t_p(u) = iota_{pi_p}(u)
    equidistributed in P^1(Z/p^k): each of the p^(k-1)(p+1) classes gets 1/(p^(k-1)(p+1)). Checked at p = 5, k = 2 (30 classes) and jointly
    at (5, 13), k = 1 (6 x 14 = 84 classes). Exact integer arithmetic; the only float is the final relative deviation.
(B) The discontinuity witness of §4.2, built exactly for S = {13}, n = 6, M = 2, eps = 1/1000, P' = least primes = 1 (mod 4) above 4^k:
    r = lam0 (y/p - z/q'^j) must lie in the basic neighbourhood W (r in nR, |r| < eps, both 13-adic coordinates in 13^M Z_13) and have
    chi_{P'}(r) = e(floor(p/2)/p). chi is evaluated exactly at every prime of P' dividing r's denominator.
Plants: --plant-root replaces iota_{pi_p}(i) by a non-root in (A) (the parametrisation is then wrong; (A) must go red);
        --plant-q takes q' inside P' in (B) (the witness then picks up a second factor; (B) must go red).
"""
import sys, math
from fractions import Fraction
from math import gcd

K = 24

def isprime(q):
    return q > 1 and all(q % d for d in range(2, math.isqrt(q) + 1))

def root_pibar(p):
    """iota_{pibar}(i) mod p^K, pibar = x - y i, x^2 + y^2 = p (so i = x/y mod pibar)."""
    x = next(x for x in range(1, math.isqrt(p) + 1) if math.isqrt(p - x * x) ** 2 == p - x * x)
    y = math.isqrt(p - x * x)
    r, mod = x * pow(y, -1, p) % p, p
    for _ in range(K - 1):
        mod2 = mod * p
        r = (r - (r * r + 1) * pow(2 * r, -1, mod2)) % mod2
        mod = mod2
    assert (r * r + 1) % mod == 0
    return r, mod

def vp(n, p):
    if n == 0:
        return 10 ** 9
    v = 0
    while n % p == 0:
        n //= p; v += 1
    return v

def triples(N):
    out = [(1, 0, 1), (-1, 0, 1), (0, 1, 1), (0, -1, 1)]
    m = 2
    while m * m + 1 <= N:
        for n in range(1, m):
            if (m - n) % 2 == 1 and gcd(m, n) == 1:
                A, B, C = m * m - n * n, 2 * m * n, m * m + n * n
                if C > N:
                    break
                for (a, b) in ((A, B), (B, A)):
                    for sa in (1, -1):
                        for sb in (1, -1):
                            out.append((sa * a, sb * b, C))
        m += 1
    return out

def p1_class(a, b, c, p, rho, k):
    """class of t = (a + b rho)/c in P^1(Z/p^k); rho = iota_{pi_p}(i) mod p^K."""
    mod = p ** K
    A = (a + b * rho) % mod
    vA, vC = vp(A, p), vp(c, p)
    assert vA < K - k
    uA, uC = (A // p ** vA) % p ** k, (c // p ** vC) % p ** k
    vt = vA - vC
    pk = p ** k
    if vt >= 0:
        return ("fin", (uA * pow(uC, -1, pk) * pow(p, vt, pk)) % pk)
    return ("inf", (uC * pow(uA, -1, pk) * pow(p, -vt, pk)) % pk)

def check_A(plant_root):
    N = 100000
    pts = triples(N)
    rho = {}
    for p in (5, 13):
        r, _ = root_pibar(p)
        r = (-r) % p ** K                       # iota_{pi_p}(i) = conjugate root
        if plant_root:
            r = (r + 1) % p ** K
        rho[p] = r
    ok = True
    for label, spec in (("p=5, k=2", [(5, 2)]), ("(5,13), k=1", [(5, 1), (13, 1)])):
        counts = {}
        for (a, b, c) in pts:
            key = tuple(p1_class(a, b, c, p, rho[p], k) for (p, k) in spec)
            counts[key] = counts.get(key, 0) + 1
        ncls = 1
        for (p, k) in spec:
            ncls *= p ** (k - 1) * (p + 1)
        exp = len(pts) / ncls
        dev = max(abs(counts.get(key, 0) - exp) for key in all_keys(spec)) / exp
        tol = 0.05 if len(spec) == 1 else 0.10
        print(f"(A) {label}: #U_N = {len(pts)}, classes seen {len(counts)} of {ncls}, max relative deviation {dev:.4f} (tolerance {tol})")
        ok &= (len(counts) == ncls and dev < tol)
    return ok

def all_keys(spec):
    keys = [()]
    for (p, k) in spec:
        pk = p ** k
        cls = [("fin", x) for x in range(pk)] + [("inf", x) for x in range(0, pk, p)]
        keys = [kk + (c,) for kk in keys for c in cls]
    return keys

def frac_p(re, im, p, rho):
    """{re + im*rho}_p for re, im in Q with denominators prime to p except powers of p; returns a Fraction in [0,1)."""
    D = re.denominator * im.denominator // gcd(re.denominator, im.denominator)
    k = vp(D, p)
    if k == 0:
        return Fraction(0)
    pk = p ** k
    Dp = D // pk
    X = (re.numerator * (D // re.denominator) + im.numerator * (D // im.denominator) * rho) % pk
    return Fraction((X * pow(Dp, -1, pk)) % pk, pk)

def check_B(plant_q):
    Pp = []
    for k in range(1, 12):
        q = 4 ** k + 1
        while not (q % 4 == 1 and isprime(q)):
            q += 1
        Pp.append(q)
    S, n, M, eps = [13], 6, 2, Fraction(1, 1000)
    sigma = 1
    for s in S:
        sigma *= s
    lam0 = n * sigma ** M
    p = next(x for x in Pp if x not in S and gcd(x, n * sigma) == 1)
    if plant_q:
        q = next(x for x in Pp if x != p and x not in S and gcd(x, n * sigma) == 1)
    else:
        q = next(x for x in range(5, 10 ** 6) if x % 4 == 1 and isprime(x) and x not in Pp and x not in S and gcd(x, n) == 1)
    rp, _ = root_pibar(p)
    target = p // 2
    # y in Z (a rational integer suffices): iota_p(lam0*y) = lam0*y = target mod p
    y = (target * pow(lam0, -1, p)) % p
    j = 1
    while Fraction(lam0, q ** j) >= eps:          # mesh of lam0 Z[i]/q^j; rounding error <= mesh/sqrt(2)
        j += 1
    zr = round(Fraction(y * q ** j, p))            # nearest z, real part; imaginary part 0
    re = lam0 * (Fraction(y, p) - Fraction(zr, q ** j))
    im = Fraction(0)
    in_nR = all(vp(x.denominator, pr) == 0 or pr in (p, q) for x in ((re / n), (im / n)) for pr in prime_factors(x.denominator))
    small = re * re + im * im < eps * eps
    sadic = all((x == 0 or vp(x.numerator, s) - vp(x.denominator, s) >= M) for x in (re, im) for s in S)
    val = Fraction(0)
    den = re.denominator * im.denominator
    for pr in prime_factors(den):
        if pr in Pp:
            rho, _ = root_pibar(pr)
            val += frac_p(re, im, pr, rho)
    val %= 1
    want = Fraction(target, p)
    dist = abs(2 * math.sin(math.pi * float(val)))   # |e(val) - 1|
    print(f"(B) S={S}, n={n}, M={M}, eps={eps}: p={p}, q'={q}{' (PLANT: q in P)' if plant_q else ''}, j={j}; "
          f"r in nR: {in_nR}, |r|<eps: {small}, S-adic: {sadic}; chi(r) = e({val}), want e({want}); |chi(r)-1| = {dist:.4f}")
    return in_nR and small and sadic and val == want and dist > 1.9

def prime_factors(n):
    out, d = [], 2
    while d * d <= n:
        if n % d == 0:
            out.append(d)
            while n % d == 0:
                n //= d
        d += 1
    if n > 1:
        out.append(n)
    return out

def main():
    okA = check_A("--plant-root" in sys.argv)
    okB = check_B("--plant-q" in sys.argv)
    print("ALL CHECKS PASS" if okA and okB else f"CHECK FAILED (A: {okA}, B: {okB})")
    return 0 if okA and okB else 1

if __name__ == "__main__":
    sys.exit(main())
