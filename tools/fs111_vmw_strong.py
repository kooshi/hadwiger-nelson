#!/usr/bin/env python3
"""FS111-VMW: saturation under the three readings, at exact sample points, on HEX7, R7, SQ9, HEX9.

Readings of "no x in d_e S_j is j-free, for every j" (data/fs111/claims.md, C-SAT-T):
  (L)  literal: x ranges over d_e S_j, so j in P(x) -- the claim list's own gloss "for every j in P(x)".
  (B)  boundary, every colour: every essential boundary point x is a j-contact point for EVERY colour j (j in P(x) or not).
  (A)  everywhere: every point x and every colour j with x not in S~_j has a closed colour-j point at distance exactly 1
       (no fill move of any colour anywhere keeps the colouring a.e.-proper) -- the strongest, "maximal" reading.
Exact: sample points lie on the boundary pieces (rational-Pythagorean rotations of the endpoint directions, or rational
points of segments) or are named interior points, all in Q(sqrt 3)^2; each verdict is fs111_vmw_exact.point_contact.
A sample finds free points; it never proves their absence (the certificates of fs111_vmw_tilings.py do that for (L)).
Usage: python3 tools/fs111_vmw_strong.py [--out FILE]
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs111_vmw_exact import Q3, P, add, sub, scal, fmt, Seg, Arc, free_colours_at, dot, cross   # noqa: E402
import fs111_vmw_tilings as TL                                                                    # noqa: E402


def rot(v, c, s):
    return (c * v[0] - s * v[1], s * v[0] + c * v[1])


def samples(pc, k=11):
    """Exact points on a piece: for an arc, rotations of the start direction by angles with tan(theta/2) = i/20."""
    pts = []
    if isinstance(pc, Seg):
        for i in range(0, k + 1):
            t = Fr(i, k)
            pts.append(add(pc.p, scal(t, sub(pc.q, pc.p))))
        return pts
    u0 = sub(pc.p0, pc.c)
    for i in range(0, 40):
        s = Fr(i, 40)
        c, sn = Q3((1 - s * s) / (1 + s * s)), Q3(2 * s / (1 + s * s))
        d = rot(u0, c, sn)
        if pc.dir_in(d):
            pts.append(add(pc.c, d))
    pts.append(pc.p1)
    return pts


def survey(label, tiles, focus, colours, interior, out):
    tl = list(tiles)
    n_pts, freeL, freeB = 0, [], []
    for T in focus:
        zeros = T.zero
        for pc in T.pieces:
            for x in samples(pc):
                n_pts += 1
                fr = free_colours_at(x, tl, colours)
                own_zero = any(x == z for z in zeros) or any(x[0] == z[0] and x[1] == z[1] for z in zeros)
                if T.colour in fr and not own_zero:
                    freeL.append((T, x))
                if fr:
                    freeB.append((T, x, fr))
    out.append(f"[{label}] {n_pts} exact boundary sample points on {len(focus)} tiles")
    out.append(f"    reading (L): points free for their own tile's colour: {len(freeL)}")
    for T, x in freeL[:3]:
        out.append(f"      e.g. {T} at {fmt(x)}")
    out.append(f"    reading (B): points free for some colour: {len(freeB)}")
    for T, x, fr in freeB[:4]:
        out.append(f"      e.g. {T} at {fmt(x)}: free colours {fr}")
    for name, x, own in interior:
        fr = [c for c in free_colours_at(x, tl, colours) if c != own]
        out.append(f"    reading (A): interior point {name} {fmt(x)} (colour {own}): free colours {fr}")
    return freeL, freeB


def main():
    out = []
    hx = TL.hex7()
    survey("HEX7", hx.values(), [hx[(0, 0)]], list(range(7)), [("centre H0,0", P(0, 0), 0)], out)
    ups, downs = TL.r7()
    cols = [("R", a, b) for a in (0, 1) for b in (0, 1)] + [("D", i) for i in range(3)]
    g_up = add(TL.lat(0, 0), P(Fr(1, 2), Q3(0, Fr(1, 6))))             # centroid of R0,0
    g_dn = add(TL.lat(0, 0), P(1, Q3(0, Fr(1, 3))))                       # centroid of D0,0
    fl, fb = survey("R7", list(ups.values()) + list(downs.values()),
                    [ups[(0, 0)], downs[(0, 0)]], cols,
                    [("centroid R0,0", g_up, ("R", 0, 0)), ("centroid D0,0", g_dn, ("D", 0))], out)
    # plant: down tiles coloured by the four cosets of 2 Lambda (eight colours, proper); predicted: down arcs free (L)
    u8, d8 = TL.r7(down_col=lambda a, b: ("D", a % 2, b % 2))
    cols8 = [("R", a, b) for a in (0, 1) for b in (0, 1)] + [("D", a, b) for a in (0, 1) for b in (0, 1)]
    fl8, _ = survey("R8-PLANT (down by 2Lambda)", list(u8.values()) + list(d8.values()), [d8[(0, 0)]], cols8, [], out)
    assert fl8, "R8-PLANT must show down-arc points free for their own colour"
    assert not fl, "R7 faithful twin: no point free for its own colour"
    s = TL.sq9()
    survey("SQ9", s.values(), [s[(0, 0)]], [(a, b) for a in range(3) for b in range(3)],
           [("centre S0,0", P(Fr(1, 4), Fr(1, 4)), (0, 0))], out)
    x9 = TL.hex9()
    survey("HEX9", x9.values(), [x9[(0, 0)]], [(a, b) for a in range(3) for b in range(3)],
           [("centre X0,0", P(0, 0), (0, 0))], out)
    text = "\n".join(out)
    if "--out" in sys.argv:
        with open(sys.argv[sys.argv.index("--out") + 1], "w") as f:
            f.write(text + "\n")
    print(text)


if __name__ == "__main__":
    main()


def grid_A(n=12):
    """Reading (A) on R7 over one cell of the lattice (by equivariance under Lambda, which permutes the colours, one cell
    suffices): the exact grid (i/n) e1 + (k/n) e2; reports the points with a free colour other than their own."""
    ups, downs = TL.r7()
    tl = list(ups.values()) + list(downs.values())
    cols = [("R", a, b) for a in (0, 1) for b in (0, 1)] + [("D", i) for i in range(3)]
    bad = []
    for i in range(n):
        for k in range(n):
            x = TL.lat(Fr(i, n), Fr(k, n))
            own = [T.colour for T in tl if T.contains_closed(x)]
            fr = [c for c in free_colours_at(x, tl, cols) if c not in own]
            if fr:
                bad.append((x, fr))
    return n * n, bad


if __name__ == "__main__" and "--grid" in sys.argv:
    npts, bad = grid_A()
    print(f"[R7 reading (A), exact grid] {npts} points of one lattice cell; points with a free foreign colour: {len(bad)}")
    for x, fr in bad[:5]:
        print(f"    {fmt(x)}: {fr}")
