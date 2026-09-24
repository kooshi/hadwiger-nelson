#!/usr/bin/env python3
"""fs79_p3b_theta4 -- FS-79 phase P3b: the exact Θ_k tool of phase P3 aimed at phase 0's survivors Λ_M over Q(sqrt167).

UNTRUSTED (tools/).  Imports last night's tools/fs79_p3_theta4.py, tools/fs79_p0_check.py, tools/fs79_p0.py and FS-73's code
read-only and never edits them; writes only data/fs79/p3b/ and the scratch directory.  Record: data/fs79/records/phase-P3b-survivors.md.

    Θ_k(Λ) = {θ ∈ Hom(Λ, R) : θ(u) mod 1 ∈ [1/k, 1 - 1/k] for every u ∈ U},   margin(θ) = min_u ‖θ(u)‖_{R/Z} - 1/k.

A point with margin > 0 lies in a full-dimensional cell, so (P3's five-step argument) Λ is four-colourable and LOOSE (F = P = 0); a point
with margin 0 is a four-colouring from a lower-dimensional cell (T22's <= half); an exhausted exact tree with Farkas leaves certifies
Θ_k = ∅ (no circular colouring -- NOT a refusal of k colours).

THE FRAME (any M).  U = units_be(M, 167) (tools/fs79_p0_check.py); H = hnf(U); a reduced Z-basis B of Λ = span U by FS-73's dual LLL
(as in P3's frame); C = the half-set's coordinates in B.  Checked both ways: every row of B has integer coordinates in H and |det| = 1
there (B is a Z-basis of span H = Λ), and every unit vector has integer coordinates in B equal to C (U ⊆ span B).

THE FINDER.  Maximise the margin t over (x ∈ [0,1]^4, t, bands j ∈ Z^pairs): j_u + 1/k + t <= c_u.x <= j_u + 1 - 1/k - t, with t >= 0
(only points of Θ_k are wanted).  This is a branch over the integer band choices guided by LP relaxations -- HiGHS's branch-and-cut
(scipy.optimize.milp), which PROPOSES a band vector.  The proposal is then re-solved EXACTLY (Fractions): the exact maximum margin t* of
that cell and a rational point; t* is what is reported, never the float.  A float claim of infeasibility is recorded as 'EMPTY per
HiGHS (float, not a certificate)'.

Subcommands (each resumable: one fsynced JSON line per finished (lattice, step) in data/fs79/p3b/steps.jsonl; a done line is skipped):
  frame  --ids ...                    the frame of each lattice, checked both ways
  find   --ids ... [--k K] [--cap S]  the finder; witnesses to data/fs79/p3b/witnesses/, each run through tools/fs79_p0_check.py
  cell   --ids ...                    the exact cell analysis (dimension, constant set) of each margin-0 witness's cell
  quot   --ids ... [--nmin 13 --nmax 24 --budget 300 --total 1800]   full quotients Λ/NΛ, gap-aimed first (phase 0's code by import)
ids: 'L21cc6506' (= Λ_420) or M.  'minimal' = the seven minimal survivors, smallest first; 'upper' = the five containing Λ_4200.
"""
from __future__ import annotations

import argparse
import json
import math
import os
import subprocess
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs79_p0_check import units_be, hnf, coords_in            # noqa: E402  (read-only)
from fs79_p3_theta4 import det_int, inverse, cell_analysis    # noqa: E402  (read-only; P3's builder)
from fs73_theta_lib import exact_lp_max                        # noqa: E402  (read-only)

D = 167
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(REPO, 'data', 'fs79', 'p3b')
STEPS = os.path.join(OUT, 'steps.jsonl')
WIT = os.path.join(OUT, 'witnesses')
SCR = '/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-p3b'
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'
MINIMAL = [2448, 2328, 2400, 4200, 10920, 14280, 24360]
UPPER = [12600, 16800, 21000, 25200, 29400]


