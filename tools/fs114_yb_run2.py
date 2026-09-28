#!/usr/bin/env python3
"""FS114-YB: the instance's objects and statements, checked exactly (called from tools/fs114_yb_run.py).

capped          object 1: the capped strip -- the capped self-pairs first, then every orbit pair; the plant cap_bulge beside the faithful twin;
                the distance from P_j to the fragment's boundary against (7 + 3 sqrt5)/4; FS112-EDGE's colourless cone at Q spot-checked exactly
pent            object 2: PENT's distances, common unit points, multicolours and leaving centres, exact
move            object 3: the moved disk, exact; the straddlers of C_0 + e(72)/100; the free sets at my points of T2_0 and T1_0 inside B(C_0, 1)
straddle-strip  statements 4, 5: the straddle relation on a window of the strip, and the derivation's facts
straddle-disk   statement 6: the straddle relation on the disk (325 pairs) and the forced-colour propagation from the six-clique
rainbow         C114-RAINBOW's third case: a valid fragment by formula (two same-colour faces meeting a face only at the two ends of its diameter)
"""
from __future__ import annotations
import itertools
import os
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402
import fs114_yb_objects as O    # noqa: E402
import fs114_yb_run as R        # noqa: E402

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub, vmul, n2 = X.vadd, X.vsub, X.vmul, X.n2


def cmp_t(c, t):
    """exact sign of (candidate distance - t), t >= 0 an element of the tower."""
    if c.kind == "sq":
        return (c.a - t * t).sign()
    D, k = c.a, c.b
    hi = X._ssp(D, k - t)
    lo = X._ssp(D, k + t)
    if hi < 0 and lo > 0:
        return -1
    if hi > 0 or lo < 0:
        return 1
    return 0


