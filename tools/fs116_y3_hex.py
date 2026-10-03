#!/usr/bin/env python3
"""FS116-Y3: exact checks of the lattice facts the forced structure at a Gamma-free four-colour vertex uses (stage 2), and the k = 9 control.

Points of the unit triangular lattice: p = 0, y_k = e(60k), q_k = sqrt3 e(60k + 30), all exact in Q(sqrt3) (sympy).

  lattice            (a) |y_k - y_(k+3)| = 2: the closed unit discs about antipodal hubs meet only at p;
                     (b) |y_1 - q_5| = |y_0 - q_1| = |y_4 - q_2| = |y_3 - q_4| = 2 with midpoints y_0, y_1, y_3, y_4: the tight tip edge at a hub and
                         the far vertex of the ring tile beside it lie in unit discs meeting only at the hub;
                     (c) at each hub the tangent cone of B(p,1) and of B(other hub of its tip, 1) contains the closed tip cone [60k+150, 60k+210]
                         (doubles) and shares exactly one endpoint with it (the tight side); singles: inside B(p,1)'s cone, no shared endpoint.
                     Last line 'LATTICE OK' or 'LATTICE FAIL: ...'.  --plant q: q_5 replaced by sqrt3 e(300) (a wrong lattice point): (b) fails.
  lens               NOQ's and LENS's lattice facts, and the conditions (Q1) (Q2) (Q4) (Q5) of stage 3 as a truth table over the 81 assignments
                     of the star's edges to interior or boundary values (a check of the hand derivation, not a search).  --plant q: q_1 misplaced;
                     --plant cond: (Q1) dropped (the generic star then satisfies the rest? it must not: (Q4) alone fails it).
  star               STARFORCE: the candidate outer colours with the neighbour-tip rule, and the lens rule at the four tight lenses, over the 81
                     assignments of the star's edges (a check of the hand derivation).  --plant nbtip: the neighbour-tip rule dropped.
  nbtip              NBTIP's angle fact: the open cone of 60 degrees about the direction from y_k to p lies inside the open half-plane of directions
                     into B(y_(k+1), 1) and into B(y_(k-1), 1), at every hub.  --plant wide: the cone widened to 180 degrees (it then leaves both).
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


def lens(plant):
    """NOQ and LENS: |y_(k-1) - q_k| = |y_(k+1) - q_(k-1)| = 2 with midpoint y_k (every k); |q_k| = sqrt3; the ring point e(60k+30) at distance
    sqrt3 - 1 < 1 from q_k; and the conditions (Q1), (Q2), (Q4), (Q5) as a truth table over the boundary values of the star's edges."""
    fails = []
    for k in range(6):
        qk, qm = Q[k], Q[(k - 1) % 6]
        if plant == 'q' and k == 1:
            qk = sp.simplify(S3 * e(60))
        for a, b, name in [(Y[(k - 1) % 6], qk, f'y_{(k-1)%6}, q_{k}'), (Y[(k + 1) % 6], qm, f'y_{(k+1)%6}, q_{(k-1)%6}')]:
            d = dist2(a, b)
            m = sp.simplify((a + b) / 2 - Y[k])
            if d != 4 or any(c != 0 for c in m):
                fails.append(name)
        if sp.simplify(Q[k].dot(Q[k]) - 3) != 0:
            fails.append(f'|q_{k}|')
        r = sp.simplify(sp.sqrt(dist2(e(60 * k + 30), Q[k])) - (S3 - 1))
        if r != 0:
            fails.append(f'ring point at q_{k}')
    print('lattice facts: ' + ('all hold' if not fails else 'FAIL ' + ', '.join(fails)))
    # boundary values: d1 in {30, 90}, d2 in {150, 210}, d3 in {210, 270}, d4 in {-30, 30}; 'i' = interior
    vals = {'d1': ['i', 30, 90], 'd2': ['i', 150, 210], 'd3': ['i', 210, 270], 'd4': ['i', -30, 30]}
    def Q1(d): return d['d4'] == -30 or d['d1'] == 30 or d['d2'] == 210
    def Q2(d): return d['d3'] == 270 or d['d1'] == 30 or d['d2'] == 210
    def Q4(d): return d['d2'] == 150 or d['d4'] == 30 or d['d3'] == 210
    def Q5(d): return d['d1'] == 90 or d['d4'] == 30 or d['d3'] == 210
    if plant == 'cond':
        Q1 = lambda d: True   # noqa: E731  (the plant drops condition (Q1))
    import itertools
    sat, minimal = [], []
    for combo in itertools.product(*vals.values()):
        d = dict(zip(vals.keys(), combo))
        if all(f(d) for f in (Q1, Q2, Q4, Q5)):
            sat.append(d)
    nb = lambda d: sum(v != 'i' for v in d.values())   # noqa: E731
    for d in sat:
        b = {k: v for k, v in d.items() if v != 'i'}
        if not any(set(o.items()) < set(b.items()) for o in [{k: v for k, v in e2.items() if v != 'i'} for e2 in sat]):
            minimal.append(b)
    generic = {'d1': 'i', 'd2': 'i', 'd3': 'i', 'd4': 'i'}
    print(f'assignments: 81; satisfying (Q1)(Q2)(Q4)(Q5): {len(sat)}; the generic star satisfies them: {generic in sat}; '
          f'fewest boundary values in a satisfying one: {min(nb(d) for d in sat)}')
    print('minimal satisfying sets of boundary values: ' + '; '.join(', '.join(f'{k}={v}' for k, v in sorted(m.items())) for m in
          sorted(minimal, key=lambda m: (len(m), sorted(m.items())))))


