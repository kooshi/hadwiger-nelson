#!/usr/bin/env python3
"""J26: an independent exact re-check of the finite parts of [AmbrusEtAl2023]'s certificate, and the arithmetic
that decides whether the notebook's continuous step (W(t) >= 1 - mu) survives with a correct Lipschitz constant.

It reads the shipped files, never a copy: the 23 points from the authors' notebook source
(data/pa-ambrus2023/verification23.nb, the exact input the checker evaluates) and the 2,350 dual coefficients
from data/pa-ambrus2023/g23.csv (decimal strings, read as exact rationals).

Checks (H-numbers are plans/PA-ambrus2023-audit.md §2.2's):
  H1  exact unit pairs (expect 47) and distinct distances (expect 27), in Q(sqrt3, sqrt11)
  H2  every listed congruence {I, J}: |I| = |J|, and every pairwise squared distance agrees under the listed
      correspondence (the criterion for congruence of planar point sets) -- EXACT
  H3  V(eps) on every independent atom (expect 13,552), EXACT, from the decimal coefficients; min V vs -nu
  H5  d_min over pairs with w2 != 0 (expect >= 0.1, exactly), |J0(s0)| at the largest J1 zero <= 1000
  H4  (a) float re-evaluation of the notebook's grids (scipy j0: NOT rigorous, independent of Mathematica);
      (b) Lipschitz constants of W on [0,100], [100,1000], [1000,10000] from the certificate, against the
          thresholds the notebook's recorded grid minima need
  H6  (w_T + nu)/(1 - mu) < 0.2470 exactly, at the notebook's nu = 1e-6 and the paper's nu = 1e-5

Plants (--plant NAME) break one input and must make exactly that check fail; --self-test runs them all.
Exact arithmetic of seconds on an existing certificate: allowed under the 2026-09-24..10-01 ban (no search).
"""
from __future__ import annotations

import argparse
import csv
import re
import sys
from fractions import Fraction
from pathlib import Path

import mpmath
import numpy as np
import scipy.special as sp
import sympy

ROOT = Path(__file__).resolve().parent.parent
NB = ROOT / "data/pa-ambrus2023/verification23.nb"
CSV = ROOT / "data/pa-ambrus2023/g23.csv"
N = 23
MU = Fraction(6, 100000)
NU_NB = Fraction(1, 10**6)
NU_PAPER = Fraction(1, 10**5)

# ---------- the field Q(sqrt3, sqrt11): a + b*sqrt3 + c*sqrt11 + d*sqrt33, as 4-tuples of Fractions ----------


def fmul(x, y):
    a, b, c, d = x
    e, f, g, h = y
    return (a * e + 3 * b * f + 11 * c * g + 33 * d * h,
            a * f + b * e + 11 * c * h + 11 * d * g,
            a * g + c * e + 3 * b * h + 3 * d * f,
            a * h + d * e + b * g + c * f)


def fsub(x, y):
    return tuple(p - q for p, q in zip(x, y))


def fadd(x, y):
    return tuple(p + q for p, q in zip(x, y))


def ffloat(x):
    a, b, c, d = x
    return mpmath.mpf(a.numerator) / a.denominator + mpmath.mpf(b.numerator) / b.denominator * mpmath.sqrt(3) \
        + mpmath.mpf(c.numerator) / c.denominator * mpmath.sqrt(11) + mpmath.mpf(d.numerator) / d.denominator * mpmath.sqrt(33)


def read_points(nb_path: Path):
    """The vertex list exactly as the notebook evaluates it: flatten the RowBox strings of the `X = {...}` cell."""
    lines = nb_path.read_text().replace("\r", "").split("\n")
    start = next(i for i, ln in enumerate(lines) if 'RowBox[{"X", "=",' in ln)
    toks = []
    for ln in lines[start:]:
        toks += re.findall(r'"((?:[^"\\]|\\.)*)"', ln)
        if any("};" in t or t == ";" for t in toks[-3:]) and "}" in "".join(toks[-3:]):
            break
    s = "".join(toks)
    s = s.replace("\\[IndentingNewLine]", "").replace("\\n", "").replace("\\[ImaginaryI]", "I")
    body = s[s.index("{") + 1: s.index("}")]
    exprs = [e for e in body.split(",")]
    assert len(exprs) == N, f"expected {N} points, read {len(exprs)}"
    sq = {sympy.Integer(1): 0, sympy.sqrt(3): 1, sympy.sqrt(11): 2, sympy.sqrt(33): 3}
    pts = []
    for e in exprs:
        z = sympy.expand(sympy.sympify(e.replace("^", "**"), locals={"I": sympy.I}))
        re_, im_ = [Fraction(0)] * 4, [Fraction(0)] * 4
        for mono, coef in z.as_coefficients_dict().items():
            imag = mono.has(sympy.I)
            base = sympy.simplify(mono / sympy.I) if imag else mono
            k = sq[base]
            q = Fraction(int(sympy.Rational(coef).p), int(sympy.Rational(coef).q))
            (im_ if imag else re_)[k] += q
        pts.append((tuple(re_), tuple(im_)))
    return pts


