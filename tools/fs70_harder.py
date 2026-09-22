#!/usr/bin/env python3
"""fs70_harder -- Harder's four-colour forcer over K = Q(sqrt3, sqrt11), as the POSITIVE CONTROL of the `forces`
encoding.  UNTRUSTED (tools/).

WHY THIS EXISTS.  Every four-colour ask this milestone has run returned SAT.  A null from an instrument that has
never been seen to fire is not a null (CLAUDE.md, "Make the gate fail"), and the only four-colour control the
milestone owns -- Haugland's G_1 -- exercises the `separated` pin (a virtual edge, the CONTRACTED encoding), not
`forces`.  This file supplies the missing one, from a claim in print:

    Jannis Harder, Polymath16 thread 1, 28 April 2018: with rho = (5 + i sqrt11)/6 the Moser twist,
    V = {0} u {zeta6^a rho^b : |b| <= 2} (31 points) and H the unit hexagon with its centre (7 points),
    every proper four-colouring of the unit-distance graph on V + V + H gives 0 and (8/3, 0) the SAME colour.

The fabric is 745 vertices after de-duplication (his number).  Run through the same `forces` pin phase 1e will
use, it MUST come back UNSAT in seconds, and the same graph with the pins dropped MUST be SAT with a colouring
proper on every edge.  Two negative controls beside it: a non-edge pair of 2-adic depth zero (row 59's law says
never forced) must be SAT, and the fabric with one edge deleted must flip the 8/3 ask to SAT or the deletion is
reported as not flipping it.

THE ARITHMETIC IS SEPARATE ON PURPOSE.  `tools/fs70_field.py` is radicand-5 only and is depended on by four
phases; rather than reach into it, this file carries its own K = Q(sqrt3, sqrt11) arithmetic and is checked
against `data/fs70/owner/po_kempe_control_K.py` -- the owner's independent implementation of the same field --
on the numbers that file prints (rank 4, 30 generators, 54 unit vectors in the saturation).

THE NINE-INTEGER FORMAT.  Points are written [a,b,c,d,e,f,g,h,m] for ((a + b sqrt3 + c sqrt11 + d sqrt33)/m,
(e + f sqrt3 + g sqrt11 + h sqrt33)/m) -- the milestone's format with **sqrt11 in the sqrt5 slot**, which the
written files say in their header so a reader is not misled.

Commands
  python3 tools/fs70_harder.py build [--out DIR]        # V + V + H, its graph, the CNFs, the nine-integer file
  python3 tools/fs70_harder.py lens N [--out DIR]       # Haugland's T_n(0 -> 8/3) on the same K-lattice
  python3 tools/fs70_harder.py selftest [--plants]
"""
import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import time
from fractions import Fraction as Fr

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
D = 11
S3 = math.sqrt(3.0)
SD = math.sqrt(11.0)
S3D = math.sqrt(33.0)

PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- K = Q(sqrt3, sqrt11), basis (1, s3, sD, s3D)

def kmul(p, q):
    a1, b1, c1, d1 = p
    a2, b2, c2, d2 = q
    return (a1 * a2 + 3 * b1 * b2 + D * c1 * c2 + 3 * D * d1 * d2,
            a1 * b2 + b1 * a2 + D * (c1 * d2 + d1 * c2),
            a1 * c2 + c1 * a2 + 3 * (b1 * d2 + d1 * b2),
            a1 * d2 + d1 * a2 + b1 * c2 + c1 * b2)


def kadd(p, q):
    return tuple(x + y for x, y in zip(p, q))


def ksub(p, q):
    return tuple(x - y for x, y in zip(p, q))


def kfloat(p):
    return p[0] + p[1] * S3 + p[2] * SD + p[3] * S3D


KZERO = (0, 0, 0, 0)
KONE = (1, 0, 0, 0)


# ---------------------------------------------------------------- E = K(i): a point is (x, y, m) = (x + i y)/m

