#!/usr/bin/env python3
"""FS114-Y stage 1, C114-PENT (plans/STUB-global-step.md open item 3), checked exactly on FS112-Y2's disk (tools/fs112_y2_disk.py Disk and
tools/fs112_y2_dial.py MovedDisk: imported and run, never edited; their field Q(sqrt5)(sqrt(10+2sqrt5))(sqrt((sqrt5-1)/2))(sqrt r^2)).

Sections (python3 tools/fs114_y_pent.py [pent] [routes] [--plant NAME]):
  pent   -- the four-centre obstruction.  At the trivalent B_k (tiles T1_k, U_k, Up_k), its close complementary partners inside the disk are
            Z^R_k and Z^L_{k+1}.  Checked exactly: the three are cubic trichromatic with the stated colours; the pairs are at distance < 2;
            omega(B_0) meets omega(Z^R_0) exactly at A_0 and C_0 (both at distance 1 from both centres, distinct -- two distinct circles meet in at
            most two points) and omega(Z^L_1) exactly at A_1 and D_1; the four points A_0, C_0, A_1, D_1 are distinct.  By FS112-N3-COR3 each
            common unit point of a close complementary pair of cubic trichromatic vertices is a leaving centre of both, and a cubic vertex has at
            most three leaving centres (FS112-C-PARTNERS's count), so no valid map has these three vertices cubic trichromatic at these places
            with these colours, whatever the arcs -- in particular no third unit arc at B_k helps.  Also printed: B_0's leaving centres in the
            disk (A_0, A_1) and the completion A_0 + A_1 - B_0, which is exactly the corner A_3.
            The same test is run on a TWIN configuration where the second partner is the completion A_1 + C_0 - B_0 (shares the centre C_0):
            the union of common unit points must then have three points (no obstruction) -- the test's negative control.
  routes -- the disk's blue and orange routes to a fourth colour at the rim corner C_0 (Y3 §4.4 (ii)), on the MOVED disk (FS112-MOVE: green
            freed, colourless wedge (54, 90)).  A route frees colour c at the points C_0 + eps e(theta), theta in the wedge, only if every
            c-tile lies in B(C_0,1)'s closure or outside B(C_0,1); the one c-tile that straddles omega(C_0) is T2_0 (blue) or T1_0 (orange),
            and its part inside B(C_0, 1) must be given other colours.  At named exact points of that part, the free set with the cut tile
            ignored: a point whose free set is {its own colour} or empty kills the route with the rest of the disk unchanged.
Controls: the free-set instrument must find green free at C_0 + e(126)/100 and nothing at C_0 + e(72)/100 on the moved disk (FS112-MOVE).
Plants (--plant): 'unmoved' (the route section's control run on the UNMOVED disk: green must be blocked there -- the move's lens is the
reason); 'wrongpts' (Z^L_1's common unit points claimed as {A_1, C_0}: the exact test must refuse the claim).
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402  (FS112-Y's arithmetic and closure types: run, never edited)
import fs112_y2_disk as DK         # noqa: E402  (FS112-Y2's disk: run, never edited)
import fs112_y2_dial as DL         # noqa: E402  (FS112-Y2's moved disk: run, never edited)

OK = True
PLANT = None
COLS = ["R", "Bl", "G", "Yw", "O", "P"]


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


def fmt(p):
    return f"({p[0].f():.5f}, {p[1].f():.5f})"


def veq(p, q):
    return Y.is0(Y.sub(p, q))


def leaving_centres(T, v):
    """the centres of the unit arcs (radius exactly 1) of the fragment having v as an endpoint."""
    out = []
    for nm, (c, prims) in T.items():
        for p in prims:
            if isinstance(p, Y.Arc) and p.r == 1 and any(veq(v, X) for X in p.ends()):
                if not any(veq(p.C, q) for q in out):
                    out.append(p.C)
    return out


def common_points_check(u, w, cands):
    """cands: points claimed to be omega(u) cap omega(w); each at distance exactly 1 from both; pairwise distinct."""
    one = all(Y.n2(Y.sub(q, u)) == 1 and Y.n2(Y.sub(q, w)) == 1 for q in cands)
    dist = all(not veq(cands[i], cands[j]) for i in range(len(cands)) for j in range(i + 1, len(cands)))
    return one and dist


def pent():
    print("== C114-PENT, the four-centre obstruction, on FS112-Y2's disk (exact)")
    D = DK.Disk()
    T, P = D.T, D.P
    g = lambda nm, k: P[(nm, k % 5)]
    B0, A0, A1, A3, C0, D1, ZR0, ZL1 = g("B", 0), g("A", 0), g("A", 1), g("A", 3), g("C", 0), g("D", 1), g("ZR", 0), g("ZL", 1)
    types = {lab: sorted(Y.closure_type(T, v)) for lab, v in (("B_0", B0), ("Z^R_0", ZR0), ("Z^L_1", ZL1))}
    for lab, t in types.items():
        print(f"   P_cl({lab}) = {t}")
    say(types["B_0"] == sorted(["O", "P", "Yw"]), "B_0 is trichromatic {O, P, Yw} (tiles T1_0, U_0, Up_0)")
    say(types["Z^R_0"] == sorted(["Bl", "G", "R"]) and types["Z^L_1"] == sorted(["Bl", "G", "R"]),
        "Z^R_0 and Z^L_1 are trichromatic {Bl, G, R}: both complementary to B_0")
    for lab, v in (("Z^R_0", ZR0), ("Z^L_1", ZL1)):
        d2 = Y.n2(Y.sub(v, B0))
        say(d2 < 4 and d2 > 0, f"|B_0 - {lab}|^2 = {d2.f():.6f} < 4 (a close pair)")
    if True:
        say(common_points_check(B0, ZR0, [A0, C0]), "omega(B_0) cap omega(Z^R_0) = {A_0, C_0} (both at distance 1 from both; distinct)")
        claimed = [A1, C0] if PLANT == "wrongpts" else [A1, D1]
        res = common_points_check(B0, ZL1, claimed)
        say(res if PLANT != "wrongpts" else not res,
            "omega(B_0) cap omega(Z^L_1) = {A_1, D_1}" if PLANT != "wrongpts" else "PLANT wrongpts: the claim {A_1, C_0} is REFUSED (C_0 is not 1 from Z^L_1)")
        four = [A0, C0, A1, D1]
        n_distinct = sum(1 for i in range(4) if not any(veq(four[i], four[j]) for j in range(i)))
        say(n_distinct == 4, f"the common unit points of B_0's two partners are {n_distinct} distinct points: A_0, C_0, A_1, D_1 "
                             f"-- FS112-N3-COR3 makes each a leaving centre of B_0; a cubic vertex has at most 3: OBSTRUCTION")
    lc = leaving_centres(T, B0)
    print("   B_0's leaving centres in the disk: " + ", ".join(fmt(q) for q in lc))
    say(len(lc) == 2 and any(veq(q, A0) for q in lc) and any(veq(q, A1) for q in lc), "B_0's leaving centres in the disk are A_0 and A_1")
    say(veq(Y.sub(Y.add(A0, A1), B0), A3), "the completion A_0 + A_1 - B_0 is exactly the corner A_3 of the central tile (four colours)")
    # the third centre each partner would need: Z^R_0 = A_0 + w - B_0 -> w = C_0; Z^L_1 = A_1 + w' - B_0 -> w' = D_1
    w = Y.sub(Y.add(ZR0, B0), A0)
    w2 = Y.sub(Y.add(ZL1, B0), A1)
    say(veq(w, C0) and veq(w2, D1) and not veq(w, w2), "the third centre Z^R_0 needs is C_0, the one Z^L_1 needs is D_1: two, not one")
    # Z^R_0 cannot pair with A_1 (nor Z^L_1 with A_0): the needed third centre would not lie on omega(B_0)
    wx = Y.sub(Y.add(ZR0, B0), A1)
    say(not (Y.n2(Y.sub(wx, B0)) == 1), f"Z^R_0 = A_1 + w - B_0 has |w - B_0|^2 = {Y.n2(Y.sub(wx, B0)).f():.5f} != 1: no such centre")
    # the twin (negative control): a second partner sharing the centre C_0
    twin = Y.sub(Y.add(A1, C0), B0)
    print(f"   twin partner A_1 + C_0 - B_0 = {fmt(twin)}, |twin - B_0|^2 = {Y.n2(Y.sub(twin, B0)).f():.5f}")
    ok_twin = common_points_check(B0, twin, [A1, C0])
    pts = [A0, C0] + [A1, C0]
    union = [q for i, q in enumerate(pts) if not any(veq(q, r) for r in pts[:i])]
    say(ok_twin and len(union) == 3, "TWIN: omega(B_0) cap omega(twin) = {A_1, C_0}; union with {A_0, C_0} has 3 points -- no obstruction "
                                     "(the count fires only when the partners' centres are four)")


def routes():
    print("== C114-PENT part 2: the blue and orange routes to a fourth colour at C_0, on the moved disk (exact at named points)")
    M = DK.Disk() if PLANT == "unmoved" else DL.MovedDisk()
    T, P, e = M.T, M.P, M.e
    g = lambda nm, k: P[(nm, k % 5)]
    C0, B0, ZL0, ZR0, A0 = g("C", 0), g("B", 0), g("ZL", 0), g("ZR", 0), g("A", 0)
    F = M.F
    Tf = {nm: DK.tile_poly(pr) for nm, (c, pr) in T.items()}          # float guard only: which tile a named point lies in
    # the free-set instrument at a known positive and a known zero (FS112-MOVE, two minds): on the moved disk green is free at
    # C_0 + e(126)/100 and nothing is free at C_0 + e(72)/100.  Plant 'unmoved' runs this on the unmoved disk: green must then be blocked.
    def free0(z):
        return [c for c in COLS if not [nm for nm, (cc, pr) in T.items() if cc == c and DK.straddles(z, pr)]]
    f126 = free0(Y.add(C0, Y.mul(M.F(Fr(1, 100)), e(126))))
    f72 = free0(Y.add(C0, Y.mul(M.F(Fr(1, 100)), e(72))))
    print(f"   control: free at C_0 + e(126)/100: {f126}; at C_0 + e(72)/100: {f72}")
    if PLANT == "unmoved":
        say("G" not in f126, "PLANT unmoved: green is NOT free at C_0 + e(126)/100 on the unmoved disk (the move is what frees it)")
        return
    say("G" in f126 and f72 == [], "control: green free at C_0 + e(126)/100 (known positive), nothing free at C_0 + e(72)/100 (known wedge)")
    eps = F(Fr(1, 100))
    for th in (54, 72, 90):
        z = Y.add(C0, Y.mul(eps, e(th)))
        bl = {c: [nm for nm, (cc, pr) in T.items() if cc == c and DK.straddles(z, pr)] for c in COLS}
        print(f"   C_0 + e({th})/100: straddlers " + "; ".join(f"{c}: {','.join(v) if v else '-'}" for c, v in bl.items()))
    z72 = Y.add(C0, Y.mul(eps, e(72)))
    bl = {c: [nm for nm, (cc, pr) in T.items() if cc == c and DK.straddles(z72, pr)] for c in COLS}
    say(bl["Bl"] == ["T2_0"] and bl["O"] == ["T1_0"], "at C_0 + e(72)/100 the only blue straddler is T2_0 and the only orange one T1_0")

    def free(z, skip):
        out = []
        blk = {}
        for c in COLS:
            b = [nm for nm, (cc, pr) in T.items() if cc == c and nm not in skip and DK.straddles(z, pr)]
            blk[c] = b
            if not b:
                out.append(c)
        return out, blk

    # BLUE: T2_0's part inside B(C_0, 1).  Named points: near Z^L_0 inside T2_0, and under the top arc of omega(A_0) (T2_0 | R_0).
    t = [F(Fr(1, 50)), F(Fr(1, 20)), F(Fr(1, 10))]
    blue_pts = []
    for s in t:
        blue_pts.append(("A_0 + (1 - s) e(90)", s, Y.add(A0, Y.mul(1 - s, e(90)))))           # under the top arc's midpoint
        blue_pts.append(("A_0 + (1 - s) e(104)", s, Y.add(A0, Y.mul(1 - s, Y.mul(F(Fr(1, 2)), Y.add(e(90), e(108)))))))
        blue_pts.append(("Z^L_0 + s (A_0 - Z^L_0)", s, Y.add(ZL0, Y.mul(s, Y.sub(A0, ZL0)))))
    print("-- BLUE route: points of T2_0 inside B(C_0, 1), T2_0 ignored")
    blue_dead = False
    for lab, s, z in blue_pts:
        inside = Y.n2(Y.sub(z, C0)) < 1
        fr, blk = free(z, ("T2_0",))
        where = DK.locate(Tf, *DK.fpt(z))
        print(f"   [in {where}] {lab}, s = {s.f():.3f} {fmt(z)}: |z - C_0|^2 = {Y.n2(Y.sub(z, C0)).f():.4f} ({'inside' if inside else 'OUTSIDE'});"
              f" free {fr}; blockers " + "; ".join(f"{c}: {','.join(v)}" for c, v in blk.items() if v))
        if inside and set(fr) <= {"Bl"}:
            blue_dead = True
    if True:
        say(blue_dead, "BLUE route: some named point of T2_0 inside B(C_0, 1) has free set within {Bl} -- the part cannot be recoloured "
                       "with the rest of the moved disk unchanged")
    # ORANGE: T1_0's part inside B(C_0, 1), near B_0 in directions (-18, 18).
    orange_pts = []
    for s in t:
        orange_pts.append(("B_0 + s e(0)", s, Y.add(B0, Y.mul(s, e(0)))))
        orange_pts.append(("B_0 + s (e(0) + e(342))/2", s, Y.add(B0, Y.mul(s / 2, Y.add(e(0), e(342))))))
        orange_pts.append(("B_0 + s (e(0) + e(18))/2", s, Y.add(B0, Y.mul(s / 2, Y.add(e(0), e(18))))))
    print("-- ORANGE route: points of T1_0 inside B(C_0, 1), T1_0 ignored")
    orange_dead = False
    for lab, s, z in orange_pts:
        inside = Y.n2(Y.sub(z, C0)) < 1
        fr, blk = free(z, ("T1_0",))
        where = DK.locate(Tf, *DK.fpt(z))
        print(f"   [in {where}] {lab}, s = {s.f():.3f} {fmt(z)}: |z - C_0|^2 = {Y.n2(Y.sub(z, C0)).f():.4f} ({'inside' if inside else 'OUTSIDE'});"
              f" free {fr}; blockers " + "; ".join(f"{c}: {','.join(v)}" for c, v in blk.items() if v))
        if inside and set(fr) <= {"O"}:
            orange_dead = True
    if True:
        say(orange_dead, "ORANGE route: some named point of T1_0 inside B(C_0, 1) has free set within {O}")


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args:
        PLANT = args[args.index("--plant") + 1]
    which = [a for a in args if a in ("pent", "routes")] or ["pent", "routes"]
    if "pent" in which:
        pent()
    if "routes" in which:
        routes()
    print("ALL AS REGISTERED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
