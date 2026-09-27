#!/usr/bin/env python3
"""FS112-Y stage 2: calibrate tools/fs112_y_check.py in the claim list's order (data/fs112/claims.md §7):
  1. FS-110's fragments S1, T2, BB, MX, WC, WC1, WCEQ, WCH, WC1H and A6-C2, rebuilt by FS-110's own builders (imported, not edited),
     converted to the tower Q(sqrt 3) and checked: the verdicts must equal the frozen checker's, pair by pair;
  2. CAL-7: the tight hexagonal 7-colouring (side 1/2: diameter exactly 1) ACCEPTs; side 11/20 REJECTs; the index-4 colouring REJECTs;
  3. CAL-STRIP: [AxenovichEtAl2014]'s strip rebuilt from the printed rule (tools/fs112_y_check.strip): height exactly sqrt15/2 + sqrt3,
     every same-colour pair examined against the number the object has, contact kinds read off, the float partition guard;
  4. CAL-PLANT: planted faults beside their faithful twins, each firing for its named reason; checker plants likewise.
Run: python3 tools/fs112_y_calibrate.py [section ...]   (sections: frags hex strip plants; default all).  Exit 1 on any mismatch.
"""
from __future__ import annotations
import sys, os, importlib
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import fs112_y_check as Y  # noqa: E402

OK = True


def say(ok, msg):
    global OK
    OK &= ok
    print(("ok       " if ok else "MISMATCH ") + msg)


# ------------------------------------------------------------------ 1. FS-110's fragments
def convert(Tfrozen, C):
    F = Y.Field([Fr(3)], names=["3"])
    def num(q): return F.embed(1, (Fr(q.a), Fr(q.b)))
    def pt(p): return (num(p[0]), num(p[1]))
    def prim(p):
        if isinstance(p, C.Seg): return Y.Seg(pt(p.P), pt(p.Q))
        return Y.Arc(pt(p.C), num(p.r), pt(p.S), pt(p.E))
    return {k: (c, [prim(p) for p in prims]) for k, (c, prims) in Tfrozen.items()}


def frags():
    import fs110_y_check as C
    import fs110_y_fragments as G
    import fs110_y_cone as K
    sys.path.insert(0, os.path.join(ROOT, "data/fs110/fs110-a6"))
    A6 = importlib.import_module("a6_c2_single_horn")
    items = [(f"S1/T2/BB/MX {n}", fn) for n, fn in G.FRAGS.items()] + [(f"cone {n}", fn) for n, fn in K.FRAGS.items()]
    items += [("A6-C2", A6.frag), ("A6-C2 tip->2", lambda: A6.frag(tipcol=2)), ("A6-C2 plant deep", lambda: A6.frag(plant="deep"))]
    items += [("G plant s1_flat", lambda: _plant(G, "s1_flat", G.FRAGS["S1"])), ("G plant t2_flat", lambda: _plant(G, "t2_flat", G.FRAGS["T2"]))]
    for name, fn in items:
        T = fn()
        tiles_f = {k: v[1] for k, v in T.items()}
        pairs = [(a, b) for a, b in Y.all_pairs(T)]
        frozen = {(a, b): C.pair_verdict(tiles_f[a], tiles_f[b], self_pair=(a == b)) for a, b in pairs}
        mine_t = convert(T, C)
        mine = {(a, b): Y.pair_verdict(mine_t[a][1], mine_t[b][1], self_pair=(a == b)) for a, b in pairs}
        diff = [p for p in pairs if frozen[p] != mine[p]]
        nrej = sum(v == "REJECT" for v in mine.values())
        say(not diff, f"{name:26s} {len(T):3d} tiles, {len(pairs):3d} same-colour pairs examined of {len(pairs)}; "
                      f"REJECT pairs {nrej} (frozen {sum(v == 'REJECT' for v in frozen.values())}); disagreements {diff}")


def _plant(G, name, fn):
    old = G.PLANT; G.PLANT = name
    try: return fn()
    finally: G.PLANT = old


# ------------------------------------------------------------------ 2. CAL-7
def hexcol(a, sub_ok):
    F = Y.Field([Fr(3)], names=["3"]); r3 = F.gen(1); a = F(a); h = a * r3 / 2
    def hexagon(c):
        vs = [(a, F(0)), (a / 2, h), (-a / 2, h), (-a, F(0)), (-a / 2, -h), (a / 2, -h)]
        vs = [Y.add(c, v) for v in vs]
        return [Y.Seg(vs[i], vs[(i + 1) % 6]) for i in range(6)]
    v1, v2 = (a * 3 / 2, a * r3 / 2), (F(0), a * r3)
    tiles = {"H0": (0, hexagon((F(0), F(0))))}; pairs = [("H0", "H0")]
    for m in range(-8, 9):
        for n in range(-8, 9):
            if (m, n) == (0, 0) or not sub_ok(m, n): continue
            c = Y.add(Y.mul(m, v1), Y.mul(n, v2))
            if Y.n2(c) > 9: continue
            nm = f"H{m},{n}"; tiles[nm] = (0, hexagon(c)); pairs.append(("H0", nm))
    return tiles, pairs


