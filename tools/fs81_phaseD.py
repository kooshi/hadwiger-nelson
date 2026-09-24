#!/usr/bin/env python3
"""fs81_phaseD -- FS-81 stage D: Q(sqrt47) at four colours, calibrated first (plan plans/FS81-quadratic-four-colours.md S.D).

UNTRUSTED (tools/).  Imports FS-73's lattice and screen code read-only and never writes there; writes only data/fs81/phaseD/.  Every
refusal it reports is re-checked by the standalone tools/fs81_check_witness_k.py (K2) before it is believed, and every colouring of a
Q(sqrt47) lattice by tools/fs81_colour_check.py (K1).  Record: data/fs81/records/phase-D.md.

THE CNF (one writer for every D ask, so any refusal can go straight to K2): x(v, c) = 4v + c + 1; at-least-one per vertex; per edge
(i < j, sorted, a named non-unit edge included) four clauses, colour inner; then one unit clause per pin (pins[c] gets colour c); then per
value-precedence chain [f1, f2] (both unpinned) the auxiliary s(0..n) and [-s(0)], [-x(v,f2), s(v)], [-s(v+1), s(v), x(v,f1)].  This is
exactly the formula K2 rebuilds (its docstring states the rule and its soundness).

Commands:
  k2-fixture   K2's k = 4 self-test fixtures from X_A's certified core (FS73-T6): (a) triangle pin, fs73's own LRAT; (b) a unit-edge pin
               plus the chain [2, 3], a fresh toolchain-CaDiCaL LRAT (a checker control, not a band ask), trimmed to what the empty
               clause's derivation reaches.
  k1-fixture   K1's d = 47 self-test fixtures: additive four-colourings of small lattices Lambda_M by enumeration, and the N = 4
               quotient witnesses they induce (no solver).
  harvest      D0a: every recorded four-colour ask into the S B.1.1 schema (no solver) -> data/fs81/phaseD/d0a-harvest.jsonl
  ladder [--radii 1.0,...,1.7] [--workers 8] [--wall 1800] [--only KEYPART,...] [--no-second]
               D0b: X_A (target and triangle encodings), X_B and the colourable ball at each radius, plus the instrument controls (T5, T7,
               the wall plant); one row per ask appended with fsync to data/fs81/phaseD/d0b-asks.jsonl; a relaunch skips recorded asks.
               Every UNSAT is re-asked by a second solver (toolchain CaDiCaL) unless --no-second.  Run it under the heavy lock.
  reask KEY [TIMES] [WALL]   a decision number: the ladder ask KEY ('X_A|target|R1.5') alone, TIMES times, min CPU -> d0b-reask.jsonl
"""
import gzip
import hashlib
import json
import math
import os
import subprocess
import sys
import time
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / 'data' / 'fs81' / 'phaseD'
SCR = Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-phaseD')
LOCK = '/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock'
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'
CADICAL = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical')
KISSAT = 'kissat'
XA_CERT = ROOT / 'data' / 'fs73' / 'census' / 'cert' / 't-16_8_8_0-R1.5'


def append(path, rec):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, 'a') as f:
        f.write(json.dumps(rec, sort_keys=True) + '\n')
        f.flush()
        os.fsync(f.fileno())


def load_jsonl(path):
    path = Path(path)
    return [json.loads(l) for l in open(path) if l.strip()] if path.exists() else []


# ================================================================ de Grey's lattice -> K2's point format over Q(sqrt3, sqrt11)
def oe_to_k2(p):
    """Z = [a, b, c, d] stands for (a + b z + c w + d z w)/9, z = (1 + i sqrt3)/2, w = (1 + i sqrt11)/2 (fs73's convention).
    Then x = (4a + 2b + 2c + d - d sqrt33)/36 and y = ((2b + d) sqrt3 + (2c + d) sqrt11)/36; over radicands [3, 11] the basis is
    (1, sqrt3, sqrt11, sqrt33), so the K2 point is [x_0, x_1, x_2, x_3, y_0, y_1, y_2, y_3, m] reduced."""
    a, b, c, d = p
    v = [4 * a + 2 * b + 2 * c + d, 0, 0, -d, 0, 2 * b + d, 2 * c + d, 0, 36]
    g = 0
    for t in v:
        g = math.gcd(g, t)
    return [t // g for t in v]


def plane_float(p):
    a, b, c, d = p
    z = complex(0.5, math.sqrt(3) / 2)
    w = complex(0.5, math.sqrt(11) / 2)
    return (a + b * z + c * w + d * z * w) / 9


# ================================================================ the CNF (K2's layout) and the solvers
def cnf_clauses(n, edges, pins, chains, k=4):
    x = lambda v, c: k * v + c + 1          # noqa: E731
    out = [[x(v, c) for c in range(k)] for v in range(n)]
    for i, j in sorted(edges):
        out += [[-x(i, c), -x(j, c)] for c in range(k)]
    out += [[x(v, c)] for c, v in enumerate(pins)]
    nvars = k * n
    pinned = set(range(len(pins)))
    for ci, (f1, f2) in enumerate(chains):
        assert f1 < f2 < k and f1 not in pinned and f2 not in pinned, 'a chain over a pinned colour is unsound (K2 refuses it)'
        base = k * n + ci * (n + 1)
        out.append([-(base + 1)])
        for v in range(n):
            out.append([-x(v, f2), base + v + 1])
            out.append([-(base + v + 2), base + v + 1, x(v, f1)])
        nvars = base + n + 1
    return out, nvars


def write_cnf(path, clauses, nvars):
    h = hashlib.sha256()
    with open(path, 'w') as f:
        head = f'p cnf {nvars} {len(clauses)}\n'
        f.write(head)
        h.update(head.encode())
        for lo in range(0, len(clauses), 200000):
            s = ''.join(' '.join(map(str, c)) + ' 0\n' for c in clauses[lo:lo + 200000])
            f.write(s)
            h.update(s.encode())
    return h.hexdigest()


def status(out, rc):
    lines = [ln.strip() for ln in out.splitlines() if ln.startswith('s ')]
    if not lines:
        return 'UNKNOWN', '(no status line)'
    v = {'s SATISFIABLE': 'SAT', 's UNSATISFIABLE': 'UNSAT'}.get(lines[-1], 'UNKNOWN')
    want = {'SAT': 10, 'UNSAT': 20}.get(v)
    assert want is None or rc == want, f'status line {lines[-1]!r} contradicts the exit code {rc}'
    return v, (None if v != 'UNKNOWN' else lines[-1])


def run_solver(cmd, wall):
    """one solver process under a wall (subprocess.run kills it on expiry); CPU seconds are the children's user + sys"""
    t0, ru0 = time.time(), os.times()
    fired = False
    try:
        pr = subprocess.run(cmd, capture_output=True, text=True, timeout=wall)
        v, sline = status(pr.stdout, pr.returncode)
        out = pr.stdout
    except subprocess.TimeoutExpired:
        v, sline, out, fired = 'UNKNOWN', None, '', True
    ru1 = os.times()
    rec = {'verdict': v, 'wall_s': round(time.time() - t0, 2), 'wall_fired': fired,
           'cpu_s': round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2)}
    if v == 'UNKNOWN':
        rec['unknown_type'] = f'the wall fired at {wall} s' if fired else f'no verdict: {sline!r}'
    return rec, out


