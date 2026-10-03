#!/usr/bin/env python3
"""FS116-Y3: exact checks of the lattice facts the forced structure at a Gamma-free four-colour vertex uses (stage 2), and the k = 9 control.

Points of the unit triangular lattice: p = 0, y_k = e(60k), q_k = sqrt3 e(60k + 30), all exact in Q(sqrt3) (sympy).

  lattice            (a) |y_k - y_(k+3)| = 2: the closed unit discs about antipodal hubs meet only at p;
                     (b) |y_1 - q_5| = |y_0 - q_1| = |y_4 - q_2| = |y_3 - q_4| = 2 with midpoints y_0, y_1, y_3, y_4: the tight tip edge at a hub and
                         the far vertex of the ring tile beside it lie in unit discs meeting only at the hub;
                     (c) at each hub the tangent cone of B(p,1) and of B(other hub of its tip, 1) contains the closed tip cone [60k+150, 60k+210]
                         (doubles) and shares exactly one endpoint with it (the tight side); singles: inside B(p,1)'s cone, no shared endpoint.
                     Last line 'LATTICE OK' or 'LATTICE FAIL: ...'.  --plant q: q_5 replaced by sqrt3 e(300) (a wrong lattice point): (b) fails.
  sq9                the square nine-colouring of side 1/2 (colour (i mod 3, j mod 3) on [i/2,(i+1)/2] x [j/2,(j+1)/2]) about the grid vertex 0:
                     its ring meets the grid lines in finitely many points (Gamma-free), and the number of change points, decided exactly at each
                     crossing.  --plant stripes: colour (i mod 3) only.
"""
import sys
import sympy as sp

S3 = sp.sqrt(3)


def e(deg):
    return sp.Matrix([sp.cos(sp.pi * deg / 180), sp.sin(sp.pi * deg / 180)]).applyfunc(sp.nsimplify)


def dist2(a, b):
    d = a - b
    return sp.simplify(d.dot(d))


def ang(v):
    a = sp.atan2(v[1], v[0])
    deg = sp.nsimplify(sp.simplify(a * 180 / sp.pi))
    return deg % 360


Y = {k: e(60 * k) for k in range(6)}
Q = {k: sp.simplify(S3 * e(60 * k + 30)) for k in range(6)}
P0 = sp.Matrix([0, 0])


def halfplane_at(w, z):
    """Closed tangent cone of the closed unit disc about z at a point w on its boundary: directions within 90 of z - w, as [lo, hi] mod 360."""
    c = ang(z - w)
    return ((c - 90) % 360, (c + 90) % 360)


def within(iv, sub):
    lo, hi = iv
    a, b = sub
    span = (hi - lo) % 360
    return ((a - lo) % 360) <= span and ((b - lo) % 360) <= span and ((b - a) % 360) <= span


def lattice(plant):
    q = dict(Q)
    if plant == 'q':
        q[5] = sp.simplify(S3 * e(300))
    fails = []
    for k in range(3):
        d = dist2(Y[k], Y[k + 3])
        print(f'(a) |y_{k} - y_{k+3}|^2 = {d}')
        if d != 4:
            fails.append(f'(a) k={k}')
    for (yi, qi, mid) in [(1, 5, 0), (0, 1, 1), (4, 2, 3), (3, 4, 4)]:
        d = dist2(Y[yi], q[qi])
        m = sp.simplify((Y[yi] + q[qi]) / 2 - Y[mid])
        print(f'(b) |y_{yi} - q_{qi}|^2 = {d}; midpoint - y_{mid} = {list(m)}')
        if d != 4 or any(c != 0 for c in m):
            fails.append(f'(b) y_{yi}, q_{qi}')
    # tips: doubles T1 on (y0, y1), T2 on (y3, y4); singles T3 on y2, T4 on y5
    other = {0: 1, 1: 0, 3: 4, 4: 3}
    for k in range(6):
        cone = ((60 * k + 150) % 360, (60 * k + 210) % 360)
        hp = halfplane_at(Y[k], P0)
        ok = within(hp, cone)
        line = f'(c) y_{k}: tip cone [{cone[0]}, {cone[1]}] in B(p)-cone [{hp[0]}, {hp[1]}]: {ok}'
        if k in other:
            hq = halfplane_at(Y[k], Y[other[k]])
            ok2 = within(hq, cone)
            # intersection of the two half-planes: report its endpoints, and the shared endpoint with the tip cone
            shared = sorted({x for x in (hp[0], hp[1], hq[0], hq[1]) if x in cone})
            line += f'; in B(y_{other[k]})-cone [{hq[0]}, {hq[1]}]: {ok2}; endpoints shared with the tip cone: {shared}'
            if not ok2 or len(shared) != 1:
                fails.append(f'(c) y_{k}')
        else:
            shared = sorted({x for x in hp if x in cone})
            line += f'; endpoints shared: {shared}'
            if shared:
                fails.append(f'(c) y_{k} single tight')
        print(line)
        if not ok:
            fails.append(f'(c) y_{k} B(p)')
    print('LATTICE OK' if not fails else 'LATTICE FAIL: ' + ', '.join(fails))


def sq9(plant):
    def colour(x, y):
        i, j = sp.floor(2 * x), sp.floor(2 * y)
        return (int(i) % 3,) if plant == 'stripes' else (int(i) % 3, int(j) % 3)
    # crossings of the unit circle with grid lines x = m/2, y = n/2 (|m|, |n| <= 2), exact
    pts = set()
    for m in range(-2, 3):
        c = sp.Rational(m, 2)
        r = 1 - c ** 2
        if r < 0:
            continue
        for s in ([0] if r == 0 else [1, -1]):
            pts.add((c, s * sp.sqrt(r)))
            pts.add((s * sp.sqrt(r), c))
    pts = sorted(pts, key=lambda t: float(sp.atan2(t[1], t[0]) % (2 * sp.pi)))
    eps = sp.Rational(1, 10 ** 6)
    changes = 0
    for (x, y) in pts:
        th = sp.atan2(y, x)
        a = (sp.cos(th - eps), sp.sin(th - eps))
        b = (sp.cos(th + eps), sp.sin(th + eps))
        # the sample points are off the grid lines (eps below the gap to the next crossing): evaluate numerically with 50 digits for the floor
        ca = colour(sp.N(a[0], 50), sp.N(a[1], 50))
        cb = colour(sp.N(b[0], 50), sp.N(b[1], 50))
        changes += ca != cb
    print(f'SQ9 ring about a grid vertex: {len(pts)} points on grid lines; colour changes: {changes}')


if __name__ == '__main__':
    args = sys.argv[1:]
    plant = args[args.index('--plant') + 1] if '--plant' in args else None
    if args and args[0] == 'lattice':
        lattice(plant)
    elif args and args[0] == 'sq9':
        sq9(plant)
    else:
        print(__doc__)
        sys.exit(2)
