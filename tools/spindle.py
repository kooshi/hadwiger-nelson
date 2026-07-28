#!/usr/bin/env python3
"""Moser spindle, exact coordinates in Q(sqrt3, sqrt11) subset Q4. Untrusted generator.

Two equilateral triangles ABC, CBD; rotate B,C,D about A=(0,0) by theta = 2 arcsin(1/(2 sqrt3)),
which has cos = 5/6, sin = sqrt11/6, giving E,F,G. The spindle's 11 edges are all unit length,
including the closing edge D-G.

Coordinates are exported in the four-square-root basis {1, s3, s5, s7, s11, s15, ...} used by Q4,
so M02 can transcribe them directly. Only the sqrt3 and sqrt11 (and their product sqrt33) slots are
nonzero here.
"""
from fractions import Fraction as F
import json, math

PRIMES = [3, 5, 7, 11]
N = 1 << len(PRIMES)
SCALE = [[__import__('functools').reduce(lambda a, b: a*b,
          [PRIMES[k] for k in range(len(PRIMES)) if (i >> k) & 1 and (j >> k) & 1], 1)
          for j in range(N)] for i in range(N)]
ZERO = (F(0),)*N
ONE = (F(1),)+(F(0),)*(N-1)
def sq(m): return tuple(F(1) if i == m else F(0) for i in range(N))
def bit(p): return 1 << PRIMES.index(p)
R3 = sq(bit(3)); R11 = sq(bit(11))
def add(a,b): return tuple(x+y for x,y in zip(a,b))
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
def smul(k,a): return tuple(F(k)*x for x in a)
def mul(a,b):
    out=[F(0)]*N
    for i,ai in enumerate(a):
        if ai:
            for j,bj in enumerate(b):
                if bj: out[i^j]+=ai*bj*SCALE[i][j]
    return tuple(out)
def rat(q): return (F(q),)+(F(0),)*(N-1)

def padd(p,q): return (add(p[0],q[0]), add(p[1],q[1]))
def psub(p,q): return (sub(p[0],q[0]), sub(p[1],q[1]))
def rot(p,c,s):
    x,y=p
    return (sub(mul(c,x),mul(s,y)), add(mul(s,x),mul(c,y)))
def normsq(p): return add(mul(p[0],p[0]), mul(p[1],p[1]))

# equilateral triangles ABC and CBD
A=(rat(0),rat(0))
B=(rat(1),rat(0))
C=(rat(F(1,2)), smul(F(1,2),R3))
D=(rat(F(3,2)), smul(F(1,2),R3))
# rotation cos=5/6 sin=sqrt11/6
c,s = rat(F(5,6)), smul(F(1,6),R11)
E=rot(B,c,s); Ff=rot(C,c,s); G=rot(D,c,s)

V=[A,B,C,D,E,Ff,G]
names=["A","B","C","D","E","F","G"]

# find all unit-distance pairs
edges=[]
for i in range(7):
    for j in range(i+1,7):
        if normsq(psub(V[i],V[j]))==ONE:
            edges.append((i,j))

print("vertices:", file=__import__('sys').stderr)
for nm,p in zip(names,V):
    print(f"  {nm}: ({p[0]}, {p[1]})", file=__import__('sys').stderr)
print(f"unit edges ({len(edges)}):", [(names[i],names[j]) for i,j in edges], file=__import__('sys').stderr)

# export as integer-leaf form: one global denominator per coordinate list
def coords_ints(V):
    # collect all Fractions, find common denom
    from math import gcd
    dens=[]
    for p in V:
        for comp in p:
            for f in comp: dens.append(f.denominator)
    L=1
    for d in dens: L=L*d//gcd(L,d)
    out=[]
    for p in V:
        pc=[]
        for comp in p:
            pc.append([int(f*L) for f in comp])
        out.append(pc)
    return out, L

ints, denom = coords_ints(V)
json.dump({"names":names, "denom":denom, "coords":ints, "edges":edges,
           "primes":PRIMES}, open("tools/spindle.json","w"), indent=1)
print(f"common denominator: {denom}", file=__import__('sys').stderr)
