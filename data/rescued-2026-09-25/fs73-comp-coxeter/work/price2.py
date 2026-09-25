from shapes import units
from theta2 import lattice_coords, halfset
from lllbb import *
import sys, math, numpy as np
from sympy import Matrix
def reduce_units(S):
    # S: coefficient vectors of U+ in some basis of Lambda. Find g in GL_r(Z) making g-coords small:
    # dual basis rows w_i minimize sum_u (w_i.u)^2 -> LLL of identity rows under Gram G = sum u u^T.
    r=len(S[0]); G=np.zeros((r,r))
    for u in S: G+=np.outer(u,u)
    Lc=np.linalg.cholesky(G)  # G = Lc Lc^T ; emb(w) = Lc^T w
    W=lll([[1 if i==j else 0 for j in range(r)] for i in range(r)], lambda w: Lc.T@np.array(w,float))
    Wm=Matrix(W)   # rows: new dual basis; new coords of u: Wm*u
    assert abs(Wm.det())==1
    return [list(map(int, Wm*Matrix(u))) for u in S], Wm
if __name__=="__main__":
    M=int(sys.argv[1]); d=int(sys.argv[2]); tl=float(sys.argv[3])
    H=[[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
    U=units(M,H,d); B,C=lattice_coords(U); S=halfset(C)
    S2,Wm=reduce_units(S)
    print("M",M,"d",d,"|U|",len(U),"max|coef|",max(max(abs(x) for x in s) for s in S2),"sum l1",sum(sum(abs(x) for x in s) for s in S2),flush=True)
    ok,nodes,leaves=bb(S2,4,tlimit=tl)
    print("finished" if ok else "TIMEOUT","nodes",nodes,"leaves",len(leaves),flush=True)
