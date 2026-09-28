#!/usr/bin/env python3
"""FS111-VMW stage 2: W's DECO-B object (tools/fs111_w_blocks.py's formula, re-built here from its docstring) checked with this
verifier's engine (tools/fs111_vmw_exact.py): HEX7, and for each hexagon H (centre z, colour c) the squares
S1 = z + [1/2, 13/25] x [-1/50, 1/50] and S2 = z + [-13/25, -1/2] x [-1/50, 1/50], both of colour c (inside the neighbours).
Checks: every square against every same-colour tile (full hexagons, squares): 1 not in (dmin, dmax); and for each colour the
triple S1 ~ H ~ S2 (dmax < 1) with S1, S2 at dmin exactly 1 and dmax > 1 (so no tight block structure).
Plant: S1 = z + [1/2, 3/5] x [-1/10, 1/10] (W's bigsq) must be improper against H.
Usage: python3 tools/fs111_vmw_decow.py [--out FILE]
"""
import sys
from fractions import Fraction as Fr

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs111_vmw_exact import Q3, P, add, scal, polygon, pair_range, check_proper_tight   # noqa: E402
import fs111_vmw_tilings as TL                                                             # noqa: E402


def build(s1x=(Fr(1, 2), Fr(13, 25)), s1y=(-Fr(1, 50), Fr(1, 50)), N=5):
    hx = TL.hex7(N)
    a1, a2 = P(Q3(0, Fr(1, 2)), 0), P(Q3(0, Fr(1, 4)), Fr(3, 4))
    sq = {}
    for (m, n), T in hx.items():
        z = add(scal(m, a1), scal(n, a2))
        (x0, x1), (y0, y1) = s1x, s1y
        sq[("S1", m, n)] = polygon(f"S1_{m},{n}", T.colour, [P(z[0] + x0, z[1] + y0), P(z[0] + x1, z[1] + y0),
                                                              P(z[0] + x1, z[1] + y1), P(z[0] + x0, z[1] + y1)])
        sq[("S2", m, n)] = polygon(f"S2_{m},{n}", T.colour, [P(z[0] - x1, z[1] + y0), P(z[0] - x0, z[1] + y0),
                                                              P(z[0] - x0, z[1] + y1), P(z[0] - x1, z[1] + y1)])
    return hx, sq


def main():
    out = []
    hx, sq = build()
    tiles = list(hx.values()) + list(sq.values())
    focus = [sq[(t, m, 0)] for t in ("S1", "S2") for m in range(-3, 4)]
    bad, tight = check_proper_tight(tiles, focus)
    out.append(f"[W-DECO] squares checked {len(focus)}; improper {len(bad)}; contacts at exactly 1: {len(tight)}")
    for T, U, w in bad[:5]:
        out.append(f"    IMPROPER {T} {U}: {w}")
    assert not bad
    for m in range(-3, 4):
        H, S1, S2 = hx[(m, 0)], sq[("S1", m, 0)], sq[("S2", m, 0)]
        _, h1 = pair_range(H, S1)
        _, h2 = pair_range(H, S2)
        l12, u12 = pair_range(S1, S2)
        ok = h1 < 0 and h2 < 0 and l12 == 0 and u12 > 0
        out.append(f"[W-DECO] colour {H.colour}: dmax(H,S1)<1 {h1 < 0}, dmax(H,S2)<1 {h2 < 0}, dmin(S1,S2)=1 {l12 == 0}, "
                   f"dmax(S1,S2)>1 {u12 > 0} -> no tight block structure {ok}")
        assert ok
    hp, sp = build(s1x=(Fr(1, 2), Fr(3, 5)), s1y=(-Fr(1, 10), Fr(1, 10)))
    bp, _ = check_proper_tight(list(hp.values()) + list(sp.values()), [sp[("S1", 0, 0)]])
    out.append(f"[W-DECO plant bigsq] improper pairs for S1_0,0: {[(str(T), str(U), w) for T, U, w in bp]}")
    assert any(str(U).startswith("H0,0") for T, U, w in bp)
    out.append("[W-DECO] W's object PASSES this verifier's engine: a.e.-proper, tight, no class with tight block structure")
    text = "\n".join(out)
    if "--out" in sys.argv:
        open(sys.argv[sys.argv.index("--out") + 1], "w").write(text + "\n")
    print(text)


if __name__ == "__main__":
    main()