# ============================================================================================ records
def append_line(rec):
    os.makedirs(OUT, exist_ok=True)
    rec = dict(rec, machine=MACHINE, at=time.strftime('%Y-%m-%dT%H:%M:%S%z'))
    with open(STEPS, 'a') as f:
        f.write(json.dumps(rec, separators=(',', ':'), default=str) + '\n')
        f.flush()
        os.fsync(f.fileno())
    return rec


def done_steps():
    out = {}
    if os.path.exists(STEPS):
        for line in open(STEPS):
            if line.strip():
                try:
                    r = json.loads(line)
                except json.JSONDecodeError:
                    continue                                   # a torn last line: the step is redone
                out[(str(r['lattice']), r['step'])] = r
    return out


def mval(lid):
    return 420 if str(lid) == 'L21cc6506' else int(lid)


# ============================================================================================ the frame
def neg(u):
    return tuple(-t for t in u)


def frame(M):
    """(U, H, half, B, C): a reduced Z-basis B of Λ_M and the half-set's coordinates C in B, checked both ways"""
    from fs73_theta_cert import dual_reduce               # read-only import
    U = sorted(units_be(M, D))
    H = hnf(U)
    assert len(H) == 4, f'rank {len(H)}'
    half = [u for u in U if u > neg(u)]
    assert 2 * len(half) == len(U)
    CH = [coords_in(H, u) for u in half]
    assert all(c is not None for c in CH)
    Wr = dual_reduce(CH, 4)
    assert abs(det_int(Wr)) == 1
    C = [[sum(w[i] * c[i] for i in range(4)) for w in Wr] for c in CH]
    Wi = inverse(Wr)
    B = [tuple(int(sum(Wi[i][j] * H[i][t] for i in range(4))) for t in range(4)) for j in range(4)]
    # both ways: B ⊆ Λ with |det| 1 in Hermite coordinates (a Z-basis of Λ), and every unit vector integral in B with coordinates C
    BH = [coords_in(H, b) for b in B]
    assert all(r is not None for r in BH) and abs(det_int(BH)) == 1, 'B is not a Z-basis of span H'
    assert hnf(list(B)) == H, 'hnf(B) != H'
    assert all(coords_in(B, u) == C[n] for n, u in enumerate(half)), 'a unit vector is not integral in B'
    return U, H, half, B, C


# ============================================================================================ margins, exactly
def margin_exact(C, x, k):
    """min over the half-set of (circular distance of c.x from 0) - 1/k, exactly"""
    m = None
    for c in C:
        v = sum(Fr(ci) * xi for ci, xi in zip(c, x))
        f = v - math.floor(v)
        d = min(f, 1 - f) - Fr(1, k)
        m = d if m is None or d < m else m
    return m


def cell_max_margin(C, js, k):
    """the exact maximum margin t* over the cell with bands js, and a maximiser x (exact LP in (x, t))"""
    A, b = [], []
    for c, j in zip(C, js):
        A.append([-Fr(t) for t in c] + [Fr(1)]); b.append(-(j + Fr(1, k)))
        A.append([Fr(t) for t in c] + [Fr(1)]); b.append(j + 1 - Fr(1, k))
    st, z, y = exact_lp_max(A, b, [Fr(0)] * 4 + [Fr(1)])
    if st == 'infeasible':
        return None, None
    assert st == 'optimal', st
    return z[4], z[:4]


def nice_point(C, x, k, want_pos):
    """a rational point near x with small denominators and margin > 0 (want_pos) or >= 0, else x itself"""
    order = lambda z: math.lcm(*[t.denominator for t in z])            # noqa: E731
    best = (order(x), x, margin_exact(C, x, k))
    for den in (2, 3, 4, 6, 8, 12, 24, 60, 120, 240, 420, 840, 1000, 2520, 10 ** 4, 10 ** 5, 10 ** 6, 10 ** 7):
        y = [xi.limit_denominator(den) for xi in x]
        m = margin_exact(C, y, k)
        if ((m > 0) if want_pos else (m >= 0)) and order(y) < best[0]:
            best = (order(y), y, m)
    return best[1], best[2]


