#!/usr/bin/env python3
"""FS112-YB3: blind rebuilds of FS112-Y3's chain-end fragments (Y3-END-A, Y3-END-B) from their defining words, the operations the claims
name (a MERGE at N; a SHAVE of N's horns), and a candidate fragment of my own against Y3-END-NEEDS (BOWTIE), each checked EXACTLY.

Written without reading FS112-Y3's record or tools.  Exact validity is decided by FS112-YB2's tower checker (tools/fs112_yb2_check.py,
imported and run, never edited): for every same-colour tile pair, a tile with itself included, REJECT iff min < 1 < max.  Every fragment
here lives in Q (every centre, radius and corner rational), so the checker's tower is Q itself.

Stuckness is checked by the chain's own definitions (N4-STUCK, N4-SHAVE, W-MERGE; plans/FS110-N-proof.md stage N4-2) at named points:
  * D_c(v) degenerate: the c-tiles touching the unit circle about v at the two antipodes v +- n, each lying outside the closed unit disc
    about v (out-type), found exactly (point-to-tile minimum and maximum of the distance, against 1);
  * no SHAVE: at named points of each horn near v, BOTH flank colours are blocked, i.e. some tile of that colour has min < 1 < max from the
    point (my own point-to-tile routine, below, independent of YB2's analysis module);
  * a MERGE is exhibited by building the merged fragment and checking it exactly; a SHAVE likewise.
Plants (each beside its faithful twin, the rejected pairs predicted in the record before the run): see PLANTS.

Run: python3 tools/fs112_yb3_frags.py [enda|endb|bowtie|plants|all]
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K   # noqa: E402  (FS112-YB2's checker: imported, never edited)

Seg, Arc = K.Seg, K.Arc
T = K.Tower.base()


def q(x):
    return T(Fr(x))


def P(x, y):
    return (q(x), q(y))


def fp(p):
    return f"({float(p[0]):.5f}, {float(p[1]):.5f})"


def poly(*v):
    return [Seg(v[i], v[(i + 1) % len(v)]) for i in range(len(v))]


# ============================================================ my own point-to-tile routine (exact)
def _cands_point_piece(z, pc):
    """(A, B) with the candidate distance |sqrt(A) + B| from z to the piece pc: every extreme of |z - p| over p in pc is among them."""
    out = []
    for X in pc.ends():
        out.append((K.n2(K.vsub(z, X)), q(0)))
    if pc.kind == "S":
        v = K.vsub(pc.Q, pc.P)
        t = K.dot(K.vsub(z, pc.P), v)
        if t.sign() > 0 and t < K.n2(v):          # the foot is interior to the segment
            c = K.cross(K.vsub(z, pc.P), v)
            out.append((c * c / K.n2(v), q(0)))
    else:
        w = K.vsub(z, pc.C)
        if K.is0v(w):
            out.append((q(0), pc.rho))
        else:
            if pc.has_dir(w):                        # the arc point nearest z (on the ray from the centre through z)
                out.append((K.n2(w), -pc.rho))
            if pc.has_dir(K.vmul(-1, w)):            # the antipodal arc point, farthest
                out.append((K.n2(w), pc.rho))
    return out


def point_vs_tile(z, pieces):
    """(min vs 1, max vs 1) over the tile's BOUNDARY, each '<', '=', '>'.  (Used at points outside the tile, where the boundary decides.)"""
    cs = [c for pc in pieces for c in _cands_point_piece(z, pc)]
    lo = any(K.lt1(A, B) for A, B in cs)
    hi = any(K.gt1(A, B) for A, B in cs)
    eq = any((not K.lt1(A, B)) and (not K.gt1(A, B)) for A, B in cs)
    return ("<" if lo else ("=" if eq else ">")), (">" if hi else ("=" if eq else "<"))


def blocked(z, tiles, colour, exclude=()):
    """the tiles of `colour` (other than `exclude`) with min < 1 < max from z: each forbids `colour` at z."""
    out = []
    for nm, (c, ps) in sorted(tiles.items()):
        if c != colour or nm in exclude:
            continue
        mn, mx = point_vs_tile(z, ps)
        if mn == "<" and mx == ">":
            out.append(nm)
    return out


