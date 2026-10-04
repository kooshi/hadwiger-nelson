#!/usr/bin/env python3
"""SEARCH-2026-10-03 encoder: proper k-colourings with gap colours at a vertex, as CNF, solved and decoded.

The Searcher's run of 2026-10-03 (plans/SEARCH-2026-10-03.md). This file is the SEARCH side: it builds each graph, writes a CNF,
runs a solver, and decodes a model into a certificate JSON. It is NOT the checker: tools/search_20261003_check.py rebuilds every
graph from its definition by a different route and checks the certificate; for an UNSAT verdict the checker regenerates the CNF on
its own and compares, and cake_lpr checks cadical's LRAT proof.

Graphs (vertex index in brackets):
  gamma q    Gamma_q = UD(F_q, 2), q prime: (x, y) in F_q^2, edge iff the difference (a, b) has a^2 + b^2 = 1 (mod q)   [x*q + y]
  zmod n     UD(Z/n, 2): (x, y) in (Z/n)^2, edge iff the difference has a^2 + b^2 = 1 (mod n)                       [x*n + y]
  uq m       U_Q = Cay(F_{Q^2}, mu_{Q+1}), Q = 2^m: F_{Q^2} = F_2[x]/(p) with p the primitive polynomial PRIM[2m];
             edge iff the sum (= difference) is a (Q+1)-st root of unity                                             [the element's bits]

Conditions at the origin (vertex 0; every graph here is vertex-transitive by translation, so "some vertex" is "the origin"):
  gaps g     at least g colours are absent from the closed neighbourhood N[0] (g = 0, plain only: colourability alone)

Clause order (fixed, so that the checker's regenerated CNF is byte-identical and an LRAT proof's clause ids carry over): per vertex
  v ascending, its at-least-one clause then its at-most-one pairs (c < d); then the edges (v, w), v < w, lexicographic, colours c
  ascending inside; then the condition's clauses in the order written below.

Encodings:
  plain      x[v][c] exactly-one per vertex, edge clauses; selectors y[c] -> colour c absent from N[0]; at least g selectors.
             Uses only the translation symmetry (to put the vertex at 0).
  sb         symmetry-broken (RUNNING.md's checklist), sound by the argument in plans/SEARCH-2026-10-03.md stage 2:
             C(0) = 0; the gap colours are the top g colours k-g..k-1 (absent from N[0]); a fixed neighbour u0 of 0 gets colour 1
             (the stabiliser of 0 is transitive on N(0): rotation by the norm-one group mu_{q+1} for Gamma_q, multiplication by
             mu_{Q+1} for U_Q); and, if g >= 2, precedence over the gap colours only (colour c > k-g at v only if c-1 appears at an
             earlier vertex) -- the gap colours are interchangeable and no pinned vertex carries one.

Usage:
  python3 tools/search_20261003_encode.py <graph> <param> --k K --gaps G --enc {plain,sb} --out DIR [--timeout S] [--solver cadical|kissat]
    writes DIR/<tag>.cnf, DIR/<tag>.meta.json; runs the solver (cadical with an LRAT proof DIR/<tag>.lrat; kissat as a second refuter);
    on SAT writes DIR/<tag>.colouring.json; prints one RESULT line; exit 0 on a verdict, 3 on UNKNOWN, 2 on a solver error.
"""
import argparse
import json
import os
import subprocess
import sys
import time

CADICAL = os.path.expanduser("~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical")
KISSAT = "/usr/bin/kissat"

# Primitive polynomials over F_2 (bit i = coefficient of x^i); primitivity is checked below by the period of x.
PRIM = {2: 0b111, 4: 0b10011, 6: 0b1000011, 8: 0b100011101, 10: 0b10000001001}


def units_mod(n):
    return [(a, b) for a in range(n) for b in range(n) if (a * a + b * b) % n == 1]


def graph_grid(n):
    """(Z/n)^2 with unit-quadrance adjacency; returns (N, adjacency lists, unit list)."""
    U = units_mod(n)
    N = n * n
    adj = [sorted(((x + a) % n) * n + (y + b) % n for (a, b) in U) for x in range(n) for y in range(n)]
    return N, adj, U


def graph_uq(m):
    deg = 2 * m
    p = PRIM[deg]
    size = 1 << deg
    exp = [0] * (size - 1)
    e = 1
    for i in range(size - 1):
        exp[i] = e
        e <<= 1
        if e & size:
            e ^= p
    assert e == 1 and len(set(exp)) == size - 1, "polynomial is not primitive"
    Q = 1 << m
    mu = sorted({exp[((Q - 1) * j) % (size - 1)] for j in range(Q + 1)})
    assert len(mu) == Q + 1
    adj = [sorted(v ^ u for u in mu) for v in range(size)]
    return size, adj, mu, p


def build(graph, param):
    if graph in ("gamma", "zmod"):
        N, adj, U = graph_grid(param)
        info = {"graph": graph, "n": param, "units": len(U)}
        u0 = 1 * param + 0 if (1, 0) in U else adj[0][0]   # the neighbour (1, 0)
        return N, adj, info, u0
    if graph == "uq":
        N, adj, mu, p = graph_uq(param)
        info = {"graph": "uq", "m": param, "Q": 1 << param, "poly": p, "mu": mu}
        return N, adj, info, 1     # the neighbour 1 (1 is in mu)
    raise SystemExit(f"unknown graph {graph}")


