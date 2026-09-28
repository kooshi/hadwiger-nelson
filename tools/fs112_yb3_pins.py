#!/usr/bin/env python3
"""FS112-YB3: exact checks of Y3-LEG, Y3-DISK-T* and Y3-STRIPCUT at NAMED points (no scan), written without reading FS112-Y3's record
or tools.  The objects are FS112-YB2's exact rebuilds (tools/fs112_yb2_objects.py: the strip and the disk; tools/fs112_yb2_analysis.py:
the disk's first move, O3 = Y2-MOVE), imported and run, never edited.  Labels: YB2's, with Y2's in comments where the claims use them
(Y2 C0 = Z; T1_k = P_k; T2_k = W_k; U_k = S_k; U'_k = T_{k+1}; Z^L_k = U_k; Z^R_k = U'_k; Y_k = X_k; strip: Y's C_m = YB2's T_m).

A colour is BLOCKED at a point z when some tile of that colour has min < 1 < max over |z - p| (then it forbids that colour on a
neighbourhood of z); my own point-to-tile routine (tools/fs112_yb3_frags.py) decides min and max against 1 exactly.

Run: python3 tools/fs112_yb3_pins.py [leg|disk|strip]
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K        # noqa: E402
import fs112_yb2_objects as O      # noqa: E402
import fs112_yb2_analysis as AN    # noqa: E402
import fs112_yb3_frags as YF       # noqa: E402

Seg, Arc = K.Seg, K.Arc
vadd, vsub, vmul, n2, dot, cross, perp, veq = K.vadd, K.vsub, K.vmul, K.n2, K.dot, K.cross, K.perp, K.veq


def fp(p):
    return f"({float(p[0]):.6f}, {float(p[1]):.6f})"


def lift_pt(p, T):
    return (p[0].to(T), p[1].to(T))


def lift_tiles(tiles, T):
    out = {}
    for nm, (c, ps) in tiles.items():
        new = []
        for pc in ps:
            if pc.kind == "S":
                new.append(Seg(lift_pt(pc.P, T), lift_pt(pc.Q, T)))
            else:
                new.append(Arc(lift_pt(pc.C, T), pc.rho.to(T), lift_pt(pc.S, T), lift_pt(pc.E, T)))
        out[nm] = (c, new)
    return out


def ang(p):
    return math.degrees(math.atan2(float(p[1]), float(p[0]))) % 360


# ============================================================ the disk: Y3-LEG and Y3-DISK-T*
def disk_setup():
    Dk = O.Disk()
    T0 = Dk.T
    p = Dk.pt
    A0, U0, X0, C0, D0 = p("A", 0), p("U", 0), p("X", 0), p("C", 0), p("D", 0)
    q2 = vsub(U0, (T0(1), T0(0)))                     # Y3's q2 = Z^L_0 - (1, 0)
    # the tower grows by sqrt3 (the equilateral points), sqrt(4r^2 - 1) (the rim's crossing with omega(C_0)) and the rim's with omega(U_0)
    T1 = T0.extend(3, "3")
    r2 = Dk.r2.to(T1)
    T2 = T1.extend(4 * r2 - 1, "4r^2-1")
    u2 = n2(lift_pt(U0, T2))
    r2b = Dk.r2.to(T2)
    m = (r2b + u2 - 1) / 2
    T3 = T2.extend(r2b * u2 - m * m, "r^2u^2-m^2")
    return Dk, T3, dict(A0=A0, U0=U0, X0=X0, C0=C0, D0=D0, q2=q2), T1


def run_leg():
    Dk, T, P, _T1 = disk_setup()
    L = {k: lift_pt(v, T) for k, v in P.items()}
    A0, U0, X0, C0, q2 = L["A0"], L["U0"], L["X0"], L["C0"], L["q2"]
    one = T(1)
    phi2 = Dk.phi.to(T) * Dk.phi.to(T)
    print("== Y3-LEG and the facts Y3-DISK-T* rests on (exact, in the tower", T, ")")
    print(f"   |q2 - Z^L_0|^2 = 1: {n2(vsub(q2, U0)) == one};  |q2 - C_0|^2 = 1: {n2(vsub(q2, C0)) == one}"
          f"  (so q2 is a point of omega(C_0) and omega(Z^L_0); the other is D_0: {n2(vsub(P['D0'], P['U0'])) == Dk.T(1)} and"
          f" C_0 + Z^L_0 - q2 = D_0: {veq(vsub(vadd(C0, U0), q2), lift_pt(P['D0'], T))})")
    print(f"   |A_0 - q2|^2 = phi^2: {n2(vsub(A0, q2)) == phi2};  |A_0 - C_0|^2 = phi^2: {n2(vsub(A0, C0)) == phi2}")
    leg = vsub(X0, A0)                                   # Y2's leg Y_0 A_0 (YB2's A_0 X_0), length s = sqrt(1/phi)
    M = vmul(Fr(1, 2), vadd(C0, q2))
    print(f"   the leg's line is the perpendicular bisector of C_0, q2: (C_0 - q2).leg = 0: {dot(vsub(C0, q2), leg).is0()};"
          f"  the midpoint on the leg's line: {cross(vsub(M, A0), leg).is0()}")
    s = Dk.s.to(T)
    u = vmul(1 / s, leg)                                 # unit vector along the leg, = e(126 deg)
    e126 = lift_pt(Dk.c[126], T)
    e36 = lift_pt(Dk.c[36], T)
    print(f"   leg direction e(126): {veq(u, e126)};  q2 - C_0 = -e(36): {veq(vsub(q2, C0), vmul(-1, e36))}")
    r3 = T.gen(5)                                       # sqrt3 (the fifth radicand)
    assert (r3 * r3) == T(3)
    Kpt = vsub(M, vmul(r3 / 2, u))                      # the intersection point of omega(C_0), omega(q2) nearer A_0
    K2 = vadd(M, vmul(r3 / 2, u))
    for nm, Z in (("K", Kpt), ("K'", K2)):
        print(f"   {nm} = {fp(Z)}: |{nm} - C_0|^2 = 1: {n2(vsub(Z, C0)) == one}; |{nm} - q2|^2 = 1: {n2(vsub(Z, q2)) == one};"
              f" on the leg's line: {cross(vsub(Z, A0), leg).is0()}; direction of {nm} - C_0 = {ang(vsub(Z, C0)):.6f} deg")
    d = dot(vsub(Kpt, A0), u)
    print(f"   K on the SEGMENT A_0 Y_0 (Y2's leg): 0 < d < s with d = (K - A_0).u: {d.sign() > 0 and d < s}  (d ~ {float(d):.6f},"
          f" s ~ {float(s):.6f});  K' beyond Y_0: {dot(vsub(K2, A0), u) > s}")
    print(f"   |q2 - Y_0|^2 < 1 (Y2's Y_0 = YB2's X_0): {n2(vsub(q2, X0)) < one}  (~ {float(n2(vsub(q2, X0))):.6f})")
    return Dk, T, dict(A0=A0, U0=U0, X0=X0, C0=C0, q2=q2, K=Kpt)


def tstar(Dk, T, C0, U0, q2):
    """Y2's thin triangle T* = disc(O, r) ∩ B(C_0, 1) \\ B̄(Z^L_0, 1): corners q2, p* (rim ∩ omega(C_0)), rho* (rim ∩ omega(Z^L_0))."""
    one = T(1)
    r2 = Dk.r2.to(T)
    r = Dk.r.to(T)
    g4 = T.gen(6)                          # sqrt(4r^2 - 1)
    g6 = T.gen(7)                          # sqrt(r^2 u^2 - m^2)
    pstar = vadd(vmul((2 * r2 - 1) / (2 * r2), C0), vmul(g4 / (2 * r2), perp(C0)))
    u2 = n2(U0)
    m = (r2 + u2 - 1) / 2
    rstar = vadd(vmul(m / u2, U0), vmul(g6 / u2, perp(U0)))
    for nm, Z in (("p*", pstar), ("rho*", rstar)):
        assert n2(Z) == r2, nm
    assert n2(vsub(pstar, C0)) == one and n2(vsub(rstar, U0)) == one
    O_ = (T(0), T(0))
    pieces = [Arc(C0, one, pstar, q2), Arc(O_, r, rstar, pstar), Arc(U0, one, rstar, q2)]
    print(f"   T*: q2 {fp(q2)} (angle {ang(q2):.4f}), p* {fp(pstar)} (rim angle {ang(pstar):.4f}), rho* {fp(rstar)} (rim angle {ang(rstar):.4f})")
    return pieces


