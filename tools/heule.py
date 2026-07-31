#!/usr/bin/env python3
"""Read a published unit-distance graph in Mathematica coordinates into this project's exact field.

UNTRUSTED, like everything in `tools/`. It converts a vertex list of the form

    {-1/2, Sqrt[3]/2}
    {(1 + Sqrt[33])/8, 3/(2*Sqrt[3])}

into integer coordinates over the multiquadratic field Q(sqrt3, sqrt5, sqrt7, sqrt11) that M02's
tower already knows how to evaluate, and re-derives the edge list from scratch. Every claim it
makes is re-checked inside Lean against the same arithmetic; a bug here can only produce a graph
Lean refuses to certify.

The provenance of the *coordinates* is Marijn Heule's CNP-SAT repository, and that provenance is
worth nothing to the proof: the theorem quantifies over the points as written, so a reader needs
only the listed coordinates and the checks in Lean, never the search that found them.

Usage:  tools/heule.py build/m07/heule/510.vtx build/m07/heule/510.edge -o tools/heule510.json
"""

from __future__ import annotations

import argparse
import ast
import json
import sys
from fractions import Fraction as F
from math import isqrt

PRIMES = [3, 5, 7, 11]
N = 1 << len(PRIMES)

SCALE = [[
    __import__('functools').reduce(lambda a, b: a * b,
        [PRIMES[k] for k in range(len(PRIMES)) if (i >> k) & 1 and (j >> k) & 1], 1)
    for j in range(N)] for i in range(N)]

ZERO = (F(0),) * N
ONE = (F(1),) + (F(0),) * (N - 1)


def rat(q) -> tuple:
    q = F(q)
    return (q,) + (F(0),) * (N - 1)


def add(a, b): return tuple(x + y for x, y in zip(a, b))
def sub(a, b): return tuple(x - y for x, y in zip(a, b))
def neg(a):    return tuple(-x for x in a)


def mul(a, b):
    out = [F(0)] * N
    for i, ai in enumerate(a):
        if ai:
            for j, bj in enumerate(b):
                if bj:
                    out[i ^ j] += ai * bj * SCALE[i][j]
    return tuple(out)


def inv(a):
    """Field inverse by solving the 16x16 multiplication-by-`a` system over Q.

    A multiquadratic field is a Q-algebra with a basis, so "divide" is one linear solve. Done this
    way rather than by iterated conjugation because a 16x16 exact solve is instant and has no case
    analysis to get wrong.
    """
    m = [[F(0)] * (N + 1) for _ in range(N)]
    for j in range(N):
        col = mul(a, tuple(F(1) if t == j else F(0) for t in range(N)))
        for i in range(N):
            m[i][j] = col[i]
    m[0][N] = F(1)
    for c in range(N):                                   # Gauss-Jordan, exact
        p = next((r for r in range(c, N) if m[r][c]), None)
        if p is None:
            raise ZeroDivisionError("not invertible")
        m[c], m[p] = m[p], m[c]
        d = m[c][c]
        m[c] = [x / d for x in m[c]]
        for r in range(N):
            if r != c and m[r][c]:
                f = m[r][c]
                m[r] = [x - f * y for x, y in zip(m[r], m[c])]
    return tuple(m[i][N] for i in range(N))