def contacts_on_circle(v, tiles, colour):
    """tiles of `colour` whose distance from v has min = 1 (out-type: the tile outside the open unit disc, touching it) or max = 1
    (in-type), with the exact contact vertices at distance 1."""
    res = []
    for nm, (c, ps) in sorted(tiles.items()):
        if c != colour:
            continue
        mn, mx = point_vs_tile(v, ps)
        touch = []
        for pc in ps:
            for X in pc.ends():
                if K.n2(K.vsub(X, v)) == q(1):
                    touch.append(X)
        if mn == "=" and mx == ">":
            res.append((nm, "out", touch))
        elif mx == "=" and mn == "<":
            res.append((nm, "in", touch))
        elif mn == "<" and mx == ">":
            res.append((nm, "CROSSES", touch))
    return res


def check(tiles, label, plant=None, show_tight=False):
    K.PLANT = plant
    rows, bad, npres = K.check_object(tiles)
    K.PLANT = None
    tight = [(a, b) for a, b, c, r in rows if r.mcmp == "=" or r.Mcmp == "="]
    verdict = "REJECT" if bad else "ACCEPT"
    print(f"== {label}: {verdict}  pairs examined {len(rows)} / present {npres}" + (f"  [checker plant {plant}]" if plant else ""))
    if bad:
        print("   rejected: " + ", ".join(f"({a},{b})" for a, b in bad))
    if show_tight:
        print("   pairs touching 1 exactly (min = 1 or max = 1): " + ", ".join(f"({a},{b})" for a, b in tight))
    return bad, len(rows), npres


# ============================================================ Y3-END-A / Y3-END-B, rebuilt from the words
# "a finite stuck chain P_0, P_1, E = P_2 with C-CHAIN-9's recursion taken with equality from the end (upper arcs on the circles about
#  N = P_3 of radii 3, 2, 1 -- the unit arc at E -- lower boundaries the lines y = k), N's neighbourhood completed by colours 1 (below),
#  3 (top, directions [45 deg, 135 deg]), 4 (two wedges tangent to a)"
# Reading (mine): P_k = (0, k), n = (0, 1), a = (1, 0), N = (0, 3).  Colours a_k (cone colour at P_k; a_{k-1} fills P_k's +n side, a_{k+1}
# its -n side): the words fix a_2 = 3 (the colour at N's top, the out-type contact E needs), a_3 = 4 (the wedges at N), a_4 = 1 (below N);
# a_1, a_0, a_{-1} are free up to four-consecutive-distinct: I take 2, 5, 6.
A = {-1: 6, 0: 5, 1: 2, 2: 3, 3: 4, 4: 1}
# each horn ends at a RATIONAL point of its circle (so the fragment lives in Q): (sin, cos) of the end angle seen from N.
HORN_END = {0: (Fr(15, 113), Fr(112, 113)), 1: (Fr(11, 61), Fr(60, 61)), 2: (Fr(5, 13), Fr(12, 13))}


def chain_tiles(plant=None):
    Nn = P(0, 3)
    t = {}
    for k in (0, 1, 2):
        R = 3 - k
        s, c = HORN_END[k]
        l = R * s                                  # the horn's half-length
        Pk = P(0, k)
        Vp, Vm = P(l, 3 - R * c), P(-l, 3 - R * c)  # the horn's far corners, on the circle (N, 3 - k)
        rho = q(R)
        upper_p = Arc(Nn, rho, Pk, Vp)             # the +a horn's upper arc (ccw from 270 deg)
        upper_m = Arc(Nn, rho, Vm, Pk)
        if plant == "p1_fat" and k == 1:
            # the P_1 horns' upper arcs replaced by arcs of the circle tangent to a at P_1 with centre (0, 1 + 550/427), radius 550/427
            # (curvature 427/550 ~ 0.776 > 1/2 = the recursion's value), ending at the same x = 22/61 at the rational height 449/427:
            # the horn is fatter than C-CHAIN-9's equality allows.
            C2, r2 = P(0, 1 + Fr(550, 427)), q(Fr(550, 427))
            Vp, Vm = P(l, Fr(449, 427)), P(-l, Fr(449, 427))
            upper_p, upper_m = Arc(C2, r2, Pk, Vp), Arc(C2, r2, Vm, Pk)
        if plant == "chord2" and k == 2:
            upper_p, upper_m = Seg(Pk, Vp), Seg(Vm, Pk)     # E's unit arcs replaced by chords of the unit circle about N
            upper_u = [Seg(Vm, Pk), Seg(Pk, Vp)]
        else:
            upper_u = [Arc(Nn, rho, Vm, Vp)] if plant != "p1_fat" or k != 1 else [
                Arc(P(0, 1 + Fr(550, 427)), q(Fr(550, 427)), Vm, Vp)]
        t[f"H{k}+"] = (A[k], [Seg(Pk, P(l, k)), Seg(P(l, k), Vp), upper_p])
        t[f"H{k}-"] = (A[k], [Seg(Pk, P(-l, k)), Seg(P(-l, k), Vm), upper_m])
        top = Fr(2 * k + 1, 2)
        t[f"U{k}"] = (A[k - 1], upper_u + [Seg(Vp, P(l, top)), Seg(P(l, top), P(-l, top)), Seg(P(-l, top), Vm)])
        t[f"L{k}"] = (A[k + 1], poly(P(-l, Fr(2 * k - 1, 2)), P(l, Fr(2 * k - 1, 2)), P(l, k), P(-l, k)))
    t["L3"] = (A[4], poly(P(Fr(-2, 5), Fr(5, 2)), P(Fr(2, 5), Fr(5, 2)), P(Fr(2, 5), 3), P(Fr(-2, 5), 3)))
    return t


