#!/usr/bin/env python3
"""FS112-Y2 stage 3 (housekeeping, round 2): exact checks, each seconds long, on objects given by formula.

Sections (python3 tools/fs112_y2_house.py [section ...]; default all; exit 1 on any mismatch):
  brick  -- D3: FS112-Y's checker (tools/fs112_y_check.py, imported, never edited) on the claim list's CAL-7, row 33's brick
            seven-colouring (cells 4/5 x 3/5, shear 2/5, colour (i + 3j) mod 7), built by FS112-YB's own builder
            (tools/fs112_yb_calib.py, imported, never edited), with YB's two plants and the closed_interval tightness plant;
            every pair's verdict compared with FS112-YB's checker (tools/fs112_yb_check.py) on the same pair.
  ystrip -- D4 on the strip: FS112-Y's strip object (fs112_y_check.strip) converted exactly into FS112-YB's multiquadratic field and
            put through YB's checker (exact meeting test, no map hypothesis): the same pairs, the same verdicts.
  arcs   -- D6: the unit-arc count.  Y read arcs of tiles in columns -1..4 and kept an arc only when both its tiles were in that window;
            here every arc of an arch in columns -1..4 is read with the outer tiles taken from columns -1..5.
  x4     -- card X, X4: at a valley W and an apex A_1 of the strip (exact), the covering pair of midline vertices whose common unit point
            it is; for each of the four unit tangent directions at the seam point, is it the start of an arc of Gamma on that circle, or
            inside a tile whose colour belongs only to the other point (the Q-rule's (S2) wording, data/fs112/claims.md §1)?
  x2     -- card X, X2: the unit circles about the strip's unit-arc end vertices (valleys, apexes) against the top edge: exact topmost
            height, and the exact points where each circle crosses the edge line.
Planted faults (--plant): 'x4_wrongpair' asks X4 at W for the pair (P_1, P_2) (not W's pair; must fail), 'arcs_window' reproduces Y's
window (must give 22, not 24).
"""
from __future__ import annotations
import sys, os
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402  (FS112-Y's checker: run, never edited)
import fs112_yb_check as K         # noqa: E402  (FS112-YB's checker: run, never edited)
import fs112_yb_calib as KC        # noqa: E402  (FS112-YB's calibration builders: run, never edited)

OK = True
PLANT = None


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg)


# ------------------------------------------------------------------ conversions between the two checkers' fields
FQ = Y.Field([Fr(3), (Fr(5), Fr(0))], names=["3", "5"])     # Q(sqrt3)(sqrt5), the strip's tower
F0 = Y.Field([Fr(3)], names=["3"])


def yb_to_y(x, Fd=FQ):
    """YB's F (masks over sqrt2, sqrt3, sqrt5 only 0, sqrt3, sqrt5, sqrt15 allowed) -> Y's tower element."""
    x = K.F.of(x)
    allowed = {0: (0, 0), 2: (1, 0), 4: (0, 1), 6: (1, 1)}
    a = {k: Fr(0) for k in allowed}
    for m, c in x.c.items():
        assert m in allowed, f"basis element outside Q(sqrt3, sqrt5): mask {m}"
        a[m] = c
    if Fd is F0:
        assert a[4] == 0 and a[6] == 0
        return F0.embed(1, (a[0], a[2]))
    return Fd.embed(2, ((a[0], a[2]), (a[4], a[6])))


def y_to_yb(n):
    """Y's element of Q(sqrt3)(sqrt5) -> YB's F."""
    (a0, a1), (b0, b1) = n.v if n.F.K == 2 else ((n.v[0], n.v[1]), (Fr(0), Fr(0)))
    return K.F({0: a0, 2: a1, 4: b0, 6: b1})


def prim_yb_to_y(p, Fd):
    pt = lambda q: (yb_to_y(q[0], Fd), yb_to_y(q[1], Fd))
    if isinstance(p, K.Seg):
        return Y.Seg(pt(p.P), pt(p.Q))
    return Y.Arc(pt(p.C), yb_to_y(p.r, Fd), pt(p.S), pt(p.E))


def prim_y_to_yb(p):
    pt = lambda q: (y_to_yb(q[0]), y_to_yb(q[1]))
    if isinstance(p, Y.Seg):
        return K.Seg(pt(p.P), pt(p.Q))
    return K.Arc(pt(p.C), y_to_yb(p.r), pt(p.S), pt(p.E))


