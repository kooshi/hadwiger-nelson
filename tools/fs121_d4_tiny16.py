#!/usr/bin/env python3
"""FS121-D4: exact checks of TINY16 and of the line colouring LINE (FS121-D4-TINY16, FS121-D4-LINE).

TINY16. The 1D partition P_eps of the line: breakpoints m, m + eps, m + 1/2 (m integer), gaps indexed i in Z in order
(three per unit), gap i coloured i mod 4. The plane colouring is the product: cell (gap i) x (gap j) gets colour (i mod 4,
j mod 4), 16 colours; it is 4Z^2-periodic. Checked exactly in rationals on the window [-3, 7]^2 (every cell meeting it), which
holds every cell within distance 2 of the fundamental domain [0, 4)^2:
  (P) properness: for every two distinct same-colour cells, the squared-distance range [dmin^2, dmax^2] between the closed
      rectangles does not contain 1 in its interior (so their unit pairs are a null set);
  (S) saturation: for every edge of every cell meeting [0,4)^2 and each of its two side colours, the unit translate of the
      closed edge along the normal (toward the side of the other colour) lies in the closure of a cell of that colour; for
      every corner and each of the four incident colours, one of the four unit translates of the corner lies in the closure
      of a cell of that colour.
  (T) the cells (gap 0) x (gap 0) have diameter eps*sqrt(2).
LINE. f(x) = (floor(x) + floor(1/s(x - floor(x)))) mod 2 for s(t) = dist(t, Z0), Z0 = {0} u {1/n}, 0 elsewhere on Z0: checks
  f(x + 1) = 1 - f(x) at 4000 exact rationals near the breakpoints, and counts the breakpoints in (1/2 - 1/100, 1/2) found among
  the first N levels (it grows without bound: an accumulation at 1/2, a point of Z0).
Exit 0 iff every assertion holds and prints ALL HOLD. Plants: --plant mod3 (gap colours i mod 3: properness must fail),
--plant noshift (LINE without floor(x): f(x+1) = 1 - f(x) must fail), --plant eps0 (eps = 1/2, the eps-gap removed: (T) must fail)."""
import sys
from fractions import Fraction as F
from itertools import product
plant = sys.argv[sys.argv.index('--plant') + 1] if '--plant' in sys.argv else None
EPS = F(1, 2) if plant == 'eps0' else F(1, 10)
MOD = 3 if plant == 'mod3' else 4
fails = []
def gaps(lo, hi):
    """gaps (index, a, b) of P_eps meeting [lo, hi]"""
    out = []
    for m in range(int(lo) - 2, int(hi) + 2):
        pts = [F(m), F(m) + EPS, F(m) + F(1, 2), F(m + 1)]
        segs = [(pts[k], pts[k + 1]) for k in range(3) if pts[k] < pts[k + 1]]
        for k, (a, b) in enumerate(segs):
            if b > lo and a < hi:
                out.append((len(segs) * m + k, a, b))
    return out
def col(i): return i % MOD
G = gaps(F(-3), F(7))
cells = [((i, a, b), (j, c, d)) for (i, a, b) in G for (j, c, d) in G]
def rng(a, b, c, d):  # range of |x - y| for x in [a,b], y in [c,d]
    lo = max(F(0), c - b, a - d); hi = max(d - a, b - c); return lo, hi
# (P)
bycol = {}
for X, Y in cells: bycol.setdefault((col(X[0]), col(Y[0])), []).append((X, Y))
npairs = 0
for key, L in bycol.items():
    for u in range(len(L)):
        for v in range(u + 1, len(L)):
            (X1, Y1), (X2, Y2) = L[u], L[v]
            lx, hx = rng(X1[1], X1[2], X2[1], X2[2]); ly, hy = rng(Y1[1], Y1[2], Y2[1], Y2[2])
            dmin2, dmax2 = lx * lx + ly * ly, hx * hx + hy * hy
            if dmin2 >= 4: continue
            npairs += 1
            if dmin2 < 1 < dmax2: fails.append(('P', key, X1, Y1, X2, Y2))
