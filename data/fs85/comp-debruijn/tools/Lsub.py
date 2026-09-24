"""For the non-tight L-types: is some SUB-generating set (a union of classes zeta6^a eta^b, b in a chosen set B, closed under b -> -b)
Hoffman-tight on Lambda/L at four colours with every least character trivial on 8 Lambda? Then every colouring of the full graph
(which colours the subgraph) is 8Lambda-periodic. Exact-shape computation: characters of Lambda/L, simple graph on distinct images."""
import itertools, numpy as np, sympy
from sympy.matrices.normalforms import smith_normal_form
from lam import *
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6))
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
def lc(a): return [int(9*x) for x in coords(a)]
dirs = [ONE, Z6, mul(Z6,Z6)]
UB = {}
for b in range(-4,5):
    UB[b] = np.array([lc(mul(pw(Z6,a), pw(eta,b))) for a in range(6)])
def analyse(choice, Bset):
    G = np.array([lc(sc(2, mul(pw(eta,k), dirs[e]))) for k, e in zip(range(-2,3), choice)])
    D = smith_normal_form(sympy.Matrix(G.tolist()), domain=sympy.ZZ)
    N = max(abs(int(D[i,i])) for i in range(4))
    grid = np.array(list(itertools.product(range(N), repeat=4)), dtype=np.int64)
    T = grid[np.all((grid @ G.T) % N == 0, axis=1)]
    UC = np.concatenate([UB[b] for b in sorted(Bset)])
    phase = (T @ UC.T) % N
    cols = {}
    for j in range(UC.shape[0]): cols.setdefault(tuple(phase[:, j]), j)
    rep = list(cols.values())
    if any(all(p == 0 for p in col) for col in cols): return None   # a generator in L: loop, not colourable
    ev = np.cos(2*np.pi*phase[:, rep]/N).sum(axis=1)
    dd = len(rep); lmin = ev.min()
    mins = T[np.abs(ev - lmin) < 1e-9]
    return (dd, round(float(lmin),6), abs(lmin + dd/3) < 1e-9, bool(np.all((8*mins) % N == 0)))
reps = {'census-type (6,6,6,48)': (0,1,2,0,1), '(6,6,6,12) deg40': None, '(6,6,6,30)': (0,0,1,1,0), '(6,6,6,42)': (0,0,1,2,2), '(6,6,12,12)': (0,0,0,0,0)}
# find a representative of (6,6,6,12) deg 40: scan choices quickly for that signature
Bfull = set(range(-4,5))
for choice in itertools.product(range(3), repeat=5):
    r = analyse(choice, Bfull)
    if r and r[0] == 40: reps['(6,6,6,12) deg40'] = choice; break
Bopts = []
for mask in range(1, 32):
    S = {b for b in range(5) if mask >> b & 1}
    Bopts.append(sorted(S | {-b for b in S}))
for name, choice in reps.items():
    good = []
    for B in Bopts:
        r = analyse(choice, set(B))
        if r and r[2] and r[3]: good.append((tuple(b for b in B if b >= 0), r[0]))
    print(name, choice, ' tight & 8Lambda-pure sub-generating sets (|b| used, degree):', good if good else 'NONE')
