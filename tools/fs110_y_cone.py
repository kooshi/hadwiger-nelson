#!/usr/bin/env python3
"""FS110-Y4's hard Woodall-cone fragments (W-4, G-CONE), given by formula and checked exactly by FS110-Y's checker
(tools/fs110_y_check.py, imported, not edited).

Frame (data/fs110/claims.md §8, N3-DEG): a vertex v whose colour c occurs only as cusp horns along +-a, with bounding curvatures in
(-1, 1), and whose out-type c-contacts sit at both v +- n.  Coordinates: v = (0,0), a = (1,0), n = (0,1), N = v + n = (0,1),
S' = v - n = (0,-1); c = 1.  All data are rational (a subfield of Q(sqrt 3), the checker's field).  No boundary arc has radius 1
(Condition 5): the radii used are 2, 3 (horns), 1/2, 2 (out-tiles), and segments.

Fragments (derivations in plans/FS110-Y-construction.md § Continuation — FS110-Y4):
  WC    the double horn.  v: horn+ and horn- of colour 1 (upper boundary on the circle of radius 2 centred (0,2), curvature +1/2; lower
        on the circle of radius 2 centred (0,-2), curvature -1/2), colour 2 above, colour 3 below: a trichromatic vertex of degree 4,
        closure type {1,2,3}, essential type {2,3}.  N: an out-type colour-1 tile bounded below by the arc of radius 1/2 centred
        (0, 3/2) through N (curvature 2 away from v; mu = 2/(1+2) = 2/3 >= 1/2); S': its mirror.  v's ring: a band 9/10 <= r <= 11/10
        about omega(v) in nine pieces coloured 6,5,4,6,5,4,6,5,4 counter-clockwise from the piece about 0 deg (piece ends at the rational
        directions 2*atan(t), t = +-3/17, +-4/7, +-6/5, +-11/4, and 180 deg); the piece about 90 deg (colour 4) wraps the N-tile, the piece
        about 270 deg (colour 5) wraps the S'-tile.  Symmetry: y -> -y with colours (2 3)(4 5).
  WC1   the single horn: WC without horn-, the 2|3 boundary along -a (a trichromatic vertex of degree 3).
  WCH   the hard cone: WC plus a double horn of colour 3 (v's colour on N's far side) at N, inside R_y = {N + (T,Y) : -T^2/6 <= Y < T^2/2}
        (upper boundary the circle centred (0,3) radius 2, lower the circle centred (0,-3) radius 4), and its mirror at S' in colour 2.
        Every circle through horn+'s or horn-'s tip then meets a colour-2, colour-3 or ring-colour interior at distance exactly 1, so no tip
        can be recoloured (the --tips tests); N and S' become vertices of closure types {1,3,4}, {1,2,5} with a cusp colour each.
  WC1H  the hard cone with N and S' ORDINARY trivalent vertices: the single horn at v; at N the colour-1 out-tile is the sector
        (60 deg, 180 deg), colour 3 the sector (0 deg, 60 deg) with its lower ray along +a, the ring piece below y = 1; S' the mirror with
        (2 3)(4 5).  Only v is degenerate (a cusp); the --tips tests show horn+'s tip cannot be recoloured 2, 3 or 4.
  WCEQ  the sharpness control: horn boundaries on the circles of radius 3 centred (0,+-3) (curvatures +-1/3), out-tiles bounded by the arcs
        of radius 2 centred (0,+-3) (curvature 1/2, mu = (1/2)/(3/2) = 1/3): equality kappa2 = mu_N, -kappa1 = mu_S; each horn arc and
        its out-tile's arc are concentric at distance exactly 1 (a contact ARC, not a point).  ACCEPT expected.

Planted faults (--plant NAME), each predicted to turn its fragment REJECT for the reason named:
  wc_flat   WC with the N-tile's arc replaced by the arc of radius 2 centred (0,3) (mu_N = 1/3 < kappa2 = 1/2): horn vs N-tile
  wc_fat    WC with horn+'s upper boundary a segment of slope 1/10 (a colour-1 sector of positive angle at v): horn+ vs N-tile
  wc_col2   WC with the ring piece about 90 deg coloured 2 (A-CIRC at v): that piece vs v's colour-2 tile
  wc1h_ylow WC1H with N's colour-3 sector's lower ray turned to -30 deg (below the tangent line, out of R_y): yN vs v3
  wch_ywide WCH with the y-horns' lower boundary on the circle centred (0,-1) radius 2 (Y ~ -T^2/4, below R_y's -T^2/6): yN vs v3
  eq_steep  WCEQ with the horns' upper arcs of radius 2 centred (0,2) (kappa2 = 1/2 > mu_N = 1/3): horns vs N-tile only
--tips runs the tip-recolouring tests (horn+'s tip recoloured 2, 3 or 4, in WC and in WCH), each against its predicted verdict.
--yplant NAME passes FS110-Y's checker plants through (closed_interval: every exact contact at distance 1 turns REJECT).
--geom runs a float geometry guard (no overlaps; discs of radius 0.05 about v, N, S' and the band 0.93 <= r <= 1.07 covered): not a verdict.
"""
from __future__ import annotations
import sys, os, math, itertools
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs110_y_check as C  # noqa: E402  (FS110-Y's checker; imported only)

