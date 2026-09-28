#!/usr/bin/env python3
"""FS114-YB: my rebuilds of the strip and the disk against FS-112's held builders (FS112-YB2's `tools/fs112_yb2_objects.py`, imported and run,
never edited).  Each tile is reduced to its colour and its set of pieces -- a segment by its two ends, an arc by its two ends, centre and radius --
in floating point rounded to 1e-9 (a comparison of two rebuilds, not a verdict; the verdicts are exact).  Labels differ (YB2 names the disk's
tiles Z, W_k, P_k, R_k, S_k, T_k; I use Y2's C0, T2_k, T1_k, R_k, U_k, U'_k), so tiles are matched by their piece sets, and the label map is printed.

Run: python3 tools/fs114_yb_compare.py
"""
from __future__ import annotations
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_objects as O    # noqa: E402
import fs112_yb2_objects as Y2O  # noqa: E402  (FS112-YB2's builder: imported and run, never edited)

R = 9


def fp(p):
    return (round(float(p[0]), R) + 0.0, round(float(p[1]), R) + 0.0)


def key_mine(t):
    ps = []
    for pc in t.pieces:
        ends = tuple(sorted([fp(pc.P), fp(pc.Q)]))
        if pc.kind == "S":
            ps.append(("S", ends))
        else:
            ps.append(("A", ends, fp(pc.C), round(float(pc.rho), R)))
    return frozenset(ps)


def key_held(ps):
    out = []
    for pc in ps:
        if pc.kind == "S":
            out.append(("S", tuple(sorted([fp(pc.P), fp(pc.Q)]))))
        else:
            out.append(("A", tuple(sorted([fp(pc.S), fp(pc.E)])), fp(pc.C), round(float(pc.rho), R)))
    return frozenset(out)


def compare(mine, held, cmap=lambda c: c):
    hk = {key_held(ps): (nm, col) for nm, (col, ps) in held.items()}
    lm, bad = {}, []
    for t in mine:
        k = key_mine(t)
        if k in hk:
            nm, col = hk[k]
            if cmap(col) != t.colour:
                bad.append((t.name, nm, "colour", t.colour, col))
            lm[t.name] = nm
        else:
            bad.append((t.name, None, "no held tile with these pieces"))
    return lm, bad


def main():
    Dk = O.Disk()
    mine = Dk.tiles()
    held = Y2O.Disk().tiles()
    lm, bad = compare(mine, held, cmap=lambda c: "purple" if c == "violet" else c)
    print(f"disk: {len(lm)} of {len(mine)} of my tiles match a held tile piece for piece and colour for colour; held tiles {len(held)}; "
          f"mismatches {len(bad)}")
    print("   label map (mine -> FS112-YB2's): " + ", ".join(f"{a}->{b}" for a, b in lm.items()))
    for b in bad:
        print("   MISMATCH", b)
    S = O.Strip()
    mine_s = S.tiles(-3, 5)
    held_s = Y2O.Strip().tiles(-3, 5)
    lm, bad = compare(mine_s, held_s)
    print(f"strip (columns -3..5): {len(lm)} of {len(mine_s)} of my tiles match a held tile piece for piece and colour for colour; mismatches {len(bad)}")
    same = all(a == b for a, b in lm.items())
    print(f"   labels identical (U, D, T, B with the same index): {same}")
    for b in bad:
        print("   MISMATCH", b)


if __name__ == "__main__" and len(sys.argv) == 1:
    main()


# ================================================================ stage 2: against FS114-Y's objects (after my stage 1 was committed)
def _f(x):
    return float(x.f()) if hasattr(x, "f") else float(x)


def _fp2(p):
    return (round(_f(p[0]), R) + 0.0, round(_f(p[1]), R) + 0.0)


def key_y(ps):
    """a tile of FS112-Y's format (Seg.P/Q; Arc.C/r/S/E) or FS112-YB2's (Arc.C/rho/S/E) as (vertex set, arc circle set)."""
    verts, circ = set(), set()
    for pc in ps:
        if hasattr(pc, "C"):
            verts |= {_fp2(pc.S), _fp2(pc.E)}
            rad = pc.rho if hasattr(pc, "rho") else pc.r
            circ.add((_fp2(pc.C), round(_f(rad), R)))
        else:
            verts |= {_fp2(pc.P), _fp2(pc.Q)}
    return frozenset(verts), frozenset(circ)


def key_mine2(t):
    verts, circ = set(), set()
    for pc in t.pieces:
        verts |= {fp(pc.P), fp(pc.Q)}
        if pc.kind == "A":
            circ.add((fp(pc.C), round(float(pc.rho), R)))
    return frozenset(verts), frozenset(circ)


def stage2():
    import fs114_y_dial as YD          # FS114-Y's capped strip (read and run after my stage 1; never edited)
    import fs112_y2_dial as DL         # FS112-Y2's moved disk, which FS114-Y's routes use (run, never edited)
    mine = O.Strip(capped=True).tiles(-3, 5)
    theirs = YD.CappedStrip().tiles(-3, 5)
    hk = {key_y(ps): (nm, col) for nm, (col, ps) in theirs.items()}
    ok = bad = 0
    for t in mine:
        k = key_mine2(t)
        if k in hk and hk[k][0] == t.name and hk[k][1] == t.colour:
            ok += 1
        else:
            bad += 1
            print("   capped strip MISMATCH", t.name, hk.get(k))
    print(f"capped strip (columns -3..5): {ok} of {len(mine)} of my tiles equal FS114-Y's tile of the same name and colour (vertex set and arc "
          f"circles to 1e-9); mismatches {bad}")
    M = DL.MovedDisk()
    mine = O.Disk(moved=True).tiles()
    cmap = {"R": "red", "Bl": "blue", "G": "green", "Yw": "yellow", "O": "orange", "P": "purple"}
    hk = {key_y(ps): (nm, col) for nm, (col, ps) in M.T.items()}
    ok = bad = 0
    lm = {}
    for t in mine:
        k = key_mine2(t)
        if k in hk and cmap.get(hk[k][1], hk[k][1]) == t.colour:
            ok += 1
            lm[t.name] = hk[k][0]
        else:
            bad += 1
            print("   moved disk MISMATCH", t.name, t.colour, "held:", [(nm, c) for kk, (nm, c) in hk.items() if kk[0] == k[0]])
    print(f"moved disk: {ok} of {len(mine)} of my tiles match a tile of FS112-Y2's MovedDisk (vertex set, arc circles, colour); mismatches {bad}")
    print("   label map (mine -> FS112-Y2's): " + ", ".join(f"{a}->{b}" for a, b in lm.items() if a != b.replace("Up_", "U'_")) or "   labels identical up to U' = Up")


if __name__ == "__main__" and len(sys.argv) > 1 and sys.argv[1] == "stage2":
    stage2()
