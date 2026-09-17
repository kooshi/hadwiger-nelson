#!/usr/bin/env python3
"""fs58_witness -- FS-58 phase B3: turn the box-piece forcing claim over Q(sqrt11) into a finite witness for chi(Q(sqrt11)^2) >= 4.

UNTRUSTED (tools/). What a reader must check is re-derived by tools/fs58_check_witness.py, which shares no code with this file.

Points of the plane over F = Q(sqrt11) are written two ways here:
  * in a box piece, a 4-tuple (a, b, c, e) of integers over N = 10, the point ((a + b sqrt11)/10, (c + e sqrt11)/10);
  * in the witness, a reduced 5-tuple (a, b, c, e, m), m > 0, gcd(a, b, c, e, m) = 1, the point ((a + b sqrt11)/m, (c + e sqrt11)/m).
Every edge and every membership is decided in exact integer arithmetic; floats only propose candidate pairs.

Subcommands (resumable: every finished step is appended to data/fs58/witness-11/steps.jsonl and skipped when the command is re-run):
  identities   the chain identities of plans/FS58-four-colours.md R-B2, in exact arithmetic over Q(sqrt11, i)
  scan         box pieces of Cay(Z[W0], W0) for every direction u (up to sign) and several box shapes: the separation query (0, 3u) and
               the identification query (0, 2u), each solved by the CaDiCaL binary with an LRAT proof, the core extracted by backward
               reachability from the empty clause, induced, and re-solved until the core stops shrinking
  forcer       from the smallest fixpoint cores: shrink to a 1-minimal forcer (no single vertex removable) (deletion over vertex groups, Glucose4
               assumptions; the D3.8 gadget for identification cores), then re-verify the winner with fresh solvers -> forcer.json
  chain        transport the forcer by the four isometries, add every exact unit distance, refute 3-colourability with CaDiCaL (LRAT)
               and Glucose4 -> witness.json, witness.lrat.gz
Plan: plans/FS58-four-colours.md R-B2 (the claim) and B3 (this phase).
"""
import sys, os, json, itertools, subprocess, time, hashlib, gzip, math
from fractions import Fraction as Fr
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
from fs58_local import units_d  # the pool enumerator (cross-checked below against a brute force)

D, N = 11, 10
OUT = ROOT / 'data/fs58/witness-11'
WORK = ROOT / 'build/fs58-witness'          # regenerable CNF/LRAT scratch (seconds to redo); the step record under OUT is the checkpoint
STEPS = OUT / 'steps.jsonl'
POOL = ROOT / 'data/fs58/chain-11/pool-10.json'


def cadical():
    pre = subprocess.run(['lean', '--print-prefix'], capture_output=True, text=True, check=True).stdout.strip()
    return os.path.join(pre, 'bin', 'cadical')


# ================================================================ step record (the checkpoint)

def load_steps():
    done = {}
    if STEPS.exists():
        for ln in STEPS.read_text().splitlines():
            if ln.strip():
                r = json.loads(ln)
                done[r['step']] = r
    return done


def record(rec):
    OUT.mkdir(parents=True, exist_ok=True)
    with open(STEPS, 'a') as f:
        f.write(json.dumps(rec, sort_keys=True) + '\n')
        f.flush()
        os.fsync(f.fileno())


def write_json(path, obj):
    tmp = str(path) + '.tmp'
    with open(tmp, 'w') as f:
        json.dump(obj, f, indent=1, sort_keys=True)
        f.write('\n')
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, path)


# ================================================================ the pool, exact

def is_unit10(v):
    a, b, c, e = v
    return a * a + D * b * b + c * c + D * e * e == N * N and a * b + c * e == 0


def pool():
    p = json.loads(POOL.read_text())
    W0 = [tuple(w) for w in p['W0']]
    B = [tuple(b) for b in p['basis']]
    brute = sorted((a, b, c, e) for a in range(-N, N + 1) for b in range(-3, 4) for c in range(-N, N + 1) for e in range(-3, 4)
                   if is_unit10((a, b, c, e)))
    assert sorted(W0) == brute == sorted(units_d(N, D)), 'W0 is not every unit vector with denominator dividing 10'
    assert len(W0) == 36
    return W0, B


def coords_in(B, v):
    """exact integer coordinates of v in the basis B (rows), or an AssertionError"""
    M = [[Fr(B[i][j]) for i in range(4)] + [Fr(v[j])] for j in range(4)]
    for c in range(4):
        piv = next(r for r in range(c, 4) if M[r][c] != 0)
        M[c], M[piv] = M[piv], M[c]
        for r in range(4):
            if r != c and M[r][c] != 0:
                f = M[r][c] / M[c][c]
                M[r] = [x - f * y for x, y in zip(M[r], M[c])]
    x = [M[i][4] / M[i][i] for i in range(4)]
    assert all(t.denominator == 1 for t in x), (v, x)
    return tuple(int(t) for t in x)