def run_disk():
    run_leg()
    Dk, T7, P, T = disk_setup()                  # T: YB2's disk tower + sqrt3 (5 levels); T7 adds the two rim radicands (for T* only)
    A0, U0, X0, C0, q2 = (lift_pt(P[k], T) for k in ("A0", "U0", "X0", "C0", "q2"))
    one = T(1)
    u = vmul(1 / Dk.s.to(T), vsub(X0, A0))
    M = vmul(Fr(1, 2), vadd(C0, q2))
    Kp = vsub(M, vmul(T.gen(5) / 2, u))
    assert n2(vsub(Kp, C0)) == one and n2(vsub(Kp, q2)) == one
    print("\n== Y3-DISK-T*: the region V = W_0 ∩ B(q2, 1) (Y2's T2_0 ∩ B(q2, 1)), at named points, against the moved disk (Y2-MOVE = YB2 O3)")
    moved = lift_tiles(AN.moved_tiles(Dk), T)
    ts = tstar(Dk, T7, lift_pt(C0, T7), lift_pt(U0, T7), lift_pt(q2, T7))
    G = vmul(Fr(1, 3), vadd(vadd(U0, X0), Kp))
    named = {"centroid": G}
    for nm, Z in (("near Z^L_0", U0), ("near Y_0", X0), ("near K", Kp)):
        named[nm] = vadd(vmul(Fr(4, 5), Z), vmul(Fr(1, 5), G))
    for nm, (Z1, Z2) in (("side Z^L_0-Y_0", (U0, X0)), ("leg Y_0-K", (X0, Kp)), ("chord K-Z^L_0", (Kp, U0))):
        mid = vmul(Fr(1, 2), vadd(Z1, Z2))
        named[nm] = vadd(vmul(Fr(9, 10), mid), vmul(Fr(1, 10), G))
    W0 = moved["W0"][1]
    changed = {"W0", "T1", "S0"}               # the tiles the second move changes (Y2's T2_0, U'_0, U_0)
    colours = ["red", "blue", "green", "yellow", "orange", "violet"]
    allfree = []
    for nm, z in named.items():
        inside = n2(vsub(z, q2)) < one
        inW = all(cross(vsub(b, a), vsub(z, a)).sign() < 0 for a, b in ((A0, X0), (X0, U0)))  # W_0 runs A->X->U clockwise: interior on the right
        print(f"-- {nm} {fp(z)}: in B(q2, 1): {inside}; on W_0's side of its leg and of its side Z^L_0-Y_0: {inW}", flush=True)
        free = []
        for col in colours:
            b_unch = YF.blocked(z, moved, col, exclude=changed)
            extra = []
            if col == "blue":
                smn, smx = YF.point_vs_tile(lift_pt(z, T7), ts)
                extra.append(f"T* (min {smn} 1, max {smx} 1)")
                if smn == "<" and smx == ">":
                    extra[-1] = "T* STRADDLES"
            if col == "violet":
                extra += [f"S0 {'STRADDLES' if YF.blocked(z, {'S0': moved['S0']}, col) else 'does not straddle'}"]
            if col == "yellow":
                extra += [f"T1 (cut by the move) {'straddles' if YF.blocked(z, {'T1': moved['T1']}, col) else 'does not straddle'}"]
            tag = ", ".join(b_unch) if b_unch else "no unchanged tile"
            tag += " | " + "; ".join(extra) if extra else ""
            if not b_unch and not any("STRADDLES" in e for e in extra):
                free.append(col)
            print(f"     {col:7s} blocked by {tag}", flush=True)
        allfree.append((nm, free))
    print("-- summary: colours admissible at each named point (blocked neither by an unchanged tile nor by T* / the unchanged S_0):")
    for nm, free in allfree:
        print(f"     {nm:18s}: {free if free else 'NONE'}")


