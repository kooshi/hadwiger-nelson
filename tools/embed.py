#!/usr/bin/env python3
"""The unit-distance DEFECT of a graph — M44's spine instrument.

    defect(H) = min over drawings of H in the plane of  max over edges |length - 1|

`defect(H) = 0` exactly when `H` is a unit-distance graph, so for a graph certified
NOT 6-colourable the defect is a continuous measure of how close it sits to settling the
top of the Hadwiger-Nelson problem: a non-6-colourable graph with defect 0 IS a proof that
chi(R^2) >= 7 (`Proofs/HadwigerNelson/Limit.lean`, `add_one_le_chromaticNumber_unitDistance_of_approx`).

WHAT A ROW LICENSES, AND WHAT IT DOES NOT
-----------------------------------------
Every number this tool reports is an UPPER bound, and the asymmetry is the whole reading rule:

  * a SMALL `defect_upper` is a hard fact. An explicit drawing achieves it, the drawing is
    in the row, and the bound is certified in exact rational arithmetic (below). It licenses
    "this graph is close to being a unit-distance graph".
  * a LARGE `defect_upper` licenses NOTHING. Local optimization may simply have missed the
    good drawing. It does NOT license "this graph is far from being a unit-distance graph" —
    that would need a lower bound, which this tool never produces and cannot.

The field is therefore named `defect_upper`, never `defect`: a reader cannot treat it as a
minimum without typing a name that contradicts them.

HOW THE BOUND IS CERTIFIED
--------------------------
The search is float (scipy least-squares from many random restarts, then a p-norm
continuation sharpening toward the max-norm). The RESULT is not trusted as a float: the
best drawing found is rounded to rationals, and the reported bound is computed on those
rationals in exact arithmetic. For an edge with exact squared length q, rational a, b with
a^2 <= q <= b^2 give |sqrt(q) - 1| <= max(|a - 1|, |b - 1|). So `defect_upper` is a rational
number, exactly valid for the exact rational drawing stored beside it, and re-checkable by
anyone in a few lines without re-running any search. The artifact is the certificate, never
the search.
"""

import argparse
import json
import math
import os
import random
import time
from fractions import Fraction as F

import numpy as np
from scipy.optimize import least_squares

SCHEMA = ("m44-defect v1 (plans/M44-epsilon-dial.md). Unit of claim: one GRAPH. "
          "`defect_upper` is an UPPER bound on min-over-drawings of max-over-edges "
          "|length-1|, certified in exact rational arithmetic for the rational drawing in "
          "`drawing`. A SMALL value is a fact (the drawing achieves it); a LARGE value "
          "licenses NOTHING (local search may have missed) and must never be read as "
          "'far from unit-distance'. No row here lower-bounds the defect. The delta "
          "(avoided-interval) rows live in a SEPARATE artifact, build/m44-interval.json, "
          "because they sit on a different axis and must not share a plot.")

ART = "build/m44-dial.json"


# ---------------------------------------------------------------- exact certification

def _sqrt_bounds(q: F, denom: int = 10 ** 12) -> tuple[F, F]:
    """Rationals a <= sqrt(q) <= b.  Integer-sqrt on the scaled numerator; no floats."""
    if q < 0:
        raise SystemExit(f"DEFECT: negative squared length {q}")
    scaled = (q.numerator * denom * denom) // q.denominator
    r = math.isqrt(scaled)
    a = F(r, denom)
    b = F(r + 1, denom)
    if a * a > q or b * b < q:
        raise SystemExit("DEFECT: sqrt bracketing failed — the exact check is broken")
    return a, b


def certified_defect(pts: list[tuple[F, F]], edges) -> F:
    """The exact max over edges of |length - 1| for a RATIONAL drawing, as a rational upper
    bound. This is the number a row reports; the float search only proposes the drawing."""
    worst = F(0)
    for (i, j) in edges:
        dx = pts[i][0] - pts[j][0]
        dy = pts[i][1] - pts[j][1]
        q = dx * dx + dy * dy
        lo, hi = _sqrt_bounds(q)
        worst = max(worst, abs(lo - 1), abs(hi - 1))
    return worst


def _rationalize(z: np.ndarray, denom: int = 10 ** 6) -> list[tuple[F, F]]:
    return [(F(round(float(x) * denom), denom), F(round(float(y) * denom), denom))
            for x, y in z.reshape(-1, 2)]


# ---------------------------------------------------------------- the search

def _residuals(flat, ei, ej, power):
    z = flat.reshape(-1, 2)
    d = np.linalg.norm(z[ei] - z[ej], axis=1)
    r = d - 1.0
    if power == 2:
        return r
    # p-norm continuation: weight the worst edges harder, pushing l2 toward l-infinity
    w = np.abs(r) ** ((power - 2) / 2.0)
    return r * w


def _one_restart(seed, n, ei, ej, powers):
    rng = np.random.default_rng(seed)
    z = rng.normal(scale=0.5 * math.sqrt(n), size=2 * n)
    for p in powers:
        out = least_squares(_residuals, z, args=(ei, ej, p), method="trf",
                            max_nfev=200 * n)
        z = out.x
    zz = z.reshape(-1, 2)
    d = np.linalg.norm(zz[ei] - zz[ej], axis=1)
    return float(np.max(np.abs(d - 1.0))), z