# ------------------------------------------------------------------ D3: the brick through Y's checker
def brick_case(coef=3, w=Fr(4, 5), h=Fr(3, 5), s=Fr(2, 5), N=4):
    col = lambda i, j: (i + coef * j) % 7
    names = [("c0,0", 0, 0)] + [(f"c{i},{j}", i, j) for i in range(-N, N + 1) for j in range(-N, N + 1)
                                if (i, j) != (0, 0) and col(i, j) == 0]
    Tk = {nm: (0, KC.brick(i, j, w, h, s)) for nm, i, j in names}
    Ty = {nm: (0, [prim_yb_to_y(p, F0) for p in prims]) for nm, (c, prims) in Tk.items()}
    pairs = [("c0,0", "c0,0")] + [("c0,0", nm) for nm, _, _ in names[1:]]
    vy = {pr: Y.pair_verdict(Ty[pr[0]][1], Ty[pr[1]][1], self_pair=(pr[0] == pr[1])) for pr in pairs}
    vk = {pr: K.pair_verdict(Tk[pr[0]][1], Tk[pr[1]][1], self_pair=(pr[0] == pr[1])).verdict for pr in pairs}
    return pairs, vy, vk


def brick():
    print("== D3: CAL-7 (row 33's brick) through FS112-Y's checker; every pair against FS112-YB's")
    for lab, kw, want in [("CAL-7 brick 4/5 x 3/5, shear 2/5, (i+3j) mod 7", {}, "ACCEPT"),
                          ("plant: colour (i+2j) mod 7", {"coef": 2}, "REJECT"),
                          ("plant: cell 81/100 x 3/5 (diagonal > 1)", {"w": Fr(81, 100)}, "REJECT")]:
        pairs, vy, vk = brick_case(**kw)
        v = "REJECT" if any(x == "REJECT" for x in vy.values()) else "ACCEPT"
        bad = sorted(p[1] for p in pairs if vy[p] == "REJECT")
        diff = [p for p in pairs if vy[p] != vk[p]]
        say(v == want and not diff, f"{lab:48s} pairs examined {len(pairs)} (cell (0,0) with itself and every same-colour cell |i|,|j| <= 4); "
                                    f"Y's verdict {v} (want {want}); REJECT at {bad}; disagreements with YB pair by pair: {diff}")
    Y.PLANT, K.PLANT = "closed_interval", "closed_interval"
    pairs, vy, vk = brick_case()
    Y.PLANT, K.PLANT = None, None
    rej = sorted(p[1] for p in pairs if vy[p] == "REJECT")
    diff = [p for p in pairs if vy[p] != vk[p]]
    say(len(rej) == 3 and not diff, f"CAL-7 under closed_interval (tightness): exact contacts at 1 at {rej} (want 3: the diagonal and "
                                    f"the cells (+-1, -+2)... as YB reports); disagreements {diff}")


# ------------------------------------------------------------------ D4 on the strip: Y's object through YB's checker
def ystrip():
    print("== D4 on the strip: FS112-Y's strip object through FS112-YB's checker (exact meeting test, no map hypothesis)")
    F, T, top = Y.strip(-4, 7)
    pairs = Y.strip_pairs(T)
    Tk = {nm: (c, [prim_y_to_yb(p) for p in prims]) for nm, (c, prims) in T.items()}
    vy = {pr: Y.pair_verdict(T[pr[0]][1], T[pr[1]][1], self_pair=(pr[0] == pr[1])) for pr in pairs}
    rk = {pr: K.pair_verdict(Tk[pr[0]][1], Tk[pr[1]][1], self_pair=(pr[0] == pr[1])) for pr in pairs}
    diff = [p for p in pairs if vy[p] != rk[p].verdict]
    touching = [p for p in pairs if p[0] != p[1] and rk[p].touch]
    ncont = sum(1 for p in pairs if rk[p].contacts)
    say(not diff and all(v == "ACCEPT" for v in vy.values()),
        f"strip, {len(pairs)} ordered same-colour pairs: Y ACCEPT on all, YB ACCEPT on all; disagreements {diff}; "
        f"distinct same-colour tiles that meet (YB's exact meeting test): {len(touching)}; pairs with an exact contact at 1: {ncont}")


