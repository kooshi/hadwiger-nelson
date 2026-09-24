"""Verifier 2 -- the exact facts W3's proof rests on (each asserted; run with --plant N to plant fault N and watch it fire).

On one component M = L5 = (1/3)O_E (every component is a translate):
 F1  Theta_5(M) has 90 characters: 21 trivial on (1/3)beta^3 O (P+-local), 21 trivial on (1/3)beta'^3 O (P- local), 48 of order 10;
     no 2-power character is mixed; the 0 character is absent.
 F2  every order-10 character is alpha + psi with alpha one of the six order-2 characters local at P+ or P- (A+ u A-), psi of order 5;
     for each alpha, the 5-parts L_alpha are the nonzero points of exactly two distinct lines of the dual of M/5M.
 F3  within A+ (and within A-) the sets L_alpha are pairwise disjoint (six distinct lines each side).
 F4  A+ is exactly the three nonzero characters of M/(1/3)P+ ~ F4, A- likewise (so every nonzero character of the residue field occurs).
 F5  U5 generates M/5M.
 F6  (the alternative route's check) for each prime and each delta in F4^*, the 5-residues of {u in U5 : u = delta mod P} have
     differences spanning M/5M.
"""
import sys
from collections import Counter
from lat import *
from theta import theta_set, order, value

PLANT = int(sys.argv[sys.argv.index("--plant") + 1]) if "--plant" in sys.argv else 0

