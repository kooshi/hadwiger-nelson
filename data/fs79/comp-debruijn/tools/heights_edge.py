#!/usr/bin/env python3
"""heights_edge -- the space of edge-local four-colour cocycles (kind 1_edge) of a presentation (Lambda, S).  UNTRUSTED scratch tool.

Unknowns: A_s(a, b) for s in S+ (one generator per +- pair) and ordered colour pairs a != b of {0,1,2,3}  (12 n unknowns; A_{-s}(b,a) =
-A_s(a,b) is built in).  Equations: for every unordered pair {s, t} of distinct generators, the commutator square x0 = 0, x1 = s,
x2 = s + t, x3 = t, and EVERY locally admissible colouring (c0..c3) of it -- proper on the four sides, and c0 != c2 if s + t in S,
c1 != c3 if s - t in S -- gives
        A_s(c0,c1) + A_t(c1,c2) - A_s(c3,c2) - A_t(c0,c3) = 0.
Trivial solutions: A_s(a,b) = g(b) - g(a) + sigma_s   (dimension 3 + n).  The script reports nullity mod p (an UPPER bound for the
nullity over Q, since rank over Q >= rank mod p), the trivial dimension (a LOWER bound, checked by substitution), and the
non-triangle graph G_S (s ~ t iff s != +-t and s - t not in S) with whether every s lies in the component of -s.
"""
import itertools
import sys

import os
PLANT = os.environ.get('PLANT', '')
P = 2147483647  # prime modulus


def neg(v):
    return tuple(-x for x in v)


def add(u, v):
    return tuple(a + b for a, b in zip(u, v))


def sub(u, v):
    return tuple(a - b for a, b in zip(u, v))


def canon_gens(S):
    """one representative per +- pair, deterministic"""
    Sset = set(S)
    assert all(neg(s) in Sset for s in S), 'S is not symmetric'
    assert all(any(x != 0 for x in s) for s in S), '0 in S'
    reps = sorted({max(s, neg(s)) for s in S})
    return reps


def colourings_of_square(diag02, diag13):
    out = []
    for c in itertools.product(range(4), repeat=4):
        c0, c1, c2, c3 = c
        if c0 == c1 or c1 == c2 or c2 == c3 or c3 == c0:
            continue
        if diag02 and c0 == c2:
            continue
        if diag13 and c1 == c3 and PLANT != 'drop_diag13':
            continue
        out.append(c)
    return out


PAIRS = [(a, b) for a in range(4) for b in range(4) if a != b]
PIDX = {p: k for k, p in enumerate(PAIRS)}


class RowReducer:
    """incremental Gaussian elimination mod P; keeps reduced rows keyed by pivot column"""
    def __init__(self, ncols):
        self.n = ncols
        self.rows = {}   # pivot -> row (dict col->val), pivot coefficient 1

    def add(self, row):
        row = {k: v % P for k, v in row.items() if v % P}
        while row:
            piv = min(row)
            if piv in self.rows:
                f = row[piv]
                for k, v in self.rows[piv].items():
                    row[k] = (row.get(k, 0) - f * v) % P
                    if row[k] == 0:
                        del row[k]
            else:
                inv = pow(row[piv], P - 2, P)
                row = {k: v * inv % P for k, v in row.items()}
                # back-substitute into existing rows to keep things tidy (not needed for rank)
                self.rows[piv] = row
                return True
        return False

    def rank(self):
        return len(self.rows)


def analyse(S, name=''):
    gens = canon_gens(S)
    n = len(gens)
    Sset = set(S)
    var = lambda i, a, b: 12 * i + PIDX[(a, b)]
    rr = RowReducer(12 * n)
    eqs = []
    npat = 0
    for i, j in itertools.combinations(range(n), 2):
        s, t = gens[i], gens[j]
        d02 = add(s, t) in Sset
        d13 = sub(s, t) in Sset
        for (c0, c1, c2, c3) in colourings_of_square(d02, d13):
            row = {}
            for key, val in ((var(i, c0, c1), 1), (var(j, c1, c2), 1), (var(i, c3, c2), -1), (var(j, c0, c3), -1)):
                row[key] = row.get(key, 0) + val
            eqs.append(row)
            rr.add(dict(row))
            npat += 1
    nullity = 12 * n - rr.rank()
    # trivial solutions: check they satisfy every equation (substitution), and their dimension
    triv = []
    for g in range(1, 4):           # g = indicator of colour g (colour 0 fixed to 0)
        vec = {}
        for i in range(n):
            for (a, b) in PAIRS:
                vec[var(i, a, b)] = (1 if b == g else 0) - (1 if a == g else 0)
        if PLANT == 'bad_trivial' and g == 1:
            vec[var(0, 0, 1)] += 1
        triv.append(vec)
    for i in range(n):
        vec = {var(i, a, b): 1 for (a, b) in PAIRS}
        triv.append(vec)
    for vec in triv:
        for row in eqs:
            assert sum(v * vec.get(k, 0) for k, v in row.items()) == 0, 'a trivial solution fails an equation'
    tr = RowReducer(12 * n)
    for vec in triv:
        tr.add(dict(vec))
    tdim = tr.rank()
    # the non-triangle graph on S (signed elements)
    Sl = sorted(Sset)
    idx = {s: k for k, s in enumerate(Sl)}
    parent = list(range(len(Sl)))

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x
    for s, t in itertools.combinations(Sl, 2):
        if t == neg(s):
            continue
        if sub(s, t) not in Sset:
            parent[find(idx[s])] = find(idx[t])
    comps = len({find(k) for k in range(len(Sl))})
    pm_joined = all(find(idx[s]) == find(idx[neg(s)]) for s in Sl)
    return dict(name=name, n=n, unknowns=12 * n, patterns=npat, nullity_modp=nullity, trivial_dim=tdim,
                extra=nullity - tdim, G_components=comps, every_s_joined_to_minus_s=pm_joined)


def sym(vs):
    out = set()
    for v in vs:
        out.add(tuple(v))
        out.add(neg(tuple(v)))
    return sorted(out)


def controls():
    res = []
    res.append(analyse(sym([(1, 0), (0, 1)]), 'grid Z^2'))
    res.append(analyse(sym([(1, 0), (0, 1), (0, 0, )][:2] + [(1, 1)]), 'triangular lattice'))
    res.append(analyse(sym([(1, 0), (0, 1), (1, 1), (2, -1)]), 'triangular + (2,-1)'))
    res.append(analyse(sym([(1, 0), (0, 1), (1, 1), (1, 2)]), 'triangular + (1,2)  [makes new triangles]'))
    res.append(analyse(sym([(1, 0, 0), (0, 1, 0), (0, 0, 1)]), 'grid Z^3'))
    res.append(analyse(sym([(1,), (5,), (7,), (10,)]), 'rank-1 wall D={1,5,7,10}'))
    res.append(analyse(sym([(1,), (3,), (4,), (5,)]), 'rank-1 D={1,3,4,5}'))
    res.append(analyse(sym([(1,), (2,), (3,)]), 'Cay(Z,{1,2,3}) (K4 cliques)'))
    res.append(analyse(sym([(1,), (3,), (7,), (12,), (17,), (22,)]), 'G(Z,{1,3,7,12,17,22})'))
    return res


if __name__ == '__main__':
    for r in controls():
        print(r)
