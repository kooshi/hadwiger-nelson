#!/usr/bin/env python3
"""FS129-MA1-NOAFF5's control: the affine hull of the proper colourings of one small graph, exactly.

H = the Moser spindle without its tip edge (two unit rhombi a,b,c,t and a,b',c',t' sharing the apex a; FS129-OA1-NOLIN5's model).
For k colours, each proper k-colouring C of H gives the 0/1 indicator vector x_C in R^(|V| k) (x_C[v, i] = 1 iff C(v) = i), an
affine image of the simplex embedding f_C.  The colourings satisfy |V| identities sum_i x[v, i] = 1, so their affine hull has
dimension at most |V| (k - 1).  FS129-MA1-NOAFF5 says that at k = 5 (where H maps into the slack plane at 11, over Q(sqrt 3)) no other
affine identity holds: the dimension is exactly |V| (k - 1) = 28.  At k = 3 the two tips are forced equal, so it must be smaller.

Exact: every proper colouring of a 7-vertex graph is enumerated (5^7 = 78,125 assignments) and the rank is computed over the
rationals by fraction-free Gaussian elimination.  It searches for nothing.

Usage:  python3 tools/fs129_ma1_noaff.py        -> prints "k=5: dim 28 of 28" ; exit 0
        python3 tools/fs129_ma1_noaff.py --fault  -> the same at k = 3 (the tips forced): the dimension falls short
"""
import itertools
import sys

V = ["a", "b", "c", "t", "b2", "c2", "t2"]
E = [("a", "b"), ("a", "c"), ("b", "c"), ("b", "t"), ("c", "t"),
     ("a", "b2"), ("a", "c2"), ("b2", "c2"), ("b2", "t2"), ("c2", "t2")]
K = 3 if "--fault" in sys.argv else 5
idx = {v: i for i, v in enumerate(V)}


def colourings(k):
    for col in itertools.product(range(k), repeat=len(V)):
        if all(col[idx[u]] != col[idx[w]] for u, w in E):
            yield col


def rank(rows):
    rows = [r[:] for r in rows]
    r = 0
    ncols = len(rows[0]) if rows else 0
    for c in range(ncols):
        piv = next((i for i in range(r, len(rows)) if rows[i][c] != 0), None)
        if piv is None:
            continue
        rows[r], rows[piv] = rows[piv], rows[r]
        for i in range(len(rows)):
            if i != r and rows[i][c] != 0:
                f, g = rows[i][c], rows[r][c]
                rows[i] = [x * g - y * f for x, y in zip(rows[i], rows[r])]
        r += 1
    return r


vecs = []
for col in colourings(K):
    x = [0] * (len(V) * K)
    for v in V:
        x[idx[v] * K + col[idx[v]]] = 1
    vecs.append(x)
base = vecs[0]
diffs = [[a - b for a, b in zip(x, base)] for x in vecs[1:]]
# the difference vectors span the direction space of the affine hull; rank them in batches to keep the elimination small
basis = []
for d in diffs:
    trial = basis + [d]
    if rank(trial) > len(basis):
        basis.append(d)
dim = len(basis)
print(f"proper {K}-colourings: {len(vecs)}")
print(f"k={K}: dim {dim} of {len(V) * (K - 1)}")
