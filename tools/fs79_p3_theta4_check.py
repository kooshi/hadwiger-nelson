#!/usr/bin/env python3
"""fs79_p3_theta4_check -- the standalone checker for FS-79 P3's enumeration of the cells of Θ_k on L21cc6506.

STANDARD LIBRARY ONLY.  Imports units_be, units_ac, hnf, coords_in from tools/fs79_p0_check.py (standard library only; the brief's named
enumeration) and nothing from the builder tools/fs79_p3_theta4.py.  Given the tree directory (header.json + one gzipped preorder node list per depth-1 subtree) and the cell file it re-derives:

  U      the 60 unit vectors, by both of fs79_p0_check's loops (they must agree); Λ = span U must have the L21cc6506 Hermite form.
  frame  the header's basis B must be a Z-basis of Λ (rows in Λ, |det| = 1 in Hermite coordinates); every half-set vector's
         coordinates C are recomputed and compared; the order must list every half-set vector exactly once (unless a plant).
  tree   every node: a Farkas node's y >= 0 bounds 0 = 0.x below by a positive number over its polytope ∩ [0,1]^4 (so it is empty);
         an internal node's yl, yu >= 0 certify a range [L, U] for the next vector, and its child list must equal every band meeting
         [L, U], each child present as a node; a leaf (full depth) carries a point satisfying every band and the box exactly.
         So the leaves' band vectors cover Θ_k ∩ [0,1]^4, and [0,1]^4 contains a fundamental domain of the translations.
  classes the leaves are grouped by translation class under THIS checker's own normal form (pivot rows chosen here, an echelon
         reduction written here); the cell file must hold exactly one record per class.
  cells  each record's points lie in its cell; they are affinely independent (so dim >= #points - 1); each equality direction d
         has multipliers yu, yl >= 0 with yu.A = d, yl.A = -d and yu.b = val = -yl.b (so d.x = val on the cell), the directions are
         independent (so dim <= 4 - #eqs), and #points - 1 = 4 - #eqs; a unit vector is recorded constant iff its coefficient vector
         lies in the span of the equality directions; the barycentre lies in the cell.
  summary the counts by dimension, the intersection of the constant sets, and W = ⋂ V^⊥ with its rank, recomputed from the checked
         records alone.

Usage: fs79_p3_theta4_check.py TREE_DIR CELLS.jsonl|- K [--only N] [--plant drop_node|children|const|dim]\nPrints CERTIFIED: ... or FAIL: <REASON>: ...  Exit 0 / 1.  --plant plants one fault; the matching refusal is required.
"""
import sys
import os
import json
import math
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs79_p0_check import units_be, units_ac, hnf, coords_in      # noqa: E402

M, D = 420, 167
KEY = [(1, 0, 0, 1), (0, 1, 1, 0), (0, 0, 2, 0), (0, 0, 0, 2)]


class Fail(Exception):
    def __init__(self, reason, msg=''):
        super().__init__(f'{reason}: {msg}')
        self.reason = reason


def lines_of(path):
    out = []
    with open(path) as f:
        for line in f:
            if line.strip():
                out.append(json.loads(line))
    return out


def det(A):
    A = [[Fr(v) for v in r] for r in A]
    n, dt = len(A), Fr(1)
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None:
            return Fr(0)
        if p != c:
            A[c], A[p] = A[p], A[c]
            dt = -dt
        dt *= A[c][c]
        for r in range(c + 1, n):
            f = A[r][c] / A[c][c]
            A[r] = [a - f * b for a, b in zip(A[r], A[c])]
    return dt


def rank(rows):
    R = [[Fr(v) for v in r] for r in rows]
    rk, ncol = 0, (len(R[0]) if R else 0)
    for c in range(ncol):
        p = next((i for i in range(rk, len(R)) if R[i][c] != 0), None)
        if p is None:
            continue
        R[rk], R[p] = R[p], R[rk]
        for i in range(len(R)):
            if i != rk and R[i][c] != 0:
                f = R[i][c] / R[rk][c]
                R[i] = [a - f * b for a, b in zip(R[i], R[rk])]
        rk += 1
    return rk


def dot(a, b):
    return sum(Fr(x) * Fr(y) for x, y in zip(a, b))