def trim_lrat(src, dst, ncl):
    """keep the additions the empty clause's derivation reaches (backward over the hints), in order, no deletion lines"""
    hints, empty = {}, None
    with gzip.open(src, 'rb') if str(src).endswith('.gz') else open(src, 'rb') as f:
        for line in f:
            t = line.split()
            if not t or t[1] == b'd':
                continue
            z = t.index(b'0', 1)
            cid = int(t[0])
            hints[cid] = [int(x) for x in t[z + 1:-1]]
            if z == 1:
                empty = cid
                break
    assert empty is not None, 'no empty clause in the proof'
    need, stack = {empty}, [empty]
    while stack:
        for h in hints[stack.pop()]:
            if h > ncl and h not in need:
                need.add(h)
                stack.append(h)
    kept = 0
    with gzip.open(src, 'rb') if str(src).endswith('.gz') else open(src, 'rb') as f, gzip.GzipFile(dst, 'wb', compresslevel=9, mtime=0) as g:
        for line in f:
            t = line.split()
            if not t or t[1] == b'd':
                continue
            if int(t[0]) in need:
                g.write(line)
                kept += 1
                if int(t[0]) == empty:
                    break
    return len(hints), kept


# ================================================================ k2-fixture
def cmd_k2_fixture():
    W = json.load(open(XA_CERT / 'witness.json'))
    pts = [oe_to_k2(p) for p in W['points']]
    n = len(pts)
    edges = [list(e) for e in W['unit_edges']]
    pair = sorted(W['pair'])
    pins_a = [v for v, c in sorted(W['pin_clique'], key=lambda t: t[1])]
    base = {'what': 'K2 self-test fixture: X_A, the certified core of FS73-T6 (2,044 points of de Grey\'s lattice over Q(sqrt3, sqrt11) '
                    'plus the one non-unit edge {0, v}, v = -(4/9)(1 + sqrt-11)), in K2\'s point format; converted from '
                    'data/fs73/census/cert/t-16_8_8_0-R1.5/witness.json by tools/fs81_phaseD.py oe_to_k2 (same vertex order)',
            'k': 4, 'radicands': [3, 11], 'points': pts, 'edges': edges, 'extra_edge': pair}
    da = OUT / 'k2-fixtures' / 'xa-core-tri'
    da.mkdir(parents=True, exist_ok=True)
    Wa = dict(base, pins=pins_a, precedence_chains=[], proof='data/fs73/census/cert/t-16_8_8_0-R1.5/witness.lrat.gz (fs73\'s trimmed LRAT, '
              'for exactly this CNF: its cnf_sha256 is fs73\'s)', cnf_sha256=W['cnf_sha256'])
    (da / 'witness.json').write_text(json.dumps(Wa))
    lr = da / 'witness.lrat.gz'
    if not lr.exists():
        lr.symlink_to(os.path.relpath(XA_CERT / 'witness.lrat.gz', da))
    cl, nv = cnf_clauses(n, [tuple(e) for e in edges] + [tuple(pair)], pins_a, [])
    sha_a = write_cnf(SCR / 'xa-a.cnf', cl, nv)
    print(f'fixture (a): {n} points, {len(edges)} unit edges, pins {pins_a}; CNF sha {sha_a[:16]} vs fs73 {W["cnf_sha256"][:16]}: '
          f'{"EQUAL" if sha_a == W["cnf_sha256"] else "DIFFERENT"}', flush=True)
    os.remove(SCR / 'xa-a.cnf')
    # (b) a unit-edge pin at the origin (vertex pins_a[0]) and a unit neighbour, plus the chain [2, 3]
    o = pins_a[0]
    nb = sorted(j for i, j in (tuple(e) for e in edges) if i == o) + sorted(i for i, j in (tuple(e) for e in edges) if j == o)
    pins_b = [o, nb[0]]
    db = OUT / 'k2-fixtures' / 'xa-core-edge-prec'
    db.mkdir(parents=True, exist_ok=True)
    cl, nv = cnf_clauses(n, [tuple(e) for e in edges] + [tuple(pair)], pins_b, [(2, 3)])
    cnf = SCR / 'xa-b.cnf'
    sha_b = write_cnf(cnf, cl, nv)
    proof = SCR / 'xa-b.lrat'
    rec, _ = run_solver([CADICAL, '-q', '--lrat=true', '--binary=false', str(cnf), str(proof)], 1800)
    print(f'fixture (b): pins {pins_b}, chain [2, 3]; CaDiCaL {rec}', flush=True)
    assert rec['verdict'] == 'UNSAT', 'fixture (b) did not refuse'
    tot, kept = trim_lrat(proof, db / 'witness.lrat.gz', len(cl))
    print(f'fixture (b): LRAT {tot} additions -> {kept} reachable; {os.path.getsize(db / "witness.lrat.gz")} gz bytes', flush=True)
    rk, _ = run_solver([KISSAT, '-q', str(cnf)], 1800)
    print(f'fixture (b): kissat on the same CNF: {rk}', flush=True)
    Wb = dict(base, pins=pins_b, precedence_chains=[[2, 3]], cnf_sha256=sha_b,
              proof=f'witness.lrat.gz: toolchain CaDiCaL 2.1.2 text LRAT for exactly this CNF, trimmed ({tot} -> {kept} additions)',
              solve={'cadical': rec, 'kissat': rk, 'machine': MACHINE})
    (db / 'witness.json').write_text(json.dumps(Wb))
    os.remove(cnf)
    os.remove(proof)
    return 0


