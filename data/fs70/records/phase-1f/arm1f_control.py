#!/usr/bin/env python3
"""The positive control arm 1f demands: the radius-3 ball IS 4-colourable (committed: SAT in 14.6 s), so SOME
first-shell colouring survives it.  Take a real 4-colouring of that ball, read its first shell off, feed that
back as a cube, and it must come back SAT.  If it does not, the cube construction -- not the fabric -- is what
the 120/120 measured.

Then the discriminating half: check whether that surviving first-shell colouring is one the random generator
could ever have produced, i.e. whether each wheel is separately proper (it must be) -- so that 0 of 120 is a
statement about the SIZE of the surviving set, not about the generator's image."""
import json, subprocess, sys, time
import numpy as np
sys.path.insert(0, 'tools')
import fs70_price_cubes as FP

OUT = 'build/fs70/1f'; PINS = [(0, 0), (25, 1), (27, 2)]
pts, ind, ptr, meta = FP.load_cache(OUT, fast=True)
n = meta['n']
cyc = FP.hexagons(ind, ptr)
A = FP._void(pts); o = np.argsort(A, kind='stable'); sk = A[o]
G8 = pts[np.array(sorted(int(x) for x in ind[ptr[0]:ptr[1]]))]
lvl, cur = {0}, np.array([0])
for r in (1, 2, 3):
    cand = (pts[cur][:, None, :] + G8[None, :, :]).reshape(-1, 8)
    k = FP._void(cand); pos0 = np.clip(np.searchsorted(sk, k), 0, len(sk) - 1)
    cur = np.unique(o[pos0[sk[pos0] == k]]); lvl |= set(int(x) for x in cur)
V = sorted(lvl); pos = {v: i for i, v in enumerate(V)}
E = sorted({(pos[a], pos[b]) for a in V for j in range(ptr[a], ptr[a + 1])
            for b in [int(ind[j])] if b in pos and pos[a] < pos[b]})
cl = []
for i in range(len(V)):
    cl.append([FP.var(i, c) for c in range(4)])
    for c1 in range(4):
        for c2 in range(c1 + 1, 4):
            cl.append([-FP.var(i, c1), -FP.var(i, c2)])
for a, b in E:
    for c in range(4):
        cl.append([-FP.var(a, c), -FP.var(b, c)])
for v, c in PINS:
    cl.append([FP.var(pos[v], c)])
p = f'{OUT}/ctl3.cnf'
open(p, 'w').write(f'p cnf {4*len(V)} {len(cl)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl))
t = time.time()
r = subprocess.run(['kissat', '-q', '--time=600', p], capture_output=True, text=True)
assert r.returncode == 10, f'the radius-3 ball came back {r.returncode}, not SAT -- the bed is wrong'
lits = [int(x) for line in r.stdout.splitlines() if line.startswith('v ') for x in line[2:].split()]
val = {abs(x): x > 0 for x in lits if x}
C = [next(c for c in range(4) if val.get(FP.var(i, c), False)) for i in range(len(V))]
assert all(C[a] != C[b] for a, b in E), 'the model is not proper'
print(f'the radius-3 ball: SAT in {time.time()-t:.2f}s, model proper on all {len(E):,} edges')

shell1 = sorted(int(x) for x in ind[ptr[0]:ptr[1]])
cube = tuple((v, C[pos[v]]) for v in shell1 if v not in {x for x, _ in PINS})
print(f'its first-shell colouring: {len(cube)} vertices')
# each wheel must be separately proper -- so this cube lies in the random generator's image
okw = all(C[pos[c[i]]] != C[pos[c[(i + 1) % 6]]] for c in cyc for i in range(6))
print(f'every wheel separately proper (so the generator COULD have drawn it): {okw}')
p2 = f'{OUT}/ctl3cube.cnf'
open(p2, 'w').write(f'p cnf {4*len(V)} {len(cl)+len(cube)}\n' +
                    ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl) +
                    ''.join(f'{FP.var(pos[v], c)} 0\n' for v, c in cube))
t = time.time()
rc = subprocess.run(['kissat', '-q', '-n', '--time=300', p2], capture_output=True).returncode
v = {20: 'UNSAT', 10: 'SAT'}.get(rc, f'UNKNOWN({rc})')
print(f'POSITIVE CONTROL -- that first-shell colouring fed back as a cube: {v} in {time.time()-t:.2f}s '
      f'-> {"PASS" if v == "SAT" else "FAIL: the cube construction is what the 120/120 measured"}')
json.dump({'radius3': 'SAT', 'wheels_separately_proper': bool(okw), 'control_verdict': v},
          open(f'{OUT}/arm1f-control.json', 'w'), indent=1)
