#!/usr/bin/env python3
"""fs79_p3_theta4 -- FS-79 phase P3: every cell of Θ_k on L21cc6506 (= Λ₄₂₀ over ℚ(√167)), exactly.

    Θ_k = {θ ∈ Hom(Λ, ℝ) : θ(u) mod 1 ∈ [1/k, 1 − 1/k] for every u ∈ U}.

A CELL is a nonempty polytope {θ : j_u + 1/k ≤ θ(u) ≤ j_u + 1 − 1/k for all u} (bands j ∈ ℤ^U); distinct band vectors give disjoint
cells, since neighbouring bands are 2/k apart.  Cells are taken up to ℤ⁴ translation (θ ↦ θ + λ, λ ∈ Hom(Λ, ℤ)).

THE FRAME.  U is enumerated by tools/fs79_p0_check.py's units_be(420, 167) (read-only import).  We choose four unit vectors b_1..b_4
that are a ℤ-BASIS of Λ (a unimodular quadruple), and coordinates x_i = θ(b_i).  Then θ(u) = c_u · x with c_u ∈ ℤ⁴ the coordinates of
u in that basis, and a translation λ shifts x by λ.  Every cell class therefore has EXACTLY ONE representative with the bands of b_1..b_4
equal to 0, i.e. x ∈ [1/k, 1 − 1/k]^4: the tree below explores that box, so each class is one leaf and no deduplication is needed.

THE TREE (FS-73 T26's certificate shape, generalised to k).  The 26 other half-set vectors (one per ± pair) are fixed in a static order.
A node is a path of bands (j for order[0], j for order[1], …).  At a node the next vector c gets multipliers yl, yu ≥ 0 certifying a
range [L, U] for c·x over the node polytope ∩ box:
    L = −y·b + Σ_i min(g_i/k, g_i(1 − 1/k)),  g = c + yA        (any y ≥ 0 gives a valid lower bound)
and its children are every band j with [j + 1/k, j + 1 − 1/k] ∩ [L, U] ≠ ∅.  An infeasible node carries a Farkas vector y (the same
formula with c = 0 is > 0).  A node at full depth is a LEAF and carries an exact rational point satisfying all 60 constraints.
Floats (HiGHS) only PROPOSE multipliers; every bound is recomputed in Fractions; when a proposal does not certify, the node is redone by
the exact simplex of tools/fs73_theta_lib.py (read-only import).

THE CELLS.  For each leaf: its affine hull by exact LPs (affinely independent points p_0..p_d found by maximising and minimising along a
basis of the current orthogonal complement), with a two-sided dual certificate for every direction d of V^⊥ (d·x constant on the cell);
dimension d; constant unit vectors (u with c_u ∈ V^⊥, i.e. θ(u) constant on the cell); a rational relative-interior point (the
barycentre of p_0..p_d); the number of unit vectors sitting at a band edge there.

Usage:
  fs79_p3_theta4.py tree  K OUT.jsonl [--drop IDX] [--workers N]   build the tree (resumable: one fsynced line per finished subtree)
  fs79_p3_theta4.py cells TREE.jsonl OUT.jsonl                     the cell analysis (resumable: one fsynced line per cell)
  fs79_p3_theta4.py report TREE.jsonl CELLS.jsonl OUT.json         the bound on P, the controls (known points, symmetry)
"""
from __future__ import annotations

import argparse
import itertools
import json
import math
import os
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs79_p0_check import units_be, hnf, coords_in          # noqa: E402  (read-only; standard library only)
from fs73_theta_lib import exact_lp_max                      # noqa: E402  (read-only)

M, D = 420, 167
BOX_LO, BOX_HI = Fr(0), Fr(1)                               # the fundamental box for x = θ(b_i)
H_KEY = [(1, 0, 0, 1), (0, 1, 1, 0), (0, 0, 2, 0), (0, 0, 0, 2)]
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WIT = os.path.join(REPO, 'data/fs79/phase0/witnesses')


# ============================================================================================ the frame
def neg(u):
    return tuple(-t for t in u)


def det_int(A):
    A = [[Fr(v) for v in r] for r in A]
    n, det = len(A), Fr(1)
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None:
            return 0
        if p != c:
            A[c], A[p] = A[p], A[c]
            det = -det
        det *= A[c][c]
        for r in range(c + 1, n):
            f = A[r][c] / A[c][c]
            A[r] = [a - f * b for a, b in zip(A[r], A[c])]
    return int(det)


