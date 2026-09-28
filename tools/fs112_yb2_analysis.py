#!/usr/bin/env python3
"""FS112-YB2's exact analysis of the disk (instance O1-O3, O5) and of the strip (O2, O4), at named points only (no scan).

Every statement printed is decided in exact tower arithmetic by tools/fs112_yb2_check.py's primitives.
  point_tile(z, T):  the exact minimum and maximum of |z - q| over q in the tile T, each against 1, with the realising contacts at exactly 1.
  A colour c is BLOCKED at z (strictly) iff some c-tile T has min < 1 < max: then every point near z is blocked for c.  A tile with max = 1
  exactly (T inside the closed unit disc about z) touching the unit circle at a vertex V blocks z + eps*d, for small eps, iff (V - z).d < 0; with
  min = 1 exactly, iff (V - z).d > 0 (first order: near V the unit circle about z + eps d is the tangent line at V shifted by eps (V-z).d).
Run: python3 tools/fs112_yb2_analysis.py [o1|o2|o3|o5|strip ...]
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K   # noqa: E402
import fs112_yb2_objects as O   # noqa: E402

Seg, Arc = K.Seg, K.Arc
vadd, vsub, vmul, n2, dot, cross, perp, veq = K.vadd, K.vsub, K.vmul, K.n2, K.dot, K.cross, K.perp, K.veq


def deg(p):
    return math.degrees(math.atan2(float(p[1]), float(p[0]))) % 360


# ------------------------------------------------------------------ a point against a tile
def point_cands(z, p):
    """(A, B, kind, witness) for |z - q| extremes over q in the piece p: distance |sqrt A + B|."""
    T = z[0].T
    out = []
    for X in p.ends():
        out.append((n2(vsub(z, X)), T(0), "vertex", X))
    if p.kind == "S":
        v = vsub(p.Q, p.P)
        t = dot(vsub(z, p.P), v)
        if t.sign() > 0 and t < n2(v):
            c = cross(vsub(z, p.P), v)
            out.append((c * c / n2(v), T(0), "foot", p))
    else:
        w = vsub(z, p.C)
        if K.is0v(w):
            out.append((T(0), p.rho, "centre", p))
        else:
            if p.has_dir(w):
                out.append((n2(w), -p.rho, "near-radial", p))
            if p.has_dir(vmul(-1, w)):
                out.append((n2(w), p.rho, "far-radial", p))
    return out


def point_tile(z, pieces):
    cs = [c for p in pieces for c in point_cands(z, p)]
    on = any(p.contains(z) for p in pieces)
    lo = on or any(K.lt1(A, B) for A, B, _, _ in cs)
    hi = any(K.gt1(A, B) for A, B, _, _ in cs)
    eq = [(kind, wit) for A, B, kind, wit in cs if not K.lt1(A, B) and not K.gt1(A, B)]
    mn = "<" if lo else ("=" if eq else ">")
    mx = ">" if hi else ("=" if eq else "<")
    return mn, mx, eq


def classify(z, tiles, label):
    """per tile: min, max against 1; returns {colour: {"strict": [tiles], "maxc": [(tile, V)], "minc": [(tile, V)]}}."""
    by = {}
    for nm, (c, ps) in sorted(tiles.items()):
        mn, mx, eq = point_tile(z, ps)
        d = by.setdefault(c, {"strict": [], "maxc": [], "minc": [], "other": []})
        if mn == "<" and mx == ">":
            d["strict"].append(nm)
        elif mx == "=" and mn == "<":
            d["maxc"].append((nm, [w for k, w in eq]))
        elif mn == "=":
            d["minc"].append((nm, [w for k, w in eq], mx))
    print(f"-- {label}: z ~ ({float(z[0]):.6f}, {float(z[1]):.6f}), |z| ~ {math.hypot(float(z[0]), float(z[1])):.6f}")
    for c in sorted(by):
        d = by[c]
        s = []
        if d["strict"]:
            s.append("STRICTLY BLOCKED by " + ",".join(d["strict"]))
        for nm, ws in d["maxc"]:
            s.append(f"max = 1 at {nm} via " + "; ".join(desc(w) for w in ws))
        for nm, ws, mx in d["minc"]:
            s.append(f"min = 1 at {nm} (max {mx} 1) via " + "; ".join(desc(w) for w in ws))
        print(f"   {c:7s} " + (" | ".join(s) if s else "free (every tile of this colour: max < 1 or min > 1)"))
    return by


def desc(w):
    if isinstance(w, tuple):
        return f"vertex ({float(w[0]):.5f}, {float(w[1]):.5f})"
    return f"{w.kind}-piece {w!r}"


# ------------------------------------------------------------------ the disk's features
def vertex_table(tiles, rim_r):
    pts = []
    for nm, (c, ps) in tiles.items():
        for p in ps:
            for X in p.ends():
                if not any(veq(X, Y) for Y in pts):
                    pts.append(X)
    rows = []
    for X in pts:
        ts = [nm for nm, (c, ps) in tiles.items() if any(p.contains(X) for p in ps)]
        cols = sorted({tiles[nm][0] for nm in ts})
        rim = n2(X) == rim_r * rim_r
        rows.append((X, ts, cols, rim))
    return rows


def unit_arcs(tiles):
    seen = []
    out = []
    for nm, (c, ps) in tiles.items():
        for p in ps:
            if p.kind == "A" and p.rho == 1:
                if any(veq(p.C, q.C) and veq(p.S, q.S) and veq(p.E, q.E) for q in seen):
                    continue
                seen.append(p)
                owners = [n for n, (cc, qs) in tiles.items() if any(q.kind == "A" and veq(q.C, p.C) and veq(q.S, p.S) and veq(q.E, p.E)
                                                                     for q in qs)]
                out.append((p, owners))
    return out


def run_o1(Dk=None, tiles=None, label="the disk (O1)"):
    Dk = Dk or O.Disk()
    tiles = tiles or Dk.tiles()
    T = Dk.T
    r = Dk.r
    print(f"==== {label}")
    print(f"radius r = sqrt((25 + 9 sqrt5)/10) ~ {float(r):.9f} (exact identities: tools/fs112_yb2_objects.py)")
    vt = vertex_table(tiles, r)
    print(f"vertices: {len(vt)} ({sum(1 for v in vt if not v[3])} interior, {sum(1 for v in vt if v[3])} on the rim)")
    for X, ts, cols, rim in sorted(vt, key=lambda v: (v[3], -len(v[2]), deg(v[0]))):
        print(f"   {'rim ' if rim else 'int '} ({float(X[0]):+.6f}, {float(X[1]):+.6f}) angle {deg(X):7.3f} |X| {math.hypot(*map(float, X)):.6f}"
              f"  tiles {','.join(sorted(ts))}  colours {{{', '.join(cols)}}}  ({len(cols)})")
    # unit arcs: centre, inner/outer tile (exact: the inner tile lies in the closed unit disc about the centre, the outer outside the open one)
    ua = unit_arcs(tiles)
    print(f"unit arcs: {len(ua)}")
    pcl = {}
    for X, ts, cols, rim in vt:
        pcl[(float(X[0]), float(X[1]))] = (cols, rim)
    for p, owners in ua:
        C = p.C
        cols_c = None
        for X, ts, cols, rim in vt:
            if veq(X, C):
                cols_c = cols
        inner = [n for n in owners if point_tile(C, tiles[n][1])[1] == "="]
        outer = [n for n in owners if point_tile(C, tiles[n][1])[0] == "="]
        assert len(inner) == 1 and len(outer) == 1, (owners, inner, outer)
        si, so = tiles[inner[0]][0], tiles[outer[0]][0]
        self_c = any(p2.contains(C) for p2 in tiles[inner[0]][1])
        inc = cols_c is not None and si in cols_c
        outc = cols_c is not None and so in cols_c
        kind = "both" if inc and outc else ("in" if inc else ("out" if outc else "inert"))
        ends_int = all(n2(X) < r * r for X in p.ends())
        print(f"   centre ({float(C[0]):+.5f}, {float(C[1]):+.5f}) {{{', '.join(cols_c or [])}}}: arc {deg(vsub(p.S, C)):6.2f}->{deg(vsub(p.E, C)):6.2f} deg"
              f"  inner {inner[0]} ({si}{', self' if self_c else ''}) | outer {outer[0]} ({so})  KIND {kind}{' (self)' if self_c and inc else ''}"
              f"  ends interior: {ends_int}")
    return Dk, tiles, vt


def close_complementary_pairs(Dk, tiles, vt):
    T = Dk.T
    r = Dk.r
    inner = [(X, set(cols)) for X, ts, cols, rim in vt if not rim]
    allc = set(tiles[n][0] for n in tiles)
    pairs = []
    for i in range(len(inner)):
        for j in range(i + 1, len(inner)):
            (u, cu), (v, cv) = inner[i], inner[j]
            if cu & cv or (cu | cv) != allc:
                continue
            if n2(vsub(u, v)) < 4:
                pairs.append((u, cu, v, cv))
    print(f"close complementary pairs of interior vertices: {len(pairs)}")
    out = []
    for u, cu, v, cv in pairs:
        # common unit points: find a vertex at distance 1 from both, else solve; the other is its reflection in the line uv
        w0 = None
        for X, ts, cols, rim in vt:
            if n2(vsub(X, u)) == 1 and n2(vsub(X, v)) == 1:
                w0 = X
                break
        assert w0 is not None, "no vertex common unit point (not expected on the disk)"
        d = vsub(v, u)
        t = dot(vsub(w0, u), d) / n2(d)
        foot = vadd(u, vmul(t, d))
        w1 = vsub(vmul(2, foot), w0)
        assert n2(vsub(w1, u)) == 1 and n2(vsub(w1, v)) == 1
        rw1 = n2(w1)
        where = "ON THE RIM" if rw1 == r * r else ("inside the disk" if rw1 < r * r else "OUTSIDE the disk")
        wcols = [cols for X, ts, cols, rim in vt if veq(X, w1)]
        w0cols = [cols for X, ts, cols, rim in vt if veq(X, w0)]
        print(f"   ({float(u[0]):+.4f},{float(u[1]):+.4f}) {{{', '.join(sorted(cu))}}} -- ({float(v[0]):+.4f},{float(v[1]):+.4f}) "
              f"{{{', '.join(sorted(cv))}}}  |uv| ~ {math.sqrt(float(n2(d))):.6f}\n"
              f"        common unit points: ({float(w0[0]):+.5f},{float(w0[1]):+.5f}) colours {w0cols[0] if w0cols else '-'};  "
              f"({float(w1[0]):+.5f},{float(w1[1]):+.5f}) |w| ~ {math.sqrt(float(rw1)):.6f} {where}"
              f"{' vertex ' + str(wcols[0]) if wcols else ''}")
        out.append((u, cu, v, cv, w0, w1, where))
    return out


# ------------------------------------------------------------------ the rim
def interior_rim_cands(ra, p):
    """candidates |sqrt A + B| between an INTERIOR point of the rim arc ra (centre O) and the piece p (critical in the rim point)."""
    T = ra.rho.T
    out = []
    a0, e0 = vsub(ra.S, ra.C), vsub(ra.E, ra.C)
    strict = lambda w: cross(a0, w).sign() > 0 and cross(w, e0).sign() > 0
    for X in p.ends():
        w = vsub(X, ra.C)
        if K.is0v(w):
            continue
        if strict(w):
            out.append((n2(w), -ra.rho))
        if strict(vmul(-1, w)):
            out.append((n2(w), ra.rho))
    if p.kind == "S":
        v = vsub(p.Q, p.P)
        t = dot(vsub(ra.C, p.P), v)
        if t.sign() >= 0 and t <= n2(v):
            nv = perp(v)
            h = dot(vsub(ra.C, p.P), nv)
            for sg in (1, -1):
                if strict(vmul(sg, nv)):
                    out.append((h * h / n2(v), ra.rho * (sg if h.sign() >= 0 else -sg)))
    else:
        w = vsub(p.C, ra.C)
        if not K.is0v(w):
            D = n2(w)
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if strict(vmul(s1, w)) and p.has_dir(vmul(s2, w)):
                        out.append((D, p.rho * s2 - ra.rho * s1))
    return out


def rim_open_arcs(Dk, tiles):
    """for each rim tile T and its rim arc: (i) every interior rim point has max distance < 1 to T (exact critical-point argument, with diam T
    <= 1 from the pair check), (ii) every other tile of T's colour is at minimum distance > 1 from the closed rim arc.  Then T's colour is
    available just outside every interior point of its rim arc."""
    r = Dk.r
    ok = True
    for nm, (c, ps) in sorted(tiles.items()):
        ras = [p for p in ps if p.kind == "A" and K.is0v(p.C) and p.rho == r]
        for ra in ras:
            bad = []
            for p in ps:
                if p is ra:
                    continue
                for A, B in interior_rim_cands(ra, p):
                    if not K.lt1(A, B):
                        bad.append((A, B))
            others = [n for n, (cc, qs) in tiles.items() if cc == c and n != nm]
            far = [(n, K.pair_verdict([ra], tiles[n][1]).mcmp) for n in others]
            good = not bad and all(m == ">" for n, m in far)
            ok &= good
            print(f"   {nm:3s} ({c:6s}) rim arc {deg(ra.S):7.3f}->{deg(ra.E):7.3f}: interior-point candidates >= 1: {len(bad)}; other {c} tiles' "
                  f"min distance to the closed rim arc: {', '.join(f'{n} {m}1' for n, m in far)}  -> {c} AVAILABLE just outside the open arc: {good}")
    return ok


def first_order(z, contacts, outward):
    """contacts: list of (colour, sign, u) meaning colour blocked at z + eps d iff sign * (u . d) > 0.  Print u's direction."""
    for c, sg, u in contacts:
        print(f"      {c:7s} blocked iff {'+' if sg > 0 else '-'}(u.d) > 0, u = contact - z at {deg(u):7.3f} deg, |u|^2 = {float(n2(u)):.6f}")


