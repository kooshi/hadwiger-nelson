#!/usr/bin/env python3
"""Owner's stress test of plan §3.4's 'dead on every 2-unit lattice': the screen on the lattice spanned by ALL 2-unit
unit vectors with denominator <= DMAX (2-integrality decided by the characteristic polynomial over Q having odd denominators),
constrained by all of them.  Survivors with phi(i sqrt3)=0 are an UPPER bound on what any richer 2-unit lattice allows."""
import sys, itertools
from fractions import Fraction
from math import gcd
sys.path.insert(0, 'data/fs70/owner')
from po_additive_screen import units_with_denominator, fmul, fadd, fsub
from sympy import Matrix, Rational
from sympy.matrices.normalforms import hermite_normal_form

DMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 14

def mult_matrix(z):
    """8x8 rational matrix of multiplication by z = (x, y) over denominator m on E = F(i) with basis
    {1,√3,√5,√15} ⊗ {1, i}."""
    (x, y), m = z
    cols = []
    for k in range(8):
        e = [0]*4; f = [0]*4
        (e if k < 4 else f)[k % 4] = 1
        # (x + iy)(e + if) = (xe - yf) + i(xf + ye)
        re = fsub(fmul(x, tuple(e)), fmul(y, tuple(f)))
        im = fadd(fmul(x, tuple(f)), fmul(y, tuple(e)))
        cols.append([Rational(v, m) for v in re + im])
    return Matrix(cols).T

def two_integral(z):
    p = mult_matrix(z).charpoly()
    return all(Rational(c).q % 2 == 1 for c in p.all_coeffs())

units = {}
for d in range(1, DMAX + 1):
    for vec in units_with_denominator(d):
        g = 0
        for v in vec + (d,):
            g = gcd(g, abs(v))
        key = tuple(v // g for v in vec) + (d // g,)
        units[key] = key
units = list(units)
z_of = lambda key: ((key[0:4], key[4:8]), key[8])
twou = [k for k in units if two_integral(z_of(k))]
print(f"unit vectors with denominator <= {DMAX}: {len(units)}; 2-units among them: {len(twou)}")
from collections import Counter
print("2-units by denominator:", sorted(Counter(k[8] for k in twou).items()))

M = 1
for k in twou:
    M = M * k[8] // gcd(M, k[8])
print("lattice denominator M =", M)
def to_vec(key):
    return tuple(v * (M // key[8]) for v in key[:8])
G = Matrix([list(to_vec(k)) for k in twou])
H = hermite_normal_form(G.T)
B = [tuple(int(v) for v in H[:, j]) for j in range(H.shape[1]) if any(H[:, j])]
Bm = Matrix(B).T
print("rank", len(B))
def coords(vec):
    sol = Bm.solve(Matrix(vec))
    cs = [Fraction(int(s.p), int(s.q)) for s in sol]
    return [int(c) for c in cs] if all(c.denominator == 1 for c in cs) else None
LU = [coords(to_vec(k)) for k in twou]
assert all(c is not None for c in LU)
def tv(x, y, m):
    return tuple(v * (M // m) for v in x + y)
targets = {"i√3": coords(tv((0,0,0,0),(0,1,0,0),1)), "2": coords(tv((2,0,0,0),(0,0,0,0),1)),
           "4/3": coords(tv((4,0,0,0),(0,0,0,0),3)), "8/3": coords(tv((8,0,0,0),(0,0,0,0),3))}
print("targets in lattice:", {k: v is not None for k, v in targets.items()})
rank = len(B)
for name, addf, neg in (("Z/4", lambda a,b:(a+b)%4, lambda a:(-a)%4), ("Klein", lambda a,b:a^b, lambda a:a)):
    count = 0; kills = {k: 0 for k in targets}
    for phi in itertools.product(range(4), repeat=rank):
        def ev(c):
            s = 0
            for ci, pi in zip(c, phi):
                q = pi if ci > 0 else neg(pi)
                for _ in range(abs(ci) % 4):
                    s = addf(s, q)
            return s
        if all(ev(c) != 0 for c in LU):
            count += 1
            for k, c in targets.items():
                if c is not None and ev(c) == 0:
                    kills[k] += 1
    print(f"{name}: proper additive colourings {count}; φ(target)=0 counts {kills}")