def rows_for(C, js, k, present):
    A, b = [], []
    for i in present:
        A.append([Fr(t) for t in C[i]]); b.append(js[i] + 1 - Fr(1, k))
        A.append([Fr(-t) for t in C[i]]); b.append(-(js[i] + Fr(1, k)))
    return A, b


def lower_box(A, b, c, y):
    """-y.b + min over [0,1]^4 of (c + yA).x ; valid lower bound for c.x on {Ax <= b} ∩ [0,1]^4 when y >= 0"""
    g = [Fr(t) for t in c]
    yb = Fr(0)
    for row, v in y.items():
        if v < 0:
            raise Fail('NEGATIVE_MULTIPLIER', str(v))
        g = [gi + v * a for gi, a in zip(g, A[row])]
        yb += v * b[row]
    return -yb + sum(min(Fr(0), gi) for gi in g)


def ydict(s):
    return {int(i): Fr(v) for i, v in s.items()}


def band_list(L, U, k):
    return [j for j in range(math.floor(L) - 2, math.ceil(U) + 2) if j + Fr(1, k) <= U and j + 1 - Fr(1, k) >= L]


def normal_form(js, C, present):
    """this checker's own class invariant for js + C.Z^4: pick the first four independent present rows P; reduce js_P modulo the
    lattice C_P Z^4 by an echelon basis computed here (column operations on C_P); translate js by the lambda used."""
    P = []
    for i in present:
        if rank([C[t] for t in P + [i]]) == len(P) + 1:
            P.append(i)
        if len(P) == 4:
            break
    CP = [list(C[i]) for i in P]                       # 4x4, rows indexed by P, columns by lambda's coordinates
    # column operations: CP * T = lower-triangular E with positive diagonal (T unimodular)
    E = [r[:] for r in CP]
    T = [[int(i == j) for j in range(4)] for i in range(4)]
    for r in range(4):
        while True:
            cols = [c for c in range(r, 4) if E[r][c] != 0]
            if len(cols) <= 1:
                break
            cols.sort(key=lambda c: abs(E[r][c]))
            p = cols[0]
            for c in cols[1:]:
                q = E[r][c] // E[r][p]
                for t in range(4):
                    E[t][c] -= q * E[t][p]
                    T[t][c] -= q * T[t][p]
        c = next(c for c in range(r, 4) if E[r][c] != 0)
        for t in range(4):
            E[t][r], E[t][c] = E[t][c], E[t][r]
            T[t][r], T[t][c] = T[t][c], T[t][r]
        if E[r][r] < 0:
            for t in range(4):
                E[t][r] = -E[t][r]
                T[t][r] = -T[t][r]
    v = [js[i] for i in P]
    mu = [0] * 4
    for r in range(4):                                 # choose mu_r so that (v - E mu)_r lies in [0, E_rr)
        cur = v[r] - sum(E[r][c] * mu[c] for c in range(r))
        mu[r] = cur // E[r][r]
    lam = [sum(T[i][c] * mu[c] for c in range(4)) for i in range(4)]
    return tuple(None if js[i] is None else js[i] - sum(C[i][t] * lam[t] for t in range(4)) for i in range(len(js)))


def frame_check(h, k_expect):
    if h.get('kind') != 'header' or h['k'] != k_expect:
        raise Fail('HEADER', 'not a header, or the wrong k')
    U1, U2 = units_be(M, D), units_ac(M, D)
    if U1 != U2 or len(U1) != 60:
        raise Fail('UNIT_ENUMERATION', f'{len(U1)} vs {len(U2)}')
    U = sorted(U1)
    Hl = hnf(U)
    if Hl != KEY:
        raise Fail('LATTICE', str(Hl))
    half = [u for u in U if u > tuple(-t for t in u)]
    if [tuple(u) for u in h['half']] != half:
        raise Fail('HALF_SET', 'the header half-set differs from the enumeration')
    B = [tuple(b) for b in h['basis']]
    CB = [coords_in(Hl, b) for b in B]
    if any(c is None for c in CB) or abs(det(CB)) != 1:
        raise Fail('BASIS', 'not a Z-basis of Lambda')
    C = [coords_in(B, u) for u in half]
    if C != h['C']:
        raise Fail('COORDINATES', 'recomputed coefficients differ')
    order, drop = h['order'], h['drop']
    present = [i for i in range(30) if i != drop]
    if sorted(order) != present:
        raise Fail('ORDER', 'the order does not list every present half-set vector once')
    return U, half, C, order, drop, present


