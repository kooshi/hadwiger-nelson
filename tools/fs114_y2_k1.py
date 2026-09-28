#!/usr/bin/env python3
"""FS114-Y2 stage 1b: K1's killing test -- a valid fragment, by formula, holding a degree-4 four-colour vertex with FOUR tactic edges.

THE OBJECT (the Reuleaux bowtie; every point in Q(sqrt3); p = (0,0), s = sqrt3/2).
  q1 = (s, 1/2), q2 = (s, -1/2), q3 = (-s, -1/2), q4 = (-s, 1/2): the four tactic centres, on the unit circle about p.
  t1 = the Reuleaux triangle p, q1, q2 (colour 1); t3 its mirror in x = 0 (colour 3).  Their four sides at p are the four edges at p:
    e1 = t1 | t4 from p to m2 on the unit circle about q1;   e2 = t1 | t2 from p to m1 on the unit circle about q2;
    e3 = t3 | t2 from p to m4 on the unit circle about q3;   e4 = t3 | t4 from p to m3 on the unit circle about q4;
    m1 = q2 + e(120) = ((sqrt3-1)/2, (sqrt3-1)/2) and its mirrors m2, m3, m4.
  t2 (colour 2): p -> m1 (arc about q2), segment m1 -> e(60), the unit circle about p from e(60) through top = (0,1) to e(120), segment
    e(120) -> m4, m4 -> p (arc about q3).  t4 = its mirror in y = 0 (colour 4).
  L1 (colour 5): t1's side from m1 to q1; the unit arc about top from q1 to b = (12/13, 8/13); the rim; the unit arc about q1 from
    a = q1 + (-4/5, 3/5) to top; the unit circle about p from top back to e(60); segment e(60) -> m1.
  V (colour 6): between the unit arc about a (from q1 to b' = a + (15/17, -8/17)) and the unit arc about top (from q1 to b), closed by the rim.
  T1 (colour 4): segment q1 -> c = (3 sqrt3/5, 2/5) (direction 330 degrees from q1), the rim c -> b', the unit arc about a from b' to q1.
  W (colour 3): segment q2 -> c' = (3 sqrt3/5, -2/5), the rim c' -> c, segment c -> q1, t1's side on the unit circle about p from q1 to q2.
  N (colour 4): the cusp above top between the unit arcs about q1 (top -> a) and about q4 (a' -> top), closed by the rim a -> a'.
  The rim between b and a runs through p1 = (11/10)(4/5, 3/5), p2 = (11/10)(3/5, 4/5), p3 = (11/10)(5/13, 12/13).
  Mirrors: sigma_x : x -> -x acts on colours by (1 3)(5 6); sigma_y : y -> -y by (2 4)(5 6).  L4, L2, L3; V'', V', V'''; T4, T2, T3; N'; W'.
  So: L1 5, L4 6, L2 6, L3 5; V 6, V'' 5, V' 5, V''' 6; T1 4, T4 4, T2 2, T3 2; N 4, N' 2; W 3, W' 1.  Twenty tiles.

THE CHECKS (FS114-YB's exact checker `tools/fs114_yb_exact.py` and its driver `check_finite`, imported and never edited):
  1. validity: every same-colour pair (a tile with itself included) ACCEPTs;   2. non-Siamese: every DISTINCT same-colour pair has min >= 1
  (a distinct pair with max <= 1 would show min < 1 or be all-1, impossible for open sets);   3. the map: every non-rim piece is shared by
  exactly two tiles in opposite directions (YB's `consistency`); the float area sum equals the rim polygon's area;   4. the fragment holds the
  closed disc of radius R0 = 3 sqrt3/5 about p (exact distance from p to every rim segment);   5. the vertex p: exactly the tiles t1..t4, four
  colours; its four pieces are unit arcs about q1..q4;   6. each q_i: the colours of the tiles with a corner at q_i (at least four);   7. the
  tactic: T_i has colour c(outer tile) and meets the inner tile only at q_i (exact: the closed tile T_i keeps distance >= 1 from p, and the only
  points of its boundary at distance exactly 1 from p are at q_i -- checked piece by piece).

PLANTS (each beside the faithful twin; predictions registered in plans/FS114-Y2-construction.md before the first run):
  v5       V coloured 5 (images by the colour maps)                    -> REJECT exactly (L1,V), (L4,V''), (L2,V'), (L3,V''')
  wide_t1  T1's edge to W leaves q1 at 300 degrees, c = q1 + e(300)/5 -> registered: REJECT exactly (t4,T1), (t4,T4), (t2,T2), (t2,T3);
           it also fired at (t1,W'), (t3,W), unregistered: moving c also moves W's rim chord c'c to x = 0.966 < 1, into the unit disc about p
  wide_t1b the same edge, with c = (3 sqrt3/5, 1/5) on W's unmoved rim line  -> REJECT exactly (t4,T1), (t4,T4), (t2,T2), (t2,T3)
Run: python3 tools/fs114_y2_k1.py [faithful|v5|wide_t1|all]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)
import fs114_yb_run as R     # noqa: E402  (its driver: check_finite)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub, vmul, n2, dot = X.vadd, X.vsub, X.vmul, X.n2, X.dot

T = X.Tower.base().extend(3, "3")
r3 = T.gen(1)
ONE, ZERO = T(1), T(0)


def P(x, y):
    return (T(x) if not isinstance(x, X.Num) else x, T(y) if not isinstance(y, X.Num) else y)


h = r3 / 2
p = P(0, 0)
q1, q2, q3, q4 = P(h, Fr(1, 2)), P(h, Fr(-1, 2)), P(-h, Fr(-1, 2)), P(-h, Fr(1, 2))
top, bot = P(0, 1), P(0, -1)
mm = (r3 - 1) / 2
m1, m2, m3, m4 = P(mm, mm), P(mm, -mm), P(-mm, -mm), P(-mm, mm)
e60, e120 = P(Fr(1, 2), h), P(Fr(-1, 2), h)
a = P(h - Fr(4, 5), Fr(11, 10))
b = P(Fr(12, 13), Fr(8, 13))
bp = vadd(a, P(Fr(15, 17), Fr(-8, 17)))
p1 = P(Fr(22, 25), Fr(33, 50))
p2 = P(Fr(33, 50), Fr(22, 25))
p3 = P(Fr(11, 26), Fr(66, 65))


def sx(z):
    return (-z[0], z[1])


def sy(z):
    return (z[0], -z[1])


CX = {1: 3, 3: 1, 5: 6, 6: 5, 2: 2, 4: 4}
CY = {2: 4, 4: 2, 5: 6, 6: 5, 1: 1, 3: 3}


def refl(tile, s, cmap, name):
    """the mirror image of a tile, boundary re-oriented counter-clockwise (reflect, then reverse the order and each piece)."""
    out = []
    for pc in reversed(tile.pieces):
        if pc.kind == "S":
            out.append(Seg(s(pc.Q), s(pc.P)))
        else:
            out.append(Arc(s(pc.C), pc.rho, s(pc.Q), s(pc.P), pc.ccw))
    return Tile(name, cmap[tile.colour], out)


def build(plant=None):
    c = P(3 * r3 / 5, Fr(2, 5))
    if plant == "wide_t1":
        c = vadd(q1, P(Fr(1, 10), -r3 / 10))          # q1 + e(300)/5
    if plant == "wide_t1b":
        c = P(3 * r3 / 5, Fr(1, 5))                     # the ray from q1 at 300 degrees meets W's rim line x = 3 sqrt3/5 here
    cp = sy(c)
    ap = sx(a)
    t1 = Tile("t1", 1, [Arc(q1, ONE, p, m2, True), Arc(q1, ONE, m2, q2, True), Arc(p, ONE, q2, q1, True),
                        Arc(q2, ONE, q1, m1, True), Arc(q2, ONE, m1, p, True)])
    t2 = Tile("t2", 2, [Arc(q2, ONE, p, m1, False), Seg(m1, e60), Arc(p, ONE, e60, top, True), Arc(p, ONE, top, e120, True),
                        Seg(e120, m4), Arc(q3, ONE, m4, p, False)])
    L1 = Tile("L1", 5, [Arc(q2, ONE, m1, q1, False), Arc(top, ONE, q1, b, True), Seg(b, p1), Seg(p1, p2), Seg(p2, p3), Seg(p3, a),
                        Arc(q1, ONE, a, top, True), Arc(p, ONE, top, e60, False), Seg(e60, m1)])
    V = Tile("V", 5 if plant == "v5" else 6, [Arc(a, ONE, q1, bp, True), Seg(bp, b), Arc(top, ONE, b, q1, False)])
    T1 = Tile("T1", 4, [Seg(q1, c), Seg(c, bp), Arc(a, ONE, bp, q1, False)])
    W = Tile("W", 3, [Seg(q2, cp), Seg(cp, c), Seg(c, q1), Arc(p, ONE, q1, q2, False)])
    N = Tile("N", 4, [Arc(q1, ONE, top, a, False), Seg(a, ap), Arc(q4, ONE, ap, top, False)])
    tiles = [t1, refl(t1, sx, CX, "t3"), t2, refl(t2, sy, CY, "t4"),
             L1, refl(L1, sx, CX, "L4"), refl(L1, sy, CY, "L2"), refl(refl(L1, sx, CX, "tmp"), sy, CY, "L3"),
             V, refl(V, sx, CX, "V''"), refl(V, sy, CY, "V'"), refl(refl(V, sx, CX, "tmp"), sy, CY, "V'''"),
             T1, refl(T1, sx, CX, "T4"), refl(T1, sy, CY, "T2"), refl(refl(T1, sx, CX, "tmp"), sy, CY, "T3"),
             N, refl(N, sy, CY, "N'"), W, refl(W, sx, CX, "W'")]
    return tiles


def is_rim(pc):
    return (n2(pc.P) - Fr(6, 5)).sign() >= 0 and (n2(pc.Q) - Fr(6, 5)).sign() >= 0


def seg_dist2(A, B, z):
    d = vsub(B, A)
    t = dot(vsub(z, A), d) / n2(d)
    if t.sign() <= 0:
        return n2(vsub(z, A))
    if (t - 1).sign() >= 0:
        return n2(vsub(z, B))
    foot = vadd(A, vmul(t, d))
    return n2(vsub(z, foot))


def corners_at(tiles, z):
    return [t for t in tiles if any(X.veq(pc.P, z) for pc in t.pieces)]


def unit_dist_points_ok(tile, z, allowed):
    """exact: no point of the closed tile is at distance < 1 from z, and on each boundary piece the points at distance exactly 1 lie in
    `allowed` (piece ends).  Segments: |.|^2 - 1 is convex along the segment, so equality away from the ends forces a tangency, checked.  Arcs:
    two distinct circles meet in at most two points, both computed."""
    lt, gt, eq, ins = X.point_tile(z, tile)
    if lt:
        return False, "some point within distance < 1"
    for pc in tile.pieces:
        ends_at1 = [e for e in pc.ends() if (n2(vsub(e, z)) - 1).is0()]
        for e in ends_at1:
            if not any(X.veq(e, w) for w in allowed):
                return False, f"piece end {X.fpt(e)} at distance 1"
        if pc.kind == "S":
            # interior points at distance exactly 1 would need both ends at distance >= 1 with the minimum 1 inside: the foot
            d2 = seg_dist2(pc.P, pc.Q, z)
            if (d2 - 1).is0() and not ends_at1:
                return False, "segment tangent to the unit circle"
        else:
            # the unit circle about z and the arc's circle (radius 1): their common points, if on the arc and not an allowed end, fail
            C = pc.C
            d = vsub(C, z)
            dd = n2(d)
            if dd.is0():
                return False, "arc concentric with the unit circle"
            # points w with |w - z| = 1 = |w - C|: on the perpendicular bisector; w = z + d/2 +- t d_perp, t^2 = 1/dd - 1/4
            t2 = 1 / dd - Fr(1, 4)
            if t2.sign() < 0:
                continue
            # decide exactly whether either intersection lies on the closed arc, in the tower extended by sqrt(t2 * dd)
            k = t2 * dd
            if k.is0():
                cands = [(d[0] / 2, d[1] / 2)]
                for w in cands:
                    if pc.has_dir(vsub(vadd(z, w), C)) and not any(X.veq(vadd(z, w), u) for u in allowed):
                        return False, "arc tangent to the unit circle"
                continue
            T2 = T.extend(k, "k")
            rk = T2.gen(len(T2.D))
            for sgn in (1, -1):
                # w - C = z + d/2 + sgn * t * dperp - C = -d/2 + sgn*(rk/dd) dperp   (t = rk/dd since t^2 dd^2 = k dd ... t = sqrt(k)/dd)
                dperp = (-d[1], d[0])
                wx = (-d[0] / 2).to(T2) + rk * sgn * (dperp[0] / dd).to(T2)
                wy = (-d[1] / 2).to(T2) + rk * sgn * (dperp[1] / dd).to(T2)
                a_, e_ = pc.a, pc.e
                on = (X.cross((a_[0].to(T2), a_[1].to(T2)), (wx, wy)).sign() >= 0 and
                      X.cross((wx, wy), (e_[0].to(T2), e_[1].to(T2))).sign() >= 0)
                if on:
                    w = (wx + C[0].to(T2), wy + C[1].to(T2))
                    if not any(((w[0] - u[0].to(T2)).is0() and (w[1] - u[1].to(T2)).is0()) for u in allowed):
                        return False, f"arc meets the unit circle about {X.fpt(z)} away from the allowed points"
    return True, "ok"


def run(plant=None):
    tiles = build(plant)
    name = {t.name: t for t in tiles}
    print(f"== FS114-Y2 K1 fragment{'' if plant is None else ' -- PLANT ' + plant}: {len(tiles)} tiles")
    rej, tmin, tmax = R.check_finite(tiles, "validity (every same-colour pair, a tile with itself included)", show=False)
    siam = [(r.A.name, r.B.name) for r in tmin + tmax if r.A is not r.B and r.max_eq1]
    distinct_lt1 = []
    for i, A in enumerate(tiles):
        for B in tiles[i + 1:]:
            if A.colour == B.colour and not X.bbox_gap_ge1(A, B):
                r = X.pair(A, B)
                if r.min_lt1:
                    distinct_lt1.append((A.name, B.name))
    print(f"non-Siamese: distinct same-colour pairs with min < 1: {distinct_lt1 or 'none'}; distinct pairs with max exactly 1: {siam or 'none'}")
    print("   tight minima (distinct pairs at minimum exactly 1): " + ", ".join(f"({r.A.name},{r.B.name})" for r in tmin))
    print("   tight maxima (tiles of diameter exactly 1): " + ", ".join(r.A.name for r in tmax if r.A is r.B))
    if plant is not None:
        return rej
    bad, unm = X.consistency(tiles, open_ok=is_rim)
    print(f"map consistency: {len(bad)} unmatched non-rim pieces; {unm} rim pieces" + ("" if not bad else f" -- {bad}"))
    rim = [pc for t in tiles for pc in t.pieces if is_rim(pc)]
    assert all(pc.kind == "S" for pc in rim)
    dmin = None
    for pc in rim:
        d2 = seg_dist2(pc.P, pc.Q, p)
        dmin = d2 if dmin is None or d2 < dmin else dmin
    R0sq = Fr(27, 25)
    print(f"the rim: {len(rim)} segments; min distance^2 from p = {float(dmin):.6f}; >= R0^2 = 27/25 (R0 = 3 sqrt3/5 = {float(3 * r3 / 5):.6f}): "
          f"{(dmin - R0sq).sign() >= 0}; equal: {(dmin - R0sq).is0()}")
    # the rim polygon's area (its segments chained) against the tiles' area sum (float guard)
    import math
    order = [rim[0]]
    while len(order) < len(rim):
        nxt = [pc for pc in rim if X.veq(pc.P, order[-1].Q)]
        assert len(nxt) == 1, "rim not a single chain"
        order.append(nxt[0])
    assert X.veq(order[-1].Q, order[0].P)
    A_rim = sum((float(pc.P[0]) * float(pc.Q[1]) - float(pc.Q[0]) * float(pc.P[1])) / 2 for pc in order)
    A_tiles = sum(t.area_float() for t in tiles)
    print(f"float guard: tiles' areas sum {A_tiles:.12f}; the rim polygon's area {A_rim:.12f}; every tile area positive: "
          f"{all(t.area_float() > 0 for t in tiles)}")
    # the vertex p
    at_p = corners_at(tiles, p)
    print(f"tiles with a corner at p: {sorted(t.name for t in at_p)}; colours {sorted(t.colour for t in at_p)}")
    for t in at_p:
        for pc in t.pieces:
            if X.veq(pc.P, p):
                print(f"   edge of {t.name} leaving p: {'unit arc about ' + str(X.fpt(pc.C)) if pc.kind == 'A' and (pc.rho - 1).is0() else pc}")
    # the tactic centres
    inner = {"q1": ("t1", "T1", "t4", q1), "q2": ("t1", "T2", "t2", q2), "q3": ("t3", "T3", "t2", q3), "q4": ("t3", "T4", "t4", q4)}
    for qn, (xin, tt, yout, qq) in inner.items():
        at = corners_at(tiles, qq)
        cols = sorted({t.colour for t in at})
        ok, why = unit_dist_points_ok(name[tt], p, [qq])
        print(f"{qn}: |{qn} - p|^2 = {n2(qq)}; tiles with a corner there {sorted(t.name for t in at)}, colours {cols} ({len(cols)}); "
              f"{tt} colour {name[tt].colour} = colour of the outer tile {yout} ({name[yout].colour}): {name[tt].colour == name[yout].colour}; "
              f"{tt} meets the closed unit disc about p only at {qn} (so meets {xin}, which lies in it, only there): {ok} ({why})")
    return rej


if __name__ == "__main__":
    what = sys.argv[1] if len(sys.argv) > 1 else "faithful"
    if what in ("faithful", "all"):
        run(None)
    if what in ("v5", "all"):
        run("v5")
    if what in ("wide_t1", "all"):
        run("wide_t1")
    if what in ("wide_t1b", "all"):
        run("wide_t1b")
