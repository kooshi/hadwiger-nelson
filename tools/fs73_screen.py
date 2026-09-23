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
VALID_PLANTS = ('dedup_steps', 'per_sample', 'kper_first', 'prec_wrong', 'loop_stale')
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
        # the periods form a group: a candidate already in the span of FULLY verified periods is a period by closure, so only a
        # candidate that would enlarge the span gets the O(n) full pass (the full pass is what the plant per_sample skips)
        H = hnf(list(Q.W), Q.r)
        X = Q.rep(np.array(surv, dtype=np.int64)) if surv else np.zeros((0, Q.r), dtype=np.int64)
        full = 0
        for t, x in zip(surv, X):
            if member(H, x):
                continue
            full += 1
            if planted('per_sample') or bool(np.array_equal(col[Q.shift(digs[t])], col)):
                H = hnf(list(H) + [tuple(int(v) for v in x)], Q.r)
        nper = Q.n // math.prod(abs(row[next(j for j in range(Q.r) if row[j])]) for row in H) if H else 0
        return H, nper

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
    """the shared heavy-job lock, taken per ask and only for asks priced heavy (> 2 min or > 8 GB); waits up to 3600 s"""
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
                    if time.time() - t0 > 3600:
                        raise RuntimeError('the heavy lock was not free within 3600 s')
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
    heavy = (Q.n > 150000) if heavy is None else heavy          # by expected cost (seconds below this), never by the cap
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
    import resource
    rec['children_maxrss_gb'] = round(resource.getrusage(resource.RUSAGE_CHILDREN).ru_maxrss / 1e6, 3)   # peak over this process's asks
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


# ================================================================ finite balls and the forcing ask

def word_ball(U, k):
    """every sum of at most k unit vectors, in lattice coordinates"""
    seen = {tuple([0] * len(U[0]))}
    front = list(seen)
    for _ in range(k):
        nxt = []
        for p in front:
            for u in U:
                q = tuple(a + b for a, b in zip(p, u))
                if q not in seen:
                    seen.add(q)
                    nxt.append(q)
        front = nxt
    return sorted(seen)


def minkowski_ball(lat, R, cap=3_000_000):
    """every lattice point z with |sigma(z)| <= R under every embedding sigma of F (acting on x and y): enumerated from the trace-form
    ellipsoid Tr(x^2 + y^2) <= n R^2 by PARI's qfminim, then filtered exactly enough (floats decide membership in a ball, which is any
    legitimate finite graph; edges are exact by construction)"""
    G = lat.gram_int()
    n, M = lat.F.n, lat.M
    bound = int(math.floor(n * R * R * M * M)) + 1
    mat = '[' + ';'.join(','.join(str(x) for x in row) for row in G) + ']'
    script = f'v = qfminim({mat}, {bound}, {cap}, 0); print(#v[3]); for(k=1, #v[3], print(Vec(v[3][,k])))'
    pr = subprocess.run(['gp', '-q', '-s', '4000000000'], input=script + '\n', capture_output=True, text=True)
    lines = pr.stdout.strip().split('\n')
    cnt = int(lines[0])
    if cnt >= cap:
        raise RuntimeError(f'minkowski_ball: the ellipsoid holds more than {cap} vectors at R = {R}')
    Hf = np.array(lat.H, dtype=float) / M
    pts = [tuple([0] * lat.rank)]
    rows = [[int(x) for x in line.strip('[] \n').split(',')] for line in lines[1:1 + cnt]]
    if rows:
        C = np.array(rows, dtype=np.int64)
        P = C.astype(float) @ Hf                      # (m x 2n) coordinates over the field basis
        ok = np.ones(len(C), dtype=bool)
        for sg in lat.F.signs:
            ev = np.array([lat.F.emb(tuple(1 if a == b else 0 for b in range(n)), sg) for a in range(n)])
            x, y = P[:, :n] @ ev, P[:, n:] @ ev
            ok &= x * x + y * y <= R * R + 1e-9
        for c in C[ok]:
            pts.append(tuple(int(t) for t in c))
            pts.append(tuple(-int(t) for t in c))
    return sorted(set(pts))


def ball_graph(points, U):
    idx = {p: i for i, p in enumerate(points)}
    E = []
    for i, p in enumerate(points):
        for u in U:
            j = idx.get(tuple(a + b for a, b in zip(p, u)))
            if j is not None and i < j:
                E.append((i, j))
    return idx, np.array(sorted(set(E)), dtype=np.int64).reshape(-1, 2)


