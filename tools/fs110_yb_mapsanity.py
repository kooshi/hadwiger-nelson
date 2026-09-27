#!/usr/bin/env python3
"""FS110-YB: float sanity of the rebuilt fragments as partial maps (not a verdict): no two tiles overlap, and small circles about
u, v, w, w' lie in the union of the tiles (so the vertex types are as the formulas say). Arcs are discretised; points within 1e-6 of a
boundary are skipped."""
import math, sys
import fs110_yb_check as K, fs110_yb_fragments as F

def outline(t, n=400):
    pts = []
    for pc in t.pieces:
        if isinstance(pc, K.Seg):
            pts.append(K.fl(pc.p)); pts.append(K.fl(pc.q))
        else:
            C = K.fl(pc.C); r = float(pc.r); a = K.fl(pc.p); b = K.fl(pc.q)
            t0 = math.atan2(a[1]-C[1], a[0]-C[0]); t1 = math.atan2(b[1]-C[1], b[0]-C[0])
            while t1 <= t0: t1 += 2*math.pi
            pts += [(C[0]+r*math.cos(t0+(t1-t0)*i/n), C[1]+r*math.sin(t0+(t1-t0)*i/n)) for i in range(n+1)]
    # order pieces into a closed chain: the pieces are listed in boundary order but arcs may run against it
    return pts

def chain(t, n=400):
    # build an ordered boundary polygon following the pieces' shared endpoints
    segs = []
    for pc in t.pieces:
        if isinstance(pc, K.Seg): segs.append([K.fl(pc.p), K.fl(pc.q)])
        else:
            C = K.fl(pc.C); r = float(pc.r); a = K.fl(pc.p); b = K.fl(pc.q)
            t0 = math.atan2(a[1]-C[1], a[0]-C[0]); t1 = math.atan2(b[1]-C[1], b[0]-C[0])
            while t1 <= t0: t1 += 2*math.pi
            segs.append([(C[0]+r*math.cos(t0+(t1-t0)*i/n), C[1]+r*math.sin(t0+(t1-t0)*i/n)) for i in range(n+1)])
    poly = list(segs[0])
    rest = segs[1:]
    close = lambda p, q: abs(p[0]-q[0]) + abs(p[1]-q[1]) < 1e-9
    while rest:
        for i, s in enumerate(rest):
            if close(s[0], poly[-1]): poly += s[1:]; rest.pop(i); break
            if close(s[-1], poly[-1]): poly += s[::-1][1:]; rest.pop(i); break
        else:
            raise SystemExit(f"tile {t.name}: boundary does not chain")
    assert close(poly[0], poly[-1]), f"tile {t.name} not closed"
    return poly

def inside(pt, poly):
    x, y = pt; c = False
    for i in range(len(poly)-1):
        (x1, y1), (x2, y2) = poly[i], poly[i+1]
        if (y1 > y) != (y2 > y):
            if x < x1 + (y - y1) * (x2 - x1) / (y2 - y1): c = not c
    return c

def near_boundary(pt, poly, eps=1e-6):
    x, y = pt
    for i in range(len(poly)-1):
        (x1, y1), (x2, y2) = poly[i], poly[i+1]
        dx, dy = x2-x1, y2-y1; L = dx*dx+dy*dy
        t = 0 if L == 0 else max(0, min(1, ((x-x1)*dx+(y-y1)*dy)/L))
        if math.hypot(x-x1-t*dx, y-y1-t*dy) < eps: return True
    return False

def sanity(tiles, centres, label):
    polys = {t.name: chain(t) for t in tiles}
    bad_overlap = 0; gaps = {}
    # overlap: sample each tile's bounding box on a grid
    import itertools
    xs = [p[0] for P_ in polys.values() for p in P_]; ys = [p[1] for P_ in polys.values() for p in P_]
    N = 260
    for i in range(N):
        for j in range(N):
            pt = (min(xs) + (max(xs)-min(xs))*(i+0.5)/N, min(ys) + (max(ys)-min(ys))*(j+0.5)/N)
            hit = [n for n, P_ in polys.items() if inside(pt, P_)]
            if len(hit) > 1 and not any(near_boundary(pt, polys[n]) for n in hit): bad_overlap += 1
    for cname, c in centres:
        miss = 0; cols = set()
        for k in range(720):
            th = 2*math.pi*(k+0.5)/720; pt = (c[0]+0.01*math.cos(th), c[1]+0.01*math.sin(th))
            hit = [t for t in tiles if inside(pt, polys[t.name])]
            if not hit and not any(near_boundary(pt, polys[t.name], 1e-4) for t in tiles): miss += 1
            for t in hit: cols.add(t.colour)
        gaps[cname] = (miss, sorted(cols))
    print(f"{label}: overlapping sample points={bad_overlap}; circle r=0.01 uncovered samples and colours: {gaps}")
    return bad_overlap == 0 and all(m == 0 for m, _ in gaps.values())

W = K.fl(F.W); Wp = K.fl(F.Wp)
C4 = [("u", (0, 0)), ("v", (1, 0)), ("w", W), ("w'", Wp)]
ok = True
for label, tiles in [("S1", F.frag_S1()), ("T2", F.frag_T2()), ("BB", F.frag_BB()), ("MX", F.frag_MX())]:
    ok &= sanity(tiles, C4, label)
# planted faults: a duplicated tile must read as overlap; a removed tile at u must read as a gap
t = F.frag_BB(); dup = t[1].mapped(lambda z: z, "dup", 9)
p1 = not sanity(t + [dup], C4, "PLANT overlap (BB + a copy of u's 2-sector)")
p2 = not sanity(F.frag_BB()[1:], C4, "PLANT gap (BB without u's first sector)")
print("plants fired:", p1, p2); ok &= p1 and p2
print("MAP SANITY", "PASS" if ok else "FAIL")
sys.exit(0 if ok else 1)
