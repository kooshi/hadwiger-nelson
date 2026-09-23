#!/usr/bin/env python3
"""FS-73 independent verifier: de Grey's lattice over K = Q(sqrt3, sqrt11), rebuilt from the recipe alone.

Written without reading tools/fs73_lattice.py or tools/fs73_screen.py (the code under test).

Representation (this file's own, chosen independently):
  A point z = x + i y of the plane over K lies in the quartic CM field E4 = Q(sqrt-3, sqrt-11), and is stored
  on the Q-basis (1, e1, e2, e3) = (1, sqrt-3, sqrt-11, sqrt33):
        z = a + b*sqrt-3 + c*sqrt-11 + d*sqrt33,     x = a + d*sqrt33,   y = b*sqrt3 + c*sqrt11.
  Multiplication table: e1^2 = -3, e2^2 = -11, e3^2 = 33, e1 e2 = -e3, e1 e3 = 3 e2, e2 e3 = 11 e1.
  Lattice points are stored as INTEGER 4-tuples (A, B, C, D) = 36 * (a, b, c, d); the recipe says every lattice
  element has coordinates in (1/36)Z, and this file re-proves that (the generators do, and Lambda is their Z-span).

Exact predicates, all in integer arithmetic (no floating point decides anything):
  S = A^2 + 3B^2 + 11C^2 + 33D^2,  T = AD + BC.
  |tau(z)|^2 = (S +- 2T sqrt33)/1296 in the two complex embeddings of E4 (= the four real embeddings of K, in pairs).
  unit vector      <=>  S == 1296 and T == 0.
  ball (R = 3/2)   <=>  S + 2|T| sqrt33 <= 2916  <=>  S <= 2916 and 132 T^2 <= (2916 - S)^2.
"""
from __future__ import annotations

import itertools
import json
import sys
from fractions import Fraction as Fr

import numpy as np

SCALE = 36

# ---------------------------------------------------------------- field arithmetic on Q-coordinates (Fractions)


def mul(z, w):
    a0, a1, a2, a3 = z
    b0, b1, b2, b3 = w
    return (
        a0 * b0 - 3 * a1 * b1 - 11 * a2 * b2 + 33 * a3 * b3,
        a0 * b1 + a1 * b0 + 11 * (a2 * b3 + a3 * b2),
        a0 * b2 + a2 * b0 + 3 * (a1 * b3 + a3 * b1),
        a0 * b3 + a3 * b0 - (a1 * b2 + a2 * b1),
    )


def conj(z):  # complex conjugation: sqrt-3 -> -sqrt-3, sqrt-11 -> -sqrt-11, sqrt33 fixed
    return (z[0], -z[1], -z[2], z[3])


def sigma3(z):  # Galois: sqrt-3 -> -sqrt-3, sqrt-11 fixed (so sqrt33 -> -sqrt33)
    return (z[0], -z[1], z[2], -z[3])


def sigma11(z):  # Galois: sqrt-11 -> -sqrt-11, sqrt-3 fixed (so sqrt33 -> -sqrt33)
    return (z[0], z[1], -z[2], -z[3])


def power(z, n):
    one = (Fr(1), Fr(0), Fr(0), Fr(0))
    if n < 0:
        z, n = conj(z), -n  # only used on unit vectors, where z^-1 = conj(z); asserted below
    r = one
    for _ in range(n):
        r = mul(r, z)
    return r


def to_complex(z, emb=0):
    """Float view, used ONLY for human-readable printing and a sanity cross-check, never for a decision."""
    s3, s11 = 3 ** 0.5, 11 ** 0.5
    sgn = 1 if emb == 0 else -1  # embedding 1: sqrt-11 -> -sqrt-11
    a, b, c, d = (float(t) for t in z)
    return complex(a + sgn * d * (33 ** 0.5), b * s3 + sgn * c * s11)


ZETA6 = (Fr(1, 2), Fr(1, 2), Fr(0), Fr(0))
RHO = (Fr(5, 6), Fr(0), Fr(1, 6), Fr(0))
ONE = (Fr(1), Fr(0), Fr(0), Fr(0))


def norm_parts(z):
    """(S, T) of z = z * conj(z) = S' + T' sqrt33 in Q-coordinates (rational)."""
    a, b, c, d = z
    return (a * a + 3 * b * b + 11 * c * c + 33 * d * d, 2 * (a * d + b * c))


def to_int(z):
    v = tuple(t * SCALE for t in z)
    assert all(t.denominator == 1 for t in v), z
    return tuple(int(t) for t in v)


def from_int(v):
    return tuple(Fr(t, SCALE) for t in v)


# ---------------------------------------------------------------- integer lattice tools (own HNF)


