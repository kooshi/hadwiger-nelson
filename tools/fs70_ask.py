#!/usr/bin/env python3
"""fs70_ask -- one four-colour ask on a fabric graph, with the cube pass as the first resort.  UNTRUSTED (tools/).

WHAT AN ASK IS, AND WHAT ITS VERDICT MEANS.  Three pins, and the milestone turns on telling them apart: they differ
by one literal and the wrong one reads as a jackpot (plan section 1.5).  The name of a pin here is its CONCLUSION
when the formula is refuted, never the constraint the formula carries.

  pin              the formula says                        UNSAT means                       SAT means
  ---------------  --------------------------------------  --------------------------------  -----------------
  control          a proper 4-colouring exists at all       the FABRIC is 5-chromatic --      a 4-colouring of
                   (a unit triangle pinned 0,1,2)           HALT AND VERIFY                   the fabric exists
  forces DELTA     c(0) != c(DELTA): the pair is joined     Forces: every proper 4-colouring  some 4-colouring
   (alias eq)      by an edge and a common neighbour is     gives 0 and DELTA ONE colour --   separates them
                   pinned to a third colour                 THE MILESTONE'S TARGET
  separated DELTA  c(0) == c(DELTA): the pair is            Separated: a virtual edge at      some 4-colouring
   (alias sep)     CONTRACTED into one vertex               DELTA (Haugland's shape)          joins them

The chain theorem (CLAUDE.md G55) consumes a FORCED-EQUAL pair, so `forces` is the ask this milestone is for, and
`Lambda_forced` in `screen.jsonl` is the screen for exactly that pin.  A target the screen has killed is never
asked.  (The owner's phase-1 brief describes `eq` as the contracted encoding; that is the encoding of `separated`.
Plan section 1.2 and `fs70_fabric.write_shape` both name a pin by its conclusion, and so does this tool.)

BOTH PINS ARE SOUND BY COLOUR RELABELLING.  `forces`: in any proper colouring with c(A) != c(B), the triangle
A, B, w takes three distinct colours, which a permutation sends to 0, 1, 2.  `separated`: in any proper colouring
with c(A) = c(B), the contracted vertex and a triangle through it take three distinct colours.  With three colours
pinned no value symmetry is left, so no precedence break is added; with two pinned, the free pair is broken by the
linear precedence encoding of `fs70_fabric.coloring_cnf` (CLAUDE.md, the symmetry checklist).

THE STOP RULE (the owner's ruling 3, from phase 0's control: a 740-vertex refusal beat eight single-solver
configurations at up to 27 minutes and fell to 1,458 cubes in 436 s).  One single-solver attempt -- kissat, which
catches the SAT direction fast -- then cube-and-conquer AT ONCE, branching on the highest-degree vertices.  Every
cube's verdict is appended to `cubes.jsonl` as it lands, so a kill costs the cubes in flight and nothing else.  A
budget expiry is recorded as UNKNOWN with the encoding named, never as a fact about the graph (CLAUDE.md G21).

Commands
  python3 tools/fs70_ask.py run DIR PIN [options]     # DIR holds graph.json from fs70_fabric
  python3 tools/fs70_ask.py resume                    # re-ask every formula in data/fs70/inflight/ and nothing else
  python3 tools/fs70_ask.py status                    # the owner's table, one block per lattice
  python3 tools/fs70_ask.py selftest [--plants]       # the calibration: an ask whose answer is known both ways

PIN: control | forces:DELTA | separated:DELTA   (eq: and sep: are accepted as the aliases of the first two)
options: --single-budget S (default 600) --cube-budget S (900) --jobs N (22) --branch N (auto) --cap-cpu-hours H
         (40) --engine auto|kissat|pysat:NAME (the cube engine) --single-solver PATH (default kissat)
         --out DIR (default build/fs70/asks/<sha>) --resume --no-single --no-cube --note TEXT
"""
from collections import defaultdict
import hashlib
import json
import math
import multiprocessing as mp
import os
import subprocess
import sys
import threading
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs70_fabric as FB                                                         # noqa: E402
import fs70_field as FF                                                          # noqa: E402

K = 4
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ASKS = os.path.join(ROOT, 'data', 'fs70', 'asks.jsonl')
INFLIGHT = os.path.join(ROOT, 'data', 'fs70', 'inflight')
PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- the instance

def var(v, c):
    return K * v + c + 1


def load_graph(d):
    with open(os.path.join(d, 'graph.json')) as fh:
        g = json.load(fh)
    pts = [tuple(p) for p in g['points']]
    edges = [tuple(e) for e in g['edges']]
    meta = g.get('meta', {})
    got = hashlib.sha256(json.dumps(sorted(pts), separators=(',', ':')).encode()).hexdigest()
    want = meta.get('points_sha256')
    if planted('sha_unchecked'):
        want = None                                   # PLANT: the asked graph need not be the recorded one
    if want and got != want:
        raise SystemExit(f'{d}/graph.json: the point set does not match its own points_sha256 '
                         f'({got[:16]} against {want[:16]}) -- the file was edited after it was written')
    return pts, edges, g['M'], meta


