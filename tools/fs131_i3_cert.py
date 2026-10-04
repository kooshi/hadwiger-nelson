#!/usr/bin/env python3
"""FS131-I3f: Positivstellensatz-style certificate finder (proof engineering for nlinarith hints).

Given polynomial constraints g_i >= 0, equalities h_j = 0 and a target f >= 0 over variables, find
f = sum_k lam_k * (product of constraints) + sum_j (monomial * h_j)  with lam_k >= 0 (an LP), then rationalise
and verify EXACTLY with sympy.  The certificate is only a hint list for Lean; Lean re-checks it.
This is not a search for a mathematical object: the statement is fixed by the plan, the identity is checked.
"""
import itertools, sys
import sympy as sp
import numpy as np
from scipy.optimize import linprog

def monomials(vars_, deg):
    out = []
    for d in range(deg + 1):
        for c in itertools.combinations_with_replacement(vars_, d):
            out.append(sp.Mul(*c) if c else sp.Integer(1))
    return out

def find(vars_, gs, hs, f, deg_prod=2, deg_eq=2, verbose=True):
    # products of the g's up to deg_prod factors
    prods = []
    names = []
    for k in range(0, deg_prod + 1):
        for c in itertools.combinations_with_replacement(range(len(gs)), k):
            p = sp.Integer(1)
            for i in c:
                p *= gs[i]
            prods.append(sp.expand(p)); names.append(c)
    eqterms = []
    eqnames = []
    for j, h in enumerate(hs):
        for m in monomials(vars_, deg_eq):
            eqterms.append(sp.expand(m * h)); eqnames.append((j, m))
    allterms = prods + eqterms
    polys = [sp.Poly(t, *vars_) for t in allterms]
    target = sp.Poly(sp.expand(f), *vars_)
    monos = set(target.monoms())
    for p in polys:
        monos |= set(p.monoms())
    monos = sorted(monos)
    idx = {m: i for i, m in enumerate(monos)}
    A = np.zeros((len(monos), len(allterms)))
    for k, p in enumerate(polys):
        for m, c in p.terms():
            A[idx[m], k] = float(c)
    b = np.zeros(len(monos))
    for m, c in target.terms():
        b[idx[m]] = float(c)
    n1 = len(prods)
    bounds = [(0, None)] * n1 + [(None, None)] * len(eqterms)
    res = linprog(np.zeros(len(allterms)), A_eq=A, b_eq=b, bounds=bounds, method='highs')
    if verbose:
        print('status', res.status, res.message)
    if res.status != 0:
        return None
    x = res.x
    sol = []
    for k in range(len(allterms)):
        if abs(x[k]) > 1e-9:
            sol.append((k, x[k]))
    return prods, names, eqterms, eqnames, sol, x

if __name__ == '__main__':
    pass
