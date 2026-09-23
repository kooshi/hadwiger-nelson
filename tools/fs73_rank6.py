#!/usr/bin/env python3
"""fs73_rank6 -- FS-73 phase P4: the rank-6 mechanism, re-aimed at four colours.  UNTRUSTED (tools/).

For each rank-6 lattice held (L2, L3, L6 over Q(sqrt3, sqrt5); KR6 = de Grey's 30 generators plus the zeta6-orbit of rho15 over
K(sqrt5) = Q(sqrt3, sqrt5, sqrt11)) and each admissible period N <= 6, the periodic four-colourings of Cay(Lambda/N Lambda, U mod N):
  N = 2   every pinned colouring (the quotient has 64 classes: enumerated to exhaustion, fs73_card.enumerate_all);
  N > 2   the finder's colourings: the P_N loop (fs73_screen.p_N, exact P_N), one separating ask per target, one gap-aimed ask.
Per colouring c (descended to Lambda/Per(c)):
  Per(c), KPer(c) (fs73_screen.PColour), and THE KEMPE TABLE: for every colour pair a < b and EVERY component Q of the (a, b)-subgraph,
  Q's voltage group V_Q = Stab(lift of Q) n Per(c), reported as Lambda/V_Q and N Lambda/(V_Q n N Lambda) (Smith invariants), grouped;
  ADDITIVE iff [Lambda : Per(c)] = 4 (the colour classes are then the four cosets of Per(c), a homomorphism to Z/4 or (Z/2)^2);
  CHIRAL (strict) iff no colour permutation tau has c(-x) = tau(c(x)); CHIRAL iff no (t, tau) has c(t - x) = tau(c(x)) (a point
  reflection about t/2 composed with a colour permutation) -- Coxeter's section 6 notion of a phase not equivalent to its antipode;
  the targets: in Per? in KPer? the origin's T10 verdict and, for an escape, R3's W' (fs73_screen.PColour.origin_screen).
Per (lattice, N): P_found at N, and at the end P_found over every N, and its intersection over the point group's images
(g.c is again a periodic colouring, so P <= g KPer(c) for every g).

  run NAME N            one lattice-period pair (rows: data/fs73/rank6/rows.jsonl; a key present is never recomputed)
  all [--only L3,KR6]   every pair, in order, resuming
  mechanism NAME N      per Kempe component: V_Q against D_Q, the sum of the fibre-collision lattices of the residues it uses
  summary               P_found per lattice over every N, closed under the point group; the report the record quotes
  selftest [--plants]   the controls (below) and the planted faults

Controls: the enumeration count on L3 at N = 2 is P1g's 2,304; a gapped colouring has KPer = 0 (L6/L2 at N = 5); the chirality test
reads every N = 2 colouring ACHIRAL (-x = x mod 2 Lambda) and an additive colouring achiral; chirality() equals a brute-force twin
on every proper 4-colouring of G(Z/10, {1, 3}), and a chiral one exists there (the positive control); paired plants: 'chir_noneg'
(the reflection omitted -- the positive control must read achiral), 'add_index' (additive read as index divisible by 4 -- the L3 N = 2
additive count must move).
"""
import gzip
import hashlib
import itertools
import json
import math
import os
import sys
import time
from collections import Counter

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs73_lattice as FL                                                     # noqa: E402
import fs73_screen as S                                                       # noqa: E402
import fs73_card as CARD                                                      # noqa: E402

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]
VALID_PLANTS = ('chir_noneg', 'add_index')

OUT = os.path.join(ROOT, 'data', 'fs73', 'rank6')
ROWS = os.path.join(OUT, 'rows.jsonl')
S.COLDIR = os.path.join(OUT, 'colourings')
S.SCRATCH = ('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-implF')
SPECS = {'L2': 'group6:u3:2+zeta6:v4', 'L3': 'group6:u3:2+zeta6:w4', 'L6': 'group6:u3:2+zeta6:rho15'}
ORDER = ['L3', 'L2', 'L6', 'KR6']
NS = [2, 3, 4, 5, 6]


def planted(name):
    return PLANT == name


# ================================================================ the lattices

