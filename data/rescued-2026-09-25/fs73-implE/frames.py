import math, sys, itertools
from fractions import Fraction as Fr
from explore import units
from frame import zbasis, coords
def idet(A):
    A=[r[:] for r in A]; n=len(A); sign=1; prev=1
    for k in range(n-1):
        if A[k][k]==0:
            for i in range(k+1,n):
                if A[i][k]!=0: A[k],A[i]=A[i],A[k]; sign=-sign; break
            else: return 0
        for i in range(k+1,n):
            for j in range(k+1,n):
                A[i][j]=(A[i][j]*A[k][k]-A[i][k]*A[k][j])//prev
        prev=A[k][k]
    return sign*A[n-1][n-1]
if __name__=="__main__":
    key=sys.argv[1]; d=int(sys.argv[2])
    M,U=units(key,d); B=zbasis(U); C=[coords(B,u) for u in U]
    half=[]; 
    for c in C:
        if tuple(-x for x in c) not in set(map(tuple,half)): half.append(c)
    print(len(U),len(half))
    import numpy as np
    res=[]
    for q in itertools.combinations(range(len(half)),4):
        F=[half[i] for i in q]; D=abs(idet(F))
        if D==0: continue
        Finv=np.linalg.inv(np.array(F,float))
        cc=np.array(half,float)@Finv   # coefficients c(u) wrt frame t
        w=np.abs(cc).sum(1)
        res.append((D, float(w.max()), float(w.mean()), q))
    res.sort()
    print("min index", res[0][:3], "count subsets", len(res))
    # pareto: index vs max width
    best=sorted(res,key=lambda r:(r[0]*max(1,r[1]/3)))[:15]
    for r in best: print(r)
    print("smallest max-width:")
    for r in sorted(res,key=lambda r:r[1])[:10]: print(r)