def _sqrt_rat(x):
    x = Fr(x)
    n, d = math.isqrt(x.numerator), math.isqrt(x.denominator)
    if n * n == x.numerator and d * d == x.denominator:
        return Fr(n, d)
    raise ValueError(f"not a rational square: {x}")


def end_a(plant=None, merged=False):
    t = chain_tiles(plant if plant in ("p1_fat", "chord2") else None)
    rho = Fr(2, 5)
    Nn = P(0, 3)
    t["W+"] = (4, poly(Nn, P(rho, 3), P(rho, 3 + rho)))                 # directions [0, 45] at N
    t["W-"] = (4, poly(Nn, P(-rho, 3 + rho), P(-rho, 3)))               # directions [135, 180]
    if merged:
        # W-MERGE at N for colour 4: the gap (the 3-sector, directions [45, 135]) recoloured 4 inside the triangle of height r.
        r = Fr(1, 5)
        t["Tin"] = (4, poly(Nn, P(r, 3 + r), P(-r, 3 + r)))
        t["T"] = (3, poly(P(r, 3 + r), P(rho, 3 + rho), P(-rho, 3 + rho), P(-r, 3 + r)))
    else:
        t["T"] = (3, poly(Nn, P(rho, 3 + rho), P(-rho, 3 + rho)))      # directions [45, 135]
    # the unit arcs' far ends V_2^{+-} = (+-5/13, 27/13), closed by small tiles of colour 6 (the one colour no tile within reach forbids)
    l2, yv = Fr(5, 13), Fr(27, 13)
    w, d = Fr(1, 20), Fr(1, 20)
    qcol = 6 if plant != "q_swap" else 5
    t["Q+"] = (qcol, poly(P(l2, Fr(39, 20)), P(l2 + w, Fr(39, 20)), P(l2 + w, yv + d), P(l2, yv + d)))
    t["Q-"] = (6, poly(P(-l2 - w, Fr(39, 20)), P(-l2, Fr(39, 20)), P(-l2, yv + d), P(-l2 - w, yv + d)))
    return t


