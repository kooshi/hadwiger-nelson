#!/usr/bin/env python3
"""Owner's independent count of a rotation's cross edges on the CM base (FS-70 phase 1c), sharing no code with tools/fs70_*.

Base B = word ball at sums of <= K over the 30 generators zeta6^m u^n (|n| <= 2), u = (-2 + i sqrt5)/3, in exact arithmetic
over F = Q(sqrt3, sqrt5) (4-tuples of Fractions, basis 1, sqrt3, sqrt5, sqrt15); a point is x + iy with x, y in F.
Cross edges of the arena B + psi.B: unordered pairs (z, w), z, w in B, both nonzero, with |z - psi.w| = 1 exactly.
Proposal: a float grid of side 1/4 and the ANNULUS of cells that can hold a point at distance 1 +- tol from z (cell ranges
derived from the tolerance, so a pair can never straddle out of the search); decision: exact field arithmetic.
Diagonal = pairs with w = z.  Usage: po_rot_cross.py K 'x0 x1 x2 x3 | y0 y1 y2 y3' (psi as Fractions in the F basis).
"""
import sys, math
from fractions import Fraction as Fr
from collections import defaultdict

S3, S5, S15 = 3**.5, 5**.5, 15**.5
def fmul(a, b):
    a0,a1,a2,a3 = a; b0,b1,b2,b3 = b
    return (a0*b0+3*a1*b1+5*a2*b2+15*a3*b3, a0*b1+a1*b0+5*(a2*b3+a3*b2), a0*b2+a2*b0+3*(a1*b3+a3*b1), a0*b3+a3*b0+a1*b2+a2*b1)
def fadd(a,b): return tuple(x+y for x,y in zip(a,b))
def fsub(a,b): return tuple(x-y for x,y in zip(a,b))
def ffloat(a): return float(a[0])+float(a[1])*S3+float(a[2])*S5+float(a[3])*S15
ZERO=(Fr(0),)*4; ONE=(Fr(1),Fr(0),Fr(0),Fr(0))
def cmul(p,q):  # (x+iy)(x'+iy')
    return (fsub(fmul(p[0],q[0]),fmul(p[1],q[1])), fadd(fmul(p[0],q[1]),fmul(p[1],q[0])))
def cadd(p,q): return (fadd(p[0],q[0]), fadd(p[1],q[1]))
def csub(p,q): return (fsub(p[0],q[0]), fsub(p[1],q[1]))
def cnorm(p): return fadd(fmul(p[0],p[0]),fmul(p[1],p[1]))

u=((Fr(-2,3),Fr(0),Fr(0),Fr(0)),(Fr(0),Fr(0),Fr(1,3),Fr(0)))
z6=((Fr(1,2),Fr(0),Fr(0),Fr(0)),(Fr(0),Fr(1,2),Fr(0),Fr(0)))
uinv=(u[0],tuple(-t for t in u[1]))  # conjugate = inverse on the unit circle
assert cnorm(u)==ONE and cnorm(z6)==ONE
gens=[]
for n in range(-2,3):
    p=((Fr(1),Fr(0),Fr(0),Fr(0)),ZERO)
    for _ in range(abs(n)): p=cmul(p,u if n>0 else uinv)
    for m in range(6):
        gens.append(p); p=cmul(p,z6)
assert len(set(gens))==30 and all(cnorm(g)==ONE for g in gens)

def ball(K):
    S={((ZERO),(ZERO))}; frontier=set(S)
    for _ in range(K):
        new=set()
        for p in frontier:
            for g in gens:
                q=cadd(p,g)
                if q not in S: new.add(q)
        S|=new; frontier=new
    return S

def parse_psi(s):
    xs,ys=s.split('|')
    x=tuple(Fr(t) for t in xs.split()); y=tuple(Fr(t) for t in ys.split())
    assert len(x)==4 and len(y)==4
    return (x,y)

def cross(B, psi, tol=1e-7):
    assert cnorm(psi)==ONE, "psi is not a unit vector"
    Bl=list(B)
    rot=[cmul(psi,w) for w in Bl]
    cell=0.25
    grid=defaultdict(list)
    for j,r in enumerate(rot):
        grid[(math.floor(ffloat(r[0])/cell), math.floor(ffloat(r[1])/cell))].append(j)
    R=int((1+tol)/cell)+2  # cells within |dx|,|dy| <= 1+tol of z's cell, one spare on each side
    pairs=[]
    for i,z in enumerate(Bl):
        zx,zy=ffloat(z[0]),ffloat(z[1]); cx,cy=math.floor(zx/cell),math.floor(zy/cell)
        for dx in range(-R,R+1):
            # annulus prune on the cell's x-distance range
            for dy in range(-R,R+1):
                for j in grid.get((cx+dx,cy+dy),()):
                    rx,ry=ffloat(rot[j][0]),ffloat(rot[j][1])
                    d2=(zx-rx)**2+(zy-ry)**2
                    if abs(d2-1.0)<=tol:
                        pairs.append((i,j))
    exact=[(i,j) for i,j in pairs if cnorm(csub(Bl[i],rot[j]))==ONE]
    origin=((ZERO),(ZERO))
    cross_=[(i,j) for i,j in exact if Bl[i]!=origin and Bl[j]!=origin]
    diag=[(i,j) for i,j in cross_ if i==j]
    return len(exact), len(cross_), len(diag)

if __name__=='__main__':
    K=int(sys.argv[1]); psi=parse_psi(sys.argv[2])
    B=ball(K); print(f"base at sums <= {K}: {len(B)} points")
    npairs,ncross,ndiag=cross(B,psi)
    print(f"psi = {sys.argv[2]}: pairs at distance 1 = {npairs}; cross edges = {ncross} ({ndiag} diagonal, {ncross-ndiag} off-diagonal)")
