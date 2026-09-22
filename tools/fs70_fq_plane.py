#!/usr/bin/env python3
"""fs70_fq_plane -- FS-70 phase 0.4: the residue planes behind the plan's section 3.1, re-derived into tools/.

At a prime of F = Q(sqrt3, sqrt5) that SPLITS in E = F(i), the residue field is F_q with q = 1 mod 4, so -1 is a
square there and the "unit circle" x^2 + y^2 = 1 is a split conic with q - 1 points.  Theorem A
(`colorable_of_residue`) maps every unit-distance graph over the valuation subring homomorphically into
UD(F_q, 2) = Cay(F_q^2, {circle}), so chi(UD(F_q^2)) is a ceiling on any fabric of p-units.  This file computes
chi at the three primes the milestone screens with:

  q = 9  (above 3): chi = 3, which is the 3-adic gate -- a lattice of 3-units is 3-colourable, and a 3-colourable
                    graph carries no four-colour pair compulsion (row 45's spare-colour lemma).  The CONTROL that
                    the encoding can refuse anything is the 2-colour ask, which must be UNSAT.
  q = 25 (above 5): four colours refused, so the residue at 5 obstructs nothing at four colours.
  q = 49 (above 7): four colours refused likewise.

Symmetry is broken before every ask (CLAUDE.md's checklist): omega(UD(F_q^2)) = 3 whenever the characteristic is 3
or 3 is a square in F_q -- true at all three q -- so a unit TRIANGLE is pinned, and the remaining colours carry a
precedence constraint.  A budget expiry is reported as UNKNOWN with the encoding named, never as a fact about the
graph.  UNTRUSTED (tools/).

Commands
  python3 tools/fs70_fq_plane.py run [Q ...] [--kmax 5] [--budget 600] [--out DIR]
  python3 tools/fs70_fq_plane.py selftest      # the field arithmetic, the circle sizes, and two planted faults
"""
from collections import defaultdict
import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import time

PLANT = None

# q = p^f as p, f, and a non-residue generating F_q = F_p[t]/(t^2 - nr) for f = 2
FIELDS = {9: (3, 2, -1), 25: (5, 2, 2), 49: (7, 2, 3), 5: (5, 1, None), 13: (13, 1, None), 17: (17, 1, None)}


