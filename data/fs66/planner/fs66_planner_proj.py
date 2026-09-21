#!/usr/bin/env python3
"""Scratch: F(b) = max |A|, A in AG(2,p) = F_p[i], with at most b_j lines used in each of the (p+1)/2 'tangent' parallel classes
(class j = cosets of F_p * i*s_j, indexed by Re(a * conj(s_j)) mod p). These are the only fibre data level-two edges see."""
import sys, time, itertools
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds
from scipy.sparse import lil_matrix
from fs66_planner_g2 import circle

def dirs(p):
    S = circle(p); seen = []; 
    for (a, b) in S:
        if ((-a) % p, (-b) % p) not in seen: seen.append((a, b))
    return seen

def F(p, b, tl=120):
    D = dirs(p); J = len(D); n = p*p
    nx = n; ny = J*p
    c = np.zeros(nx + ny); c[:nx] = -1
    rows = []
    A = lil_matrix((n*J + J, nx + ny)); lo = []; hi = []
    r = 0
    for u in range(p):
        for v in range(p):
            a = u*p + v
            for j, (s, t) in enumerate(D):
                proj = (u*s + v*t) % p           # Re((u+iv)(s-it)) = us+vt
                A[r, a] = 1; A[r, nx + j*p + proj] = -1; lo.append(-np.inf); hi.append(0); r += 1
    for j in range(J):
        for t in range(p): A[r, nx + j*p + t] = 1
        lo.append(-np.inf); hi.append(b[j]); r += 1
    res = milp(c, constraints=LinearConstraint(A.tocsr(), lo, hi), integrality=np.ones(nx + ny), bounds=Bounds(0, 1), options={"time_limit": tl})
    return (-res.fun if res.x is not None else None), res.status, (getattr(res, "mip_dual_bound", None))

if __name__ == "__main__":
    p = int(sys.argv[1])
    J = (p+1)//2
    for bb in sys.argv[2:]:
        b = [int(t) for t in bb.split(",")]
        if len(b) == 1: b = b*J
        t0 = time.time(); val, st, db = F(p, b)
        print(f"p={p} b={b}: F={val} status={st} dual_bound={-db if db is not None else None} product-of-two-smallest={sorted(b)[0]*sorted(b)[1]}  ({time.time()-t0:.1f}s)", flush=True)
