#!/usr/bin/env python3
"""J21 (crunch 2026-09-25): the places of Q(sqrt 167) below a bound, and each place's level-one spectrum.

What it checks (a derived claim, never a search):
  * the classification of the finite places of F = Q(sqrt 167) with residue size q <= QMAX:
    stable (F_v(i)/F_v a field: odd q = 3 mod 4, and the ramified 167) or split (i in F_v);
    the dyadic place: 2 ramifies in F and F_2 = Q_2(sqrt 167) = Q_2(i) (since -167 = 1 mod 8), so it is split;
  * at a stable place with residue field F_p (p = 3 mod 4): the plane Gamma_p = Cay(F_p^2, {x^2 + y^2 = 1}),
    degree p + 1; its eigenvalues lambda(xi) = sum over the circle of cos(2 pi (xi . t)/p);
    Hoffman ratio h = -lmin/(d - lmin) and mixing constant lam* = max_{xi != 0} |lambda|/d;
  * at a split place with residue field F_q: the compact sub-Cayley graph Cay(O^2, {(e, 1/e) : e in O^x}) of the
    hyperbola graph; its level-one eigenvalues are Kloosterman sums K(c)/(q - 1) (c = ab, a, b units), plus
    -1/(q - 1) (one coordinate of valuation -1) and 0; levels m >= 2 are bounded by 2/(q - 1) in odd characteristic
    (quoted in the record, not computed here);
  * thick at five colours means lam* < 1/4 (pigeonhole 1/5 > lam*/(1 + lam*)).
Floats: every eigenvalue is a sum of at most 2*QMAX cosines, each with error < 1e-15, so the error is < 1e-11;
the tool prints every margin, and refuses (exit 2) if any decision sits within 1e-9 of its threshold.

Plant (--plant): the circle is replaced by the 'circle' x^2 - y^2 = 1 at stable places (the split form); the
check that every stable plane's Hoffman ratio matches the planner's float values must then fail (exit 1).
Exit 0: all checks as stated; 1: a check failed; 2: a margin too small to decide.
"""
import argparse
import math
import sys

import numpy as np

QMAX = 200


def is_prime(n):
    if n < 2:
        return False
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def places(D=167, qmax=QMAX):
    """Finite places of Q(sqrt D) with residue size <= qmax: list of (p, kind_in_F, q, type)."""
    out = []
    for p in range(2, qmax + 1):
        if not is_prime(p):
            continue
        if p == 2:
            # D = 167 = 3 mod 4: 2 ramifies in Q(sqrt D); F_2 = Q_2(sqrt D); i in F_2 iff -D is a 2-adic square iff -D = 1 mod 8
            assert D % 4 == 3
            split = ((-D) % 8 == 1)
            out.append((2, 'ramified', 2, 'split' if split else 'stable'))
            continue
        if D % p == 0:
            q = p
            out.append((p, 'ramified', q, 'stable' if q % 4 == 3 else 'split'))
            continue
        if legendre(D, p) == 1:
            q = p
            out.append((p, 'split', q, 'stable' if q % 4 == 3 else 'split'))
            out.append((p, 'split', q, 'stable' if q % 4 == 3 else 'split'))  # two places
        else:
            q = p * p
            if q <= qmax * qmax:
                out.append((p, 'inert', q, 'split'))  # q = p^2 = 1 mod 4 always
    return out


def circle_points(p, plant=False):
    pts = []
    for x in range(p):
        for y in range(p):
            v = (x * x - y * y) if plant else (x * x + y * y)
            if v % p == 1:
                pts.append((x, y))
    return np.array(pts, dtype=np.int64)


def stable_spectrum(p, plant=False):
    T = circle_points(p, plant)
    d = len(T)
    # eigenvalue depends on xi; compute for all xi != 0 (p^2 - 1 of them) by a vectorised sum
    xs = np.arange(p)
    X1, X2 = np.meshgrid(xs, xs, indexing='ij')
    lam = np.zeros((p, p))
    for (a, b) in T:
        lam += np.cos(2 * np.pi * ((X1 * a + X2 * b) % p) / p)
    lam[0, 0] = np.nan
    lmin = np.nanmin(lam)
    lmax = np.nanmax(lam)
    return d, lmin, lmax


class Fq:
    """F_q for q = p or p^2 (as F_p[w]/(w^2 - r), r a non-residue)."""

    def __init__(self, p, f):
        self.p, self.f = p, f
        if f == 2:
            self.r = next(a for a in range(2, p) if legendre(a, p) == -1)

    def elements(self):
        if self.f == 1:
            return [(a, 0) for a in range(self.p)]
        return [(a, b) for a in range(self.p) for b in range(self.p)]

    def mul(self, x, y):
        p = self.p
        if self.f == 1:
            return ((x[0] * y[0]) % p, 0)
        return ((x[0] * y[0] + self.r * x[1] * y[1]) % p, (x[0] * y[1] + x[1] * y[0]) % p)

    def add(self, x, y):
        return ((x[0] + y[0]) % self.p, (x[1] + y[1]) % self.p)

    def inv(self, x):
        q = self.p ** self.f
        return self.pow(x, q - 2)

    def pow(self, x, e):
        res = (1, 0)
        base = x
        while e:
            if e & 1:
                res = self.mul(res, base)
            base = self.mul(base, base)
            e >>= 1
        return res

    def tr(self, x):
        # trace to F_p
        return x[0] % self.p if self.f == 1 else (2 * x[0]) % self.p


