#!/usr/bin/env python3
"""FS131-E3 (E3-FAKE): a vertex whose repeated colour is mergeable defeats the shadow argument of steps 5/6 at that vertex.

Angles in units of pi, exact.  At a point v with cones K_c (closed arcs), the inner collar about psi lies in the shadow of
colour c iff K_c meets the open far half (psi + 1/2, psi + 3/2); it fails for c iff K_c lies in the closed near half
[psi - 1/2, psi + 1/2].  The outer collar fails for c iff K_c lies in [psi + 1/2, psi + 3/2].  Townsend's lemma (and step 6)
needs both sides to fail only at finitely many psi.  We count the grid points psi = m/720, 0 <= m < 1440, where some colour
fails inside and some colour fails outside.
Default picture (the fake vertex): A [0,1/2], B [1/2,2/3], A [2/3,4/3], C [4/3,2]  (B and C not adjacent).
--fault: the normal-form picture A [0,1/2], B [1/2,2/3], C [2/3,4/3], A [4/3,2] - B and C adjacent (A is then one sector).
"""
from fractions import Fraction as Q
import sys

def red(x):
    return x - 2 * (x // 2)

def inside(arc, lo):
    # arc = (a, b) with 0 <= b - a <= 2; is it contained in the closed arc [lo, lo + 1] (mod 2)?
    a, b = arc
    s = red(a - lo)
    return s + (b - a) <= 1

def fails(K, lo):
    return all(inside(arc, lo) for arc in K)

def main():
    fault = "--fault" in sys.argv
    if fault:
        sect = [("A", 0, Q(1, 2)), ("B", Q(1, 2), Q(2, 3)), ("C", Q(2, 3), Q(4, 3)), ("A", Q(4, 3), 2)]
    else:
        sect = [("A", 0, Q(1, 2)), ("B", Q(1, 2), Q(2, 3)), ("A", Q(2, 3), Q(4, 3)), ("C", Q(4, 3), 2)]
    cones = {}
    for (col, a, b) in sect:
        cones.setdefault(col, []).append((Q(a), Q(b)))
    bad = 0
    N = 1440
    for m in range(N):
        psi = Q(m, 720)
        inner_fail = any(fails(K, psi - Q(1, 2)) for K in cones.values())
        outer_fail = any(fails(K, psi + Q(1, 2)) for K in cones.values())
        if inner_fail and outer_fail:
            bad += 1
    print("bad=%d of %d" % (bad, N))

if __name__ == "__main__":
    main()
