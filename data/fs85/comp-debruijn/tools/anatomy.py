"""Anatomy of the 12 committed colouring classes of de Grey's lattice in 2-adic coordinates (X, Y) in (Z/8[zeta3])^2."""
import json, itertools
from lam import *
from classes import H, C, lat, idx, untidx
from twoadic import emb
def pt(t):  # element of Lambda with H-coordinates t
    r = (Fr(0),)*4
    for k, h in zip(t, H): r = add(r, sc(k, h))
    return r
cells = {}
XY = [None]*4096
for i in range(4096):
    x = pt(untidx(i))
    X = emb(x, 1); Y = emb(x, -1)
    key = (X[0]%8, X[1]%8, Y[0]%8, Y[1]%8)
    XY[i] = key
    cells.setdefault(key, []).append(i)
print('Lambda/8Lambda -> (O/p^3 x O/p\'^3) bijective:', len(cells) == 4096)
inv = {v: i for i, v in enumerate(XY)}
U = load_U()
UXY = sorted({(emb(u,1)[0]%8, emb(u,1)[1]%8, emb(u,-1)[0]%8, emb(u,-1)[1]%8) for u in U})
print('distinct images of U mod 8 in (X,Y):', len(UXY))
reps = C['orbit_representatives']
def colour_fn(s):
    col = [int(ch) for ch in s]
    return {XY[i]: col[i] for i in range(4096)}
def plus(a, b): return tuple((x+y) % 8 for x, y in zip(a, b))
ALL = list(itertools.product(range(8), repeat=4))
for k, s in reps.items():
    f = colour_fn(s)
    per = [t for t in ALL if all(f[p] == f[plus(p, t)] for p in ALL)]
    # smallest generating set description: list elements of Per of "low level"
    print('rep', k, '|Per| =', len(per))

print('--- annihilators (characters v with v.t = 0 mod 8 on Per), coordinates (x0,x1,y0,y1), X = x0 + x1 zeta3')
def ann(per):
    return [v for v in ALL if all(sum(a*b for a,b in zip(v,t)) % 8 == 0 for t in per)]
def gens(group):
    # greedy generating set of a subgroup of (Z/8)^4
    span = {(0,0,0,0)}; g = []
    for v in sorted(group, key=lambda v: (-max((8//__import__('math').gcd(8, x) if x else 1) for x in v), v)):
        if v in span: continue
        g.append(v)
        new = set(span)
        for k in range(8):
            kv = tuple((k*x) % 8 for x in v)
            for s0 in span: new.add(plus(s0, kv))
        span = new
    return g
PER = {}
for k, s in reps.items():
    f = colour_fn(s)
    per = [t for t in ALL if all(f[p] == f[plus(p, t)] for p in ALL)]
    PER[k] = (f, per)
    A = ann(per)
    print('rep', k, 'index', 4096//len(per), 'annihilator generators:', gens(A))
