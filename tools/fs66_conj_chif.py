#!/usr/bin/env python3
"""FS-66 conjecture note: fractional chromatic number by constraint generation (floats; exploratory, NOT a certificate).

  chi_f(G) = max { sum_v w_v : w >= 0, w(I) <= 1 for every independent set I }.
Separation = maximum-weight independent set, solved as a MILP (scipy/HiGHS).

Usage:
  fs66_conj_chif.py plane P [--drop-one-edge | --drop-transversal SEED]
  fs66_conj_chif.py witness path/to/witness.json
"""
import sys, json, itertools, random
import numpy as np
from scipy.optimize import linprog, milp, LinearConstraint, Bounds
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
    return V, sorted(E), S

def mwis(n, E, w):
    A = lil_matrix((len(E), n))
    for r, (u, v) in enumerate(E):
        A[r, u] = 1; A[r, v] = 1
    res = milp(c=-np.asarray(w), constraints=LinearConstraint(csr_matrix(A), -np.inf, 1),
               integrality=np.ones(n), bounds=Bounds(0, 1))
    x = np.round(res.x).astype(int)
    return [i for i in range(n) if x[i]], float(np.dot(w, x))

def chif(n, E, verbose=True, tol=1e-7, maxit=2000):
    pool = []
    w = np.ones(n)
    for it in range(maxit):
        I, val = mwis(n, E, w)
        if pool and val <= 1 + tol:
            return float(w.sum()), w, pool
        pool.append(I)
        A = np.zeros((len(pool), n))
        for r, I_ in enumerate(pool):
            A[r, I_] = 1
        res = linprog(-np.ones(n), A_ub=A, b_ub=np.ones(len(pool)), bounds=(0, 1), method="highs")
        w = res.x
        if verbose and it % 25 == 0:
            print(f"  it {it}: pool {len(pool)}, LP value {-res.fun:.6f}, last MWIS {val:.6f}", flush=True)
    raise RuntimeError("no convergence")

def main():
    mode = sys.argv[1]
    if mode == "plane":
        p = int(sys.argv[2]); V, E, S = plane(p); n = len(V)
        if "--drop-one-edge" in sys.argv:
            E = E[1:]
        if "--drop-transversal" in sys.argv:
            seed = int(sys.argv[sys.argv.index("--drop-transversal") + 1]); rng = random.Random(seed)
            idx = {v: i for i, v in enumerate(V)}
            drop = set()
            dirs = set()
            for (a, b) in S:
                if ((-a) % p, (-b) % p) in dirs: continue
                dirs.add((a, b))
            for (a, b) in dirs:
                seen = set()
                for v in V:
                    if v in seen: continue
                    line = [((v[0] + j*a) % p, (v[1] + j*b) % p) for j in range(p)]
                    seen.update(line)
                    j = rng.randrange(p)
                    u1, u2 = idx[line[j]], idx[line[(j+1) % p]]
                    drop.add((min(u1, u2), max(u1, u2)))
            E = [e for e in E if e not in drop]
            print(f"dropped {len(drop)} edges (one per single-direction {p}-cycle), seed {seed}")
    else:
        w = json.load(open(sys.argv[2])); n = len(w["points"]); E = [tuple(e) for e in w["edges"]]
    print(f"n = {n}, edges = {len(E)}")
    I, a = mwis(n, E, np.ones(n)); print(f"alpha = {int(round(a))}, n/alpha = {n/a:.6f}")
    val, wt, pool = chif(n, E)
    print(f"chi_f = {val:.6f}  (pool {len(pool)}; support of optimal weight: {int((wt > 1e-9).sum())} vertices)")

if __name__ == "__main__":
    main()
