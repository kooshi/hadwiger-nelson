#!/usr/bin/env python3
"""FS110-YB4: the round-4 fragments rebuilt from the formulas quoted in data/fs110/briefs/YB4-110-instance.md
(the side's §11.3-§11.4), with the controls, the side's plants and the tip recolourings; checked with
tools/fs110_yb4_check.py (my own checker).  Coordinates: v = (0,0), a = (1,0), n = (0,1), N = (0,1), S' = (0,-1).

Choices the formulas leave open (stated, and varied in the robustness pass):
  CAP   the contact tiles at N, S' are the arc-disc cut by the disc B(N, CAP) (resp. B(S', CAP)), CAP = 1/10, so that
        the ring piece about 90 deg wraps them (they lie at angles 90 +- 5.8 deg, inside the piece (59.49, 100.39) deg);
  HN    the half-length of WCH's double horns at N, S', HN = 1/20;
  RS    the radius of WC1H's sectors at N, S', RS = 1/20;
  T0    the tip radius t0 (several values).
Each ring piece that wraps a contact is the annular sector minus the closures of the tiles it wraps (their boundary
pieces added as holes)."""
import sys
from fractions import Fraction as Fr
from fs110_yb4_check import Num, N, P, Seg, Arc, Tile, check_fragment, check_pair, PLANT, LOG, d2, sgn

B = Fr(1, 10)                 # box half-width
RIN, ROUT = Fr(9, 10), Fr(11, 10)
O = P(0, 0)
V = P(0, 0)
NN = P(0, 1)
SS = P(0, -1)


def sq(x):
    return N(x).sqrt()


def circ_x(C, R, x, upper):
    """point of circle (C, R) at abscissa x, upper or lower branch."""
    h = (N(R) * R - (N(x) - C.x) * (N(x) - C.x)).sqrt()
    return P(x, C.y + h if upper else C.y - h)


def circ_circ(C1, R1, C2, R2):
    """the two intersection points of circles with centres on the y-axis: (left, right)."""
    # centres (0, c1), (0, c2): y from subtracting the equations
    c1, c2 = N(C1.y), N(C2.y)
    y = (N(R1) * R1 - N(R2) * R2 - c1 * c1 + c2 * c2) / ((c2 - c1) * 2)
    x = (N(R1) * R1 - (y - c1) * (y - c1)).sqrt()
    return P(-x, y), P(x, y)


# ---------------------------------------------------------------- the ring
T_CUTS = [Fr(3, 17), Fr(4, 7), Fr(6, 5), Fr(11, 4)]


def dirn(t):
    return P(Fr(1) - t * t, 2 * t) * (Num(1) / (1 + t * t)) if t is not None else P(-1, 0)


def ring_dirs():
    # counter-clockwise from -20.02 deg: t = -3/17, 3/17, 4/7, 6/5, 11/4, 180 deg, -11/4, -6/5, -4/7
    ts = [-T_CUTS[0], T_CUTS[0], T_CUTS[1], T_CUTS[2], T_CUTS[3], None, -T_CUTS[3], -T_CUTS[2], -T_CUTS[1]]
    return [dirn(t) for t in ts]


RING_COL = [6, 5, 4, 6, 5, 4, 6, 5, 4]      # counter-clockwise from the piece about 0 deg


def ring(holes=None, colours=None):
    """nine annular pieces; holes: {k: [tiles]} whose closures are removed from piece k."""
    holes = holes or {}
    colours = colours or RING_COL
    ds = ring_dirs()
    out = []
    for k in range(9):
        d0, d1 = ds[k], ds[(k + 1) % 9]
        pcs = [Arc(O, ROUT, d0 * ROUT, d1 * ROUT), Seg(d1 * ROUT, d1 * RIN), Arc(O, RIN, d0 * RIN, d1 * RIN),
               Seg(d0 * RIN, d0 * ROUT)]
        for t in holes.get(k, []):
            pcs += t.pieces
        out.append(Tile(f'r{k}', colours[k], pcs))
    return out