# ================================================================ k1-fixture (no solver)
def cmd_k1_fixture():
    """K1's self-test fixtures at d = 47, from additive four-colourings phi : Lambda_M -> Z/4 found by enumeration (phi on the HNF rows,
    4^4 candidates, phi(u) != 0 on every unit vector): the additive witness, and the quotient witness at N = 4 it induces (the table
    of phi on Lambda/4Lambda, 4Lambda inside ker phi).  One gap-free (the origin sees all four colours) and one gapped, if they exist."""
    import itertools
    from fractions import Fraction as Fr
    sys.path.insert(0, str(ROOT / 'tools'))
    from fs58_local import units_d
    import fs73_screen as S
    d = 47
    od = OUT / 'k1-fixtures'
    od.mkdir(parents=True, exist_ok=True)
    wrote = {}
    for M in (24, 48, 36, 60):
        U = sorted(set(map(tuple, units_d(M, d))))
        H = [tuple(int(x) for x in h) for h in S.hnf(np.array(U, dtype=object), 4)]
        if len(H) != 4:
            continue
        A = [[Fr(H[j][i]) for j in range(4)] for i in range(4)]

        def coords(v):
            m = [row[:] + [Fr(v[i])] for i, row in enumerate(A)]
            for c in range(4):
                pv = next(r for r in range(c, 4) if m[r][c] != 0)
                m[c], m[pv] = m[pv], m[c]
                for r in range(4):
                    if r != c and m[r][c] != 0:
                        f = m[r][c] / m[c][c]
                        m[r] = [x - f * y for x, y in zip(m[r], m[c])]
            out = [m[i][4] / m[i][i] for i in range(4)]
            assert all(t.denominator == 1 for t in out)
            return [int(t) for t in out]
        CU = [coords(u) for u in U]
        for phi in itertools.product(range(4), repeat=4):
            vals = {sum(c * p for c, p in zip(cu, phi)) % 4 for cu in CU}
            if 0 in vals:
                continue
            tag = 'gapfree' if vals == {1, 2, 3} else 'gapped'
            if tag in wrote:
                continue
            base = {'lattice': f'Lambda_{M}', 'M': M, 'd': d, 'H': [list(h) for h in H], 'unit_count': len(U), 'k': 4,
                    'claims_gap': tag == 'gapped', 'source': 'tools/fs81_phaseD.py k1-fixture (enumeration, no solver)'}
            wa = dict(base, kind='additive', group='Z4', phi_on_H=list(phi))
            N = 4
            table = ''.join(str(sum(t * p for t, p in zip(tt, phi)) % 4) for tt in itertools.product(range(N), repeat=4))
            wq = dict(base, kind='quotient', N=N, basis=[list(h) for h in H], table=table)
            (od / f'L{M}-additive-{tag}.json').write_text(json.dumps(wa))
            (od / f'L{M}-quotient-N4-{tag}.json').write_text(json.dumps(wq))
            wrote[tag] = (M, phi, sorted(vals))
            print(f'  M {M}: {len(U)} units; phi {phi} on H, phi(U) = {sorted(vals)} -> {tag}', flush=True)
        if len(wrote) == 2:
            break
    print(f'k1-fixture: {wrote}')
    return 0 if wrote else 1


# ================================================================ D0a: the harvest (no solver)
SCHEMA = ('family', 'shape', 'R', 'n', 'm', 'd_ball', 'n4', 'd4', 'pins', 'precedence', 'solver', 'version', 'wall_s', 'machine',
          'verdict', 'cpu_s', 'wall_fired', 'cnf_sha256', 'source', 'note')


def ask_row(**kw):
    r = {k: kw.get(k) for k in SCHEMA}
    if r['n'] and r['m'] is not None and r['d_ball'] is None:
        r['d_ball'] = round(2 * r['m'] / r['n'], 3)
    extra = {k: v for k, v in kw.items() if k not in SCHEMA}
    if extra:
        r['extra'] = extra
    return r


def fired(rec, budget):
    if rec.get('verdict') != 'UNKNOWN':
        return False
    c = rec.get('cpu_s') or rec.get('wall_s') or 0
    return bool(budget) and c >= 0.95 * budget


