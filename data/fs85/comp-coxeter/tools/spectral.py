"""Round 2 (Coxeter): the spectral support of a colouring whose layers are equitable.
If in family k every vertex sees each other colour exactly twice among its 6 layer-neighbours (= no monochromatic sqrt3-triple of
family k), then g = v_{c(.)} (tetrahedron embedding) satisfies A_k g = -2 g, so ghat is supported on
Z_k = {theta : theta(zeta^j eta^k) = 1/2 for some j in 0,1,2}.  Compute Theta_K = cap_{k in K} Z_k exactly (Smith normal form).
theta <-> t in (R/Z)^4 acting on coords9 (basis (1/9)(1,z,w,zw) of Lambda)."""
from efield import *
from fractions import Fraction as Q
import itertools, sys
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_decomp
def c9(z): return [int(x*9) for x in z.c]
fam={k:[c9(Z**j*ETA**k) for j in range(3)] for k in range(-4,5)}

def solve_half(rows):
    """all t in (R/Z)^4 with rows.t = 1/2 mod 1.  Returns ('empty',) or ('finite', list of t as Fractions) or ('torus', dim)."""
    A=Matrix(rows)
    D,P,Qm=smith_normal_decomp(A)   # D = P*A*Qm
    m,n=A.shape
    b=Matrix([Q(1,2)]*m)
    pb=P*b
    r=sum(1 for i in range(min(m,n)) if D[i,i]!=0)
    for i in range(r,m):
        if Q(pb[i]) % 1 != 0: return ('empty',)
    if r<n: return ('torus',n-r)
    # D s = pb mod 1, s = Qm^{-1} t  -> t = Qm s
    choices=[]
    for i in range(n):
        d=int(D[i,i]); base=Q(pb[i])
        choices.append([ (base+e)/d for e in range(abs(d))])
    sols=[]
    for s in itertools.product(*choices):
        t=Qm*Matrix(s)
        sols.append(tuple(Q(x)%1 for x in t))
    return ('finite',sols)

def theta(K):
    allsols=set(); tori=[]; empties=0
    for js in itertools.product(range(3),repeat=len(K)):
        rows=[fam[k][j] for k,j in zip(K,js)]
        res=solve_half(rows)
        if res[0]=='empty': empties+=1
        elif res[0]=='torus': tori.append((js,res[1]))
        else: allsols.update(res[1])
    return allsols,tori,empties

if __name__=='__main__':
    for K in ([-2,-1,0,1,2], list(range(-4,5)), [-1,0,1], [0,1,2], [-2,0,2]):
        sols,tori,emp=theta(K)
        from math import lcm
        orders=sorted(set(lcm(*[x.denominator for x in t]) for t in sols))
        print('K=%s: |Theta|=%d finite points, %d torus components, %d empty choices; orders %s'%(K,len(sols),len(tori),emp,orders))
        if tori: print('   torus components (first 5):',tori[:5])
