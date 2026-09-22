#!/usr/bin/env python3
"""fs70_structure -- FS-70 phase 0.5: the structure instruments of the plan's section 3.6.

A four-colouring a solver FINDS is a measurement of the encoding until its structure is known (G21).  Three
instruments, run on every colouring a phase records:

  (i)   the QUOTIENT SCREEN -- is the colouring a function of Lambda / L for L = p Lambda?  One L per split prime
        at which the lattice is integral, because a residue colouring at p is a function of Lambda / p Lambda.
  (ii)  the PERIOD SCREEN -- for each candidate period t (the doubles 2s, triples 3s and sums s + s' of the
        lattice's unit vectors), the fraction of points p with c(p + t) = c(p), over the points where p + t is
        also in the graph.
  (iii) the IMPOSED-QUOTIENT ASK -- force the colouring to be a function of Lambda / p Lambda and re-ask.  SAT is
        a periodic colouring RULE and a theorem-shaped null; UNSAT says the free colourings are the only ones.
        Implemented by quotienting: one variable per class of Lambda / p Lambda that the point set meets, an edge
        between two classes holding a unit-distance pair, and a self-loop (a unit-distance pair inside one class)
        makes the ask UNSAT with no solver at all.

POSITIVE CONTROL (the plan's section 3.6, and the reason this instrument exists).  On the planner's `zeta12+v4`
ball the imposed-quotient ask at L = 3 Lambda must return SAT -- that lattice is all 3-units, so the residue
colouring at the prime above 3 lives there and is exactly a function of Lambda / 3 Lambda.  The planner's own
2 Lambda / 4 Lambda test found nothing because it asked at the wrong prime (G21: the instrument measured its own
enumeration).  On an `S_2` fabric, which is NOT all 3-units, the same ask must fail.  Both outcomes reachable,
both seen.  UNTRUSTED (tools/).

Commands
  python3 tools/fs70_structure.py quotient DIR P [--k 4] [--budget 600]   # the imposed-quotient ask
  python3 tools/fs70_structure.py screen DIR MODEL [--lat SPEC]           # (i) and (ii) on a found colouring
  python3 tools/fs70_structure.py control [--budget 600]                  # the positive control and its twin
"""
from collections import defaultdict
import hashlib
import json
import math
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_fabric as FB                                                     # noqa: E402
import fs70_field as FF                                                      # noqa: E402


def load_graph(d):
    g = json.load(open(os.path.join(d, 'graph.json')))
    pts = [tuple(p) for p in g['points']]
    edges = [tuple(e) for e in g['edges']]
    return g['meta'], g['M'], pts, edges


def class_of(p, M, mod, H, rank):
    """the class of a point in Lambda / mod*Lambda, as a tuple of coordinates mod `mod`"""
    c = FB.coords_in_basis(H, list(p))
    assert c is not None, p
    return tuple(x % mod for x in c)


def quotient_graph(pts, edges, M, H, rank, mod):
    """classes of Lambda / mod Lambda met by the point set, the induced edges, and the self-loops"""
    cls = {}
    cid = {}
    for i, p in enumerate(pts):
        k = class_of(p, M, mod, H, rank)
        if k not in cid:
            cid[k] = len(cid)
        cls[i] = cid[k]
    qe = set()
    loops = []
    for a, b in edges:
        ca, cb = cls[a], cls[b]
        if ca == cb:
            loops.append((a, b))
        else:
            qe.add((min(ca, cb), max(ca, cb)))
    return len(cid), sorted(qe), loops, cls


def cnf_colour(nv, edges, k, pins, precedence=True):
    def var(v, c):
        return k * v + c + 1
    cl = []
    for v in range(nv):
        cl.append([var(v, c) for c in range(k)])
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


