#!/usr/bin/env python3
"""fs73_certify -- FS-73 P1: certify a four-colour forcing refusal on de Grey's lattice by shrinking the PROOF, not the ball (G65, the
FS-58/FS-61 recipe: refuse on a dense ball, then assumption-core rounds to a fixpoint, then the certificate on what the proof touches).

The object.  Lambda = de Grey's lattice over K = Q(sqrt3, sqrt11) (tools/fs73_lattice.py), U its 54 unit vectors, a target delta in
Lambda.  A refusal: a finite induced subgraph G of Cay(Lambda, U) containing 0 and delta such that G plus the one extra edge {0, delta}
is not 4-colourable; then every proper 4-colouring of G, hence of Cay(Lambda, U), gives 0 and delta one colour (OneDefect.lean's
`forces_of_not_colorable_append_single` is the kernel form).

Commands (run from the repository root or tools/):
  rounds K --target T --R R [--budget S] [--resume]
      rebuild the recorded refusal's graph exactly as fs73_screen.py's `force K` built it (the Minkowski ball of radius R, its 4-core
      with the pair kept, shifted so the pair is (0, delta)) and ASSERT its CNF's sha256 equals the refusal row in K-rows.jsonl (so the
      rounds start from the object on record); then assumption-core rounds: CaDiCaL 1.9.5 (pysat) with one selector per UNPINNED vertex
      guarding its at-least-one clause (the pinned pair and pinned common neighbour are never selectable, so a pin can never keep a
      dropped vertex's constraints alive), the forcing CNF's pins and value precedence exactly as graph_cnf writes them; the failed
      assumptions plus the pinned vertices are the next kept set; to a fixpoint.  One row per round, fsynced, in OUT/steps.jsonl with the
      kept vertices' lattice coordinates; a kill redoes the one round in flight.  Every round's solve runs under the shared heavy lock.
      Soundness of a round: with the unselected vertices given no colour, the formula is exactly the kept set's induced forcing CNF (the
      precedence chain restricted to the kept order), so UNSAT under the core's assumptions is UNSAT of the induced subgraph on the
      core; the certificate below never relies on this -- it is re-solved from the kept list alone.
  emit K --target T --R R
      the certificate from the last round (or the deletion stage): OUT/witness.json (points as integer 4-vectors Z with the point Z/9,
      Z in O_E = Z<1, zeta6, w, zeta6 w>, w = (1 + sqrt-11)/2; the edge list re-derived exactly; the pair and the pinned clique),
      OUT/witness.cnf.gz (the CNF the checker rebuilds: at-least-one per vertex, four clauses per edge INCLUDING the extra edge
      {0, delta}, then the clique pin -- the pair and, when one exists, a common neighbour, to colours 0, 1, 2; no other symmetry break),
      OUT/witness.lrat.gz (the toolchain CaDiCaL's text LRAT for exactly that CNF), and the rechecks: kissat on the identical CNF, and
      kissat on the pin-free CNF.  The standalone checker is tools/fs73_cert_check.py.
  delete K --target T --R R [--budget S]
      optional: from the fixpoint, deletion toward 1-minimal (Glucose4, failed-assumption cores), checkpointed every 60 s.

Targets: 'c:a,b,c,d' (lattice coordinates in fs73_lattice's reduced Hermite basis) or a rational 'p/q'.
"""
import gzip
import hashlib
import json
import os
import resource
import shutil
import subprocess
import sys
import threading
import time

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs73_lattice as FL                                                     # noqa: E402
import fs73_screen as S                                                       # noqa: E402

CERT = os.path.join(ROOT, 'data', 'fs73', 'census', 'cert')
CADICAL = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical')
# (1/9) O_E in Lambda's coordinates (verified: integer, determinant -1, so Lambda = Z<1, zeta6, w, zeta6 w>/9); rows = 1, zeta6, w, zeta6 w
OE_IN_LAMBDA = ((4, -2, -2, -1), (2, -1, 0, -1), (2, -1, -1, 0), (1, -1, 0, 0))


def cpu_self():
    ru = resource.getrusage(resource.RUSAGE_SELF)
    return ru.ru_utime + ru.ru_stime


def outdir(delta, R):
    return os.path.join(CERT, f't{"_".join(map(str, delta))}-R{R}')


