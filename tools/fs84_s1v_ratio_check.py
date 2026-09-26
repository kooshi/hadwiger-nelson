#!/usr/bin/env python3
"""FS84-S1V: exact checks of seconds behind the blind verdict on V1 (rho_per(Q(sqrt47)) < 1/4).

Written blind (no tools/fs84_s1_* file, no deriver record opened).  Checks, in order of
evidential value:

  A. rigorous: lambda_min(Gamma_p) against -(p+1)/3 at every stable prime of Q(sqrt47) below 70,
     by (i) mpmath interval arithmetic at 80 digits and (ii) an exact route -- the integer
     polynomial prod_c (x - lambda(c)) and an exact Sturm root count on (-(p+1), -(p+1)/3];
  B. the stable primes of Q(sqrt47)(i) below a bound (p = 3 mod 4 with (47/p) = 1, and 47);
  C. float sanity of the derivation "every new character at level k has |lambda| <= 2 p^ceil(k/2)",
     hence lambda_min(G_k)/d_k = lambda_min(G_1)/d_1: unramified at p = 7 (k = 2, 3) and p = 31
     (k = 2), ramified at p = 7 (O = Z_7[sqrt7], k = 2, 3).

Plants (each must fire; run with --plants):
  P1  the Hoffman test at 31 against a threshold 1e-3 above -(p+1)/3 must FAIL;
  P2  at p = 11 the Hoffman ratio must be >= 1/4 (the certificate, not Hoffman, is needed there);
  P3  dropping one point of the unit circle must trip the circle-size assertion;
  P4  a stable-prime classifier with the Legendre symbol negated must disagree with the true list.

Exit 0 all checks pass; 1 a check failed; 2 a plant did not fire.
"""
import sys
from fractions import Fraction

import mpmath
from mpmath import iv
import numpy as np
import sympy as sp

iv.dps = 80
mpmath.mp.dps = 80


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def stable_primes_47(bound, negate=False):
    """Primes p < bound with a conjugation-stable prime of Q(sqrt47, i) above them."""
    out = []
    for p in sp.primerange(2, bound):
        if p == 47:
            out.append(p)  # ramified in Q(sqrt47), inert in Q(i): one prime above 47, stable
            continue
        if p == 2:
            continue  # 47 = 7 mod 8: primes above 2 split in F(i) (the wall broken)
        ls = legendre(47, p)
        if negate:
            ls = -ls
        if p % 4 == 3 and ls == 1:
            out.append(p)
    return out


def unit_circle(p, drop=0):
    pts = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    return pts[drop:]


def trace_counts(p, a, circle):
    """n_v = #{u in circle : Tr(a u) = v}, Tr(x + y i) = 2x, a = (s, t)."""
    s, t = a
    counts = [0] * p
    for (x, y) in circle:
        counts[(2 * (s * x - t * y)) % p] += 1
    return counts


def norm_class_reps(p):
    reps = {}
    for s in range(p):
        for t in range(p):
            c = (s * s + t * t) % p
            if c and c not in reps:
                reps[c] = (s, t)
    assert len(reps) == p - 1
    return reps


def eigen_intervals(p, circle):
    reps = norm_class_reps(p)
    lam = {}
    for c, a in reps.items():
        n = trace_counts(p, a, circle)
        val = iv.mpf(0)
        for v, cnt in enumerate(n):
            if cnt:
                val += cnt * iv.cos(2 * iv.pi * v / p)
        lam[c] = (val, n)
    return lam


def exact_count_below(p, lam):
    """Exact route: Q(x) = prod_{c != 0} (x - lambda(c)) has integer coefficients (the multiset is
    Galois-stable, its members algebraic integers).  Round the interval coefficients (certified:
    each interval holds exactly one integer and has width < 1) and count real roots in
    [-(p+1), -(p+1)/3] exactly."""
    x = sp.symbols('x')
    coeffs = [iv.mpf(1)]  # highest first
    for c, (val, _) in lam.items():
        new = [iv.mpf(0)] * (len(coeffs) + 1)
        for i, co in enumerate(coeffs):
            new[i] += co
            new[i + 1] -= co * val
        coeffs = new
    ints = []
    for co in coeffs:
        lo, hi = mpmath.mpf(co.a), mpmath.mpf(co.b)
        k = int(mpmath.nint((lo + hi) / 2))
        if not (hi - lo < 0.5 and lo <= k <= hi):
            raise RuntimeError(f"coefficient interval [{lo}, {hi}] does not certify an integer")
        ints.append(k)
    Q = sp.Poly(ints, x)
    thr = sp.Rational(-(p + 1), 3)
    if Q.eval(thr) == 0:
        return Q, None
    return Q, Q.count_roots(-(p + 1), thr)


def hoffman(p, lam_min):
    d = p + 1
    return (-lam_min) / (d - lam_min)