def core(n, E, m, keep=()):
    """the m-core, never deleting the vertices in keep; returns the surviving vertex list"""
    deg = np.bincount(E.ravel(), minlength=n).astype(np.int64)
    alive = np.ones(n, dtype=bool)
    adj = [[] for _ in range(n)]
    for i, j in E.tolist():
        adj[i].append(j)
        adj[j].append(i)
    stack = [v for v in range(n) if deg[v] < m and v not in keep]
    keep = set(keep)
    while stack:
        v = stack.pop()
        if not alive[v]:
            continue
        alive[v] = False
        for w in adj[v]:
            if alive[w]:
                deg[w] -= 1
                if deg[w] < m and w not in keep:
                    stack.append(w)
    return np.nonzero(alive)[0]


def graph_cnf(n, E, pins, forbid=(), k=4):
    """a k-colouring CNF of a finite graph: pins, forbidden (vertex, colour) literals, value precedence among unpinned colours"""
    x = lambda v, c: k * v + c + 1
    cls = [[x(v, c) for c in range(k)] for v in range(n)]
    extra = [[x(v, c)] for v, c in pins] + [[-x(v, c)] for v, c in forbid]
    free = [c for c in range(k) if c not in {c_ for _, c_ in pins}]
    nvars = k * n
    for f1, f2 in zip(free, free[1:]):
        base = nvars
        nvars += n + 1
        s = lambda v: base + v + 1
        extra.append([-s(0)])
        for v in range(n):
            extra.append([-x(v, f2), s(v)])
            extra.append([-s(v + 1), s(v), x(v, f1)])
    return (cls, E, extra), nvars


def run_cnf(parts, n, nvars, budget, solver='kissat', heavy=False, tag='g', proof=None):
    os.makedirs(SCRATCH, exist_ok=True)
    path = os.path.join(SCRATCH, f'{tag}-{os.getpid()}-{n}.cnf')
    sha, ncl = write_cnf(path, n, parts, nvars)
    rec = {'vertices': n, 'edges': int(len(parts[1])), 'clauses': ncl, 'cnf_sha256': sha, 'solver': solver, 'budget_s': budget,
           'machine': MACHINE, 'lock': bool(heavy)}
    with HeavyLock(heavy):
        t0, ru0 = time.time(), os.times()
        try:
            cmd = [solver, '-q', path] if proof is None else [solver, '-q', '--lrat=true', '--binary=false', path, proof]
            pr = subprocess.run(cmd, capture_output=True, text=True, timeout=budget)
            out = pr.stdout
            v = 'UNKNOWN'
            for line in out.splitlines():
                if line.startswith('s '):
                    v = 'UNSAT' if 'UNSATISFIABLE' in line else 'SAT'
        except subprocess.TimeoutExpired:
            out, v = '', 'UNKNOWN'
        ru1 = os.times()
    rec.update({'verdict': v, 'wall_s': round(time.time() - t0, 2),
                'cpu_s': round((ru1.children_user - ru0.children_user) + (ru1.children_system - ru0.children_system), 2)})
    if v == 'UNKNOWN':
        rec['unknown_type'] = f'budget: {budget} s wall, {solver}'
    os.remove(path)
    col = None
    if v == 'SAT':
        lits = []
        for line in out.splitlines():
            if line.startswith('v '):
                lits += [int(t) for t in line[2:].split()]
        pos = np.zeros(nvars + 1, dtype=bool)
        L = np.array(lits, dtype=np.int64)
        pos[L[L > 0]] = True
        X = pos[1:4 * n + 1].reshape(n, 4)
        col = np.argmax(X, axis=1).astype(np.int8)
        E = parts[1]
        assert X.any(axis=1).all() and not np.any(col[E[:, 0]] == col[E[:, 1]]), 'improper model'
    return rec, col


