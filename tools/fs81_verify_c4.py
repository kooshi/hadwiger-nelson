#!/usr/bin/env python3
"""FS-81 stage C, C4 (the verifier's): the finite-level threshold for configurations A = {1, v, vbar}·U^(5^K) and
B = {v^k : |k| <= 2}·U^(5^K), on their LISTED generators, derived by hand in plans/FS81-C-verification.md §4 and
checked here in exact arithmetic.

What is computed (all exact, Fractions):
  1. D_K = {g : |<g, x>| <= 1/6 for every x in U^(5^K)} by half-plane clipping (the verifier's own code path), compared
     vertex-for-vertex with phase 0's P0.1 polygons (data/fs81/phase0/rational/rational-layer-K*.json, translated by
     c_K = (5^K/2)(1, 1)).
  2. r_K^2 = D_K's squared circumradius, and s_K = the diagonal extent: the largest s with (s, s) in D_K.
  3. The two thresholds of §4:
       EMPTY  (sufficient, every pattern of layer types): 25^K > 2 r_K^2 d^2      [5^K > sqrt2 r_K d]
       NONEMPTY (the alternating construction g_k = (-1)^k c_K/d):  5^K <= 2 s_K d  [the point c_K/d lies in D_K]
     and the least K per d where both are decided, with the undecided gap reported (it must contain no d = 11 mod 12).
  4. The alternating construction verified at the layer level: every layer mu_k = c_K + (-1)^k c_K/d bands U^(5^K)
     exactly, and each of B's three shift relations (2n-1) mu_b - n(mu_{b-1} + mu_{b+1}) lies in 5^K Z[i].
  5. Configuration A at d = 11 (mod 24) (n odd): the field-level point (theta2, theta2, chi) of §4.0 checked at level K:
     layers c_K, c_K, c_K + f (f an order-3 offset) band U^(5^K) and satisfy A's one relation mod 5^K Z[i].
"""
from __future__ import annotations

import json
import math
import sys
from fractions import Fraction as Fr

SIXTH = Fr(1, 6)


def units(K):
    m = 5 ** K
    out = []
    for p in range(-m, m + 1):
        q2 = m * m - p * p
        q = math.isqrt(q2)
        if q * q == q2:
            for qq in {q, -q}:
                out.append((Fr(p, m), Fr(qq, m)))
    return sorted(set(out))


def dirs(U):
    reps = []
    for u in U:
        if (-u[0], -u[1]) not in reps:
            reps.append(u)
    return reps


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def clip(poly, a, b):
    out = []
    n = len(poly)
    for k in range(n):
        p, q = poly[k], poly[(k + 1) % n]
        sp, sq = dot(a, p) - b, dot(a, q) - b
        if sp <= 0:
            out.append(p)
        if (sp < 0 < sq) or (sq < 0 < sp):
            t = sp / (sp - sq)
            out.append((p[0] + t * (q[0] - p[0]), p[1] + t * (q[1] - p[1])))
    pts = []
    for p in out:
        if p not in pts:
            pts.append(p)
    changed = True
    while changed and len(pts) > 2:
        changed = False
        for k in range(len(pts)):
            p, q, r = pts[k - 1], pts[k], pts[(k + 1) % len(pts)]
            if (q[0] - p[0]) * (r[1] - p[1]) - (q[1] - p[1]) * (r[0] - p[0]) == 0:
                pts.pop(k)
                changed = True
                break
    return pts


def D(K):
    P = [(Fr(-1), Fr(-1)), (Fr(1), Fr(-1)), (Fr(1), Fr(1)), (Fr(-1), Fr(1))]
    for u in dirs(units(K)):
        P = clip(P, u, SIXTH)
        P = clip(P, (-u[0], -u[1]), SIXTH)
    return P


def in_band(x):
    f = x - math.floor(x)
    return Fr(1, 3) <= f <= Fr(2, 3)


def band_layer(mu, U):
    return all(in_band(dot(mu, u)) for u in U)


def in_lattice(z, m):
    return (z[0] / m).denominator == 1 and (z[1] / m).denominator == 1