def sqrt_of(q: F):
    """sqrt of a rational, as a field element -- or a failure naming the radical we cannot hold."""
    n, d = q.numerator, q.denominator
    m = n * d                                   # sqrt(n/d) = sqrt(n*d)/d
    square, free = 1, 1
    x = m
    for p in range(2, isqrt(m) + 1):
        e = 0
        while x % p == 0:
            x //= p
            e += 1
        if e:
            square *= p ** (e // 2)
            if e % 2:
                free *= p
    free *= x
    square *= isqrt(m // (free * (m // free)))  # no-op guard; `free` is squarefree by construction
    mask = 0
    rest = free
    for k, p in enumerate(PRIMES):
        if rest % p == 0:
            mask |= 1 << k
            rest //= p
    if rest != 1:
        raise ValueError(f"sqrt({q}) needs sqrt({rest}), outside Q(sqrt{',sqrt'.join(map(str, PRIMES))})")
    root = isqrt(m // free)
    return tuple(F(root, d) if i == mask else F(0) for i in range(N))


def evaluate(node):
    """Evaluate a parsed Mathematica-flavoured coordinate expression into a field element."""
    if isinstance(node, ast.Constant):
        return rat(node.value)
    if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.USub):
        return neg(evaluate(node.operand))
    if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.UAdd):
        return evaluate(node.operand)
    if isinstance(node, ast.BinOp):
        a, b = evaluate(node.left), evaluate(node.right)
        if isinstance(node.op, ast.Add):
            return add(a, b)
        if isinstance(node.op, ast.Sub):
            return sub(a, b)
        if isinstance(node.op, ast.Mult):
            return mul(a, b)
        if isinstance(node.op, ast.Div):
            return mul(a, inv(b))
        raise ValueError(f"operator {ast.dump(node.op)} not in the coordinate language")
    if isinstance(node, ast.Call) and getattr(node.func, "id", None) == "Sqrt":
        arg = evaluate(node.args[0])
        if any(arg[i] for i in range(1, N)):
            raise ValueError("nested radical: Sqrt of a non-rational")
        return sqrt_of(arg[0])
    raise ValueError(f"unexpected syntax: {ast.dump(node)}")


def read_vtx(path):
    pts = []
    for line in open(path):
        line = line.strip()
        if not line:
            continue
        src = line.replace("{", "(").replace("}", ")").replace("[", "(").replace("]", ")")
        tup = ast.parse(src, mode="eval").body
        assert isinstance(tup, ast.Tuple) and len(tup.elts) == 2, line
        pts.append(tuple(evaluate(e) for e in tup.elts))
    return pts


def read_edge(path):
    out = []
    for line in open(path):
        if line.startswith("e"):
            a, b = line.split()[1:3]
            out.append(tuple(sorted((int(a) - 1, int(b) - 1))))
    return sorted(set(out))


def normsq(p):
    return add(mul(p[0], p[0]), mul(p[1], p[1]))


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("vtx")
    ap.add_argument("edge")
    ap.add_argument("-o", "--out")
    args = ap.parse_args()

    pts = read_vtx(args.vtx)
    listed = read_edge(args.edge)
    print(f"vertices       {len(pts)}", file=sys.stderr)
    print(f"listed edges   {len(listed)}", file=sys.stderr)

    dup = len({p for p in pts})
    print(f"distinct       {dup}" + ("" if dup == len(pts) else "   <-- REPEATED POINT"),
          file=sys.stderr)

    bad = [e for e in listed if normsq((sub(pts[e[0]][0], pts[e[1]][0]),
                                        sub(pts[e[0]][1], pts[e[1]][1]))) != ONE]
    print(f"non-unit edges {len(bad)}" + ("" if not bad else f"   {bad[:5]}"), file=sys.stderr)
    if bad:
        sys.exit("the listed edge set is not a unit-distance graph over this field")

    # Independently re-derived: every unit-distance pair among the points, not just the listed ones.
    all_edges = [(i, j) for i in range(len(pts)) for j in range(i + 1, len(pts))
                 if normsq((sub(pts[i][0], pts[j][0]), sub(pts[i][1], pts[j][1]))) == ONE]
    print(f"re-derived     {len(all_edges)} unit-distance pairs "
          f"({len(set(all_edges) - set(listed))} the file omits)", file=sys.stderr)

    if args.out:
        from math import gcd
        L = 1
        for p in pts:
            for comp in p:
                for f in comp:
                    L = L * f.denominator // gcd(L, f.denominator)
        coords = [[[int(f * L) for f in comp] for comp in p] for p in pts]
        json.dump({"names": [str(i) for i in range(len(pts))], "denom": L, "coords": coords,
                   "edges": [list(e) for e in listed], "primes": PRIMES},
                  open(args.out, "w"))
        print(f"common denominator {L}", file=sys.stderr)
        print(f"wrote {args.out}", file=sys.stderr)


if __name__ == "__main__":
    main()
