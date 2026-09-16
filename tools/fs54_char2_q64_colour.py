import numpy as np, random, time, itertools, sys
from pysat.solvers import Solver
n = 4096; mu = [int(x) for x in np.load("data/fs54/char2/mu64.npy")]
nbrs = [[v ^ u for u in mu] for v in range(n)]
# 1) DSATUR upper bound
def dsatur(order_seed):
    rng = random.Random(order_seed)
    col = [-1]*n; sat = [set() for _ in range(n)]; deg_un = [65]*n
    for _ in range(n):
        v = max((x for x in range(n) if col[x] < 0), key=lambda x: (len(sat[x]), deg_un[x], rng.random()))
        c = 0
        while c in sat[v]: c += 1
        col[v] = c
        for w in nbrs[v]:
            sat[w].add(c); deg_un[w] -= 1
    return col
t0 = time.time(); best = 99
for s in range(3):
    col = dsatur(s); k = max(col) + 1
    assert all(col[v] != col[w] for v in range(n) for w in nbrs[v])
    best = min(best, k)
print(f"DSATUR best {best} colours ({time.time()-t0:.0f}s)", flush=True)
# 2) linear colourings: F_2-linear phi: F_2^12 -> F_2^k with phi(u) != 0 for all u, i.e. 2^k colours (k=3 -> 8 colours)
rng = random.Random(7)
for k in (3,):
    ok = False
    for t in range(200000):
        fs = [rng.randrange(1, n) for _ in range(k)]
        if all(any(bin(f & u).count("1") & 1 for f in fs) for u in mu):
            ok = True; print(f"linear {2**k}-colouring found, functionals {fs}", flush=True); break
    if not ok: print(f"no linear {2**k}-colouring in 200000 tries", flush=True)
