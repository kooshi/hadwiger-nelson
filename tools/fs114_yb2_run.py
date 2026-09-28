#!/usr/bin/env python3
"""FS114-YB2 drivers: the checker's self-test and plants, calibration on five held objects, and my own Reuleaux-bowtie fragment.

Run: python3 tools/fs114_yb2_run.py selftest | calib | bowtie [--plant NAME] | plants
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb2_exact as X   # noqa: E402

Seg, Arc, arc, sub, add, smul, nn, dot, crs, same, fp = X.Seg, X.Arc, X.arc, X.sub, X.add, X.smul, X.nn, X.dot, X.crs, X.same, X.fp

T3 = X.Tw().ext(3, "3")
s3 = T3.root(1)


def n(x):
    return T3.num(x)


def P(x, y):
    return (T3.num(x), T3.num(y))


def poly(*v):
    return [Seg(v[i], v[(i + 1) % len(v)]) for i in range(len(v))]


# ================================================================== self-test
def selftest():
    ok = True

    def expect(label, got, want):
        nonlocal ok
        flag = "ok" if got == want else "FAIL"
        if got != want:
            ok = False
        print(f"  [{flag}] {label}: {got} (expected {want})")

    print("arithmetic")
    expect("1.732 < sqrt3 < 1.7321", (s3 > Fr(1732, 1000)) and (s3 < Fr(17321, 10000)), True)
    expect("sqrt3^2 = 3", s3 * s3 == 3, True)
    expect("(1 + sqrt3) * inv = 1", (1 + s3) * (1 + s3).inv() == 1, True)
    T2 = T3.ext(2 + s3, "2+sqrt3")
    r = T2.root(2)
    expect("sqrt(2+sqrt3)^2 = 2 + sqrt3", r * r == T2.num(2) + T2.num(s3), True)
    expect("sqrt(2+sqrt3) = (sqrt3 + 1)/sqrt2 < 1.9319", r < Fr(19319, 10000), True)
    expect("sqrt(2+sqrt3) > 1.9318", r > Fr(19318, 10000), True)
    expect("sign(3 - 2 sqrt(2+sqrt3)) < 0", (3 - 2 * r).sign(), -1)
    expect("cmp |sqrt(4) - 3| vs 1 (=1)", X.cmp_abs(n(4), n(-3)), 0)
    expect("cmp |sqrt(3) + 0| vs 1 (>1)", X.cmp_abs(n(3), n(0)), 1)
    expect("cmp |sqrt(3) - 1| vs 1 (<1)", X.cmp_abs(n(3), n(-1)), -1)
    expect("cmp |sqrt(0) - 3/2| vs 1 (>1)", X.cmp_abs(n(0), n(Fr(-3, 2))), 1)

    print("controls (verdict of every same-colour pair)")
    objs = controls()
    for label, tiles, want in objs:
        rej, npairs, tight, nsf = X.check(tiles, log=lambda *_: None)
        got = sorted(rej)
        expect(f"{label}: rejected pairs of {npairs}", got, want)
    print("points")
    reu = reuleaux(P(0, 0), P(1, 0), (n(Fr(1, 2)), s3 / 2))
    expect("centroid inside the Reuleaux triangle", X.inside((n(Fr(1, 2)), s3 / 6), reu), True)
    expect("(1/2, -1/10) inside the lower bulge", X.inside((n(Fr(1, 2)), n(Fr(-1, 10))), reu), True)
    expect("(1/2, -14/100) outside the lower bulge", X.inside((n(Fr(1, 2)), n(Fr(-14, 100))), reu), False)
    expect("(1/2, 0.9) outside", X.inside((n(Fr(1, 2)), n(Fr(9, 10))), reu), False)
    expect("(3/2, 1/2) straddled by the triangle", X.pt_minmax(P(Fr(3, 2), Fr(1, 2)), reu), (-1, 1))
    expect("(0, -1) straddled (the corner's cone is [-30, 90])", X.pt_minmax(P(0, -1), reu), (-1, 1))
    expect("(-1, 0) at min exactly 1 (normal cone of the corner)", X.pt_minmax(P(-1, 0), reu)[0], 0)
    return ok


def reuleaux(a, b, c):
    one = n(1)
    return [arc(c, one, a, b), arc(a, one, b, c), arc(b, one, c, a)]


def controls():
    """(label, tiles, the rejected pairs predicted before the run, with no plant)."""
    out = []
    reu = reuleaux(P(0, 0), P(1, 0), (n(Fr(1, 2)), s3 / 2))
    out.append(("reuleaux", {"R": (1, reu)}, []))
    out.append(("rect 3/5x4/5", {"R": (1, poly(P(0, 0), P(Fr(3, 5), 0), P(Fr(3, 5), Fr(4, 5)), P(0, Fr(4, 5))))}, []))
    out.append(("rect 3/5x81/100", {"R": (1, poly(P(0, 0), P(Fr(3, 5), 0), P(Fr(3, 5), Fr(81, 100)), P(0, Fr(81, 100))))}, [("R", "R")]))
    sq = lambda x0: poly(P(x0, 0), P(x0 + Fr(1, 10), 0), P(x0 + Fr(1, 10), Fr(1, 10)), P(x0, Fr(1, 10)))
    out.append(("squares gap 1", {"a": (1, sq(Fr(0))), "b": (1, sq(Fr(11, 10)))}, []))
    out.append(("squares gap 9/10", {"a": (1, sq(Fr(0))), "b": (1, sq(Fr(1)))}, [("a", "b")]))
    h, t = Fr(3, 2), Fr(1, 200)
    out.append(("crossing bars", {"a": (1, poly(P(-h, -t), P(h, -t), P(h, t), P(-h, t))),
                                  "b": (1, poly(P(-t, -h), P(t, -h), P(t, h), P(-t, h)))}, [("a", "a"), ("a", "b"), ("b", "b")]))
    C = P(0, Fr(19, 10))
    S, E = add(C, (n(Fr(-1, 2)), -s3 / 2)), add(C, (n(Fr(1, 2)), -s3 / 2))
    cap = [arc(C, n(1), S, E), Seg(E, S)]
    bar = poly(P(-2, Fr(-1, 10)), P(2, Fr(-1, 10)), P(2, 0), P(-2, 0))
    out.append(("cap over bar", {"cap": (1, cap), "bar": (1, bar)}, [("bar", "bar"), ("bar", "cap")]))
    Ca, Cb = P(0, Fr(29, 20)), P(0, Fr(-29, 20))
    Sa, Ea = add(Ca, (n(Fr(-1, 2)), -s3 / 2)), add(Ca, (n(Fr(1, 2)), -s3 / 2))
    Sb, Eb = add(Cb, (n(Fr(1, 2)), s3 / 2)), add(Cb, (n(Fr(-1, 2)), s3 / 2))
    out.append(("cap over cap", {"a": (1, [arc(Ca, n(1), Sa, Ea), Seg(Ea, Sa)]), "b": (1, [arc(Cb, n(1), Sb, Eb), Seg(Eb, Sb)])},
                [("a", "b")]))
    return out


PLANT_PRED = {   # the controls whose verdict each plant flips, written before the first run
    "noself": {"rect 3/5x81/100", "crossing bars", "cap over bar"},
    "closed": {"reuleaux", "rect 3/5x4/5", "squares gap 1", "cap over bar", "cap over cap"},
    "nocross": {"crossing bars"},
    "endsonly": {"cap over bar", "cap over cap"},
    "nointerior": {"cap over bar", "cap over cap"},
}


def plants():
    base = {lab: sorted(X.check(t, log=lambda *_: None)[0]) for lab, t, _ in controls()}
    allok = True
    for pl, pred in PLANT_PRED.items():
        X.PLANT.clear()
        X.PLANT.add(pl)
        flipped = {lab for lab, t, _ in controls() if sorted(X.check(t, log=lambda *_: None)[0]) != base[lab]}
        X.PLANT.clear()
        ok = flipped == pred
        allok &= ok
        print(f"  plant {pl}: flips {sorted(flipped)} (predicted {sorted(pred)}) {'ok' if ok else 'FAIL'}")
    return allok


# ================================================================== reflections and the bowtie
def refl_pt(f, x):
    return f(x)


def refl_tile(ps, f):
    out = []
    for pc in reversed(ps):
        st, en = X.dse(pc)
        if pc.kind == "S":
            out.append(Seg(f(en), f(st)))
        else:
            out.append(arc(f(pc.C), pc.rho, f(en), f(st), ccw=getattr(pc, "fwd", True)))
    return out


MX = lambda x: (-x[0], x[1])
MY = lambda x: (x[0], -x[1])
CMX = {1: 3, 3: 1, 2: 2, 4: 4, 5: 6, 6: 5}
CMY = {1: 1, 3: 3, 2: 4, 4: 2, 5: 6, 6: 5}


class Bowtie:
    """My Reuleaux bowtie (D2-symmetric, over Q(sqrt3)).  p = 0; q1 = e(30), q2 = e(-30), qC = e(150), qD = e(210); top = (0, 1).
    t1 = Reuleaux(p, q1, q2) colour 1, t3 its mirror colour 3; t2 the tile above p (the lens between omega(q1) and omega(qC) from p to top, plus
    the horns of U below the segments AB and A'B', A = ((sqrt3-1)/2)(1, 1) on omega(q2), B = (1 - sqrt3/2, 1/2) on omega(qC)), t4 its mirror.
    X (colour 5): U above AB and the part of the vesica of q1, top outside omega(p); V (3): the part of the vesica of q1, q2 outside omega(p);
    T1 (colour 4) and Z (6): the wedge at q1 between omega(q2) (from q1) and omega(top) (from q1), split by the radial segment q1 -> F2;
    Ttop (4): the wedge at top between omega(q1) and omega(qC).  Outer boundary: the polygon OUT, F1, F2, F3, FM, F4, F4' and images."""

    def __init__(self, plant=None):
        one = n(1)
        self.one = one
        h = Fr(1, 2)
        self.p = P(0, 0)
        self.q1, self.q2 = (s3 / 2, n(h)), (s3 / 2, n(-h))
        self.qC, self.qD = (-s3 / 2, n(h)), (-s3 / 2, n(-h))
        self.top, self.bot = P(0, 1), P(0, -1)
        # the cut: A on omega(q2) and B on omega(qC), both on the line <x, e(60)> = c, B the image of A in the 60-degree line;
        # A = c e60 + (w - 1) e150, B = c e60 + (1 - w) e150 with w = sqrt(1 - c^2) (derived: |c e60 + s e150 - q2|^2 = 1 + c^2 + 2s + s^2).
        c, w = (n(h), s3 / 2) if plant != "cut_low" else (n(Fr(5, 13)), n(Fr(12, 13)))
        e60, e150 = (n(h), s3 / 2), (-s3 / 2, n(h))
        self.A = add(smul(c, e60), smul(w - 1, e150))
        self.B = add(smul(c, e60), smul(1 - w, e150))
        assert nn(sub(self.A, self.q2)) == 1 and nn(sub(self.B, self.qC)) == 1
        self.F1 = add(self.q2, P(Fr(40, 401), Fr(399, 401)))
        self.F2 = (s3 * Fr(11, 20), n(Fr(11, 20)))
        self.F3 = ((s3 * 399 + 40) / 802, (s3 * 40 + 403) / 802)
        self.FM = (n(Fr(11, 20)), s3 * Fr(11, 20))
        self.F4 = ((s3 + 20) / 401, (s3 * 20 + 400) / 401)
        self.OUT = P(Fr(11, 10), 0)
        self.plant = plant

    def tiles(self):
        p, q1, q2, qC, qD, top = self.p, self.q1, self.q2, self.qC, self.qD, self.top
        A, B, one = self.A, self.B, self.one
        Ay, Bp, Ap = MY(A), MX(B), MX(A)
        F1, F2, F3, FM, F4, OUT = self.F1, self.F2, self.F3, self.FM, self.F4, self.OUT
        F1y, F4p = MY(F1), MX(F4)
        base = {}
        base["t1"] = (1, [arc(q1, one, p, Ay), arc(q1, one, Ay, q2), arc(p, one, q2, q1), arc(q2, one, q1, A), arc(q2, one, A, p)])
        base["t2"] = (2, [arc(q2, one, p, A, ccw=False), Seg(A, B), arc(qC, one, B, top), arc(q1, one, top, Bp), Seg(Bp, Ap),
                          arc(qD, one, Ap, p, ccw=False)])
        base["X"] = (5, [arc(q2, one, A, q1, ccw=False), arc(top, one, q1, F3), Seg(F3, FM), Seg(FM, F4), arc(q1, one, F4, top),
                         arc(qC, one, top, B, ccw=False), Seg(B, A)])
        base["V"] = (3, [arc(q1, one, q2, F1y), Seg(F1y, OUT), Seg(OUT, F1), arc(q2, one, F1, q1), arc(p, one, q1, q2, ccw=False)])
        base["T1"] = (4, [arc(q2, one, q1, F1, ccw=False), Seg(F1, F2), Seg(F2, q1)])
        base["Z"] = (6, [Seg(q1, F2), Seg(F2, F3), arc(top, one, F3, q1, ccw=False)])
        base["Ttop"] = (4, [arc(q1, one, top, F4, ccw=False), Seg(F4, F4p), arc(qC, one, F4p, top, ccw=False)])
        if self.plant == "wedge_swap":
            base["T1"] = (6, base["T1"][1])
            base["Z"] = (4, base["Z"][1])
        if self.plant == "ttop_six":
            base["Ttop"] = (6, base["Ttop"][1])
        t = {}
        orbit = {"t1": ["", "x"], "t2": ["", "y"], "X": ["", "x", "y", "xy"], "V": ["", "x"], "T1": ["", "x", "y", "xy"],
                 "Z": ["", "x", "y", "xy"], "Ttop": ["", "y"]}
        names = {("t1", "x"): "t3", ("t2", "y"): "t4", ("V", "x"): "V'", ("Ttop", "y"): "Tbot"}
        for nm, (col, ps) in base.items():
            for g in orbit[nm]:
                c, q = col, ps
                if "x" in g:
                    c, q = CMX[c], refl_tile(q, MX)
                if "y" in g:
                    c, q = CMY[c], refl_tile(q, MY)
                t[names.get((nm, g), nm + ("_" + g if g else ""))] = (c, q)
        return t


