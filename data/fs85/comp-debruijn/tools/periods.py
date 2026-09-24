"""If every coset of eta^k T0 (|k| <= 2) is striped, all with one direction eta^k eps_k per orientation (derived via the corrected
Cor. 5), the colouring is periodic under L = <2 eta^k eps_k : |k| <= 2>. Exact: the index of L in Lambda and whether L contains 8 Lambda,
for every choice of the five directions (3^5 = 243)."""
import itertools, sympy
from sympy.matrices.normalforms import smith_normal_form
from lam import *
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6))
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
def lc(a): return [int(9*x) for x in coords(a)]     # coordinates in the Z-basis (1/9)(1, z6, w, z6 w) of Lambda
dirs = [ONE, Z6, mul(Z6,Z6)]
from collections import Counter
stats = Counter(); examples = {}
for choice in itertools.product(range(3), repeat=5):
    gens = [lc(sc(2, mul(pw(eta,k), dirs[e]))) for k, e in zip(range(-2,3), choice)]
    M = sympy.Matrix(gens)                      # rows = generators
    snf = smith_normal_form(M, domain=sympy.ZZ)
    d = [abs(snf[i,i]) for i in range(4)]
    rank = sum(1 for x in d if x != 0)
    if rank < 4:
        key = ('rank', rank); stats[key] += 1; continue
    # L contains 8 Lambda iff every elementary divisor divides 8
    contains8 = all(8 % x == 0 for x in d)
    key = (tuple(d), contains8); stats[key] += 1; examples.setdefault(key, choice)
for k, v in sorted(stats.items(), key=lambda kv: -kv[1]): print(k, v, 'e.g.', examples.get(k))