# ---------------------------------------------------------------- v's box
def box(kU=(P(0, 2), 2), kL=(P(0, -2), 2), double=True, fat=False):
    """horns of colour 1 between the circles kU (upper boundary) and kL (lower); colour 2 above, 3 below."""
    (CU, RU), (CL, RL) = kU, kL
    uR, uL = circ_x(CU, RU, B, False), circ_x(CU, RU, -B, False)
    lR, lL = circ_x(CL, RL, B, True), circ_x(CL, RL, -B, True)
    tiles = []
    if fat:      # plant wc_fat: h+'s upper boundary the segment of slope 1/10 from v
        fR = P(B, B / 10)
        hp = Tile('h+', 1, [Seg(V, fR), Seg(fR, lR), Arc(CL, RL, lR, V)])
        topR = fR
        c2_right = [Seg(V, fR)]
    else:
        hp = Tile('h+', 1, [Arc(CU, RU, V, uR), Seg(uR, lR), Arc(CL, RL, lR, V)])
        topR = uR
        c2_right = [Arc(CU, RU, V, uR)]
    tiles.append(hp)
    if double:
        tiles.append(Tile('h-', 1, [Arc(CU, RU, uL, V), Arc(CL, RL, V, lL), Seg(lL, uL)]))
        c2 = [Arc(CU, RU, uL, V)] + c2_right + [Seg(topR, P(B, B)), Seg(P(B, B), P(-B, B)), Seg(P(-B, B), uL)]
        c3 = [Arc(CL, RL, lR, lL), Seg(lL, P(-B, -B)), Seg(P(-B, -B), P(B, -B)), Seg(P(B, -B), lR)]
    else:        # WC1: the 2|3 boundary along -a
        mL = P(-B, 0)
        c2 = [Seg(mL, V)] + c2_right + [Seg(topR, P(B, B)), Seg(P(B, B), P(-B, B)), Seg(P(-B, B), mL)]
        c3 = [Arc(CL, RL, lR, V), Seg(V, mL), Seg(mL, P(-B, -B)), Seg(P(-B, -B), P(B, -B)), Seg(P(B, -B), lR)]
    tiles.append(Tile('v2', 2, c2))
    tiles.append(Tile('v3', 3, c3))
    return tiles


CAP = Fr(1, 10)


def contact(side, C, R, name, colour=1):
    """the colour-1 tile at N (side=+1) or S' (side=-1): inside the circle (C, R) through the contact point, cut by
    the disc of radius CAP about the contact point."""
    K = NN if side > 0 else SS
    l, r = circ_circ(C, R, K, CAP)
    if side > 0 and C.y.f() < K.y.f():   # negative curvature at N: the tile is B(N, CAP) outside the disc (C, R)
        return Tile(name, colour, [Arc(C, R, r, l), Arc(K, CAP, r, l)])
    if side > 0:     # lower arc of (C,R) through N: ccw from left to right through the bottom; cap arc over the top
        return Tile(name, colour, [Arc(C, R, l, r), Arc(K, CAP, r, l)])
    return Tile(name, colour, [Arc(C, R, r, l), Arc(K, CAP, l, r)])


def wc(kN=(P(0, Fr(3, 2)), Fr(1, 2)), kS=(P(0, Fr(-3, 2)), Fr(1, 2)), double=True, box_kw=None, ring_cols=None,
       extraN=(), extraS=()):
    bx = box(double=double, **(box_kw or {}))
    n1 = contact(1, kN[0], kN[1], 'N1')
    s1 = contact(-1, kS[0], kS[1], 'S1')
    rg = ring(holes={2: [n1, *extraN], 7: [s1, *extraS]}, colours=ring_cols)
    return bx + [n1, s1] + list(extraN) + list(extraS) + rg


def wceq(steep=False, lower_wc=False):
    kU = (P(0, 2), 2) if steep else (P(0, 3), 3)
    kL = (P(0, -2), 2) if lower_wc else (P(0, -3), 3)
    return wc(kN=(P(0, 3), 2), kS=(P(0, -3), 2), box_kw=dict(kU=kU, kL=kL))


# ---------------------------------------------------------------- WCH: double cusps of y = 3 at N and x = 2 at S'
HN = Fr(1, 20)


def cusp_pair(side, colour, upper, lower, tag):
    """a double horn at the contact point between the circle `upper` (its upper boundary) and `lower`."""
    K = NN if side > 0 else SS
    (CA, RA), (CB, RB) = upper, lower
    aR, aL = circ_x(CA, RA, HN, False if CA.y.f() > K.y.f() else True), circ_x(CA, RA, -HN, False if CA.y.f() > K.y.f() else True)
    bR, bL = circ_x(CB, RB, HN, False if CB.y.f() > K.y.f() else True), circ_x(CB, RB, -HN, False if CB.y.f() > K.y.f() else True)
    # arcs through K: orientation by which side of K the centre lies
    def arc(C, R, X, Y):          # the short arc between X and Y through K: ccw order depends on centre position
        if C.y.f() > K.y.f():     # K is the circle's bottom: ccw runs left -> right
            return Arc(C, R, X, Y) if X.x.f() < Y.x.f() else Arc(C, R, Y, X)
        return Arc(C, R, X, Y) if X.x.f() > Y.x.f() else Arc(C, R, Y, X)
    tp = Tile(tag + '+', colour, [arc(CA, RA, K, aR), Seg(aR, bR), arc(CB, RB, bR, K)])
    tm = Tile(tag + '-', colour, [arc(CA, RA, aL, K), Seg(aL, bL), arc(CB, RB, K, bL)])
    return [tp, tm]