# =================================================================================== object 1
def capped():
    S = O.Strip(capped=True)
    win = S.tiles(-9, 11)
    base = [t for t in win if int(t.name[1:]) in (0, 1, 2)]
    print("== object 1: the capped strip.  First the capped self-pairs (each top and bottom tile of a period against itself):")
    for t in base:
        if t.name[0] in "TB":
            r = X.pair(t, t)
            print("   " + R.verdict_line(r))
    print("   the cap: the unit arc about the valley V_m from Q_m to Q_{m-1}; |V_m - Q_m|^2 = |V_m - Q_{m-1}|^2 = 1 (asserted exactly by the Arc constructor)")
    R.check_periodic(base, win, "capped strip (every orbit pair)", key=R.strip_key)
    R.check_periodic(base, win, "capped strip under closed_interval (tight contacts shown)", key=R.strip_key, plant="closed_interval", show=False)
    Sp = O.Strip(capped=True, plant="cap_bulge")
    winp = Sp.tiles(-9, 11)
    basep = [t for t in winp if int(t.name[1:]) in (0, 1, 2)]
    R.check_periodic(basep, winp, "capped strip plant cap_bulge (caps of radius 5/12 through the same corners)", key=R.strip_key)
    R.check_periodic(basep, winp, "capped strip plant cap_bulge under the checker plant noself", key=R.strip_key, plant="noself")
    # the disc about P_j
    T2 = S.T.extend((7 + 3 * S.T.gen(2)) / 4, "R0^2")
    R0 = T2.gen(3)
    print("== the disc about each midline vertex P_j, j = 0, 1, 2: every candidate distance from P_j to the fragment's boundary (the caps, top and "
          "bottom, columns -9..11) against R0 = sqrt((7 + 3 sqrt5)/4) = phi^2/sqrt2, exactly")
    for j in (0, 1, 2):
        Pj = S.P(j)
        Pj = (T2(Pj[0]), T2(Pj[1]))
        below = eq = 0
        eqs = []
        for t in win:
            if t.name[0] not in "TB":
                continue
            cap = [pc for pc in t.pieces if pc.kind == "A" and ((pc.C[1] - S.h).is0() or (pc.C[1] + S.h).is0())]
            assert len(cap) == 1
            for c in X.point_piece(Pj, cap[0]):
                s = cmp_t(c, R0)
                if s < 0:
                    below += 1
                elif s == 0:
                    eq += 1
                    eqs.append((t.name, c.why))
        print(f"   P_{j}: candidates below R0: {below}; equal to R0: {eq} at " + ", ".join(sorted({f'{nm}({w})' for nm, w in eqs})))
    Q0 = S.Q(0)
    print(f"   |P_1 - Q_0|^2 - (7 + 3 sqrt5)/4 = {float(n2(vsub(S.P(1), Q0)) - (7 + 3 * S.T.gen(2)) / 4)} (exact zero: "
          f"{(n2(vsub(S.P(1), Q0)) - (7 + 3 * S.T.gen(2)) / 4).is0()}); phi^4/2 = (7 + 3 sqrt5)/4: "
          f"{(((1 + S.T.gen(2)) / 2) * ((1 + S.T.gen(2)) / 2) * ((1 + S.T.gen(2)) / 2) * ((1 + S.T.gen(2)) / 2) / 2 - (7 + 3 * S.T.gen(2)) / 4).is0()}")
    # FS112-EDGE at Q_0 on the uncapped strip: free colours at Q_0 + (a, b)
    U = O.Strip()
    wu = U.tiles(-6, 8)
    Q = U.Q(0)
    print("== FS112-EDGE spot checks at Q_0 = (1/4, Y) on the strip (uncapped): free colours at Q_0 + v, exact (angle of v in degrees, float)")
    import math
    for v in ((Fr(1, 100), Fr(17, 10000)), (Fr(1, 100), Fr(29, 10000)), (Fr(1, 100), Fr(36, 10000)), (Fr(1, 100), Fr(1, 100)), (Fr(0), Fr(1, 100)),
              (Fr(-1, 100), Fr(1, 100)), (Fr(-1, 100), Fr(36, 10000)), (Fr(-1, 100), Fr(29, 10000)), (Fr(-1, 100), Fr(17, 10000)),
              (Fr(1, 1000), Fr(1, 10000)), (Fr(1, 1000), Fr(3, 10000)), (Fr(-1, 1000), Fr(3, 10000)), (Fr(-1, 1000), Fr(1, 10000))):
        z = (Q[0] + v[0], Q[1] + v[1])
        free, blocked = X.free_colours(z, wu, ["P", "G", "B", "M", "R", "O"])
        ang = math.degrees(math.atan2(float(v[1]), float(v[0])))
        print(f"   v = ({v[0]}, {v[1]}) at {ang:.2f} deg: free {free}")
    print(f"   the cone's edges: arcsin(1/4) = {math.degrees(math.asin(0.25)):.2f} deg, 180 - arcsin(1/4) = {180 - math.degrees(math.asin(0.25)):.2f} deg")


# =================================================================================== object 2
def colours_at(v, tiles):
    return sorted({t.colour for t in tiles if any(on_piece(v, pc) for pc in t.pieces)})


def on_piece(v, pc):
    if pc.kind == "S":
        return X._on_seg(v, pc)
    return (n2(vsub(v, pc.C)) - pc.rho * pc.rho).is0() and (X.is0v(vsub(v, pc.C)) is False) and pc.has_dir(vsub(v, pc.C))


def curves_at(v, tiles):
    """the boundary pieces having v as an end (each shared piece listed once), with each arc's centre."""
    out = []
    seen = []
    for t in tiles:
        for pc in t.pieces:
            if X.veq(pc.P, v) or X.veq(pc.Q, v):
                other = pc.Q if X.veq(pc.P, v) else pc.P
                if any(X.veq(other, o) and k == pc.kind for o, k in seen):
                    continue
                seen.append((other, pc.kind))
                out.append(pc)
    return out