def check_A(p, circle=None, thr_shift=0):
    circle = circle if circle is not None else unit_circle(p)
    if len(circle) != p + 1:
        raise AssertionError(f"circle size {len(circle)} != p+1 at p={p}")
    lam = eigen_intervals(p, circle)
    lmin = None
    for c, (val, _) in lam.items():
        if lmin is None or val.a < lmin.a:
            lmin = val
    thr = iv.mpf(-(p + 1)) / 3 + thr_shift
    margin = lmin - thr                     # interval
    ratio = hoffman(p, lmin)
    return lam, lmin, margin, ratio


# ---- C: float sanity of the level-k character-sum bound -------------------------------------
def vp(n, p, cap):
    j = 0
    while j < cap and n % p == 0:
        n //= p
        j += 1
    return j


def spectrum_unramified(p, k):
    """All eigenvalues of G_k = UD(Z/p^k, 2), one per S_k-orbit of characters.  lambda(a u) =
    lambda(a) for u in S_k (reindexing), and the S_k-orbit of a = p^j b (b a unit mod p^{k-j}) is
    fixed by (j, N(b) mod p^{k-j}); so one representative per key suffices.  Returns
    {(j, c): lambda} and the degree."""
    m = p ** k
    xs, ys = np.meshgrid(np.arange(m), np.arange(m), indexing='ij')
    mask = (xs * xs + ys * ys) % m == 1
    ux, uy = xs[mask].astype(np.int64), ys[mask].astype(np.int64)
    assert len(ux) == p ** (k - 1) * (p + 1)
    reps = {}
    for s in range(m):
        for t in range(m):
            j = min(vp(s, p, k), vp(t, p, k))
            if j == k:
                key = (k, 0)
            else:
                b0, b1 = s // p ** j, t // p ** j
                key = (j, (b0 * b0 + b1 * b1) % p ** (k - j))
            if key not in reps:
                reps[key] = (s, t)
    lam = {}
    for key, (s, t) in reps.items():
        ph = (2 * (s * ux - t * uy)) % m
        lam[key] = float(np.cos(2 * np.pi * ph / m).sum())
    return lam, len(ux)