def frame():
    """U (60); the half-set (30); a reduced Z-basis B of Λ (FS-73's dual LLL); every half-set vector's coordinates C in B; and
    QD, four half-set indices with the least |det C_Q| (the pivot rows of the translation normal form, and the tree's first levels)."""
    from fs73_theta_cert import dual_reduce               # read-only import
    U = sorted(units_be(M, D))
    assert len(U) == 60, len(U)
    H = hnf(U)
    assert H == H_KEY, H                                   # Λ = span U is the L21cc6506 key
    half = [u for u in U if u > neg(u)]
    assert len(half) == 30
    CH = [coords_in(H, u) for u in half]                  # coordinates in the Hermite basis (integral: U ⊂ Λ)
    Wr = dual_reduce(CH, 4)                               # unimodular; new coordinates c' = Wr c
    assert abs(det_int(Wr)) == 1
    C = [[sum(w[i] * c[i] for i in range(4)) for w in Wr] for c in CH]
    # the basis B with coords_in(B, u) = C[u]:  u = sum_i CH_i h_i = sum_j C_j b_j  =>  B = Wr^{-T} H
    Wi = inverse(Wr)
    B = [tuple(int(sum(Wi[i][j] * H[i][t] for i in range(4))) for t in range(4)) for j in range(4)]
    assert all(coords_in(B, u) == C[n] for n, u in enumerate(half))
    best = None
    for Q in itertools.combinations(range(30), 4):
        dt = abs(det_int([C[q] for q in Q]))
        if dt:
            key = (dt, sum(sum(map(abs, C[q])) for q in Q), Q)
            best = key if best is None or key < best else best
    return U, half, B, C, list(best[2])


def inverse(A):
    n = len(A)
    Mx = [[Fr(v) for v in A[i]] + [Fr(int(i == j)) for j in range(n)] for i in range(n)]
    for c in range(n):
        p = next(r for r in range(c, n) if Mx[r][c] != 0)
        Mx[c], Mx[p] = Mx[p], Mx[c]
        inv = 1 / Mx[c][c]
        Mx[c] = [v * inv for v in Mx[c]]
        for r in range(n):
            if r != c and Mx[r][c] != 0:
                f = Mx[r][c]
                Mx[r] = [a_ - f * b_ for a_, b_ in zip(Mx[r], Mx[c])]
    return [row[n:] for row in Mx]


def translation_form(C, QD):
    """(C_Q^{-1}, the row HNF of C_Q^T): a band vector k's class mod C·Z^4 is canonicalised by reducing k_Q modulo the lattice
    C_Q Z^4 (upper-triangular basis rows) and translating the whole vector by the lambda that reduction used."""
    CQ = [C[q] for q in QD]
    HQ = hnf([list(col) for col in zip(*CQ)])             # rows: an upper-triangular Z-basis of the column lattice C_Q Z^4
    assert len(HQ) == 4
    return inverse(CQ), HQ


def canonical(js, C, QD, form):
    """the canonical representative of js + C·Z^4 (entries None, a dropped constraint, stay None), and the lambda used"""
    CQi, HQ = form
    v = [js[q] for q in QD]
    for i in range(4):
        q = v[i] // HQ[i][i]
        v = [a_ - q * b_ for a_, b_ in zip(v, HQ[i])]
    diff = [js[q] - v[i] for i, q in enumerate(QD)]      # = C_Q lam
    lam = [sum(CQi[i][j] * diff[j] for j in range(4)) for i in range(4)]
    assert all(t.denominator == 1 for t in lam)
    lam = [int(t) for t in lam]
    out = [None if j is None else j - sum(c[i] * lam[i] for i in range(4)) for j, c in zip(js, C)]
    return out, lam


def band_rows(cs, js, k):
    """rows A x <= b for j + 1/k <= c.x <= j + 1 - 1/k, two per (c, j): (c, j+1-1/k) then (-c, -(j+1/k))"""
    A, b = [], []
    for c, j in zip(cs, js):
        A.append([Fr(t) for t in c]); b.append(j + 1 - Fr(1, k))
        A.append([Fr(-t) for t in c]); b.append(-(j + Fr(1, k)))
    return A, b


def lower(A, b, c, y, k):
    """a lower bound for c.x over {A x <= b} ∩ [1/k, 1-1/k]^r, valid for every y >= 0 (y sparse: {row: value})"""
    r = len(c)
    g = [Fr(c[i]) for i in range(r)]
    yb = Fr(0)
    for row, v in y.items():
        for i in range(r):
            g[i] += v * A[row][i]
        yb += v * b[row]
    return -yb + sum(min(gi * BOX_LO, gi * BOX_HI) for gi in g)


