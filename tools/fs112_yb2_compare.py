#!/usr/bin/env python3
"""FS112-YB2's step 4 (read after my step 3 was committed at d231d771): FS112-Y2's disk object against mine, exactly.

Y2's builder (tools/fs112_y2_disk.py, run and imported, never edited) works in FS112-Y's tower over the radicands 5, 10 + 2 sqrt5, (sqrt5 - 1)/2,
(25 + 9 sqrt5)/10, stored as nested pairs a + b sqrt(d_k) exactly as my tower stores them; my disk's tower has the same four radicands in the same
order (the last computed as |C_0|^2, checked equal), so a value converts by re-wrapping.  Each of Y2's 26 tiles is matched to mine under the name map
C0 <-> Z, T1_k <-> P_k, T2_k <-> W_k, R_k <-> R_k, U_k <-> S_k, Up_k <-> T_{k+1}, colours Bl, G, Yw, O, P <-> blue, green, yellow, orange, violet, and
compared piece by piece as point sets (a segment by its two ends; an arc by centre, radius and its two ends -- both orientations are one point set only
when the ends are the same, and every arc here spans < 180 degrees).  Then Y2's three disk plants are run through MY checker beside the faithful twin.
Run: python3 tools/fs112_yb2_compare.py [objects] [plants]
"""
from __future__ import annotations
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_yb2_check as K   # noqa: E402
import fs112_yb2_objects as O   # noqa: E402
import fs112_y2_disk as Y2   # noqa: E402

COL = {"Bl": "blue", "G": "green", "Yw": "yellow", "O": "orange", "P": "violet", "R": "red"}


def name_map(n):
    if n == "C0":
        return "Z"
    kind, k = n.rsplit("_", 1)
    k = int(k)
    return {"T1": f"P{k}", "T2": f"W{k}", "R": f"R{k}", "U": f"S{k}", "Up": f"T{(k + 1) % 5}"}[kind]


def conv(T, x):
    return K.N(T, x.v)


def conv_tile(T, prims):
    out = []
    pt = lambda p: (conv(T, p[0]), conv(T, p[1]))
    for p in prims:
        if isinstance(p, Y2.Y.Seg):
            out.append(K.Seg(pt(p.P), pt(p.Q)))
        else:
            out.append(K.Arc(pt(p.C), conv(T, p.r), pt(p.S), pt(p.E)))
    return out


def same_piece(p, q):
    if p.kind != q.kind:
        return False
    ends_match = all(any(K.veq(x, y) for y in q.ends()) for x in p.ends())
    if p.kind == "S":
        return ends_match
    return ends_match and K.veq(p.C, q.C) and p.rho == q.rho


def compare_objects():
    Dk = O.Disk()
    T = Dk.T
    y2 = Y2.Disk()
    ok = True
    # the towers' radicands, value by value
    for k, (mine, theirs) in enumerate(zip(T.ds, y2.F.D[1:])):
        Tk = K.Tower(T.ds[:k], T.names[:k], None)
        eq = (K.N(Tk, mine) == K.N(Tk, theirs)) if k else (mine == theirs)
        ok &= eq
        print(f"   radicand {k + 1} ({T.names[k]}): mine equal to Y2's: {eq}")
    mine = Dk.tiles()
    n_same = 0
    for n, (c, prims) in sorted(y2.T.items()):
        m = name_map(n)
        mc, mp = mine[m]
        tp = conv_tile(T, prims)
        colour_ok = COL[c] == mc
        pieces_ok = len(tp) == len(mp) and all(any(same_piece(p, q) for q in mp) for p in tp)
        n_same += colour_ok and pieces_ok
        ok &= colour_ok and pieces_ok
        if not (colour_ok and pieces_ok):
            print(f"   DIFFERENT: Y2 {n} ({c}) vs mine {m} ({mc}): colour {colour_ok}, pieces {pieces_ok}")
    print(f"   tiles identical (colour and every piece as a point set): {n_same} of {len(y2.T)}")
    return ok, Dk, y2


def run_plants():
    Dk = O.Disk()
    T = Dk.T
    rows = []
    for plant, want in [(None, "ACCEPT"), ("chords", "REJECT"), ("swap", "REJECT"), ("ring2_short", "REJECT")]:
        y2 = Y2.Disk(plant=plant)
        tiles = {name_map(n): (COL[c], conv_tile(T, prims)) for n, (c, prims) in y2.T.items()}
        r, bad, npres = K.check_object(tiles)
        got = "REJECT" if bad else "ACCEPT"
        print(f"   Y2 plant {plant or 'none (faithful)':12s}: my checker {got} on {len(r)}/{npres} pairs, rejected {sorted(bad)}")
        rows.append((plant, got, sorted(bad)))
    return rows


if __name__ == "__main__":
    which = sys.argv[1:] or ["objects", "plants"]
    if "objects" in which:
        print("== Y2's disk against mine, tile by tile")
        ok, Dk, y2 = compare_objects()
        print("   OBJECTS", "IDENTICAL" if ok else "DIFFER")
    if "plants" in which:
        print("== Y2's disk plants through my checker (Y2's registered predictions, plans/FS112-Y-construction.md §5.0: chords -> the five "
              "(T1_k, T2_{k+3}); swap -> (T1_4, U_0), (T1_1, U'_0); ring2_short -> the five (C0, R_k) and the five (R_k, R_k))")
        run_plants()