def hexs():
    for lab, a, sub_ok, want in [("CAL-7 tight hexagonal 7-colouring, side 1/2", Fr(1, 2), lambda m, n: (m + 3 * n) % 7 == 0, "ACCEPT"),
                                 ("hexagonal 7-colouring, side 11/20 (diameter 1.1)", Fr(11, 20), lambda m, n: (m + 3 * n) % 7 == 0, "REJECT"),
                                 ("index-4 hexagonal colouring (same colour sqrt3 apart)", Fr(1, 2), lambda m, n: m % 2 == 0 and n % 2 == 0, "REJECT")]:
        tiles, pairs = hexcol(a, sub_ok)
        v, bad, n = Y.check_pairs(tiles, pairs)
        say(v == want, f"{lab:55s} pairs {n} (class 0 against its translates within 3); want {want} got {v}")


# ------------------------------------------------------------------ 3. CAL-STRIP
def strip_run(plant=None, verbose=True):
    F, T, top = Y.strip(-4, 7, plant=plant)
    pairs = Y.strip_pairs(T)
    # completeness: a wider window adds no pair within reach of the period's tiles
    F2, T2, _ = Y.strip(-8, 11, plant=plant)
    pairs2 = Y.strip_pairs(T2)
    v, bad, n = Y.check_pairs(T, pairs)
    return F, T, top, pairs, pairs2, v, bad


def strip():
    F, T, top, pairs, pairs2, v, bad = strip_run()
    r3, r5 = F.gen(1), F.gen(2)
    H = 2 * top
    say(H == r3 * r5 / 2 + r3, f"strip height exactly sqrt15/2 + sqrt3 = {H}")
    say(len(pairs) == len(pairs2), f"strip: ordered same-colour pairs examined (T in one period, T' within horizontal gap 1): {len(pairs)}; "
                                   f"the object has {len(pairs2)} (counted on a window twice as wide)")
    say(v == "ACCEPT", f"CAL-STRIP verdict {v}; REJECT pairs {bad}")
    selfs = [p for p in pairs if p[0] == p[1]]
    diam1 = all(Y.frange(T[a][1], T[a][1], True)[1] > 0.999999 for a, _ in selfs)
    say(diam1, f"every tile's diameter is 1 to float precision ({len(selfs)} self pairs; exact: ACCEPT above, and closed_interval below)")
    used, over, hole = Y.partition(T, (0.0, 1.5, -top.f(), top.f()), n=70)
    say(over == 0 and hole == 0, f"float partition guard on one period: {used} samples, {over} overlaps, {hole} holes")
    # contact kinds: every arc of radius 1, its centre, inner and outer tiles
    arcs = {}
    for nm, (c, prims) in T.items():
        if int(nm[1:]) not in range(-1, 5): continue
        for p in prims:
            if isinstance(p, Y.Arc) and p.r == 1:
                k = (Y.pkey(p.C), frozenset([Y.pkey(p.S), Y.pkey(p.E)]))
                arcs.setdefault(k, []).append((nm, c, p))
    kinds = {}
    for k, lst in arcs.items():
        if len(lst) != 2: continue
        p = lst[0][2]; Cn = p.C
        mid_dir = Y.add(Y.sub(p.S, Cn), Y.sub(p.E, Cn))          # the arc's middle direction (arcs span < 180 deg)
        # the inner tile is the one containing points toward the centre: its closure contains the centre (arches) --
        # decided exactly: the tile whose closure holds C is the inner tile (self in-contact) if any
        Pcl = Y.closure_type(T, Cn)
        inner = [(nm, c) for nm, c, _ in lst if c in Y.closure_type({nm: T[nm]}, Cn)]
        outer = [(nm, c) for nm, c, _ in lst if (nm, c) not in inner]
        if len(inner) != 1 or len(outer) != 1:
            kinds[k] = "UNDECIDED"; continue
        sin, sout = inner[0][1], outer[0][1]
        kind = ("both" if (sin in Pcl and sout in Pcl) else "in" if sin in Pcl else "out" if sout in Pcl else "inert")
        kinds[k] = (kind, inner[0][0], outer[0][0], len(Pcl), mid_dir[1].sign())
    ks = [kv[0] if isinstance(kv, tuple) else kv for kv in kinds.values()]
    say(all(k == "both" for k in ks) and len(ks) > 0,
        f"unit arcs read off (columns -1..4): {len(ks)}; kinds {sorted(set(ks))}; centres' |P_cl| {sorted({kv[3] for kv in kinds.values() if isinstance(kv, tuple)})}")
    # vertices' closure types
    x = lambda j: F(Fr(j, 2))
    h1, h2 = r3 / 2, r3 * r5 / 4
    for lab, P, want in [("midline P_1 = (1/2, 0)", (x(1), F(0)), {1, 2, 4, 5}), ("midline P_2 = (3/2, 0)", (x(3), F(0)), {1, 3, 4, 6}),
                         ("valley W = (1, sqrt3/2)", (x(2), h1), {2, 3, 4}), ("valley V0 = (0, sqrt3/2)", (x(0), h1), {1, 3, 5}),
                         ("apex A1 = (3/4, sqrt15/4)", (F(Fr(3, 4)), h2), {2, 4, 6}), ("mirror W' = (1, -sqrt3/2)", (x(2), -h1), {1, 5, 6})]:
        got = Y.closure_type(T, P)
        say(got == want, f"P_cl({lab}) = {sorted(got)}")
    V0, A1, Q = (x(0), h1), (F(Fr(3, 4)), h2), (F(Fr(1, 4)), top)
    say(Y.n2(Y.sub(Q, V0)) == 1 and Y.n2(Y.sub(Q, A1)) == 1 and Y.n2(Y.sub((x(1), F(0)), V0)) == 1 and Y.n2(Y.sub((x(1), F(0)), A1)) == 1,
        "Y112-EDGE: the common unit points of V0 {1,3,5} and A1 {2,4,6} are P_1 = (1/2, 0) and the top corner Q = (1/4, H/2), exactly")
    say(Y.n2(Y.sub(V0, A1)) == (9 - 3 * r5) / 4, f"|V0 - A1|^2 = (9 - 3 sqrt5)/4 exactly ({Y.n2(Y.sub(V0, A1))})")
    return T