# (S)
def inclosure(px, py, colour):
    return any(col(X[0]) == colour[0] and col(Y[0]) == colour[1] and X[1] <= px <= X[2] and Y[1] <= py <= Y[2] for X, Y in cells)
def seg_in(p, q, colour):  # closed segment pq inside the closure of one cell of the colour (cells are convex)
    return any(col(X[0]) == colour[0] and col(Y[0]) == colour[1] and all(X[1] <= z[0] <= X[2] and Y[1] <= z[1] <= Y[2] for z in (p, q)) for X, Y in cells)
G0 = gaps(F(0), F(4)); G0 = [g for g in G0 if g[2] > 0 and g[1] < 4]
idx = {g[0]: g for g in G}
nedges = ncorners = 0
for (i, a, b), (j, c, d) in product(G0, G0):
    me = (col(i), col(j)); right = (col(i + 1), col(j)); up = (col(i), col(j + 1))
    # vertical edge x = b between cell (i,j) [left] and (i+1,j) [right]
    nedges += 1
    if not seg_in((b + 1, c), (b + 1, d), me): fails.append(('S-left', i, j))
    if not seg_in((b - 1, c), (b - 1, d), right): fails.append(('S-right', i, j))
    # horizontal edge y = d between (i,j) [below] and (i,j+1) [above]
    nedges += 1
    if not seg_in((a, d + 1), (b, d + 1), me): fails.append(('S-below', i, j))
    if not seg_in((a, d - 1), (b, d - 1), up): fails.append(('S-above', i, j))
    # corner (b, d): incident colours (i,j), (i+1,j), (i,j+1), (i+1,j+1)
    ncorners += 1
    for cc in [(col(i), col(j)), (col(i + 1), col(j)), (col(i), col(j + 1)), (col(i + 1), col(j + 1))]:
        if not any(inclosure(b + dx, d + dy, cc) for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1))): fails.append(('S-corner', i, j, cc))
# (T)
g0 = idx[0]
if not (g0[2] - g0[1] == EPS and EPS < F(1, 2)): fails.append(('T', g0))
# LINE
def s(t):
    if t == 0: return F(0)
    n = int(1 / t)  # 1/(n+1) < t <= 1/n
    cands = [F(1, n), F(1, n + 1)] + ([F(1, n - 1)] if n > 1 else [])
    return min(abs(t - z) for z in cands + [F(0)])
def f(x):
    m = x.numerator // x.denominator; t = x - m; st = s(t)
    v = 0 if st == 0 else (int(1 / st) % 2)
    return v % 2 if plant == 'noshift' else (m + v) % 2
nline = 0
for n in range(2, 42):
    for k in range(1, 50):
        for z in (F(1, n) + F(1, 1000 * k + 7), F(1, n) - F(1, 1000 * k + 13)):
            for m in (-1, 0, 2):
                x = z + m; nline += 1
                if f(x + 1) != 1 - f(x): fails.append(('LINE', x))
def brk(N):  # colour changes of f at the points 1/2 - 1/k, 101 <= k < N, all inside (1/2 - 1/100, 1/2): checked on f itself
    c = 0
    for k in range(101, N):
        z = F(1, 2) - F(1, k); dl = F(1, 10 * k * k)
        c += f(z - dl) != f(z + dl)
    return c
print(f"TINY16 eps={EPS} colours={MOD**2}: same-colour pairs checked {npairs}, edges {nedges}, corners {ncorners}; LINE samples {nline}; "
      f"line breakpoints in (1/2-1/100, 1/2) 1/2-1/k for k<10^3: {brk(1000)}, k<4*10^3: {brk(4000)}")
for x in fails[:5]: print('FAIL', x)
print('ALL HOLD' if not fails else f'FAILED ({len(fails)})')
sys.exit(0 if not fails else 1)
