#!/usr/bin/env python3
"""Verifier X, FS-86: exact check of Lemma C'-(at P): the Z_2-span J of {w - 1 : w in T_4(O_P)} is a
full-rank lattice in O_P = Z_2[zeta_12], and holds P^m for an explicit m.

Derived claim checked (not a search): T_4 = {w(t) = (1+it)/(1-it) : t in 2 Z_2[sqrt3]}, and the span of a
finite sample of w(t) - 1 already contains 2^e O for a small e, so P^(2e) is in J (P^2 = 2).
Sampling gives a SUB-lattice of J, so the m reported is an UPPER bound on the true m (enough: m is finite).

Arithmetic: exact rationals in Q(zeta), zeta^4 = zeta^2 - 1; conjugation zeta -> zeta^-1 = zeta - zeta^3;
i = zeta^3; sqrt3 = 2 zeta - zeta^3. Each w is asserted to have norm one and w - 1 to be 2-integral with
v_P(w - 1) >= 4. Then Hermite/Smith over Z of the 2-adic reductions mod 2^K.

Plants (--plant NAME) must make the check FAIL loudly:
  noconj   : use zeta -> zeta^5 (not the conjugation of F(i)/F) -> norm-one assertion fires
  zerot    : sample only t = 0 -> span is 0 -> "NOT full rank"
  shallow  : sample t in Z_2[sqrt3] with v(t) = 1 -> depth assertion (w = 1 mod P^4) fires
"""
import sys
from fractions import Fraction as Fr
import itertools

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
K = 40  # work mod 2^K


def mul(x, y):
    # x, y: lists of 4 Fractions in basis 1, z, z^2, z^3 ; reduce z^4 = z^2 - 1
    p = [Fr(0)] * 7
    for a in range(4):
        for b in range(4):
            p[a + b] += x[a] * y[b]
    for d in (6, 5, 4):  # z^d = z^(d-2) - z^(d-4)
        c = p[d]
        p[d] = Fr(0)
        p[d - 2] += c
        p[d - 4] -= c
    return p[:4]


def add(x, y):
    return [a + b for a, b in zip(x, y)]


def sub(x, y):
    return [a - b for a, b in zip(x, y)]


def scal(c, x):
    return [c * a for a in x]


ONE = [Fr(1), Fr(0), Fr(0), Fr(0)]
Z = [Fr(0), Fr(1), Fr(0), Fr(0)]
I = mul(mul(Z, Z), Z)                       # zeta^3
SQ3 = sub(scal(Fr(2), Z), I)                # 2 zeta - zeta^3
assert mul(I, I) == scal(Fr(-1), ONE), "i^2 != -1"
assert mul(SQ3, SQ3) == scal(Fr(3), ONE), "sqrt3^2 != 3"


def power(x, n):
    r = ONE
    for _ in range(n):
        r = mul(r, x)
    return r


def conj(x):
    # ring hom zeta -> zeta^-1 (the nontrivial automorphism of Q(zeta12)/Q(sqrt3)), or a plant
    img = power(Z, 11) if PLANT != "noconj" else power(Z, 5)
    r = [Fr(0)] * 4
    pw = ONE
    for a in range(4):
        r = add(r, scal(x[a], pw))
        pw = mul(pw, img)
    return r


def inv(x):
    # solve M_x y = e1 by Gaussian elimination over Q
    M = []
    for a in range(4):
        e = [Fr(0)] * 4
        e[a] = Fr(1)
        M.append(mul(x, e))  # column a = x * z^a
    A = [[M[c][r] for c in range(4)] + [ONE[r]] for r in range(4)]
    for col in range(4):
        piv = next(r for r in range(col, 4) if A[r][col] != 0)
        A[col], A[piv] = A[piv], A[col]
        pv = A[col][col]
        A[col] = [v / pv for v in A[col]]
        for r in range(4):
            if r != col and A[r][col] != 0:
                f = A[r][col]
                A[r] = [a - f * b for a, b in zip(A[r], A[col])]
    return [A[r][4] for r in range(4)]


def v2(q):
    q = Fr(q)
    if q == 0:
        return 10**9
    n, d = q.numerator, q.denominator
    v = 0
    while n % 2 == 0:
        n //= 2; v += 1
    while d % 2 == 0:
        d //= 2; v -= 1
    return v


def vP(x):
    # P = (zeta^? ) ... use: v_P(x) = v_2(N_{L/Q}(x)) / f where f = 2 and e = 2 overall: v_2(N x) = f * v_P(x) ... with
    # e(L/Q_2)=2, f=2: v_2(N(x)) = f * v_P(x) = 2 v_P(x)
    n = x
    for k in (5, 7, 11):
        # multiply by conjugates zeta -> zeta^k
        img = power(Z, k)
        r = [Fr(0)] * 4
        pw = ONE
        for a in range(4):
            r = add(r, scal(x[a], pw))
            pw = mul(pw, img)
        n = mul(n, r)
    assert all(c == 0 for c in n[1:]), "norm not rational"
    vv = v2(n[0])
    assert vv % 2 == 0
    return vv // 2