Seg, Arc = C.Seg, C.Arc
PLANT = None


def P(x, y):
    return (C.q(Fr(x)), C.q(Fr(y)))


def mirror_y(p):
    return (p[0], -p[1])


def mirror_x(p):
    return (-p[0], p[1])


def mprim(p, f):
    """image of a primitive under a reflection f (reflections reverse arc orientation)."""
    if isinstance(p, Seg):
        return Seg(f(p.P), f(p.Q))
    return Arc(f(p.C), p.r, f(p.E), f(p.S))


def circ_pt(R, m, up):
    """rational point on the circle of radius R centred (0, R) (up) or (0, -R) (not up), near v, right of v:
    (R sin th, +-(R - R cos th)) with sin th = 2m/(1+m^2), cos th = (1-m^2)/(1+m^2)."""
    R, m = Fr(R), Fr(m)
    s, c = 2 * m / (1 + m * m), (1 - m * m) / (1 + m * m)
    return P(R * s, (R - R * c) if up else -(R - R * c))


def cpt(t):
    t = Fr(t)
    return P((1 - t * t) / (1 + t * t), 2 * t / (1 + t * t))


V = P(0, 0)
X, H = Fr(1, 10), Fr(1, 10)                 # the v-flower's box half-sizes
R_IN, R_OUT = Fr(9, 10), Fr(11, 10)          # v's ring band
TOP = Fr(11, 10)                             # the out-tiles' far edge (|y| = 11/10)


def horn_plus(Ru, Au, Rl, Bl, fat=False):
    """horn+ at v: upper boundary the arc of the circle centred (0,Ru) radius Ru from v to Au (ccw about (0,Ru)); lower boundary the
    arc of the circle centred (0,-Rl) radius Rl from Bl to v; closed by the segment Au-Bl."""
    up = Seg(V, Au) if fat else Arc(P(0, Ru), Ru, V, Au)
    lo = Arc(P(0, -Rl), Rl, Bl, V)
    return up, lo


def v_flower(Ru, Au, Rl, Bl, double=True, fat=False, Au_minus=None, mid=None, tipcol=None):
    """v's flower.  mid = (Am, Bm): split horn+'s two arcs at Am (upper) and Bm (lower), in every tile that carries them; tipcol: the
    colour given to horn+'s tip (the part between v and the segment Am-Bm) -- the tip-recolouring tests."""
    up, lo = horn_plus(Ru, Au, Rl, Bl, fat)
    Au_minus = Au if Au_minus is None else Au_minus          # horn- is never fattened
    if mid is not None and not fat:
        Am, Bm = mid
        ups = [Arc(P(0, Ru), Ru, V, Am), Arc(P(0, Ru), Ru, Am, Au)]
        los = [Arc(P(0, -Rl), Rl, Bl, Bm), Arc(P(0, -Rl), Rl, Bm, V)]
    else:
        ups, los = [up], [lo]
    if mid is not None and tipcol is not None:
        Am, Bm = mid
        T = {"tip": (tipcol, [ups[0], Seg(Am, Bm), los[1]]), "h+": (1, [ups[1], Seg(Au, Bl), los[0], Seg(Bm, Am)])}
    else:
        T = {"h+": (1, ups + [Seg(Au, Bl)] + los)}
    TR, TL, BR, BL = P(X, H), P(-X, H), P(X, -H), P(-X, -H)
    if double:
        upm, lom = mprim(horn_plus(Ru, Au_minus, Rl, Bl)[0], mirror_x), mprim(lo, mirror_x)
        Amx, Bmx = mirror_x(Au_minus), mirror_x(Bl)
        T["h-"] = (1, [upm, Seg(Bmx, Amx), lom])
        T["v2"] = (2, ups + [Seg(Au, TR), Seg(TR, TL), Seg(TL, Amx), upm])
        T["v3"] = (3, los + [lom, Seg(Bmx, BL), Seg(BL, BR), Seg(BR, Bl)])
    else:
        W = P(-X, 0)
        T["v2"] = (2, ups + [Seg(Au, TR), Seg(TR, TL), Seg(TL, W), Seg(W, V)])
        T["v3"] = (3, los + [Seg(V, W), Seg(W, BL), Seg(BL, BR), Seg(BR, Bl)])
    return T