def target_vertex(pts, M, spec, delta):
    """the index of the point DELTA (on the real axis, or i sqrt3) in the point set, and its exact 8-tuple"""
    lat = FB.Lattice(FB.generators(spec), spec)
    if lat.M != M:
        raise SystemExit(f'the lattice {spec} has denominator {lat.M}, the graph says {M}')
    z = FB.target_element(delta)
    if lat.coords(z) is None:
        raise SystemExit(f'{delta} is not in the lattice {spec}: it can never be a pair in this fabric')
    v8 = lat.vec8(z)
    idx = {p: i for i, p in enumerate(pts)}
    if v8 not in idx:
        raise SystemExit(f'{delta} = {v8} is in the lattice but not in this point set: grow the shape '
                         f'(the point set has {len(pts)} points)')
    zero = tuple([0] * 8)
    if zero not in idx:
        raise SystemExit('the origin is not in this point set: every ask here is 0 against a target')
    return idx[zero], idx[v8], v8, lat


def adjacency(n, edges):
    adj = [set() for _ in range(n)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    return adj


def build_instance(pts, edges, M, meta, pin):
    """-> dict(n, edges, pins, kind, delta, conclusion, note, vmap) -- vmap[v] is the vertex of the solved instance
    that carries the original vertex v (the identity except under `separated`, where B folds onto A)."""
    kind, _, delta = pin.partition(':')
    kind = {'eq': 'forces', 'sep': 'separated'}.get(kind, kind)
    if kind not in ('control', 'forces', 'separated'):
        raise SystemExit(f'unknown pin {pin!r}: control | forces:DELTA | separated:DELTA')
    n = len(pts)
    spec = meta.get('lattice')
    E = sorted({tuple(sorted(e)) for e in edges})
    if planted('edges_dropped'):
        E = E[:-1]                                    # PLANT: one edge lost -- colouring gets EASIER, so a
                                                      # refusal vanishes and the null looks real (G21's direction)
    if kind == 'control':
        idx = {p: i for i, p in enumerate(pts)}
        tri = [idx.get(tuple([0] * 8)), idx.get(FB.Lattice(FB.generators(spec), spec).vec8(FB.E_ONE)),
               idx.get(FB.Lattice(FB.generators(spec), spec).vec8(FB.ZETA6))]
        adj = adjacency(n, E)
        if None in tri or not (tri[1] in adj[tri[0]] and tri[2] in adj[tri[0]] and tri[2] in adj[tri[1]]):
            tri = first_triangle(n, adj)
            if tri is None:
                raise SystemExit('no triangle in this graph: the control has no clique to pin')
        pins = [(tri[0], 0), (tri[1], 1), (tri[2], 2)]
        return {'n': n, 'edges': E, 'pins': pins, 'kind': kind, 'delta': None, 'vmap': list(range(n)),
                'conclusion': 'the fabric itself is not 4-colourable -- HALT AND VERIFY',
                'note': f'unit triangle {tri} pinned to colours 0, 1, 2'}
    A, B, v8, _ = target_vertex(pts, M, spec, delta)
    adj = adjacency(n, E)
    if kind == 'forces':
        # c(A) != c(B): join the pair by an edge, and pin a triangle on it if the pair has a common neighbour
        if B in adj[A]:
            raise SystemExit(f'0 and {delta} are ALREADY adjacent in this graph (distance 1): '
                             f'"forces" there is the empty statement, not a finding')
        E2 = sorted(set(E) | {tuple(sorted((A, B)))})
        common = sorted(adj[A] & adj[B])
        pins = [(A, 0), (B, 1)] + ([(common[0], 2)] if common else [])
        if planted('pin_swapped'):
            pins = [(A, 0), (B, 0)]                   # PLANT: the `separated` constraint under the `forces` name
        return {'n': n, 'edges': E2, 'pins': pins, 'kind': kind, 'delta': delta, 'vmap': list(range(n)),
                'conclusion': f'Forces: every proper 4-colouring gives 0 and {delta} one colour',
                'note': (f'the pair joined by an edge; ' +
                         (f'common neighbour {common[0]} pinned to colour 2 ({len(common)} common neighbours)'
                          if common else 'no common neighbour, so two colours pinned and the rest broken by '
                                         'precedence'))}
    # separated: c(A) = c(B) -- contract B onto A
    m = {}
    nxt = 0
    for v in range(n):
        if v == B:
            continue
        m[v] = nxt
        nxt += 1
    m[B] = m[A]
    loops = [(a, b) for a, b in E if m[a] == m[b]]
    if loops:
        raise SystemExit(f'contracting 0 and {delta} makes {len(loops)} self-loops: they are adjacent, so '
                         f'"separated" there is the empty statement, not a finding')
    E2 = sorted({tuple(sorted((m[a], m[b]))) for a, b in E})
    adj2 = adjacency(nxt, E2)
    tri = first_triangle_at(m[A], adj2)
    if tri is None:
        tri = first_triangle(nxt, adj2)
    pins = [(tri[0], 0), (tri[1], 1), (tri[2], 2)] if tri else [(m[A], 0)]
    return {'n': nxt, 'edges': E2, 'pins': pins, 'kind': kind, 'delta': delta,
            'vmap': [m[v] for v in range(n)],
            'conclusion': f'Separated: a virtual edge at {delta} (no proper 4-colouring joins 0 and {delta})',
            'note': f'the pair contracted onto vertex {m[A]}; '
                    + (f'triangle {tri} pinned' if tri else 'no triangle: the contracted vertex alone is pinned')}


def first_triangle_at(v, adj):
    for a in sorted(adj[v]):
        c = adj[v] & adj[a]
        if c:
            return (v, a, min(c))
    return None


def first_triangle(n, adj):
    for v in range(n):
        t = first_triangle_at(v, adj)
        if t is not None:
            return t
    return None


def instance_clauses(inst, precedence=None):
    pins = inst['pins']
    if precedence is None:
        precedence = len({c for _, c in pins}) <= K - 2      # a free colour pair is the only residual symmetry
    return FB.coloring_cnf(inst['n'], inst['edges'], K, pins, precedence=precedence), precedence


def instance_sha(pts, inst):
    """the ask's identity (plan section 6): the canonical point set plus the pin"""
    h = hashlib.sha256()
    h.update(json.dumps(sorted(pts), separators=(',', ':')).encode())
    h.update(json.dumps({'kind': inst['kind'], 'delta': inst['delta'],
                         'pins': sorted(inst['pins'])}, separators=(',', ':')).encode())
    return h.hexdigest()[:24]


# ---------------------------------------------------------------- verification of a model

def verify_model(inst, model, pts=None, edges=None):
    """a SAT answer is believed only after the colouring is read back against the graph and the pin"""
    col = {}
    for v in range(inst['n']):
        cs = [c for c in range(K) if model.get(var(v, c), False)]
        if len(cs) != 1:
            return False, f'vertex {v} carries {len(cs)} colours, not exactly one'
        col[v] = cs[0]
    for a, b in inst['edges']:
        if col[a] == col[b]:
            return False, f'edge ({a}, {b}) is monochromatic in the model'
    for v, c in inst['pins']:
        if col[v] != c:
            return False, f'pin ({v}, {c}) is not respected: the model gives {col[v]}'
    if pts is not None and edges is not None:
        # the ORIGINAL graph, through the vertex map: the real statement is about the fabric, not the instance
        vm = inst['vmap']
        for a, b in edges:
            if col[vm[a]] == col[vm[b]]:
                return False, f'original edge ({a}, {b}) is monochromatic through the vertex map'
    return True, col


# ---------------------------------------------------------------- the single-solver attempt

def single_attempt(inst, out, budget, solver='kissat'):
    cl, prec = instance_clauses(inst)
    nv = FB.cnf_nvars(inst['n'], K, inst['pins']) if prec else K * inst['n']
    path = os.path.join(out, 'instance.cnf')
    sha = FB.write_cnf(path, nv, cl)
    t0 = time.time()
    try:
        r = subprocess.run([solver, '-q', f'--time={int(budget)}', path], capture_output=True, text=True,
                           timeout=budget + 60)
        rc = r.returncode
        stdout = r.stdout
    except subprocess.TimeoutExpired:
        rc, stdout = 0, ''
    secs = time.time() - t0
    verdict = 'UNSAT' if rc == 20 else 'SAT' if rc == 10 else 'UNKNOWN'
    model = None
    if verdict == 'SAT':
        lits = []
        for line in stdout.splitlines():
            if line.startswith('v '):
                lits.extend(int(x) for x in line[2:].split())
        model = {abs(x): x > 0 for x in lits if x}
    return verdict, round(secs, 2), sha, model, len(cl), nv


# ---------------------------------------------------------------- the cube pass

_G = {}


def _new_solver(name):
    """PySAT's Kissat IGNORES assumptions (it warns and carries on), so every cube would silently be solved as the
    whole instance -- refused by name here.  PySAT's CaDiCaL takes assumptions but supports neither `incr=True` nor
    `solve_limited`, so it can carry no per-cube budget; that is reported, not worked around.  Both are found HERE,
    in the parent, rather than inside a pool initializer -- an initializer that raises makes the pool retry it for
    ever with no output at all, which is how this cost twenty minutes the first time it was written."""
    from pysat.solvers import Solver
    if 'kissat' in name:
        raise SystemExit(f'the in-process cube engine may not be {name}: Kissat ignores assumptions, so every '
                         f'cube would be solved as the whole instance.  Use the `kissat` FILE engine, or '
                         f'cadical195 / glucose42 in process.')
    return Solver(name=name)


def _limited_ok(name):
    s = _new_solver(name)
    try:
        s.add_clause([1, 2])
        s.solve_limited(assumptions=[1], expect_interrupt=True)
        s.clear_interrupt()
        return True
    except (NotImplementedError, AttributeError):
        return False
    finally:
        s.delete()


def _cube_init(n, edges, pins, engine, budget, body, nv):
    if engine.startswith('pysat:'):
        s = _new_solver(engine[6:])
        for v in range(n):
            s.add_clause([var(v, c) for c in range(K)])
            for c1 in range(K):
                for c2 in range(c1 + 1, K):
                    s.add_clause([-var(v, c1), -var(v, c2)])
        for a, b in edges:
            for c in range(K):
                s.add_clause([-var(a, c), -var(b, c)])
        for v, c in pins:
            s.add_clause([var(v, c)])
        _G['s'] = s
        _G['limited'] = _limited_ok(engine[6:])
    _G['engine'] = engine
    _G['body'] = body
    _G['nv'] = nv


def _cube_solve(job):
    cube, budget, out = job
    t0 = time.time()
    if _G['engine'] == 'kissat':
        tag = 'c' + ''.join(f'{v}-{c}_' for v, c in cube)
        path = os.path.join(out, hashlib.sha256(tag.encode()).hexdigest()[:16] + '.cnf')
        units = ''.join(f'{var(v, c)} 0\n' for v, c in cube)
        with open(path, 'wb') as fh:
            fh.write(f'p cnf {_G["nv"]} {_G["body"][1] + len(cube)}\n'.encode())
            fh.write(_G['body'][0])
            fh.write(units.encode())
        try:
            r = subprocess.run(['kissat', '-q', '-n', f'--time={int(budget)}', path],
                               capture_output=True, text=True, timeout=budget + 120)
            v = 'UNSAT' if r.returncode == 20 else 'SAT' if r.returncode == 10 else 'UNKNOWN'
        except subprocess.TimeoutExpired:
            v = 'UNKNOWN'
        finally:
            if os.path.exists(path):
                os.remove(path)
        return cube, v, round(time.time() - t0, 2), None
    s = _G['s']
    assumptions = [var(v, c) for v, c in cube]
    if _G['limited']:
        timer = threading.Timer(budget, s.interrupt)
        timer.start()
        try:
            res = s.solve_limited(assumptions=assumptions, expect_interrupt=True)
        finally:
            timer.cancel()
            s.clear_interrupt()
    else:
        res = s.solve(assumptions=assumptions)          # no per-cube budget: the engine has no limited solve
    secs = round(time.time() - t0, 2)
    if res is None:
        return cube, 'UNKNOWN', secs, None
    if res:
        m = s.get_model()
        return cube, 'SAT', secs, {abs(x): x > 0 for x in m if x}
    return cube, 'UNSAT', secs, None


def branching_set(inst, nbranch):
    adj = adjacency(inst['n'], inst['edges'])
    pinned = {v for v, _ in inst['pins']}
    return sorted((v for v in range(inst['n']) if v not in pinned), key=lambda v: (-len(adj[v]), v))[:nbranch], adj


def enumerate_cubes(inst, cand, adj):
    """the colour assignments to the branching set that the graph's own edges do not already refute"""
    fixed = {v: c for v, c in inst['pins']}
    cubes = []
    stack = [(0, dict(fixed))]
    while stack:
        i, col = stack.pop()
        if i == len(cand):
            cubes.append(tuple((v, col[v]) for v in cand))
            continue
        v = cand[i]
        for c in range(K):
            if any(col.get(w) == c for w in adj[v]):
                continue
            col2 = dict(col)
            col2[v] = c
            stack.append((i + 1, col2))
    return cubes


CUBE_FILE_CLAUSE_CAP = 4_000_000        # above this the per-cube CNF body is tens of MB and the file engine's
                                        # writing dominates: go in process instead


def choose_engine(inst, engine):
    if engine != 'auto':
        return engine
    ncl = inst['n'] * (1 + K * (K - 1) // 2) + len(inst['edges']) * K
    return 'kissat' if ncl <= CUBE_FILE_CLAUSE_CAP else 'pysat:cadical195'


def cube_pass(inst, out, jobs, budget, nbranch, engine, resume, cap_seconds):
    os.makedirs(out, exist_ok=True)
    engine = choose_engine(inst, engine)
    cand, adj = branching_set(inst, nbranch)
    cubes = enumerate_cubes(inst, cand, adj)
    ledger = os.path.join(out, 'cubes.jsonl')
    done = {}
    if resume and os.path.exists(ledger):
        for line in open(ledger):
            r = json.loads(line)
            if r['verdict'] in ('SAT', 'UNSAT'):
                done[tuple(tuple(x) for x in r['cube'])] = r['verdict']
    todo = [c for c in cubes if c not in done]
    limited = engine == 'kissat' or _limited_ok(engine[6:])
    print(f'  cube pass [{engine}{"" if limited else ", NO per-cube budget: this engine has no limited solve"}]: '
          f'branching on {cand} (degrees {[len(adj[v]) for v in cand]});  '
          f'{len(cubes)} of {K ** len(cand)} cubes survive the branching set\'s own edges, '
          f'{len(done)} already done, {len(todo)} to solve, {jobs} at a time, {budget}s each', flush=True)
    nun = sum(1 for v in done.values() if v == 'UNSAT')
    nsat = sum(1 for v in done.values() if v == 'SAT')
    nunk = 0
    cpu = 0.0
    model = None
    t0 = time.time()
    body = (b'', 0)
    if engine == 'kissat':                          # the base formula's body, written once and reused per cube
        cl, prec = instance_clauses(inst)
        body = (''.join(' '.join(map(str, c)) + ' 0\n' for c in cl).encode(), len(cl))
        nv = FB.cnf_nvars(inst['n'], K, inst['pins']) if prec else K * inst['n']
    else:
        nv = K * inst['n']
        _new_solver(engine[6:]).delete()            # the engine constructs HERE, where an error is visible
    ctx = mp.get_context('fork')                    # python 3.14 defaults to forkserver: the base formula is
    args = (inst['n'], inst['edges'], inst['pins'], engine, budget, body, nv)   # inherited, not re-imported
    with ctx.Pool(processes=min(jobs, max(1, len(todo))), initializer=_cube_init, initargs=args) as pool, \
            open(ledger, 'a') as fh:
        it = pool.imap_unordered(_cube_solve, [(c, budget, out) for c in todo], chunksize=1)
        for i, (cube, v, secs, m) in enumerate(it):
            fh.write(json.dumps({'cube': [list(x) for x in cube], 'verdict': v, 'seconds': secs}) + '\n')
            fh.flush()
            cpu += secs
            nun += v == 'UNSAT'
            nsat += v == 'SAT'
            nunk += v == 'UNKNOWN'
            if v == 'SAT':
                model = m
                print(f'  *** SAT at cube {cube}: the ask is SATISFIABLE.  Stopping the pass.', flush=True)
                pool.terminate()
                break
            if (i + 1) % 25 == 0 or i + 1 == len(todo):
                el = time.time() - t0
                print(f'    {i+1}/{len(todo)}: {nun} UNSAT, {nsat} SAT, {nunk} UNKNOWN; {el:.0f}s wall, '
                      f'{cpu:.0f}s cpu, {el/(i+1)*len(todo):.0f}s projected', flush=True)
            if cap_seconds and cpu > cap_seconds:
                print(f'  the per-ask cap of {cap_seconds/3600:.1f} CPU-hours is spent at cube {i+1}/{len(todo)}; '
                      f'stopping (the ledger resumes)', flush=True)
                nunk += len(todo) - (i + 1)
                pool.terminate()
                break
    verdict = 'SAT' if nsat else ('UNSAT' if nunk == 0 else 'UNKNOWN')
    return verdict, {'cubes_total': len(cubes), 'branch': cand, 'UNSAT': nun, 'SAT': nsat, 'UNKNOWN': nunk,
                     'wall_seconds': round(time.time() - t0, 1), 'cpu_seconds': round(cpu, 1),
                     'engine': engine, 'per_cube_budget': budget if limited else None}, model


# ---------------------------------------------------------------- records

def inflight_path(sha):
    return os.path.join(INFLIGHT, f'{sha}.json')


def write_inflight(sha, rec):
    os.makedirs(INFLIGHT, exist_ok=True)
    with open(inflight_path(sha), 'w') as fh:
        json.dump(rec, fh, indent=1)


def clear_inflight(sha):
    p = inflight_path(sha)
    if os.path.exists(p):
        os.remove(p)


def append_ask(row):
    os.makedirs(os.path.dirname(ASKS), exist_ok=True)
    with open(ASKS, 'a') as fh:
        fh.write(json.dumps(row, separators=(',', ':')) + '\n')


# ---------------------------------------------------------------- run

def cmd_run(argv):
    d = argv[0]
    pin = argv[1]
    single_budget = _opt(argv, '--single-budget', 600, int)
    cube_budget = _opt(argv, '--cube-budget', 900, int)
    jobs = _opt(argv, '--jobs', 22, int)
    cap = _opt(argv, '--cap-cpu-hours', 40.0, float) * 3600
    engine = _opt(argv, '--engine', 'auto')
    single_solver = _opt(argv, '--single-solver', 'kissat')
    nbranch = _opt(argv, '--branch', 0, int)
    note = _opt(argv, '--note', '')
    resume = '--resume' in argv
    pts, edges, M, meta = load_graph(d)
    inst = build_instance(pts, edges, M, meta, pin)
    sha = instance_sha(pts, inst)
    out = _opt(argv, '--out', os.path.join(ROOT, 'build', 'fs70', 'asks', sha))
    os.makedirs(out, exist_ok=True)
    deg = 2 * len(edges) / max(1, len(pts))
    print(f'== ask {sha}  [{meta.get("lattice")}  {meta.get("shape")}]')
    print(f'   fabric: {len(pts)} points, {len(edges)} edges, average degree {deg:.2f}')
    print(f'   pin: {inst["kind"]}' + (f' {inst["delta"]}' if inst['delta'] else '') + f' -- {inst["note"]}')
    print(f'   UNSAT would mean: {inst["conclusion"]}')
    print(f'   instance: {inst["n"]} vertices, {len(inst["edges"])} edges, pins {inst["pins"]}')
    print(f'   out: {out}', flush=True)
    t_start = time.time()
    row = {'verdict': None, 'lattice': meta.get('lattice'), 'lattice_sha': meta.get('lattice_sha'),
           'shape': meta.get('shape'), 'points': len(pts), 'edges': len(edges), 'avg_degree': round(deg, 3),
           'pin': {'kind': inst['kind'], 'delta': inst['delta'], 'pins': inst['pins'], 'note': inst['note']},
           'conclusion_if_unsat': inst['conclusion'], 'sha': sha, 'graph_dir': os.path.relpath(d, ROOT),
           'out': os.path.relpath(out, ROOT), 'note': note,
           'instance': {'vertices': inst['n'], 'edges': len(inst['edges'])}}
    write_inflight(sha, {'sha': sha, 'graph_dir': os.path.relpath(d, ROOT), 'pin': pin, 'out': os.path.relpath(out, ROOT),
                         'pid': os.getpid(), 'pgid': os.getpgid(0), 'started': time.time(),
                         'ledger': os.path.relpath(os.path.join(out, 'cubes.jsonl'), ROOT),
                         'resume': f'python3 tools/fs70_ask.py run {os.path.relpath(d, ROOT)} {pin} '
                                   f'--out {os.path.relpath(out, ROOT)} --resume'})
    with open(os.path.join(out, 'pgid'), 'w') as fh:
        fh.write(str(os.getpgid(0)) + '\n')
    verdict, model = 'UNKNOWN', None
    if '--no-single' not in argv:
        v, secs, csha, model, ncl, nv = single_attempt(inst, out, single_budget, single_solver)
        row['single'] = {'solver': single_solver, 'budget': single_budget, 'verdict': v, 'seconds': secs,
                         'cnf_sha256': csha, 'clauses': ncl, 'variables': nv}
        print(f'   single solver ({single_solver}, {single_budget}s): {v} in {secs}s '
              f'[{ncl} clauses, {nv} variables, cnf {csha}]', flush=True)
        verdict = v
    if verdict == 'UNKNOWN' and '--no-cube' not in argv:
        nb = nbranch or default_branch(inst)
        verdict, cinfo, cmodel = cube_pass(inst, out, jobs, cube_budget, nb, engine, resume,
                                           cap - (time.time() - t_start))
        row['cube'] = cinfo
        model = cmodel or model
        print(f'   cube pass: {verdict}  ({cinfo["UNSAT"]} UNSAT, {cinfo["SAT"]} SAT, {cinfo["UNKNOWN"]} UNKNOWN '
              f'of {cinfo["cubes_total"]}; {cinfo["wall_seconds"]}s wall, {cinfo["cpu_seconds"]}s cpu)', flush=True)
    row['verdict'] = verdict
    row['wall_seconds'] = round(time.time() - t_start, 1)
    if verdict == 'SAT':
        if model is None:
            row['model'] = 'not captured'
        else:
            ok, res = verify_model(inst, model, pts, edges)
            row['model_verified'] = bool(ok)
            if not ok:
                row['verdict'] = verdict = 'DEFECT'
                row['model_error'] = res
                print(f'   *** the model does NOT verify: {res} -- this is a defect in the tool, not a finding')
            else:
                colpath = os.path.join(out, 'colouring.json')
                with open(colpath, 'w') as fh:
                    json.dump({'sha': sha, 'vmap': inst['vmap'],
                               'colour': [res[inst['vmap'][v]] for v in range(len(pts))]}, fh)
                row['colouring'] = os.path.relpath(colpath, ROOT)
                print(f'   model verified proper on all {len(edges)} fabric edges and on the pin; '
                      f'colouring written to {colpath}')
    if verdict == 'UNSAT':
        print(f'   *** REFUSED.  {inst["conclusion"]}')
        print(f'   *** HALT the sweep and verify (brief: rebuild in a fresh process, re-derive the edges, '
              f're-ask with a second solver, check the pin).')
    append_ask(row)
    clear_inflight(sha)
    print(f'   row appended to data/fs70/asks.jsonl;  verdict {verdict};  {row["wall_seconds"]}s wall')
    return row


def default_branch(inst):
    """enough cubes to fill the cores several times over, few enough that the enumeration is instant.  Phase 0's
    control needed 1,458 cubes from 7 branch vertices on 740 points; 8 gives ~4x that."""
    return 7 if inst['n'] < 3000 else 8


def cmd_resume(argv):
    if not os.path.isdir(INFLIGHT):
        print('no in-flight directory')
        return
    files = [f for f in sorted(os.listdir(INFLIGHT)) if f.endswith('.json')]
    if not files:
        print('nothing in flight')
        return
    for f in files:
        rec = json.load(open(os.path.join(INFLIGHT, f)))
        print(f'resuming {rec["sha"]}: {rec["resume"]}', flush=True)
        cmd_run([os.path.join(ROOT, rec['graph_dir']), rec['pin'], '--out', os.path.join(ROOT, rec['out']),
                 '--resume'] + argv)


def cmd_status(argv):
    if not os.path.exists(ASKS):
        print('no asks yet')
        return
    rows = [json.loads(l) for l in open(ASKS)]
    by = defaultdict(list)
    for r in rows:
        by[r['lattice']].append(r)
    for lat in sorted(by):
        print(f'== {lat}')
        print(f'  {"shape":28} {"points":>8} {"edges":>9} {"deg":>6} {"pin":>18} {"verdict":>8} {"wall s":>9}')
        for r in by[lat]:
            sh = r['shape']
            shape = f'{sh.get("shape")}' + (f' k={sh["k"]}' if 'k' in sh else '') + \
                    (f' n={sh["n"]}' if 'n' in sh else '') + (f' R={sh["R"]}' if 'R' in sh else '') + \
                    (f' core={sh["core"]}' if sh.get('core') else '')
            pin = r['pin']['kind'] + (f' {r["pin"]["delta"]}' if r['pin']['delta'] else '')
            print(f'  {shape:28} {r["points"]:8d} {r["edges"]:9d} {r["avg_degree"]:6.2f} {pin:>18} '
                  f'{r["verdict"]:>8} {r.get("wall_seconds", 0):9.1f}')
        print()
    print(f'{len(rows)} asks; ' + ', '.join(f'{v} {sum(1 for r in rows if r["verdict"] == v)}'
                                            for v in ('SAT', 'UNSAT', 'UNKNOWN', 'DEFECT')))


# ---------------------------------------------------------------- the calibration (selftest)

def calibration_graphs(tmp):
    """Two abstract graphs whose answers are known by hand, written in the fabric's own graph.json shape.

    K5 minus an edge: A and B non-adjacent, both joined to a triangle x, y, z.  Every proper 4-colouring gives
    x, y, z three colours and A, B the fourth, so c(A) = c(B) is FORCED -- `forces` must refuse and `separated`
    must colour.  The faithful twin drops one triangle edge (x--y), and then A and B can differ: `forces` must
    colour.  Both graphs also need a triangle for the pins, which they have.

    The points are the origin and the target 4/3 over `group:u3:2` plus three filler lattice points, so the file
    parses exactly as a fabric graph does; the GEOMETRY is deliberately not unit-distance -- this calibrates the
    encoder and the solvers, not the fabric (a unit-distance graph cannot contain K5 minus an edge at all, since
    two points have at most two common unit-distance neighbours)."""
    lat = FB.Lattice(FB.generators('group:u3:2'), 'group:u3:2')
    zero = tuple([0] * 8)
    B = lat.vec8(FB.target_element('4/3'))
    fill = [lat.vec8(z) for z in (FB.E_ONE, FB.ZETA6, FB.ZETA12)]
    pts = [zero, B] + fill                      # 0 = A, 1 = B, 2..4 = the triangle
    tri = [(2, 3), (2, 4), (3, 4)]
    full = sorted(set(tri) | {(0, 2), (0, 3), (0, 4), (1, 2), (1, 3), (1, 4)})
    twin = sorted(set(full) - {(2, 3)})
    out = {}
    for name, E in (('forced', full), ('twin', twin)):
        d = os.path.join(tmp, name)
        os.makedirs(d, exist_ok=True)
        meta = {'lattice': 'group:u3:2', 'lattice_sha': lat.sha(), 'M': lat.M,
                'shape': {'shape': 'calibration', 'which': name}, 'points': len(pts), 'edges': len(E),
                'avg_degree': 2 * len(E) / len(pts),
                'points_sha256': hashlib.sha256(json.dumps(sorted(pts), separators=(',', ':')).encode()).hexdigest()}
        with open(os.path.join(d, 'graph.json'), 'w') as fh:
            json.dump({'meta': meta, 'M': lat.M, 'points': [list(p) for p in pts],
                       'edges': [list(e) for e in E]}, fh)
        out[name] = d
    return out


def selftest():
    import tempfile
    with tempfile.TemporaryDirectory() as tmp:
        gs = calibration_graphs(tmp)
        results = {}
        for which, pin, want in (('forced', 'forces:4/3', 'UNSAT'), ('forced', 'separated:4/3', 'SAT'),
                                 ('twin', 'forces:4/3', 'SAT'), ('forced', 'control', 'SAT')):
            pts, edges, M, meta = load_graph(gs[which])
            inst = build_instance(pts, edges, M, meta, pin)
            out = os.path.join(tmp, f'{which}-{pin.replace(":", "-").replace("/", "over")}')
            os.makedirs(out, exist_ok=True)
            v, secs, sha, model, ncl, nv = single_attempt(inst, out, 60)
            results[(which, pin)] = v
            assert v == want, (f'the calibration failed: {which} under {pin} read {v}, and by hand it is {want}.  '
                               f'K5 minus an edge forces its two non-adjacent vertices equal at four colours; '
                               f'dropping one triangle edge frees them.')
            if v == 'SAT':
                ok, res = verify_model(inst, model, pts, edges)
                assert ok, f'{which}/{pin}: the model does not verify: {res}'
        # the two pins really are one literal apart and give OPPOSITE verdicts on the same graph
        assert results[('forced', 'forces:4/3')] == 'UNSAT' and results[('forced', 'separated:4/3')] == 'SAT', \
            'forces and separated read the same on a graph where they must differ: the pins are swapped'
        # the cube pass must reproduce the single solver's refusal
        pts, edges, M, meta = load_graph(gs['forced'])
        inst = build_instance(pts, edges, M, meta, 'forces:4/3')
        out = os.path.join(tmp, 'cube')
        os.makedirs(out, exist_ok=True)
        v, info, _ = cube_pass(inst, out, 2, 30, 1, 'kissat', False, 0)
        assert v == 'UNSAT', f'the file cube engine read {v} where the single solver read UNSAT'
        v, info, _ = cube_pass(inst, os.path.join(tmp, 'cube2'), 2, 30, 1, 'pysat:cadical195', False, 0)
        assert v == 'UNSAT', f'the cube pass read {v} where the single solver read UNSAT'
        assert info['UNSAT'] == info['cubes_total'], info
        # a real fabric ask, small: the origin and 4/3 on the S2 word ball k = 2 must COLOUR (the residue
        # colouring at 2 exists on this lattice, so a refusal here would be a defect)
        lat, keys, E = FB.cmd_word('group:u3:2', 2, os.path.join(tmp, 'w2'), '4/3', None, 'b', cnfs_too=False)
        pts, edges, M, meta = load_graph(os.path.join(tmp, 'w2'))
        assert len(pts) == 1801 and len(edges) == 6900, (len(pts), len(edges))
        inst = build_instance(pts, edges, M, meta, 'forces:4/3')
        assert inst['pins'][0][1] == 0 and inst['pins'][1][1] == 1, inst['pins']
        v, secs, sha, model, ncl, nv = single_attempt(inst, os.path.join(tmp, 'w2'), 120)
        assert v == 'SAT', f'the S2 word ball k = 2 refused c(0) != c(4/3): {v} -- the plan pilots say SAT'
        ok, res = verify_model(inst, model, pts, edges)
        assert ok, res
        # the graph file's own point hash is checked: a point moved after the file was written must be refused
        import shutil
        bad = os.path.join(tmp, 'moved')
        shutil.copytree(os.path.join(tmp, 'w2'), bad)
        gj = json.load(open(os.path.join(bad, 'graph.json')))
        gj['points'][5] = [x + 1 for x in gj['points'][5]]
        json.dump(gj, open(os.path.join(bad, 'graph.json'), 'w'))
        try:
            load_graph(bad)
        except SystemExit as e:
            assert 'points_sha256' in str(e), str(e)
        else:
            raise AssertionError('a point moved after the file was written was accepted: the graph asked is not '
                                 'known to be the graph recorded')
        # and the identity sha is a function of the point set and the pin, not of the spelling
        s1 = instance_sha(pts, inst)
        s2 = instance_sha(list(reversed(pts)), inst)
        assert s1 == s2, 'the ask identity depends on the order of the point list'
    print('fs70_ask selftest OK')
    print('  calibration: K5 minus an edge refuses `forces` and colours `separated`; the twin colours both')
    print('  the cube pass reproduces the refusal; the S2 word ball k = 2 colours c(0) != c(4/3) as the plan says')


PLANTS = ('pin_swapped', 'edges_dropped', 'sha_unchecked')


def run_plants():
    print('--- faithful twin')
    selftest()
    ok = True
    for name in PLANTS:
        print(f'--- plant {name}: the self-test must fail')
        r = subprocess.run([sys.executable, __file__, 'selftest', '--plant', name], capture_output=True, text=True)
        if r.returncode == 0:
            print(f'    NOT REFUSED -- plant {name} left the self-test green: the check is blind')
            ok = False
        else:
            print(f'    refused (exit {r.returncode}): {(r.stderr.strip().split(chr(10)) or [""])[-1][:190]}')
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print('the plant fired; faithful twin green')


# ---------------------------------------------------------------- main

def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


if __name__ == '__main__':
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = _opt(argv, '--plant')
        if PLANT not in PLANTS:
            raise SystemExit(f'unknown plant {PLANT}; known: {", ".join(PLANTS)}')
    if not argv:
        print(__doc__)
    elif argv[0] == 'run':
        cmd_run(argv[1:])
    elif argv[0] == 'resume':
        cmd_resume(argv[1:])
    elif argv[0] == 'status':
        cmd_status(argv[1:])
    elif argv[0] == 'selftest':
        run_plants() if '--plants' in argv else selftest()
    else:
        raise SystemExit(f'unknown command {argv[0]!r}; see --help / no arguments for the grammar')
