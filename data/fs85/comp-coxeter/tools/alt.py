"""Alternate-triple lemma inputs: coset classes of zeta^j eta^k mod Lambda_K (K = families already known), per family."""
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
from zlin import hnf
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_decomp
def classes(K, k):
    L=Matrix(hnf([c9(Z**j*ETA**kk) for j in range(6) for kk in K]))
    D,S,T=smith_normal_decomp(L); d=[D[i,i] for i in range(4)]
    def cls(v):
        r=Matrix([v])*T; return tuple(int(r[i])%d[i] for i in range(4) if d[i]!=1)
    return d,[cls(c9(Z**j*ETA**k)) for j in range(6)]
for K,k in (([-3,-2,-1,0,1,2,3],4),([-3,-2,-1,0,1,2,3],-4),([-2,-1,0,1,2],3),([-2,-1,0,1,2],-3),([-2,-1,0,1,2],4)):
    d,c=classes(K,k); print('K=%s family %d: Lambda/Lambda_K %s; classes of zeta^j eta^k, j=0..5: %s'%(K,k,d,c))