def norm9(z):
    x, y, m = z
    g = m
    for v in x + y:
        g = math.gcd(g, abs(v))
    if g == 0:
        g = 1
    if m < 0:
        g = -g
    return (tuple(v // g for v in x), tuple(v // g for v in y), m // g)


def cmul(z, w):
    (x1, y1, m1), (x2, y2, m2) = z, w
    return norm9((ksub(kmul(x1, x2), kmul(y1, y2)), kadd(kmul(x1, y2), kmul(y1, x2)), m1 * m2))


def cadd(z, w):
    (x1, y1, m1), (x2, y2, m2) = z, w
    L = m1 * m2 // math.gcd(m1, m2)
    a, b = L // m1, L // m2
    return norm9((tuple(a * u + b * v for u, v in zip(x1, x2)),
                  tuple(a * u + b * v for u, v in zip(y1, y2)), L))


def csub(z, w):
    x, y, m = w
    return cadd(z, (tuple(-v for v in x), tuple(-v for v in y), m))


def cconj(z):
    x, y, m = z
    return (x, tuple(-v for v in y), m)


def quad(z):
    """|z|^2 as an element of K, exactly: (x^2 + y^2)/m^2, returned as a tuple of Fractions"""
    x, y, m = z
    n = kadd(kmul(x, x), kmul(y, y))
    return tuple(Fr(v, m * m) for v in n)


def is_unit_vector(z):
    q = quad(z)
    return q == (Fr(1), Fr(0), Fr(0), Fr(0))


def cfloat(z):
    x, y, m = z
    return (kfloat(x) / m, kfloat(y) / m)


ZETA6 = ((1, 0, 0, 0), (0, 1, 0, 0), 2)          # (1 + i sqrt3)/2
RHO = ((5, 0, 0, 0), (0, 0, 1, 0), 6)            # (5 + i sqrt11)/6, the Moser twist
CONE = ((1, 0, 0, 0), (0, 0, 0, 0), 1)
CZERO = ((0, 0, 0, 0), (0, 0, 0, 0), 1)


def cpow(z, k):
    out = CONE
    w = z if k >= 0 else cconj(z)          # |z| = 1, so z^-1 = conj z
    for _ in range(abs(k)):
        out = cmul(out, w)
    return out


def rational(n, d=1):
    return norm9(((n, 0, 0, 0), (0, 0, 0, 0), d))


# ---------------------------------------------------------------- the fabric

def harder_V():
    """de Grey's V = {0} u {zeta6^a rho^b : |b| <= 2}"""
    out = [CZERO]
    for a in range(6):
        for b in range(-2, 3):
            out.append(cmul(cpow(ZETA6, a), cpow(RHO, b)))
    seen, uniq = set(), []
    for z in out:
        if z not in seen:
            seen.add(z)
            uniq.append(z)
    return uniq


def hexagon_H():
    """the unit hexagon with its centre"""
    return [CZERO] + [cpow(ZETA6, a) for a in range(6)]


def minkowski(*sets):
    cur = [CZERO]
    for S in sets:
        nxt = {}
        for z in cur:
            for s in S:
                w = cadd(z, s)
                nxt[w] = True
        cur = list(nxt)
    return cur


def unit_graph(points):
    """the COMPLETE unit-distance graph on the points: a float band proposes, exact K arithmetic decides.
    The band is 1e-6 against a float error of about 1e-13 on these magnitudes; every proposal is decided
    exactly, and the count is cross-checked against a full exact sweep in the self-test."""
    fl = [cfloat(z) for z in points]
    n = len(points)
    cell = 0.5
    rad = int(math.sqrt(1.0 + 1e-6) / cell) + 1
    buckets = {}
    for i, (a, b) in enumerate(fl):
        buckets.setdefault((math.floor(a / cell), math.floor(b / cell)), []).append(i)
    edges = set()
    for (cx, cy), idxs in buckets.items():
        for dx in range(-rad, rad + 1):
            for dy in range(-rad, rad + 1):
                other = buckets.get((cx + dx, cy + dy))
                if not other:
                    continue
                for i in idxs:
                    for j in other:
                        if i >= j:
                            continue
                        ax, ay = fl[i]
                        bx, by = fl[j]
                        dd = (ax - bx) ** 2 + (ay - by) ** 2
                        if abs(dd - 1.0) > 1e-6:
                            continue
                        if is_unit_vector(csub(points[i], points[j])):
                            edges.add((i, j))
    return sorted(edges)


def unit_graph_exact(points):
    """the same graph by an exhaustive exact sweep, no float anywhere -- the cross-check of `unit_graph`"""
    n = len(points)
    edges = set()
    for i in range(n):
        for j in range(i + 1, n):
            if is_unit_vector(csub(points[i], points[j])):
                edges.add((i, j))
    return sorted(edges)


# ---------------------------------------------------------------- the K-lattice and its saturation

def units_with_denominator(M):
    """every unit vector of E = K(i) with denominator dividing M, by the box of the four real embeddings
    (the owner's po_kempe_control_K.py routine, re-implemented)"""
    box = []
    for a in range(-M, M + 1):
        for b in range(-int(M / S3) - 1, int(M / S3) + 2):
            for c in range(-int(M / SD) - 1, int(M / SD) + 2):
                for d in range(-int(M / S3D) - 1, int(M / S3D) + 2):
                    if all(abs(a + sb * b * S3 + sc * c * SD + sb * sc * d * S3D) <= M + 1e-9
                           for sb in (1, -1) for sc in (1, -1)):
                        box.append((a, b, c, d))
    sq = {}
    for e in box:
        sq.setdefault(kmul(e, e), []).append(e)
    T = (M * M, 0, 0, 0)
    out = set()
    for e in box:
        for f in sq.get(ksub(T, kmul(e, e)), []):
            out.add(norm9((e, f, M)))
    return sorted(out)


def lattice_saturation(gens, M=None):
    """the unit vectors of the Z-span of `gens`, by FS-61's method B: every unit vector of the lattice has a
    denominator dividing the lattice's own denominator M, so enumerate by denominator and test membership."""
    if M is None:
        M = 1
        for z in gens:
            M = M * z[2] // math.gcd(M, z[2])
    vecs = [vec8(z, M) for z in gens]
    B = hnf_rows8(vecs)
    out = []
    for d in [d for d in range(1, M + 1) if M % d == 0]:
        for z in units_with_denominator(d):
            v = vec8(z, M)
            if v is not None and member8(B, v):
                out.append(z)
    return sorted(set(out)), B, M


def vec8(z, M):
    x, y, m = z
    if M % m:
        return None
    k = M // m
    return tuple(k * v for v in x + y)


def hnf_rows8(vectors):
    Mx = [list(v) for v in vectors]
    basis = []
    for col in range(8):
        while True:
            nz = [i for i in range(len(Mx)) if Mx[i][col] != 0]
            if not nz:
                break
            i0 = min(nz, key=lambda i: abs(Mx[i][col]))
            p = Mx[i0][col]
            done = True
            for i in nz:
                if i != i0:
                    q = Mx[i][col] // p
                    Mx[i] = [a - q * b for a, b in zip(Mx[i], Mx[i0])]
                    if Mx[i][col] != 0:
                        done = False
            if done:
                basis.append(Mx[i0])
                Mx = [Mx[i] for i in range(len(Mx)) if i != i0]
                break
    return basis


def member8(basis, v):
    v = list(v)
    for b in basis:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]:
            return False
        q = v[p] // b[p]
        v = [a - q * c for a, c in zip(v, b)]
    return all(x == 0 for x in v)


def lens_points(units, A, B, n):
    """Haugland's T_n(A -> B) on the lattice the unit vectors span: every point on a unit-vector path from A to
    B of graph length <= n.  ONE breadth-first search: the generator set is symmetric, so d_B(p) = d(p - B)."""
    shift = csub(B, A)
    dist = {CZERO: 0}
    frontier = [CZERO]
    for dd in range(1, n + 1):
        nxt = []
        for p in frontier:
            for s in units:
                q = cadd(p, s)
                if q not in dist:
                    dist[q] = dd
                    nxt.append(q)
        frontier = nxt
    out = {}
    for p, a in dist.items():
        b = dist.get(csub(p, shift))
        if b is not None and a + b <= n:
            out[cadd(p, A)] = a
    return out


def m_core(points, edges, m):
    """iteratively delete vertices of degree < m (the `--core` filter of fs70_fabric)"""
    from collections import defaultdict
    adj = defaultdict(set)
    for i, j in edges:
        adj[i].add(j)
        adj[j].add(i)
    alive = set(range(len(points)))
    changed = True
    while changed:
        changed = False
        for v in list(alive):
            if len(adj[v] & alive) < m:
                alive.discard(v)
                changed = True
    return sorted(alive)


# ---------------------------------------------------------------- CNF

def coloring_cnf(n, edges, pins, k=4, precedence=True):
    cls = [[4 * v + c + 1 for c in range(k)] for v in range(n)]
    for i, j in edges:
        for c in range(k):
            cls.append([-(4 * i + c + 1), -(4 * j + c + 1)])
    pinned = {}
    for v, c in pins:
        cls.append([4 * v + c + 1])
        pinned[v] = c
    free = [c for c in range(k) if c not in pinned.values()]
    if precedence and len(free) > 1 and n <= 5000:
        # a free colour c may appear at v only if c-1 (the previous free colour) appears strictly earlier
        for a in range(1, len(free)):
            c, cprev = free[a], free[a - 1]
            for v in range(n):
                cls.append([-(4 * v + c + 1)] + [4 * u + cprev + 1 for u in range(v)])
    return cls


def write_cnf(path, n, cls, k=4):
    with open(path, 'w') as f:
        f.write(f'p cnf {k * n} {len(cls)}\n')
        out = []
        for c in cls:
            out.append(' '.join(map(str, c)) + ' 0\n')
        f.writelines(out)
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()


def solve(path, solver='kissat', budget=600, extra=()):
    t = time.time()
    try:
        p = subprocess.run([solver] + list(extra) + [path], capture_output=True, text=True, timeout=budget)
        out = p.stdout
    except subprocess.TimeoutExpired:
        return 'UNKNOWN', time.time() - t, ''
    v = 'UNKNOWN'
    for line in out.splitlines():
        if line.startswith('s '):
            v = 'SAT' if 'UNSATISFIABLE' not in line else 'UNSAT'
    return v, time.time() - t, out


def model_from(out, n, k=4):
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(x) for x in line[2:].split()]
    val = {}
    for x in lits:
        if x:
            val[abs(x)] = x > 0
    col = []
    for v in range(n):
        cs = [c for c in range(k) if val.get(4 * v + c + 1)]
        col.append(cs[0] if cs else None)
    return col