# ============================================================ the strip: Y3-STRIPCUT
def run_strip():
    S = O.Strip()
    T = S.T
    tiles = S.tiles(-8, 9)
    Y = S.Y
    Q = (T(Fr(1, 4)), Y)
    one = T(1)
    print("== Y3-STRIPCUT on YB2's strip (exact).  Y's colours: 1..6 = P, G, B, M, R, O; colour 4 = M; C_m = YB2's T_m")
    for nm in ("T-1", "T2"):
        c, ps = tiles[nm]
        print(f"   {nm} colour {c}: corners " + ", ".join(fp(X) for pc in ps for X in pc.ends()[:1]))
    # omega(Q) through each: the corner and the apex
    tests = {"(-3/4, Y)": (T(Fr(-3, 4)), Y), "apex A_{-1} (-1/4, sqrt15/4)": S.A(-1, 1), "(5/4, Y)": (T(Fr(5, 4)), Y),
             "apex A_1 (3/4, sqrt15/4)": S.A(1, 1), "valley V_2 (1, sqrt3/2)": S.V(2, 1), "valley V_-1 (-1/2, sqrt3/2)": S.V(-1, 1)}
    for nm, Z in tests.items():
        d2 = n2(vsub(Z, Q))
        print(f"   |Q - {nm}|^2 = {float(d2):.6f}: " + ("= 1" if d2 == one else ("< 1" if d2 < one else "> 1")))
    # named points: on the cut (Q + a rational unit vector) and beside it, in each tile's inner part
    r3, r5 = T.gen(1), T.gen(2)
    rats = [(Fr(3, 5), Fr(-4, 5)), (Fr(4, 5), Fr(-3, 5)), (Fr(12, 13), Fr(-5, 13))]
    named = {}
    for sx, tile in ((1, "T2"), (-1, "T-1")):
        for (a, b) in rats:
            on = (Q[0] + T(a) * sx, Q[1] + T(b))
            named[f"{tile} on the cut, Q + ({sx * a}, {b})"] = (tile, on)
            named[f"{tile} just inside the cut, Q + 0.97({sx * a}, {b})"] = (tile, (Q[0] + T(a * sx * Fr(97, 100)), Q[1] + T(b * Fr(97, 100))))
            named[f"{tile} just outside the cut, Q + 1.03({sx * a}, {b})"] = (tile, (Q[0] + T(a * sx * Fr(103, 100)), Q[1] + T(b * Fr(103, 100))))
        cx = Fr(3, 4) if sx == 1 else Fr(-1, 4)
        named[f"{tile} inner corner region ({cx} + {sx}/20, Y - 1/20)"] = (tile, (T(cx + sx * Fr(1, 20)), Y - Fr(1, 20)))
        named[f"{tile} inner part ({cx} + {sx}/5, Y - 1/10)"] = (tile, (T(cx + sx * Fr(1, 5)), Y - Fr(1, 10)))
    names = {1: "P", 2: "G", 3: "B", 4: "M", 5: "R", 6: "O"}
    summary = []
    for nm, (tile, z) in named.items():
        mn, mx = YF.point_vs_tile(z, tiles[tile][1])
        dQ = n2(vsub(z, Q))
        pos = "on omega(Q)" if dQ == one else ("inside B(Q,1)" if dQ < one else "outside B(Q,1)")
        print(f"-- {nm}: {fp(z)} [{pos}]")
        free = []
        for k in range(1, 7):
            b = YF.blocked(z, tiles, names[k], exclude=("T-1", "T2"))
            print(f"     colour {k} ({names[k]}) blocked by: {', '.join(b) if b else 'NO OTHER TILE'}")
            if not b:
                free.append(k)
        summary.append((nm, pos, free))
    print("-- summary: colours no other tile forbids (T_-1 and T_2 excluded)")
    for nm, pos, free in summary:
        print(f"     {nm:52s} [{pos:14s}]: {free}")