def cmd_harvest():
    """every recorded four-colour ask named in S.D's D0a row (and the rest of the same records), one row each in the S B.1.1 schema;
    fields the record does not hold are null with a note; no solver is run"""
    out = []
    M73 = MACHINE
    # (1) FS-73's census force asks on de Grey's lattice balls (K-rows.jsonl): each row holds a plain control and the forcing ask
    K = load_jsonl(ROOT / 'data' / 'fs73' / 'census' / 'K-rows.jsonl')
    names = {'c:-16,8,8,0': 'v', '8/9': '8/9', '8/3': '8/3', '0': '0 (the pair is one point: a trivial refusal)'}
    for r in K:
        if not r['key'].startswith('force'):
            continue
        tgt = names.get(str(r.get('target')), str(r.get('target')))
        fam = 'X_A' if tgt == 'v' else f'X_delta(delta = {tgt})'
        pins = ('the pair (0, delta) to colours 0, 1' + (' and a common neighbour to 2 (a triangle through the extra edge)' if r.get('common_neighbours') else
                                                        ' (an edge pin on the extra edge; no common neighbour)'))
        prec = 'fs73 graph_cnf chain over the unpinned colours' + (' (none: one unpinned colour)' if r.get('common_neighbours') else ' [2, 3]')
        base = dict(shape='embedding-bounded ball of radius R about the pair\'s midpoint, its 4-core with the pair kept, + extra edge {0, delta}',
                    R=r['R'], n=r['points'], m=r['edges'] + 1, n4=r.get('core4_points'), machine=M73, version='kissat 4.0.4',
                    source=f'data/fs73/census/K-rows.jsonl {r["key"]}')
        f = r['forces']
        out.append(ask_row(family=fam, pins=pins, precedence=prec, solver=f.get('solver'), wall_s=f.get('budget_s'), verdict=f.get('verdict'),
                           cpu_s=f.get('cpu_s'), wall_fired=fired(f, f.get('budget_s')), cnf_sha256=f.get('cnf_sha256'),
                           note='the forcing ask (ball + extra edge)', **base))
        c = r['control']
        if 'how' in c:          # decided by an exhibited colouring (Theorem B's residue colouring), not by a solver: not an ask
            out.append(ask_row(family='colourable: Cay(Lambda_dG, U) ball', pins=None, precedence=None, solver=None, verdict='SAT (exhibited)',
                               cpu_s=None, note=f'NOT A SOLVER ASK: {c["how"]}', **dict(base, m=r['edges'])))
            continue
        out.append(ask_row(family='colourable: Cay(Lambda_dG, U) ball', pins='origin 0, its least neighbour 1, a triangle vertex 2 (fs73 forcing_ask)',
                           precedence='fs73 graph_cnf chain over the unpinned colours (none: one unpinned colour)',
                           solver=c.get('solver'), wall_s=c.get('budget_s'), verdict=c.get('verdict'), cpu_s=c.get('cpu_s'),
                           wall_fired=fired(c, c.get('budget_s')), cnf_sha256=c.get('cnf_sha256'),
                           note='the plain control of the same ball (no extra edge); four-colourable by Theorem B', **dict(base, m=r['edges'])))
    # (2) X_A's core rounds (FS73-T6's certificate): assumption-core rounds, pysat CaDiCaL 1.9.5
    for st in load_jsonl(XA_CERT / 'steps.jsonl'):
        if not st['step'].startswith('core-round'):
            continue
        out.append(ask_row(family='X_A', shape='core round: the induced subgraph on the kept set + extra edge, selector per unpinned vertex',
                           R=1.5, n=st['points_in'], m=st['edges_in'], pins='the pair and a common neighbour (triangle)',
                           precedence='none (one unpinned colour)', solver=st['solver'], version='CaDiCaL 1.9.5 (pysat Cadical195)',
                           wall_s=st.get('budget_s'), machine=st.get('machine'), verdict=st['verdict'], cpu_s=st.get('cpu_s'),
                           wall_fired=fired(st, st.get('budget_s')), source=f'data/fs73/census/cert/t-16_8_8_0-R1.5/steps.jsonl {st["step"]}',
                           note=f'points out {st.get("points_out")}; the last round is the certified 2,044-point core (d_c 10.47)'))
    # (3) FS-73 P1d's independent re-asks on the same R = 1.5 ball (verify-P1d-asks.jsonl), solver rows only
    for r in load_jsonl(ROOT / 'data' / 'fs73' / 'records' / 'verify-P1d-asks.jsonl'):
        if 'verdict' not in r:
            continue
        tgt = {'v': 'v', 'eight_ninths': '8/9', 'harder_eight_thirds': '8/3', 'two': '2', 'four_ninths': '4/9'}[r['pair']]
        brk = r.get('cnf_path', '').split('-')[-2] if r.get('cnf_path') else None
        refusing = tgt in ('v', '8/9', '8/3')
        out.append(ask_row(family='X_A' if tgt == 'v' else f'X_delta(delta = {tgt})' + ('' if refusing else ' [negative control: not forced]'),
                           shape='embedding-bounded ball R = 1.5 about the pair\'s midpoint + extra edge (the verifier\'s own rebuild)',
                           R=1.5, n=39829, m=366660 + 1, n4=39829, pins=f'the verifier\'s break "{brk}" (nb: pair + a neighbour; cn: pair + '
                           'common neighbour; none: the pair only)', precedence='none recorded', solver=r['solver'], version=r['solver'],
                           wall_s=r.get('budget_s'), machine=MACHINE, verdict=r['verdict'], cpu_s=r.get('cpu_s_solver', r.get('cpu_s_process')),
                           wall_fired=fired({'verdict': r['verdict'], 'cpu_s': r.get('wall_s')}, r.get('budget_s')),
                           cnf_sha256=(r.get('cnf') or '').split("'sha256': '")[-1][:64] if isinstance(r.get('cnf'), str) else None,
                           source=f'data/fs73/records/verify-P1d-asks.jsonl pair {r["pair"]}', note='DRUP-verified by drat-trim' if r['verdict'] == 'UNSAT' else None))
    # (4) FS-73's quotient asks on de Grey's lattice (K-rows seeded/cold/confirm): Cay(Lambda/W, U mod W), not balls
    for r in K:
        if r['key'].split(':')[0] not in ('seeded', 'cold', 'confirm') or 'verdict' not in r:
            continue
        out.append(ask_row(family='quotient: Cay(Lambda_dG/W, U)', shape=f'finite quotient, W = {r.get("W")}', n=r.get('classes'), m=r.get('edges'),
                           n4=r.get('classes'), pins=r.get('note'), precedence='fs73 chain over unpinned colours', solver=r.get('solver'),
                           version=r.get('solver'), wall_s=r.get('budget_s'), machine=r.get('machine'), verdict=r.get('verdict'), cpu_s=r.get('cpu_s'),
                           wall_fired=fired(r, r.get('budget_s')), cnf_sha256=r.get('cnf_sha256'), source=f'data/fs73/census/K-rows.jsonl {r["key"]}',
                           note=f'aim {r.get("aim")}; a regular Cayley graph: the 4-core is the whole graph'))
    # (5) the held unit-distance witnesses (cores; refusal times are not on record in machine-readable form)
    for name, path, n, d in (('Heule-510', 'tools/heule510.json', 510, 9.82), ('Heule-553', 'tools/heule553.json', 553, 9.84),
                             ("de Grey's 1581", 'tools/degrey_cert.json', 1581, 9.96)):
        out.append(ask_row(family='X_W (held unit-distance witnesses)', shape='a minimal-ish core, no radius', n=n, d_ball=d, n4=n, d4=d,
                           pins=None, precedence=None, solver=None, verdict='UNSAT (known: chi = 5, kernel for Heule-510)', cpu_s=None,
                           source=path, note='d measured at stage B (plan S B.1.2); no timed four-colour ask of this object is on record'))
    # (6) FS79-T5: G(Z, {1,3,7,12,17,22}) on consecutive points (bench_recheck.py; times not recorded)
    for L, v in ((33, 'UNSAT'), (32, 'SAT')):
        m = sum(1 for i in range(L) for dd in (1, 3, 7, 12, 17, 22) if i + dd < L)
        out.append(ask_row(family='T5 (instrument control; refutation rank 1)', shape=f'{L} consecutive integers', n=L, m=m, n4=None,
                           pins='none', precedence='none', solver='pysat Glucose4 (bisection), Minisat22 agreeing', verdict=v, cpu_s=None,
                           source='data/fs79/checks/bench_recheck.py; plans/FS79-derivation.md T5', note='seconds; not recorded'))
    # (7) FS-79 at 167: quotient asks (phase 0, controls, P3b) and the solver-decided target asks at 23
    for fn, tag in (('data/fs79/phase0/quotients.jsonl', 'P0'), ('data/fs79/phase0/controls-quotients.jsonl', 'P0 controls'),
                    ('data/fs79/p3b/quotients.jsonl', 'P3b')):
        for r in load_jsonl(ROOT / fn):
            if 'verdict' not in r:
                continue
            k = r.get('key', '')
            fam = 'colourable: Cay(Lambda_dG, U) quotient' if k.startswith('K|') else f'Q(sqrt167) lattice quotient ({k.split("|")[1] if "|" in k else "?"})'
            out.append(ask_row(family=fam, shape=f'finite quotient Cay(Lambda/NLambda, U), W = {r.get("W")}', n=r.get('classes'), m=r.get('edges'),
                               n4=r.get('classes'), pins=r.get('note'), precedence='chain over unpinned colours (fs73 graph_cnf)', solver=r.get('solver'),
                               version=r.get('solver'), wall_s=r.get('budget_s'), machine=r.get('machine'), verdict=r.get('verdict'),
                               cpu_s=r.get('cpu_s'), wall_fired=fired(r, r.get('budget_s')), cnf_sha256=r.get('cnf_sha256'),
                               source=f'{fn} {k}', note=f'FS-79 {tag}; aim {r.get("aim")}'))
    for r in load_jsonl(ROOT / 'data' / 'fs79' / 'phase0' / 'screen.jsonl'):
        if not r['screen'].startswith('residue') or not str(r.get('plain_by', '')).startswith('kissat'):
            continue
        q, img = r['q'], r['image']
        out.append(ask_row(family=f'Q(sqrt167) residue target at {q} (image of U_M)', shape=f'Cay(F_{q}^2, image), {img} generators', n=q * q,
                           m=q * q * img // 2, n4=q * q, pins=r['plain_by'], precedence='as in the pins line', solver='kissat', version='kissat 4.0.4',
                           wall_s=None, machine=r.get('machine'), verdict=r['plain'], cpu_s=None, wall_fired=None,
                           source=f'data/fs79/phase0/screen.jsonl {r["lattice"]} {r["screen"]}', note='CPU not recorded; UNKNOWN = the budget in the pins line'))
    for r in load_jsonl(ROOT / 'data' / 'fs79' / 'phase0' / 'classify-q23-k4.jsonl'):
        if not str(r.get('by', '')).startswith('kissat') or r.get('what') != 'orbit':
            continue
        img = sum(2 if o else 1 for o in r['orbit'])       # rough: the recorded orbit list names circle representatives, not the set size
        out.append(ask_row(family='Gamma_23 subgraphs (classify, k = 4)', shape='Cay(F_23^2, S), S an antipodal circle subset', n=529, m=None,
                           n4=529, pins=r['by'], precedence='as in the pins line', solver='kissat', version='kissat 4.0.4', wall_s=60.0, machine=MACHINE,
                           verdict=r['verdict'], cpu_s=r.get('cpu_s'), wall_fired=None, source='data/fs79/phase0/classify-q23-k4.jsonl',
                           note=f'orbit {r["orbit"]}; replication {r.get("replication")}; |S| not recorded as a number, so d is left null'))
    path = OUT / 'd0a-harvest.jsonl'
    with open(path, 'w') as f:
        for r in out:
            f.write(json.dumps(r, sort_keys=True) + '\n')
    # the summary: per family, verdict counts and d bins
    import collections
    fams = collections.OrderedDict()
    for r in out:
        fams.setdefault(r['family'], []).append(r)
    print(f'D0a harvest: {len(out)} asks -> {path.relative_to(ROOT)}')
    print('| family | asks | SAT | UNSAT | UNKNOWN | d range | CPU s range (decided) |')
    print('|---|---|---|---|---|---|---|')
    for fam, rs in fams.items():
        cnt = collections.Counter(str(r['verdict']).split(' ')[0] for r in rs)
        ds = [r['d_ball'] for r in rs if r['d_ball'] is not None]
        cs = [r['cpu_s'] for r in rs if r['cpu_s'] is not None and str(r['verdict']).split(' ')[0] in ('SAT', 'UNSAT')]
        print(f'| {fam} | {len(rs)} | {cnt.get("SAT", 0)} | {cnt.get("UNSAT", 0)} | {cnt.get("UNKNOWN", 0)} | '
              f'{(f"{min(ds):.2f}-{max(ds):.2f}" if ds else "-")} | {(f"{min(cs):.2f}-{max(cs):.2f}" if cs else "-")} |')
    return 0


