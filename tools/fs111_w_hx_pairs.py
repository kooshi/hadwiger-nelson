#!/usr/bin/env python3
"""FS111-W — FS111-W-HX-PAIRS: family HX (FS-107's hexagonal seven-colouring with colour 0 absorbed; `plans/FS107-derivation.md`
§2) carries complementary pairs of fat junctions in FS107-R-CP's sense, blocking toward points inside its voids.

The hexagonal seven-colouring at circumradius R (centres m(sqrt3 R, 0) + n(sqrt3 R/2, 3R/2), colour (m + 3n) mod 7).  HX
changes only the colour-0 hexagons (absorbed triangles, a void of radius rho at each centre).  Its other vertices keep
three 120-degree sectors: fat junctions (FS107-R-CP: cones K(x, I_j; r, s) in C_j, nothing assumed inside B(x, r)).
Computed: every pair of such vertices with disjoint (complementary, K-C6) types at distance < 2, its two common unit
points, the distance from each to the nearest colour-0 centre (in units of R), and the angle between the direction
from each vertex to the unit point and the nearest edge-normal at that vertex (blocking with margin mu holds when this
angle exceeds mu; FS107-R-CP's definition, side chosen freely).

Grade: [tools, float] -- vertex types are exact (they are those of tools/fs111_w_check.py's exact hex7), the locations
are floats; every margin printed is at least 0.07 R or 5 degrees, far above float error.  Planted fault (--plant): the
same computation with colour 3 absorbed in place of colour 0 must place the unit points in colour-3 hexagons (it tests
that the computation reads the absorbed colour, not a constant).
"""
import math
# hex7 at circumradius R (float), colour (m+3n) mod 7, centres m*u+n*v
def run(R, absorbed=0):
    u = (math.sqrt(3)*R, 0.0); v = (math.sqrt(3)*R/2, 1.5*R)
    cents = {}
    for m in range(-8, 9):
        for n in range(-8, 9):
            c = (m*u[0]+n*v[0], m*u[1]+n*v[1]); cents[(m,n)] = (c, (m+3*n) % 7)
    # vertices: centre + R*e^{i(30+60k)}; type = colours of the 3 hexagons whose centres are at distance R
    verts = {}
    for (m,n),(c,col) in cents.items():
        for k in range(6):
            a = math.radians(30+60*k); p = (round(c[0]+R*math.cos(a), 9), round(c[1]+R*math.sin(a), 9))
            verts.setdefault(p, set()).add(col)
    V = [(p, t) for p, t in verts.items() if len(t) == 3 and math.hypot(*p) < 3]
    res = []
    for i in range(len(V)):
        for j in range(i+1, len(V)):
            (p, tp), (q, tq) = V[i], V[j]
            if absorbed in tp or absorbed in tq or tp & tq: continue
            D = math.dist(p, q)
            if not 0 < D < 2: continue
            h = math.sqrt(1 - D*D/4); mx, my = (p[0]+q[0])/2, (p[1]+q[1])/2
            nx, ny = -(q[1]-p[1])/D, (q[0]-p[0])/D
            for s in (1, -1):
                w = (mx + s*h*nx, my + s*h*ny)
                # nearest centre and its colour
                (c, col) = min(cents.values(), key=lambda cc: math.dist(cc[0], w))
                res.append((round(D, 4), col, round(math.dist(c, w)/R, 4)))
    from collections import Counter
    return Counter(res)

def blocking(R, absorbed=0):
    u = (math.sqrt(3)*R, 0.0); v = (math.sqrt(3)*R/2, 1.5*R)
    cents = {}
    for m in range(-8, 9):
        for n in range(-8, 9):
            cents[(m,n)] = ((m*u[0]+n*v[0], m*u[1]+n*v[1]), (m+3*n) % 7)
    verts = {}
    for (m,n),(c,col) in cents.items():
        for k in range(6):
            a = math.radians(30+60*k); p = (round(c[0]+R*math.cos(a), 9), round(c[1]+R*math.sin(a), 9))
            verts.setdefault(p, []).append((c, col))
    V = [(p, t) for p, t in verts.items() if len(t) == 3 and math.hypot(*p) < 2.5]
    out = set()
    for i in range(len(V)):
        for j in range(i+1, len(V)):
            (p, tp), (q, tq) = V[i], V[j]
            sp, sq = {c for _, c in tp}, {c for _, c in tq}
            if absorbed in sp or absorbed in sq or sp & sq: continue
            D = math.dist(p, q)
            if not 0 < D < 2: continue
            h = math.sqrt(1 - D*D/4); mx, my = (p[0]+q[0])/2, (p[1]+q[1])/2
            nx, ny = -(q[1]-p[1])/D, (q[0]-p[0])/D
            for s in (1, -1):
                w = (mx + s*h*nx, my + s*h*ny)
                for (x, tx) in ((p, tp), (q, tq)):
                    th = math.degrees(math.atan2(w[1]-x[1], w[0]-x[0]))
                    # sectors at x: directions to the three centres are bisectors; edges are at bisector +- 60
                    edges = []
                    for (c, col) in tx:
                        b = math.degrees(math.atan2(c[1]-x[1], c[0]-x[0]))
                        edges += [b + 60, b - 60]
                    # smallest angle between theta and a direction perpendicular to an edge
                    dmin = min(abs(((th - (e + 90)) + 180) % 360 - 180) for e in edges)
                    dmin = min(dmin, min(abs(((th - (e - 90)) + 180) % 360 - 180) for e in edges))
                    out.add(round(dmin, 3))
    return sorted(out)

if __name__ == "__main__":
    import sys
    if "--plant" in sys.argv:
        r = run(2/math.sqrt(21), absorbed=3)
        cols = {k[1] for k in r}
        print("### plant: colour 3 absorbed -> unit points in colours", sorted(cols))
        ok = cols == {3}
        print("  ->", "FIRES FOR ITS OWN REASON" if ok else "PLANT MISBEHAVES"); sys.exit(0 if ok else 1)
    bad = False
    for R, rho in ((0.5, None), (2/math.sqrt(21), 0.5), (0.433, 0.24/0.433)):
        r = run(R); b = blocking(R)
        print(f"### R = {R:.4f}" + (f", HX void radius rho/R = {rho:.4f}" if rho else " (the tight seven-colouring itself)"))
        for k, c in sorted(r.items()):
            inside = (rho is not None and k[2] < rho)
            print(f"   complementary pair at distance {k[0]:.4f}: unit point in a colour-{k[1]} hexagon at {k[2]:.4f} R from its centre"
                  + (f" -> inside the void" if inside else "") + f" (x{c})")
            if rho is not None and not inside: bad = True
        print(f"   angle from dir(vertex -> unit point) to the nearest edge-normal: {b} degrees (blocking margin available: below {min(b):.3f})")
    sys.exit(1 if bad else 0)
