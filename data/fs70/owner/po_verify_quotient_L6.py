#!/usr/bin/env python3
"""Owner's verifier of phase 1d's fan-gap closure on L6 = <zeta6, u^{+-1,+-2}, rho15, conj rho15> (FS-70).

Independent of tools/fs70_* except for one datum -- the Hermite basis of L6 the tool's quotient used, which fixes the
coordinates of the committed colouring (a basis is data; if it were the basis of a different lattice, MY 54 unit vectors
would not all have integer coordinates in it, which is checked).  MY 54 unit vectors of L6 (po_cm_lattice's enumeration,
denominator 144) are reduced mod N in that basis and compared as a set with the file's connection set; the colouring is checked
proper and gapped on MY Cayley graph; then the colouring is pulled back to phase 1b's committed word ball of L6 (a point set;
its unit-distance edges re-derived HERE by the float-annulus-plus-exact method) and checked.  Usage: po_verify_quotient_L6.py N [graph.json]"""
import sys, json, math, itertools
sys.path.insert(0, 'data/fs70/owner'); sys.path.insert(0, 'tools')
from fractions import Fraction as Fr
from collections import defaultdict
from po_additive_screen import fmul, fadd, fsub, units_with_denominator
N = int(sys.argv[1]); GRAPH = sys.argv[2] if len(sys.argv) > 2 else 'build/fs70/L6-w3/graph.json'
M = 144
# --- my unit vectors of L6: all unit vectors of F with denominator | 144 lying in the Z-span of the generators
S3, S5, S15 = 3 ** .5, 5 ** .5, 15 ** .5
def cm(z, w):
    (x1, y1), (x2, y2) = z, w
    return (fsub(fmul(x1, x2), fmul(y1, y2)), fadd(fmul(x1, y2), fmul(y1, x2)))
ONEF = (Fr(1), Fr(0), Fr(0), Fr(0))
u = ((Fr(-2, 3), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(1, 3), Fr(0)))
z6 = ((Fr(1, 2), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(1, 2), Fr(0), Fr(0)))
rho = ((Fr(7, 8), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(1, 8)))
def cj(z): return (z[0], tuple(-t for t in z[1]))
gens = []
for n in range(-2, 3):
    p = ((Fr(1), Fr(0), Fr(0), Fr(0)), (Fr(0),) * 4)
    for _ in range(abs(n)): p = cm(p, u if n > 0 else cj(u))
    for m in range(6): gens.append(p); p = cm(p, z6)
for r in (rho, cj(rho)):
    p = r
    for m in range(6): gens.append(p); p = cm(p, z6)
gens = sorted(set(gens)); print(f"generators: {len(gens)}")
def vec8(z): return tuple(int(t * M) for t in z[0] + z[1])
assert all(all((t * M).denominator == 1 for t in z[0] + z[1]) for z in gens)
# integer HNF (mine) for membership
def hnf(vectors, dim=8):
    Mx = [list(v) for v in vectors]; basis = []
    for col in range(dim):
        while True:
            nz = [i for i in range(len(Mx)) if Mx[i][col] != 0]
            if not nz: break
            i0 = min(nz, key=lambda i: abs(Mx[i][col])); p = Mx[i0][col]; done = True
            for i in nz:
                if i != i0:
                    q = Mx[i][col] // p; Mx[i] = [a - q * b for a, b in zip(Mx[i], Mx[i0])]
                    if Mx[i][col] != 0: done = False
            if done: basis.append(Mx[i0]); Mx = [Mx[i] for i in range(len(Mx)) if i != i0]; break
    return basis
def coords_in(basis, v):
    v = list(v); out = []
    for b in basis:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]: return None
        q = v[p] // b[p]; out.append(q); v = [a - q * c for a, c in zip(v, b)]
    return tuple(out) if all(x == 0 for x in v) else None
myB = hnf([vec8(g) for g in gens]); print(f"my HNF rank {len(myB)}")
import os
cache = 'data/fs70/owner/L6-units-mine.json'
if os.path.exists(cache):
    myU = [tuple(v) for v in json.load(open(cache))]; allU = None
