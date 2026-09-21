#!/usr/bin/env python3
"""FS-66 conjecture note, experiment E1: is every edge of G_1(p) = UD(F_p, 2) alpha-critical, and what does
deleting one edge per single-direction p-cycle (the only cycles that fail to lift) do to alpha?
Exact (MILP, HiGHS); each reported set is re-verified from the definition.  Usage: fs66_conj_edgecrit.py P [NTRANS]"""
import sys, random
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

def alpha(n, E):
    A = lil_matrix((len(E), n))
    for r, (u, v) in enumerate(E):
        A[r, u] = 1; A[r, v] = 1
    res = milp(c=-np.ones(n), constraints=LinearConstraint(csr_matrix(A), -np.inf, 1), integrality=np.ones(n), bounds=Bounds(0, 1))
    I = [i for i in range(n) if res.x[i] > 0.5]
    Es = set(E)
    assert all((min(u, v), max(u, v)) not in Es for u in I for v in I if u < v), "not independent"
    return len(I), I

def lines(p, V, idx, S):
    dirs = []
    for (a, b) in S:
        if ((-a) % p, (-b) % p) not in dirs: dirs.append((a, b))
    out = []
    for (a, b) in dirs:
        seen = set()
        for v in V:
            if v in seen: continue
            line = [((v[0] + j*a) % p, (v[1] + j*b) % p) for j in range(p)]
            seen.update(line); out.append([idx[q] for q in line])
    return out

p = int(sys.argv[1]); ntrans = int(sys.argv[2]) if len(sys.argv) > 2 else 5
V, idx, E, S = plane(p); n = len(V)
a0, _ = alpha(n, E); print(f"p={p}: n={n}, |E|={len(E)}, alpha(G_1) = {a0}")
a1, _ = alpha(n, E[1:]); print(f"alpha(G_1 - one edge) = {a1}   (G_1 is edge-transitive, so this is every edge)")
L = lines(p, V, idx, S); print(f"single-direction {p}-cycles: {len(L)} (they partition the edge set: {len(L)*p} = {len(E)})")
rng = random.Random(1)
for t in range(ntrans):
    drop = set()
    for line in L:
        j = rng.randrange(p); u, v = line[j], line[(j+1) % p]; drop.add((min(u, v), max(u, v)))
    at, _ = alpha(n, [e for e in E if e not in drop])
    print(f"  random transversal {t}: alpha(G_1 - E') = {at}")