def consistency(tiles):
    """every tile a closed chain; every piece shared by exactly two tiles in opposite directions or on the outer boundary; returns the outer pieces."""
    bad = []
    for nm, (c, ps) in tiles.items():
        if not X.closed_chain(ps):
            bad.append(("open chain", nm))
    seen = {}
    for nm, (c, ps) in tiles.items():
        for pc in ps:
            seen.setdefault(X.pkey(pc), []).append((nm, pc))
    outer = []
    for k, lst in seen.items():
        if len(lst) == 1:
            outer.append(lst[0])
        elif len(lst) == 2:
            (n1, a), (n2, b) = lst
            sa, ea = X.dse(a)
            sb, eb = X.dse(b)
            if not (same(sa, eb) and same(ea, sb)):
                bad.append(("same direction", n1, n2))
            if a.kind != b.kind or (a.kind == "A" and not (same(a.C, b.C) and a.rho == b.rho)):
                bad.append(("unequal pieces", n1, n2))
        else:
            bad.append(("piece in >2 tiles", [x[0] for x in lst]))
    return bad, outer


def seg_min_dist_cmp(P0, sg, R2):
    """sign(min distance from P0 to the segment, squared, - R2)."""
    d = sub(sg.Q, sg.P)
    t = dot(sub(P0, sg.P), d)
    if t.sign() > 0 and (t - nn(d)).sign() < 0:
        c = crs(d, sub(P0, sg.P))
        return (c * c / nn(d) - R2).sign()
    return min((nn(sub(P0, sg.P)) - R2).sign(), (nn(sub(P0, sg.Q)) - R2).sign())


