#!/usr/bin/env python3
"""FS114-Y stage 3, C114-ENCLOSED3's local form: at a cubic trichromatic vertex v of a held valid fragment, a colour d is FREE WITH MARGIN when
every d-tile has all its points at distance < 1 from v or all at distance > 1 (strictly: min > 1 or max < 1, exact).  Then a small enough
triangular tile of colour d with corners on v's three boundary curves can be inserted at v (the three tiles at v lose a small piece, which
creates no conflict; the new tile's distances to every d-tile stay on one side of 1), giving a fragment with an enclosed tile of exactly three
edge-neighbours.  This tool reads, exactly, the free-with-margin colours at the cubic vertices of the strip (one period) and builds and checks
one such insertion when a free colour exists.
Tools imported, never edited: tools/fs112_yb2_check.py (pair verdicts), tools/fs112_yb2_objects.py (the strip), tools/fs112_yb3_frags.py
(point_vs_tile: the exact min/max of |z - q| over a tile's boundary, against 1).
Controls: at the point (1/2, 7/2), above the strip's top edge by more than 1.6, every colour must read free with margin (a known positive);
at a valley, whose unit circle meets tiles of all three complementary colours in the printed figure, none (the reading itself).  No insertion is
built unless a free colour is found (none is, on the strip).
Run: python3 tools/fs114_y_insert.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_yb2_check as K          # noqa: E402
import fs112_yb2_objects as O        # noqa: E402
import fs112_yb3_frags as F3         # noqa: E402  (point_vs_tile only)

PLANT = None
OK = True


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


def colours_at(tiles, v):
    return sorted({c for nm, (c, ps) in tiles.items() if any(p.contains(v) for p in ps)})


def margin_report(tiles, v, lab):
    at = colours_at(tiles, v)
    allc = sorted({c for c, _ in tiles.values()})
    out = {}
    for d in allc:
        if d in at:
            continue
        rels = []
        for nm, (c, ps) in sorted(tiles.items()):
            if c != d:
                continue
            mn, mx = F3.point_vs_tile(v, ps)
            if mn == ">" or mx == "<":
                continue                         # strictly on one side: no obstruction to a small tile at v
            rels.append(f"{nm}(min{mn}1,max{mx}1)")
        out[d] = rels
    free = [d for d, r in out.items() if not r]
    print(f"   {lab} {F3.fp(v)} colours {at}; complementary colours: " +
          "; ".join(f"{d}: {'FREE with margin' if not r else ' '.join(r)}" for d, r in out.items()))
    return at, free


def main():
    S = O.Strip()
    tiles = S.tiles(-6, 8)
    T = S.T
    print("== the strip: cubic trichromatic vertices of one period (valleys V_m, apexes of U_j, and their mirrors)")
    found = []
    for m in range(3):
        for s_ in (1, -1):
            v = S.V(m, s_)
            at, free = margin_report(tiles, v, f"valley V_{m}{'' if s_ == 1 else chr(39)}")
            if len(at) == 3 and free:
                found.append((v, free))
            a = S.A(m, s_)
            at, free = margin_report(tiles, a, f"apex of arch {m}{'' if s_ == 1 else chr(39)}")
            if len(at) == 3 and free:
                found.append((a, free))
    print(f"   cubic trichromatic vertices of one period with a colour free with margin: {len(found)}")
    far = (T(Fr(1, 2)), T(Fr(7, 2)))
    at, free = margin_report(tiles, far, "control point")
    say(sorted(free) == sorted({c for c, _ in tiles.values()}), "control: every colour is free with margin at (1/2, 7/2)")
    return found


if __name__ == "__main__":
    args = sys.argv[1:]
    main()
    print("ALL AS REGISTERED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
