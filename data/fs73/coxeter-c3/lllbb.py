# Theta via an LLL-reduced basis of Lambda (Minkowski embedding) and a direct branch-and-bound on theta in [0,1]^r.
import math, sys, time, itertools
import numpy as np
from fractions import Fraction as Fr
from scipy.optimize import linprog
def lll(B, emb, delta=0.99):
    # B: list of integer row vectors (basis in some coords); emb(v)->float vector. Returns LLL-reduced integer basis.
    B=[list(b) for b in B]; n=len(B)
    def gs(B):
        E=[np.array(emb(b),float) for b in B]; Bs=[]; mu=[[0.0]*n for _ in range(n)]
        for i in range(n):
            v=E[i].copy()
            for j in range(i):
                mu[i][j]=float(E[i]@Bs[j])/float(Bs[j]@Bs[j]); v=v-mu[i][j]*Bs[j]
            Bs.append(v)
        return Bs,mu
    k=1
    while k<n:
        Bs,mu=gs(B)
        for j in range(k-1,-1,-1):
            q=round(mu[k][j])
            if q: B[k]=[B[k][t]-q*B[j][t] for t in range(len(B[k]))]; Bs,mu=gs(B)
        if Bs[k]@Bs[k] >= (delta-mu[k][k-1]**2)*(Bs[k-1]@Bs[k-1]): k+=1
        else: B[k],B[k-1]=B[k-1],B[k]; k=max(k-1,1)
    return B
def solve_coords(B, v):
    from sympy import Matrix
    x=Matrix(B).T.solve(Matrix(v)); assert all(t.q==1 for t in x); return [int(t) for t in x]
def bb(S, r, tlimit=100, verbose=True):
    """S: list of integer coefficient vectors u (theta(u)=theta.u). B&B over theta in [0,1]^r."""
    order=sorted(range(len(S)), key=lambda i: sum(abs(x) for x in S[i]))
    Sx=[S[i] for i in order]
    t0=time.time(); nodes=0; leaves=[]
    stack=[(0,[],[])]
    while stack:
        if time.time()-t0>tlimit: return None, nodes, leaves
        idx,Aub,bub=stack.pop(); nodes+=1
        if idx==len(Sx): leaves.append((Aub,bub)); continue
        u=Sx[idx]; cf=[float(x) for x in u]
        r1=linprog(cf,A_ub=Aub or None,b_ub=bub or None,bounds=[(0,1)]*r,method="highs")
        if r1.status!=0: continue
        r2=linprog([-x for x in cf],A_ub=Aub or None,b_ub=bub or None,bounds=[(0,1)]*r,method="highs")
        mn,mx=r1.fun,-r2.fun
        for j in range(math.floor(mn-2/3)-1, math.ceil(mx-1/3)+2):
            l=j+1/3; h=j+2/3
            if h<mn-1e-9 or l>mx+1e-9: continue
            stack.append((idx+1, Aub+[cf,[-x for x in cf]], bub+[h,-l]))
    return True, nodes, leaves
