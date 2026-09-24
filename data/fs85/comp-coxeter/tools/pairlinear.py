"""Classification of the 'pair-linear' four-colourings of Cay(Lambda, U) by linear algebra (Coxeter, FS-85). No search.
A pair-linear colouring is c = beta(pi(z), sigma(z)), beta: F2^2 -> 4 colours a bijection, pi in Hom(Lambda, F2).
It is proper iff for u in U0 := U cap ker pi : sigma(z+u) = sigma(z) + 1 for all z  (u with pi(u)=1 join different pairs).
So sigma = ell + (any function of z mod L0), L0 = <U0>, where ell: L0 -> F2 is the homomorphism with ell(U0) = 1, which must exist."""
from efield import *
from zlin import *
import itertools, math
def c9(z): return [int(x*9) for x in z.c]
Uv=[c9(u) for u in UNITS]
good=[]
for pv in itertools.product(range(2),repeat=4):
    if not any(pv): continue
    pi=lambda v: sum(a*b for a,b in zip(pv,v))%2
    U0=[v for v in Uv if pi(v)==0]
    idxL0=index_full(U0,4)
    H=hnf([v+[1] for v in U0])
    P=pivots(H)
    g = H[P.index(4)][4] if 4 in P else 0     # (0,g) generates L' cap (0 x Z); g = 0 means none
    ell_ok = (g==0) or (g%2==0)
    eis=[pi(c9(Z**j)) for j in range(3)]
    print('pi=%s |U0|=%2d [Lambda:L0]=%s  g=%s  ell exists: %s   pi(1,zeta,zeta^2)=%s'%(pv,len(U0),idxL0,g,ell_ok,eis))
    if ell_ok: good.append(pv)
print('functionals admitting pair-linear colourings:',good)