def kloosterman_max(p, f):
    """max over c != 0 of |sum_{e != 0} psi(Tr(e + c/e))| for F_q, q = p^f."""
    F = Fq(p, f)
    els = [e for e in F.elements() if e != (0, 0)]
    invs = {e: F.inv(e) for e in els}
    best = 0.0
    worst_c = None
    for c in els:
        s = 0.0
        for e in els:
            s += math.cos(2 * math.pi * F.tr(F.add(e, F.mul(c, invs[e]))) / p)
        if abs(s) > best:
            best, worst_c = abs(s), c
    return best, worst_c


PLANNER = {23: 0.24908, 43: 0.21376, 59: 0.19912}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--plant', action='store_true')
    ap.add_argument('--qmax', type=int, default=QMAX)
    a = ap.parse_args()
    ok = True
    tight = False
    pl = places(qmax=a.qmax)
    print('places of Q(sqrt 167) with residue size q <= %d (p, in F, q, type in F(i)/F):' % a.qmax)
    for row in pl:
        if row[2] <= a.qmax:
            print('  ', row)
    stable_ps = sorted({row[0] for row in pl if row[3] == 'stable'})
    print('stable residue characteristics:', stable_ps)
    # expected from the derivation: stable odd places below 59 are 23 and 43 only; 167 ramified stable
    exp_below59 = [23, 43]
    got_below59 = [p for p in stable_ps if p < 59]
    if got_below59 != exp_below59:
        print('FAIL: stable places below 59 are', got_below59, 'expected', exp_below59)
        ok = False
    print('\nstable places: level-one spectrum of Gamma_p (d = p + 1)')
    for p in stable_ps:
        if p == 2:
            continue
        if p > 71 and p != 167:
            continue
        d, lmin, lmax = stable_spectrum(p, a.plant)
        h = -lmin / (d - lmin)
        lam_star = max(-lmin, lmax) / d
        weil = 2 * math.sqrt(p) / (p + 1)
        print('  p=%3d d=%3d lmin=%+.6f lmax=%+.6f Hoffman=%.5f (<1/5: %s, margin %.2e)  lam*=%.5f (<1/4: %s, margin %.2e)  Weil lam*<=%.5f'
              % (p, d, lmin, lmax, h, h < 0.2, abs(0.2 - h), lam_star, lam_star < 0.25, abs(0.25 - lam_star), weil))
        if min(abs(0.2 - h), abs(0.25 - lam_star)) < 1e-9:
            tight = True
        if p in PLANNER and abs(h - PLANNER[p]) > 5e-5:
            print('  FAIL: Hoffman ratio at %d is %.5f, planner %.5f' % (p, h, PLANNER[p]))
            ok = False
        if d != p + 1:
            print('  FAIL: circle size %d != p + 1' % d)
            ok = False
    # Weil suffices from 67 on for lam* < 1/4 (8 sqrt p < p + 1)
    first_weil = next(p for p in range(3, 1000) if 8 * math.sqrt(p) < p + 1)
    print('Weil gives lam* < 1/4 for p >= %d (8 sqrt p < p + 1); Hoffman < 1/5 needs |lmin| < (p+1)/4, same threshold' % first_weil)
    print('\nsplit places: compact subgraph Cay(O^2, {(e, 1/e)}), level-one |K|/(q-1)')
    seen = set()
    for (p, kind, q, typ) in pl:
        if typ != 'split' or q in seen or q > 200:
            continue
        seen.add(q)
        if q == 2:
            print('  q=  2: e = 1 mod pi for every unit, so (1/pi)(x1 + x2) is trivial on the subgraph: lam* = 1 (not thick)')
            continue
        f = 1 if q == p else 2
        kmax, c = kloosterman_max(p, f)
        lam_star = max(kmax, 1.0) / (q - 1)
        weil = 2 * math.sqrt(q) / (q - 1)
        print('  q=%4d (p=%d, %s in F): max|K|=%.6f  lam*=%.5f (<1/4: %s, margin %.2e)  Weil<=%.5f'
              % (q, p, kind, kmax, lam_star, lam_star < 0.25, abs(0.25 - lam_star), weil))
        if abs(0.25 - lam_star) < 1e-9:
            tight = True
    if tight:
        print('UNDECIDED: a margin below 1e-9')
        sys.exit(2)
    print('\nRESULT:', 'OK' if ok else 'FAIL')
    sys.exit(0 if ok else 1)


if __name__ == '__main__':
    main()
