#!/usr/bin/env python3
"""The Kempe screen's falsification control, run by the owner: over K = Q(sqrt3, sqrt11), on the lattice spanned by
{zeta6^m rho^n : |n| <= 2} (rho = (5 + i sqrt11)/6, the Moser twist; de Grey's V), Harder's pair (0, 8/3) IS forced
equal at four colours by a finite graph (Polymath16, 28 April 2018).  So every proper additive four-colouring (Z/4 AND
Klein) of the lattice must have phi(8/3) = 0 AND no Kempe swap may free the pair.  A KILL here refutes the screen."""
import itertools, sys
from math import gcd, sqrt
from fractions import Fraction
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form
D=11; SD=sqrt(D); S3=sqrt(3); S3D=sqrt(3*D)
def fmul(p,q):
    a1,b1,c1,d1=p; a2,b2,c2,d2=q
    return (a1*a2+3*b1*b2+D*c1*c2+3*D*d1*d2, a1*b2+b1*a2+D*(c1*d2+d1*c2), a1*c2+c1*a2+3*(b1*d2+d1*b2), a1*d2+d1*a2+b1*c2+c1*b2)
fadd=lambda p,q: tuple(x+y for x,y in zip(p,q)); fsub=lambda p,q: tuple(x-y for x,y in zip(p,q))
def units_with_denominator(M):
    box=[]
    for a in range(-M,M+1):
        for b in range(-int(M/S3)-1,int(M/S3)+2):
            for c in range(-int(M/SD)-1,int(M/SD)+2):
                for d in range(-int(M/S3D)-1,int(M/S3D)+2):
                    if all(abs(a+sb*b*S3+sc*c*SD+sb*sc*d*S3D)<=M+1e-9 for sb in (1,-1) for sc in (1,-1)):
                        box.append((a,b,c,d))
    sq={}
    for e in box: sq.setdefault(fmul(e,e),[]).append(e)
    out=set(); T=(M*M,0,0,0)
    for e in box:
        for f in sq.get(fsub(T,fmul(e,e)),[]): out.add(e+f)
    return sorted(out)
def norm(z):
    x,y,m=z; g=0
    for v in x+y+(m,): g=gcd(g,abs(v))
    return (tuple(v//g for v in x),tuple(v//g for v in y),m//g)
def cmul(z,w):
    (x1,y1,m1),(x2,y2,m2)=z,w
    return norm((fsub(fmul(x1,x2),fmul(y1,y2)),fadd(fmul(x1,y2),fmul(y1,x2)),m1*m2))
def conj(z): x,y,m=z; return (x,tuple(-v for v in y),m)
Z6=((1,0,0,0),(0,1,0,0),2)          # (1 + i sqrt3)/2
RHO=((5,0,0,0),(0,0,1,0),6)         # (5 + i sqrt11)/6
one=((1,0,0,0),(0,0,0,0),1)
gens=[]
for n in range(-2,3):
    z=one
    for _ in range(abs(n)): z=cmul(z, RHO if n>0 else conj(RHO))
    for _ in range(6):
        gens.append(z); z=cmul(z,Z6)
M=1
for z in gens: M=M*z[2]//gcd(M,z[2])
def vec(z):
    x,y,m=z
    if M%m: return None
    k=M//m; return tuple(k*v for v in x+y)
G=Matrix([list(vec(z)) for z in gens]); H=hermite_normal_form(G.T)
B=[tuple(int(v) for v in H[:,j]) for j in range(H.shape[1]) if any(H[:,j])]; Bm=Matrix(B).T; rank=len(B)
def coords(v):
    if v is None: return None
    sol=Bm.solve_least_squares(Matrix(v)) if rank<8 else Bm.solve(Matrix(v))
    if (Bm*sol-Matrix(v)).norm()!=0: return None
    cs=[Fraction(int(s.p),int(s.q)) for s in sol]
    return [int(c) for c in cs] if all(c.denominator==1 for c in cs) else None
U={}
for d in [d for d in range(1,M+1) if M%d==0]:
    for cand in units_with_denominator(d):
        z=norm((cand[0:4],cand[4:8],d)); U[z]=z
LU=[c for c in (coords(vec(z)) for z in U) if c is not None]
#print(f"K-lattice <zeta6, rho^(+-1,+-2)>: M={M} rank={rank} generators={len(set(gens))} g={len(LU)}")
tgt=coords(vec(((8,0,0,0),(0,0,0,0),3)))
