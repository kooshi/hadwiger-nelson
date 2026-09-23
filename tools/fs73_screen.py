#!/usr/bin/env python3
"""fs73_screen -- FS-73 phase P1: the screens and the census of the subgroup sandwich F_known <= F <= P <= P_found.  UNTRUSTED (tools/).

THE OBJECTS (plan section 0, "The normal form").  Lambda = Z^r in lattice coordinates (tools/fs73_lattice.py), U its complete unit-
vector set, X the proper four-colourings of Cay(Lambda, U).  A PERIODIC colouring is one invariant under a finite-index subgroup W;
it is a colouring of the finite Cayley graph Cay(Lambda/W, U mod W), and every such colouring pulls back (row 56).
  Per(c)   its period group: {t : c(x + t) = c(x) for all x}, computed EXACTLY on Lambda/W (a sampled pass proposes, a full pass decides).
  KPer(c)  its Kempe period group: the translations fixing every (a,b)-Kempe component, a != b.  With W = Per(c) and the colouring
           descended to Lambda/W, KPer(c) = intersection over EVERY component Q of every two-colour subgraph, at all six colour pairs,
           of Q's voltage group V_Q (the deck group of the covering K -> Q; FS70-T10's theorem with W in place of N Lambda).
           Proof sketch: KPer <= Per = W (k >= 3); t in W fixes the lift K of Q iff t lies in V_Q, because K meets the class of x in
           x0 + p(x) + V_Q.
  P_N      the H1 group at period N: the common periods of all N Lambda-periodic colourings, exactly, by a counterexample-guided loop.
  P_found  the intersection of KPer(c) over every colouring found (every P_N term contains it, since KPer <= Per).
  F_known  the span of the orbits of certified forced vectors under the point group (fs73_lattice.point_group).
Quotients by an arbitrary finite-index W are built from its Smith form: a unimodular C and invariant factors d with x in W iff
(x C)_i = 0 mod d_i; a class is the big-endian mixed-radix index of (x C) mod d, which for W = N Lambda (C = I) is FS-70's convention.

THE FINDERS (CLAUDE.md, "break the symmetry before any SAT search").  Every CNF pins the origin to colour 0, its least neighbour to 1,
and a common neighbour of the two (a triangle; there is one iff sqrt3 is in the field, G57) to 2; any colours still interchangeable get a
value-precedence break over ALL vertices through auxiliary variables (O(n) clauses).  Aims: 'plain'; 'sep:G' adds c(G) != c(0); 'gap'
empties colour 3 from the closed neighbourhood of the origin.  An UNSAT says only that no colouring of that shape exists at that period
(G21); every UNSAT is recorded with the CNF's sha256; every SAT model is re-verified edge by edge before it is used.

Commands
  python3 tools/fs73_screen.py selftest [--plants]           # P1b's controls
  python3 tools/fs73_screen.py spectrum NAME [--nmax 12]      # P1b (i): m(Lambda) and each quotient's minimum
  python3 tools/fs73_screen.py crosscheck                    # P1c
  python3 tools/fs73_screen.py census K [--resume]            # P1d
  python3 tools/fs73_screen.py periods K [--resume]           # P1d'
Plants (--plant): dedup_steps (parallel edges dropped from the voltage computation), per_sample (Per accepted on the sampled pass
alone), kper_first (KPer taken from the first component only), prec_wrong (the precedence break inverted, 3 before 2).
"""
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

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]
VALID_PLANTS = ('dedup_steps', 'per_sample', 'kper_first', 'prec_wrong')
SCRATCH = os.environ.get('FS73_SCRATCH', '/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/'
                         'scratchpad/fs73-implA')
LOCK = '/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock'
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'


def planted(name):
    return PLANT == name


# ================================================================ integer lattices in Z^r

def hnf(rows, r):
    return FL.hnf([tuple(int(x) for x in row) for row in rows], r)


def member(H, v):
    return FL.coords_in(H, tuple(int(x) for x in v)) is not None


def rank_of(H):
    return len(H)


def intersect(L1, L2, r):
    """L1 n L2 for sublattices of Z^r given by row bases: the rows of HNF[(b | b) for b in L1; (b | 0) for b in L2] with zero first block"""
    rows = [list(b) + list(b) for b in L1] + [list(b) + [0] * r for b in L2]
    H = FL.hnf(rows, 2 * r)
    return hnf([row[r:] for row in H if not any(row[:r])], r)