def colours_at(v, tiles):
    return sorted({c for nm, (c, ps) in tiles.items() if any(X.on_piece(v, pc) for pc in ps)})


def tiles_at(v, tiles):
    return sorted(nm for nm, (c, ps) in tiles.items() if any(X.on_piece(v, pc) for pc in ps))


BOW_PLANT_PRED = {   # rejected pairs predicted before the first run (the faithful twin: none)
    "wedge_swap": [("Tbot", "Z_xy"), ("Tbot", "Z_y"), ("Ttop", "Z"), ("Ttop", "Z_x")],
    "ttop_six": [("Tbot", "X_xy"), ("Ttop", "X_x")],
    "cut_low": [("X", "X_xy"), ("X_x", "X_y")],
}


def run_bowtie(plant=None):
    bw = Bowtie(plant)
    tiles = bw.tiles()
    print(f"tiles: {len(tiles)}; colours: " + ", ".join(f"{k}:{sorted(nm for nm, (c, _) in tiles.items() if c == k)}" for k in range(1, 7)))
    bad, outer = consistency(tiles)
    print(f"map consistency: {'OK' if not bad else bad}; outer pieces {len(outer)} (all segments: {all(pc.kind == 'S' for _, pc in outer)})")
    import math
    areas = {nm: X.float_area(ps) for nm, (c, ps) in tiles.items()}
    print(f"float guard: every tile counter-clockwise with positive area: {all(a > 0 for a in areas.values())}; "
          f"sum of areas {sum(areas.values()):.9f}")
    R2 = n(Fr(27, 25))     # (3 sqrt3 / 5)^2
    cm = [seg_min_dist_cmp(bw.p, pc, R2) for _, pc in outer]
    print(f"outer boundary: min distance from p against 3 sqrt3/5: {'all >' if all(c > 0 for c in cm) else cm}")
    # the polygon area as a second float guard: outer boundary pieces form one closed polygon around p
    for v, lab in [(bw.p, "p"), (bw.q1, "q1"), (bw.q2, "q2"), (bw.qC, "qC"), (bw.qD, "qD"), (bw.top, "top"), (bw.bot, "bot")]:
        print(f"  at {lab}: tiles {tiles_at(v, tiles)}, colours {colours_at(v, tiles)}")
    rej, npairs, tight, nsf = X.check(tiles)
    want = sum(1 for a in tiles for b in tiles if a <= b and tiles[a][0] == tiles[b][0])
    print(f"same-colour pairs the object has: {want}; examined exactly: {npairs}; rejected: {rej}; non-Siamese failures: {nsf}")
    print(f"tight at 1: {len(tight)}: {tight}")
    print("VERDICT:", "ACCEPT" if not rej and not nsf and not bad and npairs == want else "REJECT")
    if plant:
        pr = sorted(tuple(sorted(x)) for x in BOW_PLANT_PRED[plant])
        got = sorted(tuple(sorted(x)) for x in rej)
        print(f"PLANT {plant}: rejected {got}; predicted {pr}: {'AS PREDICTED' if got == pr else 'NOT AS PREDICTED'}")
    return tiles, rej, nsf


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "selftest"
    if cmd == "selftest":
        a = selftest()
        print("plants")
        b = plants()
        print("SELFTEST", "PASSED" if a and b else "FAILED")
        sys.exit(0 if a and b else 1)
    if cmd == "bowtie":
        pl = sys.argv[3] if len(sys.argv) > 3 and sys.argv[2] == "--plant" else None
        run_bowtie(pl)