def star(plant):
    """STARFORCE (stage 4): candidate outer colours from the cone conditions and the neighbour-tip rule (NBTIP: the tip of y_(k±1) meets B(y_k, 1),
    so its colour is no outer colour of y_k); then at each tight lens the colour near q_k must be some c in P minus the two tips such that, at each of
    the two hubs, c is not a candidate or the hub has at least two candidates (LENS + NOQ).  Prints the satisfying assignments of the four edges.
    --plant nbtip: the neighbour-tip rule dropped."""
    import itertools
    tip = {0: 1, 1: 1, 2: 3, 3: 2, 4: 2, 5: 4}
    vals = {'d1': ['i', 30, 90], 'd2': ['i', 150, 210], 'd3': ['i', 210, 270], 'd4': ['i', -30, 30]}

    def cand(d):
        c = {0: {2} | ({3} if d['d1'] == 90 else set()),
             1: {2} | ({4} if d['d4'] == -30 else set()),
             2: {4} | ({2} if d['d2'] == 210 else set()) | ({1} if d['d1'] == 30 else set()),
             3: {1} | ({4} if d['d3'] == 270 else set()),
             4: {1} | ({3} if d['d2'] == 150 else set()),
             5: {3} | ({1} if d['d4'] == 30 else set()) | ({2} if d['d3'] == 210 else set())}
        if plant != 'nbtip':
            for k in range(6):
                c[k] -= {tip[(k - 1) % 6], tip[(k + 1) % 6]} - {tip[k]}
        return c

    def lens_ok(d, k):
        c = cand(d)
        a, b = k, (k + 1) % 6
        for col in {1, 2, 3, 4} - {tip[a], tip[b]}:
            if all(col not in c[h] or len(c[h]) >= 2 for h in (a, b)):
                return True
        return False

    sat = []
    for combo in itertools.product(*vals.values()):
        d = dict(zip(vals.keys(), combo))
        c = cand(d)
        if all(c[k] for k in range(6)) and all(lens_ok(d, k) for k in (1, 2, 4, 5)):
            sat.append(d)
    print(f'satisfying assignments: {len(sat)}')
    for d in sat[:6]:
        print('  ' + ', '.join(f'{k}={v}' for k, v in d.items()) + '   candidate outer colours: ' +
              ', '.join(f'y_{k}:{sorted(v)}' for k, v in cand(d).items()))


def nbtip(plant):
    w = 90 if plant == 'wide' else 30
    ok = True
    for k in range(6):
        to_p = (60 * k + 180) % 360
        for j in ((k + 1) % 6, (k - 1) % 6):
            c = ang(Y[j] - Y[k])                      # direction from y_k to its neighbour
            # the open cone (to_p - w, to_p + w) lies in the open half-plane (c - 90, c + 90) iff |to_p - c| + w <= 90
            off = abs(((to_p - c + 180) % 360) - 180)
            ok = ok and (off + w <= 90)
    print(f'NBTIP angle fact (cone half-width {w}): {"holds at every hub" if ok else "FAILS"}')


if __name__ == '__main__':
    args = sys.argv[1:]
    plant = args[args.index('--plant') + 1] if '--plant' in args else None
    if args and args[0] == 'lattice':
        lattice(plant)
    elif args and args[0] == 'sq9':
        sq9(plant)
    elif args and args[0] == 'lens':
        lens(plant)
    elif args and args[0] == 'star':
        star(plant)
    elif args and args[0] == 'nbtip':
        nbtip(plant)
    else:
        print(__doc__)
        sys.exit(2)
