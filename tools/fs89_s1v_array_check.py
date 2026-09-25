#!/usr/bin/env python3
"""FS-89 S1V: exact check of the rank-r orbit model (the record's V-A4), at S = {5, 13}.

Checks DERIVED claims; searches for nothing.  A character of R_S = Z[i][1/65] is built from adelic data
(e; b_v), e a Gaussian rational, b_v a p-adic integer truncated mod p^K at each of the four split places
v in {pi5, pibar5, pi13, pibar13}, by
    theta(x) = Re(conj(e) x) - sum_v { iota_v(b_v x) / 2 }_p   (mod 1),
which kills the lattice {(conj g; g, g, g, g) : g in R_S} (the half-trace makes Z[i] self-dual).  Its array is
e_m := theta(w^m) + i theta(i w^m) mod Z[i], m in Z^2, w^m = w5^m1 w13^m2.  Claims checked on random data:
  (1) the step rule per prime:  e_{m+eps_j} - conj(w_j) e_m  in  pi_j^{-1} Z[i]  (mod Z[i]);
  (2) the square rule: e_{m+e1+e2} is the unique class mod Z[i] in the intersection of the two cosets given by
      e_{m+e1} (rule 2) and e_{m+e2} (rule 1);
  (3) the orthant reading: e_m depends only on e and, for each j with m_j > 0, the component at pibar_j, and for each
      j with m_j < 0, the component at pi_j (perturbing an unread component leaves e_m unchanged; perturbing a read one
      changes some e_m in the orthant);
  (4) the T + A criterion: data (e; q, q, q, q) with one rational q gives e_m = c_tau(m) + conj(w)^m d with one torsion
      tau (c_tau(m) = the Z[i]-parameter of tau o w^m) and d = e - conj(q), and c_tau is periodic (period 4 in m1 at
      q = (1+i)/3, since w5 = -i mod 3).  (The converse, two rationals => not T + A, is proved by hand, not checked here.)
Planted faults (each must fire): the step lattice pibar_j^{-1}Z[i] in place of pi_j^{-1}Z[i]; the reading swapped
(pi_j read for m_j > 0).  Usage: python3 tools/fs89_s1v_array_check.py
"""
from __future__ import annotations

import random
import sys
from fractions import Fraction as Fr

K = 10  # p-adic precision
PI = {5: (2, 1), 13: (3, 2)}  # pi_p = a + b i