def cmd_quotient(d, mod, k=4, budget=600, solver='kissat', out=None):
    meta, M, pts, edges = load_graph(d)
    spec = meta['lattice']
    lat = FB.Lattice(FB.generators(spec), spec)
    assert lat.M == M, (lat.M, M)
    nq, qe, loops, cls = quotient_graph(pts, edges, M, lat.H, lat.rank, mod)
    print(f'{d}: {len(pts)} points, {len(edges)} edges; Lambda / {mod}Lambda meets {nq} classes, '
          f'{len(qe)} quotient edges, {len(loops)} unit-distance pairs INSIDE a class')
    if loops:
        print(f'  => no {mod}Lambda-periodic colouring exists at any colour count: the pair '
              f'{loops[0]} is a unit edge inside one class (no solver needed)')
        return {'dir': d, 'mod': mod, 'k': k, 'classes': nq, 'quotient_edges': len(qe),
                'self_loops': len(loops), 'verdict': 'UNSAT', 'by': 'self-loop', 'seconds': 0.0}
    out = out or os.path.join(d, f'quotient{mod}')
    os.makedirs(out, exist_ok=True)
    cl = cnf_colour(nq, qe, k, [(0, 0)])
    path = os.path.join(out, f'k{k}.cnf')
    sha = write_cnf(path, k * nq, cl)
    t0 = time.time()
    try:
        r = subprocess.run([solver, path], capture_output=True, text=True, timeout=budget)
    except subprocess.TimeoutExpired:
        return {'dir': d, 'mod': mod, 'k': k, 'classes': nq, 'quotient_edges': len(qe), 'self_loops': 0,
                'verdict': 'UNKNOWN', 'seconds': budget, 'sha256': sha}
    secs = round(time.time() - t0, 3)
    verdict = 'UNSAT' if r.returncode == 20 else 'SAT' if r.returncode == 10 else f'UNKNOWN({r.returncode})'
    rec = {'dir': d, 'mod': mod, 'k': k, 'classes': nq, 'quotient_edges': len(qe), 'self_loops': 0,
           'verdict': verdict, 'seconds': secs, 'sha256': sha}
    if verdict == 'SAT':
        # lift the class colouring to the points and verify it on EVERY edge of the original graph
        sol = {}
        for line in r.stdout.split('\n'):
            if line.startswith('v'):
                for t in line[1:].split():
                    x = int(t)
                    if x:
                        sol[abs(x)] = x > 0
        qcol = {}
        for v in range(nq):
            cs = [c for c in range(k) if sol.get(k * v + c + 1)]
            qcol[v] = cs[0]
        colour = [qcol[cls[i]] for i in range(len(pts))]
        bad = [(a, b) for a, b in edges if colour[a] == colour[b]]
        rec['lifted_proper'] = not bad
        rec['lift_error'] = None if not bad else f'{len(bad)} monochromatic edges, first {bad[0]}'
        with open(os.path.join(out, f'k{k}.colouring.json'), 'w') as f:
            json.dump({'mod': mod, 'k': k, 'classes': nq, 'colour': colour}, f)
    print(f'  imposed-quotient ask at L = {mod}Lambda, k = {k}: {verdict} in {secs}s'
          + (f'; lifted colouring proper on all {len(edges)} edges: {rec.get("lifted_proper")}'
             if verdict == 'SAT' else ''))
    return rec


def cmd_screen(d, colouring, lat_spec=None):
    """(i) the quotient screen and (ii) the period screen on a colouring already in hand"""
    meta, M, pts, edges = load_graph(d)
    spec = lat_spec or meta['lattice']
    lat = FB.Lattice(FB.generators(spec), spec)
    lat.saturate('b')
    colour = json.load(open(colouring))['colour'] if isinstance(colouring, str) else colouring
    assert len(colour) == len(pts)
    out = {'dir': d, 'points': len(pts), 'edges': len(edges), 'quotient': {}, 'period': []}
    print(f'{d}: {len(pts)} points, {len(edges)} edges')
    for mod in (2, 3, 4, 5, 6, 7):
        cls = defaultdict(set)
        for i, p in enumerate(pts):
            cls[class_of(p, M, mod, lat.H, lat.rank)].add(colour[i])
        consistent = sum(1 for v in cls.values() if len(v) == 1)
        out['quotient'][mod] = {'classes': len(cls), 'monochromatic': consistent,
                                'is_function_of_quotient': consistent == len(cls)}
        print(f'  quotient screen at {mod}Lambda: {consistent} of {len(cls)} classes monochromatic'
              + ('  <== the colouring IS a function of the quotient' if consistent == len(cls) else ''))
    index = {p: i for i, p in enumerate(pts)}
    cands = {}
    U = [lat.vec8(z) for z in lat.units]
    for s in U:
        cands[tuple(2 * x for x in s)] = f'2*{s[:2]}'
        cands[tuple(3 * x for x in s)] = f'3*{s[:2]}'
    for a in U[:40]:
        for b in U[:40]:
            cands[tuple(x + y for x, y in zip(a, b))] = 'sum'
    rows = []
    for t, tag in cands.items():
        if not any(t):
            continue
        n = same = 0
        for i, p in enumerate(pts):
            j = index.get(tuple(x + y for x, y in zip(p, t)))
            if j is not None:
                n += 1
                same += colour[i] == colour[j]
        if n >= 20:
            rows.append((same / n, n, t, tag))
    rows.sort(reverse=True)
    out['period'] = [{'fraction': round(f, 4), 'pairs': n, 'kind': tag} for f, n, t, tag in rows[:10]]
    print(f'  period screen: {len(rows)} candidate periods with >= 20 testable pairs; best agreement '
          + ', '.join(f'{f:.3f} ({n} pairs, {tag})' for f, n, t, tag in rows[:5]))
    return out


