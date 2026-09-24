"""For each choice of stripe directions eps_k (|k| <= 2), L = <2 eta^k eps_k>. Spectrum of the simple Cayley graph Cay(Lambda/L, U mod L)
via characters t in (1/N)Z^4 / Z^4 vanishing on L (N = the largest elementary divisor). Report: 4-colour Hoffman tightness, and whether
every least character is trivial on 8 Lambda (then every L-periodic four-colouring is 8Lambda-periodic, by the Hoffman equality case).
Floats with tolerance 1e-9 (aiming); the decisive rows are re-checked exactly afterwards."""
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
U = load_U(); UC = np.array([lc(u) for u in U])
dirs = [ONE, Z6, mul(Z6,Z6)]
results = {}
for choice in itertools.product(range(3), repeat=5):
    G = np.array([lc(sc(2, mul(pw(eta,k), dirs[e]))) for k, e in zip(range(-2,3), choice)])
    D = smith_normal_form(sympy.Matrix(G.tolist()), domain=sympy.ZZ)
    d = tuple(abs(int(D[i,i])) for i in range(4))
    N = max(d)
    key = d
    # characters: t in (Z/N)^4 with G t = 0 mod N
    grid = np.array(list(itertools.product(range(N), repeat=4)), dtype=np.int64)
    ok = np.all((grid @ G.T) % N == 0, axis=1)
    T = grid[ok]
    assert len(T) == int(np.prod(d)), (len(T), d)
    # distinct generator images mod L: u ~ u' iff every character agrees on them
    phase = (T @ UC.T) % N          # (chars, 54)
    cols = {}
    for j in range(len(U)): cols.setdefault(tuple(phase[:, j]), j)
    rep = list(cols.values())
    ev = np.cos(2*np.pi*phase[:, rep]/N).sum(axis=1)
    dd = len(rep); lmin = ev.min()
    tight = abs(lmin + dd/3) < 1e-9
    mins = T[np.abs(ev - lmin) < 1e-9]
    triv8 = bool(np.all((8*mins) % N == 0))
    results[choice] = (d, dd, round(lmin, 6), tight, triv8, len(mins))
from collections import Counter
c = Counter((v[0], v[1], v[2], v[3], v[4]) for v in results.values())
print('(elementary divisors, degree, lambda_min, tight at 4, least chars trivial on 8Lambda) : count')
for k, v in sorted(c.items(), key=lambda kv: -kv[1]): print(k, v)