def run_rim(Dk, tiles, label):
    print(f"==== the rim of {label}: open rim arcs")
    rim_open_arcs(Dk, tiles)
    print(f"==== the rim vertices of {label} (sector 0; the other sectors are its turns by 72k with the colours permuted)")
    p = Dk.pt
    res = {}
    for nm in ("C", "D", "F"):
        z = p(nm, 0)
        res[nm] = classify(z, tiles, f"rim vertex {nm}_0, outward normal at {deg(z):.3f} deg")
    return res


# ------------------------------------------------------------------ O3: the move at C_k and D_k
def moved_tiles(Dk, which=("C", "D")):
    t = Dk.tiles()
    p = Dk.pt
    one = Dk.T(1)
    for k in range(5):
        C, D, U, Up = p("C", k), p("D", k), p("U", k), p("Up", k)
        arcC = Arc(C, one, Up, D)            # the arc of omega(C_k) through U'_k and D_k (bulging away from C_k)
        arcD = Arc(D, one, C, U)             # the arc of omega(D_k) through C_k and U_k
        for nm in (f"R{k}", f"T{k}", f"S{k}"):
            col, ps = t[nm]
            new = []
            for q in ps:
                if "C" in which and q.kind == "S" and {tuple(map(float, q.P)), tuple(map(float, q.Q))} == {tuple(map(float, D)), tuple(map(float, Up))}:
                    new.append(arcC)
                elif "D" in which and q.kind == "S" and {tuple(map(float, q.P)), tuple(map(float, q.Q))} == {tuple(map(float, C)), tuple(map(float, U))}:
                    new.append(arcD)
                else:
                    new.append(q)
            t[nm] = (col, new)
    return t


