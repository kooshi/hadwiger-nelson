#!/usr/bin/env python3
"""FS-54 — the residue graphs at an INERT prime above 2: Cay(F_{Q^2}, mu_{Q+1}) for Q = 4, 8, 16, 32 (Q = 2 is K_4).
Prints each spectrum and Hoffman floor and asks CaDiCaL for a k-colouring from the floor up, verifying any colouring on
every edge. Measured 2026-09-16: 4-colourable at every Q, with the 3-colouring refused at Q = 4 and floors 4.000 at 8 and 32.
Run: python3 tools/fs54_char2_residue.py"""
# G_Q = Cay(F_{Q^2}, mu_{Q+1}) for Q = 2^m: the residue graph at an inert prime above 2 (conjugation = Frobenius x -> x^Q)
import itertools, time, sys, numpy as np
from pysat.card import CardEnc, EncType
from pysat.solvers import Solver
PRIM = {4: 0b10011, 6: 0b1000011, 8: 0b100011101, 10: 0b10000001001}  # primitive polynomials over F_2
def build(m2):
    n = 1 << m2; poly = PRIM[m2]
    exp = [0]*(n-1); x = 1
    for i in range(n-1):
        exp[i] = x; x <<= 1
        if x & n: x ^= poly
    assert len(set(exp)) == n-1
    Q = 1 << (m2//2)
    mu = sorted({exp[(Q-1)*k % (n-1)] for k in range(Q+1)})
    assert len(mu) == Q+1 and all(any(exp[(Q-1)*k%(n-1)]==u for k in range(Q+1)) for u in mu)
    return n, Q, mu
def spectrum(n, mu):
    A = np.array([[bin(a & u).count("1") % 2 for u in mu] for a in range(n)])
    ev = (1 - 2*A).sum(axis=1)
    return sorted(set(ev.tolist())), int(ev[1:].min())
def colourable(n, mu, k, budget=None):
    v = lambda i, c: i*k + c + 1
    cnf = [[v(i, c) for c in range(k)] for i in range(n)]
    for i in range(n):
        for u in mu:
            j = i ^ u
            if i < j:
                cnf += [[-v(i, c), -v(j, c)] for c in range(k)]
    cnf += [[v(0, 0)], [v(mu[0], 1)]]
    top = n*k
    for i in range(n):  # colour precedence beyond the pins
        for c in range(2, k):
            cnf.append([-v(i, c)] + [v(j, c-1) for j in range(i)])
    with Solver(name="cadical153", bootstrap_with=cnf) as s:
        if budget: s.conf_budget(budget); r = s.solve_limited()
        else: r = s.solve()
        if r:
            m = s.get_model(); col = [next(c for c in range(k) if m[v(i, c)-1] > 0) for i in range(n)]
            assert all(col[i] != col[i ^ u] for i in range(n) for u in mu)
    return r
for m2 in (4, 6, 8, 10):
    n, Q, mu = build(m2)
    ev, lmin = spectrum(n, mu)
    d = Q + 1; hoff = 1 + d/(-lmin)
    line = f"Q={Q:2d}: {n} vertices, degree {d}, spectrum {ev}, lambda_min {lmin}, Hoffman chi >= {hoff:.3f}"
    print(line, flush=True)
    for k in range(max(2, int(np.ceil(hoff))), 9):
        t0 = time.time(); r = colourable(n, mu, k, budget=None if n <= 256 else 5_000_000)
        print(f"    k={k}: {{True:'colourable',False:'NOT colourable',None:'undecided at budget'}}[r] ({time.time()-t0:.1f}s)".replace("{True:'colourable',False:'NOT colourable',None:'undecided at budget'}[r]", {True:'colourable',False:'NOT colourable',None:'undecided at budget'}[r]), flush=True)
        if r: break