def build(target, R, require_row=True):
    """the refusal's graph exactly as `fs73_screen.py force K` built it; returns (lat, U, delta, points, E, pins, row)"""
    lat, r, T = S.degrey_setup()
    U = lat.U
    delta = S.parse_target(lat, target)
    assert delta is not None and any(delta), f'{target}: not a nonzero lattice vector'
    half = tuple(x // 2 for x in delta) if all(x % 2 == 0 for x in delta) else None
    pts = S.minkowski_ball(lat, R)
    idx, E = S.ball_graph(pts, U)
    a, b = (tuple(-x for x in half), half) if half else (tuple([0] * r), delta)
    keep = S.core(len(pts), E, 4, keep=(idx[a], idx[b]))
    shifted = [tuple(x - y for x, y in zip(pts[i], a)) for i in keep]
    idx2, E2 = S.ball_graph(shifted, U)
    n = len(shifted)
    o, dl = idx2[tuple([0] * r)], idx2[delta]
    adj0 = set(E2[E2[:, 0] == o, 1].tolist()) | set(E2[E2[:, 1] == o, 0].tolist())
    adjd = set(E2[E2[:, 0] == dl, 1].tolist()) | set(E2[E2[:, 1] == dl, 0].tolist())
    common = sorted(adj0 & adjd)
    pins = [(o, 0), (dl, 1)] + ([(common[0], 2)] if common else [])
    parts, nv = S.graph_cnf(n, E2, pins)
    os.makedirs(S.SCRATCH, exist_ok=True)
    tmp = os.path.join(S.SCRATCH, f'build-{os.getpid()}.cnf')
    sha, _ = S.write_cnf(tmp, n, parts, nv)
    os.remove(tmp)
    rows = S.Rows(os.path.join(S.CENSUS, 'K-rows.jsonl'))
    key = f'force:{",".join(map(str, delta))}:R{R}'
    row = rows.get(key)
    if require_row:
        assert row is not None and row['forces']['verdict'] == 'UNSAT', f'{key}: no recorded refusal'
        assert row['forces']['cnf_sha256'] == sha, f'{key}: the rebuilt CNF {sha[:12]} is not the recorded one {row["forces"]["cnf_sha256"][:12]}'
    return lat, U, delta, shifted, E2, pins, row, sha


def record(path, obj):
    with open(path, 'a') as f:
        f.write(json.dumps(obj, separators=(',', ':')) + '\n')
        f.flush()
        os.fsync(f.fileno())


def read_steps(path):
    return [json.loads(ln) for ln in open(path)] if os.path.exists(path) else []


def assumption_round(kept, E, pins, budget, solver_name='Cadical195'):
    """one assumption-core round on the induced subgraph over `kept` (sorted vertex ids; every pinned vertex in it).  Returns
    (verdict, new kept list or None, stats)"""
    from pysat import solvers as PS
    kept = sorted(kept)
    loc = {v: i for i, v in enumerate(kept)}
    m = len(kept)
    pinned = {v for v, _ in pins}
    assert pinned <= set(kept), 'a pinned vertex left the kept set'
    kset = np.zeros(max(max(kept), int(E.max())) + 1, dtype=bool)
    kset[kept] = True
    Ek = E[kset[E[:, 0]] & kset[E[:, 1]]]
    lk = np.full(len(kset), -1, dtype=np.int64)
    lk[kept] = np.arange(m)
    Ek = lk[Ek]
    x = lambda i, c: 4 * i + c + 1
    nv = 4 * m
    sel = {}
    cls = []
    for i, v in enumerate(kept):
        if v in pinned:
            cls.append([x(i, c) for c in range(4)])
        else:
            nv += 1
            sel[nv] = v
            cls.append([-nv] + [x(i, c) for c in range(4)])
    for c in range(4):
        cls += np.stack([-(4 * Ek[:, 0] + c + 1), -(4 * Ek[:, 1] + c + 1)], axis=1).tolist()
    cls += [[x(loc[v], c)] for v, c in pins]
    free = [c for c in range(4) if c not in {c_ for _, c_ in pins}]
    for f1, f2 in zip(free, free[1:]):                # graph_cnf's value precedence, over the kept order
        base = nv
        nv += m + 1
        s = lambda i: base + i + 1
        cls.append([-s(0)])
        for i in range(m):
            cls.append([-x(i, f2), s(i)])
            cls.append([-s(i + 1), s(i), x(i, f1)])
    sv = getattr(PS, solver_name)(bootstrap_with=cls)
    assumptions = sorted(sel)
    timer = threading.Timer(budget, sv.interrupt)
    with S.HeavyLock(True):
        t0, c0 = time.time(), cpu_self()
        timer.start()
        res = sv.solve_limited(assumptions=assumptions, expect_interrupt=True)
        timer.cancel()
        wall, cpu = time.time() - t0, cpu_self() - c0
    stats = {'points_in': m, 'edges_in': int(len(Ek)), 'solver': f'pysat {solver_name}', 'wall_s': round(wall, 2), 'cpu_s': round(cpu, 2),
             'budget_s': budget, 'machine': S.MACHINE}
    if res is None:
        sv.delete()
        return 'UNKNOWN', None, stats
    if res:
        sv.delete()
        return 'SAT', None, stats
    core = sv.get_core() or []
    sv.delete()
    new = sorted(pinned | {sel[a] for a in core})
    return 'UNSAT', new, stats


def cmd_rounds(target, R, budget, resume):
    lat, U, delta, pts, E, pins, row, sha = build(target, R)
    od = outdir(delta, R)
    os.makedirs(od, exist_ok=True)
    stp = os.path.join(od, 'steps.jsonl')
    done = read_steps(stp)
    if done and not resume:
        raise SystemExit(f'{stp} exists; pass --resume')
    if not done:
        record(stp, {'step': 'start', 'target': target, 'delta': list(delta), 'R': R, 'points': len(pts), 'edges': int(len(E)),
                     'pins': [[list(pts[v]), c] for v, c in pins], 'refusal_row': row['key'], 'cnf_sha256': sha,
                     'refusal': {k: row['forces'][k] for k in ('verdict', 'solver', 'cpu_s', 'wall_s')}})
    key = {p: i for i, p in enumerate(pts)}
    rounds = [d for d in done if d['step'].startswith('core-round-')]
    kept = [key[tuple(p)] for p in rounds[-1]['kept']] if rounds else list(range(len(pts)))
    fix = bool(rounds) and rounds[-1]['points_out'] == rounds[-1]['points_in']
    k = len(rounds)
    print(f'rounds {target} R={R}: {len(pts)} points, {len(E)} edges; resuming at round {k} with {len(kept)} kept', flush=True)
    while not fix:
        v, new, st = assumption_round(kept, E, pins, budget)
        rec = {'step': f'core-round-{k}', 'verdict': v, **st}
        if v != 'UNSAT':
            record(stp, rec)
            print(f'  round {k}: {v} on {len(kept)} points ({st["cpu_s"]} s CPU) -- stopping', flush=True)
            return 1 if v == 'SAT' else 2
        rec.update({'points_out': len(new), 'kept': [list(pts[i]) for i in new]})
        record(stp, rec)
        print(f'  round {k}: {len(kept)} -> {len(new)} points, UNSAT ({st["cpu_s"]} s CPU, {st["wall_s"]} s wall)', flush=True)
        fix = len(new) == len(kept)
        kept = new
        k += 1
    print(f'  fixpoint: {len(kept)} points', flush=True)
    return 0


def cmd_delete(target, R, budget):
    """deletion toward 1-minimal from the last kept set: each unpinned vertex in turn (outermost first by Minkowski norm), asked with
    Glucose4 under assumptions; an UNSAT answer replaces the kept set by its failed-assumption core.  Checkpointed every 60 s."""
    from pysat.solvers import Glucose4
    lat, U, delta, pts, E, pins, row, sha = build(target, R)
    od = outdir(delta, R)
    stp = os.path.join(od, 'steps.jsonl')
    done = read_steps(stp)
    rounds = [d for d in done if d['step'].startswith('core-round-') and d['verdict'] == 'UNSAT']
    assert rounds and rounds[-1]['points_out'] == rounds[-1]['points_in'], 'run the rounds to a fixpoint first'
    key = {p: i for i, p in enumerate(pts)}
    dels = [d for d in done if d['step'] == 'deletion']
    if dels and dels[-1]['finished']:
        print(f'deletion finished already: {len(dels[-1]["kept"])} points', flush=True)
        return 0
    start = [key[tuple(p)] for p in rounds[-1]['kept']]
    cur = set(key[tuple(p)] for p in dels[-1]['kept']) if dels else set(start)
    pos = dels[-1]['position'] if dels else 0
    ks = sorted(start)
    loc = {v: i for i, v in enumerate(ks)}
    m = len(ks)
    pinned = {v for v, _ in pins}
    x = lambda i, c: 4 * i + c + 1
    g = Glucose4()
    nv = 4 * m
    sel, selof = {}, {}
    for i, v in enumerate(ks):
        if v in pinned:
            g.add_clause([x(i, c) for c in range(4)])
        else:
            nv += 1
            sel[nv], selof[v] = v, nv
            g.add_clause([-nv] + [x(i, c) for c in range(4)])
    kset = set(ks)
    for a, b in E.tolist():
        if a in kset and b in kset:
            for c in range(4):
                g.add_clause([-x(loc[a], c), -x(loc[b], c)])
    for v, c in pins:
        g.add_clause([x(loc[v], c)])
    free = [c for c in range(4) if c not in {c_ for _, c_ in pins}]
    for f1, f2 in zip(free, free[1:]):
        base = nv
        nv += m + 1
        s = lambda i: base + i + 1
        g.add_clause([-s(0)])
        for i in range(m):
            g.add_clause([-x(i, f2), s(i)])
            g.add_clause([-s(i + 1), s(i), x(i, f1)])
    Hf = np.array(lat.H, dtype=float) / lat.M
    norm = lambda v: float(np.abs(np.array(pts[v], dtype=float) @ Hf).sum())
    order = sorted((v for v in ks if v not in pinned), key=lambda v: (-norm(v), v))
    last = time.time()
    t0, c0 = time.time(), cpu_self()
    with S.HeavyLock(True):
        for j in range(pos, len(order)):
            v = order[j]
            if v in cur:
                ok = g.solve(assumptions=[selof[u] for u in sorted(cur - {v} - pinned)])
                if not ok:
                    cur = pinned | {sel[a] for a in g.get_core()}
            if time.time() - last > 60 or j == len(order) - 1:
                fin = j == len(order) - 1
                record(stp, {'step': 'deletion', 'position': j + 1, 'finished': fin, 'points': len(cur),
                             'cpu_s': round(cpu_self() - c0, 1), 'wall_s': round(time.time() - t0, 1),
                             'kept': [list(pts[u]) for u in sorted(cur)]})
                print(f'  deletion {j + 1}/{len(order)}: {len(cur)} kept', flush=True)
                last = time.time()
    g.delete()
    return 0


# ---------------------------------------------------------------- the certificate

def to_oe(c):
    """lattice coordinates -> Z in O_E (on 1, zeta6, w, zeta6 w) with the point Z/9"""
    A = np.array(OE_IN_LAMBDA, dtype=np.int64)       # rows: the O_E/9 basis in Lambda coordinates; Z A = c
    Ai = np.round(np.linalg.inv(A.astype(float))).astype(np.int64)
    assert (A @ Ai == np.eye(4, dtype=np.int64)).all()
    z = np.array(c, dtype=np.int64) @ Ai
    assert (z @ A == np.array(c)).all()
    return [int(t) for t in z]


def oe_mul(p, q):
    """(a + b z + c w + d z w)(...) with z^2 = z - 1, w^2 = w - 3 (z = zeta6, w = (1 + sqrt-11)/2)"""
    def zmul(a, b):                                   # Z[z]: (a0 + a1 z)(b0 + b1 z)
        return (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0] + a[1] * b[1])
    A0, A1 = (p[0], p[1]), (p[2], p[3])               # p = A0 + A1 w
    B0, B1 = (q[0], q[1]), (q[2], q[3])
    c0 = zmul(A0, B0)
    c1a, c1b = zmul(A0, B1), zmul(A1, B0)
    c2 = zmul(A1, B1)                                  # times w^2 = w - 3
    r0 = (c0[0] - 3 * c2[0], c0[1] - 3 * c2[1])
    r1 = (c1a[0] + c1b[0] + c2[0], c1a[1] + c1b[1] + c2[1])
    return (r0[0], r0[1], r1[0], r1[1])