# ------------------------------------------------------------------ 4. plants
def plants():
    # object plants, each beside its faithful twin (the faithful strip ACCEPTs above)
    for plant, want, reason in [
        ("tall", lambda bad: bad and all(a == b and a[0] in "CD" for a, b in bad),
         "H/2 raised by 1/100: the C and D tiles' diameters exceed 1 -- REJECT exactly at their self pairs"),
        ("flat", lambda bad: bad and all({a[0], b[0]} in ({"C", "B"}, {"D", "A"}) for a, b in bad),
         "shared arcs replaced by chords: each C tile reaches inside omega(P) of its out-contact centre -- REJECT at (C, B) and (D, A) pairs only"),
        ("swap", lambda bad: bad and all(any(n[0] == "C" and int(n[1:]) % 3 in (1, 2) for n in (a, b)) for a, b in bad),
         "C_1, C_2 colours exchanged: every REJECT pair holds a swapped C tile")]:
        F, T, top, pairs, pairs2, v, bad = strip_run(plant)
        say(v == "REJECT" and want(bad), f"object plant {plant:5s}: {v}, {len(bad)} REJECT pairs, e.g. {sorted(bad)[:4]} -- {reason}")
    # checker plants
    for plant, obj, want, reason in [
        ("closed_interval", None, "REJECT", "every exact contact at distance 1 turns REJECT: the strip is tight"),
        ("noself", "tall", "ACCEPT", "the tall plant's only REJECTs are self pairs, which noself skips"),
        ("endpoints_only", None, "ACCEPT", "unreachable here? (a REJECT needs an interior extreme; recorded either way)"),
        ("cw_arcs", None, "REJECT", "minor arcs become major arcs: diameters blow up")]:
        Y.PLANT = plant
        try:
            F, T, top, pairs, pairs2, v, bad = strip_run(obj)
        except AssertionError as e:
            v, bad = f"ASSERT({e})", []
        finally:
            Y.PLANT = None
        say(v == want, f"checker plant {plant:15s} on {obj or 'faithful'} strip: want {want} got {v} ({len(bad)} pairs) -- {reason}")


if __name__ == "__main__":
    secs = sys.argv[1:] or ["frags", "hex", "strip", "plants"]
    if "frags" in secs: frags()
    if "hex" in secs: hexs()
    if "strip" in secs: strip()
    if "plants" in secs: plants()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
