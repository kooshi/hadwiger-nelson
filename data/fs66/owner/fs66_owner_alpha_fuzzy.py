# Owner's exploratory check: the single-class version.  alpha_fuzzy(p) = max sum(phi) subject to
#   phi^T (A1 + c I) phi <= c * sum(phi),  0 <= phi <= 1      (necessary for an independent set of ANY level >= 2)
# It bounds alpha(G_k)/p^(2(k-1)) for every k.  Four colours at 11 need 30.25; level one's alpha is 28.
import numpy as np, sys
from scipy.optimize import minimize
p=int(sys.argv[1]); starts=int(sys.argv[2]); need=float(sys.argv[3])
n=p*p
pts=np.array([(x,y) for x in range(p) for y in range(p)])
dx=(pts[:,None,0]-pts[None,:,0])%p; dy=(pts[:,None,1]-pts[None,:,1])%p
A=(((dx*dx+dy*dy)%p)==1).astype(float)
m=p*p; b=np.arange(m)
ind=np.zeros((m,m)); ind[((b[:,None]**2+b[None,:]**2)%m)==1]=1
e2=np.real(np.fft.fft2(ind)); pb=(b[:,None]%p==0)&(b[None,:]%p==0)
c=-e2[~pb].min()/p
M=A+c*np.eye(n)
g=lambda f: c*f.sum()-f@M@f            # >= 0 feasible
gj=lambda f: c-2*M@f
rng=np.random.default_rng(3)
def greedy_indep():
    order=rng.permutation(n); S=[]
    blocked=np.zeros(n,bool)
    for v in order:
        if not blocked[v]: S.append(v); blocked[A[v]>0]=True; blocked[v]=True
    f=np.zeros(n); f[S]=1; return f
best=0; vals=[]; fracs=[]
for s in range(starts):
    f0=greedy_indep()*0.97+0.01 if s%2 else rng.random(n)*0.4
    r=minimize(lambda f:-f.sum(), f0, jac=lambda f:-np.ones(n), bounds=[(0,1)]*n,
               constraints=[{'type':'ineq','fun':g,'jac':gj}], method='SLSQP', options={'maxiter':500,'ftol':1e-10})
    if g(r.x)>-1e-7:
        vals.append(r.x.sum()); fracs.append(int(((r.x>1e-5)&(r.x<1-1e-5)).sum()))
        if r.x.sum()>best: best=r.x.sum(); bf=r.x.copy()
vals=np.array(vals)
print(f"p={p}: c={c:.6f}; {len(vals)} feasible local maxima of {starts} starts; best sum(phi) = {best:.4f}; median {np.median(vals):.4f}; needed for the colour count asked: {need}")
fr=((bf>1e-5)&(bf<1-1e-5)).sum(); print(f"   best phi: {int((bf>1-1e-5).sum())} full, {int(fr)} fractional, {int((bf<1e-5).sum())} empty; top fractional values {np.round(np.sort(bf[(bf>1e-5)&(bf<1-1e-5)])[::-1][:8],3)}")
print("   per-start (sum, #fractional):", [(round(float(v),3),f) for v,f in zip(vals,fracs)])
