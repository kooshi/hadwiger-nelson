#!/usr/bin/env python3
"""FS121-V4: exact check of C121-C1-COVMAP on DISC7's merged map.

DISC7 (plans/FS111-M2-regularity.md § 1.6): closed discs of radius 1/2 at c(m, n) = m(√3/2, 0) + n(√3/4, 3/4), colour (m + 3n) mod 7.
Merged map under a total order of the seven colours: each face of the arrangement of the boundary circles takes the least colour, in the
order, of a disc containing it.

What is checked, exactly (arithmetic in Q(√3), numbers a + b√3 with a, b rational, signs decided without floating point):

Geometry, at the base disc D_0 = B(c(0,0), 1/2) and each of its six neighbour directions v (neighbour centre c(0,0) + v, colour col(v)),
at the arc midpoint x = c(0,0) + v/√3 and its antipode x' = c(0,0) − v/√3, over every centre with |m|, |n| <= 8:
  (a) x lies on ∂D_0 and in the open neighbour disc D_v, and in no other closed disc;
  (b) x' lies on ∂D_0 and in the open disc D_{−v}, and in no other closed disc;
  (c) every centre of colour col(v) other than D_v's is more than 3/2 from x (so T₁(x) misses those discs), and |x − centre_v| < 1/2
      (so T₁(x) misses D_v: every point of D_v is within |x − centre_v| + 1/2 < 1 of x);
  (d) every centre of colour 0 other than c(0,0) is more than 3/2 from x (so T₁(x) meets the colour-0 discs only at x').
So, for d = 0 and c = col(v), c' = col(−v): the arc through x separates d and c when d < c in the order; x is never c-bound; and x is
d-bound iff x' lies in the closure of the colour-d class, i.e. iff the face just inside D_0 at x' has colour d, i.e. iff d < c'.
Translation by c(1, 0) adds 1 to every colour, so the structure at every colour is this one with labels shifted.

Orders: over all 5040 total orders, count those with a colour d and a neighbour direction v such that c' < d < c (an edge point bound by
neither colour). The claim: 5040 of 5040.

Plants: --plant cover  (colour-d class = the whole disc, DISC7's classes themselves: x' always in F_d) must drop the count;
        --plant vertex (x taken at a hexagon vertex, on three circles) must fail the geometry.
"""
import itertools, sys
from fractions import Fraction as Q

class R3:
    """a + b√3, a, b rational."""
    __slots__ = ("a", "b")
    def __init__(self, a, b=0):
        self.a, self.b = Q(a), Q(b)
    def __add__(s, o): o = o if isinstance(o, R3) else R3(o); return R3(s.a + o.a, s.b + o.b)
    def __sub__(s, o): o = o if isinstance(o, R3) else R3(o); return R3(s.a - o.a, s.b - o.b)
    def __mul__(s, o):
        o = o if isinstance(o, R3) else R3(o)
        return R3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)
    def div_sqrt3(s):  # (a + b√3)/√3 = b + (a/3)√3
        return R3(s.b, s.a / 3)
    def sign(s):
        a, b = s.a, s.b
        if a >= 0 and b >= 0: return 0 if (a == 0 and b == 0) else 1
        if a <= 0 and b <= 0: return -1
        # opposite signs: compare a^2 with 3 b^2
        d = a * a - 3 * b * b
        if d == 0: return 0
        return (1 if a > 0 else -1) if d > 0 else (1 if b > 0 else -1)
    def cmp(s, o): return (s - (o if isinstance(o, R3) else R3(o))).sign()

def centre(m, n):  # (√3/2 m + √3/4 n, 3/4 n)
    return (R3(0, Q(m, 2) + Q(n, 4)), R3(Q(3 * n, 4), 0))

def col(m, n): return (m + 3 * n) % 7

def d2(p, q):
    dx, dy = p[0] - q[0], p[1] - q[1]
    return dx * dx + dy * dy

