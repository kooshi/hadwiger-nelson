# Poros round 2: independent re-check of dB9 step 3 (Smith forms of L = <2 eps_k eta^k : |k|<=2>, eps_k in {1, z, z^2}).
# Own arithmetic (basis 1, s3=sqrt-3, s11=sqrt-11, s33=s3*s11), own conversion to Lambda = (1/9) O_E, O_E basis 1, z, w, z*w.
from fractions import Fraction as Fr
import itertools, collections
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_form
from sympy import ZZ
tab={(0,0):(1,0),(0,1):(1,1),(0,2):(1,2),(0,3):(1,3),(1,1):(-3,0),(1,2):(1,3),(1,3):(-3,2),(2,2):(-11,0),(2,3):(-11,1),(3,3):(33,0)}
def mul(x,y):
    r=[Fr(0)]*4
    for i in range(4):
        for j in range(4):
            c,k=tab[(min(i,j),max(i,j))]; r[k]+=c*x[i]*y[j]
    return tuple(r)
one=(Fr(1),Fr(0),Fr(0),Fr(0)); z=(Fr(1,2),Fr(1,2),Fr(0),Fr(0))
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6)); etab=(Fr(0),Fr(-1,6),Fr(0),Fr(-1,6))
def pw(k):
    r=one
    for _ in range(abs(k)): r=mul(r, eta if k>0 else etab)
    return r
def lam(x):  # coordinates in Lambda basis (1/9)(1,z,w,zw); must be integral for x in Lambda
    x0,x1,x2,x3=x; d=4*x3; c=2*x2-2*x3; b=2*x1-2*x3; a=x0-b/2-c/2-d/4
    v=[9*a,9*b,9*c,9*d]; assert all(t.denominator==1 for t in v),x; return [int(t) for t in v]
assert lam(eta)==[-3,6,3,-6]
zs=[one,z,mul(z,z)]
types=collections.Counter()
for choice in itertools.product(range(3),repeat=5):
    rows=[lam(mul(zs[choice[i]],mul(one,pw(k)))) for i,k in enumerate(range(-2,3))]
    rows=[[2*t for t in r] for r in rows]
    S=smith_normal_form(Matrix(rows),domain=ZZ)
    inv=tuple(sorted(abs(S[i,i]) for i in range(4)))
    types[inv]+=1
for t,n in sorted(types.items(),key=lambda x:-x[1]): print(t,n)
print("total",sum(types.values()))