class Field3(FL.Field):
    """FL.Field for any number of radicands (the multiplication table and embeddings are already general; only the assert differs)"""
    def __init__(self, radicands):
        self.rad = tuple(radicands)
        k = len(self.rad)
        self.n = 2 ** k
        self.subsets = [tuple(i for i in range(k) if m >> i & 1) for m in range(self.n)]
        self.mask = {s: sum(1 << i for i in s) for s in self.subsets}
        self.table = {}
        for a in range(self.n):
            for b in range(self.n):
                coef = 1
                for i in range(k):
                    if a >> i & 1 and b >> i & 1:
                        coef *= self.rad[i]
                self.table[(a, b)] = (coef, a ^ b)
        self.signs = list(itertools.product((1, -1), repeat=k))
        self.sqrt = [math.sqrt(r) for r in self.rad]
        self.name = 'Q(' + ','.join(f'sqrt{r}' for r in self.rad) + ')'


F3511 = Field3((3, 5, 11))
KMASK = {0: 0, 1: 1, 2: 4, 3: 5}          # K = Q(sqrt3, sqrt11) mask (3 -> bit 0, 11 -> bit 1) into (3, 5, 11) (11 -> bit 2)


def kr6():
    """de Grey's 30 generators zeta6^m rho^n (|n| <= 2), lifted into K(sqrt5), plus zeta6^m rho15 and zeta6^m conj(rho15),
    rho15 = (7 + i sqrt15)/8"""
    F = F3511
    pts = []
    for v, m in [(p, 36) for p in _degrey_generators()]:
        x = [0] * 8
        y = [0] * 8
        for km, nm in KMASK.items():
            x[nm] = v[km]
            y[nm] = v[4 + km]
        pts.append((tuple(x) + tuple(y), m))
    zeta6 = (tuple([1, 0, 0, 0, 0, 0, 0, 0]) + tuple([0, 1, 0, 0, 0, 0, 0, 0]), 2)
    rho15 = (tuple([7, 0, 0, 0, 0, 0, 0, 0]) + tuple([0, 0, 0, 1, 0, 0, 0, 0]), 8)
    for w in (rho15, (rho15[0][:8] + tuple(-t for t in rho15[0][8:]), 8)):
        z = w
        for _ in range(6):
            pts.append(z)
            z = FL.reduce_point(FL.cmul(F, z[0], zeta6[0]), z[1] * zeta6[1])
    for p, m in pts:
        assert FL.is_unit(F, FL.reduce_point(p, m)[0], FL.reduce_point(p, m)[1]), (p, m)
    return FL.Lattice(F, pts, 'KR6')


def _degrey_generators():
    """de Grey's 30 generators as 8-vectors over 36 (FL.degrey keeps only the Hermite basis, so rebuild them)"""
    K = FL.K
    zeta6 = ((1, 0, 0, 0, 0, 1, 0, 0), 2)
    rho = ((5, 0, 0, 0, 0, 0, 1, 0), 6)
    rhob = ((5, 0, 0, 0, 0, 0, -1, 0), 6)

    def mul(p, q):
        return FL.reduce_point(FL.cmul(K, p[0], q[0]), p[1] * q[1])
    out = []
    zm = ((1, 0, 0, 0, 0, 0, 0, 0), 1)
    for m in range(6):
        for nn in range(-2, 3):
            w = zm
            for _ in range(abs(nn)):
                w = mul(w, rho if nn > 0 else rhob)
            out.append(FL.over(w[0], w[1], 36))
        zm = mul(zm, zeta6)
    return out


def build(name):
    if name in SPECS:
        lat = FL.fabric(SPECS[name])
    elif name == 'KR6':
        lat = kr6()
    else:
        raise SystemExit(f'unknown lattice {name!r}')
    return lat