if __name__ == "__main__":
    which = sys.argv[1:] or ["leg", "disk", "strip"]
    if "leg" in which and "disk" not in which:
        run_leg()
    if "disk" in which:
        run_disk()
    if "strip" in which:
        run_strip()


# ============================================================ the second move's violet extension, exactly
def run_violet():
    """Y2 6.4: the part of T_1 (Y2's U'_0) inside B(C_0, 1) and inside the closed unit disc about Z^L_0 joins S_0 (Y2's U_0, violet).
    X_ext = the curvilinear quadrilateral B_0, F_0, rho*, q2 (segment B_0F_0; rim F_0 -> rho*; arc of omega(Z^L_0) rho* -> q2; arc of
    omega(C_0) q2 -> B_0).  Checked: X_ext's corners on the circles named; its validity as part of the violet tile (self pair and against
    every violet tile); then violet at the seven named points of V with S_0 and X_ext in place."""
    Dk, T7, P, T5 = disk_setup()
    L = {k: lift_pt(v, T7) for k, v in P.items()}
    A0, U0, X0, C0, q2 = L["A0"], L["U0"], L["X0"], L["C0"], L["q2"]
    one = T7(1)
    r2, r = Dk.r2.to(T7), Dk.r.to(T7)
    g6 = T7.gen(7)
    u2 = n2(U0)
    m = (r2 + u2 - 1) / 2
    rstar = vadd(vmul(m / u2, U0), vmul(g6 / u2, perp(U0)))
    B0, F0 = lift_pt(Dk.pt("B", 0), T7), lift_pt(Dk.pt("F", 0), T7)
    O_ = (T7(0), T7(0))
    print("== the violet extension X_ext of S_0 (Y2 6.4), exact")
    print(f"   |B_0 - C_0|^2 = 1: {n2(vsub(B0, C0)) == one}; |F_0 - C_0|^2 < 1: {n2(vsub(F0, C0)) < one};"
          f" |F_0 - Z^L_0|^2 < 1: {n2(vsub(F0, U0)) < one}; |B_0 - Z^L_0|^2 < 1: {n2(vsub(B0, U0)) < one}")
    xext = [Seg(B0, F0), Arc(O_, r, F0, rstar), Arc(U0, one, rstar, q2), Arc(C0, one, q2, B0)]
    moved = lift_tiles(AN.moved_tiles(Dk), T7)
    viol = {nm: v for nm, v in moved.items() if v[0] == "violet"}
    viol["Xext"] = ("violet", xext)
    rows = []
    for a in sorted(viol):
        r_ = K.pair_verdict(viol[a][1], viol["Xext"][1], self_pair=(a == "Xext")) if a != "Xext" else K.pair_verdict(xext, xext, True)
        rows.append((a, r_))
        print(f"   pair (Xext, {a}): {r_}")
    # the union S_0 + X_ext as one tile: its self pair is the pair (S_0, X_ext) together with each self pair
    Kpt = vsub(vmul(Fr(1, 2), vadd(C0, q2)), vmul(T7.gen(5) / 2, vmul(1 / Dk.s.to(T7), vsub(X0, A0))))
    G = vmul(Fr(1, 3), vadd(vadd(U0, X0), Kpt))
    named = {"centroid": G}
    for nm, Z in (("near Z^L_0", U0), ("near Y_0", X0), ("near K", Kpt)):
        named[nm] = vadd(vmul(Fr(4, 5), Z), vmul(Fr(1, 5), G))
    for nm, (Z1, Z2) in (("side Z^L_0-Y_0", (U0, X0)), ("leg Y_0-K", (X0, Kpt)), ("chord K-Z^L_0", (Kpt, U0))):
        mid = vmul(Fr(1, 2), vadd(Z1, Z2))
        named[nm] = vadd(vmul(Fr(9, 10), mid), vmul(Fr(1, 10), G))
    print("-- violet at the named points of V with S_0 and X_ext in place (the union straddles iff min < 1 over the union and max > 1)")
    for nm, z in named.items():
        s_mn, s_mx = YF.point_vs_tile(z, moved["S0"][1])
        x_mn, x_mx = YF.point_vs_tile(z, xext)
        mn = "<" if "<" in (s_mn, x_mn) else ("=" if "=" in (s_mn, x_mn) else ">")
        mx = ">" if ">" in (s_mx, x_mx) else ("=" if "=" in (s_mx, x_mx) else "<")
        other = YF.blocked(z, moved, "violet", exclude=("S0",))
        print(f"     {nm:18s}: S_0 min {s_mn} max {s_mx}; X_ext min {x_mn} max {x_mx}; union straddles: {mn == '<' and mx == '>'};"
              f" other violet tiles blocking: {other if other else 'none'}", flush=True)


