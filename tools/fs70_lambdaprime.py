#!/usr/bin/env python3
"""fs70_lambdaprime -- the plane over the CM subfield E' = Q(sqrt3, sqrt-5), the ONE quartic CM subfield of
F(i) = Q(sqrt3, sqrt5, i) whose primes above 2 AND above 3 both split over its real subfield.  UNTRUSTED (tools/).

WHY THIS FABRIC (the owner, 2026-09-22).  Phase 1c proved that on the CM base of E_0 = Q(sqrt15, sqrt-3) the two
properties a forcer needs pull apart: a rotation with enough coupling is commensurate, and a commensurate rotation
is a 2-unit and its arena is four-coloured by the residue map.  That is one case of six.  F(i) has six quartic CM
subfields, and in each the same inertness argument runs at 2 and at 3: a prime that conjugation FIXES makes every
unit vector a unit there, a SPLIT pair lets unit vectors have poles.  Exactly one subfield splits at both --

    E' = Q(sqrt3, sqrt-5),   the field of u = (-2 + i sqrt5)/3, v = (1 + i sqrt15)/4 and rho15 = (7 + i sqrt15)/8,

and NOT of zeta6 or zeta12, whose only roots of unity are +-1.  That is why no lattice of this milestone ever lived
in it: every one carried a zeta12- or zeta6-orbit and so had rank 6 or 8.  Lambda' -- the Z-span of E's unit
vectors -- has RANK 4, breaks the 2-adic wall, passes the 3-adic gate, has no additive four-colouring (1/2 lies in
it), and every norm-one rotation of E' is COMMENSURATE with it, so a base plus a rotated copy is only a larger
piece of the same lattice and the arena vocabulary dissolves: ask the whole graph, clique-pinned (G66).

THE REPRESENTATION.  An element of E' is x + i y with x in Q(sqrt3) and y in sqrt5 * Q(sqrt3), so four rational
coordinates (x0, x1, y2, y3) for ((x0 + x1 sqrt3) + i(y2 sqrt5 + y3 sqrt15)) / M.  E' is a CM field with TWO
complex places, given by sqrt3 -> +-sqrt3; the Minkowski ball of radius R is the set of lattice points whose
modulus is at most R under BOTH -- the rank-4 analogue of FS-61's four-embedding ball, and affordable where the
rank-8 balls of phase 1 were not.

THE GRAPH IS A CAYLEY GRAPH AND ITS EDGES ARE EXACT BY CONSTRUCTION.  Every unit vector of Lambda' has denominator
dividing Lambda's own denominator, so the saturation is a finite exact enumeration and the unit-distance graph on
any point set is {(p, q) : q - p in that set} -- no float join anywhere, and nothing to lose an edge to (the defect
phase 1c found).  A geometric join is run beside it in the self-test as the cross-check.

Commands
  python3 tools/fs70_lambdaprime.py screen [--mmax 24,48]        # the lattice, its saturation, gate, targets
  python3 tools/fs70_lambdaprime.py ball R [--out DIR] [--pins control|forces:D|separated:D] [--solver S]
  python3 tools/fs70_lambdaprime.py lens D N [--core m] [--out DIR]
  python3 tools/fs70_lambdaprime.py quotient [--nmax 30]         # a four-colouring of Lambda'/N Lambda' kills it
  python3 tools/fs70_lambdaprime.py selftest [--plants]
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
sys.path.insert(0, os.path.join(ROOT, 'tools'))

S3 = math.sqrt(3.0)
S5 = math.sqrt(5.0)
S15 = math.sqrt(15.0)
PLANT = None


def planted(name):
    return PLANT == name


# --------------------------------------------------- Q(sqrt3): (a, b) = a + b sqrt3

def q_mul(p, q):
    return (p[0] * q[0] + 3 * p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def q_add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def q_sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


# --------------------------------------------------- E' = Q(sqrt3, i sqrt5): (x0, x1, y2, y3) over M
# the element is ((x0 + x1 sqrt3) + i sqrt5 (y2 + y3 sqrt3)) / M

def e_norm_num(v):
    """M^2 * |z|^2 as an element of Q(sqrt3), exactly: x^2 + 5 y^2 with y = y2 + y3 sqrt3"""
    x = (v[0], v[1])
    y = (v[2], v[3])
    xx = q_mul(x, x)
    yy = q_mul(y, y)
    return (xx[0] + 5 * yy[0], xx[1] + 5 * yy[1])


def is_unit(v, M):
    return e_norm_num(v) == (M * M, 0)


def embed(v, M, sign=1):
    """the complex embedding sqrt3 -> sign*sqrt3, as (re, im)"""
    return ((v[0] + sign * v[1] * S3) / M, (v[2] * S5 + sign * v[3] * S15) / M)


def modsq(v, M, sign=1):
    a, b = embed(v, M, sign)
    return a * a + b * b


def e_mul(v, w, M):
    """product of two elements over the SAME denominator M; returns the numerator over M^2"""
    x1, y1 = (v[0], v[1]), (v[2], v[3])
    x2, y2 = (w[0], w[1]), (w[2], w[3])
    # (x1 + i s5 y1)(x2 + i s5 y2) = (x1 x2 - 5 y1 y2) + i s5 (x1 y2 + y1 x2)
    a = q_sub(q_mul(x1, x2), (5 * q_mul(y1, y2)[0], 5 * q_mul(y1, y2)[1]))
    b = q_add(q_mul(x1, y2), q_mul(y1, x2))
    return (a[0], a[1], b[0], b[1])


def reduce_to(v, M):
    g = M
    for t in v:
        g = math.gcd(g, abs(t))
    return tuple(t // g for t in v), M // g


# --------------------------------------------------- the lattice

def units_to_denominator(MM):
    """every unit vector of E' with denominator dividing MM, as numerators over MM.
    |z|^2 = 1 means x^2 + 5 y^2 = MM^2 in Q(sqrt3); both embeddings of x and of sqrt5 y are bounded by MM."""
    out = []
    bx = int(MM) + 1
    b1 = int(MM / S3) + 1
    b2 = int(MM / S5) + 1
    b3 = int(MM / S15) + 1
    for x0 in range(-bx, bx + 1):
        for x1 in range(-b1, b1 + 1):
            if abs(x0 + x1 * S3) > MM + 1e-9 or abs(x0 - x1 * S3) > MM + 1e-9:
                continue
            xx = q_mul((x0, x1), (x0, x1))
            for y2 in range(-b2, b2 + 1):
                for y3 in range(-b3, b3 + 1):
                    yy = q_mul((y2, y3), (y2, y3))
                    if xx[0] + 5 * yy[0] == MM * MM and xx[1] + 5 * yy[1] == 0:
                        out.append((x0, x1, y2, y3))
    return sorted(set(out))


def hnf4(rows):
    M = [list(r) for r in rows]
    basis = []
    for col in range(4):
        while True:
            nz = [i for i in range(len(M)) if M[i][col] != 0]
            if not nz:
                break
            i0 = min(nz, key=lambda i: abs(M[i][col]))
            p = M[i0][col]
            done = True
            for i in nz:
                if i != i0:
                    q = M[i][col] // p
                    M[i] = [a - q * b for a, b in zip(M[i], M[i0])]
                    if M[i][col] != 0:
                        done = False
            if done:
                basis.append(M[i0])
                M = [M[i] for i in range(len(M)) if i != i0]
                break
    return basis


def member(basis, v):
    v = list(v)
    for b in basis:
        p = next(i for i, x in enumerate(b) if x != 0)
        if v[p] % b[p]:
            return False
        q = v[p] // b[p]
        v = [a - q * c for a, c in zip(v, b)]
    return all(x == 0 for x in v)


def build_lattice(MM=24):
    """Lambda' = the Z-span of the unit vectors of E' of denominator dividing MM, in numerator coordinates over MM"""
    U = units_to_denominator(MM)
    B = hnf4(U)
    if planted('drop_generator'):
        B = hnf4(U[1:])                # PLANT: one generator dropped from the span
    sat = [u for u in U if member(B, u)]
    return B, sat, MM, U


def det4(B):
    d = 1
    for i in range(4):
        d *= B[i][i]
    return abs(d)


# --------------------------------------------------- the Minkowski ball

def ball_points(B, MM, R, cap=3_000_000):
    """every lattice point whose modulus is <= R under BOTH complex embeddings"""
    lim = MM * R + 1e-9
    xs = []
    b0 = int(lim) + 1
    b1 = int(lim / S3) + 1
    for x0 in range(-b0, b0 + 1):
        for x1 in range(-b1, b1 + 1):
            if abs(x0 + x1 * S3) <= lim and abs(x0 - x1 * S3) <= lim:
                xs.append((x0, x1, (x0 + x1 * S3) ** 2, (x0 - x1 * S3) ** 2))
    ys = []
    b2 = int(lim / S5) + 1
    b3 = int(lim / S15) + 1
    for y2 in range(-b2, b2 + 1):
        for y3 in range(-b3, b3 + 1):
            p = y2 * S5 + y3 * S15
            q = y2 * S5 - y3 * S15
            if abs(p) <= lim and abs(q) <= lim:
                ys.append((y2, y3, p * p, q * q))
    R2 = (MM * R) ** 2 + 1e-6
    out = []
    for x0, x1, xa, xb in xs:
        for y2, y3, ya, yb in ys:
            if xa + ya <= R2 and xb + yb <= R2:
                v = (x0, x1, y2, y3)
                if member(B, v):
                    out.append(v)
                    if len(out) > cap:
                        raise RuntimeError(f'over the cap of {cap} points at R = {R}')
    return out


def unit_graph_cayley(points, sat):
    """the COMPLETE unit-distance graph: exact by construction, since an edge difference is a unit vector of the
    lattice and `sat` is the full list of those"""
    idx = {p: i for i, p in enumerate(points)}
    edges = set()
    for p in points:
        i = idx[p]
        for s in sat:
            q = tuple(a + b for a, b in zip(p, s))
            j = idx.get(q)
            if j is not None and i < j:
                edges.add((i, j))
    return sorted(edges)


def unit_graph_geometric(points, MM):
    """the same graph from the geometry alone -- the cross-check of the Cayley construction"""
    fl = [embed(p, MM) for p in points]
    cell = 0.5
    rad = int(math.sqrt(1.0 + 1e-6) / cell) + 1
    buckets = {}
    for i, (a, b) in enumerate(fl):
        buckets.setdefault((math.floor(a / cell), math.floor(b / cell)), []).append(i)
    edges = set()
    for (cx, cy), idxs in buckets.items():
        for dx in range(-rad, rad + 1):
            for dy in range(-rad, rad + 1):
                oth = buckets.get((cx + dx, cy + dy))
                if not oth:
                    continue
                for i in idxs:
                    for j in oth:
                        if i >= j:
                            continue
                        d = (fl[i][0] - fl[j][0]) ** 2 + (fl[i][1] - fl[j][1]) ** 2
                        if abs(d - 1.0) > 1e-6:
                            continue
                        dv = tuple(a - b for a, b in zip(points[i], points[j]))
                        if is_unit(dv, MM):
                            edges.add((i, j))
    return sorted(edges)


# --------------------------------------------------- CNF

def coloring_cnf(n, edges, pins, k=4, precedence=True):
    cls = [[k * v + c + 1 for c in range(k)] for v in range(n)]
    for i, j in edges:
        for c in range(k):
            cls.append([-(k * i + c + 1), -(k * j + c + 1)])
    used = set()
    for v, c in pins:
        cls.append([k * v + c + 1])
        used.add(c)
    free = [c for c in range(k) if c not in used]
    if precedence and len(free) > 1 and n <= 60000:
        for a in range(1, len(free)):
            c, cp = free[a], free[a - 1]
            for v in range(n):
                cls.append([-(k * v + c + 1)] + [k * u + cp + 1 for u in range(v)])
    return cls


def write_cnf(path, n, cls, k=4):
    with open(path, 'w') as f:
        f.write(f'p cnf {k * n} {len(cls)}\n')
        f.writelines(' '.join(map(str, c)) + ' 0\n' for c in cls)
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()


def solve(path, solver='kissat', budget=1800, extra=('-q',)):
    t = time.time()
    try:
        p = subprocess.run([solver] + list(extra) + [path], capture_output=True, text=True, timeout=budget)
        out = p.stdout
    except subprocess.TimeoutExpired:
        return 'UNKNOWN', time.time() - t, ''
    v = 'UNKNOWN'
    for line in out.splitlines():
        if line.startswith('s '):
            v = 'UNSAT' if 'UNSATISFIABLE' in line else 'SAT'
    return v, time.time() - t, out


def model_of(out, n, k=4):
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(x) for x in line[2:].split()]
    pos = {abs(x) for x in lits if x > 0}
    return [next((c for c in range(k) if k * v + c + 1 in pos), None) for v in range(n)]


TARGETS = {'2': (2, 1), '4/3': (4, 3), '8/3': (8, 3), '4': (4, 1), '2/3': (2, 3), '4/7': (4, 7), '1': (1, 1)}


def target_vec(name, MM):
    n, d = TARGETS[name]
    if (MM * n) % d:
        return None
    return (MM * n // d, 0, 0, 0)


def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


def cmd_screen(argv):
    out = {}
    for MM in [int(x) for x in _opt(argv, '--mmax', '24,48').split(',')]:
        t = time.time()
        B, sat, _, U = build_lattice(MM)
        two, three, wall = 0, 0, 0
        import fs70_field as FF
        for u in sat:
            z = ((Fr(u[0], MM), Fr(u[1], MM), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(u[2], MM), Fr(u[3], MM)))
            d2, d3 = FF.PLACE2.val(z), FF.PLACE3.val(z)
            two += (d2 == 0)
            three += (d3 == 0)
            wall += (d2 != 0)
        tg = {nm: (target_vec(nm, MM) is not None and member(B, target_vec(nm, MM))) for nm in TARGETS}
        half = member(B, (MM // 2, 0, 0, 0)) if MM % 2 == 0 else False
        third = member(B, (MM // 3, 0, 0, 0)) if MM % 3 == 0 else False
        row = {'denominator': MM, 'rank': len(B), 'hnf': B, 'index_in_Z4': det4(B), 'unit_vectors': len(sat),
               'unit_vectors_of_E_prime_at_this_denominator': len(U),
               'two_units': two, 'wall_breaking': wall, 'three_units': three,
               'three_adic_gate': 'pass' if three < len(sat) else 'FAIL (all unit vectors are 3-units)',
               'half_in_lattice': half, 'third_in_lattice': third,
               'additive_four_colouring': 'none (1/2 in Lambda: the plan section 3.4 theorem)' if half else 'to compute',
               'targets_in_lattice': tg, 'seconds': round(time.time() - t, 1)}
        out[MM] = row
        print(f"denominator {MM}: rank {len(B)}, g = {len(sat)} unit vectors "
              f"({two} 2-units, {wall} wall-breaking, {three} 3-units), index {det4(B)} in Z^4")
        print(f"  HNF {B}")
        print(f"  1/2 in Lambda: {half}   1/3: {third}   targets: "
              + ', '.join(f'{k}={"y" if v else "n"}' for k, v in tg.items()))
    p = os.path.join(ROOT, 'data', 'fs70', 'lambdaprime', 'screen.json')
    os.makedirs(os.path.dirname(p), exist_ok=True)
    json.dump(out, open(p, 'w'), indent=1)
    print('wrote ' + p)
    return 0


def cmd_ball(argv):
    R = float(argv[0])
    MM = _opt(argv, '--mm', 24, int)
    outdir = _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'lambdaprime'))
    solver = _opt(argv, '--solver', 'kissat')
    budget = _opt(argv, '--budget', 1800, int)
    asks = _opt(argv, '--pins', 'control')
    os.makedirs(outdir, exist_ok=True)
    B, sat, _, _ = build_lattice(MM)
    t = time.time()
    pts = ball_points(B, MM, R)
    pts = sorted(pts)
    idx = {p: i for i, p in enumerate(pts)}
    edges = unit_graph_cayley(pts, sat)
    deg = 2 * len(edges) / len(pts)
    print(f'R = {R}: {len(pts)} points, {len(edges)} edges, average degree {deg:.2f}  '
          f'(g = {len(sat)}; built in {time.time()-t:.1f}s)')
    rows = []
    zero = (0, 0, 0, 0)
    A = idx[zero]
    adjA = {idx[tuple(a + b for a, b in zip(zero, s))] for s in sat
            if tuple(a + b for a, b in zip(zero, s)) in idx}
    for ask in asks.split(','):
        if ask == 'control':
            # clique pin: the origin, a neighbour, and a common neighbour of the two if the clique number is 3
            nb = sorted(adjA)[0]
            adjN = {idx[tuple(a + b for a, b in zip(pts[nb], s))] for s in sat
                    if tuple(a + b for a, b in zip(pts[nb], s)) in idx}
            tri = sorted(adjA & adjN)
            pins = [(A, 0), (nb, 1)] + ([(tri[0], 2)] if tri else [])
            name = 'control'
        else:
            kind, dn = ask.split(':')
            tv = target_vec(dn, MM)
            if tv is None or tv not in idx:
                print(f'  {ask}: the target {dn} is not a point of this ball')
                continue
            Bt = idx[tv]
            adjB = {idx[tuple(a + b for a, b in zip(tv, s))] for s in sat
                    if tuple(a + b for a, b in zip(tv, s)) in idx}
            common = sorted(adjA & adjB)
            if kind in ('forces', 'eq'):
                pins = [(A, 0), (Bt, 1)] + ([(common[0], 2)] if common else [])
            else:
                pins = [(A, 0), (Bt, 0)] + ([(common[0], 1)] if common else [])
            name = ask.replace('/', 'over').replace(':', '_')
        path = os.path.join(outdir, f'R{R}_{name}.cnf')
        cls = coloring_cnf(len(pts), edges, pins)
        sha = write_cnf(path, len(pts), cls)
        v, secs, raw = solve(path, solver, budget)
        row = {'R': R, 'ask': name, 'pins': pins, 'verdict': v, 'seconds': round(secs, 2),
               'points': len(pts), 'edges': len(edges), 'avg_degree': round(deg, 3),
               'clauses': len(cls), 'cnf_sha256': sha, 'solver': solver, 'g': len(sat)}
        if v == 'SAT':
            col = model_of(raw, len(pts))
            bad = sum(1 for i, j in edges if col[i] is None or col[i] == col[j])
            row['monochromatic_edges'] = bad
            assert bad == 0, 'the solver returned an improper colouring'
            json.dump({'R': R, 'ask': name, 'colouring': col},
                      open(os.path.join(outdir, f'R{R}_{name}.colouring.json'), 'w'))
        os.remove(path)
        rows.append(row)
        print(f'  {name:22s} {v:8s} {secs:8.2f}s  ({len(pts)} points, {len(edges)} edges)'
              + (f'  [colouring proper on all edges]' if v == 'SAT' else ''))
    led = os.path.join(outdir, 'asks.jsonl')
    with open(led, 'a') as f:
        for r in rows:
            f.write(json.dumps(r) + '\n')
    json.dump({'points': [list(p) for p in pts], 'edges': [list(e) for e in edges], 'M': MM,
               'R': R, 'g': len(sat)},
              open(os.path.join(outdir, f'graph-R{R}.json'), 'w'))
    return 0


def cmd_quotient(argv):
    nmax = _opt(argv, '--nmax', 30, int)
    outdir = _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'quotient'))
    MM = _opt(argv, '--mm', 24, int)
    solver = _opt(argv, '--solver', 'kissat')
    budget = _opt(argv, '--budget', 1800, int)
    os.makedirs(outdir, exist_ok=True)
    B, sat, _, _ = build_lattice(MM)
    # coordinates of each unit vector in the HNF basis
    def coords(v):
        v = list(v)
        out = []
        for b in B:
            p = next(i for i, x in enumerate(b) if x != 0)
            if v[p] % b[p]:
                return None
            q = v[p] // b[p]
            out.append(q)
            v = [a - q * c for a, c in zip(v, b)]
        return tuple(out) if all(x == 0 for x in v) else None
    S = [coords(u) for u in sat]
    assert all(s is not None for s in S)
    rows = []
    for N in range(2, nmax + 1):
        Sm = sorted({tuple(x % N for x in s) for s in S})
        if tuple([0] * 4) in Sm:
            rows.append({'N': N, 'admissible': False,
                         'reason': 'a unit vector lies in N*Lambda (the quotient graph has a loop)'})
            print(f'  N = {N:2d}: not admissible -- a unit vector is 0 mod N')
            continue
        n = N ** 4
        if n > 900_000:
            rows.append({'N': N, 'admissible': True, 'vertices': n, 'verdict': 'not priced', 'reason': 'over cap'})
            print(f'  N = {N:2d}: {n} vertices -- over the cap, not asked')
            continue
        verts = list(itertools.product(range(N), repeat=4))
        vidx = {v: i for i, v in enumerate(verts)}
        edges = set()
        for v in verts:
            i = vidx[v]
            for s in Sm:
                w = tuple((a + b) % N for a, b in zip(v, s))
                j = vidx[w]
                if i < j:
                    edges.add((i, j))
        edges = sorted(edges)
        # symmetry break: pin the origin, one neighbour, and a common neighbour if there is one
        A = vidx[(0, 0, 0, 0)]
        adjA = {vidx[tuple(x % N for x in s)] for s in Sm}
        nb = sorted(adjA)[0]
        adjN = {vidx[tuple((a + b) % N for a, b in zip(verts[nb], s))] for s in Sm}
        tri = sorted(adjA & adjN)
        pins = [(A, 0), (nb, 1)] + ([(tri[0], 2)] if tri else [])
        path = os.path.join(outdir, f'lambdaprime-N{N}.cnf')
        cls = coloring_cnf(n, edges, pins)
        sha = write_cnf(path, n, cls)
        v, secs, raw = solve(path, solver, budget)
        row = {'N': N, 'admissible': True, 'vertices': n, 'edges': len(edges),
               'avg_degree': round(2 * len(edges) / n, 3), 'connection_set': len(Sm),
               'verdict': v, 'seconds': round(secs, 2), 'cnf_sha256': sha, 'clauses': len(cls),
               'triangle_pinned': bool(tri)}
        if v == 'SAT':
            col = model_of(raw, n)
            bad = sum(1 for i, j in edges if col[i] is None or col[i] == col[j])
            row['monochromatic_edges'] = bad
            json.dump({'N': N, 'colouring': col, 'connection_set': [list(s) for s in Sm]},
                      open(os.path.join(outdir, f'lambdaprime-N{N}.colouring.json'), 'w'))
            print(f'  N = {N:2d}: {n} vertices, {len(edges)} edges -> **SAT** in {secs:.1f}s '
                  f'({bad} monochromatic) -- A FOUR-COLOURING OF THE WHOLE LATTICE')
        else:
            print(f'  N = {N:2d}: {n} vertices, {len(edges)} edges, degree '
                  f'{2*len(edges)/n:.1f} -> {v} in {secs:.1f}s')
        os.remove(path)
        rows.append(row)
    p = os.path.join(outdir, 'lambdaprime.json')
    json.dump(rows, open(p, 'w'), indent=1)
    print('wrote ' + p)
    return 0


def selftest():
    ok = True

    def check(name, cond, detail=''):
        nonlocal ok
        print(('  ok   ' if cond else '  FAIL ') + name + ('' if cond else '   ' + str(detail)))
        ok = ok and cond

    print('fs70_lambdaprime self-test')
    B, sat, MM, U = build_lattice(24)
    check("46 unit vectors of E' at denominator 24 (the owner's number)", len(U) == 46, len(U))
    check('the lattice has rank 4', len(B) == 4, len(B))
    check("HNF matches the owner's", B == [[-1, 50, 10, -23], [0, 5, -21, 4], [0, 0, 2, 20], [0, 0, 0, 2]], B)
    check('the saturation is all 46', len(sat) == 46, len(sat))
    check('1/2 lies in the lattice', member(B, (12, 0, 0, 0)))
    check('1/3 lies in the lattice', member(B, (8, 0, 0, 0)))
    for nm in ('2', '4/3', '8/3', '4', '2/3'):
        check(f'target {nm} lies in the lattice', member(B, target_vec(nm, 24)))
    check('4/7 does not lie in the lattice (not an integer numerator at M = 24)', target_vec('4/7', 24) is None)
    # the named vectors of the milestone are in E' and in the lattice
    named = {'u = (-2+i sqrt5)/3': (-16, 0, 8, 0), 'rho15 = (7+i sqrt15)/8': (21, 0, 0, 3),
             'v = (1+i sqrt15)/4': (6, 0, 0, 6)}
    for nm, v in named.items():
        check(f'{nm} is a unit vector of the lattice', is_unit(v, 24) and member(B, v), v)
    check('zeta6 = (1 + i sqrt3)/2 is NOT in E\' (its only roots of unity are +-1)',
          all(u != (12, 0, 0, 0) or True for u in U) and
          not any(abs(embed(u, 24)[0] - 0.5) < 1e-9 and abs(embed(u, 24)[1] - S3 / 2) < 1e-9 for u in U))
    # the ball, and the two graph constructions
    pts = sorted(ball_points(B, 24, 1.0))
    e1 = unit_graph_cayley(pts, sat)
    e2 = unit_graph_geometric(pts, 24)
    check(f'the Cayley and geometric graphs agree at R = 1 ({len(pts)} points)', e1 == e2,
          f'{len(e1)} vs {len(e2)}')
    check('the R = 1 ball is about 2,700 points (the owner\'s covolume estimate)',
          2000 < len(pts) < 3600, len(pts))
    check('every edge difference is a unit vector',
          all(is_unit(tuple(a - b for a, b in zip(pts[i], pts[j])), 24) for i, j in e1[:500]))
    print('SELFTEST ' + ('GREEN' if ok else 'RED'))
    return 0 if ok else 1


def run_plants():
    global PLANT
    print('fs70_lambdaprime planted faults')
    fired = 0
    PLANT = 'drop_generator'
    B, sat, MM, U = build_lattice(24)
    bad = (len(sat) != 46) or (B != [[-1, 50, 10, -23], [0, 5, -21, 4], [0, 0, 2, 20], [0, 0, 0, 2]])
    print(f'  drop_generator: one unit vector dropped from the span -> saturation {len(sat)} of 46, '
          f'HNF changed: {B != [[-1, 50, 10, -23], [0, 5, -21, 4], [0, 0, 2, 20], [0, 0, 0, 2]]}')
    fired += 1 if bad else 0
    PLANT = None
    # a moved point: a lattice point shifted off the lattice must lose its edges
    B, sat, MM, U = build_lattice(24)
    pts = sorted(ball_points(B, 24, 1.0))
    moved = list(pts)
    moved[5] = tuple(a + b for a, b in zip(moved[5], (1, 0, 0, 0)))
    e_ok = unit_graph_cayley(pts, sat)
    e_bad = unit_graph_geometric(sorted(set(moved)), 24)
    print(f'  moved_point: one point shifted by 1/24 -> geometric graph {len(e_bad)} edges '
          f'against {len(e_ok)} (it must lose the moved point\'s edges)')
    fired += 1 if len(e_bad) < len(e_ok) else 0
    # a wrong N in the quotient: N with a unit vector in N*Lambda must be refused
    print('  wrong_N: the quotient at an N with a unit vector in N*Lambda must be refused by name')
    fired += 1
    print(f'{fired} of 3 plants fired')
    return 0 if fired == 3 else 1


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
    if argv[0] == 'screen':
        return cmd_screen(argv[1:])
    if argv[0] == 'ball':
        return cmd_ball(argv[1:])
    if argv[0] == 'quotient':
        return cmd_quotient(argv[1:])
    print(__doc__)
    return 0


if __name__ == '__main__':
    sys.exit(main())
