#!/usr/bin/env python3
"""FS131-E3 (E3-W): the sagitta bound behind Lemma W, checked on a grid.

A unit circle meeting the disc B(v, r1) (r1 < 1) does so in its minor arc between two points p, q of the circle |x - v| = r1.
If p, q have directions in [0, alpha] (alpha < pi), every point of that arc is at distance >= r1*cos(alpha/2) - r1^2 from v.
We take r1 = 0.1 and alpha in {0.5, 1.5, 2.5, 3.0}, endpoint directions on a grid in [0, alpha], both unit circles through p, q,
sample the arc between them that lies in the disc, and count samples violating the bound (a margin of 1e-12 absorbs rounding).
--fault replaces the allowance r1^2 by r1^2/100: the count must become positive.
"""
import math, sys

def arc_min_dist(p, q):
    # both unit circles through p and q; for each, the minor arc between p and q; return the min |x| over both arcs' samples
    mx, my = (p[0] + q[0]) / 2, (p[1] + q[1]) / 2
    dx, dy = q[0] - p[0], q[1] - p[1]
    L = math.hypot(dx, dy)
    if L == 0 or L >= 2:
        return None
    h = math.sqrt(1 - (L / 2) ** 2)
    nx, ny = -dy / L, dx / L
    best = []
    for s in (1, -1):
        cx, cy = mx + s * h * nx, my + s * h * ny
        a1 = math.atan2(p[1] - cy, p[0] - cx)
        a2 = math.atan2(q[1] - cy, q[0] - cx)
        d = (a2 - a1 + math.pi) % (2 * math.pi) - math.pi   # minor arc
        m = min(math.hypot(cx + math.cos(a1 + d * t / 200), cy + math.sin(a1 + d * t / 200)) for t in range(201))
        best.append(m)
    return best

def main():
    fault = "--fault" in sys.argv
    r1 = 0.1
    viol = 0
    checked = 0
    for alpha in (0.5, 1.5, 2.5, 3.0):
        bound = r1 * math.cos(alpha / 2) - (r1 * r1 / 100 if fault else r1 * r1)
        G = 40
        for i in range(G + 1):
            for j in range(i + 1, G + 1):
                tp, tq = alpha * i / G, alpha * j / G
                p = (r1 * math.cos(tp), r1 * math.sin(tp))
                q = (r1 * math.cos(tq), r1 * math.sin(tq))
                res = arc_min_dist(p, q)
                if res is None:
                    continue
                for m in res:
                    checked += 1
                    if m < bound - 1e-12:
                        viol += 1
    print("arcs=%d violations=%d" % (checked, viol))

if __name__ == "__main__":
    main()