# ============================================================================================ the finder (HiGHS proposes)
def mip_find(C, k, cap, tmin=0.0):
    import numpy as np
    from scipy.optimize import milp, LinearConstraint, Bounds
    from scipy.sparse import lil_matrix
    n = len(C)
    nv = 5 + n
    A = lil_matrix((2 * n, nv))
    lo, hi = np.empty(2 * n), np.empty(2 * n)
    for i, c in enumerate(C):
        for t in range(4):
            A[2 * i, t] = c[t]; A[2 * i + 1, t] = c[t]
        A[2 * i, 4] = -1.0; A[2 * i, 5 + i] = -1.0          # c.x - j - t >= 1/k
        lo[2 * i], hi[2 * i] = 1.0 / k, np.inf
        A[2 * i + 1, 4] = 1.0; A[2 * i + 1, 5 + i] = -1.0   # c.x - j + t <= 1 - 1/k
        lo[2 * i + 1], hi[2 * i + 1] = -np.inf, 1.0 - 1.0 / k
    jl = [math.floor(sum(min(0, t) for t in c)) - 1 for c in C]
    jh = [math.ceil(sum(max(0, t) for t in c)) + 1 for c in C]
    bl = np.r_[np.zeros(4), tmin, jl]
    bh = np.r_[np.ones(4), 0.5 - 1.0 / k, jh]
    obj = np.zeros(nv); obj[4] = -1.0
    integ = np.r_[np.zeros(5), np.ones(n)]
    t0 = time.time()
    res = milp(obj, constraints=LinearConstraint(A.tocsr(), lo, hi), integrality=integ, bounds=Bounds(bl, bh),
               options={'time_limit': float(cap), 'disp': False, 'mip_rel_gap': 0.0})
    sec = round(time.time() - t0, 1)
    info = {'status': int(res.status), 'message': str(res.message), 'seconds': sec,
            'nodes': int(getattr(res, 'mip_node_count', -1) or -1),
            'dual_bound_margin': (None if getattr(res, 'mip_dual_bound', None) is None else -float(res.mip_dual_bound))}
    if res.x is None:
        return info, None
    info['float_margin'] = float(res.x[4])
    js = [int(round(v)) for v in res.x[5:]]
    return info, js


def witness(lid, M, H, U, B, x, k, note):
    return {'lattice': str(lid), 'M': M, 'd': D, 'H': [list(h) for h in H], 'unit_count': len(U), 'k': k, 'kind': 'linear',
            'claims_gap': False, 'basis': [list(b) for b in B], 'theta_on_basis': [str(t) for t in x], 'note': note}


def run_checker(path):
    p = subprocess.run([sys.executable, os.path.join(REPO, 'tools', 'fs79_p0_check.py'), path], capture_output=True, text=True)
    return p.returncode, (p.stdout + p.stderr).strip()


