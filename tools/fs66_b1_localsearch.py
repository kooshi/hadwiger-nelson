#!/usr/bin/env python3
"""FS-66 phase 2, planner's numerics: local maxima of the single-class problem at c = 2 EXACTLY, WITH the cuts.

    max sum(phi),  phi in [0,1]^(p^2),  phi^T (A1 + 2 I) phi <= 2 sum(phi),
    phi_x + phi_y <= 1 on edges,  phi_x + phi_y + phi_z <= 1 on triangles.

A local search finds lower bounds on B1(p); it proves nothing (nulls at a budget).  The owner's runs used the
FFT's c = 1.9993 and no cuts; the certificate is built for the hand-proved constant c = 2, so the numerics are
redone here for that problem.  Usage: fs66_b1_localsearch.py P STARTS [--nocuts]
"""
import sys, json, time
import numpy as np
from scipy.optimize import minimize
p = int(sys.argv[1]); starts = int(sys.argv[2]); cuts = "--nocuts" not in sys.argv
c = 2.0
n = p * p
pts = np.array([(x, y) for x in range(p) for y in range(p)])
dx = (pts[:, None, 0] - pts[None, :, 0]) % p; dy = (pts[:, None, 1] - pts[None, :, 1]) % p
A = (((dx * dx + dy * dy) % p) == 1).astype(float)
M = A + c * np.eye(n)
edges = [(i, j) for i in range(n) for j in range(i + 1, n) if A[i, j]]
tris = [(i, j, k) for (i, j) in edges for k in range(j + 1, n) if A[i, k] and A[j, k]]
rowsC = []
if cuts:
    for e in edges:
        r = np.zeros(n); r[list(e)] = 1; rowsC.append(r)
    for t in tris:
        r = np.zeros(n); r[list(t)] = 1; rowsC.append(r)
C = np.array(rowsC) if rowsC else np.zeros((0, n))
g = lambda f: c * f.sum() - f @ M @ f
gj = lambda f: c - 2 * M @ f
cons = [{'type': 'ineq', 'fun': g, 'jac': gj}]
if len(C): cons.append({'type': 'ineq', 'fun': lambda f: 1.0 - C @ f, 'jac': lambda f: -C})
rng = np.random.default_rng(20260920)
def greedy_indep():
    order = rng.permutation(n); blocked = np.zeros(n, bool); f = np.zeros(n)
    for v in order:
        if not blocked[v]: f[v] = 1; blocked[A[v] > 0] = True; blocked[v] = True
    return f
T0 = time.time(); vals = []; fracs = []; best = 0; bf = None
for s in range(starts):
    kind = s % 3
    if kind == 0: f0 = rng.random(n) * 0.4
    elif kind == 1: f0 = greedy_indep() * 0.97 + 0.01
    else:
        f0 = greedy_indep() * 0.9
        f0 = np.clip(f0 + 0.3 * rng.random(n) * (rng.random(n) < 0.15), 0, 1)     # fractional perturbation of a pure set
    r = minimize(lambda f: -f.sum(), f0, jac=lambda f: -np.ones(n), bounds=[(0, 1)] * n, constraints=cons,
                 method='SLSQP', options={'maxiter': 800, 'ftol': 1e-11})
    x = r.x
    ok = g(x) > -1e-7 and (len(C) == 0 or (C @ x).max() < 1 + 1e-7)
    if ok:
        vals.append(float(x.sum())); fracs.append(int(((x > 1e-5) & (x < 1 - 1e-5)).sum()))
        if x.sum() > best: best = float(x.sum()); bf = x.copy()
vals = np.array(vals)
rec = dict(p=p, c=c, cuts=cuts, edges=len(edges), triangles=len(tris), starts=starts, feasible=len(vals),
           best=round(best, 6), median=round(float(np.median(vals)), 6),
           top5=[round(v, 4) for v in sorted(vals, reverse=True)[:5]],
           best_full=int((bf > 1 - 1e-5).sum()), best_fractional=int(((bf > 1e-5) & (bf < 1 - 1e-5)).sum()),
           distinct_values=sorted({round(v, 3) for v in vals}, reverse=True)[:12], seconds=round(time.time() - T0, 1))
print(json.dumps(rec))