def load(name):
    """the lattice, saturated (trace), with its point group; cached in data/fs73/rank6/lattice-NAME.json"""
    path = os.path.join(OUT, f'lattice-{name}.json')
    if os.path.exists(path):
        d = json.load(open(path))
        F = F3511 if d['radicands'] == [3, 5, 11] else FL.Field(tuple(d['radicands']))
        lat = FL.Lattice(F, [(tuple(h), d['M']) for h in d['H']], name, M=d['M'])
        assert [list(h) for h in lat.H] == d['H']
        lat.U8 = [tuple(u) for u in d['U8']]
        lat.U = [lat.coords(v) for v in lat.U8]
        lat.saturation = d['saturation']
        G = [tuple(tuple(r) for r in A) for A in d['point_group']]
        return lat, G
    t0 = time.time()
    lat = build(name)
    lat.saturate('trace')
    G, gens = FL.point_group(lat)
    os.makedirs(OUT, exist_ok=True)
    json.dump({'name': name, 'spec': SPECS.get(name, 'degrey 30 + zeta6.{rho15, conj rho15} over Q(sqrt3,sqrt5,sqrt11)'),
               'radicands': list(lat.F.rad), 'M': lat.M, 'rank': lat.rank, 'H': [list(h) for h in lat.H],
               'U8': [list(u) for u in lat.U8], 'saturation': lat.saturation, 'point_group': [[list(r) for r in A] for A in G],
               'point_group_generators': sorted({v[0] if not v[0].startswith('mul') else 'mul' for v in gens.values()}),
               'seconds': round(time.time() - t0, 1), 'machine': S.MACHINE}, open(path, 'w'))
    return lat, G


def targets(lat):
    """the chainable targets (FS70-T1/T7's depth classes) as lattice coordinates, where they lie in the lattice"""
    n = lat.F.n
    out = {}
    for nm, (num, den) in {'2': (2, 1), '2/3': (2, 3), '4/3': (4, 3), '8/3': (8, 3), '4': (4, 1), '8/9': (8, 9),
                           '16/3': (16, 3)}.items():
        c = FL.rational_point(lat, num, den)
        if c is not None:
            out[nm] = tuple(c)
    x = [0] * (2 * n)
    x[n + 1] = 1                                    # i sqrt3 (sqrt3 is the first radicand in every field here)
    w = lat.to_M(tuple(x), 1)
    c = None if w is None else lat.coords(w)
    if c is not None:
        out['i sqrt3'] = tuple(c)
    x = [0] * (2 * n)
    x[1] = 4                                        # 4/sqrt3 = 4 sqrt3 / 3
    w = lat.to_M(tuple(x), 3)
    c = None if w is None else lat.coords(w)
    if c is not None:
        out['4/sqrt3'] = tuple(c)
    if lat.name == 'KR6':                           # de Grey's certified v = -(4/9)(1 + sqrt-11): x = -4/9, y = -(4/9) sqrt11
        x = [0] * (2 * n)
        x[0] = -4
        x[n + 4] = -4
        w = lat.to_M(tuple(x), 9)
        c = None if w is None else lat.coords(w)
        if c is not None:
            out['v'] = tuple(c)
    return out


# ================================================================ per-colouring analysis

def chirality(Q, col):
    """(strict, translated): strict = no tau with c(-x) = tau(c(x)); translated = no (t, tau) with c(t - x) = tau(c(x))"""
    n = Q.n
    D = Q.digits()
    negD = np.mod(-D, Q.mods)
    if planted('chir_noneg'):
        negD = D                                     # PLANT: the reflection omitted
    neg = (negD * Q.pw).sum(axis=1)

    def consistent(vals):
        tau = np.full(4, -1, dtype=np.int64)
        for a in range(4):
            m = col == a
            if not m.any():
                continue
            v = vals[m]
            if not (v == v[0]).all():
                return None
            tau[a] = v[0]
        used = tau[tau >= 0]
        return tau if len(set(used.tolist())) == len(used) else None
    strict = consistent(col[neg]) is None
    rng = np.random.default_rng(0)
    Ssamp = rng.choice(n, size=min(96, n), replace=False)
    # every t at once on the sample: class of t - s = (t + neg(s))
    translated_ok = None
    for lo in range(0, n, 4096):
        T = D[lo:lo + 4096]
        Cls = (np.mod(T[:, None, :] + negD[Ssamp][None, :, :], Q.mods) * Q.pw).sum(axis=2)
        vals = col[Cls]                              # (t, s)
        cs = col[Ssamp]
        good = np.ones(len(T), dtype=bool)
        for a in range(4):
            m = cs == a
            if m.sum() > 1:
                good &= (vals[:, m] == vals[:, m][:, :1]).all(axis=1)
        for i in np.nonzero(good)[0]:
            t = lo + int(i)
            cl = (np.mod(D[t][None, :] + negD, Q.mods) * Q.pw).sum(axis=1)
            if consistent(col[cl]) is not None:
                translated_ok = t
                break
        if translated_ok is not None:
            break
    return strict, translated_ok is None, translated_ok


