#!/usr/bin/env python3
"""Owner's verifier of phase 1d's fan-gap closure on Lambda' (FS-70), independent of tools/fs70_*.

Rebuilds, from MY enumeration of the unit vectors of E' = Q(sqrt3, sqrt-5) to denominator 24 and MY Hermite basis, the
quotient Cayley graph Cay(Lambda'/N Lambda', U mod N); checks (a) the file's connection set equals mine as a set, (b) no unit
vector lies in N.Lambda', (c) the committed colouring is proper on MY edges, (d) which vertices carry a fan gap (a colour absent
from the CLOSED neighbourhood) -- one suffices for row 66's closure; then (e) pulls the colouring back to a Minkowski ball of
Lambda' that I build (both complex embeddings bounded by R) and checks it on the ball's unit-distance edges derived by the
float-annulus-plus-exact method.  A plant (--plant) recolours one vertex of the quotient by a colour present in its
neighbourhood and must be reported.  Usage: po_verify_quotient.py N [R] [--plant]"""
import sys, json, math, itertools
sys.path.insert(0, 'data/fs70/owner')
from fractions import Fraction as Fr
from collections import defaultdict
from po_additive_screen import units_with_denominator, fmul, fadd, fsub
from po_cm_subfield import hnf_cols, member   # my helpers (the module runs its screen on import; harmless)

N = int(sys.argv[1]); R = float(sys.argv[2]) if len(sys.argv) > 2 and not sys.argv[2].startswith('--') else None
PLANT = '--plant' in sys.argv
M = 24
U8 = [v for v in units_with_denominator(M) if v[2] == v[3] == 0 and v[4] == v[5] == 0]   # E' members: x in Q(sqrt3), y in sqrt5 Q(sqrt3)
U = [(a, b, g, h) for (a, b, c, d, e, f, g, h) in U8]
B = hnf_cols(U, dim=4)
print(f"E' unit vectors at denominator {M}: {len(U)}; HNF {B}")
def coords(v):
    v = list(v); out = []
    for b in B:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]: return None
        q = v[p] // b[p]; out.append(q); v = [a - q * c for a, c in zip(v, b)]
    return tuple(out) if all(x == 0 for x in v) else None
S = [coords(u) for u in U]; assert all(s is not None for s in S)
Smod = sorted({tuple(x % N for x in s) for s in S})
assert (0, 0, 0, 0) not in Smod, "a unit vector lies in N.Lambda'"
f = json.load(open(f'data/fs70/quotient/lambdaprime-N{N}.colouring.json'))
theirs = sorted(tuple(s) for s in f['connection_set']); col = f['colouring']
print(f"connection set mod {N}: mine {len(Smod)}, file {len(theirs)}, equal as sets: {Smod == theirs}")
verts = list(itertools.product(range(N), repeat=4)); vidx = {v: i for i, v in enumerate(verts)}
assert len(col) == len(verts)
if PLANT:
    v0 = 7; nbcols = {col[vidx[tuple((a + b) % N for a, b in zip(verts[v0], s))]] for s in Smod}
    col = list(col); col[v0] = next(c for c in nbcols); print(f"PLANT: vertex {v0} recoloured {col[v0]} (a colour of its neighbourhood)")
mono = 0; gapped = 0; gap_example = None
for i, v in enumerate(verts):
    nb = {col[vidx[tuple((a + b) % N for a, b in zip(v, s))]] for s in Smod}
    if col[i] in nb: mono += 1
    closed = nb | {col[i]}
    if len(closed) < 4:
        gapped += 1
        if gap_example is None: gap_example = (v, sorted(set(range(4)) - closed))
print(f"quotient: {len(verts)} vertices, degree {len(Smod)}; vertices with a monochromatic edge: {mono}; gapped vertices: {gapped}; example {gap_example}")
ok_q = (mono == 0 and gapped > 0 and Smod == theirs)
if R is not None:
    # Minkowski ball: lattice points a.B (a in Z^4) with |x + iy| <= R in both embeddings (sqrt3 -> +-sqrt3)
    S3, S5 = 3 ** .5, 5 ** .5
    def emb(pt, sgn):  # pt = (x0, x1, y2, y3) integers over M -> complex in embedding sgn
        x0, x1, y2, y3 = pt
        return complex(x0 + sgn * x1 * S3, S5 * (y2 + sgn * y3 * S3)) / M
    # enumerate: coordinates a_i bounded by |a| <= bound found by searching a box around the origin; the lattice is B-rows*a
    # use the coordinate box: |x0 + x1 sqrt3| <= R M, |x0 - x1 sqrt3| <= R M => |x0|,|x1 sqrt3| <= R M; same for y (with sqrt5)
    pts = set()
    RM = R * M + 1e-9
    for x0 in range(-int(RM) - 1, int(RM) + 2):
        for x1 in range(-int(RM / S3) - 1, int(RM / S3) + 2):
            if abs(x0 + x1 * S3) > RM or abs(x0 - x1 * S3) > RM: continue
            for y2 in range(-int(RM / S5) - 1, int(RM / S5) + 2):
                for y3 in range(-int(RM / (S5 * S3)) - 1, int(RM / (S5 * S3)) + 2):
                    p = (x0, x1, y2, y3)
                    if abs(emb(p, 1)) > R + 1e-9 or abs(emb(p, -1)) > R + 1e-9: continue
                    if coords(p) is not None: pts.add(p)
    P = sorted(pts); print(f"Minkowski ball R = {R}: {len(P)} lattice points")
    colour = [col[vidx[tuple(x % N for x in coords(p))]] for p in P]
    ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
    cell = 0.25; grid = defaultdict(list); Z = [emb(p, 1) for p in P]
    for i, z in enumerate(Z): grid[(math.floor(z.real / cell), math.floor(z.imag / cell))].append(i)
    Rc = int((1 + 1e-7) / cell) + 2; edges = 0; bad = 0
    for i, z in enumerate(Z):
        cx, cy = math.floor(z.real / cell), math.floor(z.imag / cell)
        for dx in range(-Rc, Rc + 1):
            for dy in range(-Rc, Rc + 1):
                for j in grid.get((cx + dx, cy + dy), ()):
                    if j <= i: continue
                    if abs(abs(Z[i] - Z[j]) ** 2 - 1.0) <= 1e-7:
                        d = tuple(a - b for a, b in zip(P[i], P[j]))
                        x = (Fr(d[0], M), Fr(d[1], M), Fr(0), Fr(0)); y = (Fr(0), Fr(0), Fr(d[2], M), Fr(d[3], M))
                        if fadd(fmul(x, x), fmul(y, y)) == ONE:
                            edges += 1
                            if colour[i] == colour[j]: bad += 1
    print(f"ball edges (my derivation) {edges}, average degree {2 * edges / len(P):.2f}; monochromatic under the pulled-back colouring: {bad}; colours used {sorted(set(colour))}")
    ok_q = ok_q and bad == 0
print("VERDICT:", "OK" if ok_q else "FAIL")
sys.exit(0 if ok_q else 1)
