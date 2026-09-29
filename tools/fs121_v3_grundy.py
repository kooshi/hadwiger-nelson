#!/usr/bin/env python3
"""FS121-V3 control for FS121-D3-GRUNDY: its construction, on a finite unit-distance graph given by formula.

The graph: points m(1,0) + n(1/2, sqrt3/2), |m|, |n| <= 8, joined at distance 1 (a patch of the triangular lattice).
The input colouring (by formula): f = ((m + 2n) mod 3) + 1, except f = 4 where m = n = 0 (mod 4); proper.
The procedure (the measurable one's discrete skeleton): for c = 1 .. 4, A_c = the vertices of colour c not yet used, then every
unused vertex with no neighbour in A_c is added to A_c (in sorted order), so A_c is maximal independent among the unused vertices.
Checked: the output is proper; it never raises a colour; A_1 is a maximal independent set; every vertex of output colour c has a
neighbour in A_i for every i < c (the Grundy property). Output: the number of violations (expected 0).
Fault (--no-extend): A_c is only the unused vertices of input colour c (no maximal extension); the Grundy property then fails at the
colour-4 vertices whose base colour is 1 (they have no neighbour of colour 1), so the count is positive.
"""
import sys

no_extend = "--no-extend" in sys.argv[1:]
R = 8
V = [(m, n) for m in range(-R, R + 1) for n in range(-R, R + 1)]
Vs = set(V)
STEPS = [(1, 0), (-1, 0), (0, 1), (0, -1), (1, -1), (-1, 1)]
nbr = {v: [(v[0] + a, v[1] + b) for a, b in STEPS if (v[0] + a, v[1] + b) in Vs] for v in V}

def f(v):
    m, n = v
    return 4 if (m % 4 == 0 and n % 4 == 0) else ((m + 2 * n) % 3) + 1

bad = sum(1 for v in V for w in nbr[v] if f(v) == f(w))
assert bad == 0, "input colouring is not proper"

used, A = set(), {}
for c in range(1, 5):
    Ac = {v for v in V if f(v) == c and v not in used}
    if not no_extend:
        for v in sorted(V):
            if v not in used and v not in Ac and not any(w in Ac for w in nbr[v]):
                Ac.add(v)
    A[c] = Ac
    used |= Ac
g = {v: c for c in A for v in A[c]}

viol = 0
viol += sum(1 for v in V if v not in g)                                      # every vertex coloured
viol += sum(1 for v in V for w in nbr[v] if g.get(v) == g.get(w))            # proper
viol += sum(1 for v in V if g.get(v, 99) > f(v))                             # never raises
viol += sum(1 for v in V if v not in A[1] and not any(w in A[1] for w in nbr[v]))  # A_1 maximal independent
viol += sum(1 for v in V for i in range(1, g[v]) if not any(w in A[i] for w in nbr[v]))  # Grundy property
print(viol)
