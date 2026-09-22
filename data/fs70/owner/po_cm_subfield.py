#!/usr/bin/env python3
"""Owner's screen of the rank-4 lattices inside the six quartic CM subfields of F(i) = Q(sqrt3, sqrt5, i) (FS-70, 2026-09-22).

Phase 1c proved: in E0 = Q(sqrt-3, sqrt-5) every unit vector is a 2-unit (one prime above 2, inert over Q(sqrt15)). The
same argument at every CM subfield E of F(i), at 2 and at 3: a prime of E above p that conjugation FIXES makes every unit
vector a p-unit; a SPLIT pair lets unit vectors have poles.  This script measures it on the atlas-free enumeration of unit
vectors of F to denominator M (po_additive_screen.units_with_denominator), per subfield: how many unit vectors, how many
break the 2-adic wall, how many have 3 in a denominator; then for the one subfield with both, the Z-span LAMBDA of ALL its unit
vectors to denominator M (closed under conjugation and negation, NOT under zeta12, which the field lacks): its rank, whether
1/2 lies in it, and which chainable targets lie in it.  Usage: po_cm_subfield.py [M]   (default 24; 48 takes minutes)"""
import sys
sys.path.insert(0, 'data/fs70/owner')
from po_additive_screen import units_with_denominator
def hnf_cols(vectors, dim=8):
    """integer row-echelon basis of the Z-span of the given integer vectors (copied from po_kempe_screen, which cannot be imported without running its screen)"""
    M_=[list(v) for v in vectors]; basis=[]
    for col in range(dim):
        while True:
            nz=[i for i in range(len(M_)) if M_[i][col]!=0]
            if not nz: break
            i0=min(nz, key=lambda i: abs(M_[i][col])); p=M_[i0][col]; done=True
            for i in nz:
                if i!=i0:
                    q=M_[i][col]//p; M_[i]=[a-q*b for a,b in zip(M_[i],M_[i0])]
                    if M_[i][col]!=0: done=False
            if done:
                basis.append(M_[i0]); M_=[M_[i] for i in range(len(M_)) if i!=i0]; break
    return basis
def member(basis, v):
    v=list(v)
    for b in basis:
        p=next(i for i,x in enumerate(b) if x!=0)
        if v[p]%b[p]!=0: return False
        q=v[p]//b[p]; v=[a-q*c for a,c in zip(v,b)]
    return all(x==0 for x in v)
from math import gcd
from fractions import Fraction as Fr

M = int(sys.argv[1]) if len(sys.argv) > 1 else 24
U = units_with_denominator(M)       # integer 8-tuples (a,b,c,d, e,f,g,h) over M: x=(a+b√3+c√5+d√15)/M, y=(e+f√3+g√5+h√15)/M
print(f"unit vectors of F with denominator dividing {M}: {len(U)}")

def red(v):
    g = 0
    for t in v: g = gcd(g, t)
    g = gcd(g, M)
    return tuple(t // g for t in v), M // g
def v2(n):
    k = 0
    while n % 2 == 0: n //= 2; k += 1
    return k
def has_pole(v, p):
    _, m = red(v)
    return m % p == 0
from sympy import Matrix, Rational
from po_additive_screen import fmul, fadd, fsub
def mult_matrix(x, y, m):
    cols = []
    for k in range(8):
        e = [0]*4; f = [0]*4
        (e if k < 4 else f)[k % 4] = 1
        re = fsub(fmul(x, tuple(e)), fmul(y, tuple(f))); im = fadd(fmul(x, tuple(f)), fmul(y, tuple(e)))
        cols.append([Rational(t, m) for t in re + im])
    return Matrix(cols).T
def p_integral(v, p):
    """z is integral at every prime above p iff the characteristic polynomial of multiplication by z on F(i)/Q has
    p-integral coefficients (the denominator test is wrong at 2: zeta12 = (sqrt3 + i)/2 is a unit)"""
    x, y = v[:4], v[4:]
    return all(Rational(c).q % p != 0 for c in mult_matrix(x, y, M).charpoly().all_coeffs())
def wall_breaking(v):   # a unit vector with a pole at a prime above 2 (equivalently, not 2-integral)
    return not p_integral(v, 2)

# membership tests (basis order 1, √3, √5, √15 in x and in y)
F = {
 'Q(sqrt3,i)':        lambda a,b,c,d,e,f,g,h: c==d==0 and g==h==0,
 'Q(sqrt3,sqrt-5)':   lambda a,b,c,d,e,f,g,h: c==d==0 and e==f==0,
 'Q(sqrt5,i)':        lambda a,b,c,d,e,f,g,h: b==d==0 and f==h==0,
 'Q(sqrt5,sqrt-3)':   lambda a,b,c,d,e,f,g,h: b==d==0 and e==g==0,
 'Q(sqrt15,i)':       lambda a,b,c,d,e,f,g,h: b==c==0 and f==g==0,
 'E0=Q(sqrt15,sqrt-3)': lambda a,b,c,d,e,f,g,h: b==c==0 and e==h==0,
}
print(f"{'subfield':22s} {'units':>6s} {'wall':>5s} {'3-pole':>6s} {'both':>5s}")
mem = {}
for name, t in F.items():
    m = [v for v in U if t(*v)]
    mem[name] = m
    w = sum(wall_breaking(v) for v in m); th = sum(not p_integral(v, 3) for v in m); both = sum(wall_breaking(v) and not p_integral(v, 3) for v in m)
    print(f"{name:22s} {len(m):6d} {w:5d} {th:6d} {both:5d}")

# the lattice of E' = Q(sqrt3, sqrt-5): coordinates (a, b, g, h) over M  (x = a + b√3, y = g√5 + h√15)
name = 'Q(sqrt3,sqrt-5)'
vecs = [(a, b, g, h) for (a, b, c, d, e, f, g, h) in mem[name]]
basis = hnf_cols(vecs, dim=4)
print(f"\nLambda' = Z-span of the {len(vecs)} unit vectors of {name} to denominator {M}: rank {len(basis)}; HNF rows {basis}")
def inL(x0, x1, y2, y3):  # rationals
    from fractions import Fraction as Fr
    v = [Fr(x0) * M, Fr(x1) * M, Fr(y2) * M, Fr(y3) * M]
    if any(t.denominator != 1 for t in v): return False
    return member(basis, [int(t) for t in v])
print("1/2 in Lambda':", inL(Fr(1,2),0,0,0), " 1/3:", inL(Fr(1,3),0,0,0), " 1/4:", inL(Fr(1,4),0,0,0))
for nm, (p, q) in {'2':(2,1), '4/3':(4,3), '8/3':(8,3), '4':(4,1), '4/7':(4,7), '2/3':(2,3)}.items():
    print(f"  target {nm:4s} in Lambda': {inL(Fr(p,q),0,0,0)}")
# 4/sqrt3 = (4/3)√3 : x = (0, 4/3)
print(f"  target 4/√3 in Lambda': {inL(0, Fr(4,3), 0, 0)}")
# count of the field's unit vectors that lie in Lambda' among those to denominator M (all of them by construction) and the
# density: unit vectors per denominator class
from collections import Counter
print("denominators of E' unit vectors:", dict(sorted(Counter(red(v)[1] for v in mem[name]).items())))
print("E' unit vectors: 2-units", sum(p_integral(v,2) for v in mem[name]), " wall-breaking", sum(not p_integral(v,2) for v in mem[name]), " 3-units", sum(p_integral(v,3) for v in mem[name]))