def n_tile(rho, Qpt, split=False):
    """out-type colour-1 tile at N: below, the arc of the circle centred (0, 1+rho) radius rho from Pp = (-qx, qy) ccw through N to
    Q = (qx, qy) (split at N when horns sit at N); then up to y = TOP.  Returns (tile, arcs, Pp, Qpt, TL, TR)."""
    Pp = mirror_x(Qpt)
    Cn = P(0, 1 + Fr(rho))
    arcs = [Arc(Cn, rho, Pp, NPT), Arc(Cn, rho, NPT, Qpt)] if split else [Arc(Cn, rho, Pp, Qpt)]
    TR, TL = (Qpt[0], C.q(TOP)), (Pp[0], C.q(TOP))
    return arcs + [Seg(Qpt, TR), Seg(TR, TL), Seg(TL, Pp)], arcs, Pp, Qpt, TL, TR


NPT = P(0, 1)
# the y-horns at N (colour 3), inside R_y = {N + (T, Y) : -T^2/6 <= Y < T^2/2} (for the horn curvatures -1/2, +1/2 at v):
# upper boundary on the circle centred (0,3) radius 2 (Y ~ T^2/4), lower on the circle centred (0,-3) radius 4 (Y ~ -T^2/8).
UY = (C.q(Fr(160, 1601)), C.q(Fr(1605, 1601)))            # on the circle centred (0,3), radius 2
LY = (C.q(Fr(640, 6401)), C.q(Fr(6393, 6401)))            # on the circle centred (0,-3), radius 4
LY_WIDE = (C.q(Fr(160, 1601)), C.q(Fr(1597, 1601)))       # on the circle centred (0,-1), radius 2 (Y ~ -T^2/4): plant wch_ywide


def y_horns_N(wide=False):
    """the double y-horn at N: [upper arc N->UY, closing segment, lower arc ->N] and its mirror in x."""
    if wide:
        lo = Arc(P(0, -1), 2, LY_WIDE, NPT); L = LY_WIDE
    else:
        lo = Arc(P(0, -3), 4, LY, NPT); L = LY
    up = Arc(P(0, 3), 2, NPT, UY)
    hp = [up, Seg(UY, L), lo]
    hm = [mprim(p, mirror_x) for p in hp]
    return hp, hm


RING_T = [Fr(-3, 17), Fr(3, 17), Fr(4, 7), Fr(6, 5), Fr(11, 4), None, Fr(-11, 4), Fr(-6, 5), Fr(-4, 7)]   # piece starts, ccw
RING_COL = [6, 5, 4, 6, 5, 4, 6, 5, 4]


E1 = (C.q(Fr(231, 2210)), C.q(Fr(242, 221)))   # (11/10)*cpt(10/11): on r = 11/10 at ~84.55 deg, just right of the N-tile


def ring(narc, ncol=4, nhorns=None):
    """nine ring pieces, annular sectors 9/10 <= r <= 11/10 (inner and outer boundaries arcs centred v, radii 9/10 and 11/10: not 1);
    piece k runs ccw from direction RING_T[k] to RING_T[k+1] (None = 180 deg).  Piece 2 (about 90 deg) wraps the N-tile's lower arc and
    sides, and the y-horns at N when present (it then meets N from three sides); piece 7 is piece 2's mirror image (y -> -y)."""
    arcs, Pp, Qpt, TL, TR = narc
    dirs = [P(-1, 0) if t is None else cpt(t) for t in RING_T]
    T = {}
    for k in range(9):
        d1, d2 = dirs[k], dirs[(k + 1) % 9]
        i1, o1 = C.mul(C.q(R_IN), d1), C.mul(C.q(R_OUT), d1)
        i2, o2 = C.mul(C.q(R_IN), d2), C.mul(C.q(R_OUT), d2)
        inner = Arc(V, R_IN, i1, i2)
        if k == 2:
            E2 = mirror_x(E1)
            prims = [Seg(i1, o1), Arc(V, R_OUT, o1, E1), Seg(E1, TR), Seg(TR, Qpt)] + arcs + [Seg(Pp, TL), Seg(TL, E2),
                     Arc(V, R_OUT, E2, o2), Seg(o2, i2), inner]
            if nhorns is not None:
                prims += nhorns[0] + nhorns[1]
            T["r2"] = (ncol, prims)
            T["r7"] = (RING_COL[7], [mprim(p, mirror_y) for p in prims])
        elif k == 7:
            continue
        else:
            T[f"r{k}"] = (RING_COL[k], [Seg(i1, o1), Arc(V, R_OUT, o1, o2), Seg(o2, i2), inner])
    return T