# ------------------------------------------------------------------ D6: the arc count
def arcs():
    print("== D6: the strip's unit arcs in columns -1..4, every one read with both its tiles")
    F, T, top = Y.strip(-2, 6)
    lo, hi_outer = -1, (4 if PLANT == "arcs_window" else 5)
    arcs = {}
    for nm, (c, prims) in T.items():
        j = int(nm[1:])
        if not (lo <= j <= hi_outer):
            continue
        for p in prims:
            if isinstance(p, Y.Arc) and p.r == 1:
                k = (Y.pkey(p.C), frozenset([Y.pkey(p.S), Y.pkey(p.E)]))
                arcs.setdefault(k, []).append((nm, c, p))
    # an arc belongs to the window when its ARCH (A or B tile) is in columns -1..4
    inwin = {k: v for k, v in arcs.items() if any(nm[0] in "AB" and -1 <= int(nm[1:]) <= 4 for nm, _, _ in v)}
    both = [k for k, v in inwin.items() if len(v) == 2]
    half = [k for k, v in inwin.items() if len(v) != 2]
    kinds = set()
    for k in both:
        lst = inwin[k]
        Cn = lst[0][2].C
        Pcl = Y.closure_type(T, Cn)
        inner = [(nm, c) for nm, c, _ in lst if c in Y.closure_type({nm: T[nm]}, Cn)]
        outer = [(nm, c) for nm, c, _ in lst if (nm, c) not in inner]
        kinds.add(("both" if (inner[0][1] in Pcl and outer[0][1] in Pcl) else "other", len(Pcl)))
    want = 22 if PLANT == "arcs_window" else 24
    say(len(both) == want, f"arcs of arches in columns -1..4: {len(inwin)}; read with both tiles: {len(both)} (want {want}); "
                           f"missing an outer tile: {len(half)} {[sorted(nm for nm, _, _ in inwin[k]) for k in half]}; kinds {sorted(kinds)}")


# ------------------------------------------------------------------ X4: the (S2)-with-arcs pattern at valleys and apexes
def strip_membership(F, top):
    """exact tile predicates of the strip (the printed rule): arch A_j = {x_j <= x <= x_{j+1}, y > 0, |p - P_j| < 1, |p - P_{j+1}| < 1};
    top tile C_j = {|x - x_j| < 1/4, 0 < y < top, |p - P_{j-1}| > 1, |p - P_{j+1}| > 1}; B_j, D_j their mirrors.  Interior points only."""
    def P(j): return (F(Fr(j, 2)), F(0))
    def d2(p, q): return (p[0] - q[0]) * (p[0] - q[0]) + (p[1] - q[1]) * (p[1] - q[1])
    def which(p):
        x, y = p
        if y == 0:
            return None
        s = 1 if y > 0 else -1
        q = (x, y * s)
        hits = []
        for j in range(-6, 10):
            xj, xj1 = F(Fr(j, 2)), F(Fr(j + 1, 2))
            if xj < q[0] < xj1 and d2(q, P(j)) < 1 and d2(q, P(j + 1)) < 1:
                hits.append(("A" if s > 0 else "B") + str(j))
            if (q[0] - F(Fr(j, 2)) < Fr(1, 4)) and (F(Fr(j, 2)) - q[0] < Fr(1, 4)) and q[1] < top and d2(q, P(j - 1)) > 1 and d2(q, P(j + 1)) > 1:
                hits.append(("C" if s > 0 else "D") + str(j))
        return hits
    return which


