#!/usr/bin/env python3
"""J02 (crunch 2026-09-25): exact checks of the finite-field facts behind J02-L4.

J02-L4(a): for q = 3^f, an additive map lam: F_{q^2} -> (1/3)Z/Z with lam(t) != 0 for every t in mu_{q+1}
           (the norm-one group) exists iff q = 3.  Checked exactly at q = 3 (exists: the positive control),
           q = 27 and q = 243 (none), by enumerating EVERY nonzero F_3-linear functional
           x -> Tr_{F_{q^2}/F_3}(a x), a != 0 (the trace form is nondegenerate, so these are all of them).
           Also checked: the zero count Z(a) = #{t in mu : Tr(at) = 0} equals (q + 1 + 2 S(a))/3 with
           S(a) = sum_t omega^{Tr(at)} real and |S(a)| <= 2 sqrt(q) (the Weil bound the hand proof uses for q >= 27).
J02-L4(b): for Q = 2^f (f = 1..5), no additive lam: F_{Q^2} -> (1/2)Z/Z is 1/2 on all of mu_{Q+1};
           and sum_{t in mu_{Q+1}} t = 0 (the one-line reason).

This is a complete enumeration of a finite set whose extent the derivation fixed first (every functional, every
norm-one element), logged as at the ban's edge in plans/FS91-S0F-three-colours.md.

Plants (--plant NAME): each must make the run fail, for its own stated reason.
  notsubgroup : take the first q+1 powers of the generator instead of the norm-one subgroup -> the subgroup check fires.
  badtrace    : drop the last Frobenius term from the trace -> the "trace lands in F_p" check fires.
Exit 0 iff every assertion holds (faithful run); a planted run must exit nonzero.
"""
import argparse
import cmath
import math
import sys

import numpy as np


