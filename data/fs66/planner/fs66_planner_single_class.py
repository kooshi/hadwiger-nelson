#!/usr/bin/env python3
"""Scratch: the single-set fibre-density relaxation. max sum(phi) s.t. phi^T A1 phi <= c * sum phi(1-phi), 0<=phi<=1.
Local maxima from many starts (SLSQP); pure phi = independent sets of G1 are feasible with value alpha(G1)."""
import sys, numpy as np, time
from scipy.optimize import minimize
p = int(sys.argv[1]); starts = int(sys.argv[2]); n = p*p
pts = [(x, y) for x in range(p) for y in range(p)]
A = np.array([[1.0 if ((a-c)**2 + (b-d)**2) % p == 1 else 0.0 for (c, d) in pts] for (a, b) in pts])
m = p*p; b = np.arange(m)
ind = np.zeros((m, m)); ind[((b[:, None]**2 + b[None, :]**2) % m) == 1] = 1
e2 = np.real(np.fft.fft2(ind)); pb = (b[:, None] % p == 0) & (b[None, :] % p == 0)
c = -e2[~pb].min()/p
M = A + c*np.eye(n)
g = lambda f: c*f.sum() - f @ M @ f          # >= 0
gj = lambda f: c - 2*(M @ f)
rng = np.random.default_rng(1); best = 0; vals = []
t0 = time.time()
for s in range(starts):
    f0 = rng.random(n) * rng.choice([0.2, 0.5, 1.0])
    r = minimize(lambda f: -f.sum(), f0, jac=lambda f: -np.ones(n), bounds=[(0, 1)]*n,
                 constraints=[{"type": "ineq", "fun": g, "jac": gj}], method="SLSQP", options={"maxiter": 400, "ftol": 1e-10})
    if r.success and g(r.x) > -1e-7:
        vals.append(-r.fun)
        if -r.fun > best: best = -r.fun; bx = r.x.copy()
vals = np.array(vals)
frac = int(((bx > 1e-5) & (bx < 1-1e-5)).sum())
print(f"p={p}: c={c:.6f}; {len(vals)}/{starts} converged in {time.time()-t0:.0f}s; local maxima of sum(phi): max {vals.max():.4f} median {np.median(vals):.4f}; "
      f"ratio max/p^2 = {vals.max()/n:.5f}; best has {frac} fractional entries, {int((bx>1-1e-5).sum())} ones")
