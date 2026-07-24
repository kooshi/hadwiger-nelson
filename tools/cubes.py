#!/usr/bin/env python3
"""Colour-cube split: turn one 4-colourability instance into many independent ones.

Soundness (proved in Lean, not here): a proper colouring of G induces a colouring of any fixed
vertex list W, so if every cube -- every function W -> Fin 4 -- yields an unsatisfiable pinned
instance, G is not 4-colourable. Plus one symmetry reduction: the maximum clique of a plane
unit-distance graph is a triangle (four mutually unit-distant points would be a regular
tetrahedron), and permuting colours lets us fix one unit triangle to 0,1,2.

Emits one DIMACS per cube. Untrusted: Lean re-derives the cover and re-checks each certificate.
"""

import json, os, sys, itertools
from collections import defaultdict

K = 4
var = lambda v, c: v * K + c + 1


def load(path):
    d = json.load(open(path))
    return d["n"], [tuple(e) for e in d["edges"]]


def adjacency(n, E):
    adj = defaultdict(set)
    for u, w in E:
        adj[u].add(w)
        adj[w].add(u)
    return adj


def find_triangle(adj):
    for u in sorted(adj, key=lambda x: -len(adj[x])):
        for w in adj[u]:
            common = adj[u] & adj[w]
            if common:
                return tuple(sorted((u, w, min(common))))
    return None


def pick_split(adj, avoid, m):
    """Highest-degree vertices outside `avoid`, as extra cube coordinates."""
    cands = sorted((v for v in adj if v not in avoid), key=lambda v: -len(adj[v]))
    return cands[:m]


def emit(path, n, E, pins):
    with open(path, "w") as f:
        cls = []
        for v in range(n):
            cls.append([var(v, c) for c in range(K)])
        for (u, w) in E:
            for c in range(K):
                cls.append([-var(u, c), -var(w, c)])
        for (v, c) in pins:
            cls.append([var(v, c)])
        f.write(f"p cnf {n*K} {len(cls)}\n")
        for c in cls:
            f.write(" ".join(map(str, c)) + " 0\n")


if __name__ == "__main__":
    graph, outdir, m = sys.argv[1], sys.argv[2], int(sys.argv[3])
    n, E = load(graph)
    adj = adjacency(n, E)
    tri = find_triangle(adj)
    assert tri, "no unit triangle found -- symmetry reduction unavailable"
    base = [(tri[0], 0), (tri[1], 1), (tri[2], 2)]
    W = pick_split(adj, set(tri), m)

    os.makedirs(outdir, exist_ok=True)
    index = []
    for i, phi in enumerate(itertools.product(range(K), repeat=len(W))):
        pins = base + [(w, c) for w, c in zip(W, phi)]
        emit(f"{outdir}/cube{i:04d}.cnf", n, E, pins)
        index.append({"id": i, "pins": pins})
    json.dump({"triangle": tri, "split": W, "cubes": index},
              open(f"{outdir}/index.json", "w"), indent=1)
    print(f"triangle {tri}   split {W}   cubes {len(index)}", file=sys.stderr)
