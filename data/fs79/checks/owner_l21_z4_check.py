# Owner's independent check: L21cc6506 = Z<U>, U = {1, v, vbar, z, zbar} * U_R (FS73-T40), elements of Q(i, s), s = sqrt(167),
# as 4-tuples (a, b, c, d) = a + b i + c s + d i s. Count homs phi: Z<U> -> Z/4 with phi(u) != 0 for every u in U.
from fractions import Fraction as Fr
from itertools import product
from math import lcm
def mul(x, y):
    a,b,c,d = x; e,f,g,h = y
    # (a + b i + c s + d i s)(e + f i + g s + h i s), i^2=-1, s^2=167
    return (a*e - b*f + 167*c*g - 167*d*h,
            a*f + b*e + 167*c*h + 167*d*g,
            a*g + c*e - b*h - d*f,
            a*h + d*e + b*g + c*f)
def norm2(x):  # |x|^2 where conj: i -> -i, s fixed
    a,b,c,d = x; xc = (a,-b,c,-d); return mul(x, xc)
one=(Fr(1),Fr(0),Fr(0),Fr(0)); I=(Fr(0),Fr(1),Fr(0),Fr(0))
v=(Fr(83,84),Fr(0),Fr(0),Fr(1,84)); vb=(Fr(83,84),Fr(0),Fr(0),Fr(-1,84))
z=(Fr(15,28),Fr(15,28),Fr(1,28),Fr(-1,28)); zb=(Fr(15,28),Fr(-15,28),Fr(1,28),Fr(1,28))
for w in (v,vb,z,zb): assert norm2(w)==one, w
UR=[]
for (p,q) in [(1,0),(0,1),(-1,0),(0,-1),(3,4),(-3,4),(3,-4),(-3,-4),(4,3),(-4,3),(4,-3),(-4,-3)]:
    den = 1 if p*p+q*q==1 else 5
    UR.append((Fr(p,den),Fr(q,den),Fr(0),Fr(0)))
U=sorted(set(mul(r,u) for r in (one,v,vb,z,zb) for u in UR))
assert all(norm2(u)==one for u in U)
print('|U| =', len(U))
# integer coordinates: scale by common denominator
D = lcm(*[x.denominator for u in U for x in u]); print('common denominator', D)
M = [[int(x*D) for x in u] for u in U]
# Hermite normal form of the row lattice (row-style, integer), simple implementation
import copy
def hnf(rows):
    A=[r[:] for r in rows if any(r)]; n=len(A[0]); H=[]; col=0
    while A and col<n:
        A=[r for r in A if any(r)]
        piv=[r for r in A if r[col]!=0]
        if not piv: col+=1; continue
        while len([r for r in A if r[col]!=0])>1:
            piv=sorted([r for r in A if r[col]!=0], key=lambda r: abs(r[col]))
            p=piv[0]
            for r in piv[1:]:
                q=r[col]//p[col]
                for k in range(n): r[k]-=q*p[k]
        p=[r for r in A if r[col]!=0][0]
        if p[col]<0: p[:]=[-x for x in p]
        H.append(p); A=[r for r in A if r is not p]; col+=1
    return H
B=hnf(M); print('rank', len(B)); print('basis (scaled by D):', B)
# coordinates of each u in basis B (solve triangular system)
def coords(u):
    x=[0]*len(B); r=u[:]
    for i,b in enumerate(B):
        c=next(k for k in range(4) if b[k]!=0)
        assert r[c] % b[c] == 0, 'not in lattice?'
        q=r[c]//b[c]; x[i]=q; r=[r[k]-q*b[k] for k in range(4)]
    assert not any(r); return x
C=[coords(u) for u in M]
sols=[phi for phi in product(range(4),repeat=len(B)) if all(sum(p*c for p,c in zip(phi,cc))%4!=0 for cc in C)]
print('homs to Z/4 nonzero on all of U:', len(sols))
if sols:
    phi=sols[0]; vals=sorted(set(sum(p*c for p,c in zip(phi,cc))%4 for cc in C)); print('example', phi, 'values on U', vals)
# negative control: Z/2 (bipartite) should have none if the graph has odd cycles
sols2=[phi for phi in product(range(2),repeat=len(B)) if all(sum(p*c for p,c in zip(phi,cc))%2!=0 for cc in C)]
print('homs to Z/2 nonzero on all of U (bipartite test):', len(sols2))