def spectrum_ramified7(k):
    """O = Z_7[pi], pi^2 = 7; M = O[i]; level k = M / pi^k M, elements x0 + x1 pi with x0 mod
    7^ceil(k/2), x1 mod 7^floor(k/2).  Every character of the group (Z/m0 x Z/m1)^2 is enumerated
    (no orbit reduction).  Returns eigenvalues, the 'new at level k' mask and the degree."""
    p = 7
    m0, m1 = p ** ((k + 1) // 2), p ** (k // 2)
    r = m0 // m1
    pts = []
    for x0 in range(m0):
        for x1 in range(m1):
            for y0 in range(m0):
                for y1 in range(m1):
                    n0 = (x0 * x0 + y0 * y0 + p * (x1 * x1 + y1 * y1)) % m0
                    n1 = (2 * (x0 * x1 + y0 * y1)) % m1
                    if n0 == 1 % m0 and n1 == 0:
                        pts.append((x0, x1, y0, y1))
    pts = np.array(pts, dtype=np.int64)
    assert len(pts) == 8 * p ** (k - 1), len(pts)
    w = np.stack(np.meshgrid(np.arange(m0), np.arange(m1), np.arange(m0), np.arange(m1),
                             indexing='ij'), -1).reshape(-1, 4).astype(np.int64)
    lam = np.empty(len(w))
    step = 4096
    for i in range(0, len(w), step):
        ww = w[i:i + step]
        ph = (np.outer(ww[:, 0], pts[:, 0]) + r * np.outer(ww[:, 1], pts[:, 1])
              + np.outer(ww[:, 2], pts[:, 2]) + r * np.outer(ww[:, 3], pts[:, 3])) % m0
        lam[i:i + step] = np.cos(2 * np.pi * ph / m0).sum(axis=1)
    if k == 1:
        new = np.ones(len(w), bool)
    elif k == 2:
        new = (w[:, 1] != 0) | (w[:, 3] != 0)
    elif k == 3:
        new = (w[:, 0] % p != 0) | (w[:, 2] % p != 0)
    else:
        raise ValueError
    return lam, new, len(pts)


def main(plants=False):
    ok = True
    out = []
    T = stable_primes_47(200)
    out.append(f"B  stable primes of Q(sqrt47)(i) below 200: {T}")
    for q in (2, 3, 7):
        if q in T:
            ok = False
            out.append(f"B  FAIL: {q} should be invertible")
    # A: rigorous Hoffman at the stable primes below 70
    table = {}
    for p in [q for q in T if q < 70] + [7]:
        lam, lmin, margin, ratio = check_A(p)
        table[p] = (lmin, margin, ratio)
        lo = lambda z: mpmath.nstr(mpmath.mpf(z.a), 15)
        hi = lambda z: mpmath.nstr(mpmath.mpf(z.b), 15)
        wmax = max(max(abs(mpmath.mpf(v.a)), abs(mpmath.mpf(v.b))) for v, _ in lam.values())
        weil = wmax <= 2 * mpmath.sqrt(p)
        ok &= bool(weil)
        out.append(f"A  p={p:3d}  lambda_min in [{lo(lmin)}, {hi(lmin)}]"
                   f"  lambda_min+(p+1)/3 >= {lo(margin)}"
                   f"  Hoffman ratio <= {hi(ratio)}"
                   f"  1/4 - ratio >= {mpmath.nstr(mpmath.mpf(1) / 4 - mpmath.mpf(ratio.b), 6)}"
                   f"  Weil max|lambda| {mpmath.nstr(wmax, 8)} <= 2sqrt(p): {weil}")
    lmin31, margin31, ratio31 = table[31]
    if not (mpmath.mpf(margin31.a) > 0 and mpmath.mpf(ratio31.b) < mpmath.mpf(1) / 4):
        ok = False
        out.append("A  FAIL at 31")
    # exact route at 31 and 43 and 47
    for p in (31, 43, 47):
        lam = eigen_intervals(p, unit_circle(p))
        Q, cnt = exact_count_below(p, lam)
        out.append(f"A' p={p}: exact integer polynomial degree {Q.degree()}, "
                   f"real roots in [-(p+1), -(p+1)/3]: {cnt}")
        if cnt != 0:
            ok = False
    # Weil tail: 6 sqrt(p) < p + 1 for p >= 37, and 2sqrt(p)/(p+1+2sqrt(p)) decreasing
    thr = 17 + 12 * mpmath.sqrt(2)
    out.append(f"W  6 sqrt(p) < p+1  iff  p > 17 + 12 sqrt2 = {mpmath.nstr(thr, 10)}")
    wb = {p: 2 * mpmath.sqrt(p) / (p + 1 + 2 * mpmath.sqrt(p)) for p in (43, 47, 67)}
    out.append("W  Weil-Hoffman ratio bounds: " + ", ".join(f"{p}: {mpmath.nstr(v, 8)}" for p, v in wb.items()))
    # C: level-k sanity
    for (p, k) in ((7, 2), (7, 3), (31, 2)):
        lam, d = spectrum_unramified(p, k)
        lam1, d1 = spectrum_unramified(p, 1)
        r_k = min(lam.values()) / d
        r_1 = min(lam1.values()) / d1
        mx = max(abs(v) for key, v in lam.items() if key[0] == 0)
        bnd = 2 * p ** ((k + 1) // 2)
        good = abs(r_k - r_1) < 1e-9 and mx <= bnd + 1e-6
        ok &= good
        out.append(f"C  unramified p={p} k={k}: lam_min/d level k {r_k:.12f}, level 1 {r_1:.12f}; "
                   f"max|new| {mx:.6f} <= 2p^ceil(k/2) = {bnd}: {good}")
    lamR1, _, dR1 = spectrum_ramified7(1)
    for k in (2, 3):
        lam, new, d = spectrum_ramified7(k)
        r_k = lam.min() / d
        r_1 = lamR1.min() / dR1
        mx = np.abs(lam[new]).max()
        bnd = 2 * 7 ** ((k + 1) // 2)
        good = abs(r_k - r_1) < 1e-9 and mx <= bnd + 1e-6
        ok &= good
        out.append(f"C  ramified Z_7[sqrt7] k={k}: lam_min/d {r_k:.12f} vs level one {r_1:.12f}; "
                   f"max|new| {mx:.6f} <= 2*7^ceil(k/2) = {bnd}: {good}")
    print("\n".join(out))
    if not ok:
        print("RESULT: FAIL")
        return 1
    print("RESULT: all checks pass")
    if not plants:
        return 0
    fired = []
    # P1
    _, _, m, r = check_A(31, thr_shift=mpmath.mpf('1e-3'))
    fired.append(("P1 threshold +1e-3 at 31 must fail", mpmath.mpf(m.b) < 0))
    # P2
    _, _, _, r11 = check_A(11)
    fired.append(("P2 Hoffman at 11 must be >= 1/4", mpmath.mpf(r11.a) >= mpmath.mpf(1) / 4))
    # P3
    try:
        check_A(31, circle=unit_circle(31, drop=1))
        fired.append(("P3 dropped circle point must assert", False))
    except AssertionError:
        fired.append(("P3 dropped circle point must assert", True))
    # P4
    fired.append(("P4 negated Legendre classifier must disagree",
                  stable_primes_47(200, negate=True) != stable_primes_47(200)))
    for name, f in fired:
        print(f"{name}: {'FIRED' if f else 'DID NOT FIRE'}")
    if not all(f for _, f in fired):
        return 2
    print("PLANTS: all fired")
    return 0


if __name__ == "__main__":
    sys.exit(main(plants="--plants" in sys.argv))
