import math, sys, itertools, time
import numpy as np
from explore import units
from frame import zbasis, coords
from frames import idet
def col_hnf(F):
    """Lower-triangular H = F V (V unimodular) by integer column operations; returns H (list of rows)."""
    A=[r[:] for r in F]; n=len(A)
    for i in range(n):
        # make A[i][i..] have a single nonzero at column i via column gcd ops
        while True:
            nz=[j for j in range(i,n) if A[i][j]!=0]
            if len(nz)<=1: break
            p=min(nz,key=lambda j:abs(A[i][j]))
            for j in nz:
                if j!=p:
                    q=A[i][j]//A[i][p]
                    for r in range(n): A[r][j]-=q*A[r][p]
        nz=[j for j in range(i,n) if A[i][j]!=0]
        p=nz[0]
        for r in range(n): A[r][i],A[r][p]=A[r][p],A[r][i]
        if A[i][i]<0:
            for r in range(n): A[r][i]=-A[r][i]
        for j in range(i):
            q=A[i][j]//A[i][i]
            for r in range(n): A[r][j]-=q*A[r][i]
    return A
def adj(F):
    n=len(F); Aj=[[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            m=[[F[r][c] for c in range(n) if c!=j] for r in range(n) if r!=i]
            # 3x3 det
            dd=(m[0][0]*(m[1][1]*m[2][2]-m[1][2]*m[2][1])-m[0][1]*(m[1][0]*m[2][2]-m[1][2]*m[2][0])+m[0][2]*(m[1][0]*m[2][1]-m[1][1]*m[2][0]))
            Aj[j][i]=(-1)**(i+j)*dd
    return Aj
def survivors(half, q, chunk=2_000_000, verbose=True):
    F=[half[i] for i in q]; det=idet(F); A=adj(F)   # F^{-1} = A/det
    if det<0: det=-det; A=[[-x for x in r] for r in A]
    others=[c for k,c in enumerate(half) if k not in q]
    N=np.array([[sum(c[k]*A[k][i] for k in range(4)) for i in range(4)] for c in others],dtype=np.int64)  # c(u)*det
    H=col_hnf(F); diag=[H[i][i] for i in range(4)]; assert np.prod(diag)==det
    Hn=np.array(H,dtype=np.int64)
    s3=3*N.sum(1); hw=np.abs(N).sum(1); D=det
    total=det; surv=[]; t0=time.time()
    # enumerate k in prod [0,diag_i); j = H k? No: representatives are j with 0<=j_i<H_ii (triangular reduction)
    grids=[np.arange(dd,dtype=np.int64) for dd in diag]
    # iterate over first three coords, vectorise last
    cnt=0
    for j0 in range(diag[0]):
        for j1 in range(diag[1]):
            J=np.stack(np.meshgrid(np.array([j0]),np.array([j1]),grids[2],grids[3],indexing='ij'),-1).reshape(-1,4)
            C=6*(J@N.T)+s3[None,:]   # 6*det*center
            lo=C-hw[None,:]; hi=C+hw[None,:]
            k=np.floor_divide(hi-2*D,6*D); end=2*D+6*D*k+2*D
            ok=(end>=lo).all(1)
            cnt+=ok.sum()
            if ok.any(): surv.extend(J[ok].tolist())
    return det,diag,cnt,surv
if __name__=="__main__":
    key=sys.argv[1]; d=int(sys.argv[2]); q=tuple(map(int,sys.argv[3].split(',')))
    M,U=units(key,d); B=zbasis(U); C=[coords(B,u) for u in U]
    half=[]
    for c in C:
        if tuple(-x for x in c) not in set(map(tuple,half)): half.append(c)
    t0=time.time(); det,diag,cnt,surv=survivors(half,q)
    print("frame",q,"index",det,"diag",diag,"survivors",cnt,"time",round(time.time()-t0,1))