def meets_only_at_ends(tiles, new_pieces):
    """exact: each new arc meets every other piece only at a shared endpoint (circle-circle and circle-line second intersections tested)."""
    allp = [(nm, q) for nm, (c, ps) in tiles.items() for q in ps]
    bad = []
    for a in new_pieces:
        for nm, q in allp:
            if q is a or (q.kind == "A" and veq(q.C, a.C) and veq(q.S, a.S) and veq(q.E, a.E)):
                continue
            shared = [X for X in a.ends() if any(veq(X, Y) for Y in q.ends())]
            if not shared:
                if K.meet(a, q):
                    bad.append((nm, q))
                continue
            P0 = shared[0]
            # the other intersection of the two curves through P0
            if q.kind == "A":
                w = vsub(q.C, a.C)
                if K.is0v(w):
                    if q.rho == a.rho:
                        bad.append((nm, q, "concentric overlap?"))
                    continue
                t = dot(vsub(P0, a.C), w) / n2(w)
                foot = vadd(a.C, vmul(t, w))
                P1 = vsub(vmul(2, foot), P0)
            else:
                v = vsub(q.Q, q.P)
                s = -2 * dot(vsub(P0, a.C), v) / n2(v)
                P1 = vadd(P0, vmul(s, v))
            if not veq(P1, P0) and a.contains(P1) and q.contains(P1):
                bad.append((nm, q, "second intersection on both"))
    return bad