def wch(ywide=False):
    lowN = (P(0, -1), 2) if ywide else (P(0, -3), 4)     # lower boundary at N: Y ~ -T^2/4 (plant) or -T^2/8
    uppS = (P(0, 1), 2) if ywide else (P(0, 3), 4)
    yN = cusp_pair(1, 3, (P(0, 3), 2), lowN, 'yN')
    xS = cusp_pair(-1, 2, uppS, (P(0, -3), 2), 'xS')
    return wc(extraN=yN, extraS=xS)


# ---------------------------------------------------------------- WC1H: ordinary trivalent vertices at N, S'
RS = Fr(1, 20)
S3 = Num(0, Fr(1, 2), 3)      # sqrt(3)/2


def sector(K, r, d0, d1, name, colour):
    """the open sector of B(K, r) between the unit directions d0 -> d1 (counter-clockwise)."""
    A, Bp = K + d0 * r, K + d1 * r
    return Tile(name, colour, [Seg(K, A), Arc(K, r, A, Bp), Seg(Bp, K)])


def wc1h(ylow=False):
    e0, e60, e180 = P(1, 0), P(Fr(1, 2), S3), P(-1, 0)
    e300, e_30, e30 = P(Fr(1, 2), -S3), P(S3, Fr(-1, 2)), P(S3, Fr(1, 2))
    n1 = sector(NN, RS, e60, e180, 'N1', 1)
    s1 = sector(SS, RS, e180, e300, 'S1', 1)
    if ylow:     # colour 3 at N turned to (-30, 30) deg; mirror at S'
        yN = sector(NN, RS, e_30, e30, 'yN', 3)
        xS = sector(SS, RS, e_30, e30, 'xS', 2)
    else:
        yN = sector(NN, RS, e0, e60, 'yN', 3)
        xS = sector(SS, RS, e300, e0, 'xS', 2)
    # the ring pieces wrap the half-discs: remove the upper half-disc of B(N,RS) from r2 (and the lower of B(S',RS) from r7)
    capN = Tile('capN', 0, [Seg(NN + e0 * RS, NN + e180 * RS), Arc(NN, RS, NN + e0 * RS, NN + e180 * RS)])
    capS = Tile('capS', 0, [Seg(SS + e180 * RS, SS + e0 * RS), Arc(SS, RS, SS + e180 * RS, SS + e0 * RS)])
    if ylow:
        capN = Tile('capN', 0, [Seg(NN, NN + e_30 * RS), Arc(NN, RS, NN + e_30 * RS, NN + e180 * RS), Seg(NN + e180 * RS, NN)])
        capS = Tile('capS', 0, [Seg(SS, SS + e180 * RS), Arc(SS, RS, SS + e180 * RS, SS + e30 * RS), Seg(SS + e30 * RS, SS)])
    bx = box(double=False)
    rg = ring(holes={2: [capN], 7: [capS]})
    return bx + [n1, s1, yN, xS] + rg


# ---------------------------------------------------------------- tip recolouring
def tip(tiles, t0, j, which='h+'):
    """recolour Theta = h(+/-) cap B(v, t0) into colour j: the tip becomes a tile of colour j, the rest of the horn
    keeps colour 1."""
    h = [t for t in tiles if t.name == which][0]
    up = [pc for pc in h.pieces if isinstance(pc, Arc) and pc.C.y.f() > 0][0]
    lo = [pc for pc in h.pieces if isinstance(pc, Arc) and pc.C.y.f() < 0][0]
    sgnx = 1 if which == 'h+' else -1
    # intersection of each horn arc with the circle |p| = t0 (centres on the y-axis)
    def hit(arc):
        l, r = circ_circ(arc.C, arc.R, O, t0)
        return r if sgnx > 0 else l
    pu, pl = hit(up), hit(lo)
    if sgnx > 0:
        th = Tile('tip', j, [Arc(up.C, up.R, V, pu), Arc(O, t0, pl, pu), Arc(lo.C, lo.R, pl, V)])
        rest = Tile(which, 1, [Arc(up.C, up.R, pu, up.E), ] + [pc for pc in h.pieces if isinstance(pc, Seg)] +
                    [Arc(lo.C, lo.R, lo.S, pl), Arc(O, t0, pl, pu)])
    else:
        th = Tile('tip', j, [Arc(up.C, up.R, pu, V), Arc(O, t0, pu, pl), Arc(lo.C, lo.R, V, pl)])
        rest = Tile(which, 1, [Arc(up.C, up.R, up.S, pu)] + [pc for pc in h.pieces if isinstance(pc, Seg)] +
                    [Arc(lo.C, lo.R, pl, lo.E), Arc(O, t0, pu, pl)])
    return [t for t in tiles if t.name != which] + [rest, th]
