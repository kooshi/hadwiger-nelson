#!/usr/bin/env python3
"""FS116-Y2: a vertex of SIX colours (all six at p, so its ring omega(p) lies in Gamma and every ring arc is a (Q) arc), by formula, checked exactly.

Objects (p = origin, e(t) the unit vector at angle t degrees, rotation by 60 degrees = rho):
  S_j  the sector p, e(60j), e(60j+60)                                           (the flower: six tiles at p, each carrying a 60-degree ring arc)
  Q_j  the outer lens over the ring arc [60j-30, 60j+30]: points outside omega(p) within 1 of e(60j-30) and of e(60j+30), cut at |x| = RHO
  G_j  the gap tile at e(60j+30): points outside omega(p), at distance >= 1 from e(60j-30) and from e(60j+90), cut at |x| = RHO
  colour pattern A: S_j -> j, Q_j -> j+2, G_j -> j+4 (mod 6);  pattern B: S_j -> j, Q_j -> j+3, G_j -> j+2.
Exact arithmetic in Q(sqrt3)(sqrt7) (RHO = 3/2: the cut points have cos = 3/4, sin = sqrt7/4) or Q(sqrt3) (RHO = 8/5).  The pair verdict, the point
straddle and the map-consistency test are FS114-YB's exact checker (tools/fs114_yb_exact.py, imported read-only, never edited).

Run: python3 tools/fs116_y2_six.py frag  [--plant patbreak|grow]   the fragment: validity, non-Siamese (every distinct same-colour pair at min >= 1),
                                                                   consistency (every non-rim piece shared by two tiles), six colours at p
     python3 tools/fs116_y2_six.py point [--pattern A|B] [--plant move]   FS116-Y2-SIXOFF's step at sqrt3 e(0): which colours the tiles near sqrt3 e(0)
                                                                   straddle at x = (sqrt3, -1/100) (pattern A) or (sqrt3, +1/100) (pattern B)
     python3 tools/fs116_y2_six.py dcread [--plant phi]            FS116-Y2-DCREAD's window (disk coordinates about A_0)
Plants: patbreak (Q_0 recoloured to Q_1's colour: the lenses touching at e(30) must REJECT); grow (cut at RHO = 8/5: G_j's diameter exceeds 1, REJECT);
        move (the point moved to (sqrt3 + 1/100, 0): a different colour is left unstraddled); phi (the window at R = phi instead of 2).
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as K   # noqa: E402  (read-only import of FS114-YB's exact checker)

Seg, Arc, Tile = K.Seg, K.Arc, K.Tile
vadd, vsub, vmul, n2 = K.vadd, K.vsub, K.vmul, K.n2

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
PATTERN = sys.argv[sys.argv.index("--pattern") + 1] if "--pattern" in sys.argv else "A"


def tower(need7):
    T = K.Tower.base().extend(3, "3")
    if need7:
        T = T.extend(7, "7")
    return T


def build_points(T, rho_num, rho_den, cosa, sina):
    """e(60j), e(60j+30), and the cut points on |x| = RHO of the lens Q_0 (cutR on omega(e(30)), cutL on omega(e(-30)))."""
    r3 = T.gen(1)
    h = T(Fr(1, 2))
    O = (T(0), T(0))
    E = [(T(1), T(0)), (h, r3 / 2), (-h, r3 / 2), (T(-1), T(0)), (-h, -r3 / 2), (h, -r3 / 2)]
    M = [(r3 / 2, h), (T(0), T(1)), (-r3 / 2, h), (-r3 / 2, -h), (T(0), T(-1)), (r3 / 2, -h)]   # e(30), e(90), ..., e(330)
    R = T(Fr(rho_num, rho_den))
    # cos(a - 30), sin(a - 30) with cos a = cosa, sin a = sina
    c = cosa * r3 / 2 + sina / 2
    s = sina * r3 / 2 - cosa / 2
    cutL = (R * c, R * s)            # direction a - 30, on omega(e(-30))
    cutR = (R * c, -(R * s))         # direction 30 - a, on omega(e(30))
    return O, E, M, R, cutL, cutR


def rot(p, k, T):
    r3 = T.gen(1)
    for _ in range(k % 6):
        p = (p[0] / 2 - r3 / 2 * p[1], r3 / 2 * p[0] + p[1] / 2)
    return p


def colours(pattern):
    if pattern == "A":
        return (lambda j: j % 6), (lambda j: (j + 2) % 6), (lambda j: (j + 4) % 6)
    return (lambda j: j % 6), (lambda j: (j + 3) % 6), (lambda j: (j + 2) % 6)


def fragment(rho=(3, 2), pattern="A", plant=None):
    if plant == "grow":
        rho = (8, 5)
    if rho == (3, 2):
        T = tower(True)
        cosa, sina = T(Fr(3, 4)), T.gen(2) / 4
    else:
        T = tower(False)
        cosa, sina = T(Fr(rho[0], 2 * rho[1])), T(Fr(3, 5))
        assert (cosa * cosa + sina * sina - 1).is0()
    O, E, M, R, cutL, cutR = build_points(T, rho[0], rho[1], cosa, sina)
    one = T(1)
    cS, cQ, cG = colours(pattern)
    tiles = []
    for j in range(6):
        e0, e1 = E[j], E[(j + 1) % 6]
        mL, mR = M[(j - 1) % 6], M[j]                  # e(60j - 30), e(60j + 30)
        cl, cr = rot(cutL, j, T), rot(cutR, j, T)      # Q_j's cut points: left (ccw side, on omega(e(60j-30))), right (on omega(e(60j+30)))
        cr_next = rot(cutR, j + 1, T)                  # Q_{j+1}'s right cut point, on omega(e(60j+90))
        mN = M[(j + 1) % 6]                            # e(60j + 90)
        tiles.append(Tile(f"S{j}", cS(j), [Seg(O, e0), Arc(O, one, e0, mR, True), Arc(O, one, mR, e1, True), Seg(e1, O)]))
        tiles.append(Tile(f"Q{j}", cQ(j), [Arc(O, one, mR, e0, False), Arc(O, one, e0, mL, False), Arc(mR, one, mL, cr, True),
                                           Arc(O, R, cr, cl, True), Arc(mL, one, cl, mR, True)]))
        tiles.append(Tile(f"G{j}", cG(j), [Arc(mL, one, mR, cl, False), Arc(O, R, cl, cr_next, True), Arc(mN, one, cr_next, mR, False)]))
    if plant == "patbreak":
        t = tiles[1]
        tiles[1] = Tile(t.name, cQ(1), t.pieces)
    return T, O, R, tiles


def run_frag():
    T, O, R, tiles = fragment(plant=PLANT)
    print(f"fragment: RHO = {float(R):.4f}, pattern A, plant = {PLANT}; {len(tiles)} tiles")
    rejects, siamese, pairs = [], [], 0
    for i, a in enumerate(tiles):
        for b in tiles[i:]:
            if a.colour != b.colour:
                continue
            pairs += 1
            r = K.pair(a, b)
            if r.reject:
                rejects.append((a.name, b.name))
            if a is not b and r.min_lt1:
                siamese.append((a.name, b.name))
    print(f"  same-colour pairs (self included): {pairs}")
    print(f"  REJECT: {rejects if rejects else 'none'}")
    print(f"  distinct same-colour pairs with min distance < 1 (Siamese-close): {siamese if siamese else 'none'}")
    bad, unmatched = K.consistency(tiles, open_ok=lambda pc: pc.kind == "A" and K.veq(pc.C, O) and (pc.rho - R).is0())
    print(f"  consistency: {len(bad)} unmatched interior pieces, {unmatched} rim pieces on |x| = RHO")
    at_p = sorted({t.colour for t in tiles if any(K.is0v(q) for pc in t.pieces for q in pc.ends())})
    print(f"  colours of the tiles whose boundary holds p: {at_p}")
    ok = (not rejects) and (not siamese) and (not bad) and at_p == [0, 1, 2, 3, 4, 5]
    print("=> FRAGMENT: VALID, NON-SIAMESE, SIX COLOURS AT p" if ok else "=> FRAGMENT: FAILS")
    return 0


def run_point():
    """the tiles near sqrt3 e(0) that SIXOFF uses, uncut (full lenses; G_0, G_5 as small pieces near e(30), e(-30) with their full cones)."""
    T = tower(False)
    O = (T(0), T(0))
    r3 = T.gen(1)
    h = T(Fr(1, 2))
    one = T(1)
    E0, E60, E300 = (T(1), T(0)), (h, r3 / 2), (h, -r3 / 2)
    M30, M90, M330, M270 = (r3 / 2, h), (T(0), T(1)), (r3 / 2, -h), (T(0), T(-1))
    V0, V60, V300 = (r3, T(0)), (r3 / 2, r3 * r3 / 2), (r3 / 2, -(r3 * r3) / 2)
    cS, cQ, cG = colours(PATTERN)
    lens = lambda mL, mR, V: [Arc(O, one, mR, mL, False), Arc(mR, one, mL, V, True), Arc(mL, one, V, mR, True)]
    cd, sd = T(Fr(99, 101)), T(Fr(20, 101))            # a small rotation delta (cos 99/101, sin 20/101)
    a = vadd(M330, (sd, cd))                           # on omega(e(-30)), delta clockwise from e(30)
    b = vadd(M90, (cd * r3 / 2 + sd / 2, sd * r3 / 2 - cd / 2))   # on omega(e(90)), delta counter-clockwise from e(30)
    G0 = [Arc(M330, one, M30, a, False), Seg(a, b), Arc(M90, one, b, M30, False)]
    G5 = [Arc(pc.C if False else rot(pc.C, 5, T), pc.rho, rot(pc.P, 5, T), rot(pc.Q, 5, T), pc.ccw) if pc.kind == "A"
          else Seg(rot(pc.P, 5, T), rot(pc.Q, 5, T)) for pc in G0]
    tiles = [Tile("S0", cS(0), [Seg(O, E0), Arc(O, one, E0, E60, True), Seg(E60, O)]),
             Tile("S5", cS(5), [Seg(O, E300), Arc(O, one, E300, E0, True), Seg(E0, O)]),
             Tile("Q0", cQ(0), lens(M330, M30, V0)), Tile("Q1", cQ(1), lens(M30, M90, V60)),
             Tile("Q5", cQ(5), lens(M270, M330, V300)),
             Tile("G0", cG(0), G0), Tile("G5", cG(5), G5)]
    s = T(Fr(1, 100))
    x = (r3, -s) if PATTERN == "A" else (r3, s)
    if PLANT == "move":
        x = (r3 + s, T(0))
    print(f"pattern {PATTERN}; x = ({float(x[0]):.5f}, {float(x[1]):.5f}); plant = {PLANT}")
    print(f"  |x - e(30)|^2 - 1 = {float(n2(vsub(x, M30)) - 1):+.5f},  |x - e(-30)|^2 - 1 = {float(n2(vsub(x, M330)) - 1):+.5f}")
    free, blocked = K.free_colours(x, tiles, list(range(6)))
    for c in range(6):
        names = [t.name for t in tiles if t.colour == c]
        detail = []
        for t in tiles:
            if t.colour != c:
                continue
            lt, gt, eq, ins = K.point_tile(x, t)
            detail.append(f"{t.name}: min<1 {lt}, max>1 {gt}")
        print(f"  colour {c}: {'STRADDLED by ' + ','.join(blocked[c]) if c in blocked else 'not straddled'}   [{'; '.join(detail)}]")
    print(f"=> unstraddled colours at x: {free}")
    return 0


def run_dcread():
    """the directions about A_0 (disk coordinates) in which B(A_0, R) leaves B(O, r): sin t > (r^2 - R^2 - a^2)/(2 R a)."""
    r5 = math.sqrt(5)
    r2 = (25 + 9 * r5) / 10
    a2 = (5 - r5) / 10
    a = math.sqrt(a2)
    R = (1 + r5) / 2 if PLANT == "phi" else 2.0
    s0 = (r2 - R * R - a2) / (2 * R * a)
    t0 = math.degrees(math.asin(s0))
    psi = 209.0102
    lo, hi = (t0 - psi) % 360, (180 - t0 - psi) % 360
    print(f"R = {R:.4f}: sin t0 = {s0:.6f} (at R = 2 this is (sqrt5 - 2)/(4a)); window about A_0 in disk coordinates ({t0:.1f}, {180 - t0:.1f}) deg;"
          f" relative to y at psi = {psi}: ({lo:.1f}, {hi:.1f})")
    return 0


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "frag"
    sys.exit({"frag": run_frag, "point": run_point, "dcread": run_dcread}[cmd]())