def build(Ru, Au, Rl, Bl, rho, Qpt, double=True, fat=False, ncol=4, Au_minus=None, hard=False, wide=False, tipcol=None):
    mid = (AM, BM) if (hard or tipcol is not None) else None
    T = v_flower(Ru, Au, Rl, Bl, double, fat, Au_minus, mid, tipcol)
    nt, arcs, Pp, Qq, TL, TR = n_tile(rho, Qpt, split=hard)
    T["N1"] = (1, nt)
    T["S1"] = (1, [mprim(p, mirror_y) for p in nt])
    nh = None
    if hard:
        hp, hm = y_horns_N(wide)
        nh = (hp, hm)
        T["yN+"] = (3, hp); T["yN-"] = (3, hm)
        T["xS+"] = (2, [mprim(p, mirror_y) for p in hp]); T["xS-"] = (2, [mprim(p, mirror_y) for p in hm])
    T.update(ring((arcs, Pp, Qq, TL, TR), ncol, nh))
    return T


A2 = circ_pt(2, Fr(1, 40), True)          # (160/1601, 4/1601) on the circle centred (0,2), radius 2
B2 = circ_pt(2, Fr(1, 40), False)         # (160/1601, -4/1601) on the circle centred (0,-2), radius 2
A3 = circ_pt(3, Fr(1, 60), True)          # (360/3601, 6/3601) on the circle centred (0,3), radius 3
B3 = circ_pt(3, Fr(1, 60), False)         # (360/3601, -6/3601) on the circle centred (0,-3), radius 3
AM = circ_pt(2, Fr(1, 80), True)          # (320/6401, 4/6401): horn+'s upper arc split point (the tip is t < 0.05)
BM = circ_pt(2, Fr(1, 80), False)         # (320/6401, -4/6401)
Q_HALF = P(Fr(10, 101), Fr(102, 101))     # on the circle centred (0,3/2), radius 1/2
Q_TWO = (C.q(Fr(160, 1601)), C.q(3) - C.q(Fr(3198, 1601)))   # on the circle centred (0,3), radius 2: (160/1601, 1605/1601)


def frag_WC():
    if PLANT == "wc_flat":
        return build(2, A2, 2, B2, 2, Q_TWO)
    if PLANT == "wc_fat":
        return build(2, P(Fr(160, 1601), Fr(16, 1601)), 2, B2, Fr(1, 2), Q_HALF, fat=True, Au_minus=A2)
    if PLANT == "wc_col2":
        return build(2, A2, 2, B2, Fr(1, 2), Q_HALF, ncol=2)
    return build(2, A2, 2, B2, Fr(1, 2), Q_HALF)


def frag_WC1():
    return build(2, A2, 2, B2, Fr(1, 2), Q_HALF, double=False)


def frag_WCEQ():
    if PLANT == "eq_steep":
        return build(2, A2, 3, B3, 2, Q_TWO)
    return build(3, A3, 3, B3, 2, Q_TWO)


def frag_WCH():
    if PLANT == "wch_ywide":
        return build(2, A2, 2, B2, Fr(1, 2), Q_HALF, hard=True, wide=True)
    return build(2, A2, 2, B2, Fr(1, 2), Q_HALF, hard=True)


