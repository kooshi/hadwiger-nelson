#!/usr/bin/env python3
"""Language-restricted edge-local cocycles on a Q(sqrt167) lattice, using exhibited colourings: every additive Z/4 and V4 colouring
(enumerated here) and the phase-0 linear Theta_4 witnesses.  Exhibited patterns are a SUBSET of the language, so the nullity found is
an upper bound for language cocycles; meeting the trivial dimension proves triviality on the language."""
import sys, json, itertools
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
import fs73_lattice as L
from heights_edge import canon_gens, neg
from lang_heights import solve, type_of
W = '/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'

def solve_coords(B, v):
    """rational coordinates of v in the rows of B (4x4)"""
    import sympy
    M = sympy.Matrix(B).T
    return [Fr(int(x.p), int(x.q)) for x in M.LUsolve(sympy.Matrix(v))]

COORD = 'lattice'
def main(M, tag):
    F = L.Field((167,))
    pts = [(v, M) for v in L.units_over(F, M)]
    lat = L.Lattice(F, pts, tag, M=M)
    U8 = lat.saturate('box')
    U8 = [lat.point(c) for c in lat.U]
    H = [list(r) for r in lat.H]
    Uc = [tuple(c) for c in lat.U]                         # lattice coordinates (w.r.t. lat.H)
    S = sorted(set(Uc) | {neg(u) for u in Uc})
    gens = canon_gens(S)
    n = len(gens)
    point = {g: lat.point(g) for g in gens}                # 4-vector over M
    colourings = []   # each: function giving the pattern set on square (s,t)
    # additive into Z/4 and V4: homomorphisms on lattice coords
    homs = []
    for phi in itertools.product(range(4), repeat=4):
        vals = [sum(a * b for a, b in zip(phi, g)) % 4 for g in gens]
        if all(v != 0 for v in vals):
            homs.append(('Z4', phi))
    for phi in itertools.product(range(4), repeat=4):      # V4 = F2^2: two F2 functionals encoded as pairs
        a = [p & 1 for p in phi]; b = [p >> 1 for p in phi]
        vals = [(sum(x * y for x, y in zip(a, g)) % 2, sum(x * y for x, y in zip(b, g)) % 2) for g in gens]
        if all(v != (0, 0) for v in vals):
            homs.append(('V4', phi))
    print(tag, 'rank', lat.rank, '|U|', len(Uc), 'additive homs:', sum(1 for h in homs if h[0] == 'Z4'), 'Z4,',
          sum(1 for h in homs if h[0] == 'V4'), 'V4')
    # linear witnesses
    thetas = []
    for fn in (f'{tag}-linear.json', f'{tag}-linear-probe.json'):
        try:
            d = json.load(open(W + fn))
        except FileNotFoundError:
            continue
        B = d['basis'] if isinstance(d['basis'], list) else json.loads(d['basis'])
        thr = d['theta_on_basis']
        th = [Fr(x) for x in (thr if isinstance(thr, list) else json.loads(thr.replace("'", '"')))]
        tv = []
        for g in gens:
            co = solve_coords(B, list(g) if COORD == 'lattice' else list(point[g]))
            tv.append(sum(c * t for c, t in zip(co, th)) % 1)
        den = 1
        for x in th:
            den = den * x.denominator // __import__('math').gcd(den, x.denominator)
        thetas.append((fn, tv, den))
        assert all(Fr(1, 4) <= x <= Fr(3, 4) for x in tv), 'theta not in Theta4 on U'
    print('linear witnesses:', [(t[0], t[2]) for t in thetas])
    occ = {}
    for i, j in itertools.combinations(range(n), 2):
        pats = set()
        for kind, phi in homs:
            if kind == 'Z4':
                fs = sum(a * b for a, b in zip(phi, gens[i])) % 4
                ft = sum(a * b for a, b in zip(phi, gens[j])) % 4
                pats.add((0, fs, (fs + ft) % 4, ft))
            else:
                a = [p & 1 for p in phi]; b = [p >> 1 for p in phi]
                def v4(g):
                    return (sum(x * y for x, y in zip(a, g)) % 2) + 2 * (sum(x * y for x, y in zip(b, g)) % 2)
                fs, ft = v4(gens[i]), v4(gens[j])
                pats.add((0, fs, fs ^ ft, ft))
        for fn, tv, den in thetas:
            ts, tt = tv[i], tv[j]
            for k in range(den):
                y = Fr(k, den)
                fl = lambda z: int((z % 1) * 4)
                pats.add((fl(y), fl(y + ts), fl(y + ts + tt), fl(y + tt)))
        occ[(i, j)] = pats
    null, neq = solve(gens, occ)
    types = {}
    for k, v in occ.items():
        key = tuple(sorted({type_of(q) for q in v}))
        types[key] = types.get(key, 0) + 1
    print('n', n, 'exhibited-language nullity mod p', null, 'trivial', 3 + n, 'extra', null - 3 - n, 'eqs', neq)
    print('pair type-sets:', types)

if __name__ == '__main__':
    if len(sys.argv) > 3: COORD = sys.argv[3]
    main(int(sys.argv[1]), sys.argv[2])