def end_b(shaved=None):
    """ "the same chain with N a five-colour vertex {1, 3, 4, 5, 6} (colour 4 a double horn at N, flanks 5 and 6, and a colour-4 tile at
    N + n on the concentric circle making D_4(N) the line)".  Reading (mine): the 4-horns at N between the line y = 3 (lower flank 1) and
    arcs of the circle about M = (0, 5) of radius 2; upper flanks 5 (+a side) and 6 (-a side); the 3-tile T at the top, directions
    [45, 135]; the 4-tile at N + n = (0, 4) inside the unit disc about M (the concentric circle through N + n).  Not claimed arc-closed at
    E's unit arcs, and built without the Q tiles (see the record: with five colours at N those ends need colour 2 on the unit circle about N).
    shaved = 'low' | 'up': the +a horn's tip within x <= 30/113 recoloured by its lower flank (1) or its upper flank (5)."""
    t = chain_tiles()
    Nn, M = P(0, 3), P(0, 5)
    rho = Fr(2, 5)
    s, c = Fr(11, 61), Fr(60, 61)
    l3 = 2 * s                                              # 22/61
    Vp, Vm = P(l3, 5 - 2 * c), P(-l3, 5 - 2 * c)            # (+-22/61, 185/61)
    two = q(2)
    if shaved:
        st, ct = Fr(15, 113), Fr(112, 113)
        r = 2 * st                                          # 30/113
        Wp = P(r, 5 - 2 * ct)                               # (30/113, 341/113) on the circle (M, 2)
        tip = [Seg(Nn, P(r, 3)), Seg(P(r, 3), Wp), Arc(M, two, Nn, Wp)]
        rest = [Seg(P(r, 3), P(l3, 3)), Seg(P(l3, 3), Vp), Arc(M, two, Wp, Vp), Seg(Wp, P(r, 3))]
        t["H3+tip"] = ({"low": 1, "up": 5}[shaved], tip)
        t["H3+"] = (4, rest)
    else:
        t["H3+"] = (4, [Seg(Nn, P(l3, 3)), Seg(P(l3, 3), Vp), Arc(M, two, Nn, Vp)])
    t["H3-"] = (4, [Seg(Nn, P(-l3, 3)), Seg(P(-l3, 3), Vm), Arc(M, two, Vm, Nn)])
    t["F+"] = (5, [Arc(M, two, Nn, Vp), Seg(Vp, P(rho, 3 + rho)), Seg(P(rho, 3 + rho), Nn)])
    t["F-"] = (6, [Arc(M, two, Vm, Nn), Seg(Nn, P(-rho, 3 + rho)), Seg(P(-rho, 3 + rho), Vm)])
    t["T"] = (3, poly(Nn, P(rho, 3 + rho), P(-rho, 3 + rho)))
    one = q(1)
    u4 = P(Fr(5, 13), Fr(53, 13))
    u4m = P(Fr(-5, 13), Fr(53, 13))
    t["U4"] = (4, [Arc(M, one, u4m, u4), Seg(u4, P(Fr(5, 13), Fr(9, 2))), Seg(P(Fr(5, 13), Fr(9, 2)), P(Fr(-5, 13), Fr(9, 2))),
                   Seg(P(Fr(-5, 13), Fr(9, 2)), u4m)])
    return t


# ============================================================ BOWTIE: my candidate against Y3-END-NEEDS (a stuck E with no h at N)
def bowtie(plant=None):
    """E = (0, 0), N = (0, 1), S = (0, -1).  E's c-horns (colour 2) lie between the unit circle about N (above) and the unit circle about
    S (below): upper and lower arcs are UNIT arcs.  g = 1 is the circular sector G of radius 1 about N, half-angle alpha (sin 5/13): it
    is E's whole +n side near E AND a tile at N lying in the closed unit disc about E (in-type) -- the tactic's self in-contact; h = 3 is its
    mirror H about S.  c = 2 at N in the pinch [45, 135] and at S in [225, 315] (out-type), so D_2(E) is the line.  N carries {1, 2, 4, 5}
    and S {3, 2, 4, 5}: h is NOT at N.  The unit arcs' ends (G's and H's arc ends) are closed by two small tiles of colour 6."""
    s, c = Fr(5, 13), Fr(12, 13)
    Nn, S, E = P(0, 1), P(0, -1), P(0, 0)
    one = q(1)
    GR, GL = P(s, 1 - c), P(-s, 1 - c)                     # (+-5/13, 1/13)
    HR, HL = P(s, -1 + c), P(-s, -1 + c)                   # (+-5/13, -1/13)
    t = {}
    t["G"] = (1, [Seg(Nn, GL), Arc(Nn, one, GL, GR), Seg(GR, Nn)])
    t["H"] = (3, [Seg(S, HR), Arc(S, one, HR, HL), Seg(HL, S)])
    t["C+"] = (2, [Arc(S, one, HR, E), Arc(Nn, one, E, GR), Seg(GR, HR)])     # the +a horn: between H's arc (below) and G's arc (above)
    t["C-"] = (2, [Arc(Nn, one, GL, E), Arc(S, one, E, HL), Seg(HL, GL)])
    if plant == "h_is_g":
        t["H"] = (1, t["H"][1])                  # H given G's colour: the two sectors meet at E
    rho = Fr(2, 5)
    if plant != "no_cn":
        t["CN"] = (2, poly(Nn, P(rho, 1 + rho), P(-rho, 1 + rho)))            # directions [45, 135] at N
    else:
        t["CN"] = (3, poly(Nn, P(rho, 1 + rho), P(-rho, 1 + rho)))            # plant: the top tile at N given h's colour 3, not c
    t["CS"] = (2, poly(S, P(-rho, -1 - rho), P(rho, -1 - rho)))               # directions [225, 315] at S
    a1 = (q(s * rho), q(1 - c * rho))                                        # N + rho e(270 + alpha), on G's right edge
    t["XR"] = (4, poly(Nn, a1, P(rho, 1 - c * rho), P(rho, 1 + rho)))       # directions [270 + alpha, 45] at N
    a1m = (q(-s * rho), q(1 - c * rho))
    t["XL"] = (5, poly(Nn, P(-rho, 1 + rho), P(-rho, 1 - c * rho), a1m))
    b1 = (q(s * rho), q(-1 + c * rho))
    t["YR"] = (4, poly(S, P(rho, -1 - rho), P(rho, -1 + c * rho), b1))
    b1m = (q(-s * rho), q(-1 + c * rho))
    t["YL"] = (5, poly(S, b1m, P(-rho, -1 + c * rho), P(-rho, -1 - rho)))
    # arc ends G_R, H_R (and mirrors) closed: a small tile of colour 6 right of the horn's closing segment, along G's and H's right edges
    tt, w = Fr(1, 10), Fr(1, 20)
    gR = (q(s - s * tt), q(1 - c + c * tt))                                  # G_R + tt (N - G_R)
    hR = (q(s - s * tt), q(-1 + c - c * tt))                                 # H_R + tt (S - H_R)
    t["ZR"] = (6, poly(GR, gR, P(s + w, 1 - c + c * tt), P(s + w, -1 + c - c * tt), hR, HR))
    gL = (q(-s + s * tt), q(1 - c + c * tt))
    hL = (q(-s + s * tt), q(-1 + c - c * tt))
    t["ZL"] = (6, poly(GL, HL, hL, P(-s - w, -1 + c - c * tt), P(-s - w, 1 - c + c * tt), gL))
    return t