def hnf_rows(rows):
    """Row Hermite normal form (upper triangular, positive pivots, reduced above) of an integer matrix."""
    M = [list(map(int, r)) for r in rows]
    ncols = len(M[0])
    out = []
    r0 = 0
    for col in range(ncols):
        # gather rows r0.. with nonzero entry in col, reduce by gcd
        while True:
            nz = [i for i in range(r0, len(M)) if M[i][col] != 0]
            if not nz:
                break
            piv = min(nz, key=lambda i: abs(M[i][col]))
            M[r0], M[piv] = M[piv], M[r0]
            done = True
            for i in range(r0 + 1, len(M)):
                if M[i][col] != 0:
                    q = M[i][col] // M[r0][col]
                    M[i] = [x - q * y for x, y in zip(M[i], M[r0])]
                    if M[i][col] != 0:
                        done = False
            if done:
                break
        if r0 < len(M) and M[r0][col] != 0:
            if M[r0][col] < 0:
                M[r0] = [-x for x in M[r0]]
            r0 += 1
    H = [r for r in M[:r0]]
    # reduce entries above pivots
    for i in range(len(H)):
        pc = next(j for j in range(ncols) if H[i][j] != 0)
        for k in range(i):
            q = H[k][pc] // H[i][pc]
            H[k] = [x - q * y for x, y in zip(H[k], H[i])]
    return H


def member(H, v):
    """Is the integer vector v in the Z-row-span of the upper-triangular full-rank HNF H? Exact."""
    w = list(v)
    coeffs = []
    for i, row in enumerate(H):
        pc = next(j for j in range(len(row)) if row[j] != 0)
        if any(w[j] != 0 for j in range(pc)):
            return None
        if w[pc] % row[pc] != 0:
            return None
        k = w[pc] // row[pc]
        coeffs.append(k)
        w = [x - k * y for x, y in zip(w, row)]
    if any(w):
        return None
    return coeffs


def member_np(H, V):
    """Vectorised exact membership for an (n,4) int64 array V; returns a bool mask."""
    W = V.astype(np.int64).copy()
    ok = np.ones(len(W), dtype=bool)
    for row in H:
        pc = next(j for j in range(len(row)) if row[j] != 0)
        r = np.array(row, dtype=np.int64)
        ok &= (W[:, pc] % r[pc]) == 0
        k = W[:, pc] // r[pc]
        W = W - k[:, None] * r[None, :]
    ok &= np.all(W == 0, axis=1)
    return ok


# ---------------------------------------------------------------- the construction


def generators():
    gens = []
    for m in range(6):
        for n in range(-2, 3):
            g = mul(power(ZETA6, m), power(RHO, n))
            gens.append(((m, n), g))
    return gens


