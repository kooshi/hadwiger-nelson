#!/usr/bin/env python3
"""FS121-D1: exact checks of the erosion-corner geometry (FS121-D1-EROSION) and of its consistency with the held controls.

(1) At 60 angle pairs (60-digit residuals), for a convex corner at z = 0 of angle theta in (0, pi) with edges along u(phi1), u(phi2), phi2 = phi1 + theta:
    the inner unit parallels of the two edges (the partner lines, each shifted by 1 into the corner) meet at a point X with
    X - P_i = cot(theta/2) u(phi_i) (P_i the foot of the perpendicular from z) and |X| = 1/sin(theta/2).
(2) Exact, on one tile of each held control: for every tile edge, its partner segment (the edge translated by 1 along its inward
    normal); no two partner segments of one tile cross at a point interior to both (the lemma's conclusion on SQ9 and HEX9).
    SQ9: squares of side 1/2. HEX9: regular hexagons of width 1/2 (side 1/(2*sqrt(3))).
--plant hexbig: the hexagon side is set above cot(pi/3) = 1/sqrt(3); partner segments of adjacent edges then cross, and the
check must report it (exit 0 iff the plant fires). Exit 0 on the faithful run iff every assertion holds; a failed assertion or
an exception exits 1."""
import sys
import sympy as sp

def u(a): return sp.Matrix([sp.cos(a), sp.sin(a)])

def symbolic():
    """checked at 60 angle pairs (theta = k*pi/13, k = 1..12; phi1 = j*pi/5, j = 0..4), each residual evaluated to 60 digits"""
    worst = 0
    for k in range(1, 13):
        for j in range(5):
            th, p1 = k*sp.pi/13, j*sp.pi/5
            p2 = p1 + th
            n1, n2 = u(p1 + sp.pi/2), u(p2 - sp.pi/2)      # unit normals of the two edges pointing into the corner
            X1, X2 = n1 + sp.cot(th/2)*u(p1), n2 + sp.cot(th/2)*u(p2)
            res = [X1[0] - X2[0], X1[1] - X2[1], X1.dot(X1) - 1/sp.sin(th/2)**2]
            worst = max(worst, max(abs(sp.N(r, 60)) for r in res))
    ok = worst < sp.Float('1e-50')
    print(f"symbolic: partner lines meet at cot(theta/2) along each, |X| = 1/sin(theta/2), 60 angle pairs, max residual {sp.N(worst, 3)}: {ok}")
    return ok

def cross_interior(a, b, c, d):
    """segments ab and cd (exact) cross at a point interior to both (transversal, not at an endpoint)."""
    r, s = b - a, d - c
    den = sp.simplify(r[0]*s[1] - r[1]*s[0])
    if den == 0: return False
    t = sp.simplify(((c - a)[0]*s[1] - (c - a)[1]*s[0]) / den)
    w = sp.simplify(((c - a)[0]*r[1] - (c - a)[1]*r[0]) / den)
    return bool(sp.simplify(t) > 0 and sp.simplify(t) < 1 and sp.simplify(w) > 0 and sp.simplify(w) < 1)

def tile_check(name, verts):
    m = len(verts)
    cen = sum(verts, sp.zeros(2, 1)) / m
    parts = []
    for i in range(m):
        a, b = verts[i], verts[(i + 1) % m]
        e = b - a
        n = sp.Matrix([-e[1], e[0]]) / sp.sqrt(e.dot(e))
        if (cen - a).dot(n) < 0: n = -n                   # inward normal
        parts.append((sp.simplify(a + n), sp.simplify(b + n)))
    bad = [(i, j) for i in range(m) for j in range(i + 1, m) if cross_interior(*parts[i], *parts[j])]
    print(f"{name}: {m} edges, partner segments crossing at interior points: {len(bad)} {bad}")
    return not bad

def main():
    plant = 'hexbig' if '--plant' in sys.argv and 'hexbig' in sys.argv else None
    ok = symbolic()
    h = sp.Rational(1, 2)
    ok &= tile_check('SQ9 square, side 1/2', [sp.Matrix([0, 0]), sp.Matrix([h, 0]), sp.Matrix([h, h]), sp.Matrix([0, h])])
    side = sp.Rational(3, 5) if plant else 1/(2*sp.sqrt(3))
    hexv = [side*u(sp.pi*k/3) for k in range(6)]
    ok &= tile_check(f"HEX9 hexagon, side {side}", hexv)
    if plant:
        print('PLANT FIRED' if not ok else 'PLANT DID NOT FIRE'); sys.exit(0 if not ok else 1)
    print('ALL HOLD' if ok else 'FAILED'); sys.exit(0 if ok else 1)

try:
    main()
except SystemExit:
    raise
except Exception as ex:
    print(f"EXCEPTION: {ex!r}"); sys.exit(1)
