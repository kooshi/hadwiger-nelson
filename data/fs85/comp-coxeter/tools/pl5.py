"""Pair-linear colourings of Cay(Lambda, U_K) for a family set K: admissible pi, [Lambda:L0] structure (Smith), parity char."""
from efield import *
from zlin import *
import itertools
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_form
def c9(z): return [int(x*9) for x in z.c]
def run(K):
    UK=[c9(Z**j*ETA**k) for j in range(6) for k in K]
    print('K=',K)
    for pv in itertools.product(range(2),repeat=4):
        if not any(pv): continue
        pi=lambda v: sum(a*b for a,b in zip(pv,v))%2
        U0=[v for v in UK if pi(v)==0]
        H=hnf([v+[1] for v in U0]); P=pivots(H)
        g = H[P.index(4)][4] if 4 in P else 0
        ell_ok=(g==0) or (g%2==0)
        if not ell_ok: continue
        H0=hnf(U0)
        sm=smith_normal_form(Matrix(H0)).tolist() if len(H0)==4 else 'rank<4'
        print('  pi=%s |U0|=%d  Lambda/L0 Smith: %s'%(pv,len(U0),[sm[i][i] for i in range(4)] if sm!='rank<4' else sm))
run([-2,-1,0,1,2]); run(list(range(-4,5))); run([-3,-2,-1,0,1,2,3])
