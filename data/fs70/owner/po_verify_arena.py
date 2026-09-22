#!/usr/bin/env python3
"""Owner's verifier for a phase-1c arena (FS-70), independent of tools/fs70_*: the arena's complete unit-distance graph is
re-derived from its point set alone -- a float grid of side 1/4 proposes every pair at distance 1 +- tol (cell range derived
from the tolerance, so nothing straddles out), exact arithmetic over Q(sqrt3, sqrt5) decides -- compared with the file's edge
list, and the committed colouring is checked on MY edges.  A plant (--plant) drops one edge from my derivation and must be
reported as a disagreement.  Usage: po_verify_arena.py GRAPH.json COLOURING(.json|.json.gz) [--plant]"""
import sys, json, gzip, math
from fractions import Fraction as Fr
from collections import defaultdict
S3,S5,S15=3**.5,5**.5,15**.5
def ff(a): return float(a[0])+float(a[1])*S3+float(a[2])*S5+float(a[3])*S15
def fmul(a,b):
    a0,a1,a2,a3=a; b0,b1,b2,b3=b
    return (a0*b0+3*a1*b1+5*a2*b2+15*a3*b3, a0*b1+a1*b0+5*(a2*b3+a3*b2), a0*b2+a2*b0+3*(a1*b3+a3*b1), a0*b3+a3*b0+a1*b2+a2*b1)
def fsub(a,b): return tuple(x-y for x,y in zip(a,b))
def fadd(a,b): return tuple(x+y for x,y in zip(a,b))
ONE=(Fr(1),Fr(0),Fr(0),Fr(0))
g=json.load(open(sys.argv[1])); M=g['M']
P=[(tuple(Fr(t,M) for t in p[:4]), tuple(Fr(t,M) for t in p[4:])) for p in g['points']]
E=set((min(a,b),max(a,b)) for a,b in g['edges'])
n=len(P); print(f"{sys.argv[1]}: {n} points over M={M}, file edges {len(E)}")
cell=0.25; tol=1e-7
grid=defaultdict(list); X=[ff(p[0]) for p in P]; Y=[ff(p[1]) for p in P]
for i in range(n): grid[(math.floor(X[i]/cell),math.floor(Y[i]/cell))].append(i)
R=int((1+tol)/cell)+2
mine=set()
for i in range(n):
    cx,cy=math.floor(X[i]/cell),math.floor(Y[i]/cell)
    for dx in range(-R,R+1):
        for dy in range(-R,R+1):
            for j in grid.get((cx+dx,cy+dy),()):
                if j<=i: continue
                if abs((X[i]-X[j])**2+(Y[i]-Y[j])**2-1.0)<=tol:
                    d=(fsub(P[i][0],P[j][0]),fsub(P[i][1],P[j][1]))
                    if fadd(fmul(d[0],d[0]),fmul(d[1],d[1]))==ONE: mine.add((i,j))
if '--plant' in sys.argv:
    e=next(iter(mine)); mine.discard(e); print(f"PLANT: dropped my edge {e}")
print(f"my edges {len(mine)}; equal to file: {mine==E}; missing-from-file {len(mine-E)}; extra-in-file {len(E-mine)}")
cpath=sys.argv[2]; c=json.load(gzip.open(cpath) if cpath.endswith('.gz') else open(cpath))
col=c['colour'] if isinstance(c,dict) else c
assert len(col)==n, f"colouring length {len(col)} != {n}"
bad=sum(1 for i,j in mine if col[i]==col[j])
print(f"colouring: {len(set(col))} colours, monochromatic edges under MY derivation: {bad}")
sys.exit(0 if (mine==E and bad==0) else 1)
