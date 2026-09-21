#!/usr/bin/env python3
"""fs66_tower -- build, ask, and shrink the unit-distance graphs UD(Z/n, 2) of the residue tower (FS-66).

UNTRUSTED, like everything in tools/. Nothing here certifies anything: it *proposes* a witness, which
`tools/fs66_check_witness.py` (standard library only, sharing no code with this file) then re-checks from the
definition, and which the Lean kernel re-checks after that. A mistake here costs a theorem and cannot buy one.

The object. For a modulus n the graph UD(Z/n, 2) has the n^2 points (a, b) of (Z/n)^2, with (a, b) ~ (c, e)
exactly when (a - c)^2 + (b - e)^2 = 1 in Z/n. Vertex ids are v = a*n + b throughout, in every file this tool
writes and reads. For n = p^k this is level k of the tower at p; reduction mod p^(k-1) is a graph homomorphism,
so chi(level k) <= chi(level k-1).

The CNF order is `tools/coloring.py`'s, which is `Sat/Encoding.lean`'s `coloringCNF k n E ++ cubeCNF k n cube`:
variable x(v, c) = k*v + c + 1; clauses 1..N the at-least-one clauses in vertex order; then, per listed edge in
listed order, its k conflict clauses; then one unit clause per pin. Positions are load-bearing -- the LRAT
addresses clauses by position -- so every edge list this tool writes is sorted and deduplicated, and nothing
re-sorts a list between building a CNF and reading its proof.

Subcommands
  build     P K [--level L] [--out CNF]            the whole level-L graph at p, as a CNF with a triangle pinned
  ask       CNF [--lrat F] [-c N] [-t S]           run the toolchain's CaDiCaL; verdict from its exit status
  core      CNF LRAT K [--out J]                   backward reachability in the LRAT -> the vertices/edges used
  shrink    CORE.json K [--out J] [--seed S]       re-solve the core and re-extract, to a fixpoint
  witness   CORE.json --n N --k K --out DIR        the witness.json + witness.lrat.gz a checker consumes
  cnfdigest WITNESS.json                           the SAME CNF built by `tools/coloring.py` -- the second
                                                   builder, for fs66_check_witness's digest control
  certify   WITNESS.json --record R                run tools/fs66_check_witness.py and record ITS verdict
  level     CORE.json --from N --to M [--out J]    the subgraph of UD(Z/M,2) induced on the preimage of a core
  quotient  P K --quot a,b [--out CNF]             level two modulo the order-p translation subgroup p*(a,b)*Z

Every subcommand prints one line per fact and writes nothing it was not asked for.
"""
from __future__ import annotations

import argparse
import collections
import glob
import gzip
import hashlib
import json
import os
import re
import subprocess
import sys
import time

CADICAL = sorted(glob.glob(os.path.expanduser('~/.elan/toolchains/*/bin/cadical')))[-1]


# ------------------------------------------------------------------ the one record shape (plan section D)

RECORD_FIELDS = ('kind', 'record_version', 'utc', 'command', 'tool_sha256', 'graph', 'vertices', 'edges', 'k',
                 'encoding', 'symmetry', 'solver', 'seed', 'limit', 'verdict', 'conflicts', 'cpu_s', 'wall_s',
                 'rss_mb', 'machine', 'threads', 'artifact', 'artifact_sha256', 'trust')

TRUST_WORDS = ('verified colouring', 'refused (solver, untrusted)', 'CERTIFIED (fs66_check_witness)', 'kernel')


def sha_file(path):
    if not path or not os.path.exists(path):
        return None
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def emit_record(path, tool, **kw):
    """append one flat, typed line to a directory's records.jsonl. Every ask this milestone makes lands here,
    including the UNKNOWNs -- a typed null is a first-class record and must carry the limit that stopped it."""
    if kw.get('trust') not in TRUST_WORDS:
        raise SystemExit(f'trust must be one of {TRUST_WORDS}, not {kw.get("trust")!r}')
    rec = {'kind': 'fs66-ask', 'record_version': 1,
           'utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
           'command': ' '.join([sys.executable.split(os.sep)[-1]] + sys.argv),
           'tool_sha256': sha_file(os.path.abspath(tool)), 'machine': 'desktop', 'threads': 1}
    rec.update(kw)
    unknown = sorted(set(rec) - set(RECORD_FIELDS))
    if unknown:
        raise SystemExit(f'record field {unknown[0]!r} is not one of {RECORD_FIELDS}')
    os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)
    with open(path, 'a') as f:
        f.write(json.dumps({k: rec.get(k) for k in RECORD_FIELDS}) + '\n')
        f.flush()
        os.fsync(f.fileno())
    return rec