def snf(B, r):
    """Smith form by row and column operations, tracking only the columns.  Returns (C, Cinv, d): C unimodular with
    x in span(B) <=> (x C)_i in d_i Z for every i (d_i = 0 means the coordinate must vanish; d_1 | d_2 | ...)."""
    M = [list(int(x) for x in b) for b in B if any(b)]
    C = [[1 if i == j else 0 for j in range(r)] for i in range(r)]

    def colop(j, t, q):                         # col_j -= q col_t, in M and C
        for row in M:
            row[j] -= q * row[t]
        for row in C:
            row[j] -= q * row[t]

    def colswap(a, b):
        for row in M:
            row[a], row[b] = row[b], row[a]
        for row in C:
            row[a], row[b] = row[b], row[a]
    t = 0
    while t < r and t < len(M):
        cand = [(abs(M[i][j]), i, j) for i in range(t, len(M)) for j in range(t, r) if M[i][j]]
        if not cand:
            break
        _, i, j = min(cand)
        M[t], M[i] = M[i], M[t]
        colswap(t, j)
        while True:
            changed = False
            for i in range(t + 1, len(M)):
                if M[i][t]:
                    q = M[i][t] // M[t][t]
                    M[i] = [a - q * b for a, b in zip(M[i], M[t])]
                    changed = changed or M[i][t] != 0
            for j in range(t + 1, r):
                if M[t][j]:
                    colop(j, t, M[t][j] // M[t][t])
                    changed = changed or M[t][j] != 0
            if changed:
                cand = [(abs(M[i][t]), i, t) for i in range(t, len(M)) if M[i][t]] + \
                       [(abs(M[t][j]), t, j) for j in range(t, r) if M[t][j]]
                _, i, j = min(cand)
                if i != t:
                    M[t], M[i] = M[i], M[t]
                if j != t:
                    colswap(t, j)
                continue
            bad = next(((i, j) for i in range(t + 1, len(M)) for j in range(t + 1, r) if M[i][j] % M[t][t]), None)
            if bad is None:
                break
            M[t] = [a + b for a, b in zip(M[t], M[bad[0]])]
        t += 1
    d = [abs(M[i][i]) for i in range(t)] + [0] * (r - t)
    Cinv = _inverse(C)
    for b in B:                                  # verification, never skipped
        y = [sum(b[k] * C[k][j] for k in range(r)) for j in range(r)]
        assert all((yj % dj == 0) if dj else yj == 0 for yj, dj in zip(y, d)), 'Smith form: a generator is not in the diagonal span'
    return C, Cinv, d


def _inverse(C):
    n = len(C)
    A = [[Fr(x) for x in row] + [Fr(1 if i == j else 0) for j in range(n)] for i, row in enumerate(C)]
    for i in range(n):
        p = next(k for k in range(i, n) if A[k][i])
        A[i], A[p] = A[p], A[i]
        piv = A[i][i]
        A[i] = [x / piv for x in A[i]]
        for k in range(n):
            if k != i and A[k][i]:
                f = A[k][i]
                A[k] = [x - f * y for x, y in zip(A[k], A[i])]
    inv = [[A[i][n + j] for j in range(n)] for i in range(n)]
    assert all(x.denominator == 1 for row in inv for x in row), 'C is not unimodular'
    return [[int(x) for x in row] for row in inv]


def describe(H, r):
    """the subgroup's rank, generators, and Lambda/H as Z^f x (+) Z/d"""
    _, _, d = snf(H, r) if H else (None, None, [0] * r)
    tors = [x for x in d if x > 1]
    free = sum(1 for x in d if x == 0)
    return {'rank': len(H), 'generators': [list(h) for h in H], 'Lambda_mod': {'free': free, 'torsion': tors},
            'index': (math.prod(tors) if free == 0 else None)}


def quotient_structure(P, F, r):
    """P/F for F <= P, both row bases in Z^r: Z^f x (+) Z/d, from the Smith form of F in P's coordinates"""
    rows = []
    for f in F:
        c = FL.coords_in(P, tuple(f))
        assert c is not None, 'F is not inside P'
        rows.append(c)
    k = len(P)
    if not rows:
        return {'free': k, 'torsion': []}
    _, _, d = snf(rows, k)
    return {'free': sum(1 for x in d if x == 0), 'torsion': [x for x in d if x > 1]}


# ================================================================ quotients Lambda / W

class Quot:
    def __init__(self, W, r):
        W = hnf(W, r)
        assert len(W) == r, 'W must have finite index'
        self.W, self.r = W, r
        C, Cinv, d = snf(W, r)
        assert all(x > 0 for x in d)
        self.C = np.array(C, dtype=np.int64)
        self.Cinv = np.array(Cinv, dtype=np.int64)
        self.keep = [i for i in range(r) if d[i] > 1]
        self.mods = np.array([d[i] for i in self.keep], dtype=np.int64)
        self.n = int(np.prod(self.mods)) if len(self.keep) else 1
        k = len(self.keep)
        self.pw = np.array([int(np.prod(self.mods[i + 1:])) for i in range(k)], dtype=np.int64)
        self._digs = None
        idx_hnf = math.prod(abs(row[next(j for j in range(r) if row[j])]) for row in W)
        assert self.n == idx_hnf, f'Smith form and Hermite form disagree on the index: {self.n} vs {idx_hnf}'

    def digits_of(self, X):
        """lattice points (m x r) -> class digits (m x k)"""
        Y = np.asarray(X, dtype=np.int64) @ self.C
        return np.mod(Y[:, self.keep], self.mods)

    def cls(self, X):
        return (self.digits_of(X) * self.pw).sum(axis=1)

    def digits(self):
        if self._digs is None:
            idx = np.arange(self.n, dtype=np.int64)
            self._digs = np.stack([(idx // p) % m for p, m in zip(self.pw, self.mods)], axis=1) if len(self.keep) else \
                np.zeros((1, 0), dtype=np.int64)
        return self._digs

    def rep(self, idx):
        """class indices -> lattice points (a representative of each class)"""
        idx = np.atleast_1d(np.asarray(idx, dtype=np.int64))
        Y = np.zeros((len(idx), self.r), dtype=np.int64)
        for j, (p, m) in enumerate(zip(self.pw, self.mods)):
            Y[:, self.keep[j]] = (idx // p) % m
        return Y @ self.Cinv

    def shift(self, t_digits):
        """the class translation by a digit vector, as an index array"""
        D = np.mod(self.digits() + np.asarray(t_digits, dtype=np.int64), self.mods)
        return (D * self.pw).sum(axis=1)

    def shift_by_point(self, u):
        return self.shift(self.digits_of(np.array([u]))[0])

    def admissible(self, U):
        return not any(c == 0 for c in self.cls(np.array(U)))


def NW(N, r):
    return [tuple(N if i == j else 0 for j in range(r)) for i in range(r)]


# ================================================================ periodic colourings

class PColour:
    def __init__(self, U, Q, col, label=''):
        self.U = [tuple(u) for u in U]
        self.Q, self.label = Q, label
        self.col = np.asarray(col, dtype=np.int8)
        assert len(self.col) == Q.n
        self.add = [Q.shift_by_point(u).astype(np.int64) for u in self.U]     # the FULL multiset: parallel edges kept
        bad = sum(int(np.count_nonzero(self.col[t] == self.col)) for t in self.add)
        assert bad == 0, f'{label}: the colouring is not proper on its quotient ({bad} monochromatic incidences)'

    # -- the exact period group
    def per(self, seed=0):
        Q, col = self.Q, self.col
        cand = np.nonzero(col == col[0])[0]
        digs = Q.digits()
        rng = np.random.default_rng(seed)
        S = rng.choice(Q.n, size=1 if planted('per_sample') else min(64, Q.n), replace=False)   # PLANT: a one-point sample
        surv = []
        for lo in range(0, len(cand), 20000):
            cd = digs[cand[lo:lo + 20000]]
            D = np.mod(digs[S][None, :, :] + cd[:, None, :], Q.mods)
            ok = (col[(D * Q.pw).sum(axis=2)] == col[S][None, :]).all(axis=1)
            surv += cand[lo:lo + 20000][ok].tolist()
        periods = []
        for t in surv:
            if planted('per_sample') or bool(np.array_equal(col[Q.shift(digs[t])], col)):
                periods.append(t)
        rows = list(Q.W)
        H = hnf(rows, Q.r)
        for t in periods:
            x = Q.rep([t])[0]
            if not member(H, x):
                H = hnf(list(H) + [tuple(int(v) for v in x)], Q.r)
        return H, len(periods)

    def descend(self, W2):
        Q2 = Quot(W2, self.Q.r)
        reps = Q2.rep(np.arange(Q2.n))
        col2 = self.col[self.Q.cls(reps)]
        return PColour(self.U, Q2, col2, self.label + '|descended')

    # -- every Kempe component and its voltage group
    def components(self, a, b):
        """(labels on the two-colour classes, potentials p, {label: HNF of V_Q}, root of each label)"""
        from scipy.sparse import coo_matrix
        from scipy.sparse.csgraph import connected_components
        Q, col, r = self.Q, self.col, self.Q.r
        inQ = (col == a) | (col == b)
        idx = np.nonzero(inQ)[0]
        steps = list(enumerate(self.U))
        if planted('dedup_steps'):
            seen, keep = set(), []
            for k, u in steps:
                rr = int(self.add[k][0])
                if rr not in seen:
                    seen.add(rr)
                    keep.append((k, u))
            steps = keep
        src, dst = [], []
        for k, _ in steps:
            j = self.add[k][idx]
            m = inQ[j]
            src.append(idx[m])
            dst.append(j[m])
        src = np.concatenate(src)
        dst = np.concatenate(dst)
        A = coo_matrix((np.ones(len(src), dtype=np.int8), (src, dst)), shape=(Q.n, Q.n)).tocsr()
        ncomp, lab = connected_components(A, directed=False)
        lab = np.where(inQ, lab, -1)
        # simultaneous BFS from one root per component: p is an actual lattice point of its class
        roots_lab, roots = np.unique(lab[idx], return_index=True)
        roots = idx[roots]
        p = np.zeros((Q.n, r), dtype=np.int64)
        vis = np.zeros(Q.n, dtype=bool)
        p[roots] = Q.rep(roots)
        vis[roots] = True
        front = roots
        while front.size:
            new = []
            for k, u in steps:
                j = self.add[k][front]
                m = inQ[j] & ~vis[j]
                if m.any():
                    jj, first = np.unique(j[m], return_index=True)
                    p[jj] = p[front[m][first]] + np.array(u, dtype=np.int64)
                    vis[jj] = True
                    new.append(jj)
            front = np.concatenate(new) if new else np.zeros(0, dtype=np.int64)
        assert vis[idx].all()
        # fundamental-cycle voltages, one per edge incidence, grouped by component
        G = []
        for k, u in steps:
            j = self.add[k][idx]
            m = inQ[j]
            g = p[idx[m]] + np.array(u, dtype=np.int64) - p[j[m]]
            G.append(np.concatenate([lab[idx[m]][:, None], g], axis=1))
        G = np.unique(np.concatenate(G), axis=0)
        V = {}
        order = np.argsort(G[:, 0], kind='stable')
        G = G[order]
        cuts = np.flatnonzero(np.diff(G[:, 0])) + 1
        for block in np.split(G, cuts):
            L = int(block[0, 0])
            H = []
            for g in block[:, 1:]:
                if g.any() and not member(H, g):
                    H = hnf(list(H) + [tuple(int(x) for x in g)], r)
            V[L] = H
        for L in roots_lab:                      # a component with no edge at all (an isolated class) has V = 0
            V.setdefault(int(L), [])
        return lab, p, V, dict(zip(roots_lab.tolist(), roots.tolist()))

    def kper(self):
        """KPer(c) = intersection of V_Q over every component of every two-colour subgraph.  Requires the colouring to be on
        Lambda/Per(c) (call descend(per) first); asserted."""
        r = self.Q.r
        H = [tuple(w) for w in self.Q.W]
        stats = {}
        distinct = set()
        for a, b in itertools.combinations(range(4), 2):
            if not ((self.col == a).any() and (self.col == b).any()):
                continue
            lab, p, V, roots = self.components(a, b)
            ranks = [len(v) for v in V.values()]
            stats[f'{a}{b}'] = {'components': len(V), 'min_V_rank': min(ranks), 'max_V_rank': max(ranks)}
            for v in V.values():
                distinct.add(tuple(v))
            if planted('kper_first'):
                break
        for v in sorted(distinct):
            H = intersect(H, list(v), r)
        return H, stats

    # -- T10 at the origin, with the re-periodised separator's period W' (R3)
    def origin_screen(self, delta):
        Q, r = self.Q, self.Q.r
        dcl = int(Q.cls(np.array([delta]))[0])
        a = int(self.col[0])
        if int(self.col[dcl]) != a:
            return {'verdict': 'escape', 'level': 0, 'W_prime': describe(Q.W, r), 'escape_colour': None}
        out = {'verdict': 'rigid', 'level': 1, 'per_b': {}}
        for b in range(4):
            if b == a:
                continue
            lab, p, V, roots = self.components(a, b)
            L0 = int(lab[0])
            root = roots[L0]
            shift0 = p[0].copy()                 # potentials relative to the origin: q(x) = p(x) - p(0), a point of x's class minus 0
            H = V[L0]
            inQ0 = int(lab[dcl]) == L0
            e = None if not inQ0 else (np.asarray(delta, dtype=np.int64) - (p[dcl] - shift0))
            reached = inQ0 and member(H, e)
            info = {'component_classes': int((lab == L0).sum()), 'V_rank': len(H), 'delta_in_K0': bool(reached)}
            if not reached:
                info['W_prime'] = w_prime(Q.W, H, e, r)
                if out['verdict'] == 'rigid':
                    out['verdict'] = 'escape'
                    out['escape_colour'] = b
            out['per_b'][b] = info
        return out


def w_prime(W, V, e, r):
    """R3: a finite-index W' with V <= W' <= W and e not in W' (e None: the target's class is off the component, W' = W).
    Chosen of least index in W: from the Smith form of W/V, restrict one coordinate that e does not satisfy."""
    if e is None:
        return describe(W, r)
    Wc = [FL.coords_in(W, tuple(w)) for w in W]           # W's own basis: identity coordinates
    Vc = [FL.coords_in(W, tuple(int(x) for x in v)) for v in V]
    ec = FL.coords_in(W, tuple(int(x) for x in e))
    assert ec is not None and all(c is not None for c in Vc), 'V or e is not inside W'
    k = len(W)
    C, Cinv, d = snf(Vc, k) if Vc else ([[1 if i == j else 0 for j in range(k)] for i in range(k)], None, [0] * k)
    y = [sum(ec[i] * C[i][j] for i in range(k)) for j in range(k)]
    best = None
    for j in range(k):
        if d[j] > 1 and y[j] % d[j]:            # a torsion coordinate: the least divisor ell of d_j with ell not dividing y_j
            ell = next(l for l in range(2, d[j] + 1) if d[j] % l == 0 and y[j] % l)
        elif d[j] == 0 and y[j]:                 # a free coordinate: the least ell >= 2 not dividing y_j
            ell = next(l for l in itertools.count(2) if y[j] % l)
        else:
            continue
        if best is None or ell < best[2]:
            best = (None, j, ell)
    assert best is not None, 'e lies in V: no escape to certify'
    _, j, m = best
    # W' = { x in W : (x C)_j = 0 mod m } (plus V automatically), back in Lambda coordinates
    Cinv_full = _inverse(C)
    rows = []
    for i in range(k):
        yy = [0] * k
        yy[i] = m if i == j else 1
        xc = [sum(yy[s] * Cinv_full[s][t] for s in range(k)) for t in range(k)]
        rows.append(tuple(sum(xc[s] * W[s][t] for s in range(k)) for t in range(r)))
    Wp = hnf(rows, r)
    assert all(member(Wp, v) for v in V) and not member(Wp, e)
    dsc = describe(Wp, r)
    dsc['exponent'] = _exponent(Wp, r)
    return dsc


def _exponent(H, r):
    """least m with m Lambda <= H"""
    _, _, d = snf(H, r)
    return max(d) if all(x > 0 for x in d) else None


# ================================================================ the SAT finders

def quotient_graph(Q, U):
    """the simple graph Cay(Lambda/W, U mod W): distinct residues, edges i < j"""
    res = sorted({int(c) for c in Q.cls(np.array(U))})
    assert 0 not in res, 'W is not admissible: a unit vector lies in W'
    E = []
    idx = np.arange(Q.n, dtype=np.int64)
    for rcls in res:
        j = Q.shift(Q.digits()[rcls])
        m = idx < j
        E.append(np.stack([idx[m], j[m]], axis=1))
    E = np.unique(np.concatenate(E), axis=0)
    return E, res


def build_cnf(Q, U, aim='plain', target=None, k=4):
    """returns (clauses as a list of int lists, nvars, pins, note).  Variables: x[v][c] = k v + c + 1."""
    E, res = quotient_graph(Q, U)
    n = Q.n
    x = lambda v, c: k * v + c + 1
    nb = min(res)
    nbset = set(res)
    # a common neighbour of 0 and nb: w in N(0) with w - nb in U mod W
    tri = None
    dn = Q.digits()[nb]
    for w in res:
        diff = int((np.mod(Q.digits()[w] - dn, Q.mods) * Q.pw).sum())
        if diff in nbset:
            tri = w
            break
    pins = [(0, 0), (nb, 1)] + ([(tri, 2)] if tri is not None else [])
    cls = [[x(v, c) for c in range(k)] for v in range(n)]
    note = []
    extra = []
    if aim == 'sep':
        tcl = int(Q.cls(np.array([target]))[0])
        if tcl == 0:
            return None, 0, pins, 'the target lies in W: its class is the origin'
        if tcl in (nb, tri):
            # the pinned vertex's colour is already != 0 : the ask is trivially the plain ask
            pass
        extra.append([-x(tcl, 0)])
        note.append(f'c(target class {tcl}) != c(0)')
    elif aim == 'gap':
        extra.append([-x(0, 3)])
        extra += [[-x(s, 3)] for s in res]
        note.append('colour 3 absent from N[0]')
    for v, c in pins:
        extra.append([x(v, c)])
    free = [c for c in range(k) if c not in {c_ for _, c_ in pins} and not (aim == 'gap' and c == 3)]
    nvars = k * n
    if len(free) >= 2:
        for f1, f2 in zip(free, free[1:]):
            if planted('prec_wrong'):
                f1, f2 = f2, f1                  # PLANT: the break inverted
            base = nvars
            nvars += n + 1                        # s_v = "f1 occurs at some vertex < v", v = 0..n
            s = lambda v: base + v + 1
            extra.append([-s(0)])
            for v in range(n):
                extra.append([-x(v, f2), s(v)])
                extra.append([-s(v + 1), s(v), x(v, f1)])
        note.append(f'value precedence over all {n} vertices among colours {free}')
    note.insert(0, 'origin 0, least neighbour 1' + (', triangle 2' if tri is not None else ' (no triangle: omega = 2)'))
    return (cls, E, extra), nvars, pins, '; '.join(note)


def write_cnf(path, n, parts, nvars, k=4):
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


class HeavyLock:
    """the shared heavy-job lock, taken per ask and only for asks priced heavy (> 2 min or > 8 GB); waits up to 600 s"""
    def __init__(self, heavy):
        self.heavy, self.f = heavy, None

    def __enter__(self):
        if self.heavy:
            import fcntl
            self.f = open(LOCK, 'a')
            t0 = time.time()
            while True:
                try:
                    fcntl.flock(self.f, fcntl.LOCK_EX | fcntl.LOCK_NB)
                    break
                except BlockingIOError:
                    if time.time() - t0 > 600:
                        raise RuntimeError('the heavy lock was not free within 600 s')
                    time.sleep(2)
        return self

    def __exit__(self, *a):
        if self.f is not None:
            import fcntl
            fcntl.flock(self.f, fcntl.LOCK_UN)
            self.f.close()


def solve(Q, U, aim='plain', target=None, budget=600, solver='kissat', heavy=None):
    """one finder ask.  Returns a record dict and the colouring (np.int8 array) or None."""
    parts, nvars, pins, note = build_cnf(Q, U, aim, target)
    rec = {'aim': aim, 'classes': Q.n, 'note': note, 'solver': solver, 'budget_s': budget, 'machine': MACHINE}
    if parts is None:
        rec['verdict'] = 'n/a'
        return rec, None
    os.makedirs(SCRATCH, exist_ok=True)
    path = os.path.join(SCRATCH, f'ask-{os.getpid()}-{Q.n}-{aim}.cnf')
    sha, ncl = write_cnf(path, Q.n, parts, nvars)
    rec.update({'cnf_sha256': sha, 'clauses': ncl, 'vars': nvars, 'edges': int(len(parts[1]))})
    heavy = (Q.n > 150000 or budget > 120) if heavy is None else heavy
    t0 = time.time()
    ru0 = os.times()
    with HeavyLock(heavy):
        t0 = time.time()
        ru0 = os.times()
        try:
            p = subprocess.run([solver, '-q', path], capture_output=True, text=True, timeout=budget)
            out = p.stdout
            v = 'UNKNOWN'
            for line in out.splitlines():
                if line.startswith('s '):
                    v = 'UNSAT' if 'UNSATISFIABLE' in line else 'SAT'
        except subprocess.TimeoutExpired:
            out, v = '', 'UNKNOWN'
    ru1 = os.times()
    rec['wall_s'] = round(time.time() - t0, 2)
    rec['cpu_s'] = round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2)
    rec['verdict'] = v
    rec['lock'] = bool(heavy)
    os.remove(path)
    if v != 'SAT':
        if v == 'UNKNOWN':
            rec['unknown_type'] = f'budget: {budget} s wall, {solver}'
        return rec, None
    lits = []
    for line in out.splitlines():
        if line.startswith('v '):
            lits += [int(t) for t in line[2:].split()]
    pos = np.zeros(nvars + 1, dtype=bool)
    L = np.array(lits, dtype=np.int64)
    pos[L[L > 0]] = True
    X = pos[1:4 * Q.n + 1].reshape(Q.n, 4)
    assert X.any(axis=1).all()
    col = np.argmax(X, axis=1).astype(np.int8)
    E = parts[1]
    assert not np.any(col[E[:, 0]] == col[E[:, 1]]), 'the solver returned an improper colouring'
    for v_, c_ in pins:
        assert col[v_] == c_
    if aim == 'sep':
        assert col[int(Q.cls(np.array([target]))[0])] != col[0]
    return rec, col


# ================================================================ the spectrum (P1b i)

def spectrum_quotient(U, N, r):
    Ua = np.array(U, dtype=float)
    best = math.inf
    cnt = 0
    for chunk in _chunks(itertools.product(range(N), repeat=r), 200000):
        th = np.array(chunk, dtype=float) / N
        v = np.cos(2 * np.pi * (th @ Ua.T)).sum(axis=1)
        m = v.min()
        if m < best - 1e-9:
            best, cnt = m, int(np.isclose(v, m, atol=1e-9).sum())
        elif abs(m - best) <= 1e-9:
            cnt += int(np.isclose(v, best, atol=1e-9).sum())
    return best, cnt


def _chunks(it, n):
    buf = []
    for x in it:
        buf.append(x)
        if len(buf) == n:
            yield buf
            buf = []
    if buf:
        yield buf


def spectrum_continuous(U, r, starts=4000, seed=1):
    from scipy.optimize import minimize
    Ua = np.array(U, dtype=float)
    f = lambda t: float(np.cos(2 * np.pi * (Ua @ t)).sum())
    g = lambda t: -2 * np.pi * (np.sin(2 * np.pi * (Ua @ t)) @ Ua)
    rng = np.random.default_rng(seed)
    best = (math.inf, None)
    for _ in range(starts):
        o = minimize(f, rng.random(r), jac=g, method='BFGS')
        if o.fun < best[0]:
            best = (o.fun, np.mod(o.x, 1))
    return best


# ================================================================ additive colourings (P1b iii) and the two named ones

def additive_family(U, r, group):
    """every proper additive colouring phi : Lambda -> Z/4 ('z4') or (Z/2)^2 ('k4'), as the list of basis values"""
    Ua = np.array(U, dtype=np.int64)
    out = []
    for phi in itertools.product(range(4), repeat=r):
        ph = np.array(phi, dtype=np.int64)
        if group == 'z4':
            vals = np.mod(Ua @ ph, 4)
        else:
            vals = np.mod(Ua @ (ph & 1), 2) + 2 * np.mod(Ua @ (ph >> 1), 2)
        if (vals != 0).all():
            out.append(phi)
    return out


def additive_colouring(Q, phi, group):
    X = Q.rep(np.arange(Q.n))
    ph = np.array(phi, dtype=np.int64)
    if group == 'z4':
        return np.mod(X @ ph, 4).astype(np.int8)
    return (np.mod(X @ (ph & 1), 2) + 2 * np.mod(X @ (ph >> 1), 2)).astype(np.int8)


def named_colouring_values(lat, which):
    """the basis values of Theorem B's residue colouring ('residue', tools/residue_colouring.py, S = the 2-adic sqrt33 = 17 mod 256)
    or [Fischer1994]'s Z/4 colouring ('fischer', tools/fischer1994_check.py's v_of) on de Grey's lattice"""
    import residue_colouring as RC
    import fischer1994_check as FC
    out = []
    S = RC.sqrt33_2adic(17)
    for b in lat.H:
        x = tuple(Fr(t, lat.M) for t in b[:4])
        y = tuple(Fr(t, lat.M) for t in b[4:])
        if which == 'residue':
            pq = RC.residue_of_coords(x, y, S)
            assert pq is not None
            out.append(pq[0] + 2 * pq[1])
        else:
            res = FC.v_of((x, y))[-1]
            assert res is not None, 'Fischer map not 2-integral on a basis vector'
            out.append(res)
    return out


def check_assignment(Q, U, col, aim='plain', target=None):
    """does the finder's own CNF accept this colouring, after the colour permutation its pins require?  (a positive control on the
    encoding: a known solution must satisfy every clause)"""
    parts, nvars, pins, note = build_cnf(Q, U, aim, target)
    perm = {}
    for v, c in pins:
        if int(col[v]) in perm and perm[int(col[v])] != c:
            return False, 'the pins clash'
        perm[int(col[v])] = c
    rest = [c for c in range(4) if c not in perm.values()]
    for c in range(4):
        if c not in perm:
            perm[c] = rest.pop(0)
    c2 = np.array([perm[int(c)] for c in col], dtype=np.int8)
    # precedence among any free colours: relabel by first appearance
    cls, E, extra = parts
    free = [c for c in range(4) if c not in {c_ for _, c_ in pins}]
    if len(free) >= 2:
        order = [c for c in dict.fromkeys(c2.tolist()) if c in free]
        remap = {a: b for a, b in zip(order, sorted(free))}
        c2 = np.array([remap.get(int(c), int(c)) for c in c2], dtype=np.int8)
    assign = {4 * v + int(c2[v]) + 1 for v in range(Q.n)}
    # auxiliary precedence variables: s_v true iff the earlier colour occurred before v
    val = lambda l: (abs(l) in assign) if l > 0 else (abs(l) not in assign)
    base = 4 * Q.n
    if len(free) >= 2:
        f1 = min(free)
        seen = False
        for v in range(Q.n + 1):
            if seen:
                assign.add(base + v + 1)
            if v < Q.n and c2[v] == f1:
                seen = True
    if np.any(c2[E[:, 0]] == c2[E[:, 1]]):
        return False, 'not proper'
    for c in cls + extra:
        if not any(val(l) for l in c):
            return False, f'clause {c[:4]} violated'
    return True, note


# ================================================================ FS-70's committed colourings, re-read in this file's coordinates

def fs70_degrey_colouring(lat, N):
    """FS-70's committed de Grey colouring at N, mapped class by class through the points (its basis is fs70_harder's echelon)"""
    import fs70_harder as HD
    d = json.load(open(os.path.join(ROOT, 'data', 'fs70', 'quotient', f'degrey-K-N{N}.colouring.json')))
    gens = [z for z in HD.harder_V() if z != HD.CZERO]
    units, B, M = HD.lattice_saturation(gens)
    assert M == lat.M
    r = len(B)
    Q = Quot(NW(N, r), r)
    col = np.zeros(Q.n, dtype=np.int8)
    fs70_pw = [N ** (r - 1 - i) for i in range(r)]
    for i, c in enumerate(d['colouring']):
        digs = [(i // p) % N for p in fs70_pw]
        v8 = tuple(sum(dj * B[j][t] for j, dj in enumerate(digs)) for t in range(8))
        mine = lat.coords(v8)
        col[int(Q.cls(np.array([mine]))[0])] = c
    return Q, col


# ================================================================ P1b: the self-test

def degrey_setup():
    lat = FL.degrey()
    lat.saturate('trace')
    r = lat.rank
    T = {'8/3': FL.rational_point(lat, 8, 3), '2': FL.rational_point(lat, 2), '4': FL.rational_point(lat, 4)}
    return lat, r, T


def selftest(plants=False):
    fails = []

    def check(nm, ok, detail=''):
        print(f'  [{"ok " if ok else "FAIL"}] {nm}  {detail}', flush=True)
        if not ok:
            fails.append(nm)

    print('fs73_screen self-test (P1b controls)', flush=True)
    lat, r, T = degrey_setup()
    U = lat.U
    # algebra
    C, Ci, d = snf([(2, 0), (0, 3)], 2)
    check('Smith form of 2Z x 3Z is Z/6', sorted(x for x in d if x > 1) == [6], str(d))
    check('intersection 2Z^2 n 3Z^2 = 6Z^2', hnf(intersect(NW(2, 2), NW(3, 2), 2), 2) == hnf(NW(6, 2), 2))
    # (i) the spectrum, against section R0
    R0 = {2: -18.0, 4: -18.0, 5: -18.034442, 6: -18.0, 7: -14.344814, 8: -18.142136, 9: -9.517541, 10: -18.270510,
          11: -21.580897, 12: -18.928203, 3: 24.0}
    got = {N: spectrum_quotient(U, N, r)[0] for N in R0}
    check('(i) quotient minima at N = 2..12 equal section R0 to 1e-6', all(abs(got[N] - R0[N]) < 2e-6 for N in R0),
          ' '.join(f'{N}:{got[N]:+.6f}' for N in sorted(got)))
    mn, th = spectrum_continuous(U, r, starts=1000)
    check('(i) continuous minimum over T^4 is -22.4095 (section R0), 1000 BFGS starts', abs(mn + 22.409530) < 1e-5, f'{mn:+.9f}')
    # (iii) the named colourings, from their definitions, accepted by the finder's own CNF
    for which, N, group in (('residue', 2, 'k4'), ('fischer', 4, 'z4')):
        vals = named_colouring_values(lat, which)
        Q = Quot(NW(N, r), r)
        col = additive_colouring(Q, vals, group)
        try:
            pc = PColour(U, Q, col, which)
            proper = True
        except AssertionError:
            proper = False
        ok, why = check_assignment(Q, U, col)
        fam = additive_family(U, r, group)
        check(f'(iii) {which} colouring (period {N}) is proper, accepted by the plain CNF, and in the {group} additive family',
              proper and ok and tuple(vals) in {tuple(p) for p in fam}, f'basis values {vals}; family size {len(fam)}; {why}')
    # the additive slice against row 50: 1/2 in Lambda empties the family
    half = FL.rational_point(lat, 1, 2)
    check('(iii) 1/2 is not in de Grey\'s lattice, so the additive family may be nonempty', half is None, str(half))
    # (ii) FS-70's committed colourings re-screened: 8/3 rigid at all six, 2 and 4 escape at five (N = 12 rigid)
    table = {}
    for N in (2, 4, 6, 8, 10, 12):
        Q, col = fs70_degrey_colouring(lat, N)
        pc = PColour(U, Q, col, f'fs70-N{N}')
        table[N] = {t: pc.origin_screen(T[t])['verdict'] for t in ('8/3', '2', '4')}
    ok = all(table[N]['8/3'] == 'rigid' for N in table) and [table[N]['2'] for N in (2, 4, 6, 8, 10, 12)] == \
        ['escape'] * 5 + ['rigid'] and [table[N]['4'] for N in (2, 4, 6, 8, 10, 12)] == ['escape'] * 5 + ['rigid']
    check("(ii) FS-70's six de Grey colourings: 8/3 rigid at 6 of 6; 2 and 4 escape at N = 2..10 and not at 12 (FS-70 1e §3.2)",
          ok, str({N: ''.join(v[0] for v in table[N].values()) for N in table}))
    # (ii) the gap finder on L1 at N = 5 (T6's instance): must find a gapped colouring
    L1 = FL.fabric('group6:u3:2')
    L1.saturate('trace')
    Q = Quot(NW(5, L1.rank), L1.rank)
    rec, col = solve(Q, L1.U, 'gap', budget=120)
    gapped = False
    if col is not None:
        pc = PColour(L1.U, Q, col, 'L1-gap')
        seen = {int(col[0])} | {int(col[t[0]]) for t in pc.add}
        gapped = 3 not in seen
    check('(ii) the gap-aimed finder finds a gapped colouring of L1 at N = 5 (T6), verified from the colouring', gapped,
          f'{rec["verdict"]} in {rec.get("wall_s")} s, {Q.n} classes')
    # and the paired control: de Grey at N = 8 has NO gapped colouring (Harder + T6); the finder must refuse
    Q8 = Quot(NW(8, r), r)
    rec8, col8 = solve(Q8, U, 'gap', budget=300)
    check('(ii) paired: the gap finder refuses de Grey at N = 8 (Harder + T6 forbid a gap there)', rec8['verdict'] == 'UNSAT',
          f'{rec8["verdict"]} in {rec8.get("wall_s")} s')
    # Per and KPer on one committed colouring, with the descended quotient
    Q, col = fs70_degrey_colouring(lat, 12)
    pc = PColour(U, Q, col, 'fs70-N12')
    Wp, nper = pc.per()
    pd = pc.descend(Wp)
    KP, st = pd.kper()
    t83_in = member(KP, T['8/3'])
    check('KPer of the N = 12 colouring: contains 8/3 (it is forced) and lies inside Per', t83_in and all(member(Wp, k) for k in KP),
          f'Per: {describe(Wp, r)["Lambda_mod"]}; KPer: rank {len(KP)}, {describe(KP, r)["Lambda_mod"]}')
    if plants:
        global PLANT
        print('  -- plants: each must move the N = 12 bed (Per, KPer or the prec check)', flush=True)
        base = (tuple(map(tuple, Wp)), tuple(map(tuple, KP)))
        for nm in VALID_PLANTS:
            PLANT = nm
            try:
                if nm == 'prec_wrong':
                    PLANT = None                  # the bed: FS-61's Q(sqrt11) shape at the first N whose quotient has no triangle
                    Lq = FL.q11shape()
                    Lq.saturate('trace')
                    for Nq in range(2, 9):
                        Qq = Quot(NW(Nq, Lq.rank), Lq.rank)
                        if Qq.admissible(Lq.U) and 'no triangle' in build_cnf(Qq, Lq.U)[3]:
                            break
                    recq, colq = solve(Qq, Lq.U, 'plain', budget=60)
                    okq = colq is not None and check_assignment(Qq, Lq.U, colq)[0]
                    PLANT = nm
                    pl = check_assignment(Qq, Lq.U, colq)[0] if colq is not None else None
                    moved = okq and pl is False
                    why = f'bed N = {Nq}, {Qq.n} classes; faithful accepted {okq}, planted accepted {pl}'
                else:
                    pc2 = PColour(U, Q, col, 'plant')
                    W2, _ = pc2.per()
                    KP2, _ = pc2.descend(W2).kper()
                    moved = (tuple(map(tuple, W2)), tuple(map(tuple, KP2))) != base
                    why = f'Per {describe(W2, r)["Lambda_mod"]}, KPer rank {len(KP2)} {describe(KP2, r)["Lambda_mod"]}'
            except AssertionError as e:
                moved, why = True, f'raised: {str(e)[:80]}'
            PLANT = None
            check(f'plant {nm} fires', moved, why)
    print('SELF-TEST PASSED' if not fails else 'SELF-TEST FAILED: ' + ', '.join(fails), flush=True)
    return 1 if fails else 0


def cmd_spectrum(name, nmax):
    lat = FL.named(name)
    lat.saturate('trace')
    for N in range(2, nmax + 1):
        mn, cnt = spectrum_quotient(lat.U, N, lat.rank)
        print(f'N={N:2d} quotient lambda_min={mn:+.6f} #argmin={cnt} Hoffman floor {1 + len(lat.U) / abs(mn):.4f}')
    mn, th = spectrum_continuous(lat.U, lat.rank)
    print(f'continuous min over T^{lat.rank}: {mn:+.9f} at {np.round(th, 6)}; -d/3 = {-len(lat.U) / 3:.6f}')


def main():
    argv = sys.argv[1:]
    if PLANT is not None and PLANT not in VALID_PLANTS:
        raise SystemExit(f'unknown plant {PLANT!r}')
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 'selftest':
        return selftest('--plants' in argv)
    if argv[0] == 'spectrum':
        cmd_spectrum(argv[1], int(argv[argv.index('--nmax') + 1]) if '--nmax' in argv else 12)
        return 0
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
