#!/usr/bin/env python3
"""FS131-E4: a small exact model of the enclosure case, the receipt for the recognition's sort.

The map (exact rationals; units are the unit distance): domain the open disc |z| < 9/20 about 0.
  arcs: the circles |z| = 1/10 and |z| = 3/10; the segment [-1/10, 1/10] x {0};
        three radial segments from radius 3/10 to the domain's edge along the rational unit directions
        (0, 1), (-4/5, -3/5), (4/5, -3/5).
  colours: |z| < 1/10: 5 above the segment, 6 below (u's tiles R_5, R_6, in the hole);
           1/10 < |z| < 3/10: 4 (the enclosing tile R_4, an annulus);
           3/10 < |z| < 9/20: 1, 2, 3 in the three sectors cut by the radial segments.
  u = (1/10, 0): the vertex where R_4, R_5, R_6 meet. Its other C|C neighbour is u' = (-1/10, 0).

Checked exactly: the domain's diameter is below 1 (so the fragment is valid); the candidate vertices (all segment
endpoints and circle-segment meetings inside the domain; no other two arcs meet) carry, by sampling 72 rational
directions at radius 1/1000, the sector colours stated; no point has a repeated colour or four colours; R_4 holds every
sampled direction at radius 1/5 about 0 (it surrounds the hole); and the count of three-colour points carrying exactly two
of u's colours (the eleventh point's type) is printed.

--fault  breaks the annulus: the annular sector between the directions (3/5, -4/5) and (0, -1) becomes colour 5, cut off by
         two radial segments. The model's own check must then find eleventh points on the enclosing rim.
"""
import sys
from fractions import Fraction as Q
import math

FAULT = "--fault" in sys.argv
R1, R2, RD = Q(1, 10), Q(3, 10), Q(9, 20)
DIRS_OUT = [(Q(0), Q(1)), (Q(-4, 5), Q(-3, 5)), (Q(4, 5), Q(-3, 5))]  # radial cuts of the outer ring
FD = [(Q(3, 5), Q(-4, 5)), (Q(0), Q(-1))]  # the fault's radial cuts in the annulus


def cross(a, b):
    return a[0] * b[1] - a[1] * b[0]


def in_ccw_sector(p, d1, d2):
    """p strictly inside the counter-clockwise open sector from direction d1 to direction d2 (convex, < 180 deg)."""
    return cross(d1, p) > 0 and cross(p, d2) > 0


def segments():
    segs = [((-R1, Q(0)), (R1, Q(0)))]
    for d in DIRS_OUT:
        segs.append(((R2 * d[0], R2 * d[1]), (RD * d[0], RD * d[1])))
    if FAULT:
        for d in FD:
            segs.append(((R1 * d[0], R1 * d[1]), (R2 * d[0], R2 * d[1])))
    return segs


def on_segment(p, s):
    a, b = s
    v, w = (b[0] - a[0], b[1] - a[1]), (p[0] - a[0], p[1] - a[1])
    if cross(v, w) != 0:
        return False
    t = (w[0] * v[0] + w[1] * v[1]) / (v[0] ** 2 + v[1] ** 2)
    return 0 <= t <= 1


def colour(p):
    """The colour at an interior point; raises if p is on an arc or outside the domain."""
    r2 = p[0] ** 2 + p[1] ** 2
    if r2 >= RD ** 2:
        raise ValueError("outside the domain")
    if r2 in (R1 ** 2, R2 ** 2) or any(on_segment(p, s) for s in segments()):
        raise ValueError(f"on an arc: {p}")
    if r2 < R1 ** 2:
        return 5 if p[1] > 0 else 6
    if r2 < R2 ** 2:
        if FAULT and in_ccw_sector(p, FD[1], FD[0]):
            return 5
        return 4
    d0, d1, d2 = DIRS_OUT  # (0,1) -> (-4/5,-3/5) ccw is colour 1, then 2, then 3
    if in_ccw_sector(p, d0, d1):
        return 1
    if in_ccw_sector(p, d1, d2):
        return 2
    if in_ccw_sector(p, d2, d0):
        return 3
    raise ValueError(f"no sector: {p}")


def directions(n=72):
    out = []
    for k in range(n):
        th = (2.5 + 360.0 * k / n) * math.pi / 180
        t = Q(math.tan(th / 2)).limit_denominator(10 ** 6)
        out.append(((1 - t * t) / (1 + t * t), 2 * t / (1 + t * t)))
    return out


DIRS = directions()


def sectors(p, eps=Q(1, 1000)):
    """The cyclic sequence of colour runs about p (each run a sector), sampled at radius eps."""
    cols = [colour((p[0] + eps * d[0], p[1] + eps * d[1])) for d in DIRS]
    runs = [c for i, c in enumerate(cols) if c != cols[i - 1]]
    return runs if runs else [cols[0]]


def candidates():
    pts = set()
    for a, b in segments():
        for p in (a, b):
            if p[0] ** 2 + p[1] ** 2 < RD ** 2:
                pts.add(p)
    return sorted(pts)


# validity: every two points of the domain are closer than 1
diameter_ok = 2 * RD < 1
# no other meeting of arcs: radial cuts start on a circle and cross no other; the chord [-1/10, 1/10] ends on the inner circle
U = (R1, Q(0))
rows, bad, eleventh = [], 0, 0
CU = set(sectors(U))
for p in candidates():
    s = sectors(p)
    rep = len(s) != len(set(s))
    four = len(set(s)) >= 4
    bad += rep or four
    if len(set(s)) == 3 and len(set(s) & CU) == 2:
        eleventh += 1
    rows.append((p, s))
surround = all(colour((Q(1, 5) * d[0], Q(1, 5) * d[1])) == 4 for d in DIRS)
cubic_u = sorted(sectors(U)) == [4, 5, 6]
print(f"valid={diameter_ok} cubic_u={cubic_u} vertices={len(rows)} bad={bad} encloses={surround} eleventh={eleventh}")
if "--verbose" in sys.argv:
    for p, s in rows:
        print(f"  {p[0]},{p[1]}: {s}")
