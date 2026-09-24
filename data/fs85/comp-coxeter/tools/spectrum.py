"""The symbol lambda(theta) = sum_{u in U} cos(2 pi theta.u) of Cay(Lambda, U) on the character torus (coordinates: 9z on basis
1,zeta,w,zeta w).  Spectrum at N-torsion characters, then local minimisation.  Coxeter FS-85 (a spectrum, G44/G54; not a search
for a witness)."""
import numpy as np, itertools
from efield import *
def c9(z): return [int(x*9) for x in z.c]
Uv=np.array([c9(u) for u in UNITS])
def lam(th): return np.cos(2*np.pi*(Uv@th)).sum()
for N in (2,4,8,16):
    g=np.array(list(itertools.product(range(N),repeat=4)))/N
    vals=np.cos(2*np.pi*(g@Uv.T)).sum(axis=1)
    m=vals.min(); arg=np.where(np.abs(vals-m)<1e-9)[0]
    print('N=%2d  min lambda = %.6f  attained at %d characters; second smallest %.6f'%(N,m,len(arg),np.unique(np.round(vals,9))[1]))
# continuous minimisation from many starts
from scipy.optimize import minimize
rng=np.random.default_rng(1)
best=[]
for _ in range(3000):
    x0=rng.random(4)
    r=minimize(lambda t: lam(t), x0, method='BFGS', jac=lambda t: -2*np.pi*(np.sin(2*np.pi*(Uv@t))@Uv))
    best.append((r.fun, tuple(np.round(r.x%1,6))))
best.sort()
print('continuous: best values', [round(b[0],6) for b in best[:5]])
ms=sorted(set(round(b[0],5) for b in best))[:8]; print('distinct local minima (lowest):',ms)