def sqdist(p, q):
    dx, dy = fsub(p[0], q[0]), fsub(p[1], q[1])
    return fadd(fmul(dx, dx), fmul(dy, dy))


def read_coeffs(csv_path: Path):
    rows = list(csv.reader(csv_path.read_text().replace("\r", "").splitlines()))
    w0 = wT = w1 = None
    w2, wc = [], []
    for r in rows:
        v, kind = Fraction(r[0]), r[1]
        if kind == "w_0":
            w0 = v
        elif kind == "w_T":
            wT = v
        elif kind == "w_1":
            assert r[2] == "1", "w_1 is expected only at vertex 1 (paper §8)"
            w1 = v
        elif kind == "w_2":
            w2.append((v, int(r[2]), int(r[3])))
        elif kind == "w_C":
            I = [int(t) for t in r[2].strip("{}").split(",")]
            J = [int(t) for t in r[3].strip("{}").split(",")]
            wc.append((v, I, J))
        else:
            raise ValueError(kind)
    return w0, wT, w1, w2, wc


def mask(ix):
    m = 0
    for i in ix:
        m |= 1 << (i - 1)
    return m


def independent_sets(adj):
    out = []

    def rec(v, cur):
        if v == N:
            out.append(cur)
            return
        rec(v + 1, cur)
        if not (adj[v] & cur):
            rec(v + 1, cur | (1 << v))
    rec(0, 0)
    return out


def exact_dot(atoms_incidence, coeffs_int):
    """Exact sum_k sign[a,k]*c_k for every atom a, with int64 dots on 32-bit halves (no overflow: |sign|<=1,
    <= 2,350 terms, halves < 2^40)."""
    hi = np.array([c >> 32 for c in coeffs_int], dtype=np.int64)
    lo = np.array([c & 0xFFFFFFFF for c in coeffs_int], dtype=np.int64)
    assert all(abs(int(h)) < 2**40 for h in hi)
    sh = atoms_incidence @ hi
    sl = atoms_incidence @ lo
    return [int(a) * 2**32 + int(b) for a, b in zip(sh, sl)]