def x4():
    print("== X4: the strip's close covering pairs of midline vertices, read at their common unit points (the Q-rule's (S2) with arcs)")
    F, T, top = Y.strip(-4, 8)
    which = strip_membership(F, top)
    r3, r5 = F.gen(1), F.gen(2)
    def P(j): return (F(Fr(j, 2)), F(0))
    eps = Fr(1, 1000)
    cases = [("valley W = (1, sqrt3/2)", (F(1), r3 / 2), 1, 3), ("apex A_1 = (3/4, sqrt15/4)", (F(Fr(3, 4)), r3 * r5 / 4), 1, 2),
             ("mirror valley W' = (1, -sqrt3/2)", (F(1), -r3 / 2), 1, 3), ("mirror apex A'_1 = (3/4, -sqrt15/4)", (F(Fr(3, 4)), -r3 * r5 / 4), 1, 2)]
    if PLANT == "x4_wrongpair":
        cases = [("PLANT: W with the pair (P_1, P_2)", (F(1), r3 / 2), 1, 2)]
    for lab, w0, iu, iv in cases:
        u, v = P(iu), P(iv)
        on = lambda x: Y.n2(Y.sub(w0, x)) == 1
        pcu, pcv, pcw = Y.closure_type(T, u), Y.closure_type(T, v), Y.closure_type(T, w0)
        cover = (pcu | pcv) == {1, 2, 3, 4, 5, 6}
        rows, good = [], on(u) and on(v) and cover
        for x, xname, other in [(u, f"P_{iu}", pcv), (v, f"P_{iv}", pcu)]:
            mine = Y.closure_type(T, x)
            rad = Y.sub(w0, x)
            for sgn in (1, -1):
                t = (-rad[1] * sgn, rad[0] * sgn)              # a unit tangent of omega(x) at w0 (|rad| = 1)
                # an arc of Gamma on omega(x) starting at w0 in direction t: an Arc primitive with centre x, an endpoint w0, the other end on the t side
                arc = False
                for nm, (c, prims) in T.items():
                    for p in prims:
                        if isinstance(p, Y.Arc) and Y.is0(Y.sub(p.C, x)) and p.r == 1:
                            ends = p.ends()
                            for a, b in [(ends[0], ends[1]), (ends[1], ends[0])]:
                                if Y.is0(Y.sub(a, w0)) and Y.dot(Y.sub(b, w0), t) > 0:
                                    arc = True
                q = Y.add(w0, Y.mul(F(eps), t))
                hits = which(q)
                if arc:
                    rows.append(f"omega({xname}) dir {'+' if sgn > 0 else '-'}: an arc of Gamma starts at the seam")
                    continue
                cols = {T[h][0] for h in hits} if hits and all(h in T for h in hits) else set()
                only_other = len(hits) == 1 and cols and all((cc in other and cc not in mine) for cc in cols)
                good &= only_other
                rows.append(f"omega({xname}) dir {'+' if sgn > 0 else '-'}: inside {hits} colour {sorted(cols)}"
                            f" -> {'only the other point''s colour' if only_other else 'NOT only the other point''s'}")
        # every tile at w0 lies on one side of omega(x) for each x holding its colour (checked at the tile's sample point)
        want_ok = PLANT != "x4_wrongpair"
        say(good == want_ok, f"{lab}: pair (P_{iu}, P_{iv}) |P_{iu}P_{iv}| = {abs(iu - iv)}/2, types {sorted(pcu)} {sorted(pcv)} covering={cover}; "
                             f"P_cl(seam) = {sorted(pcw)}; both at distance 1: {on(u) and on(v)}; " + "; ".join(rows))


# ------------------------------------------------------------------ X2: circles about the unit-arc end vertices against the top edge
def x2():
    print("== X2: the unit circles about the strip's unit-arc end vertices, against the top edge y = top")
    F, T, top = Y.strip(-2, 6)
    r3, r5 = F.gen(1), F.gen(2)
    for lab, c in [("valley V_0 = (0, sqrt3/2)", (F(0), r3 / 2)), ("apex A_0 = (1/4, sqrt15/4)", (F(Fr(1, 4)), r3 * r5 / 4))]:
        over = c[1] + 1 - top
        dy = top - c[1]
        dx2 = 1 - dy * dy                              # crossing points (c_x +- sqrt(dx2), top)
        # is dx2 a rational square?  report exactly
        dxq = None
        for cand in (Fr(1, 4), Fr(1, 2), Fr(3, 4), Fr(1)):
            if dx2 == cand * cand:
                dxq = cand
        xs = (c[0] - dxq, c[0] + dxq) if dxq is not None else None
        pts = [(xx, top) for xx in xs] if xs else []
        types = [sorted(Y.closure_type(T, p)) for p in pts]
        say(over > 0 and dxq is not None, f"{lab}: omega reaches top + {over} (exact, > 0: leaves the strip); crosses y = top at x = "
                                          f"{xs} (c_x -+ {dxq}) -- P_cl there {types} (edge vertices: two colours each)")
    # the midline vertices' circles stay inside
    mid = (F(Fr(1, 2)), F(0))
    say(mid[1] + 1 < top, f"midline P_1: omega reaches height 1 < top = {top}: wholly inside the strip")


SECTIONS = {"brick": brick, "ystrip": ystrip, "arcs": arcs, "x4": x4, "x2": x2}

if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
        args = [a for a in args if a != PLANT]
    for s in (args or list(SECTIONS)):
        SECTIONS[s]()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