def reps_up_to_sign(W0):
    reps = []
    for u in W0:
        if tuple(-x for x in u) not in reps:
            reps.append(u)
    return reps


# ================================================================ CNF, solvers, LRAT core

def var(v, c):
    return 3 * v + c + 1


def graph_cnf(n, edges, units):
    """clauses in the canonical order (the checker builds the same order for the witness): at-least-one per vertex in vertex order,
    then for each edge (sorted, i < j) its colour clauses in colour order, then the unit clauses. owner[k] = vertices of clause k+1."""
    cl, owner = [], []
    for v in range(n):
        cl.append((var(v, 0), var(v, 1), var(v, 2)))
        owner.append((v,))
    for i, j in sorted(edges):
        assert i < j
        for c in range(3):
            cl.append((-var(i, c), -var(j, c)))
            owner.append((i, j))
    for lit in units:
        cl.append((lit,))
        owner.append(((abs(lit) - 1) // 3,))
    return cl, owner


def write_dimacs(path, nvars, clauses):
    tmp = str(path) + '.tmp'
    with open(tmp, 'w') as f:
        f.write(f'p cnf {nvars} {len(clauses)}\n')
        for c in clauses:
            f.write(' '.join(map(str, c)) + ' 0\n')
    os.replace(tmp, path)


def run_cadical(cnf, proof):
    """the CaDiCaL binary (v2.1.2 at the pinned toolchain), text LRAT; returns (exit code, seconds, model or None)"""
    t = time.time()
    r = subprocess.run([cadical(), '-q', '--lrat=true', '--binary=false', str(cnf), str(proof)], capture_output=True, text=True)
    dt = time.time() - t
    if r.returncode not in (10, 20):
        raise RuntimeError(f'cadical exit {r.returncode}: {r.stderr[-400:]}')
    model = None
    if r.returncode == 10:
        model = set()
        for ln in r.stdout.splitlines():
            if ln.startswith('v '):
                model.update(int(x) for x in ln[2:].split() if int(x) > 0)
    return r.returncode, dt, model


def glucose(clauses):
    from pysat.solvers import Glucose4
    g = Glucose4(bootstrap_with=[list(c) for c in clauses])
    t = time.time()
    res = g.solve()
    dt = time.time() - t
    m = set(x for x in g.get_model() if x > 0) if res else None
    g.delete()
    return res, dt, m


def colouring_from(model, n, edges):
    col = [next(c for c in range(3) if var(v, c) in model) for v in range(n)]
    assert all(col[a] != col[b] for a, b in edges), 'model is not a proper colouring'
    return col


def lrat_core(proof, m):
    """the original clause ids (1..m) reached backward from the empty clause through the LRAT hints, and the count of additions"""
    lines = open(proof, 'rb').read().split(b'\n')
    needed, orig, started, adds = set(), set(), False, 0
    for ln in reversed(lines):
        if not ln:
            continue
        toks = ln.split()
        if toks[1] == b'd':
            continue
        adds += 1
        cid = int(toks[0])
        k = toks.index(b'0', 1)
        if not started:
            if k != 1:
                continue
            started = True
            needed.add(cid)
        if cid in needed:
            for h in toks[k + 1:-1]:
                h = int(h)
                assert h > 0, 'RAT hint in a CaDiCaL proof'
                if h <= m:
                    orig.add(h)
                else:
                    needed.add(h)
    assert started, 'no empty clause in the proof'
    return orig, adds


# ================================================================ pieces

def add4(p, q):
    return tuple(a + b for a, b in zip(p, q))


def sc4(k, p):
    return tuple(k * a for a in p)


def box_points(B, lo, hi):
    """exact points x.B for lo_i <= x_i <= hi_i"""
    return [tuple(sum(x[i] * B[i][j] for i in range(4)) for j in range(4))
            for x in itertools.product(*[range(lo[i], hi[i] + 1) for i in range(4)])]


def w0_edges(pts, W0):
    """every pair of the piece at a difference in W0. Since W0 is every unit vector with denominator dividing 10 and every difference of
    two piece points has denominator dividing 10, these are all the unit distances among the piece's points."""
    idx = {p: i for i, p in enumerate(pts)}
    E = set()
    for i, p in enumerate(pts):
        for w in W0:
            j = idx.get(add4(p, w))
            if j is not None and i < j:
                E.add((i, j))
    return E


def shape_box(coords_t, shape):
    """(lo, hi) in basis coordinates for a target with coordinates coords_t: ('R', r) centred at 0, or ('span', m) the smallest box
    holding 0 and the target, widened by m. None if a centred box does not hold the target."""
    kind, s = shape
    if kind == 'R':
        if max(map(abs, coords_t)) > s:
            return None
        return [-s] * 4, [s] * 4
    return [min(0, t) - s for t in coords_t], [max(0, t) + s for t in coords_t]


def pins(mode, i0, iq, inb):
    """c(0) = colour 0 by colour symmetry. A neighbour nb of 0 may be pinned to colour 1: given c(0) = 0, swapping colours 1 and 2 fixes
    colour 0, so it preserves both c(q) = c(0) and c(q) != c(0), and puts c(nb) = 1. Then the query's own clause."""
    u = [var(i0, 0)]
    if inb is not None:
        u.append(var(inb, 1))
    u.append(var(iq, 0) if mode == 'identify' else -var(iq, 0))
    return u


def solve_to_fixpoint(tag, pts, W0, mode, q, done, rounds=8):
    """solve the query on the piece (W0 edges), take the LRAT core's vertices (plus 0 and q), induce, repeat until the core stops
    shrinking. Returns (final points or None if SAT, list of round records)."""
    WORK.mkdir(parents=True, exist_ok=True)
    nb = (-10, 0, 0, 0)
    cur, recs = sorted(pts), []
    for rnd in range(rounds):
        step = f'{tag}/round{rnd}'
        if step in done:
            rec = done[step]
        else:
            idx = {p: i for i, p in enumerate(cur)}
            E = w0_edges(cur, W0)
            i0, iq = idx[(0, 0, 0, 0)], idx[q]
            units = pins(mode, i0, iq, idx.get(nb))
            cl, owner = graph_cnf(len(cur), E, units)
            base = WORK / tag.replace('/', '_').replace(' ', '')
            cnf, prf = Path(f'{base}_r{rnd}.cnf'), Path(f'{base}_r{rnd}.lrat')
            write_dimacs(cnf, 3 * len(cur), cl)
            code, dt, model = run_cadical(cnf, prf)
            rec = {'step': step, 'points': len(cur), 'edges': len(E), 'clauses': len(cl), 'mode': mode, 'q': list(q), 'pins': units,
                   'cadical_seconds': round(dt, 3), 'verdict': 'Forced (solver claim)' if code == 20 else 'Separable (colouring verified)'}
            if mode == 'identify':
                rec['verdict'] = 'Separated (solver claim)' if code == 20 else 'Identifiable (colouring verified)'
            if code == 10:
                col = colouring_from(model, len(cur), E)
                assert (col[i0] == col[iq]) == (mode == 'identify')
                rec['c0_cq'] = [col[i0], col[iq]]
                rec['core_points'] = None
            else:
                orig, adds = lrat_core(prf, len(cl))
                V = {i0, iq}
                for k in orig:
                    V.update(owner[k - 1])
                core = sorted(cur[i] for i in V)
                rec.update({'proof_bytes': prf.stat().st_size, 'proof_additions': adds, 'core_clauses': len(orig),
                            'core_points': len(core), 'core': [list(p) for p in core]})
            record(rec)
            cnf.unlink()
            prf.unlink()
        recs.append(rec)
        print(f'  {step}: {rec["points"]} points, {rec["edges"]} edges -> {rec["verdict"]}'
              + (f'; core {rec["core_clauses"]} clauses on {rec["core_points"]} points' if rec.get('core_points') else ''), flush=True)
        if rec.get('core_points') is None:
            return None, recs
        nxt = [tuple(p) for p in rec['core']]
        if len(nxt) == rec['points']:
            return nxt, recs
        cur = nxt
    return cur, recs


# ================================================================ exact arithmetic in F(i) = Q(sqrt11, i)
# z = (x0, x1, y0, y1) is (x0 + x1 sqrt11) + i (y0 + y1 sqrt11), with rational entries

def fmul(x, y):
    return (x[0] * y[0] + D * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def cmul(z, w):
    re, re2 = fmul(z[:2], w[:2]), fmul(z[2:], w[2:])
    im, im2 = fmul(z[:2], w[2:]), fmul(z[2:], w[:2])
    return (re[0] - re2[0], re[1] - re2[1], im[0] + im2[0], im[1] + im2[1])


def cadd(z, w):
    return tuple(a + b for a, b in zip(z, w))


def cconj(z):
    return (z[0], z[1], -z[2], -z[3])


def csc(k, z):
    return tuple(Fr(k) * a for a in z)


ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
ZERO = (Fr(0), Fr(0), Fr(0), Fr(0))
V_UNIT = (Fr(-5, 6), Fr(0), Fr(0), Fr(1, 6))            # v = (-5 + i sqrt11)/6


def as_complex(p10):
    return tuple(Fr(x, N) for x in p10)


def transports(u10):
    """T_k(z) = t_k + r_k z with r = (ubar, ubar, ubar v, ubar vbar) and t_{k+1} = t_k + 3 u r_k, t_1 = 0; asserts |u| = |v| = |r_k| = 1,
    1 + 1 + v + vbar = 1/3 and t_5 = 1, all exactly. Returns (r, t) with t = [t_1, ..., t_5]."""
    u = as_complex(u10)
    assert cmul(u, cconj(u)) == ONE and cmul(V_UNIT, cconj(V_UNIT)) == ONE
    assert cadd(cadd(ONE, ONE), cadd(V_UNIT, cconj(V_UNIT))) == csc(Fr(1, 3), ONE), '1/3 = 1 + 1 + v + vbar fails'
    ub = cconj(u)
    r = [ub, ub, cmul(ub, V_UNIT), cmul(ub, cconj(V_UNIT))]
    t = [ZERO]
    for k in range(4):
        assert cmul(r[k], cconj(r[k])) == ONE
        t.append(cadd(t[k], cmul(r[k], csc(3, u))))
    assert t[4] == ONE, 't_5 != 1'
    return r, t


def reduced(z):
    """the reduced 5-tuple (a, b, c, e, m) of the point z"""
    m = 1
    for x in z:
        m = m * x.denominator // math.gcd(m, x.denominator)
    a, b, c, e = (int(x * m) for x in z)
    assert math.gcd(math.gcd(math.gcd(math.gcd(a, b), c), e), m) == 1
    return (a, b, c, e, m)


def cmd_identities():
    W0, B = pool()
    w = (0, 3, -1, 0)
    r, t = transports(w)
    assert t[1] == csc(3, ONE) and t[2] == csc(6, ONE) and t[3] == cadd(csc(6, ONE), csc(3, V_UNIT))
    print('identities, exact over Q(sqrt11, i):')
    print('  w = (3 sqrt11 - i)/10 and v = (-5 + i sqrt11)/6 are unit vectors; 1 + 1 + v + vbar = 1/3')
    print('  T_k(z) = t_k + r_k z, r = (wbar, wbar, wbar v, wbar vbar): T_k(0) = t_k and T_k(3w) = t_{k+1}, t = 0, 3, 6, 6 + 3v, 1: holds')
    for u in W0:
        transports(u)
    print(f'  the same chain (r = ubar (1, 1, v, vbar)) closes at t_5 = 1 for all {len(W0)} directions u in W0')


# ================================================================ scan

SHAPES = [('R', 4), ('R', 5), ('R', 6), ('span', 1), ('span', 2), ('span', 3)]


def cmd_scan():
    W0, B = pool()
    done = load_steps()
    reps = reps_up_to_sign(W0)
    t0 = time.time()
    print(f'scan: {len(reps)} directions up to sign x {len(SHAPES)} shapes x 2 queries; resumable from {STEPS.relative_to(ROOT)}')
    for u in reps:
        cu = coords_in(B, u)
        for mode, k in (('separate', 3), ('identify', 2)):
            q = sc4(k, u)
            for shape in SHAPES:
                lohi = shape_box(sc4(k, cu), shape)
                tag = f'scan/{mode}/u={",".join(map(str, u))}/{shape[0]}{shape[1]}'
                if lohi is None:
                    continue
                pts = box_points(B, *lohi) if f'{tag}/round0' not in done else []
                if pts:
                    assert (0, 0, 0, 0) in pts and q in pts
                solve_to_fixpoint(tag, pts, W0, mode, q, done)
    # summary
    done = load_steps()
    final = {}
    for step, r in done.items():
        if step.startswith('scan/'):
            tag = step.rsplit('/', 1)[0]
            final.setdefault(tag, []).append(r)
    rows = []
    for tag, rs in final.items():
        rs.sort(key=lambda r: int(r['step'].rsplit('round', 1)[1]))
        first, last = rs[0], rs[-1]
        rows.append((tag, first['points'], first['verdict'], last.get('core_points')))
    for mode in ('separate', 'identify'):
        got = sorted((r for r in rows if f'/{mode}/' in r[0] and r[3]), key=lambda r: r[3])
        print(f'{mode}: {len(got)} of {sum(1 for r in rows if f"/{mode}/" in r[0])} pieces refuse; smallest fixpoint cores:')
        for r in got[:8]:
            print(f'  {r[0]}: piece {r[1]} points -> core {r[3]} points')
    print(f'scan done in {time.time() - t0:.0f} s')


# ================================================================ forcer

def group_mus(pts, W0, i0_pt, iq_pt, protect_pts, order_key):
    """deletion-based vertex-minimal subset (over vertex groups) of pts keeping c(0) = 0, c(q) != 0 unsatisfiable, with Glucose4 and
    one selector per vertex guarding its at-least-one clause (an absent vertex may take no colour, which satisfies all its edge clauses).
    Every returned vertex was necessary when tested, and necessity is inherited by subsets, so the result is 1-minimal."""
    from pysat.solvers import Glucose4
    pts = sorted(pts)
    idx = {p: i for i, p in enumerate(pts)}
    n = len(pts)
    E = w0_edges(pts, W0)
    sel = lambda v: 3 * n + 1 + v
    g = Glucose4()
    for v in range(n):
        g.add_clause([-sel(v), var(v, 0), var(v, 1), var(v, 2)])
    for a, b in E:
        for c in range(3):
            g.add_clause([-var(a, c), -var(b, c)])
    g.add_clause([var(idx[i0_pt], 0)])
    g.add_clause([-var(idx[iq_pt], 0)])
    protect = {idx[p] for p in protect_pts}
    cur = set(range(n))
    assert not g.solve(assumptions=[sel(v) for v in sorted(cur)]), 'the starting set does not force'
    cur = {s - 3 * n - 1 for s in g.get_core()} | protect
    calls = 1
    for v in sorted(cur, key=lambda v: order_key(pts[v])):
        if v in protect or v not in cur:
            continue
        trial = sorted(cur - {v})
        calls += 1
        if not g.solve(assumptions=[sel(x) for x in trial]):
            cur = {s - 3 * n - 1 for s in g.get_core()} | protect
    g.delete()
    return sorted(pts[v] for v in cur), calls


def fnorm(p):
    """Minkowski-ish float size of a box point (ordering heuristic only)"""
    s = math.sqrt(D)
    x, y = (p[0] + p[1] * s) / N, (p[2] + p[3] * s) / N
    return x * x + y * y


def verify_forcer(tag, pts, W0, u, done):
    """fresh checks of a forcer: separation (0, 3u) UNSAT by the CaDiCaL binary (LRAT, core must reach both ends) and by Glucose4;
    identification (0, 3u) SAT with a verified model; plain 3-colourability SAT with a verified model."""
    step = f'{tag}/verify'
    if step in done:
        return done[step]
    pts = sorted(pts)
    idx = {p: i for i, p in enumerate(pts)}
    E = w0_edges(pts, W0)
    n = len(pts)
    i0, iq = idx[(0, 0, 0, 0)], idx[sc4(3, u)]
    WORK.mkdir(parents=True, exist_ok=True)
    rec = {'step': step, 'points': n, 'edges': len(E), 'u': list(u)}
    for name, units in (('separate', [var(i0, 0), -var(iq, 0)]), ('identify', [var(i0, 0), var(iq, 0)]), ('colourable', [var(i0, 0)])):
        cl, owner = graph_cnf(n, E, units)
        cnf, prf = WORK / f'verify_{name}.cnf', WORK / f'verify_{name}.lrat'
        write_dimacs(cnf, 3 * n, cl)
        code, dt, model = run_cadical(cnf, prf)
        gres, gdt, gmodel = glucose(cl)
        row = {'cadical_exit': code, 'cadical_seconds': round(dt, 3), 'glucose4': 'SAT' if gres else 'UNSAT', 'glucose4_seconds': round(gdt, 3)}
        assert (code == 10) == bool(gres), f'{name}: the solvers disagree'
        if code == 20:
            orig, adds = lrat_core(prf, len(cl))
            V = set()
            for k in orig:
                V.update(owner[k - 1])
            row.update({'proof_additions': adds, 'core_clauses': len(orig), 'core_points': len(V)})
        else:
            for mdl, who in ((model, 'cadical'), (gmodel, 'glucose4')):
                col = colouring_from(mdl, n, E)
                assert col[i0] == 0 and (name != 'separate' or col[iq] != 0) and (name != 'identify' or col[iq] == 0)
            row['models_verified'] = 'CaDiCaL and Glucose4 models proper and meeting the pins'
        rec[name] = row
        cnf.unlink()
        prf.unlink()
    record(rec)
    return rec


def cmd_forcer(top=6):
    W0, B = pool()
    done = load_steps()
    final = {}
    for step, r in done.items():
        if step.startswith('scan/') and '/round' in step:
            final.setdefault(step.rsplit('/', 1)[0], []).append(r)
    cands = []
    for tag, rs in final.items():
        rs.sort(key=lambda r: int(r['step'].rsplit('round', 1)[1]))
        if rs[-1].get('core_points'):
            cands.append((rs[-1]['core_points'], tag, [tuple(p) for p in rs[-1]['core']]))
    cands.sort()
    results = []
    for mode in ('separate', 'identify'):
        mine = [c for c in cands if f'/{mode}/' in c[1]][:top]
        for size, tag, core in mine:
            u = tuple(int(x) for x in tag.split('/u=')[1].split('/')[0].split(','))
            step = f'forcer/{tag}'
            if step in done:
                results.append(done[step])
                print(f'  [resume] {step}: {done[step]["start_points"]} -> {done[step]["points"]} points')
                continue
            t = time.time()
            q3 = sc4(3, u)
            if mode == 'separate':
                start = core
            else:   # D3.8: a separator S of (0, 2u) with its translate by u and the run 0, u, 2u, 3u forces (0, 3u)
                start = sorted(set(core) | {add4(p, u) for p in core} | {(0, 0, 0, 0), u, sc4(2, u), q3})
            mid = sc4(Fr(3, 2), u)
            key = lambda p: -fnorm(tuple(float(a) - float(b) for a, b in zip(p, mid)))
            mus, calls = group_mus(start, W0, (0, 0, 0, 0), q3, [(0, 0, 0, 0), q3], key)
            rec = {'step': step, 'u': list(u), 'mode': mode, 'start_points': len(start), 'points': len(mus), 'solver_calls': calls,
                   'seconds': round(time.time() - t, 2), 'forcer': [list(p) for p in mus]}
            record(rec)
            results.append(rec)
            print(f'  {step}: start {len(start)} points -> 1-minimal forcer of (0, 3u) (no single vertex removable) with {len(mus)} points '
                  f'({calls} Glucose4 calls, {rec["seconds"]} s)', flush=True)
    best = min(results, key=lambda r: (r['points'], r['step']))
    for mode in ('separate', 'identify'):
        rs = [r for r in results if r['mode'] == mode]
        if rs:
            b = min(rs, key=lambda r: r['points'])
            print(f'smallest forcer from {mode} cores: {b["points"]} points ({b["step"]})')
    u = tuple(best['u'])
    pts = [tuple(p) for p in best['forcer']]
    ver = verify_forcer(best['step'], pts, W0, u, load_steps())
    E = w0_edges(sorted(pts), W0)
    obj = {'what': 'a finite set of points of Q(sqrt11)^2 whose unit-distance graph forces c(0) = c(3u) in every proper 3-colouring',
           'convention': '(a, b, c, e) over 10 is ((a + b sqrt11)/10, (c + e sqrt11)/10)',
           'u': list(u), 'three_u': list(sc4(3, u)), 'source_step': best['step'], 'points': [list(p) for p in sorted(pts)],
           'edges': sorted(E), 'verification': ver, 'trust': 'solver claims (CaDiCaL binary with LRAT core, Glucose4); '
           'the certified object is the chained witness (witness.json), not this file'}
    write_json(OUT / 'forcer.json', obj)
    print(f'forcer.json: u = {u}, {len(pts)} points, {len(E)} edges; separate {ver["separate"]["glucose4"]} / exit {ver["separate"]["cadical_exit"]}, '
          f'identify {ver["identify"]["glucose4"]}, colourable {ver["colourable"]["glucose4"]}')


# ================================================================ chain

def unit_pair(p, q):
    a1, b1, c1, e1, m1 = p
    a2, b2, c2, e2, m2 = q
    A, Bb, C, E, M = a1 * m2 - a2 * m1, b1 * m2 - b2 * m1, c1 * m2 - c2 * m1, e1 * m2 - e2 * m1, m1 * m2
    return A * Bb + C * E == 0 and A * A + D * Bb * Bb + C * C + D * E * E == M * M


def all_unit_edges(P):
    """every exact unit distance among the points; a float grid of unit cells proposes (all pairs within two cells, which contains every
    pair at distance <= 1 whatever the float error below 1/2), exact integer arithmetic decides"""
    s = math.sqrt(D)
    cell = {}
    for i, (a, b, c, e, m) in enumerate(P):
        cell.setdefault((math.floor((a + b * s) / m), math.floor((c + e * s) / m)), []).append(i)
    E = set()
    for (cx, cy), mem in cell.items():
        for dx in range(-2, 3):
            for dy in range(-2, 3):
                for j in cell.get((cx + dx, cy + dy), ()):
                    for i in mem:
                        if i < j and unit_pair(P[i], P[j]):
                            E.add((i, j))
    return E


def exhaustive_colouring(n, edges, doms):
    """an exhaustive search (no SAT solver, no learning) for a proper 3-colouring with colour domains doms (bitmasks over colours
    0, 1, 2): smallest-domain branching and singleton propagation. Returns (a colouring or None, search nodes)."""
    adj = [[] for _ in range(n)]
    for i, j in edges:
        adj[i].append(j)
        adj[j].append(i)
    nodes = [0]

    def propagate(dom, stack):
        while stack:
            v = stack.pop()
            for u in adj[v]:
                if dom[u] & dom[v]:
                    dom[u] &= ~dom[v]
                    if dom[u] == 0:
                        return False
                    if dom[u] & (dom[u] - 1) == 0:
                        stack.append(u)
        return True

    def rec(dom):
        nodes[0] += 1
        best, bc = None, 4
        for v in range(n):
            if dom[v] & (dom[v] - 1):
                k = bin(dom[v]).count('1')
                if k < bc:
                    best, bc = v, k
        if best is None:
            return dom
        for c in (1, 2, 4):
            if dom[best] & c:
                nd = dom[:]
                nd[best] = c
                if propagate(nd, [best]):
                    r = rec(nd)
                    if r:
                        return r
        return None

    dom = list(doms)
    if not propagate(dom, [v for v in range(n) if dom[v] & (dom[v] - 1) == 0]):
        return None, 1
    r = rec(dom)
    return ([{1: 0, 2: 1, 4: 2}[x] for x in r] if r else None), nodes[0]


def cmd_chain():
    W0, B = pool()
    done = load_steps()
    if 'chain' in done and (OUT / 'witness.json').exists() and (OUT / 'witness.lrat.gz').exists() and '--redo' not in sys.argv:
        r = done['chain']
        print(f'[resume] chain done: G* {r["points"]} points, {r["edges"]} edges (re-run with --redo to rebuild)')
        return
    fo = json.loads((OUT / 'forcer.json').read_text())
    u = tuple(fo['u'])
    H = [tuple(p) for p in fo['points']]
    assert (0, 0, 0, 0) in H and sc4(3, u) in H
    r, t = transports(u)
    pts = {}
    copies = []
    for k in range(4):
        img = []
        for p in H:
            z = cadd(t[k], cmul(r[k], as_complex(p)))
            img.append(reduced(z))
        copies.append(img)
        assert reduced(cadd(t[k], cmul(r[k], as_complex((0, 0, 0, 0))))) == reduced(t[k])
        assert reduced(cadd(t[k], cmul(r[k], as_complex(sc4(3, u))))) == reduced(t[k + 1])
    P = sorted(set(itertools.chain.from_iterable(copies)))
    idx = {p: i for i, p in enumerate(P)}
    origin, one = idx[(0, 0, 0, 0, 1)], idx[(1, 0, 0, 0, 1)]
    t0 = time.time()
    E = all_unit_edges(P)
    # the transported forcer edges must be among them (an isometry keeps unit distances)
    HE = w0_edges(sorted(H), W0)
    Hs = sorted(H)
    for k in range(4):
        cmap = {Hs[i]: copies[k][H.index(Hs[i])] for i in range(len(Hs))}
        for a, b in HE:
            x, y = idx[cmap[Hs[a]]], idx[cmap[Hs[b]]]
            assert (min(x, y), max(x, y)) in E, 'a transported edge is missing'
    assert (min(origin, one), max(origin, one)) in E
    n = len(P)
    # a second, solver-free route to the same conclusion: each copy, as an induced subgraph of G*, forces its two ends equal
    # (exhaustive search), and the ends chain 0 -> 3 -> 6 -> 6 + 3v -> 1 with 0 and 1 adjacent
    solver_free = []
    for k in range(4):
        S = sorted({idx[p] for p in copies[k]})
        loc = {g: i for i, g in enumerate(S)}
        sub = [(loc[i], loc[j]) for i, j in E if i in loc and j in loc]
        a, b = loc[idx[reduced(t[k])]], loc[idx[reduced(t[k + 1])]]
        doms = [7] * len(S)
        doms[a], doms[b] = 1, 6
        col, nodes = exhaustive_colouring(len(S), sub, doms)
        assert col is None, f'copy {k + 1} does not force its ends equal: {col}'
        doms[b] = 1
        col2, nodes2 = exhaustive_colouring(len(S), sub, doms)
        assert col2 is not None and all(col2[i] != col2[j] for i, j in sub), f'copy {k + 1}: identification control failed'
        solver_free.append({'copy': k + 1, 'points': len(S), 'edges': len(sub), 'separation_nodes': nodes,
                            'separation': 'no colouring (exhaustive)', 'identification': 'colouring found and verified'})
    print('solver-free route: each copy forces its ends equal by exhaustive search (nodes '
          + ', '.join(str(r['separation_nodes']) for r in solver_free) + '); identification colourings verified')
    pin = (origin, one)
    units = [var(origin, 0), var(one, 1)]
    cl, owner = graph_cnf(n, E, units)
    OUT.mkdir(parents=True, exist_ok=True)
    WORK.mkdir(parents=True, exist_ok=True)
    cnf, prf = WORK / 'witness.cnf', WORK / 'witness.lrat'
    write_dimacs(cnf, 3 * n, cl)
    code, dt, model = run_cadical(cnf, prf)
    if code == 10:
        col = colouring_from(model, n, E)
        write_json(OUT / 'COLOURABLE-G-star.json', {'points': [list(p) for p in P], 'colouring': col})
        raise SystemExit(f'G* IS 3-COLOURABLE: CaDiCaL returned a model, verified proper; written to COLOURABLE-G-star.json. STOP.')
    gres, gdt, _ = glucose(cl)
    assert not gres, 'Glucose4 finds G* 3-colourable while CaDiCaL refuses it'
    orig, adds = lrat_core(prf, len(cl))
    Vc = set()
    for k in orig:
        Vc.update(owner[k - 1])
    raw = prf.read_bytes()
    with open(OUT / 'witness.lrat.gz.tmp', 'wb') as fh, gzip.GzipFile(filename='witness.lrat', mode='wb', compresslevel=9, fileobj=fh, mtime=0) as f:
        f.write(raw)   # mtime 0: a rebuild is byte-identical
    os.replace(OUT / 'witness.lrat.gz.tmp', OUT / 'witness.lrat.gz')
    trans = [{'k': k + 1, 'rotation_r': [str(x) for x in r[k]], 'translation_t': [str(x) for x in t[k]],
              'image_of_0': list(reduced(t[k])), 'image_of_3u': list(reduced(t[k + 1]))} for k in range(4)]
    obj = {
        'claim': 'the unit-distance graph on these points of Q(sqrt11)^2 has no proper 3-colouring, so chi(Q(sqrt11)^2) >= 4',
        'convention': 'a point (a, b, c, e, m) is ((a + b sqrt11)/m, (c + e sqrt11)/m), m > 0, gcd(a, b, c, e, m) = 1; points sorted',
        'points': [list(p) for p in P],
        'edges': sorted(E),
        'cnf': 'variables x(v, k) = 3v + k + 1 (vertex v has colour k in {0, 1, 2}); clauses in order: for each vertex v, '
               '[x(v,0), x(v,1), x(v,2)]; for each edge (i, j), i < j, in sorted order, [-x(i,k), -x(j,k)] for k = 0, 1, 2; '
               'then the pin [x(p,0)], [x(q,1)] for the pinned edge (p, q)',
        'pinned_edge': list(pin),
        'pin_justification': 'p and q are adjacent, so in any proper 3-colouring they differ; a colour permutation makes them 0 and 1',
        'proof': 'witness.lrat.gz: CaDiCaL 2.1.2 text LRAT for exactly this CNF (original clauses numbered 1..M in the order above)',
        'proof_sha256_uncompressed': hashlib.sha256(raw).hexdigest(),
        'transport': {'u': list(u), 'v': '(-5 + i sqrt11)/6', 'rule': 'T_k(z) = t_k + r_k z on z = x + iy; r = (ubar, ubar, ubar v, ubar vbar); '
                      't_{k+1} = t_k + 3 u r_k; so T_k(0) = t_k and T_k(3u) = t_{k+1}, t_1 = 0, t_5 = 1',
                      'copies': trans, 'forcer_points': len(H), 'forcer_file': 'forcer.json'},
    }
    write_json(OUT / 'witness.json', obj)
    rec = {'step': 'chain', 'points': n, 'edges': len(E), 'clauses': len(cl), 'copy_sizes': [len(set(c)) for c in copies],
           'cadical_exit': code, 'cadical_seconds': round(dt, 3), 'glucose4': 'UNSAT', 'glucose4_seconds': round(gdt, 3),
           'proof_bytes': len(raw), 'proof_gz_bytes': (OUT / 'witness.lrat.gz').stat().st_size, 'proof_additions': adds,
           'proof_core_clauses': len(orig), 'proof_core_points': len(Vc), 'edges_seconds': round(time.time() - t0, 2),
           'solver_free_route': solver_free}
    record(rec)
    cnf.unlink()
    prf.unlink()
    print(f'G*: {n} points (copies {rec["copy_sizes"]}), {len(E)} unit edges; not 3-colourable: CaDiCaL exit 20 in {dt:.2f} s, '
          f'Glucose4 UNSAT in {gdt:.2f} s; LRAT {len(raw)/1e6:.2f} MB ({rec["proof_gz_bytes"]/1e6:.2f} MB gz), {adds} additions; '
          f'its core touches {len(orig)} clauses on {len(Vc)} points')


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else ''
    if cmd == 'identities':
        cmd_identities()
    elif cmd == 'scan':
        cmd_scan()
    elif cmd == 'forcer':
        cmd_forcer(int(sys.argv[2]) if len(sys.argv) > 2 else 6)
    elif cmd == 'chain':
        cmd_chain()
    else:
        raise SystemExit(__doc__)


if __name__ == '__main__':
    main()