def oe_conj(p):
    """complex conjugation: z -> 1 - z, w -> 1 - w"""
    a, b, c, d = p
    # a + b(1 - z) + c(1 - w) + d(1 - z)(1 - w) = (a + b + c + d) + (-b - d) z + (-c - d) w + d z w
    return (a + b + c + d, -b - d, -c - d, d)


def emit_cnf(n, edges, pins, with_pins=True):
    """DIMACS text: at-least-one per vertex; per edge (i < j, sorted, the extra edge included) four clauses; then the pins"""
    lines = [f'p cnf {4 * n} {n + 4 * len(edges) + (len(pins) if with_pins else 0)}']
    lines += [f'{4 * v + 1} {4 * v + 2} {4 * v + 3} {4 * v + 4} 0' for v in range(n)]
    for i, j in edges:
        lines += [f'-{4 * i + c + 1} -{4 * j + c + 1} 0' for c in range(4)]
    if with_pins:
        lines += [f'{4 * v + c + 1} 0' for v, c in pins]
    return '\n'.join(lines) + '\n'


def run_solver(cmd, budget):
    t0 = time.time()
    ru0 = os.times()
    with S.HeavyLock(True):
        try:
            pr = subprocess.run(cmd, capture_output=True, text=True, timeout=budget)
            v, sline = S.sline_verdict(pr.stdout, pr.returncode)
        except subprocess.TimeoutExpired:
            v, sline = 'UNKNOWN', None
    ru1 = os.times()
    return {'verdict': v, 'wall_s': round(time.time() - t0, 2),
            'cpu_s': round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2),
            **({'unknown_type': f'budget {budget} s' if sline is None else sline} if v == 'UNKNOWN' else {})}


