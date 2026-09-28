#!/usr/bin/env python3
"""FS112-N3: exact checks (sympy / rationals, seconds) of the identities behind plans/FS112-N-proof.md § Continuation -- FS112-N3,
stage N3-2 (card R's R1: the monotone chain).  Earlier tools (tools/fs112_n_*.py, tools/fs112_n2_*.py) are not edited.

Every check returns (ok, reason, detail).  `reason` is one code from REASONS; a check is GREEN iff ok.  A planted fault must turn exactly
its own check RED, with exactly its expected reason code (a plant that dies of the scaffolding is a DEFECT, not a firing).
`--self-test` runs every plant and the faithful run.

Frame (FS110-N4 §2.1): f(x) = x/(1+x) (a curvature at P_{k+1} read at P_k), ft(x) = x/(1-x) (at P_{k-1} read at P_k), ft = f^{-1}.
Along a chain of stuck vertices: lam_k <= f(lam_{k+1}), ft(ups_{k-1}) <= ups_k, lam_k < ups_k, all in [-1, 1], with lam_{k+1} > -1 and
ups_k < 1 whenever P_k, resp. P_{k+1}, is stuck (N112-END).

  MONO   f(x) - x = -x^2/(1+x) and ft(x) - x = x^2/(1-x) as rational functions, and f(x) < x < ft(x) at named nonzero x in (-1, 1).
         Expected: IDENTITY.  plant mono_swap: the check is handed ft in place of f -> RED, NOT_BELOW.
  STEP   the step lemma (N3-STEP): at every step at least one of lam, ups strictly increases and neither decreases.  Checked exhaustively on
         the named grid G = {j/6 : -6 <= j <= 6} over all quadruples (lam_k, lam_{k+1}, ups_k, ups_{k+1}) satisfying the two recursions,
         lam < ups at both vertices, lam_{k+1} > -1, ups_k < 1.  Expected: STRICT_STEP.
         plant step_identity: the recursions replaced by lam_k <= lam_{k+1}, ups_k <= ups_{k+1} (f, ft the identity) -> a quadruple with
         no strict increase exists -> RED, NO_STRICT_STEP.
  RAY    the ray bound (N3-RAYR): ft^k(x) = x/(1 - kx) and f^k(x) = x/(1 + kx) (k = 0..20, as rational functions), and
         x/(1 - kx) + 1/(k+1) = (x + 1)/((1 - kx)(k + 1)), x/(1 + kx) - 1/(k+1) = (x - 1)/((1 + kx)(k + 1)); so for x in [-1, 0) every
         ft^k(x) >= -1/(k+1), for x in (0, 1] every f^k(x) <= 1/(k+1), equality exactly at x = -1, resp. 1 (NB2's pencil: the circle of
         radius k+1 about P_{-1} has upward curvature -1/(k+1) at P_k).  Named x: -1, -1/2, -1/7; 1, 1/3.  Expected: BOUND_HOLDS.
         plant ray_below: x = -11/10 (below N3-DEG's -1) -> the bound fails -> RED, BELOW_BOUND.

Exit 0 iff the requested run behaves as expected (faithful: all GREEN; --plant X: exactly X RED with its reason; --self-test: all of it).
"""
from __future__ import annotations

import argparse
import itertools
import sys
from fractions import Fraction as Fr

import sympy as sp

REASONS = ("IDENTITY", "NOT_BELOW", "STRICT_STEP", "NO_STRICT_STEP", "BOUND_HOLDS", "BELOW_BOUND")
PLANTS = {"mono_swap": ("MONO", "NOT_BELOW"), "step_identity": ("STEP", "NO_STRICT_STEP"), "ray_below": ("RAY", "BELOW_BOUND")}


def f(x):
    return x / (1 + x)


def ft(x):
    return x / (1 - x)


def check_mono(plant):
    x = sp.symbols("x")
    fx = ft(x) if plant == "mono_swap" else f(x)
    ok1 = sp.simplify(fx - x + x ** 2 / (1 + x)) == 0
    ok2 = sp.simplify(ft(x) - x - x ** 2 / (1 - x)) == 0
    below = all((fx.subs(x, v) < v) and (ft(v) > v) for v in (sp.Rational(-5, 6), sp.Rational(-1, 3), sp.Rational(1, 7), sp.Rational(2, 3)))
    if not below:
        return False, "NOT_BELOW", "f(x) < x fails at a named nonzero x in (-1, 1)"
    if not (ok1 and ok2):
        return False, "NOT_BELOW", "the rational identity fails"
    return True, "IDENTITY", "f(x) - x = -x^2/(1+x), ft(x) - x = x^2/(1-x); f(x) < x < ft(x) at -5/6, -1/3, 1/7, 2/3"