def kempe_table(pc, N, r):
    """every component of every two-colour subgraph: {pair: [{'components', 'classes', 'V_rank', 'Lambda/V', 'NLambda/V'}]}"""
    NLam = S.NW(N, r)
    out = {}
    distinct = {}
    for a, b in itertools.combinations(range(4), 2):
        if not ((pc.col == a).any() and (pc.col == b).any()):
            continue
        lab, p, V, roots = pc.components(a, b)
        sizes = Counter(lab[lab >= 0].tolist())
        groups = {}
        for L, H in V.items():
            key = tuple(tuple(h) for h in H)
            g = groups.setdefault(key, {'components': 0, 'classes': Counter()})
            g['components'] += 1
            g['classes'][sizes[L]] += 1
        rowsab = []
        for key, g in groups.items():
            H = [list(h) for h in key]
            if key not in distinct:
                VN = S.intersect(H, NLam, r) if H else []
                distinct[key] = {'V_rank': len(H), 'Lambda/V': S.describe(H, r)['Lambda_mod'],
                                 'NLambda/V': S.quotient_structure(S.hnf(NLam, r), VN, r) if VN else {'free': r, 'torsion': []}}
            rowsab.append(dict(distinct[key], components=g['components'],
                               classes=dict(sorted((int(k), v) for k, v in g['classes'].items()))))
        out[f'{a}{b}'] = sorted(rowsab, key=lambda d: (d['V_rank'], json.dumps(d['Lambda/V'])))
    return out


def analyse(lat, U, N, col, tg):
    r = lat.rank
    Q = S.Quot(S.NW(N, r), r)
    pc = S.PColour(U, Q, col, f'N{N}')
    Wp, _ = pc.per()
    pd = pc.descend(Wp) if S.hnf(Wp, r) != S.hnf(Q.W, r) else pc
    KP, st = pd.kper()
    per = S.describe(Wp, r)
    idx = per['index']
    additive = (idx is not None and idx % 4 == 0) if planted('add_index') else (idx == 4)   # PLANT: index divisible by 4
    strict, chiral, t = chirality(pd.Q, pd.col)
    tab = kempe_table(pd, N, r)
    trg = {}
    for nm, d in tg.items():
        inPer = S.member(Wp, d)
        inK = S.member(KP, d) if KP else False
        scr = pc.origin_screen(d)
        esc = None
        if scr['verdict'] == 'escape':
            esc = {'level': scr['level'], 'escape_colour': scr.get('escape_colour')}
            if scr['level'] == 1:
                wp = scr['per_b'][scr['escape_colour']]['W_prime']
                esc['W_prime_mod'] = wp['Lambda_mod']
                esc['W_prime_exponent'] = wp.get('exponent')
        trg[nm] = {'in_Per': inPer, 'in_KPer': inK, 'T10': scr['verdict'], 'escape': esc}
    gaps = S.gap_vertex_count(Q, U, col)
    return {'sha': hashlib.sha256(''.join(map(str, col.tolist())).encode()).hexdigest()[:16],
            'Per': S.lat_rows(Wp), 'Lambda/Per': per['Lambda_mod'], 'additive': additive, 'chiral_strict': strict,
            'chiral': chiral, 'reflection_centre_class': t, 'KPer': S.lat_rows(KP), 'Lambda/KPer': S.describe(KP, r)['Lambda_mod'],
            'KPer_rank': len(KP), 'gapped_classes': gaps, 'kempe': tab, 'targets': trg}


# ================================================================ one lattice-period pair

