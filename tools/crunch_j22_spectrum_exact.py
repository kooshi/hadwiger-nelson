#!/usr/bin/env python3
"""J22 (crunch 2026-09-25): exact decision of the level-one spectrum of a local unit-circle graph.

The graph: Gamma = Cay(F_p^2, T), T = {(x, y) : x^2 + y^2 = 1} (p odd prime).  For p = 3 (mod 4) this is the
level-one plane of a stable place with residue field F_p; for p = 1 (mod 4) it is the level-one graph of the
standard compact piece of a split place (T is the hyperbola uw = 1 in the coordinates u = x + iy, w = x - iy).

For a character xi = (a, b) != 0 the eigenvalue is lambda(xi) = sum_{t in T} zeta^{a t1 + b t2}, an element of
Z[zeta_p].  We compute every lambda(xi) EXACTLY as a vector in Z[zeta_p], group the characters into Galois orbits
(sigma_s : zeta -> zeta^s acts as xi -> s*xi), form each orbit's minimal polynomial prod (x - lambda') over the
DISTINCT conjugates in Z[zeta_p][x], check that every coefficient is a rational integer (the orbit is complete),
and decide by Sturm's theorem (sympy, exact over Q) how many roots lie in (-oo, -B] and [B, oo), B = |T|/4.

    lambda* := max_{xi != 0} |lambda(xi)| / |T|  <  1/4   <=>   no root of any orbit polynomial has |x| >= B.

Exact checks carried along (each must hold or the run exits 2):
  (S) structure: lambda is constant on the orbits of the circle group acting on characters (xi -> z*xi); for
      p = 3 (mod 4) this is 'lambda depends only on a^2 + b^2';
  (I) integrality: every orbit polynomial has rational-integer coefficients;
  (T) trace:     sum_{xi != 0} lambda(xi) = -|T|              (exact, in Z[zeta_p]);
  (P) Parseval:  sum_{xi != 0} lambda(xi)^2 = p^2|T| - |T|^2   (exact, in Z[zeta_p]);
  (W) Weil:      every root has |x| <= 2 sqrt(p) + tiny, checked by Sturm counts outside +-(2 sqrt p) rounded up.
The extreme roots are then isolated to width < 1e-12 by sympy's exact rational root isolation.

Planted faults (--plant), each must make the run exit 2 at the named check:
  drop-point   remove one point of T              -> fires (S)
  orbit-drop   omit one conjugate from one orbit  -> fires (I)
  trace-skew   add 1 to every eigenvalue in one circle-group orbit -> fires (T)
Exit codes: 0 = decided, all checks green; 2 = a check failed (the named one); 1 = usage.
"""
from __future__ import annotations

import argparse
import math
import sys
from fractions import Fraction

import sympy


def circle(p: int) -> list[tuple[int, int]]:
    return [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]


def normalize(v: list[int], p: int) -> tuple[int, ...]:
    """Canonical form of sum v[k] zeta^k (length p) in Z[zeta_p]: subtract v[p-1] * (1 + ... + zeta^{p-1})."""
    c = v[p - 1]
    return tuple(v[k] - c for k in range(p - 1))


def mul(u: tuple[int, ...], w: tuple[int, ...], p: int) -> tuple[int, ...]:
    """Product in Z[zeta_p] of two canonical vectors (length p-1), returned canonical."""
    out = [0] * p
    for i, ui in enumerate(u):
        if ui == 0:
            continue
        for j, wj in enumerate(w):
            if wj:
                out[(i + j) % p] += ui * wj
    return normalize(out, p)


def add(u, w):
    return tuple(a + b for a, b in zip(u, w))