def graph_spec(n, p, level, restriction='all', of_sha=None, detail=None):
    return {'n': n, 'level': level, 'p': p,
            'restriction': {'type': restriction, 'of_sha256': of_sha, 'detail': detail}}


# ------------------------------------------------------------------ the graph, from the definition

def circle(n: int) -> list[tuple[int, int]]:
    """{(x, y) in (Z/n)^2 : x^2 + y^2 = 1 mod n} -- the unit circle, the graph's connection set."""
    return [(x, y) for x in range(n) for y in range(n) if (x * x + y * y) % n == 1 % n]


def all_edges(n: int) -> list[tuple[int, int]]:
    """every edge of UD(Z/n, 2), as sorted id pairs u < v with id = a*n + b."""
    S = circle(n)
    E = set()
    for a in range(n):
        for b in range(n):
            u = a * n + b
            for x, y in S:
                v = ((a + x) % n) * n + (b + y) % n
                if u != v:
                    E.add((min(u, v), max(u, v)))
    return sorted(E)


def is_unit_pair(n: int, u: int, v: int) -> bool:
    """the adjacency test, from the definition, in integer arithmetic -- the one predicate everything agrees on."""
    a, b = divmod(u, n)
    c, e = divmod(v, n)
    return ((a - c) ** 2 + (b - e) ** 2) % n == 1 % n


def find_triangle(V: list[int], E: list[tuple[int, int]]) -> tuple[int, int, int] | None:
    """a triangle of the listed graph, to pin. Colours are interchangeable, so fixing a clique's colours is a
    sound symmetry reduction -- but only while the clique's edges are IN the graph being asked (plan T1)."""
    adj = collections.defaultdict(set)
    for u, v in E:
        adj[u].add(v)
        adj[v].add(u)
    for u, v in E:
        common = adj[u] & adj[v]
        if common:
            return (u, v, min(common))
    return None


# ------------------------------------------------------------------ the CNF, in Lean's clause order

def build_cnf(N: int, edges: list[tuple[int, int]], pins: list[tuple[int, int]], k: int) -> list[list[int]]:
    """`coloringCNF k N edges ++ cubeCNF k N pins` over the LOCAL ids 0..N-1 (positions are the contract)."""
    x = lambda v, c: k * v + c + 1
    cl = [[x(v, c) for c in range(k)] for v in range(N)]
    for u, v in edges:
        for c in range(k):
            cl.append([-x(u, c), -x(v, c)])
    for v, c in pins:
        cl.append([x(v, c)])
    return cl


def cnf_text(N: int, cl: list[list[int]], k: int) -> str:
    return f'p cnf {k * N} {len(cl)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl)


def write_cnf(path: str, N: int, cl: list[list[int]], k: int) -> str:
    text = cnf_text(N, cl, k)
    with open(path, 'w') as f:
        f.write(text)
    return hashlib.sha256(text.encode()).hexdigest()


# ------------------------------------------------------------------ the solver, read by exit status