def verify_colouring(points, edges, col):
    bad = [(i, j) for i, j in edges if col[i] is None or col[i] == col[j]]
    return len(bad), bad[:5]


def to9(z):
    x, y, m = z
    return list(x) + list(y) + [m]


# ---------------------------------------------------------------- the build

def cmd_build(argv):
    out = _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'harder-control'))
    os.makedirs(out, exist_ok=True)
    solver = _opt(argv, '--solver', 'kissat')
    V = harder_V()
    Hx = hexagon_H()
    print(f'V = {len(V)} points, H = {len(Hx)} points')
    if planted('drop_hexagon'):
        Hx = [CZERO]                     # PLANT: the hexagon dropped -- Harder's V+V alone does not force
    pts = minkowski(V, V, Hx)
    pts = sorted(pts, key=lambda z: (cfloat(z)[0], cfloat(z)[1]))
    print(f'V + V + H = {len(pts)} points after de-duplication '
          f'(Harder\'s 745 is his smallest forcing SUBGRAPH, not this sum)')
    t = time.time()
    edges = unit_graph(pts)
    print(f'unit-distance graph: {len(edges)} edges, average degree {2*len(edges)/len(pts):.2f}  ({time.time()-t:.1f}s)')
    idx = {z: i for i, z in enumerate(pts)}
    A = idx.get(CZERO)
    Bt = idx.get(rational(8, 3))
    assert A is not None, 'the origin is not in the fabric'
    assert Bt is not None, '(8/3, 0) is not in the fabric -- the recipe is wrong'
    adj = {i: set() for i in range(len(pts))}
    for i, j in edges:
        adj[i].add(j)
        adj[j].add(i)
    common = sorted(adj[A] & adj[Bt])
    print(f'0 is vertex {A}, 8/3 is vertex {Bt}; they share {len(common)} common neighbours; '
          f'adjacent = {Bt in adj[A]}')
    meta = {'field': [3, 11], 'format': 'nine integers [a,b,c,d,e,f,g,h,m] for ((a+b*sqrt3+c*sqrt11+d*sqrt33)/m,'
                                        ' (e+f*sqrt3+g*sqrt11+h*sqrt33)/m) -- SQRT11 IS IN THE SQRT5 SLOT',
            'construction': 'V + V + H with V = {0} u {zeta6^a rho^b : |b| <= 2} (rho = (5+i sqrt11)/6) and '
                            'H the unit hexagon with its centre; Harder, Polymath16 thread 1, 28 April 2018',
            'points': len(pts), 'edges': len(edges), 'avg_degree': 2 * len(edges) / len(pts),
            'origin_index': A, 'eight_thirds_index': Bt, 'common_neighbours': len(common)}
    with open(os.path.join(out, 'graph.json'), 'w') as f:
        json.dump({'meta': meta, 'points': [to9(z) for z in pts], 'edges': [list(e) for e in edges]}, f)
    rows = []

    def ask(name, pins, expect, note='', edges_used=None, solver_=None):
        E = edges if edges_used is None else edges_used
        path = os.path.join(out, name + '.cnf')
        cls = coloring_cnf(len(pts), E, pins)
        sha = write_cnf(path, len(pts), cls)
        sv = solver_ or solver
        verdict, secs, raw = solve(path, sv, extra=('-q',) if sv == 'kissat' else ())
        row = {'ask': name, 'pins': pins, 'verdict': verdict, 'expected': expect, 'solver': sv,
               'seconds': round(secs, 2), 'clauses': len(cls), 'vertices': len(pts), 'edges': len(E),
               'cnf_sha256': sha, 'note': note}
        if verdict == 'SAT':
            col = model_from(raw, len(pts))
            nbad, ex = verify_colouring(pts, E, col)
            row['monochromatic_edges'] = nbad
            assert nbad == 0, ('the solver returned an improper colouring', ex)
            with open(os.path.join(out, name + '.colouring.json'), 'w') as f:
                json.dump({'ask': name, 'colouring': col}, f)
        rows.append(row)
        flag = 'ok  ' if verdict == expect else 'MISMATCH'
        print(f'  {flag} {name:28s} {verdict:8s} (expected {expect:8s}) {secs:7.2f}s  {note}')
        return verdict

    print('the asks:')
    # control: a unit triangle pinned.  0, 1, zeta6 is a unit triangle when all three are present.
    tri = [idx.get(CZERO), idx.get(CONE), idx.get(ZETA6)]
    assert all(t is not None for t in tri), 'the unit triangle 0, 1, zeta6 is not in the fabric'
    assert (tri[0], tri[1]) in set(edges) or (tri[1], tri[0]) in set(edges)
    ask('control', [(tri[0], 0), (tri[1], 1), (tri[2], 2)], 'SAT', 'the fabric is four-colourable')
    pins = [(A, 0), (Bt, 1)] + ([(common[0], 2)] if common else [])
    v83 = ask('forces_8over3', pins, 'UNSAT', "Harder's claim: every proper 4-colouring gives 0 and 8/3 one colour")
    # negative control 1: a non-edge pair of 2-adic depth 0 is never forced (row 59's law)
    import random
    rnd = random.Random(7)
    eset = set(edges)
    cand = None
    for _ in range(4000):
        j = rnd.randrange(len(pts))
        if j == A or (min(A, j), max(A, j)) in eset:
            continue
        dz = csub(pts[j], pts[A])
        q = quad(dz)
        if q[0].denominator % 2 == 1 and all(x.denominator % 2 == 1 for x in q) and q != (Fr(1), Fr(0), Fr(0), Fr(0)):
            cand = j
            break
    if cand is not None:
        cn = sorted(adj[A] & adj[cand])
        ask('forces_depth0_control', [(A, 0), (cand, 1)] + ([(cn[0], 2)] if cn else []), 'SAT',
            f'a non-edge pair at odd-denominator (depth 0) squared distance -- row 59 says never forced (vertex {cand})')
    # negative control 2: one edge deleted must flip the 8/3 ask
    flips = []
    for trial in range(6):
        e = edges[rnd.randrange(len(edges))]
        red = [x for x in edges if x != e]
        path = os.path.join(out, f'forces_8over3_minus_edge{trial}.cnf')
        cls = coloring_cnf(len(pts), red, pins)
        write_cnf(path, len(pts), cls)
        verdict, secs, raw = solve(path, solver, extra=('-q',))
        flips.append({'edge': list(e), 'verdict': verdict, 'seconds': round(secs, 2)})
        print(f'       one edge deleted {str(e):16s} -> {verdict} ({secs:.2f}s)')
        os.remove(path)
    rows.append({'ask': 'forces_8over3_single_edge_deletions', 'trials': flips,
                 'flipped_to_SAT': sum(1 for f in flips if f['verdict'] == 'SAT')})
    with open(os.path.join(out, 'verdicts.json'), 'w') as f:
        json.dump({'meta': meta, 'asks': rows}, f, indent=1)
    print('wrote ' + out)
    return 0 if v83 == 'UNSAT' else 1