def as_integer(u: tuple[int, ...]):
    """Return the rational integer u equals, or None if u is not in Z."""
    if any(x != 0 for x in u[1:]):
        return None
    return u[0]


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--p", type=int, required=True)
    ap.add_argument("--plant", choices=["drop-point", "orbit-drop", "trace-skew"], default=None)
    args = ap.parse_args()
    p = args.p
    if p < 3 or not sympy.isprime(p):
        print("usage: --p must be an odd prime", file=sys.stderr)
        return 1

    T = circle(p)
    nT_true = len(T)
    if args.plant == "drop-point":
        T = T[1:]
    nT = len(T)
    B = Fraction(nT, 4)
    kind = "stable (p = 3 mod 4)" if p % 4 == 3 else "split standard piece (p = 1 mod 4)"
    print(f"p={p}  kind={kind}  |T|={nT} (true circle size {nT_true})  threshold B=|T|/4={float(B)}")

    one = tuple([1] + [0] * (p - 2))
    zero = tuple([0] * (p - 1))

    # lambda(xi) for every xi != 0, exact.
    lam: dict[tuple[int, int], tuple[int, ...]] = {}
    for a in range(p):
        for b in range(p):
            if a == 0 and b == 0:
                continue
            v = [0] * p
            for (x, y) in T:
                v[(a * x + b * y) % p] += 1
            lam[(a, b)] = normalize(v, p)

    if args.plant == "trace-skew":
        # Skew a whole circle-group orbit (so that (S) still passes and (T) must fire for its own reason).
        # A first version skewed one character and fired (S) instead -- the wrong reason; kept as a note.
        for (z1, z2) in circle(p):
            k0 = ((-z2) % p, z1 % p)  # z * (0, 1)
            lam[k0] = add(lam[k0], one)

    # (S) structure: constant on circle-group orbits xi -> z*xi, with z = (z1, z2) acting as the complex
    # multiplication (a, b) -> (z1 a - z2 b, z2 a + z1 b), which preserves T and a^2 + b^2.
    Ttrue = circle(p)
    seen = set()
    for xi in lam:
        if xi in seen:
            continue
        orb = set()
        for (z1, z2) in Ttrue:
            orb.add(((z1 * xi[0] - z2 * xi[1]) % p, (z2 * xi[0] + z1 * xi[1]) % p))
        vals = {lam[e] for e in orb}
        seen |= orb
        if len(vals) != 1:
            print(f"CHECK (S) FAILED: lambda not constant on the circle-group orbit of {xi} ({len(vals)} values)")
            return 2
    print("check (S) structure: PASS (lambda constant on every circle-group orbit of characters)")

    # (T) and (P), exact in Z[zeta_p].
    tr = zero
    sq = zero
    for v in lam.values():
        tr = add(tr, v)
        sq = add(sq, mul(v, v, p))
    tr_i, sq_i = as_integer(tr), as_integer(sq)
    if tr_i != -nT:
        print(f"CHECK (T) FAILED: sum of nontrivial eigenvalues = {tr_i if tr_i is not None else 'non-integer'}, expected {-nT}")
        return 2
    if sq_i != p * p * nT - nT * nT:
        print(f"CHECK (P) FAILED: sum of squares = {sq_i}, expected {p*p*nT - nT*nT}")
        return 2
    print(f"check (T) trace: PASS ({tr_i});  check (P) Parseval: PASS ({sq_i})")

    # Galois orbits: xi -> s*xi.  Distinct conjugate values per orbit.
    x = sympy.Symbol("x")
    done = set()
    orbit_polys = []
    planted = False
    for xi in sorted(lam):
        if xi in done:
            continue
        members = {((s * xi[0]) % p, (s * xi[1]) % p) for s in range(1, p)}
        done |= members
        distinct = sorted({lam[e] for e in members})
        mult = {val: sum(1 for e in lam if lam[e] == val) for val in distinct}
        if args.plant == "orbit-drop" and not planted and len(distinct) > 1:
            distinct = distinct[1:]
            planted = True
        # prod (x - val) with coefficients in Z[zeta_p], lowest degree first.
        poly = [one]
        for val in distinct:
            neg = tuple(-c for c in val)
            new = [zero] * (len(poly) + 1)
            for i, c in enumerate(poly):
                new[i + 1] = add(new[i + 1], c)          # x * c
                new[i] = add(new[i], mul(c, neg, p))      # -val * c
            poly = new
        ints = [as_integer(c) for c in poly]
        if any(c is None for c in ints):
            print(f"CHECK (I) FAILED: the orbit of {xi} gives a polynomial with a non-rational coefficient")
            return 2
        P = sympy.Poly(list(reversed(ints)), x)
        orbit_polys.append((xi, P, len(distinct), mult[distinct[0]]))
    print(f"check (I) integrality: PASS ({len(orbit_polys)} Galois orbits; degrees "
          f"{[d for (_, _, d, _) in orbit_polys]})")

    # (W) Weil and the decision, by exact Sturm counts.
    weil = sympy.Rational(math.isqrt(4 * p) + 1)  # an integer >= 2 sqrt(p)
    beyond_weil = sum(P.count_roots(inf=weil) + P.count_roots(sup=-weil) for (_, P, _, _) in orbit_polys)
    if beyond_weil:
        print(f"CHECK (W) FAILED: {beyond_weil} roots beyond +-{weil}")
        return 2
    print(f"check (W) Weil: PASS (no root beyond +-{weil} >= 2 sqrt p = {2*math.sqrt(p):.4f})")

    Bs = sympy.Rational(B.numerator, B.denominator)
    n_hi = sum(P.count_roots(inf=Bs) for (_, P, _, _) in orbit_polys)
    n_lo = sum(P.count_roots(sup=-Bs) for (_, P, _, _) in orbit_polys)

    # Isolate the extreme roots.
    eps = sympy.Rational(1, 10**13)
    lo_iv, hi_iv = None, None
    for (_, P, _, _) in orbit_polys:
        ivs = P.intervals(eps=eps)
        for (iv, _) in ivs:
            a, b = iv
            if lo_iv is None or a < lo_iv[0]:
                lo_iv = (a, b)
            if hi_iv is None or b > hi_iv[1]:
                hi_iv = (a, b)
    lmin_lo, lmin_hi = lo_iv
    lmax_lo, lmax_hi = hi_iv
    print(f"lambda_min in [{float(lmin_lo):.13f}, {float(lmin_hi):.13f}]   (exact rational isolating interval)")
    print(f"lambda_max in [{float(lmax_lo):.13f}, {float(lmax_hi):.13f}]   (largest nontrivial eigenvalue)")
    lstar_hi = max(-lmin_lo, lmax_hi) / nT
    lstar_lo = max(-lmin_hi, lmax_lo) / nT
    print(f"lambda* = max|lambda|/|T| in [{float(lstar_lo):.13f}, {float(lstar_hi):.13f}];  "
          f"1/4 - lambda* in [{float(sympy.Rational(1,4)-lstar_hi):.3e}, {float(sympy.Rational(1,4)-lstar_lo):.3e}]")
    hoff = (-lmin_hi) / (nT - lmin_hi), (-lmin_lo) / (nT - lmin_lo)
    print(f"Hoffman ratio -lambda_min/(|T| - lambda_min) in [{float(hoff[0]):.12f}, {float(hoff[1]):.12f}]  (1/5 = 0.2)")
    print(f"Sturm: roots <= -B: {n_lo};  roots >= +B: {n_hi}")
    verdict = "lambda* < 1/4 (5-thick at level one)" if n_lo == 0 and n_hi == 0 else "lambda* >= 1/4 (NOT 5-thick at level one)"
    print(f"DECISION p={p}: {verdict}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