def pent():
    Dk = O.Disk()
    tiles = Dk.tiles()
    p = Dk.p
    one = Dk.T(1)
    print("== object 2: PENT on the disk (Y2's labels), exact")
    for k in range(5):
        B, ZR, ZL1 = p("B", k), p("ZR", k), p("ZL", k + 1)
        A, C, A1, D1 = p("A", k), p("C", k), p("A", k + 1), p("D", k + 1)
        d1, d2 = n2(vsub(B, ZR)), n2(vsub(B, ZL1))
        uni = all((n2(vsub(x, y)) - one).is0() for x, y in ((B, A), (B, C), (ZR, A), (ZR, C), (B, A1), (B, D1), (ZL1, A1), (ZL1, D1)))
        distinct = all(not X.veq(x, y) for x, y in itertools.combinations([A, C, A1, D1], 2))
        rh1 = X.veq(ZR, vsub(vadd(A, C), B))
        rh2 = X.veq(ZL1, vsub(vadd(A1, D1), B))
        cb, czr, czl = colours_at(B, tiles), colours_at(ZR, tiles), colours_at(ZL1, tiles)
        curves = curves_at(B, tiles)
        cent = []
        for pc in curves:
            if pc.kind == "A" and (pc.rho - 1).is0():
                cent.append(pc.C)
        names = []
        for c in cent:
            nm = [f"{a}{j}" for (a, j), q in Dk.pts.items() if X.veq(q, c)]
            names.append(nm[0] if nm else str(X.fpt(c)))
        print(f"   k={k}: |B-Z^R|^2 = {float(d1):.6f} < 4: {(d1 - 4).sign() < 0}; |B-Z^L_(k+1)|^2 = {float(d2):.6f} < 4: {(d2 - 4).sign() < 0}; "
              f"the eight unit distances exact: {uni}; A_k, C_k, A_(k+1), D_(k+1) pairwise distinct: {distinct}; "
              f"Z^R_k = A_k + C_k - B_k: {rh1}; Z^L_(k+1) = A_(k+1) + D_(k+1) - B_k: {rh2}")
        print(f"        colours at B_k {cb}, at Z^R_k {czr}, at Z^L_(k+1) {czl}; complementary: {set(cb).isdisjoint(czr) and set(cb).isdisjoint(czl)}; "
              f"boundary curves at B_k: {len(curves)} ({', '.join(pc.kind for pc in curves)}), unit-arc centres {names}")
        lhs = vsub(vadd(A, A1), B)
        print(f"        A_k + A_(k+1) - B_k = A_(k+3): {X.veq(lhs, p('A', k + 3))}; colours at A_(k+3) {colours_at(p('A', k + 3), tiles)}")


