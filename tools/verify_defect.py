#!/usr/bin/env python3
"""Independent re-check of every `defect_upper` row in build/m44-dial.json.

This file deliberately shares NO code with `tools/embed.py` — it does not import it, and it
decides the claim WITHOUT computing a square root at all (see `within`). The point is
decorrelation: re-reading the instrument that produced a number re-samples the prior that
produced it, so the check has to be written from the claim, not from the code. That paid: the
first draft of this checker failed a valid row, and the diagnosis (comparing two upper bounds
cannot decide either) produced the exact test now used.

The claim being checked, per row: for the rational drawing stored in `drawing`, every edge of
the graph has length within `defect_upper` of 1. If that holds, the row is a certificate anyone
can verify without running a search — which is the standard this project holds itself to above
rung B ("the artifact is the certificate plus the checker, never the search").

Usage:  python3 tools/verify_defect.py            # checks every row
        python3 tools/verify_defect.py --plant     # ALSO plants a corruption and expects a FAIL
"""

import argparse
import json
import sys
from fractions import Fraction as F


def within(q: F, c: F) -> bool:
    """Is a segment of squared length `q` within `c` of unit length — exactly, with no square
    root anywhere?  For 0 <= c <= 1,   |sqrt(q) - 1| <= c   iff   (1-c)^2 <= q <= (1+c)^2,
    and both sides are rational comparisons.

    The first draft of this file bracketed sqrt(q) by bisection and compared the bracket to the
    claim. That was wrong in a way worth recording, because it FAILED a valid row: the claim and
    the bracket are BOTH upper bounds on the same quantity, and comparing two upper bounds cannot
    decide whether either is valid. (The row it flagged had an axis-aligned edge whose length is
    rational, so the instrument's value was exact while the checker's bracket sat 3e-25 above it.)
    Squaring removes the square root, the tolerance, and the question."""
    if c < 0:
        return False
    if c >= 1:
        return q <= (1 + c) * (1 + c)
    return (1 - c) * (1 - c) <= q <= (1 + c) * (1 + c)


def check_row(row, edges_by_object) -> tuple[bool, str]:
    name = row["object"]
    claim = F(row["defect_upper"])
    pts = [(F(x), F(y)) for x, y in row["drawing"]]
    edges = edges_by_object.get(name)
    if edges is None:
        return False, f"{name}: no independently derived edge list to check against"
    bad = [(i, j) for (i, j) in edges
           if not within((pts[i][0] - pts[j][0]) ** 2 + (pts[i][1] - pts[j][1]) ** 2, claim)]
    ok = not bad
    return ok, (f"{name}: {len(edges)} edges, claim {float(claim):.9f} — "
                f"{'every edge within it' if ok else f'{len(bad)} edge(s) OUTSIDE it, e.g. {bad[0]}'}")


def derive_edges():
    """Re-derive each core's edge list from the addresses, from scratch, using only the exact
    interval criterion — no norm filter, no cached edge list."""
    sys.path.insert(0, "tools")
    import celllat as C  # only for the validated `interval`; the criterion is re-applied here
    out = {}
    for fn in ("build/m40-chiomega.json", "build/m43-finetail.json"):
        try:
            art = json.load(open(fn))
        except OSError:
            continue
        for c in art.get("cores", []):
            if c.get("k") != 6 or not c.get("core"):
                continue
            T = F(c["T"])
            T2 = T * T
            pts = [tuple(v) for v in c["core"]]
            es = []
            for a in range(len(pts)):
                for b in range(a + 1, len(pts)):
                    d = (F(pts[a][0] - pts[b][0]), F(pts[a][1] - pts[b][1]))
                    mn, mx = C.interval(d)
                    if mn <= T2 <= mx:
                        es.append((a, b))
            out[f"cell-core T={T}"] = es
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", action="store_true",
                    help="also corrupt a drawing and require the check to FAIL")
    a = ap.parse_args()
    art = json.load(open("build/m44-dial.json"))
    rows = [r for r in art["rows"] if r.get("kind") == "defect"]
    edges = derive_edges()
    ok_all = True
    for r in rows:
        ok, msg = check_row(r, edges)
        print(f"  [{'ok ' if ok else 'FAIL'}] {msg}")
        ok_all = ok_all and ok
    if a.plant and rows:
        bad = json.loads(json.dumps(rows[0]))
        x, y = bad["drawing"][0]
        bad["drawing"][0] = [str(F(x) + F(1, 3)), y]      # move one point by 1/3
        ok, msg = check_row(bad, edges)
        print(f"  [{'ok ' if not ok else 'FAIL'}] PLANTED: {msg}")
        ok_all = ok_all and (not ok)
    print("VERIFY", "PASS" if ok_all else "FAIL")
    raise SystemExit(0 if ok_all else 1)


if __name__ == "__main__":
    main()
