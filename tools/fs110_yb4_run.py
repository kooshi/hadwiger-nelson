#!/usr/bin/env python3
"""FS110-YB4: run the rebuilt fragments, the tip recolourings, the side's plants, my controls and my checker's plants.
Usage: python3 tools/fs110_yb4_run.py [section ...]   (sections: controls fragments tips plants checkerplants robust)"""
import sys, time
from fractions import Fraction as Fr
sys.path.insert(0, 'tools')
import fs110_yb4_check as K
import fs110_yb4_fragments as G
from fs110_yb4_check import Num, P, Seg, Arc, Tile, check_fragment

S3 = Num(0, 1, 3)


def hexagons(a, colfn, R=3):
    """pointy-top regular hexagons of side a on the triangular lattice, |m|,|n| <= R, coloured colfn(m, n)."""
    e1, e2 = P(S3 * a, 0), P(S3 * a / 2, Num(a) * Fr(3, 2))
    vs = [P(S3 * a / 2, Num(a) / 2), P(0, a), P(-S3 * a / 2, Num(a) / 2), P(-S3 * a / 2, -Num(a) / 2), P(0, -Num(a)),
          P(S3 * a / 2, -Num(a) / 2)]
    tiles = []
    for m in range(-R, R + 1):
        for n in range(-R, R + 1):
            c = e1 * m + e2 * n
            pts = [c + v for v in vs]
            tiles.append(Tile(f'H{m},{n}', colfn(m, n), [Seg(pts[k], pts[(k + 1) % 6]) for k in range(6)]))
    return tiles


def disc(name, c, r, colour):
    top, bot = P(c.x, c.y + r), P(c.x, c.y - r)
    return Tile(name, colour, [Arc(c, r, top, bot), Arc(c, r, bot, top)])


def rect(name, x0, y0, x1, y1, colour):
    a, b, c, d = P(x0, y0), P(x1, y0), P(x1, y1), P(x0, y1)
    return Tile(name, colour, [Seg(a, b), Seg(b, c), Seg(c, d), Seg(d, a)])


def show(label, res, expect=None, expect_pairs=None, want_reject=None):
    ok = True
    line = f'{label}: {res["verdict"]} pairs={res["pairs"]}'
    if res['reject']:
        line += ' reject=' + ','.join(f'({a},{b})' for a, b in res['reject'])
    if res['ambig']:
        line += ' AMBIG=' + ','.join(f'({a},{b})' for a, b in res['ambig'])
    nt = sum(len(p) for _, p in res['tight'])
    line += f' tight_pairs={len(res["tight"])} tight_points={nt}'
    if expect is not None and res['verdict'] != expect:
        ok = False
    if expect_pairs is not None and res['pairs'] != expect_pairs:
        ok = False
    if want_reject is not None and sorted(tuple(sorted(p)) for p in res['reject']) != sorted(tuple(sorted(p)) for p in want_reject):
        ok = False
    print(('PASS ' if ok else 'FAIL ') + line)
    return ok


def detail(res, names=None):
    for r in res['results']:
        if names and r['pair'] not in names and tuple(reversed(r['pair'])) not in names:
            continue
        lo, hi = r['lo'], r['hi']
        print(f'   {r["pair"]}: {r["verdict"]} {r["kind"]} min^2={lo[0]} ({lo[1]}) max^2={hi[0]} ({hi[1]}) n={r["n"]}')
    for pair, pts in res['tight']:
        print(f'   tight {pair}: {pts}')


def controls():
    allok = True
    c7 = lambda m, n: (m + 3 * n) % 7
    allok &= show('hex7 tight (a=1/2)', check_fragment(hexagons(Fr(1, 2), c7)), 'ACCEPT')
    allok &= show('hex7 fat (a=51/100) [known REJECT: diameter]', check_fragment(hexagons(Fr(51, 100), c7, R=1)), 'REJECT')
    allok &= show('hex (m+n)%7 [known REJECT: same colour neighbours]', check_fragment(hexagons(Fr(1, 2), lambda m, n: (m + n) % 7, R=1)), 'REJECT')
    q = Fr(1, 4)
    allok &= show('discs at 3/2 [tight ACCEPT]', check_fragment([disc('D1', P(0, 0), q, 1), disc('D2', P(Fr(3, 2), 0), q, 1)]), 'ACCEPT')
    allok &= show('discs at 149/100 [known REJECT]', check_fragment([disc('D1', P(0, 0), q, 1), disc('D2', P(Fr(149, 100), 0), q, 1)]), 'REJECT')
    e = Fr(1, 100)
    allok &= show('crossing X [known REJECT: touch]', check_fragment([rect('X1', Fr(-3, 2), -e, Fr(3, 2), e, 1), rect('X2', -e, Fr(-3, 2), e, Fr(3, 2), 1)]), 'REJECT')
    return allok