def check_step(plant):
    G = [Fr(j, 6) for j in range(-6, 7)]
    ident = plant == "step_identity"
    n = 0
    for lk, lk1, uk, uk1 in itertools.product(G, repeat=4):
        if not (lk < uk and lk1 < uk1 and lk1 > -1 and uk < 1):
            continue
        rec_l = (lk <= lk1) if ident else (lk <= f(lk1))
        rec_u = (uk <= uk1) if ident else (ft(uk) <= uk1)
        if not (rec_l and rec_u):
            continue
        n += 1
        if lk > lk1 or uk > uk1:
            return False, "NO_STRICT_STEP", f"a decrease at {(lk, lk1, uk, uk1)}"
        if not (lk1 > lk or uk1 > uk):
            return False, "NO_STRICT_STEP", f"no strict increase at (lam_k, lam_k+1, ups_k, ups_k+1) = {(str(lk), str(lk1), str(uk), str(uk1))}"
    return True, "STRICT_STEP", f"{n} admissible quadruples on the grid j/6; each has lam or ups strictly increasing, neither decreasing"


def check_ray(plant):
    x = sp.symbols("x")
    g_up, g_dn = x, x
    for k in range(0, 21):
        if sp.simplify(g_up - x / (1 - k * x)) != 0 or sp.simplify(g_dn - x / (1 + k * x)) != 0:
            return False, "BELOW_BOUND", f"closed form fails at k = {k}"
        if sp.simplify(x / (1 - k * x) + sp.Rational(1, k + 1) - (x + 1) / ((1 - k * x) * (k + 1))) != 0:
            return False, "BELOW_BOUND", f"bound identity fails at k = {k}"
        if sp.simplify(x / (1 + k * x) - sp.Rational(1, k + 1) - (x - 1) / ((1 + k * x) * (k + 1))) != 0:
            return False, "BELOW_BOUND", f"mirror identity fails at k = {k}"
        g_up, g_dn = sp.simplify(ft(g_up)), sp.simplify(f(g_dn))
    xs_up = [sp.Rational(-11, 10)] if plant == "ray_below" else [sp.Integer(-1), sp.Rational(-1, 2), sp.Rational(-1, 7)]
    for v in xs_up:
        for k in range(0, 21):
            val = v / (1 - k * v)
            if val < -sp.Rational(1, k + 1):
                return False, "BELOW_BOUND", f"ft^{k}({v}) = {val} < -1/{k + 1}"
    for v in (sp.Integer(1), sp.Rational(1, 3)):
        for k in range(0, 21):
            if v / (1 + k * v) > sp.Rational(1, k + 1):
                return False, "BELOW_BOUND", f"f^{k}({v}) > 1/{k + 1}"
    # NB2's pencil: centre P_{-1} = -n, radius k+1, read at P_k = k n: centre at C = -1, upward curvature 1/(C - k) = -1/(k+1).
    if any(sp.Rational(1, -1 - k) != -sp.Rational(1, k + 1) for k in range(0, 21)):
        return False, "BELOW_BOUND", "pencil curvature"
    return True, "BOUND_HOLDS", "ft^k(x) >= -1/(k+1) on [-1, 0), f^k(x) <= 1/(k+1) on (0, 1], k <= 20; equality at x = -1 (the pencil)"


CHECKS = {"MONO": check_mono, "STEP": check_step, "RAY": check_ray}


def run(plant):
    return {n: c(plant) for n, c in CHECKS.items()}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", choices=sorted(PLANTS))
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        bad = 0
        for p, (target, reason) in PLANTS.items():
            res = run(p)
            red = [n for n, r in res.items() if not r[0]]
            fired = red == [target] and res[target][1] == reason
            bad += not fired
            print(f"plant {p:13s}: red {red}, reason {res[target][1]} -> {'FIRES' if fired else 'DEFECT'}")
        res = run(None)
        red = [n for n, r in res.items() if not r[0]]
        print(f"faithful run: red {red} -> {'PASS' if not red else 'DEFECT'}")
        for n, (ok, reason, detail) in res.items():
            print(f"  {n:5s}: {reason:12s} {detail}")
        return 1 if (bad or red) else 0
    res = run(args.plant)
    for n, (ok, reason, detail) in res.items():
        print(f"{n:5s}: {'GREEN' if ok else 'RED  '} {reason:12s} {detail}")
    red = [n for n, r in res.items() if not r[0]]
    if args.plant is None:
        return 0 if not red else 1
    target, reason = PLANTS[args.plant]
    return 0 if (red == [target] and res[target][1] == reason) else 1


if __name__ == "__main__":
    sys.exit(main())