# ================================================================ D0b: the rank-4 ladder
LADDER = OUT / 'd0b-asks.jsonl'
XA_TARGET = 'c:-16,8,8,0'          # v = -(4/9)(1 + sqrt-11) in fs73_lattice's reduced Hermite coordinates (FS73-T6's target)


def degrey_graphs(R):
    """X_A, X_B and the colourable graph on ONE point set: the embedding-bounded ball of radius R about the midpoint of the pair
    (0, v), shifted so the pair is (0, v) -- exactly fs73_certify.build's construction.  Returns the points (lattice coordinates),
    the unit edges, the v-translate edges, and the pair's indices."""
    sys.path.insert(0, str(ROOT / 'tools'))
    import fs73_screen as S
    lat, r, T = S.degrey_setup()
    delta = S.parse_target(lat, XA_TARGET)
    half = tuple(x // 2 for x in delta)
    assert all(x % 2 == 0 for x in delta)
    pts = [tuple(p + h for p, h in zip(q, half)) for q in S.minkowski_ball(lat, R)]
    idx, E = S.ball_graph(pts, lat.U)
    o, dl = idx[tuple([0] * r)], idx[delta]
    V = sorted({(min(i, idx[q]), max(i, idx[q])) for i, p in enumerate(pts) for q in [tuple(a + b for a, b in zip(p, delta))] if q in idx})
    return pts, [tuple(e) for e in E.tolist()], V, o, dl, lat


def core4(n, edges, keep):
    adj = [[] for _ in range(n)]
    for i, j in edges:
        adj[i].append(j)
        adj[j].append(i)
    deg = [len(a) for a in adj]
    alive = [True] * n
    stack = [v for v in range(n) if deg[v] < 4 and v not in keep]
    while stack:
        v = stack.pop()
        if not alive[v]:
            continue
        alive[v] = False
        for w in adj[v]:
            if alive[w]:
                deg[w] -= 1
                if deg[w] < 4 and w not in keep:
                    stack.append(w)
    kept = [v for v in range(n) if alive[v]]
    ren = {v: k for k, v in enumerate(kept)}
    return kept, sorted((ren[i], ren[j]) for i, j in edges if alive[i] and alive[j]), ren


def ladder_tasks(radii, only=None):
    """(key, builder) for every D0b ask; a builder returns (graph meta, n4, edges4, pins, chains)"""
    tasks = []
    for R in radii:
        for fam, enc in (('X_A', 'target'), ('X_A', 'triangle'), ('X_B', 'target'), ('colourable', 'target')):
            key = f'{fam}|{enc}|R{R}'
            if only and not any(o in key for o in only):
                continue
            tasks.append((key, ('degrey', fam, enc, R)))
    return tasks


_DG = {}


def build_degrey(fam, enc, R):
    if R not in _DG:
        _DG[R] = degrey_graphs(R)
    pts, U, V, o, dl, lat = _DG[R]
    n = len(pts)
    if fam == 'X_A':
        E = sorted(set(U) | {(min(o, dl), max(o, dl))})
        keep = {o, dl}
        shape = 'embedding-bounded ball about the midpoint of (0, v), shifted; unit edges + the ONE edge {0, v}'
    elif fam == 'X_B':
        E = sorted(set(U) | set(V))
        keep = {o, dl}
        shape = 'the same ball; unit edges + EVERY v-translate edge {p, p + v} inside it (balls of Cay(Lambda_dG, U u {+-v}))'
    else:
        E = sorted(set(U))
        keep = {o}
        shape = 'the same ball; unit edges only (Cay(Lambda_dG, U), four-colourable by Theorem B)'
    kept, E4, ren = core4(n, E, keep)
    o4 = ren[o]
    Uset = set(U)
    # the least UNIT neighbour of 0 in the 4-core (never the pair partner, whose edge is not unit)
    nb = min(ren[j] for j in range(n) if j in ren and (min(o, j), max(o, j)) in Uset)
    if enc == 'target':
        pins, chains = [o4, nb], [(2, 3)]
        pdesc = 'unit-edge pin: the pair\'s first point 0 (colour 0) and its least unit neighbour (colour 1); chain [2, 3]'
    else:
        d4 = ren[dl]
        n0 = {j for i, j in E4 if i == o4} | {i for i, j in E4 if j == o4}
        nd = {j for i, j in E4 if i == d4} | {i for i, j in E4 if j == d4}
        cm = sorted((n0 & nd) - {o4, d4})
        pins, chains = [o4, d4] + cm[:1], []
        pdesc = 'triangle pin (FS73-T6\'s): 0, v and their least common neighbour to colours 0, 1, 2; no chain (one unpinned colour)'
    core_pts = {tuple(pts[v]) for v in kept}
    meta = {'family': {'X_A': 'X_A', 'X_B': 'X_B', 'colourable': 'colourable: Cay(Lambda_dG, U) ball'}[fam], 'shape': shape, 'R': R, 'n': n,
            'm': len(E), 'n4': len(kept), 'm4': len(E4), 'pins': pdesc, 'precedence': 'chain [2, 3] over the unpinned colours' if chains else 'none'}
    if fam in ('X_A', 'X_B'):
        W = json.load(open(XA_CERT / 'witness.json'))
        lc = [tuple(c) for c in W['provenance']['lattice_coordinates']]
        meta['contains_certified_core'] = all(c in core_pts for c in lc)
    return meta, len(kept), E4, pins, chains


def int_graphs(which, L):
    """FS79-T5 (G(Z, {1,3,7,12,17,22}) on L consecutive points) and T7 (the same times a path of 2: Cay(Z^2, (+-d, 0), (0, +-1)) on L x 2)"""
    D = (1, 3, 7, 12, 17, 22)
    if which == 'T5':
        return L, sorted((i, i + d) for i in range(L) for d in D if i + d < L)
    idx = lambda i, j: 2 * i + j          # noqa: E731
    E = [(idx(i, j), idx(i + d, j)) for i in range(L) for j in range(2) for d in D if i + d < L] + [(idx(i, 0), idx(i, 1)) for i in range(L)]
    return 2 * L, sorted((min(a, b), max(a, b)) for a, b in E)


def run_ask(cmd, wall, logpath):
    """one solver process, its own rusage (os.wait4), killed at the wall; the status line read from its output file"""
    t0 = time.time()
    with open(logpath, 'w') as lg:
        p = subprocess.Popen(cmd, stdout=lg, stderr=subprocess.STDOUT)
    fired = False
    while True:
        pid, st, ru = os.wait4(p.pid, os.WNOHANG)
        if pid:
            break
        if time.time() - t0 > wall:
            p.kill()
            pid, st, ru = os.wait4(p.pid, 0)
            fired = True
            break
        time.sleep(0.2)
    rc = os.waitstatus_to_exitcode(st)
    out = open(logpath).read()
    if fired:
        v, sline = 'UNKNOWN', None
    else:
        v, sline = status(out, rc)
    rec = {'verdict': v, 'wall_s': round(time.time() - t0, 2), 'cpu_s': round(ru.ru_utime + ru.ru_stime, 2), 'maxrss_mb': round(ru.ru_maxrss / 1024),
           'wall_fired': fired}
    if v == 'UNKNOWN':
        rec['unknown_type'] = f'the wall fired at {wall} s' if fired else f'no verdict: {sline!r} (exit {rc})'
    return rec, out


def model_check(out, n, E, pins, k=4):
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(t) for t in line[2:].split()]
    pos = {l for l in lits if l > 0}
    col = []
    for v in range(n):
        cs = [c for c in range(k) if k * v + c + 1 in pos]
        if not cs:
            return f'vertex {v} has no colour'
        col.append(cs[0])
    bad = sum(1 for i, j in E if col[i] == col[j])
    pin_ok = all(col[v] == c for c, v in enumerate(pins))
    return 'proper, pins respected' if bad == 0 and pin_ok else f'IMPROPER: {bad} monochromatic edges, pins ok {pin_ok}'