# =================================================================================== object 3
def move():
    Dm = O.Disk(moved=True)
    tiles = Dm.tiles()
    R.check_finite(tiles, "moved disk (FS112-MOVE)")
    R.check_finite(tiles, "moved disk under closed_interval", plant="closed_interval")
    p = Dm.p
    C0 = p("C", 0)
    e72 = Dm.e(72)
    z0 = vadd(C0, vmul(Fr(1, 100), e72))
    cols = Dm.CS + ["red"]
    free, blocked = X.free_colours(z0, tiles, cols)
    print(f"== object 3: at z0 = C_0 + e(72)/100: free colours {free}; straddling tiles by colour: " +
          "; ".join(f"{c}: {', '.join(v)}" for c, v in sorted(blocked.items())))
    ZL, ZR, A0, B0 = p("ZL", 0), p("ZR", 0), p("A", 0), p("B", 0)
    T = Dm.T
    pts2 = [("A_0 + (9/10)(Z^L_0 - A_0)", vadd(A0, vmul(Fr(9, 10), vsub(ZL, A0)))),
            ("(Z^L_0 + Z^R_0)/2", vmul(Fr(1, 2), vadd(ZL, ZR))),
            ("A_0 + (1/2)(Z^L_0 - A_0) + (1/4)(Z^R_0 - A_0)", vadd(A0, vadd(vmul(Fr(1, 2), vsub(ZL, A0)), vmul(Fr(1, 4), vsub(ZR, A0))))),
            ("Z^R_0 + (-3/100, -1/100)", vadd(ZR, (T(Fr(-3, 100)), T(Fr(-1, 100))))),
            ("Z^L_0 + (1/100)(A_0 - Z^L_0)", vadd(ZL, vmul(Fr(1, 100), vsub(A0, ZL)))),
            ("A_0 + (99/100)(Z^R_0 - A_0) + (1/100)(Z^L_0 - A_0) - toward A_0", vadd(A0, vadd(vmul(Fr(97, 100), vsub(ZR, A0)), vmul(Fr(2, 100), vsub(ZL, A0)))))]
    t2 = [t for t in tiles if t.name == "T2_0"][0]
    t1 = [t for t in tiles if t.name == "T1_0"][0]
    for label, cut, pts in (("T2_0 (blue route)", t2, pts2),
                            ("T1_0 (orange route)", t1, [("B_0 + (1/20, 0)", vadd(B0, (T(Fr(1, 20)), T(0)))),
                                                         ("B_0 + (1/10)(10, -1)/10", vadd(B0, (T(Fr(1, 10)), T(Fr(-1, 100))))),
                                                         ("B_0 + (1/10)(10, 1)/10", vadd(B0, (T(Fr(1, 10)), T(Fr(1, 100))))),
                                                         ("B_0 + (1/5, 0)", vadd(B0, (T(Fr(1, 5)), T(0)))),
                                                         ("B_0 + (3/10, -1/50)", vadd(B0, (T(Fr(3, 10)), T(Fr(-1, 50)))))])):
        print(f"-- points of {label} inside B(C_0, 1), the cut tile ignored:")
        for nm, z in pts:
            ins = X.inside(z, cut)
            dC = n2(vsub(z, C0))
            fr, bl = X.free_colours(z, tiles, cols, ignore=(cut.name,))
            print(f"   {nm}: in {cut.name} (exact): {ins == 1}; |z - C_0|^2 = {float(dC):.6f} < 1: {(dC - 1).sign() < 0}; free {fr}; "
                  f"blocked: " + "; ".join(f"{c} by {', '.join(v)}" for c, v in sorted(bl.items())))


# =================================================================================== statements 4, 5 (the strip's straddle relation)
def straddle_strip():
    S = O.Strip()
    win = S.tiles(-6, 8)
    by = {t.name: t for t in win}
    names = [f"{x}{j}" for j in range(-3, 6) for x in "UDTB"]
    t0 = time.time()
    st = {}
    for a, b in itertools.combinations(names, 2):
        st[(a, b)] = st[(b, a)] = X.straddle_tiles(by[a], by[b])
    print(f"== the strip's straddle relation on columns -3..5 ({len(names)} tiles, {len(st) // 2} pairs, exact; {time.time() - t0:.1f} s)")

    def s(a, b):
        return st[(a, b)]
    for m in (0, 1, 2):
        six = [f"U{m - 1}", f"U{m}", f"T{m}", f"U{m + 1}", f"T{m + 1}", f"T{m + 2}"]
        k6 = all(s(a, b) for a, b in itertools.combinations(six, 2))
        low = [f"D{m - 1}", f"D{m}", f"B{m}", f"D{m + 1}", f"B{m + 1}", f"B{m + 2}"]
        k6l = all(s(a, b) for a, b in itertools.combinations(low, 2))
        print(f"   m={m}: {six} pairwise straddle: {k6}; mirror {low}: {k6l}")
        print(f"        U{m + 2}~T{m}: {s(f'U{m + 2}', f'T{m}')}; T{m + 3}~U{m - 1}: {s(f'T{m + 3}', f'U{m - 1}')}; "
              f"D{m + 2}~B{m}: {s(f'D{m + 2}', f'B{m}')}; U{m - 1}~U{m + 2}: {s(f'U{m - 1}', f'U{m + 2}')}; T{m}~T{m + 3}: {s(f'T{m}', f'T{m + 3}')}")
        print(f"        U{m}~D{m - 2}..D{m + 2}: {[s(f'U{m}', f'D{j}') for j in range(m - 2, m + 3)]}; U{m}~D{m + 3}: {s(f'U{m}', f'D{m + 3}')}; "
              f"T{m}~D{m - 1}, D{m}, D{m + 1}, D{m - 2}: {[s(f'T{m}', f'D{j}') for j in (m - 1, m, m + 1, m - 2)]}; "
              f"B{m}~U{m - 1}, U{m}, U{m + 1}, U{m - 2}: {[s(f'B{m}', f'U{j}') for j in (m - 1, m, m + 1, m - 2)]}")
    # statement 4's geometry at V_0 and A_1
    V0, A1, Q0, P1 = S.V(0), S.A(1), S.Q(0), S.P(1)
    one = S.T(1)
    print(f"   |V_0 - A_1|^2 = {float(n2(vsub(V0, A1))):.6f} < 4; |V_0 - Q_0|^2 = 1: {(n2(vsub(V0, Q0)) - one).is0()}; |A_1 - Q_0|^2 = 1: "
          f"{(n2(vsub(A1, Q0)) - one).is0()}; |V_0 - P_1|^2 = 1: {(n2(vsub(V0, P1)) - one).is0()}; |A_1 - P_1|^2 = 1: {(n2(vsub(A1, P1)) - one).is0()}")
    cv = curves_at(V0, win)
    print("   boundary curves at V_0: " + "; ".join(f"{pc.kind}" + (f" about {X.fpt(pc.C)}" if pc.kind == 'A' else '') for pc in cv) +
          f"; any on the unit circle about Q_0: {any(pc.kind == 'A' and X.veq(pc.C, Q0) for pc in cv)}")
    cva = curves_at(A1, win)
    print("   boundary curves at A_1: " + "; ".join(f"{pc.kind}" + (f" about {X.fpt(pc.C)}" if pc.kind == 'A' else '') for pc in cva))


