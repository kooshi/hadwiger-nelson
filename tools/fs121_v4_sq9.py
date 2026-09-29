#!/usr/bin/env python3
"""FS121-V4: exact model check for C121-C1-BOUND and C121-C1-SAT on SQ9 (plans/FS111-derivation.md, FS111-W-SQ9).

SQ9: closed squares [i s, (i+1) s] x [j s, (j+1) s], s = 1/2, square (i, j) coloured (i mod 3, j mod 3). The components of F_c are single
squares (same-colour squares are 3s apart, gap 2s = 1 > 0).
At rational points x on the four edges of the base square (0, 0) (t = 0, 1/40, ..., 1 along each edge, endpoints included), for each of the
two colours c the edge separates, over every square of colour c with |i|, |j| <= 6, compute exactly d_K(x)^2 and D_K(x)^2 and decide
  bound:    some K with d_K(x) <= 1 <= D_K(x)      (T_1(x) meets F_c; K compact and connected)
  on level: some K with d_K(x) = 1 or D_K(x) = 1   (outer unit parallel or far level of a component)
Claims checked: every sampled point is bound by both colours (SAT's conclusion: every order), and bound <=> on level (BOUND at those points).
Plant: --plant slack uses s = 12/25 with the same colouring (same-colour gap 24/25 < 1: unit pairs, not a map colouring); BOUND's
"only if" must then fail at some point (bound through a square it crosses, on no level).
"""
import sys
from fractions import Fraction as Q

def run(s):
    def sq(i, j): return (i * s, (i + 1) * s, j * s, (j + 1) * s)
    def dist2(x, K):
        x0, x1, y0, y1 = K
        dx = max(Q(0), x0 - x[0], x[0] - x1); dy = max(Q(0), y0 - x[1], x[1] - y1)
        return dx * dx + dy * dy
    def far2(x, K):
        x0, x1, y0, y1 = K
        return max((cx - x[0]) ** 2 + (cy - x[1]) ** 2 for cx in (x0, x1) for cy in (y0, y1))
    W = 6
    edges = []  # (point function, neighbour square)
    N = 40
    for n in range(N + 1):
        u = Q(n, N) * s
        edges.append(((u, s), (0, 1)))      # top edge, neighbour (0, 1)
        edges.append(((u, Q(0)), (0, -1)))  # bottom
        edges.append(((Q(0), u), (-1, 0)))  # left
        edges.append(((s, u), (1, 0)))      # right
    pts = bound_both = agree = 0
    bad = []
    for x, nb in edges:
        cols = [(0, 0), (nb[0] % 3, nb[1] % 3)]
        pts += 1
        both = True
        for c in cols:
            Ks = [sq(i, j) for i in range(-W, W + 1) for j in range(-W, W + 1) if (i % 3, j % 3) == c]
            b = any(dist2(x, K) <= 1 <= far2(x, K) for K in Ks)
            lv = any(dist2(x, K) == 1 or far2(x, K) == 1 for K in Ks)
            both &= b
            if b == lv: agree += 1
            else: bad.append((x, c, b, lv))
        bound_both += both
    return pts, bound_both, agree, bad

def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    s = Q(12, 25) if plant == "slack" else Q(1, 2)
    pts, bb, agree, bad = run(s)
    for b in bad[:3]:
        print(f"BOUND fails at x = ({b[0][0]}, {b[0][1]}), colour {b[1]}: bound {b[2]}, on a level {b[3]}")
    ok = not bad and bb == pts
    print(f"edge points {pts}; bound by both colours {bb}; bound <=> on a level {agree} of {2 * pts}; {'ALL PASS' if ok else 'FAIL'} (plant = {plant})")
    sys.exit(0 if ok else 1)

main()