# ================================================================== calibration on held objects
_TW = {}


def conv_num(x):
    """an FS-112 tower element (fs112_yb2_check.N: .T with raw radicands .ds, .v nested pairs) as mine, exactly."""
    key = id(x.T)
    if key not in _TW:
        _TW[key] = X.Tw(x.T.ds, x.T.names)
    return X.Q(_TW[key], x.v)


def conv_tiles(tiles):
    out = {}
    for nm, (col, ps) in tiles.items():
        qs = []
        for pc in ps:
            if pc.kind == "S":
                qs.append(Seg((conv_num(pc.P[0]), conv_num(pc.P[1])), (conv_num(pc.Q[0]), conv_num(pc.Q[1]))))
            else:
                C = (conv_num(pc.C[0]), conv_num(pc.C[1]))
                qs.append(Arc(C, conv_num(pc.rho), (conv_num(pc.S[0]), conv_num(pc.S[1])), (conv_num(pc.E[0]), conv_num(pc.E[1]))))
        out[nm] = (col, qs)
    return out


def brick(w=4):
    t = {}
    for i in range(-w, w + 1):
        for j in range(-w, w + 1):
            x0 = Fr(4, 5) * i + Fr(2, 5) * j
            y0 = Fr(3, 5) * j
            t[f"b{i},{j}"] = ((i + 3 * j) % 7, poly(P(x0, y0), P(x0 + Fr(4, 5), y0), P(x0 + Fr(4, 5), y0 + Fr(3, 5)), P(x0, y0 + Fr(3, 5))))
    return t