def cmd_ladder(radii, workers, wall, only, second):
    import threading
    from concurrent.futures import ThreadPoolExecutor
    done = {r['key'] for r in load_jsonl(LADDER) if r.get('verdict') in ('SAT', 'UNSAT', 'UNKNOWN')}
    tasks = [t for t in ladder_tasks(radii, only) if t[0] not in done]
    # the instrument controls (plan S.D: T5 and T7 once each; the wall on a plant; the pins never refuse a colourable graph)
    ctl = [('T5|target|L32', ('int', 'T5', 32)), ('T5|target|L33', ('int', 'T5', 33)), ('T7|target|L32x2', ('int', 'T7', 32)),
           ('T7|target|L33x2', ('int', 'T7', 33)), ('control:wall-plant|colourable|target|R1.0', ('degrey', 'colourable', 'target', 1.0))]
    if not only:
        tasks = [t for t in ctl if t[0] not in done] + tasks
    lock = threading.Lock()
    inflight = [0]
    print(f'D0b ladder: {len(tasks)} asks to run ({len(done)} already recorded); {workers} at a time; wall {wall} s', flush=True)
    # build every graph in the parent first (the builders share the ball cache and are not thread-safe)
    built = []
    for key, spec in tasks:
        if spec[0] == 'degrey':
            meta, n, E, pins, chains = build_degrey(*spec[1:])
        else:
            n, E = int_graphs(spec[1], spec[2])
            pins, chains = [0, 1] if spec[1] == 'T5' else [0, 2], [(2, 3)]
            meta = {'family': f'{spec[1]} (instrument control; refutation rank 1)', 'shape': f'{spec[2]} consecutive integers' + (' x 2' if spec[1] == 'T7' else ''),
                    'R': None, 'n': n, 'm': len(E), 'n4': n, 'm4': len(E), 'pins': 'an edge pinned to 0, 1; chain [2, 3]',
                    'precedence': 'chain [2, 3] over the unpinned colours'}
        cl, nv = cnf_clauses(n, E, pins, chains)
        path = SCR / f'd0b-{abs(hash(key)) % 10**10}.cnf'
        sha = write_cnf(path, cl, nv)
        meta.update({'d_ball': round(2 * meta['m'] / meta['n'], 3), 'd4': round(2 * meta['m4'] / meta['n4'], 3) if meta['n4'] else None})
        built.append((key, meta, n, E, pins, chains, path, sha))
        print(f'  built {key}: n {meta["n"]}, d_ball {meta["d_ball"]}, 4-core {meta["n4"]} at {meta["d4"]}' +
              (f', contains the certified core: {meta["contains_certified_core"]}' if 'contains_certified_core' in meta else ''), flush=True)
    _DG.clear()

    def one(item):
        key, meta, n, E, pins, chains, path, sha = item
        w = 3.0 if key.startswith('control:wall-plant') else wall
        with lock:
            inflight[0] += 1
            load = inflight[0]
        rec, out = run_ask([KISSAT, '-q', str(path)], w, str(path) + '.log')
        with lock:
            inflight[0] -= 1
        row = dict(meta, key=key, solver='kissat', version='kissat 4.0.4', wall_s_budget=w, machine=MACHINE, workers=workers,
                   in_flight_at_start=load, cnf_sha256=sha, **rec)
        if rec['verdict'] == 'SAT':
            row['model_check'] = model_check(out, n, E, pins)
        if key.startswith('control:wall-plant'):
            row['control_verdict'] = 'PASS' if rec['wall_fired'] and rec['verdict'] == 'UNKNOWN' else 'FAIL: the wall did not fire'
        if rec['verdict'] == 'UNSAT' and second:
            r2, _ = run_ask([CADICAL, '-q', str(path)], wall, str(path) + '.cad.log')
            row['second_solver'] = dict(r2, solver='CaDiCaL 2.1.2 (toolchain)')
        with lock:
            append(LADDER, row)
        os.remove(str(path) + '.log')
        if os.path.exists(str(path) + '.cad.log'):
            os.remove(str(path) + '.cad.log')
        os.remove(path)
        print(f'  {key}: {rec["verdict"]} {rec["cpu_s"]} s CPU (load {load})' + (f'; second solver {row["second_solver"]["verdict"]} '
              f'{row["second_solver"]["cpu_s"]} s' if 'second_solver' in row else '') + (f'; model {row.get("model_check")}' if 'model_check' in row else '')
              + (f'; {row["control_verdict"]}' if 'control_verdict' in row else ''), flush=True)
        return row

    with ThreadPoolExecutor(max_workers=workers) as ex:
        list(ex.map(one, built))
    print('DONE ladder', flush=True)
    return 0