def forcing_ask(points, U, delta, budget=1500, solver='kissat', heavy=None, critical=True):
    """on the finite graph over `points`: (1) the plain control (must be SAT); (2) the forcing ask c(0) = 0, c(delta) = 1 (a common
    neighbour pinned 2 when one exists): UNSAT is a refusal, the pair forced in this graph; (3) for a refusal, the critical-set check
    (G39, M54-T1): the critical set lies in N(0) n N(delta), so it is empty when that is empty; otherwise each common neighbour w is
    tested by asking for a 3-colouring of G - w."""
    idx, E = ball_graph(points, U)
    n = len(points)
    o, dl = idx[tuple([0] * len(U[0]))], idx.get(tuple(delta))
    out = {'points': n, 'edges': int(len(E)), 'avg_degree': round(2 * len(E) / n, 2)}
    if dl is None:
        out['verdict'] = 'target outside the graph'
        return out
    heavy = True if heavy is None else heavy       # a ball ask is priced over ~2 minutes: always under the shared lock (the brief)
    adj0 = set(E[E[:, 0] == o, 1].tolist()) | set(E[E[:, 1] == o, 0].tolist())
    adjd = set(E[E[:, 0] == dl, 1].tolist()) | set(E[E[:, 1] == dl, 0].tolist())
    common = sorted(adj0 & adjd)
    nb = min(adj0)
    adjnb = set(E[E[:, 0] == nb, 1].tolist()) | set(E[E[:, 1] == nb, 0].tolist())
    tri = next((w for w in sorted(adj0 & adjnb)), None)
    ctl_pins = [(o, 0), (nb, 1)] + ([(tri, 2)] if tri is not None else [])
    parts, nv = graph_cnf(n, E, ctl_pins)
    out['control'], col = run_cnf(parts, n, nv, budget, solver, heavy, 'ctl')
    pins = [(o, 0), (dl, 1)] + ([(common[0], 2)] if common else [])
    parts, nv = graph_cnf(n, E, pins)
    out['forces'], _ = run_cnf(parts, n, nv, budget, solver, heavy, 'frc')
    out['common_neighbours'] = len(common)
    if out['forces']['verdict'] == 'UNSAT' and critical:
        crit = []
        for w in common:
            keep = [v for v in range(n) if v != w]
            remap = {v: i for i, v in enumerate(keep)}
            E2 = np.array([(remap[a], remap[b]) for a, b in E.tolist() if a != w and b != w], dtype=np.int64)
            parts3, nv3 = graph_cnf(n - 1, E2, [(remap[o], 0)], forbid=[(v, 3) for v in range(n - 1)])
            r3, _ = run_cnf(parts3, n - 1, nv3, budget, solver, heavy, 'crit')
            crit.append({'vertex': w, 'three_colourable_after_deletion': r3['verdict']})
        out['critical_set'] = ('empty: N(0) n N(delta) is empty (G39)' if not common else
                               'empty' if all(c['three_colourable_after_deletion'] == 'UNSAT' for c in crit) else 'NONEMPTY')
        out['critical_checks'] = crit
    out['verdict'] = ('refused (forced in this graph)' if out['forces']['verdict'] == 'UNSAT' and out['control']['verdict'] == 'SAT'
                      else 'VACUOUS: the control is not SAT' if out['forces']['verdict'] == 'UNSAT'
                      else 'separated in this graph' if out['forces']['verdict'] == 'SAT' else 'UNKNOWN')
    return out


# ================================================================ the census records

CENSUS = os.path.join(ROOT, 'data', 'fs73', 'census')
COLDIR = os.path.join(CENSUS, 'colourings')


class Rows:
    """an append-only jsonl of verdict rows, fsynced per row; a key present is never re-asked (the resume rule)"""
    def __init__(self, path):
        self.path = path
        self.rows = {}
        if os.path.exists(path):
            for line in open(path):
                if line.strip():
                    d = json.loads(line)
                    self.rows[d['key']] = d

    def get(self, key):
        return self.rows.get(key)

    def put(self, d):
        assert 'key' in d
        with open(self.path, 'a') as f:
            f.write(json.dumps(d, sort_keys=True) + '\n')
            f.flush()
            os.fsync(f.fileno())
        self.rows[d['key']] = d
        return d


def save_colouring(tag, lat_name, W, col):
    import gzip
    os.makedirs(COLDIR, exist_ok=True)
    s_ = ''.join(map(str, col.tolist()))
    sha = hashlib.sha256(s_.encode()).hexdigest()[:16]
    path = os.path.join(COLDIR, f'{tag}-{sha}.json.gz')
    if not os.path.exists(path):
        with gzip.open(path, 'wt') as f:
            json.dump({'lattice': lat_name, 'W': [list(w) for w in W], 'classes': len(col), 'colouring': s_,
                       'index': 'big-endian mixed radix of (x C) mod d, C and d the Smith form of W (tools/fs73_screen.py Quot)'}, f)
    return os.path.relpath(path, ROOT), sha


def load_colouring(rel):
    import gzip
    d = json.load(gzip.open(os.path.join(ROOT, rel), 'rt'))
    return d['W'], np.array([int(c) for c in d['colouring']], dtype=np.int8)


def lat_rows(H):
    return [list(map(int, h)) for h in H]


def analyse(U, W, col, r, rows, tag):
    """Per and KPer of one colouring, cached in the rows by the colouring's sha"""
    s_ = ''.join(map(str, col.tolist()))
    sha = hashlib.sha256(s_.encode()).hexdigest()[:16]
    key = f'analyse:{sha}'
    got = rows.get(key)
    if got:
        return got
    Q = Quot(W, r)
    pc = PColour(U, Q, col, tag)
    with HeavyLock(Q.n > 150000):
        t0 = time.time()
        Wp, nper = pc.per()
        pd = pc.descend(Wp) if len(Wp) and hnf(Wp, r) != hnf(W, r) else pc
        KP, st = pd.kper()
    return rows.put({'key': key, 'tag': tag, 'colouring_sha': sha, 'Per': lat_rows(Wp), 'Per_desc': describe(Wp, r)['Lambda_mod'],
                     'KPer': lat_rows(KP), 'KPer_desc': describe(KP, r)['Lambda_mod'], 'KPer_rank': len(KP),
                     'component_stats': st, 'seconds': round(time.time() - t0, 2), 'machine': MACHINE})


