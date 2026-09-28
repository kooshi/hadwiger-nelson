#!/usr/bin/env python3
"""FS114-YB3 drivers: my checker's self-test and plants; calibration on five held objects; the held Reuleaux bowtie (FS114-YB2's rebuild of
FS114-Y2-BOWTIE, its builder imported unedited) checked by my checker, read against the structure my stage-1b derivations say is forced, and
planted beside its faithful twin; the SIDES identity at a named angle.

Run: python3 tools/fs114_yb3_run.py selftest | calib | bowtie | sides | all
Every prediction below was written before the first run (the docstrings and the *_PRED tables).
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr
import sympy as sp

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb3_check as X   # noqa: E402

R, P, Seg, Arc, arc = X.R, X.P, X.Seg, X.Arc, X.arc
sub, add, smul, dot, crs, nn, same = X.sub, X.add, X.smul, X.dot, X.crs, X.nn, X.same
S3 = sp.sqrt(3)


def poly(*v):
    return [Seg(v[i], v[(i + 1) % len(v)]) for i in range(len(v))]


# ================================================================== controls
def reuleaux(a, b, c):
    return [arc(c, 1, a, b), arc(a, 1, b, c), arc(b, 1, c, a)]


def controls():
    """(label, tiles, rejected pairs predicted before the first run)."""
    out = []
    reu = reuleaux(P(0, 0), P(1, 0), P(Fr(1, 2), S3 / 2))
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
    S, E = add(C, P(Fr(-1, 2), -S3 / 2)), add(C, P(Fr(1, 2), -S3 / 2))
    cap = [Arc(C, 1, S, E), Seg(E, S)]
    bar = poly(P(-2, Fr(-1, 10)), P(2, Fr(-1, 10)), P(2, 0), P(-2, 0))
    out.append(("cap over bar", {"cap": (1, cap), "bar": (1, bar)}, [("bar", "bar"), ("bar", "cap")]))
    Ca, Cb = P(0, Fr(29, 20)), P(0, Fr(-29, 20))
    Sa, Ea = add(Ca, P(Fr(-1, 2), -S3 / 2)), add(Ca, P(Fr(1, 2), -S3 / 2))
    Sb, Eb = add(Cb, P(Fr(1, 2), S3 / 2)), add(Cb, P(Fr(-1, 2), S3 / 2))
    out.append(("cap over cap", {"a": (1, [Arc(Ca, 1, Sa, Ea), Seg(Ea, Sa)]), "b": (1, [Arc(Cb, 1, Sb, Eb), Seg(Eb, Sb)])}, [("a", "b")]))
    return out


PLANT_PRED = {   # the controls whose verdict each checker plant flips, written before the first run
    "noself": {"rect 3/5x81/100", "crossing bars", "cap over bar"},
    "closed": {"reuleaux", "rect 3/5x4/5", "squares gap 1", "cap over bar", "cap over cap"},
    "nocross": {"crossing bars"},
    "endsonly": {"cap over bar", "cap over cap"},
    "nointerior": {"cap over bar", "cap over cap"},
    "tieup": {"reuleaux", "rect 3/5x4/5", "cap over bar", "cap over cap"},
}


def selftest():
    ok = True
    print("arithmetic (interval + exact zero test)")
    s3 = R(S3)
    r = R(sp.sqrt(2 + S3))
    tests = [("sqrt3^2 - 3 = 0", (s3 * s3 - 3).sign(), 0),
             ("sqrt(2+sqrt3) - (sqrt6+sqrt2)/2 = 0", (r - R((sp.sqrt(6) + sp.sqrt(2)) / 2)).sign(), 0),
             ("sqrt(2+sqrt3) < 1.9319", (r - Fr(19319, 10000)).sign(), -1),
             ("3 - 2 sqrt(2+sqrt3) < 0", (3 - 2 * r).sign(), -1),
             ("|sqrt4 - 3| vs 1: equal", X.cmp1(R.of(4), R.of(-3)), 0),
             ("|sqrt3| vs 1: above", X.cmp1(R.of(3), R.of(0)), 1),
             ("|sqrt3 - 1| vs 1: below", X.cmp1(R.of(3), R.of(-1)), -1)]
    try:
        R(sp.Rational(1, 10**200) + 0 * S3).sign()
        tests.append(("1e-200 read as positive (interval sees it)", 1, 1))
    except X.Undecided:
        tests.append(("1e-200 read as positive (interval sees it)", "Undecided", 1))
    for lab, got, want in tests:
        good = got == want
        ok &= good
        print(f"  [{'ok' if good else 'FAIL'}] {lab}: {got} (expected {want})")
    print("controls")
    base = {}
    for lab, tiles, want in controls():
        rej, npairs, tight, nsf = X.check(tiles, log=lambda *_: None)
        got = sorted(rej)
        base[lab] = got
        good = got == sorted(want)
        ok &= good
        print(f"  [{'ok' if good else 'FAIL'}] {lab}: rejected {got} of {npairs} pairs (predicted {sorted(want)}); tight {tight}")
    print("checker plants")
    for pl, pred in PLANT_PRED.items():
        X.PLANT.clear()
        X.PLANT.add(pl)
        flipped = {lab for lab, t, _ in controls() if sorted(X.check(t, log=lambda *_: None)[0]) != base[lab]}
        X.PLANT.clear()
        good = flipped == pred
        ok &= good
        print(f"  [{'ok' if good else 'FAIL'}] plant {pl}: flips {sorted(flipped)} (predicted {sorted(pred)})")
    print("SELF-TEST", "PASSED" if ok else "FAILED")
    return ok


# ================================================================== conversions of held objects (tower numbers -> exact sympy)
_DS = {}


def _tower_expr(v, k, ds):
    if k == 0:
        return sp.Rational(v.numerator, v.denominator)
    a, b = v
    return _tower_expr(a, k - 1, ds) + _tower_expr(b, k - 1, ds) * _root(ds, k)


def _root(ds, k):
    key = (id(ds), k)
    if key not in _DS:
        _DS[key] = sp.sqrt(_tower_expr(ds[k - 1], k - 1, ds))
    return _DS[key]


def conv_num(x):
    ds = x.T.ds
    return R(sp.expand(_tower_expr(x.v, len(ds), ds)))


def conv_pt(p):
    return (conv_num(p[0]), conv_num(p[1]))


def conv_tiles(tiles):
    out = {}
    for nm, (col, ps) in tiles.items():
        qs = []
        for pc in ps:
            if pc.kind == "S":
                qs.append(Seg(conv_pt(pc.P), conv_pt(pc.Q)))
            else:
                qs.append(Arc(conv_pt(pc.C), conv_num(pc.rho), conv_pt(pc.S), conv_pt(pc.E), getattr(pc, "fwd", True)))
        out[nm] = (col, qs)
    return out


def brick(w=4, width=Fr(4, 5)):
    t = {}
    for i in range(-w, w + 1):
        for j in range(-w, w + 1):
            x0, y0 = Fr(4, 5) * i + Fr(2, 5) * j, Fr(3, 5) * j
            t[f"b{i},{j}"] = ((i + 3 * j) % 7, poly(P(x0, y0), P(x0 + width, y0), P(x0 + width, y0 + Fr(3, 5)), P(x0, y0 + Fr(3, 5))))
    return t


def hexes(w=3, side=Fr(1, 2)):
    t = {}
    vs = [(S3 / 2, Fr(1, 2)), (0, 1), (-S3 / 2, Fr(1, 2)), (-S3 / 2, Fr(-1, 2)), (0, -1), (S3 / 2, Fr(-1, 2))]
    for q in range(-w, w + 1):
        for r in range(-w, w + 1):
            cx, cy = S3 / 2 * q + S3 / 4 * r, sp.Rational(3, 4) * r
            t[f"h{q},{r}"] = ((q + 3 * r) % 7, poly(*[P(cx + side * a, cy + side * b) for a, b in vs]))
    return t


def calib_one(label, tiles, reps, plant_tiles=None, pred=None):
    pairs = {(a, b) if a <= b else (b, a) for a in reps for b in tiles if tiles[a][0] == tiles[b][0]}
    rej, npairs, tight, nsf = X.check(tiles, pairs=pairs, log=lambda *_: None)
    print(f"{label}: same-colour pairs the object has with a first tile among the representatives: {len(pairs)}; examined: {npairs}; "
          f"rejected {sorted(rej)}; tight at 1: {len(tight)}; VERDICT {'ACCEPT' if not rej and npairs == len(pairs) else 'REJECT'}")
    if plant_tiles is not None:
        pairs2 = {(a, b) if a <= b else (b, a) for a in reps for b in plant_tiles if plant_tiles[a][0] == plant_tiles[b][0]}
        rej2 = X.check(plant_tiles, pairs=pairs2, log=lambda *_: None)[0]
        got = sorted(tuple(sorted(x)) for x in rej2)
        pr = sorted(tuple(sorted(x)) for x in pred)
        print(f"   plant beside it: rejected {got}; predicted {pr}: {'AS PREDICTED' if got == pr else 'NOT AS PREDICTED'}")
        return (not rej) and got == pr
    return not rej


def calib():
    import fs112_yb2_objects as O
    import fs112_yb3_frags as F
    ok = True
    ok &= calib_one("brick (row 33; cells 4/5 x 3/5, shear 2/5, colour (i + 3j) mod 7)", brick(), ["b0,0"],
                    brick(width=Fr(9, 10)), [("b0,0", "b0,0"), ("b0,0", "b1,2"), ("b-1,-2", "b0,0")])
    ok &= calib_one("hexagonal seven-colouring (side 1/2)", hexes(), ["h0,0"], hexes(side=Fr(11, 20)), [("h0,0", "h0,0")])
    S = O.Strip()
    st = conv_tiles(S.tiles(-4, 6))
    ok &= calib_one("the strip (FS112-YB2's builder, unedited)", st, [f"{k}{j}" for j in range(3) for k in "UDTB"])
    dk = conv_tiles(O.Disk().tiles())
    ok &= calib_one("the disk (FS112-YB2's builder, unedited)", dk, list(dk))
    bw = conv_tiles(F.bowtie())
    ok &= calib_one("FS112-BOWTIE (FS112-YB3's builder, unedited)", bw, list(bw), conv_tiles(F.bowtie("h_is_g")), [("G", "H")])
    print("CALIBRATION", "PASSED" if ok else "FAILED")
    return ok


# ================================================================== the held Reuleaux bowtie
def held_bowtie(plant=None):
    import fs114_yb2_run as B   # FS114-YB2's builder (open to this job), imported unedited
    t = conv_tiles(B.Bowtie().tiles())
    if plant == "sides":        # X2 (YB2's X_y, at q2) given X1's colour: SIDES clause 1 must fire at (X, X_y)
        t["X_y"] = (t["X"][0], t["X_y"][1])
    if plant == "wcol":         # W (YB2's V, colour 3) given X1's colour: YB3-W must fire
        t["V"] = (t["X"][0], t["V"][1])
    return t


BOW_PRED = {   # rejected pairs predicted before the first run (the faithful twin: none)
    "sides": [("X", "X_y"), ("X_xy", "X_y"), ("X_y", "Z_y")],
    "wcol": [("V", "X"), ("V", "Z_y")],
}


def bowtie():
    ok = True
    t = held_bowtie()
    rej, npairs, tight, nsf = X.check(t, log=lambda *_: None)
    want = sum(1 for a in t for b in t if a <= b and t[a][0] == t[b][0])
    print(f"held bowtie: {len(t)} tiles; same-colour pairs it has {want}; examined {npairs}; rejected {rej}; distinct pairs with min < 1 "
          f"(non-Siamese failures) {nsf}; tight at 1: {len(tight)}")
    ok &= (not rej) and (not nsf) and npairs == want
    for pl, pred in BOW_PRED.items():
        tp = held_bowtie(pl)
        rp = X.check(tp, log=lambda *_: None)[0]
        got = sorted(tuple(sorted(x)) for x in rp)
        pr = sorted(tuple(sorted(x)) for x in pred)
        good = got == pr
        ok &= good
        print(f"  plant {pl}: rejected {got}; predicted {pr}: {'AS PREDICTED' if good else 'NOT AS PREDICTED'}")
    ok &= structure(t)
    print("BOWTIE", "PASSED" if ok else "FAILED")
    return ok


def _e(deg):
    return {0: P(1, 0), 60: P(Fr(1, 2), S3 / 2), 90: P(0, 1), 120: P(Fr(-1, 2), S3 / 2), 150: P(-S3 / 2, Fr(1, 2)),
            180: P(-1, 0), 240: P(Fr(-1, 2), -S3 / 2), 270: P(0, -1), 300: P(Fr(1, 2), -S3 / 2), 330: P(S3 / 2, Fr(-1, 2))}[deg]


def _parallel(u, v):
    return crs(u, v).sign() == 0 and dot(u, v).sign() > 0


def structure(t):
    """YB3-DIAG's and YB3-W's forced structure, read on the held object (a consistency control of the derivation, not a proof of it)."""
    ok = True
    q1, q2, top, bot = P(S3 / 2, Fr(1, 2)), P(S3 / 2, Fr(-1, 2)), P(0, 1), P(0, -1)

    def say(lab, good):
        nonlocal ok
        ok &= bool(good)
        print(f"  [{'ok' if good else 'FAIL'}] {lab}")

    sec = X.sectors_at(q1, t)
    order = sorted(sec, key=lambda s: (X.ang(s[2]) - 180.0) % 360.0)
    print("  at q1 (counter-clockwise from 180 deg): " + ", ".join(f"{nm}({col}) [{X.ang(a):.2f}, {X.ang(b):.2f}]" for nm, col, a, b in order))
    say("q1 has exactly five tiles of five distinct colours, 2 absent", len(sec) == 5 and len({s[1] for s in sec}) == 5 and 2 not in {s[1] for s in sec})
    say("order t1(1), W(3), T1(4), sliver(b), X1(a) with {a, b} = {5, 6}",
        [s[1] for s in order][:3] == [1, 3, 4] and {order[3][1], order[4][1]} == {5, 6})
    Xname, Tname, Vname = order[4][0], order[2][0], order[3][0]
    xs = [s for s in sec if s[0] == Xname][0]
    say(f"X1 ({Xname}) leaves q1 at exactly 60 deg and ends at 180 deg", _parallel(xs[2], _e(60)) and _parallel(xs[3], _e(180)))
    wsec = [s for s in sec if s[1] == 3][0]
    say("W (colour 3) at q1 lies in [300, 360] (starts at 300, ends at or before 360)",
        _parallel(wsec[2], _e(300)) and crs(_e(0), wsec[3]).sign() <= 0 and crs(_e(300), wsec[3]).sign() >= 0)
    w2 = [s for s in X.sectors_at(q2, t) if s[1] == 3]
    say("the colour-3 tile at q2 is the same tile, within [0, 60] there", len(w2) == 1 and w2[0][0] == wsec[0]
        and crs(w2[0][2], _e(0)).sign() <= 0 and crs(w2[0][2], _e(60)).sign() >= 0 and _parallel(w2[0][3], _e(60)))
    at_top = X.sectors_at(top, t)
    cols_top = sorted(s[1] for s in at_top)
    say(f"top carries X1, a colour-4 tile N and X4 (colours at top {cols_top})", 4 in cols_top and {5, 6} <= set(cols_top)
        and any(s[0] == Xname for s in at_top))
    # the X1 | N arc about q1 from top, its angular extent, and T1's end against U1's facing-away cone
    N = [s for s in at_top if s[1] == 4][0][0]
    arcs = [pc for pc in t[N][1] if pc.kind == "A" and same(pc.C, q1)]
    say("the X1 | N edge is a unit arc of omega(q1) (one arc of N about q1)", len(arcs) == 1)
    a = arcs[0]
    ts = [s for s in sec if s[0] == Tname][0]
    ok_u1 = all(dot(d, sub(x, q1)).sign() <= 0 for d in (ts[2], ts[3]) for x in a.ends())
    say("T1's whole sector at q1 lies in U1's facing-away cone of that arc (both ends of T1's sector, both ends of the arc)", ok_u1)
    vs = [s for s in sec if s[0] == Vname][0]
    say("the sliver ends exactly where X1 starts (60 deg), and has no direction beyond 60 deg", _parallel(vs[3], _e(60)))
    # at q2: T2 (colour 2) against the X2 | N' arc about q2 from bot, and against the tactic arc t1 | t2
    sec2 = X.sectors_at(q2, t)
    T2 = [s for s in sec2 if s[1] == 2][0]
    at_bot = X.sectors_at(bot, t)
    Np = [s for s in at_bot if s[1] == 2][0][0]
    arcs2 = [pc for pc in t[Np][1] if pc.kind == "A" and same(pc.C, q2)]
    say("the X2 | N' edge is a unit arc of omega(q2)", len(arcs2) == 1)
    ok_u1b = all(dot(d, sub(x, q2)).sign() <= 0 for d in (T2[2], T2[3]) for x in arcs2[0].ends())
    say("T2's sector at q2 lies in the facing-away cone of the X2 | N' arc (so it starts after 300 deg)", ok_u1b)
    say("T2 points toward r: both ends of its sector within < 90 deg of 30 deg", all(dot(d, P(S3 / 2, Fr(1, 2))).sign() > 0 for d in (T2[2], T2[3])))
    print(f"  T2 at q2: [{X.ang(T2[2]):.2f}, {X.ang(T2[3]):.2f}] deg; the X1 | N arc about q1: "
          f"[{X.ang(sub(a.S, q1)):.2f}, {X.ang(sub(a.E, q1)):.2f}] deg; T1 at q1: [{X.ang(ts[2]):.2f}, {X.ang(ts[3]):.2f}] deg")
    return ok


# ================================================================== SIDES at a named angle
def sides():
    """cos e = 4/5, sin e = 3/5: z1 = q2 + e(90 + e) = q2 + (-3/5, 4/5), z2 = q1 + e(270 - e) = q1 + (-3/5, -4/5); |z1 - z2| = 2 cos e - 1 = 3/5 exactly,
    and |z1| < 1 (clause 2's point within 1 of p)."""
    q1, q2 = P(S3 / 2, Fr(1, 2)), P(S3 / 2, Fr(-1, 2))
    z1, z2 = add(q2, P(Fr(-3, 5), Fr(4, 5))), add(q1, P(Fr(-3, 5), Fr(-4, 5)))
    a = (nn(sub(z1, z2)) - Fr(9, 25)).sign() == 0
    b = (nn(z1) - 1).sign() < 0
    c = (nn(sub(z1, q2)) - 1).sign() == 0 and (nn(sub(z2, q1)) - 1).sign() == 0
    print(f"SIDES at cos e = 4/5: z1, z2 on omega(q2), omega(q1): {c}; |z1 - z2|^2 = 9/25 exactly: {a}; |z1| < 1: {b}")
    return a and b and c


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "all"
    res = True
    if cmd in ("selftest", "all"):
        res &= selftest()
    if cmd in ("calib", "all"):
        res &= calib()
    if cmd in ("bowtie", "all"):
        res &= bowtie()
    if cmd in ("sides", "all"):
        res &= sides()
    print("exact zero tests used:", X.STATS["exact_zero_tests"])
    print("ALL", "PASSED" if res else "FAILED")
    sys.exit(0 if res else 1)