FRAG = {
    'WC': (lambda: G.wc(), 30),
    'WC1': (lambda: G.wc(double=False), 26),
    'WCEQ': (lambda: G.wceq(), 30),
    'WCH': (lambda: G.wch(), 40),
    'WC1H': (lambda: G.wc1h(), 30),
}


def fragments(verbose=True):
    allok = True
    for name, (mk, npairs) in FRAG.items():
        t = time.time()
        res = check_fragment(mk())
        allok &= show(f'{name}', res, 'ACCEPT', npairs)
        if verbose:
            for pair, pts in res['tight']:
                print(f'   tight {pair}: {pts}')
        print(f'   ({time.time() - t:.1f}s)')
    return allok


def tips(t0s=(Fr(1, 20), Fr(1, 100))):
    allok = True
    rings4 = [('r2', 'tip'), ('r5', 'tip'), ('r8', 'tip')]
    for t0 in t0s:
        base = G.wc()
        allok &= show(f'WC tip->2 t0={t0}', check_fragment(G.tip(base, t0, 2)), 'ACCEPT')
        allok &= show(f'WC tip->3 t0={t0}', check_fragment(G.tip(base, t0, 3)), 'ACCEPT')
        allok &= show(f'WC tip->4 t0={t0}', check_fragment(G.tip(base, t0, 4)), 'REJECT', want_reject=rings4)
        allok &= show(f'WC tip(h-)->2 t0={t0}', check_fragment(G.tip(base, t0, 2, 'h-')), 'ACCEPT')
        base = G.wch()
        allok &= show(f'WCH tip->2 t0={t0}', check_fragment(G.tip(base, t0, 2)), 'REJECT', want_reject=[('xS+', 'tip')])
        allok &= show(f'WCH tip->3 t0={t0}', check_fragment(G.tip(base, t0, 3)), 'REJECT', want_reject=[('yN+', 'tip')])
        allok &= show(f'WCH tip(h-)->2 t0={t0}', check_fragment(G.tip(base, t0, 2, 'h-')), 'REJECT', want_reject=[('xS-', 'tip')])
        allok &= show(f'WCH tip(h-)->3 t0={t0}', check_fragment(G.tip(base, t0, 3, 'h-')), 'REJECT', want_reject=[('yN-', 'tip')])
        allok &= show(f'WCH tip->4 t0={t0}', check_fragment(G.tip(base, t0, 4)), 'REJECT', want_reject=rings4)
        base = G.wc1h()
        allok &= show(f'WC1H tip->2 t0={t0}', check_fragment(G.tip(base, t0, 2)), 'REJECT', want_reject=[('xS', 'tip')])
        allok &= show(f'WC1H tip->3 t0={t0}', check_fragment(G.tip(base, t0, 3)), 'REJECT', want_reject=[('yN', 'tip')])
        allok &= show(f'WC1H tip->4 t0={t0}', check_fragment(G.tip(base, t0, 4)), 'REJECT', want_reject=rings4)
    return allok


