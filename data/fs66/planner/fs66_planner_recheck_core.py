#!/usr/bin/env python3
"""Scratch: independent recheck of the core. (1) every edge re-verified from the definition by plain arithmetic, with vertex index
decoded as v = a*121 + b; (2) k-colourability of the core's edge list asked of several solvers, no pins; (3) k+1 control."""
import json, sys, time
from pysat.solvers import Solver
n = 121; k = int(sys.argv[2])
d = json.load(open(sys.argv[1]))
V = d["verts"]; E = [tuple(e) for e in d["edges"]]
bad = 0
for (u, v) in E:
    a, b = divmod(u, n); c, e = divmod(v, n)
    if ((a-c)**2 + (b-e)**2) % n != 1: bad += 1
print(f"edges re-verified from the definition: {len(E)-bad} of {len(E)} are unit (bad={bad}); vertices={len(V)}")
pos = {v: i for i, v in enumerate(V)}
def clauses(kk):
    cl = [[pos[v]*kk + c + 1 for c in range(kk)] for v in V]
    for (u, v) in E:
        for c in range(kk): cl.append([-(pos[u]*kk + c + 1), -(pos[v]*kk + c + 1)])
    return cl
for kk in (k, k+1):
    for name in ("glucose4", "minisat22", "cadical153", "maplechrono"):
        t0 = time.time()
        with Solver(name=name, bootstrap_with=clauses(kk)) as s:
            r = s.solve()
            ok = None
            if r:
                m = set(l for l in s.get_model() if l > 0)
                col = {v: next(c for c in range(kk) if pos[v]*kk + c + 1 in m) for v in V}
                ok = all(col[u] != col[v] for u, v in E)
        print(f"  k={kk} {name}: {'SAT' if r else 'UNSAT'} in {time.time()-t0:.1f}s" + (f" (model verified proper on all core edges: {ok})" if r else ""), flush=True)
        if kk == k+1: break
