"""FS-73 planner measurement: the lattice graph's own Hoffman sign at k = 4 on de Grey's K-lattice (Poros's reading P-S1).
lambda(theta) = sum_{u in U} cos(2 pi theta.u) over theta in T^rank; a period-N quotient's spectrum is lambda on (1/N)Z^r.
Four-colourability forces min lambda <= -d/3.  Tight iff min = -d/3 exactly."""
import sys, itertools, math, random
import numpy as np
sys.path.insert(0, sys.argv[1]); import klat
U = np.array(klat.LU, dtype=float); d = len(U); r = klat.rank
print('8/3 coords', klat.tgt); print(f'rank={r} d={d} (unit vectors) target -d/3 = {-d/3:.6f}')
lam = lambda th: np.cos(2*np.pi*(U @ th)).sum(axis=0)
res = {}
for N in range(2, 13):
    pts = np.array(list(itertools.product(range(N), repeat=r)), dtype=float).T / N
    v = lam(pts); mn = v.min()
    arg = pts[:, np.isclose(v, mn, atol=1e-9)].T
    res[N] = (mn, arg)
    print(f'N={N:2d} quotient lambda_min={mn:+.6f}  #argmin={len(arg)}  Hoffman floor 1+d/|lmin|={1+d/abs(mn):.4f}')
# continuous minimisation
from scipy.optimize import minimize
best = (1e9, None); rng = np.random.default_rng(1)
for _ in range(4000):
    x0 = rng.random(r)
    o = minimize(lambda t: lam(t.reshape(r,1))[0], x0, method='BFGS')
    if o.fun < best[0]: best = (o.fun, o.x % 1)
print(f'continuous min over T^{r}: {best[0]:+.9f} at theta = {np.round(best[1], 6)}')
mn8, arg8 = res[8]
print('minimisers at N=8 (x8):', sorted({tuple(int(round(8*t)) % 8 for t in a) for a in arg8})[:20])