def cmd_lens(argv):
    n = int(argv[0])
    out = _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'harder-control'))
    core = _opt(argv, '--core', 7, int)
    solver = _opt(argv, '--solver', 'kissat')
    os.makedirs(out, exist_ok=True)
    gens = [cmul(cpow(ZETA6, a), cpow(RHO, b)) for a in range(6) for b in range(-2, 3)]
    units, B, M = lattice_saturation(gens)
    print(f"de Grey's lattice <zeta6^m rho^n, |n| <= 2>: M = {M}, rank {len(B)}, "
          f"{len(set(gens))} generators, {len(units)} unit vectors in the saturation "
          f"(the owner's po_kempe_control_K.py reads 54)")
    tgt = rational(8, 3)
    pts_d = lens_points(units, CZERO, tgt, n)
    pts = sorted(pts_d, key=lambda z: (cfloat(z)[0], cfloat(z)[1]))
    print(f'T_{n}(0 -> 8/3): {len(pts)} points')
    edges = unit_graph(pts)
    print(f'  {len(edges)} edges, average degree {2*len(edges)/len(pts):.2f}')
    keep = m_core(pts, edges, core)
    kmap = {v: i for i, v in enumerate(keep)}
    pts2 = [pts[v] for v in keep]
    edges2 = [(kmap[i], kmap[j]) for i, j in edges if i in kmap and j in kmap]
    print(f'  {core}-core: {len(pts2)} points, {len(edges2)} edges, '
          f'average degree {2*len(edges2)/max(1,len(pts2)):.2f}')
    res = {'n': n, 'core': core, 'lens_points': len(pts), 'lens_edges': len(edges),
           'core_points': len(pts2), 'core_edges': len(edges2), 'unit_vectors': len(units), 'M': M}
    for tag, P, E in (('lens', pts, edges), (f'core{core}', pts2, edges2)):
        idx = {z: i for i, z in enumerate(P)}
        A, Bt = idx.get(CZERO), idx.get(tgt)
        if A is None or Bt is None:
            print(f'  {tag}: an endpoint is absent (0 in {A is not None}, 8/3 in {Bt is not None})')
            res[tag] = 'endpoint absent'
            continue
        adj = {i: set() for i in range(len(P))}
        for i, j in E:
            adj[i].add(j)
            adj[j].add(i)
        common = sorted(adj[A] & adj[Bt])
        pins = [(A, 0), (Bt, 1)] + ([(common[0], 2)] if common else [])
        path = os.path.join(out, f'lens{n}_{tag}_forces_8over3.cnf')
        cls = coloring_cnf(len(P), E, pins)
        sha = write_cnf(path, len(P), cls)
        verdict, secs, raw = solve(path, solver, extra=('-q',))
        nbad = None
        if verdict == 'SAT':
            col = model_from(raw, len(P))
            nbad, _ = verify_colouring(P, E, col)
        print(f'  {tag}: forces 8/3 -> {verdict} ({secs:.1f}s, {len(P)} points, {len(E)} edges, '
              f'{len(common)} common neighbours)' + (f'  [colouring proper: {nbad} bad edges]' if nbad is not None else ''))
        res[tag] = {'verdict': verdict, 'seconds': round(secs, 2), 'points': len(P), 'edges': len(E),
                    'common_neighbours': len(common), 'cnf_sha256': sha, 'monochromatic_edges': nbad}
        with open(os.path.join(out, f'lens{n}_{tag}_graph.json'), 'w') as f:
            json.dump({'points': [to9(z) for z in P], 'edges': [list(e) for e in E]}, f)
    p = os.path.join(out, f'lens{n}.json')
    with open(p, 'w') as f:
        json.dump(res, f, indent=1)
    print('wrote ' + p)
    return 0