def encode(N, adj, k, gaps, enc, u0):
    var = lambda v, c: v * k + c + 1
    nv = N * k
    clauses = []
    for v in range(N):
        clauses.append([var(v, c) for c in range(k)])
        for c in range(k):
            for d in range(c + 1, k):
                clauses.append([-var(v, c), -var(v, d)])
    for v in range(N):
        for w in adj[v]:
            if v < w:
                for c in range(k):
                    clauses.append([-var(v, c), -var(w, c)])
    closed0 = [0] + list(adj[0])
    if enc == "plain" and gaps == 0:
        pass                      # colourability alone: no condition at the origin
    elif enc == "plain":
        y = [nv + 1 + c for c in range(k)]
        nv += k
        for c in range(k):
            for u in closed0:
                clauses.append([-y[c], -var(u, c)])
        if gaps == 1:
            clauses.append(list(y))
        elif gaps == 2:
            for c in range(k):
                clauses.append([y[d] for d in range(k) if d != c])
        else:
            raise SystemExit("gaps must be 1 or 2")
    elif enc == "sb":
        clauses.append([var(0, 0)])
        assert u0 in adj[0]
        clauses.append([var(u0, 1)])
        top = list(range(k - gaps, k))
        assert 1 < k - gaps, "colour 1 must not be a gap colour"
        for c in top:
            for u in closed0:
                clauses.append([-var(u, c)])
        for c in top[1:]:
            for v in range(N):
                clauses.append([-var(v, c)] + [var(u, c - 1) for u in range(v)])
    else:
        raise SystemExit(f"unknown encoding {enc}")
    return nv, clauses


def write_cnf(path, nv, clauses):
    with open(path, "w") as f:
        f.write(f"p cnf {nv} {len(clauses)}\n")
        for cl in clauses:
            f.write(" ".join(map(str, cl)) + " 0\n")


def run_solver(solver, cnf, lrat, timeout, log):
    if solver == "cadical":
        cmd = [CADICAL, "--lrat=true", "--binary=false", "-t", str(timeout), cnf, lrat]
    else:
        cmd = [KISSAT, f"--time={timeout}", cnf]
    t0 = time.time()
    with open(log, "w") as lf:
        r = subprocess.run(cmd, stdout=lf, stderr=subprocess.STDOUT)
    wall = time.time() - t0
    status, model = None, []
    with open(log) as lf:
        for line in lf:
            if line.startswith("s "):
                status = line[2:].strip()
            elif line.startswith("v "):
                model += [int(t) for t in line[2:].split()]
    return r.returncode, status, model, wall, cmd


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("graph")
    ap.add_argument("param", type=int)
    ap.add_argument("--k", type=int, required=True)
    ap.add_argument("--gaps", type=int, required=True)
    ap.add_argument("--enc", choices=["plain", "sb"], required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--timeout", type=int, default=600)
    ap.add_argument("--solver", choices=["cadical", "kissat"], default="cadical")
    ap.add_argument("--cnf-only", action="store_true", help="write the CNF and meta, solve nothing")
    ap.add_argument("--decode", metavar="LOG", help="decode a model from a solver log (v lines) for this formula; solve nothing")
    a = ap.parse_args()
    os.makedirs(a.out, exist_ok=True)
    N, adj, info, u0 = build(a.graph, a.param)
    nv, clauses = encode(N, adj, a.k, a.gaps, a.enc, u0)
    tag = f"{a.graph}{a.param}-k{a.k}-g{a.gaps}-{a.enc}"
    cnf = os.path.join(a.out, tag + ".cnf")
    write_cnf(cnf, nv, clauses)
    meta = dict(info, k=a.k, gaps=a.gaps, enc=a.enc, vertices=N, degree=len(adj[0]), vars=nv, clauses=len(clauses), u0=u0,
                vertex_index="x*n+y" if a.graph != "uq" else "element bits in F_2[x]/(poly)")
    with open(os.path.join(a.out, tag + ".meta.json"), "w") as f:
        json.dump(meta, f, indent=1)
    if a.cnf_only:
        print(f"CNF {cnf} vars={nv} clauses={len(clauses)}")
        sys.exit(0)
    lrat = os.path.join(a.out, tag + ".lrat")
    log = os.path.join(a.out, tag + f".{a.solver}.log")
    if a.decode:
        status, model, rc, wall, cmd = None, [], 0, 0.0, ["(decoded from)", a.decode]
        for ln in open(a.decode):
            if ln.startswith("s "):
                status = ln[2:].strip()
            elif ln.startswith("v "):
                model += [int(t) for t in ln[2:].split()]
    else:
        rc, status, model, wall, cmd = run_solver(a.solver, cnf, lrat, a.timeout, log)
    if a.solver == "kissat" or status != "UNSATISFIABLE":
        if os.path.exists(lrat):
            os.remove(lrat)
    line = f"RESULT {tag} solver={a.solver} status={status} rc={rc} wall={wall:.2f}s vars={nv} clauses={len(clauses)}"
    if status == "SATISFIABLE":
        pos = set(l for l in model if l > 0)
        col = []
        for v in range(N):
            cs = [c for c in range(a.k) if v * a.k + c + 1 in pos]
            if len(cs) != 1:
                print(line + f" DECODE-ERROR vertex {v} colours {cs}")
                sys.exit(2)
            col.append(cs[0])
        cert = dict(info, k=a.k, gaps_claimed=a.gaps, at_vertex=0, colouring=col,
                    found_by=" ".join(cmd), encoding=a.enc, cnf=os.path.basename(cnf))
        with open(os.path.join(a.out, tag + ".colouring.json"), "w") as f:
            json.dump(cert, f)
        print(line)
        sys.exit(0)
    if status == "UNSATISFIABLE":
        print(line + (f" lrat={lrat}" if a.solver == "cadical" else ""))
        sys.exit(0)
    print(line + " UNKNOWN")
    sys.exit(3 if status in (None, "UNKNOWN") and rc == 0 else 2)


if __name__ == "__main__":
    main()
