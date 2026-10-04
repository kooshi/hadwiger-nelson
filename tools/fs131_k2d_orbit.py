#!/usr/bin/env python3
"""FS131-K2d: the orbit facts behind FALC-RES (ii), checked on EXISTING kernel tables (no search).

For q in {11, 19}: a proper 5-colouring C of UD(F_q, 2) with a fan gap gamma at g (both already kernel facts:
finitePlane11_fanGap, FanGap19's gap at (0,4)), and the rotation group {(a,b) : a^2+b^2 = 1} acting about g.
Claim checked: for every w != 0 there is a rotation R with C(g + R w) not in {C(g), gamma}.
Then C composed with (translate by g) . R has gap gamma at 0 and value not in {C(0), gamma} at w.

Also re-checks: C is proper, gamma is absent from N[g].  --plant flips one table entry / the gap colour, and the
check must FAIL (exit 1).
Usage: python3 tools/fs131_k2d_orbit.py [--plant gap|table]
"""
import sys

T11 = [[0,1,4,0,2,0,1,4,0,3,2],[2,4,1,3,0,1,4,1,3,0,1],[4,3,2,0,1,4,3,4,0,3,0],
       [3,0,1,2,4,1,4,0,2,1,4],[2,3,2,1,3,4,0,3,0,4,3],[1,0,1,4,2,1,2,4,1,3,0],
       [2,1,4,3,0,2,4,3,4,0,3],[1,4,2,1,2,4,1,4,0,2,0],[4,0,3,2,1,3,4,3,2,1,3],
       [3,2,0,1,2,4,0,2,0,2,4],[2,0,2,4,1,3,2,1,3,4,0]]
CIRC19 = [0,4,3,2,4,3,2,1,0,4,3,0,4,3,2,1,0,2,1]

def run(plant=None):
    ok = True
    cases = []
    def c11(v): return T11[v[0]][v[1]]
    def c19(v): return CIRC19[(1*v[1] - 1*v[0]) % 19]   # projAlong (1,1) (x,y) = 1*y - 1*x
    cases.append((11, c11, (2, 4), 2))
    cases.append((19, c19, (0, 4), 1))
    for q, C, g, gam in cases:
        if plant == 'gap':
            gam = (gam + 1) % 5
        if plant == 'table' and q == 11:
            T11[3][3] = (T11[3][3] + 1) % 5
        circ = [(a, b) for a in range(q) for b in range(q) if (a*a + b*b) % q == 1]
        assert len(circ) == q + 1, (q, len(circ))
        add = lambda u, v: ((u[0]+v[0]) % q, (u[1]+v[1]) % q)
        pts = [(x, y) for x in range(q) for y in range(q)]
        proper = all(C(u) != C(add(u, d)) for u in pts for d in circ)
        gap = gam != C(g) and all(C(add(g, d)) != gam for d in circ)
        rot = lambda r, w: ((r[0]*w[0] - r[1]*w[1]) % q, (r[1]*w[0] + r[0]*w[1]) % q)
        bad = [w for w in pts if w != (0, 0)
               and not any(C(add(g, rot(r, w))) not in (C(g), gam) for r in circ)]
        print(f"q={q}: proper={proper} gap={gap} rotations={len(circ)} uncovered={len(bad)} {bad[:6]}")
        ok = ok and proper and gap and not bad
    return ok

if __name__ == '__main__':
    plant = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == '--plant' else None
    ok = run(plant)
    print('PASS' if ok else 'FAIL')
    sys.exit(0 if ok else 1)
