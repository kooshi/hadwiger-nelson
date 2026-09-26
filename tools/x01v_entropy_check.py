#!/usr/bin/env python3
"""X01V (FS-100, x2x3 crunch): the control on EF-G (a).

EF-G (a) claims h_m(u) = log H(u), where H(u) = prod over the FINITE places w of L of max(1, |u|_w).
The Lind-Ward / Yuzvinskii formula for an automorphism of a solenoid sums log max(1, |u|_w) over the
archimedean places as well.  For u in U the two agree iff |u|_w = 1 at every archimedean place of L.

For u algebraic with primitive minimal polynomial P = a0 * prod (x - alpha_i) over Z, and e = [L : Q(u)]:
    sum over finite places of L of log max(1, |u|_w)      = e * log a0
    sum over archimedean places of L of log max(1, |u|_w) = e * sum_i log max(1, |alpha_i|)
So EF-G (a) holds for u iff every root of P lies in the closed unit disc; for u in U, u^{-1} = ubar is a
conjugate of u, so P is reciprocal and its roots come in pairs alpha, 1/alpha: EF-G (a) holds for u iff
every root lies ON the unit circle.  (First version of this tool tested non-reciprocity, which is wrong:
P is always reciprocal here; the run went red on the counterexample for that reason, recorded in the
record.)  Exact test: write P(x) = x^k Q(x + 1/x) (degree 2k); every root is on the unit circle iff all k
roots of Q are real and lie in [-2, 2], counted by Sturm sequences (sympy count_roots).  Numerical
(60 digits, reported with the margin): the root moduli.

Cases:
  totally real control  F = Q(sqrt 2),   u = (1 + sqrt2 i)/(1 - sqrt2 i)   -> all roots on the circle
  counterexample        F = Q(cbrt 2),   u = (1 + cbrt2 i)/(1 - cbrt2 i)   -> roots off the circle
Plants (each must make the run go red, and is watched firing by --plant):
  P1  replace u by (1 + c i)/(2 - c i), not of norm one: the membership assertion must fire
  P2  swap the two fields' expectations: both on-circle assertions must fire
"""
import sys
import sympy as sp
import mpmath as mp

mp.mp.dps = 60
x = sp.symbols('x')
I = sp.I


def analyse(c, label, denom=1):
    u = (1 + c * I) / (denom - c * I)
    ubar = (1 - c * I) / (denom + c * I)  # complex conjugation of L/F: i -> -i, c real in F
    norm = sp.nsimplify(sp.simplify(sp.expand(u * ubar)))
    in_U = sp.simplify(norm - 1) == 0
    P = sp.Poly(sp.minimal_polynomial(u, x), x)
    coeffs = P.all_coeffs()
    g = sp.gcd_list(coeffs)
    P = sp.Poly([cc / g for cc in coeffs], x)
    if P.LC() < 0:
        P = -P
    n = P.degree()
    rev = sp.Poly(list(reversed(P.all_coeffs())), x)
    reciprocal = (rev == P) or (rev == -P)
    # trace polynomial Q with P(x) = x^k Q(x + 1/x); only for reciprocal P of even degree
    on_circle = None
    if reciprocal and n % 2 == 0:
        k = n // 2
        t = sp.symbols('t')
        rem = sp.Poly(P.as_expr(), x)
        Q = sp.Integer(0)
        # peel from the top: x^k T_j(x+1/x) expansions
        cur = sp.expand(P.as_expr() / x**k)
        for j in range(k, -1, -1):
            cj = sp.expand(cur * x**j).coeff(x, 2 * j) if j > 0 else cur
            if j == 0:
                cj = sp.expand(cur)
            Q += cj * t**j
            cur = sp.expand(cur - cj * (x + 1 / x)**j)
        assert sp.simplify(cur) == 0, "trace-polynomial peel failed"
        Qp = sp.Poly(Q, t)
        inside = Qp.count_roots(-2, 2)
        on_circle = (inside == k)
        print(f"  trace polynomial Q(t) = {Qp.as_expr()}; real roots in [-2,2] (Sturm, exact): {inside} of {k}")
    roots = mp.polyroots([int(cc) for cc in P.all_coeffs()], maxsteps=200, extraprec=200)
    mods = sorted(float(abs(r)) for r in roots)
    arch = sum(mp.log(max(1, abs(r))) for r in roots)
    a0 = int(P.LC())
    print(f"[{label}] c = {c}; u*ubar = {norm}; u in U: {in_U}")
    print(f"[{label}] minimal polynomial (primitive, degree {n}): {P.as_expr()}")
    print(f"[{label}] a0 = {a0}; per-conjugate finite part log a0 = {mp.nstr(mp.log(a0), 12)}")
    print(f"[{label}] root moduli: {[round(m, 12) for m in mods]}")
    print(f"[{label}] reciprocal: {reciprocal}; all roots on the unit circle (exact): {on_circle}")
    print(f"[{label}] archimedean part sum log max(1,|alpha|) = {mp.nstr(arch, 15)}")
    return in_U, on_circle, mods, arch


def main(plant=None):
    ok = True
    s2, c2 = sp.sqrt(2), sp.cbrt(2)
    d_ctrl = 2 if plant == 'P1' else 1
    in_U, rec, mods, arch = analyse(s2, 'control Q(sqrt2)', denom=d_ctrl)
    if not in_U:
        print("RED: control u is not a unit vector (membership assertion)"); ok = False
    expect_ctrl_rec = (plant != 'P2')
    if rec != expect_ctrl_rec:
        print("RED: control on-circle verdict differs from expectation"); ok = False
    if expect_ctrl_rec and not all(abs(m - 1) < 1e-40 for m in mods):
        print("RED: control roots not all on the unit circle"); ok = False
    in_U, rec, mods, arch = analyse(c2, 'counterexample Q(cbrt2)')
    if not in_U:
        print("RED: counterexample u is not a unit vector"); ok = False
    expect_cx_rec = (plant == 'P2')  # expected on-circle verdict
    if rec != expect_cx_rec:
        print("RED: counterexample on-circle verdict differs from expectation"); ok = False
    if not expect_cx_rec:
        margin = max(mods) - 1
        if not margin > 1:
            print("RED: counterexample root modulus not clear of the circle by margin 1"); ok = False
        else:
            print(f"counterexample: largest root modulus exceeds 1 by {margin:.6f}; "
                  f"h_m(u) - log H(u) = e * {mp.nstr(arch, 12)} > 0, e = [L:Q(u)]")
    print("GREEN" if ok else "RED")
    return ok


if __name__ == '__main__':
    if len(sys.argv) > 2 and sys.argv[1] == '--plant':
        ok = main(sys.argv[2])
        # a plant must go red; exit 0 only if it did
        sys.exit(0 if not ok else 1)
    sys.exit(0 if main() else 1)
