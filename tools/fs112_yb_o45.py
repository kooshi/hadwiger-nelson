#!/usr/bin/env python3
"""FS112-YB: the strip against the unit-arc-centre claims (instance O4) and the Condition-5 chain (instance O5): the exact facts the verdicts in
plans/FS112-YB-verification.md rest on.

  W   C-UA-WEDGE at every unit arc of one period: the facing wedge {d : d.e >= 0 for every arc direction e}, the away wedge {d.e <= 0}, the two
      side cones between them; where the inner and outer colours' sectors at the centre lie (exact angle comparisons).
  B   C-UA-BUDGET at the four-colour vertices: the Gamma-arcs on omega(v) and their total angle (exact cosines: arccos(1/4) - pi/3 each); the
      ring points y with P_cl(v) u P_cl(y) = all six (union sense) and with P_cl(y) = the two missing colours (disjoint sense); whether a
      Gamma-arc of omega(sigma_v^{+-1} y) passes through y.
  L   ARC-INERT's converse on the strip: an arc with a contact at both ends of its centre is locked -- bent inward (replaced by its chord) or
      outward (a kink through a point outside the circle), exactly checked: both reject, each for its own named pair.
  C   C-UA-CHAIN: the chains of unit arcs (end to end) in the strip.
  R   rings of the trivalent vertices (C-CHAIN-12, 15) and same-multicolour trivalent pairs at distances in (1, 2) (C-CHAIN-14): which part of
      each ring lies in the strip (exact: its exits are named), the ring's colours inside (float-sampled, for reading), the Gamma-crossings and
      their M-in status (float-sampled), antipodal M-in pairs with both points in the strip.
Run: python3 tools/fs112_yb_o45.py
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb_check as K      # noqa: E402
import fs112_yb_strip as ST     # noqa: E402
import fs112_yb_objects as OB   # noqa: E402

F, pt = K.F, K.pt
R3, R15 = F.sqrt(3), F.sqrt(15)
COL = ST.COLOURS


def rot90(v, k):
    """rotate by k * 90 degrees exactly."""
    for _ in range(k % 4):
        v = (-v[1], v[0])
    return v


def in_closed_ccw(a, b, d):
    """is direction d in the closed ccw angular interval from a to b (both nonzero, interval < 360)?"""
    if OB.ang_eq(d, a) or OB.ang_eq(d, b):
        return True
    if OB.ang_lt(a, b):
        return OB.ang_lt(a, d) and OB.ang_lt(d, b)
    return OB.ang_lt(a, d) or OB.ang_lt(d, b)


def sector_in(a, b, w1, w2):
    """is the closed sector [a, b] (ccw) inside the closed wedge [w1, w2] (ccw)?  a, b in the wedge, and a reached before b going ccw from w1."""
    return in_closed_ccw(w1, w2, a) and in_closed_ccw(w1, w2, b) and in_closed_ccw(w1, b, a)


def sector_meets_open(a, b, w1, w2):
    """does the closed sector [a, b] (ccw) meet the OPEN wedge (w1, w2) (ccw)?"""
    a_open = in_closed_ccw(w1, w2, a) and not OB.ang_eq(a, w1) and not OB.ang_eq(a, w2)
    w1_in = in_closed_ccw(a, b, w1) and not OB.ang_eq(w1, b)
    return a_open or w1_in


def part_W(M):
    print("== W. C-UA-WEDGE on every unit arc of one period (exact)")
    ok_all = True
    arcs = [(p, nms) for (p, nms) in M.pieces if p.kind == "A" and p.C[0].sign() >= 0 and (p.C[0] - Fr(3, 2)).sign() < 0]
    for (p, nms) in arcs:
        inner = [nm for nm in nms if all(K.n2(K.vsub(e, p.C)) <= 1 for q in M.T[nm][1] for e in q.ends())][0]
        outer = [nm for nm in nms if nm != inner][0]
        s_in, s_out = M.T[inner][0], M.T[outer][0]
        e1, e2 = K.vsub(p.S, p.C), K.vsub(p.E, p.C)          # arc ccw from e1 to e2
        face = (rot90(e2, 3), rot90(e1, 1))                  # [e2 - 90, e1 + 90]
        away = (rot90(e2, 1), rot90(e1, 3))                  # [e2 + 90, e1 + 270]
        side1 = (rot90(e1, 1), rot90(e2, 1))                 # (e1 + 90, e2 + 90)
        side2 = (rot90(e1, 3), rot90(e2, 3))                 # (e1 + 270, e2 + 270)
        inc, sectors = M.star(p.C)
        res = []
        good = True
        for (a, b, nms2) in sectors:
            col = M.T[nms2[0]][0]
            if col == s_in:
                f = sector_in(a, b, *face)
                good &= f
                res.append(f"{col}(inner) [{OB.deg(a):.1f},{OB.deg(b):.1f}] in facing wedge: {f}")
            if col == s_out:
                f = sector_in(a, b, *away)
                good &= f
                res.append(f"{col}(outer) [{OB.deg(a):.1f},{OB.deg(b):.1f}] in away wedge: {f}")
            if col in (s_in, s_out):
                sc = sector_meets_open(a, b, *side1) or sector_meets_open(a, b, *side2)
                good &= not sc
                if sc:
                    res.append(f"{col} MEETS A SIDE CONE")
        ok_all &= good
        print(f"   arc about ({float(p.C[0]):.2f},0) [{OB.deg(e1):.2f},{OB.deg(e2):.2f}] {s_in}|{s_out}: facing [{OB.deg(face[0]):.2f},{OB.deg(face[1]):.2f}] "
              f"away [{OB.deg(away[0]):.2f},{OB.deg(away[1]):.2f}] side cones ({OB.deg(side1[0]):.2f},{OB.deg(side1[1]):.2f}), "
              f"({OB.deg(side2[0]):.2f},{OB.deg(side2[1]):.2f}); " + "; ".join(res))
    print(f"   corrected C-UA-WEDGE (inner colour facing, outer colour away, side cones free of both) at every arc: {ok_all}")
    return ok_all


def part_B(M):
    print("== B. C-UA-BUDGET at the four-colour vertices (exact)")
    S = M.S
    for j in range(0, 3):
        v = S.P(j)
        pc = set(M.pcl(v))
        missing = set(COL) - pc
        arcs_on = [p for (p, nms) in M.pieces if p.kind == "A" and K.veq(p.C, v)]
        # each arc spans arccos(1/4) - pi/3: its endpoints' cosines about v are 1/2 and 1/4 (exact)
        spans = []
        for p in arcs_on:
            c = K.dot(K.vsub(p.S, v), K.vsub(p.E, v))        # cos of the arc's angle (radius 1)
            spans.append(c)
        tot = sum(math.degrees(math.acos(float(c))) for c in spans)
        exact_cos = all(c == (Fr(1, 2) * Fr(1, 4) + (R3 / 2) * (R15 / 4)) for c in spans)
        print(f"   v = P_{j} = ({float(v[0]):.2f}, 0): P_cl = {{{','.join(sorted(pc, key=COL.index))}}}, missing {{{','.join(sorted(missing, key=COL.index))}}}; "
              f"Gamma-arcs on omega(v): {len(arcs_on)}, each of cosine 1/8 + 3*sqrt5/8 = cos(arccos(1/4) - pi/3): {exact_cos}; total {tot:.4f} deg "
              f"(>= 60: {tot >= 60})")
        # ring points y (vertices on omega(v)) and covering pairs
        for y in M.verts:
            if not (K.n2(K.vsub(y, v)) == 1):
                continue
            py = set(M.pcl(y))
            union = (py | pc) == set(COL)
            disj = py == missing
            if union or disj:
                w = K.vsub(y, v)
                c60, s60 = F.of(Fr(1, 2)), R3 / 2
                sig_p = K.vadd(v, (w[0] * c60 - w[1] * s60, w[0] * s60 + w[1] * c60))
                sig_m = K.vadd(v, (w[0] * c60 + w[1] * s60, -w[0] * s60 + w[1] * c60))
                through = [p for (p, nms) in M.pieces if p.kind == "A" and (K.veq(p.C, sig_p) or K.veq(p.C, sig_m)) and ST.on_piece(p, y)]
                print(f"      ring point y = ({float(y[0]):.2f},{float(y[1]):+.4f}) P_cl = {{{','.join(sorted(py, key=COL.index))}}}: covering (union) {union}, "
                      f"P_cl(y) = the missing pair (disjoint) {disj}; sigma^(+-1) y = ({float(sig_p[0]):.2f},{float(sig_p[1]):+.4f}), "
                      f"({float(sig_m[0]):.2f},{float(sig_m[1]):+.4f}); Gamma-arcs of omega(sigma^(+-1) y) through y: {len(through)}")


def part_L(S):
    print("== L. The arc between arch 1 (G) and the top tile over V_2 (M), centred at P_1 ('both'): bent both ways, checked exactly")
    T = S.tiles(-9, 11)
    V2, A1, P1 = S.V(2), S.A(1), S.P(1)

    def replace(prims, new_list):
        out = []
        for p in prims:
            if p.kind == "A" and K.veq(p.C, P1) and ((K.veq(p.S, V2) and K.veq(p.E, A1)) or (K.veq(p.S, A1) and K.veq(p.E, V2))):
                out.extend(new_list)
            else:
                out.append(p)
        return out
    chord = [K.Seg(V2, A1)]
    # an outward kink: through the point at radius 21/20 on the ray through the chord's midpoint direction, kept in the field:
    mid = ((V2[0] + A1[0]) / 2, (V2[1] + A1[1]) / 2)
    kpt = (mid[0] * Fr(11, 10) - P1[0] * Fr(1, 10), mid[1] * Fr(11, 10) - P1[1] * Fr(1, 10))    # P1 + (11/10)(mid - P1)
    kink = [K.Seg(V2, kpt), K.Seg(kpt, A1)]
    print(f"   kink point at distance {float(K.n2(K.vsub(kpt, P1))) ** 0.5:.5f} from P_1 (outside the unit circle: {K.n2(K.vsub(kpt, P1)) > 1})")
    for label, new, pred in [("inward (the chord): the top tile T2 (M) comes within 1 of P_1, a corner of D0 (M)", chord, {("D0", "T2")}),
                             ("outward (a kink beyond the circle): arch U1 (G) reaches beyond 1 from its own corner P_1", kink, {("U1", "U1")})]:
        T2 = dict(T)
        T2["U1"] = (T["U1"][0], replace(T["U1"][1], new))
        T2["T2"] = (T["T2"][0], replace(T["T2"][1], new))
        bad = []
        for a in ("U1", "T2"):
            for b in T2:
                if T2[b][0] == T2[a][0]:
                    r = K.pair_verdict(T2[a][1], T2[b][1], self_pair=(a == b))
                    if r.verdict == "REJECT":
                        bad.append(tuple(sorted((a, b))))
        bad = set(bad)
        print(f"   {label}: rejected pairs {sorted(bad)}; predicted {sorted(pred)}: {'as predicted' if bad == pred else 'MISMATCH'}")


def part_C(M):
    print("== C. Chains of unit arcs (end to end) in the strip")
    S = M.S
    arcs = [p for (p, nms) in M.pieces if p.kind == "A"]
    # follow the upper chain from V_0 to the right
    X = S.V(0)
    seq = []
    for _ in range(7):
        nxt = [p for p in arcs if any(K.veq(e, X) for e in p.ends()) and p not in [q for (q, _) in seq] and (p.S[1].sign() > 0)
               and (p.S[0] + p.E[0] - X[0] * 2).sign() > 0]
        if not nxt:
            break
        p = nxt[0]
        other = p.E if K.veq(p.S, X) else p.S
        seq.append((p, X))
        X = other
    print("   upper chain: " + " -> ".join(f"({float(x[0]):.2f},{float(x[1]):.4f}) [omega({float(p.C[0]):.1f},0)]" for (p, x) in seq)
          + f" -> ({float(X[0]):.2f},{float(X[1]):.4f}) ...")
    print("   each junction is a trivalent vertex (a valley V or an apex A) where two unit arcs about different centres meet at an angle; the chain is "
          "periodic (period 1/2 up to colour permutation), bi-infinite, and lies at heights sqrt3/2 .. sqrt15/4; its mirror runs below the midline")


def ring_report(M, u, name):
    """the ring omega(u) for a vertex u of the strip: exits from the strip (exact), Gamma crossings (float), colours (float), M-in points."""
    S = M.S
    Y = S.Y
    pc = set(M.pcl(u))
    # exits: omega(u) meets y = +-Y where (y - u_y)^2 <= 1
    N = 4000
    pts = []
    for k in range(N):
        th = 2 * math.pi * k / N
        x, y = float(u[0]) + math.cos(th), float(u[1]) + math.sin(th)
        pts.append((th, x, y))
    outside = [th for (th, x, y) in pts if abs(y) > float(Y)]
    # colours by float point-in-tile
    tiles = {nm: ps for nm, (c, ps) in M.T.items()}

    def colour_at(x, y):
        hits = [nm for nm, ps in tiles.items() if inside_float(ps, x, y)]
        return (M.T[hits[0]][0] if len(hits) == 1 else ("-" if not hits else "?"))
    seqc = []
    for (th, x, y) in pts:
        c = "out" if abs(y) > float(Y) else colour_at(x, y)
        if not seqc or seqc[-1][1] != c:
            seqc.append((th, c))
    return pc, outside, seqc


_POLY = {}


def inside_float(prims, x, y):
    key = id(prims)
    if key not in _POLY:
        chain = []
        for p in prims:
            if p.kind == "S":
                chain.append([K.fpt(p.P), K.fpt(p.Q)])
            else:
                cx, cy = K.fpt(p.C)
                r = float(p.r)
                a0 = math.atan2(float(p.S[1]) - cy, float(p.S[0]) - cx)
                a1 = math.atan2(float(p.E[1]) - cy, float(p.E[0]) - cx)
                span = (a1 - a0) % (2 * math.pi)
                chain.append([(cx + r * math.cos(a0 + span * i / 64), cy + r * math.sin(a0 + span * i / 64)) for i in range(65)])
        _POLY[key] = chain
    cnt = 0
    for ch in _POLY[key]:
        for (x1, y1), (x2, y2) in zip(ch, ch[1:]):
            if (y1 > y) != (y2 > y) and x < x1 + (y - y1) * (x2 - x1) / (y2 - y1):
                cnt += 1
    return cnt % 2 == 1


def part_R(M):
    print("== R. Rings of the trivalent vertices of one period (upper half; the lower half is the mirror image with (P M)(G R)(B O))")
    S = M.S
    Y = S.Y
    tri = [S.V(0), S.V(1), S.V(2), S.A(0), S.A(1), S.A(2)]
    for u in tri:
        pc, outside, seqc = ring_report(M, u, "")
        # exact exits: omega(u) n {y = Y}: x = u_x +- sqrt(1 - (Y - u_y)^2); for V: (Y - sqrt3/2)^2 = 15/16 -> +-1/4; for A: 3/4 -> +-1/2
        dy2 = (Y - u[1]) * (Y - u[1])
        rem = F.of(1) - dy2
        exits = f"x = {float(u[0]):.2f} +- sqrt({rem!r})"
        print(f"   u = ({float(u[0]):.2f},{float(u[1]):.4f}) P_cl={{{','.join(sorted(pc, key=COL.index))}}}: ring leaves the strip on the arc between the "
              f"edge points {exits} (angles {math.degrees(min(outside)):.2f}..{math.degrees(max(outside)):.2f} deg, float); ring colours inside "
              f"(float-sampled, ccw from 0 deg): " + " ".join(f"{math.degrees(th):.1f}:{c}" for (th, c) in seqc))
    # exact M-in points of each ring (vertices x on omega(u) with a tile of a colour of M = P_cl(u) meeting the open inner half-plane at x) and their
    # antipodes 2u - x (C-CHAIN-15)
    print("   M-in points on each ring (exact; tile-interior ring points are never M-in by A-CIRC) and their antipodes:")
    for u in tri:
        Mset = set(M.pcl(u))
        min_pts = []
        for x in M.verts:
            if not (K.n2(K.vsub(x, u)) == 1):
                continue
            inward = K.vsub(u, x)
            inc, sectors = M.star(x)
            hit = []
            for (a, b, nms) in sectors:
                if not nms:
                    continue
                c = M.T[nms[0]][0]
                if c not in Mset:
                    continue
                # the sector meets {d : d.inward > 0}: an endpoint direction does, or the sector spans the inward direction
                if K.dot(a, inward).sign() > 0 or K.dot(b, inward).sign() > 0 or in_closed_ccw(a, b, inward):
                    hit.append(c)
            if hit:
                min_pts.append((x, hit))
        desc = []
        for (x, hit) in min_pts:
            xa = K.vsub(K.vmul(2, u), x)
            inside = (xa[1] - Y).sign() < 0 and (xa[1] + Y).sign() > 0
            anti_min = any(K.veq(xa, z) for (z, _) in min_pts)
            desc.append(f"({float(x[0]):.2f},{float(x[1]):+.3f}) via {','.join(hit)}; antipode ({float(xa[0]):.2f},{float(xa[1]):+.3f}) "
                        f"{'in the strip' if inside else 'BEYOND the strip'}, M-in: {anti_min}")
        print(f"      u = ({float(u[0]):.2f},{float(u[1]):.4f}) M = {{{','.join(sorted(Mset, key=COL.index))}}}: " + ("; ".join(desc) or "none"))
    # same-multicolour trivalent pairs at distance in (1, 2)
    print("   same-multicolour trivalent pairs at distance in (1, 2), a member in the period (exact distances):")
    allv = [v for v in M.verts if M.pcl(v) and len(M.pcl(v)) == 3]
    for u in tri + [S.V(0, -1), S.V(1, -1), S.V(2, -1), S.A(0, -1), S.A(1, -1), S.A(2, -1)]:
        for v in allv:
            if K.veq(u, v):
                continue
            d2 = K.n2(K.vsub(u, v))
            if d2 > 1 and d2 < 4 and set(M.pcl(u)) == set(M.pcl(v)):
                on_edge = []
                print(f"      ({float(u[0]):.2f},{float(u[1]):+.4f}) -- ({float(v[0]):.2f},{float(v[1]):+.4f}) {{{','.join(M.pcl(u))}}}  d^2 = {d2!r} "
                      f"(~{float(d2) ** 0.5:.4f})")


def main():
    S = ST.Strip()
    M = OB.Map(S, -6, 8)
    part_W(M)
    part_B(M)
    part_L(S)
    part_C(M)
    part_R(M)


if __name__ == "__main__" and "--zonly" not in sys.argv:
    main()


def point_tile_straddles(Z, pieces):
    """exact: is there an interior point of the tile at distance exactly 1 from the point Z (Z outside the tile)?  (min < 1 < max over the
    tile's boundary: candidates VV/VS/VA from Z; the tile interior is open and connected.)"""
    cs = []
    for p in pieces:
        for e in p.ends():
            cs.append((K.n2(K.vsub(Z, e)), K.F.of(0), None))
        K._cand_point(Z, p, cs, "Z")
    cls = [K.cmp1(c) for c in cs]
    return any(k < 0 for k in cls) and any(k > 0 for k in cls)


def part_Z(S):
    print("== Z. O3's edge point X1 = (1/4, Y): points just above it, every colour tested exactly (a straddling tile of that colour = an interior point at distance 1)")
    T = S.tiles(-9, 11)
    X1 = (F.of(Fr(1, 4)), S.Y)
    e = Fr(1, 100)
    tests = [("X1 + (0, 1/100)   (direction 90)", (X1[0], X1[1] + e)),
             ("X1 + (1/100, 1/100)  (direction 45)", (X1[0] + e, X1[1] + e)),
             ("X1 + (-1/100, 1/100) (direction 135)", (X1[0] - e, X1[1] + e)),
             ("X1 + (-1/100, 1/1000) (direction 174, OUTSIDE the cone (30, 165.52))", (X1[0] - e, X1[1] + Fr(1, 1000))),
             ("control: (1/2, Y + 1/100), above the middle of the top tile over V_1", (F.of(Fr(1, 2)), S.Y + e))]
    for (label, Z) in tests:
        excluded = {}
        for nm, (c, ps) in T.items():
            if c in excluded:
                continue
            if point_tile_straddles(Z, ps):
                excluded[c] = nm
        free = [c for c in COL if c not in excluded]
        print(f"   {label}: colours excluded {sorted(excluded, key=COL.index)} (witness tiles {', '.join(f'{c}:{excluded[c]}' for c in sorted(excluded, key=COL.index))}); "
              f"free: {free or 'NONE'}")


if __name__ == "__main__":
    part_Z(ST.Strip())
