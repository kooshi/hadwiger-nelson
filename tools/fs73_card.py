#!/usr/bin/env python3
"""fs73_card -- FS-73 P1g, Poros's rank-6 card (P-R1): on L3 = group6:u3:2+zeta6:w4 (rank 6, 42 unit vectors, over Q(sqrt3, sqrt5)),
at period N = 2: for each four-colouring c of Cay(L3/2L3, U mod 2) and each chainable target delta, the Smith form of the origin's
escape component's voltage group V inside 2L3, the escape e = delta - q(delta), R3's re-periodised period W' (V <= W' <= 2L3, e not in
W'), the separating colouring itself (c with colours a, b swapped on the lift K_0 + W'), verified proper on L3/W' and separating
(c'(0) != c'(delta)), and its exact period group Per(c').  The verdict per escape: LOCAL AT 2 when L3/Per(c') is a 2-group (c' constant
on the cosets of some 2^j L3), LOCAL AT 3 when a 3-group, NEITHER otherwise.  P-R1 (Poros) predicts NEITHER.

  card [--out data/fs73/census/P1g-L3-card.json]

The colourings: FS-70's committed N = 2 colouring (data/fs70/quotient/group6_u3_2_zeta6_w4-N2.colouring.json, re-read class by class
through its points), and every pinned colouring of the 64-class quotient (enumerated to exhaustion).  The control (the plan's): the same
classifier on c itself, which IS 2L3-periodic, must read LOCAL AT 2; and a paired plant (the swap applied on K_0 alone, re-periodised
at W = 2L3 instead of W') must fail the properness or periodicity assertion, so the W' step is seen to be what makes c' periodic.
"""
import json
import math
import os
import sys

import numpy as np

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import fs73_lattice as FL                                                     # noqa: E402
import fs73_screen as S                                                       # noqa: E402

SPEC = 'group6:u3:2+zeta6:w4'


def factor_primes(n):
    ps, p = set(), 2
    while p * p <= n:
        while n % p == 0:
            ps.add(p)
            n //= p
        p += 1
    if n > 1:
        ps.add(n)
    return sorted(ps)


def locality(H, r):
    d = S.describe(H, r)['Lambda_mod']
    if d['free']:
        return 'NOT PERIODIC', d
    ps = sorted({p for t in d['torsion'] for p in factor_primes(t)})
    return ('LOCAL AT 2' if ps == [2] else 'LOCAL AT 3' if ps == [3] else 'TRIVIAL' if not ps else 'NEITHER'), d


