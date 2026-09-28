#!/usr/bin/env python3
"""FS114-NB exact checks of the counting statements (N114-EULER, N114-FIVE, N114-ROOM, N114-CUBIC) — derived identities
checked at named values, on combinatorial torus maps given by formula.  No search: every map is a named lattice tiling
of a named torus; every quantity is an integer.

Part 1 (EULER).  A cellular map of the torus is built from a doubly periodic planar graph (vertices Z_m x Z_n, edges with
integer direction vectors), its rotation system read from the directions, its faces the orbits of the face permutation.
For every face f: corners (darts in its orbit), d(v) = number of darts leaving v; the multiset L_f = for each corner at v
all d(v) - 1 other corners' faces, minus one copy of the face across each edge of f's walk; deg_M(f) = number of distinct
faces other than f in L_f; mu_f = |L_f| - deg_M(f) (the excess reading).  Checked: V - E + F = 0 and
  sum_f (deg_M(f) - (k-1)) = (7-k)F + sum_v (d(v)-2)(d(v)-3) - mu   for k = 5, 6, 7.
deg_M is also computed directly (faces sharing a vertex with f, f excluded) and must equal the L_f count.  The alternative
reading of mu ("the number of distinct neighbours met more than once", self-meetings not counted) is evaluated beside it.

Part 2 (the count's algebra).  Per-vertex polynomial p_k(d) = 2d^2 + (2 - 3k)d + 6k - 6 (the summed tile inequality
3 deg_D(x) + sum_v (d(v)-3) <= 3(k-1) + A_x, with sum_x A_x <= E' and Euler); the side's bounds at k = 5 and k = 6.

Planted faults (--plant NAME), each must turn a check red for its own reason while the faithful run is green:
  drop_mu   : mu omitted -> EULER fails exactly on the maps with mu > 0 (the small tori);
  seven_six : the constant 7 read as 6 -> EULER fails on every map;
  mu_alt    : mu read as "distinct neighbours met more than once" -> EULER fails where a neighbour is met 3+ times or a
              face meets itself.
"""
import math
import sys
from fractions import Fraction
from itertools import product


def torus_map(m, n, edges):
    """edges: list of ((i,j) offset-free base vertex (0,0), direction (a,b)) templates applied at every lattice point;
    returns darts, rotation, faces.  Vertex (i,j) mod (m,n)."""
    E = []
    for i, j in product(range(m), range(n)):
        for (a, b), keep in edges:
            if keep(i, j):
                E.append(((i, j), ((i + a) % m, (j + b) % n), (a, b)))
    darts = []  # (edge index, 0 forward / 1 backward)
    for e in range(len(E)):
        darts += [(e, 0), (e, 1)]

    def tail(d):
        return E[d[0]][0] if d[1] == 0 else E[d[0]][1]

    def vec(d):
        a, b = E[d[0]][2]
        return (a, b) if d[1] == 0 else (-a, -b)

    out = {}
    for d in darts:
        out.setdefault(tail(d), []).append(d)
    for v in out:
        out[v].sort(key=lambda d: math.atan2(vec(d)[1], vec(d)[0]))
    pos = {d: (v, k) for v, ds in out.items() for k, d in enumerate(ds)}

    def rev(d):
        return (d[0], 1 - d[1])

    def nxt(d):  # face walk: arrive along d, leave by the dart after rev(d) clockwise at the head
        v, k = pos[rev(d)]
        ds = out[v]
        return ds[(k - 1) % len(ds)]

    face_of, faces = {}, []
    for d in darts:
        if d in face_of:
            continue
        orb, x = [], d
        while x not in face_of:
            face_of[x] = len(faces)
            orb.append(x)
            x = nxt(x)
        faces.append(orb)
    return E, darts, out, faces, face_of, tail, rev


def euler_data(m, n, edges, mu_mode='excess'):
    E, darts, out, faces, face_of, tail, rev = torus_map(m, n, edges)
    V, Ecount, F = len(out), len(E), len(faces)
    deg = {v: len(ds) for v, ds in out.items()}
    degM, mu, mu_alt = [], [], []
    for f, orb in enumerate(faces):
        L = []
        for d in orb:  # corner of f at tail(d)
            v = tail(d)
            L += [face_of[x] for x in out[v] if x != d]
        for d in orb:  # the face across the edge of d, one copy removed per edge of the walk
            L.remove(face_of[rev(d)])
        distinct = set(L) - {f}
        direct = set(face_of[x] for d in orb for x in out[tail(d)]) - {f}
        assert direct == distinct, (m, n, f)
        degM.append(len(distinct))
        mu.append(len(L) - len(distinct))
        cnt = {}
        for g in L:
            cnt[g] = cnt.get(g, 0) + 1
        mu_alt.append(sum(1 for g, c in cnt.items() if g != f and c > 1))
    return dict(V=V, E=Ecount, F=F, deg=deg, degM=degM, mu=mu, mu_alt=mu_alt)