# ============================================================ drivers
def report_contacts(v, tiles, colour, label):
    cs = contacts_on_circle(v, tiles, colour)
    print(f"   contacts of colour {colour} on the unit circle about {label} {fp(v)}: " +
          ("; ".join(f"{nm} {kind} at " + ",".join(fp(X) for X in xs) for nm, kind, xs in cs) if cs else "none"))
    return cs


def shadow_points(tiles, pts, flanks, label):
    ok = True
    for z in pts:
        parts = []
        for col in flanks:
            b = blocked(z, tiles, col)
            parts.append(f"colour {col} blocked by {','.join(b) if b else 'NOTHING'}")
            ok &= bool(b)
        print(f"   {label} point {fp(z)}: " + "; ".join(parts))
    return ok


def run_enda():
    t = end_a()
    check(t, "Y3-END-A rebuilt (faithful)", show_tight=True)
    check(t, "Y3-END-A under the checker plant closed_interval (tightness visible)", plant="closed_interval")
    Nn, E, P1, P0 = P(0, 3), P(0, 2), P(0, 1), P(0, 0)
    print("-- stuck at E (cone colour 3 = a_2): D_3(E) needs out-type 3-contacts at N and at P_1")
    report_contacts(E, t, 3, "E")
    print("-- stuck at P_1 (cone colour 2 = a_1): D_2(P_1) needs out-type 2-contacts at E and at P_0")
    report_contacts(P1, t, 2, "P_1")
    print("-- no SHAVE: named points of each horn tip, both flank colours blocked")
    ptsE = [P(Fr(1, 20), 2 + Fr(1, 1000)), P(Fr(1, 10), 2 + Fr(1, 400)), P(Fr(-1, 10), 2 + Fr(1, 400))]
    okE = shadow_points(t, ptsE, (2, 4), "E-horn")
    ptsP1 = [P(Fr(1, 20), 1 + Fr(1, 2000)), P(Fr(1, 10), 1 + Fr(1, 800)), P(Fr(-1, 10), 1 + Fr(1, 800))]
    okP1 = shadow_points(t, ptsP1, (5, 3), "P_1-horn")
    print(f"   E doubly shadowed at every named point: {okE}; P_1: {okP1}")
    print("-- MERGE of colour 4 at N: D_4(N) from the 4-contacts on the unit circle about N (a half-plane if only E's is out-type)")
    report_contacts(Nn, t, 4, "N")
    tm = end_a(merged=True)
    check(tm, "Y3-END-A with the MERGE of colour 4 at N performed (the 3-sector's tip within height 1/5 recoloured 4)")
    print("   after the merge, 3's contacts on the unit circle about E:")
    report_contacts(E, tm, 3, "E")


