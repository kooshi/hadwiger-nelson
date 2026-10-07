#!/usr/bin/env python3
"""FS133-E1: an exact finite instance for C133-INV's infimum (plans/FS133-E1-derivation.md, stage 4).

The Moser spindle as seven points of the algebraic plane, in exact arithmetic over Q(s, t), s^2 = -3, t^2 = -<T> (T = 11):
0, 1, z, 1+z, w, wz, w(1+z) with z = (1+s)/2 (a sixth root of unity) and w = (5+t)/6.  Prints "<points> <unit pairs> <alpha>":
the number of points, of pairs at distance exactly 1, and the independence number of that graph (brute force over 2^7 subsets).
With T = 11 it must print "7 11 2", so alpha(G)/|G| = 2/7 for a finite G in E.  Fault: T = 13 (w is then not of modulus 1).
Usage: fs133_e1_spindle.py [T]
"""
import sys
from fractions import Fraction as Fr
from itertools import combinations
T = int(sys.argv[1]) if len(sys.argv) > 1 else 11
# elements a + b s + c t + d st as 4-tuples of Fractions
def mul(x, y):
    a, b, c, d = x; e, f, g, h = y
    return (a*e - 3*b*f - T*c*g + 3*T*d*h,
            a*f + b*e - T*c*h - T*d*g,
            a*g + c*e - 3*b*h - 3*d*f,
            a*h + d*e + b*g + c*f)
def add(x, y): return tuple(p + q for p, q in zip(x, y))
def sub(x, y): return tuple(p - q for p, q in zip(x, y))
def conj(x): return (x[0], -x[1], -x[2], x[3])
one = (Fr(1), Fr(0), Fr(0), Fr(0)); zero = (Fr(0),) * 4
z = (Fr(1, 2), Fr(1, 2), Fr(0), Fr(0)); w = (Fr(5, 6), Fr(0), Fr(1, 6), Fr(0))
pts = [zero, one, z, add(one, z), w, mul(w, z), mul(w, add(one, z))]
assert len(set(pts)) == 7
def unit(p, q):
    d = sub(p, q); return mul(d, conj(d)) == one
edges = [(i, j) for i, j in combinations(range(7), 2) if unit(pts[i], pts[j])]
alpha = max(len(c) for r in range(8) for c in combinations(range(7), r)
            if not any((i, j) in edges for i, j in combinations(c, 2)))
print(len(pts), len(edges), alpha)
