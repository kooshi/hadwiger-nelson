#!/usr/bin/env python3
"""fs73_table -- FS-73 phase P2: the classification table.  UNTRUSTED (tools/).

WHAT IT COMPUTES (plans/FS73-rigidity-dichotomy.md section S.2, row P2; section 0, "The normal form").  For a field F and each quartic
CM subfield E of F(i), a rank-4 lattice Lambda of unit vectors of E (Lambda_D: the Z-span of E's unit vectors of denominator dividing D;
or a named lattice), its complete unit-vector set U (fs73_lattice's trace saturation), and a colour count k:
  (a), (b)  the arithmetic columns: for every prime p in PRIMES and every prime of E+ above p, its type in E/E+ (split / inert /
            ramified), by PARI; the 2-adic column is "wall-broken" (every prime of E+ above 2 splits in E) or "2-unit" (some prime
            above 2 is fixed by conjugation: every unit vector is integral there and the residue map is a homomorphism of the whole
            plane over E, onto K2-type targets: ramified -> 2 colours, inert of norm Q -> U_Q = Cay(F_{Q^2}, mu_{Q+1}), 4-colourable for
            Q <= 32, G56); the 3-adic column the same at 3.  Counts of E's unit vectors of denominator dividing D that are not 2-integral
            (wall-breaking) and not 3-integral (3-adic pole), by the characteristic polynomial (T5's definitions; po_cm_subfield.py).
  (c)       spectral: m(Lambda) = min over the torus of sum_{u in U} cos(2 pi theta.u), against -d/(k-1) (G54 for the lattice itself),
            and each quotient's minimum over its characters (N^4 of them).
  (d)       per admissible N <= 12 (no unit vector in N Lambda): the quotient Cay(Lambda/N Lambda, U mod N) asked plain and gap-aimed at
            k colours; |U mod N| beside the size of the norm-one group of O_E/p for the prime-period rows (the quotient is a SUBGRAPH of
            that target, equal to it exactly when the counts agree -- target and quotient kept apart, retraction 2).
  (e)       composite periods: N = p q whose single-prime quotients both refuse, computed when priced under CLASS_CAP.
  (f)       the chainable targets delta = q u (q in QLIST, u in U, delta in Lambda) with 1/delta in Z[U_F] -- prime inversion (G55): every
            prime dividing q's numerator has no conjugation-stable prime of F(i) above it -- each placed in the sandwich.
  VERDICT   the sandwich F_known <= F <= P <= P_found in subgroup form: a gapped periodic colouring at any N makes P_found = 0, hence
            F = P = 0 (FS70-T6); otherwise P_N exactly at every colourable N by the counterexample-guided loop, and KPer(c) of every
            colouring found (every component of every two-colour subgraph); P_found = the intersection.  A lattice with no periodic
            colouring at any N searched is REFUSING (C3-aper's vacuous case: P_found = Lambda).  F_known is 0 except where a certified
            forced vector exists (de Grey's lattice: F = 8 Lambda, data/fs73/records/verify-P1d.md).
  Every "rigid" or "P_found" statement is a statement about the colourings FOUND at the periods SEARCHED (G21), and every row says which.

THE ENCODINGS (k-generic versions of fs73_screen's four-colour finder, which this file imports and does not edit).  Pins: the origin
colour 0, its least neighbour class 1, a common neighbour of the two (a triangle; one exists iff sqrt3 is in the field, G57) colour 2 when
k >= 3.  Value precedence only among colours no pin uses and that are not the gap colour (sound: those colours are interchangeable in every
solution meeting the pins).  Aims: 'plain'; 'sep' adds c(target class) != c(0); 'gap' empties colour k-1 from the closed neighbourhood of
the origin (vertex-transitivity puts any gap at the origin; the gap colour is never a pinned one unless k = 3 with a triangle, where the
pin makes the ask UNSAT, which is the truth: a triangle in N[0] leaves no gap at three colours).  Every SAT model is re-verified edge by
edge; every verdict carries the CNF sha256, CPU seconds and the machine.

Commands
  python3 tools/fs73_table.py t5                         # control: T5's six-subfield table over Q(sqrt3, sqrt5) at denominator 24
  python3 tools/fs73_table.py arith FIELD                 # the arithmetic columns for every CM subfield of FIELD
  python3 tools/fs73_table.py table FIELD [--resume]      # the computed columns and the verdict, rows to data/fs73/table/rows.jsonl
  python3 tools/fs73_table.py selftest [--plants]         # the code controls (k-generic finder and KPer against fs73_screen at k = 4)
FIELD: K, Q35, Q3_23, Q3_47, Q11, Q167, PILOT.  --resume is the default behaviour: a row key present is never re-asked.
"""
import gzip
import hashlib
import itertools
import json
import math
import os
import subprocess
import sys
import time
from fractions import Fraction as Fr

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs73_lattice as FL                                                     # noqa: E402
import fs73_screen as S                                                       # noqa: E402

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]
VALID_PLANTS = ('kper_skip_unused', 'gap_pin_clash', 'pin_prec')

TABLE = os.path.join(ROOT, 'data', 'fs73', 'table')
ROWS = os.path.join(TABLE, 'rows.jsonl')
COLDIR = os.path.join(TABLE, 'colourings')
SCRATCH = '/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implB'
S.SCRATCH = SCRATCH
MACHINE = S.MACHINE
PRIMES = (2, 3, 5, 7, 11, 13, 17, 19, 23)
QLIST = sorted({Fr(a, b) for b in (1, 3, 9, 7) for a in (1, 2, 3, 4, 6, 8, 16) if Fr(a, b) >= Fr(1, 2) and Fr(a, b) != 1})
BUDGET = 300                  # seconds per quotient ask (the plan's cap)
CADICAL = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical')
CLASS_CAP = 250_000           # composite periods above this many classes are priced and skipped


def planted(name):
    return PLANT == name


# ================================================================ fields and their quartic CM subfields

FIELDS = {
    'K': (3, 11), 'Q35': (3, 5), 'Q3_23': (3, 23), 'Q3_47': (3, 47), 'Q11': (11,), 'Q167': (167,),
}


def sqfree(n):
    out, p = 1, 2
    while p * p <= n:
        while n % (p * p) == 0:
            n //= p * p
        if n % p == 0:
            out *= p
            n //= p
        p += 1
    return out * n


def cm_subfields(F):
    """every quartic CM subfield E = E+(sqrt -m) of F(i): its E+ radicand s, its m, and the coordinate masks a point (x, y) of E may
    use (x in E+, y in sqrt(m) E+).  For F quadratic, E = F(i) itself."""
    if F.n == 2:
        d = F.rad[0]
        return [{'name': f'Q(sqrt{d},i)', 's': d, 'm': 1, 'xm': (0, 1), 'ym': (0, 1)}]
    a, b = F.rad
    val = {0: 1, 1: a, 2: b, 3: a * b}
    out = []
    for s in (1, 2, 3):
        others = [t for t in (1, 2, 3) if t != s]
        for t in (0, others[0]):
            es, m = sqfree(val[s]), (sqfree(val[t]) if t else 1)
            ym = (0, s) if t == 0 else (t, t ^ s)
            name = f'Q(sqrt{es},' + ('i)' if m == 1 else f'sqrt-{m})')
            out.append({'name': name, 's': es, 'm': m, 'xm': (0, s), 'ym': ym})
    return out


def in_subfield(v, sub, n):
    return all(v[j] == 0 for j in range(n) if j not in sub['xm']) and all(v[n + j] == 0 for j in range(n) if j not in sub['ym'])


def gp(script):
    p = subprocess.run(['gp', '-q', '-s', '400000000'], input=script + '\n', capture_output=True, text=True, timeout=600)
    if p.returncode != 0 or '***' in p.stderr + p.stdout:
        raise RuntimeError('gp failed: ' + (p.stderr[-500:] or p.stdout[-500:]))
    return p.stdout