def cmd_emit(target, R, budget):
    lat, U, delta, pts, E, pins, row, sha = build(target, R)
    od = outdir(delta, R)
    stp = os.path.join(od, 'steps.jsonl')
    done = read_steps(stp)
    dels = [d for d in done if d['step'] == 'deletion' and d['finished']]
    rounds = [d for d in done if d['step'].startswith('core-round-') and d['verdict'] == 'UNSAT']
    src = dels[-1] if dels else rounds[-1]
    kept = sorted(tuple(p) for p in src['kept'])
    r = len(delta)
    zero = tuple([0] * r)
    assert zero in kept and tuple(delta) in kept
    # the certificate's own vertex order: lexicographic in lattice coordinates; edges re-derived from U over the kept list ALONE
    idx = {p: i for i, p in enumerate(kept)}
    uedges = sorted({(min(i, idx[q]), max(i, idx[q])) for i, p in enumerate(kept) for u in U
                     for q in [tuple(a + b for a, b in zip(p, u))] if q in idx})
    a, b = idx[zero], idx[tuple(delta)]
    assert (min(a, b), max(a, b)) not in uedges, 'the pair is already a unit edge'
    nb = lambda v: {j for i, j in uedges if i == v} | {i for i, j in uedges if j == v}
    common = sorted(nb(a) & nb(b))
    pin_list = [(a, 0), (b, 1)] + ([(common[0], 2)] if common else [])
    edges = sorted(uedges + [(min(a, b), max(a, b))])
    n = len(kept)
    cnf = emit_cnf(n, edges, pin_list)
    cnf_free = emit_cnf(n, edges, pin_list, with_pins=False)
    csha = hashlib.sha256(cnf.encode()).hexdigest()
    os.makedirs(S.SCRATCH, exist_ok=True)
    cpath = os.path.join(S.SCRATCH, 'witness.cnf')
    fpath = os.path.join(S.SCRATCH, 'witness-free.cnf')
    lpath = os.path.join(S.SCRATCH, 'witness.lrat')
    open(cpath, 'w').write(cnf)
    open(fpath, 'w').write(cnf_free)
    print(f'emit {target} R={R}: {n} points, {len(uedges)} unit edges + the pair edge; pins {len(pin_list)} '
          f'(from {"deletion" if dels else rounds[-1]["step"]}); CNF sha {csha[:16]}', flush=True)
    res = {'lrat': run_solver([CADICAL, '-q', '--lrat=true', '--binary=false', cpath, lpath], budget)}
    print(f'  cadical --lrat: {res["lrat"]}', flush=True)
    assert res['lrat']['verdict'] == 'UNSAT', 'the certificate CNF is not refused'
    res['kissat_identical'] = run_solver(['kissat', '-q', cpath], budget)
    print(f'  kissat, identical CNF: {res["kissat_identical"]}', flush=True)
    res['kissat_pin_free'] = run_solver(['kissat', '-q', fpath], budget)
    print(f'  kissat, pin-free CNF: {res["kissat_pin_free"]}', flush=True)
    os.makedirs(od, exist_ok=True)
    with open(lpath, 'rb') as fi, gzip.GzipFile(os.path.join(od, 'witness.lrat.gz.tmp'), 'wb', compresslevel=9, mtime=0) as fo:
        shutil.copyfileobj(fi, fo)
    os.replace(os.path.join(od, 'witness.lrat.gz.tmp'), os.path.join(od, 'witness.lrat.gz'))
    lsha = hashlib.sha256(open(lpath, 'rb').read()).hexdigest()
    lbytes = os.path.getsize(lpath)
    with gzip.GzipFile(os.path.join(od, 'witness.cnf.gz'), 'wb', compresslevel=9, mtime=0) as fo:
        fo.write(cnf.encode())
    for p_ in (cpath, fpath, lpath):
        os.remove(p_)
    Z = [to_oe(p) for p in kept]
    for (i, j) in uedges:                                               # the geometry, re-checked here in O_E arithmetic
        D = tuple(y - x for x, y in zip(Z[i], Z[j]))
        assert oe_mul(D, oe_conj(D)) == (81, 0, 0, 0), (i, j, D)
    w = {'what': 'FS-73 P1: a finite subgraph G of the unit-distance graph on Lambda = (1/9) O_E, O_E = Z<1, zeta6, w, zeta6 w>, '
                 'zeta6 = (1 + sqrt-3)/2, w = (1 + sqrt-11)/2 (de Grey\'s lattice over K = Q(sqrt3, sqrt11), embedded in C by '
                 'sqrt-3 -> i sqrt3, sqrt-11 -> i sqrt11), such that G plus the one extra edge {pair[0], pair[1]} is not 4-colourable; '
                 'so every proper 4-colouring of the plane gives the pair one colour whenever it colours G',
         'point_format': 'Z = [a, b, c, d]: the point (a + b zeta6 + c w + d zeta6 w)/9',
         'points': Z, 'unit_edges': [list(e) for e in uedges], 'pair': [a, b],
         'pair_difference_Z': [y - x for x, y in zip(Z[a], Z[b])],
         'pin_clique': [[v, c] for v, c in pin_list],
         'cnf': 'x(v, k) = 4v + k + 1; for each vertex in order [x(v,0) x(v,1) x(v,2) x(v,3)]; for each edge (i, j), i < j, of '
                'unit_edges + [pair] in sorted order, [-x(i,k) -x(j,k)] for k = 0..3; then the unit clause [x(v,k)] per pin_clique '
                'entry (a clique of G + pair: a symmetry reduction)',
         'cnf_sha256': csha, 'lrat_sha256': lsha, 'lrat_bytes': lbytes,
         'provenance': {'generator': 'tools/fs73_certify.py', 'lattice_coordinates': [list(p) for p in kept],
                        'lattice_basis_over_36': [list(h) for h in lat.H], 'delta_lattice': list(delta),
                        'source_ball': {'R': R, 'points': len(pts), 'edges': int(len(E)), 'refusal_row': row['key'],
                                        'refusal_cnf_sha256': sha},
                        'reduction': src['step'], 'rechecks': res, 'machine': S.MACHINE}}
    json.dump(w, open(os.path.join(od, 'witness.json'), 'w'), separators=(',', ':'))
    print(f'  wrote {od}/witness.json, witness.cnf.gz, witness.lrat.gz ({lbytes} bytes LRAT)', flush=True)
    return 0


def main():
    a = sys.argv[1:]
    if len(a) < 2 or a[1] != 'K':
        print(__doc__)
        return 2
    tg = a[a.index('--target') + 1]
    R = float(a[a.index('--R') + 1])
    budget = int(a[a.index('--budget') + 1]) if '--budget' in a else 3600
    if a[0] == 'rounds':
        return cmd_rounds(tg, R, budget, '--resume' in a)
    if a[0] == 'delete':
        return cmd_delete(tg, R, budget)
    if a[0] == 'emit':
        return cmd_emit(tg, R, budget)
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
