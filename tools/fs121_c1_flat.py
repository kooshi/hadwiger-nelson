#!/usr/bin/env python3
"""FS121-C1: C121-C1-FLAT, exact (truncated power series in sympy, no floating point).

Germ U_0: y = x^4 at P_0 (tangent to a, curvature 0). Its parallel at signed distance t along the upward unit normal is computed as an exact
power series Y(X) - t, t symbolic, through X^6: the check is Y(X) - t = X^4 + O(X^6) for every t (no X^1, X^2, X^3, X^5 term; X^4 coefficient 1).
So U_k (the parallel at distance k, i.e. U_{k-1}'s unit parallel toward P_k) lies strictly above the line L_k through P_k along a, with
curvature 0 at P_k, for every integer k; L_k is L_{k+1}'s unit parallel toward P_k (a line's parallel is a line).
--circle plants the fault: U_0 is y = x^2/20 (curvature 1/10, a circle to second order); the curvature of U_k at P_k, 2 x (X^2 coefficient),
computed at each integer k, leaves (-1, 1) at k = 9: that chain cannot be bi-infinite (FS110-N4-FIN's mechanism)."""
import sys, sympy as sp
x, X, t = sp.symbols('x X t')
N = 7
def trunc(e, v): e = sp.expand(e); return sum(e.coeff(v, j) * v**j for j in range(N))
def parallel(g, tt):  # Y(X) - tt through X^(N-1), exact
    gp = sp.diff(g, x); u = trunc(gp**2, x)
    inv_s = trunc(sum(sp.binomial(sp.Rational(-1, 2), j) * u**j for j in range(N)), x)
    Xs, Ys = trunc(x - tt*gp*inv_s, x), trunc(g + tt*inv_s, x)
    c1 = Xs.coeff(x, 1)  # revert X = Xs(x): each pass fixes one more order exactly
    inv = X / c1
    for _ in range(N): inv = trunc((X - (Xs.subs(x, inv) - c1*inv)) / c1, X)
    return trunc(Ys.subs(x, inv) - tt, X)
if '--circle' not in sys.argv:
    Y = parallel(x**4, t)
    co = [sp.simplify(Y.coeff(X, j)) for j in range(N)]
    print("parallel of y = x^4 at signed distance t:  Y - t =", Y)
    ok = co[:4] == [0, 0, 0, 0] and co[4] == 1 and co[5] == 0
    comp = sp.expand(parallel(Y.subs(X, x), 1) - parallel(x**4, t + 1))  # U_{k-1}'s unit parallel is U_k: parallels compose, through X^6
    print("parallel at distance 1 of the parallel at distance t, minus the parallel at distance t + 1:", comp)
    ok = ok and comp == 0
    print("FLAT CHAIN:", "ALL HOLD (for every t: Y - t = X^4 + O(X^6), curvature 0, strictly above the line)" if ok else f"FAILS {co}")
else:
    bad = None
    for k in range(0, 21):
        kap = 2 * parallel(x**2/20, k).coeff(X, 2)
        if not (-1 < kap < 1): bad = (k, kap); break
    print("FLAT CHAIN:", f"FAILS (curvature at P_k is {bad[1]} at k = {bad[0]})" if bad else "ALL HOLD")