def arithmetic(s, m, primes=PRIMES):
    """for E = Q(sqrt s)(sqrt -m): per prime p, the primes of E+ above it with (e, f) and their type in E/E+"""
    script = (f'nf = nfinit(y^2 - {s}); rnf = rnfinit(nf, x^2 + {m}); '
              f'foreach({list(primes)}, p, P = idealprimedec(nf, p); for(j = 1, #P, Q = rnfidealprimedec(rnf, P[j]); '
              f'print(p, " ", P[j].e, " ", P[j].f, " ", #Q, " ", Q[1].e, " ", Q[1].f)))')
    out = {}
    for line in gp(script).strip().split('\n'):
        p, e, f, nq, qe, qf = (int(t) for t in line.split())
        typ = 'split' if nq == 2 else ('ramified' if qe // e == 2 else 'inert')
        out.setdefault(p, []).append({'e': e, 'f': f, 'q': p ** f, 'type': typ})
    return out


def field_inversion(rad, primes=(2, 3, 5, 7)):
    """prime inversion over the whole field F (G55): 1/p is in Z[U_F] iff no prime of F(i) above p is fixed by conjugation, i.e.
    every prime of F above p splits in F(i)"""
    pol = f'y^2 - {rad[0]}' if len(rad) == 1 else f'polcompositum(y^2 - {rad[0]}, y^2 - {rad[1]})[1]'
    script = (f'nf = nfinit({pol}); rnf = rnfinit(nf, x^2 + 1); '
              f'foreach({list(primes)}, p, P = idealprimedec(nf, p); s = 1; '
              f'for(j = 1, #P, if(#rnfidealprimedec(rnf, P[j]) != 2, s = 0)); print(p, " ", s))')
    return {int(a): bool(int(b)) for a, b in (ln.split() for ln in gp(script).strip().split('\n'))}


def norm_one_count(ar, p):
    """|norm-one group of O_E / p O_E| from the prime types above p (split q - 1, inert q + 1, ramified 2q)"""
    c = 1
    for pr in ar.get(p, []):
        q, e = pr['q'], pr['e']                    # O_E / p O_E = product over primes of E+ above p of O_E / P^e O_E
        c *= {'split': q ** (e - 1) * (q - 1), 'inert': q ** (e - 1) * (q + 1), 'ramified': 2 * q ** e}[pr['type']]
    return c


# ================================================================ p-integrality (T5's counts)

def integral_at(F, v, D, p):
    """is z = v/D (a point of F(i), 2n-vector over D) integral at every prime above p?  Iff the characteristic polynomial of
    multiplication by z on F(i)/Q has p-integral coefficients: power sums by repeated multiplication, then Newton's identities"""
    n = F.n
    deg = 2 * n
    w, den = tuple(v), D
    ps = []
    for j in range(1, deg + 1):
        ps.append(Fr(2 * n * w[0], den))                    # Tr_{F(i)/Q}(x + iy) = 2 Tr_{F/Q}(x) = 2 n x_0
        if j < deg:
            w, den = FL.cmul(F, w, v), den * D
    e = [Fr(1)]
    for k in range(1, deg + 1):
        e.append(sum((-1) ** (i - 1) * e[k - i] * ps[i - 1] for i in range(1, k + 1)) / k)
    return all(c.denominator % p for c in e)


def t5_counts(F, D=24):
    U = FL.units_over(F, D)
    out = {}
    for sub in cm_subfields(F):
        m = [v for v in U if in_subfield(v, sub, F.n)]
        w = [not integral_at(F, v, D, 2) for v in m]
        t = [not integral_at(F, v, D, 3) for v in m]
        out[sub['name']] = {'units': len(m), 'wall_breaking': sum(w), 'three_pole': sum(t),
                            'both': sum(a and b for a, b in zip(w, t))}
    return out


# ================================================================ k-generic finder, Kempe period group, H1 loop

def build_cnf_k(Q, U, k, aim='plain', target=None, nobreak=False):
    E, res = S.quotient_graph(Q, U)
    n = Q.n
    x = lambda v, c: k * v + c + 1                                           # noqa: E731
    nb = min(res)
    nbset = set(res)
    tri = None
    dn = Q.digits()[nb]
    for w in res:
        diff = int((np.mod(Q.digits()[w] - dn, Q.mods) * Q.pw).sum())
        if diff in nbset:
            tri = w
            break
    pins = [(0, 0), (nb, 1)] + ([(tri, 2)] if tri is not None and k >= 3 else [])
    if nobreak:
        pins = []                        # the break-free encoding: no pin, no precedence (the soundness control's reference)
    cls = [[x(v, c) for c in range(k)] for v in range(n)]
    extra, note = [], []
    gapc = k - 1
    if aim == 'sep':
        tcl = int(Q.cls(np.array([target]))[0])
        if tcl == 0:
            return None, 0, pins, 'the target lies in W: its class is the origin'
        if nobreak:
            extra += [[-x(tcl, c), -x(0, c)] for c in range(k)]
        else:
            extra.append([-x(tcl, 0)])
        note.append(f'c(target class {tcl}) != c(0)')
    elif aim == 'gap':
        extra.append([-x(0, gapc)])
        extra += [[-x(s, gapc)] for s in res]
        note.append(f'colour {gapc} absent from N[0]')
    for v, c in pins:
        extra.append([x(v, c)])
    used = {c_ for _, c_ in pins}
    free = [c for c in range(k) if c not in used and not (aim == 'gap' and c == gapc)]
    if nobreak:
        free = []
    if planted('pin_prec') and not nobreak:
        free = [1, 0]                    # PLANT: colour 0 may occur only after colour 1 -- a precedence on two PINNED colours (unsound)
    if planted('gap_pin_clash') and aim == 'gap':
        pins = pins + [(0, gapc)]                                           # PLANT: the origin pinned to the gap colour as well
        extra.append([x(0, gapc)])
    nvars = k * n
    for f1, f2 in zip(free, free[1:]):
        base = nvars
        nvars += n + 1
        s_ = lambda v, base=base: base + v + 1                             # noqa: E731
        extra.append([-s_(0)])
        for v in range(n):
            extra.append([-x(v, f2), s_(v)])
            extra.append([-s_(v + 1), s_(v), x(v, f1)])
    if len(free) >= 2:
        note.append(f'value precedence over all {n} vertices among colours {free}')
    note.insert(0, 'origin 0, least neighbour 1' + (', triangle 2' if tri is not None and k >= 3 else ' (no triangle)'))
    return (cls, E, extra), nvars, pins, '; '.join(note)


def write_cnf_k(path, parts, nvars, k):
    cls, E, extra = parts
    nclauses = len(cls) + k * len(E) + len(extra)
    h = hashlib.sha256()
    with open(path, 'w') as f:
        def w(s):
            f.write(s)
            h.update(s.encode())
        w(f'p cnf {nvars} {nclauses}\n')
        w(''.join(' '.join(map(str, c)) + ' 0\n' for c in cls))
        for c in range(k):
            a = k * E[:, 0] + c + 1
            b = k * E[:, 1] + c + 1
            for lo in range(0, len(E), 500000):
                w(''.join(f'-{p} -{q} 0\n' for p, q in zip(a[lo:lo + 500000].tolist(), b[lo:lo + 500000].tolist())))
        w(''.join(' '.join(map(str, c)) + ' 0\n' for c in extra))
    return h.hexdigest(), nclauses


def solve_k(Q, U, k, aim='plain', target=None, budget=BUDGET, solver='kissat', nobreak=False):
    parts, nvars, pins, note = build_cnf_k(Q, U, k, aim, target, nobreak=nobreak)
    rec = {'aim': aim, 'k': k, 'classes': Q.n, 'note': note, 'solver': solver, 'budget_s': budget, 'machine': MACHINE}
    if parts is None:
        rec['verdict'] = 'n/a'
        return rec, None
    os.makedirs(SCRATCH, exist_ok=True)
    path = os.path.join(SCRATCH, f'tab-{os.getpid()}-{Q.n}-{aim}.cnf')
    sha, ncl = write_cnf_k(path, parts, nvars, k)
    rec.update({'cnf_sha256': sha, 'clauses': ncl, 'vars': nvars, 'edges': int(len(parts[1]))})
    heavy = Q.n > 60000            # quotient asks to N = 12 (<= 20,736 classes) measured at seconds and < 1 GB, capped at 300 s
    with S.HeavyLock(heavy):
        t0, ru0 = time.time(), os.times()
        try:
            exe = CADICAL if solver == 'cadical' else solver
            p = subprocess.run([exe, '-q', path], capture_output=True, text=True, timeout=budget)
            out = p.stdout
            v, sline = S.sline_verdict(out, p.returncode)
        except subprocess.TimeoutExpired:
            out, v, sline = '', 'UNKNOWN', None
        ru1 = os.times()
    rec['wall_s'] = round(time.time() - t0, 2)
    rec['cpu_s'] = round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2)
    rec['verdict'] = v
    rec['lock'] = heavy
    os.remove(path)
    if v != 'SAT':
        if v == 'UNKNOWN':
            rec['unknown_type'] = f'budget: {budget} s wall, {solver}' if sline is None else f'no verdict: {sline!r}'
        return rec, None
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(t) for t in line[2:].split()]
    pos = np.zeros(nvars + 1, dtype=bool)
    L = np.array(lits, dtype=np.int64)
    pos[L[L > 0]] = True
    X = pos[1:k * Q.n + 1].reshape(Q.n, k)
    assert X.any(axis=1).all()
    col = np.argmax(X, axis=1).astype(np.int8)
    E = parts[1]
    assert not np.any(col[E[:, 0]] == col[E[:, 1]]), 'the solver returned an improper colouring'
    for v_, c_ in pins:
        assert col[v_] == c_
    if aim == 'sep':
        assert col[int(Q.cls(np.array([target]))[0])] != col[0]
    if aim == 'gap':
        assert gap_at_origin(Q, U, col, k) is not None, 'a gap-aimed model has no gap at the origin'
    return rec, col


def gap_at_origin(Q, U, col, k):
    """a colour absent from the closed neighbourhood of the origin class, or None -- read from the colouring itself"""
    nbr = {int(c) for c in Q.cls(np.array(U))}
    present = {int(col[0])} | {int(col[c]) for c in nbr}
    missing = [c for c in range(k) if c not in present]
    return missing[0] if missing else None


def kper_k(pc, k):
    """KPer(c) at k colours: the intersection of the voltage groups of every component of every two-colour subgraph, every pair a < b.
    If some colour is unused while another is used, every component of that pair is a single vertex (a fan gap everywhere), so
    KPer = 0.  fs73_screen.PColour.kper is the k = 4 case and skips such pairs, an over-approximation that stays a sound upper bound."""
    r = pc.Q.r
    H = [tuple(w) for w in pc.Q.W]
    stats, distinct = {}, set()
    used = {int(c) for c in np.unique(pc.col)}
    for a, b in itertools.combinations(range(k), 2):
        if a not in used and b not in used:
            continue
        if (a in used) != (b in used):
            if planted('kper_skip_unused'):
                continue                                                  # PLANT: fs73_screen's skip
            stats[f'{a}{b}'] = {'components': 'singletons (one colour unused)'}
            return [], stats
        lab, p, V, roots = pc.components(a, b)
        ranks = [len(v) for v in V.values()]
        stats[f'{a}{b}'] = {'components': len(V), 'min_V_rank': min(ranks), 'max_V_rank': max(ranks)}
        for v in V.values():
            distinct.add(tuple(v))
    for v in sorted(distinct):
        H = S.intersect(H, list(v), r)
        if not H:
            break
    return H, stats


class Rows(S.Rows):
    pass


def save_colouring(tag, W, col):
    os.makedirs(COLDIR, exist_ok=True)
    s_ = ''.join(map(str, col.tolist()))
    sha = hashlib.sha256(s_.encode()).hexdigest()[:16]
    path = os.path.join(COLDIR, f'{tag}-{sha}.json.gz')
    if not os.path.exists(path):
        with gzip.open(path, 'wt') as f:
            json.dump({'lattice': tag, 'W': [list(map(int, w)) for w in W], 'classes': len(col), 'colouring': s_,
                       'index': 'big-endian mixed radix of (x C) mod d, C and d the Smith form of W (tools/fs73_screen.py Quot)'}, f)
    return os.path.relpath(path, ROOT), sha