def cmd_reask(key, times, wall):
    """a number that enters a decision (t_A, the matched control, d*): the ask re-run ALONE, `times` times in sequence, each a fresh
    kissat on the same CNF; rows appended to d0b-reask.jsonl with load 1; the minimum CPU s is the decision number (CLAUDE.md
    S Toolchain: CPU seconds, minimum of three, machine named).  Run it under the heavy lock with nothing else of ours running."""
    fam, enc, R = key.split('|')
    R = float(R[1:])
    meta, n, E, pins, chains = build_degrey({'X_A': 'X_A', 'X_B': 'X_B', 'colourable': 'colourable'}[fam], enc, R)
    cl, nv = cnf_clauses(n, E, pins, chains)
    path = SCR / f'reask-{os.getpid()}.cnf'
    sha = write_cnf(path, cl, nv)
    meta.update({'d_ball': round(2 * meta['m'] / meta['n'], 3), 'd4': round(2 * meta['m4'] / meta['n4'], 3)})
    have = [r for r in load_jsonl(OUT / 'd0b-reask.jsonl') if r['key'] == key and r['cnf_sha256'] == sha]
    cpus = [r['cpu_s'] for r in have if r['verdict'] != 'UNKNOWN']
    for t in range(len(have), times):
        rec, out = run_ask([KISSAT, '-q', str(path)], wall, str(path) + '.log')
        row = dict(meta, key=key, repeat=t + 1, solver='kissat', version='kissat 4.0.4', wall_s_budget=wall, machine=MACHINE, workers=1,
                   in_flight_at_start=1, quiet=True, cnf_sha256=sha, **rec)
        append(OUT / 'd0b-reask.jsonl', row)
        print(f'  {key} repeat {t + 1}: {rec["verdict"]} {rec["cpu_s"]} s CPU', flush=True)
        if rec['verdict'] != 'UNKNOWN':
            cpus.append(rec['cpu_s'])
        os.remove(str(path) + '.log')
    os.remove(path)
    print(f'DONE reask {key}: min CPU {min(cpus) if cpus else None} s over {len(cpus)} decided runs', flush=True)
    return 0


def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        return 2
    SCR.mkdir(parents=True, exist_ok=True)
    if a[0] == 'k2-fixture':
        return cmd_k2_fixture()
    if a[0] == 'k1-fixture':
        return cmd_k1_fixture()
    if a[0] == 'harvest':
        return cmd_harvest()
    if a[0] == 'reask':
        return cmd_reask(a[1], int(a[2]) if len(a) > 2 else 3, float(a[3]) if len(a) > 3 else 1800.0)
    if a[0] == 'ladder':
        import argparse
        ap = argparse.ArgumentParser()
        ap.add_argument('cmd')
        ap.add_argument('--radii', default='1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7')
        ap.add_argument('--workers', type=int, default=8)
        ap.add_argument('--wall', type=float, default=1800.0)
        ap.add_argument('--only', default=None)
        ap.add_argument('--no-second', action='store_true')
        g = ap.parse_args(a)
        return cmd_ladder([float(x) for x in g.radii.split(',')], g.workers, g.wall, g.only.split(',') if g.only else None, not g.no_second)
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
