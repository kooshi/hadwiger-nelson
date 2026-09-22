#!/usr/bin/env python3
"""fs70_fabric -- lattices of unit vectors over Q(sqrt3, sqrt5), their saturation (every unit vector the lattice holds),
the additive four-colouring screen, Haugland's T_n bidisc between A = 0 and B = i*sqrt3, and the CNF of the pinned ask.
Standard library plus a call to PARI/gp (`qfminim`, exact flag) for the saturation.  UNTRUSTED (tools/).

Objects.  A lattice is the Z-span of a finite set S of unit vectors (S is taken closed under negation).  Its points live in
F^2 = Q^8 (coordinates a..d of x and e..h of y); with a common denominator M they are integer 8-vectors, and the lattice is a
row-HNF over Z.  Its saturation Lambda cap U is finite: under the Minkowski embedding F^2 -> R^8 the form
    B(lambda, mu) = Tr_{F/Q}(x x' + y y')
is positive definite, B(lambda, lambda) = Tr(|lambda|^2) = 4 for a unit vector, so the unit vectors of Lambda are among the
lattice vectors of B-norm exactly 4, which qfminim enumerates exactly; the exact identity |lambda|^2 = 1 then decides.

The additive screen (Haugland section 4; CLAUDE.md G41).  An additive 4-colouring of Lambda is a homomorphism phi from
Lambda to a group of order 4 (Z/4 or the Klein group) that is nonzero on every unit vector of Lambda; it colours every finite
graph drawn in Lambda properly.  Hom(Lambda, G) = G^rank is enumerated in full.  Reported: how many exist; how many send the
target difference B - A = i sqrt3 to 0 (each such phi is a four-colouring in which A and B share a colour, so the sqrt3
virtual edge is impossible on any graph drawn in Lambda); how many send 2 to a nonzero value (each such phi separates every
pair at distance 2, so no distance-2 forced pair exists on any graph drawn in Lambda).

Usage:
  python3 tools/fs70_fabric.py lattice NAME [NAME ...]     # the named generating sets, saturation, screen
  python3 tools/fs70_fabric.py tn NAME n [--out DIR]       # build T_n over lattice NAME, write the pinned CNF + control CNF
The named generating sets are in GENERATORS below; NAME can also be a '+'-joined list of family names.
"""
import itertools
import json
import math
import os
import subprocess
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs70_field import *  # noqa: E402,F401,F403

# ---------------------------------------------------------------- families of unit vectors (each closed under zeta12 and conj)

def orbit(z):
    """the 24-or-fewer vectors zeta12^k z and zeta12^k conj(z)"""
    out = {}
    for k in range(12):
        for w in (z, e_conj(z)):
            r = e_mul(e_pow(ZETA12, k), w)
            out[canonical(r)] = r
    return list(out.values())


FAMILIES = {
    'zeta12': orbit(E_ONE),                                  # 12 roots of unity            (2-units)
    'u3': orbit(U_SQRT5),                                    # (-2 + i sqrt5)/3 family      (2-units, 3-depth +-2)
    'v4': orbit(V_SQRT15),                                   # (1 + i sqrt15)/4 family      (2-depth +-2)
    'w4': orbit(W_MIX),                                      # ((s3+s5) + i(s5-s3))/4       (2-depth +-1)
    'rho15': orbit(RHO15),                                   # (7 + i sqrt15)/8             (2-depth +-4)
    'q5': orbit(((Fr(3, 5), ZERO[1], ZERO[2], ZERO[3]), (Fr(4, 5), ZERO[1], ZERO[2], ZERO[3]))),  # (3+4i)/5 (5-depths)
    's5': orbit(((Fr(0), Fr(0), Fr(2, 5), Fr(0)), (Fr(0), Fr(0), Fr(1, 5), Fr(0)))),               # (2 sqrt5 + i sqrt5)/5
    'q7': orbit(((Fr(1, 7), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(4, 7), Fr(0), Fr(0)))),               # (1 + 4 i sqrt3)/7
    's7': orbit(((Fr(2, 7), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(3, 7), Fr(0)))),               # (2 + 3 i sqrt5)/7
}
for _nm, _fam in FAMILIES.items():
    for _z in _fam:
        assert e_is_unit_vector(_z), (_nm, e_str(_z))