else:
    allU = units_with_denominator(M)
    myU = [v for v in allU if coords_in(myB, v) is not None]
    json.dump(myU, open(cache, 'w'))
print(f"unit vectors of F with denominator | {M}: {len(allU) if allU else '(cached)'}; in L6: {len(myU)}")
# --- the tool's basis (data), and my unit vectors in it
import fs70_fabric as FB
lat = FB.Lattice(FB.generators('group6:u3:2+zeta6:rho15'), 'group6:u3:2+zeta6:rho15')
assert lat.M == M, lat.M
B = [list(b) for b in lat.H]
print(f"tool basis rows {len(B)} over M = {lat.M}")
S = [coords_in(B, v) for v in myU]
assert all(s is not None for s in S), "one of MY unit vectors is not in the tool's basis span"
Smod = sorted({tuple(x % N for x in s) for s in S}); assert (0,) * 6 not in Smod
f = json.load(open(f'data/fs70/quotient/group6_u3_2_zeta6_rho15-N{N}.colouring.json'))
theirs = sorted(tuple(s) for s in f['connection_set']); col = f['colouring']
print(f"connection set mod {N}: mine {len(Smod)}, file {len(theirs)}, equal: {Smod == theirs}")
verts = list(itertools.product(range(N), repeat=6)); vidx = {v: i for i, v in enumerate(verts)}
assert len(col) == len(verts)
mono = 0; gapped = 0; ex = None
for i, v in enumerate(verts):
    nb = {col[vidx[tuple((a + b) % N for a, b in zip(v, s))]] for s in Smod}
    if col[i] in nb: mono += 1
    if len(nb | {col[i]}) < 4:
        gapped += 1
        if ex is None: ex = (v, sorted(set(range(4)) - (nb | {col[i]})))
print(f"quotient: {len(verts)} vertices, degree {len(Smod)}; vertices with a monochromatic edge: {mono}; gapped: {gapped}; example {ex}")
# --- pull back to the committed word ball, edges re-derived here
g = json.load(open(GRAPH)); assert g['M'] == M
P = [tuple(p) for p in g['points']]
cols = []
for p in P:
    c = coords_in(B, p); assert c is not None, "a ball point outside the basis span"
    cols.append(col[vidx[tuple(x % N for x in c)]])
Z = [complex((p[0] + p[1] * S3 + p[2] * S5 + p[3] * S15) / M, (p[4] + p[5] * S3 + p[6] * S5 + p[7] * S15) / M) for p in P]
cell = 0.25; grid = defaultdict(list)
for i, z in enumerate(Z): grid[(math.floor(z.real / cell), math.floor(z.imag / cell))].append(i)
Rc = int((1 + 1e-7) / cell) + 2; edges = 0; bad = 0
for i, z in enumerate(Z):
    cx, cy = math.floor(z.real / cell), math.floor(z.imag / cell)
    for dx in range(-Rc, Rc + 1):
        for dy in range(-Rc, Rc + 1):
            for j in grid.get((cx + dx, cy + dy), ()):
                if j <= i: continue
                if abs(abs(Z[i] - Z[j]) ** 2 - 1.0) <= 1e-7:
                    d = [Fr(a - b, M) for a, b in zip(P[i], P[j])]
                    if fadd(fmul(tuple(d[:4]), tuple(d[:4])), fmul(tuple(d[4:]), tuple(d[4:]))) == ONEF:
                        edges += 1; bad += (cols[i] == cols[j])
print(f"ball {GRAPH}: {len(P)} points, my edges {edges} (file says {len(g['edges'])}), monochromatic under the pulled-back colouring: {bad}")
ok = (Smod == theirs and mono == 0 and gapped > 0 and bad == 0 and edges == len(g['edges']))
print("VERDICT:", "OK" if ok else "FAIL"); sys.exit(0 if ok else 1)