def children(L, U, k):
    lo, hi = Fr(1, k), 1 - Fr(1, k)
    return [j for j in range(math.floor(L - hi) - 1, math.ceil(U - lo) + 2) if j + lo <= U and j + hi >= L]


# ============================================================================================ float proposals
def rat(v, den=10 ** 7):
    return Fr(v).limit_denominator(den)


def sparse(y):
    return {i: v for i, v in enumerate(y) if v != 0}


def float_min(A, b, c, k):
    import numpy as np
    from scipy.optimize import linprog
    r = len(c)
    bounds = [(0.0, 1.0)] * r
    if not A:
        return 'opt', []
    res = linprog([float(t) for t in c], A_ub=np.array([[float(t) for t in row] for row in A]),
                  b_ub=np.array([float(t) for t in b]), bounds=bounds, method='highs')
    if res.status == 2:
        return 'inf', None
    if res.status != 0:
        return 'err', None
    return 'opt', [max(0.0, -t) for t in res.ineqlin.marginals]


def float_farkas(A, b, k):
    """y >= 0, sum y = 1, maximising the box-formula bound with c = 0 (an LP in (y, t))"""
    import numpy as np
    from scipy.optimize import linprog
    m, r = len(A), len(A[0])
    lo, hi = 0.0, 1.0
    Af = np.array([[float(t) for t in row] for row in A]); bf = np.array([float(t) for t in b])
    # maximise -y.b + sum_i t_i, t_i <= lo*g_i, t_i <= hi*g_i, g = yA
    nv = m + r
    obj = np.r_[bf, -np.ones(r)]
    Aub = np.vstack([np.c_[-lo * Af.T, np.eye(r)], np.c_[-hi * Af.T, np.eye(r)]])
    res = linprog(obj, A_ub=Aub, b_ub=np.zeros(2 * r), A_eq=np.r_[np.ones(m), np.zeros(r)][None, :], b_eq=[1.0],
                  bounds=[(0, None)] * m + [(None, None)] * r, method='highs')
    if res.status != 0:
        return None
    return [max(0.0, t) for t in res.x[:m]]


def exact_node(A, b, c, k):
    """('inf', ray) or ('opt', yl, yu) exactly, with the box as explicit rows (box multipliers dropped, which only helps)"""
    r = len(c)
    lo, hi = BOX_LO, BOX_HI
    Ab = A + [[Fr(int(i == t)) for i in range(r)] for t in range(r)] + [[Fr(-int(i == t)) for i in range(r)] for t in range(r)]
    bb = b + [hi] * r + [-lo] * r
    m = len(A)
    st, x, y = exact_lp_max(Ab, bb, [-t for t in c])
    if st == 'infeasible':
        return ('inf', sparse(y[:m]))
    st2, x2, y2 = exact_lp_max(Ab, bb, list(c))
    return ('opt', sparse(y[:m]), sparse(y2[:m]))


def exact_point(A, b, k):
    """an exact point of {A x <= b} ∩ box, or a Farkas vector"""
    r = len(A[0])
    lo, hi = BOX_LO, BOX_HI
    Ab = A + [[Fr(int(i == t)) for i in range(r)] for t in range(r)] + [[Fr(-int(i == t)) for i in range(r)] for t in range(r)]
    bb = b + [hi] * r + [-lo] * r
    st, x, y = exact_lp_max(Ab, bb, [Fr(0)] * r)
    if st == 'infeasible':
        return ('inf', sparse(y[:len(A)]))
    return ('pt', x)


def s_y(y):
    return {str(i): str(v) for i, v in y.items()}


