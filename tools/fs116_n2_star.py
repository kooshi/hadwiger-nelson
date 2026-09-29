#!/usr/bin/env python3
"""FS116-N2 control for RT-STAR (and RT-ANTI's genericity) on held rings, in floats (aiming-grade reading of held exact objects).
At every change point y = p + e(psi) of the strip's midline vertices and the disk's corner (FS116-N1's ring tool, imported read-only):
  A(p) in P(y); tips (tiles of p at y) and outer tiles (other tiles of p's colours at y) have disjoint colours; each tip's cone at p lies in
  [psi-90, psi+90] and the p-tile of each outer colour in [psi+90, psi+270]; the germs of omega(y) at p carry colours absent at y.
--plant swaps the two half-planes (a wrong rule), which must report violations."""
import math, os, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs116_n1_ring as N1   # noqa: E402  read-only
PLANT = '--plant' in sys.argv
def tiles_at(TF, x): return N1.around(TF, x, r=1e-6, n=720)
def cone(TF, p, nm):  # sampled directions (deg) at p lying in tile nm
    return [a / 4 for a in range(0, 1440) if nm in N1.locate(TF, (p[0] + 1e-6 * math.cos(math.radians(a / 4 + .01)), p[1] + 1e-6 * math.sin(math.radians(a / 4 + .01))))]
def inhalf(dirs, c):  # all directions within 90 deg (+tol) of c
    return all(math.cos(math.radians(d - c)) >= -2e-3 for d in dirs)
out = []
for label, T0, p in N1.objects():
    TF = N1.fl_tiles(T0)
    col = lambda nm: TF[nm][0]
    tp = tiles_at(TF, p); Pp = {col(t) for t in tp}; Ap = {col(t) for t in TF} - Pp
    evs, rarcs = N1.ring_events(TF, p)
    for ev in evs:
        if N1.in_rarc(rarcs, ev - 1e-4) or N1.in_rarc(rarcs, ev + 1e-4): continue   # the ring off Gamma on both sides (reading L)
        psi = math.degrees(ev) % 360; y = (p[0] + math.cos(ev), p[1] + math.sin(ev))
        ty = tiles_at(TF, y); Py = {col(t) for t in ty}
        g = [N1.locate(TF, (y[0] + math.cos(math.radians(psi + 180 + s)), y[1] + math.sin(math.radians(psi + 180 + s)))) for s in (-.2, .2)]
        side = [N1.locate(TF, (p[0] + math.cos(ev + s * 1e-4), p[1] + math.sin(ev + s * 1e-4))) for s in (-1, 1)]
        if not (all(len(x) == 1 for x in side) and col(side[0][0]) != col(side[1][0])): continue   # change points only (ring off Gamma both sides)
        T = {col(t) for t in ty if t in tp}; O = {col(t) for t in ty if t not in tp and col(t) in Pp}
        ht, ho = (psi + 180, psi) if PLANT else (psi, psi + 180)
        ok = Ap <= Py and not (T & O) and all(inhalf(cone(TF, p, t), ht) for t in ty if t in tp) \
            and all(inhalf(cone(TF, p, t), ho) for t in tp if col(t) in O) and all(col(x[0]) not in Py for x in g if x)
        out.append(f"{label} y={psi:6.2f}: A(y)={''.join(sorted(Pp - Py))} T={''.join(sorted(T)) or '-'} O={''.join(sorted(O)) or '-'} {'OK' if ok else 'VIOLATION'}")
print('\n'.join(out)); print('STAR ALL OK' if all(l.endswith('OK') for l in out) else 'STAR VIOLATION')
