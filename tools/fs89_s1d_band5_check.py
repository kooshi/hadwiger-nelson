#!/usr/bin/env python3
"""FS-89 S1D: exact checks of the corner-LEAF exit lemma at the five-colour band [1/5, 4/5] (D5-L6 in
plans/FS89-S1D-derivation.md).  Not a search: finite exact computations over the 5 and 13 digit classes.

At band 1/5 the corner characters x0 (2 x0 = theta_2) have margin 1/20; their leaf arrays are c_{m,n} + wbar^{(m,n)} d,
|d| <= 1/20, with c_{m,n} = (-1)^m c0.  An exit from a leaf block changes one digit by a class delta; along the exit column
(row) the class is multiplied by the other prime's unit (D0-L3), while the leaf part keeps rotating with |rho| = |d'|.
Conservatively, a class is ADMISSIBLE at corner c if SOME displacement rho with |rho| <= r keeps c + rho + delta in Q_{1/5}
(mod Z[i]), i.e. dist(c + delta + Z[i], Q) <= r.  The lemma holds if every nonzero exit orbit leaves the admissible
sets within a bounded number of steps (reported).

Plants (each derived to fire): r = 3/10 (a fat disc: admissible sets grow and exits survive); wb13 -> 1 in the
right exit (no rotation of the class: the rank-one freedom).  Consistency: band 1/4 with r = 0 reproduces the
corner check's verdict.
Usage: python3 tools/fs89_s1d_band5_check.py [--out data/fs89/s1d/band5-check.txt]
"""
from __future__ import annotations

import argparse
import os
import sys
from fractions import Fraction as Fr
from itertools import product

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs89_s1d_corner_check import (PI5, PI13, W5, W13, WB5, WB13, add, c, classes, complete, conj, neg,  # noqa: E402
                                   red)


def dist2_to_Q(p, lo, hi):
    """Squared distance from the class of p (mod Z[i]) to the square [lo,hi]^2."""
    q = red(p)
    best = None
    for a, b in product((-1, 0, 1), repeat=2):
        x, y = q[0] + a, q[1] + b
        dx = max(lo - x, Fr(0), x - hi)
        dy = max(lo - y, Fr(0), y - hi)
        d2 = dx * dx + dy * dy
        best = d2 if best is None or d2 < best else best
    return best


def admissible(corner, delta, lo, hi, r):
    return dist2_to_Q(add(corner, delta), lo, hi) <= r * r


def corners():
    return [red(add(c(Fr(1, 4), Fr(1, 4)), c(Fr(a, 2), Fr(b, 2)))) for a, b in product(range(2), repeat=2)]


def exits(kind, lo, hi, r, L=24, wb13=WB13):
    """For each corner and nonzero starting class, walk the exit line and return the first index where the class is
    inadmissible (None if it survives L steps)."""
    out = []
    for c0 in corners():
        if kind in ("right", "left"):
            pi = PI5 if kind == "right" else conj(PI5)
            wback = WB5 if kind == "right" else W5
            base = red(neg(c0))                      # the exit column's corner (m = +-1): -c0
            for d0 in classes(pi)[1:]:
                col = [red(add(base, d0))]
                for n in range(L - 1):               # e_{1,n+1} from e_{1,n} (13-step) and e_{0,n+1} = c0
                    s = complete(col[n], c0, wb13, PI13, wback, pi)
                    assert len(s) == 1, s
                    col.append(s[0])
                first = next((n for n, e in enumerate(col)
                              if not admissible(base, add(e, neg(base)), lo, hi, r)), None)
                out.append((c0, d0, first))
        else:
            pi = PI13 if kind == "up" else conj(PI13)
            wside = WB13 if kind == "up" else W13
            row0 = [red(c0 if m % 2 == 0 else neg(c0)) for m in range(L)]
            for e0 in classes(pi)[1:]:
                row = [red(add(row0[0], e0))]
                for m in range(L - 1):               # e_{m+1,1} from e_{m,1} (5-step) and e_{m+1,0} (13-step)
                    s = complete(row[m], row0[m + 1], WB5, PI5, wside, pi)
                    assert len(s) == 1, s
                    row.append(s[0])
                first = next((m for m, e in enumerate(row)
                              if not admissible(row0[m], add(e, neg(row0[m])), lo, hi, r)), None)
                out.append((c0, e0, first))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=None)
    args = ap.parse_args()
    lines, fails = [], 0
    log = lines.append
    lo, hi, r = Fr(1, 5), Fr(4, 5), Fr(1, 20) + Fr(1, 100)
    log(f"band [{lo}, {hi}], displacement bound r = {r} (corner margin 1/20 plus slack 1/100)")
    c0 = corners()[0]
    a5 = [d for d in classes(PI5)[1:] if admissible(red(neg(c0)), d, lo, hi, r)]
    a13 = [d for d in classes(PI13)[1:] if admissible(c0, d, lo, hi, r)]
    log(f"admissible nonzero classes at corner {c0}: 5-step (next corner -c0) {len(a5)}, 13-step {len(a13)}")
    worst = {}
    for kind in ("right", "left", "up", "down"):
        res = exits(kind, lo, hi, r)
        surv = [x for x in res if x[2] is None]
        worst[kind] = max(x[2] for x in res if x[2] is not None)
        log(f"{kind:5s} exit: {len(res)} (corner, class) pairs; surviving {len(surv)} (expected 0); "
            f"latest first failure at step {worst[kind]}")
        fails += len(surv) != 0
    log(f"=> a leaf block needs columns of height >= {max(worst['right'], worst['left']) + 1} and rows of length "
        f">= {max(worst['up'], worst['down']) + 1} for every exit to die")
    # consistency with the band-1/4 corner check (r = 0)
    res4 = [x for k in ("right", "left", "up", "down") for x in exits(k, Fr(1, 4), Fr(3, 4), Fr(0))]
    log(f"consistency: band 1/4, r = 0: surviving exits {sum(1 for x in res4 if x[2] is None)} (expected 0)")
    fails += any(x[2] is None for x in res4)
    # plants
    p1 = [x for k in ("right", "up") for x in exits(k, lo, hi, Fr(3, 10))]
    p2 = exits("right", lo, hi, r, wb13=c(1))
    n1 = sum(1 for x in p1 if x[2] is None)
    n2 = sum(1 for x in p2 if x[2] is None)
    log(f"plant r = 3/10: surviving exits {n1} (must be > 0)")
    log(f"plant wb13 -> 1 in the right exit: surviving exits {n2} (must be > 0)")
    fails += (n1 == 0) + (n2 == 0)
    log(f"RESULT: {'PASS' if fails == 0 else 'FAIL'} (fails = {fails})")
    text = "\n".join(lines) + "\n"
    sys.stdout.write(text)
    if args.out:
        with open(args.out, "w") as f:
            f.write(text)
    return 0 if fails == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