def build(R2_num=9, R2_den=4, verbose=True):
    """Build Lambda, U and the ball of radius^2 = R2_num/R2_den (default 9/4) in both complex embeddings."""
    info = {}
    # sanity: zeta6 has order 6, rho is a unit vector and rho^-1 = conj(rho)
    assert power(ZETA6, 6) == ONE and power(ZETA6, 3) != ONE and power(ZETA6, 2) != ONE
    assert norm_parts(RHO) == (1, 0) and mul(RHO, conj(RHO)) == ONE and norm_parts(ZETA6) == (1, 0)
    gens = generators()
    for (_, g) in gens:
        assert norm_parts(g) == (1, 0)
    gi = [to_int(g) for _, g in gens]  # raises if a generator is not in (1/36)Z^4
    info["generators"] = len(gi)
    info["distinct_generators"] = len(set(gi))
    H = hnf_rows(gi)
    info["rank"] = len(H)
    info["hnf_36Lambda"] = H
    det = 1
    for i, row in enumerate(H):
        pc = next(j for j in range(4) if row[j] != 0)
        det *= row[pc]
    info["index_of_36Lambda_in_Z4"] = det

    # ---- U: every unit vector of Lambda. Units have S = 1296: |A| <= 36, |B| <= 20 (3B^2<=1296), |C| <= 10, |D| <= 6.
    U = []
    for A in range(-36, 37):
        for B in range(-20, 21):
            r1 = 1296 - A * A - 3 * B * B
            if r1 < 0:
                continue
            for C in range(-10, 11):
                r2 = r1 - 11 * C * C
                if r2 < 0:
                    continue
                for D in range(-6, 7):
                    if r2 - 33 * D * D != 0:
                        continue
                    if A * D + B * C != 0:
                        continue
                    if member(H, (A, B, C, D)) is not None:
                        U.append((A, B, C, D))
    # exhaustive bounds are exact: 3*21^2 = 1323 > 1296, 11*11^2 = 1331 > 1296, 33*7^2 = 1617 > 1296
    info["U"] = len(U)
    Uset = set(U)
    assert all(tuple(-t for t in u) in Uset for u in U)
    genset = set(gi)
    info["U_minus_generators"] = len(Uset - genset)
    info["generators_in_U"] = len(genset & Uset)

    # ---- the ball: integer bounds derived exactly from S <= 2916:
    #  A^2 <= 2916 -> |A| <= 54; 3B^2 <= 2916 -> |B| <= 31; 11C^2 <= 2916 -> |C| <= 16; 33D^2 <= 2916 -> |D| <= 9.
    assert (R2_num, R2_den) == (9, 4)
    LIM = 2916
    assert 3 * 32 ** 2 > LIM and 3 * 31 ** 2 <= LIM and 11 * 17 ** 2 > LIM and 11 * 16 ** 2 <= LIM
    assert 33 * 10 ** 2 > LIM and 33 * 9 ** 2 <= LIM and 55 ** 2 > LIM
    Aa = np.arange(-54, 55)
    Bb = np.arange(-31, 32)
    Cc = np.arange(-16, 17)
    Dd = np.arange(-9, 10)
    G = np.stack(np.meshgrid(Aa, Bb, Cc, Dd, indexing="ij"), axis=-1).reshape(-1, 4).astype(np.int64)
    S = G[:, 0] ** 2 + 3 * G[:, 1] ** 2 + 11 * G[:, 2] ** 2 + 33 * G[:, 3] ** 2
    T = G[:, 0] * G[:, 3] + G[:, 1] * G[:, 2]
    inball = (S <= LIM) & (132 * T * T <= (LIM - S) ** 2)
    boundary = inball & (132 * T * T == (LIM - S) ** 2)
    cand = G[inball]
    mem = member_np(H, cand)
    pts = cand[mem]
    info["ball_candidates_in_Q_region"] = int(inball.sum())
    info["ball_points"] = int(len(pts))
    bmask = boundary[inball][mem]
    info["ball_points_on_boundary"] = int(bmask.sum())
    # cross-check membership with the pure-python routine on a sample
    for v in pts[:: max(1, len(pts) // 500)]:
        assert member(H, tuple(int(t) for t in v)) is not None
    rej = cand[~mem]
    for v in rej[:: max(1, len(rej) // 500)]:
        assert member(H, tuple(int(t) for t in v)) is None

    index = {tuple(int(t) for t in p): i for i, p in enumerate(pts)}
    edges = []
    for i, p in enumerate(pts):
        pt = tuple(int(t) for t in p)
        for u in U:
            q = (pt[0] + u[0], pt[1] + u[1], pt[2] + u[2], pt[3] + u[3])
            j = index.get(q)
            if j is not None and j > i:
                edges.append((i, j))
    info["edges"] = len(edges)
    if verbose:
        for k, v in info.items():
            print(f"{k}: {v}")
    return dict(info=info, H=H, U=U, pts=pts, index=index, edges=edges)


def neighbours_of(built, p):
    idx = built["index"]
    out = set()
    for u in built["U"]:
        q = tuple(a + b for a, b in zip(p, u))
        if q in idx:
            out.add(q)
    return out


# ---------------------------------------------------------------- Theorem B's residue colouring at a prime above 2


def residue_colour(v, s=1):
    """Colour in F4 = {0,1,w,w^2} (encoded 0..3 as 2-bit vectors b0 + 2 b1 meaning b0 + b1*w) of the point with
    integer coordinates v = 36*(a,b,c,d). Basis change to the integral basis {1, zeta6, theta, zeta6*theta},
    theta = (1 + sqrt-11)/2:  z = (a-b-c-d) + (2b+2d) zeta6 + (2c+2d) theta - 4d zeta6 theta.
    The ring map zeta6 -> w, theta -> w^s (s = 1 or 2 picks one of the two primes above 2), 1/odd -> 1."""
    a, b, c, d = (Fr(t, SCALE) for t in v)
    co = [a - b - c - d, 2 * b + 2 * d, 2 * c + 2 * d, -4 * d]
    bits = []
    for t in co:
        assert t.denominator % 2 == 1, ("not 2-integral", v)
        bits.append(t.numerator % 2)
    # F4 arithmetic on (x0, x1) = x0 + x1 w, w^2 = w + 1
    def fmul(p, q):
        p0, p1 = p
        q0, q1 = q
        # (p0 + p1 w)(q0 + q1 w) = p0q0 + (p0q1 + p1q0) w + p1q1 (w + 1)
        return ((p0 * q0 + p1 * q1) % 2, (p0 * q1 + p1 * q0 + p1 * q1) % 2)
    W = (0, 1)
    Ws = W if s == 1 else fmul(W, W)
    terms = [(1, 0), W, Ws, fmul(W, Ws)]
    tot = (0, 0)
    for bit, t in zip(bits, terms):
        if bit:
            tot = ((tot[0] + t[0]) % 2, (tot[1] + t[1]) % 2)
    return tot[0] + 2 * tot[1]


if __name__ == "__main__":
    B = build()
    json.dump({k: v for k, v in B["info"].items()}, sys.stdout, default=str)
    print()
