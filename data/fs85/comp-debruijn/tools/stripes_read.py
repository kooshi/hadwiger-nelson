"""Reading the committed census (all 380 pinned colourings of Lambda/8Lambda): for each, (a) the prime it is local at,
(b) which Eisenstein doublings 2, 2 zeta6, 2 zeta6^2 are periods, (c) whether its restriction to every coset of T0 is a
stripe pattern (two colours per row in the stripe direction, alternating). Reading only; nothing searched."""
import json, gzip, itertools
from lam import *
from classes import H, C, lat, idx, untidx
from twoadic import emb
from collections import Counter
import gzip as _gz
_d = json.load(_gz.open("/home/kooshi/source/lean-dir/data/fs73/census/K-8Lambda-classes-all.json.gz"))
allc = _d["colourings"] if isinstance(_d, dict) and "colourings" in _d else _d
if isinstance(allc, str) or allc is None:
    print('all_colourings field:', type(allc), (allc[:200] if isinstance(allc,str) else allc)); raise SystemExit
print('colourings read:', len(allc))
def pt(t):
    r=(Fr(0),)*4
    for k,h in zip(t,H): r=add(r,sc(k,h))
    return r
XY=[None]*4096
for i in range(4096):
    x=pt(untidx(i)); X=emb(x,1); Y=emb(x,-1)
    XY[i]=(X[0]%8,X[1]%8,Y[0]%8,Y[1]%8)
L1 = lat(ONE); LZ = lat(Z6); LZ2 = lat(mul(Z6,Z6))
def add8(a,b): return tuple((x+y)%8 for x,y in zip(a,b))
def is_period(col, t):
    return all(col[i] == col[idx(add8(untidx(i), t))] for i in range(4096))
stats = Counter()
for s in allc:
    col = [int(ch) for ch in s]
    depX = all(col[i] == col[j] for i in range(4096) for j in [idx(add8(untidx(i), (0,0,0,0)))])  # placeholder
    # local at one prime?  c depends only on X iff constant on fibres of X
    byX = {}; byY = {}
    okX = okY = True
    for i in range(4096):
        kx = XY[i][:2]; ky = XY[i][2:]
        if byX.setdefault(kx, col[i]) != col[i]: okX = False
        if byY.setdefault(ky, col[i]) != col[i]: okY = False
    prime = 'p' if okX else ('p\'' if okY else 'both-dependent')
    per = tuple(is_period(col, tuple(2*x for x in L)) for L in (L1, LZ, LZ2))
    stats[(prime, per)] += 1
for k, v in sorted(stats.items()): print(k, v)