UM = {key: tuple(c // 3 for c in v) for key, v in ULAM.items() if abs(key[1]) <= 2}
K5 = list(range(-2, 3))
if PLANT == 1:           # fault: drop a family from the hypothesis
    K5 = [-2, -1, 0, 1]
if PLANT == 2:           # fault: a wrong unit vector for (1, 1)
    UM = dict(UM); UM[(1, 1)] = tuple(a + (1 if i == 0 else 0) for i, a in enumerate(UM[(1, 1)]))
Th = theta_set(K5, UM, [0, 1, -1, 2] if len(K5) == 5 else [0, 1, -1, -2])

BETA = scal(Fr(1, 2), add(scal(5, ONE), scal(-1, mul(SQRTm3, SQRTm11))))
BETAb = scal(Fr(1, 2), add(scal(5, ONE), mul(SQRTm3, SQRTm11)))
assert mul(BETA, BETAb) == scal(-2, ONE)
if PLANT == 3:           # fault: use beta^2 instead of beta^3 for the local ideal
    BETA3, BETAb3 = power(BETA, 2), power(BETAb, 2)
else:
    BETA3, BETAb3 = power(BETA, 3), power(BETAb, 3)
def mcoords(x):
    y = [3 * a for a in x]; assert all(a.denominator == 1 for a in y); return tuple(int(a) for a in y)
basisOE = [ONE, Z6, W, mul(Z6, W)]
def gens(g, s=Fr(1, 3)):
    return [mcoords(scal(s, mul(g, b))) for b in basisOE]
Pp, Pm, Pp1, Pm1 = gens(BETA3), gens(BETAb3), gens(BETA), gens(BETAb)
triv = lambda t, G: all(value(t, g) == 0 for g in G)

# F1
assert len(Th) == 90, len(Th)
assert tuple([Fr(0)] * 4) not in Th
plus = [t for t in Th if order(t) in (2, 4, 8) and triv(t, Pp)]
minus = [t for t in Th if order(t) in (2, 4, 8) and triv(t, Pm)]
ten = [t for t in Th if order(t) == 10]
assert len(plus) == 21 and len(minus) == 21 and len(ten) == 48, (len(plus), len(minus), len(ten))
assert len(plus) + len(minus) + len(ten) == 90 and not set(plus) & set(minus)
print("F1 ok: 21 + 21 + 48, no mixed 2-power character, no trivial character")

# F2
def part(t, p):
    o = order(t); q = 1
    while o % p == 0: o //= p; q *= p
    e = next(e for e in range(q * o) if e % q == 1 % q and e % o == 0)
    return tuple((e * a) % 1 for a in t)
Aplus = [t for t in plus if order(t) == 2]; Aminus = [t for t in minus if order(t) == 2]
assert len(Aplus) == 3 and len(Aminus) == 3
L = {}
for t in ten:
    a, p = part(t, 2), part(t, 5)
    assert a in Aplus or a in Aminus, "an order-10 character with a mixed 2-part"
    L.setdefault(a, set()).add(tuple(int(5 * c) % 5 for c in p))
def line(v):
    i = next(i for i in range(4) if v[i]); s = pow(v[i], -1, 5); return tuple((s * c) % 5 for c in v)
lines = {}
for a, pts in L.items():
    ls = {line(v) for v in pts}
    assert len(ls) == 2 and len(pts) == 8, (a, ls, len(pts))
    assert pts == {tuple((s * c) % 5 for c in l) for l in ls for s in range(1, 5)}
    lines[a] = ls
print("F2 ok: each of the six alpha carries the nonzero points of exactly two distinct lines")

# F3
if PLANT == 4:           # fault: pretend one alpha's line is another's
    a0, a1 = Aplus[0], Aplus[1]; lines[a1] = {sorted(lines[a0])[0], sorted(lines[a1])[0]}
for side in (Aplus, Aminus):
    allines = [l for a in side for l in lines[a]]
    assert len(set(allines)) == 6, "two alpha on one side share a line"
print("F3 ok: six distinct lines on each side")

# F4: A+ = nonzero characters of M / (1/3)P+  (order 2, trivial on (1/3)P+ ; there are exactly 3 such nonzero characters)
for side, G in ((Aplus, Pp1), (Aminus, Pm1)):
    assert all(triv(t, G) for t in side), "an alpha not factoring through the residue field"
print("F4 ok: A+/- are the three nonzero characters of the residue fields F4 at P+/-")

# F5
U5 = list(UM.values())
if PLANT == 5:           # fault: only family 0 as generators
    U5 = [UM[(j, 0)] for j in range(6)]
H = hnf_rows([list(u) for u in U5] + [[5 * int(i == j) for j in range(4)] for i in range(4)])
assert abs(det(H)) == 1, "U5 does not generate M/5M"
print("F5 ok: U5 generates M/5M")

# F6
def res(u, G):
    # residue class of u modulo the ideal lattice spanned by G (+ nothing): compare u - u' membership
    return None
for G in (Pp1, Pm1):
    HG = hnf_rows([list(g) for g in G])
    classes = {}
    for u in U5:
        key = next((k for k in classes if in_lattice(tuple(a - b for a, b in zip(u, k)), HG)), u)
        classes.setdefault(key, []).append(u)
    assert len(classes) == 3, len(classes)          # three nonzero residues, ten unit vectors each
    for k, us in classes.items():
        assert len(us) == 10
        diffs = [[a - b for a, b in zip(x, us[0])] for x in us[1:]]
        H = hnf_rows(diffs + [[5 * int(i == j) for j in range(4)] for i in range(4)])
        assert abs(det(H)) == 1, "D - D does not span M/5M"
print("F6 ok: at each prime above 2 and each nonzero residue, the ten unit vectors' 5-residues have differences spanning M/5M")

# F7 (a second route to the residue case's slice step, spectrum only): 1_{Y-} would need its spectrum inside every plane
# Pi_alpha = span(L_alpha), alpha in A+ u A-.  Record the pairwise sums and assert that the six planes meet only in 0.
from itertools import product as _prod
def in_span(v, ls):
    return any(tuple((a * p + b * q) % 5 for p, q in zip(*ls)) == v for a in range(5) for b in range(5))
planes = {a: sorted(lines[a]) for a in Aplus + Aminus}
common = [v for v in _prod(range(5), repeat=4) if all(in_span(v, planes[a]) for a in planes)]
if PLANT == 6:
    common.append((1, 0, 0, 0))
pair = Counter()
for a in Aplus:
    for b in Aminus:
        pair[sum(1 for v in _prod(range(5), repeat=4) if in_span(v, planes[a]) and in_span(v, planes[b]))] += 1
print("F7: |Pi_alpha n Pi_beta| over the 9 cross pairs ->", dict(pair))
within = [sum(1 for v in _prod(range(5), repeat=4) if all(in_span(v, planes[a]) for a in side)) for side in (Aplus, Aminus)]
print("    |common to the three planes of one side| ->", within)
assert common == [(0, 0, 0, 0)], common
print("F7 ok: the six planes meet only in 0")