def colourings(lat, U, N, rows, name, tg):
    r = lat.rank
    Q = S.Quot(S.NW(N, r), r)
    if Q.n <= 64:
        cols, pins, note = CARD.enumerate_all(Q, U)
        return cols, {'how': f'every pinned colouring (enumerated to exhaustion; {note})', 'count': len(cols)}
    G, cols, status = S.p_N(rows, name, U, r, N, prefix=f'{name}|')
    if G is None:
        return [], {'how': 'P_N loop', 'plain': status}
    info = {'how': 'P_N loop + one sep ask per target + one gap ask', 'P_N': S.describe(G, r)['Lambda_mod'], 'P_N_status': status}
    for nm, d in tg.items():
        rec, col = S.ask(rows, f'{name}|N{N}:sep:{nm}', Q, U, 'sep', d, 600, name, f'{name}-N{N}')
        info[f'sep:{nm}'] = rec['verdict']
        if col is not None:
            cols.append(col)
    rec, col = S.ask(rows, f'{name}|N{N}:gap', Q, U, 'gap', None, 600, name, f'{name}-N{N}')
    info['gap'] = rec['verdict']
    if col is not None:
        cols.append(col)
    uniq, seen = [], set()
    for c in cols:
        h = c.tobytes()
        if h not in seen:
            seen.add(h)
            uniq.append(c)
    info['count'] = len(uniq)
    return uniq, info


def run_pair(name, N, rows=None):
    rows = rows or S.Rows(ROWS)
    key = f'{name}|N{N}|pair'
    if rows.get(key):
        return rows.get(key)
    lat, G = load(name)
    U, r = lat.U, lat.rank
    tg = targets(lat)
    Q = S.Quot(S.NW(N, r), r)
    t0 = time.time()
    if not Q.admissible(U):
        return rows.put({'key': key, 'lattice': name, 'N': N, 'admissible': False, 'machine': S.MACHINE})
    cols, info = colourings(lat, U, N, rows, name, tg)
    per_col = [analyse(lat, U, N, c, tg) for c in cols]
    P = None
    for a in per_col:
        P = a['KPer'] if P is None else S.intersect(P, a['KPer'], r)
    agg = aggregate(per_col, tg)
    os.makedirs(S.COLDIR, exist_ok=True)
    cpath = os.path.join(S.COLDIR, f'{name}-N{N}-all.json.gz')
    with gzip.open(cpath, 'wt') as f:
        json.dump({'lattice': name, 'N': N, 'index': 'fs73_screen.Quot of N Lambda (big-endian, C = I)',
                   'colourings': [''.join(map(str, c.tolist())) for c in cols]}, f)
    detail = per_col if len(per_col) <= 64 else 'aggregated (more than 64 colourings; recompute from the colourings file)'
    return rows.put({'key': key, 'lattice': name, 'N': N, 'admissible': True, 'classes': Q.n, 'colourings_info': info,
                     'colourings_file': os.path.relpath(cpath, ROOT),
                     'P_found_N': None if P is None else S.lat_rows(P),
                     'Lambda/P_found_N': None if P is None else S.describe(P, r)['Lambda_mod'],
                     'aggregate': agg, 'per_colouring': detail, 'seconds': round(time.time() - t0, 1), 'machine': S.MACHINE})


def aggregate(per_col, tg):
    kp = Counter(json.dumps(a['Lambda/KPer'], sort_keys=True) + f" rank {a['KPer_rank']}" for a in per_col)
    pe = Counter(json.dumps(a['Lambda/Per'], sort_keys=True) for a in per_col)
    comp = Counter()
    for a in per_col:
        for pair, lst in a['kempe'].items():
            for d in lst:
                comp[json.dumps({'V_rank': d['V_rank'], 'NLambda/V': d['NLambda/V']}, sort_keys=True)] += d['components']
    tgt = {}
    for nm in tg:
        c = Counter()
        for a in per_col:
            t = a['targets'][nm]
            c['in_KPer' if t['in_KPer'] else 'not_in_KPer'] += 1
            if t['escape'] and t['escape'].get('W_prime_exponent'):
                c[f"W'_exponent_{t['escape']['W_prime_exponent']}"] += 1
        tgt[nm] = dict(c)
    return {'colourings': len(per_col), 'additive': sum(a['additive'] for a in per_col),
            'chiral_strict': sum(a['chiral_strict'] for a in per_col), 'chiral': sum(a['chiral'] for a in per_col),
            'chiral_non_additive': sum(a['chiral'] and not a['additive'] for a in per_col),
            'gapped': sum(a['gapped_classes'] > 0 for a in per_col),
            'Lambda/Per': dict(pe), 'Lambda/KPer': dict(kp), 'components_by_V': dict(comp), 'targets': tgt}


