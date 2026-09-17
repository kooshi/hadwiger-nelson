#!/usr/bin/env python3
"""fs58_box -- FS-58 phase B2: box pieces of Cay(ℤ[W0], W0) (a direction pool from tools/fs58_chain.py pool), LLL-reduced in the
Minkowski embedding; for the shortest directions w: identify (0, 2w) [UNSAT = a virtual edge], separate (0, 3w) [UNSAT = forced
equal], identify (0, 3w) [the control: affine colourings identify 3w, so it must be SAT]. Verdicts are the solver's claims.
Usage: fs58_box.py POOL.json R NU. Plan: plans/FS58-four-colours.md §R-B2. UNTRUSTED (tools/).
"""
import json, sys, math, itertools, time
from pysat.solvers import Cadical195
f = sys.argv[1]; R = int(sys.argv[2]); nu = int(sys.argv[3])
p = json.load(open(f)); d, N = p['D'], p['N']; B = [list(b) for b in p['basis']]; W0 = [tuple(w) for w in p['W0']]
sq = math.sqrt(d)
emb = lambda v: [(v[0] + v[1]*sq)/N, (v[2] + v[3]*sq)/N, (v[0] - v[1]*sq)/N, (v[2] - v[3]*sq)/N]
def lll(Bm, delta=0.99):
    Bm = [list(b) for b in Bm]; n = len(Bm)
    def gso(Bm):
        E = [emb(b) for b in Bm]; Bs = []; mu = [[0.0]*n for _ in range(n)]
        for i in range(n):
            v = E[i][:]
            for j in range(i):
                mu[i][j] = sum(a*b for a, b in zip(E[i], Bs[j])) / sum(a*a for a in Bs[j])
                v = [a - mu[i][j]*b for a, b in zip(v, Bs[j])]
            Bs.append(v)
        return Bs, mu
    k = 1
    while k < n:
        Bs, mu = gso(Bm)
        for j in range(k-1, -1, -1):
            q = round(mu[k][j])
            if q:
                Bm[k] = [a - q*b for a, b in zip(Bm[k], Bm[j])]
                Bs, mu = gso(Bm)
        nk = sum(a*a for a in Bs[k]); nk1 = sum(a*a for a in Bs[k-1])
        if nk >= (delta - mu[k][k-1]**2) * nk1: k += 1
        else: Bm[k], Bm[k-1] = Bm[k-1], Bm[k]; k = max(k-1, 1)
    return Bm
Bred = lll(B)
# coordinates of generators in Bred (exact, by solving the integer system)
from fractions import Fraction as Fr
def solve(Bm, v):
    M = [[Fr(Bm[i][j]) for i in range(4)] + [Fr(v[j])] for j in range(4)]
    for c in range(4):
        piv = next(r for r in range(c, 4) if M[r][c] != 0); M[c], M[piv] = M[piv], M[c]
        for r in range(4):
            if r != c and M[r][c] != 0:
                fct = M[r][c] / M[c][c]; M[r] = [a - fct*b for a, b in zip(M[r], M[c])]
    x = [M[i][4] / M[i][i] for i in range(4)]
    assert all(t.denominator == 1 for t in x); return tuple(int(t) for t in x)
G = [solve(Bred, w) for w in W0]
for g, w in zip(G, W0): assert tuple(sum(g[i]*Bred[i][j] for i in range(4)) for j in range(4)) == w
print(f"{f}: d={d} N={N} |W0|={len(W0)} reduced max coord {max(max(map(abs,g)) for g in G)}")
side = 2*R+1; n = side**4
idx = lambda x: ((x[0]+R)*side + (x[1]+R))*side*side + (x[2]+R)*side + (x[3]+R)
inside = lambda x: all(-R <= c <= R for c in x)
var = lambda v, c: 3*v + c + 1
s = Cadical195(); E = 0
for v in range(n): s.add_clause([var(v,0), var(v,1), var(v,2)])
half = [g for g in G if g > tuple(-x for x in g)]
for x in itertools.product(range(-R, R+1), repeat=4):
    i = idx(x)
    for g in half:
        y = tuple(a+b for a, b in zip(x, g))
        if inside(y):
            E += 1
            for c in range(3): s.add_clause([-var(i,c), -var(idx(y),c)])
z = (0,0,0,0); s.add_clause([var(idx(z), 0)])
print(f"  R={R}: {n} points, {E} edges, mean degree {2*E/n:.1f}; 3-colourable: {s.solve()}", flush=True)
reps = []
for g in G:
    if tuple(-x for x in g) not in reps: reps.append(g)
reps.sort(key=lambda g: max(map(abs, g)))
nxt = 3*n + 1
for u in reps[:nu]:
    out = []
    for k, mode in ((2, 'identify'), (3, 'separate'), (3, 'identify')):
        q = tuple(k*c for c in u)
        if not inside(q): out.append(f"{mode} {k}w: outside"); continue
        sel = nxt; nxt += 1
        for c in range(3):
            s.add_clause([-sel, -var(idx(z),c), var(idx(q),c)] if mode == 'identify' else [-sel, -var(idx(z),c), -var(idx(q),c)])
        r = s.solve(assumptions=[sel])
        out.append(f"{mode} {k}w: {'SAT' if r else 'UNSAT'}")
    print(f"  u={u}: " + "; ".join(out), flush=True)