def run_endb():
    t = end_b()
    check(t, "Y3-END-B rebuilt (faithful)", show_tight=True)
    Nn, E, N1 = P(0, 3), P(0, 2), P(0, 4)
    print("-- colours at N (tiles whose closure holds N):",
          sorted({c for nm, (c, ps) in t.items() if any(K.veq(X, Nn) for pc in ps for X in pc.ends())}))
    print("-- no MERGE at N: D_4(N) from the 4-contacts on the unit circle about N")
    report_contacts(Nn, t, 4, "N")
    print("-- E still stuck (out-type 3 at N and P_1; E's horn doubly shadowed at named points)")
    report_contacts(E, t, 3, "E")
    shadow_points(t, [P(Fr(1, 20), 2 + Fr(1, 1000)), P(Fr(1, 10), 2 + Fr(1, 400))], (2, 4), "E-horn")
    print("-- N's +a 4-horn: are its flank colours (5 above, 1 below) blocked at named points of its tip?")
    shadow_points(t, [P(Fr(1, 20), 3 + Fr(1, 4000)), P(Fr(1, 10), 3 + Fr(1, 1000))], (5, 1), "N-horn")
    check(end_b(shaved="low"), "Y3-END-B with the +a 4-horn's tip SHAVED by its lower flank (colour 1)")
    check(end_b(shaved="up"), "Y3-END-B with the +a 4-horn's tip SHAVED by its upper flank (colour 5)")


def run_bowtie():
    t = bowtie()
    check(t, "BOWTIE (faithful)", show_tight=True)
    E, Nn, S = P(0, 0), P(0, 1), P(0, -1)
    for v, lab in ((E, "E"), (Nn, "N"), (S, "S")):
        cols = sorted({c for nm, (c, ps) in t.items() if any(K.veq(X, v) for pc in ps for X in pc.ends())
                       or any(pc.kind == "A" and pc.contains(v) for pc in ps)})
        print(f"-- colours whose tiles' closures hold {lab} {fp(v)}: {cols}")
    print("-- E stuck: D_2(E) (c = 2) from the 2-contacts on the unit circle about E")
    report_contacts(E, t, 2, "E")
    print("-- E's horns: g = 1 and h = 3 contacts (in-type at N and S respectively)")
    report_contacts(E, t, 1, "E")
    report_contacts(E, t, 3, "E")
    pts = [P(Fr(1, 20), 0), P(Fr(1, 10), Fr(1, 400)), P(Fr(1, 5), Fr(-1, 100)), P(Fr(-1, 10), 0), P(Fr(1, 3), Fr(1, 20))]
    ok = shadow_points(t, pts, (1, 3), "E-horn")
    print(f"   E doubly shadowed at every named point: {ok}")
    print("-- h = 3 at N? 3-tiles whose closure holds N:", [nm for nm, (c, ps) in t.items() if c == 3 and
                                                      any(K.veq(X, Nn) for pc in ps for X in pc.ends())])


def run_plants():
    print("#### plants on Y3-END-A (predicted in the record before the run)")
    check(end_a(), "END-A faithful twin")
    check(end_a(plant="chord2"), "plant chord2 (E's unit arcs -> chords)")
    check(end_a(plant="p1_fat"), "plant p1_fat (P_1's horns' upper arcs of curvature 427/550 > 1/2)")
    check(end_a(plant="q_swap"), "plant q_swap (Q+ coloured 5)")
    print("#### plants on BOWTIE")
    check(bowtie(), "BOWTIE faithful twin")
    check(bowtie(plant="h_is_g"), "plant h_is_g (H given G's colour 1)")
    t = bowtie(plant="no_cn")
    check(t, "plant no_cn (the top tile at N coloured 3: c no longer at N)")
    report_contacts(P(0, 0), t, 2, "E (plant no_cn)")
    check(bowtie(), "BOWTIE under the checker plant closed_interval", plant="closed_interval")


if __name__ == "__main__":
    which = sys.argv[1:] or ["all"]
    if "enda" in which or "all" in which:
        run_enda()
    if "endb" in which or "all" in which:
        run_endb()
    if "bowtie" in which or "all" in which:
        run_bowtie()
    if "plants" in which or "all" in which:
        run_plants()
