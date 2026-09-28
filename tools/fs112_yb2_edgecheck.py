#!/usr/bin/env python3
"""FS112-YB2, step 4: the strip's stop point X_1 = (1/4, Y) at a finite offset, in FS112-Y2's own terms (a straddle test against every tile at
z = X_1 + e(theta)/100, exact), at rational directions theta ~ 10, 20, 160, 170 degrees (e(theta) = ((1 - t^2), 2t)/(1 + t^2), t rational).
Registered before the run (from the exact first-order cone (14.48, 165.52) of stage 5): theta ~ 20 and ~ 160: NO colour; theta ~ 10: orange free;
theta ~ 170: red free.  Y2 tested only 30, 60, ..., 150 and stated the wedge (30, 165.52)."""
import os
import sys
import math
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K       # noqa: E402
import fs112_yb2_objects as O     # noqa: E402
import fs112_yb2_analysis as A    # noqa: E402

S = O.Strip()
T = S.T
tiles = S.tiles(-4, 6)
X1 = (T(Fr(1, 4)), S.Y)
for t in (Fr(7, 80), Fr(3, 17), Fr(17, 3), Fr(80, 7)):
    c, s = (1 - t * t) / (1 + t * t), 2 * t / (1 + t * t)
    th = math.degrees(math.atan2(float(s), float(c)))
    z = (X1[0] + T(c) / 100, X1[1] + T(s) / 100)
    free = []
    for col in sorted({c_ for c_, _ in tiles.values()}):
        blocked = False
        for nm, (c_, ps) in tiles.items():
            if c_ != col:
                continue
            mn, mx, eq = A.point_tile(z, ps)
            if mn == "<" and mx == ">":
                blocked = True
                break
        if not blocked:
            free.append(col)
    print(f"z = X_1 + e({th:.3f} deg)/100: colours free at z (no tile of the colour straddles distance 1): {free if free else 'NONE'}")
