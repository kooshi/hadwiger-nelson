#!/usr/bin/env python3
"""J27D stage 4.
  A. The two-step winding D_C (odd cycle C = C5 = G): for every arc (f, g) of K_3^{C5}, D(f) = D(g) = 3*w(f, g), w the winding of the
     double walk f(0), g(1), f(2), ..., g(4) (length 10) in K_3.  Then the structure of E_3(C5) by D (a complete evaluation of a
     finite set fixed by the derivation: 3^5 maps; logged under the ban as at the edge).
  B. S1 = UD(F9, 2), F9 = F3[i]: its 8 circle points, exact integer spectrum (characters psi(tr(a.x + b.y)), tr(r + s i) = 2r),
     Hoffman-tightness at 3 (lam_min = -d/2), the linear 3-colouring l(x, y) = x0 + y0 + x1, connectivity (F3-span of the circle).
Usage: crunch_j27d_db.py [--plant]  (plant: wrong sign in the two-step increment, and one circle point dropped -> both parts must fail)"""
import itertools, sys
PLANT = "--plant" in sys.argv
ok = True
def step(a, b):            # +1 / -1 step of K_3 from a to b (a != b), as the lift to Z
    return 1 if (b - a) % 3 == 1 else -1
def d2(a, b):              # two-step displacement determined by the endpoints
    if a == b: return 0
    v = 2 if (b - a) % 3 == 2 else -2
    return -v if PLANT else v
L = 5; E = [(i, (i+1) % L) for i in range(L)]; A = E + [(v, u) for (u, v) in E]
maps = list(itertools.product(range(3), repeat=L))
D = {f: sum(d2(f[(2*j) % L], f[(2*j+2) % L]) for j in range(L)) for f in maps}
adj = lambda f, g: all(f[u] != g[v] for (u, v) in A)
bad = arcs = 0
for f in maps:
    for g in maps:
        if adj(f, g):
            arcs += 1
            walk = [(f if i % 2 == 0 else g)[i % L] for i in range(2*L)] + [f[0]]
            tot = sum(step(walk[i], walk[i+1]) for i in range(2*L))
            if not (D[f] == D[g] == tot): bad += 1
print(f"A  K_3^C5: {arcs} arcs; arcs violating D(f) = D(g) = 3w: {bad}")
ok &= bad == 0
proper = {f for f in maps if all(f[u] != f[v] for (u, v) in E)}
imp = [f for f in maps if f not in proper]
from collections import Counter
print(f"A  E_3(C5): {len(imp)} improper maps; by D: {dict(Counter(D[f] for f in imp))}; proper maps by D: {dict(Counter(D[f] for f in proper))}")
nz = [f for f in imp if D[f] != 0]
e_nz = sum(1 for f in nz for g in nz if adj(f, g)) // 2
print(f"A  edges of E_3(C5) among improper maps with D != 0: {e_nz}")
# B
def mul(p, q): return ((p[0]*q[0] - p[1]*q[1]) % 3, (p[0]*q[1] + p[1]*q[0]) % 3)
F9 = [(r, s) for r in range(3) for s in range(3)]
circ = [(x, y) for x in F9 for y in F9 if tuple((mul(x, x)[j] + mul(y, y)[j]) % 3 for j in (0, 1)) == (1, 0)]
if PLANT: circ = circ + [((1, 0), (1, 0)), ((2, 0), (2, 0))]   # a non-circle antipodal pair
d = len(circ)
def tr(z): return (2*z[0]) % 3
def add(p, q): return ((p[0]+q[0]) % 3, (p[1]+q[1]) % 3)
evs = []
for a in F9:
    for b in F9:
        if (a, b) == ((0, 0), (0, 0)): continue
        cnt = Counter(tr(add(mul(a, x), mul(b, y))) for (x, y) in circ)
        assert cnt[1] == cnt[2] or PLANT
        evs.append(cnt[0] - (cnt[1] + cnt[2]) / 2)
lmin = min(evs)
print(f"B  UD(F9,2): d = {d}, circle = {circ}; lam_min = {lmin}; tight at 3 (lam_min = -d/2): {lmin == -d/2}")
ok &= (lmin == -d/2)
ell = lambda x, y: (x[0] + y[0] + x[1]) % 3
col_ok = all(ell(*t) != 0 for t in circ)
span = {((0, 0), (0, 0))}
while True:
    new = {tuple(add(p[j], t[j]) for j in (0, 1)) for p in span for t in circ} | span
    if new == span: break
    span = new
print(f"B  l(x,y) = x0 + y0 + x1 is nonzero on every circle point (a proper 3-colouring): {col_ok}; circle spans {len(span)} of 81 (connected: {len(span) == 81})")
ok &= col_ok and len(span) == 81
print("ALL OK" if ok else "FAILED"); sys.exit(0 if ok else 1)
