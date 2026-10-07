#!/usr/bin/env python3
"""FS136-E2 — a second path to the tables at the four stops, in floats, straight from C124-SHADOW-OPEN (no classes, no
cyclic order): for a point z at distance 1e-6 from w inside each corner cut at w, a label is barred at z iff the unit circle
about z meets a corner of that label at a member (the corner sampled at radii from 0.02 down to 2e-9: a sign change of
|q - z| - 1 over its samples).  The labels left must be the ones closure.py's exact table leaves, corner by corner.
  python3 data/fs136/e2/shadow_check.py [--fault]      --fault reads z on the far side of w (the opposite corner's place)."""
import sys, os, math
FAULT = "--fault" in sys.argv; sys.argv = [sys.argv[0]]
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import closure as C

for name in ("strip", "disk", "bowtie", "flower"):
    ob = C.obj_tiles(name); p, x, y = (ob["locate"](q) for q in C.STOPS[name]); w = C.sub(C.add(x, y), p)
    run = C.Run(ob["labels"])
    for z in (x, y): run.add(z, ob["corners"](z)[0])
    wi = run.R.id(w); mem, tab = run.table(wi); wf = C.fl(w); agree = 0; shown = []
    for c in tab:
        z = C.samples(c["lo"], c["hi"], w, ts=(1e-6,), frs=(0.5,))[0]
        if FAULT: z = (2 * wf[0] - z[0], 2 * wf[1] - z[1])
        barred = set()
        for xi in mem:
            xf = C.fl(run.R.P[xi])
            for g in run.fam[xi]:
                vals = []
                for t in [0.02 * 10 ** (-k / 4) for k in range(29)]:
                    a, b = C.cpt(g.lo, xf, t), C.cpt(g.hi, xf, t)
                    a0 = math.atan2(a[1] - xf[1], a[0] - xf[0]); sp = (math.atan2(b[1] - xf[1], b[0] - xf[0]) - a0) % C.TAU
                    for i in range(1, 80):
                        q = (xf[0] + t * math.cos(a0 + i / 80 * sp), xf[1] + t * math.sin(a0 + i / 80 * sp))
                        vals.append(math.hypot(q[0] - z[0], q[1] - z[1]) - 1)
                if min(vals) < -1e-14 and max(vals) > 1e-14: barred.add(g.label)
        left = ob["labels"] - barred; agree += left == c["left"]; shown.append(C.lstr(left))
    print(f"{name}: corners at w={len(tab)} left by the shadow: {' '.join(shown)} | agree with the exact table: {agree} of {len(tab)}")
