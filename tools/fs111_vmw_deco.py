#!/usr/bin/env python3
"""FS111-VMW: a decorated hexagonal seven-colouring (VMW-DECO), checked exactly -- this verifier's own reading of
"hex7 decorated with two squares per hexagon" (FS111-W-DECO-B), built blind to W's construction.

HEX7 (tools/fs111_vmw_tilings.py) with, in each hexagon H_{m,n} (centre z, colour a = (m + 3n) mod 7), two squares of side
1/100 recoloured:
  E (colour a+1): x in z_x + [sqrt3/4 - 9/100, sqrt3/4 - 8/100], y in z_y + [-1/200, 1/200]   (hugs the east neighbour, colour a+1)
  W (colour a-1): x in z_x + [-sqrt3/4 + 8/100, -sqrt3/4 + 9/100], same y                    (hugs the west neighbour, colour a-1)
Checks (exact): every square against every same-colour tile (full hexagons, a superset of the carved ones, and squares) --
1 not in (dmin, dmax); tightness (hexagon diameters); and for each colour j the triple E_{j-1,0} ~ H_{j,0} ~ W_{j+1,0}
(dmax < 1: all cross distances < 1, so each pair lies in one block) with E, W apart (dmin > 1): the block holding H_{j,0} has
diameter > 1, so class j has no tight block structure.  Plant: squares at offsets 6/100-7/100 instead of 8/100-9/100 (the
E-W pair then has dmin = sqrt3/2 + 12/100 < 1 < dmax) -> the properness check must fire on that pair.
Usage: python3 tools/fs111_vmw_deco.py [--out FILE]
"""
import sys
from fractions import Fraction as Fr

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs111_vmw_exact import Q3, P, add, polygon, pair_range, check_proper_tight   # noqa: E402
import fs111_vmw_tilings as TL                                                     # noqa: E402


def deco(N=5, lo=Fr(8, 100), hi=Fr(9, 100)):
    hx = TL.hex7(N)
    sq = {}
    s = Q3(0, Fr(1, 4))
    h = Fr(1, 200)
    for (m, n), T in hx.items():
        a = T.colour
        a1 = P(Q3(0, Fr(1, 2)), 0)
        a2 = P(Q3(0, Fr(1, 4)), Fr(3, 4))
        z = add(TL.scal(m, a1), TL.scal(n, a2))
        x0, x1 = z[0] + s - hi, z[0] + s - lo
        sq[("E", m, n)] = polygon(f"E{m},{n}", (a + 1) % 7, [P(x0, z[1] - h), P(x1, z[1] - h), P(x1, z[1] + h), P(x0, z[1] + h)])
        x0, x1 = z[0] - s + lo, z[0] - s + hi
        sq[("W", m, n)] = polygon(f"W{m},{n}", (a - 1) % 7, [P(x0, z[1] - h), P(x1, z[1] - h), P(x1, z[1] + h), P(x0, z[1] + h)])
    return hx, sq


def main():
    out = []
    hx, sq = deco()
    tiles = list(hx.values()) + list(sq.values())
    focus = [sq[(t, m, 0)] for t in "EW" for m in range(-3, 4)]
    bad, tight = check_proper_tight(tiles, focus)
    out.append(f"[DECO] squares checked: {len(focus)}; improper pairs: {len(bad)}; contacts at exactly 1: {len(tight)}")
    for T, U, w in bad[:5]:
        out.append(f"    IMPROPER {T} {U}: {w}")
    assert not bad
    b2, t2 = check_proper_tight(tiles, [hx[(0, 0)]])
    out.append(f"[DECO] hexagon H0,0 against its colour: improper {len(b2)}, tight {[(str(T), str(U), w) for T, U, w in t2]}")
    assert not b2 and t2
    for m in range(-3, 4):
        j = m % 7
        E, H, W = sq[("E", m - 1, 0)], hx[(m, 0)], sq[("W", m + 1, 0)]
        assert E.colour == H.colour == W.colour == j
        loEH, hiEH = pair_range(E, H)
        loHW, hiHW = pair_range(H, W)
        loEW, hiEW = pair_range(E, W)
        ok = hiEH < 0 and hiHW < 0 and loEW > 0
        out.append(f"[DECO] colour {j}: {E}~{H} (dmax<1: {hiEH < 0}), {H}~{W} (dmax<1: {hiHW < 0}), {E} apart {W} "
                   f"(dmin>1: {loEW > 0}) -> no tight block structure: {ok}")
        assert ok
    # plant
    hxp, sqp = deco(lo=Fr(6, 100), hi=Fr(7, 100))
    tp = list(hxp.values()) + list(sqp.values())
    badp, _ = check_proper_tight(tp, [sqp[("E", 0, 0)]])
    out.append(f"[DECO-PLANT offsets 6/100-7/100] improper pairs for E0,0: {[(str(T), str(U), w) for T, U, w in badp]}")
    assert badp and any(str(U).startswith("W") for T, U, w in badp)
    out.append("[DECO] PASSED: a.e.-proper, tight, no class has tight block structure; plant fired on the E-W pair")
    text = "\n".join(out)
    if "--out" in sys.argv:
        open(sys.argv[sys.argv.index("--out") + 1], "w").write(text + "\n")
    print(text)


if __name__ == "__main__":
    main()