def ask(rows, key, Q, U, aim, target, budget, lat_name, tag):
    """one finder ask, recorded; a key present is reused (resume); SAT colourings are saved and re-verified on load"""
    got = rows.get(key)
    if got:
        col = load_colouring(got['colouring'])[1] if got.get('colouring') else None
        if col is not None:
            PColour(U, Q, col, key)                       # re-verify properness on load
        return got, col
    rec, col = solve(Q, U, aim, target, budget=budget)
    rec.update({'key': key, 'W': lat_rows(Q.W), 'target': list(map(int, target)) if target is not None else None})
    if col is not None:
        rec['colouring'], rec['colouring_sha'] = save_colouring(tag, lat_name, Q.W, col)
    return rows.put(rec), col


def p_N(rows, lat_name, U, r, N, seeds=(), budget=1500, run='seeded', W=None):
    """the H1 group at period W (default N Lambda), exactly: guess = common periods of the colourings found; each guess generator not
    yet confirmed is asked 'sep'; SAT shrinks the guess (asserted), UNSAT confirms.  Returns (P_N rows, colourings, status)"""
    W = NW(N, r) if W is None else W
    Q = Quot(W, r)
    cols = list(seeds)
    if not cols and run != 'cold':
        rec, col = ask(rows, f'{run}:N{N}:plain', Q, U, 'plain', None, budget, lat_name, f'{lat_name}-N{N}')
        if col is None:
            return None, [], rec['verdict']
        cols.append(col)
    # the cold control starts from NO colouring: the guess is all of Lambda, and every generator is asked
    G = hnf([tuple(1 if i == j else 0 for j in range(r)) for i in range(r)], r) if run == 'cold' else None
    for c in cols:
        Wc, _ = PColour(U, Q, c).per()
        G = Wc if G is None else intersect(G, Wc, r)
    conf = hnf(W, r)
    status = 'exact'
    while True:
        gens = [g for g in G if not member(conf, g)]
        if not gens:
            break
        g = gens[0]
        rec, col = ask(rows, f'{run}:N{N}:sep:{",".join(map(str, g))}', Q, U, 'sep', g, budget, lat_name, f'{lat_name}-N{N}')
        if rec['verdict'] == 'SAT':
            if planted('loop_stale'):
                col = cols[-1]                    # PLANT: the previous colouring re-used instead of the separating one
            cols.append(col)
            Wc, _ = PColour(U, Q, col).per()
            G = intersect(G, Wc, r)
            assert not member(G, g), 'a separating colouring failed to shrink the guess'
        elif rec['verdict'] == 'UNSAT':
            conf = hnf(list(conf) + [tuple(g)], r)
        else:
            status = f'upper bound: UNKNOWN at generator {g}'
            break
    return G, cols, status


def forced_span(lat, vectors):
    """F_known: the span of the orbits of the certified forced vectors under the named point group"""
    Gp, _ = FL.point_group(lat)
    orbit = set()
    for v in vectors:
        for A in Gp:
            orbit.add(tuple(sum(v[i] * A[i][j] for i in range(len(v))) for j in range(len(v))))
    return hnf(sorted(orbit), lat.rank), len(Gp), len(orbit)


def emb_length(lat, c):
    """the largest modulus of the point over the embeddings of F (the Minkowski radius a ball needs to hold it)"""
    v = lat.point(c)
    n = lat.F.n
    best = 0.0
    for sg in lat.F.signs:
        x = lat.F.emb(v[:n], sg) / lat.M
        y = lat.F.emb(v[n:], sg) / lat.M
        best = max(best, math.hypot(x, y))
    return best


