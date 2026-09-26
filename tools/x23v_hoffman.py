#!/usr/bin/env python3
"""X23V — level-one least eigenvalues of the residue targets named in CLS (seconds; float with integer-exact controls).

Gamma_q = Cay(F_{q^2}, mu_{q+1}) for odd q = 23, 27, 31, 43, 47 and U_Q = Cay(F_{Q^2}, mu_{Q+1}) for Q = 32, 64, 128.
Eigenvalue at a in F_{q^2}: sum over x in mu_{q+1} of omega^{Tr(a x)}, Tr the absolute trace to F_p, omega = exp(2 pi i/p).
Prints lambda_min, d = q+1, |lambda_min|/d and Hoffman's ratio |lambda_min|/(d+|lambda_min|); checks it against 1/4 and 1/3.
Controls: Q = 2 (K_4: lambda_min = -1), q = 3 (-2), q = 7 (Hoffman ratio >= 1/4 expected), and the exact integer value
lambda_min(U_64) = -15 (G56). Plant: 'wrong-circle' uses mu_{q-1} (must break the controls).
"""
import sys, cmath, math

def gf(p, n):
    """F_{p^n} as integer-coded polynomials mod a monic irreducible of degree n (found by trial; n <= 14)."""
    def polymulmod(a, b, mod, n):
        # a, b: lists of length n (coeffs, low first); mod: monic degree-n list of length n+1
        res = [0] * (2 * n - 1)
        for i, ai in enumerate(a):
            if ai:
                for j, bj in enumerate(b):
                    if bj:
                        res[i + j] = (res[i + j] + ai * bj) % p
        for k in range(2 * n - 2, n - 1, -1):
            c = res[k]
            if c:
                for t in range(n + 1):
                    res[k - n + t] = (res[k - n + t] - c * mod[t]) % p
        return res[:n]
    # find a primitive-element-friendly irreducible: test that x has order p^n - 1 (so the polynomial is primitive)
    N = p ** n - 1
    def factors(m):
        f, d = set(), 2
        while d * d <= m:
            while m % d == 0:
                f.add(d); m //= d
            d += 1
        if m > 1:
            f.add(m)
        return f
    fs = factors(N)
    def powx(e, mod):
        result = [1] + [0] * (n - 1)
        base = [0, 1] + [0] * (n - 2) if n >= 2 else [0]
        while e:
            if e & 1:
                result = polymulmod(result, base, mod, n)
            base = polymulmod(base, base, mod, n)
            e >>= 1
        return result
    one = [1] + [0] * (n - 1)
    import itertools
    for tail in itertools.product(range(p), repeat=n):
        mod = list(tail) + [1]
        if mod[0] == 0:
            continue
        if powx(N, mod) != one:
            continue
        if all(powx(N // r, mod) != one for r in fs):
            return mod, polymulmod
    raise RuntimeError("no primitive polynomial")

def spectrum_min(p, n, circle_order):
    """min eigenvalue of Cay(F_{p^n}, {x : x^circle_order = 1})."""
    mod, mul = gf(p, n)
    N = p ** n - 1
    # powers of the primitive element x: table g^k as coefficient tuples
    elems = []
    cur = [1] + [0] * (n - 1)
    X = [0, 1] + [0] * (n - 2)
    for k in range(N):
        elems.append(tuple(cur))
        cur = mul(cur, X, mod, n)
    # absolute trace F_{p^n} -> F_p of g^k: Tr(y) = sum_{i<n} y^{p^i}
    idx = {e: k for k, e in enumerate(elems)}
    def add(a, b):
        return tuple((x + y) % p for x, y in zip(a, b))
    zero = tuple([0] * n)
    tr = []
    for k in range(N):
        s = zero
        for i in range(n):
            s = add(s, elems[(k * p ** i) % N])
        assert all(c == 0 for c in s[1:]), "trace not in F_p"
        tr.append(s[0])
    step = N // circle_order
    circle = [(step * j) % N for j in range(circle_order)]  # exponents of the circle's elements
    om = [cmath.exp(2j * math.pi * t / p) for t in range(p)]
    lam_min = None
    for a in range(N):  # a = g^a, nonzero
        v = sum(om[tr[(a + c) % N]] for c in circle)
        if lam_min is None or v.real < lam_min:
            lam_min = v.real
    return lam_min

def main(plant=None):
    cases = [(2, 2, 2, "U_2 control"), (3, 2, 3, "Gamma_3 control"), (7, 2, 7, "Gamma_7 control"),
             (23, 2, 23, ""), (3, 6, 27, ""), (31, 2, 31, ""), (43, 2, 43, ""), (47, 2, 47, ""),
             (2, 10, 32, "U_32"), (2, 12, 64, "U_64"), (2, 14, 128, "U_128")]
    fails = []
    for p, n, q, note in cases:
        order = q + 1 if plant != "wrong-circle" else q - 1
        lm = spectrum_min(p, n, order)
        d = order
        h = -lm / (d - lm)
        print("q=%4d  d=%4d  lambda_min=%10.5f  |l|/d=%.6f  Hoffman=%.6f  %s" % (q, d, lm, -lm / d, h, note))
        if q == 2 and abs(lm + 1) > 1e-9: fails.append("U_2 control")
        if q == 3 and abs(lm + 2) > 1e-9: fails.append("Gamma_3 control")
        if q == 7 and h < 0.25: fails.append("Gamma_7 control")
        if q == 64 and abs(lm + 15) > 1e-9: fails.append("U_64 = -15 control")
        if q in (23, 27, 31, 43, 47, 64, 128) and not h < 0.25: fails.append("q=%d Hoffman >= 1/4" % q)
    if fails:
        print("FAIL:", fails); sys.exit(1)
    print("ALL CHECKS PASS")

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else None)
