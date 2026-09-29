#!/usr/bin/env python3
"""FS121-C1: C121-C1-COVMAP, exact in Q(sqrt 3).

DISC7: discs of radius 1/2 at the hexagonal lattice m*u + n*w, u = (3/4, sqrt3/4), w = (0, sqrt3/2), colour (m - 2n) mod 7
(same-colour centres sqrt21/2 apart). For every total order of the 7 colours, with l the least and c the second: x is the midpoint of c's
circle arc inside the disc of its neighbour d opposite to its l-neighbour. Checked: x lies on c's circle, strictly inside disc d, in no other
disc, so it is an edge point separating the merged map's colours c (the lens, min(c, d) = c) and d; its antipode y on c's circle (the only
point of disc c at distance 1 from x) lies strictly inside disc l, so no colour-c face is near y; every other c- or d-disc is farther than 1
from x; disc d lies within distance < 1 of x. So x is bound by neither side colour.
--cover plants the fault: binding is read in the cover's classes (whole discs) instead of the map's, so y counts for c and x is c-bound."""
import sys, itertools
from fractions import Fraction as Fr
class Q3:  # a + b*sqrt3, exact
    def __init__(s, a, b=0): s.a, s.b = Fr(a), Fr(b)
    def __add__(s, o): o = o if isinstance(o, Q3) else Q3(o); return Q3(s.a + o.a, s.b + o.b)
    def __sub__(s, o): o = o if isinstance(o, Q3) else Q3(o); return Q3(s.a - o.a, s.b - o.b)
    def __mul__(s, o): o = o if isinstance(o, Q3) else Q3(o); return Q3(s.a*o.a + 3*s.b*o.b, s.a*o.b + s.b*o.a)
    def div_sqrt3(s): return Q3(s.b, s.a/3)
    def sign(s):
        a, b = s.a, s.b
        if a >= 0 and b >= 0: return (a > 0 or b > 0) and 1 or 0
        if a <= 0 and b <= 0: return -1
        return (1 if a > 0 else -1) * (1 if a*a > 3*b*b else -1 if a*a < 3*b*b else 0)
U, W = (Q3(Fr(3, 4)), Q3(0, Fr(1, 4))), (Q3(0), Q3(0, Fr(1, 2)))
def ctr(m, n): return (U[0]*m + W[0]*n, U[1]*m + W[1]*n)
def col(m, n): return (m - 2*n) % 7
def d2(p, q): dx, dy = p[0] - q[0], p[1] - q[1]; return dx*dx + dy*dy
UNITS = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]
cover = '--cover' in sys.argv
q14, q94 = Q3(Fr(1, 4)), Q3(Fr(9, 4))
geo = {}
def geometry(l, c):  # per (least, second) pair: the edge point x, its antipode y, and the exact facts about them
    mc = (c, 0); qc = ctr(*mc)
    e = next(uu for uu in UNITS if col(mc[0] + uu[0], mc[1] + uu[1]) == l)
    md = (c - e[0], -e[1]); d = col(*md); qd = ctr(*md)
    x = (qc[0] + (qd[0] - qc[0]).div_sqrt3(), qc[1] + (qd[1] - qc[1]).div_sqrt3())
    y = (qc[0] - (qd[0] - qc[0]).div_sqrt3(), qc[1] - (qd[1] - qc[1]).div_sqrt3())
    ok = (d2(x, qc) - q14).sign() == 0 and (d2(x, qd) - q14).sign() < 0 and (d2(y, qc) - q14).sign() == 0
    ok = ok and (d2(x, y) - Q3(1)).sign() == 0 and d not in (l, c)
    win = [(m, n) for m in range(c - 6, c + 7) for n in range(-6, 7)]
    far_cd = True
    for mn in win:  # x in no other disc; every other c- and d-disc farther than 1 from x
        if mn in (mc, md): continue
        q = ctr(*mn); ok = ok and (d2(x, q) - q14).sign() > 0
        if col(*mn) in (c, d): far_cd = far_cd and (d2(x, q) - q94).sign() > 0
    y_in = [col(*mn) for mn in win if (d2(y, ctr(*mn)) - q14).sign() < 0]  # colours of the discs holding y in their interior
    return ok, d, far_cd, y_in
same = [d2(ctr(0, 0), ctr(m, n)) for m in range(-6, 7) for n in range(-6, 7) if (m, n) != (0, 0) and col(m, n) == 0]
m21 = all((v - Q3(Fr(21, 4))).sign() >= 0 for v in same) and any((v - Q3(Fr(21, 4))).sign() == 0 for v in same)
print(f"least squared distance between same-colour centres is 21/4: {m21}")
fails, unbound = 0, 0
for order in itertools.permutations(range(7)):
    rank = {cc: i for i, cc in enumerate(order)}
    l, c = order[0], order[1]
    if (l, c) not in geo: geo[(l, c)] = geometry(l, c)
    ok, d, far_cd, y_in = geo[(l, c)]
    if not ok or rank[c] > rank[d]: fails += 1; continue  # x separates the lens (colour c = min(c, d)) from disc d
    # y is the only point of disc c at distance 1 from x; in the merged map y is in F_c unless a lower-ranked disc holds it in its interior
    y_in_Fc = cover or not any(rank[k] < rank[c] for k in y_in)
    c_bound = y_in_Fc or not far_cd
    d_bound = not far_cd  # disc d lies within distance < 1 of x (|x - q_d| < 1/2, checked in ok)
    unbound += (not c_bound and not d_bound)
print(f"pairs (least, second) checked: {len(geo)}; geometry checks failed at {fails} orders")
print(f"orders with an edge point bound by neither side colour: {unbound} of 5040")