# ------------------------------------------------------------------ drivers
def run_all_disk(which):
    Dk = O.Disk()
    tiles = Dk.tiles()
    if "o1" in which or "o2" in which:
        Dk, tiles, vt = run_o1(Dk, tiles)
        pairs = close_complementary_pairs(Dk, tiles, vt)
    if "o1" in which:
        run_rim(Dk, tiles, "the disk")
        p = Dk.pt
        C0 = p("C", 0)
        print("   exact directions at C_0:")
        u1 = vsub(p("Up", 0), C0)
        u2 = vsub(p("B", 0), C0)
        uD = vsub(p("D", 0), C0)
        c36, s36 = Dk.c[36]
        print(f"      U'_0 - C_0 = e(-36 deg) exactly: {veq(u1, (c36, -s36))};  B_0 - C_0 = -e(72 deg) exactly: {veq(u2, vmul(-1, Dk.c[72]))};"
              f"  D_0 - C_0 = (1, 0): {veq(uD, (Dk.T(1), Dk.T(0)))}")
        print(f"      (U'_0 - C_0).(B_0 - C_0) = cos 72 exactly: {dot(u1, u2) == Dk.c[72][0]}")
    if "o2" in which:
        print("==== O2 on the disk: each pair's second common unit point, and the colours there")
        for (u, cu, v, cv, w0, w1, where) in pairs:
            if where == "OUTSIDE the disk":
                classify(w1, tiles, f"the second common unit point of ({','.join(sorted(cu))}) and ({','.join(sorted(cv))})")
                break
    if "o3" in which:
        run_o3(Dk)
    if "o5" in which:
        run_o5(Dk)