def ask_k(rows, key, Q, U, k, aim, target, lid, budget=BUDGET):
    got = rows.get(key)
    if got:
        col = S.load_colouring(got['colouring'])[1] if got.get('colouring') else None
        if col is not None:
            S.PColour(U, Q, col, key)                                     # re-verify properness on load
        return got, col
    rec, col = solve_k(Q, U, k, aim, target, budget=budget)
    if rec['verdict'] == 'UNSAT':
        # every quotient refusal is re-asked on a SECOND encoding (no pin, no precedence) by a SECOND solver (cadical): an
        # agreement checks the symmetry break and the solver at once; a disagreement raises (G21: the failure path is the loud one)
        r2, c2 = solve_k(Q, U, k, aim, target, solver='cadical', nobreak=True, budget=budget)
        rec['replication'] = {kk: r2.get(kk) for kk in ('solver', 'verdict', 'cpu_s', 'cnf_sha256', 'note', 'unknown_type')}
        assert r2['verdict'] != 'SAT', f'{key}: the break-free encoding is SAT where the broken one refused -- an unsound break'
    rec.update({'key': key, 'W': S.lat_rows(Q.W), 'target': list(map(int, target)) if target is not None else None})
    if col is not None:
        rec['colouring'], rec['colouring_sha'] = save_colouring(lid.replace('|', '_').replace('/', '_'), Q.W, col)
        if aim == 'gap':
            rec['gap_colour_verified'] = gap_at_origin(Q, U, col, k)
    return rows.put(rec), col


def analyse_k(rows, U, W, col, r, k, lid):
    s_ = ''.join(map(str, col.tolist()))
    sha = hashlib.sha256(s_.encode()).hexdigest()[:16]
    key = f'{lid}|k{k}|analyse:{sha}'
    got = rows.get(key)
    if got:
        return got
    Q = S.Quot(W, r)
    pc = S.PColour(U, Q, col, key)
    t0 = time.time()
    Wp, _ = pc.per()
    pd = pc.descend(Wp) if len(Wp) and S.hnf(Wp, r) != S.hnf(W, r) else pc
    KP, st = kper_k(pd, k)
    return rows.put({'key': key, 'colouring_sha': sha, 'Per': S.lat_rows(Wp), 'Per_desc': S.describe(Wp, r)['Lambda_mod'],
                     'KPer': S.lat_rows(KP), 'KPer_desc': S.describe(KP, r)['Lambda_mod'] if KP else 'zero', 'KPer_rank': len(KP),
                     'component_stats': st, 'seconds': round(time.time() - t0, 2), 'machine': MACHINE})


def p_N_k(rows, lid, U, r, k, N):
    """P_N exactly by the counterexample-guided loop (fs73_screen.p_N at k colours).  Returns (P_N, colourings, status)."""
    W = S.NW(N, r)
    Q = S.Quot(W, r)
    rec, col = ask_k(rows, f'{lid}|k{k}|N{N}|plain', Q, U, k, 'plain', None, lid)
    if col is None:
        return None, [], rec['verdict']
    cols = [col]
    G, _ = S.PColour(U, Q, col).per()
    conf = S.hnf(W, r)
    status = 'exact'
    while True:
        gens = [g for g in G if not S.member(conf, g)]
        if not gens:
            break
        g = gens[0]
        rec, col = ask_k(rows, f'{lid}|k{k}|N{N}|sep:{",".join(map(str, g))}', Q, U, k, 'sep', g, lid)
        if rec['verdict'] == 'SAT':
            cols.append(col)
            Wc, _ = S.PColour(U, Q, col).per()
            G = S.intersect(G, Wc, r)
            assert not S.member(G, g), 'a separating colouring failed to shrink the guess'
        elif rec['verdict'] == 'UNSAT':
            conf = S.hnf(list(conf) + [tuple(g)], r)
        else:
            status = f'upper bound: {rec["verdict"]} at generator {list(g)}'
            break
    return G, cols, status


# ================================================================ the lattices of the table

def lattice_D(F, sub, D):
    U = [v for v in FL.units_over(F, D) if in_subfield(v, sub, F.n)]
    lat = FL.Lattice(F, [(v, D) for v in U], name=f'{F.name}|{sub["name"]}|D{D}', M=D)
    return lat, len(U)


def fs61_shape(d, spec):
    """an FS-61 atlas shape 'M|r1;r2;r3;r4' over Q(sqrt d) in (a, b, c, e): the lattice is the Z-span of the shape's unit vectors"""
    F = FL.Field((d,))
    M, rows_ = spec.split('|')
    M = int(M)
    B = [tuple(int(t) for t in r.split(',')) for r in rows_.split(';')]
    shape = FL.Lattice(F, [(b, M) for b in B], name=f'shape:{spec}', M=M)
    shape.saturate('box')
    lat = FL.Lattice(F, [(v, M) for v in shape.U8], name=f'Q(sqrt{d})|fs61:{spec}', M=M)
    return lat, len(shape.U8)


def three_integral_D(F, sub, D):
    """the Z-span of E's unit vectors of denominator dividing D that are integral at every prime above 3"""
    U = [v for v in FL.units_over(F, D) if in_subfield(v, sub, F.n) and integral_at(F, v, D, 3)]
    lat = FL.Lattice(F, [(v, D) for v in U], name=f'{F.name}|{sub["name"]}|3int|D{D}', M=D)
    return lat, len(U)


def lattice_specs(field):
    """the lattices of each field's rows, chosen by supply (FS61-T3: never carried between fields) -- (id, builder, k)"""
    if field == 'K':
        F = FL.Field(FIELDS['K'])
        out = [('K|degrey', lambda: (FL.degrey(), 30), 4)]
        for sub in cm_subfields(F):
            out.append((f'K|{sub["name"]}|D36', lambda sub=sub: lattice_D(F, sub, 36), 4))
        return out
    if field in ('Q35', 'Q3_23', 'Q3_47'):
        F = FL.Field(FIELDS[field])
        return [(f'{field}|{sub["name"]}|D24', lambda sub=sub: lattice_D(F, sub, 24), 4) for sub in cm_subfields(F)]
    if field == 'Q11':
        F = FL.Field((11,))
        sub = cm_subfields(F)[0]
        return [('Q11|3int|D10', lambda: three_integral_D(F, sub, 10), 3),     # 36 unit vectors, denominators 1, 5, 10
                ('Q11|3int|D50', lambda: three_integral_D(F, sub, 50), 3),     # 100, denominators to 50 (priced 2026-09-23)
                ('Q11|D30', lambda: lattice_D(F, sub, 30), 3)]                 # 108 = 36 + 72 with a 3-adic pole (row 74's supply)
    if field == 'Q167':
        return [(f'Q167|fs61:{nm}', lambda spec=spec: fs61_shape(167, spec), 3) for nm, spec in Q167_SHAPES]
    if field == 'PILOT':
        a, b, s_mask, t_mask = PILOT
        F = FL.Field((a, b))
        sub = next(x for x in cm_subfields(F) if x['xm'] == (0, s_mask) and x['ym'][0] == t_mask)
        return [(f'PILOT|{sub["name"]}|D{PILOT_D}', lambda: lattice_D(F, sub, PILOT_D), 5)]
    raise SystemExit(f'unknown field {field!r}')


Q167_SHAPES = []            # filled from data/fs61 below (the richest by unit-vector count)
PILOT = (3, 77, 1, 2)       # E = Q(sqrt3, sqrt-77) inside Q(sqrt3, sqrt77)(i) <= K(sqrt7)(i): chosen by cmd_pilot_screen as the one
PILOT_D = 144               # quartic CM subfield with the wall broken, no fixed prime to 47 whose target has a known gapped 5-colouring, and
                            # the most unit vectors (26 at D = 144: denominators 1, 9, 16, 24, 144)


def subfield_of(lid):
    for field, rad in FIELDS.items():
        if lid.startswith(field + '|'):
            return field, rad
    if lid.startswith('PILOT|'):
        return 'PILOT', PILOT[:2]
    raise KeyError(lid)


# ================================================================ one lattice's row

def targets(lat, U, r, inv):
    """the chainable targets q u in Lambda (q in QLIST, u in U), one per point-group orbit, with the chain condition from prime
    inversion over F: every prime dividing q's numerator is invertible in Z[U_F]"""
    Gp, _ = FL.point_group(lat)
    seen, out = set(), []
    for q in QLIST:
        for u in U:
            v8 = lat.point(u)
            w = lat.to_M(tuple(q.numerator * t for t in v8), q.denominator * lat.M)
            c = None if w is None else lat.coords(w)
            if c is None or c in seen:
                continue
            orb = {tuple(sum(c[i] * A[i][j] for i in range(r)) for j in range(r)) for A in Gp}
            seen |= orb
            num = q.numerator
            primes = [p for p in (2, 3, 5, 7) if num % p == 0]
            chain = all(inv.get(p, False) for p in primes)
            out.append({'q': str(q), 'u': list(map(int, u)), 'coords': list(map(int, c)), 'orbit': len(orb), 'chainable': chain})
    return out


def spectral_sign(md, k):
    """G54's sign of m/d against -1/(k-1): below is SLACK (Hoffman's alpha-bound exceeds n/k, gaps permitted), equal is TIGHT, above
    is a Hoffman REFUSAL (no k-colouring of any finite quotient reaching the minimiser).  The label is derived from the stored numbers
    wherever a row is read (a row written before 2026-09-23 12:40 carries a wrong label, 'tight-or-below', for the slack case)."""
    t = -1 / (k - 1)
    return 'slack' if md < t - 1e-6 else ('tight' if md <= t + 1e-6 else 'Hoffman-refuses')


