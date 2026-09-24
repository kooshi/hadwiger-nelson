# Exact check (Poros round 2): which unit vectors of U = {zeta6^j eta^k : |k|<=4} lie in T0 + eta*T0,
# T0 = Z[zeta6]. If only mu6 and mu6*eta, the induced subgraph of Cay(Lambda,U) on P + T0 + eta T0 is Tri box Tri (C6's graph).
from fractions import Fraction as Fr
import itertools
# basis 1, s3, s11, s33 with s3=sqrt(-3), s11=sqrt(-11), s33=s3*s11 (= -sqrt33)
def mul(x,y):
    a0,a1,a2,a3=x; b0,b1,b2,b3=y
    # products of basis: 1,s3,s11,s33
    r=[Fr(0)]*4
    tab={ (0,0):(1,0),(0,1):(1,1),(0,2):(1,2),(0,3):(1,3),
          (1,1):(-3,0),(1,2):(1,3),(1,3):(-3,2),
          (2,2):(-11,0),(2,3):(-11,1),(3,3):(33,0)}
    for i in range(4):
        for j in range(4):
            c,k = tab[(min(i,j),max(i,j))]
            r[k]+=c*x[i]*y[j]
    return tuple(r)
one=(Fr(1),Fr(0),Fr(0),Fr(0))
zeta=(Fr(1,2),Fr(1,2),Fr(0),Fr(0))
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6))
etab=(Fr(0),Fr(-1,6),Fr(0),Fr(-1,6))  # conjugate: s3->-s3, s11->-s11, s33->s33
assert mul(eta,etab)==one
def pw(x,k):
    r=one
    base = x if k>=0 else etab
    for _ in range(abs(k)): r=mul(r,base)
    return r
# write X = p + q*eta with p,q in Q(s3): X = p0+p1 s3 + (q0+q1 s3)(s3-s33)/6
# (q0+q1 s3)(s3 - s33)/6 = (q0 s3 - q0 s33 + q1*(-3) - q1*(-3 s11))/6 = (-3q1 + q0 s3 + 3 q1 s11 - q0 s33)/6
def decomp(X):
    x0,x1,x2,x3=X
    q1 = x2*2      # 3q1/6 = x2
    q0 = -x3*6     # -q0/6 = x3
    p0 = x0 + 3*q1/6
    p1 = x1 - q0/6
    # check consistency
    return (p0,p1),(q0,q1)
def in_T0(p):
    # p0 + p1 s3 = a + b zeta = (a+b/2) + (b/2) s3  -> b=2p1, a=p0-p1
    b=2*p[1]; a=p[0]-p[1]
    return a.denominator==1 and b.denominator==1
hits=[]
for k in range(-4,5):
    for j in range(6):
        X=mul(pw(zeta,j),pw(eta,k))
        p,q=decomp(X)
        # verify reconstruction
        recon=[p[0],p[1],Fr(0),Fr(0)]
        t=mul((q[0],q[1],Fr(0),Fr(0)),eta)
        recon=tuple(recon[i]+t[i] for i in range(4))
        assert recon==X,(k,j)
        if in_T0(p) and in_T0(q): hits.append((j,k))
print("unit vectors in T0+eta*T0 (j,k):",hits)
print("count",len(hits))
# control: eta^2 must NOT be in, and eta must be
print("eta^2 decomposition", decomp(pw(eta,2)))
