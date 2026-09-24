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
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