def hexes(w=4, side=Fr(1, 2)):
    t = {}
    a1 = (s3 / 2, n(0))
    a2 = (s3 / 4, n(Fr(3, 4)))
    vs = [(s3 / 2, n(Fr(1, 2))), (n(0), n(1)), (-s3 / 2, n(Fr(1, 2))), (-s3 / 2, n(Fr(-1, 2))), (n(0), n(-1)), (s3 / 2, n(Fr(-1, 2)))]
    for q in range(-w, w + 1):
        for r in range(-w, w + 1):
            c = add(smul(n(q), a1), smul(n(r), a2))
            t[f"h{q},{r}"] = ((q + 3 * r) % 7, poly(*[add(c, smul(n(side), v)) for v in vs]))
    return t


def calib_one(label, tiles, reps, plant_tiles=None, pred=None):
    pairs = {(a, b) if a <= b else (b, a) for a in reps for b in tiles if tiles[a][0] == tiles[b][0]}
    rej, npairs, tight, nsf = X.check(tiles, log=lambda *_: None, pairs=pairs)
    print(f"{label}: same-colour pairs with a first tile among the representatives: {len(pairs)}; examined exactly: {npairs}; "
          f"rejected {rej}; tight at 1: {len(tight)}; VERDICT {'ACCEPT' if not rej and npairs == len(pairs) else 'REJECT'}")
    if plant_tiles is not None:
        pairs2 = {(a, b) if a <= b else (b, a) for a in reps for b in plant_tiles if plant_tiles[a][0] == plant_tiles[b][0]}
        rej2, np2, _, _ = X.check(plant_tiles, log=lambda *_: None, pairs=pairs2)
        got = sorted(tuple(sorted(x)) for x in rej2)
        pr = sorted(tuple(sorted(x)) for x in pred)
        print(f"   plant beside it: rejected {got}; predicted {pr}: {'AS PREDICTED' if got == pr else 'NOT AS PREDICTED'}")
    return rej, tight


