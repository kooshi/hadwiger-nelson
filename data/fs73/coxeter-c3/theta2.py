# Theta = {theta in Hom(Lambda,R): ||theta(u)|| >= 1/3 for all u in U}. Branch-and-bound over integer parts, float LP pruning,
# exact (Fraction) evaluation of each leaf's vertices.
import itertools, math, sys
from fractions import Fraction as Fr
import numpy as np
from scipy.optimize import linprog
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form
def lattice_coords(U):
    """U: list of integer tuples spanning Lambda. Returns (basis cols, coords of each u as int lists)."""
    M = Matrix([list(u) for u in U]).T
    H = hermite_normal_form(M)
    B = Matrix.hstack(*[H[:,j] for j in range(H.shape[1]) if any(H[:,j])])
    r = B.shape[1]
    # solve B x = u exactly (B has full column rank)
    BtB = (B.T*B).inv()*B.T
    C = []
    for u in U:
        x = BtB*Matrix(list(u))
        assert all(v.q == 1 for v in x) and B*x == Matrix(list(u))
        C.append([int(v) for v in x])
    return B, C
def halfset(C):
    S = []; seen = set()
    for c in C:
        t = tuple(c)
        if tuple(-x for x in t) in seen or t in seen: continue
        seen.add(t); S.append(list(t))
    return S
def idet(A):
    # Bareiss fraction-free determinant, python ints
    A=[row[:] for row in A]; n=len(A); sign=1; prev=1
    for k in range(n-1):
        if A[k][k]==0:
            for i in range(k+1,n):
                if A[i][k]!=0: A[k],A[i]=A[i],A[k]; sign=-sign; break
            else: return 0
        for i in range(k+1,n):
            for j in range(k+1,n):
                A[i][j]=(A[i][j]*A[k][k]-A[i][k]*A[k][j])//prev
        prev=A[k][k]
    return sign*A[n-1][n-1]
def best_frame(S, r, cap=400000):
    best=None
    for cnt,sub in enumerate(itertools.combinations(range(len(S)), r)):
        d=abs(idet([S[i] for i in sub]))
        if d and (best is None or d<best[0]):
            best=(d,sub)
            if d==1: break
        if cnt>cap and best: break
    return best
def enumerate_theta(S, r, verbose=True):
    D, sub = best_frame(S, r)
    M = Matrix([S[i] for i in sub])      # rows u_i ; t = M theta
    Minv = M.inv()
    others = [i for i in range(len(S)) if i not in sub]
    Cu = [ [Fr(int(x.p), int(x.q)) for x in (Matrix([S[i]])*Minv)] for i in others ]
    Cu.sort(key=lambda c: sum(abs(x) for x in c))
    # reps of Z^r / M Z^r  (t mod M Z^r, M acting on integer theta): t = M theta, theta in Z^r -> t in M Z^r (column span of M)
    reps = []; seen = set()
    for k in itertools.product(range(D), repeat=r):
        key = tuple(Fr(int(x.p), int(x.q)) % 1 for x in Minv*Matrix(k))
        if key not in seen: seen.add(key); reps.append(k)
        if len(reps) == D: break
    if verbose: print("frame index D =", D, "frame", sub, "others", len(others), "reps", len(reps))
    leaves = []
    third = 1/3
    for k in reps:
        # variables t0 in [1/3,2/3]^r ; t = t0 + k
        # constraint for u: c.t0 + c.k in [1/3 + j, 2/3 + j]
        def rec(idx, A, lo, hi):
            # A: list of (row, lo, hi) constraints on t0 (float for pruning, exact kept separately)
            if idx == len(Cu):
                leaves.append((k, list(A))); return
            c = Cu[idx]; ck = sum(c[i]*k[i] for i in range(r))
            cf = [float(x) for x in c]
            # range of c.t0 over current polytope via LP
            bnds = [(third, 2*third)]*r
            Aub = []; bub = []
            for (row, l, h) in A:
                Aub.append([float(x) for x in row]); bub.append(float(h - 0) )
                Aub.append([-float(x) for x in row]); bub.append(-float(l))
            res1 = linprog(cf, A_ub=Aub or None, b_ub=bub or None, bounds=bnds, method="highs")
            res2 = linprog([-x for x in cf], A_ub=Aub or None, b_ub=bub or None, bounds=bnds, method="highs")
            if res1.status != 0 or res2.status != 0: return
            mn = res1.fun + float(ck); mx = -res2.fun + float(ck)
            for j in range(math.floor(mn - 2/3) - 1, math.ceil(mx - 1/3) + 2):
                l = Fr(1,3) + j - ck; h = Fr(2,3) + j - ck
                if float(h) < mn - float(ck) - 1e-9 or float(l) > mx - float(ck) + 1e-9: continue
                rec(idx+1, A + [(c, l, h)], lo, hi)
        rec(0, [], None, None)
    return D, sub, M, Minv, Cu, leaves
def leaf_extent(r, A):
    bnds = [(1/3, 2/3)]*r
    Aub = []; bub = []
    for (row, l, h) in A:
        Aub.append([float(x) for x in row]); bub.append(float(h))
        Aub.append([-float(x) for x in row]); bub.append(-float(l))
    ext = []
    for i in range(r):
        e = [0.0]*r; e[i] = 1.0
        a = linprog(e, A_ub=Aub or None, b_ub=bub or None, bounds=bnds, method="highs")
        b = linprog([-x for x in e], A_ub=Aub or None, b_ub=bub or None, bounds=bnds, method="highs")
        if a.status != 0 or b.status != 0: return None
        ext.append((a.fun, -b.fun))
    return ext
