#!/usr/bin/env python3
"""FS-61 gate C.10 -- the product owner's decorrelated recheck of a witness.

Shares no code with tools/fs58_*.py or tools/fs61_*.py.  Given a radicand D and a witness.json in FS-58's format
(points (a, b, c, e, m) = ((a + b sqrtD)/m, (c + e sqrtD)/m); edges = index pairs), it

  1. re-derives EVERY unit-distance pair among the points by exact integer arithmetic (all n(n-1)/2 pairs) and
     requires the file's edge list to equal that set exactly (no missing edge, no invented edge);
  2. asks two solvers that are not CaDiCaL whether the graph is 3-colourable (own CNF; one edge pinned to colours 0, 1);
  3. finds a 4-colouring and verifies it on every edge in plain Python;
  4. reports the triangle count (zero is forced when sqrt3 is not in the field).

UNTRUSTED like everything in tools/: a second opinion, never a certificate.  Exit 0 = RECHECK PASS, 1 = a check failed.
"""
import json, sys, itertools
from math import gcd, isqrt


def is_unit(P, Q, D):
    a1, b1, c1, e1, m1 = P
    a2, b2, c2, e2, m2 = Q
    A, B = a1 * m2 - a2 * m1, b1 * m2 - b2 * m1
    C, E = c1 * m2 - c2 * m1, e1 * m2 - e2 * m1
    M = m1 * m2
    # (A + B sqrtD)^2 + (C + E sqrtD)^2 = M^2  <=>  rational part = M^2 and sqrtD part = 0 (sqrtD irrational)
    return A * A + D * B * B + C * C + D * E * E == M * M and A * B + C * E == 0


def squarefree(n):
    p = 2
    while p * p <= n:
        if n % (p * p) == 0:
            return False
        p += 1
    return n > 1


def colourable(n, edges, k, pin, solver_name):
    from pysat.solvers import Solver
    cnf = [[k * v + c + 1 for c in range(k)] for v in range(n)]
    for i, j in edges:
        for c in range(k):
            cnf.append([-(k * i + c + 1), -(k * j + c + 1)])
    units = [k * pin[0] + 1, k * pin[1] + 2]          # adjacent, so WLOG colours 0 and 1
    with Solver(name=solver_name, bootstrap_with=cnf) as s:
        ok = s.solve(assumptions=units)
        model = s.get_model() if ok else None
    if not ok:
        return False, None
    col = [next(c for c in range(k) if model[k * v + c] > 0) for v in range(n)]
    return True, col


def recheck(D, path, solvers=('glucose4', 'lingeling'), quiet=False):
    say = (lambda *a: None) if quiet else print
    w = json.load(open(path))
    pts = [tuple(p) for p in w['points']]
    file_edges = {tuple(sorted(e)) for e in w['edges']}
    n = len(pts)
    fails = []
    if not squarefree(D): fails.append(f'D = {D} is not squarefree')
    if len(set(pts)) != n: fails.append('repeated point')
    for p in pts:
        if p[4] <= 0 or gcd(gcd(gcd(p[0], p[1]), gcd(p[2], p[3])), p[4]) != 1:
            fails.append(f'point {p} is not in lowest terms'); break
    mine = {(i, j) for i, j in itertools.combinations(range(n), 2) if is_unit(pts[i], pts[j], D)}
    missing, invented = mine - file_edges, file_edges - mine
    say(f'  points {n}; unit-distance pairs by exact arithmetic over all {n*(n-1)//2} pairs: {len(mine)}; file lists {len(file_edges)}')
    if missing: fails.append(f'{len(missing)} unit-distance pairs MISSING from the file, e.g. {sorted(missing)[0]}')
    if invented: fails.append(f'{len(invented)} listed edges are NOT at distance 1, e.g. {sorted(invented)[0]}')
    edges = sorted(mine)
    if not edges:
        fails.append('no edges at all'); return fails
    pin = edges[0]
    for name in solvers:
        ok, _ = colourable(n, edges, 3, pin, name)
        say(f'  3-colourable? {name}: {"SAT -- the graph IS 3-colourable" if ok else "UNSAT"}')
        if ok: fails.append(f'{name} found a 3-colouring: the witness does not refuse')
    ok4, col = colourable(n, edges, 4, pin, solvers[0])
    if not ok4:
        fails.append('no 4-colouring found (so chi >= 5 would be claimed -- check by hand)')
    else:
        bad = [(i, j) for i, j in edges if col[i] == col[j]]
        say(f'  4-colouring found and verified on all {len(edges)} edges: {"yes" if not bad else "NO"}; class sizes {sorted([col.count(c) for c in range(4)], reverse=True)}')
        if bad: fails.append('the 4-colouring is not proper')
    adj = [set() for _ in range(n)]
    for i, j in edges: adj[i].add(j); adj[j].add(i)
    tri = sum(len(adj[i] & adj[j]) for i, j in edges) // 3
    deg = sorted(len(a) for a in adj)
    say(f'  triangles: {tri}; degrees min/median/max {deg[0]}/{deg[n//2]}/{deg[-1]}; 3 in some edge denominator: '
        f'{sum(1 for i, j in edges if (pts[i][4] * pts[j][4]) % 3 == 0)} edges have 3 | m_i m_j')
    return fails


if __name__ == '__main__':
    D, path = int(sys.argv[1]), sys.argv[2]
    print(f'owner recheck: D = {D}, {path}')
    fails = recheck(D, path)
    if '--plants' in sys.argv:
        import tempfile, os, copy
        w = json.load(open(path))
        print('  plants (each must make the recheck FAIL):')
        for label, mut, DD in (
            ('one listed edge removed', lambda x: x['edges'].pop(len(x['edges']) // 2), D),
            ('one non-edge added', lambda x: x['edges'].append([0, next(j for j in range(1, len(x['points'])) if not is_unit(tuple(x['points'][0]), tuple(x['points'][j]), D))]), D),
            ('wrong radicand D + 12', lambda x: None, D + 12),
        ):
            x = copy.deepcopy(w); mut(x)
            fd, tmp = tempfile.mkstemp(suffix='.json'); os.close(fd)
            json.dump(x, open(tmp, 'w'))
            f = recheck(DD, tmp, solvers=('glucose4',), quiet=True)
            os.unlink(tmp)
            print(f'    [{"fired" if f else "DID NOT FIRE"}] {label}: {f[0] if f else ""}'[:170])
            if not f: fails.append(f'plant did not fire: {label}')
    print('RECHECK PASS' if not fails else 'RECHECK FAIL: ' + '; '.join(fails))
    sys.exit(0 if not fails else 1)
