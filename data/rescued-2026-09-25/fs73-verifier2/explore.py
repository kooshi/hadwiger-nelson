import json, sys, itertools
from fractions import Fraction as F
sys.path.insert(0, 'tools')
from fs73v2_units import det, solve, hnf
name = sys.argv[1]
info = json.load(open(f'{sys.argv[2]}/units-{name}.json'))
d, D = info['d'], info['D']
pos = [tuple(u) for u in info['pos']]
spanB = info['span_hnf']
ds = abs(det(spanB))
# index histogram of 4-subsets
from collections import Counter
h = Counter()
best = None
for quad in itertools.combinations(range(len(pos)), 4):
    M = [list(pos[i]) for i in quad]
    k = abs(det(M)) / ds
    h[k] += 1
print('index histogram (4-subsets of U+):', sorted(h.items())[:12])
# LLL with Q = a^2 + d b^2 + c^2 + d e^2
W = [1, d, 1, d]
def ip(x, y): return sum(F(W[i]) * x[i] * y[i] for i in range(4))
def lll(B, delta=F(3,4)):
    B = [list(b) for b in B]
    n = len(B)
    def gs(B):
        Bs = []; mu = [[F(0)]*n for _ in range(n)]
        for i in range(n):
            v = [F(x) for x in B[i]]
            for j in range(i):
                mu[i][j] = ip(B[i], Bs[j]) / ip(Bs[j], Bs[j])
                v = [v[k] - mu[i][j]*Bs[j][k] for k in range(4)]
            Bs.append(v)
        return Bs, mu
    k = 1
    while k < n:
        Bs, mu = gs(B)
        for j in range(k-1, -1, -1):
            q = round(mu[k][j])
            if q:
                B[k] = [B[k][i] - q*B[j][i] for i in range(4)]
                Bs, mu = gs(B)
        if ip(Bs[k], Bs[k]) >= (delta - mu[k][k-1]**2) * ip(Bs[k-1], Bs[k-1]):
            k += 1
        else:
            B[k], B[k-1] = B[k-1], B[k]
            k = max(k-1, 1)
    return B
B = lll(spanB)
print('LLL basis:', B, 'norms Q/D^2:', [float(ip(b,b)/D**2) for b in B])
C = [[int(x) for x in solve(B, list(u))] for u in pos]
print('coords of U+ in LLL basis:')
for u, c in zip(pos, C): print(u, c, 'L1', sum(map(abs,c)))
print('sum L1:', sum(sum(map(abs,c)) for c in C))
