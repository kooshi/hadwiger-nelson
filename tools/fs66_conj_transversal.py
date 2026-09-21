#!/usr/bin/env python3
"""FS-66 conjecture note, experiment E1b: does G_1(p) have a spanning subgraph K with alpha(K) = alpha(G_1) in which
every single-direction p-cycle is broken (at least one edge of each deleted)?  Every subgraph of G_1 that lifts to
Z/p^2 -- let alone to Z_p -- with distinct residues is contained in such a K (single-direction cycles have holonomy 1).
Constraint generation: master = delete exactly one edge per cycle, subject to no-good cuts 'not all induced edges of T
are deleted' for every (alpha+1)-set T found; oracle = MILP for alpha(G_1 - E').  Exact (HiGHS); ends with a transversal
(re-verified) or INFEASIBLE.  Deleting MORE edges only raises alpha, so 'exactly one' loses nothing.
Usage: fs66_conj_transversal.py P [MAXIT]"""
import sys
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds
from scipy.sparse import lil_matrix, csr_matrix

def plane(p):
    S = [(a, b) for a in range(p) for b in range(p) if (a*a + b*b) % p == 1]
    V = [(x, y) for x in range(p) for y in range(p)]
    idx = {v: i for i, v in enumerate(V)}
    E = set()
    for (x, y) in V:
        for (a, b) in S:
            u, v = idx[(x, y)], idx[((x+a) % p, (y+b) % p)]
            E.add((min(u, v), max(u, v)))
    return V, idx, sorted(E), S

def max_indep(n, E):
    A = lil_matrix((len(E), n))
    for r, (u, v) in enumerate(E):
        A[r, u] = 1; A[r, v] = 1
    res = milp(c=-np.ones(n), constraints=LinearConstraint(csr_matrix(A), -np.inf, 1), integrality=np.ones(n), bounds=Bounds(0, 1))
    return [i for i in range(n) if res.x[i] > 0.5]

p = int(sys.argv[1]); maxit = int(sys.argv[2]) if len(sys.argv) > 2 else 3000
V, idx, E, S = plane(p); n = len(V); eid = {e: k for k, e in enumerate(E)}
dirs = []
for (a, b) in S:
    if ((-a) % p, (-b) % p) not in dirs: dirs.append((a, b))
cyc = []
for (a, b) in dirs:
    seen = set()
    for v in V:
        if v in seen: continue
        line = [((v[0] + j*a) % p, (v[1] + j*b) % p) for j in range(p)]; seen.update(line)
        li = [idx[q] for q in line]
        cyc.append([eid[(min(li[j], li[(j+1) % p]), max(li[j], li[(j+1) % p]))] for j in range(p)])
a0 = len(max_indep(n, E)); print(f"p={p}: alpha(G_1)={a0}, {len(cyc)} single-direction cycles", flush=True)
m = len(E); rows = []; lo = []; hi = []
for c in cyc:
    r = np.zeros(m); r[c] = 1; rows.append(r); lo.append(1); hi.append(1)
Eset = set(E)
# Seed cuts (added after the first run stalled at ~1,850 lazily found cuts): every maximum independent set J plus one outside
# vertex v is an (alpha+1)-set whose induced edges are exactly v's edges into J; none of those edge sets may be wholly deleted.
# Maximum independent sets are enumerated as the orbit of one under translations and the 2(p+1) linear isometries.
S1 = [(a, b) for a in range(p) for b in range(p) if (a*a + b*b) % p == 1]
J0 = frozenset(max_indep(n, E)); assert len(J0) == a0
def img(J, s, conj, t):
    out = []
    for k in J:
        x, y = V[k]
        if conj: y = (-y) % p
        x, y = (s[0]*x - s[1]*y) % p, (s[1]*x + s[0]*y) % p
        out.append(idx[((x + t[0]) % p, (y + t[1]) % p)])
    return frozenset(out)
orbit = {img(J0, s, c, t) for s in S1 for c in (0, 1) for t in V}
adj = {k: set() for k in range(n)}
for (u, v) in E: adj[u].add(v); adj[v].add(u)
seeded = set()
for J in orbit:
    for v in range(n):
        if v in J: continue
        ind = frozenset(eid[(min(u, v), max(u, v))] for u in adj[v] & J)
        if ind and ind not in seeded:
            seeded.add(ind); r = np.zeros(m); r[list(ind)] = 1; rows.append(r); lo.append(0); hi.append(len(ind) - 1)
print(f"seeded {len(seeded)} cuts from {len(orbit)} maximum independent sets (orbit of one; sizes of cut supports: {sorted(set(len(c) for c in seeded))})", flush=True)
for it in range(maxit):
    res = milp(c=np.zeros(m), constraints=LinearConstraint(np.array(rows), lo, hi), integrality=np.ones(m), bounds=Bounds(0, 1))
    if res.x is None:
        print(f"INFEASIBLE after {it} no-good cuts: every way of breaking all single-direction cycles raises alpha above {a0}"); sys.exit(0)
    drop = {E[k] for k in range(m) if res.x[k] > 0.5}
    T = max_indep(n, [e for e in E if e not in drop])
    if len(T) <= a0:
        K = [e for e in E if e not in drop]
        assert len(max_indep(n, K)) == a0
        print(f"FOUND after {it} cuts: a transversal E' ({len(drop)} edges) with alpha(G_1 - E') = {a0}")
        print("deleted edges:", sorted((V[u], V[v]) for (u, v) in drop)); sys.exit(0)
    ind = [eid[(min(u, v), max(u, v))] for u in T for v in T if u < v and (min(u, v), max(u, v)) in Eset]
    r = np.zeros(m); r[ind] = 1; rows.append(r); lo.append(0); hi.append(len(ind) - 1)
    if it % 50 == 0: print(f"  it {it}: |T|={len(T)}, induced edges {len(ind)}", flush=True)
print("UNDECIDED at the iteration cap")