def run_cadical(cnf: str, lrat: str | None = None, conflicts: int | None = None, wall: int | None = None,
                seed: int = 0, witness: bool = True) -> dict:
    """CaDiCaL's verdict from ITS OWN exit status (10 SAT, 20 UNSAT, anything else unknown) -- never from a
    pipeline, and never from the absence of a message (plan T2, T8). Statistics come from its own report, so
    `-q` is never passed; `witness=False` suppresses only the model lines."""
    cmd = [CADICAL, f'--seed={seed}'] + ([] if witness else ['-n'])
    if conflicts is not None:
        cmd += ['-c', str(conflicts)]
    if wall is not None:
        cmd += ['-t', str(wall)]
    if lrat is not None:
        cmd += ['--lrat', '--no-binary']
    cmd.append(cnf)
    if lrat is not None:
        cmd.append(lrat)
    t0 = time.time()
    r = subprocess.run(cmd, capture_output=True, text=True)
    dt = time.time() - t0
    verdict = {10: 'SAT', 20: 'UNSAT'}.get(r.returncode, 'UNKNOWN')
    stats = {}
    for line in r.stdout.splitlines():
        m = re.match(r'^c (conflicts|decisions|propagations):\s+(\d+)', line)
        if m:
            stats[m.group(1)] = int(m.group(2))
        m = re.match(r'^c total process time since initialization:\s+([\d.]+)', line)
        if m:
            stats['process_s'] = float(m.group(1))
        m = re.match(r'^c maximum resident set size of process:\s+([\d.]+)\s+MB', line)
        if m:
            stats['rss_mb'] = float(m.group(1))
    model = None
    if r.returncode == 10:
        lits = set()
        for line in r.stdout.splitlines():
            if line.startswith('v '):
                lits.update(int(t) for t in line.split()[1:])
        model = lits
    return {'verdict': verdict, 'rc': r.returncode, 'wall_s': round(dt, 3), 'model': model,
            'cmd': ' '.join(cmd), **stats}


# ------------------------------------------------------------------ the LRAT core, by backward reachability

def read_cnf_file(path: str) -> tuple[int, int, list[list[int]]]:
    clauses = []
    with open(path) as f:
        hdr = f.readline().split()
        nv, nc = int(hdr[2]), int(hdr[3])
        for line in f:
            if line.strip():
                clauses.append([int(t) for t in line.split()[:-1]])
    if len(clauses) != nc:
        raise SystemExit(f'{path}: header says {nc} clauses, file has {len(clauses)}')
    return nv, nc, clauses


def lrat_used_originals(lrat: str, nc: int) -> set[int]:
    """the original clause ids the refutation actually uses, by backward reachability from the empty clause."""
    hints, empty = {}, None
    with open(lrat) as f:
        for line in f:
            t = line.split()
            if len(t) > 1 and t[1] == 'd':
                continue
            if not t:
                continue
            cid = int(t[0])
            z = t.index('0', 1)
            hints[cid] = [abs(int(h)) for h in t[z + 1:-1]]
            if z == 1:
                empty = cid
    if empty is None:
        raise SystemExit(f'{lrat}: no empty clause')
    used, stack, seen = set(), [empty], set()
    while stack:
        c = stack.pop()
        if c in seen:
            continue
        seen.add(c)
        if c <= nc:
            used.add(c)
        else:
            stack.extend(hints[c])
    return used


