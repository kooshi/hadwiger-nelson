#!/usr/bin/env python3
"""FS131-E8 § 6.1 — the model of FS131-E8-BRANCH's second alternative, exactly: SQ9 at the vertex z = (1/2, 1/2).
SQ9 colours the half-open square [i/2, (i+1)/2) × [j/2, (j+1)/2) by (i mod 3, j mod 3). Branch m of the fan at z runs along
e(d_m), d_m = mπ/2; the region counter-clockwise of it is the square between branches m and m+1, the clockwise one between m−1 and m.
The claim: z + i e(d_m) lies in the support of the clockwise colour and z − i e(d_m) in the support of the counter-clockwise colour
(a grid vertex is in the support of the colours of the four squares at it). Prints the number of the eight memberships that fail.
Usage: e8_sq9_contacts.py [--swap]      (the planted fault: --swap exchanges the two contact points)"""
import sys
from fractions import Fraction as F
swap = "--swap" in sys.argv
def col(x, y):
    return ((2 * x).__floor__() % 3, (2 * y).__floor__() % 3)
def colours_at_vertex(x, y):
    q = F(1, 4)
    return {col(x + sx * q, y + sy * q) for sx in (1, -1) for sy in (1, -1)}
z = (F(1, 2), F(1, 2))
E = [(1, 0), (0, 1), (-1, 0), (0, -1)]           # e(d_m)
q = F(1, 4)
bad = 0
for m in range(4):
    e, nxt, prv = E[m], E[(m + 1) % 4], E[(m - 1) % 4]
    ccw = col(z[0] + q * (e[0] + nxt[0]), z[1] + q * (e[1] + nxt[1]))
    cw = col(z[0] + q * (e[0] + prv[0]), z[1] + q * (e[1] + prv[1]))
    ie = (-e[1], e[0])                              # i e(d_m)
    plus = (z[0] + ie[0], z[1] + ie[1]); minus = (z[0] - ie[0], z[1] - ie[1])
    if swap: plus, minus = minus, plus
    bad += cw not in colours_at_vertex(*plus)
    bad += ccw not in colours_at_vertex(*minus)
print(bad)