# ================================================================ the summary

def image(H, A, r):
    return S.hnf([tuple(sum(h[i] * A[i][j] for i in range(r)) for j in range(r)) for h in H], r)


def summary():
    rows = S.Rows(ROWS)
    out = {}
    for name in ORDER:
        pairs = [rows.get(f'{name}|N{N}|pair') for N in NS]
        pairs = [p for p in pairs if p]
        if not pairs:
            continue
        lat, G = load(name)
        r = lat.rank
        tg = targets(lat)
        P = None
        for p in pairs:
            if p.get('P_found_N') is not None:
                P = p['P_found_N'] if P is None else S.intersect(P, p['P_found_N'], r)
        Ppg = P
        if P is not None and P:
            for A in G:
                Ppg = S.intersect(Ppg, image(P, A, r), r) if Ppg else []
                if not Ppg:
                    break
        d = {'rank': r, 'M': lat.M, 'U': len(lat.U), 'point_group': len(G),
             'periods': {p['N']: ('inadmissible' if not p['admissible'] else
                                  f"{p['aggregate']['colourings']} colourings" if p.get('aggregate') else 'no colouring')
                         for p in pairs},
             'P_found': None if P is None else S.describe(P, r)['Lambda_mod'],
             'P_found_point_group_closed': None if Ppg is None else S.describe(Ppg, r)['Lambda_mod'],
             'P_found_point_group_closed_rows': None if Ppg is None else S.lat_rows(Ppg),
             'targets_in_P_found_pg': {nm: (S.member(Ppg, t) if Ppg else False) for nm, t in tg.items()} if Ppg is not None else None}
        out[name] = d
        print(name, json.dumps(d, default=str)[:1500], flush=True)
    json.dump(out, open(os.path.join(OUT, 'summary.json'), 'w'), indent=1, default=str)
    return out


# ================================================================ the mechanism: fibre collisions versus cycles

def fibre_lattices(Q, U, r):
    """{residue class of U mod W: Delta = <u - u' : u, u' in U with that residue>} (the 2-cycles' voltages)"""
    cl = Q.cls(np.array(U)).tolist()
    fib = {}
    for c, u in zip(cl, U):
        fib.setdefault(int(c), []).append(tuple(u))
    out = {}
    for c, us in fib.items():
        diffs = [tuple(a - b for a, b in zip(v, us[0])) for v in us[1:]]
        out[c] = S.hnf(diffs, r) if diffs else []
    return out, fib


def mechanism_one(lat, U, N, col):
    """per Kempe component Q of c (descended to Lambda/Per(c)): R(Q) = residues of the edges inside Q; D_Q = sum of their fibre
    lattices (a sublattice of V_Q: a parallel pair u, u' of one residue is a 2-cycle of voltage u - u'); and [V_Q : D_Q] -- 1 when the
    component's voltages are all fibre collisions, larger when its cycles add voltages of their own"""
    r = lat.rank
    Q = S.Quot(S.NW(N, r), r)
    pc = S.PColour(U, Q, col)
    Wp, _ = pc.per()
    pd = pc.descend(Wp) if S.hnf(Wp, r) != S.hnf(Q.W, r) else pc
    Qd = pd.Q
    fl, fib = fibre_lattices(Qd, U, r)
    res = sorted(fl)
    out = Counter()
    for a, b in itertools.combinations(range(4), 2):
        if not ((pd.col == a).any() and (pd.col == b).any()):
            continue
        lab, p, V, roots = pd.components(a, b)
        inQ = lab >= 0
        used = {}
        for rc in res:
            j = Qd.shift(Qd.digits()[rc])
            both = inQ & inQ[j] & (lab == lab[j])
            for L in np.unique(lab[both]).tolist():
                used.setdefault(L, set()).add(rc)
        for L, H in V.items():
            R = used.get(L, set())
            Dl = []
            for rc in R:
                Dl += [tuple(x) for x in fl[rc]]
            D = S.hnf(Dl, r) if Dl else []
            if len(D) < len(H):
                rel = f'rank {len(D)} < {len(H)}'
            elif not H:
                rel = 'both 0'
            else:
                qs = S.quotient_structure(S.hnf([list(h) for h in H], r), D, r)
                rel = 'equal' if not qs['free'] and not qs['torsion'] else f"V/D {qs}"
            out[(len(H), rel, len(R))] += 1
    return out