def plants():
    allok = True
    four = [('h+', 'N1'), ('h-', 'N1'), ('h+', 'S1'), ('h-', 'S1')]
    r = check_fragment(G.wc(kN=(P(0, 3), 2), kS=(P(0, -3), 2)))
    allok &= show('plant wc_flat', r, 'REJECT', want_reject=four)
    detail(r, four)
    allok &= show('plant wc_fat', check_fragment(G.wc(box_kw=dict(fat=True))), 'REJECT', want_reject=[('h+', 'N1')])
    cols = list(G.RING_COL); cols[2] = 2
    allok &= show('plant wc_col2', check_fragment(G.wc(ring_cols=cols)), 'REJECT', want_reject=[('v2', 'r2')])
    allok &= show('plant eq_steep', check_fragment(G.wceq(steep=True)), 'REJECT', want_reject=[('h+', 'N1'), ('h-', 'N1')])
    allok &= show('slip WCEQ-first (lower arc of WC)', check_fragment(G.wceq(lower_wc=True)), 'REJECT', want_reject=[('h+', 'S1'), ('h-', 'S1')])
    allok &= show('plant wch_ywide', check_fragment(G.wch(ywide=True)), 'REJECT',
                  want_reject=[('v3', 'yN+'), ('v3', 'yN-'), ('v2', 'xS+'), ('v2', 'xS-')])
    allok &= show('plant wc1h_ylow', check_fragment(G.wc1h(ylow=True)), 'REJECT', want_reject=[('v3', 'yN'), ('v2', 'xS')])
    return allok


def curv_circle(K, kappa, side=1):
    """the circle through the contact point K whose arc there is Y = kappa*T^2/2 (Y along +y), as (centre, radius)."""
    kappa = Fr(kappa)
    R = 1 / abs(kappa)
    return (P(0, K.y + (R if kappa > 0 else -R)), R)


def windows():
    """sharp tests of Y4-MU's mu and of Y4-TIP's window R_y = [-T^2/6, T^2/2) at WC's kappa = +-1/2, lambda = 2."""
    allok = True
    NN = G.NN
    # (a) mu = lambda/(1+lambda) at lambda = 1/2 (mu = 1/3): horn kappa2 = 3/10 < 1/3 ACCEPT; 9/25 > 1/3 REJECT on N's side.
    kN = curv_circle(NN, Fr(1, 2))
    for k2, exp in ((Fr(3, 10), 'ACCEPT'), (Fr(9, 25), 'REJECT')):
        kU = (P(0, 1 / k2), 1 / k2)
        r = check_fragment(G.wc(kN=kN, box_kw=dict(kU=kU)))
        allok &= show(f'mu test: lambda_N=1/2 (mu=1/3), kappa2={k2}', r, exp,
                      want_reject=None if exp == 'ACCEPT' else [('h+', 'N1'), ('h-', 'N1')])
    # (b) lambda_N = -1/2 (mu = -1): no horn fits; WC's horns REJECT on N's side
    r = check_fragment(G.wc(kN=curv_circle(NN, Fr(-1, 2))))
    allok &= show('mu test: lambda_N=-1/2 (mu=-1) with WC horns', r, 'REJECT', want_reject=[('h+', 'N1'), ('h-', 'N1')])
    # (c) R_y at N: colour-3 double horns with (lower, upper) curvatures (b, u); Y = b T^2/2 .. u T^2/2
    cases = [  # (b, u, fragment verdict, tip->3 verdict)
        (Fr(-3, 10), Fr(1, 2), 'ACCEPT', 'REJECT'),     # lower -0.15 T^2 inside R_y (> -1/6)
        (Fr(-9, 25), Fr(1, 2), 'REJECT', None),         # lower -0.18 T^2 below R_y: A-EXACT against v3
        (Fr(6, 5), Fr(8, 5), 'ACCEPT', 'ACCEPT'),       # 0.6 T^2 .. 0.8 T^2: above R_y (T^2/2), below N1 (T^2)
        (Fr(4, 5), Fr(8, 5), 'ACCEPT', 'REJECT'),       # 0.4 T^2 .. 0.8 T^2: meets R_y's top
    ]
    for b, u, fexp, texp in cases:
        up, lo = curv_circle(NN, u), curv_circle(NN, b)
        yN = G.cusp_pair(1, 3, up, lo, 'yN')
        base = G.wc(extraN=yN)
        r = check_fragment(base)
        allok &= show(f'R_y test: y-horn at N, Y in ({b / 2}, {u / 2}) T^2', r, fexp,
                      want_reject=None if fexp == 'ACCEPT' else [('v3', 'yN+'), ('v3', 'yN-')])
        if texp:
            for t0 in (Fr(1, 20), Fr(1, 200)):
                r = check_fragment(G.tip(base, t0, 3))
                allok &= show(f'   tip->3 t0={t0}', r, texp, want_reject=None if texp == 'ACCEPT' else [('yN+', 'tip')])
    return allok