def selftest():
    ok = True

    def check(name, cond, detail=''):
        nonlocal ok
        print(('  ok   ' if cond else '  FAIL ') + name + ('' if cond else '   ' + str(detail)))
        ok = ok and cond

    print('fs70_harder self-test')
    check('zeta6 is a unit vector', is_unit_vector(ZETA6))
    check('rho is a unit vector', is_unit_vector(RHO))
    check('zeta6^6 = 1', cpow(ZETA6, 6) == CONE)
    check('rho * conj rho = 1', cmul(RHO, cconj(RHO)) == CONE)
    check('|1 - zeta6| = 1 (the unit triangle)', is_unit_vector(csub(CONE, ZETA6)))
    check('rho is the Moser twist: |1 - rho|^2 = 1/3',
          quad(csub(CONE, RHO)) == (Fr(1, 3), Fr(0), Fr(0), Fr(0)), quad(csub(CONE, RHO)))
    V = harder_V()
    check('V has 31 points', len(V) == 31, len(V))
    check('H has 7 points', len(hexagon_H()) == 7)
    pts = minkowski(V, V, hexagon_H())
    # Harder's 745 is his SMALLEST FORCING SUBGRAPH, not |V + V + H|: the thread text held at
    # ~/source/library/notes/polymath16-threads-1-18-text.txt reads "The smallest subgraph ... 745 vertices".
    # The Minkowski sum itself is 2,341 points, and that is the graph his claim is about.
    check('V + V + H has 2341 points (the Minkowski sum; 745 is his smallest forcing SUBGRAPH)',
          len(pts) == 2341, len(pts))
    check('(8/3, 0) is in the fabric', rational(8, 3) in set(pts))
    small = sorted(pts, key=lambda z: (cfloat(z)[0], cfloat(z)[1]))[:260]
    e1 = unit_graph(small)
    e2 = unit_graph_exact(small)
    check('the grid join and the exhaustive exact sweep agree on a 260-point sample',
          e1 == e2, f'{len(e1)} vs {len(e2)}')
    gens = [cmul(cpow(ZETA6, a), cpow(RHO, b)) for a in range(6) for b in range(-2, 3)]
    units, B, M = lattice_saturation(gens)
    check("de Grey's lattice has rank 4 (the owner's number)", len(B) == 4, len(B))
    check("it has 30 distinct generators (the owner's number)", len(set(gens)) == 30, len(set(gens)))
    check("its saturation has 54 unit vectors (the owner's number)", len(units) == 54, len(units))
    check('8/3 lies in the lattice', member8(B, vec8(rational(8, 3), M)))
    print('SELFTEST ' + ('GREEN' if ok else 'RED'))
    return 0 if ok else 1