def certify_node(C, order, path, k, stats):
    """One node, exactly certified.  Returns (record, children or None)."""
    cs = [C[order[t]] for t in range(len(path))]
    A, b = band_rows(cs, path, k)
    if len(path) == len(order):                            # a leaf: an exact point, or a Farkas vector
        stats['leaf_lp'] += 1
        res = exact_point(A, b, k) if A else ('pt', [Fr(1, 2)] * 4)
        if res[0] == 'inf':
            assert lower(A, b, [0] * 4, res[1], k) > 0
            return {'p': path, 'farkas': s_y(res[1])}, None
        x = res[1]
        return {'p': path, 'pt': [str(t) for t in x]}, 'leaf'
    c = [Fr(t) for t in C[order[len(path)]]]
    st, yl = float_min(A, b, c, k)
    st2, yu = float_min(A, b, [-t for t in c], k) if st == 'opt' else (st, None)
    if st == 'opt' and st2 == 'opt':
        yl = sparse([rat(v) for v in yl]); yu = sparse([rat(v) for v in yu])
        L = lower(A, b, c, yl, k); U = -lower(A, b, [-t for t in c], yu, k)
        if L <= U + Fr(1, 10 ** 6):
            ch = children(L, U, k)
            return {'p': path, 'yl': s_y(yl), 'yu': s_y(yu), 'ch': ch}, ch
    if st == 'inf' or st2 == 'inf':
        ray = float_farkas(A, b, k)
        if ray is not None:
            ray = sparse([rat(v) for v in ray])
            if lower(A, b, [0] * 4, ray, k) > 0:
                return {'p': path, 'farkas': s_y(ray)}, None
    stats['exact'] += 1
    res = exact_node(A, b, c, k)
    if res[0] == 'inf':
        assert lower(A, b, [0] * 4, res[1], k) > 0
        return {'p': path, 'farkas': s_y(res[1])}, None
    _, yl, yu = res
    L = lower(A, b, c, yl, k); U = -lower(A, b, [-t for t in c], yu, k)
    ch = children(L, U, k)
    return {'p': path, 'yl': s_y(yl), 'yu': s_y(yu), 'ch': ch}, ch


def dfs(C, order, root, k, stats):
    """the subtree under `root` in PREORDER, children visited in the order of their parent's 'ch' list; records carry no path
    (the checker reconstructs every path from the order).  Returns (nodes, leaves as [path, point])."""
    nodes, leaves, stack = [], [], [list(root)]
    while stack:
        p = stack.pop()
        rec, ch = certify_node(C, order, p, k, stats)
        del rec['p']
        nodes.append(rec)
        stats['nodes'] += 1
        if ch == 'leaf':
            stats['leaves'] += 1
            leaves.append([p, rec['pt']])
        elif ch:
            for j in reversed(ch):
                stack.append(p + [j])
    return nodes, leaves


def layers(half):
    """the five layers b·U_R (b in {1, v, v̄, z, z̄}) as lists of half-set indices, identified by complex arithmetic"""
    import cmath  # noqa: F401
    s = math.sqrt(D)
    zf = lambda u: complex(u[0] + u[1] * s, u[2] + u[3] * s) / M
    UR = [complex(1, 0), complex(0, 1), complex(.6, .8), complex(.8, .6), complex(.6, -.8), complex(.8, -.6)]
    UR += [-x for x in UR]
    v = complex(83, s) / 84
    z = (1 + 1j) * complex(15, -s) / 28
    B5 = {'1': 1, 'v': v, 'vb': v.conjugate(), 'z': z, 'zb': z.conjugate()}
    out = {n: [] for n in B5}
    for i, u in enumerate(half):
        hits = [n for n, b in B5.items() if any(abs(zf(u) - b * x) < 1e-9 for x in UR)]
        assert len(hits) == 1
        out[hits[0]].append(i)
    assert all(len(t) == 6 for t in out.values())
    return out


def write_atomic_gz(path, obj):
    import gzip
    tmp = path + '.tmp'
    with gzip.open(tmp, 'wt') as f:
        json.dump(obj, f, separators=(',', ':'))
    with open(tmp, 'rb') as f:
        os.fsync(f.fileno())
    os.replace(tmp, path)
    dfd = os.open(os.path.dirname(path), os.O_RDONLY)
    os.fsync(dfd)
    os.close(dfd)


def _subtree(args):
    C, order, root, k, outdir = args
    stats = {'nodes': 0, 'leaves': 0, 'exact': 0, 'leaf_lp': 0}
    t0 = time.time()
    nodes, leaves = dfs(C, order, root, k, stats)
    rec = {'root': root, 'nodes': nodes, 'leaves': leaves, 'stats': stats, 'seconds': round(time.time() - t0, 2)}
    write_atomic_gz(os.path.join(outdir, 'sub_' + '_'.join(str(j) for j in root) + '.json.gz'), rec)
    return root, stats, rec['seconds']