def run_lattice(rows, lid, build, k, nmax=12, composite=True):
    """every column of one lattice's row; returns the summary row (also written)"""
    key = f'row:{lid}|k{k}'
    got = rows.get(key)
    if got:
        return got
    field, rad = subfield_of(lid)
    t_start = time.time()
    lat, ngen = build()
    # the box saturation to D = M is complete for any lattice inside (1/M) Z^{2n} (fs73_lattice) and costs by M, where the trace
    # method's Fincke-Pohst enumeration costs by covolume and explodes on fine lattices (FS-61's 167 shapes); de Grey's keeps A2's trace
    lat.saturate('trace' if lid == 'K|degrey' else 'box')
    U, r = lat.U, lat.rank
    summary = {'key': key, 'lattice': lid, 'k': k, 'rank': r, 'M': lat.M, 'generators': ngen, 'U': len(U),
               'saturation': lat.saturation, 'H': [list(h) for h in lat.H], 'machine': MACHINE}
    inv = field_inversion(rad)
    summary['field_inversion'] = {str(p): v for p, v in inv.items()}
    # (c) the continuous spectrum
    val, th = S.spectrum_continuous(U, r, starts=300)
    fr = [Fr(float(t)).limit_denominator(64) for t in th]
    summary['spectral'] = {'m': round(val, 6), 'd': len(U), 'm_over_d': round(val / len(U), 6), 'tight_at': round(-1 / (k - 1), 6),
                           'sign': spectral_sign(val / len(U), k),
                           'argmin': [str(f) for f in fr],
                           'argmin_residual': round(max(abs(float(t) - float(f)) for t, f in zip(th, fr)), 6)}
    # (d) the admissible periods
    per_rows, gapped, colourable, refused = [], None, [], []
    for N in range(2, nmax + 1):
        Q = S.Quot(S.NW(N, r), r)
        if not Q.admissible(U):
            per_rows.append({'N': N, 'admissible': False})
            continue
        umod = len({int(c) for c in Q.cls(np.array(U))})
        qmin, qcnt = S.spectrum_quotient(U, N, r)
        bud = 60 if gapped else BUDGET        # after a gap the verdict is settled (T6); later periods only fill column (d)
        rec_p, col_p = ask_k(rows, f'{lid}|k{k}|N{N}|plain', Q, U, k, 'plain', None, lid, budget=bud)
        rec_g, col_g = ask_k(rows, f'{lid}|k{k}|N{N}|gap', Q, U, k, 'gap', None, lid, budget=bud)
        pr = {'N': N, 'admissible': True, 'classes': Q.n, 'U_mod_N': umod, 'quotient_min': round(qmin, 6),
              'plain': rec_p['verdict'], 'gap': rec_g['verdict'], 'cpu_s': round(rec_p.get('cpu_s', 0) + rec_g.get('cpu_s', 0), 2)}
        if col_g is not None:
            pr['gap_colouring'] = rec_g['colouring']
            gapped = gapped or {'N': N, 'colouring': rec_g['colouring'], 'gap_colour': rec_g.get('gap_colour_verified')}
        if rec_p['verdict'] == 'SAT':
            colourable.append(N)
        elif rec_p['verdict'] == 'UNSAT':
            refused.append(N)
        per_rows.append(pr)
    summary['periods'] = per_rows
    # m(Lambda) is the minimum over the torus; BFGS finds a LOCAL minimum, and every quotient's exact minimum is a value at a torsion
    # point, so the column reads the least of them (2026-09-23: BFGS alone read 'Hoffman-refuses' on a lattice with a verified
    # 3-colouring -- impossible, since a k-colourable Cayley graph has m/d <= -1/(k-1))
    qm = [(pr['quotient_min'], pr['N']) for pr in per_rows if pr.get('admissible')]
    if qm and min(qm)[0] < summary['spectral']['m'] - 1e-9:
        summary['spectral'].update({'m_bfgs': summary['spectral']['m'], 'm': min(qm)[0], 'm_over_d': round(min(qm)[0] / len(U), 6),
                                    'argmin': f'torsion: attained on the N = {min(qm)[1]} quotient'})
    summary['spectral']['sign'] = spectral_sign(summary['spectral']['m_over_d'], k)
    # (e) composite periods whose two prime factors both refuse
    comp = []
    if composite:
        ref_primes = [N for N in refused if all(N % p for p in range(2, N))]
        for p1, p2 in itertools.combinations(sorted(ref_primes), 2):
            N = p1 * p2
            if N <= nmax:
                continue
            ncls = N ** r
            if ncls > CLASS_CAP:
                comp.append({'N': N, 'classes': ncls, 'verdict': f'priced, not run ({ncls} classes > {CLASS_CAP})'})
                continue
            Q = S.Quot(S.NW(N, r), r)
            if not Q.admissible(U):
                comp.append({'N': N, 'admissible': False})
                continue
            rec_p, col_p = ask_k(rows, f'{lid}|k{k}|N{N}|plain', Q, U, k, 'plain', None, lid)
            rec_g, col_g = ask_k(rows, f'{lid}|k{k}|N{N}|gap', Q, U, k, 'gap', None, lid)
            comp.append({'N': N, 'classes': ncls, 'plain': rec_p['verdict'], 'gap': rec_g['verdict']})
            if col_g is not None:
                gapped = gapped or {'N': N, 'colouring': rec_g['colouring'], 'gap_colour': rec_g.get('gap_colour_verified')}
            if rec_p['verdict'] == 'SAT':
                colourable.append(N)
    summary['composite'] = comp
    # the sandwich
    Lam = [tuple(1 if i == j else 0 for j in range(r)) for i in range(r)]
    tg = targets(lat, U, r, inv)
    if gapped:
        P_found, status = [], f'gapped periodic colouring at N = {gapped["N"]} (FS70-T6): P_found = 0, so F = P = 0'
        pn = {}
        kp = []
    elif not colourable:
        P_found, status = Lam, 'REFUSING: no periodic colouring at any N searched (C3-aper; P_found = Lambda, vacuous)'
        pn, kp = {}, []
    else:
        P_found, pn, kp = Lam, {}, []
        status = 'exact at every colourable N'
        for N in colourable:
            G, cols, st = p_N_k(rows, lid, U, r, k, N)
            pn[N] = {'P_N': S.lat_rows(G), 'desc': S.describe(G, r)['Lambda_mod'], 'rank': len(G), 'status': st,
                     'colourings': len(cols)}
            if not st.startswith('exact'):
                status = 'P_N an upper bound at some N (an UNKNOWN in the loop)'
            P_found = S.intersect(P_found, G, r)
            for c in cols:
                a = analyse_k(rows, U, S.NW(N, r), c, r, k, lid)
                kp.append({'N': N, 'sha': a['colouring_sha'], 'KPer_rank': a['KPer_rank'], 'KPer_desc': a['KPer_desc']})
                P_found = S.intersect(P_found, [tuple(x) for x in a['KPer']], r) if a['KPer'] else []
                if not P_found:
                    break
            if not P_found:
                break
    F_known, fk_note = [], 'no certified forced vector'
    if lid == 'K|degrey':
        v = (-16, 8, 8, 0)                                               # v = -(4/9)(1 + sqrt-11), certified (verify-P1d.md)
        F_known, _, _ = S.forced_span(lat, [v])
        fk_note = 'span of the point-group orbit of v = -(4/9)(1+sqrt-11), refused and drat-trim verified (data/fs73/records/verify-P1d.md)'
    summary['P_N'] = {str(N): d for N, d in pn.items()}
    summary['KPer'] = kp
    summary['status'] = status
    summary['P_found'] = {'generators': S.lat_rows(P_found), 'rank': len(P_found),
                          'Lambda_mod': S.describe(P_found, r)['Lambda_mod'] if P_found else {'free': r, 'torsion': []}}
    summary['F_known'] = {'generators': S.lat_rows(F_known), 'rank': len(F_known), 'note': fk_note,
                          'Lambda_mod': S.describe(F_known, r)['Lambda_mod'] if F_known else {'free': r, 'torsion': []}}
    if F_known and P_found:
        summary['P_found_mod_F_known'] = S.quotient_structure(P_found, F_known, r)
    for t in tg:
        c = tuple(t['coords'])
        t['in_P_found'] = bool(P_found) and S.member(P_found, c)
        t['in_F_known'] = bool(F_known) and S.member(F_known, c)
        t['verdict'] = ('forced' if t['in_F_known'] else 'rigid-found' if t['in_P_found'] else 'loose by theorem')
    summary['targets'] = tg
    summary['gapped'] = gapped
    summary['colourable_periods'] = colourable
    summary['refused_periods'] = refused
    summary['informative'] = (len(P_found) == r and len(F_known) < r and bool(colourable) and not gapped)
    summary['seconds'] = round(time.time() - t_start, 1)
    return rows.put(summary)


# ================================================================ commands

def cmd_t5():
    """control: T5's table (data/fs70/owner/cm-subfields-2026-09-22.md), counts and prime types"""
    F = FL.Field((3, 5))
    want = {'Q(sqrt3,i)': (12, 0, 0, 0), 'Q(sqrt3,sqrt-5)': (46, 40, 36, 32), 'Q(sqrt5,i)': (12, 0, 8, 0),
            'Q(sqrt5,sqrt-3)': (22, 16, 0, 0), 'Q(sqrt15,i)': (20, 16, 0, 0), 'Q(sqrt15,sqrt-3)': (18, 0, 12, 0)}
    got = t5_counts(F, 24)
    ok = True
    print('T5 reproduced (units of denominator dividing 24; wall-breaking = not 2-integral; 3-pole = not 3-integral):')
    for sub in cm_subfields(F):
        g = got[sub['name']]
        ar = arithmetic(sub['s'], sub['m'], (2, 3))
        two = '/'.join(p['type'] for p in ar[2])
        three = '/'.join(p['type'] for p in ar[3])
        row = (g['units'], g['wall_breaking'], g['three_pole'], g['both'])
        good = want.get(sub['name']) == row
        ok &= good
        print(f'  {sub["name"]:18s} units {row[0]:3d}  wall {row[1]:3d}  3-pole {row[2]:3d}  both {row[3]:3d}   '
              f'2 over E+: {two:14s} 3 over E+: {three:14s} {"= T5" if good else "!= T5 " + str(want.get(sub["name"]))}')
    print('T5 CONTROL PASSED' if ok else 'T5 CONTROL FAILED')
    return 0 if ok else 1


