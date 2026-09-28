#!/usr/bin/env python3
"""FS111-W — sampled exact check of FS111-W-HEX7-RIGID: in the tight hexagonal seven-colouring (hex7 of
tools/fs111_w_check.py) the only colours that are *free* at a point p (every tile u of that colour has dist(p, u) > 1 or
maxdist(p, u) < 1, strictly -- so a small disc about p may take that colour without a unit pair of interior points) are
the colours of the tiles containing p and, near an edge, the colour across that edge.  No third colour is free at any
sampled interface point, and no two foreign colours are free at any sampled interior point.

Sample (exact arithmetic in Q(sqrt3)): the 19 interior points t = k/20 of each of the base hexagon's six edges, and the
points (i*sqrt3/20, j/20) of the closed base hexagon.  A sample, not a proof: the proof is the half-plane argument of
plans/FS111-W-wild.md stage 2 (section 2.5).  Planted fault (--plant): the same test on hex7 at circumradius 2/5 (slack
0.2), where a third colour must be free somewhere on an edge -- the plant must report a free third colour.
"""
import sys
sys.path.insert(0, __import__("os").path.dirname(__file__))
from fs111_w_check import hex7, Q3, R3, Fr, add, sub, scale, point_in_convex, point_poly_d2, point_maxdist2


def free_colours(near, p, exclude):
    out = []
    for c in range(7):
        if c in exclude:
            continue
        if all(point_poly_d2(p, up) > 1 or point_maxdist2(p, up) < 1 for (uid, up, uc) in near if uc == c):
            out.append(c)
    return out


def run(a):
    T = hex7(a=a)
    near = T.tiles_near()
    (tid, tp, tc) = T.base_tiles()[0]
    third_on_edges = 0
    for i in range(6):
        e0, e1 = tp[i], tp[(i + 1) % 6]
        for k in range(1, 20):
            p = add(e0, scale(sub(e1, e0), Fr(k, 20)))
            cols = {uc for (uid, up, uc) in near if point_in_convex(p, up)}
            f = free_colours(near, p, cols)
            if f:
                third_on_edges += 1
                print(f"  edge {i}, t = {k}/20: third colour(s) free: {f}")
    two_foreign = 0
    n_int = 0
    for iu in range(-9, 10):
        for iv in range(-9, 10):
            p = (R3 * Fr(iu, 20), Q3(Fr(iv, 20)))
            if not point_in_convex(p, tp):
                continue
            n_int += 1
            f = free_colours(near, p, {tc})
            if len(f) >= 2:
                two_foreign += 1
                print(f"  interior point ({iu}/20*sqrt3, {iv}/20): foreign colours free: {f}")
    print(f"  edge points with a free third colour: {third_on_edges} of 114; "
          f"interior points (of {n_int}) with two foreign colours free: {two_foreign}")
    return third_on_edges, two_foreign


if __name__ == "__main__":
    if "--plant" in sys.argv:
        print("### plant: hex7 at circumradius 2/5 (slack), must show a free third colour on an edge")
        t, _ = run(Fr(2, 5))
        print("  ->", "FIRES FOR ITS OWN REASON" if t > 0 else "PLANT MISBEHAVES")
        sys.exit(0 if t > 0 else 1)
    print("### hex7 at circumradius 1/2 (tight)")
    t, w = run(Fr(1, 2))
    ok = (t == 0 and w == 0)
    print("  ->", "HEX7-RIGID holds on the sample" if ok else "UNEXPECTED")
    sys.exit(0 if ok else 1)