def cmd_census_K(resume):
    lat, r, T = degrey_setup()
    U = lat.U
    os.makedirs(CENSUS, exist_ok=True)
    rows = Rows(os.path.join(CENSUS, 'K-rows.jsonl'))
    print(f"de Grey's K-lattice: rank {r}, |U| {len(U)}, M {lat.M}; targets (lattice coordinates) {T}", flush=True)
    allcols = []
    PN = {}
    for N in (2, 4, 6, 8, 10, 12):
        Qn, fs70col = fs70_degrey_colouring(lat, N)
        G, cols, status = p_N(rows, 'degrey', U, r, N, seeds=[fs70col])
        PN[N] = (G, status)
        allcols += [(N, c) for c in cols]
        print(f'N = {N:2d}: P_N {status}; {len(cols)} colourings; Lambda/P_N = {describe(G, r)["Lambda_mod"]}; '
              f'8/3 in P_N: {member(G, T["8/3"])}, 2: {member(G, T["2"])}, 4: {member(G, T["4"])}', flush=True)
    # control (c): the loop re-run cold (no colouring given, guess = Lambda) reproduces P_N
    cold = {}
    for N in (2, 4, 6, 8, 10, 12):
        Gc, colsc, stc = p_N(rows, 'degrey', U, r, N, run='cold')
        cold[N] = hnf(Gc, r) == hnf(PN[N][0], r)
        allcols += [(N, c) for c in colsc]
        print(f'  cold re-run at N = {N}: {"reproduces" if cold[N] else "DIFFERS FROM"} P_N ({len(colsc)} colourings, {stc})', flush=True)
    # KPer of every colouring found
    P_found = None
    ana = []
    seen = set()
    for N, c in allcols:
        sha = hashlib.sha256(''.join(map(str, c.tolist())).encode()).hexdigest()[:16]
        if sha in seen:
            continue
        seen.add(sha)
        a = analyse(U, NW(N, r), c, r, rows, f'degrey-N{N}')
        ana.append((N, a))
        P_found = a['KPer'] if P_found is None else intersect(P_found, a['KPer'], r)
    for N in PN:
        P_found = intersect(P_found, PN[N][0], r)
    Fk, gord, osz = forced_span(lat, [T['8/3']])
    sand = {'F_known': describe(Fk, r), 'P_found': describe(P_found, r), 'P_found_mod_F_known': quotient_structure(P_found, Fk, r),
            'point_group_order': gord, 'orbit_of_8over3': osz, 'colourings': len(ana),
            'P_N': {N: {'status': PN[N][1], **describe(PN[N][0], r)} for N in PN}, 'cold_rerun_reproduces': cold}
    assert all(member(P_found, f) for f in Fk), 'F_known is not inside P_found'
    neg = {}
    for t in ('2', '4'):
        sep = next(((N, a['tag'], a['colouring_sha'], 'Per' if not member(a['Per'], T[t]) else 'KPer') for N, a in ana
                    if not member(a['KPer'], T[t])), None)
        neg[t] = {'in_P_found': member(P_found, T[t]), 'separator': sep}
    sand['negative_controls'] = neg
    sand['kper_rank_min'] = min(a['KPer_rank'] for _, a in ana)
    rows.put({'key': f'sandwich:{len(rows.rows)}', **sand})
    json.dump(sand, open(os.path.join(CENSUS, 'K-sandwich.json'), 'w'), indent=1)
    print(json.dumps({k: sand[k] for k in ('F_known', 'P_found', 'P_found_mod_F_known', 'negative_controls')}, indent=1))
    return 0


PERIODS_K = (16, 14, 15, 20, 21, 22, 24, 25, 26, 28, 32, 33, 35)     # 16 first (the plan's 2-power period), then by class count


def census_state(lat, r, T, rows):
    """P_found and F_known recomputed from the rows (never stored alone): the intersection of KPer over every analysed colouring"""
    P = None
    n = 0
    for d in rows.rows.values():
        if d['key'].startswith('analyse:'):
            P = d['KPer'] if P is None else intersect(P, d['KPer'], r)
            n += 1
    Fk, _, _ = forced_span(lat, [T['8/3']])
    return (hnf(P, r) if P else None), Fk, n


