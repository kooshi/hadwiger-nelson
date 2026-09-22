#!/usr/bin/env python3
"""Owner's screen of a named lattice (independent of tools/fs70_*): generators as complex numbers over Q(sqrt3,sqrt5),
closed under zeta12 and conjugation; the lattice's unit vectors by box enumeration over every denominator dividing M;
additive Z/4 and Klein counts.  Usage: po_screen_lattice.py NAME[+NAME...]   names: zeta12 u3 q7 v4 w4 s7 q5 s5 d6 u3sq"""
import sys, itertools
from fractions import Fraction
from math import gcd
sys.path.insert(0, 'data/fs70/owner')
from po_additive_screen import units_with_denominator, fmul, fadd, fsub, fscale
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form

Z = ((0,1,0,0),(1,0,0,0),2)           # zeta12 = (sqrt3 + i)/2
NAMED = {
 'zeta12': Z,
 'u3':  ((-2,0,0,0),(0,0,1,0),3),      # (-2 + i sqrt5)/3
 'u3sq':((-1,0,0,0),(0,0,-4,0),9),     # u^2 = (-1 - 4 i sqrt5)/9
 'q7':  ((1,0,0,0),(0,4,0,0),7),       # (1 + 4 i sqrt3)/7
 's7':  ((2,0,0,0),(0,0,3,0),7),       # (2 + 3 i sqrt5)/7
 'v4':  ((1,0,0,0),(0,0,0,1),4),       # (1 + i sqrt15)/4
 'w4':  ((0,1,1,0),(0,-1,1,0),4),      # ((sqrt3+sqrt5) + i(sqrt5-sqrt3))/4
 'q5':  ((3,0,0,0),(4,0,0,0),5),       # (3 + 4i)/5
 's5':  ((0,0,2,0),(0,0,1,0),5),       # (2 sqrt5 + i sqrt5)/5
 'd6':  ((0,1,0,0),((0,0,0,0)),6),     # placeholder, replaced below
}
def norm(z):
    x,y,m = z
    g=0
    for v in x+y+(m,): g=gcd(g,abs(v))
    return (tuple(v//g for v in x), tuple(v//g for v in y), m//g)
def cmul(z,w):
    (x1,y1,m1),(x2,y2,m2)=z,w
    return norm((fsub(fmul(x1,x2),fmul(y1,y2)), fadd(fmul(x1,y2),fmul(y1,x2)), m1*m2))
def conj(z): x,y,m=z; return (x, tuple(-v for v in y), m)
def is_unit(z):
    x,y,m=z; s=fadd(fmul(x,x),fmul(y,y)); return s==(m*m,0,0,0)
# a denominator-6 unit vector: find one from the box
for cand in units_with_denominator(6):
    z=norm((cand[0:4],cand[4:8],6))
    if z[2]==6: NAMED['d6']=z; break
names=sys.argv[1].split('+')
gens=[]
for n in names:
    z=NAMED[n]; assert is_unit(z), n
    orbit=[]
    for _ in range(12):
        orbit.append(z); orbit.append(conj(z)); z=cmul(z,Z)
    gens+=orbit
M=1
for z in gens: M=M*z[2]//gcd(M,z[2])
def vec(z):
    x,y,m=z
    if M%m: return None
    k=M//m; return tuple(k*v for v in x+y)
G=Matrix([list(vec(z)) for z in gens])
H=hermite_normal_form(G.T)
B=[tuple(int(v) for v in H[:,j]) for j in range(H.shape[1]) if any(H[:,j])]
Bm=Matrix(B).T; rank=len(B)
def coords(v):
    if v is None: return None
    sol=Bm.solve(Matrix(v)); cs=[Fraction(int(s.p),int(s.q)) for s in sol]
    return [int(c) for c in cs] if all(c.denominator==1 for c in cs) else None
# unit vectors with denominator dividing M: enumerate by every divisor d of M (each box small), normalise, dedupe
divs=[d for d in range(1,M+1) if M%d==0]
U={}
for d in divs:
    for cand in units_with_denominator(d):
        z=norm((cand[0:4],cand[4:8],d)); U[z]=z
LU=[]
for z in U:
    c=coords(vec(z))
    if c is not None: LU.append(c)
print(f"lattice {sys.argv[1]}: M={M} rank={rank} candidates={len(U)} g={len(LU)}")
tg={'i√3':coords(vec(((0,0,0,0),(0,1,0,0),1))),'2':coords(vec(((2,0,0,0),(0,0,0,0),1))),
    '4/3':coords(vec(((4,0,0,0),(0,0,0,0),3))),'8/3':coords(vec(((8,0,0,0),(0,0,0,0),3))),'4/7':coords(vec(((4,0,0,0),(0,0,0,0),7)))}
print("targets in lattice:", {k:(v is not None) for k,v in tg.items()})
for name,addf,neg in (("Z/4",lambda a,b:(a+b)%4,lambda a:(-a)%4),("Klein",lambda a,b:a^b,lambda a:a)):
    cnt=0; kills={k:0 for k in tg}
    for phi in itertools.product(range(4),repeat=rank):
        def ev(c):
            s=0
            for ci,pi in zip(c,phi):
                q=pi if ci>0 else neg(pi)
                for _ in range(abs(ci)%4): s=addf(s,q)
            return s
        if all(ev(c)!=0 for c in LU):
            cnt+=1
            for k,c in tg.items():
                if c is not None and ev(c)==0: kills[k]+=1
    print(f"  {name}: proper {cnt}; zero-at {kills}")