def run_o3(Dk):
    print("==== O3: the move (the chord D_k U'_k of omega(C_k) bent to its unit arc; mirror: C_k U_k of omega(D_k)), all five sectors")
    t = moved_tiles(Dk)
    p = Dk.pt
    one = Dk.T(1)
    new = [Arc(p("C", k), one, p("Up", k), p("D", k)) for k in range(5)] + [Arc(p("D", k), one, p("C", k), p("U", k)) for k in range(5)]
    bad = meets_only_at_ends(t, new)
    print(f"   new arcs meet other pieces only at shared ends (exact): {'yes' if not bad else bad}")
    bad2, npieces = O.consistency(t, rim_rho=Dk.r)
    print(f"   map consistency (exact): {npieces} pieces; defects {bad2 if bad2 else 'none'}")
    areas = sum(O.float_area(ps) for _, (c, ps) in t.items())
    print(f"   float area guard: {areas:.9f} against pi r^2 {math.pi * float(Dk.r2):.9f}")
    rows, badp, npres = K.check_object(t)
    tight = sum(1 for a, b, c, r in rows if r.mcmp == "=" or (a == b and r.Mcmp == "="))
    print(f"   pairs examined {len(rows)} / present {npres}; exact contacts at 1: {tight}; VERDICT: {'REJECT ' + str(badp) if badp else 'ACCEPT'}")
    for a, b, c, r in rows:
        if a in ("R0", "T0", "S0") or b in ("R0", "T0", "S0"):
            print(f"      {c:7s} {a:3s} {b:3s} {r}")
    run_o1(Dk, t, "the moved disk (O3): new unit arcs")
    run_rim(Dk, t, "the moved disk")
    return t


