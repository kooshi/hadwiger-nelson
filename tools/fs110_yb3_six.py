#!/usr/bin/env python3
"""FS110-YB3 — exact checks for Y3-SIX's geometry (my derivation, plans/FS110-YB3-verification.md §2.7), blind to FS110-Y3's tools.

Setting: u = 0, a six-arc ring on ω(u) — the arcs are exactly 60°, change points z_k = e^{i·60k}.
 (a) |z_k − z_{k+1}| = |z_k − u| = 1 exactly (ℚ(√3)).
 (b) ω(z_{k+1}) and ω(z_{k−1}) pass through z_k with tangent directions 60k+30 and 60k−30.
 (c) the open outward wedge at z_k (outside both closed discs D(z_{k±1}, 1), to first order) is the 60° wedge about the radial n_k:
     n_k points strictly out of both discs, and the wedge's edges are the two tangent directions.
 (d) the arc direction of ω(u) at z_k (60k+90) points strictly into D(z_{k+1}, 1): the arc tile's cone meets the disc's interior.
 (e) the counting lemma: three sectors, each serving a cyclic interval of ≤ 3 of the six directions (arc length < 180°), with the
     length budget Σ (s_i − 1)^+ ≤ 3 when no sector is reflex (Σ L_i = 180°, L_i ≥ 60(s_i − 1)), or only two serving sectors: no
     assignment of the six directions to serving sectors has s_k ≠ s_{k+1} for every k.  Exhaustive over all interval triples.
 (f) the tight configuration (sectors of 120° with edges at 30°, 150°, 270°): its served sets computed exactly are
     {0,60}, {120,180}, {240,300}, so s_0 = s_1 is forced.
Run: python3 tools/fs110_yb3_six.py [--plant P1|P2]
  P1: spacing 72° instead of 60° — (a) must fire.
  P2: the lemma's size cap and budget dropped — (e) must fire (a proper assignment appears).
"""
import itertools
import sys
from fractions import Fraction as Fr

import sympy as sp

PLANT = None
if "--plant" in sys.argv:
    PLANT = sys.argv[sys.argv.index("--plant") + 1]

STEP = 72 if PLANT == "P1" else 60


def e(deg):
    t = sp.pi * sp.Rational(deg, 180)
    return sp.Matrix([sp.nsimplify(sp.cos(t)), sp.nsimplify(sp.sin(t))])


def dot(p, q):
    return sp.simplify((p.T * q)[0])


def geometry():
    fails = []
    for k in range(6):
        zk, zn, zp = e(STEP * k), e(STEP * (k + 1)), e(STEP * (k - 1))
        if sp.simplify(dot(zk - zn, zk - zn) - 1) != 0 or sp.simplify(dot(zk, zk) - 1) != 0:
            fails.append(f"(a) k={k}: |z_k − z_(k+1)|² = {sp.simplify(dot(zk - zn, zk - zn))}")
            continue
        # (b) tangent of ω(z_{k+1}) at z_k is ⟂ (z_k − z_{k+1}); check against direction 60k+30
        if dot(e(60 * k + 30), zk - zn) != 0 or dot(e(60 * k - 30), zk - zp) != 0:
            fails.append(f"(b) k={k}: tangent directions wrong")
        # (c) the radial n_k = z_k points out of both discs; the wedge half-angle is 30°
        nk = zk
        if not (dot(nk, zn - zk) < 0 and dot(nk, zp - zk) < 0):
            fails.append(f"(c) k={k}: radial not outward of both discs")
        if sp.simplify(dot(nk, e(60 * k + 30)) - sp.sqrt(3) / 2) != 0:
            fails.append(f"(c) k={k}: wedge half-angle ≠ 30°")
        # (d) the arc direction 60k+90 points into D(z_{k+1})
        if not dot(e(60 * k + 90), zn - zk) > 0:
            fails.append(f"(d) k={k}: arc direction not into D(z_(k+1))")
    return fails


def cyc_intervals(maxsize):
    out = [frozenset()]
    for start in range(6):
        for s in range(1, maxsize + 1):
            out.append(frozenset((start + j) % 6 for j in range(s)))
    return sorted(set(out), key=lambda x: (len(x), sorted(x)))


def proper_assignment(I):
    for sigma in itertools.product(range(3), repeat=6):
        if all(k in I[sigma[k]] for k in range(6)) and all(sigma[k] != sigma[(k + 1) % 6] for k in range(6)):
            return sigma
    return None


def lemma():
    fails = []
    cap = 4 if PLANT == "P2" else 3
    ints = cyc_intervals(cap)
    checked = 0
    for I in itertools.product(ints, repeat=3):
        if PLANT != "P2":
            serving = [x for x in I if x]
            ok_budget = (sum(max(len(x) - 1, 0) for x in I) <= 3) or len(serving) <= 2
            if not ok_budget:
                continue
        checked += 1
        sig = proper_assignment(I)
        if sig is not None:
            fails.append(f"(e) proper assignment exists for served sets {[sorted(x) for x in I]}: {sig}")
            break
    return fails, checked


def tight_config():
    """sectors [30,150], [150,270], [270,390]; serves n iff [lo,hi] ⊆ [n+90, n+270] (as arcs)."""
    secs = [(Fr(30), Fr(150)), (Fr(150), Fr(270)), (Fr(270), Fr(390))]
    served = []
    for lo, hi in secs:
        S = set()
        for k in range(6):
            n = 60 * k
            a = (lo - (n + 90)) % 360
            b = a + (hi - lo)
            if b <= 180:
                S.add(n)
        served.append(sorted(S))
    return served


def main():
    fails = geometry()
    lf, checked = lemma()
    fails += lf
    served = tight_config()
    print(f"mode: {'faithful' if PLANT is None else 'PLANT ' + PLANT}; spacing {STEP}°")
    print(f"(e) interval triples checked: {checked}")
    print(f"(f) tight configuration served sets: {served}")
    if served != [[240, 300], [0, 60], [120, 180]]:
        fails.append(f"(f) served sets {served}")
    for f in fails:
        print("FAIL:", f)
    if PLANT is None:
        print("RESULT:", "ALL PASS" if not fails else "FAILURES")
        return 0 if not fails else 1
    want = {"P1": "(a)", "P2": "(e)"}[PLANT]
    caught = any(f.startswith(want) for f in fails)
    print("PLANT", PLANT, "CAUGHT for its own reason" if caught else "NOT CAUGHT")
    return 0 if caught else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (AssertionError, ValueError, TypeError) as ex:
        print("CRASH (not a catch):", repr(ex))
        sys.exit(2)