def fs70_colouring(lat, Q):
    import fs70_fabric as FB
    d = json.load(open(os.path.join(ROOT, 'data', 'fs70', 'quotient', 'group6_u3_2_zeta6_w4-N2.colouring.json')))
    assert d['spec'] == SPEC and d['N'] == 2
    fb = FB.Lattice(FB.generators(SPEC), SPEC)
    fb.saturate('b')
    r = fb.rank
    col = np.full(Q.n, -1, dtype=np.int8)
    pw = [2 ** (r - 1 - i) for i in range(r)]
    for i, c in enumerate(d['colouring']):
        digs = [(i // p) % 2 for p in pw]
        v8 = tuple(sum(dj * fb.H[j][t] for j, dj in enumerate(digs)) for t in range(8))
        w = lat.to_M(v8, fb.M)
        mine = lat.coords(w)
        assert mine is not None
        col[int(Q.cls(np.array([mine]))[0])] = c
    assert (col >= 0).all(), 'the FS-70 colouring does not cover every class'
    return col


def enumerate_all(Q, U):
    from pysat.solvers import Cadical153
    (cls, E, extra), nvars, pins, note = S.build_cnf(Q, U, 'plain')
    n = Q.n
    x = lambda v, c: 4 * v + c + 1
    amo = [[-x(v, a), -x(v, b)] for v in range(n) for a in range(4) for b in range(a + 1, 4)]
    sv = Cadical153(bootstrap_with=cls + [[-x(i, c), -x(j, c)] for i, j in E.tolist() for c in range(4)] + extra + amo)
    out = []
    while sv.solve():
        m = sv.get_model()
        col = np.array([next(c for c in range(4) if m[x(v, c) - 1] > 0) for v in range(n)], dtype=np.int8)
        out.append(col)
        sv.add_clause([-x(v, int(col[v])) for v in range(n)])
    sv.delete()
    return out, pins, note


def wprime_p(W, V, e, r, prime):
    """R3's W' restricted to prime-power index: the least ell = prime^k not dividing e's coordinate, over every Smith coordinate of W/V
    where one exists (torsion: ell | d_j; free: any k); None when no prime-power W' excludes e this way"""
    k = len(W)
    Vc = [FL.coords_in(W, tuple(int(x) for x in v)) for v in V]
    ec = FL.coords_in(W, tuple(int(x) for x in e))
    C, Cinv, d = S.snf(Vc, k) if Vc else ([[1 if i == j else 0 for j in range(k)] for i in range(k)], None, [0] * k)
    y = [sum(ec[i] * C[i][j] for i in range(k)) for j in range(k)]
    best = None
    for j in range(k):
        if d[j] == 1 or (d[j] > 1 and y[j] % d[j] == 0) or (d[j] == 0 and y[j] == 0):
            continue
        ell = prime
        while (d[j] == 0 or d[j] % ell == 0) and y[j] % ell == 0:
            ell *= prime
        if (d[j] == 0 or d[j] % ell == 0) and y[j] % ell and (best is None or ell < best[1]):
            best = (j, ell)
    if best is None:
        return None
    j, m = best
    Ci = S._inverse(C)
    rows = []
    for i in range(k):
        yy = [0] * k
        yy[i] = m if i == j else 1
        xc = [sum(yy[s_] * Ci[s_][t] for s_ in range(k)) for t in range(k)]
        rows.append(tuple(sum(xc[s_] * W[s_][t] for s_ in range(k)) for t in range(r)))
    Wp = S.hnf(rows, r)
    assert all(S.member(Wp, v) for v in V) and not S.member(Wp, e)
    return Wp


def swapped_per(U, Q, col, lab, L0, p, shift0, a, b, Wp, delta, r):
    Q2 = S.Quot(Wp, r)
    reps = Q2.rep(np.arange(Q2.n))
    xb = Q.cls(reps)
    col2 = col[xb].copy()
    Wh = S.hnf(Wp, r)
    for y in range(Q2.n):
        if int(lab[xb[y]]) == L0 and S.member(Wh, tuple(int(t) for t in reps[y] - (p[xb[y]] - shift0))):
            col2[y] = b if col2[y] == a else a if col2[y] == b else col2[y]
    pc2 = S.PColour(U, Q2, col2, 'swapped')
    assert int(col2[int(Q2.cls(np.array([[0] * r]))[0])]) != int(col2[int(Q2.cls(np.array([delta]))[0])])
    return locality(pc2.per()[0], r)


def card_one(lat, U, Q, col, delta, r, plant=False):
    pc = S.PColour(U, Q, col, 'L3-N2')
    a = int(col[0])
    dcl = int(Q.cls(np.array([delta]))[0])
    if int(col[dcl]) != a:
        return {'verdict': 'escape at level 0 (c itself separates)', 'local': locality(S.hnf(list(Q.W), r), r)[0]}
    rows = []
    for b in range(4):
        if b == a:
            continue
        lab, p, V, roots = pc.components(a, b)
        L0 = int(lab[0])
        H = V[L0]
        shift0 = p[0].copy()
        inK = int(lab[dcl]) == L0
        e = None if not inK else (np.asarray(delta, dtype=np.int64) - (p[dcl] - shift0))
        if inK and S.member(H, e):
            rows.append({'b': b, 'verdict': 'rigid (delta in K_0)'})
            continue
        Vin = S.quotient_structure(S.hnf(list(Q.W), r), H, r) if H else None
        Wd = S.w_prime(Q.W, H, e, r)
        Wp = [tuple(g) for g in Wd['generators']]
        if plant:
            Wp = [tuple(w) for w in Q.W]             # PLANT: swap on K_0 + W instead of K_0 + W'
        Q2 = S.Quot(Wp, r)
        reps = Q2.rep(np.arange(Q2.n))
        xb = Q.cls(reps)
        col2 = col[xb].copy()
        Wh = S.hnf(Wp, r)
        for y in range(Q2.n):
            if int(lab[xb[y]]) == L0 and S.member(Wh, tuple(int(t) for t in reps[y] - (p[xb[y]] - shift0))):
                col2[y] = b if col2[y] == a else a if col2[y] == b else col2[y]
        pc2 = S.PColour(U, Q2, col2, 'swapped')     # asserts properness on L3/W'
        sep = int(col2[int(Q2.cls(np.array([[0] * r]))[0])]) != int(col2[int(Q2.cls(np.array([delta]))[0])])
        assert sep, 'the swapped colouring does not separate the pair'
        Hp, _ = pc2.per()
        loc, dmod = locality(Hp, r)
        alt = {}
        if e is not None and not plant:
            for pr in (2, 3):
                Wq = wprime_p(Q.W, H, e, r, pr)
                alt[f'prime-power {pr}'] = None if Wq is None else swapped_per(U, Q, col, lab, L0, p, shift0, a, b, Wq, delta, r)[0]
        rows.append({'b': b, 'verdict': 'escape', 'alternatives': alt, 'component_classes': int((lab == L0).sum()), 'V_rank': len(H),
                     'two_L_mod_V': Vin, 'e': [int(t) for t in e] if e is not None else None,
                     'W_prime': Wd['Lambda_mod'], 'W_prime_exponent': Wd.get('exponent'), 'separates': sep,
                     'Per_swapped': dmod, 'local': loc})
    return {'verdict': 'rigid' if all(x['verdict'].startswith('rigid') for x in rows) else 'escape', 'per_b': rows}


def cmd_card(out_path):
    lat = FL.fabric(SPEC)
    lat.saturate('trace')
    U, r = lat.U, lat.rank
    assert r == 6 and len(U) == 42
    Q = S.Quot(S.NW(2, r), r)
    targets = {'2': FL.rational_point(lat, 2), '2/3': FL.rational_point(lat, 2, 3), '4/3': FL.rational_point(lat, 4, 3),
               '8/3': FL.rational_point(lat, 8, 3), '4': FL.rational_point(lat, 4),
               'i sqrt3': lat.coords(lat.to_M((0, 0, 0, 0, 0, 1, 0, 0), 1))}
    assert all(t is not None for t in targets.values()), targets
    c70 = fs70_colouring(lat, Q)
    cols, pins, note = enumerate_all(Q, U)
    from fs73_classify import relabel
    k70 = relabel(c70, pins)
    idx70 = next((i for i, c in enumerate(cols) if np.array_equal(c, k70)), None)
    print(f'L3 at N = 2: {Q.n} classes; {len(cols)} pinned colourings; FS-70\'s colouring is #{idx70}', flush=True)
    # the control: c itself is 2L3-periodic -> LOCAL AT 2
    Hc, _ = S.PColour(U, Q, c70, 'fs70').per()
    ctl = locality(Hc, r)
    print(f'control: FS-70\'s colouring itself: Per {ctl[1]} -> {ctl[0]} (must be LOCAL AT 2)', flush=True)
    res = {}
    for i, c in enumerate(cols):
        res[i] = {}
        for nm, t in targets.items():
            res[i][nm] = card_one(lat, U, Q, c, t, r)
    # the paired plant: swap on K_0 + 2L3 must not give a proper periodic separating colouring
    plant_fired = None
    for nm, t in targets.items():
        one = card_one(lat, U, Q, cols[idx70], t, r)
        if one['verdict'] == 'escape' and any(x['verdict'] == 'escape' and x['e'] is not None for x in one.get('per_b', [])):
            try:
                card_one(lat, U, Q, cols[idx70], t, r, plant=True)
                plant_fired = False
            except AssertionError as ex:
                plant_fired = f'raised on target {nm}: {str(ex)[:90]}'
            break
    print(f'plant (swap on K_0 + 2L3 instead of K_0 + W\'): {plant_fired}', flush=True)
    summary = {}
    for i in res:
        for nm in targets:
            for x in res[i][nm].get('per_b', []):
                if x['verdict'] == 'escape':
                    summary.setdefault(x['local'], 0)
                    summary[x['local']] += 1
    for nm in targets:
        one = res[idx70][nm]
        for x in one.get('per_b', []):
            if x['verdict'] == 'escape':
                print(f"  FS-70 colouring, target {nm}, b = {x['b']}: component {x['component_classes']} classes, V rank {x['V_rank']}, "
                      f"2L3/V {x['two_L_mod_V']}, W' {x['W_prime']}, Per(c') {x['Per_swapped']} -> {x['local']}; "
                      f"prime-power W': {x['alternatives']}", flush=True)
            else:
                print(f"  FS-70 colouring, target {nm}, b = {x['b']}: {x['verdict']}", flush=True)
    best = {}
    for i in res:
        for nm in targets:
            one = res[i][nm]
            locs = {one['local']} if 'local' in one else set()
            for x in one.get('per_b', []):
                if x['verdict'] == 'escape':
                    locs |= {x['local']} | {v for v in x['alternatives'].values() if v}
            best.setdefault(nm, {})
            key = 'LOCAL AT 2 achievable' if 'LOCAL AT 2' in locs else 'rigid' if not locs else 'only ' + '/'.join(sorted(locs))
            best[nm][key] = best[nm].get(key, 0) + 1
    print(f'all {len(cols)} colourings x {len(targets)} targets, escapes by locality (least-ell rule): {summary}', flush=True)
    print(f'per target, over all colourings: {best}', flush=True)
    out = {'what': 'FS-73 P1g: Poros\'s card on L3 at N = 2 (P-R1)', 'spec': SPEC, 'classes': Q.n, 'pinned_colourings': len(cols),
           'fs70_colouring_index': idx70, 'control_fs70_itself': {'Per': ctl[1], 'local': ctl[0]},
           'plant_swap_on_K0_plus_2L': plant_fired, 'targets': {k: list(v) for k, v in targets.items()},
           'escapes_by_locality': summary, 'per_target_best_locality': best,
           'rows_fs70_colouring': res[idx70],
           'rows_all': 'not stored (7.7 MB); rerun the command -- every row is recomputed from the enumerated colourings in minutes',
           'colourings': [''.join(map(str, c.tolist())) for c in cols], 'machine': S.MACHINE}
    json.dump(out, open(out_path, 'w'), indent=1)
    print(f'wrote {out_path}', flush=True)
    return 0 if ctl[0] == 'LOCAL AT 2' and isinstance(plant_fired, str) else 1


if __name__ == '__main__':
    a = sys.argv[1:]
    if a and a[0] == 'card':
        sys.exit(cmd_card(a[a.index('--out') + 1] if '--out' in a else os.path.join(S.CENSUS, 'P1g-L3-card.json')))
    print(__doc__)
    sys.exit(2)