def run_o5(Dk):
    print("==== O5: vertex-centred discs")
    p = Dk.pt
    a = Dk.a
    print(f"   inside O1: the largest closed disc centred at a vertex is centred at an A_k, radius r - a = sqrt((25+9sqrt5)/10) - "
          f"sqrt((5-sqrt5)/10) ~ {float(Dk.r - a):.9f}; a^2 = (5 - sqrt5)/10 exactly: {a * a == (5 - Dk.r5) / 10}")
    tiles = Dk.tiles()
    vt = vertex_table(tiles, Dk.r)
    best = min(n2(X) for X, ts, cols, rim in vt)
    print(f"   the least |vertex|^2 is a^2: {best == a * a}")
    # the extension: R_0's rim arc replaced by the arc of the circle (A_0, phi) from D_0 to C_0
    A0, C0, D0 = p("A", 0), p("C", 0), p("D", 0)
    phi = Dk.phi
    print(f"   |A_0 C_0| = |A_0 D_0| = phi exactly: {n2(vsub(C0, A0)) == phi * phi and n2(vsub(D0, A0)) == phi * phi}")
    ext = dict(tiles)
    col, ps = ext["R0"]
    new = [q for q in ps if not (q.kind == "A" and K.is0v(q.C))] + [Arc(A0, phi, D0, C0)]
    ext["R0"] = (col, new)
    rows, badp, npres = K.check_object(ext)
    print(f"   the extension (R_0 grown to the arc of the circle (A_0, phi) over its rim arc): pairs {len(rows)} / {npres}; "
          f"VERDICT {'REJECT ' + str(badp) if badp else 'ACCEPT'}")
    for a_, b, c, r in rows:
        if "R0" in (a_, b):
            print(f"      {c:7s} {a_:3s} {b:3s} {r}")
    # distances from every interior vertex to the nearest colourless rim vertex (C_k, D_k)
    cd = [p(n, k) for n in ("C", "D") for k in range(5)]
    worst = []
    for X, ts, cols, rim in vt:
        if rim:
            continue
        m = min(math.sqrt(float(n2(vsub(X, Y)))) for Y in cd)
        worst.append((m, X, cols))
    worst.sort(key=lambda t: -t[0])
    print("   interior vertices by distance to the nearest C_k / D_k (floats; the A_k exact: phi):")
    for m, X, cols in worst[:8]:
        print(f"      ({float(X[0]):+.5f}, {float(X[1]):+.5f}) {{{', '.join(cols)}}}  {m:.6f}")


