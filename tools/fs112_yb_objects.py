#!/usr/bin/env python3
"""FS112-YB: the exact structural report on the rebuilt strip (tools/fs112_yb_strip.py) and the instance's objects O1-O3
(data/fs112/briefs/YB112-instance.md), all exact in Q(sqrt3, sqrt5) (floats printed for reading only).

  O1  every vertex of one period: closure type P_cl, degree (pieces of the boundary set at the vertex, the strip's edge excluded), the
      sectors in angular order; every boundary arc of radius 1: centre, inner/outer tiles and colours, contact kind at the centre
      (claim list §0: in (self when the inner tile holds the centre), out, both, inert); the symmetries (exact tile-to-tile maps);
      every covering pair (closure types uniting to all six) of vertices at distance < 2 with a member in the period, its two common unit
      points located (inside the strip, on its edge, beyond) and, when inside, whether they are vertices.
  O2  the unit rhombus P1 = (1/2, 0), P3 = (3/2, 0), W = (1, sqrt3/2), W' = (1, -sqrt3/2).
  O3  V0 = (0, sqrt3/2), A1 = (3/4, sqrt15/4) and their common unit point on the top edge.
Run: python3 tools/fs112_yb_objects.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb_check as K    # noqa: E402
import fs112_yb_strip as ST   # noqa: E402

F, pt, Sur = K.F, K.pt, K.Sur
R3, R5, R15 = F.sqrt(3), F.sqrt(5), F.sqrt(15)
COL = ST.COLOURS


# ------------------------------------------------------------------ exact angular tools
def half(v):
    """0 for angle in [0, pi), 1 for [pi, 2 pi) (v has F or Sur components)."""
    x, y = v
    sy, sx = K.sgn(y), K.sgn(x)
    return 0 if (sy > 0 or (sy == 0 and sx > 0)) else 1


def ang_lt(u, v):
    hu, hv = half(u), half(v)
    if hu != hv:
        return hu < hv
    return K.sgn(K.cross(u, v)) > 0


def ang_eq(u, v):
    return half(u) == half(v) and K.sgn(K.cross(u, v)) == 0


def deg(v):
    import math
    return math.degrees(math.atan2(float(v[1]), float(v[0]))) % 360


def tangent_at(p, X):
    """the direction in which piece p leaves its endpoint X."""
    if p.kind == "S":
        return K.vsub(p.Q, X) if K.veq(p.P, X) else K.vsub(p.P, X)
    w = K.vsub(X, p.C)
    if K.veq(X, p.S):
        return (-w[1], w[0])       # ccw from S
    return (w[1], -w[0])           # back into the arc from E


class Map:
    def __init__(self, S, jlo=-6, jhi=8):
        self.S = S
        self.T = S.tiles(jlo, jhi)
        self.pieces = []
        for nm, (c, ps) in self.T.items():
            for p in ps:
                for q in self.pieces:
                    if ST.piece_equal(p, q[0]):
                        q[1].append(nm)
                        break
                else:
                    self.pieces.append([p, [nm]])
        self.verts = []
        for (p, _) in self.pieces:
            for e in p.ends():
                if not any(K.veq(e, v) for v in self.verts):
                    self.verts.append(e)

    def on_edge(self, p):
        Y = self.S.Y
        return p.kind == "S" and (((p.P[1] - Y).is0() and (p.Q[1] - Y).is0()) or ((p.P[1] + Y).is0() and (p.Q[1] + Y).is0()))

    def pcl(self, X):
        return sorted({self.T[nm][0] for (p, nms) in self.pieces if ST.on_piece(p, X) for nm in nms}, key=COL.index)

    def star(self, X):
        """the pieces at the vertex X (edge pieces excluded), sorted by leaving direction; sectors between consecutive pieces with their
        tile. Returns [(direction, piece, tiles-of-piece)] and [(from_dir, to_dir, tile name)]."""
        inc = []
        for (p, nms) in self.pieces:
            if any(K.veq(e, X) for e in p.ends()):
                inc.append((tangent_at(p, X), p, nms))
        inc.sort(key=lambda t: deg(t[0]))
        # exact re-check of the order
        for i in range(len(inc) - 1):
            assert ang_lt(inc[i][0], inc[i + 1][0]) or ang_eq(inc[i][0], inc[i + 1][0])
        sectors = []
        for i in range(len(inc)):
            a, b = inc[i], inc[(i + 1) % len(inc)]
            common = set(a[2]) & set(b[2])
            sectors.append((a[0], b[0], sorted(common)))
        return inc, sectors

    def colour_in_direction(self, X, d):
        """the tile at vertex X whose sector contains direction d (strictly), or 'edge' if d runs along a piece."""
        inc, sectors = self.star(X)
        for (dir_, p, nms) in inc:
            if ang_eq(dir_, d):
                return f"along a boundary piece ({'arc' if p.kind == 'A' else 'segment'})"
        for (a, b, nms) in sectors:
            # d strictly between a and b counter-clockwise
            if ang_lt(a, b):
                inside = ang_lt(a, d) and ang_lt(d, b)
            else:
                inside = ang_lt(a, d) or ang_lt(d, b)
            if inside:
                if not nms:
                    return "outside the strip"
                return "/".join(f"{nm}({self.T[nm][0]})" for nm in nms)
        return "?"


def circle_meet(c1, c2):
    """the two common unit points of the unit circles about c1, c2 (|c1 - c2| < 2), as (Sur, Sur) pairs."""
    e = K.vsub(c2, c1)
    D = K.n2(e)
    al = F.of(Fr(1, 2))
    h2 = F.of(1) / D - al * al
    out = []
    for sg in (1, -1):
        out.append((Sur(c1[0] + al * e[0], -sg * e[1], h2), Sur(c1[1] + al * e[1], sg * e[0], h2)))
    return out, h2


def main():
    S = ST.Strip()
    M = Map(S)
    Y = S.Y
    print("== O1. The strip rebuilt: vertices of one period (x in [0, 3/2)), closure types, degrees, sectors")
    per = [v for v in M.verts if (v[0].sign() >= 0) and (v[0] - Fr(3, 2)).sign() < 0 and (v[1] - Y).sign() <= 0 and (v[1] + Y).sign() >= 0]
    per.sort(key=lambda v: (-float(v[1]), float(v[0])))
    for v in per:
        inc, sectors = M.star(v)
        edge = (v[1] - Y).is0() or (v[1] + Y).is0()
        d = sum(1 for (_, p, _) in inc if not M.on_edge(p))
        secs = "  ".join(f"[{deg(a):.2f},{deg(b):.2f}]:{'/'.join(M.T[n][0] for n in nms) or '-'}" for (a, b, nms) in sectors)
        print(f"   ({float(v[0]):.4f}, {float(v[1]):+.4f}) {'edge ' if edge else '     '} P_cl={{{','.join(M.pcl(v))}}} "
              f"|P_cl|={len(M.pcl(v))} degree={d}   sectors {secs}")
    print("== O1. Every boundary arc of one period (all have radius 1): centre, sides, contact kind at the centre")
    arcs = [(p, nms) for (p, nms) in M.pieces if p.kind == "A" and (p.C[0].sign() >= 0) and (p.C[0] - Fr(3, 2)).sign() < 0]
    kinds = {}
    for (p, nms) in sorted(arcs, key=lambda t: (float(t[0].C[0]), float(t[0].S[1]), float(t[0].S[0]))):
        assert (p.r - 1).is0() and len(nms) == 2
        # inner tile: the tile holding the arc's centre side -- the one whose other pieces lie inside the closed unit disc about C
        inner = [nm for nm in nms if all(K.n2(K.vsub(e, p.C)) <= 1 for q in M.T[nm][1] for e in q.ends())]
        assert len(inner) == 1, (repr(p), nms)
        inner = inner[0]
        outer = [nm for nm in nms if nm != inner][0]
        s_in, s_out = M.T[inner][0], M.T[outer][0]
        pc = M.pcl(p.C)
        self_ = any(ST.on_piece(q, p.C) for q in M.T[inner][1])
        inc = s_in in pc
        out = s_out in pc
        kind = ("both" if inc and out else "in" if inc else "out" if out else "inert") + (" (in-contact self)" if self_ else "")
        kinds[kind] = kinds.get(kind, 0) + 1
        print(f"   arc about ({float(p.C[0]):.2f}, 0) from ({float(p.S[0]):.4f},{float(p.S[1]):+.4f}) to ({float(p.E[0]):.4f},{float(p.E[1]):+.4f}):"
              f" inner {inner}({s_in}) | outer {outer}({s_out});  P_cl(centre)={{{','.join(pc)}}}  ->  {kind}")
    print(f"   contact kinds over the {len(arcs)} arcs of the period: {kinds}")
    print("== O1. Symmetries (exact: every tile of the period maps onto a tile; the colour permutation)")
    half_ = F.of(Fr(1, 2))
    for (label, f, refl) in [("translation by 1/2", lambda p: (p[0] + half_, p[1]), False),
                             ("translation by 3/2", lambda p: (p[0] + Fr(3, 2), p[1]), False),
                             ("reflection y -> -y", lambda p: (p[0], -p[1]), True),
                             ("reflection x -> -x (axis through the midline vertex P_0)", lambda p: (-p[0], p[1]), True),
                             ("reflection x -> 1/2 - x (axis through the apex A_0)", lambda p: (half_ - p[0], p[1]), True),
                             ("half-turn about P_0", lambda p: (-p[0], -p[1]), False),
                             ("glide: y -> -y then x + 1/4", lambda p: (p[0] + Fr(1, 4), -p[1]), True),
                             ("translation by 1/4", lambda p: (p[0] + Fr(1, 4), p[1]), False)]:
        perm, why = ST.symmetry(S, f, refl, label)
        print(f"   {label:58s} {'colour permutation ' + ST.cycles(perm) if perm is not None else 'NOT a symmetry: ' + why}")
    print("== O1. Tightness: every same-colour pair within reach touches at exactly 1 (from tools/fs112_yb_strip.py's exact check)")
    rows, bad, gmin = ST.check_strip(S)
    reach = [r for (a, b, c, r) in rows if r.lo_class <= 0]
    exact = [r for r in reach if r.contacts]
    print(f"   pairs within reach (min <= 1): {len(reach)}; of them with an exact contact at distance 1: {len(exact)}; slack pairs within reach: "
          f"{len(reach) - len(exact)};  per colour: " + ", ".join(
              f"{c}: {sum(1 for (a, b, cc, r) in rows if cc == c and r.lo_class <= 0)}" for c in COL))

    print("== O1/O3. Covering pairs of vertices (P_cl uniting to all six) at distance < 2, a member in the period; their common unit points")
    cov = []
    for u in per:
        for v in M.verts:
            if K.veq(u, v):
                continue
            d2 = K.n2(K.vsub(u, v))
            if not (d2 < 4):
                continue
            pu, pv = set(M.pcl(u)), set(M.pcl(v))
            if pu | pv != set(COL):
                continue
            key = tuple(sorted([(float(u[0]), float(u[1])), (float(v[0]), float(v[1]))]))
            if any(k == key for k, *_ in cov):
                continue
            cov.append((key, u, v, pu, pv, d2))
    for (key, u, v, pu, pv, d2) in sorted(cov, key=lambda t: float(t[5])):
        pts_, h2 = circle_meet(u, v)
        locs = []
        for X in pts_:
            ys = (X[1] - Y).sign()
            yb = (X[1] + Y).sign()
            where = "beyond the strip" if (ys > 0 or yb < 0) else ("ON THE EDGE" if (ys == 0 or yb == 0) else "inside")
            # a vertex? exact confirmation against the vertex list
            vx = None
            for w in M.verts:
                if abs(float(w[0]) - float(X[0])) < 1e-12 and abs(float(w[1]) - float(X[1])) < 1e-12:
                    if (K.n2(K.vsub(w, u)) == 1) and (K.n2(K.vsub(w, v)) == 1):
                        vx = w
            locs.append(f"({float(X[0]):.4f},{float(X[1]):+.4f}) {where}" + (f", vertex P_cl={{{','.join(M.pcl(vx))}}}" if vx else ", not a vertex"))
        disj = "complementary" if not (pu & pv) else f"overlap {{{','.join(sorted(pu & pv, key=COL.index))}}}"
        print(f"   ({key[0][0]:.4f},{key[0][1]:+.4f}) {{{','.join(sorted(pu, key=COL.index))}}} -- ({key[1][0]:.4f},{key[1][1]:+.4f}) "
              f"{{{','.join(sorted(pv, key=COL.index))}}}  d^2 = {d2!r} (~{float(d2) ** 0.5:.4f}) {disj};  common unit points: " + "; ".join(locs))

    print("== O2. The unit rhombus")
    P1, P3 = pt(Fr(1, 2), 0), pt(Fr(3, 2), 0)
    W, W2 = (F.of(1), R3 / 2), (F.of(1), -R3 / 2)
    for nm, X in [("P1 = (1/2, 0)", P1), ("P3 = (3/2, 0) (the instance's 'P_2')", P3), ("W = (1, sqrt3/2)", W), ("W' = (1, -sqrt3/2)", W2)]:
        inc, sectors = M.star(X)
        print(f"   {nm:40s} P_cl={{{','.join(M.pcl(X))}}}  degree {len(inc)}")
    print(f"   |P1 W|^2 = {K.n2(K.vsub(P1, W))!r}, |P1 W'|^2 = {K.n2(K.vsub(P1, W2))!r}, |P3 W|^2 = {K.n2(K.vsub(P3, W))!r}, "
          f"|P3 W'|^2 = {K.n2(K.vsub(P3, W2))!r}, |P1 P3|^2 = {K.n2(K.vsub(P1, P3))!r}, |W W'|^2 = {K.n2(K.vsub(W, W2))!r}")
    pw, pw2 = set(M.pcl(W)), set(M.pcl(W2))
    print(f"   W, W' complementary: {not (pw & pw2) and (pw | pw2) == set(COL)}  (types {{{','.join(sorted(pw, key=COL.index))}}} and "
          f"{{{','.join(sorted(pw2, key=COL.index))}}}), at distance sqrt3")
    pts_, h2 = circle_meet(P1, P3)
    print(f"   omega(P1) n omega(P3): " + ", ".join(f"({float(X[0]):.4f},{float(X[1]):+.4f})" for X in pts_) + f"  (h^2 = {h2!r}: the points (1, +-sqrt3/2) = W, W')")
    print(f"   omega(P1) n omega(P3) as the instance writes it, 'omega(P_1) n omega(P_2)' with P_2 = (3/2, 0): {{W, W'}}; the closure types meet: "
          f"P_cl(P1) n P_cl(P3) = {{{','.join(sorted(set(M.pcl(P1)) & set(M.pcl(P3)), key=COL.index))}}}")
    for nm, X in [("W", W), ("W'", W2)]:
        for (dir_, p, nms) in M.star(X)[0]:
            if p.kind == "A":
                other = p.E if K.veq(p.S, X) else p.S
                interior = (other[1] - Y).sign() < 0 and (other[1] + Y).sign() > 0 and (X[1] - Y).sign() < 0 and (X[1] + Y).sign() > 0
                print(f"   unit arc through {nm}: about ({float(p.C[0]):.2f}, 0), ends {nm} and ({float(other[0]):.4f},{float(other[1]):+.4f}); "
                      f"both ends interior to the strip: {interior}; the ends' closure types {{{','.join(M.pcl(X))}}} and {{{','.join(M.pcl(other))}}}")
    for (cname, C) in [("W", W), ("W'", W2)]:
        for (vname, V) in [("P1", P1), ("P3", P3)]:
            w = K.vsub(V, C)
            tdir = (-w[1], w[0])
            a = M.colour_in_direction(V, tdir)
            b = M.colour_in_direction(V, K.vneg(tdir))
            print(f"   omega({cname}) at {vname}: leaves along {deg(tdir):.2f} deg into {a}; along {deg(K.vneg(tdir)):.2f} deg into {b}")
    # alternation of the two circles' branches at P1 (Y-T2W)
    for (vname, V) in [("P1", P1), ("P3", P3)]:
        dirs = []
        for (cname, C) in [("W", W), ("W'", W2)]:
            w = K.vsub(V, C)
            for t in ((-w[1], w[0]), (w[1], -w[0])):
                dirs.append((deg(t), cname))
        dirs.sort()
        print(f"   branches of omega(W), omega(W') at {vname} in angular order: " + ", ".join(f"{a:.1f}:{c}" for a, c in dirs)
              + f"  -> alternate: {all(dirs[i][1] != dirs[(i + 1) % 4][1] for i in range(4))}")

    print("== O3. V0 = (0, sqrt3/2), A1 = (3/4, sqrt15/4), and the top edge y = Y")
    V0, A1 = (F.of(0), R3 / 2), (F.of(Fr(3, 4)), R15 / 4)
    for nm, X in [("V0", V0), ("A1", A1)]:
        inc, sectors = M.star(X)
        secs = "  ".join(f"[{deg(a):.2f},{deg(b):.2f}]:{'/'.join(M.T[n][0] for n in nms)}" for (a, b, nms) in sectors)
        print(f"   {nm}: P_cl={{{','.join(M.pcl(X))}}} degree {len(inc)}  sectors {secs}")
    d2 = K.n2(K.vsub(V0, A1))
    print(f"   |V0 A1|^2 = {d2!r}  (= (9 - 3 sqrt5)/4: {(d2 - (F.of(9) - R5 * 3) / 4).is0()}; distance ~{float(d2) ** 0.5:.6f})")
    X1 = (F.of(Fr(1, 4)), Y)
    X2 = pt(Fr(1, 2), 0)
    print(f"   common unit points: X1 = (1/4, Y): |X1 V0|^2 = {K.n2(K.vsub(X1, V0))!r}, |X1 A1|^2 = {K.n2(K.vsub(X1, A1))!r}, on the top edge (y = Y exactly); "
          f"X2 = V0 + A1 - X1 = {tuple(float(c) for c in K.vsub(K.vadd(V0, A1), X1))} = P1 = (1/2, 0): |P1 V0|^2 = {K.n2(K.vsub(X2, V0))!r}, "
          f"|P1 A1|^2 = {K.n2(K.vsub(X2, A1))!r}")
    print(f"   X1 is the vertex where T0 ({M.T['T0'][0]}) and T1 ({M.T['T1'][0]}) meet the top edge: P_cl(X1) = {{{','.join(M.pcl(X1))}}}")
    # the cone above X1 outside both unit discs: directions u with u.(X1 - V0) > 0 and u.(X1 - A1) > 0
    n1, n2_ = K.vsub(X1, V0), K.vsub(X1, A1)
    print(f"   Z = X1 + eps*u is outside D(V0,1) and D(A1,1) iff u.(X1-V0) > 0 and u.(X1-A1) > 0: directions ({deg(n2_) - 90:.2f}, {deg(n1) + 90:.2f}) deg,"
          f" all above the edge")
    for (nm, C, n) in [("V0", V0, n1), ("A1", A1, n2_)]:
        inc, sectors = M.star(C)
        crossed = [f"{deg(d):.2f}" for (d, p, nms) in inc if K.dot(d, n).sign() > 0]
        met = []
        for (a, b, nms) in sectors:
            # the sector meets the half-plane {d.n > 0} in an open set iff one of its bounding rays is crossed, or it spans n
            spans = (ang_lt(a, n) and ang_lt(n, b)) if ang_lt(a, b) else (ang_lt(a, n) or ang_lt(n, b))
            if K.dot(a, n).sign() > 0 or K.dot(b, n).sign() > 0 or spans:
                met.append("/".join(M.T[x][0] for x in nms))
        print(f"   near {nm}: omega(Z) runs at a small positive offset toward X1 (normal {deg(n):.2f} deg); the rays it crosses: {crossed}; the sectors it "
              f"passes through (their colours): {sorted(set(met), key=COL.index)}")
    print("   => every point of that open cone near X1 is at distance exactly 1 from interior points of all six colours (O3's answer: no colour)")


if __name__ == "__main__":
    main()
