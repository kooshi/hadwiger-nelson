# Rotation set Theta_k(Lambda,U) = {theta in R^r/Z^r : theta.u in [1/k, 1-1/k] mod 1 for all u in U}
# U given in integer coordinates w.r.t. a Z-basis of Lambda. DFS over integer shifts with LP pruning (floats),
# leaves reported with their coordinate ranges; exact verification separately.
import numpy as np, itertools, sys, json
from scipy.optimize import linprog
from fractions import Fraction as Fr

def theta_set(Ucoords, k, eps=1e-9):
    A = np.array(Ucoords, dtype=float)
    # use one representative per +-pair
    reps=[]; seen=set()
    for u in Ucoords:
        t=tuple(u); m=tuple(-x for x in u)
        if m in seen: continue
        seen.add(t); reps.append(u)
    A=np.array(reps,dtype=float); m,r=A.shape
    lo,hi=1.0/k,1.0-1.0/k
    leaves=[]
    # constraints: 0<=theta_i<=1 (fundamental domain, closed)
    def lp_range(Aub,bub,Aeq,beq,c):
        res=linprog(c,A_ub=Aub if len(Aub) else None,b_ub=bub if len(bub) else None,bounds=[(0,1)]*r,method='highs')
        return res
    order=sorted(range(m),key=lambda j:-np.abs(A[j]).sum())
    def dfs(idx,Aub,bub):
        if idx==m:
            leaves.append((list(Aub),list(bub))); return
        j=order[idx]; a=A[j]
        rmin=lp_range(Aub,bub,None,None,a); rmax=lp_range(Aub,bub,None,None,-a)
        if rmin.status!=0 or rmax.status!=0: return
        vmin=rmin.fun; vmax=-rmax.fun
        for n in range(int(np.floor(vmin-hi))-1,int(np.ceil(vmax))+2):
            L=n+lo; H=n+hi
            if H<vmin-eps or L>vmax+eps: continue
            Aub2=Aub+[list(a),list(-a)]; bub2=bub+[H+eps,-(L-eps)]
            # feasibility
            res=linprog(np.zeros(r),A_ub=Aub2,b_ub=bub2,bounds=[(0,1)]*r,method='highs')
            if res.status==0: dfs(idx+1,Aub2,bub2)
    dfs(0,[],[])
    return reps,leaves

def leaf_box(Aub,bub,r):
    out=[]
    for i in range(r):
        c=np.zeros(r); c[i]=1
        a=linprog(c,A_ub=Aub,b_ub=bub,bounds=[(0,1)]*r,method='highs').fun
        b=-linprog(-c,A_ub=Aub,b_ub=bub,bounds=[(0,1)]*r,method='highs').fun
        out.append((a,b))
    return out
