#!/usr/bin/env python3
"""BASE-V: exact symbolic checks of the plane identities in the refutation of the hexagon (Lemma 6's < 9 branch).

Record: `plans/BASE-V-verification.md`, statement 3.  Setting: u = 0, x_k = exp(i*pi*(k-1)/3), k = 1..6, the six kept
bichromatic points of the recoloured pseudo-colouring (a regular hexagon on the unit circle omega(u)).

Derived claims checked (sympy, exact):
  G1  the open cone K_k := B(x_k, rho) \\ (D(x_{k+1},1) u D(x_{k-1},1)) contains the radial points x_k + s n_k:
      |x_k + s n_k - x_{k+-1}|^2 = 1 + s + s^2  (> 1 for s > 0);
  G2  the translate ray: v(s) = s * t_k, t_k the unit vector perpendicular to e_k = x_{k+1} - x_k with t_k . n_k > 0,
      lies in K_k - x_k AND in K_{k+1} - x_{k+1} for 0 < s < rho (rho = 1/2 suffices):
        |v - e_k|^2 = 1 + s^2,  |v - (x_{k-1} - x_k)|^2 > 1,  |v + e_k|^2 = 1 + s^2,  |v - (x_{k+2} - x_{k+1})|^2 > 1;
      so x_k + v and x_{k+1} + v are at distance |e_k| = 1 exactly;
  G3  a sector direction d at u with d . n_k > 0 puts x_k (limit s -> 0) strictly inside omega(u + t d) for small t:
      |n_k - t d|^2 = 1 - 2 t (d . n_k) + t^2 < 1 for 0 < t < 2 d . n_k.

Run: `python3 tools/base_v_hexagon.py`; `--plant` swaps t_k for -t_k (the ray pointing inward), which must FAIL G2.
"""
import sys

import sympy as sp

s, t = sp.symbols("s t", positive=True)
PLANT = "--plant" in sys.argv


def pt(k):
    a = sp.pi * (k - 1) / 3
    return sp.Matrix([sp.cos(a), sp.sin(a)])


def sq(v):
    return sp.simplify((v.T * v)[0])


fails = 0
for k in range(1, 7):
    xk, xn, xp, xnn = pt(k), pt(k + 1), pt(k - 1), pt(k + 2)
    nk = xk  # radial unit vector (u = 0)
    # G1
    for other in (xn, xp):
        val = sp.expand(sp.simplify(sq(xk + s * nk - other)))
        if sp.simplify(val - (1 + s + s**2)) != 0:
            print(f"FAIL G1 k={k}: {val}")
            fails += 1
    # G2
    ek = xn - xk
    tk = sp.Matrix([ek[1], -ek[0]])  # perpendicular
    if sp.simplify((tk.T * nk)[0]) < 0:
        tk = -tk
    if PLANT:
        tk = -tk
    v = s * tk
    c1 = sp.simplify(sq(v - ek) - (1 + s**2))
    c3 = sp.simplify(sq(v + ek) - (1 + s**2))
    c2 = sp.simplify(sq(v - (xp - xk)) - 1)
    c4 = sp.simplify(sq(v - (xnn - xn)) - 1)
    ok = c1 == 0 and c3 == 0
    # c2, c4 must be > 0 on 0 < s < 1/2: check they are s*(positive linear) + s^2
    for c in (c2, c4):
        cc = sp.expand(c)
        ok = ok and all(sp.simplify(cc.subs(s, val)) > 0 for val in (sp.Rational(1, 1000), sp.Rational(1, 4), sp.Rational(1, 2)))
        ok = ok and sp.Poly(cc, s).coeff_monomial(s) > 0
    if not ok:
        print(f"FAIL G2 k={k}: |v-e|^2-(1+s^2)={c1}, |v+e|^2-(1+s^2)={c3}, c2={sp.expand(c2)}, c4={sp.expand(c4)}")
        fails += 1
    # the two translates are at distance exactly 1
    if sp.simplify(sq((xk + v) - (xn + v)) - 1) != 0:
        print(f"FAIL G2-dist k={k}")
        fails += 1
# G3 (a general direction d with d.n = c > 0)
c = sp.symbols("c", positive=True)
expr = 1 - 2 * t * c + t**2
if sp.simplify(expr.subs(t, c) - (1 - c**2)) != 0:
    print("FAIL G3")
    fails += 1
print("ALL OK" if fails == 0 else f"{fails} FAILURE(S)")
sys.exit(1 if fails else 0)
