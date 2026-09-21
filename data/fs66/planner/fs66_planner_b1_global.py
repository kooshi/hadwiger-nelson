#!/usr/bin/env python3
"""Scratch pricing pilot: certify an UPPER bound on B1(p) = max sum(phi), phi in [0,1]^{p^2}, phi^T (A1 + cI) phi <= c sum(phi),
optionally with the liftable-subgraph cuts (edges, triangles), by a global solver (spatial branch and bound).
usage: b1_global.py P {scip|gurobi} TLIM [--cuts] [--pin] [--target T]"""
import sys, time, itertools, numpy as np
p = int(sys.argv[1]); solver = sys.argv[2]; tlim = float(sys.argv[3])
cuts = "--cuts" in sys.argv; pin = "--pin" in sys.argv
target = float(sys.argv[sys.argv.index("--target")+1]) if "--target" in sys.argv else None
n = p*p
pts = [(x, y) for x in range(p) for y in range(p)]
adj = [[j for j, (c, d) in enumerate(pts) if ((a-c)**2 + (b-d)**2) % p == 1] for (a, b) in pts]
m = p*p; b = np.arange(m)
ind = np.zeros((m, m)); ind[((b[:, None]**2 + b[None, :]**2) % m) == 1] = 1
e2 = np.real(np.fft.fft2(ind)); pb = (b[:, None] % p == 0) & (b[None, :] % p == 0)
c = float(-e2[~pb].min()/p)
c_up = np.nextafter(c, 3.0) + 1e-9      # a slightly LARGER c only weakens the constraint: sound for an upper bound
edges = [(i, j) for i in range(n) for j in adj[i] if i < j]
tris = sorted({tuple(sorted((i, j, k))) for i, j in edges for k in adj[i] if k in adj[j]})
print(f"p={p} n={n} c={c:.6f} edges={len(edges)} triangles={len(tris)} cuts={cuts} pin={pin} target={target}", flush=True)
t0 = time.time()
if solver == "gurobi":
    import gurobipy as gp
    M = gp.Model(); M.Params.NonConvex = 2; M.Params.TimeLimit = tlim; M.Params.Threads = 4
    f = M.addVars(n, lb=0.0, ub=1.0)
    M.addQConstr(gp.quicksum(2*f[i]*f[j] for i, j in edges) + c_up*gp.quicksum(f[i]*f[i] for i in range(n)) <= c_up*gp.quicksum(f[i] for i in range(n)))
    if cuts:
        for i, j in edges: M.addConstr(f[i] + f[j] <= 1)
        for t in tris: M.addConstr(f[t[0]] + f[t[1]] + f[t[2]] <= 1)
    if pin:  # SOUND symmetry breaks: translate so a maximum entry sits at vertex 0; rotate so the largest neighbour of 0 is adj[0][0]
        for i in range(1, n): M.addConstr(f[0] >= f[i])
        for j in adj[0][1:]: M.addConstr(f[adj[0][0]] >= f[j])
    if target is not None: M.addConstr(gp.quicksum(f[i] for i in range(n)) >= target); M.setObjective(0)
    else: M.setObjective(gp.quicksum(f[i] for i in range(n)), gp.GRB.MAXIMIZE)
    M.optimize()
    print(f"gurobi status={M.Status} best={M.ObjVal if M.SolCount else None} bound={M.ObjBound} nodes={M.NodeCount} time={time.time()-t0:.0f}s")
else:
    from pyscipopt import Model, quicksum
    M = Model(); M.setParam("limits/time", tlim); M.hideOutput(False)
    f = [M.addVar(lb=0.0, ub=1.0, name=f"f{i}") for i in range(n)]
    M.addCons(quicksum(2*f[i]*f[j] for i, j in edges) + c_up*quicksum(f[i]*f[i] for i in range(n)) - c_up*quicksum(f) <= 0)
    if cuts:
        for i, j in edges: M.addCons(f[i] + f[j] <= 1)
        for t in tris: M.addCons(f[t[0]] + f[t[1]] + f[t[2]] <= 1)
    if target is not None: M.addCons(quicksum(f) >= target); M.setObjective(0*f[0], "maximize")
    else: M.setObjective(quicksum(f), "maximize")
    M.optimize()
    print(f"scip status={M.getStatus()} primal={M.getPrimalbound()} dual={M.getDualbound()} nodes={M.getNNodes()} time={time.time()-t0:.0f}s")