def cmd_tree(a):
    k = a.K
    U, half, B, C, QD = frame()
    Ly = layers(half)
    l1 = lambda i: (sum(map(abs, C[i])), i)
    order = []
    for n in ('1', 'v', 'vb', 'z', 'zb'):                  # the pair (1, v) has the least joint determinant (1,764 periods)
        order += sorted(Ly[n], key=l1)
    assert order[0] == 0 and sorted(order) == list(range(30))
    if a.drop is not None:                                 # the planted fault: one ± pair's constraint dropped
        assert a.drop != order[0]
        order = [i for i in order if i != a.drop]
    header = {'kind': 'header', 'k': k, 'M': M, 'd': D, 'QD': QD, 'basis': [list(t) for t in B], 'layers': Ly,
              'half': [list(u) for u in half], 'C': C, 'order': order, 'drop': a.drop, 'box': [str(BOX_LO), str(BOX_HI)]}
    os.makedirs(a.OUT, exist_ok=True)
    hp = os.path.join(a.OUT, 'header.json')
    if os.path.exists(hp):
        h = json.load(open(hp))
        for key in ('k', 'basis', 'order', 'drop', 'C'):
            assert h[key] == header[key], f'resume: header field {key} differs'
    else:
        stats = {'nodes': 0, 'leaves': 0, 'exact': 0, 'leaf_lp': 0}
        rec, ch = certify_node(C, order, [], k, stats)
        header['root'] = rec
        with open(hp + '.tmp', 'w') as f:
            json.dump(header, f)
            f.flush()
            os.fsync(f.fileno())
        os.replace(hp + '.tmp', hp)
        h = header
    roots = [[j] for j in h['root']['ch']]
    if a.only is not None:                                 # a sample of subtrees (the plant's control run)
        roots = roots[:a.only]
    todo = [r for r in roots if not os.path.exists(os.path.join(a.OUT, 'sub_' + '_'.join(map(str, r)) + '.json.gz'))]
    print(f'{len(roots)} subtrees, {len(roots) - len(todo)} done, {len(todo)} to go', flush=True)
    t0, tot, n_done = time.time(), {'nodes': 0, 'leaves': 0, 'exact': 0}, 0
    import multiprocessing as mp
    with mp.get_context('fork').Pool(a.workers) as pool:
        for root, st, sec in pool.imap_unordered(_subtree, [(C, order, r, k, a.OUT) for r in todo]):
            n_done += 1
            for key in tot:
                tot[key] += st[key]
            if n_done % 10 == 0 or n_done == len(todo):
                print(f'{n_done}/{len(todo)} subtrees; +{tot["nodes"]} nodes, +{tot["leaves"]} leaves, +{tot["exact"]} exact; '
                      f'{round(time.time() - t0, 1)} s', flush=True)
            if time.time() - t0 > 2 * 3600:
                print('STOP RULE: the tree ran past 2 hours', flush=True)
                pool.terminate()
                break
    print('DONE tree', flush=True)


def append_line(path, rec):
    with open(path, 'a') as f:
        f.write(json.dumps(rec, separators=(',', ':')) + '\n')
        f.flush()
        os.fsync(f.fileno())


def read_lines(path):
    """every complete JSON line; a torn last line (a kill mid-write) is dropped and the file truncated to the good prefix"""
    good, out = 0, []
    with open(path, 'rb') as f:
        data = f.read()
    for line in data.split(b'\n'):
        if not line:
            good += 1
            continue
        try:
            out.append(json.loads(line))
        except json.JSONDecodeError:
            break
        good += len(line) + 1
    if good < len(data):
        with open(path, 'r+b') as f:
            f.truncate(min(good, len(data)))
    return out


def tree_leaves(outdir):
    import gzip
    h = json.load(open(os.path.join(outdir, 'header.json')))
    leaves, nodes = [], 1
    for fn in sorted(os.listdir(outdir)):
        if fn.startswith('sub_') and fn.endswith('.json.gz'):
            rec = json.load(gzip.open(os.path.join(outdir, fn), 'rt'))
            nodes += len(rec['nodes'])
            leaves += [{'p': p, 'pt': pt} for p, pt in rec['leaves']]
    return h, leaves, nodes, None


