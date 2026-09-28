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

  VOTES  the vote table at a leaving centre q (N3-FAIL, stage N3-3): u cubic with colours i, j, k; tau_ij a unit arc of omega(q) leaving u
         (its outer colour s_out is excluded inside omega(u) near q, its inner colour s_in outside: N112-U1's shadows), tau_ik, tau_jk voting
         'in' or 'out' (S-V Prop. 9: an arc excludes its two colours on the side it votes).  Also DEG2: tau_ij, tau_ik both on omega(q).
         Checked over the whole finite case table: u's strip fails at q exactly in the stated cases, and then the colours of c(u) allowed
         inside omega(u) near q are exactly the s_in colours, outside exactly the s_out colours.  Expected: LAW_HOLDS.
         plant votes_noshadow: the unit arc's shadow exclusions dropped -> an s_out colour is allowed inside -> RED, LAW_BROKEN.
  ANTI   the antipodal vote lemma (N3-ANTI): an arc from u = 0 with tangent t and upward curvature kappa votes at q = +e and q = -e by the
         sign of F(+/-e) = |x -/+ e|^2 - 1; F(+e) - ... : F(+/-e) = -/+ 2 e.x + |x|^2, and on exact circle points x (rational parametrisation)
         at named kappa in {-2, -1, -1/2, 0, 1/2, 1, 2}, named directions and delta in {1/10, 1/100}: at least one of F(+e), F(-e) is > 0 (an
         'in' vote), never both < 0; kappa = +/-1 with t perpendicular to e gives exactly 0 at one antipode.  Expected: IN_VOTE.
         plant anti_half: the antipodes replaced by +/- e/2 (not on omega(u)) -> both negative -> RED, NO_IN_VOTE.

Exit 0 iff the requested run behaves as expected (faithful: all GREEN; --plant X: exactly X RED with its reason; --self-test: all of it).
"""
from __future__ import annotations

import argparse
import itertools
import sys
from fractions import Fraction as Fr

import sympy as sp

REASONS = ("IDENTITY", "NOT_BELOW", "STRICT_STEP", "NO_STRICT_STEP", "BOUND_HOLDS", "BELOW_BOUND", "LAW_HOLDS", "LAW_BROKEN",
           "IN_VOTE", "NO_IN_VOTE")
PLANTS = {"mono_swap": ("MONO", "NOT_BELOW"), "step_identity": ("STEP", "NO_STRICT_STEP"), "ray_below": ("RAY", "BELOW_BOUND"),
          "votes_noshadow": ("VOTES", "LAW_BROKEN"), "anti_half": ("ANTI", "NO_IN_VOTE")}


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


def check_votes(plant):
    C = {"i", "j", "k"}
    shadows = plant != "votes_noshadow"
    rows = 0
    # single unit arc tau_ij on omega(q); tau_ik, tau_jk vote
    for s_ik, s_jk, s_out in itertools.product(("in", "out"), ("in", "out"), ("i", "j")):
        s_in = ({"i", "j"} - {s_out}).pop()
        ex = {"in": set(), "out": set()}
        ex[s_ik] |= {"i", "k"}
        ex[s_jk] |= {"j", "k"}
        if shadows:
            ex["in"].add(s_out)
            ex["out"].add(s_in)
        fails = ex["in"] != C and ex["out"] != C
        shared_with_in_voter = "i" if s_ik == "in" else "j"
        predicted = (s_ik != s_jk) and s_out == shared_with_in_voter
        rows += 1
        if fails:
            if (C - ex["in"]) != {s_in} or (C - ex["out"]) != {s_out}:
                return False, "LAW_BROKEN", f"allowed in {sorted(C - ex['in'])}, out {sorted(C - ex['out'])} vs s_in {s_in}, s_out {s_out}"
        if fails != predicted:
            return False, "LAW_BROKEN", f"failure pattern differs at {(s_ik, s_jk, s_out)}"
    # DEG2: tau_ij, tau_ik on omega(q), colour i between them on one side; tau_jk votes
    for i_side, s_jk in itertools.product(("in", "out"), ("in", "out")):
        s_ins = {"i"} if i_side == "in" else {"j", "k"}
        s_outs = C - s_ins
        ex = {"in": set(), "out": set()}
        ex[s_jk] |= {"j", "k"}
        if shadows:
            ex["in"] |= s_outs
            ex["out"] |= s_ins
        fails = ex["in"] != C and ex["out"] != C
        rows += 1
        if fails and ((C - ex["in"]) - s_ins or (C - ex["out"]) - s_outs or not (C - ex["in"]) or not (C - ex["out"])):
            return False, "LAW_BROKEN", f"DEG2 {(i_side, s_jk)}: allowed in {sorted(C - ex['in'])}, out {sorted(C - ex['out'])}"
    return True, "LAW_HOLDS", f"{rows} case rows: at a failing leaving centre, inside allows only s_in colours, outside only s_out colours"


def check_anti(plant):
    scale = sp.Rational(1, 2) if plant == "anti_half" else sp.Integer(1)
    dirs = [(sp.Integer(0), sp.Integer(1)), (sp.Rational(3, 5), sp.Rational(4, 5)), (sp.Integer(1), sp.Integer(0))]
    n = 0
    for kap in (sp.Integer(-2), sp.Integer(-1), sp.Rational(-1, 2), sp.Integer(0), sp.Rational(1, 2), sp.Integer(1), sp.Integer(2)):
        for d in (sp.Rational(1, 10), sp.Rational(1, 100)):
            # exact point on the circle of upward curvature kap tangent to t = (1, 0) at 0: rational parametrisation by s = tan(theta/2)
            if kap == 0:
                x = (d, sp.Integer(0))
            else:
                sv = d * kap / 2          # arc parameter ~ half the turning angle
                x = (2 * sv / (kap * (1 + sv ** 2)), 2 * sv ** 2 / (kap * (1 + sv ** 2)))
            for e in dirs:
                ep = (scale * e[0], scale * e[1])
                Fp = (x[0] - ep[0]) ** 2 + (x[1] - ep[1]) ** 2 - 1
                Fm = (x[0] + ep[0]) ** 2 + (x[1] + ep[1]) ** 2 - 1
                n += 1
                if Fp < 0 and Fm < 0:
                    return False, "NO_IN_VOTE", f"kappa {kap}, e {e}: both antipodes vote out"
                if not (Fp > 0 or Fm > 0):
                    return False, "NO_IN_VOTE", f"kappa {kap}, e {e}: no antipode votes in (F = {Fp}, {Fm})"
                if e == dirs[0] and abs(kap) == 1 and scale == 1 and not (Fp == 0 or Fm == 0):
                    return False, "NO_IN_VOTE", f"kappa {kap}: the unit arc should vote exactly 0 at one antipode"
    return True, "IN_VOTE", f"{n} (arc, antipodal pair) cases: every arc votes 'in' at one antipode at least; unit arcs vote 0 exactly on their own circle"


CHECKS = {"MONO": check_mono, "STEP": check_step, "RAY": check_ray, "VOTES": check_votes, "ANTI": check_anti}


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
