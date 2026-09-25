#!/usr/bin/env python3
"""FS-89 S1V: exact check of the derived classification of band torsion characters of Q = Z[i][1/p : p = 1 mod 4].

Checks a DERIVED claim (the record's V-A2, Theorems V2-V4); it searches for nothing.  For each order N in a fixed
list chosen by the derivation (the divisors of 336 = 16*3*7, plus 9, 11, 19, 23, 32, 49), it computes
  G_N = the image of the rational unit circle in (Z[i]/N)^x  (= prod over q | N of the image of T(Z_q)),
and lists every character tau(x + yi) = (alpha*x + beta*y)/N of exact order N with tau(G_N) inside [1/4, 3/4], with
its margin min over G_N of the distance from tau(c) to {1/4, 3/4}.

The derivation predicts: orders 2 (1 character, margin 1/4), 3 (4, 1/12), 4 (8, 0), 7 (8, 1/28), 8 (8, 0), and no
other order in the list.  G_N at 2^k is computed from T(Z_2) = {(+-sqrt(1 - b^2), b), (b, +-sqrt(1 - b^2)) : b in 4Z_2}
(1 - b^2 is a 2-adic square iff 4 | b); at odd q from Hensel (the conic is smooth there).

Controls (planted, each must go red): (1) replace G_N at 2^k by all norm-one residues mod 2^k (not only liftable ones);
(2) shrink the band's closed ends inward by 1/(8N) (margin-0 characters must disappear); (3) G_N at odd q replaced
by the unit circle mod q only (drops the level-collapse cosets): an order-9 band character must appear if the
level-collapse lemma is what excludes 9.  Usage: python3 tools/fs89_s1v_n0_check.py [--controls]
"""
from __future__ import annotations

import sys
from fractions import Fraction
from math import gcd

import numpy as np


def factor(n: int) -> dict[int, int]:
    out: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            out[p] = out.get(p, 0) + 1
            n //= p
        p += 1
    if n > 1:
        out[n] = out.get(n, 0) + 1
    return out


def g_two(k: int, liftable_only: bool = True) -> set[tuple[int, int]]:
    """Image of T(Z_2) in Z[i]/2^k (liftable_only) or all norm-one residues mod 2^k (the planted fault)."""
    m = 2 ** k
    if not liftable_only:
        return {(a, b) for a in range(m) for b in range(m) if (a * a + b * b - 1) % m == 0}
    prec = 2 ** (k + 3)
    out: set[tuple[int, int]] = set()
    for b in range(0, prec, 4):
        x = (1 - b * b) % prec
        roots = [s for s in range(1, prec, 4) if (s * s - x) % prec == 0]
        assert roots, (k, b)
        sm = {s % m for s in roots}
        assert len(sm) == 1, (k, b, sm)
        s = sm.pop()
        for a in (s, (-s) % m):
            out.add((a, b % m))
            out.add((b % m, a))
    return out


def g_odd(q: int, e: int, level_one_only: bool = False) -> set[tuple[int, int]]:
    m = q ** e
    if level_one_only and e > 1:
        # planted fault: only the lifts (a, b) with a, b in {0..q-1} of the level-one circle, i.e. drop the cosets
        base = {(a, b) for a in range(q) for b in range(q) if (a * a + b * b - 1) % q == 0}
        return {(a, b) for (a, b) in base}
    return {(a, b) for a in range(m) for b in range(m) if (a * a + b * b - 1) % m == 0}


def crt_pair(parts: list[tuple[int, set[tuple[int, int]]]]) -> list[tuple[int, int]]:
    """Combine local residue sets by CRT into residues mod the product."""
    cur_m, cur = 1, [(0, 0)]
    for m, s in parts:
        new = []
        # x = cur_x + cur_m * t, t chosen with x = s_x mod m
        inv = pow(cur_m, -1, m) if m > 1 else 0
        for (a0, b0) in cur:
            for (a1, b1) in s:
                ta = ((a1 - a0) * inv) % m
                tb = ((b1 - b0) * inv) % m
                new.append((a0 + cur_m * ta, b0 + cur_m * tb))
        cur_m *= m
        cur = new
    return cur


