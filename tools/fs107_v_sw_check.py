#!/usr/bin/env python3
"""FS107-V: numerical check of the geometric inequalities behind V's proof of R's FS107-R-SW (the s^3 part).

Setting (V's reading of "a same-multicolour unit pair at flat boundaries of scale s", the mirrored tangent case):
p = (0, 0), q = (1, 0); boundaries perpendicular to pq. The FACING colour b occupies {a_x > 0} in B(p, s) and
{b_x < 1} in B(q, s). V's proof uses two sub-rectangles (coordinates a = (alpha, y), b = (1 - beta, y')):
    P      = {0 < alpha < s^2/32,  -s/2 < y  < -s/4}      P_good = P with -s/2 < y < -3s/8
    Q      = {0 < beta  < s^2,      0   < y' <  s/2}
and three inequalities, for every eps <= s^2/32 and s <= 1/2:
    (i)   |band(a) ∩ Q| >= eps*s        for a in P_good
    (ii)  |band(b) ∩ P| <= 0.6*eps*s    for b in Q
    (iii) P, Q lie inside the two half-discs.
where band(x) = {y : 1 - eps <= |x - y| <= 1 + eps}. Then 0 = ∫_{P\\H} |band(a) ∩ (Q\\H)| da gives
|H ∩ P| + 0.6 |H ∩ Q| >= |P_good| = s^3/256.

The band set along each fibre is an exact interval (the distance is monotone in beta, resp. alpha, for fixed y, y'),
so each fibre length is a closed form; the only numerical step is the 1-D quadrature over y' (resp. y), done with a
fine midpoint rule, and the extremes over a, b are taken over grids (a check of the derived inequalities on samples,
[tools, float]; the proof is in the record).

`--plant` swaps in the AWAY-facing colour's regions ({a_x < 0}, {b_x > 1}): there band(a) ∩ Q is empty away from the
boundary, so (i) must fail -- for its own reason (the wrong orientation), not the scaffolding.
"""
from __future__ import annotations

import math
import sys

import numpy as np

PLANT = "--plant" in sys.argv


def fibre_len(c, delta, eps, hi):
    """Length of {t in (0, hi) : 1 - eps <= sqrt((1 - c - t)^2 + delta^2) <= 1 + eps} (facing geometry), or the away
    geometry sqrt((1 + c + t)^2 + delta^2) under PLANT.  c = the fixed depth (alpha or beta), t = the free depth."""
    lo_sq, hi_sq = (1 - eps) ** 2 - delta ** 2, (1 + eps) ** 2 - delta ** 2
    if PLANT:
        # away: 1 + c + t in [sqrt(lo_sq), sqrt(hi_sq)]
        a = np.sqrt(np.maximum(lo_sq, 0)) - 1 - c
        b = np.sqrt(hi_sq) - 1 - c
    else:
        # facing: 1 - c - t in [sqrt(lo_sq), sqrt(hi_sq)]  =>  t in [1 - c - sqrt(hi_sq), 1 - c - sqrt(lo_sq)]
        a = 1 - c - np.sqrt(hi_sq)
        b = 1 - c - np.sqrt(np.maximum(lo_sq, 0))
    return np.clip(np.minimum(b, hi) - np.maximum(a, 0), 0, None)


def check(s, eps, n=4000):
    ys_good = np.linspace(-s / 2, -3 * s / 8, 25)
    alphas = np.linspace(0, s * s / 32, 25)
    yq = (np.arange(n) + 0.5) * (s / 2) / n                     # midpoints of (0, s/2)
    worst_i = min(float(np.sum(fibre_len(al, yq - y, eps, s * s)) * (s / 2) / n) for al in alphas for y in ys_good)
    betas = np.linspace(0, s * s, 25)
    yqs = np.linspace(0, s / 2, 25)
    yp = -s / 2 + (np.arange(n) + 0.5) * (s / 4) / n            # midpoints of (-s/2, -s/4)
    worst_ii = max(float(np.sum(fibre_len(be, yv - yp, eps, s * s / 32)) * (s / 4) / n) for be in betas for yv in yqs)
    inside = (s * s / 32) ** 2 + (s / 2) ** 2 < s * s and (s * s) ** 2 + (s / 2) ** 2 < s * s
    ok = worst_i >= eps * s * (1 - 1e-3) and worst_ii <= 0.6 * eps * s and inside
    print(f"s={s:<6} eps={eps:.3e}: min_(P_good) |band ∩ Q| / (eps s) = {worst_i / (eps * s):.4f} (need >= 1);"
          f"  max_Q |band ∩ P| / (eps s) = {worst_ii / (eps * s):.4f} (need <= 0.6);  inside = {inside}  -> {'PASS' if ok else 'FAIL'}")
    return ok


def main():
    cases = [(0.5, 0.5 ** 2 / 32), (0.5, 1e-5), (0.2, 0.2 ** 2 / 32), (0.2, 1e-6), (0.05, 0.05 ** 2 / 32), (0.05, 1e-8)]
    oks = [check(s, e) for s, e in cases]
    allok = all(oks)
    if PLANT:
        print("PLANT (away-facing colour): must FAIL ->", "OK (fired)" if not allok else "NOT FIRED -- the check is blind")
        sys.exit(0 if not allok else 1)
    print("ALL PASS" if allok else "SOME FAIL")
    sys.exit(0 if allok else 1)


if __name__ == "__main__":
    main()
