#!/usr/bin/env python3
"""FS-73 V2 (independent verifier): unit vectors of a quadratic-field lattice, from its key alone.

A key `D|r1;r2;r3;r4` over d names the lattice Λ = ℤ-span of the rows r_i in (a, b, c, e) coordinates, the point (a, b, c, e)
standing for ((a + b√d)/D, (c + e√d)/D) ∈ ℚ(√d)².  It is a unit vector iff

    a² + d b² + c² + d e² = D²   and   a b + c e = 0

(the rational and √d parts of |x|² = 1; √d irrational).  This module enumerates EVERY integer solution of the two equations
by exhaustive search over (b, e) and then a (c is determined up to sign), and keeps those in Λ.  Integer arithmetic only.

Also: the Hermite normal form of span U, whether some four unit vectors form a ℤ-basis of span U (and of Λ), and every unit
vector's integer coordinates in a chosen basis.  Written for the verification of FS-73 P3b without reading any other FS-73 tool.
"""
from __future__ import annotations

import itertools
import json
import math
import sys
from fractions import Fraction


def parse_key(key: str) -> tuple[int, list[list[int]]]:
    den, rows = key.split("|")
    return int(den), [[int(x) for x in r.split(",")] for r in rows.split(";")]


def all_solutions(d: int, D: int) -> list[tuple[int, int, int, int]]:
    """Every integer (a, b, c, e) with a² + d b² + c² + d e² = D² and a b + c e = 0 (exhaustive)."""
    N = D * D
    out = []
    bmax = math.isqrt(N // d)
    for b in range(-bmax, bmax + 1):
        for e in range(-bmax, bmax + 1):
            rest = N - d * (b * b + e * e)
            if rest < 0:
                continue
            amax = math.isqrt(rest)
            for a in range(-amax, amax + 1):
                c2 = rest - a * a
                c = math.isqrt(c2)
                if c * c != c2:
                    continue
                for cc in {c, -c}:
                    if a * b + cc * e == 0:
                        out.append((a, b, cc, e))
    return sorted(set(out))


def det(M: list[list[Fraction]]) -> Fraction:
    M = [list(map(Fraction, r)) for r in M]
    n = len(M)
    s = Fraction(1)
    for i in range(n):
        p = next((r for r in range(i, n) if M[r][i] != 0), None)
        if p is None:
            return Fraction(0)
        if p != i:
            M[i], M[p] = M[p], M[i]
            s = -s
        s *= M[i][i]
        for r in range(i + 1, n):
            f = M[r][i] / M[i][i]
            if f:
                M[r] = [M[r][k] - f * M[i][k] for k in range(n)]
    return s


def solve(B: list[list[int]], v: list[int]) -> list[Fraction]:
    """x with Σ x_j B[j] = v (B rows), exact."""
    n = len(B)
    # columns of the system are the rows of B
    A = [[Fraction(B[j][i]) for j in range(n)] + [Fraction(v[i])] for i in range(n)]
    for i in range(n):
        p = next(r for r in range(i, n) if A[r][i] != 0)
        A[i], A[p] = A[p], A[i]
        piv = A[i][i]
        A[i] = [x / piv for x in A[i]]
        for r in range(n):
            if r != i and A[r][i] != 0:
                f = A[r][i]
                A[r] = [A[r][k] - f * A[i][k] for k in range(n + 1)]
    return [A[i][n] for i in range(n)]


def hnf(vectors: list[list[int]]) -> list[list[int]]:
    """Row Hermite normal form (a ℤ-basis of the row span), integer Euclid on columns."""
    rows = [list(v) for v in vectors if any(v)]
    n = len(rows[0])
    basis = []
    col = 0
    while rows and col < n:
        rows = [r for r in rows if any(r)]
        nz = [r for r in rows if r[col] != 0]
        if not nz:
            col += 1
            continue
        while len([r for r in rows if r[col] != 0]) > 1:
            nz = sorted([r for r in rows if r[col] != 0], key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for k in range(n):
                    r[k] -= q * p[k]
            rows = [r for r in rows if any(r)]
        p = next(r for r in rows if r[col] != 0)
        if p[col] < 0:
            p[:] = [-x for x in p]
        basis.append(p)
        rows = [r for r in rows if r is not p]
        col += 1
    return basis


def in_lattice(B: list[list[int]], v) -> bool:
    return all(x.denominator == 1 for x in solve(B, list(v)))


def analyse(d: int, key: str, want_unit_basis: bool = True) -> dict:
    D, rows = parse_key(key)
    sols = all_solutions(d, D)
    keyB = hnf(rows)
    assert len(keyB) == 4, "key rows must span rank 4"
    U = [u for u in sols if in_lattice(keyB, u)]
    assert set(U) == {tuple(-x for x in u) for u in U}, "U = -U fails"
    spanB = hnf([list(u) for u in U])
    info = {
        "d": d, "key": key, "D": D,
        "n_solutions_Z4": len(sols), "n_units_in_key_lattice": len(U),
        "span_rank": len(spanB),
        "index_span_in_key": None, "index_key_in_Z4": abs(det(keyB)),
        "span_hnf": spanB, "units": [list(u) for u in U],
    }
    if len(spanB) == 4:
        info["index_span_in_key"] = abs(det(spanB)) / abs(det(keyB))
    # a basis of span U made of unit vectors?
    pos = [u for u in U if u > tuple(-x for x in u)]
    info["n_pairs"] = len(pos)
    unit_bases = []
    if want_unit_basis and len(spanB) == 4:
        dspan = abs(det(spanB))
        for quad in itertools.combinations(range(len(pos)), 4):
            M = [list(pos[i]) for i in quad]
            if abs(det(M)) == dspan:
                unit_bases.append(quad)
                if len(unit_bases) >= 2000:
                    break
    info["n_unit_bases_found"] = len(unit_bases)
    info["pos"] = [list(u) for u in pos]
    info["unit_bases_sample"] = unit_bases[:20]
    return info


def coords(B: list[list[int]], U: list[list[int]]) -> list[list[int]]:
    out = []
    for u in U:
        x = solve(B, u)
        assert all(t.denominator == 1 for t in x), (u, x)
        out.append([int(t) for t in x])
    return out


def main() -> None:
    d = int(sys.argv[1])
    key = sys.argv[2]
    info = analyse(d, key)
    info_s = {k: (str(v) if isinstance(v, Fraction) else v) for k, v in info.items()}
    small = {k: v for k, v in info_s.items() if k not in ("units", "pos", "span_hnf")}
    print(json.dumps(small, indent=1))
    print("span HNF:", info["span_hnf"])
    if len(sys.argv) > 3:
        with open(sys.argv[3], "w") as f:
            json.dump(info_s, f)


if __name__ == "__main__":
    main()