def g_n(n: int, fault: str = "") -> np.ndarray:
    parts = []
    for q, e in sorted(factor(n).items()):
        if q == 2:
            parts.append((2 ** e, g_two(e, liftable_only=(fault != "two"))))
        else:
            assert q % 4 == 3, n
            parts.append((q ** e, g_odd(q, e, level_one_only=(fault == "odd"))))
    return np.array(crt_pair(parts), dtype=np.int64)


def band_chars(n: int, fault: str = "", shrink: bool = False) -> list[tuple[int, int, Fraction]]:
    g = g_n(n, fault)
    a_, b_ = g[:, 0], g[:, 1]
    out = []
    beta = np.arange(n, dtype=np.int64)
    for alpha in range(n):
        vals = (alpha * a_[None, :] + beta[:, None] * b_[None, :]) % n  # shape (n, |G|)
        four = 4 * vals
        if shrink:
            # band [1/4 + 1/(8n), 3/4 - 1/(8n)]: 8*v >= 2n + 1 and 8*v <= 6n - 1
            ok = ((8 * vals >= 2 * n + 1) & (8 * vals <= 6 * n - 1)).all(axis=1)
        else:
            ok = ((four >= n) & (four <= 3 * n)).all(axis=1)
        for bt in np.nonzero(ok)[0]:
            bt = int(bt)
            if gcd(gcd(alpha, bt), n) != 1:
                continue
            v = vals[bt]
            marg = min(min(Fraction(int(x), n) - Fraction(1, 4), Fraction(3, 4) - Fraction(int(x), n)) for x in v)
            out.append((alpha, bt, marg))
    return out


def main() -> int:
    ns = sorted({d for d in range(1, 337) if 336 % d == 0} | {9, 11, 19, 23, 32, 49})
    ns = [n for n in ns if n > 1]
    predicted = {2: (1, Fraction(1, 4)), 3: (4, Fraction(1, 12)), 4: (8, Fraction(0)), 7: (8, Fraction(1, 28)),
                 8: (8, Fraction(0))}
    ok = True
    total = 0
    for n in ns:
        chars = band_chars(n)
        total += len(chars)
        margins = sorted({m for (_, _, m) in chars})
        gsize = len(g_n(n))
        line = f"N={n:4d} |G_N|={gsize:5d} band chars of exact order N: {len(chars):3d} margins {[str(m) for m in margins]}"
        print(line)
        if n in predicted:
            cnt, mg = predicted[n]
            if len(chars) != cnt or margins != [mg]:
                print(f"  MISMATCH with prediction {cnt}, {mg}")
                ok = False
        elif chars:
            print("  MISMATCH: predicted none")
            ok = False
    print(f"total band torsion characters over the list: {total} (predicted 29)")
    ok = ok and total == 29
    if "--controls" in sys.argv:
        # control 1: all norm-one residues mod 2^k at 16 (non-liftable ones included) must change the order-16 or 8 answer
        c1 = {n: len(band_chars(n, fault="two")) for n in (4, 8, 16)}
        print(f"control 1 (non-liftable residues at 2^k): counts {c1}")
        red1 = c1 != {4: 8, 8: 8, 16: 0}
        # control 2: shrinking the band removes the margin-0 characters (orders 4, 8) and keeps 2, 3, 7
        c2 = {n: len(band_chars(n, shrink=True)) for n in (2, 3, 4, 7, 8)}
        print(f"control 2 (band shrunk by 1/(8N)): counts {c2}")
        red2 = c2 == {2: 1, 3: 4, 4: 0, 7: 8, 8: 0}
        # control 3: level-one circle only at 9 and 49 (no level-collapse cosets)
        c3 = {n: len(band_chars(n, fault="odd")) for n in (9, 49)}
        print(f"control 3 (odd level-collapse cosets dropped): counts {c3}")
        red3 = c3[9] > 0 or c3[49] > 0
        print(f"controls fired as designed: 1 {red1}, 2 {red2}, 3 {red3}")
        ok = ok and red1 and red2 and red3
    print("ALL AS PREDICTED" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