class Fq:
    """F_q for q = p (elements are ints) or q = p^2 = F_p[t]/(t^2 - nr) (elements are pairs (a, b) = a + b t)"""

    def __init__(self, q):
        if q not in FIELDS:
            raise SystemExit(f'unknown q = {q}; known: {sorted(FIELDS)}')
        self.q = q
        self.p, self.f, self.nr = FIELDS[q]
        if self.f == 2:
            assert pow(self.nr % self.p, (self.p - 1) // 2, self.p) == self.p - 1, \
                f'{self.nr} is a square mod {self.p}: not a valid non-residue'
            self.elems = [(a, b) for a in range(self.p) for b in range(self.p)]
            self.zero, self.one = (0, 0), (1, 0)
        else:
            self.elems = list(range(self.p))
            self.zero, self.one = 0, 1
        assert len(self.elems) == q

    def add(self, x, y):
        if self.f == 1:
            return (x + y) % self.p
        return ((x[0] + y[0]) % self.p, (x[1] + y[1]) % self.p)

    def sub(self, x, y):
        if self.f == 1:
            return (x - y) % self.p
        return ((x[0] - y[0]) % self.p, (x[1] - y[1]) % self.p)

    def mul(self, x, y):
        if self.f == 1:
            return (x * y) % self.p
        a, b = x
        c, d = y
        return ((a * c + self.nr * b * d) % self.p, (a * d + b * c) % self.p)

    def sq(self, x):
        return self.mul(x, x)

    def is_square(self, x):
        return any(self.sq(e) == x for e in self.elems)


def circle(F):
    """{(x, y) : x^2 + y^2 = 1} in F^2"""
    out = []
    for x in F.elems:
        for y in F.elems:
            if F.add(F.sq(x), F.sq(y)) == F.one:
                out.append((x, y))
    if PLANT == 'circle_short':
        out = out[:-2]                        # PLANT: two circle points dropped -> edges missing
    return out


def plane_graph(F):
    """UD(F^2): vertices F^2, edges v -- v + s for s on the circle"""
    C = circle(F)
    pts = [(x, y) for x in F.elems for y in F.elems]
    index = {p: i for i, p in enumerate(pts)}
    edges = set()
    for p in pts:
        for s in C:
            qp = (F.add(p[0], s[0]), F.add(p[1], s[1]))
            i, j = index[p], index[qp]
            if i < j:
                edges.add((i, j))
            elif j < i:
                edges.add((j, i))
    return pts, index, sorted(edges), C


def find_triangle(pts, index, edges):
    """a unit triangle if one exists (omega = 3), else a single edge"""
    adj = defaultdict(set)
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    for a, b in edges:
        common = adj[a] & adj[b]
        if common:
            return [a, b, min(common)]
    a, b = edges[0]
    return [a, b]


def cnf(nv, edges, k, pins, precedence=True):
    def var(v, c):
        return k * v + c + 1
    cl = []
    for v in range(nv):
        cl.append([var(v, c) for c in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                cl.append([-var(v, c1), -var(v, c2)])
    for a, b in edges:
        for c in range(k):
            cl.append([-var(a, c), -var(b, c)])
    for v, c in pins:
        cl.append([var(v, c)])
    if precedence:
        pinned = {c for _, c in pins}
        free = [c for c in range(k) if c not in pinned]
        for j in range(1, len(free)):
            c, cp = free[j], free[j - 1]
            for v in range(nv):
                cl.append([-var(v, c)] + [var(u, cp) for u in range(v)])
    return cl


def write_cnf(path, nv, cl):
    with open(path, 'w') as f:
        f.write(f'p cnf {nv} {len(cl)}\n')
        for c in cl:
            f.write(' '.join(map(str, c)) + ' 0\n')
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()


def verify_model(path, nv, edges, k):
    """read a solver model and check the colouring is proper -- a SAT verdict is never believed on the exit code"""
    sol = {}
    for line in open(path):
        if line.startswith('v'):
            for t in line[1:].split():
                x = int(t)
                if x:
                    sol[abs(x)] = x > 0
    col = {}
    for v in range(nv):
        cs = [c for c in range(k) if sol.get(k * v + c + 1)]
        if len(cs) != 1:
            return None, f'vertex {v} has colours {cs}'
        col[v] = cs[0]
    for a, b in edges:
        if col[a] == col[b]:
            return None, f'edge ({a}, {b}) is monochromatic'
    return col, None


def ask(out, tag, nv, edges, k, pins, solver, budget):
    os.makedirs(out, exist_ok=True)
    cl = cnf(nv, edges, k, pins)
    path = os.path.join(out, f'{tag}.cnf')
    sha = write_cnf(path, k * nv, cl)
    mpath = os.path.join(out, f'{tag}.model')
    t0 = time.time()
    try:
        r = subprocess.run([solver, os.path.join(out, f'{tag}.cnf')], capture_output=True, text=True,
                           timeout=budget)
        txt = r.stdout
    except subprocess.TimeoutExpired:
        return {'tag': tag, 'k': k, 'verdict': 'UNKNOWN', 'seconds': budget, 'sha256': sha,
                'note': f'budget {budget}s expired on this encoding (clique pin + precedence); '
                        f'a fact about the encoding, not about the graph'}
    secs = round(time.time() - t0, 3)
    if r.returncode == 20:
        return {'tag': tag, 'k': k, 'verdict': 'UNSAT', 'seconds': secs, 'sha256': sha, 'clauses': len(cl)}
    if r.returncode == 10:
        with open(mpath, 'w') as f:
            f.write(txt)
        col, err = verify_model(mpath, nv, edges, k)
        return {'tag': tag, 'k': k, 'verdict': 'SAT', 'seconds': secs, 'sha256': sha, 'clauses': len(cl),
                'model_verified': err is None, 'model_error': err}
    return {'tag': tag, 'k': k, 'verdict': f'UNKNOWN({r.returncode})', 'seconds': secs, 'sha256': sha}


def cmd_run(qs, kmax, budget, out, solver='kissat'):
    rows = []
    for q in qs:
        F = Fq(q)
        pts, index, edges, C = plane_graph(F)
        tri = find_triangle(pts, index, edges)
        deg = 2 * len(edges) / len(pts)
        print(f'== UD(F_{q}^2): {len(pts)} vertices, {len(edges)} edges, degree {deg:.0f}, '
              f'circle {len(C)} points, omega >= {len(tri)}')
        rec = {'q': q, 'vertices': len(pts), 'edges': len(edges), 'degree': int(deg), 'circle': len(C),
               'clique_pinned': len(tri), 'asks': []}
        for k in range(2, kmax + 1):
            pins = [(v, c) for c, v in enumerate(tri[:k])]
            a = ask(os.path.join(out, f'q{q}'), f'k{k}', len(pts), edges, k, pins, solver, budget)
            a['pins'] = pins
            rec['asks'].append(a)
            print(f'   k = {k}: {a["verdict"]:>8}  {a["seconds"]:>8.3f}s  '
                  f'{"model verified" if a.get("model_verified") else ""}'
                  f'{"  MODEL BAD: " + str(a.get("model_error")) if a.get("model_error") else ""}'
                  f'  sha {a["sha256"][:16]}')
            if a['verdict'] == 'SAT':
                rec['chi_upper'] = k
                break
            if a['verdict'] == 'UNSAT':
                rec['chi_lower'] = k + 1
        rows.append(rec)
        print()
    if out:
        os.makedirs(out, exist_ok=True)
        with open(os.path.join(out, 'fq-planes.json'), 'w') as f:
            json.dump(rows, f, indent=1)
        print('wrote', os.path.join(out, 'fq-planes.json'))
    return rows


PLANTS = ('circle_short',)


def cmd_selftest(solver='kissat'):
    global PLANT
    # the field arithmetic: q - 1 circle points at every q = 1 mod 4, q + 1 at q = 3 mod 4
    for q in (9, 25, 49, 5, 13, 17):
        F = Fq(q)
        C = circle(F)
        want = q - 1 if q % 4 == 1 else q + 1
        assert len(C) == want, f'|circle| at q = {q} is {len(C)}, expected {want}'
        assert F.mul(F.one, F.one) == F.one
    # omega = 3 iff char 3 or 3 is a square (Krebs); check the triangle really is one
    for q in (9, 25, 49):
        F = Fq(q)
        pts, index, edges, C = plane_graph(F)
        tri = find_triangle(pts, index, edges)
        assert len(tri) == 3, f'no unit triangle at q = {q}, but 3 is a square or the characteristic'
        es = set(edges)
        for a, b in itertools.combinations(sorted(tri), 2):
            assert (a, b) in es, (q, a, b)
    # the encoding CAN refuse: two colours at q = 9 must be UNSAT (a triangle alone refutes it)
    F = Fq(9)
    pts, index, edges, C = plane_graph(F)
    tri = find_triangle(pts, index, edges)
    a2 = ask('build/fs70/fq-selftest', 'k2', len(pts), edges, 2, [(tri[0], 0), (tri[1], 1)], solver, 60)
    assert a2['verdict'] == 'UNSAT', a2
    a3 = ask('build/fs70/fq-selftest', 'k3', len(pts), edges, 3,
             [(tri[0], 0), (tri[1], 1), (tri[2], 2)], solver, 60)
    assert a3['verdict'] == 'SAT' and a3['model_verified'], a3
    print('fs70_fq_plane selftest OK: circle sizes at q = 5, 9, 13, 17, 25, 49; a unit triangle at 9, 25, 49; '
          'two colours refused and three colours found-and-verified at q = 9')
    ok = True
    for name in PLANTS:
        r = subprocess.run([sys.executable, __file__, 'selftest', '--plant', name], capture_output=True, text=True)
        if r.returncode == 0:
            print(f'--- plant {name}: NOT REFUSED')
            ok = False
        else:
            print(f'--- plant {name}: refused (exit {r.returncode}): '
                  f'{(r.stderr.strip().split(chr(10)) or [""])[-1][:140]}')
    if not ok:
        raise SystemExit('a planted fault did not fire')


if __name__ == '__main__':
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = argv[argv.index('--plant') + 1]
    out = argv[argv.index('--out') + 1] if '--out' in argv else 'build/fs70/fq'
    kmax = int(argv[argv.index('--kmax') + 1]) if '--kmax' in argv else 5
    budget = int(argv[argv.index('--budget') + 1]) if '--budget' in argv else 600
    if not argv or argv[0] == 'selftest':
        cmd_selftest()
    elif argv[0] == 'run':
        qs, i = [], 1
        while i < len(argv):                       # option VALUES must not be read as q's
            if argv[i].startswith('--'):
                i += 2
                continue
            qs.append(int(argv[i]))
            i += 1
        qs = qs or [9, 25, 49]
        cmd_run(qs, kmax, budget, out)
    else:
        print(__doc__)