# =================================================================================== statement 6 (the disk's straddle relation)
def straddle_disk():
    Dk = O.Disk()
    tiles = Dk.tiles()
    by = {t.name: t for t in tiles}
    t0 = time.time()
    st = {}
    for a, b in itertools.combinations(tiles, 2):
        st[(a.name, b.name)] = st[(b.name, a.name)] = X.straddle_tiles(a, b)
    print(f"== the disk's straddle relation: {len(st) // 2} pairs, exact; {time.time() - t0:.1f} s")
    k6 = ["C0"] + [f"T1_{k}" for k in range(5)]
    print(f"   the six-clique {k6} pairwise straddle: {all(st[(a, b)] for a, b in itertools.combinations(k6, 2))}")
    for t in tiles:
        if t.name in k6:
            continue
        miss = [c for c in k6 if not st[(t.name, c)]]
        print(f"   {t.name} ({t.colour}) does not straddle: {miss}")
    # forced-colour propagation from the clique (labels 0..5 = the clique's colours), each step printed
    lab = {c: i for i, c in enumerate(k6)}
    step = 0
    changed = True
    while changed:
        changed = False
        for t in tiles:
            if t.name in lab:
                continue
            used = {lab[u] for u in lab if st[(t.name, u)]}
            allowed = [i for i in range(6) if i not in used]
            if len(allowed) == 1:
                step += 1
                why = sorted(u for u in lab if st[(t.name, u)])
                lab[t.name] = allowed[0]
                print(f"   step {step}: {t.name} gets the colour of {k6[allowed[0]]} (it straddles {why})")
                changed = True
            elif not allowed:
                print(f"   {t.name}: NO colour allowed -- the geometry has no valid colouring")
    left = [t.name for t in tiles if t.name not in lab]
    print(f"   determined: {len(lab)} of {len(tiles)}; undetermined: {left}")
    ref = {t.name: t.colour for t in tiles}
    agree = all((ref[a] == ref[b]) == (lab[a] == lab[b]) for a, b in itertools.combinations(lab, 2))
    print(f"   the forced colouring equals the printed one up to a permutation (same-colour classes identical): {agree}")
    for k in range(5):
        b = [f"T1_{k}", f"U_{k}", f"U'_{k}"]
        zr = [f"T2_{k}", f"R_{k}", f"U'_{(k - 1) % 5}"]
        zl = [f"T2_{(k + 1) % 5}", f"R_{(k + 1) % 5}", f"U_{(k + 1) % 5}"]
        k6r = all(st[(x, y)] for x, y in itertools.combinations(b + zr, 2))
        k6l = all(st[(x, y)] for x, y in itertools.combinations(b + zl, 2))
        print(f"   local six-cliques at B_{k}: tiles of B_k and Z^R_k {b + zr}: {k6r}; of B_k and Z^L_(k+1) {b + zl}: {k6l}")