def cmd_mechanism(name, N):
    lat, G = load(name)
    d = json.load(gzip.open(os.path.join(OUT, 'colourings', f'{name}-N{N}-all.json.gz'), 'rt'))
    tot = Counter()
    for s_ in d['colourings']:
        tot += mechanism_one(lat, lat.U, N, np.array([int(c) for c in s_], dtype=np.int8))
    rows = S.Rows(ROWS)
    rec = {'key': f'{name}|N{N}|mechanism', 'lattice': name, 'N': N, 'colourings': len(d['colourings']),
           'components_by_(V_rank, V vs D, |R(Q)|)': {json.dumps(k): v for k, v in sorted(tot.items(), key=str)}, 'machine': S.MACHINE}
    if not rows.get(rec['key']):
        rows.put(rec)
    print(json.dumps(rec, indent=1))


def cmd_certificate(name, N):
    """the fewest colourings (greedy, least KPer rank first) whose Kempe period groups intersect in 0: with R3 each delta != 0 is then
    separated by a periodic colouring, so P = F = 0 (the lattice is loose).  Each chosen colouring's KPer is recomputed here."""
    lat, G = load(name)
    r, U = lat.rank, lat.U
    d = json.load(gzip.open(os.path.join(OUT, 'colourings', f'{name}-N{N}-all.json.gz'), 'rt'))
    Q = S.Quot(S.NW(N, r), r)
    kp = []
    for s_ in d['colourings']:
        col = np.array([int(c) for c in s_], dtype=np.int8)
        pc = S.PColour(U, Q, col)
        Wp, _ = pc.per()
        pd = pc.descend(Wp) if S.hnf(Wp, r) != S.hnf(Q.W, r) else pc
        kp.append((len(pd.kper()[0]), s_, pd.kper()[0]))
    kp.sort(key=lambda t: t[0])
    H, chosen = None, []
    for rk, s_, K in kp:
        nxt = K if H is None else (S.intersect(H, K, r) if H and K else [])
        if H is None or len(nxt) < len(H) or S.hnf(nxt, r) != S.hnf(H, r):
            H = nxt
            chosen.append({'colouring': s_, 'KPer': S.lat_rows(K), 'KPer_rank': rk})
        if not H:
            break
    rec = {'key': f'{name}|N{N}|certificate', 'lattice': name, 'N': N, 'intersection_rank': len(H),
           'chosen': chosen, 'machine': S.MACHINE}
    rows = S.Rows(ROWS)
    if not rows.get(rec['key']):
        rows.put(rec)
    print(json.dumps({k: v for k, v in rec.items() if k != 'chosen'}), [c['KPer_rank'] for c in chosen])


# ================================================================ controls

def cycle_bed(n, gens, col):
    Q = S.Quot([(n,)], 1)
    c = np.array(col, dtype=np.int8)
    S.PColour([(g,) for g in gens] + [(-g,) for g in gens], Q, c, f'Z/{n}')                      # asserts properness
    return Q, c


def brute_chirality(col, n):
    """(strict, translated) by definition, over every t in Z/n and every colour permutation: the independent twin of chirality()"""
    st = ch = True
    for t in range(n):
        for tau in itertools.permutations(range(4)):
            if all(col[(t - x) % n] == tau[col[x]] for x in range(n)):
                ch = False
                st = st and t != 0
    return st, ch


