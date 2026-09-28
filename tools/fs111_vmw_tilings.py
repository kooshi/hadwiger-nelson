#!/usr/bin/env python3
"""FS111-VMW: the tilings of FS-111 round 1, built by formula, checked exactly with tools/fs111_vmw_exact.py.

Objects (every coordinate in Q(sqrt 3)):
  HEX7  the hexagonal seven-colouring: regular hexagons of circumradius 1/2 (pointy-top), centres m*a1 + n*a2,
        a1 = (sqrt3/2, 0), a2 = (sqrt3/4, 3/4), colour (m + 3n) mod 7.  The calibration object (tight, a.e.-proper,
        NOT saturated: its edge midpoints are free).
  R7    the Reuleaux seven-colouring (Polymath16 thread 4, ag24ag24 = de Grey, 5 May 2018): on the unit triangular lattice
        (e1 = (1,0), e2 = (1/2, sqrt3/2)), the up triangle p, p+e1, p+e2 (p = a e1 + b e2) fattened to its Reuleaux triangle,
        colour ('R', a mod 2, b mod 2) -- the four cosets of 2 Lambda; the down triangle q+e1, q+e2, q+e1+e2 cut by the three
        bulges, i.e. the curvilinear triangle between the pairwise tangent unit circles about q, q+2e1, q+2e2, colour
        ('D', (a - b) mod 3) -- the three cosets of M = <(0, sqrt3), (3/2, sqrt3/2)> = {a e1 + b e2 : a = b mod 3}.
  SQ9   squares of side 1/2, [i/2,(i+1)/2] x [j/2,(j+1)/2], colour (i mod 3, j mod 3).
  HEX9  regular hexagons of width 1/2 (inradius 1/4, pointy-top), centres (1/2)(m e1 + n e2), colour (m mod 3, n mod 3).
Plants (each must fail for its own reason; the faithful twin beside it must pass):
  R7-P1 down triangles coloured by the index-3 sublattice <3e1, e2> (a unit vector in it) -> improper pair named.
  R7-P2 Reuleaux triangles coloured by <4 e1, e2> cosets (index 4, contains e2) -> improper pair named.
  CERT-P a forged certificate: a down arc's centre claimed to lie in a tile of the wrong colour -> rejected.
Usage: python3 tools/fs111_vmw_tilings.py [--out FILE]
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs111_vmw_exact import (Q3, R3, P, add, sub, scal, n2, fmt, peq, Seg, Arc, Tile, polygon, pair_range,  # noqa: E402
                             point_contact, check_proper_tight, free_colours_at, certify_piece, on_piece, dot, cross)

H = Fr(1, 2)
E1 = P(1, 0)
E2 = P(H, Q3(0, H))


def lat(a, b):
    return add(scal(a, E1), scal(b, E2))


# ------------------------------------------------------------------------------------------------------------ HEX7
def hex7(N=5, colour=lambda m, n: (m + 3 * n) % 7):
    a1 = P(Q3(0, Fr(1, 2)), 0)
    a2 = P(Q3(0, Fr(1, 4)), Fr(3, 4))
    off = [P(0, H), P(Q3(0, Fr(1, 4)), Fr(1, 4)), P(Q3(0, Fr(1, 4)), -Fr(1, 4)), P(0, -H), P(Q3(0, -Fr(1, 4)), -Fr(1, 4)),
           P(Q3(0, -Fr(1, 4)), Fr(1, 4))]
    off = off[::-1]   # counter-clockwise
    tiles = {}
    for m in range(-N, N + 1):
        for n in range(-N, N + 1):
            c = add(scal(m, a1), scal(n, a2))
            tiles[(m, n)] = polygon(f"H{m},{n}", colour(m, n), [add(c, o) for o in off])
    return tiles


# -------------------------------------------------------------------------------------------------------------- R7
def reuleaux(p, name, colour):
    A, B, C = p, add(p, E1), add(p, E2)
    # CCW boundary: arc centred C from A to B (240->300), arc centred A from B to C (0->60), arc centred B from C to A (120->180)
    return Tile(name, colour, [Arc(C, A, B), Arc(A, B, C), Arc(B, C, A)],
                member=lambda x: all((n2(sub(x, v)) - 1).sign() <= 0 for v in (A, B, C)))


def deltoid(q, name, colour):
    c0, c1, c2 = q, add(q, scal(2, E1)), add(q, scal(2, E2))
    k01, k02, k12 = add(q, E1), add(q, E2), add(q, add(E1, E2))
    # boundary (clockwise as a curve, but each arc stored CCW about its centre): pieces must chain; we store the loop
    # k01 -> k02 (arc about q, CCW 0->60), k02 -> k12 (arc about q+2e2 is 240->300: from k02 to k12), k12 -> k01 (arc about
    # q+2e1, CCW 120->180: from k12 to k01)
    tri = [k01, k12, k02]      # counter-clockwise

    def member(x):
        in_tri = all(cross(sub(tri[(i + 1) % 3], tri[i]), sub(x, tri[i])).sign() >= 0 for i in range(3))
        return in_tri and all((n2(sub(x, c)) - 1).sign() >= 0 for c in (c0, c1, c2))
    return Tile(name, colour, [Arc(c0, k01, k02), Arc(c2, k02, k12), Arc(c1, k12, k01)], zero_density_points=[k01, k02, k12],
                member=member)


def r7(N=4, up_col=lambda a, b: ("R", a % 2, b % 2), down_col=lambda a, b: ("D", (a - b) % 3)):
    ups, downs = {}, {}
    for a in range(-N, N + 1):
        for b in range(-N, N + 1):
            ups[(a, b)] = reuleaux(lat(a, b), f"R{a},{b}", up_col(a, b))
            downs[(a, b)] = deltoid(lat(a, b), f"D{a},{b}", down_col(a, b))
    return ups, downs


# ------------------------------------------------------------------------------------------------------------- SQ9
def sq9(N=6):
    tiles = {}
    for i in range(-N, N + 1):
        for j in range(-N, N + 1):
            x0, y0 = Fr(i, 2), Fr(j, 2)
            tiles[(i, j)] = polygon(f"S{i},{j}", (i % 3, j % 3),
                                    [P(x0, y0), P(x0 + H, y0), P(x0 + H, y0 + H), P(x0, y0 + H)])
    return tiles


# ------------------------------------------------------------------------------------------------------------ HEX9
def hex9(N=6):
    R = Q3(0, Fr(1, 6))       # circumradius sqrt3/6
    off = [P(0, R), P(-Fr(1, 4), Q3(0, Fr(1, 12))), P(-Fr(1, 4), Q3(0, -Fr(1, 12))), P(0, Q3(0, -Fr(1, 6))),
           P(Fr(1, 4), Q3(0, -Fr(1, 12))), P(Fr(1, 4), Q3(0, Fr(1, 12)))]
    tiles = {}
    for m in range(-N, N + 1):
        for n in range(-N, N + 1):
            c = scal(H, lat(m, n))
            tiles[(m, n)] = polygon(f"X{m},{n}", (m % 3, n % 3), [add(c, o) for o in off])
    return tiles


# --------------------------------------------------------------------------------------------------------- reports
def report_proper(label, tiles, focus, out):
    bad, tight = check_proper_tight(tiles, focus)
    out.append(f"[{label}] pairs improper: {len(bad)}; tight contacts: {len(tight)}")
    for T, U, why in bad[:6]:
        out.append(f"    IMPROPER {T} {U}: {why}")
    for T, U, why in tight[:4]:
        out.append(f"    tight {T} {U}: {why}")
    return bad, tight


def report_saturation(label, tiles, focus, out):
    """Literal reading: every boundary piece of every focus tile, certified non-free for the tile's own colour."""
    uncert = []
    for T in focus:
        for pc in T.pieces:
            c = certify_piece(T, pc, tiles)
            if c is None:
                uncert.append((T, pc))
            else:
                out.append(f"    cert {T} {pc}: {c}")
    out.append(f"[{label}] uncertified boundary pieces: {len(uncert)}")
    for T, pc in uncert[:6]:
        out.append(f"    UNCERTIFIED {T} {pc}")
    return uncert