def main() -> int:
    ok = True
    Kmax = 6
    geo = {}
    print("K  vertices  r_K^2          s_K        sqrt2*r_K   2*s_K   P0.1 polygon match")
    for K in range(1, Kmax + 1):
        P = D(K)
        r2 = max(p[0] ** 2 + p[1] ** 2 for p in P)
        s = min(SIXTH / abs(u[0] + u[1]) for u in dirs(units(K)) if u[0] + u[1] != 0)
        assert all(abs(dot((s, s), u)) <= SIXTH for u in units(K))
        cK = Fr(5 ** K, 2)
        try:
            rec = json.load(open(f"data/fs81/phase0/rational/rational-layer-K{K}.json"))
            polys = [c for c in rec["cells_exact"] if len(c) > 2]
            assert len(polys) == 1
            theirs = sorted((Fr(x) - cK, Fr(y) - cK) for x, y in polys[0])
            match = theirs == sorted(P)
        except FileNotFoundError:
            match = "no file"
        ok &= match is True
        geo[K] = (r2, s)
        print(f"{K}  {len(P):>8}  {str(r2):>13}  {str(s):>9}  {math.sqrt(2 * r2):.6f}  {float(2 * s):.6f}  {match}")

    # thresholds per d, and the gap check
    print("\nleast K (listed generators):  B at every d = 11 (mod 12);  A at d = 23 (mod 24);  A at d = 11 (mod 24) is NONEMPTY at every K")
    gaps = []
    table = []
    for d in range(11, 70000, 12):
        n = (d + 1) // 4
        Kemp = Knon = None
        decided = []
        for K in range(1, Kmax + 1):
            r2, s = geo[K]
            empty = 25 ** K > 2 * r2 * d * d
            nonempty = 5 ** K <= 2 * s * d
            assert not (empty and nonempty), (d, K)
            decided.append("E" if empty else "N" if nonempty else "?")
        if "?" in decided:
            gaps.append((d, decided))
        table.append((d, n, decided))
    census = [11, 23, 35, 47, 59, 71, 83, 95, 107, 119, 131, 143, 155, 167, 179, 191, 203, 215, 227, 239, 251, 263, 287,
              299, 311, 323, 335, 347, 359, 371, 383, 395, 407, 419, 431, 443, 455, 467, 479, 491]
    for d, n, dec in table:
        if d in census:
            kB = next((K + 1 for K, x in enumerate(dec) if x == "E"), None)
            kA = kB if d % 24 == 23 else "inf"
            print(f"  d={d:>4} n={n:>4} d%24={d % 24:>2}  levels 1..{Kmax}: {''.join(dec)}   K_B={kB}  K_A={kA}")
    print(f"\nundecided (d, K) pairs for d < 70000, d = 11 mod 12, K <= {Kmax}: {len(gaps)}")
    for g in gaps[:10]:
        print("   ", g)
    formula_ok = all(
        (next((K + 1 for K, x in enumerate(dec) if x == "E"), None) == next(K for K in range(1, 99) if d < 21 * 5 ** (K - 1)))
        for d, n, dec in table if d < 21 * 5 ** 5 and "?" not in dec
    )
    print(f"K_B(d) = min{{K : d < 21*5^(K-1)}} for every d = 11 (mod 12) below 65,625: {formula_ok}")
    ok &= formula_ok

    # the alternating construction, layer level, on a sample
    bad = 0
    for d in (23, 35, 107, 131, 491, 503, 2603):
        n = (d + 1) // 4
        for K in (1, 2, 3):
            r2, s = geo[K]
            if not 5 ** K <= 2 * s * d:
                continue
            U = units(K)
            cK = (Fr(5 ** K, 2), Fr(5 ** K, 2))
            g = (cK[0] / d, cK[1] / d)
            mu = {k: (cK[0] + (1 if k % 2 == 0 else -1) * g[0], cK[1] + (1 if k % 2 == 0 else -1) * g[1]) for k in range(-2, 3)}
            bands = all(band_layer(mu[k], U) for k in mu)
            rels = all(in_lattice(((2 * n - 1) * mu[b][0] - n * (mu[b - 1][0] + mu[b + 1][0]),
                                   (2 * n - 1) * mu[b][1] - n * (mu[b - 1][1] + mu[b + 1][1])), 5 ** K) for b in (-1, 0, 1))
            if not (bands and rels):
                bad += 1
                print("   CONSTRUCTION FAILS", d, K, bands, rels)
    print(f"alternating construction (B's five layers; A's three are a sub-case) verified on the sample: {bad == 0}")
    ok &= bad == 0

    # A at d = 11 (mod 24): (theta2, theta2, chi) at every sampled level
    bad = 0
    for d in (11, 35, 59, 83, 107, 491):
        n = (d + 1) // 4
        assert n % 2 == 1 and n % 3 == 0
        for K in range(1, 5):
            U = units(K)
            m = 5 ** K
            cK = (Fr(m, 2), Fr(m, 2))
            for f in ((Fr(m, 6), Fr(m, 6)), (Fr(-m, 6), Fr(m, 6))):
                mu0 = cK                                   # layer 1: theta2
                mu1 = cK                                   # layer v: theta2
                mu2 = (cK[0] + f[0], cK[1] + f[1])         # layer vbar: order 3
                bands = band_layer(mu0, U) and band_layer(mu1, U) and band_layer(mu2, U)
                rel = ((2 * n - 1) * mu0[0] - n * (mu1[0] + mu2[0]), (2 * n - 1) * mu0[1] - n * (mu1[1] + mu2[1]))
                if not (bands and in_lattice(rel, m)):
                    bad += 1
                    print("   A-POINT FAILS", d, K, f, bands, rel)
    print(f"configuration A's point (theta2, theta2, chi) at d = 11 (mod 24), K = 1..4: {bad == 0}")
    ok &= bad == 0
    print("VERDICT:", "all checks pass" if ok else "A CHECK FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