def cmd_frame(ids):
    have = done_steps()
    for lid in ids:
        if (str(lid), 'frame') in have:
            print('frame', lid, 'done', flush=True)
            continue
        M = mval(lid)
        t0 = time.time()
        U, H, half, B, C = frame(M)
        l1 = [sum(map(abs, c)) for c in C]
        r = append_line({'lattice': str(lid), 'M': M, 'step': 'frame', 'units': len(U), 'H': [list(h) for h in H],
                         'basis': [list(b) for b in B], 'l1_max': max(l1), 'l1_median': sorted(l1)[len(l1) // 2],
                         'seconds': round(time.time() - t0, 1), 'checks': 'B in Λ with |det| 1 in H; hnf(B) = H; C integral'})
        print(json.dumps({k_: r[k_] for k_ in ('lattice', 'units', 'l1_max', 'l1_median', 'seconds')}), flush=True)


def cmd_find(ids, k, cap, tag):
    have = done_steps()
    os.makedirs(WIT, exist_ok=True)
    step = f'find-k{k}' + (f'-{tag}' if tag else '')
    for lid in ids:
        if (str(lid), step) in have:
            print(step, lid, 'done:', have[(str(lid), step)]['verdict'], flush=True)
            continue
        M = mval(lid)
        U, H, half, B, C = frame(M)
        info, js = mip_find(C, k, cap)
        rec = {'lattice': str(lid), 'M': M, 'step': step, 'k': k, 'units': len(U), 'cap_s': cap, 'highs': info}
        if js is None:
            infeasible = info['status'] == 2 or 'nfeasible' in info['message']
            rec['verdict'] = 'EMPTY per HiGHS (float, not a certificate)' if infeasible else 'UNDECIDED at the cap'
        else:
            tstar, x = cell_max_margin(C, js, k)
            rec['bands'] = js
            if tstar is None or tstar < 0:
                rec['verdict'] = 'FLOAT FALSE POSITIVE (the proposed cell is empty exactly)'
                rec['exact_cell_margin'] = None if tstar is None else str(tstar)
            else:
                y, m = nice_point(C, x, k, tstar > 0)
                assert m >= 0 and (m > 0) == (tstar > 0)
                rec['exact_cell_margin'] = str(tstar)
                rec['point_margin'] = str(m)
                rec['point_order'] = math.lcm(*[t.denominator for t in y])
                note = (f'FS-79 P3b: a point of Theta_{k} with margin {m} > 0, so inside a full-dimensional cell (loose)' if tstar > 0
                        else f'FS-79 P3b: a point of Theta_{k} in a cell of max margin 0 (a lower-dimensional cell)')
                w = witness(lid, M, H, U, B, y, k, note)
                path = os.path.join(WIT, f'{lid}-theta{k}-' + ('loose' if tstar > 0 else 'margin0') + (f'-{tag}' if tag else '') + '.json')
                with open(path, 'w') as f:
                    json.dump(w, f, indent=1)
                rc, out = run_checker(path)
                rec['witness'] = os.path.relpath(path, REPO)
                rec['checker'] = out
                rec['checker_rc'] = rc
                rec['verdict'] = ('FOUR-COLOURABLE AND LOOSE' if tstar > 0 else 'FOUR-COLOURABLE (margin 0)') if rc == 0 else 'CHECKER REFUSED'
        append_line(rec)
        print(json.dumps({k_: rec.get(k_) for k_ in ('lattice', 'units', 'verdict', 'exact_cell_margin', 'point_margin', 'point_order')}),
              json.dumps(info), flush=True)


def cmd_cell(ids, k):
    """the exact cell analysis (P3's cell_analysis) of each margin-0 witness's cell"""
    have = done_steps()
    for lid in ids:
        f = have.get((str(lid), f'find-k{k}'))
        if not f or f.get('exact_cell_margin') != '0' or (str(lid), f'cell-k{k}') in have:
            continue
        M = mval(lid)
        U, H, half, B, C = frame(M)
        w = json.load(open(os.path.join(REPO, f['witness'])))
        x = [Fr(t) for t in w['theta_on_basis']]
        js = [math.floor(sum(Fr(ci) * xi for ci, xi in zip(c, x)) - Fr(1, k)) for c in C]
        t0 = time.time()
        rec = cell_analysis(C, js, k, x)
        append_line({'lattice': str(lid), 'M': M, 'step': f'cell-k{k}', 'dim': rec['dim'], 'n_const': rec['n_const'],
                     'const_half': [list(half[i]) for i in rec['const_half']], 'n_edge_at_bary': rec['n_edge'],
                     'bary': rec['bary'], 'bary_order': rec['bary_order'], 'seconds': round(time.time() - t0, 1)})
        print(lid, 'cell dim', rec['dim'], 'constant', rec['n_const'], flush=True)


def cmd_quot(ids, nmin, nmax, budget, total):
    """full quotients Λ/NΛ at admissible N in [nmin, nmax], gap-aimed first then plain, by phase 0's / FS-73's code (imported)"""
    import numpy as np
    import itertools
    import fs79_p0 as P0
    import fs73_table as TB
    import fs73_screen as SC
    TB.COLDIR = os.path.join(OUT, 'colourings')
    TB.SCRATCH = SCR
    SC.SCRATCH = SCR
    rows = TB.Rows(os.path.join(OUT, 'quotients.jsonl'))
    have = done_steps()
    t_start = time.time()
    lats = {}
    for lid in ids:
        M = mval(lid)
        U = P0.units_M(M)
        lats[lid] = (M, U, P0.lattice_M(M, U))
    coloured = {lid for lid in ids for (l_, s_), r in have.items() if l_ == str(lid) and s_.startswith('quot-') and r['verdict'] == 'SAT'}
    # ROUND-ROBIN: the outer loop is N, the inner the lattices (smallest first), so the cheap small-N asks are spread over every
    # lattice before any lattice's large N.  One ask at a time; each holds the heavy lock exactly once -- ours for asks FS-73 prices
    # light (Q.n <= 60000), FS-73's own (solve_k's HeavyLock) above that, so the two never nest (fs73_table's deadlock note).
    for N in range(nmin, nmax + 1):
        for lid in ids:
            if lid in coloured:
                continue
            M, U, lat = lats[lid]
            key_step = f'quot-N{N}'
            if (str(lid), key_step) in have:
                print(lid, key_step, 'done:', have[(str(lid), key_step)]['verdict'], flush=True)
                continue
            Qt = SC.Quot(SC.NW(N, lat.rank), lat.rank)
            if not Qt.admissible(lat.U):
                append_line({'lattice': str(lid), 'M': M, 'step': key_step, 'verdict': 'inadmissible'})
                continue
            if time.time() - t_start > total:
                print(f'STOP RULE: quotient total {total} s spent before {lid} N = {N}', flush=True)
                print('DONE quot (stopped)', flush=True)
                return
            verdicts, col_found = {}, None
            for aim in ('gap', 'plain'):
                with SC.HeavyLock(Qt.n <= 60000):
                    rec, col = TB.ask_k(rows, f'Q167|L{M}|k4|N{N}|{aim}|p3b', Qt, lat.U, 4, aim, None, f'Q167|L{M}',
                                        budget=budget)
                verdicts[aim] = {'verdict': rec['verdict'], 'cpu_s': rec.get('cpu_s'), 'wall_s': rec.get('wall_s'),
                                 'replication': rec.get('replication')}
                print(f'  {lid} N {N} ({Qt.n} classes) {aim}: {rec["verdict"]} ({rec.get("wall_s")} s)', flush=True)
                if col is not None:
                    col_found = (aim, col)
                    break
            out = {'lattice': str(lid), 'M': M, 'step': key_step, 'classes': Qt.n, 'asks': verdicts}
            if col_found is not None:
                aim, col = col_found
                digs = np.array(list(itertools.product(range(N), repeat=lat.rank)), dtype=np.int64)
                table = ''.join(map(str, col[Qt.cls(digs)].tolist()))
                w = {'lattice': str(lid), 'M': M, 'd': D, 'H': [list(h) for h in lat.H], 'unit_count': len(U), 'k': 4,
                     'kind': 'quotient', 'claims_gap': aim == 'gap', 'N': N, 'basis': [list(h) for h in lat.H], 'table': table}
                path = os.path.join(WIT, f'{lid}-quotient-N{N}.json')
                with open(path, 'w') as f:
                    json.dump(w, f)
                rc, msg = run_checker(path)
                out.update({'verdict': 'SAT' if rc == 0 else 'CHECKER REFUSED', 'witness': os.path.relpath(path, REPO),
                            'checker': msg, 'checker_rc': rc})
            else:
                out['verdict'] = 'UNSAT' if all(v['verdict'] == 'UNSAT' for v in verdicts.values()) and 'plain' in verdicts else \
                    ('UNSAT (plain)' if verdicts.get('plain', {}).get('verdict') == 'UNSAT' else 'UNKNOWN')
            append_line(out)
            if out['verdict'] == 'SAT':
                coloured.add(lid)
    print('DONE quot', flush=True)


def cmd_price(lid, k, cap):
    """PRICE the exact emptiness tree (P3's certify_node, imported) before running it: the root's children, then depth-first
    subtrees in order until `cap` seconds; reports nodes/s, finished subtrees and their mean size -- a projection, not a count."""
    import itertools
    from fs79_p3_theta4 import certify_node
    M = mval(lid)
    U, H, half, B, C = frame(M)
    best = None
    for Q in itertools.combinations(range(len(C)), 4):
        dt = abs(det_int([C[q] for q in Q]))
        if dt and (best is None or (dt, Q) < best):
            best = (dt, Q)
    l1 = lambda i: sum(map(abs, C[i]))                                  # noqa: E731
    order = list(best[1]) + sorted((i for i in range(len(C)) if i not in best[1]), key=l1)
    stats = {'nodes': 0, 'leaves': 0, 'exact': 0, 'leaf_lp': 0}
    t0 = time.time()
    root, ch = certify_node(C, order, [], k, stats)
    roots = [[j] for j in ch]
    done_sizes, nodes, maxdepth, leaves = [], 0, 0, 0
    for r in roots:
        stack, size, finished = [list(r)], 0, True
        while stack:
            if time.time() - t0 > cap:
                finished = False
                break
            p = stack.pop()
            rec, c2 = certify_node(C, order, p, k, stats)
            size += 1
            maxdepth = max(maxdepth, len(p))
            if c2 == 'leaf':
                leaves += 1
            elif c2:
                stack += [p + [j] for j in reversed(c2)]
        nodes += size
        if not finished:
            break
        done_sizes.append(size)
    sec = time.time() - t0
    rec = {'lattice': str(lid), 'M': M, 'step': f'price-tree-k{k}', 'least_quad_det': best[0], 'root_children': len(roots),
           'subtrees_finished': len(done_sizes), 'finished_sizes': done_sizes[:20], 'nodes': nodes, 'leaves_seen': leaves,
           'max_depth_seen': maxdepth, 'pairs': len(C), 'seconds': round(sec, 1), 'nodes_per_s_one_core': round(nodes / sec, 1),
           'exact_fallbacks': stats['exact']}
    if done_sizes:
        mean = sum(done_sizes) / len(done_sizes)
        rec['projected_nodes'] = round(mean * len(roots))
    append_line(rec)
    print(json.dumps(rec), flush=True)


def resolve_ids(ids):
    out = []
    for t in ids:
        out += MINIMAL if t == 'minimal' else UPPER if t == 'upper' else [t]
    return out


def main():
    ap = argparse.ArgumentParser()
    sp = ap.add_subparsers(dest='cmd', required=True)
    f = sp.add_parser('frame'); f.add_argument('--ids', nargs='+', required=True)
    g = sp.add_parser('find'); g.add_argument('--ids', nargs='+', required=True); g.add_argument('--k', type=int, default=4)
    g.add_argument('--cap', type=float, default=1200.0); g.add_argument('--tag', default='')
    c = sp.add_parser('cell'); c.add_argument('--ids', nargs='+', required=True); c.add_argument('--k', type=int, default=4)
    q = sp.add_parser('quot'); q.add_argument('--ids', nargs='+', required=True)
    q.add_argument('--nmin', type=int, default=13); q.add_argument('--nmax', type=int, default=24)
    q.add_argument('--budget', type=float, default=300.0); q.add_argument('--total', type=float, default=1800.0)
    p = sp.add_parser('price'); p.add_argument('--ids', nargs='+', required=True); p.add_argument('--k', type=int, default=4)
    p.add_argument('--cap', type=float, default=90.0)
    a = ap.parse_args()
    ids = resolve_ids(a.ids)
    if a.cmd == 'price':
        for lid in ids:
            cmd_price(lid, a.k, a.cap)
        return
    if a.cmd == 'frame':
        cmd_frame(ids)
    elif a.cmd == 'find':
        cmd_find(ids, a.k, a.cap, a.tag)
    elif a.cmd == 'cell':
        cmd_cell(ids, a.k)
    else:
        cmd_quot(ids, a.nmin, a.nmax, a.budget, a.total)


if __name__ == '__main__':
    main()
