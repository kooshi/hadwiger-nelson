# Owner's exploratory check, second pass: block-coordinate descent (exact row best responses) from many starts,
# including starts from min-conflict pure colourings.  Reports the distribution of local minima of
#   Q(Phi) = tr(Phi^T (A1 + c I) Phi)  against the budget c*n   (necessary for k-colourability of EVERY level >= 2).
import numpy as np, sys, time
p=int(sys.argv[1]); k=int(sys.argv[2]); starts=int(sys.argv[3]); seed=int(sys.argv[4]) if len(sys.argv)>4 else 1
n=p*p
pts=np.array([(x,y) for x in range(p) for y in range(p)])
dx=(pts[:,None,0]-pts[None,:,0])%p; dy=(pts[:,None,1]-pts[None,:,1])%p
A=(((dx*dx+dy*dy)%p)==1).astype(float)
nbr=[np.nonzero(A[v])[0] for v in range(n)]
m=p*p; b=np.arange(m)
ind=np.zeros((m,m)); ind[((b[:,None]**2+b[None,:]**2)%m)==1]=1
e2=np.real(np.fft.fft2(ind)); pb=(b[:,None]%p==0)&(b[None,:]%p==0)
c=-e2[~pb].min()/p
budget=c*n
def proj_simplex_vec(v):
    u=np.sort(v)[::-1]; css=np.cumsum(u)-1; idx=np.arange(1,len(v)+1)
    rho=np.nonzero(u-css/idx>0)[0][-1]; th=css[rho]/(rho+1)
    return np.maximum(v-th,0)
def Q(Phi): return float(np.einsum('ij,ij->',Phi,A@Phi)+c*(Phi**2).sum())
def bcd(Phi,rng,sweeps=400):
    T=A@Phi
    for s in range(sweeps):
        moved=0.0
        for x in rng.permutation(n):
            new=proj_simplex_vec(-T[x]/c)
            d=new-Phi[x]
            if np.abs(d).max()>1e-12:
                T[nbr[x]]+=d; Phi[x]=new; moved=max(moved,np.abs(d).max())
        if moved<1e-9: break
    return Phi
def min_conflict(rng,iters=20000):
    col=rng.integers(0,k,n)
    cnt=np.zeros((n,k),dtype=int)
    for v in range(n):
        for w in nbr[v]: cnt[v,col[w]]+=1
    for it in range(iters):
        conf=np.nonzero(cnt[np.arange(n),col]>0)[0]
        if len(conf)==0: break
        v=conf[rng.integers(len(conf))]
        best=np.nonzero(cnt[v]==cnt[v].min())[0]; nc=best[rng.integers(len(best))]
        if nc!=col[v]:
            for w in nbr[v]: cnt[w,col[v]]-=1; cnt[w,nc]+=1
            col[v]=nc
    mono=int(cnt[np.arange(n),col].sum()//2)
    return col,mono
rng=np.random.default_rng(seed)
t0=time.time(); vals=[]; best=1e18; bestmono=10**9
for s in range(starts):
    if s%2==0:
        Phi=rng.dirichlet(np.ones(k),n)
    else:
        col,mono=min_conflict(rng); bestmono=min(bestmono,mono)
        Phi=np.eye(k)[col]*0.98+0.02/k
    Phi=bcd(Phi,rng); q=Q(Phi); vals.append(q)
    if q<best: best=q; bestPhi=Phi.copy()
vals=np.array(vals)
print(f"p={p} k={k}: c={c:.6f} budget={budget:.3f}; {starts} starts in {time.time()-t0:.0f}s")
print(f"   local minima Q/budget: min {vals.min()/budget:.4f}  5% {np.percentile(vals,5)/budget:.4f}  median {np.median(vals)/budget:.4f}  max {vals.max()/budget:.4f}")
print(f"   best pure colouring seen: {bestmono} monochromatic edges (pure Q/budget = {(2*bestmono+c*n)/budget:.4f})")
fr=((bestPhi>1e-6)&(bestPhi<1-1e-6)).any(axis=1).sum()
print(f"   best Phi: {int(fr)} fractional rows of {n}; verdict: {'SATISFIABLE (no information)' if best<=budget else 'never satisfied (null at this budget of starts; candidate refusal at EVERY level)'}")