# ============================================================================================ the cells
def nullspace(rows, n=4):
    """a basis (integer vectors) of {x : r.x = 0 for every row}"""
    R = [[Fr(t) for t in r] for r in rows if any(r)]
    piv, rk = [], 0
    for col in range(n):
        p = next((i for i in range(rk, len(R)) if R[i][col] != 0), None)
        if p is None:
            continue
        R[rk], R[p] = R[p], R[rk]
        inv = 1 / R[rk][col]
        R[rk] = [v * inv for v in R[rk]]
        for i in range(len(R)):
            if i != rk and R[i][col] != 0:
                f = R[i][col]
                R[i] = [a_ - f * b_ for a_, b_ in zip(R[i], R[rk])]
        piv.append(col)
        rk += 1
    out = []
    for fcol in (c for c in range(n) if c not in piv):
        v = [Fr(0)] * n
        v[fcol] = Fr(1)
        for i, pc in enumerate(piv):
            v[pc] = -R[i][fcol]
        den = math.lcm(*[t.denominator for t in v])
        v = [int(t * den) for t in v]
        g = math.gcd(*v)
        out.append([t // g for t in v])
    return out


def dot(a, b):
    return sum(Fr(x) * Fr(y) for x, y in zip(a, b))


def cell_analysis(C30, js, k, p0):
    """affine hull, constant set, barycentre and certificates of the cell with bands js (all 30 half-set vectors)"""
    A, b = band_rows(C30, js, k)
    pts, V = [list(p0)], []
    while True:
        perp = nullspace(V)
        grew, eqs = False, []
        for d in perp:
            st, xmax, ymax = exact_lp_max(A, b, d)
            st2, xmin, ymin = exact_lp_max(A, b, [-t for t in d])
            assert st == 'optimal' and st2 == 'optimal'
            vmax, vmin = dot(d, xmax), dot(d, xmin)
            if vmax > vmin:
                x = xmax if dot(d, xmax) != dot(d, p0) else xmin
                V.append([xi - pi for xi, pi in zip(x, p0)])
                pts.append(list(x))
                grew = True
                break
            eqs.append({'d': d, 'val': str(vmax), 'yu': s_y(sparse(ymax)), 'yl': s_y(sparse(ymin))})
        if not grew:
            break
    dim = len(V)
    bary = [sum(p[i] for p in pts) / len(pts) for i in range(4)]
    const = [i for i in range(len(C30)) if all(dot(C30[i], v) == 0 for v in V)]
    edge = []
    for i in range(len(C30)):
        t = dot(C30[i], bary)
        assert js[i] + Fr(1, k) <= t <= js[i] + 1 - Fr(1, k), 'barycentre outside the cell'
        if t in (js[i] + Fr(1, k), js[i] + 1 - Fr(1, k)):
            edge.append(i)
    order_ = math.lcm(*[t.denominator for t in bary])
    return {'bands': js, 'dim': dim, 'pts': [[str(t) for t in p] for p in pts], 'eqs': eqs, 'const_half': const,
            'n_const': 2 * len(const), 'edge_half': edge, 'n_edge': 2 * len(edge), 'bary': [str(t) for t in bary],
            'bary_order': order_}


def full_bands(order, path, drop=None):
    """the band of every half-set vector at a leaf (the dropped vector, if any: None)"""
    js = [None] * 30
    for t, i in enumerate(order):
        js[i] = path[t]
    assert all((j is None) == (i == drop) for i, j in enumerate(js))
    return js


def _cell_job(args):
    C, js, k, p0 = args
    t0 = time.time()
    rec = cell_analysis(C, js, k, [Fr(t) for t in p0])
    rec['seconds'] = round(time.time() - t0, 3)
    return rec


def classes(h, leaves, C, QD):
    """the leaves grouped by translation class: {canonical band vector: (leaf band vector, its point translated to the class rep)}"""
    form = translation_form(C, QD)
    out, mult = {}, {}
    for lf in leaves:
        js = full_bands(h['order'], lf['p'], h['drop'])
        can, lam = canonical(js, C, QD, form)
        key = tuple(can)
        mult[key] = mult.get(key, 0) + 1
        if key not in out:
            out[key] = [str(Fr(t) - l) for t, l in zip(lf['pt'], lam)]
    return out, mult


def cmd_cells(a):
    h, leaves, nodes, _ = tree_leaves(a.TREE)
    k = h['k']
    U, half, B, C, QD = frame()
    assert h['basis'] == [list(t) for t in B] and h['QD'] == QD
    cls, mult = classes(h, leaves, C, QD)
    done = set()
    if os.path.exists(a.OUT):
        done = {tuple(r['bands']) for r in read_lines(a.OUT)}
    keep = [i for i in range(30) if i != h['drop']]
    jobs = [(key, pt) for key, pt in cls.items() if key not in done]
    print(f'{len(leaves)} leaves, {len(cls)} translation classes, {len(done)} done, {len(jobs)} to go', flush=True)
    import multiprocessing as mp
    t0 = time.time()
    with mp.get_context('fork').Pool(a.workers) as pool:
        args = [([C[i] for i in keep], [key[i] for i in keep], k, pt) for key, pt in jobs]
        for n_, rec in enumerate(pool.imap_unordered(_cell_job, args), 1):
            full = [None] * 30                            # re-expand to the 30 half-set indices
            for t, i in enumerate(keep):
                full[i] = rec['bands'][t]
            rec['bands'] = full
            rec['const_half'] = [keep[t] for t in rec['const_half']]
            rec['edge_half'] = [keep[t] for t in rec['edge_half']]
            rec['leaves'] = mult[tuple(full)]
            append_line(a.OUT, rec)
            if n_ % 200 == 0 or n_ == len(jobs):
                print(f'{n_}/{len(jobs)} cells; {round(time.time() - t0, 1)} s', flush=True)
    print('DONE cells', flush=True)


# ============================================================================================ the report
def int_kernel(rows, n=4):
    """a Z-basis of {x in Z^n : r.x = 0 for every (integer) row}: column operations on [rows; I]"""
    rows = [list(r) for r in rows if any(r)]
    m = len(rows)
    Mx = [r[:] for r in rows] + [[int(i == j) for j in range(n)] for i in range(n)]   # (m+n) x n, columns are vectors
    cols = [[Mx[i][j] for i in range(m + n)] for j in range(n)]
    piv_row = 0
    active = list(range(n))
    fixed = []
    for rrow in range(m):
        cand = [c for c in active if cols[c][rrow] != 0]
        while len(cand) > 1:
            cand.sort(key=lambda c: abs(cols[c][rrow]))
            p = cand[0]
            for c in cand[1:]:
                q = cols[c][rrow] // cols[p][rrow]
                cols[c] = [x - q * y for x, y in zip(cols[c], cols[p])]
            cand = [c for c in active if cols[c][rrow] != 0]
        if cand:
            active.remove(cand[0])
            fixed.append(cand[0])
    return [cols[c][m:] for c in active]


def lattice_index_bound(Wb, funcs):
    """K = {n in Z^w : q.n in Z for q in funcs} (q rational, in the basis Wb); returns (index [Z^w : K], a basis of K)"""
    w = len(Wb)
    if w == 0:
        return 1, []
    Dn = math.lcm(1, *[t.denominator for q in funcs for t in q])
    gens = [[Dn * int(i == j) for j in range(w)] for i in range(w)] + [[int(t * Dn) for t in q] for q in funcs]
    Hs = hnf(gens, n=w)                                   # D·L*, L* = Z^w + span(q): an integer lattice of rank w
    detH = abs(det_int(Hs))
    index = Dn ** w // detH                              # [L* : Z^w] = D^w / det(D L*)... = index of K in Z^w (duality)
    return index, Hs


def class_of(x, C, QD, form, drop=None):
    """the canonical band vector of the cell containing the point x (x in Θ_k: every c.x lies in a band, checked by the caller)"""
    js = [None if i == drop else math.floor(dot(c, x)) for i, c in enumerate(C)]
    return tuple(canonical(js, C, QD, form)[0])


def in_theta(x, C, k, drop=None):
    return all(i == drop or Fr(1, k) <= dot(c, x) - math.floor(dot(c, x)) <= 1 - Fr(1, k) for i, c in enumerate(C))


def cmd_report(a):
    h, leaves, nnodes, lines = tree_leaves(a.TREE)
    k = h['k']
    U, half, B, C, QD = frame()
    form = translation_form(C, QD)
    cls, mult = classes(h, leaves, C, QD)
    cells = read_lines(a.CELLS)
    keyset = {tuple(c['bands']): c for c in cells}
    assert set(keyset) == set(cls), 'the cell file and the tree disagree on the classes'
    drop = h['drop']
    by_dim = {}
    for c in cells:
        by_dim[c['dim']] = by_dim.get(c['dim'], 0) + 1
    out = {'k': k, 'drop': drop, 'tree_nodes': nnodes, 'leaves': len(leaves), 'cells': len(cells),
           'cells_by_dim': dict(sorted(by_dim.items())), 'basis': [list(t) for t in B]}
    # the intersection of the constant sets, and W = the intersection of the V^perp
    inter = set(range(30))
    allV = []
    for c in cells:
        inter &= set(c['const_half'])
        p0 = [Fr(t) for t in c['pts'][0]]
        for p in c['pts'][1:]:
            allV.append([Fr(t) - s for t, s in zip(p, p0)])
    inter = sorted(inter)
    Vint = []
    for v in allV:
        den = math.lcm(*[t.denominator for t in v])
        Vint.append([int(t * den) for t in v])
    W = int_kernel(Vint)                                  # Λ ∩ W, a saturated Z-basis in the unit-vector basis B
    rank_inter = 0 if not inter else len([r for r in hnf([C[i] for i in inter])])
    rational = [i for i in range(30) if half[i][1] == 0 and half[i][3] == 0]
    Wrat = int_kernel(nullspace([C[i] for i in rational]))  # the saturated rational layer
    out['const_intersection_half'] = [list(half[i]) for i in inter]
    out['const_intersection_count'] = 2 * len(inter)
    out['const_intersection_rank'] = rank_inter
    out['W_rank'] = len(W)
    out['W_basis'] = W
    out['rational_half'] = [list(half[i]) for i in rational]
    out['W_equals_rational_plane'] = bool(W) and hnf(W) == hnf(Wrat)
    if W:
        funcs = []
        for c in cells:
            x = [Fr(t) for t in c['bary']]
            funcs.append([dot(x, w_) for w_ in W])        # θ_c restricted to Λ ∩ W (constant on the cell when dim ≥ 1)
        idx, _ = lattice_index_bound(W, funcs)
        out['P_circ_index_in_Lambda_cap_W'] = idx
    # control 1: the known points
    known = {}
    for name in ('L21cc6506-linear.json', 'L21cc6506-linear-probe.json'):
        w = json.load(open(os.path.join(WIT, name)))
        Bp = [tuple(t) for t in w['basis']]
        th = [Fr(t) for t in w['theta_on_basis']]
        x = [dot(coords_in(Bp, b_), th) for b_ in B]
        order_ = math.lcm(*[t.denominator for t in th])
        inb = in_theta(x, C, k, drop)
        cell = keyset.get(class_of(x, C, QD, form, drop)) if inb else None
        known[name] = {'order': order_, 'in_band': inb, 'found': cell is not None,
                       'dim': cell and cell['dim'], 'n_const': cell and cell['n_const'],
                       'const_is_rational_layer': cell and sorted(cell['const_half']) == sorted(rational)}
    out['known_points'] = known
    # control 4: the automorphisms (i, conjugation, Galois) map the cell set to itself
    maps = {'i': lambda u: (-u[2], -u[3], u[0], u[1]), 'conj': lambda u: (u[0], u[1], -u[2], -u[3]),
            'galois': lambda u: (u[0], -u[1], u[2], -u[3])}
    Uset = set(U)
    sym = {}
    for name, g in maps.items():
        assert {g(u) for u in U} == Uset, f'{name} does not permute U'
        G = [coords_in(B, g(b_)) for b_ in B]              # row i: coordinates of g(b_i); (θ∘g)(b_i) = G[i]·x
        assert all(r is not None for r in G)
        miss = 0
        for c in cells:
            x = [Fr(t) for t in c['bary']]
            y = [dot(G[i], x) for i in range(4)]
            if drop is not None:
                continue                                   # the plant breaks the symmetry by design
            if not in_theta(y, C, k) or class_of(y, C, QD, form) not in keyset:
                miss += 1
        sym[name] = {'images_missing': miss}
    out['symmetry'] = sym
    with open(a.OUT, 'w') as f:
        json.dump(out, f, indent=1, default=str)
    print(json.dumps({kk: v for kk, v in out.items() if kk not in ('W_basis', 'basis', 'rational_half')}, indent=1, default=str))


def main():
    ap = argparse.ArgumentParser()
    sp = ap.add_subparsers(dest='cmd', required=True)
    t = sp.add_parser('tree'); t.add_argument('K', type=int); t.add_argument('OUT')
    t.add_argument('--drop', type=int, default=None); t.add_argument('--workers', type=int, default=16)
    t.add_argument('--only', type=int, default=None)
    c = sp.add_parser('cells'); c.add_argument('TREE'); c.add_argument('OUT'); c.add_argument('--workers', type=int, default=16)
    r = sp.add_parser('report'); r.add_argument('TREE'); r.add_argument('CELLS'); r.add_argument('OUT')
    a = ap.parse_args()
    {'tree': cmd_tree, 'cells': cmd_cells, 'report': cmd_report}[a.cmd](a)


if __name__ == '__main__':
    main()
