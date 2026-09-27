#!/usr/bin/env python3
"""FS110-A6, card A6-C2: a DOUBLY SHADOWED single horn at a cubic vertex, with N and S' ordinary trivalent vertices.

WC1H (tools/fs110_y_cone.py, imported, not edited) with ONE change: at N the colour-3 sector's lower boundary, which ran along +a (curvature
0), is bent to the arc of the circle centred (0,-3), radius 4, through N (upward curvature -1/4, Y ~ -T^2/8; inside Y4's window R_y =
[-T^2/6, T^2/2)); the colour-4 ring piece that wraps N follows it.  Mirror at S' by the fragment's own symmetry.  N4-SHADOW:
sigma_h = f(-1/4) = -1/3, sigma_g = +1/3, both inside (kappa_-, kappa_+) = (-1/2, 1/2): doubly shadowed (N4-SHAVE blocked).
At v every colour has ONE sector (horn 1, flanks 2, 3): MERGE and MERGE-RAY do not apply; N, S' carry no repeated colour.

Runs (each with its predicted verdict): the fragment (ACCEPT); every tip recolouring into one colour 2..6 (REJECT); the two-colour
splits: along y = 0, and along a chord below Sigma(sigma_h) giving colour 3 all it may take (REJECT, at the side predicted).  Control:
the unbent WC1H's split along y = 0 (ACCEPT, as in a6_shave_wc1h.py).  Plant: bend N's boundary to curvature -1/2 about (0,-1)
(outside R_y's reach, sigma_h = f(-1/2) = -1 ... the colour-3 tile at N then sees v's colour-3 tile at distance exactly 1): REJECT at (v3, yN).
"""
from __future__ import annotations
import sys, os
from fractions import Fraction as Fr
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "tools"))
import fs110_y_cone as Y   # noqa: E402
C = Y.C
Seg, Arc = C.Seg, C.Arc


def circ_pt_c(cy, R, m):
    """rational point right of the top of the circle centred (0, cy), radius R: (R s, cy + R c)."""
    m, R = Fr(m), Fr(R)
    s, c = 2 * m / (1 + m * m), (1 - m * m) / (1 + m * m)
    return (C.q(R * s), C.q(Fr(cy) + R * c))


def bend(T, cy, R, m):
    """replace R = (1/10, 1) at N by R' on the circle centred (0,cy) radius R through N, in yN and in the ring piece r2; mirror both."""
    Rold = (C.q(Fr(1, 10)), C.q(1))
    Rp = circ_pt_c(cy, R, m)
    arc = Arc((C.q(0), C.q(cy)), Fr(R), Rp, Y.NPT)

    def fix(prims):
        out = []
        for p in prims:
            if isinstance(p, Seg) and p.P == Rold and p.Q == Y.NPT: out.append(arc)
            elif isinstance(p, Seg) and p.Q == Rold and p.P == Y.NPT: out.append(arc)
            elif isinstance(p, Seg) and p.Q == Rold: out.append(Seg(p.P, Rp))
            elif isinstance(p, Seg) and p.P == Rold: out.append(Seg(Rp, p.Q))
            else: out.append(p)
        return out
    for k in ("yN", "r2"):
        col, prims = T[k]
        new = fix(prims)
        assert new != prims, k
        T[k] = (col, new)
    T["xS"] = (2, [Y.mprim(q, Y.mirror_y) for q in T["yN"][1]])
    T["r7"] = (5, [Y.mprim(q, Y.mirror_y) for q in T["r2"][1]])
    return T


def frag(tipcol=None, plant=None):
    T = Y.build_trivalent_hard(tipcol=tipcol)
    if plant == "deep":
        return bend(T, -1, 2, Fr(1, 40))             # curvature -1/2 at N: below R_y
    return bend(T, -3, 4, Fr(1, 80))                 # R' = (640/6401, 6393/6401), curvature -1/4 at N


def split(T, yM):
    up_arc, mid_seg, lo_arc = T["tip"][1]
    x = Y.AM[0]
    M0 = (x, yM)
    assert Y.BM[1] < M0[1] < Y.AM[1]
    del T["tip"]
    T["tipU"] = (2, [up_arc, Seg(Y.AM, M0), Seg(M0, Y.V)])
    T["tipL"] = (3, [Seg(Y.V, M0), Seg(M0, Y.BM), lo_arc])
    return T


def run(name, T, want, want_bad=None):
    rows, bad = Y.check_fragment(T)
    got = "REJECT" if bad else "ACCEPT"
    ok = got == want and (want_bad is None or sorted(bad) == sorted(want_bad))
    print(f"== {name}: {len(T)} tiles, {len(rows)} pairs; want {want} {want_bad or ''} got {got} {bad}  {'ok' if ok else 'MISMATCH'}")
    return ok


if __name__ == "__main__":
    x = Y.AM[0]
    ok = run("A6-C2 fragment (sigma_h = -1/3 < sigma_g = 1/3)", frag(), "ACCEPT")
    for j in (2, 3, 4, 5, 6):
        ok &= run(f"tip -> {j}", frag(tipcol=j), "REJECT")
    ok &= run("SHAVE split along y = 0", split(frag(tipcol=2), C.q(0)), "REJECT", [("tipL", "yN"), ("tipU", "xS")])
    ok &= run("SHAVE split, colour 3 below a chord under Sigma(-1/3)", split(frag(tipcol=2), -x * x / 5), "REJECT", [("tipU", "xS")])
    ok &= run("SHAVE split, colour 2 above a chord over Sigma(+1/3)", split(frag(tipcol=2), x * x / 5), "REJECT", [("tipL", "yN")])
    ok &= run("control: unbent WC1H split along y = 0", split(Y.build_trivalent_hard(tipcol=2), C.q(0)), "ACCEPT")
    ok &= run("plant: N's boundary at curvature -1/2 (below R_y)", frag(plant="deep"), "REJECT")
    print("ALL AS PREDICTED" if ok else "SOME MISMATCH")
    sys.exit(0 if ok else 1)