def robust():
    allok = True
    saved = (G.CAP, G.HN, G.RS)
    for cap, hn, rs in ((Fr(1, 20), Fr(1, 40), Fr(1, 10)), (Fr(1, 10), Fr(1, 10), Fr(1, 40))):
        G.CAP, G.HN, G.RS = cap, hn, rs
        for name, (mk, npairs) in FRAG.items():
            allok &= show(f'{name} CAP={cap} HN={hn} RS={rs}', check_fragment(mk()), 'ACCEPT', npairs)
        t0 = Fr(1, 1000)
        allok &= show(f'  WCH tip->3 t0={t0}', check_fragment(G.tip(G.wch(), t0, 3)), 'REJECT', want_reject=[('yN+', 'tip')])
        allok &= show(f'  WC1H tip->2 t0={t0}', check_fragment(G.tip(G.wc1h(), t0, 2)), 'REJECT', want_reject=[('xS', 'tip')])
        allok &= show(f'  WC tip->3 t0={t0}', check_fragment(G.tip(G.wc(), t0, 3)), 'ACCEPT')
    G.CAP, G.HN, G.RS = saved
    return allok


def checkerplants():
    """faults planted in MY checker; each must turn a control or a plant to the wrong verdict, for its own reason."""
    allok = True
    q = Fr(1, 4)
    e = Fr(1, 100)
    tests = {
        'no_self': lambda: check_fragment(hexagons(Fr(51, 100), lambda m, n: (m + 3 * n) % 7, R=1))['verdict'],
        'no_arc_arc': lambda: check_fragment([disc('D1', P(0, 0), q, 1), disc('D2', P(Fr(149, 100), 0), q, 1)])['verdict'],
        'no_vertex_arc': lambda: K.check_pair(Tile('T', 1, [Seg(P(0, 0), P(Fr(-1, 20), Fr(-1, 10))), Seg(P(Fr(-1, 20), Fr(-1, 10)), P(Fr(1, 20), Fr(-1, 10))), Seg(P(Fr(1, 20), Fr(-1, 10)), P(0, 0))]),
                                              Tile('D', 1, [Arc(P(0, Fr(124, 100)), q, P(q, Fr(124, 100)), P(-q, Fr(124, 100))), Arc(P(0, Fr(124, 100)), q, P(-q, Fr(124, 100)), P(q, Fr(124, 100)))]))['verdict'],
        'no_intersect': lambda: K.check_pair(rect('X1', Fr(-3, 2), -e, Fr(3, 2), e, 1), rect('X2', -e, Fr(-3, 2), e, Fr(3, 2), 1))['verdict'],
    }
    for plant, fn in tests.items():
        before = fn()
        K.PLANT.add(plant)
        after = fn()
        K.PLANT.discard(plant)
        fired = before == 'REJECT' and after != 'REJECT'
        allok &= fired
        print(f'{"PASS" if fired else "FAIL"} checker plant {plant}: {before} -> {after} (must flip REJECT to not-REJECT)')
    # closed_interval: exactly the tight pairs REJECT
    for name in ('WC', 'WCH', 'WC1H', 'WCEQ'):
        base = check_fragment(FRAG[name][0]())
        K.PLANT.add('closed_interval')
        r = check_fragment(FRAG[name][0]())
        K.PLANT.discard('closed_interval')
        tp = sorted(p for p, _ in base['tight'] if p[0] != p[1])
        fired = sorted(r['reject']) == tp and len(tp) > 0
        allok &= fired
        print(f'{"PASS" if fired else "FAIL"} checker plant closed_interval on {name}: rejects {len(r["reject"])} = tight cross pairs {len(tp)}')
    return allok


if __name__ == '__main__':
    secs = sys.argv[1:] or ['controls', 'fragments', 'tips', 'plants']
    ok = True
    for s in secs:
        print(f'== {s}')
        ok &= globals()[s]()
    print('LOG', K.LOG)
    print('ALL-PASS' if ok else 'SOME-FAIL')
    sys.exit(0 if ok else 1)
