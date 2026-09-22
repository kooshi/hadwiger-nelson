#!/usr/bin/env python3
"""The CM-shaped lattice over Q(sqrt3,sqrt5): the Z-span of {zeta6^m u^n : |n| <= NMAX} (no quarter turn), which lies in the
degree-4 CM field Q(sqrt-3, sqrt-5) -- the analogue of de Grey's Moser lattice in Q(sqrt-3, sqrt-11).  Screen: rank, unit
vectors, additive Z/4 and Klein colourings, and the Kempe reach at each chainable target.  Usage: po_cm_lattice.py NMAX [extra: rho15]"""
import sys, itertools
from math import gcd
from fractions import Fraction
sys.path.insert(0,'data/fs70/owner')
from po_additive_screen import units_with_denominator, fmul, fadd, fsub
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form
NMAX=int(sys.argv[1]); extra=sys.argv[2:] 
def norm(z):
    x,y,m=z; g=0
    for v in x+y+(m,): g=gcd(g,abs(v))
    return (tuple(v//g for v in x),tuple(v//g for v in y),m//g)
def cmul(z,w):
    (x1,y1,m1),(x2,y2,m2)=z,w
    return norm((fsub(fmul(x1,x2),fmul(y1,y2)),fadd(fmul(x1,y2),fmul(y1,x2)),m1*m2))
def conj(z): x,y,m=z; return (x,tuple(-v for v in y),m)
Z6=((1,0,0,0),(0,1,0,0),2); U=((-2,0,0,0),(0,0,1,0),3); one=((1,0,0,0),(0,0,0,0),1)
RHO15=((7,0,0,0),(0,0,0,1),8)
gens=[]
for n in range(-NMAX,NMAX+1):
    z=one
    for _ in range(abs(n)): z=cmul(z,U if n>0 else conj(U))
    for _ in range(6): gens.append(z); z=cmul(z,Z6)
if 'rho15' in extra:
    for base in (RHO15,conj(RHO15)):
        z=base
        for _ in range(6): gens.append(z); z=cmul(z,Z6)
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
Us={}
for d in [d for d in range(1,M+1) if M%d==0]:
    for cand in units_with_denominator(d):
        z=norm((cand[0:4],cand[4:8],d)); Us[z]=z
LU=[c for c in (coords(vec(z)) for z in Us) if c is not None]
print(f"CM lattice <zeta6, u^(|n|<={NMAX}){' + rho15' if extra else ''}>: M={M} rank={rank} generators={len(set(gens))} g={len(LU)}")
targets={'4/3':((4,0,0,0),(0,0,0,0),3),'8/3':((8,0,0,0),(0,0,0,0),3),'2':((2,0,0,0),(0,0,0,0),1),'4':((4,0,0,0),(0,0,0,0),1),'2/3':((2,0,0,0),(0,0,0,0),3),'i√3':((0,0,0,0),(0,1,0,0),1),'1/2':((1,0,0,0),(0,0,0,0),2)}
tc={k:coords(vec(v)) for k,v in targets.items()}
print("targets in lattice:", {k:(v is not None) for k,v in tc.items()})
def hnf_rows(vectors):
    Mx=[list(v) for v in vectors]; basis=[]
    for col in range(rank):
        while True:
            nz=[i for i in range(len(Mx)) if Mx[i][col]!=0]
            if not nz: break
            i0=min(nz,key=lambda i:abs(Mx[i][col])); p=Mx[i0][col]; done=True
            for i in nz:
                if i!=i0:
                    q=Mx[i][col]//p; Mx[i]=[a-q*b for a,b in zip(Mx[i],Mx[i0])]
                    if Mx[i][col]!=0: done=False
            if done: basis.append(Mx[i0]); Mx=[Mx[i] for i in range(len(Mx)) if i!=i0]; break
    return basis
def member(basis,v):
    v=list(v)
    for b in basis:
        p=next(i for i,x in enumerate(b) if x!=0)
        if v[p]%b[p]: return False
        q=v[p]//b[p]; v=[a-q*c for a,c in zip(v,b)]
    return all(x==0 for x in v)
import functools
for name,ev,negb in (("Z/4",lambda c,phi: sum(a*p for a,p in zip(c,phi))%4, lambda b:(-b)%4),
                     ("Klein",lambda c,phi: functools.reduce(lambda s,t:s^t,[p for a,p in zip(c,phi) for _ in range(abs(a)%2)],0), lambda b:b)):
    proper=[]
    for phi in itertools.product(range(4),repeat=rank):
        vals=[ev(c,phi) for c in LU]
        if all(v!=0 for v in vals): proper.append((phi,vals))
    print(f"  {name}: proper additive colourings {len(proper)}")
    for tname,tgt in tc.items():
        if tgt is None: continue
        sep=sum(1 for phi,_ in proper if ev(tgt,phi)!=0)
        esc={1:0,2:0,3:0}
        for phi,vals in proper:
            if ev(tgt,phi)!=0: continue
            for b in (1,2,3):
                Zs=[c for c,v in zip(LU,vals) if v==b]; Ws=[c for c,v in zip(LU,vals) if v==negb(b)]
                sums=[[x+y for x,y in zip(z,w)] for z in Zs for w in Ws]
                if sums and not member(hnf_rows(sums),tgt): esc[b]+=1
                if not sums: esc[b]+=1
        verdict='LIVE' if (sep==0 and not any(esc.values())) else ('dead: separated by an additive colouring' if sep else 'dead: Kempe escape')
        print(f"    target {tname:5s}: separated by {sep}; Kempe escapes {esc} -> {verdict}")
