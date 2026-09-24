"""Exact-ish spectrum of Cay(Lambda/8Lambda, U mod 8) in 2-adic coordinates: eigenvalue at character v is
sum_u cos(2 pi v.u / 8). Values are in Z[sqrt2]; computed as a + b sqrt2 exactly."""
import itertools
from lam import *
from twoadic import emb
from collections import Counter
U = load_U()
UXY = [(emb(u,1)[0]%8, emb(u,1)[1]%8, emb(u,-1)[0]%8, emb(u,-1)[1]%8) for u in U]
mult = Counter(UXY)
print('U mod 8: %d vectors, %d distinct, multiplicities %s' % (len(UXY), len(mult), sorted(Counter(mult.values()).items())))
# cos(2 pi k/8) = (1, s/2, 0, -s/2, -1, -s/2, 0, s/2), s = sqrt2 ; represent as (a, b) meaning a + b*s/2
COS = [(1,0),(0,1),(0,0),(0,-1),(-1,0),(0,-1),(0,0),(0,1)]
def eig(v, gens):
    a = b = 0
    for u, m in gens.items():
        k = sum(x*y for x, y in zip(v, u)) % 8
        a += m*COS[k][0]; b += m*COS[k][1]
    return (a, b)  # a + b*sqrt2/2
import math
ALL = list(itertools.product(range(8), repeat=4))
for name, gens in [('multiset U (54)', mult), ('simple U mod 8 (36)', Counter({u:1 for u in mult}))]:
    ev = Counter(eig(v, gens) for v in ALL)
    vals = sorted(ev.items(), key=lambda kv: kv[0][0] + kv[0][1]*math.sqrt(2)/2)
    d = sum(gens.values())
    lmin = vals[0][0]
    print(name, 'd =', d, ' lambda_min =', lmin, '= %.6f' % (lmin[0] + lmin[1]*math.sqrt(2)/2), ' multiplicity', vals[0][1],
          ' tight at 4 needs', -d/3)
    print('   lowest five eigenvalues:', [(k, m, round(k[0]+k[1]*math.sqrt(2)/2, 4)) for k, m in vals[:5]])
    minchars = [v for v in ALL if eig(v, gens) == lmin]
    print('   minimising characters (x0,x1,y0,y1):', minchars[:24])

simple = Counter({u:1 for u in mult})
lmin = (-12, 0)
Emin = [v for v in ALL if eig(v, simple) == lmin]
pureX = [v for v in Emin if v[2] == 0 and v[3] == 0]; pureY = [v for v in Emin if v[0] == 0 and v[1] == 0]
print('|E_min| =', len(Emin), ' pure-X', len(pureX), ' pure-Y', len(pureY), ' mixed', len(Emin) - len(pureX) - len(pureY))
print('pure-X chars:', pureX)
# projections of the 36 generators
projX = Counter((u[0],u[1]) for u in mult); projY = Counter((u[2],u[3]) for u in mult)
print('projection to X: %d distinct, multiplicities %s' % (len(projX), sorted(Counter(projX.values()).items())))
print('projection to Y: %d distinct, multiplicities %s' % (len(projY), sorted(Counter(projY.values()).items())))
print('X-images:', sorted(projX))
# G3 = Cay(Z/8[zeta3], S3) with S3 = projX set; its spectrum
G3 = Counter({x:1 for x in projX})
ALL2 = list(itertools.product(range(8), repeat=2))
def eig2(v, gens):
    a=b=0
    for u,m in gens.items():
        k=(v[0]*u[0]+v[1]*u[1])%8; a+=m*COS[k][0]; b+=m*COS[k][1]
    return (a,b)
ev2 = Counter(eig2(v, G3) for v in ALL2)
print('G3 degree', len(G3), ' spectrum', sorted(((k, round(k[0]+k[1]*math.sqrt(2)/2,4), m) for k, m in ev2.items()), key=lambda t: t[1]))
# sanity: norm-one group mod 8 of Z/8[zeta3]: x*conj(x) = 1
def zm(x,y): return ((x[0]*y[0]-x[1]*y[1])%8, (x[0]*y[1]+x[1]*y[0]-x[1]*y[1])%8)
def zc(x): return ((x[0]-x[1])%8, (-x[1])%8)
S3 = [x for x in ALL2 if zm(x, zc(x)) == (1,0)]
print('norm-one group mod 8 has', len(S3), 'elements; equals X-image set:', sorted(S3) == sorted(projX))