def main():
    out = []
    # ---------------- HEX7 calibration
    hx = hex7()
    focus = [hx[(0, 0)], hx[(1, 0)], hx[(0, 1)]]
    tl = list(hx.values())
    bad, tight = report_proper("HEX7", tl, focus, out)
    assert not bad and tight, "HEX7 calibration: expected proper and tight"
    un = report_saturation("HEX7", tl, [hx[(0, 0)]], out)
    assert len(un) == 6, "HEX7 calibration: every edge of a hexagon should be uncertified"
    T = hx[(0, 0)]
    for pc in T.pieces:
        mid = scal(H, add(pc.p, pc.q))
        fr = free_colours_at(mid, tl, list(range(7)))
        v = pc.p
        frv = free_colours_at(v, tl, list(range(7)))
        out.append(f"    HEX7 edge midpoint {fmt(mid)}: free colours {fr}; vertex {fmt(v)}: free colours {frv}")
        assert T.colour in fr, "HEX7: the edge midpoint must be free for its own colour"
        assert T.colour not in frv, "HEX7: the vertex must not be free for its own colour"
    out.append("[HEX7] calibration PASSED: proper, tight, not saturated (every edge midpoint free for its own colour; "
               "vertices not free)")

    # ---------------- R7
    ups, downs = r7()
    tl = list(ups.values()) + list(downs.values())
    focus = [ups[(a, b)] for a in (0, 1) for b in (0, 1)] + [downs[(a, 0)] for a in (0, 1, 2)]
    bad, tight = report_proper("R7", tl, focus, out)
    assert not bad and tight, "R7: expected proper and tight"
    un = report_saturation("R7", tl, focus, out)
    assert not un, "R7: expected every boundary piece certified (literal reading)"
    out.append("[R7] PASSED: a.e.-proper, tight, every boundary arc certified non-free for its own colour")

    # ---------------- R7 plants
    ups1, downs1 = r7(down_col=lambda a, b: ("D", a % 3))       # sublattice <3e1, e2>
    tl1 = list(ups1.values()) + list(downs1.values())
    bad1, _ = report_proper("R7-P1 (down by <3e1,e2>)", tl1, [downs1[(0, 0)]], out)
    assert bad1 and all(T.colour[0] == "D" for T, U, w in bad1), "R7-P1 must fail on a down pair"
    ups2, downs2 = r7(up_col=lambda a, b: ("R", a % 4, 0))     # cosets of <4e1, e2>
    tl2 = list(ups2.values()) + list(downs2.values())
    bad2, _ = report_proper("R7-P2 (up by <4e1,e2>)", tl2, [ups2[(0, 0)]], out)
    assert bad2 and all(T.colour[0] == "R" for T, U, w in bad2), "R7-P2 must fail on an up pair"
    # forged certificate: recolour the tile holding a down arc's centre (as a cusp) and ask again
    D0 = downs[(0, 0)]
    arc = D0.pieces[0]              # centred at q = 0
    holders = [U for U in tl if U.colour == D0.colour and U.contains_closed(arc.c)]
    out.append(f"[CERT-P] down arc {arc} of {D0}: same-colour tiles holding its centre: {[str(U) for U in holders]}")
    assert holders, "the faithful certificate must find a holder"
    forged = [U for U in tl if not (U.colour == D0.colour and U.contains_closed(arc.c) and U is not D0)]
    c_forged = certify_piece(D0, arc, forged)
    out.append(f"[CERT-P] with the holder removed from the tiling, certificate = {c_forged}")
    assert c_forged is None, "CERT-P must fire: the arc has no certificate once its holder is gone"
    out.append("[plants] R7-P1, R7-P2, CERT-P fired, each for its own reason; faithful twins passed")

    # ---------------- SQ9, HEX9
    s = sq9()
    tl = list(s.values())
    bad, tight = report_proper("SQ9", tl, [s[(0, 0)]], out)
    assert not bad and tight
    un = report_saturation("SQ9", tl, [s[(0, 0)]], out)
    assert not un
    x9 = hex9()
    tl = list(x9.values())
    bad, tight = report_proper("HEX9", tl, [x9[(0, 0)]], out)
    assert not bad and tight
    un = report_saturation("HEX9", tl, [x9[(0, 0)]], out)
    assert not un
    out.append("[SQ9, HEX9] PASSED: a.e.-proper, tight, every boundary piece certified non-free (literal reading)")

    text = "\n".join(out)
    if "--out" in sys.argv:
        with open(sys.argv[sys.argv.index("--out") + 1], "w") as f:
            f.write(text + "\n")
    print(text)


if __name__ == "__main__":
    main()