def generators(name):
    S = {}
    for part in name.split('+'):
        for z in FAMILIES[part]:
            S[canonical(z)] = z
    return list(S.values())


# ---------------------------------------------------------------- integer lattices in Q^8

def to_vec8(z):
    return tuple(z[0]) + tuple(z[1])


def from_vec8(v):
    return (tuple(v[:4]), tuple(v[4:]))


def hnf(rows, dim=8):
    """row Hermite normal form of the Z-span of integer vectors"""
    work = [list(r) for r in rows if any(r)]
    basis = []
    for col in range(dim):
        while len([r for r in work if r[col]]) > 1:
            nz = sorted((r for r in work if r[col]), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(dim):
                    r[j] -= q * p[j]
            work = [r for r in work if any(r)]
        k = next((i for i, r in enumerate(work) if r[col]), None)
        if k is None:
            continue
        p = work.pop(k)
        if p[col] < 0:
            p = [-x for x in p]
        basis.append((col, p))
    for i in range(len(basis)):
        ci, pi = basis[i]
        for k in range(i):
            pk = basis[k][1]
            q = pk[ci] // pi[ci]
            if q:
                for j in range(dim):
                    pk[j] -= q * pi[j]
    return [tuple(r) for _, r in basis]


def coords_in_basis(H, v, dim=8):
    """integer coordinates of v in the HNF basis H, or None"""
    v = list(v)
    cs = []
    for row in H:
        c = next(j for j in range(dim) if row[j])
        if v[c] % row[c]:
            return None
        q = v[c] // row[c]
        cs.append(q)
        if q:
            for j in range(dim):
                v[j] -= q * row[j]
    return tuple(cs) if not any(v) else None


class Lattice:
    def __init__(self, S):
        self.S = S
        self.M = 1
        for z in S:
            self.M = self.M * e_denominator(z) // math.gcd(self.M, e_denominator(z))
        rows = [tuple(int(q * self.M) for q in to_vec8(z)) for z in S]
        self.H = hnf(rows)
        self.rank = len(self.H)
        # basis as E elements
        self.basis = [from_vec8(tuple(Fr(x, self.M) for x in row)) for row in self.H]

    def contains(self, z):
        v = to_vec8(z)
        for q in v:
            if (q * self.M).denominator != 1:
                return False
        return coords_in_basis(self.H, tuple(int(q * self.M) for q in v)) is not None

    def coords(self, z):
        v = to_vec8(z)
        return coords_in_basis(self.H, tuple(int(q * self.M) for q in v))

    def gram(self):
        """the trace form on the basis, as Fractions"""
        G = []
        for bi in self.basis:
            row = []
            for bj in self.basis:
                s = f_add(f_mul(bi[0], bj[0]), f_mul(bi[1], bj[1]))
                row.append(f_trace(s))
            G.append(row)
        return G

    def saturation(self):
        """every unit vector in the lattice: qfminim (exact flag) enumerates the lattice vectors of trace-norm <= 4 (millions
        when the lattice is dense), gp filters them by the four real embeddings numerically, Python decides exactly"""
        G = self.gram()
        L = 1
        for row in G:
            for q in row:
                L = L * q.denominator // math.gcd(L, q.denominator)
        Gi = [[int(q * L) for q in row] for row in G]
        mat = '[' + ';'.join(','.join(str(x) for x in row) for row in Gi) + ']'
        # embedding matrix: row j = (s1(x_j), s1(y_j), ..., s4(x_j), s4(y_j)) for the four sign choices of (sqrt3, sqrt5)
        emb_rows = []
        for (x, y) in self.basis:
            row = []
            for s3 in (math.sqrt(3), -math.sqrt(3)):
                for s5 in (math.sqrt(5), -math.sqrt(5)):
                    row.append(repr(f_float(x, s3, s5)))
                    row.append(repr(f_float(y, s3, s5)))
            emb_rows.append(','.join(row))
        emb = '[' + ';'.join(emb_rows) + ']'
        script = (f'G = {mat}; Emb = {emb}; v = qfminim(G, {4 * L}, , 2); n = 0; '
                  f'for(k=1, #v[3], w = v[3][,k]~ * Emb; ok = 1; for(t=0,3, if(abs(w[2*t+1]^2 + w[2*t+2]^2 - 1) > 1e-6, ok = 0)); '
                  f'if(ok, n++; print(Vec(v[3][,k])))); print("count ", n)')
        out = subprocess.run(['gp', '-q', '-s', '4000000000'], input=script + '\n', capture_output=True, text=True)
        if out.returncode != 0 or 'count' not in out.stdout:
            raise RuntimeError('gp failed: ' + out.stderr[-2000:] + out.stdout[-500:])
        units = {}
        for line in out.stdout.strip().split('\n'):
            if line.startswith('count'):
                continue
            c = [int(x) for x in line.strip('[] \n').split(',')]
            for sign in (1, -1):
                z = E_ZERO
                for ci, b in zip(c, self.basis):
                    if ci:
                        z = e_add(z, e_scale(sign * ci, b))
                if e_is_unit_vector(z):
                    units[canonical(z)] = z
        return list(units.values())


# ---------------------------------------------------------------- the additive screen

def hom_values(rank, group):
    """all homomorphisms from Z^rank to the group, as tuples of images of the basis"""
    if group == 'Z4':
        elems = [0, 1, 2, 3]
    else:
        elems = [(0, 0), (0, 1), (1, 0), (1, 1)]
    return itertools.product(elems, repeat=rank), elems


def apply_hom(images, coords, group):
    if group == 'Z4':
        return sum(i * c for i, c in zip(images, coords)) % 4
    a = sum(i[0] * c for i, c in zip(images, coords)) % 2
    b = sum(i[1] * c for i, c in zip(images, coords)) % 2
    return (a, b)


def additive_screen(lat, units, targets):
    """targets: dict name -> E element (a difference).  Returns per group: count of proper additive colourings, and for each
    target the number of colourings with phi(target) = 0."""
    ucoords = [lat.coords(z) for z in units]
    assert all(c is not None for c in ucoords)
    tcoords = {nm: lat.coords(t) for nm, t in targets.items()}
    res = {}
    for group in ('Z4', 'K4'):
        zero = 0 if group == 'Z4' else (0, 0)
        homs, _ = hom_values(lat.rank, group)
        count = 0
        zeros = {nm: 0 for nm in targets}
        examples = {nm: None for nm in targets}
        for images in homs:
            ok = True
            for c in ucoords:
                if apply_hom(images, c, group) == zero:
                    ok = False
                    break
            if not ok:
                continue
            count += 1
            for nm, tc in tcoords.items():
                if tc is None:
                    continue
                if apply_hom(images, tc, group) == zero:
                    zeros[nm] += 1
                    if examples[nm] is None:
                        examples[nm] = images
        res[group] = {'proper': count, 'target_zero': zeros, 'in_lattice': {nm: tc is not None for nm, tc in tcoords.items()},
                      'example': {nm: (list(ex) if ex is not None else None) for nm, ex in examples.items()}}
    return res


# ---------------------------------------------------------------- T_n

def t_n(units, A, B, n):
    """points on unit-vector paths from A to B of length <= n over the direction set `units`; returns (points, dA, dB)"""
    def bfs(start):
        dist = {canonical(start): 0}
        frontier = [start]
        pts = {canonical(start): start}
        for d in range(1, n + 1):
            nxt = []
            for p in frontier:
                for s in units:
                    q = e_add(p, s)
                    k = canonical(q)
                    if k not in dist:
                        dist[k] = d
                        pts[k] = q
                        nxt.append(q)
            frontier = nxt
        return dist, pts
    dA, pA = bfs(A)
    dB, pB = bfs(B)
    keep = {}
    for k, d in dA.items():
        if k in dB and d + dB[k] <= n:
            keep[k] = pA[k]
    return keep, dA, dB


def unit_graph(points, units):
    """edges of the unit-distance graph on the point dict {key: E element}, directions restricted to `units` (complete when
    `units` is the saturation of the lattice the points lie in)"""
    keys = list(points)
    index = {k: i for i, k in enumerate(keys)}
    edges = set()
    for k in keys:
        p = points[k]
        for s in units:
            q = canonical(e_add(p, s))
            j = index.get(q)
            if j is not None:
                i = index[k]
                if i < j:
                    edges.add((i, j))
    return keys, sorted(edges)


def m_core(n, edges, m):
    """vertices of the m-core, as a sorted list of original indices; and the induced edges"""
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    alive = set(range(n))
    changed = True
    while changed:
        changed = False
        for v in list(alive):
            if len(adj[v] & alive) < m:
                alive.discard(v)
                changed = True
    keep = sorted(alive)
    pos = {v: i for i, v in enumerate(keep)}
    es = [(pos[a], pos[b]) for a, b in edges if a in alive and b in alive]
    return keep, es


# ---------------------------------------------------------------- CNF

def var(v, c, k=4):
    return k * v + c + 1


def coloring_cnf(n, edges, k, pins, precedence=True, amo=True):
    """one-hot k-colouring; pins: list of (vertex, colour); precedence: colour c at v needs colour c-1 at some u < v, for
    c >= 2 (colour 0 and 1 are fixed by the pins / the first free vertex), applied to colours not pinned anywhere."""
    clauses = []
    for v in range(n):
        clauses.append([var(v, c, k) for c in range(k)])
        if amo:
            for c1 in range(k):
                for c2 in range(c1 + 1, k):
                    clauses.append([-var(v, c1, k), -var(v, c2, k)])
    for a, b in edges:
        for c in range(k):
            clauses.append([-var(a, c, k), -var(b, c, k)])
    for v, c in pins:
        clauses.append([var(v, c, k)])
    if precedence:
        pinned = {c for _, c in pins}
        free = [c for c in range(k) if c not in pinned]
        # among the free colours in increasing order: free[j] at v implies free[j-1] at some u < v
        for j in range(1, len(free)):
            c, cp = free[j], free[j - 1]
            for v in range(n):
                clauses.append([-var(v, c, k)] + [var(u, cp, k) for u in range(v)])
    return clauses


def write_cnf(path, nvars, clauses):
    with open(path, 'w') as f:
        f.write(f'p cnf {nvars} {len(clauses)}\n')
        for cl in clauses:
            f.write(' '.join(str(x) for x in cl) + ' 0\n')


# ---------------------------------------------------------------- commands

def cmd_lattice(names):
    for name in names:
        S = generators(name)
        lat = Lattice(S)
        units = lat.saturation()
        dep = {}
        for z in units:
            dep[depths(z)] = dep.get(depths(z), 0) + 1
        print(f'== {name}: |S| = {len(S)}, denominator {lat.M}, rank {lat.rank}, g = |Lambda cap U| = {len(units)}')
        print('   depths of the saturation (P2,P3,P5):', dict(sorted(dep.items())))
        two = (f_scale(2, ONE), ZERO)
        res = additive_screen(lat, units, {'i sqrt3': I_SQRT3, '2': two, '4/3': (f_scale(Fr(4, 3), ONE), ZERO),
                                           '8/3': (f_scale(Fr(8, 3), ONE), ZERO)})
        for g, r in res.items():
            print(f'   additive {g}: proper colourings {r["proper"]}; target in lattice {r["in_lattice"]}; '
                  f'phi(target)=0 counts {r["target_zero"]}')
        # covolume-ish figure: det of gram
        print()


TARGETS = {'isqrt3': I_SQRT3, '4/3': (f_scale(Fr(4, 3), ONE), ZERO), '8/3': (f_scale(Fr(8, 3), ONE), ZERO),
           '2': (f_scale(2, ONE), ZERO), '4': (f_scale(4, ONE), ZERO)}


def cmd_tn(name, n, out=None, core=None, target='isqrt3'):
    S = generators(name)
    lat = Lattice(S)
    units = lat.saturation()
    A = E_ZERO
    B = TARGETS[target]
    pts, dA, dB = t_n(units, A, B, n)
    keys, edges = unit_graph(pts, units)
    N = len(keys)
    deg = 2 * len(edges) / N if N else 0
    print(f'T_{n} over {name}: |S|={len(S)} g={len(units)} points={N} edges={len(edges)} avg degree={deg:.2f}')
    if core:
        keep, edges2 = m_core(N, edges, core)
        keys = [keys[i] for i in keep]
        edges = edges2
        N = len(keys)
        deg = 2 * len(edges) / N if N else 0
        print(f'  {core}-core: points={N} edges={len(edges)} avg degree={deg:.2f}')
    ia = keys.index(canonical(A))
    ib = keys.index(canonical(B))
    if out:
        os.makedirs(out, exist_ok=True)
        # relabel so A = 0, B = 1
        order = [ia, ib] + [i for i in range(N) if i not in (ia, ib)]
        pos = {v: i for i, v in enumerate(order)}
        edges_r = sorted(tuple(sorted((pos[a], pos[b]))) for a, b in edges)
        pts_r = [pts[keys[i]] for i in order]
        meta = {'lattice': name, 'n': n, 'points': N, 'edges': len(edges_r), 'avg_degree': deg,
                'A': 0, 'B': 1, 'core': core, 'target': target}
        with open(os.path.join(out, 'graph.json'), 'w') as f:
            json.dump({'meta': meta, 'points': [[str(q) for q in to_vec8(p)] for p in pts_r], 'edges': edges_r}, f)
        # pinned ask: A and B both colour 0 ; a neighbour of A gets colour 1 (arc-transitivity is NOT available here, so
        # only the colour-permutation symmetry is broken: precedence over the free colours)
        cl = coloring_cnf(N, edges_r, 4, [(0, 0), (1, 0)])
        write_cnf(os.path.join(out, 'pinned.cnf'), 4 * N, cl)
        # the forced-equal ask: A = 0, B = 1 (the other colours are interchangeable: precedence over {2, 3}); UNSAT means
        # every 4-colouring gives A and B one colour
        cl3 = coloring_cnf(N, edges_r, 4, [(0, 0), (1, 1)])
        write_cnf(os.path.join(out, 'pinned_neq.cnf'), 4 * N, cl3)
        # the control: a triangle pinned (A, A+1, A+zeta6 if present), four colours
        tri = []
        for i, p in enumerate(pts_r):
            if canonical(p) == canonical(E_ONE):
                tri.append((i, 1))
            if canonical(p) == canonical(ZETA6):
                tri.append((i, 2))
        cl2 = coloring_cnf(N, edges_r, 4, [(0, 0)] + tri)
        write_cnf(os.path.join(out, 'control.cnf'), 4 * N, cl2)
        print(f'  wrote {out}/graph.json, pinned.cnf ({len(cl)} clauses), control.cnf ({len(cl2)} clauses; pins {[(0,0)]+tri})')


# ---------------------------------------------------------------- Minkowski balls (FS-61's ball shape, four embeddings)

def minkowski_ball(lat, R):
    """all lattice points p with |sigma(p)| <= R under each of the four real embeddings sigma of F (a 4-disc product in R^8,
    finite): qfminim on the trace form with bound 4R^2 proposes, gp filters by the embeddings, Python keeps the exact points"""
    G = lat.gram()
    L = 1
    for row in G:
        for q in row:
            L = L * q.denominator // math.gcd(L, q.denominator)
    Gi = [[int(q * L) for q in row] for row in G]
    mat = '[' + ';'.join(','.join(str(x) for x in row) for row in Gi) + ']'
    emb_rows = []
    for (x, y) in lat.basis:
        row = []
        for s3 in (math.sqrt(3), -math.sqrt(3)):
            for s5 in (math.sqrt(5), -math.sqrt(5)):
                row.append(repr(f_float(x, s3, s5)))
                row.append(repr(f_float(y, s3, s5)))
        emb_rows.append(','.join(row))
    emb = '[' + ';'.join(emb_rows) + ']'
    bound = int(math.ceil(4 * R * R * L))
    script = (f'G = {mat}; Emb = {emb}; v = qfminim(G, {bound}, , 2); n = 0; '
              f'for(k=1, #v[3], w = v[3][,k]~ * Emb; ok = 1; for(t=0,3, if(w[2*t+1]^2 + w[2*t+2]^2 > {R * R} + 1e-9, ok = 0)); '
              f'if(ok, n++; print(Vec(v[3][,k])))); print("count ", n)')
    out = subprocess.run(['gp', '-q', '-s', '4000000000'], input=script + '\n', capture_output=True, text=True)
    if out.returncode != 0 or 'count' not in out.stdout:
        raise RuntimeError('gp failed: ' + out.stderr[-2000:] + out.stdout[-500:])
    pts = {canonical(E_ZERO): E_ZERO}
    R2 = Fr(R).limit_denominator(1000) ** 2
    for line in out.stdout.strip().split('\n'):
        if line.startswith('count'):
            continue
        c = [int(x) for x in line.strip('[] \n').split(',')]
        for sign in (1, -1):
            z = E_ZERO
            for ci, b in zip(c, lat.basis):
                if ci:
                    z = e_add(z, e_scale(sign * ci, b))
            # exact check: every embedding of |z|^2 is <= R^2
            n2 = e_normF(z)
            ok = True
            for s3 in (1, -1):
                for s5 in (1, -1):
                    a, b_, c_, d = n2
                    val = a + b_ * s3 * Fr(1732050807568877, 10**15) + c_ * s5 * Fr(2236067977499790, 10**15) + \
                        d * s3 * s5 * Fr(3872983346207417, 10**15)
                    if val > R2 + Fr(1, 10**6):
                        ok = False
            if ok:
                pts[canonical(z)] = z
    return pts


def cmd_ball(name, R, out=None, core=None, targets=('isqrt3', '4/3', '8/3', '2')):
    S = generators(name)
    lat = Lattice(S)
    units = lat.saturation()
    pts = minkowski_ball(lat, R)
    keys, edges = unit_graph(pts, units)
    N = len(keys)
    deg = 2 * len(edges) / N if N else 0
    print(f'ball R={R} over {name}: |S|={len(S)} g={len(units)} points={N} edges={len(edges)} avg degree={deg:.2f}')
    if core:
        keep, edges2 = m_core(N, edges, core)
        keys = [keys[i] for i in keep]
        edges = edges2
        N = len(keys)
        deg = 2 * len(edges) / N if N else 0
        print(f'  {core}-core: points={N} edges={len(edges)} avg degree={deg:.2f}')
    if out:
        os.makedirs(out, exist_ok=True)
        index = {k: i for i, k in enumerate(keys)}
        pts_l = [pts[k] for k in keys]
        with open(os.path.join(out, 'graph.json'), 'w') as f:
            json.dump({'meta': {'lattice': name, 'R': R, 'points': N, 'edges': len(edges), 'avg_degree': deg, 'core': core},
                       'points': [[str(q) for q in to_vec8(p)] for p in pts_l], 'edges': edges}, f)
        i0 = index[canonical(E_ZERO)]
        tri = [(i0, 0)]
        for z, c in ((E_ONE, 1), (ZETA6, 2)):
            if canonical(z) in index:
                tri.append((index[canonical(z)], c))
        cl = coloring_cnf(N, edges, 4, tri)
        write_cnf(os.path.join(out, 'control.cnf'), 4 * N, cl)
        print(f'  control.cnf: {len(cl)} clauses, pins {tri}')
        for t in targets:
            tz = TARGETS[t]
            if canonical(tz) not in index:
                continue
            it = index[canonical(tz)]
            cl_eq = coloring_cnf(N, edges, 4, [(i0, 0), (it, 0)])   # refuses => virtual edge at t
            cl_ne = coloring_cnf(N, edges, 4, [(i0, 0), (it, 1)])   # refuses => forced equal at t
            tn = t.replace('/', 'over')
            write_cnf(os.path.join(out, f'sep_{tn}.cnf'), 4 * N, cl_eq)
            write_cnf(os.path.join(out, f'eq_{tn}.cnf'), 4 * N, cl_ne)
            print(f'  target {t}: vertex {it}; sep_{tn}.cnf / eq_{tn}.cnf written')


if __name__ == '__main__':
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        sys.exit(0)
    if args[0] == 'lattice':
        cmd_lattice(args[1:])
    elif args[0] == 'tn':
        out = None
        core = None
        if '--out' in args:
            out = args[args.index('--out') + 1]
        if '--core' in args:
            core = int(args[args.index('--core') + 1])
        target = 'isqrt3'
        if '--target' in args:
            target = args[args.index('--target') + 1]
        cmd_tn(args[1], int(args[2]), out, core, target)
    elif args[0] == 'ball':
        out = None
        core = None
        if '--out' in args:
            out = args[args.index('--out') + 1]
        if '--core' in args:
            core = int(args[args.index('--core') + 1])
        cmd_ball(args[1], float(args[2]), out, core)
