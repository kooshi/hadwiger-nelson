#!/usr/bin/env python3
"""FS110-YB3 stage 4 — FS110-Y3's six named rings (plans/FS110-Y-construction.md stage 9 table), rebuilt from their formulas and run through
MY checker (tools/fs110_yb3_ring.py's Ring class), plus the six-arc three-colour W = 0 ring d,e,d,f,e,f (Y3-SIX §8.5's pattern remark).
Exit 0 iff every ring is valid, W and GP match the side's table, Y3-GP holds on the GP ones, and the extra ring has six arcs and W = 0."""
import sys
from fractions import Fraction as F
sys.path.insert(0, "tools")
import fs110_yb3_ring as R  # noqa: E402

theirs = [
    ("Y-alternating", [60 * k for k in range(6)], [k % 2 for k in range(6)], 0, False),
    ("Y-r0r1r2-twice", [60 * k for k in range(6)], [k % 3 for k in range(6)], 2, False),
    ("Y-r0r1r2-thrice", [40 * k for k in range(9)], [k % 3 for k in range(9)], 3, False),
    ("Y-41k", [41 * k for k in range(9)], [k % 3 for k in range(9)], 3, True),
    ("Y-41k-mirror", [41 * k for k in range(9)], [(-k) % 3 for k in range(9)], -3, True),
    ("Y-27", [F(40 * k, 3) + F(k, 1000) for k in range(27)], [k % 3 for k in range(27)], 9, True),
]
bad = []
for name, pts, cols, Wt, gpt in theirs:
    r = R.Ring(name, pts, cols, "gp" if gpt else "aligned")
    v, W, g = r.valid(), r.W(), r.gp()
    gs, ms, sums, _ = r.mechanism()
    print(f"{name:18s} valid={v} W={W:3d} (side {Wt:3d}) GP={g} (side {gpt}) m={sorted(ms)} g={sorted(gs)}")
    if not v or W != Wt or g != gpt or sums != {3 * W} or (g and (W % 6 != 3 or ms != {3})):
        bad.append(name)
x = R.Ring("six-arc-W0-three-colour", [60 * k for k in range(6)], [0, 1, 0, 2, 1, 2], "aligned")
print(f"{x.name:18s} valid={x.valid()} W={x.W()} arcs={len(x.x)} colours={sorted(set(x.c))}")
if not (x.valid() and x.W() == 0 and len(set(x.c)) == 3):
    bad.append(x.name)
print("RESULT:", "ALL MATCH" if not bad else f"MISMATCH {bad}")
sys.exit(0 if not bad else 1)