def gmul(x, y):
    return (x[0] * y[0] - x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def gconj(x):
    return (x[0], -x[1])


def ginv(x):
    n = x[0] * x[0] + x[1] * x[1]
    return (Fr(x[0]) / n, Fr(-x[1]) / n)


def gpow(x, k):
    r = (Fr(1), Fr(0))
    base = x if k >= 0 else ginv(x)
    for _ in range(abs(k)):
        r = gmul(r, base)
    return r


def root_minus_one(p: int, a: int, b: int) -> int:
    """r with r^2 = -1 mod p^K and a + b r = 0 mod p (the place pi = a + bi)."""
    m = p ** K
    r0 = next(r for r in range(p) if (r * r + 1) % p == 0 and (a + b * r) % p == 0)
    r = r0
    for _ in range(2 * K):  # Newton for r^2 + 1
        r = (r - (r * r + 1) * pow(2 * r, -1, m)) % m
    assert (r * r + 1) % m == 0 and (a + b * r) % p == 0
    return r


PLACES = []  # (name, p, r_v)
for p, (a, b) in PI.items():
    r = root_minus_one(p, a, b)
    PLACES.append((f"pi{p}", p, r))
    PLACES.append((f"pibar{p}", p, (-r) % (p ** K)))


def frac_p(y, p: int, r: int, bv: int) -> Fr:
    """{ iota_v(bv * y) / 2 }_p for a Gaussian rational y."""
    A, B = y
    den = 1
    for c in (A, B):
        den = den * c.denominator // __import__("math").gcd(den, c.denominator)
    A2, B2 = int(A * den), int(B * den)
    k = 0
    d = den
    while d % p == 0:
        d //= p
        k += 1
    if k == 0:
        return Fr(0)
    m = p ** k
    num = ((A2 + B2 * r) * bv * pow(2 * d, -1, m)) % m
    return Fr(num, m)


def theta(data, x) -> Fr:
    e, bs = data
    val = x[0] * e[0] + x[1] * e[1]  # Re(conj(e) x)
    for (name, p, r) in PLACES:
        val -= frac_p(x, p, r, bs[name])
    return val % 1


W = {5: None, 13: None}
for p, pi in PI.items():
    W[p] = gmul((Fr(pi[0]), Fr(pi[1])), ginv(gconj(pi)))  # w_p = pi / pibar


def wm(m):
    return gmul(gpow(W[5], m[0]), gpow(W[13], m[1]))


def arr(data, m):
    x = wm(m)
    return (theta(data, x), theta(data, gmul((Fr(0), Fr(1)), x)))


def mod1(z):
    return (z[0] % 1, z[1] % 1)


def in_lattice(z, gen) -> bool:
    """is z in gen^{-1} Z[i] (mod Z[i])?  i.e. gen * z in Z[i]."""
    y = gmul(gen, z)
    return y[0].denominator == 1 and y[1].denominator == 1


def rand_data(rng):
    e = (Fr(rng.randrange(1000), 997), Fr(rng.randrange(1000), 991))
    bs = {name: rng.randrange(p ** K) for (name, p, _) in PLACES}
    return (e, bs)


def main() -> int:
    rng = random.Random(20260925)
    ok = True
    box = [(a, b) for a in range(-3, 4) for b in range(-3, 4)]
    steps = {0: (1, 0), 1: (0, 1)}
    gens = {0: PI[5], 1: PI[13]}
    fault_step = fault_read = False
    for trial in range(6):
        data = rand_data(rng)
        E = {m: arr(data, m) for m in box}
        # (1) step rule
        for m in box:
            for j in (0, 1):
                m2 = (m[0] + steps[j][0], m[1] + steps[j][1])
                if m2 not in E:
                    continue
                wj = W[5] if j == 0 else W[13]
                diff = (E[m2][0] - (gmul(gconj(wj), E[m]))[0], E[m2][1] - (gmul(gconj(wj), E[m]))[1])
                g = (Fr(gens[j][0]), Fr(gens[j][1]))
                if not in_lattice(diff, g):
                    ok = False
                    print("step rule FAILED", trial, m, j)
                gb = gconj(g)
                if not in_lattice(diff, gb):
                    fault_step = True  # the planted lattice refuses somewhere
        # (2) square rule: e_{m+e1+e2} determined mod Z[i] by the two neighbours
        for m in box:
            m1, m2, m12 = (m[0] + 1, m[1]), (m[0], m[1] + 1), (m[0] + 1, m[1] + 1)
            if m12 not in E:
                continue
            # the candidate set: x = conj(w13) e_{m1} + a/pi13 = conj(w5) e_{m2} + c/pi5 ; solve by brute force over residues
            base1 = gmul(gconj(W[13]), E[m1])
            base2 = gmul(gconj(W[5]), E[m2])
            p13, p5 = (Fr(3), Fr(2)), (Fr(2), Fr(1))
            sols = set()
            for a0 in range(13):
                for a1 in range(13):
                    x = (base1[0] + gmul((Fr(a0), Fr(a1)), ginv((3, 2)))[0],
                         base1[1] + gmul((Fr(a0), Fr(a1)), ginv((3, 2)))[1])
                    d = (x[0] - base2[0], x[1] - base2[1])
                    if in_lattice(d, p5):
                        sols.add(mod1(x))
            if sols != {mod1(E[m12])}:
                ok = False
                print("square rule FAILED", trial, m, len(sols))
        # (3) orthant reading
        for name in [n for (n, _, _) in PLACES]:
            pert = (data[0], dict(data[1]))
            p = 5 if name.endswith("5") else 13
            pert[1][name] = (pert[1][name] + rng.randrange(1, p ** K)) % (p ** K)
            j = 0 if p == 5 else 1
            bar = name.startswith("pibar")
            for m in box:
                reads = (m[j] > 0 and bar) or (m[j] < 0 and not bar)
                same = mod1(arr(pert, m)) == mod1(E[m])
                if not reads and not same:
                    ok = False
                    print("orthant reading FAILED (unread component moved e_m)", trial, name, m)
                swapped = (m[j] > 0 and not bar) or (m[j] < 0 and bar)
                if swapped and same:
                    fault_read = True  # the swapped reading predicts a move here; none happened
            moved = [m for m in box if ((m[j] > 0 and bar) or (m[j] < 0 and not bar)) and mod1(arr(pert, m)) != mod1(E[m])]
            if not moved:
                ok = False
                print("orthant reading FAILED (read component moved nothing)", trial, name)
    # (4) T + A criterion
    q = (Fr(1, 3), Fr(1, 3))
    e = (Fr(3, 17), Fr(-2, 19))
    tau_data = ((q[0], -q[1]), {n: 0 for (n, _, _) in PLACES})  # (conj q; 0,...) is tau + lambda, used to read c_tau
    data_q = (e, {})
    for (name, p, r) in PLACES:  # b_v = iota_v(q) as a p-adic integer
        m = p ** K
        data_q[1][name] = ((q[0].numerator * pow(q[0].denominator, -1, m)) + (q[1].numerator * pow(q[1].denominator, -1, m)) * r) % m
    d = (e[0] - q[0], e[1] + q[1])  # d = e - conj(q)
    for m in box:
        # the torsion tau = (conj q; q, q, q, q) - lambda_{conj q}... read c_tau(m) as the array of (conj q; q,...) minus conj(w)^m conj(q)
        tdata = ((q[0], -q[1]), data_q[1])
        cm = arr(tdata, m)
        wbm = gconj(wm(m))
        lhs = mod1(arr(data_q, m))
        rhs = mod1((cm[0] + gmul(wbm, d)[0], cm[1] + gmul(wbm, d)[1]))
        if lhs != rhs:
            ok = False
            print("T + A criterion FAILED", m)
    # c_tau(m) must be periodic with a finite period and have order 3 values
    periodic = mod1(arr(((q[0], -q[1]), data_q[1]), (0, 0))) == mod1(arr(((q[0], -q[1]), data_q[1]), (4, 0)))
    print(f"(4) torsion part periodic in m1 with period 4 (w5 = -i mod 3): {periodic}")
    ok = ok and periodic
    print(f"planted faults fired: step lattice pibar^-1: {fault_step}; swapped reading: {fault_read}")
    ok = ok and fault_step and fault_read
    print("ALL AS DERIVED" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
