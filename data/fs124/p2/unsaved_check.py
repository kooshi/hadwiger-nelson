#!/usr/bin/env python3
"""FS124-P2 — where the common unit points of the close complementary pairs lie when they are NOT centres of unit arcs.
For FS-112's strip and disk: every pair of three-label ends of unit arcs with disjoint label triples and 0 < distance < 2; its two
common unit points; each one that is no centre is classed outside-the-object (no label read in a ball of radius 3e-4), on-its-cut
(part of the ball unread) or inside (the whole ball read).  Exit 0 iff no such point is inside; --fault counts centres as non-centres.
  python3 data/fs124/p2/unsaved_check.py
"""
import sys, math, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
FAULT = "--fault" in sys.argv
sys.argv = [sys.argv[0]]
import centre_read as CR
e, add, dist, TAU = CR.e, CR.add, CR.dist, CR.TAU
done = set(); inside = 0
for lab, TF, col, p in CR.load_maps():
    key = lab.split()[0]
    if key in done: continue
    done.add(key); cen = set(); pts = {}
    for nm, (c, ps) in TF.items():
        for pc in ps:
            if pc[0] == "A" and abs(pc[2] - 1) < 1e-12:
                _, C, rho, S, E_ = pc
                cen.add((round(C[0], 6), round(C[1], 6)))
                for P in (S, E_):
                    P = (round(P[0], 6), round(P[1], 6))
                    ball = [col(add(P, tuple(3e-4 * c for c in e(TAU * i / 48)))) for i in range(48)]
                    if None not in ball and len(set(ball)) == 3: pts[P] = frozenset(ball)
    P = sorted(pts); second = {}
    for i in range(len(P)):
        for j in range(i + 1, len(P)):
            x, y = P[i], P[j]; d = dist(x, y)
            if (pts[x] & pts[y]) or not (1e-9 < d < 2 - 1e-9): continue
            m = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = math.sqrt(1 - d * d / 4); n = ((y[1] - x[1]) / d, -(y[0] - x[0]) / d)
            for sg in (1, -1):
                w = (m[0] + sg * h * n[0], m[1] + sg * h * n[1])
                isc = any(dist(w, Q) < 1e-6 for Q in cen) and not FAULT
                ball = [col(add(w, tuple(3e-4 * c for c in e(TAU * k / 48)))) for k in range(48)]
                cut = sum(b is None for b in ball)
                if not isc:
                    k2 = "outside-the-object" if cut == 48 else ("on-its-cut" if cut else "inside")
                    second[k2] = second.get(k2, 0) + 1; inside += (cut == 0)
                elif cut: second["centre-on-the-cut"] = second.get("centre-on-the-cut", 0) + 1
    print(key, "common unit points that are not centres:", dict(sorted(second.items())))
print("unsaved: " + ("OK" if inside == 0 else "FAULT-SEEN"))
sys.exit(0 if inside == 0 else 1)