def run(plant: str | None):
    mpmath.mp.dps = 40
    pts = read_points(NB)
    w0, wT, w1, w2, wc = read_coeffs(CSV)
    if plant == "coord":
        re_, im_ = pts[1]
        pts[1] = ((re_[0] + Fraction(1, 100),) + re_[1:], im_)
    if plant == "cong2":   # a two-point "congruence" whose distances differ: the notebook's similarity test passes it
        for k, (v, I, J) in enumerate(wc):
            if len(I) == 2:
                d2I = sqdist(pts[I[0] - 1], pts[I[1] - 1])
                alt = next((a, b) for a in range(1, N + 1) for b in range(a + 1, N + 1)
                           if sqdist(pts[a - 1], pts[b - 1]) != d2I)
                wc[k] = (v, I, list(alt))
                break
    if plant == "cong_order":
        for k, (v, I, J) in enumerate(wc):
            if len(I) >= 3:
                J2 = J[:]
                J2[0], J2[1] = J2[1], J2[0]
                if any(sqdist(pts[J2[a] - 1], pts[J2[b] - 1]) != sqdist(pts[I[a] - 1], pts[I[b] - 1])
                       for a in range(len(I)) for b in range(a + 1, len(I))):
                    wc[k] = (v, I, J2)
                    break
    if plant == "wT":
        wT = wT - Fraction(1, 10**6)
    if plant == "w2scale":
        w2 = [(2 * v, i, j) for v, i, j in w2]

    ok = {}
    D2 = [[sqdist(pts[i], pts[j]) for j in range(N)] for i in range(N)]
    one = (Fraction(1), Fraction(0), Fraction(0), Fraction(0))
    units = [(i, j) for i in range(N) for j in range(i + 1, N) if D2[i][j] == one]
    distinct = {D2[i][j] for i in range(N) for j in range(i + 1, N)}
    print(f"H1 unit pairs: {len(units)} (notebook: 47); distinct distances: {len(distinct)} (notebook: 27)")
    ok["H1"] = len(units) == 47 and len(distinct) == 27

    bad = []
    size_hist = {}
    for v, I, J in wc:
        size_hist[len(I)] = size_hist.get(len(I), 0) + 1
        good = len(I) == len(J) and len(set(I)) == len(I) and len(set(J)) == len(J) and set(I) != set(J) \
            and all(1 <= t <= N for t in I + J)
        if good:
            good = all(D2[I[a] - 1][I[b] - 1] == D2[J[a] - 1][J[b] - 1]
                       for a in range(len(I)) for b in range(a + 1, len(I)))
        if not good:
            bad.append((I, J))
    print(f"H2 congruences listed: {len(wc)}; set sizes {dict(sorted(size_hist.items()))}; "
          f"FAILING exact pairwise-distance check: {len(bad)}" + (f"  e.g. {bad[:3]}" if bad else ""))
    ok["H2"] = not bad

    adj = [0] * N
    for i, j in units:
        adj[i] |= 1 << j
        adj[j] |= 1 << i
    atoms = independent_sets(adj)
    print(f"H3 independent atoms (incl. the empty one): {len(atoms)} (notebook: 13,552)")
    # incidence: column 0 = w1 (vertex 1 in S -> -1), then w2 pairs (-1 if both in S), then wc (+[I<=S] - [J<=S])
    terms = [(-1, mask([1]), None, w1)] + [(-1, mask([i, j]), None, v) for v, i, j in w2] \
        + [(+1, mask(I), mask(J), v) for v, I, J in wc]
    A = np.array(atoms, dtype=np.int64)
    cols = []
    for sgn, mI, mJ, _ in terms:
        colI = ((A & mI) == mI).astype(np.int64)
        col = sgn * colI if mJ is None else colI - ((A & mJ) == mJ).astype(np.int64)
        cols.append(col)
    inc = np.stack(cols, axis=1)
    denom = 1
    for *_, v in terms:
        denom = _lcm(denom, v.denominator)
    denom = _lcm(denom, wT.denominator)
    cint = [int(v * denom) for *_, v in terms]
    assert all(Fraction(c, denom) == v for c, (*_, v) in zip(cint, terms))
    sums = exact_dot(inc, cint)
    V = [Fraction(int(wT * denom) + s, denom) for s in sums]
    vmin = min(V)
    print(f"H3 min V(eps) = {float(vmin):.6e} exactly {vmin if vmin.denominator < 10**30 else '(long rational)'} "
          f"(notebook: -6.71224e-8); >= -1e-6: {vmin >= -NU_NB}; >= -1e-5: {vmin >= -NU_PAPER}")
    ok["H3"] = len(atoms) == 13552 and vmin >= -NU_NB

    # H5: d_min over pairs with w2 != 0, exactly; |J0(s0)|
    dmin2f = min(ffloat(D2[i - 1][j - 1]) for _, i, j in w2)
    # exact: d^2 >= 1/100 for every w2 pair, decided by sympy on the exact algebraic number
    exact_ge = []
    for _, i, j in w2:
        a, b, c, d = D2[i - 1][j - 1]
        expr = sympy.Rational(a.numerator, a.denominator) + sympy.Rational(b.numerator, b.denominator) * sympy.sqrt(3) \
            + sympy.Rational(c.numerator, c.denominator) * sympy.sqrt(11) + sympy.Rational(d.numerator, d.denominator) * sympy.sqrt(33) \
            - sympy.Rational(1, 100)
        exact_ge.append(bool(expr.is_nonnegative))
    s0 = mpmath.besseljzero(1, 1)
    k = 1
    while True:
        z = mpmath.besseljzero(1, k + 1)
        if z > 1000:
            break
        k += 1
        s0 = z
    j0s0 = abs(mpmath.besselj(0, s0))
    L1 = abs(w0) + sum(abs(v) for v, _, _ in w2)
    tail = w1 - L1 * j0s0
    print(f"H5 d_min over w2 pairs = {mpmath.nstr(mpmath.sqrt(dmin2f), 12)} (>= 0.1 exactly: {all(exact_ge)}); "
          f"s0 = {mpmath.nstr(s0, 12)}, |J0(s0)| = {mpmath.nstr(j0s0, 10)}; |w0|+sum|w2| = {float(L1):.6f}; "
          f"w1 - (|w0|+sum|w2|)|J0(s0)| = {mpmath.nstr(tail, 10)} (> 1: {tail > 1})")
    ok["H5"] = all(exact_ge) and tail > 1

    # H4 (a): float re-evaluation of the notebook's grids
    dists = np.array([float(mpmath.sqrt(ffloat(D2[i - 1][j - 1]))) for _, i, j in w2])
    w2f = np.array([float(v) for v, _, _ in w2])
    w0f, w1f = float(w0), float(w1)

    def fi(t):
        t = np.asarray(t, dtype=float)
        return w0f * sp.j0(t) + w1f + (w2f[None, :] * sp.j0(np.outer(t, dists))).sum(axis=1)
    g3 = fi(1000 + np.arange(1, 9001) * 1.0).min()
    g2 = fi(100 + np.arange(1, 9001) * 0.1).min()
    tk = np.arange(1, 100001)
    f1 = fi(tk * 0.001)
    sel = tk[f1 < 0.99995 + 0.001]
    fine = min(fi((k - 1) * 0.001 + np.arange(0, 201) * 0.00001).min() for k in sel)
    W0 = float(w0 + w1 + sum(v for v, _, _ in w2))
    print(f"H4a float grids (scipy): min on [1001,10000] step 1 = {g3:.6f} (nb 1.03829); on [100.1,1000] step 0.1 = "
          f"{g2:.6f} (nb 1.01102); #points with fi<1.00095 on step 0.001 = {len(sel)} (nb 2629); fine min = {fine:.9f} "
          f"(nb 0.99995); 1 - fine + 1e-5 = {1 - fine + 1e-5:.9f} (nb 0.000059969; mu = 6e-5); W(0) = {W0:.6f}")

    # H4 (b): Lipschitz constants.  W'(t) = -w0 J1(t) - sum w2 d J1(t d).
    supJ1 = mpmath.findroot(lambda x: mpmath.besselj(0, x) - mpmath.besselj(1, x) / x, 1.84)
    supJ1 = abs(mpmath.besselj(1, supJ1)) * (1 + mpmath.mpf(10) ** -12)
    u0 = mpmath.mpf(10)
    C = mpmath.sqrt(u0 * (mpmath.besselj(1, u0) ** 2 + mpmath.bessely(1, u0) ** 2))  # |J1(u)| <= C/sqrt(u), u >= 10
    ds = [mpmath.sqrt(ffloat(D2[i - 1][j - 1])) for _, i, j in w2]
    S1 = abs(w0) + sum(abs(v) * d for (v, _, _), d in zip(w2, ds))
    Sh = abs(w0) + sum(abs(v) * mpmath.sqrt(d) for (v, _, _), d in zip(w2, ds))
    Sfloat1, Sfloath = float(S1), float(Sh)
    L_a = supJ1 * Sfloat1
    L_b = C / mpmath.sqrt(100) * Sfloath
    L_c = C / mpmath.sqrt(1000) * Sfloath
    need_a = (1.00095 - 0.99994) / 0.0005    # coarse selection; the fine step's "+eps" is valid iff L <= 2
    need_b = (1.011015 - 0.99994) / 0.05     # recorded 1.01102, lower rounding end
    need_c = (1.038285 - 0.99994) / 0.5      # recorded 1.03829
    print(f"H4b sup|J1| = {mpmath.nstr(supJ1, 10)}; C = sqrt(10)*M1(10) = {mpmath.nstr(C, 10)}; "
          f"|w0|+sum|w2|d = {Sfloat1:.6f}; |w0|+sum|w2|sqrt(d) = {Sfloath:.6f}")
    print(f"    L[0,100] <= {mpmath.nstr(L_a, 6)}  (needs <= 2.0 for the fine step's +eps, {need_a:.4f} for the coarse)")
    print(f"    L[100,1000] <= {mpmath.nstr(L_b, 6)}  (needs <= {need_b:.4f})")
    print(f"    L[1000,10000] <= {mpmath.nstr(L_c, 6)}  (needs <= {need_c:.4f})")
    # Sanity (not a proof) of Watson §13.74 as used for C: x*(J1^2+Y1^2) is decreasing on [10, 10^4].
    xs = [mpmath.mpf(10) * (mpmath.mpf(1000) ** (k / 40)) for k in range(41)]
    ms = [x * (mpmath.besselj(1, x) ** 2 + mpmath.bessely(1, x) ** 2) for x in xs]
    assert all(a >= b for a, b in zip(ms, ms[1:])), "x M_1(x)^2 not decreasing on the sample"
    # Covering: every t in [0, 10000] lies between two consecutive evaluation points a < b of the notebook's grids
    # (coarse grids, plus the fine grids where the notebook refined, plus t = 0); on [a, b] a function with Lipschitz
    # constant L is >= (W(a) + W(b))/2 - L (b - a)/2.  L by region: the region of a (the larger constant).
    pts_ = np.concatenate([[0.0], tk * 0.001, np.concatenate([(k - 1) * 0.001 + np.arange(0, 201) * 0.00001 for k in sel]),
                           100 + np.arange(1, 9001) * 0.1, 1000 + np.arange(1, 9001) * 1.0])
    pts_ = np.unique(pts_)
    vals = fi(pts_)
    a_, b_ = pts_[:-1], pts_[1:]
    Lr = np.where(a_ < 100, float(L_a), np.where(a_ < 1000, float(L_b), float(L_c)))
    lb = (vals[:-1] + vals[1:]) / 2 - Lr * (b_ - a_) / 2
    worst = int(np.argmin(lb))
    print(f"H4c covering of [0, 10000] by the notebook's evaluation points with the corrected constants: "
          f"min lower bound {lb[worst]:.9f} on [{a_[worst]:.5f}, {b_[worst]:.5f}] (needs >= 1 - mu = 0.99994); "
          f"max gap {np.max(b_ - a_):.3f}; W(100.0) = {float(fi([100.0])[0]):.6f}, W(1000.0) = {float(fi([1000.0])[0]):.6f}")
    ok["H4"] = L_a <= 2.0 and len(sel) == 2629 and lb[worst] >= 0.99994 and pts_[0] == 0 and pts_[-1] == 10000 \
        and abs(g3 - 1.03829) < 1e-5 and abs(g2 - 1.01102) < 1e-5 and 1 - fine + 1e-5 <= 6e-5

    b_nb = (wT + NU_NB) / (1 - MU)
    b_pa = (wT + NU_PAPER) / (1 - MU)
    print(f"H6 (wT+nu)/(1-mu): nu=1e-6 -> {float(b_nb):.9f}; nu=1e-5 -> {float(b_pa):.9f}; both < 0.2470: "
          f"{b_nb < Fraction(247, 1000) and b_pa < Fraction(247, 1000)}")
    ok["H6"] = b_pa < Fraction(247, 1000)
    print("VERDICTS:", " ".join(f"{k}={'PASS' if v else 'FAIL'}" for k, v in ok.items()))
    return ok, vmin


def _lcm(a, b):
    from math import gcd
    return a * b // gcd(a, b)


PLANTS = {"coord": "H1", "cong2": "H2", "cong_order": "H2", "wT": "H3", "w2scale": "H4"}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=sorted(PLANTS))
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if not a.self_test:
        ok, _ = run(a.plant)
        sys.exit(0 if all(ok.values()) else 1)
    base, vmin0 = run(None)
    assert all(base.values()), f"guarded run must pass: {base}"
    for p, target in PLANTS.items():
        print(f"\n--- plant {p} (must fail {target}) ---")
        res, vmin = run(p)
        fired = [k for k, v in res.items() if not v]
        assert target in fired, f"plant {p} did not fire {target}: {res}"
        if p == "wT":   # two-sided: the plant moves min V by exactly 1e-6
            diff = vmin0 - vmin
            assert 0 < diff <= Fraction(1, 10**6), diff
        print(f"plant {p}: fired {fired}")
    print("\nSELF-TEST OK: every plant fired its check")


if __name__ == "__main__":
    main()