def cmd_control(budget=600):
    """the plan's positive control, and its twin that must NOT find a rule."""
    results = {}
    # the ball over zeta12+v4 (all 3-units: the residue rule at the prime above 3 lives there)
    d = 'build/fs70/ball-v4-25'
    if not os.path.exists(os.path.join(d, 'graph.json')):
        print('building the control ball (zeta12+v4, R = 2.5) ...', flush=True)
        FB.cmd_ball('zeta12+v4', 2.5, d, None, 'b')
    r = cmd_quotient(d, 3, 4, budget)
    results['ball_v4_R2.5_mod3'] = r
    assert r['verdict'] == 'SAT', ('the positive control did not find the 3-adic rule', r)
    assert r.get('lifted_proper'), ('the lifted colouring is not proper', r)
    # the twin: an S_2 fabric, which is not all 3-units, must not admit a 3Lambda-periodic colouring
    d2 = 'build/fs70/word-u3k2-2'
    if not os.path.exists(os.path.join(d2, 'graph.json')):
        print('building the twin (group:u3:2, word ball k = 2) ...', flush=True)
        FB.cmd_word('group:u3:2', 2, d2, 'isqrt3', None, 'b')
    r2 = cmd_quotient(d2, 3, 4, budget)
    results['word_u3k2_k2_mod3'] = r2
    assert r2['verdict'] == 'UNSAT', ('the twin found a 3Lambda-periodic colouring, which the 3-adic gate '
                                      'says must not exist on fabric that is not all 3-units', r2)
    # and the same ball at the prime the planner asked at, which must find nothing
    r3 = cmd_quotient(d, 2, 4, budget)
    results['ball_v4_R2.5_mod2'] = r3
    r4 = cmd_quotient(d, 4, 4, budget)
    results['ball_v4_R2.5_mod4'] = r4
    print('\nCONTROL PASSED: the instrument sees the 3-adic rule on 3-unit fabric (SAT, lifted and verified) '
          'and does not on S_2 fabric (UNSAT).')
    print(f"  the planner's own primes on the same ball: 2Lambda {r3['verdict']} ({r3.get('by', 'solver')}), "
          f"4Lambda {r4['verdict']} ({r4.get('by', 'solver')})")
    return results


if __name__ == '__main__':
    argv = sys.argv[1:]
    budget = int(argv[argv.index('--budget') + 1]) if '--budget' in argv else 600
    k = int(argv[argv.index('--k') + 1]) if '--k' in argv else 4
    out = argv[argv.index('--out') + 1] if '--out' in argv else None
    if not argv or argv[0] == 'control':
        res = cmd_control(budget)
        if out:
            with open(out, 'w') as f:
                json.dump(res, f, indent=1)
            print('wrote', out)
    elif argv[0] == 'quotient':
        r = cmd_quotient(argv[1], int(argv[2]), k, budget)
        print(json.dumps(r))
    elif argv[0] == 'screen':
        r = cmd_screen(argv[1], argv[2])
        if out:
            with open(out, 'w') as f:
                json.dump(r, f, indent=1)
    else:
        print(__doc__)