# ------------------------------------------------------------------ the strip: O2 and O4
def run_strip(which):
    S = O.Strip()
    T = S.T
    tiles = S.tiles(-4, 6)
    r3, r5 = T.gen(1), T.gen(2)
    one = T(1)
    V0 = S.V(0, 1)
    A1 = S.A(1, 1)
    X1 = (T(Fr(1, 4)), S.Y)
    P = S.P
    print("==== the strip: O2")
    print(f"   |X_1 V_0| = |X_1 A_1| = 1: {n2(vsub(X1, V0)) == 1 and n2(vsub(X1, A1)) == 1};  |P_1 V_0| = |P_1 A_1| = 1: "
          f"{n2(vsub(P(1), V0)) == 1 and n2(vsub(P(1), A1)) == 1};  X_1 on the top edge y = Y: True by construction")
    print(f"   |X_1 V_1| = |X_1 A_-1| = 1 too: {n2(vsub(X1, S.V(1, 1))) == 1 and n2(vsub(X1, S.A(-1, 1))) == 1}")
    classify(X1, tiles, "the strip's edge vertex X_1 = (1/4, Y)")
    print("==== the strip: O4 (first-order forcing at V_0 and A_1 by the four-colour midline vertices at distance 1)")
    for nm, Z, nbrs in (("V_0", V0, (-1, 1)), ("A_1", A1, (1, 2))):
        for j in nbrs:
            u = vsub(P(j), Z)
            print(f"   {nm}: P_{j} - {nm} at {deg(u):7.3f} deg (|u| = 1: {n2(u) == 1}); tangent line of omega({nm}) at P_{j}: "
                  f"{(deg(u) + 90) % 360:7.3f} / {(deg(u) + 270) % 360:7.3f} deg")
    # T_2 (M) against X_1: strict?
    mn, mx, eq = point_tile(X1, tiles["T2"][1])
    print(f"   the top tile T_2 over V_2 (colour {tiles['T2'][0]}) against X_1: min {mn} 1, max {mx} 1 -> strictly blocks {tiles['T2'][0]} at X_1")
    far = S.A(2, 1)
    print(f"   |X_1 - A_2|^2 = 7/4 exactly: {n2(vsub(X1, far)) == Fr(7, 4)};  |X_1 - (3/4, Y)| = 1/2")


# ------------------------------------------------------------------ the colourless cone at z (first order), exact on test directions
def contact_vectors(z, eq_list):
    """contact directions u = (contact point - z) for the exactly-1 witnesses (vertices, tangency feet, radial points, whole arcs about z)."""
    us = []
    for kind, w in eq_list:
        if kind == "vertex":
            us.append(vsub(w, z))
        elif kind == "foot":
            v = vsub(w.Q, w.P)
            t = dot(vsub(z, w.P), v) / n2(v)
            us.append(vsub(vadd(w.P, vmul(t, v)), z))
        elif kind == "near-radial":
            ww = vsub(z, w.C)
            us.append(vmul(-1, ww) if n2(ww) > w.rho * w.rho else ww)
        elif kind == "far-radial":
            us.append(vmul(-1, vsub(z, w.C)))
        elif kind == "centre":                       # a whole arc of the unit circle about z: its end directions (span < 180 deg)
            us += [vsub(w.S, z), vsub(w.E, z)]
    return us


def cone_conditions(z, tiles):
    """{colour: None (strictly blocked) | list of (sign, u)}: colour blocked at z + eps d iff some sign*(u.d) > 0."""
    cond = {}
    for nm, (c, ps) in sorted(tiles.items()):
        mn, mx, eq = point_tile(z, ps)
        if cond.get(c, 0) is None:
            continue
        if mn == "<" and mx == ">":
            cond[c] = None
            continue
        L = cond.setdefault(c, [])
        if mx == "=" and mn == "<":           # the tile lies in the closed unit disc about z: blocked when moving toward a contact
            L += [(-1, u) for u in contact_vectors(z, eq)]
        elif mn == "=" and mx == ">":         # outside the open disc: blocked when moving away from z past a contact
            L += [(+1, u) for u in contact_vectors(z, eq)]
        elif mn == "=" and mx == "=":
            raise ValueError("a tile inside and outside at once")
    return cond