def cmd_arith(field):
    rad = PILOT[:2] if field == 'PILOT' else FIELDS[field]
    F = FL.Field(rad)
    inv = field_inversion(rad)
    print(f'{F.name}: prime inversion over F (1/p in Z[U_F]): {inv}')
    out = []
    for sub in cm_subfields(F):
        ar = arithmetic(sub['s'], sub['m'])
        wall = all(p['type'] == 'split' for p in ar[2])
        row = {'field': field, 'E': sub['name'], 'wall': 'wall-broken' if wall else '2-unit',
               'primes': {str(p): v for p, v in ar.items()}}
        out.append(row)
        desc = '; '.join(f'{p}: ' + ','.join(f'{x["type"][:3]}({x["q"]})' for x in v) for p, v in ar.items())
        print(f'  {sub["name"]:20s} {row["wall"]:12s} {desc}')
    return out


def load_q167():
    """FS-61's lattices over Q(sqrt167) (data/fs61/charmeans.jsonl, one row per field and shape): the two with the most unit vectors,
    and L3e1c94c6, the one lattice FS-61 asked a ball of at degree 14 (data/fs61/aiming-167.md)"""
    global Q167_SHAPES
    best = {}
    for line in open(os.path.join(ROOT, 'data', 'fs61', 'charmeans.jsonl')):
        d = json.loads(line)
        if d.get('D') == 167 and 'lattice' in d:
            best[d['id']] = (d.get('size', 0), d['lattice'])
    top = sorted(best.items(), key=lambda kv: -kv[1][0])[:2]
    if 'L3e1c94c6' not in dict(top):
        top.append(('L3e1c94c6', best['L3e1c94c6']))
    Q167_SHAPES = [(nm, spec) for nm, (sz, spec) in top]
    return top


def cmd_table(field):
    os.makedirs(TABLE, exist_ok=True)
    rows = Rows(ROWS)
    if field == 'Q167':
        load_q167()
    for lid, build, k in lattice_specs(field):
        t0 = time.time()
        s = run_lattice(rows, lid, build, k)
        print(f'{lid:40s} k={k} rank {s["rank"]} |U| {s["U"]:3d}  m/d {s["spectral"]["m_over_d"]:+.4f} '
              f'({spectral_sign(s["spectral"]["m_over_d"], k)})  '
              f'colourable {s["colourable_periods"]} refused {s["refused_periods"]}  P_found rank {s["P_found"]["rank"]} '
              f'{s["P_found"]["Lambda_mod"]}  F_known rank {s["F_known"]["rank"]}  -- {s["status"]}  [{time.time() - t0:.0f} s]')
    return 0


def selftest(plants=False):
    """code controls: the k-generic finder and KPer at k = 4 against fs73_screen on de Grey's lattice (P_N at N <= 8), a gap found on
    L1 at N = 5 and refused on de Grey at N = 8, and the three plants"""
    fails = []

    def check(nm, ok, detail=''):
        print(f'  [{"ok " if ok else "FAIL"}] {nm}  {detail}')
        if not ok:
            fails.append(nm)
    lat = FL.degrey()
    lat.saturate('trace')
    U, r = lat.U, lat.rank
    tmp = Rows(os.path.join(SCRATCH, f'selftest-{os.getpid()}.jsonl'))
    want = {2: 2, 4: 4, 6: 2, 8: 8}
    for N, m in want.items():
        G, cols, st = p_N_k(tmp, 'selftest', U, r, 4, N)
        check(f'de Grey P_{N} = {m} Lambda (fs73_screen census)', S.hnf(G, r) == S.hnf(S.NW(m, r), r), f'{S.describe(G, r)["Lambda_mod"]}, {st}')
    Q8 = S.Quot(S.NW(8, r), r)
    rec, col = solve_k(Q8, U, 4, 'gap')
    check('de Grey N = 8: no gapped colouring (Harder + T6)', rec['verdict'] == 'UNSAT', rec['verdict'])
    L1 = FL.fabric('group6:u3:2')
    try:
        L1.saturate('trace')
        Q5 = S.Quot(S.NW(5, L1.rank), L1.rank)
        rec, col = solve_k(Q5, L1.U, 4, 'gap')
        check('L1 at N = 5: a gapped colouring (T6 instance), gap read from the colouring', rec['verdict'] == 'SAT' and
              gap_at_origin(Q5, L1.U, col, 4) is not None, rec['verdict'])
    except Exception as e:                                                  # noqa: BLE001
        check('L1 at N = 5', False, f'raised {e}')
    # KPer at k = 4 on a found N = 8 colouring equals fs73_screen's
    G, cols, st = p_N_k(tmp, 'selftest', U, r, 4, 8)
    pc = S.PColour(U, Q8, cols[0])
    Wp, _ = pc.per()
    pd = pc.descend(Wp)
    a, _ = kper_k(pd, 4)
    b, _ = pd.kper()
    check('kper_k(k = 4) = fs73_screen kper on a de Grey N = 8 colouring', S.hnf(a, r) == S.hnf(b, r), S.describe(a, r)['Lambda_mod'])
    # a colouring with an unused colour: kper_k is 0 (every vertex gapped), fs73_screen's skip over-approximates
    Q2 = S.Quot(S.NW(2, r), r)
    col3 = np.array([int(c) for c in S.load_colouring(tmp.get('selftest|k4|N2|plain')['colouring'])[1]], dtype=np.int8)
    pc2 = S.PColour(U, Q2, col3)
    k5, _ = kper_k(pc2, 5)
    check('kper_k at k = 5 on a four-colouring (colour 4 unused) is 0', k5 == [], str(k5))
    # soundness: the broken and the break-free encodings agree on known instances (SAT and UNSAT, three aims, k = 3, 4, 5)
    Q4, Q5d = S.Quot(S.NW(4, r), r), S.Quot(S.NW(5, r), r)
    q11 = FL.q11shape()
    q11.saturate('trace')
    Q7q = S.Quot(S.NW(7, q11.rank), q11.rank)
    cases = [('de Grey N=4 plain k=4', Q4, U, 4, 'plain', None), ('de Grey N=5 plain k=4', Q5d, U, 4, 'plain', None),
             ('de Grey N=8 gap k=4', Q8, U, 4, 'gap', None), ('L1 N=5 gap k=4', Q5, L1.U, 4, 'gap', None),
             ('de Grey N=4 sep 2 k=4', Q4, U, 4, 'sep', tuple(int(x) for x in FL.rational_point(lat, 2))),
             ('de Grey N=4 gap k=5', Q4, U, 5, 'gap', None), ('Q(sqrt11) shape N=7 plain k=3', Q7q, q11.U, 3, 'plain', None)]
    # (de Grey N = 5 plain at k = 5 -- the split plane at 25, five-chromatic by FS-70 phase 0 -- ran to 300 s under both encodings,
    # 2026-09-23: a hardness data point, replaced here by a decidable five-colour case)
    verdicts = {}
    for nm, Qc, Uc, kc, aim, tgt in cases:
        a_, _ = solve_k(Qc, Uc, kc, aim, tgt)
        b_, _ = solve_k(Qc, Uc, kc, aim, tgt, solver='cadical', nobreak=True)
        verdicts[nm] = a_['verdict']
        check(f'break = no break: {nm}', a_['verdict'] == b_['verdict'] and a_['verdict'] in ('SAT', 'UNSAT'),
              f'{a_["verdict"]} / {b_["verdict"]}')
    check('the comparison saw both outcomes (a SAT and an UNSAT case)', {'SAT', 'UNSAT'} <= set(verdicts.values()), str(verdicts))
    if plants:
        global PLANT
        print('  -- plants')
        PLANT = 'pin_prec'
        a_, _ = solve_k(Q4, U, 4, 'plain')
        PLANT = None
        b_, _ = solve_k(Q4, U, 4, 'plain', solver='cadical', nobreak=True)
        check('plant pin_prec fires (the unsound break refuses a colourable quotient; the comparison sees it)',
              a_['verdict'] == 'UNSAT' and b_['verdict'] == 'SAT', f'{a_["verdict"]} / {b_["verdict"]}')
        PLANT = 'kper_skip_unused'
        k5p, _ = kper_k(pc2, 5)
        check('plant kper_skip_unused fires (KPer no longer 0)', k5p != [], S.describe(k5p, r)['Lambda_mod'] if k5p else '0')
        PLANT = 'gap_pin_clash'
        rec, _ = solve_k(Q5, L1.U, 4, 'gap')
        check('plant gap_pin_clash fires (L1 gap refused)', rec['verdict'] == 'UNSAT', rec['verdict'])
        PLANT = None
    os.remove(tmp.path)
    print('SELF-TEST PASSED' if not fails else 'SELF-TEST FAILED: ' + ', '.join(fails))
    return 1 if fails else 0


GAMMA_CHI = {3: '3', 7: '4', 11: '5', 19: '5', 23: '6-8', 27: '6-7', 31: '5-8', 43: '6-8', 47: '6-10'}


def fixed_targets(ar):
    """the conjugation-fixed primes (non-split in E/E+) and what their residue maps give: a homomorphism of the whole plane over E"""
    out = []
    for p, prs in ar.items():
        for pr in prs:
            if pr['type'] == 'split':
                continue
            q = pr['q']
            if p == 2:
                t = 'chi <= 2 (ramified dyadic)' if pr['type'] == 'ramified' else f'U_{q}' + (' (4-colourable)' if q <= 32 else '')
            elif pr['type'] == 'ramified':
                t = f'level-2 at {q} (first level impotent, FS66-E)'
            elif q % 4 == 3:
                t = f'Gamma_{q} (chi {GAMMA_CHI.get(q, ">= 7" if q >= 59 else "?")})'
            else:
                t = f'Cay(F_{q}^2, mu_{q + 1}) (non-split circle)'
            out.append({'p': p, 'q': q, 'type': pr['type'], 'target': t})
    return out


