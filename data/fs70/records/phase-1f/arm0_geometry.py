#!/usr/bin/env python3
"""The control this phase owed and had not run: is the graph it priced actually a unit-distance graph?

Every number in phase 1f is about build/fs70/L3-w4/graph.json.  A point is (x, y) with
x = (a + b*sqrt3 + c*sqrt5 + d*sqrt15)/72 and z = x + iy, so |z|^2 = x^2 + y^2 must be exactly 1.  Expanding in
the basis (1, sqrt3, sqrt5, sqrt15) and clearing 72^2, an edge (p, q) with difference (a..d, e..h) is a unit
edge iff FOUR integer identities hold:

  a^2+3b^2+5c^2+15d^2 + e^2+3f^2+5g^2+15h^2 = 5184,   ab+5cd + ef+5gh = 0,
  ac+3bd + eg+3fh = 0,                                 ad+bc + eh+fg = 0.

Exact integer arithmetic, no floats.  Planted control: one coordinate of one endpoint moved by 1 must fail.
"""
import json, sys, time
import numpy as np
sys.path.insert(0, 'tools')
from fs70_price_cubes import load_cache

t0 = time.time()
pts, ind, ptr, meta = load_cache('build/fs70/1f', fast=False)
M = meta['meta']['M']
g = json.load(open('build/fs70/L3-w4/graph.json'))
E = np.array(g['edges'], dtype=np.int64); del g
print(f'{len(E):,} edges, denominator M = {M} ({time.time()-t0:.0f}s)', flush=True)

def check(D):
    a, b, c, d, e, f, gg, h = (D[:, i] for i in range(8))
    r = a*a + 3*b*b + 5*c*c + 15*d*d + e*e + 3*f*f + 5*gg*gg + 15*h*h
    s3 = a*b + 5*c*d + e*f + 5*gg*h
    s5 = a*c + 3*b*d + e*gg + 3*f*h
    s15 = a*d + b*c + e*h + f*gg
    return (r == M*M) & (s3 == 0) & (s5 == 0) & (s15 == 0)

bad = 0
for s in range(0, len(E), 2_000_000):
    blk = E[s:s+2_000_000]
    ok = check(pts[blk[:, 0]] - pts[blk[:, 1]])
    bad += int((~ok).sum())
print(f'edges failing the exact unit-distance identity: {bad}  -> {"PASS" if bad == 0 else "FAIL"}')

# planted control: move one endpoint of the first 5 edges by 1 in coordinate 0; each must now FAIL
P2 = pts.copy(); P2[E[:5, 0], 0] += 1
fired = int((~check(P2[E[:5, 0]] - P2[E[:5, 1]])).sum())
print(f'planted control (one coordinate moved by 1 on 5 edges): {fired}/5 now fail '
      f'-> {"FIRED" if fired == 5 else "DID NOT FIRE"}')
json.dump({'edges': int(len(E)), 'failing': bad, 'plant_fired': fired,
           'seconds': round(time.time()-t0, 1)}, open('build/fs70/1f/arm0.json', 'w'), indent=1)
print(f'done in {time.time()-t0:.0f}s')