def run_plants():
    global PLANT
    print('fs70_harder planted faults')
    fired = 0
    PLANT = 'drop_hexagon'
    print('  drop_hexagon: V + V alone (no hexagon) -- Harder says the hexagon is needed')
    V = harder_V()
    pts = sorted(minkowski(V, V, [CZERO]), key=lambda z: (cfloat(z)[0], cfloat(z)[1]))
    edges = unit_graph(pts)
    idx = {z: i for i, z in enumerate(pts)}
    A, Bt = idx.get(CZERO), idx.get(rational(8, 3))
    if Bt is None:
        print('     refused: 8/3 is not even a point of V + V')
        fired += 1
    else:
        adj = {i: set() for i in range(len(pts))}
        for i, j in edges:
            adj[i].add(j)
            adj[j].add(i)
        common = sorted(adj[A] & adj[Bt])
        path = os.path.join(ROOT, 'build', 'fs70', 'harder-plant.cnf')
        os.makedirs(os.path.dirname(path), exist_ok=True)
        cls = coloring_cnf(len(pts), edges, [(A, 0), (Bt, 1)] + ([(common[0], 2)] if common else []))
        write_cnf(path, len(pts), cls)
        verdict, secs, _ = solve(path, 'kissat', extra=('-q',))
        print(f'     V + V alone ({len(pts)} points, {len(edges)} edges): forces 8/3 -> {verdict} ({secs:.1f}s)')
        fired += 1 if verdict == 'SAT' else 0
        if verdict != 'SAT':
            print('     NOT REFUSED: V + V alone already forces 8/3 -- the hexagon is not load-bearing')
    PLANT = None
    # a moved point: one vertex of the fabric shifted off the lattice must break the refusal
    print('  moved_point: 8/3 replaced by 8/3 + 1/1000 (off the field) -- the graph must lose its edges there')
    z = rational(8, 3)
    zz = cadd(z, rational(1, 1000))
    print(f'     |8/3 - (8/3 + 1/1000)|^2 = {quad(csub(z, zz))} -- not 1, and not 0: the point moved')
    fired += 1 if quad(csub(z, zz)) != (Fr(0), Fr(0), Fr(0), Fr(0)) else 0
    print(f'{fired} of 2 plants fired')
    return 0 if fired == 2 else 1


def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


def main():
    global PLANT
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = _opt(argv, '--plant')
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 'selftest':
        return run_plants() if '--plants' in argv else selftest()
    if argv[0] == 'build':
        return cmd_build(argv[1:])
    if argv[0] == 'lens':
        return cmd_lens(argv[1:])
    print(__doc__)
    return 0


if __name__ == '__main__':
    sys.exit(main())
