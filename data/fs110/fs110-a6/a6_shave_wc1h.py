#!/usr/bin/env python3
"""FS110-A6: N4-SHAVE's equality case (sigma_g = sigma_h) on FS110-Y4's fragment WC1H, checked exactly by FS110-Y's checker.

WC1H (tools/fs110_y_cone.py, imported, not edited): a single colour-1 horn at v along +a, flanks 2 above and 3 below; at N the colour-3
sector (0 deg, 60 deg) has its lower ray ALONG +a (a straight boundary, curvature 0), so its shadow near v is {y > 0} (N4-SHADOW,
f(0) = 0: sigma_h = 0); the mirror at S' gives the colour-2 shadow {y < 0} (sigma_g = 0).  N4-SHAVE: sigma_g <= sigma_h, so the tip
is recoloured by its flanks along Sigma = the tangent line y = 0: above by 2 (g), below by 3 (h).  Y4 tested only single-colour tips.

Expected: SPLIT -> ACCEPT.  Plants, each for its own reason: tilt the split line up (slope +1/200: colour 3 above y = 0, inside the
3-shadow) -> REJECT at (tipL, yN) only; tilt it down (slope -1/200) -> REJECT at (tipU, xS) only.  Controls: Y4's own single-colour tip
tests (tip -> 2, tip -> 3) REJECT as recorded.
"""
from __future__ import annotations
import sys, os
from fractions import Fraction as Fr
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..", "tools"))
import fs110_y_cone as Y   # noqa: E402
C = Y.C
Seg = C.Seg


def split(slope):
    T = Y.build_trivalent_hard(tipcol=2)            # the tip exists as its own tile ("tip"), bounded by upper arc, Seg(AM, BM), lower arc
    up_arc, mid_seg, lo_arc = T["tip"][1]
    assert mid_seg.P == Y.AM and mid_seg.Q == Y.BM and Y.AM[0] == Y.BM[0]
    x = Y.AM[0]
    M0 = (x, C.q(Fr(slope)) * x)                    # on Seg(AM, BM): |slope * x| < 4/6401
    assert Y.BM[1] < M0[1] < Y.AM[1]
    del T["tip"]
    T["tipU"] = (2, [up_arc, Seg(Y.AM, M0), Seg(M0, Y.V)])
    T["tipL"] = (3, [Seg(Y.V, M0), Seg(M0, Y.BM), lo_arc])
    return T


def run(name, T, want, want_bad=None):
    rows, bad = Y.check_fragment(T)
    got = "REJECT" if bad else "ACCEPT"
    ok = got == want and (want_bad is None or sorted(bad) == sorted(want_bad))
    print(f"== {name}: {len(T)} tiles, {len(rows)} same-colour pairs; want {want} {want_bad or ''} got {got} {bad}  {'ok' if ok else 'MISMATCH'}")
    return ok


if __name__ == "__main__":
    ok = True
    ok &= run("WC1H shaved along y = 0 (N4-SHAVE, sigma_g = sigma_h = 0)", split(0), "ACCEPT")
    ok &= run("plant: split tilted up (+1/200)", split(Fr(1, 200)), "REJECT", [("tipL", "yN")])
    ok &= run("plant: split tilted down (-1/200)", split(Fr(-1, 200)), "REJECT", [("tipU", "xS")])
    ok &= run("control: Y4 tip -> 2", Y.build_trivalent_hard(tipcol=2), "REJECT")
    ok &= run("control: Y4 tip -> 3", Y.build_trivalent_hard(tipcol=3), "REJECT")
    print("ALL AS PREDICTED" if ok else "SOME MISMATCH")
    sys.exit(0 if ok else 1)
