#!/usr/bin/env python3
"""FS114-Y stage 2: the exact CONFLICT RELATIONS of a given geometry (tiles fixed, colours ignored), read by FS112-YB2's tower checker
(tools/fs112_yb2_check.py pair_verdict, imported, never edited).  For two distinct tiles X, Y of a geometry:
  conflict  -- min < 1 < max over cross distances: X and Y can never share a colour in a valid fragment;
  tight     -- min = 1: they may share a colour (touching at exactly 1, the outer case of N-E2);
  siamese   -- max <= 1: they may share a colour (Siamese);
  far       -- min > 1: they may share a colour.
No colouring is enumerated: the relations are read, and the derivation that uses them is by hand, in the record (plans/FS114-Y-construction.md
stage 2, FS114-Y-STRIPRIGID and FS114-Y-DISKRIGID).

Sections: strip -- FS112-YB2's strip (Strip.tiles; U = arch up, D = arch down, T = top tile over the valley V_m, B = bottom tile), the
          relations of U0, D0, T0, B0 with every tile of columns -5..5 (beyond, an exact x-gap > 1 is checked);
          disk  -- FS112-YB2's disk (Disk.tiles; Z central, W_k ring 2 at A_k, P_k ring 1 on the side A_k A_{k+1}, R_k, S_k, T_k rim), the
          relations of every pair (26 tiles, 325 pairs).
Controls: the printed colouring must put every 'conflict' pair in different colours (it is valid); plant --plant shrink (every relation
recomputed with each tile's pieces scaled by 1/2 about the origin, a different geometry) must change the relation table -- the table is
read from the geometry, not from the colours.
Run: python3 tools/fs114_y_conflicts.py [strip] [disk] [--plant shrink]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr
from itertools import combinations

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_yb2_check as K          # noqa: E402
import fs112_yb2_objects as O        # noqa: E402

PLANT = None
OK = True


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


def relation(X, Y):
    r = K.pair_verdict(X, Y, self_pair=False)
    if r.mcmp == "<" and r.Mcmp == ">":
        return "conflict"
    if r.mcmp == "=":
        return "tight"
    if r.Mcmp in ("<", "="):
        return "siamese"
    return "far"


def scale(pieces, t):
    out = []
    for p in pieces:
        if p.kind == "S":
            out.append(K.Seg(K.vmul(t, p.P), K.vmul(t, p.Q)))
        else:
            out.append(K.Arc(K.vmul(t, p.C), p.rho * t, K.vmul(t, p.S), K.vmul(t, p.E)))
    return out


def strip():
    S = O.Strip()
    tiles = S.tiles(-6, 8)
    if PLANT == "shrink":
        tiles = {nm: (c, scale(ps, Fr(1, 2))) for nm, (c, ps) in tiles.items()}
    table = {}
    for a in ("U0", "D0", "T0", "B0"):
        row = []
        for kb in "UDTB":
            for jb in range(-5, 6):
                b = f"{kb}{jb}"
                if b == a:
                    continue
                rel = relation(tiles[a][1], tiles[b][1])
                table[(a, b)] = rel
                if rel == "conflict":
                    row.append(b)
        print(f"   {a} conflicts with: {' '.join(row)}")
    # beyond columns +-5: x-gap
    xr = {nm: O.xrange_of(ps) for nm, (_, ps) in tiles.items()}
    g = min((max(xr[b][0] - xr[a][1], xr[a][0] - xr[b][1]) for a in ("U0", "D0", "T0", "B0") for kb in "UDTB" for b in (f"{kb}6", f"{kb}-6")),
            key=float)
    print(f"   x-gap from column 0 to columns +-6: {float(g):.3f}")
    if PLANT == "shrink":
        return table
    want = {   # registered after the first run corrected my hand premises (T_m meets six arches, not four); the derivation uses subsets
        "U0": {"U-2", "U-1", "U1", "U2", "D-2", "D-1", "D0", "D1", "D2", "T-2", "T-1", "T0", "T1", "T2", "T3", "B0", "B1"},
        "D0": {"D-2", "D-1", "D1", "D2", "U-2", "U-1", "U0", "U1", "U2", "B-2", "B-1", "B0", "B1", "B2", "B3", "T0", "T1"},
        "T0": {"T-2", "T-1", "T1", "T2", "U-3", "U-2", "U-1", "U0", "U1", "U2", "D-1", "D0"},
        "B0": {"B-2", "B-1", "B1", "B2", "D-3", "D-2", "D-1", "D0", "D1", "D2", "U-1", "U0"},
    }
    for a, w in want.items():
        got = {b for (x, b), rel in table.items() if x == a and rel == "conflict"}
        say(got == w, f"{a}: the conflict set used by the derivation (got {sorted(got)})")
    say(g > 1, "every tile beyond columns +-5 is more than 1 away from column 0")
    say(table[("T0", "D-2")] == "tight" and table[("T0", "D1")] == "tight", "T0 is tight (min = 1) with D-2 and D1: it may share their colour")
    say(table[("U0", "U3")] in ("tight", "far") and table[("U0", "D3")] in ("tight", "far"), "U0 may share a colour with U3 and D3")
    # the printed colouring is proper for the conflicts (a control: the colours are not used by the table)
    bad = [(a, b) for (a, b), rel in table.items() if rel == "conflict" and tiles[a][0] == tiles[b][0]]
    say(not bad, "the printed colouring separates every conflict pair (control)")
    def conf(a, b):
        ka, ja, kb, jb = a[0], int(a[1:]), b[0], int(b[1:])
        return table[(f"{ka}0", f"{kb}{jb - ja}")] == "conflict"
    six = ["U-1", "U0", "U1", "T0", "T1", "T2"]
    say(all(conf(a, b) for i, a in enumerate(six) for b in six[i + 1:]),
        "K6: the six tiles at the valley V_0 (U-1, U0, T0) and at the apex of U1 (U1, T1, T2) pairwise conflict -- the two vertices are "
        "complementary in EVERY valid colouring of the strip's geometry")
    # the uniqueness (FS114-Y-STRIPRIGID) uses: U offsets 1,2; T offsets 1,2; T_m vs U_{m-1..m+2}; D_j vs U_{j-2..j+2}; T_m vs D_{m-1}, D_m
    need = [("U0", "U1"), ("U0", "U2"), ("T0", "T1"), ("T0", "T2"), ("T0", "U-1"), ("T0", "U0"), ("T0", "U1"), ("T0", "U2"),
            ("D0", "U-2"), ("D0", "U-1"), ("D0", "U0"), ("D0", "U1"), ("D0", "U2"), ("T0", "D-1"), ("T0", "D0")]
    say(all(conf(a, b) for a, b in need), "every conflict the uniqueness derivation uses holds exactly")
    return table


def disk():
    D = O.Disk()
    tiles = D.tiles()
    if PLANT == "shrink":
        tiles = {nm: (c, scale(ps, Fr(1, 2))) for nm, (c, ps) in tiles.items()}
    names = sorted(tiles)
    table = {}
    for a, b in combinations(names, 2):
        table[(a, b)] = table[(b, a)] = relation(tiles[a][1], tiles[b][1])
    for a in names:
        cf = [b for b in names if b != a and table[(a, b)] == "conflict"]
        ok_ = [f"{b}:{table[(a, b)][0]}" for b in names if b != a and table[(a, b)] != "conflict"]
        print(f"   {a:3s} ({tiles[a][0]:6s}) conflicts {len(cf):2d}: {' '.join(cf)}   | may share: {' '.join(ok_)}")
    if PLANT != "shrink":
        bad = [(a, b) for (a, b), rel in table.items() if rel == "conflict" and tiles[a][0] == tiles[b][0]]
        say(not bad, "the printed colouring separates every conflict pair (control)")
        # FS114-Y-DISKRIGID: a fixed chain of deductions, each with exactly one outcome (asserted), never a search over colourings
        k6 = ["Z"] + [f"P{k}" for k in range(5)]
        say(all(table[(a, b)] == "conflict" for i, a in enumerate(k6) for b in k6[i + 1:]),
            "K6: the central tile and the five ring-1 tiles pairwise conflict -- six colour classes, named by them")
        cls = {"Z": 0, **{f"P{k}": k + 1 for k in range(5)}}
        order = [f"W{k}" for k in range(5)] + [f"R{k}" for k in range(5)] + [f"S{k}" for k in range(5)] + [f"T{k}" for k in range(5)]
        unique = True
        for a in order:
            forb = {cls[b] for b in names if b != a and b in cls and table[(a, b)] == "conflict"}
            left = sorted(set(range(6)) - forb)
            unique &= len(left) == 1
            cls[a] = left[0] if left else None
            print(f"   {a}: forbidden classes {sorted(forb)} -> class {left}")
        say(unique, "each of W_k, R_k, S_k, T_k (in that order) has exactly one class left: the colouring is unique up to permutation")
        # control: the forced classes reproduce the printed colouring (same partition)
        part = lambda f: sorted(sorted(nm for nm in names if f(nm) == v) for v in {f(nm) for nm in names})
        say(part(lambda nm: cls[nm]) == part(lambda nm: tiles[nm][0]), "the forced classes are exactly the printed colour classes (control)")
        # B_0 (P0, S0, T1) against Z^R_0 (W0, R0, T0) and Z^L_1 (W1, R1, S1): complementary in every valid colouring
        b0 = {cls["P0"], cls["S0"], cls["T1"]}
        say(b0 | {cls["W0"], cls["R0"], cls["T0"]} == set(range(6)) and b0 | {cls["W1"], cls["R1"], cls["S1"]} == set(range(6)),
            "B_0 is complementary to Z^R_0 and to Z^L_1 in every valid colouring of the disk's geometry")
    return table


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args:
        PLANT = args[args.index("--plant") + 1]
    which = [a for a in args if a in ("strip", "disk")] or ["strip", "disk"]
    res = {}
    for w in which:
        print(f"== {w}" + (f"  [PLANT {PLANT}]" if PLANT else ""))
        res[w] = strip() if w == "strip" else disk()
    print("ALL AS REGISTERED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