def build_trivalent_hard(tipcol=None, plant=None):
    """WC1H: the single horn at v (tip-split), and N, S' ORDINARY trivalent vertices.  N: the out-tile of colour 1 is the sector
    (60 deg, 180 deg) at N (a corner toward horn+: mu = 1), colour 3 the sector (0 deg, 60 deg) whose lower ray runs along +a (inside
    R_y), the ring piece (colour 4) below the tangent line y = 1.  S' is the mirror image with colours (2 3)(4 5)."""
    T = v_flower(2, A2, 2, B2, double=False, mid=(AM, BM), tipcol=tipcol)
    b, h = C.q(Fr(1, 10)), C.q(Fr(11, 10))
    N, L, R = NPT, (-b, C.q(1)), (b, C.q(1))
    TLb, TRb = (-b, h), (b, h)
    R60 = (C.R3 / 30, h)                                   # N + (0.2/sqrt3)*(1/2, sqrt3/2): the 60-degree ray at y = 11/10
    if plant == "wc1h_ylow":                               # colour 3 at N reaching below the tangent line: the lower ray at -30 deg
        R = (b, C.q(1) - C.R3 / 30)
    N1 = [Seg(N, L), Seg(L, TLb), Seg(TLb, R60), Seg(R60, N)]
    Y3 = [Seg(N, R60), Seg(R60, TRb), Seg(TRb, R), Seg(R, N)]
    T["N1"] = (1, N1); T["yN"] = (3, Y3)
    T["S1"] = (1, [mprim(q, mirror_y) for q in N1]); T["xS"] = (2, [mprim(q, mirror_y) for q in Y3])
    dirs = [P(-1, 0) if t is None else cpt(t) for t in RING_T]
    for k in range(9):
        if k == 7: continue
        d1, d2 = dirs[k], dirs[(k + 1) % 9]
        i1, o1 = C.mul(C.q(R_IN), d1), C.mul(C.q(R_OUT), d1)
        i2, o2 = C.mul(C.q(R_IN), d2), C.mul(C.q(R_OUT), d2)
        inner = Arc(V, R_IN, i1, i2)
        if k == 2:
            E2 = mirror_x(E1)
            prims = [Seg(i1, o1), Arc(V, R_OUT, o1, E1), Seg(E1, TRb), Seg(TRb, R), Seg(R, N), Seg(N, L), Seg(L, TLb),
                     Seg(TLb, E2), Arc(V, R_OUT, E2, o2), Seg(o2, i2), inner]
            T["r2"] = (4, prims); T["r7"] = (5, [mprim(q, mirror_y) for q in prims])
        else:
            T[f"r{k}"] = (RING_COL[k], [Seg(i1, o1), Arc(V, R_OUT, o1, o2), Seg(o2, i2), inner])
    return T


def frag_WC1H():
    return build_trivalent_hard(plant=PLANT)


FRAGS = {"WC": frag_WC, "WC1": frag_WC1, "WCEQ": frag_WCEQ, "WCH": frag_WCH, "WC1H": frag_WC1H}

# the tip-recolouring tests: horn+'s tip (t < 0.05) recoloured; (name, builder, the verdict the derivation predicts)
TIPS = [("WC  tip->2", lambda: build(2, A2, 2, B2, Fr(1, 2), Q_HALF, tipcol=2), "ACCEPT"),
        ("WC  tip->3", lambda: build(2, A2, 2, B2, Fr(1, 2), Q_HALF, tipcol=3), "ACCEPT"),
        ("WC  tip->4", lambda: build(2, A2, 2, B2, Fr(1, 2), Q_HALF, tipcol=4), "REJECT"),
        ("WCH tip->2", lambda: build(2, A2, 2, B2, Fr(1, 2), Q_HALF, hard=True, tipcol=2), "REJECT"),
        ("WCH tip->3", lambda: build(2, A2, 2, B2, Fr(1, 2), Q_HALF, hard=True, tipcol=3), "REJECT"),
        ("WC1H tip->2", lambda: build_trivalent_hard(tipcol=2), "REJECT"),
        ("WC1H tip->3", lambda: build_trivalent_hard(tipcol=3), "REJECT"),
        ("WC1H tip->4", lambda: build_trivalent_hard(tipcol=4), "REJECT")]


def fdist_range(T1, T2):
    cs = [c for p1 in T1 for p2 in T2 for c in C.cands(p1, p2)]
    vals = [abs(math.sqrt(max(A.f(), 0.0)) + B.f()) for (A, B) in cs]
    return min(vals), max(vals)


