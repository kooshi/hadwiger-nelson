"""G3 = Cay(Z/8[zeta3], S3), S3 = norm-one group mod 8 = mu6 * {1, 5}; in the basis (1, zeta6), coordinates (m, n) mod 8.
Exact spectrum by characters chi_(a,b)(m,n) = w8^(a m + b n); E_min split by the three Eisenstein directions."""
import itertools, math
from collections import Counter
# zeta6 basis: zeta6^2 = zeta6 - 1.  mu6 = +-1, +-zeta6, +-(zeta6 - 1)
mu6 = [(1,0),(7,0),(0,1),(0,7),(7,1),(1,7)]
S3 = sorted({((k*a)%8, (k*b)%8) for (a,b) in mu6 for k in (1,5)})
assert len(S3) == 12
COS = [(1,0),(0,1),(0,0),(0,-1),(-1,0),(0,-1),(0,0),(0,1)]
def eig(v):
    a=b=0
    for u in S3:
        k=(v[0]*u[0]+v[1]*u[1])%8; a+=COS[k][0]; b+=COS[k][1]
    return (a,b)
ALL=list(itertools.product(range(8),repeat=2))
spec = Counter(eig(v) for v in ALL)
print('spectrum:', sorted(((k[0]+k[1]*math.sqrt(2)/2, m) for k,m in spec.items())))
Emin = [v for v in ALL if eig(v) == (-4,0)]
# direction classes: character trivial on 2*eps
dirs = {'1': (1,0), 'z6': (0,1), 'z6^2': (7,1)}
def triv(v, e): return (2*(v[0]*e[0] + v[1]*e[1])) % 8 == 0
V0 = [v for v in Emin if all(triv(v,e) for e in dirs.values())]
V = {k: [v for v in Emin if triv(v,e) and v not in V0] for k,e in dirs.items()}
print('E_min', len(Emin), ' V0 (level 1):', V0)
for k in V: print('  V_%s:' % k, V[k])
print('partition complete:', len(V0) + sum(len(x) for x in V.values()) == len(Emin),
      ' disjoint:', len(set(V0) | set().union(*map(set, V.values()))) == len(Emin))
def sumset(A, B): return {((a[0]+b[0])%8, (a[1]+b[1])%8) for a in A for b in B}
base = set([(0,0)]) | set(Emin)
keys = ['0','1','z6','z6^2']; comp = {'0': V0, **V}
SS = {(p,q): sumset(comp[p], comp[q]) for i,p in enumerate(keys) for q in keys[i:]}
for (p,q), s in SS.items():
    if p == q or p == '0': continue
    others = set().union(*[s2 for (p2,q2), s2 in SS.items() if (p2,q2) != (p,q)])
    print('V_%s + V_%s: %d chars; meets {0}+E_min: %d; meets other sumsets: %d' % (p, q, len(s), len(s & base), len(s & others)))