ALL = lambda i, j: True
SQUARE = [((1, 0), ALL), ((0, 1), ALL)]
TRI = SQUARE + [((1, 1), ALL)]
BRICK = [((1, 0), ALL), ((0, 1), lambda i, j: (i + j) % 2 == 0)]          # hexagonal (brick wall), all degrees 3
MIXED = SQUARE + [((1, 1), lambda i, j: (i + 2 * j) % 3 == 0)]            # degrees 4, 5, 6 mixed
MAPS = [('square', m, n, SQUARE) for m, n in [(1, 1), (1, 2), (2, 2), (2, 3), (3, 3), (4, 5)]] + \
       [('triangular', m, n, TRI) for m, n in [(1, 1), (2, 2), (3, 3), (3, 4)]] + \
       [('brick-hex', m, n, BRICK) for m, n in [(2, 2), (2, 3), (4, 4), (6, 5)]] + \
       [('mixed', m, n, MIXED) for m, n in [(3, 3), (6, 6), (9, 4)]]


def check_euler(plant=None):
    bad = 0
    for name, m, n, edges in MAPS:
        D = euler_data(m, n, edges)
        chi = D['V'] - D['E'] + D['F']
        mu = sum(D['mu_alt']) if plant == 'mu_alt' else (0 if plant == 'drop_mu' else sum(D['mu']))
        seven = 6 if plant == 'seven_six' else 7
        rows = []
        for k in (5, 6, 7):
            lhs = sum(g - (k - 1) for g in D['degM'])
            rhs = (seven - k) * D['F'] + sum((d - 2) * (d - 3) for d in D['deg'].values()) - mu
            rows.append(lhs == rhs)
        ok = chi == 0 and all(rows)
        bad += not ok
        degs = sorted(set(D['deg'].values()))
        print(f"{'OK ' if ok else 'BAD'} {name:10s} {m}x{n}: V={D['V']} E={D['E']} F={D['F']} chi={chi} degrees={degs} "
              f"mu={sum(D['mu'])} mu_alt={sum(D['mu_alt'])} identity(k=5,6,7)={rows}")
    return bad


def check_algebra():
    bad = 0
    # N114-EULER reduces to Euler: sum_v [d(d-2) - (d-2)(d-3)] = 3 sum_v (d-2) = 6F  (sum d = 2E, E = V + F)
    for d in range(2, 12):
        bad += (d * (d - 2) - (d - 2) * (d - 3)) != 3 * (d - 2)
    # per-vertex polynomial of the full count (tile inequality with the absent-colour bound), k = 5, 6, 7
    p = lambda k, d: 2 * d * d + (2 - 3 * k) * d + 6 * k - 6
    table = {k: [p(k, d) for d in range(3, 8)] for k in (5, 6, 7)}
    print('p_k(d), d = 3..7:', table)
    bad += not all(v > 0 for v in table[5][:3])                  # k = 5: every d in {3,4,5} positive -> contradiction
    bad += table[6][:4] != [0, -2, 0, 6]                         # k = 6: 2(d-3)(d-5): room iff V4 >= 3 V6
    bad += table[7][0] >= 0                                      # k = 7: cubic vertices leave room (hexagonal control)
    # the side's bounds: k = 5 needed - E' = F - V3 + V4 + 5V5 >= F + V4 + 4V5 given V3 <= V5 (rainbow: deg_D <= 4)
    # k = 6 needed - E' = -V3 + V4 + 5V5 + 11V6 >= 3V6 - V4 given V3 <= 2V4 + 5V5 + 8V6 (rainbow: deg_D <= 5)
    for V3, V4, V5, V6 in product(range(0, 7), repeat=4):
        Ep = Fraction(3 * V3 + 4 * V4 + 5 * V5 + 6 * V6, 2)
        F = Ep - (V3 + V4 + V5 + V6)
        if V6 == 0 and 2 * Ep <= 4 * F:        # k = 5, rainbow holds
            need = 2 * F + 2 * V4 + 6 * V5
            bad += (need - Ep) < F + V4 + 4 * V5
            bad += 2 * F + 2 * V4 + 6 * V5 <= Ep + 2 * (4 * F - 2 * Ep) and (V3 + V4 + V5) > 0
        if 2 * Ep <= 5 * F:                    # k = 6, rainbow holds
            need = F + 2 * V4 + 6 * V5 + 12 * V6
            bad += (need - Ep) < 3 * V6 - V4
            full_ok = need <= Ep + 2 * (5 * F - 2 * Ep)
            bad += full_ok != (V4 >= 3 * V6)
    return bad


if __name__ == '__main__':
    plant = None
    if '--plant' in sys.argv:
        plant = sys.argv[sys.argv.index('--plant') + 1]
    b1 = check_euler(plant)
    b2 = check_algebra() if plant is None else 0
    print(f'EULER maps failing: {b1}; algebra failures: {b2}')
    sys.exit(1 if (b1 or b2) else 0)
