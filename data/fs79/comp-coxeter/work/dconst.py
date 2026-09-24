"""On an induced square at k=4 (parity-dependent edge-local zeta): is {zeta : d zeta constant (per parity)} equal to {zeta : d zeta = 0}?"""
import itertools
from local_forms import rank
k = 4; P = [0, 1]
pairs = [(a,b) for a in range(k) for b in range(k) if a != b]
idx = {}
for dr in range(2):
    for ab in pairs:
        for p in P: idx[(dr,ab,p)] = len(idx)
n0 = len(idx); n = n0 + 2          # two extra unknowns: the constant value of d zeta at base parity 0 and 1
def F(dr, a, b, p):
    v = [0]*n; v[idx[(dr,(a,b),p % 2)]] = 1; return v
eq0, eqc = [], []
for p in P:
    for a,b,c,d in itertools.product(range(k), repeat=4):
        if a==b or b==c or c==d or d==a: continue
        v = [x+y-z-w for x,y,z,w in zip(F(0,a,b,p), F(1,b,c,p+1), F(1,a,d,p), F(0,d,c,p+1))]
        eq0.append(v)
        w = list(v); w[n0 + p] = -1; eqc.append(w)
print('dim{d zeta = 0} =', n - 2 - rank([r[:n0] for r in eq0], n0), '| dim{d zeta = const}, projected to zeta:',
      'closed', n - rank(eqc, n), '(includes the 2 constants if they are free)')
