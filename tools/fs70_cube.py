#!/usr/bin/env python3
"""fs70_cube -- cube-and-conquer for a four-colouring refutation, checkpointed per cube.

Splits a CNF-free colouring instance (vertices, edges, pins) on the colours of a branching set of vertices,
prunes the cubes that the edges among the branching set and the pins already refute, and solves the survivors in
parallel.  Every cube's verdict is appended to `cubes.jsonl` AS IT LANDS, so a kill costs the cubes in flight and
nothing else; `--resume` re-asks only the cubes with no row.  The instance is UNSAT iff every cube is.

  python3 tools/fs70_cube.py run GRAPH.json --branch 7 [--jobs 30] [--budget 900] [--out DIR] [--resume]

GRAPH.json carries {"points": …, "edges": [[i,j],…], "A": i, "B": j} and the ask is "c(A) = c(B)": A and B are
contracted into one vertex, which is the same question and propagates better.  UNTRUSTED (tools/).
"""
from collections import defaultdict
import concurrent.futures as cf
import hashlib
import itertools
import json
import os
import subprocess
import sys
import time

K = 4


def var(v, c):
    return K * v + c + 1


def base_clauses(n, edges, pins):
    cl = []
    for v in range(n):
        cl.append([var(v, c) for c in range(K)])
        for c1 in range(K):
            for c2 in range(c1 + 1, K):
                cl.append([-var(v, c1), -var(v, c2)])
    for a, b in edges:
        for c in range(K):
            cl.append([-var(a, c), -var(b, c)])
    for v, c in pins:
        cl.append([var(v, c)])
    return cl


def write_cnf(path, nv, cl):
    with open(path, 'w') as f:
        f.write(f'p cnf {nv} {len(cl)}\n')
        for c in cl:
            f.write(' '.join(map(str, c)) + ' 0\n')
    return hashlib.sha256(open(path, 'rb').read()).hexdigest()


def load(path):
    g = json.load(open(path))
    n = len(g['points'])
    edges = [tuple(e) for e in g['edges']]
    ia, ib = g['A'], g['B']
    m = {}
    nxt = 0
    for v in range(n):
        if v == ib:
            continue
        m[v] = nxt
        nxt += 1
    m[ib] = m[ia]
    E = sorted({tuple(sorted((m[a], m[b]))) for a, b in edges if m[a] != m[b]})
    loops = [(a, b) for a, b in edges if m[a] == m[b]]
    return nxt, E, m[ia], loops


def solve_one(args):
    path, solver, budget = args
    t0 = time.time()
    try:
        r = subprocess.run([solver, '-q', path], capture_output=True, text=True, timeout=budget)
        v = 'UNSAT' if r.returncode == 20 else 'SAT' if r.returncode == 10 else f'UNKNOWN({r.returncode})'
    except subprocess.TimeoutExpired:
        v = 'UNKNOWN'
    return path, v, round(time.time() - t0, 2)


def main():
    argv = sys.argv[1:]
    graph = argv[1]
    nbranch = int(argv[argv.index('--branch') + 1]) if '--branch' in argv else 7
    jobs = int(argv[argv.index('--jobs') + 1]) if '--jobs' in argv else 30
    budget = int(argv[argv.index('--budget') + 1]) if '--budget' in argv else 900
    out = argv[argv.index('--out') + 1] if '--out' in argv else 'build/fs70/cubes'
    solver = argv[argv.index('--solver') + 1] if '--solver' in argv else 'kissat'
    resume = '--resume' in argv
    os.makedirs(out, exist_ok=True)
    n, E, A, loops = load(graph)
    assert not loops, f'the contraction created {len(loops)} self-loops: c(A) = c(B) is refuted outright'
    adj = defaultdict(set)
    for a, b in E:
        adj[a].add(b)
        adj[b].add(a)
    tri = None
    for v1 in sorted(adj[A]):
        c = adj[A] & adj[v1]
        if c:
            tri = (v1, min(c))
            break
    pins = [(A, 0), (tri[0], 1), (tri[1], 2)]
    print(f'{graph}: contracted to {n} vertices, {len(E)} edges; pins {pins}')
    fixed = {v: c for v, c in pins}
    # branching set: the highest-degree unpinned vertices
    cand = sorted((v for v in range(n) if v not in fixed), key=lambda v: -len(adj[v]))[:nbranch]
    print(f'branching on {cand} (degrees {[len(adj[v]) for v in cand]})')
    base = base_clauses(n, E, pins)
    cubes = []
    for assign in itertools.product(range(K), repeat=nbranch):
        col = dict(fixed)
        ok = True
        for v, c in zip(cand, assign):
            col[v] = c
        for v, c in zip(cand, assign):
            for w in adj[v]:
                if col.get(w) == c:
                    ok = False
                    break
            if not ok:
                break
        if ok:
            cubes.append(assign)
    print(f'{len(cubes)} cubes of {K ** nbranch} survive the branching set\'s own edges')
    ledger = os.path.join(out, 'cubes.jsonl')
    done = {}
    if resume and os.path.exists(ledger):
        for line in open(ledger):
            r = json.loads(line)
            done[tuple(r['cube'])] = r['verdict']
        print(f'resuming: {len(done)} cubes already have a verdict')
    todo = []
    for assign in cubes:
        if tuple(assign) in done and done[tuple(assign)] in ('SAT', 'UNSAT'):
            continue
        tag = 'c' + ''.join(map(str, assign))
        path = os.path.join(out, tag + '.cnf')
        cl = base + [[var(v, c)] for v, c in zip(cand, assign)]
        write_cnf(path, K * n, cl)
        todo.append((path, assign))
    print(f'{len(todo)} cubes to solve, {jobs} at a time, budget {budget}s each', flush=True)
    t0 = time.time()
    nun = nsat = nunk = 0
    with cf.ProcessPoolExecutor(max_workers=jobs) as ex, open(ledger, 'a') as fh:
        futs = {ex.submit(solve_one, (p, solver, budget)): a for p, a in todo}
        for i, fut in enumerate(cf.as_completed(futs)):
            path, v, secs = fut.result()
            a = futs[fut]
            fh.write(json.dumps({'cube': list(a), 'verdict': v, 'seconds': secs}) + '\n')
            fh.flush()
            os.remove(path)
            nun += v == 'UNSAT'
            nsat += v == 'SAT'
            nunk += v.startswith('UNKNOWN')
            if v == 'SAT':
                print(f'  *** SAT cube {a} -- the instance is SATISFIABLE, so A = B is possible.  STOP.')
                ex.shutdown(cancel_futures=True)
                break
            if (i + 1) % 25 == 0 or i + 1 == len(todo):
                el = time.time() - t0
                print(f'  {i+1}/{len(todo)} cubes: {nun} UNSAT, {nsat} SAT, {nunk} UNKNOWN; '
                      f'{el:.0f}s elapsed, {el/(i+1)*len(todo):.0f}s projected', flush=True)
    print(f'DONE: {nun} UNSAT, {nsat} SAT, {nunk} UNKNOWN of {len(todo)} in {time.time()-t0:.0f}s')
    print('VERDICT:', 'UNSAT (every cube refuted)' if nsat == 0 and nunk == 0 else
          ('SAT' if nsat else f'UNDECIDED ({nunk} cubes hit the budget)'))


if __name__ == '__main__':
    main()