NB = [(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]  # neighbour offsets (m, n); opposite pairs i, i+3

def geometry(plant):
    W = 8
    cells = [(m, n) for m in range(-W, W + 1) for n in range(-W, W + 1)]
    o = centre(0, 0)
    quarter, nine4 = Q(1, 4), Q(9, 4)
    fails = []
    for i, (vm, vn) in enumerate(NB):
        cv = centre(vm, vn)
        v = (cv[0] - o[0], cv[1] - o[1])
        if plant == "vertex":  # a hexagon vertex: rotate v's midpoint to the circles' crossing, circumradius 1/2 at angle +30°
            # vertex = o + (1/2)(unit v rotated by 30°); unit v = v·2/√3; rotation by 30°: (cos, sin) = (√3/2, 1/2)
            ux, uy = v[0].div_sqrt3() * 2, v[1].div_sqrt3() * 2
            rx = ux * R3(0, Q(1, 2)) - uy * Q(1, 2)
            ry = ux * Q(1, 2) + uy * R3(0, Q(1, 2))
            x = (o[0] + rx * Q(1, 2), o[1] + ry * Q(1, 2))
        else:
            x = (o[0] + v[0].div_sqrt3(), o[1] + v[1].div_sqrt3())
        xa = (o[0] - v[0].div_sqrt3(), o[1] - v[1].div_sqrt3())
        opp = NB[(i + 3) % 6]
        cc, ccp = col(vm, vn), col(*opp)
        # (a), (b)
        if d2(x, o).cmp(quarter) != 0: fails.append(f"dir {i}: x not on ∂D_0")
        if d2(xa, o).cmp(quarter) != 0: fails.append(f"dir {i}: x' not on ∂D_0")
        for (m, n) in cells:
            if (m, n) == (0, 0): continue
            c = centre(m, n)
            s = d2(x, c).cmp(quarter)
            if (m, n) == (vm, vn):
                if s >= 0: fails.append(f"dir {i}: x not in the open neighbour disc")
            elif s <= 0: fails.append(f"dir {i}: x in another closed disc {(m, n)}")
            s2 = d2(xa, c).cmp(quarter)
            if (m, n) == opp:
                if s2 >= 0: fails.append(f"dir {i}: x' not in the open opposite disc")
            elif s2 <= 0: fails.append(f"dir {i}: x' in another closed disc {(m, n)}")
            # (c), (d): far same-colour centres
            if col(m, n) in (cc, 0) and (m, n) != (vm, vn):
                if d2(x, c).cmp(nine4) <= 0: fails.append(f"dir {i}: centre {(m, n)} of colour {col(m, n)} within 3/2 of x")
        # (c) second half: |x − centre_v| < 1/2 (implied by (a)); recorded
    return fails

def orders(plant):
    pairs = []  # (d-offset label structure): for base colour 0, (c, c') per direction; shift by l for colour l
    for i, (vm, vn) in enumerate(NB):
        pairs.append((col(vm, vn), col(*NB[(i + 3) % 6])))
    total = good = 0
    rank4_always = True
    min_unbound = 10 ** 9
    for perm in itertools.permutations(range(7)):
        rk = {c: r for r, c in enumerate(perm)}  # rank of each colour
        total += 1
        unbound = 0
        for l in range(7):
            for (c, cp) in pairs:
                d, c, cp = l, (l + c) % 7, (l + cp) % 7
                if rk[d] < rk[c]:  # an edge of the merged map separates d and c along ∂D_d inside D_c
                    d_bound = True if plant == "cover" else (rk[d] < rk[cp])
                    if not d_bound:
                        unbound += 1
        if unbound: good += 1
        min_unbound = min(min_unbound, unbound)
        mid = perm[3]
        if not any(rk[(mid + cp) % 7] < 3 < rk[(mid + c) % 7] for (c, cp) in pairs):
            rank4_always = False
    return total, good, min_unbound, rank4_always

def main():
    plant = None
    if "--plant" in sys.argv:
        plant = sys.argv[sys.argv.index("--plant") + 1]
    g = geometry(plant)
    for f in g[:10]:
        print("FAIL geometry:", f)
    total, good, mn, r4 = orders(plant)
    print(f"opposite colour pairs at colour 0: {[(col(*NB[i]), col(*NB[i + 3])) for i in range(3)]}")
    print(f"the colour of rank 4 lies between two opposite neighbours under every order: {r4}")
    print(f"least number of unbound edge types (d, direction) over the orders: {mn}")
    ok = (not g) and good == total
    print(f"orders with an edge point bound by neither colour: {good} of {total}; geometry: {'ALL PASS' if not g else 'FAIL'}; plant = {plant}")
    sys.exit(0 if ok else 1)

main()