def defect_upper(n: int, edges, restarts: int = 64, workers: int = 30,
                 powers=(2, 4, 8, 16), seed0: int = 0):
    """Search for a low-defect drawing, then certify the best one exactly."""
    if not edges:
        return F(0), [(F(0), F(0))] * n, 0
    ei = np.array([e[0] for e in edges])
    ej = np.array([e[1] for e in edges])
    from concurrent.futures import ProcessPoolExecutor
    best = (float("inf"), None)
    with ProcessPoolExecutor(max_workers=workers) as ex:
        futs = [ex.submit(_one_restart, seed0 + s, n, ei, ej, powers) for s in range(restarts)]
        for f in futs:
            v, z = f.result()
            if v < best[0]:
                best = (v, z)
    pts = _rationalize(best[1])
    return certified_defect(pts, edges), pts, best[0]


# ---------------------------------------------------------------- artifact

def record(row):
    os.makedirs("build", exist_ok=True)
    art = {"schema": SCHEMA, "rows": []}
    if os.path.exists(ART):
        with open(ART) as fh:
            art = json.load(fh)
    art["schema"] = SCHEMA
    art["rows"] = [r for r in art["rows"] if r.get("object") != row.get("object")] + [row]
    with open(ART, "w") as fh:
        json.dump(art, fh, indent=1, default=str)


def measure(name, n, edges, restarts, workers, note=""):
    t0 = time.time()
    ub, pts, flt = defect_upper(n, edges, restarts=restarts, workers=workers)
    row = {"kind": "defect", "object": name, "n": n, "m": len(edges),
           "defect_upper": str(ub), "defect_upper_float": float(ub),
           "search_float": flt, "restarts": restarts,
           "drawing": [[str(x), str(y)] for x, y in pts],
           "seconds": round(time.time() - t0, 1), "note": note}
    record(row)
    return row


# ---------------------------------------------------------------- controls

def _spindle():
    s = json.load(open("tools/spindle.json"))
    den = s["denom"]
    coords = s["coords"]
    pts = []
    for c in coords:
        # coords are exact in a quadratic field: [a, b] meaning (a + b*sqrt(11)) / denom etc.
        pts.append(c)
    return len(coords), [tuple(e) for e in s["edges"]], pts, den


def self_test(workers=30):
    """Red and green, both ways. A control that has not been seen to fail is not a control."""
    ok = True

    def expect(name, got, want):
        nonlocal ok
        good = want(got)
        print(f"  [{'ok ' if good else 'FAIL'}] {name}: {got}")
        ok = ok and good

    # exact-arithmetic check of the certifier itself: a perfect unit triangle has defect 0
    tri = [(F(0), F(0)), (F(1), F(0)), (F(1, 2), F(0))]  # deliberately WRONG third point
    expect("planted red — a squashed triangle is NOT defect 0",
           certified_defect(tri, [(0, 1), (1, 2), (0, 2)]) > F(1, 100), lambda g: g)

    # green: the certifier on a genuinely unit-distance drawing (rational, so use a rhombus
    # of unit sides built from a 3-4-5-like rational point is impossible; use a unit square
    # path whose two edges are exactly 1)
    sq = [(F(0), F(0)), (F(1), F(0)), (F(1), F(1))]
    expect("green — two exact unit edges certify below 1e-9",
           certified_defect(sq, [(0, 1), (1, 2)]) < F(1, 10 ** 9), lambda g: g)

    # green: the optimizer finds a unit-distance realization of the Moser spindle from
    # RANDOM starts (the spindle IS a unit-distance graph, so its defect is 0)
    sp = json.load(open("tools/spindle.json"))
    n = len(sp["names"])
    edges = [tuple(e) for e in sp["edges"]]
    ub, _, flt = defect_upper(n, edges, restarts=32, workers=workers)
    expect("green — optimizer reaches ~0 on the Moser spindle (a unit-distance graph)",
           flt, lambda g: g < 1e-6)

    # red: K4 is not a unit-distance graph; the optimizer must NOT reach 0
    k4 = [(i, j) for i in range(4) for j in range(i + 1, 4)]
    ub4, _, flt4 = defect_upper(4, k4, restarts=64, workers=workers)
    expect("red — K4 never reaches 0 (it is not a unit-distance graph)",
           flt4, lambda g: g > 1e-3)

    print("SELF-TEST", "PASS" if ok else "FAIL")
    return ok


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--graph", type=str, help="JSON with {name, n, edges}")
    ap.add_argument("--restarts", type=int, default=64)
    ap.add_argument("--workers", type=int, default=30)
    a = ap.parse_args()
    if a.self_test:
        raise SystemExit(0 if self_test(a.workers) else 1)
    if a.graph:
        g = json.load(open(a.graph))
        row = measure(g["name"], g["n"], [tuple(e) for e in g["edges"]],
                      a.restarts, a.workers, g.get("note", ""))
        print(json.dumps({k: v for k, v in row.items() if k != "drawing"}, indent=1))


if __name__ == "__main__":
    main()
