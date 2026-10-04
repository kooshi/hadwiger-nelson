#!/usr/bin/env python3
"""SEARCH-2026-10-03: quotient colourings of Gamma_q with gap colours at the origin (a structured search).

A colouring of the form c(x, y) = f(a*y - b*x) -- the kernel's projAlong (a, b) -- is proper on Gamma_q iff the projection D of the
unit circle misses 0 and f is a proper colouring of the circulant Cay(Z/q, D). Its closed neighbourhood at the origin shows the
colours f(0) and f(D). For each direction (a, b) in P^1(F_q) this script searches f exhaustively (backtracking, colour symmetry
broken by first occurrence) for a proper k-colouring of the circulant with at least `gaps` colours absent from {f(0)} u f(D), and
writes the first hit, lifted to the plane, as a certificate for tools/search_20261003_check.py.

It decides only the quotient family: a "none" here says nothing about Gamma_q's other colourings.

Usage: python3 tools/search_20261003_quotient.py q --k K --gaps G --out DIR
"""
import argparse
import json
import os
import sys


def directions(q):
    return [(1, b) for b in range(q)] + [(0, 1)]


def search(q, k, gaps, D):
    nbr = sorted(set(D))
    f = [-1] * q
    order = [0] + nbr + [z for z in range(q) if z != 0 and z not in nbr]
    best = []

    def ok(z, c):
        return all(f[(z + d) % q] != c and f[(z - d) % q] != c for d in nbr)

    def closed_colours():
        return {f[0]} | {f[d] for d in nbr if f[d] >= 0}

    def rec(i, used):
        if len(closed_colours() - {-1}) > k - gaps:
            return False
        if i == q:
            best.append(list(f))
            return True
        z = order[i]
        for c in range(min(used + 1, k)):
            if ok(z, c):
                f[z] = c
                if rec(i + 1, max(used, c + 1)):
                    return True
                f[z] = -1
        return False

    rec(0, 0)
    return best[0] if best else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("q", type=int)
    ap.add_argument("--k", type=int, required=True)
    ap.add_argument("--gaps", type=int, required=True)
    ap.add_argument("--out", required=True)
    a = ap.parse_args()
    q = a.q
    U = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    hits = 0
    for (da, db) in directions(q):
        D = [(da * y - db * x) % q for (x, y) in U]
        if 0 in D:
            print(f"direction ({da}, {db}): the projection meets the circle's kernel (0 in D) -- no quotient colouring")
            continue
        f = search(q, a.k, a.gaps, D)
        if f is None:
            print(f"direction ({da}, {db}): |D| = {len(set(D))}: no proper {a.k}-colouring of the circulant with {a.gaps} gap(s) at 0")
            continue
        hits += 1
        col = [f[(da * y - db * x) % q] for x in range(q) for y in range(q)]
        cert = {"graph": "gamma", "n": q, "k": a.k, "gaps_claimed": a.gaps, "at_vertex": 0, "colouring": col,
                "found_by": f"tools/search_20261003_quotient.py: c(x, y) = f({da}*y - {db}*x), f = {f}"}
        os.makedirs(a.out, exist_ok=True)
        path = os.path.join(a.out, f"gamma{q}-k{a.k}-g{a.gaps}-quot-{da}-{db}.colouring.json")
        with open(path, "w") as fh:
            json.dump(cert, fh)
        print(f"direction ({da}, {db}): |D| = {len(set(D))}: HIT f = {f} -> {path}")
    print(f"QUOTIENT SUMMARY q={q} k={a.k} gaps={a.gaps}: {hits} direction(s) with a hit")


if __name__ == "__main__":
    main()