# =================================================================================== C114-RAINBOW's third case
def rainbow():
    T = X.Tower.base()

    def P(x, y):
        return (T(Fr(x)), T(Fr(y)))
    p1, p2 = P(0, 0), P(1, 0)
    top, bot = P(Fr(1, 2), Fr(1, 10)), P(Fr(1, 2), Fr(-1, 10))
    L, Rr = Fr(-1, 5), Fr(6, 5)
    H = Fr(7, 10)
    tiles = [Tile("x", 1, O.poly([p1, bot, p2, top])),
             Tile("n1", 2, O.poly([p1, P(L, Fr(1, 5)), P(L, Fr(-1, 5))])),
             Tile("n2", 2, O.poly([p2, P(Rr, Fr(-1, 5)), P(Rr, Fr(1, 5))])),
             Tile("y1", 3, O.poly([p1, top, P(Fr(1, 2), H), P(L, H), P(L, Fr(1, 5))])),
             Tile("y2", 4, O.poly([p2, P(Rr, Fr(1, 5)), P(Rr, H), P(Fr(1, 2), H), top])),
             Tile("z1", 5, O.poly([p1, P(L, Fr(-1, 5)), P(L, -H), P(Fr(1, 2), -H), bot])),
             Tile("z2", 6, O.poly([p2, bot, P(Fr(1, 2), -H), P(Rr, -H), P(Rr, Fr(-1, 5))]))]
    print("== C114-RAINBOW's third case: a valid fragment on the closed disc of radius 3/5 about (1/2, 0) (it covers [-1/5, 6/5] x [-7/10, 7/10])")
    bad, unm = X.consistency(tiles, open_ok=lambda pc: True)
    area = sum(t.area_float() for t in tiles)
    print(f"   float guard: areas sum to {area:.9f} against the rectangle's {1.4 * 1.4:.9f}")
    R.check_finite(tiles, "the fragment", show=True)
    x, n1, n2_ = tiles[0], tiles[1], tiles[2]
    zero, onex = T(0), T(1)
    xs = [pc.P[0] for pc in x.pieces]
    n1s = [pc.P[0] for pc in n1.pieces]
    n2s = [pc.P[0] for pc in n2_.pieces]
    print(f"   x's corners have abscissae in [0, 1], only (0,0) at 0 and only (1,0) at 1: "
          f"{all(v.sign() >= 0 and (v - 1).sign() <= 0 for v in xs) and sum(v.is0() for v in xs) == 1 and sum((v - 1).is0() for v in xs) == 1}; "
          f"n1's corners at abscissa <= 0, only (0,0) at 0: {all(v.sign() <= 0 for v in n1s) and sum(v.is0() for v in n1s) == 1}; "
          f"n2's at >= 1, only (1,0) at 1: {all((v - 1).sign() >= 0 for v in n2s) and sum((v - 1).is0() for v in n2s) == 1}  "
          f"(all three convex polygons, so cl n1 meets cl x exactly at (0,0) and cl n2 exactly at (1,0))")
    _ = (zero, onex)
    r = X.pair(x, x)
    print(f"   x's diameter is exactly 1: {r.max_eq1}; n1, n2 at minimum distance exactly 1: {X.pair(n1, n2_).min_eq1}; "
          f"no piece of the fragment is an arc (no unit arc anywhere)")


def main(what):
    {"capped": capped, "pent": pent, "move": move, "straddle-strip": straddle_strip, "straddle-disk": straddle_disk, "rainbow": rainbow}[what]()
