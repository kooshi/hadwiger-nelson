"""FS107-VW: the symbolic half of the HX derivation (job FS107-VW, 2026-09-27).

Checks, exactly (sympy over Q(sqrt3), R and rho symbols, t = rho/R in (0, 1)):
  D1  the diameter of a piece H_m u Q_m is sqrt(7R^2 - 4R rho + rho^2) (pair 1), i.e. every other hull-vertex pair is <= it;
  D2  the min distance from Q_m to the norm-3 hexagon of its colour is sqrt(4R^2 + 2R rho + rho^2) (pair 2) -- the value at
      the arc end; checked here against the exact min of the checker at sampled rational (R, rho);
  D3  every other same-colour class (hexagon-hexagon, triangle-triangle, triangle-hexagon at sites of norm >= 4) has
      min distance >= the pair-2 value whenever 0 < rho < R, so the two named pairs are the whole admissible region;
  D4  the stall: pair 1 and pair 2 together force t >= 1/2, with equality only at eps = 0, R = 2/sqrt21.
Exit 0 iff every check holds.
"""
import sys
from fractions import Fraction as F

import sympy as sp

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import fs107_vw_hx_check as hx  # noqa: E402
from fs107_vw_q3geom import Q3, add, scale, piece_min_cands, Poly, u30  # noqa: E402

R, rho, t, e = sp.symbols("R rho t epsilon", positive=True)
r3 = sp.sqrt(3)


def u(k):  # u(30k degrees)
    return sp.Matrix([sp.cos(sp.pi * k / 6), sp.sin(sp.pi * k / 6)])


ok = True
# piece m = 0: H0 centred at sqrt3 R (1, 0); Q0 = triangle(O, R u(-1), R u(1)) minus D(O, rho)
C0 = r3 * R * u(0)
Hv = [C0 + R * u(1 + 2 * i) for i in range(6)]
E1, E2 = rho * u(-1), rho * u(1)
hull = Hv + [E1, E2]
p1 = 7 * R**2 - 4 * R * rho + rho**2
print("D1: hull-vertex pairs of H0 u Q0 against pair 1 = 7R^2 - 4R rho + rho^2, for t = rho/R in (0,1)")
worst = None
for i in range(len(hull)):
    for j in range(i + 1, len(hull)):
        d2 = sp.expand((hull[i] - hull[j]).dot(hull[i] - hull[j]))
        g = sp.simplify(sp.expand((p1 - d2).subs(rho, t * R) / R**2))
        # g is a polynomial in t of degree <= 2; need g >= 0 on [0, 1]
        mn = min([g.subs(t, 0), g.subs(t, 1)] + [g.subs(t, s) for s in sp.solve(sp.diff(g, t), t) if s.is_real and 0 <= s <= 1])
        if sp.nsimplify(mn) < 0:
            ok = False
            print("  VIOLATED by pair", i, j, g)
        if g == 0:
            worst = (i, j)
print("  every pair <= pair 1 on t in [0,1]:", ok, "; pair 1 itself is hull pair", worst)

print("D2/D3: exact min distances over classes, at R = 1, as t varies (checker, exact in Q(sqrt3))")
# classes for colour 1 (m = 0): Q0 vs the hexagon of colour 1 at every site of norm <= 31; H-H; T-T (triangle bound)
Rv = F(1)
comps, w1, w2, a, b = hx.build(Rv, F(1, 2))
H0 = comps[1][0]
sites = []
for p in range(-4, 5):
    for q in range(-4, 5):
        x, y = 1 + (2 * p - q), 0 + (p + 3 * q)
        nrm = x * x + x * y + y * y
        if 0 < nrm <= 31 and (x, y) != (1, 0):
            sites.append((nrm, (p, q)))
sites.sort()
tri = Poly([(Q3(0), Q3(0)), scale(Q3(Rv), u30(-1)), scale(Q3(Rv), u30(1))], "T0")


def fmin(A, B):
    return min(float(c) for c in piece_min_cands(A, B)[0])


