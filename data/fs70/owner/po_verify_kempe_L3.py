#!/usr/bin/env python3
"""Owner's independent exhibition of phase 1e's Kempe escapes on the rank-6 L3 = <zeta6^m u^n (|n|<=2)> + zeta6.{w, conj w}
(FS-70). Independent of tools/fs70_periodic_kempe.py: MY generators, MY word ball at sums of <= K, MY unit-distance edges
(float annulus + exact decision), the committed N-periodic colouring pulled back through the tool's Hermite basis (a datum;
every ball point is checked to lie in it), MY breadth-first Kempe component of the origin in colours {C(0), b}, the swap,
and the check that the swapped colouring is proper on MY edges and separates (0, delta).  A plant (--plant) swaps a component
of a NON-Kempe pair of colours and must be reported improper.  Usage: po_verify_kempe_L3.py N K [--plant]"""
import sys, json, math
sys.path.insert(0, 'data/fs70/owner'); sys.path.insert(0, 'tools')
from fractions import Fraction as Fr
from collections import defaultdict, deque
from po_additive_screen import fmul, fadd, fsub
N = int(sys.argv[1]); K = int(sys.argv[2]); PLANT = '--plant' in sys.argv
S3, S5, S15 = 3 ** .5, 5 ** .5, 15 ** .5
def cm(z, w):
    (x1, y1), (x2, y2) = z, w
    return (fsub(fmul(x1, x2), fmul(y1, y2)), fadd(fmul(x1, y2), fmul(y1, x2)))
def cj(z): return (z[0], tuple(-t for t in z[1]))
def cadd(z, w): return (fadd(z[0], w[0]), fadd(z[1], w[1]))
ONEF = (Fr(1), Fr(0), Fr(0), Fr(0)); ZERO = (Fr(0),) * 4
u = ((Fr(-2, 3), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(1, 3), Fr(0)))
z6 = ((Fr(1, 2), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(1, 2), Fr(0), Fr(0)))
w = ((Fr(0), Fr(1, 4), Fr(1, 4), Fr(0)), (Fr(0), Fr(-1, 4), Fr(1, 4), Fr(0)))
assert fadd(fmul(w[0], w[0]), fmul(w[1], w[1])) == ONEF
gens = []
for n in range(-2, 3):
    p = ((Fr(1), Fr(0), Fr(0), Fr(0)), ZERO)
    for _ in range(abs(n)): p = cm(p, u if n > 0 else cj(u))
    for m in range(6): gens.append(p); p = cm(p, z6)
for r in (w, cj(w)):
    p = r
    for m in range(6): gens.append(p); p = cm(p, z6)
gens = sorted(set(gens)); assert len(gens) == 42, len(gens)
import fs70_fabric as FB
lat = FB.Lattice(FB.generators('group6:u3:2+zeta6:w4'), 'group6:u3:2+zeta6:w4'); M = lat.M; B = [list(b) for b in lat.H]
print(f"rank-6 L3: 42 generators (mine); tool basis rows {len(B)} over M = {M}")
def vec8(z): return tuple(int(t * M) for t in z[0] + z[1])
assert all(all((t * M).denominator == 1 for t in z[0] + z[1]) for z in gens)
def coords_in(basis, v):
    v = list(v); out = []
    for b in basis:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]: return None
        q = v[p] // b[p]; out.append(q); v = [a - q * c for a, c in zip(v, b)]
    return tuple(out) if all(x == 0 for x in v) else None
# my word ball
G8 = [vec8(g) for g in gens]
seen = {(0,) * 8}; frontier = [(0,) * 8]
for _ in range(K):
    nxt = []
    for p in frontier:
        for s in G8:
            q = tuple(a + b for a, b in zip(p, s))
            if q not in seen: seen.add(q); nxt.append(q)
    frontier = nxt
