#!/usr/bin/env python3
"""FS133-E1: exact control for the counting step of C133-CHIF (plans/FS133-E1-derivation.md, stage 5).

An L-periodic set U that is a union of n grid squares of side s (L/s an integer), and the (L/s)^2 translates U + t,
t in s*Z^2 modulo L*Z^2.  The derivation says: with HALF-OPEN squares [a, a+s) x [b, b+s), every point of the plane lies in
exactly n of the translates.  This script takes L = 3, s = 1/2, the n = 16 cells (i, j) with (i*i + 3*j) % 5 in {0, 1},
tests every point of the grid (s/4)*Z^2 in one period (cell interiors, edges and corners), and prints n and the sorted list of
distinct counts.  Mode 'halfopen' must print "16 [16]"; mode 'closed' (the fault: closed squares) prints more than one count.
(Placed under data/fs133/e1/ at the coordinator's word of 2026-10-07: new scripts are not written into tools/.)
"""
import sys
from fractions import Fraction as Fr
mode = sys.argv[1]
L, s = Fr(3), Fr(1, 2)
m = int(L / s)
cells = [(i, j) for i in range(m) for j in range(m) if (i * i + 3 * j) % 5 in (0, 1)]
def inside(c, lo):
    c %= L
    if mode == "halfopen":
        return lo <= c < lo + s
    return (lo <= c <= lo + s) or (lo == 0 and c == 0) or (lo + s == L and c == 0)   # closed, modulo L
def in_U(x, y):
    return any(inside(x, i * s) and inside(y, j * s) for i, j in cells)
counts = set()
q = s / 4
for a in range(4 * m):
    for b in range(4 * m):
        x, y = a * q, b * q
        counts.add(sum(in_U(x - ti * s, y - tj * s) for ti in range(m) for tj in range(m)))
print(len(cells), sorted(counts))