def circle_target(q):
    """Cay(F_{q^2}, mu_{q+1}) for an odd prime q: F_q[t]/(t^2 - n), n a non-residue; vertices a + b t as a q + b; the unit circle
    a^2 - n b^2 = 1 (q + 1 points).  For q = 3 mod 4, n = -1 and this is Gamma_q; for q = 1 mod 4 it is the non-split circle."""
    n = next(x for x in range(2, q) if pow(x, (q - 1) // 2, q) == q - 1) if q % 4 == 1 else q - 1
    circ = [(a, b) for a in range(q) for b in range(q) if (a * a - n * b * b) % q == 1]
    assert len(circ) == q + 1
    E = set()
    for a in range(q):
        for b in range(q):
            for c, d in circ:
                i, j = a * q + b, ((a + c) % q) * q + (b + d) % q
                if i < j:
                    E.add((i, j))
    return q * q, np.array(sorted(E), dtype=np.int64), [c * q + d for c, d in circ]


def cmd_targets(k=5, qs=(3, 5, 7, 11, 13, 17, 19)):
    """does each small fixed-prime target have a gapped k-colouring (a colour absent from the closed neighbourhood of 0)?  A gapped
    colouring of the target pulls back along the residue map at a conjugation-fixed prime to a gapped periodic colouring of every
    lattice of E, so every such lattice is loose at k by FS70-T6.  Break-free CNF (no pins, no precedence), kissat, 300 s.  Rows in
    data/fs73/table/targets.jsonl (a separate file: it may run beside the table driver)."""
    rows = Rows(os.path.join(TABLE, 'targets.jsonl'))
    for q in qs:
        key = f'target:circle{q}|k{k}|gap'
        if rows.get(key):
            print(rows.get(key)['summary'])
            continue
        n, E, nb = circle_target(q)
        x = lambda v, c: k * v + c + 1                                     # noqa: E731
        extra = [[-x(0, k - 1)]] + [[-x(v, k - 1)] for v in nb]
        path = os.path.join(SCRATCH, f'target-{q}.cnf')
        sha, _ = write_cnf_k(path, ([[x(v, c) for c in range(k)] for v in range(n)], E, extra), k * n, k)
        t0, ru0 = time.time(), os.times()
        try:
            pr = subprocess.run(['kissat', '-q', path], capture_output=True, text=True, timeout=BUDGET)
            v, _ = S.sline_verdict(pr.stdout, pr.returncode)
        except subprocess.TimeoutExpired:
            v, pr = 'UNKNOWN', None
        ru1 = os.times()
        cpu = round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2)
        rec = {'key': key, 'q': q, 'k': k, 'vertices': n, 'edges': int(len(E)), 'verdict': v, 'cnf_sha256': sha, 'cpu_s': cpu,
               'machine': MACHINE}
        if v == 'SAT':
            lits = [int(t) for line in pr.stdout.splitlines() if line.startswith('v ') for t in line[2:].split()]
            pos = np.zeros(k * n + 1, dtype=bool)
            L = np.array(lits, dtype=np.int64)
            pos[L[L > 0]] = True
            col = np.argmax(pos[1:].reshape(n, k), axis=1)
            assert not np.any(col[E[:, 0]] == col[E[:, 1]]) and (k - 1) not in {int(col[0])} | {int(col[u]) for u in nb}
            rec['colouring'] = ''.join(map(str, col.tolist()))
            rec['colours_used'] = len(set(col.tolist()))
        rec['summary'] = f'circle target at q = {q}, k = {k}: gapped colouring {v}' + (f' (uses {rec["colours_used"]} colours)' if v == 'SAT' else '')
        os.remove(path)
        rows.put(rec)
        print(rec['summary'])


def cmd_q11_import():
    """F_known over Q(sqrt11) at three colours, from the in-house record (the PO's correction, 2026-09-23): FS-58's forcer of
    (0, 3u), u = (-3/5, 4/5) (data/fs58/witness-11/forcer.json, 52 points on Cay(Z[W0], W0), W0 = the 36 unit vectors of denominator
    dividing 10 -- which IS this table's lattice Q11|3int|D10).  Steps: the forcer's points are placed in the lattice; its edges are
    recomputed from this file's saturated U and compared with the record's; the CNF (three colours, c(0) = 0, a neighbour of 0 at 1,
    c(3u) != 0) is written ONCE and refused by kissat and by cadical on the identical file; the plain control is SAT; then F_known =
    the span of the point-group orbit of 3u, on the 36-vector lattice and on the 100-vector one (forcing is monotone upward in the
    graph, and the 36-vector lattice sits inside the 100-vector one with its unit vectors)."""
    rows = Rows(os.path.join(TABLE, 'imports.jsonl'))
    F = FL.Field((11,))
    sub = cm_subfields(F)[0]
    rec = json.load(open(os.path.join(ROOT, 'data', 'fs58', 'witness-11', 'forcer.json')))
    pts8 = [tuple(p) for p in rec['points']]
    out = {'key': 'import:fs58-forcer-q11', 'source': 'data/fs58/witness-11/forcer.json', 'record_trust': rec['trust'],
           'u_over_10': rec['u'], 'three_u_over_10': rec['three_u'], 'machine': MACHINE}
    for D, lid in ((10, 'Q11|3int|D10'), (50, 'Q11|3int|D50')):
        lat, _ = three_integral_D(F, sub, D)
        lat.saturate('box')
        r = lat.rank
        cs = [lat.coords(lat.to_M(p, 10)) for p in pts8]
        assert all(c is not None for c in cs), 'a forcer point is outside the lattice'
        idx, E = S.ball_graph(cs, lat.U)
        rec_edges = {tuple(sorted(e)) for e in rec['edges']}
        mine = {tuple(sorted(e)) for e in E.tolist()}
        o = cs.index(tuple([0] * r))
        t = cs.index(lat.coords(lat.to_M(tuple(rec['three_u']), 10)))
        nb = min(j for i, j in E.tolist() if i == o) if any(i == o for i, j in E.tolist()) else \
            min(i for i, j in E.tolist() if j == o)
        n = len(cs)
        res = {'lattice': lid, 'U': len(lat.U), 'points': n, 'edges_recomputed': len(mine), 'edges_in_record': len(rec_edges),
               'edges_equal': mine == rec_edges}
        if D == 10:
            parts, nv = S.graph_cnf(n, E, [(o, 0), (nb, 1)], forbid=[(t, 0)], k=3)
            path = os.path.join(SCRATCH, 'q11-forcer.cnf')
            sha, _ = write_cnf_k(path, parts, nv, 3)
            sols = {}
            for solver in ('kissat', 'cadical'):
                exe = CADICAL if solver == 'cadical' else solver
                pr = subprocess.run([exe, '-q', path], capture_output=True, text=True, timeout=BUDGET)
                assert hashlib.sha256(open(path).read().encode()).hexdigest() == sha
                sols[solver] = S.sline_verdict(pr.stdout, pr.returncode)[0]
            partsc, nvc = S.graph_cnf(n, E, [(o, 0), (nb, 1)], k=3)
            pc = os.path.join(SCRATCH, 'q11-forcer-ctl.cnf')
            write_cnf_k(pc, partsc, nvc, 3)
            prc = subprocess.run(['kissat', '-q', pc], capture_output=True, text=True, timeout=BUDGET)
            res.update({'cnf_sha256': sha, 'separate_ask': sols, 'control': S.sline_verdict(prc.stdout, prc.returncode)[0],
                        'critical_set_note': f'common neighbours of 0 and 3u: {len(set(j for i, j in E.tolist() if i == o) & set(j for i, j in E.tolist() if i == t))}'})
            os.remove(path)
            os.remove(pc)
        three_u = cs[t]
        Fk, gord, osz = S.forced_span(lat, [three_u])
        three_all = [tuple(3 * x for x in u) for u in lat.U]
        res.update({'point_group_order': gord, 'orbit_of_3u': osz, 'F_known_from_3u_orbit': S.describe(Fk, r),
                    'F_known_equals_3Lambda': S.hnf(Fk, r) == S.hnf(S.NW(3, r), r),
                    'span_of_3u_all_u_in_U': S.describe(S.hnf(three_all, r), r)})
        out[lid] = res
        print(lid, json.dumps(res))
    rows.put(out)
    return out


def cmd_q11_import_all():
    """every 1-minimal forcer of (0, 3u) FS-58 filed (data/fs58/witness-11/steps.jsonl, rows 'forcer/scan/separate/u=...'): each is
    placed in Q11|3int|D10, its edges recomputed from this file's U, and the separate ask (c(0) = 0, least neighbour 1, c(3u) != 0)
    written once and refused by kissat and cadical on the identical CNF, with the plain control SAT.  F_known = the span of the
    point-group orbits of every 3u so replicated, on the 36- and the 100-vector lattice."""
    rows = Rows(os.path.join(TABLE, 'imports.jsonl'))
    F = FL.Field((11,))
    sub = cm_subfields(F)[0]
    lat, _ = three_integral_D(F, sub, 10)
    lat.saturate('box')
    r = lat.rank
    forced = []
    for line in open(os.path.join(ROOT, 'data', 'fs58', 'witness-11', 'steps.jsonl')):
        d = json.loads(line)
        if not d.get('step', '').startswith('forcer/scan/separate/') or not d.get('forcer'):
            continue
        key = 'import:' + d['step']
        got = rows.get(key)
        if got is None:
            u = tuple(d['u']) if isinstance(d.get('u'), list) else tuple(int(x) for x in d['step'].split('u=')[1].split('/')[0].split(','))
            pts = [tuple(p) for p in d['forcer']]
            cs = [lat.coords(lat.to_M(p, 10)) for p in pts]
            assert all(c is not None for c in cs)
            idx, E = S.ball_graph(cs, lat.U)
            o = cs.index(tuple([0] * r))
            tu = lat.coords(lat.to_M(tuple(3 * x for x in u), 10))
            t = cs.index(tu)
            adj0 = sorted({j for i, j in E.tolist() if i == o} | {i for i, j in E.tolist() if j == o})
            n = len(cs)
            parts, nv = S.graph_cnf(n, E, [(o, 0), (adj0[0], 1)], forbid=[(t, 0)], k=3)
            path = os.path.join(SCRATCH, 'q11-f.cnf')
            sha, _ = write_cnf_k(path, parts, nv, 3)
            sols = {}
            for solver in ('kissat', 'cadical'):
                pr = subprocess.run([CADICAL if solver == 'cadical' else solver, '-q', path], capture_output=True, text=True,
                                    timeout=BUDGET)
                sols[solver] = S.sline_verdict(pr.stdout, pr.returncode)[0]
            partsc, nvc = S.graph_cnf(n, E, [(o, 0), (adj0[0], 1)], k=3)
            write_cnf_k(path, partsc, nvc, 3)
            prc = subprocess.run(['kissat', '-q', path], capture_output=True, text=True, timeout=BUDGET)
            os.remove(path)
            got = rows.put({'key': key, 'u_over_10': list(u), 'three_u_coords': list(tu), 'points': n, 'edges': len(E),
                            'cnf_sha256': sha, 'separate_ask': sols, 'control': S.sline_verdict(prc.stdout, prc.returncode)[0],
                            'in_Q_i': u[1] == 0 and u[3] == 0, 'machine': MACHINE})
        ok = got['separate_ask'] == {'kissat': 'UNSAT', 'cadical': 'UNSAT'} and got['control'] == 'SAT'
        print(f"u = {got['u_over_10']}/10  {'Q(i)' if got['in_Q_i'] else 'sqrt11'}  {got['points']:4d} points  "
              f"{got['separate_ask']}  control {got['control']}  {'REPLICATED' if ok else 'NOT replicated'}")
        if ok:
            forced.append(tuple(got['three_u_coords']))
    Fk, gord, osz = S.forced_span(lat, forced)
    qi = [v for v in forced if True]
    print(f'36-vector lattice: {len(forced)} replicated directions; F_known = {S.describe(Fk, r)}; equals 3 Lambda: '
          f'{S.hnf(Fk, r) == S.hnf(S.NW(3, r), r)}')
    lat50, _ = three_integral_D(F, sub, 50)
    lat50.saturate('box')
    f50 = [lat50.coords(lat50.to_M(lat.point(v), 10)) for v in forced]
    Fk50, gord50, _ = S.forced_span(lat50, f50)
    print(f'100-vector lattice: F_known = {S.describe(Fk50, r)}; equals 3 Lambda: {S.hnf(Fk50, r) == S.hnf(S.NW(3, r), r)}; '
          f'point group order {gord50}')
    rows.put({'key': f'import:summary:{len(forced)}', 'replicated': len(forced), 'F_known_D10': S.describe(Fk, r),
              'F_known_D50': S.describe(Fk50, r), 'point_group_D10': gord, 'point_group_D50': gord50, 'machine': MACHINE})


def cmd_q11_close():
    """(a) every proper 3-colouring of Cay(Lambda/3Lambda, W0 mod 3) on the 36-vector lattice, enumerated with no symmetry break
    (PySAT cadical153 with blocking clauses), each tested for affinity: its colour classes are the three cosets of one index-3
    subgroup.  With F = 3 Lambda every 3-colouring of the lattice graph is one of these.  (b) P_15 exactly on the 100-vector lattice,
    where F contains 15 Lambda_50 (the imported forcers), so every 3-colouring is 15 Lambda_50-periodic and P = F = P_15."""
    from pysat.solvers import Solver
    rows = Rows(os.path.join(TABLE, 'imports.jsonl'))
    F = FL.Field((11,))
    sub = cm_subfields(F)[0]
    lat, _ = three_integral_D(F, sub, 10)
    lat.saturate('box')
    r = lat.rank
    Q = S.Quot(S.NW(3, r), r)
    E, res = S.quotient_graph(Q, lat.U)
    n, k = Q.n, 3
    x = lambda v, c: k * v + c + 1                                               # noqa: E731
    cls = [[x(v, c) for c in range(k)] for v in range(n)] + [[-x(v, a), -x(v, b)] for v in range(n) for a in range(k)
                                                               for b in range(a + 1, k)]
    cls += [[-x(int(a), c), -x(int(b), c)] for a, b in E for c in range(k)]
    digs = Q.digits()
    allc, affine = 0, 0
    with Solver(name='cadical153', bootstrap_with=cls) as sv:
        while sv.solve():
            m = sv.get_model()
            col = np.array([next(c for c in range(k) if m[x(v, c) - 1] > 0) for v in range(n)])
            allc += 1
            H = set(np.nonzero(col == col[0])[0].tolist())
            Hd = {tuple(digs[h]) for h in H}
            closed = len(H) == n // 3 and all(tuple(np.mod(np.array(a) + np.array(b), 3)) in Hd for a in Hd for b in Hd)
            cosets = closed and all(len({tuple(np.mod(digs[v] - digs[w], 3)) for w in np.nonzero(col == c)[0][:1]
                                          for v in np.nonzero(col == c)[0]} - Hd) == 0 for c in range(k))
            affine += bool(cosets)
            sv.add_clause([-x(v, int(col[v])) for v in range(n)])
    out = {'key': 'import:q11-close:affine', 'classes': n, 'edges': int(len(E)), 'colourings_all': allc, 'affine': affine,
           'machine': MACHINE}
    print(f'Lambda_10/3Lambda_10: {n} classes, {len(E)} edges, {allc} proper 3-colourings (no break), {affine} affine')
    rows.put(out)
    lat50, _ = three_integral_D(F, sub, 50)
    lat50.saturate('box')
    Q15 = S.Quot(S.NW(15, r), r)
    print(f'100-vector lattice: N = 15 admissible {Q15.admissible(lat50.U)}, {Q15.n} classes')
    G, cols, st = p_N_k(rows, 'Q11|3int|D50', lat50.U, r, 3, 15)
    d = {'key': 'import:q11-close:P15', 'P_15': S.lat_rows(G) if G else None, 'status': st, 'colourings': len(cols),
         'desc': S.describe(G, r) if G else None, 'equals_3Lambda50': bool(G) and S.hnf(G, r) == S.hnf(S.NW(3, r), r),
         'machine': MACHINE}
    rows.put(d)
    print(json.dumps(d))


def load_jsonl(name):
    path = os.path.join(TABLE, name)
    out = {}
    if os.path.exists(path):
        for line in open(path):
            if line.strip():
                d = json.loads(line)
                out[d['key']] = d
    return out


def fmt_mod(d, r):
    """Lambda / G as Z^f x (+) Z/t"""
    if d is None:
        return '?'
    parts = ([f'Z^{d["free"]}'] if d['free'] else []) + [f'Z/{t}' for t in d['torsion']]
    return ' x '.join(parts) if parts else '0'


def cmd_report():
    """the table, rendered from the committed rows only (rows.jsonl, imports.jsonl, targets.jsonl) and PARI's arithmetic"""
    R = load_jsonl('rows.jsonl')
    I = load_jsonl('imports.jsonl')
    summ = [d for k_, d in R.items() if k_.startswith('row:')]
    degrey = R.get('row:K|degrey|k4')
    order = ['K', 'Q35', 'Q3_23', 'Q3_47', 'Q11', 'Q167', 'PILOT']
    summ.sort(key=lambda d: (order.index(d['lattice'].split('|')[0]), d['lattice'] != 'K|degrey', d['lattice']))
    lines = ['| lattice (field, CM subfield E, how built) | k | rank, U | 2-adic (b) | 3-adic (a) | spectral (c): m/d vs -1/(k-1) | '
             'periods (d): colourable / refused / first gap | composite (e) | P_found | F_known (provenance) | chainable targets (f) | verdict |',
             '|' + '---|' * 12]
    cache = {}
    for d in summ:
        lid, k, r = d['lattice'], d['k'], d['rank']
        field = lid.split('|')[0]
        if field == 'PILOT':
            s_, m = 3, 77
        elif lid == 'K|degrey':
            s_, m = 33, 3
        else:
            nm = lid.split('|')[1]
            if nm.startswith('Q(sqrt') and ',' in nm:
                a, b = nm[len('Q(sqrt'):-1].split(',')
                s_, m = int(a), (1 if b == 'i' else int(b[len('sqrt-'):]))
            else:                                      # the quadratic fields' rows: E = F(i)
                s_, m = {'Q11': 11, 'Q167': 167}[field], 1
        if (s_, m) not in cache:
            cache[(s_, m)] = arithmetic(s_, m, (2, 3))
        ar = cache[(s_, m)]
        two = ', '.join(f'{p["type"]}({p["q"]})' for p in ar[2])
        three = ', '.join(f'{p["type"]}({p["q"]})' for p in ar[3])
        wall = 'wall-broken' if all(p['type'] == 'split' for p in ar[2]) else '2-unit'
        sp = d['spectral']
        sign = spectral_sign(sp['m_over_d'], k)
        tors = sp.get('argmin', '')
        tors = tors if isinstance(tors, str) else ('not torsion at denominators <= 64' if sp.get('argmin_residual', 1) > 1e-5
                                                    else 'torsion (' + ', '.join(tors) + ')')
        if (s_, m, 'odd') not in cache:
            cache[(s_, m, 'odd')] = arithmetic(s_, m, (5, 7, 11))
        aro = cache[(s_, m, 'odd')]
        qt = '; '.join(f'{pr["N"]}: {pr["U_mod_N"]} of {norm_one_count(aro, pr["N"])}' for pr in d['periods']
                       if pr.get('admissible') and pr['N'] in (5, 7, 11) and d['M'] % pr['N'])
        unk = [pr['N'] for pr in d['periods'] if pr.get('admissible') and pr['plain'] not in ('SAT', 'UNSAT')]
        per = f'{d["colourable_periods"] or "none"} / {d["refused_periods"] or "none"} / ' + \
              (f'UNKNOWN at 300 s {unk} / ' if unk else '') + \
              (str(d['gapped']['N']) if d.get('gapped') else 'no gap') + (f'; U mod p of the target circle: {qt}' if qt else '')
        comp = '; '.join(f'{c["N"]}: ' + (c.get('verdict') or f'{c.get("plain")}, gap {c.get("gap")}') for c in d['composite']) or '-'
        Pf, Fk = d['P_found'], d['F_known']
        prov = 'none'
        fk_rank, fk_mod = Fk['rank'], Fk['Lambda_mod']
        if lid == 'K|degrey' or (degrey and d['H'] == degrey['H'] and k == 4):
            fk_rank, fk_mod = 4, {'free': 0, 'torsion': [8, 8, 8, 8]}
            prov = 'census + independent verifier: v = -(4/9)(1+sqrt-11) refused (drat-trim), orbit spans 8 Lambda'
        imp = None
        if lid == 'Q11|3int|D10':
            imp = I.get('import:summary:48')
            if imp:
                fk_rank, fk_mod = imp['F_known_D10']['rank'], imp['F_known_D10']['Lambda_mod']
        if lid == 'Q11|3int|D50':
            imp = I.get('import:summary:48')
            if imp:
                fk_rank, fk_mod = imp['F_known_D50']['rank'], imp['F_known_D50']['Lambda_mod']
        if imp and lid == 'Q11|3int|D10':
            prov = ("in-house record: FS-58's forcers of (0, 3u) (48 filed, each refused here by kissat and cadical on an identical "
                    "CNF); the two that span 3 Lambda -- u1 = (-3/5, 4/5), orbit rank 2, and u2 = ((-3-2 sqrt11)/10, (-6+sqrt11)/10), "
                    "orbit rank 4 at index 9 in 3 Lambda: BOTH needed for exactly 3 Lambda (at K, v alone gave 8 Lambda) -- "
                    "VERIFIED (independent), 4eba7998, data/fs73/records/verify-P2-q11.md")
            imp = None
        if imp and lid == 'Q11|3int|D50':
            p15 = I.get('import:q11-close:P15')
            prov = ("the verified Lambda_10 forcers (4eba7998) are forcers here too (Lambda_10 = 5 Lambda_50 with its unit vectors; "
                    "Forces is monotone): F >= 15 Lambda_50, finite index, so every colouring is 15 Lambda_50-periodic and "
                    "P = F = P_15 (section 0 consequence 3)")
            if p15 and p15.get('equals_3Lambda50'):
                fk_rank, fk_mod = r, Pf['Lambda_mod']
                prov += ('; P_15 = 3 Lambda_50 EXACTLY by this phase\'s loop (every generator UNSAT, each replicated break-free '
                         'by cadical; not independently verified)')
            imp = None
        if d.get('gapped'):
            prov = 'none needed: F = 0 (a gapped periodic colouring, FS70-T6)'
        tg = d['targets']
        ch = [t for t in tg if t['chainable']]
        in_f = sorted({t['q'] for t in ch if t['in_F_known'] or (fk_rank == r and Pf['rank'] == r and t['in_P_found'] and
                                                             fk_mod == Pf['Lambda_mod'])})
        rig = sorted({t['q'] for t in ch if t['in_P_found']} - set(in_f))
        loose = sorted({t['q'] for t in ch if not t['in_P_found']})
        chs = f'forced {in_f or "-"}; rigid-found {rig or "-"}; loose {loose or "-"}' if ch else 'none chainable in the list'
        if not d['colourable_periods'] and not d.get('gapped'):
            chs = f'vacuous (no periodic colouring found): {sorted({t["q"] for t in ch})}'
        if d.get('gapped'):
            verdict = f'loose by theorem: F = P = 0 (gap at N = {d["gapped"]["N"]})'
        elif not d['colourable_periods']:
            verdict = 'REFUSING at every N <= 12 searched (C3-aper case; P_found = Lambda vacuously)'
        elif fk_rank == r and fk_mod == Pf['Lambda_mod']:
            verdict = f'C3 holds: F = P = P_found ({fmt_mod(Pf["Lambda_mod"], r)})'
        elif fk_rank == r:
            verdict = f'C3 holds (F finite index); P_found / F_known finite'
        elif Pf['rank'] == r:
            verdict = 'INFORMATIVE: P_found full rank, F_known lower rank, forcing undecided'
        else:
            verdict = 'P_found rank < 4'
        nm = lid if len(lid) < 40 else lid[:40]
        lines.append(f'| `{nm}` | {k} | {r}, {d["U"]} | {wall}: {two} | {three} | {sp["m_over_d"]:+.4f} vs {sp["tight_at"]:+.4f}: '
                     f'{sign} ({tors}) | {per} | {comp} | rank {Pf["rank"]}, Lambda/P = {fmt_mod(Pf["Lambda_mod"], r)} | '
                     f'rank {fk_rank}, Lambda/F = {fmt_mod(fk_mod, r)} ({prov}) | {chs} | {verdict} |')
    txt = '\n'.join(lines)
    print(txt)
    return txt


def cmd_q167_periods(name='L3e1c94c6', nmin=13, nmax=24):
    """the period search on one Q(sqrt167) lattice beyond N = 12 (plain asks at three colours; rows in q167-periods.jsonl, which
    may run beside the table driver): does the lattice have ANY periodic 3-colouring?"""
    load_q167()
    spec = dict(Q167_SHAPES)[name]
    lat, _ = fs61_shape(167, spec)
    lat.saturate('box')
    U, r = lat.U, lat.rank
    rows = Rows(os.path.join(TABLE, 'q167-periods.jsonl'))
    lid = f'Q167|fs61:{name}'
    for N in range(nmin, nmax + 1):
        Q = S.Quot(S.NW(N, r), r)
        if not Q.admissible(U):
            print(f'N = {N}: inadmissible (a unit vector lies in N Lambda)')
            continue
        rec, col = ask_k(rows, f'{lid}|k3|N{N}|plain', Q, U, 3, 'plain', None, lid)
        extra = ''
        if col is not None:
            rg, cg = ask_k(rows, f'{lid}|k3|N{N}|gap', Q, U, 3, 'gap', None, lid)
            extra = f'; gap {rg["verdict"]}'
        rep = (rec.get('replication') or {}).get('verdict')
        print(f'N = {N}: {Q.n} classes, plain {rec["verdict"]} ({rec.get("cpu_s")} s; break-free cadical {rep}){extra}')


def cmd_pilot_screen(D=24):
    """every quartic CM subfield of K(sqrt7)(i) = Q(sqrt3, sqrt7, sqrt11, i): its wall, its fixed primes' targets, its units at D"""
    group = [1, 3, 7, 11, 21, 33, 77, 231]
    seen, out = set(), []
    for s_ in group[1:]:
        for m in group:
            cls = frozenset({m, sqfree(m * s_)})
            if (s_, cls) in seen:
                continue
            seen.add((s_, cls))
            # a coprime biquadratic representation F = Q(sqrt a, sqrt b) holding E
            rep = None
            for a in group[1:]:
                for b in group[1:]:
                    if a < b and math.gcd(a, b) == 1:
                        vals = {1: a, 2: b, 3: a * b}
                        sm = next((kk for kk, vv in vals.items() if vv == s_), None)
                        if sm is None:
                            continue
                        if m == 1 and 1 in cls:
                            rep = (a, b, sm, 0)
                        else:
                            tm = next((kk for kk, vv in vals.items() if kk != sm and vv in cls), None)
                            if tm is not None:
                                rep = (a, b, sm, tm)
                    if rep:
                        break
                if rep:
                    break
            if rep is None:                        # no coprime pair: the non-coprime basis (1, sqrt s, sqrt m, sqrt sm) is still a
                rep = (s_, max(cls), 1, 2)          # valid multiplication table (fs73_lattice.Field); unit enumeration may need a larger D
            mm = min(cls)
            ar = arithmetic(s_, mm)
            wall = all(p['type'] == 'split' for p in ar[2])
            F = FL.Field(rep[:2])
            sub = next(x for x in cm_subfields(F) if x['xm'] == (0, rep[2]) and (x['ym'][0] == rep[3]))
            nU = sum(1 for v in FL.units_over(F, D) if in_subfield(v, sub, F.n))
            ft = fixed_targets(ar)
            small = [t for t in ft if t['p'] > 2 and ('chi 3' in t['target'] or 'chi 4' in t['target'] or 'chi 5' in t['target'])]
            row = {'E': sub['name'], 'rep': rep, 'wall': 'wall-broken' if wall else '2-unit', 'units_D24': nU,
                   'fixed': ft, 'small_fixed_targets': [f"{t['q']}:{t['target']}" for t in small]}
            out.append(row)
            print(f"{sub['name']:22s} rep {rep}  {row['wall']:12s} units {nU:3d}  fixed-with-chi<=5: {row['small_fixed_targets']}  "
                  f"all fixed: {[(t['q'], t['type'][:3]) for t in ft]}")
    return out


def main():
    argv = sys.argv[1:]
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 't5':
        return cmd_t5()
    if argv[0] == 'arith':
        cmd_arith(argv[1])
        return 0
    if argv[0] == 'table':
        return cmd_table(argv[1])
    if argv[0] == 'selftest':
        return selftest('--plants' in argv)
    if argv[0] == 'q167periods':
        cmd_q167_periods(nmax=int(argv[1]) if len(argv) > 1 else 24)
        return 0
    if argv[0] == 'report':
        cmd_report()
        return 0
    if argv[0] == 'q11close':
        cmd_q11_close()
        return 0
    if argv[0] == 'q11importall':
        cmd_q11_import_all()
        return 0
    if argv[0] == 'q11import':
        cmd_q11_import()
        return 0
    if argv[0] == 'targets':
        cmd_targets()
        return 0
    if argv[0] == 'pilotscreen':
        cmd_pilot_screen()
        return 0
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