def colourless_cone(z, tiles, outward=None, label=""):
    """the open arcs of directions d (restricted to outward.d > 0 if given) where every colour is blocked to first order."""
    cond = cone_conditions(z, tiles)
    us = [u for L in cond.values() if L for (_, u) in L] + ([outward] if outward is not None else [])
    crit = sorted({round((deg(u) + 90) % 360, 9) for u in us} | {round((deg(u) + 270) % 360, 9) for u in us})
    arcs = []
    T = z[0].T
    for i, a in enumerate(crit):
        b = crit[(i + 1) % len(crit)] + (360 if i == len(crit) - 1 else 0)
        m = math.radians((a + b) / 2)
        d = (T(Fr(round(math.cos(m) * 10 ** 6), 10 ** 6)), T(Fr(round(math.sin(m) * 10 ** 6), 10 ** 6)))
        if outward is not None and dot(outward, d).sign() <= 0:
            continue
        blocked = all(L is None or any((sg * dot(u, d)).sign() > 0 for sg, u in L) for L in cond.values())
        avail = [c for c, L in cond.items() if not (L is None or any((sg * dot(u, d)).sign() > 0 for sg, u in L))]
        arcs.append((a % 360, b % 360, blocked, avail))
    print(f"   first-order cone at {label}:")
    for c, L in sorted(cond.items()):
        if L is None:
            print(f"      {c:7s} blocked in every direction")
        else:
            print(f"      {c:7s} blocked iff " + " or ".join(f"{'+' if sg > 0 else '-'}(u.d) > 0 [u at {deg(u):.3f} deg]" for sg, u in L)
                  if L else f"      {c:7s} never blocked")
    merged = []
    for a, b, bl, av in arcs:
        if merged and merged[-1][2] == bl and abs(merged[-1][1] - a) < 1e-9 and merged[-1][3] == av:
            merged[-1] = (merged[-1][0], b, bl, av)
        else:
            merged.append((a, b, bl, av))
    for a, b, bl, av in merged:
        w = (b - a) % 360
        print(f"      directions ({a:9.4f}, {b:9.4f}) deg, width {w:8.4f}: " + ("COLOURLESS" if bl else "available: " + ", ".join(av)))
    return merged


def run_cones(which):
    if "strip" in which:
        S = O.Strip()
        T = S.T
        tiles = S.tiles(-4, 6)
        X1 = (T(Fr(1, 4)), S.Y)
        colourless_cone(X1, tiles, outward=(T(0), T(1)), label="the strip's edge vertex X_1 (outward: up)")
    if "disk" in which or "moved" in which:
        Dk = O.Disk()
        p = Dk.pt
        if "disk" in which:
            tiles = Dk.tiles()
            for nm in ("C", "D", "F"):
                z = p(nm, 0)
                colourless_cone(z, tiles, outward=z, label=f"the disk's rim vertex {nm}_0 (outward: radial)")
            vt = vertex_table(tiles, Dk.r)
            # the outside common point Q_0: the reflection of A_0 in the line U_0 Y_0
            U0, Y0, A0 = p("U", 0), p("Y", 0), p("A", 0)
            dd = vsub(Y0, U0)
            foot = vadd(U0, vmul(dot(vsub(A0, U0), dd) / n2(dd), dd))
            Q0 = vsub(vmul(2, foot), A0)
            print(f"   Q_0 on the ray of B_0: {cross(Q0, p('B', 0)).is0()};  |Q_0|^2 > r^2: {n2(Q0) > Dk.r2};  |Q_0|^2 ~ {float(n2(Q0)):.9f}")
            for nm in ("X", "U", "Y"):
                print(f"      |Q_0 - {nm}_0| = 1: {n2(vsub(Q0, p(nm, 0))) == 1}")
            print(f"      |Q_0 - U'_1| = 1: {n2(vsub(Q0, p('Up', 1))) == 1}")
            colourless_cone(Q0, tiles, outward=None, label="the outside point Q_0 (all directions)")
        if "moved" in which:
            t = moved_tiles(Dk)
            for nm in ("C", "D"):
                z = p(nm, 0)
                colourless_cone(z, t, outward=z, label=f"the MOVED disk's rim vertex {nm}_0 (outward: radial)")


if __name__ == "__main__":
    which = sys.argv[1:] or ["o1", "o2", "o3", "o5", "strip"]
    if "cones" in which:
        run_cones(which)
        sys.exit(0)
    if any(w in which for w in ("o1", "o2", "o3", "o5")):
        run_all_disk(which)
    if "strip" in which:
        run_strip(which)
