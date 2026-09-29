#!/usr/bin/env python3
"""FS116-N1 stage 4: FS116-N1-AXIS (a)-(d) and FS116-N1-TOUCH read exactly on FS116-Y1-F15's fragment F(1/5).

F(1/5) is built by tools/fs116_y1_sat.py build() (FS116-Y1's tool, imported, never edited): the capped strip's arches about p = P_0 = (0, 0), its top
and bottom tiles trimmed at |y| = 5/4, and the partner tiles M* = [0, 1/5] x [1, 5/4] (M), O* = [-1/5, 0] x [1, 5/4] (O) with their mirrors beta* (P),
alpha* (B).  p's tiles: U0 (P, quadrant I), U-1 (B, II), D-1 (O, III), D0 (M, IV); absent colours G, R.  Every point below is in Q(sqrt3, sqrt5);
point location is FS114-YB's exact ray casting (tools/fs114_yb_exact.py inside(), imported): 1 interior, 0 boundary, -1 outside.

For each axis point a of the ring (qE = (1,0), qN = (0,1), qW = (-1,0), qS = (0,-1)) it prints:
  inward   the colours of the tiles holding six exact points a + h, h in the open inward half-plane at a (|h| = 1/100-ish; two of them between the
           ring and the tangent line), and TOUCH if one colour, CHANGE if two;  AXIS (a) says: absent colours only
  outward  the colours just beyond the tangent line on each side (h = (+-1/100, 1/1000) rotated);   AXIS (b) says: the two opposite quadrants' colours
  germs    for each germ at a +- 60 deg, the ring point there (t-parametrised, exact, 0.11 deg from a +- 60): its tile's colour if interior, or
           'X|Y' (inner|outer side tiles' colours) if it lies on a boundary arc of the ring -- a (Q) arc when both are colours of p
  ring     the colours of the tiles holding the ring just clockwise and just counter-clockwise of a (exact ring points 0.11 deg away)
  at-a     the colours of the closed tiles holding a;   TOUCH says: at a touch point no tile of the other absent colour holds a
The last line checks the stage-4 predictions: AXIS (c) the eight outer germs 30+, 60-, 120+, 150-, 210+, 240-, 300+, 330- on no (Q) arc; AXIS (d) at
every axis point whose inner germs (v-, u+) lie on no (Q) arc, the inward half-plane is one colour; TOUCH at each touch point whose four germs lie on
no (Q) arc, its four germs carry the other absent colour and the axis point carries none of it.
PLANT (--plant): U1 recoloured G -> R (its ring germs at 30 and 60 then carry the touch colour of qN); TOUCH's germ clause fails at qN.
Run: python3 tools/fs116_n1_axis.py [--plant] [--line]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402  (FS114-YB's exact checker, unedited)
import fs116_y1_sat as Y        # noqa: E402  (FS116-Y1's builder of F(1/5), unedited)

PCOL = {"P", "B", "O", "M"}      # p's colours
ABS = {"G", "R"}                 # absent at p


def sq9_mode(plant):
    """k = 9: FS111-W-SQ9 (Y1's sq9(), imported), p = (0, 0), qN = (0, 1).  AXIS (d)'s hypothesis (the inner germs 30-, 150+ off (Q) arcs) holds and
    its conclusion (one inward colour) fails: the step where six is spent.  Plant: square (0,1) recoloured as (-1,1), so qN's inward half is one colour."""
    tiles = Y.sq9()
    if plant:
        for t in tiles:
            if t.name == "S0,1":
                t.colour = (2, 1)
    Tq = X.Tower.base()

    def interior(z):
        return [t for t in tiles if X.inside(z, t) > 0]

    def ring_pt(t):
        t = Tq(t)
        d = 1 + t * t
        return ((1 - t * t) / d, (2 * t) / d)
    s = Fr(1, 100)
    inN = [(-1, Fr(-1, 50)), (-1, -1), (0, -1), (1, -1), (1, Fr(-1, 50))]
    cols = set()
    for d in inN:
        cols |= {t.colour for t in interior((Tq(Fr(d[0]) * s), Tq(1 + Fr(d[1]) * s)))}
    g30m = [t.colour for t in interior(ring_pt(Fr(2675, 10000)))]       # 2 atan(0.2675) = 29.95 deg
    g150p = [t.colour for t in interior(ring_pt(Fr(3745, 1000)))]       # 2 atan(3.745) = 150.05 deg
    kind = "TOUCH" if len(cols) == 1 else "CHANGE"
    fmt = lambda c: "(%d,%d)" % c
    print("SQ9 k=9: qN inward {%s} %s; germs 30-:%s 150+:%s" % (
        ",".join(sorted(fmt(c) for c in cols)), kind, ",".join(fmt(c) for c in g30m), ",".join(fmt(c) for c in g150p)))


def main():
    plant = "--plant" in sys.argv
    line = "--line" in sys.argv
    if "--sq9" in sys.argv:
        sq9_mode(plant)
        return
    S, tiles = Y.build()
    if plant:
        for t in tiles:
            if t.name == "U1":
                t.colour = "R"
    q = S.q
    r3 = S.T.gen(1)

    def rot(v, k):               # rotate by k * 90 degrees counter-clockwise
        x, y = v
        for _ in range(k % 4):
            x, y = -y, x
        return (x, y)

    def interior(z):
        return [t for t in tiles if X.inside(z, t) > 0]

    def closed(z):
        return [t for t in tiles if X.inside(z, t) >= 0]

    def ring_pt(t):              # the unit-circle point with half-angle tangent t
        d = 1 + t * t
        return ((1 - t * t) / d, (2 * t) / d)

    eps = q(Fr(1, 1000))
    # half-angle tangents for 30, 60, 120, 150 degrees (15, 30, 60, 75): 2 - sqrt3, sqrt3/3, sqrt3, 2 + sqrt3
    base = {30: q(2) - r3, 60: r3 / 3, 120: r3, 150: q(2) + r3}

    def germ_pt(ang, side):      # side -1: just clockwise of ang, +1: just counter-clockwise
        if ang in base:
            x, y = ring_pt(base[ang] + side * eps)
            return (x, y)
        if ang in (210, 240):    # 180 + (30, 60): the antipode of the germ on the same side
            x, y = ring_pt(base[ang - 180] + side * eps)
            return (-x, -y)
        if ang in (300, 330):    # reflection of (60, 30) in the x-axis; reflection swaps sides
            x, y = ring_pt(base[360 - ang] - side * eps)
            return (x, -y)
        raise ValueError(ang)

    def germ(ang, side):
        z = germ_pt(ang, side)
        ins = interior(z)
        if len(ins) == 1:
            return ins[0].colour, False
        bd = [t for t in tiles if X.inside(z, t) == 0]
        # inner | outer: the side tile containing z - tiny * z (inside the ring) and z + tiny * z (outside)
        k = q(Fr(1, 10 ** 6))
        zin = (z[0] * (1 - k), z[1] * (1 - k))
        zout = (z[0] * (1 + k), z[1] * (1 + k))
        ci = [t.colour for t in interior(zin)]
        co = [t.colour for t in interior(zout)]
        return "%s|%s" % ("".join(ci) or "?", "".join(co) or "?"), bool(bd)

    def ring_germ(name, side):   # the ring just clockwise (-1) / counter-clockwise (+1) of the axis point: interior tile's colour, or 'on-Gamma'
        if name == "qE":
            z = ring_pt(side * eps)
        elif name == "qN":
            z = ring_pt(q(1) + side * eps)
        elif name == "qW":       # reflect the qE germ of the other side in the y-axis
            x, y = ring_pt(-side * eps)
            z = (-x, y)
        else:                    # qS: reflect the qN germ of the other side in the x-axis
            x, y = ring_pt(q(1) - side * eps)
            z = (x, -y)
        ins = interior(z)
        return ins[0].colour if len(ins) == 1 else "on-Gamma"

    axes = [("qE", 0, (q(1), q(0))), ("qN", 1, (q(0), q(1))), ("qW", 2, (q(-1), q(0))), ("qS", 3, (q(0), q(-1)))]
    # inward directions at qN (absolute, below y = 1), scaled by 1/100
    inN = [(-1, Fr(-1, 50)), (-1, -1), (0, -1), (1, -1), (1, Fr(-1, 50)), (1, Fr(-1, 500)), (-1, Fr(-1, 500))]
    outN = {"left": (-1, Fr(1, 10)), "right": (1, Fr(1, 10))}     # just above y = 1 at x = -+1/100
    germs_of = {"qE": (300, 60), "qN": (30, 150), "qW": (120, 240), "qS": (210, 330)}   # (v, u)
    outer_germs = [(30, +1), (60, -1), (120, +1), (150, -1), (210, +1), (240, -1), (300, +1), (330, -1)]
    lines, ok = [], True
    gcache = {}

    def G(ang, side):
        if (ang, side) not in gcache:
            gcache[(ang, side)] = germ(ang, side)
        return gcache[(ang, side)][0]

    def is_q(val):
        return "|" in val and set(val.split("|")) <= PCOL
    for name, k, a in axes:
        s = Fr(1, 100)
        cols = set()
        for d in inN:
            h = rot((q(Fr(d[0]) * s), q(Fr(d[1]) * s)), k - 1)
            cs = [t.colour for t in interior((a[0] + h[0], a[1] + h[1]))]
            cols |= set(cs)
        kind = "TOUCH" if len(cols) == 1 else "CHANGE"
        outs = {}
        for side, d in outN.items():
            h = rot((q(Fr(d[0]) * s), q(Fr(d[1]) * s)), k - 1)
            outs[side] = "".join(t.colour for t in interior((a[0] + h[0], a[1] + h[1])))
        v, u = germs_of[name]
        gm = {"v-": G(v, -1), "v+": G(v, +1), "u-": G(u, -1), "u+": G(u, +1)}
        at = sorted({t.colour for t in closed(a)})
        rg = [ring_germ(name, sd) for sd in (-1, +1)]
        lines.append("%s: inward {%s} %s; ring %s,%s; outward left %s right %s; germs %d-:%s %d+:%s %d-:%s %d+:%s; at %s: %s" % (
            name, ",".join(sorted(cols)), kind, rg[0], rg[1], outs["left"], outs["right"], v, gm["v-"], v, gm["v+"], u, gm["u-"], u, gm["u+"],
            name, ",".join(at)))
        if kind == "TOUCH" and not (rg[0] == rg[1] == next(iter(cols))):
            ok = False
            lines.append("  TOUCH FAILS at %s: ring germs %s" % (name, rg))
        # AXIS (a): inward absent only
        if not cols <= ABS:
            ok = False
            lines.append("  AXIS (a) FAILS at %s: %s" % (name, cols))
        # AXIS (d): inner germs v-, u+ on no (Q) arc -> one colour inward
        if not is_q(gm["v-"]) and not is_q(gm["u+"]) and kind != "TOUCH":
            ok = False
            lines.append("  AXIS (d) FAILS at %s" % name)
        # TOUCH: four germs carry the other absent colour; the axis point carries none of it
        if kind == "TOUCH" and not any(is_q(val) for val in gm.values()):
            x = next(iter(cols))
            xb = (ABS - {x}).pop()
            if any(val != xb for val in gm.values()) or xb in at:
                ok = False
                lines.append("  TOUCH FAILS at %s: touch colour %s, germs %s, at %s" % (name, x, gm, at))
    # AXIS (c): outer germs on no (Q) arc
    bad = [(a_, s_) for a_, s_ in outer_germs if is_q(G(a_, s_))]
    if bad:
        ok = False
        lines.append("  AXIS (c) FAILS: outer germs on (Q) arcs %s" % bad)
    summary = "AXIS-TOUCH F(1/5): %s" % ("ALL AS DERIVED" if ok else "NOT AS DERIVED")
    if line:
        print(summary)
    else:
        print("\n".join(lines))
        print(summary)


if __name__ == "__main__":
    main()