class Field:
    """F_{p^m} with a primitive generator g = x; elements coded as ints (base-p coefficient digits)."""

    def __init__(self, p, m):
        self.p, self.m, self.N = p, m, p ** m
        self.poly = self._find_primitive_poly()
        # exp[k] = code of g^k, log[code] = k (log[0] unused)
        self.exp = np.array(self._powers, dtype=np.int64)
        self.log = np.full(self.N, -1, dtype=np.int64)
        self.log[self.exp] = np.arange(self.N - 1)
        assert (self.log[1:] >= 0).all(), "generator not primitive"
        # digit vectors of every code
        codes = np.arange(self.N)
        self.digits = np.stack([(codes // p ** j) % p for j in range(m)], axis=1)

    def _mulx(self, code, poly):
        p, m = self.p, self.m
        d = [(code // p ** j) % p for j in range(m)]
        top = d[-1]
        d = [0] + d[:-1]
        # x^m = -(poly[0] + poly[1] x + ... + poly[m-1] x^{m-1})
        d = [(d[j] - top * poly[j]) % p for j in range(m)]
        return sum(d[j] * p ** j for j in range(m))

    def _find_primitive_poly(self):
        p, m = self.p, self.m
        for idx in range(p ** m):
            poly = [(idx // p ** j) % p for j in range(m)]  # monic x^m + sum poly[j] x^j
            if poly[0] == 0:
                continue
            powers, cur = [], 1
            ok = True
            for k in range(self.N - 1):
                powers.append(cur)
                cur = self._mulx(cur, poly)
                if cur == 1 and k < self.N - 2:
                    ok = False
                    break
            if ok and cur == 1 and len(set(powers)) == self.N - 1:
                self._powers = powers
                return poly
        raise RuntimeError("no primitive polynomial found")

    def add(self, a, b):
        da, db = self.digits[a], self.digits[b]
        s = (da + db) % self.p
        return (s * (self.p ** np.arange(self.m))).sum(axis=-1)

    def mul(self, a, b):
        a = np.asarray(a)
        b = np.asarray(b)
        out = self.exp[(self.log[a] + self.log[b]) % (self.N - 1)]
        return np.where((a == 0) | (b == 0), 0, out)

    def frob_pow(self, y, j):
        """y^{p^j} for an array of codes y."""
        y = np.asarray(y)
        out = self.exp[(self.log[y] * pow(self.p, j, self.N - 1)) % (self.N - 1)]
        return np.where(y == 0, 0, out)


def trace_table(F, plant=None):
    """Tr_{F_{p^m}/F_p}(y) for every code y, as an int in 0..p-1 (asserting it lands in F_p)."""
    ys = np.arange(F.N)
    terms = F.m - 1 if plant == "badtrace" else F.m
    acc = np.zeros((F.N, F.m), dtype=np.int64)
    for j in range(terms):
        acc = (acc + F.digits[F.frob_pow(ys, j)]) % F.p
    in_prime_field = (acc[:, 1:] == 0).all()
    return acc[:, 0], in_prime_field


def norm_one_group(F, q, plant=None):
    """mu_{q+1} inside F_{q^2} = F (F.N = q^2), as codes."""
    if plant == "notsubgroup":
        return F.exp[: q + 1].copy()
    return F.exp[np.arange(q + 1) * (q - 1)]


def is_subgroup(F, mu):
    s = set(int(x) for x in mu)
    prod = F.mul(mu[:, None], mu[None, :])
    return all(int(x) in s for x in prod.ravel())


def check_three(f, plant, report):
    q = 3 ** f
    F = Field(3, 2 * f)
    assert F.N == q * q
    tr, ok = trace_table(F, plant)
    report(f"q={q}: trace lands in F_3: {ok}")
    if not ok:
        return False
    mu = norm_one_group(F, q, plant)
    sub = is_subgroup(F, mu) and len(set(mu.tolist())) == q + 1
    minus1 = int(F.exp[(F.N - 1) // 2])
    report(f"q={q}: mu_(q+1) is a subgroup of order q+1: {sub}; -1 in mu: {minus1 in set(mu.tolist())}")
    if not sub or minus1 not in set(mu.tolist()):
        return False
    a = np.arange(1, F.N)
    prods = F.mul(a[:, None], mu[None, :])  # (N-1, q+1)
    vals = tr[prods]
    Z = (vals == 0).sum(axis=1)
    omega = cmath.exp(2j * math.pi / 3)
    w = np.array([1, omega, omega ** 2])
    S = w[vals].sum(axis=1)
    real = np.abs(S.imag).max() < 1e-9
    Sr = np.rint(S.real).astype(np.int64)
    exact_int = np.abs(S.real - Sr).max() < 1e-9
    count_identity = bool((3 * Z == q + 1 + 2 * Sr).all())
    weil = bool((np.abs(Sr) <= 2 * math.sqrt(q) + 1e-12).all())
    minZ, witness = int(Z.min()), int(a[Z.argmin()])
    report(f"q={q}: functionals checked={len(a)}; min zero count on mu = {minZ}; S real={real}, integral={exact_int}; "
           f"Z=(q+1+2S)/3 for all a: {count_identity}; |S|<=2sqrt(q) for all a: {weil}; S range [{Sr.min()}, {Sr.max()}]")
    good = real and exact_int and count_identity and weil
    if q == 3:
        # positive control: a functional nonzero on all of mu_4 must exist
        good = good and minZ == 0
        report(f"q=3 control: an additive 3-colouring of Gamma_3 exists (min Z = 0): {minZ == 0}; witness a-code={witness}")
    else:
        good = good and minZ >= 1
        report(f"q={q}: NO additive 3-colouring of Gamma_q (every functional vanishes somewhere on mu): {minZ >= 1}")
    return good


def check_two(f, plant, report):
    Q = 2 ** f
    F = Field(2, 2 * f)
    tr, ok = trace_table(F, plant)
    if not ok:
        report(f"Q={Q}: trace lands in F_2: False")
        return False
    mu = norm_one_group(F, Q, plant)
    sub = is_subgroup(F, mu) and len(set(mu.tolist())) == Q + 1
    if not sub:
        report(f"Q={Q}: mu_(Q+1) is a subgroup of order Q+1: False")
        return False
    total = 0
    for t in mu.tolist():
        total = int(F.add(np.array(total), np.array(t)))
    a = np.arange(1, F.N)
    vals = tr[F.mul(a[:, None], mu[None, :])]
    all_one = (vals == 1).all(axis=1)
    report(f"Q={Q}: sum of mu_(Q+1) = 0: {total == 0}; functionals equal to 1 on all of mu: {int(all_one.sum())}")
    return total == 0 and not all_one.any()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=["notsubgroup", "badtrace"], default=None)
    args = ap.parse_args()
    lines = []
    report = lambda s: (lines.append(s), print(s))
    ok = True
    for f in (1, 3, 5):
        ok = check_three(f, args.plant, report) and ok
    for f in range(1, 6):
        ok = check_two(f, args.plant, report) and ok
    print("RESULT:", "PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
