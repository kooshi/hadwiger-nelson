#!/usr/bin/env python3
"""FS110-YB4: float cross-check of the rebuilt fragments WCH and WC1H (and their tips) against region predicates written
independently of the boundary pieces: (1) the tiles do not overlap and cover the discs of radius 0.05 about v, N, S' and
the band 0.93 <= r <= 1.07; (2) for every same-colour pair, sampled cross-distances lie inside the exact [min, max] of
tools/fs110_yb4_check.py and approach its ends.  Floats propose; the exact checker decides (this is a guard on the
construction, not a verdict)."""
import sys
import numpy as np
sys.path.insert(0, 'tools')
import fs110_yb4_fragments as G
from fs110_yb4_check import check_pair

rng = np.random.default_rng(110)
th = [np.arctan2(p.y.f(), p.x.f()) % (2 * np.pi) for p in G.ring_dirs()]
S3 = np.sqrt(3)


def U(x, c, R, lower):   # circle (0,c) R at abscissa x, lower/upper branch
    h = np.sqrt(np.maximum(R * R - x * x, 0))
    return c - h if lower else c + h


def ring_pred(k):
    a0, a1 = th[k], th[(k + 1) % 9]
    def f(x, y):
        r = np.hypot(x, y); a = np.arctan2(y, x) % (2 * np.pi)
        ina = ((a - a0) % (2 * np.pi)) < ((a1 - a0) % (2 * np.pi))
        return (r > .9) & (r < 1.1) & ina
    return f


def preds(which):
    P = {}
    H = P
    yU = lambda x: U(x, 2, 2, True); yL = lambda x: U(x, -2, 2, False)
    P['h+'] = lambda x, y: (x > 0) & (x < .1) & (y > yL(x)) & (y < yU(x))
    if which == 'WCH':
        P['h-'] = lambda x, y: (x < 0) & (x > -.1) & (y > yL(x)) & (y < yU(x))
        P['v2'] = lambda x, y: (abs(x) < .1) & (y > yU(x)) & (y < .1)
        P['v3'] = lambda x, y: (abs(x) < .1) & (y < yL(x)) & (y > -.1)
        P['N1'] = lambda x, y: (np.hypot(x, y - 1.5) < .5) & (np.hypot(x, y - 1) < .1)
        P['S1'] = lambda x, y: (np.hypot(x, y + 1.5) < .5) & (np.hypot(x, y + 1) < .1)
        yNu = lambda x: U(x, 3, 2, True); yNl = lambda x: U(x, -3, 4, False)
        P['yN+'] = lambda x, y: (x > 0) & (x < .05) & (y > yNl(x)) & (y < yNu(x))
        P['yN-'] = lambda x, y: (x < 0) & (x > -.05) & (y > yNl(x)) & (y < yNu(x))
        P['xS+'] = lambda x, y: P['yN+'](x, -y)
        P['xS-'] = lambda x, y: P['yN-'](x, -y)
        holesN = ['N1', 'yN+', 'yN-']; holesS = ['S1', 'xS+', 'xS-']
    else:
        P['v2'] = lambda x, y: (abs(x) < .1) & (y < .1) & (((x >= 0) & (y > yU(x))) | ((x < 0) & (y > 0)))
        P['v3'] = lambda x, y: (abs(x) < .1) & (y > -.1) & (((x >= 0) & (y < yL(x))) | ((x < 0) & (y < 0)))
        def sec(cy, a0, a1):
            def f(x, y):
                a = np.degrees(np.arctan2(y - cy, x)) % 360
                return (np.hypot(x, y - cy) < .05) & (a > a0) & (a < a1)
            return f
        P['N1'] = sec(1, 60, 180); P['yN'] = sec(1, 0, 60)
        P['S1'] = sec(-1, 180, 300); P['xS'] = sec(-1, 300, 360)
        holesN = ['capN']; holesS = ['capS']
        H = {}
        H['capN'] = lambda x, y: (np.hypot(x, y - 1) < .05) & (y > 1)
        H['capS'] = lambda x, y: (np.hypot(x, y + 1) < .05) & (y < -1)
    for k in range(9):
        base = ring_pred(k)
        hs = holesN if k == 2 else holesS if k == 7 else []
        P[f'r{k}'] = (lambda base, hs: lambda x, y: base(x, y) & ~np.any([H[h](x, y) for h in hs], axis=0) if hs else base(x, y))(base, hs)
    return P


