#!/usr/bin/env python3
"""FS131-E3: the phantom-horn picture, checked against SectorsAt's clauses exactly.

Angles are exact rationals in units of pi.  A picture is (d, c): d monotone of length n+1, c of length n.
SectorsAt's clauses (Plane/Woodall/Basic.lean at f73cb1e3), read as data:
  0 < n;  d monotone;  d[n] = d[0] + 2;  (n >= 2 -> c[i] != c[(i+1) % n]);
  for every colour j: cone(j) = union over {i : c[i] = j} of angleIcc(d[i], d[i+1])   (mod 2, closed arcs).
The model point: the midpoint of the edge between two adjacent hexagons of the hexagonal seven-colouring,
colour(a, b) = (a + 3b) mod 7 on the triangular lattice; the edge between centres (0,0) and (1,0) is
perpendicular to the direction 0, so hexagon (1,0) holds the directions [-1/2, 1/2] and hexagon (0,0) holds [1/2, 3/2].
The honest picture is n = 2; the phantom inserts a B-horn then an A-horn at the boundary direction 1/2.
--fault inserts only the A-horn (adjacency must fail).
"""
from fractions import Fraction as Q
import sys

def colour(a, b):
    return (a + 3 * b) % 7

def red(x):
    return x - 2 * (x // 2)

def arcs_of(d, c, j):
    return [(d[i], d[i + 1]) for i in range(len(c)) if c[i] == j]

def member(x, arcs):
    x = red(x)
    for (a, b) in arcs:
        if b - a >= 2:
            return True
        if red(x - a) <= b - a:
            return True
    return False

def same_set(A, B):
    pts = set()
    for (a, b) in A + B:
        pts.add(red(a)); pts.add(red(b))
    pts = sorted(pts) or [Q(0)]
    tests = list(pts)
    for k in range(len(pts)):
        nxt = pts[k + 1] if k + 1 < len(pts) else pts[0] + 2
        tests.append((pts[k] + nxt) / 2)
    return all(member(t, A) == member(t, B) for t in tests)

def is_picture(d, c, cones, k):
    n = len(c)
    if n <= 0 or len(d) != n + 1:
        return False, "shape"
    if any(d[i] > d[i + 1] for i in range(n)):
        return False, "monotone"
    if d[n] != d[0] + 2:
        return False, "wrap"
    if n >= 2 and any(c[i] == c[(i + 1) % n] for i in range(n)):
        return False, "adjacent"
    for j in range(k):
        if not same_set(arcs_of(d, c, j), cones.get(j, [])):
            return False, "cone(%d)" % j
    return True, "ok"

def merged(d, c):
    n = len(c)
    for i in range(n):
        for j in range(n):
            if i != j and c[i] == c[j] and not (d[i] == d[i + 1] and d[j] == d[j + 1]):
                return False
    return True

def main():
    fault = "--fault" in sys.argv
    A, B = colour(1, 0), colour(0, 0)          # A on [-1/2, 1/2], B on [1/2, 3/2]
    assert A != B
    cones = {A: [(Q(-1, 2), Q(1, 2))], B: [(Q(1, 2), Q(3, 2))]}
    d0, c0 = [Q(-1, 2), Q(1, 2), Q(3, 2)], [A, B]
    ok0, why0 = is_picture(d0, c0, cones, 7)
    th = Q(1, 2)
    if fault:
        d1, c1 = [Q(-1, 2), th, th, Q(3, 2)], [A, A, B]
    else:
        d1, c1 = [Q(-1, 2), th, th, th, Q(3, 2)], [A, B, A, B]
    ok1, why1 = is_picture(d1, c1, cones, 7)
    print("honest=%s:%s merged=%s phantom=%s:%s phantom_merged=%s" % (
        ok0, why0, merged(d0, c0), ok1, why1, merged(d1, c1)))

if __name__ == "__main__":
    main()
