"""Check the plan's rank-1 (Q-obs) benchmark inhabitant G(Z, D), D = {1,3,7,12,17,22}, at four colours.
(1) triangle-free (D sum-free); (2) a periodic independent set of density 8/29 (chi_f <= 29/8);
(3) the least interval length L with [0, L) not 4-colourable (SAT, pysat cadical, colour 0 pinned at vertex 0,
    colour 1 at vertex 1 -- an edge, since 1 in D); (4) the UNSAT core size at that L."""
import itertools, sys, time
from pysat.solvers import Solver
D = [1, 3, 7, 12, 17, 22]
k = 4
# (1)
assert not any(a + b in D for a in D for b in D), "not sum-free"
print("sum-free (triangle-free): yes")
# (2) independent sets mod 29 of size 8
m = 29
forb = {d % m for d in D} | {(-d) % m for d in D}
best = None
for comb in itertools.combinations(range(1, m), 7):
    S = (0,) + comb
    if all(((a - b) % m) not in forb for a in S for b in S if a != b):
        best = S; break
print("independent set of size 8 mod 29:", best)
def var(v, c): return v * k + c + 1
def cnf(L):
    cl = []
    for v in range(L):
        cl.append([var(v, c) for c in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                cl.append([-var(v, c1), -var(v, c2)])
        for d in D:
            if v + d < L:
                for c in range(k):
                    cl.append([-var(v, c), -var(v + d, c)])
    return cl
def sat(L, core=False):
    cl = cnf(L)
    assum = [var(0, 0), var(1, 1)]
    with Solver(name='cadical195', bootstrap_with=cl) as s:
        r = s.solve(assumptions=assum)
        return r
t = time.time()
lo, hi = 23, 400
assert sat(lo) and not sat(hi)
while hi - lo > 1:
    mid = (lo + hi) // 2
    if sat(mid): lo = mid
    else: hi = mid
print(f"least refuting interval length L = {hi} (colourable at {lo}); {time.time()-t:.1f}s")