def selftest(plants=False):
    global PLANT
    ok = True

    def check(nm, cond, detail=''):
        nonlocal ok
        ok &= bool(cond)
        print(f"[{'pass' if cond else 'FAIL'}] {nm} {detail}", flush=True)
    Q5, c5 = cycle_bed(10, (1, 3), (0, 1, 0, 1, 0, 1, 2, 1, 2, 3))
    st, ch, _ = chirality(Q5, c5)
    check('G(Z/10, {1, 3}) colouring 0101012123 reads chiral both ways (the positive control)', st and ch)
    Qc, cc = cycle_bed(8, (1, 3, 4, 5), (0, 1, 0, 1, 2, 3, 2, 3))
    st, ch, t = chirality(Qc, cc)
    check("Coxeter's C-5 colouring 01012323: strict-chiral, but ACHIRAL up to translation (the reflection about 3/2, tau = (01)(23))",
          st and not ch, f't = {t}')
    agree = tot = nch = 0
    for col in itertools.product(range(4), repeat=10):
        if col[0] or any(col[x] == col[(x + g) % 10] for x in range(10) for g in (1, 3)):
            continue
        Qx, cx = cycle_bed(10, (1, 3), col)
        a_ = chirality(Qx, cx)[:2]
        b_ = brute_chirality(col, 10)
        tot += 1
        agree += tuple(a_) == b_
        nch += b_[1]
    check('chirality() equals the brute-force definition on every proper 4-colouring of G(Z/10, {1, 3}) with c(0) = 0',
          agree == tot and nch > 0, f'{agree} of {tot}; {nch} chiral')
    lat, G = load('L3')
    U, r = lat.U, lat.rank
    check('L3: rank 6, 42 unit vectors (P1a)', r == 6 and len(U) == 42, f'{r}, {len(U)}')
    Q2 = S.Quot(S.NW(2, r), r)
    cols, _, _ = CARD.enumerate_all(Q2, U)
    check('L3, N = 2: 2,304 pinned colourings (P1g)', len(cols) == 2304, len(cols))
    ach = [chirality(Q2, c) for c in cols[:200]]
    check('the first 200 N = 2 colourings read achiral both ways (-x = x mod 2 Lambda)', not any(a or b for a, b, _ in ach))
    dg = FL.degrey()
    dg.saturate('trace')
    Q4 = S.Quot(S.NW(4, 4), 4)
    vals = S.named_colouring_values(dg, 'fischer')
    colF = np.mod(Q4.rep(np.arange(Q4.n)) @ np.array(vals, dtype=np.int64), 4).astype(np.int8)
    WpF, _ = S.PColour(dg.U, Q4, colF).per()
    check("[Fischer1994]'s Z/4 colouring of de Grey's lattice at N = 4: [Lambda : Per] = 4", S.describe(WpF, 4)['index'] == 4)
    stF, chF, _ = chirality(Q4, colF)
    check('... and it reads achiral both ways (c(-x) = -c(x), a colour permutation)', not stF and not chF)
    idx2 = Counter(S.describe(S.PColour(U, Q2, c).per()[0], r)['index'] for c in cols)
    check('L3, N = 2: the index distribution of Per (read for the add_index plant bed)', True, dict(idx2))
    if plants:
        PLANT = 'chir_noneg'
        st, ch, _ = chirality(Q5, c5)
        check('plant chir_noneg: the Z/10 positive control now reads achiral (the plant fires)', not st and not ch)
        PLANT = 'add_index'
        n_plant = sum((i is not None and i % 4 == 0) for i in idx2.elements())
        n_true = sum(i == 4 for i in idx2.elements())
        check('plant add_index: the additive count moves on L3 at N = 2', n_plant != n_true, f'{n_true} -> {n_plant}')
        PLANT = None
    return ok


def main():
    a = sys.argv[1:]
    if PLANT is not None and PLANT not in VALID_PLANTS:
        raise SystemExit(f'unknown plant {PLANT!r}')
    if not a:
        print(__doc__)
        return 2
    if a[0] == 'run':
        d = run_pair(a[1], int(a[2]))
        print(json.dumps({k: v for k, v in d.items() if k != 'per_colouring'}, default=str)[:3000])
        return 0
    if a[0] == 'all':
        only = a[a.index('--only') + 1].split(',') if '--only' in a else ORDER
        rows = S.Rows(ROWS)
        for name in only:
            for N in NS:
                d = run_pair(name, N, rows)
                print(name, N, json.dumps({k: d.get(k) for k in ('admissible', 'classes', 'Lambda/P_found_N', 'seconds')}),
                      json.dumps(d.get('aggregate', {}))[:600], flush=True)
        return 0
    if a[0] == 'certificate':
        cmd_certificate(a[1], int(a[2]))
        return 0
    if a[0] == 'mechanism':
        cmd_mechanism(a[1], int(a[2]))
        return 0
    if a[0] == 'summary':
        summary()
        return 0
    if a[0] == 'selftest':
        return 0 if selftest('--plants' in a) else 1
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