def cmd_periods_K(resume, budget_core_s=8 * 3600, only=None, stop_rule=True):
    lat, r, T = degrey_setup()
    U = lat.U
    rows = Rows(os.path.join(CENSUS, 'K-rows.jsonl'))            # the colourings and analyses of P1d, shared
    prow = Rows(os.path.join(CENSUS, 'K-periods.jsonl'))          # one stabilisation row per period
    P0, Fk, na = census_state(lat, r, T, rows)
    print(f'start: P_found from {na} analysed colourings: Lambda/P_found = {describe(P0, r)["Lambda_mod"]}; '
          f'P_found/F_known = {quotient_structure(P0, Fk, r)}', flush=True)
    spent = sum(d.get('cpu_s', 0) + d.get('analyse_s', 0) for d in prow.rows.values())
    prev, unchanged = hnf(P0, r), 0
    for N in (only or PERIODS_K):
        key = f'period:N{N}'
        if prow.get(key):
            d = prow.get(key)
            P_now = hnf(d['P_found']['generators'], r)
            if d['colourable'] == 'SAT':
                unchanged = unchanged + 1 if P_now == prev else 0
            prev = P_now
            print(f'N = {N}: (resumed) {d["colourable"]}; Lambda/P_found = {d["P_found"]["Lambda_mod"]}', flush=True)
            continue
        if spent > budget_core_s:
            print(f'budget spent ({spent:.0f} s of {budget_core_s} s): stopping before N = {N}', flush=True)
            break
        if N >= 32:
            # the dry price: exact clause count at N, scaled by the largest measured bytes per clause of any earlier ask
            nres = len({tuple(x % N for x in u) for u in U})
            ncl = 4 * N ** r + 4 * (N ** r * nres // 2) + 3 * N ** r
            meas = [(d_['children_maxrss_gb'] * 1e9 / d_['clauses']) for d_ in rows.rows.values()
                    if d_.get('children_maxrss_gb') and d_.get('clauses', 0) > 1e6]
            bpc = max(meas) if meas else 200.0
            gb = ncl * bpc / 1e9
            print(f'N = {N}: dry price {ncl:,} clauses x {bpc:.0f} bytes/clause (largest measured) = {gb:.1f} GB', flush=True)
            if gb > 40:
                prow.put({'key': key, 'N': N, 'colourable': 'not asked', 'note': f'priced {gb:.1f} GB > 40 GB cap', 'clauses': ncl})
                continue
        Q = Quot(NW(N, r), r)
        if not Q.admissible(U):
            prow.put({'key': key, 'N': N, 'colourable': 'inadmissible', 'note': 'a unit vector lies in N Lambda'})
            print(f'N = {N}: inadmissible', flush=True)
            continue
        t0 = time.time()
        G, cols, status = p_N(rows, 'degrey', U, r, N, budget=1500)
        cpu = sum(rows.get(k_).get('cpu_s', 0) for k_ in rows.rows if k_.startswith(f'seeded:N{N}:'))
        if G is None:
            spent += cpu
            prow.put({'key': key, 'N': N, 'colourable': status, 'cpu_s': cpu, 'note': 'an UNSAT period counts as no step'})
            print(f'N = {N}: plain ask {status} ({cpu:.1f} s CPU) -- no step', flush=True)
            continue
        ta = time.time()
        kp_new = []
        for c in cols:
            a = analyse(U, NW(N, r), c, r, rows, f'degrey-N{N}')
            kp_new.append({'colouring_sha': a['colouring_sha'], 'Per': a['Per_desc'], 'KPer': a['KPer_desc'], 'KPer_rank': a['KPer_rank']})
        P_now, Fk, na = census_state(lat, r, T, rows)
        P_now = hnf(intersect(P_now, G, r), r)
        changed = P_now != prev
        unchanged = 0 if changed else unchanged + 1
        d = {'key': key, 'N': N, 'colourable': 'SAT', 'P_N_status': status, 'P_N': describe(G, r), 'colourings': len(cols),
             'KPer_new': kp_new, 'P_found': describe(P_now, r), 'P_found_mod_F_known': quotient_structure(P_now, Fk, r),
             'changed': changed, 'consecutive_colourable_unchanged': unchanged, 'cpu_s': cpu, 'analyse_s': round(time.time() - ta, 1),
             'wall_s': round(time.time() - t0, 1), 'targets_in_P_found': {t: member(P_now, T[t]) for t in T},
             'eight_ninths_in_P_found': member(P_now, FL.rational_point(lat, 8, 9)), 'machine': MACHINE}
        prow.put(d)
        spent += cpu + d['analyse_s']
        print(f'N = {N}: P_N {status}, Lambda/P_N = {d["P_N"]["Lambda_mod"]}; {len(cols)} colourings; Lambda/P_found = '
              f'{d["P_found"]["Lambda_mod"]} (rank {d["P_found"]["rank"]}); P_found/F_known = {d["P_found_mod_F_known"]}; '
              f'changed {changed}; 8/9 in P_found {d["eight_ninths_in_P_found"]}; {cpu:.0f} s solver CPU', flush=True)
        prev = P_now
        if d['P_found']['rank'] == len(Fk):
            print('OUTCOME (a): rank P_found fell to rank F_known', flush=True)
            break
        if unchanged >= 3 and not stop_rule:
            print('the plan\'s stop rule would declare OUTCOME (b) here; continuing past it (PO ruling: a plateau over periods whose '
                  '2-part is at most 4 measures the enumeration)', flush=True)
        if unchanged >= 3 and stop_rule:
            print('OUTCOME (b): P_found unchanged across three consecutive colourable periods, rank above F_known', flush=True)
            break
    return 0


def parse_target(lat, t):
    """'8/3' (a rational point) or 'c:a,b,c,d' (lattice coordinates)"""
    if t.startswith('c:'):
        return tuple(int(x) for x in t[2:].split(','))
    num, den = (t.split('/') + ['1'])[:2]
    return FL.rational_point(lat, int(num), int(den))


def cmd_force_K(targets, radii, budget=1500):
    """P1d step (4): forcing asks on Minkowski balls about the origin, the pair placed symmetrically (-h, h) when delta = 2h with h in
    Lambda (translation invariance), else (0, delta); the graph is the ball's 4-core (a vertex of degree < 4 other than the pair can
    always be coloured last, so deleting it changes no verdict); stop per target after 3 radii or 3 undecided asks"""
    lat, r, T = degrey_setup()
    U = lat.U
    rows = Rows(os.path.join(CENSUS, 'K-rows.jsonl'))
    for t in targets:
        delta = parse_target(lat, t)
        assert delta is not None, f'{t} is not in the lattice'
        assert len(delta) == r and any(delta), f'{t}: not a nonzero lattice vector of rank {r} (targets are separated by ";")'
        half = tuple(x // 2 for x in delta) if all(x % 2 == 0 for x in delta) else None
        undecided = 0
        for R in radii:
            key = f'force:{",".join(map(str, delta))}:R{R}'
            got = rows.get(key)
            if got is None:
                pts = minkowski_ball(lat, R)
                idx, E = ball_graph(pts, U)
                a, b = (tuple(-x for x in half), half) if half else (tuple([0] * r), delta)
                if a not in idx or b not in idx:
                    print(f'{t} R={R}: the pair is not in the ball', flush=True)
                    continue
                keep = core(len(pts), E, 4, keep=(idx[a], idx[b]))
                sub = [pts[i] for i in keep]
                shifted = [tuple(x - y for x, y in zip(p_, a)) for p_ in sub]        # the pair becomes (0, delta)
                fa = forcing_ask(shifted, U, delta, budget=budget)
                got = rows.put({'key': key, 'target': t, 'delta': list(delta), 'R': R, 'ball_points': len(pts),
                                'core4_points': len(sub), **fa})
            v = got['verdict']
            print(f'{t} R={R}: ball {got.get("ball_points")} -> 4-core {got.get("core4_points")} points, degree {got.get("avg_degree")}; '
                  f'control {got.get("control", {}).get("verdict")}; forces {got.get("forces", {}).get("verdict")} '
                  f'({got.get("forces", {}).get("cpu_s")} s CPU); {v}; critical set {got.get("critical_set")}', flush=True)
            if v.startswith('refused') or v.startswith('separated'):
                break
            undecided += 1
            if undecided >= 3:
                break
    return 0


def cmd_confirm_K(key, solver, budget):
    """re-ask one recorded forcing refusal with another solver: the graph and CNF rebuilt from the recipe, the CNF's sha256 asserted
    equal to the recorded one, the ask run under the lock"""
    lat, r, T = degrey_setup()
    U = lat.U
    rows = Rows(os.path.join(CENSUS, 'K-rows.jsonl'))
    d = rows.get(key)
    assert d and d['forces']['verdict'] == 'UNSAT', f'{key}: no recorded refusal'
    delta = tuple(d['delta'])
    half = tuple(x // 2 for x in delta) if all(x % 2 == 0 for x in delta) else None
    pts = minkowski_ball(lat, d['R'])
    idx, E = ball_graph(pts, U)
    a, b = (tuple(-x for x in half), half) if half else (tuple([0] * r), delta)
    keep = core(len(pts), E, 4, keep=(idx[a], idx[b]))
    shifted = [tuple(x - y for x, y in zip(pts[i], a)) for i in keep]
    idx2, E2 = ball_graph(shifted, U)
    n = len(shifted)
    o, dl = idx2[tuple([0] * r)], idx2[delta]
    parts, nv = graph_cnf(n, E2, [(o, 0), (dl, 1)])
    exe = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical') if solver == 'cadical' else solver
    proof = None
    if '--lrat' in sys.argv:
        pdir = os.path.join(CENSUS, 'proofs')
        os.makedirs(pdir, exist_ok=True)
        proof = os.path.join(pdir, key.replace(':', '_').replace(',', '_') + '.lrat')
    rec, _ = run_cnf(parts, n, nv, budget, exe, True, 'confirm', proof=proof)
    if proof:
        rec['lrat'] = os.path.relpath(proof, ROOT)
        rec['lrat_bytes'] = os.path.getsize(proof) if os.path.exists(proof) else None
    rec['solver'] = solver
    same = rec['cnf_sha256'] == d['forces']['cnf_sha256']
    out = rows.put({'key': f'confirm:{key}:{solver}', 'of': key, 'cnf_identical': same, **rec})
    print(f'{key}: {solver} -> {rec["verdict"]} ({rec["cpu_s"]} s CPU); CNF identical to the recorded one: {same}', flush=True)
    return 0 if (same and rec['verdict'] == 'UNSAT') else 1


# ================================================================ P1c: the two-instrument cross-check

def cmd_crosscheck():
    import fs70_periodic_kempe as PK
    lat, r, T = degrey_setup()
    U = lat.U
    cad = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical')
    rows = []
    for N in (8, 10, 12):
        Q = Quot(NW(N, r), r)
        rec1, col1 = solve(Q, U, 'gap', budget=1500)
        v2, secs2, model2, sha2, note2 = PK.find(U, N, r, 'gap', budget=1500, solver=cad)
        row = {'N': N, 'classes': Q.n, 'instrument_1': {'encoding': 'fs73 (clique pins + full precedence)', 'solver': 'kissat', **rec1},
               'instrument_1b': {'encoding': 'fs70_periodic_kempe.find (origin + least neighbour pins)', 'solver': 'cadical 2.1.2',
                                 'verdict': v2, 'wall_s': round(secs2, 2), 'cnf_sha256': sha2, 'note': note2}}
        print(f'N = {N:2d}: gap ask fs73/kissat {rec1["verdict"]} ({rec1["wall_s"]} s), fs70/cadical {v2} ({secs2:.2f} s)', flush=True)
        rows.append(row)
    pts = word_ball(U, 3)
    fa = forcing_ask(pts, U, T['8/3'], budget=1500)
    print(f"Harder's word ball (sums of <= 3 of the 54): {fa['points']} points, {fa['edges']} edges, degree {fa['avg_degree']}; "
          f"control {fa['control']['verdict']} ({fa['control']['wall_s']} s); forces 8/3 {fa['forces']['verdict']} "
          f"({fa['forces']['wall_s']} s wall, {fa['forces']['cpu_s']} s CPU); critical set {fa.get('critical_set')}", flush=True)
    agree = all(r_['instrument_1']['verdict'] == 'UNSAT' and r_['instrument_1b']['verdict'] == 'UNSAT' for r_ in rows) and \
        fa['forces']['verdict'] == 'UNSAT'
    out = {'what': 'P1c: gap finder (two encodings, two solvers) against Harder\'s forcing refusal, de Grey\'s lattice',
           'gap_rows': rows, 'harder': fa, 'agree': agree,
           'reading': 'agree: no gapped colouring at N = 8, 10, 12 and the pair forced (the expected, uninformative outcome)'
           if agree else 'DISAGREE: one instrument is defective; trace it'}
    json.dump(out, open(os.path.join(ROOT, 'data', 'fs73', 'census', 'P1c-crosscheck.json'), 'w'), indent=1)
    print('P-C1:', out['reading'])
    return 0 if agree else 1


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

    global COLDIR
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
                if nm == 'loop_stale':
                    # its own bed: the loop at N = 4 seeded with FS-70's colouring, rows in scratch; the plant must trip the shrink
                    # assertion, and the faithful loop on the same bed must return P_4 = 4 Lambda
                    PLANT = None
                    coldir_saved, COLDIR = COLDIR, os.path.join(SCRATCH, 'bed-colourings')     # the bed writes nothing committed
                    tmp = os.path.join(SCRATCH, f'loop-bed-{os.getpid()}.jsonl')
                    Q4, c4 = fs70_degrey_colouring(lat, 4)
                    G4, _, st4 = p_N(Rows(tmp), 'degrey-bed', U, r, 4, seeds=[c4])
                    faithful = hnf(G4, r) == hnf(NW(4, r), r)
                    os.remove(tmp)
                    PLANT = nm
                    try:
                        p_N(Rows(tmp), 'degrey-bed', U, r, 4, seeds=[c4])
                        raised = False
                    except AssertionError:
                        raised = True
                    if os.path.exists(tmp):
                        os.remove(tmp)
                    COLDIR = coldir_saved
                    moved = faithful and raised
                    why = f'faithful loop returns 4 Lambda: {faithful}; planted loop raised: {raised}'
                elif nm == 'prec_wrong':
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
    if argv[0] == 'census' and argv[1] == 'K':
        return cmd_census_K('--resume' in argv)
    if argv[0] == 'periods' and argv[1] == 'K':
        only = [int(x) for x in argv[argv.index('--only') + 1].split(',')] if '--only' in argv else None
        return cmd_periods_K('--resume' in argv, only=only, stop_rule='--past-plateau' not in argv)
    if argv[0] == 'force' and argv[1] == 'K':
        tg = argv[argv.index('--targets') + 1].split(';') if '--targets' in argv else ['8/9']
        rd = [float(x) for x in argv[argv.index('--radii') + 1].split(',')] if '--radii' in argv else [1.0, 1.25, 1.5]
        return cmd_force_K(tg, rd)
    if argv[0] == 'confirm' and argv[1] == 'K':
        return cmd_confirm_K(argv[argv.index('--key') + 1], argv[argv.index('--solver') + 1],
                             int(argv[argv.index('--budget') + 1]) if '--budget' in argv else 3000)
    if argv[0] == 'crosscheck':
        return cmd_crosscheck()
    if argv[0] == 'spectrum':
        cmd_spectrum(argv[1], int(argv[argv.index('--nmax') + 1]) if '--nmax' in argv else 12)
        return 0
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())