def core_of(clauses: list[list[int]], used: set[int], k: int, ids: list[int] | None = None):
    """the vertices and edges of the clauses a refutation used. `ids` maps local index -> global vertex id."""
    loc = (lambda i: ids[i]) if ids is not None else (lambda i: i)
    V, E, units = set(), set(), []
    for c in used:
        cl = clauses[c - 1]
        vs = sorted({loc((abs(l) - 1) // k) for l in cl})
        V.update(vs)
        if len(cl) == 1:
            units.append(cl[0])
        elif len(vs) == 2:
            E.add((vs[0], vs[1]))
    return sorted(V), sorted(E), units


# ------------------------------------------------------------------ subcommands

def cmd_build(a):
    n = a.p ** a.level
    t0 = time.time()
    E = all_edges(n)
    N = n * n
    tri = find_triangle(list(range(N)), E)
    pins = [(tri[i], i) for i in range(3)] if tri else []
    cl = build_cnf(N, E, pins, a.k)
    out = a.out or f'g{a.level}-p{a.p}-k{a.k}.cnf'
    sha = write_cnf(out, N, cl, a.k)
    print(f'n={n} (p={a.p}, level={a.level}): {N} vertices, {len(E)} edges, degree {2 * len(E) // N}, '
          f'circle {len(circle(n))} points')
    print(f'pinned triangle {list(tri)} -> colours 0,1,2' if tri else 'no triangle: nothing pinned')
    print(f'CNF {out}: {a.k * N} variables, {len(cl)} clauses, sha256 {sha}, built in {time.time() - t0:.1f}s')


def cmd_ask(a):
    r = run_cadical(a.cnf, a.lrat, a.conflicts, a.tlim, a.seed)
    print(f'{a.cnf}: {r["verdict"]} (exit {r["rc"]}) in {r["wall_s"]}s, '
          f'conflicts={r.get("conflicts")} rss={r.get("rss_mb")}MB')
    if a.record:
        lim = ({'kind': 'conflicts', 'value': a.conflicts} if a.conflicts else
               {'kind': 'wall_s', 'value': a.tlim} if a.tlim else {'kind': 'none', 'value': None})
        emit_record(a.record, __file__, graph=graph_spec(a.n, a.p, a.level, a.restriction),
                    vertices=a.vertices, edges=a.edge_count, k=a.k, encoding='plain',
                    symmetry={'pin': a.pin, 'precedence': False}, solver='cadical-2.1.2', seed=a.seed,
                    limit=lim, verdict=r['verdict'], conflicts=r.get('conflicts'),
                    cpu_s=r.get('process_s'), wall_s=r['wall_s'], rss_mb=r.get('rss_mb'),
                    artifact=a.lrat, artifact_sha256=sha_file(a.lrat),
                    trust='refused (solver, untrusted)' if r['verdict'] == 'UNSAT' else
                          'verified colouring' if r['verdict'] == 'SAT' else 'refused (solver, untrusted)')
    if r['verdict'] == 'SAT' and a.model_out:
        json.dump(sorted(l for l in r['model'] if l > 0), open(a.model_out, 'w'))
        print(f'  model written to {a.model_out}')
    return 0 if r['verdict'] != 'UNKNOWN' else 3


def cmd_core(a):
    nv, nc, clauses = read_cnf_file(a.cnf)
    used = lrat_used_originals(a.lrat, nc)
    V, E, units = core_of(clauses, used, a.k)
    out = a.out or a.lrat + '.core.json'
    json.dump({'verts': V, 'edges': [list(e) for e in E], 'units': units}, open(out, 'w'))
    print(f'original clauses used: {len(used)} of {nc}')
    print(f'core: {len(V)} vertices, {len(E)} edges, units={units} -> {out}')


def solve_subgraph(V, E, k, tri, workdir, tag, seed=0, conflicts=None):
    """solve the listed graph with `tri` pinned, keeping the LRAT. Returns (result, local clauses, ids)."""
    pos = {v: i for i, v in enumerate(V)}
    loc_E = [(pos[u], pos[v]) for u, v in E]
    pins = [(pos[tri[i]], i) for i in range(3)] if tri else []
    cl = build_cnf(len(V), loc_E, pins, k)
    cnf = os.path.join(workdir, f'{tag}.cnf')
    lrat = os.path.join(workdir, f'{tag}.lrat')
    write_cnf(cnf, len(V), cl, k)
    r = run_cadical(cnf, lrat, conflicts=conflicts, seed=seed)
    return r, cl, cnf, lrat


def cmd_shrink(a):
    d = json.load(open(a.core))
    V, E = list(d['verts']), [tuple(e) for e in d['edges']]
    tri = find_triangle(V, E)
    print(f'pinned triangle {list(tri) if tri else None}')
    workdir = a.workdir
    os.makedirs(workdir, exist_ok=True)
    rnd = 0
    while True:
        r, cl, cnf, lrat = solve_subgraph(V, E, a.k, tri, workdir, 'shrink', seed=a.seed + rnd)
        if r['verdict'] != 'UNSAT':
            raise SystemExit(f'round {rnd}: {r["verdict"]}, not UNSAT -- the core does not refuse')
        used = lrat_used_originals(lrat, len(cl))
        nV, nE, _ = core_of(cl, used, a.k, ids=V)
        nV, nE = set(nV), set(nE)
        if tri:  # T1: the pin is sound only while its triangle is in the graph -- put its edges back
            for e in ((tri[0], tri[1]), (tri[0], tri[2]), (tri[1], tri[2])):
                nE.add((min(e), max(e)))
            nV.update(tri)
        rnd += 1
        print(f'round {rnd}: {len(V)}v/{len(E)}e -> {len(nV)}v/{len(nE)}e '
              f'(lrat {os.path.getsize(lrat) // 1024} KB, {r["conflicts"]} conflicts)', flush=True)
        if len(nV) == len(V) and len(nE) == len(E):
            break
        V, E = sorted(nV), sorted(nE)
        if rnd >= a.max_rounds:
            break
    out = a.out or a.core.replace('.json', '') + '.shrunk.json'
    json.dump({'verts': V, 'edges': [list(e) for e in E]}, open(out, 'w'))
    print(f'fixpoint: {len(V)} vertices, {len(E)} edges -> {out}')


def cmd_witness(a):
    """core JSON -> the witness a checker consumes: points, sorted edge list, pin, and a fresh LRAT of ITS CNF."""
    d = json.load(open(a.core))
    V = sorted(d['verts'])
    pos = {v: i for i, v in enumerate(V)}
    E = sorted({(pos[u], pos[v]) if pos[u] < pos[v] else (pos[v], pos[u]) for u, v in d['edges']})
    n = a.n
    bad = [(i, j) for i, j in E if not is_unit_pair(n, V[i], V[j])]
    if bad:
        raise SystemExit(f'{len(bad)} listed pairs are not unit pairs modulo {n}: {bad[:3]}')
    tri = find_triangle(list(range(len(V))), E)
    if tri is None:
        raise SystemExit('no triangle in the listed graph: nothing to pin')
    pins = [(tri[i], i) for i in range(3)]
    cl = build_cnf(len(V), E, pins, a.k)
    os.makedirs(a.out, exist_ok=True)
    cnf = os.path.join(a.out, 'witness.cnf')
    lrat = os.path.join(a.out, 'witness.lrat')
    sha = write_cnf(cnf, len(V), cl, a.k)
    r = run_cadical(cnf, lrat, seed=a.seed)
    if r['verdict'] != 'UNSAT':
        raise SystemExit(f'the listed graph is {r["verdict"]}, not UNSAT: no witness')
    with open(lrat, 'rb') as f:
        raw = f.read()
    with gzip.open(os.path.join(a.out, 'witness.lrat.gz'), 'wb', compresslevel=9) as f:
        f.write(raw)
    W = {'kind': 'fs66-witness', 'n': n, 'k': a.k,
         'points': [list(divmod(v, n)) for v in V],
         'edges': [list(e) for e in E], 'pin': list(tri),
         'provenance': {'tool': 'fs66_tower.py witness', 'utc': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()),
                        'source_core': os.path.basename(a.core), 'cadical_seed': a.seed,
                        'cnf_sha256': sha, 'lrat_lines': raw.count(b'\n'),
                        'lrat_sha256': hashlib.sha256(raw).hexdigest(),
                        'conflicts': r.get('conflicts'), 'solver_wall_s': r['wall_s']}}
    with open(os.path.join(a.out, 'witness.json'), 'w') as f:
        json.dump(W, f, indent=1)
    os.remove(lrat)
    print(f'witness: {len(V)} points, {len(E)} edges, pin {list(tri)}, n={n}, k={a.k}')
    print(f'  CNF {a.k * len(V)} vars / {len(cl)} clauses sha256 {sha}')
    nlines = raw.count(b'\n')
    print(f'  LRAT {len(raw) // 1024} KB text, {nlines} lines, {r["conflicts"]} conflicts, '
          f'{r["wall_s"]}s -> {a.out}/witness.lrat.gz')
    if a.record:
        emit_record(a.record, __file__,
                    graph=graph_spec(n, None, None, 'subset', None, 'the witness\'s own point list'),
                    vertices=len(V), edges=len(E), k=a.k, encoding='plain',
                    symmetry={'pin': list(tri), 'precedence': False}, solver='cadical-2.1.2', seed=a.seed,
                    limit={'kind': 'none', 'value': None}, verdict=r['verdict'], conflicts=r.get('conflicts'),
                    cpu_s=r.get('process_s'), wall_s=r['wall_s'], rss_mb=r.get('rss_mb'),
                    artifact=os.path.join(a.out, 'witness.lrat.gz'),
                    artifact_sha256=sha_file(os.path.join(a.out, 'witness.lrat.gz')),
                    trust='refused (solver, untrusted)')


def cmd_certify(a):
    """run the standard-library checker on a witness and record ITS verdict, with its trust word."""
    checker = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'fs66_check_witness.py')
    r = subprocess.run([sys.executable, checker, a.witness], capture_output=True, text=True)
    last = [l for l in r.stdout.strip().splitlines() if l.strip()][-1] if r.stdout.strip() else '(no output)'
    print(last)
    W = json.load(open(a.witness))
    proof = os.path.join(os.path.dirname(os.path.abspath(a.witness)), 'witness.lrat.gz')
    if a.record:
        emit_record(a.record, checker,
                    graph=graph_spec(W['n'], None, None, 'subset', sha_file(a.witness),
                                     "the witness's own point list"),
                    vertices=len(W['points']), edges=len(W['edges']), k=W['k'], encoding='plain',
                    symmetry={'pin': W['pin'], 'precedence': False}, solver='fs66_check_witness (no solver)',
                    seed=None, limit={'kind': 'none', 'value': None},
                    verdict='UNSAT' if r.returncode == 0 else 'UNKNOWN', conflicts=None, cpu_s=None,
                    wall_s=None, rss_mb=None, artifact=proof, artifact_sha256=sha_file(proof),
                    trust='CERTIFIED (fs66_check_witness)' if r.returncode == 0
                          else 'refused (solver, untrusted)')
    return r.returncode


def cmd_cnfdigest(a):
    """the SECOND CNF builder: `tools/coloring.py`'s, over the same witness. Two builders, agreement checked."""
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import coloring  # noqa: E402  -- deliberately the other builder
    W = json.load(open(a.witness))
    n_pts, k = len(W['points']), W['k']
    edges = [tuple(e) for e in W['edges']]
    pins = [(v, c) for c, v in enumerate(W['pin'])]
    cl = coloring.base_clauses(n_pts, edges, k) + coloring.pin_clauses(pins, k)
    text = f'p cnf {k * n_pts} {len(cl)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl)
    print(f'sha256 {hashlib.sha256(text.encode()).hexdigest()} vars {k * n_pts} clauses {len(cl)} '
          f'builder tools/coloring.py')


def cmd_level(a):
    """the subgraph of UD(Z/M, 2) induced on the preimage of a core of UD(Z/N, 2) (M a multiple of N)."""
    d = json.load(open(a.core))
    N, M = a.from_n, a.to_n
    if M % N:
        raise SystemExit(f'{M} is not a multiple of {N}')
    f = M // N
    pre = []
    for v in d['verts']:
        a0, b0 = divmod(v, N)
        for s in range(f):
            for t in range(f):
                pre.append((a0 + N * s) * M + (b0 + N * t))
    pre.sort()
    idx = {v: i for i, v in enumerate(pre)}
    S = circle(M)
    E = set()
    for v in pre:
        x0, y0 = divmod(v, M)
        for dx, dy in S:
            w = ((x0 + dx) % M) * M + (y0 + dy) % M
            if w in idx and v != w:
                E.add((min(v, w), max(v, w)))
    E = sorted(E)
    out = a.out or f'preimage-{N}-to-{M}.json'
    json.dump({'verts': pre, 'edges': [list(e) for e in E]}, open(out, 'w'))
    deg = collections.Counter()
    for u, v in E:
        deg[u] += 1
        deg[v] += 1
    print(f'preimage of {len(d["verts"])} vertices of UD(Z/{N},2) in UD(Z/{M},2): {len(pre)} vertices, '
          f'{len(E)} edges, degree min/mean/max {min(deg.values())}/{2 * len(E) // len(pre)}/{max(deg.values())} -> {out}')


def cmd_quotient(a):
    """level two modulo the order-p translation subgroup p*(qa, qb)*Z -- a periodic ask, kept as a record."""
    p, n = a.p, a.p ** 2
    qa, qb = (int(t) for t in a.quot.split(','))
    H = [((p * t * qa) % n, (p * t * qb) % n) for t in range(p)]
    rep = lambda x, y: min(((x + u) % n, (y + v) % n) for u, v in H)
    reps = sorted({rep(x, y) for x in range(n) for y in range(n)})
    pos = {r: i for i, r in enumerate(reps)}
    S = circle(n)
    E = set()
    for i, (x, y) in enumerate(reps):
        for dx, dy in S:
            j = pos[rep(x + dx, y + dy)]
            if i == j:
                raise SystemExit('the subgroup meets the circle: the quotient has a loop')
            E.add((min(i, j), max(i, j)))
    E = sorted(E)
    tri = find_triangle(list(range(len(reps))), E)
    cl = build_cnf(len(reps), E, [(tri[i], i) for i in range(3)] if tri else [], a.k)
    out = a.out or f'quot-p{p}-{qa}_{qb}-k{a.k}.cnf'
    write_cnf(out, len(reps), cl, a.k)
    print(f'quotient by p*({qa},{qb})*Z: {len(reps)} vertices, {len(E)} edges, degree {2 * len(E) // len(reps)} -> {out}')


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest='cmd', required=True)

    b = sub.add_parser('build'); b.add_argument('p', type=int); b.add_argument('k', type=int)
    b.add_argument('--level', type=int, default=2); b.add_argument('--out'); b.set_defaults(fn=cmd_build)

    s = sub.add_parser('ask'); s.add_argument('cnf'); s.add_argument('--lrat')
    s.add_argument('-c', '--conflicts', type=int); s.add_argument('-t', '--tlim', type=int)
    s.add_argument('--seed', type=int, default=0); s.add_argument('--model-out')
    s.add_argument('--record'); s.add_argument('--n', type=int); s.add_argument('--p', type=int)
    s.add_argument('--level', type=int); s.add_argument('--k', type=int); s.add_argument('--vertices', type=int)
    s.add_argument('--edge-count', type=int); s.add_argument('--pin', type=json.loads, default=None)
    s.add_argument('--restriction', default='all'); s.set_defaults(fn=cmd_ask)

    c = sub.add_parser('core'); c.add_argument('cnf'); c.add_argument('lrat'); c.add_argument('k', type=int)
    c.add_argument('--out'); c.set_defaults(fn=cmd_core)

    h = sub.add_parser('shrink'); h.add_argument('core'); h.add_argument('k', type=int)
    h.add_argument('--out'); h.add_argument('--seed', type=int, default=0)
    h.add_argument('--max-rounds', type=int, default=40)
    h.add_argument('--workdir', default='/tmp/fs66-shrink'); h.set_defaults(fn=cmd_shrink)

    w = sub.add_parser('witness'); w.add_argument('core'); w.add_argument('--n', type=int, required=True)
    w.add_argument('--k', type=int, required=True); w.add_argument('--out', required=True)
    w.add_argument('--seed', type=int, default=0); w.add_argument('--record'); w.set_defaults(fn=cmd_witness)

    g = sub.add_parser('cnfdigest'); g.add_argument('witness'); g.set_defaults(fn=cmd_cnfdigest)

    ce = sub.add_parser('certify'); ce.add_argument('witness'); ce.add_argument('--record')
    ce.set_defaults(fn=cmd_certify)

    l = sub.add_parser('level'); l.add_argument('core'); l.add_argument('--from', dest='from_n', type=int, required=True)
    l.add_argument('--to', dest='to_n', type=int, required=True); l.add_argument('--out'); l.set_defaults(fn=cmd_level)

    q = sub.add_parser('quotient'); q.add_argument('p', type=int); q.add_argument('k', type=int)
    q.add_argument('--quot', required=True); q.add_argument('--out'); q.set_defaults(fn=cmd_quotient)

    a = ap.parse_args()
    sys.exit(a.fn(a) or 0)


if __name__ == '__main__':
    main()