def calib():
    import fs112_yb2_objects as O
    import fs112_yb3_frags as F
    # the brick: cell (0,0) against the window; plant: cells 1/2 wide -> exactly the pairs of cell (0,0) with (-3,1) and (3,-1)
    bt = brick()
    bp = {k: v for k, v in bt.items()}
    for i in range(-4, 5):
        for j in range(-4, 5):
            x0, y0 = Fr(4, 5) * i + Fr(2, 5) * j, Fr(3, 5) * j
            # plant: every cell 9/10 wide (overlapping its right neighbour is irrelevant to same-colour distances): diagonal > 1
            bp[f"b{i},{j}"] = ((i + 3 * j) % 7, poly(P(x0, y0), P(x0 + Fr(9, 10), y0), P(x0 + Fr(9, 10), y0 + Fr(3, 5)), P(x0, y0 + Fr(3, 5))))
    calib_one("brick (row 33)", bt, ["b0,0"], bp, [("b0,0", "b0,0"), ("b0,0", "b1,2"), ("b-1,-2", "b0,0")])
    ht = hexes()
    calib_one("hexagonal seven-colouring (side 1/2)", ht, ["h0,0"], hexes(side=Fr(11, 20)), [("h0,0", "h0,0")])
    # the strip: FS112-YB2's builder (imported, never edited), the 12 tiles of columns 0..2 against columns -4..6
    S = O.Strip()
    st = conv_tiles(S.tiles(-4, 6))
    reps = [f"{k}{j}" for j in range(3) for k in "UDTB"]
    calib_one("the strip (FS112-YB2's builder)", st, reps)
    # the disk: all 26 tiles
    dk = conv_tiles(O.Disk().tiles())
    calib_one("the disk (FS112-YB2's builder)", dk, list(dk))
    # FS112-BOWTIE: FS112-YB3's builder; plant h_is_g -> exactly (G, H)
    bw = conv_tiles(F.bowtie())
    calib_one("FS112-BOWTIE (FS112-YB3's builder)", bw, list(bw), conv_tiles(F.bowtie("h_is_g")), [("G", "H")])


if __name__ == "__main__" and len(sys.argv) > 1 and sys.argv[1] == "calib":
    calib()