def verify_node(n, p, C, order, k):
    """verifies one node at path p; returns ('leaf', x) | ('dead', None) | ('int', children)"""
    A, b = rows_for(C, {order[t]: p[t] for t in range(len(p))}, k, [order[t] for t in range(len(p))])
    if 'farkas' in n:
        if lower_box(A, b, [0, 0, 0, 0], ydict(n['farkas'])) <= 0:
            raise Fail('FARKAS', f'the Farkas vector at {p} does not refute')
        return ('dead', None)
    if 'pt' in n:
        if len(p) != len(order):
            raise Fail('TREE', f'a point before full depth at {p}')
        x = [Fr(t) for t in n['pt']]
        if not all(0 <= t <= 1 for t in x):
            raise Fail('LEAF', f'point outside the box at {p}')
        if any(dot(a, x) > bb for a, bb in zip(A, b)):
            raise Fail('LEAF', f'point outside its bands at {p}')
        return ('leaf', x)
    if len(p) >= len(order):
        raise Fail('TREE', f'internal node at full depth {p}')
    c = C[order[len(p)]]
    Lo = lower_box(A, b, c, ydict(n['yl']))
    Hi = -lower_box(A, b, [-t for t in c], ydict(n['yu']))
    if band_list(Lo, Hi, k) != n['ch']:
        raise Fail('CHILDREN', f'at {p}: bands {band_list(Lo, Hi, k)} vs recorded {n["ch"]}')
    return ('int' if n['ch'] else 'dead', n['ch'])


def verify_subtree(args):
    """one subtree file, in preorder; returns (leaves [(path, point)], node count, dead count) or ('FAIL', reason, msg)"""
    path, root, C, order, k, plant = args
    import gzip
    try:
        rec = json.load(gzip.open(path, 'rt'))
        if rec['root'] != list(root):
            raise Fail('TREE', f'{path}: root {rec["root"]} vs {root}')
        nodes = rec['nodes']
        if plant == 'drop_node':
            nodes = nodes[:-1]
        if plant == 'children':
            t = next(i for i, n in enumerate(nodes) if len(n.get('ch', [])) >= 2)
            nodes = nodes[:t] + [dict(nodes[t], ch=nodes[t]['ch'][:-1])] + nodes[t + 1:]
        idx, leaves, dead = 0, [], 0
        stack = [tuple(root)]
        while stack:
            p = stack.pop()
            if idx >= len(nodes):
                raise Fail('MISSING_NODE', f'{path}: the node list ends before {p}')
            kind, val = verify_node(nodes[idx], p, C, order, k)
            idx += 1
            if kind == 'leaf':
                leaves.append((p, val))
            elif kind == 'dead':
                dead += 1
            else:
                for j in reversed(val):
                    stack.append(p + (j,))
        if idx != len(nodes):
            raise Fail('TREE', f'{path}: {len(nodes) - idx} nodes past the end of the traversal')
        return leaves, len(nodes), dead
    except Fail as e:
        return ('FAIL', e.reason, str(e))