for nrm, (p, q) in sites:
    w = add(scale(Q3(p), w1), scale(Q3(q), w2))
    Hs = H0.shift(w)
    vals = []
    for tv in (F(1, 100), F(1, 4), F(1, 2), F(3, 4), F(43, 50)):
        Q = hx.TriDisc((Q3(0), Q3(0)), scale(Q3(Rv), u30(-1)), scale(Q3(Rv), u30(1)), tv * Rv, Rv, "Q0")
        vals.append((tv, fmin(Q, Hs)))
    pair2 = [float(sp.sqrt(4 + 2 * v + v * v)) for v, _ in vals]
    tb = fmin(tri, Hs)
    tag = "pair2" if nrm == 3 else ("(C)" if nrm == 4 else "")
    rel = all(val >= p2 - 1e-12 for (_, val), p2 in zip(vals, pair2))
    exact_eq = all(abs(val - p2) < 1e-12 for (_, val), p2 in zip(vals, pair2)) if nrm == 3 else None
    if nrm == 3 and not exact_eq:
        ok = False
    if nrm != 3 and not rel:
        ok = False
    print(f"  site norm {nrm:2d} {tag:6s}: min(T0, H) = {tb:.6f}R; min(Q, H) at t=.01,.25,.5,.75,.86:"
          f" {[round(v, 6) for _, v in vals]}; >= pair2 {rel}; == pair2 {exact_eq}")
# H-H and T-T
hh = min(fmin(H0, H0.shift(add(scale(Q3(p), w1), scale(Q3(q), w2)))) for p in range(-2, 3) for q in range(-2, 3) if (p, q) != (0, 0))
tt = min(fmin(tri, tri.shift(add(scale(Q3(p), w1), scale(Q3(q), w2)))) for p in range(-2, 3) for q in range(-2, 3) if (p, q) != (0, 0))
print(f"  H-H min over L7 = {hh:.6f}R (sqrt7 = {7 ** .5:.6f}); T-T min = {tt:.6f}R (sqrt13 = {13 ** .5:.6f})")
ok &= abs(hh - 7 ** .5) < 1e-12 and abs(tt - 13 ** .5) < 1e-12
# symbolic: (C) - pair2 = 3R(R - rho) >= 0 for rho >= R/2, and 27/4 R^2 - pair2 >= 0 for rho <= R/2; H-H 7R^2 - pair2 = 3R^2 - 2R rho - rho^2 = (R - rho)(3R + rho)
p2 = 4 * R**2 + 2 * R * rho + rho**2
c_hi = sp.factor(sp.expand((rho - R / 2) ** 2 + sp.Rational(27, 4) * R**2 - p2))
c_lo = sp.factor(sp.expand(sp.Rational(27, 4) * R**2 - p2))
hh_s = sp.factor(7 * R**2 - p2)
tt_s = sp.factor(13 * R**2 - p2)
print(f"  (C) - pair2 (rho >= R/2) = {c_hi}; (C) - pair2 (rho <= R/2) = {c_lo} (>= 27/4 - 21/4 > 0); H-H - pair2 = {hh_s}; T-T - pair2 = {tt_s}")

print("D4: the stall")
ratio = sp.simplify((4 + 2 * t + t**2) - (7 - 4 * t + t**2))
print(f"  pair2 - pair1 (in R^2 units) = {ratio}  -> needs t >= 1/2 (since pair2 >= (1+e)^2 > (1-e)^2 >= pair1)")
Rst = sp.solve(sp.Eq((7 - 4 * sp.Rational(1, 2) + sp.Rational(1, 4)) * R**2, 1), R)
dstar = sp.nsimplify(2 * sp.pi / (21 * r3) * sp.Rational(1, 4))
print(f"  at t = 1/2, eps = 0: R = {Rst}; delta* = (2 pi/(21 sqrt3)) t^2 = {dstar} = {float(dstar):.6f}; pi/(42 sqrt3) = {float(sp.pi / (42 * r3)):.6f}")
ok &= abs(float(dstar) - float(sp.pi / (42 * r3))) < 1e-15 and any(abs(float(r) - 2 / 21 ** .5) < 1e-15 for r in Rst)
print("ALL HOLD" if ok else "SOME CHECK FAILED")
sys.exit(0 if ok else 1)
