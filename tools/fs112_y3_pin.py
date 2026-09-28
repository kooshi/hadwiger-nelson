#!/usr/bin/env python3
"""FS112-Y3 stage 2: the pinned corner's two named GAPs (A3-3.5 item 1), by formula, checked exactly at named points.

Sections (python3 tools/fs112_y3_pin.py [strip] [disk] [--plant NAME]):
  strip -- the strip's colour 4 at Q = (1/4, top) by cutting C_{-1} and C_2 along omega(Q) (Y2 §6.5, Y2 §7 item 4).
           Exact: omega(Q) runs through C_{-1}'s corners (-3/4, top) and (-1/4, sqrt15/4) (the apex of A_{-1}) and through C_2's (5/4, top),
           (3/4, sqrt15/4) (the apex A_1); the valley V_{-1} = (-1/2, sqrt3/2) is outside B(Q, 1).  At named points of C_{-1} on both sides of
           the cut, and in the valley's top sector with the valley's own three tiles removed, the colours no other strip tile forbids
           (the free set: colour c is forbidden at w when some c-tile has points at distance < 1 and > 1 from w), with each blocker named.
  disk  -- the disk's second move at the rim corner C_0 (Y2 §6.4, Y2 §7 item 3): on Y2's moved disk (tools/fs112_y2_dial.py MovedDisk,
           run, never edited), U'_0's part inside B(C_0, 1) is taken from it; inside B(Z^L_0, 1) it joins U_0 (purple), the rest is T*
           (blue); every corner is derived in Y2's base tower (no new square root: q2 = Z^L_0 - (1, 0) = omega(C_0) cap omega(Z^L_0), the
           second point being D_0; p* = omega(C_0) cap rim with sqrt(4r^2 - 1) = 3 tan72/sqrt5; T* and U_0 are closed just beyond the rim at
           s1 = Z^L_0 + e(162), s2 = C_0 + e(198)).  The change near Z^L_0 that keeps T2_0's top arc: T2_0's side Z^L_0 Y_0 (direction 244)
           replaced by Z^L_0 M, M Y_0 with M = (x(Z^L_0), y(Y_0)) (direction exactly 270 = 180 + 90, the tangent bound set by q2), the
           sliver Z^L_0 M Y_0 to U_0.  Exact check of every same-colour pair that holds a changed tile (the others are Y2's, unchanged:
           71/71 ACCEPT, data/fs112/fs112-y/y2_dial_move.out); then the free colours at C_0 + e(theta)/100 and D_0 + e(theta)/100.
Plant (--plant): 'tstar_purple' (T* coloured purple: registered REJECT at (T*, U_0), U_0's diameter through Z^L_0).
Variants run in `disk` (each with its registered verdict, record §2.2): 'route' (T2_0 unchanged): REJECT at (T2_0, T*) only;
'sliver270' (Y2's literal change near Z^L_0): REJECT at (T2_0, T*) and (U_0, U_0).  The first run of this tool (a 270-degree sliver and
U_0 closed at s1) returned REJECT at (T2_0, T*), (U_0, U_0): data/fs112/fs112-y/y3_pin_disk_first.out; the diagnosis is in the record.
"""
from __future__ import annotations
import sys, os, math, itertools
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402  (FS112-Y's checker: run, never edited)
import fs112_y2_disk as DK         # noqa: E402  (FS112-Y2's disk: run, never edited)
import fs112_y2_dial as DL         # noqa: E402  (FS112-Y2's moved disk: run, never edited)

OK = True
PLANT = None


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


def blockers(T, z, colset, skip=()):
    """{colour: [tiles of that colour straddling distance 1 at z]}, tiles in `skip` ignored (the tiles being cut)."""
    out = {}
    for c in colset:
        out[c] = [nm for nm, (cc, prims) in T.items() if cc == c and nm not in skip and DK.straddles(z, prims)]
    return out


def free_of(bl):
    return sorted(c for c, v in bl.items() if not v)


def fmt(p):
    return f"({p[0].f():.4f}, {p[1].f():.4f})"


# ================================================================== the strip
def strip():
    print("== the strip: colour 4 at Q by cutting C_{-1} and C_2 along omega(Q) (exact)")
    F, T, top = Y.strip(-6, 8)
    r3, r5 = F.gen(1), F.gen(2)
    Q = (F(Fr(1, 4)), top)
    h1, h2 = r3 / 2, r3 * r5 / 4
    d2 = lambda p, q: Y.n2(Y.sub(p, q))
    c1a, c1b = (F(Fr(-3, 4)), top), (F(Fr(-1, 4)), h2)
    c2a, c2b = (F(Fr(5, 4)), top), (F(Fr(3, 4)), h2)
    V = (F(Fr(-1, 2)), h1)
    say(d2(Q, c1a) == 1 and d2(Q, c1b) == 1 and d2(Q, c2a) == 1 and d2(Q, c2b) == 1,
        "omega(Q) passes exactly through C_{-1}'s corners (-3/4, top), (-1/4, sqrt15/4) and C_2's (5/4, top), (3/4, sqrt15/4) = A_1")
    say(d2(Q, V) > 1, f"the valley V_(-1) = (-1/2, sqrt3/2) is outside B(Q, 1): |Q - V|^2 = {d2(Q, V)}")
    cols = [1, 2, 3, 4, 5, 6]
    # points of C_{-1} on both sides of the cut: w = Q - rho * e(t), e(t) = ((1-t^2)/(1+t^2), 2t/(1+t^2)), direction 180 + 2 atan t from Q
    print("-- points of C_{-1} near the cut arc (U = inside B(Q,1), L = outside), free colours with C_{-1} itself ignored:")
    allfree = []
    for t in (Fr(1, 5), Fr(1, 3), Fr(1, 2)):
        e = (F((1 - t * t) / (1 + t * t)), F(2 * t / (1 + t * t)))
        for rho in (Fr(19, 20), Fr(1), Fr(21, 20)):
            w = Y.sub(Q, Y.mul(F(rho), e))
            where = "U" if rho < 1 else ("L" if rho > 1 else "on the arc")
            bl = blockers(T, w, cols, skip=("C-1",))
            fr = free_of(bl)
            allfree.append(fr)
            print(f"   t = {t}, rho = {rho} ({where}): w = {fmt(w)}  free {fr}  blockers " +
                  "; ".join(f"{c}: {v}" for c, v in bl.items() if v))
    say(all(fr == [4] for fr in allfree), "at every named point of C_{-1} along the cut, on both sides, the only colour no other tile forbids is 4")
    # the valley's top sector with the valley's own three tiles removed
    print("-- V_(-1)'s neighbourhood with its top tile C_{-1} removed (A_{-2}, A_{-1} kept): free colours at V + e(theta)/50")
    eps = F(Fr(1, 50))
    dirs = {30: (r3 / 2, F(Fr(1, 2))), 60: (F(Fr(1, 2)), r3 / 2), 90: (F(0), F(1)), 120: (F(Fr(-1, 2)), r3 / 2),
            150: (-r3 / 2, F(Fr(1, 2))), 180: (F(-1), F(0)), 240: (F(Fr(-1, 2)), -r3 / 2), 270: (F(0), F(-1)),
            300: (F(Fr(1, 2)), -r3 / 2), 0: (F(1), F(0))}
    vfree = {}
    for th in sorted(dirs):
        z = Y.add(V, Y.mul(eps, dirs[th]))
        bl = blockers(T, z, cols, skip=("C-1",))
        vfree[th] = free_of(bl)
    print("   " + "; ".join(f"{th}: {v}" for th, v in vfree.items()))
    # (informational) with all three valley tiles removed the pointwise sets widen: the force comes from A_{-2}, A_{-1} themselves
    vf3 = {th: free_of(blockers(T, Y.add(V, Y.mul(eps, dirs[th])), cols, skip=("C-1", "A-2", "A-1"))) for th in (60, 90, 120)}
    print("   (all three valley tiles removed: " + "; ".join(f"{th}: {v}" for th, v in vf3.items()) + ")")
    say(vfree[60] == [4] and vfree[90] == [4] and vfree[120] == [4],
        "the valley's top sector (directions 60, 90, 120) is forced to colour 4 by the rest of the strip (Y2-FORCE, exact at V_(-1))")
    # the mirror side: C_2 along the cut
    print("-- points of C_2 near the cut arc, free colours with C_2 ignored:")
    allfree2 = []
    for t in (Fr(1, 5), Fr(1, 3), Fr(1, 2)):
        e = (F((1 - t * t) / (1 + t * t)), F(-2 * t / (1 + t * t)))       # directions -2 atan t from Q (toward C_2's lower left)
        for rho in (Fr(19, 20), Fr(21, 20)):
            w = Y.add(Q, Y.mul(F(rho), e))
            bl = blockers(T, w, cols, skip=("C2",))
            fr = free_of(bl)
            allfree2.append(fr)
            print(f"   t = {t}, rho = {rho}: w = {fmt(w)}  free {fr}")
    say(all(fr == [4] for fr in allfree2), "at every named point of C_2 along the cut the only free colour is 4")


# ================================================================== the disk
def disk_objects(variant="route", tstar_col="Bl"):
    """variant: 'route' -- the second move (U'_0 cut along omega(C_0); W' = W cap B(Z^L_0, 1) to U_0; T* = W minus it, blue), U_0's
    bulge beyond the rim closed at s1' on omega(Z^L_0) (inside B(Y_0, 1)), T2_0 unchanged;  'sliver270' -- as 'route' with Y2's
    literal change near Z^L_0: T2_0's side Z^L_0 Y_0 replaced by Z^L_0 M, M Y_0, M = (x(Z^L_0), y(Y_0)) (the side leaves Z^L_0 at
    exactly 270 = 180 + 90, the tangent bound q2 sets), the sliver to U_0."""
    M0 = DL.MovedDisk()
    F, P, T = M0.F, M0.P, dict(M0.T)
    g = lambda nm, k: P[(nm, k % 5)]
    one = F(1)
    O = (F(0), F(0))
    r, s5, s = M0.r, M0.r5, M0.s
    A0, A1, B0, C0, D0, ZL0, ZR0, Y0, u0 = (g("A", 0), g("A", 1), g("B", 0), g("C", 0), g("D", 0), g("ZL", 0), g("ZR", 0), g("Y", 0), g("u", 0))
    D1 = g("D", 1)

    def arc(Cn, rad, p, q):
        a1, a2 = Y.sub(p, Cn), Y.sub(q, Cn)
        return Y.Arc(Cn, rad, p, q) if Y.cross(a1, a2) > 0 else Y.Arc(Cn, rad, q, p)

    def rot(v, t):          # rotate v by -2 atan(t)*sign: t rational; clockwise for t > 0
        c, sn = F((1 - t * t) / (1 + t * t)), F(-2 * t / (1 + t * t))
        return (c * v[0] - sn * v[1], sn * v[0] + c * v[1])

    q2 = (ZL0[0] - 1, ZL0[1])
    r2 = r * r
    a = 1 - 1 / (2 * r2)
    root = 3 * s / ((s5 - 1) * s5)                         # sqrt(4 r^2 - 1) = 3 tan72 / sqrt5, tan72 = s/(sqrt5 - 1)
    h = root / (2 * r2)
    pstar = (a * C0[0] - h * C0[1], a * C0[1] + h * C0[0])
    s1 = Y.add(ZL0, M0.e(162))
    s2 = Y.add(C0, M0.e(198))
    s1b = Y.add(ZL0, rot(M0.e(162), Fr(-1, 28)))          # e(162 + 2 atan(1/28)) ~ e(166.09)
    # K = C_0 + e(276) = the lower point of omega(C_0) cap omega(q2) needs sqrt3: built in the base tower extended by sqrt3
    F3 = Y.Field(F.D[1:] + [F.embed(0, Fr(3)).v], names=F.names + ["3"])
    up = lambda pt: (F3.embed(4, pt[0].v), F3.embed(4, pt[1].v))
    r3 = F3.gen(5)
    C03, q23, A03, Y03, u03, A13 = up(C0), up(q2), up(A0), up(Y0), up(u0), up(A1)
    w = Y.sub(q23, C03)                                   # the unit vector e(216) from C_0 to q2
    K = Y.add(C03, (w[0] / 2 - r3 / 2 * w[1], w[1] / 2 + r3 / 2 * w[0]))     # e(216) turned by +60 degrees: e(276)
    M = (ZL0[0], Y0[1])
    pts = dict(q2=q2, pstar=pstar, s1=s1, s1b=s1b, s2=s2, M=M)
    d2 = lambda p_, q_: Y.n2(Y.sub(p_, q_))
    facts = {
        "sqrt(4r^2 - 1) = 3 tan72/sqrt5": root * root == 4 * r2 - 1,
        "q2 = Z^L_0 - (1,0) is on omega(C_0) and omega(Z^L_0), inside the disc": d2(q2, C0) == 1 and d2(q2, ZL0) == 1 and Y.n2(q2) < r2,
        "the other point of omega(C_0) cap omega(Z^L_0) is D_0": d2(D0, C0) == 1 and d2(D0, ZL0) == 1,
        "p* on the rim and omega(C_0), counter-clockwise of C_0": Y.n2(pstar) == r2 and d2(pstar, C0) == 1 and Y.cross(C0, pstar) > 0,
        "s1, s2 beyond the rim on omega(Z^L_0), omega(C_0)": d2(s1, ZL0) == 1 and Y.n2(s1) > r2 and d2(s2, C0) == 1 and Y.n2(s2) > r2,
        "s1' on omega(Z^L_0), beyond the rim, inside B(Y_0,1) and B(C_0,1)": d2(s1b, ZL0) == 1 and Y.n2(s1b) > r2 and d2(s1b, Y0) < 1 and d2(s1b, C0) < 1,
        "s1 is outside B(Y_0, 1) (why U_0 cannot reach s1)": d2(s1, Y0) > 1,
        "|q2 - Y_0| < 1 (Y_0 a corner of T2_0)": d2(q2, Y0) < 1,
        "|q2 - Z^R_0| > 1 (T2_0 reaches beyond 1 from q2)": d2(q2, ZR0) > 1,
        "|A_0 - q2|^2 = |A_0 - C_0|^2 = phi^2: the leg Y_0 A_0 is the perpendicular bisector of C_0 q2": d2(A0, q2) == d2(A0, C0)
            and d2(A0, C0) == ((1 + s5) / 2) * ((1 + s5) / 2) and Y.dot(Y.sub(A0, Y0), Y.sub(C0, q2)) == 0,
        "K (in Q(...)(sqrt3)) is on omega(C_0), on omega(q2), and on T2_0's side Y_0 A_0 strictly between": Y.n2(Y.sub(K, C03)) == 1
            and Y.n2(Y.sub(K, q23)) == 1 and Y.cross(Y.sub(K, Y03), Y.sub(A03, Y03)) == 0 and Y.dot(Y.sub(K, Y03), Y.sub(A03, Y03)) > 0
            and Y.dot(Y.sub(K, Y03), Y.sub(A03, Y03)) < Y.n2(Y.sub(A03, Y03)),
        "|K - u_0| > 1 (K cannot be purple with U_0)": Y.n2(Y.sub(K, u03)) > 1,
        "|K - A_1| < 1": Y.n2(Y.sub(K, A13)) < 1,
        "|Z^L_0 - A_1| > 1 (Z^L_0 cannot be orange with T1_0)": d2(ZL0, A1) > 1,
        "|M - q2| > 1 (the 270-degree sliver cannot join a U_0 holding q2)": d2(M, q2) > 1,
    }
    cU, prU = T["U_0"]
    cUp, prUp = T["Up_0"]
    cT2, prT2 = T["T2_0"]
    Tn = dict(T)
    Tn["Up_0"] = (cUp, [arc(O, r, pstar, D1)] + [p for p in prUp if not (isinstance(p, Y.Seg) and {Y.pkey(p.P), Y.pkey(p.Q)} == {Y.pkey(B0), Y.pkey(u0)})
                                                  and not (isinstance(p, Y.Arc) and Y.is0(Y.sub(p.C, O)))]
                   + [arc(C0, one, B0, pstar)])
    Tn["Tstar"] = (tstar_col, [arc(C0, one, q2, s2), Y.Seg(s2, s1), arc(ZL0, one, s1, q2)])
    newU = [arc(O, r, C0, u0), Y.Seg(u0, s1b), arc(ZL0, one, s1b, q2), arc(C0, one, q2, B0), arc(A1, one, B0, Y0)]
    newU += [Y.Seg(Y0, M), Y.Seg(M, ZL0)] if variant == "sliver270" else [Y.Seg(Y0, ZL0)]
    newU += [p for p in prU if isinstance(p, Y.Arc) and Y.is0(Y.sub(p.C, D0))]
    Tn["U_0"] = (cU, newU)
    if variant == "sliver270":
        prT = [p for p in prT2 if not (isinstance(p, Y.Seg) and {Y.pkey(p.P), Y.pkey(p.Q)} == {Y.pkey(ZL0), Y.pkey(Y0)})]
        assert len(prT) == len(prT2) - 1
        Tn["T2_0"] = (cT2, prT + [Y.Seg(ZL0, M), Y.Seg(M, Y0)])
    changed = ["U_0", "Up_0", "T2_0", "Tstar"]
    return M0, Tn, pts, facts, changed


def check_changed(T, changed, lab):
    pairs = [(a, b) for a, b in Y.all_pairs(T) if a in changed or b in changed]
    present = len(Y.all_pairs(T))
    v, bad, n = Y.check_pairs(T, pairs)
    print(f"   [{lab}] same-colour pairs holding a changed tile examined: {n} (the object has {present}; the other {present - n} are Y2's moved "
          f"disk's, unchanged, ACCEPT in data/fs112/fs112-y/y2_dial_move.out); VERDICT {v}; REJECT {bad}", flush=True)
    for a, b in bad:
        lo = min((abs(math.sqrt(max(A.f(), 0)) + B.f()), i, j) for i, p1 in enumerate(T[a][1]) for j, p2 in enumerate(T[b][1])
                 for (A, B) in Y.cands(p1, p2))
        print(f"      ({a}, {b}): float min {lo[0]:.5f} at primitives {T[a][1][lo[1]]} | {T[b][1][lo[2]]}")
    return v, bad


def disk():
    print(f"== the disk's second move at C_0{'  [PLANT ' + PLANT + ']' if PLANT else ''} (exact, Y2's base tower)")
    M0, T, pts, facts, changed = disk_objects("route", "P" if PLANT == "tstar_purple" else "Bl")
    for k, v in facts.items():
        say(v, k)
    print("   points: " + "; ".join(f"{k} = {fmt(p)} (|.| = {math.hypot(p[0].f(), p[1].f()):.5f})" for k, p in pts.items()), flush=True)
    v, bad = check_changed(T, changed, "route: T2_0 unchanged")
    if PLANT == "tstar_purple":
        say(any("Tstar" in pr and "U_0" in pr for pr in bad), "plant tstar_purple: REJECT at (T*, U_0)")
        return
    say(bad == [("T2_0", "Tstar")], "route: REJECT exactly at (T2_0, T*)")
    M1, T1, _, _, _ = disk_objects("sliver270")
    v1, bad1 = check_changed(T1, changed, "sliver270: Y2's literal change near Z^L_0")
    say(set(bad1) == {("T2_0", "Tstar"), ("U_0", "U_0")}, "sliver270: REJECT at (T2_0, T*) (Y_0 to q2) and (U_0, U_0) (M to q2)")
    # the obstruction: T2_0 must vacate B(q2, 1); points of T2_0 cap B(q2, 1), and the colours no other tile forbids there
    print("-- points p = q2 + rho e(-2 atan t) of T2_0 inside B(q2, 1): free colours with T2_0 itself ignored (the route's other tiles in place)")
    F = M0.F
    q2 = pts["q2"]
    Tf2 = {"T2_0": DK.tile_poly(T["T2_0"][1])}
    empty = []
    for t in (Fr(1, 40), Fr(1, 20), Fr(1, 12), Fr(1, 8), Fr(1, 6), Fr(1, 4)):
        e = (F((1 - t * t) / (1 + t * t)), F(-2 * t / (1 + t * t)))
        for rho in (Fr(99, 100), Fr(19, 20)):
            p = Y.add(q2, Y.mul(F(rho), e))
            inside = bool(DK.locate(Tf2, *DK.fpt(p)))
            bl = blockers(T, p, DL.COLS, skip=("T2_0",))
            fr = free_of(bl)
            if inside and not fr:
                empty.append((t, rho))
            print(f"   t = {t}, rho = {rho}: p = {fmt(p)} {'in T2_0' if inside else 'NOT in T2_0'}; free {fr if fr else 'NONE'}; "
                  f"blockers " + "; ".join(f"{c}: {w}" for c, w in bl.items() if w), flush=True)
    say(len(empty) > 0, f"named points of T2_0 cap B(q2, 1) with no admissible colour once T2_0 vacates it: {empty}")
    # the other half: on Y2's moved disk (move 1 only), points of W = U'_0 cap B(C_0, 1) near q2 and outside B(Z^L_0, 1), U'_0 vacated
    print("-- on Y2's moved disk, points of W = U'_0 cap B(C_0,1) near q2, outside B(Z^L_0,1): free colours with U'_0 ignored")
    T0 = M0.T
    C0, ZL0 = M0.P[("C", 0)], M0.P[("ZL", 0)]
    TfU = {"Up_0": DK.tile_poly(T0["Up_0"][1])}
    nowhere = []
    for (dx, dy, eps) in ((Fr(-1, 10), Fr(1), Fr(1, 50)), (Fr(-1, 5), Fr(1), Fr(1, 50)), (Fr(-1, 10), Fr(1), Fr(1, 20)), (Fr(-1, 2), Fr(1), Fr(1, 30))):
        p = (q2[0] + F(eps * dx), q2[1] + F(eps * dy))
        inW = Y.n2(Y.sub(p, C0)) < 1 and Y.n2(Y.sub(p, ZL0)) > 1 and bool(DK.locate(TfU, *DK.fpt(p)))
        bl = blockers(T0, p, DL.COLS, skip=("Up_0",))
        fr = free_of(bl)
        if inW and fr == ["Yw"] and bl["Bl"] == ["T2_0"]:
            nowhere.append((dx, dy, eps))
        print(f"   p = q2 + {eps}*({dx}, {dy}) = {fmt(p)} {'in W, outside B(Z^L_0,1)' if inW else 'NOT in W minus B(Z^L_0,1)'}; free {fr if fr else 'NONE'}; "
              "blockers " + "; ".join(f"{c}: {w}" for c, w in bl.items() if w), flush=True)
    say(len(nowhere) == 4, f"at every named point of W near q2 outside B(Z^L_0, 1) the only admissible colour is yellow, the colour the move must "
                           f"remove, and blue is blocked by T2_0 alone: {len(nowhere)}/4")


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
        args = [a for a in args if a != PLANT]
    for sct in (args or ["strip", "disk"]):
        {"strip": strip, "disk": disk}[sct]()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