def check(tree_dir, cells_path, k_expect, plant=None, only=None, workers=28):
    h = json.load(open(os.path.join(tree_dir, 'header.json')))
    U, half, C, order, drop, present = frame_check(h, k_expect)
    k = h['k']
    kind, roots = verify_node(h['root'], (), C, order, k)
    roots = [(j,) for j in (roots or [])]
    if only is not None:
        roots = roots[:only]
    files = [os.path.join(tree_dir, 'sub_' + '_'.join(map(str, r)) + '.json.gz') for r in roots]
    missing = [f for f in files if not os.path.exists(f)]
    if missing:
        raise Fail('MISSING_SUBTREE', f'{len(missing)} subtree files absent, e.g. {missing[0]}')
    import multiprocessing as mp
    leaves, n_nodes, n_dead = [], 1, 0
    jobs = [(f, r, C, order, k, plant if i == 0 else None) for i, (f, r) in enumerate(zip(files, roots))]
    with mp.get_context('fork').Pool(workers) as pool:
        for res in pool.imap(verify_subtree, jobs, chunksize=1):
            if res[0] == 'FAIL':
                raise Fail(res[1], res[2])
            leaves += res[0]
            n_nodes += res[1]
            n_dead += res[2]
    # classes (this checker's own normal form)
    leaf_classes = {}
    for p, x in leaves:
        js = [None] * 30
        for t, i in enumerate(order):
            js[i] = p[t]
        nf = normal_form(js, C, present)
        leaf_classes[nf] = leaf_classes.get(nf, 0) + 1
    out = {'k': k, 'drop': drop, 'subtrees_checked': len(roots), 'nodes': n_nodes, 'dead_ends': n_dead,
           'leaves': len(leaves), 'classes': len(leaf_classes)}
    if cells_path is None:
        return out
    cells = lines_of(cells_path)
    if plant == 'const':
        c0 = next(c for c in cells if 0 < len(c['const_half']) < len(present))
        extra = next(i for i in present if i not in c0['const_half'])
        c0['const_half'] = sorted(c0['const_half'] + [extra])
    if plant == 'dim':
        c0 = next(c for c in cells if c['dim'] == 2)
        c0['dim'] = 3
    cell_classes = {}
    for c in cells:
        nf = normal_form(c['bands'], C, present)
        if nf in cell_classes:
            raise Fail('CLASSES', 'two cell records in one translation class')
        cell_classes[nf] = c
    if set(cell_classes) != set(leaf_classes):
        raise Fail('CLASSES', f'{len(cell_classes)} cell records vs {len(leaf_classes)} leaf classes')
    by_dim, inter, allV = {}, set(present), []
    for c in cells:
        js = c['bands']
        A, b = rows_for(C, js, k, present)
        pts = [[Fr(t) for t in q] for q in c['pts']]
        for q in pts + [[Fr(t) for t in c['bary']]]:
            if any(dot(a, q) > bb for a, bb in zip(A, b)):
                raise Fail('CELL_POINT', 'a recorded point is outside its cell')
        diffs = [[a - b_ for a, b_ in zip(q, pts[0])] for q in pts[1:]]
        if diffs and rank(diffs) != len(diffs):
            raise Fail('CELL_DIM', 'points not affinely independent')
        ds = []
        for e in c['eqs']:
            d_, val = [Fr(t) for t in e['d']], Fr(e['val'])
            for y, sgn, v in ((ydict(e['yu']), 1, val), (ydict(e['yl']), -1, -val)):
                if any(t < 0 for t in y.values()):
                    raise Fail('CELL_EQ', 'negative multiplier')
                yA = [sum(y.get(r, 0) * A[r][i] for r in range(len(A))) for i in range(4)]
                if yA != [sgn * t for t in d_] or sum(y.get(r, 0) * b[r] for r in range(len(A))) != v:
                    raise Fail('CELL_EQ', 'an equality certificate does not certify')
            ds.append(d_)
        if ds and rank(ds) != len(ds):
            raise Fail('CELL_EQ', 'dependent equality directions')
        dim = len(pts) - 1
        if dim != 4 - len(ds) or dim != c['dim']:
            raise Fail('CELL_DIM', f'points give >= {dim}, equalities give <= {4 - len(ds)}, record says {c["dim"]}')
        const = [i for i in present if ds and rank(ds + [C[i]]) == len(ds)]
        if sorted(const) != sorted(c['const_half']):
            raise Fail('CELL_CONST', 'the constant set differs from the recomputation')
        by_dim[dim] = by_dim.get(dim, 0) + 1
        inter &= set(const)
        allV += diffs
    rows = [v for v in allV if any(v)]
    out.update({'cells_by_dim': dict(sorted(by_dim.items())), 'const_intersection': [list(half[i]) for i in sorted(inter)],
                'W_dim': 4 - (rank(rows) if rows else 0)})
    return out


def main():
    args = sys.argv[1:]
    plant = None
    if '--plant' in args:
        i = args.index('--plant')
        plant = args[i + 1]
        del args[i:i + 2]
    only = None
    if '--only' in args:
        i = args.index('--only')
        only = int(args[i + 1])
        del args[i:i + 2]
    tree, cells, k = args[0], (args[1] if args[1] != '-' else None), int(args[2])
    try:
        out = check(tree, cells, k, plant, only)
    except Fail as e:
        print(f'FAIL: {e}')
        sys.exit(1)
    print('CERTIFIED:', json.dumps(out))


if __name__ == '__main__':
    main()
