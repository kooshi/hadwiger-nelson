from efield import *
from zlin import *
import itertools, math
def c9(z): return [int(x*9) for x in z.c]
Uv=[c9(u) for u in UNITS]
ADM=[(0,1,1,0),(0,1,1,1),(1,0,0,1),(1,0,1,1),(1,1,0,1),(1,1,1,0)]
for pv in ADM:
    pi=lambda v: sum(a*b for a,b in zip(pv,v))%2
    U0=[v for v in Uv if pi(v)==0]
    H=hnf(U0)            # basis of L0 (4 rows)
    # structure of Lambda/L0 : Smith form via sympy
    import sympy
    from sympy.matrices.normalforms import smith_normal_form
    S=smith_normal_form(sympy.Matrix(H),domain=sympy.ZZ)
    inv=[abs(S[i,i]) for i in range(4)]
    # ell on 8*e_i : write 8 e_i in terms of U0 (solve integer combination) -> parity of coefficient sum
    # method: L' = span (v,1); 8e_i in L0; find x with (8e_i, x) in L'; ell(8 e_i) = x mod 2 (well-defined since g even)
    Hp=hnf([v+[1] for v in U0])
    def ell(w):
        v=list(w)+[0]
        for r,p in zip(Hp,pivots(Hp)):
            if p==4: break
            q=v[p]//r[p]; assert v[p]%r[p]==0
            for j in range(5): v[j]-=q*r[j]
        assert not any(v[:4]), 'not in L0'
        return (-v[4])%2
    e=[[8 if i==j else 0 for j in range(4)] for i in range(4)]
    print('pi',pv,'Lambda/L0 invariants',inv,' ell(8 e_i) =',[ell(x) for x in e],' ell on U0 all 1:',all(ell(v)==1 for v in U0))