P = sorted(seen); idx = {p: i for i, p in enumerate(P)}; n = len(P)
print(f"my word ball at sums <= {K}: {n} points")
f = json.load(open(f'data/fs70/quotient/group6_u3_2_zeta6_w4-N{N}.colouring.json')); col = f['colouring']
import itertools
verts = list(itertools.product(range(N), repeat=6)); vidx = {v: i for i, v in enumerate(verts)}
C = []
for p in P:
    c = coords_in(B, p); assert c is not None
    C.append(col[vidx[tuple(x % N for x in c)]])
# my edges
Z = [complex((p[0] + p[1] * S3 + p[2] * S5 + p[3] * S15) / M, (p[4] + p[5] * S3 + p[6] * S5 + p[7] * S15) / M) for p in P]
cell = 0.25; grid = defaultdict(list)
for i, z in enumerate(Z): grid[(math.floor(z.real / cell), math.floor(z.imag / cell))].append(i)
Rc = int((1 + 1e-7) / cell) + 2; adj = [[] for _ in range(n)]; edges = 0
for i, z in enumerate(Z):
    cx, cy = math.floor(z.real / cell), math.floor(z.imag / cell)
    for dx in range(-Rc, Rc + 1):
        for dy in range(-Rc, Rc + 1):
            for j in grid.get((cx + dx, cy + dy), ()):
                if j <= i: continue
                if abs(abs(Z[i] - Z[j]) ** 2 - 1.0) <= 1e-7:
                    d = [Fr(a - b, M) for a, b in zip(P[i], P[j])]
                    if fadd(fmul(tuple(d[:4]), tuple(d[:4])), fmul(tuple(d[4:]), tuple(d[4:]))) == ONEF:
                        adj[i].append(j); adj[j].append(i); edges += 1
bad = sum(1 for i in range(n) for j in adj[i] if j > i and C[i] == C[j])
print(f"my edges {edges}; pulled-back N = {N} colouring: monochromatic {bad}")
o = idx[(0,) * 8]; a = C[o]
# fix scaling: targets given as integer 8-tuples over M
T = {'2': (2 * M, 0, 0, 0, 0, 0, 0, 0), '4': (4 * M, 0, 0, 0, 0, 0, 0, 0), '4/3': (4 * M // 3, 0, 0, 0, 0, 0, 0, 0),
     '8/3': (8 * M // 3, 0, 0, 0, 0, 0, 0, 0), '2/3': (2 * M // 3, 0, 0, 0, 0, 0, 0, 0), 'isqrt3': (0, 0, 0, 0, 0, M, 0, 0)}
ok_all = True
for name, t in T.items():
    if t not in idx: print(f"  target {name}: outside the ball"); continue
    d = idx[t]
    if C[d] != a:
        print(f"  target {name}: C(0) = {a}, C(δ) = {C[d]} -- separated by the colouring itself (level 0)"); continue
    found = False
    for b in range(4):
        if b == a: continue
        comp = {o}; dq = deque([o])
        while dq:
            x = dq.popleft()
            for y in adj[x]:
                if y not in comp and C[y] in (a, b): comp.add(y); dq.append(y)
        C2 = list(C)
        for x in comp: C2[x] = b if C[x] == a else a
        if PLANT: C2[adj[o][0]] = C2[o]   # plant: the checker must see one monochromatic edge at the origin
        bad2 = sum(1 for i in range(n) for j in adj[i] if j > i and C2[i] == C2[j])
        sep = C2[o] != C2[d]
        print(f"  target {name}, b = {b}: component {len(comp)} points; swapped colouring monochromatic {bad2}; separates: {sep}")
        if bad2 == 0 and sep: found = True
    ok_all = ok_all and found
    print(f"  -> {name}: {'ESCAPE exhibited' if found else 'no escape in this ball'}")
print("VERDICT:", "OK" if (bad == 0 and ok_all) else "FAIL"); sys.exit(0 if (bad == 0 and ok_all) else 1)