def sample(pred, box, n):
    (x0, x1, y0, y1) = box
    out = []
    while sum(len(o) for o in out) < n:
        x = rng.uniform(x0, x1, 200000); y = rng.uniform(y0, y1, 200000)
        m = pred(x, y)
        out.append(np.stack([x[m], y[m]], 1))
    return np.concatenate(out)[:n]


def run(which, tiles, P, colours):
    bad = 0
    # (1) cover / overlap in the four regions
    for (cx, cy, r) in ((0, 0, .05), (0, 1, .05), (0, -1, .05)):
        a = rng.uniform(0, 2 * np.pi, 200000); rr = r * np.sqrt(rng.uniform(0, 1, 200000))
        x, y = cx + rr * np.cos(a), cy + rr * np.sin(a)
        cnt = sum(P[t](x, y).astype(int) for t in P)
        print(f'  {which} disc ({cx},{cy}): uncovered {np.mean(cnt == 0):.2e} overlap {np.mean(cnt > 1):.2e}')
        bad += np.sum(cnt > 1)
    a = rng.uniform(0, 2 * np.pi, 400000); rr = np.sqrt(rng.uniform(.93 ** 2, 1.07 ** 2, 400000))
    x, y = rr * np.cos(a), rr * np.sin(a)
    cnt = sum(P[t](x, y).astype(int) for t in P)
    print(f'  {which} band: uncovered {np.mean(cnt == 0):.2e} overlap {np.mean(cnt > 1):.2e}')
    bad += np.sum(cnt > 1) + np.sum(cnt == 0)
    # (2) sampled distances inside the exact range
    T = {t.name: t for t in tiles}
    boxes = {}
    for name in P:
        boxes[name] = (-.1, .1, -.1, .1) if name in ('h+', 'h-', 'v2', 'v3', 'tip') else \
            (-.12, .12, .88, 1.12) if name in ('N1', 'yN+', 'yN-', 'yN') else \
            (-.12, .12, -1.12, -.88) if name in ('S1', 'xS+', 'xS-', 'xS') else (-1.1, 1.1, -1.1, 1.1)
    worst = 0
    for i, A in enumerate(P):
        for B in list(P)[i:]:
            if colours[A] != colours[B]:
                continue
            sa, sb = sample(P[A], boxes[A], 1500), sample(P[B], boxes[B], 1500)
            dd = np.sqrt(((sa[:, None, :] - sb[None, :, :]) ** 2).sum(-1))
            r = check_pair(T[A], T[B])
            lo, hi = np.sqrt(max(r['lo'][0].f(), 0)), np.sqrt(r['hi'][0].f())
            smin, smax = (dd[dd > 0].min() if A == B else dd.min()), dd.max()
            viol = (smin < lo - 1e-9) or (smax > hi + 1e-9)
            worst = max(worst, (smin - lo) if A != B else 0, hi - smax)
            if viol:
                bad += 1
                print(f'  VIOLATION {A},{B}: sampled [{smin:.6f},{smax:.6f}] exact [{lo:.6f},{hi:.6f}]')
    print(f'  {which}: sampled ranges inside exact ranges; worst gap to the exact ends {worst:.4f}; bad={bad}')
    return bad == 0


ok = True
for which, mk in (('WCH', G.wch), ('WC1H', G.wc1h)):
    tiles = mk()
    P = preds(which)
    colours = {t.name: t.colour for t in tiles}
    assert set(P) == set(colours), (set(P) ^ set(colours))
    ok &= run(which, tiles, P, colours)
print('SAMPLE-PASS' if ok else 'SAMPLE-FAIL')
sys.exit(0 if ok else 1)