if __name__ == "__main__" and "violet" in sys.argv[1:]:
    run_violet()


# ============================================================ step 4: Y3's seven named points, in the IN-DISK object
def run_y3points():
    """FS112-Y3 §2.2 item 4's seven points q2 + rho e(-2 atan t) (t = 1/40, 1/20, 1/12 at rho = 99/100; t = 1/8, 1/6 at rho = 99/100, 19/20),
    tested against the moved disk with the second move's tiles kept INSIDE the disk (T*, the violet extension X_ext ending on the rim),
    W_0, T_1, S_0 excluded as changed; violet against S_0 and X_ext together."""
    Dk, T7, P, T5 = disk_setup()
    L = {k: lift_pt(v, T7) for k, v in P.items()}
    U0, C0, q2 = L["U0"], L["C0"], L["q2"]
    one = T7(1)
    r2, r = Dk.r2.to(T7), Dk.r.to(T7)
    g6 = T7.gen(7)
    u2 = n2(U0)
    m = (r2 + u2 - 1) / 2
    rstar = vadd(vmul(m / u2, U0), vmul(g6 / u2, perp(U0)))
    B0, F0 = lift_pt(Dk.pt("B", 0), T7), lift_pt(Dk.pt("F", 0), T7)
    O_ = (T7(0), T7(0))
    xext = [Seg(B0, F0), Arc(O_, r, F0, rstar), Arc(U0, one, rstar, q2), Arc(C0, one, q2, B0)]
    ts = tstar(Dk, T7, C0, U0, q2)
    moved = lift_tiles(AN.moved_tiles(Dk), T7)
    pts = []
    for t, rho in ((Fr(1, 40), Fr(99, 100)), (Fr(1, 20), Fr(99, 100)), (Fr(1, 12), Fr(99, 100)), (Fr(1, 8), Fr(99, 100)),
                   (Fr(1, 6), Fr(99, 100)), (Fr(1, 8), Fr(19, 20)), (Fr(1, 6), Fr(19, 20))):
        e = ((1 - t * t) / (1 + t * t), -2 * t / (1 + t * t))
        pts.append((f"t={t}, rho={rho}", vadd(q2, (T7(rho * e[0]), T7(rho * e[1])))))
    print("== FS112-Y3's seven named points of V, tested in the IN-DISK object (my X_ext ends on the rim; Y3's U_0 was closed beyond it)")
    for nm, z in pts:
        free = []
        parts = []
        for col in ["red", "blue", "green", "yellow", "orange", "violet"]:
            b = YF.blocked(z, moved, col, exclude={"W0", "T1", "S0"})
            if col == "blue":
                mn, mx = YF.point_vs_tile(z, ts)
                if mn == "<" and mx == ">":
                    b = b + ["T*"]
            if col == "violet":
                s_mn, s_mx = YF.point_vs_tile(z, moved["S0"][1])
                x_mn, x_mx = YF.point_vs_tile(z, xext)
                if ("<" in (s_mn, x_mn)) and (">" in (s_mx, x_mx)):
                    b = b + ["S0+Xext"]
            if col == "yellow" and YF.blocked(z, {"T1": moved["T1"]}, col):
                b = b + ["(T1)"]
            if not [x for x in b if not x.startswith("(")]:
                free.append(col)
            parts.append(f"{col}: {','.join(b) if b else '-'}")
        print(f"   {nm:18s} {fp(z)} |z-q2|^2 < 1: {n2(vsub(z, q2)) < one}; free {free if free else 'NONE'}  [{'; '.join(parts)}]", flush=True)


if __name__ == "__main__" and "y3points" in sys.argv[1:]:
    run_y3points()