def w_of(t):
    it = mul(I, t)
    return mul(add(ONE, it), inv(sub(ONE, it)))


samples = []
rng = range(-3, 4)
for a, b in itertools.product(rng, rng):
    if PLANT == "zerot":
        a, b = 0, 0
    base = add(scal(Fr(a), ONE), scal(Fr(b), SQ3))
    t = scal(Fr(2), base) if PLANT != "shallow" else base  # shallow: t in Z2[sqrt3], v(t) may be 0 or 1
    if PLANT == "shallow" and (a, b) == (0, 0):
        continue
    w = w_of(t)
    nw = mul(w, conj(w))
    assert nw == ONE, f"norm-one assertion failed at t=({a},{b}): {nw}"
    d = sub(w, ONE)
    assert all(v2(c) >= 0 for c in d), "w - 1 not 2-integral"
    dep = vP(d)
    assert dep >= 4, f"depth assertion failed: v_P(w-1) = {dep} < 4 at t=({a},{b})"
    samples.append(d)


def red(q):
    n, den = q.numerator, q.denominator
    return (n * pow(den, -1, 2**K)) % 2**K


rows = [[red(c) for c in d] for d in samples] + [[2**K if r == c else 0 for c in range(4)] for r in range(4)]


def hnf_diag(rows):
    # Hermite normal form over Z (upper triangular), return diagonal
    rows = [r[:] for r in rows]
    n = 4
    out = []
    for col in range(n):
        # gcd-reduce column col among rows
        while True:
            nz = [r for r in rows if r[col] != 0]
            if len(nz) <= 1:
                break
            nz.sort(key=lambda r: abs(r[col]))
            p = nz[0]
            new = [p]
            for r in nz[1:]:
                q = r[col] // p[col]
                new.append([x - q * y for x, y in zip(r, p)])
            rows = [r for r in rows if r[col] == 0] + new
        piv = [r for r in rows if r[col] != 0]
        if not piv:
            out.append(0)
            continue
        out.append(abs(piv[0][col]))
        rows = [r for r in rows if r[col] == 0]
    return out


diag = hnf_diag(rows)
vals = [v2(x) if x else None for x in diag]
print("samples:", len(samples), " HNF diagonal 2-valuations (basis 1,z,z^2,z^3):", vals)
if any(v is None or v >= K for v in vals):
    print("FAIL: NOT full rank (some diagonal entry is 0 or 2^K)")
    sys.exit(1)
# elementary divisors: Smith form exponent = max over... compute smallest e with 2^e O in J: check each 2^e z^a in J
# Using HNF triangularity, 2^e O in J iff 2^e * e_a in lattice for all a; test by membership via HNF reduction.


def in_lattice(vec, rows):
    # reduce vec by the lattice generated by rows (mod 2^K included)
    basis = []
    rs = [r[:] for r in rows]
    for col in range(4):
        while True:
            nz = [r for r in rs if r[col] != 0]
            if len(nz) <= 1:
                break
            nz.sort(key=lambda r: abs(r[col]))
            p = nz[0]
            new = [p]
            for r in nz[1:]:
                q = r[col] // p[col]
                new.append([x - q * y for x, y in zip(r, p)])
            rs = [r for r in rs if r[col] == 0] + new
        piv = [r for r in rs if r[col] != 0]
        if piv:
            basis.append(piv[0])
        rs = [r for r in rs if r[col] == 0]
    v = vec[:]
    for b in basis:
        col = next(c for c in range(4) if b[c] != 0)
        if v[col] % b[col] != 0:
            return False
        q = v[col] // b[col]
        v = [x - q * y for x, y in zip(v, b)]
    return all(x == 0 for x in v)


e = 0
while not all(in_lattice([2**e if r == a else 0 for r in range(4)], rows) for a in range(4)):
    e += 1
# P^(2e) = 2^e O is in J; test P^(2e-1) = 2^(e-1) * P, P = (zeta^? - 1)?  P is generated by sqrt3 - 1.
P = sub(SQ3, ONE)
assert vP(P) == 1
mP = 2 * e
if e >= 1:
    gen = scal(Fr(2**(e - 1)), P)
    ok = all(in_lattice([red(c) for c in mul(gen, power(Z, a))], rows) for a in range(4))
    if ok:
        mP = 2 * e - 1
print(f"2^{e} O  is contained in J  =>  P^{2*e} in J;  smallest m found (upper bound on true m): m <= {mP}")
print("PASS: J is full rank; Lemma C' holds at P with m <=", max(4, mP))
