#!/usr/bin/env python3
"""arm 1d: the TRUE cube count at the depths the ladder probed.

Arm 1a enumerated the cubes exactly to depth 22 and found `11 x 66^h` -- propagation prunes nothing there, so
the wheels are independent.  I then extrapolated that formula to depths 40, 58 and 82, and that is wrong: at
depth 82 every vertex of the second shell has many fixed neighbours, propagation does cascade (the ladder's
depth-82 probes are refuted in 43 s and 93 s, and three colourings of the whole radius-2 ball in 8 s), so the
real tree is far smaller than `11 x 66^13`.

Full enumeration is out of reach, so the count is estimated by Knuth's random-descent estimator: walk from the
root, at each level take the children that survive propagation, multiply the running weight by how many there
are, and descend into one of them uniformly.  The arithmetic mean over probes is an UNBIASED estimate of the
number of leaves.  Its variance is large, so the median and the spread are reported beside it and the figure
is used only for its order of magnitude.
"""
import json, math, random, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f'
PINS = [(0, 0), (25, 1), (27, 2)]
t0 = time.time()
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
DEPTHS = [int(x) for x in (sys.argv[1] if len(sys.argv) > 1 else '22,40,58,82').split(',')]
PROBES = int(sys.argv[2]) if len(sys.argv) > 2 else 400
sets, cyc = FP.branching_sets(ind, ptr, PINS, DEPTHS)
rng = random.Random(20260922)
out = {}
for d in DEPTHS:
    cand = sets[d]
    ests, zeros = [], 0
    tstart = time.time()
    for _ in range(PROBES):
        dom = bytearray([FP.FULL]) * n
        trail = []
        for v, c in PINS:
            FP.propagate(dom, trail, ind, ptr, v, c)
        w = 1.0
        ok = True
        for i in range(len(cand)):
            v = cand[i]
            mask = int(dom[v])
            live = []
            for c in range(4):
                if not (mask >> c) & 1:
                    continue
                mk = len(trail)
                good = FP.propagate(dom, trail, ind, ptr, v, c)
                FP.undo(dom, trail, mk)
                if good:
                    live.append(c)
            if not live:
                ok = False
                break
            w *= len(live)
            FP.propagate(dom, trail, ind, ptr, v, rng.choice(live))
        if ok:
            ests.append(w)
        else:
            zeros += 1
        if time.time() - tstart > 900:
            break
    allv = ests + [0.0] * zeros
    mean = sum(allv) / len(allv)
    se = (sum((x - mean) ** 2 for x in allv) / max(1, len(allv) - 1) / len(allv)) ** 0.5
    med = sorted(ests)[len(ests) // 2] if ests else 0.0
    naive = 11 * 66 ** ((d - 4) // 6)
    out[d] = {'probes': len(allv), 'dead_probes': zeros, 'estimate': mean, 'standard_error': se,
              'median_of_live_probes': med, 'log10_estimate': round(math.log10(mean), 2) if mean else None,
              'independent_wheels_formula': naive,
              'log10_formula': round(math.log10(naive), 2),
              'seconds': round(time.time() - tstart, 1)}
    print(f'  depth {d}: estimate {mean:.4g} (+- {se:.2g}), median {med:.4g}, '
          f'{zeros}/{len(allv)} probes died; the independent-wheels formula says {naive:.4g} '
          f'[{time.time()-t0:.0f}s]', flush=True)
json.dump(out, open(f'{OUT}/arm1d.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