def check_fragment(T):
    names = sorted(T)
    pairs = [(a, b) for a, b in itertools.combinations_with_replacement(names, 2) if T[a][0] == T[b][0]]
    tiles = {k: v[1] for k, v in T.items()}
    rows, bad = [], []
    for a, b in pairs:
        v = C.pair_verdict(tiles[a], tiles[b], self_pair=(a == b))
        lo, hi = fdist_range(tiles[a], tiles[b]) if a != b else (0.0, fdist_range(tiles[a], tiles[a])[1])
        rows.append((a, b, T[a][0], v, lo, hi))
        if v == "REJECT":
            bad.append((a, b))
    return rows, bad


# ------------------------------------------------------------------ float geometry guard (not a verdict)
def polyline(prims, n=48):
    out = []
    for p in prims:
        if isinstance(p, Seg):
            out.append([(p.P[0].f(), p.P[1].f()), (p.Q[0].f(), p.Q[1].f())])
        else:
            cx, cy = p.C[0].f(), p.C[1].f(); r = p.r.f()
            a0 = math.atan2(p.S[1].f() - cy, p.S[0].f() - cx); a1 = math.atan2(p.E[1].f() - cy, p.E[0].f() - cx)
            span = (a1 - a0) % (2 * math.pi)
            assert span < math.pi / 2, "arc span >= 90 deg: wrong orientation?"
            out.append([(cx + r * math.cos(a0 + span * i / n), cy + r * math.sin(a0 + span * i / n)) for i in range(n + 1)])
    return out


def inside(prims, x, y):
    cnt = 0
    for ch in polyline(prims):
        for (x1, y1), (x2, y2) in zip(ch, ch[1:]):
            if (y1 > y) != (y2 > y) and x < x1 + (y - y1) * (x2 - x1) / (y2 - y1):
                cnt += 1
    return cnt % 2 == 1


def geom(T):
    tiles = {k: v[1] for k, v in T.items()}
    pts = []
    for (cx, cy) in [(0, 0), (0, 1), (0, -1)]:  # discs about v, N, S'; then the ring band
        for i in range(-12, 13):
            for j in range(-12, 13):
                x, y = cx + 0.05 * i / 12 + 1e-7, cy + 0.05 * j / 12 + 2e-7
                if (x - cx) ** 2 + (y - cy) ** 2 <= 0.05 ** 2: pts.append((x, y))
    for k in range(720):
        th = 2 * math.pi * (k + 0.37) / 720
        for r in (0.93, 0.97, 1.0 + 1e-6, 1.03, 1.07):
            pts.append((r * math.cos(th), r * math.sin(th)))
    over = holes = 0
    for (x, y) in pts:
        k = sum(inside(p, x, y) for p in tiles.values())
        over += k > 1; holes += k == 0
    return over, holes, len(pts)


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args: PLANT = args[args.index("--plant") + 1]
    if "--yplant" in args: C.PLANT = args[args.index("--yplant") + 1]
    only = args[args.index("--frag") + 1] if "--frag" in args else None
    verbose = "--verbose" in args
    allok = True
    for name, f in FRAGS.items():
        if only and name != only: continue
        T = f()
        rows, bad = check_fragment(T)
        verdict = "REJECT" if bad else "ACCEPT"
        print(f"== fragment {name}: {len(T)} tiles, {len(rows)} same-colour pairs (self included): {verdict}")
        for (a, b, c, v, lo, hi) in rows:
            if verbose or v == "REJECT":
                print(f"   colour {c}  {a:4s} {b:4s} {v:6s} range ~[{lo:.6f}, {hi:.6f}]")
        if bad: print("   REJECTED PAIRS:", bad)
        if "--geom" in args:
            ov, ho, n = geom(T)
            print(f"   geometry guard (float): {n} samples; overlapping {ov}; uncovered {ho}")
        allok &= (verdict == "ACCEPT")
    if "--tips" in args:
        tipok = True
        for (name, f, want) in TIPS:
            T = f(); rows, bad = check_fragment(T)
            got = "REJECT" if bad else "ACCEPT"
            tipok &= got == want
            print(f"== tip test {name}: want {want} got {got}  {'ok' if got == want else 'MISMATCH'}")
            for (a, b, c, v, lo, hi) in rows:
                if v == "REJECT": print(f"   colour {c}  {a:4s} {b:4s} {v:6s} range ~[{lo:.6f}, {hi:.6f}]")
        print("TIP TESTS", "ALL AS PREDICTED" if tipok else "SOME MISMATCH")
        allok &= tipok
    print("PLANT", PLANT, "YPLANT", C.PLANT, "ALL ACCEPT" if allok else "SOME REJECT")
    sys.exit(0 if allok else 1)
