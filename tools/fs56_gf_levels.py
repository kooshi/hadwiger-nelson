#!/usr/bin/env python3
"""fs56_gf_levels -- the level-k programme on a small point set by full enumeration of its independent sets (float LP, HiGHS):
how much of chi_gf comes from congruences of pairs, of triples, of all sizes.  A READING, not a certificate.

  .venv/bin/python tools/fs56_gf_levels.py CERT.json K [K ...]      (the certificate supplies H; its weights are ignored)
"""
import itertools
import json
import sys
from pathlib import Path

import numpy as np
from scipy.optimize import linprog
from scipy.sparse import coo_matrix

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fs56_gf_check as C  # noqa: E402

cert = json.loads(Path(sys.argv[1]).read_text())
F = C.Field(cert["field"]["radicands"])
P = C.Plane(F, cert["denominator"], [(tuple(x), tuple(y)) for x, y in cert["points"]])
n = len(P.pts)
sets = []
stack = [(0, 0, 0)]
while stack:
    I, forb, p = stack.pop()
    sets.append(I)
    for v in range(p, n):
        if not forb >> v & 1:
            stack.append((I | 1 << v, forb | P.adj[v], v + 1))
print(f"H: {n} points, {sum(bin(a).count('1') for a in P.adj) // 2} edges, {len(sets)} independent sets (with the empty set)")
cols = [S for S in sets if S]
for K in map(int, sys.argv[2:]):
    shapes = [Y for r in range(2, K + 1) for Y in itertools.combinations(range(n), r) if C.independent(P, Y)]
    classes = C.group_classes(P, shapes)
    rows_Y = [(tuple(shapes[t] for t in cls)) for cls in classes if len(cls) >= 2]
    # rows: gamma_bar({v}) = 1 for every v; gamma_bar(Y) - gamma_bar(Y0) = 0 within each class
    ri, ci, val = [], [], []
    r = 0
    masks = [sum(1 << v for v in Y) for Y in [(v,) for v in range(n)]]
    for v in range(n):
        for j, S in enumerate(cols):
            if S >> v & 1:
                ri.append(r); ci.append(j); val.append(1.0)
        r += 1
    colarr = np.array(cols, dtype=object)
    for cls in rows_Y:
        m0 = sum(1 << v for v in cls[0])
        in0 = [j for j, S in enumerate(cols) if S & m0 == m0]
        for Y in cls[1:]:
            m = sum(1 << v for v in Y)
            for j, S in enumerate(cols):
                if S & m == m:
                    ri.append(r); ci.append(j); val.append(1.0)
            for j in in0:
                ri.append(r); ci.append(j); val.append(-1.0)
            r += 1
    A = coo_matrix((val, (ri, ci)), shape=(r, len(cols))).tocsr()
    b = np.r_[np.ones(n), np.zeros(r - n)]
    res = linprog(np.ones(len(cols)), A_eq=A, b_eq=b, bounds=(0, None), method="highs")
    print(f"level {K}: {len(classes)} congruence classes of independent sets of 2..{K} points, {r - n} equality rows; "
          f"LP value {res.fun:.6f} ({res.message})", flush=True)
