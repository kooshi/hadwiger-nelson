# the lean y_from_set against the reference y_from_set at q = 11 and q = 19, each on a random maximal independent set (seed 3)
import sys, json
sys.path.insert(0, "tools")
import numpy as np
import fs54_d4_quad as Q
for q, setsrc in ((11, "data/fs54/d4/randsets-q11.json"), (19, None)):
    P = Q.Plane(q); dreps, _, _ = Q.d_classes(P); Tb = Q.Tables(P, dreps, log=lambda *a: None)
    rng = np.random.default_rng(3); order = rng.permutation(P.n); S, blocked = [], np.zeros(P.n, bool)
    for v in order:
        if not blocked[v]:
            S.append(int(v)); blocked[v] = True; blocked |= P.unit[P.SUB[:, v]]
    yr = Q.y_from_set(P, Tb, S)
    yl = Q.lean_y_from_set(P, Tb.keys, Tb.var, Tb.nvar, S, workers=4, log=lambda *a: None)
    print(f"q={q} |S|={len(S)}: max |lean - reference| = {np.abs(yl - yr).max():.2e} over {Tb.nvar} orbits")
