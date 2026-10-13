#!/usr/bin/env python3
"""FS131-EN1 § Stage 7: the eigenvalues of U_Q = Cay(F_{Q^2}, mu_{Q+1}), Q = 2^f, exactly, against an elementary bound.

The non-trivial eigenvalues are S(a) = sum over x in mu_{Q+1} of (-1)^Tr(a x), a != 0; S depends only on N(a), and in
characteristic 2 the elements of F_Q^* represent every norm class (a -> a^2 is a bijection of F_Q^*).
For each f the script prints:  Q  lambda_min  max|S|  sum_n S_n^4  bound = 2Q^3 - 2Q^2 - 3Q - 1  ok4  thin
  ok4  = 1 iff sum_n S_n^4 <= bound (the fourth-moment count: at most two ways to write s != 0 as a sum of two norm-one elements)
  thin = 1 iff 3*max|S| < Q + 1 (Hoffman's ratio below 1/4 at level one)
usage: uq_fourth_moment.py <f> [<f> ...]      --plant: count the norm-one group as mu_{Q-1} (the wrong circle)."""
import sys
plant = "--plant" in sys.argv
fs = [int(a) for a in sys.argv[1:] if a != "--plant"]

def irreducible(deg):
    def pmod(a, b):
        db = b.bit_length() - 1
        while a.bit_length() - 1 >= db:
            a ^= b << (a.bit_length() - 1 - db)
        return a
    for p in range((1 << deg) | 1, 1 << (deg + 1), 2):
        if all(pmod(p, d) for d in range(2, 1 << (deg // 2 + 1))):
            return p

for f in fs:
    n, Q = 2 * f, 1 << f
    P = irreducible(n)
    def mul(a, b):
        r = 0
        while b:
            if b & 1: r ^= a
            b >>= 1; a <<= 1
            if a >> n: a ^= P
        return r
    def power(a, e):
        r = 1
        while e:
            if e & 1: r = mul(r, a)
            a = mul(a, a); e >>= 1
        return r
    def tr(y):
        s = 0
        for _ in range(n):
            s ^= y; y = mul(y, y)
        return s  # 0 or 1
    mask = sum(tr(1 << i) << i for i in range(n))
    order = Q - 1 if plant else Q + 1
    cof = (Q * Q - 1) // order
    mu = None
    for y in range(2, Q * Q):
        z = power(y, cof); s = {1}; w = z
        while w != 1:
            s.add(w); w = mul(w, z)
        if len(s) == order:
            mu = sorted(s); break
    FQ = [a for a in range(1, Q * Q) if power(a, Q) == a]
    assert len(FQ) == Q - 1
    S = [sum(1 - 2 * (bin(mul(a, x) & mask).count("1") & 1) for x in mu) for a in FQ]
    lam, mx, m4 = min(S), max(abs(v) for v in S), sum(v ** 4 for v in S)
    bound = 2 * Q ** 3 - 2 * Q ** 2 - 3 * Q - 1
    print(Q, lam, mx, m4, bound, int(m4 <= bound), int(3 * mx < Q + 1))
