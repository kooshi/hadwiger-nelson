#!/usr/bin/env python3
"""FS-73 V2: independent check that U(L21cc6506) = {1, v, v̄, z, z̄}·U_R (implementer E's P3b-T2) and construction of the
sub-configurations b·U_R used in data/fs73/records/verify-P3b-q167.md §8.  Usage: fs73v2_b5.py SCRATCH (reads units-L21cc6506.json)."""
# independent check of U = B5 · U_R and construction of sub-configurations {b}·U_R
import json, sys, itertools
from fractions import Fraction as F
S = sys.argv[1]
D, d = 420, 167
U = [tuple(u) for u in json.load(open(f'{S}/units-L21cc6506.json'))['units']]
# element of Q(sqrt d)(i) as (p, q, r, s): (p + q√d) + i (r + s√d), rationals
def mul(x, y):
    (p1,q1,r1,s1),(p2,q2,r2,s2) = x, y
    re_p = p1*p2 + d*q1*q2 - (r1*r2 + d*s1*s2); re_q = p1*q2 + q1*p2 - (r1*s2 + s1*r2)
    im_p = p1*r2 + d*q1*s2 + r1*p2 + d*s1*q2; im_q = p1*s2 + q1*r2 + r1*q2 + s1*p2
    return (re_p, re_q, im_p, im_q)
def from_u(u): return tuple(F(t, D) for t in u)
def to_u(x):
    t = tuple(v*D for v in x)
    assert all(v.denominator == 1 for v in t), x
    return tuple(int(v) for v in t)
UR = [(F(1),0,0,0),(F(-1),0,0,0),(0,0,F(1),0),(0,0,F(-1),0)] + [(F(a,5),0,F(b,5),0) for a,b in itertools.product([3,-3,4,-4],[3,-3,4,-4]) if a*a+b*b==25]
UR = [tuple(F(v) for v in x) for x in UR]
assert len(UR) == 12
v = from_u((415,0,0,5)); z = from_u((225,15,225,-15))
conj = lambda x: (x[0], x[1], -x[2], -x[3])
B5 = {'1': (F(1),F(0),F(0),F(0)), 'v': v, 'vb': conj(v), 'z': z, 'zb': conj(z)}
prods = {name: {to_u(mul(b, x)) for x in UR} for name, b in B5.items()}
allp = set().union(*prods.values())
print('B5·U_R has', len(allp), 'elements; equals U:', allp == set(U))
def pairs(vs):
    out = []
    for u in sorted(vs):
        if tuple(-t for t in u) not in out: out.append(u)
    return out
for combo in [('1','v','z'), ('1','v','zb'), ('1','v','vb'), ('v','z'), ('1','z'), ('1','v'), ('z','zb'), ('1','z','zb'), ('v','vb','z'), ('1','vb','z'), ('1','vb','zb'), ('v','vb','zb'), ('v','z','zb'), ('vb','z','zb')]:
    vs = set().union(*[prods[c] for c in combo])
    json.dump([list(u) for u in pairs(vs)], open(f'{S}/sub-{"-".join(combo)}.json','w'))
    print(combo, len(pairs(vs)), 'pairs')
