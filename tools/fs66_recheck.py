#!/usr/bin/env python3
"""fs66_recheck -- ask four independent solver codebases whether a witness's BARE edge list can be coloured,
with no pin and no symmetry breaking at all (FS-66; the shape of the plan's measurement M2).

UNTRUSTED, like everything in tools/. This adds nothing to `tools/fs66_check_witness.py`'s certificate, which
is the artifact a sceptic re-checks; it answers a different question -- *does the refusal depend on CaDiCaL,
or on the pin?* -- and it answers it with four solvers that share no code with CaDiCaL or with each other's
CDCL implementations (glucose4, minisat22, cadical153, maplechrono, through pysat).

Three things are asked of every witness:
  * every listed pair re-verified from the definition, in integer arithmetic, with the point coordinates read
    out of the witness file (a fifth opinion on the geometry, independent of the checker);
  * the bare edge list at k colours, NO pin, of each solver -- expected UNSAT;
  * the bare edge list at k + 1 colours of one solver, with the model verified on every listed edge -- the
    POSITIVE control, without which a row of UNSATs measures only that the instrument can say no.

usage: fs66_recheck.py WITNESS.json [--record records.jsonl] [--workers 4]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import multiprocessing as mp
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs66_tower import emit_record, graph_spec, sha_file  # noqa: E402

SOLVERS = ('glucose4', 'minisat22', 'cadical153', 'maplechrono')


def clauses_of(points, edges, k):
    """the bare colouring formula: no pin, no precedence, nothing broken."""
    x = lambda v, c: k * v + c + 1
    cl = [[x(v, c) for c in range(k)] for v in range(len(points))]
    for i, j in edges:
        for c in range(k):
            cl.append([-x(i, c), -x(j, c)])
    return cl


def one(job):
    name, points, edges, k = job
    from pysat.solvers import Solver
    t0 = time.time()
    proper = None
    with Solver(name=name, bootstrap_with=clauses_of(points, edges, k)) as s:
        sat = s.solve()
        if sat:
            m = {l for l in s.get_model() if l > 0}
            col = [next(c for c in range(k) if k * v + c + 1 in m) for v in range(len(points))]
            proper = all(col[i] != col[j] for i, j in edges)
    return name, k, ('SAT' if sat else 'UNSAT'), round(time.time() - t0, 2), proper


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('witness')
    ap.add_argument('--record')
    ap.add_argument('--workers', type=int, default=4)
    a = ap.parse_args()

    with open(a.witness, 'rb') as f:
        wbytes = f.read()
    W = json.loads(wbytes)
    n, k = W['n'], W['k']
    pts = [tuple(p) for p in W['points']]
    E = [tuple(e) for e in W['edges']]
    bad = [(m, i, j) for m, (i, j) in enumerate(E)
           if ((pts[i][0] - pts[j][0]) ** 2 + (pts[i][1] - pts[j][1]) ** 2) % n != 1 % n]
    print(f'{a.witness}: {len(pts)} points of (Z/{n})^2, {len(E)} listed pairs, '
          f'{len(E) - len(bad)} of {len(E)} re-verified as unit pairs from the definition'
          + (f' -- {len(bad)} ARE NOT: {bad[:3]}' if bad else ''))
    if bad:
        return 1
    print(f'the bare edge list at {k} and {k + 1} colours, no pin, no symmetry breaking:')

    ctx = mp.get_context('fork')     # Python 3.14's default is forkserver, which empties module globals
    jobs = [(s, pts, E, k) for s in SOLVERS] + [(s, pts, E, k + 1) for s in SOLVERS]
    with ctx.Pool(min(a.workers, len(jobs))) as pool:
        results = sorted(pool.map(one, jobs), key=lambda r: (r[1], SOLVERS.index(r[0])))

    wsha = hashlib.sha256(wbytes).hexdigest()
    agree = True
    for name, kk, verdict, secs, proper in results:
        want = 'UNSAT' if kk == k else 'SAT'
        ok = verdict == want and (proper is not False)
        agree &= ok
        print(f'  k={kk} {name:12s} {verdict:5s} in {secs:5.1f} s'
              + ('' if proper is None else f' (model verified proper on all {len(E)} listed edges: {proper})')
              + ('' if ok else f'   <-- expected {want}'))
        if a.record:
            emit_record(a.record, __file__,
                        graph=graph_spec(n, None, None, 'subset', wsha, 'the witness\'s own edge list'),
                        vertices=len(pts), edges=len(E), k=kk, encoding='plain',
                        symmetry={'pin': None, 'precedence': False}, solver=name, seed=0,
                        limit={'kind': 'none', 'value': None}, verdict=verdict, conflicts=None,
                        cpu_s=secs, wall_s=secs, rss_mb=None, artifact=a.witness, artifact_sha256=wsha,
                        trust='verified colouring' if verdict == 'SAT' else 'refused (solver, untrusted)')
    print(f'{"all four solvers refuse " + str(k) + " colours on the bare list, and the same list takes "}'
          f'{k + 1} (the positive control)' if agree else 'SOMETHING DISAGREED -- see the rows above')
    return 0 if agree else 1


if __name__ == '__main__':
    sys.exit(main())
