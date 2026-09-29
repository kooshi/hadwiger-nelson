#!/usr/bin/env python3
"""FS121-V4: symbolic check of C121-C1-FLAT's witness family, with k a free symbol (so every k in Z at once).

Frame (data/fs121/claims.md § 7.0, the chain's frame): a = (1, 0), n = (0, 1), P_k = (0, k).
Witness (this record, § 2.5): p(t) = (t, t^4); nu(t) = the unit normal of p with positive n-component;
  U_k = the germ at P_k of q_k(t) = p(t) + k nu(t);   L_k = the germ at P_k of the line (t, k).
Checked, exactly and symbolically in t and k:
  (1) q_k'(t) is parallel to p'(t) (cross product identically 0), so the unit normal of q_k is ±nu(t);
  (2) q_k'(0) = (1, 0): the sign is +, q_k is a graph over the a-axis near 0, and q_{k} = q_{k-1} + nu = the unit parallel of U_{k-1} toward P_k;
      likewise q_k = q_{k+1} − nu, the unit parallel of U_{k+1} toward P_k (the same family read the other way);
  (3) q_k(0) = P_k;
  (4) Y_k(t) := q_k,2(t) − k = t^4 − 8k t^6 + O(t^8): positive for small t ≠ 0 (both signs of t), so U_k > L_k on both sides of P_k;
  (5) the curvature of q_k at t = 0 is 0 (and L_k is a line);
  (6) as a graph, Y_k(X) = X^4 + 8k X^6 + O(X^8) (series reversion), so Y_k(0) = Y_k'(0) = Y_k''(0) = 0.
Plants: --plant cubic (p = (t, t^3)) must fail (4); --plant parabola (p = (t, t^2)) must fail (5).
"""
import sys
import sympy as sp

t, k, X = sp.symbols("t k X", real=True)

def run(plant):
    y = {"cubic": t**3, "parabola": t**2}.get(plant, t**4)
    p = sp.Matrix([t, y])
    dp = p.diff(t)
    s = sp.sqrt(dp.dot(dp))
    nu = sp.Matrix([-dp[1], dp[0]]) / s          # positive n-component: dp[0] = 1 > 0
    q = p + k * nu
    dq = q.diff(t)
    fails = []
    cross = sp.simplify(dq[0] * dp[1] - dq[1] * dp[0])
    if cross != 0: fails.append(f"(1) q_k' not parallel to p': {cross}")
    dq0 = [sp.simplify(e.subs(t, 0)) for e in dq]
    if dq0 != [1, 0]: fails.append(f"(2) q_k'(0) = {dq0}, not (1, 0)")
    q0 = [sp.simplify(e.subs(t, 0)) for e in q]
    if q0 != [0, k]: fails.append(f"(3) q_k(0) = {q0}, not P_k")
    Y = sp.series(q[1] - k, t, 0, 8).removeO()
    Xs = sp.series(q[0], t, 0, 8).removeO()
    lead = sp.Poly(sp.expand(Y), t).terms()[-1] if Y != 0 else None  # lowest-degree term
    low = min(sp.Poly(sp.expand(Y), t).monoms())[0] if Y != 0 else None
    coeff = sp.expand(Y).coeff(t, low) if low is not None else 0
    if not (low is not None and low % 2 == 0 and coeff.is_positive):
        fails.append(f"(4) Y_k(t) = {sp.expand(Y)} + O(t^8): lowest term t^{low} with coefficient {coeff} — not positive on both sides")
    curv = sp.simplify(((dq[0] * dq.diff(t)[1] - dq[1] * dq.diff(t)[0]) / (dq.dot(dq))**sp.Rational(3, 2)).subs(t, 0))
    if curv != 0: fails.append(f"(5) curvature of U_k at P_k = {curv}")
    # (6) graph form by series reversion: t = X + a3 X^3 + a5 X^5, solve X_k(t(X)) = X to order 7
    a3, a5 = sp.symbols("a3 a5")
    tX = X + a3 * X**3 + a5 * X**5
    eq = sp.expand(sp.series(Xs.subs(t, tX), X, 0, 7).removeO() - X)
    sol = sp.solve([eq.coeff(X, 3), eq.coeff(X, 5)], [a3, a5], dict=True)[0]
    YX = sp.expand(sp.series(Y.subs(t, tX.subs(sol)), X, 0, 8).removeO())
    return fails, sp.expand(Y), sp.expand(Xs), YX, curv

def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    fails, Y, Xs, YX, curv = run(plant)
    print(f"X_k(t) = {Xs} + O(t^8)")
    print(f"Y_k(t) = {Y} + O(t^8)")
    print(f"Y_k(X) = {YX} + O(X^8)")
    print(f"curvature of U_k at P_k: {curv}")
    for f in fails: print("FAIL", f)
    print(f"{'ALL PASS' if not fails else 'FAIL'} (plant = {plant})")
    sys.exit(0 if not fails else 1)

main()
