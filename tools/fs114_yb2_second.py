#!/usr/bin/env python3
"""FS114-YB2: a second checker on my Reuleaux bowtie -- FS114-YB's tools/fs114_yb_exact.py, imported and run unedited, on my tiles converted exactly
(Q(sqrt3) values carried over as its level-1 elements; my directed pieces as its (P, Q, ccw) pieces).  Plus a float sampling guard of every
same-colour pair's minimum and maximum distance (400 points per piece), never a verdict.
Run: python3 tools/fs114_yb2_second.py [--plant NAME]"""
from __future__ import annotations
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as Y        # noqa: E402  (FS114-YB's checker: imported, never edited)
import fs114_yb2_exact as X      # noqa: E402
import fs114_yb2_run as R        # noqa: E402

TY = Y.Tower.base().extend(3, "3")


def cn(x):
    return Y.Num(TY, 1, x.v)


def cp(p):
    return (cn(p[0]), cn(p[1]))


def conv(tiles):
    out = {}
    for nm, (col, ps) in tiles.items():
        qs = []
        for pc in ps:
            st, en = X.dse(pc)
            if pc.kind == "S":
                qs.append(Y.Seg(cp(st), cp(en)))
            else:
                qs.append(Y.Arc(cp(pc.C), cn(pc.rho), cp(st), cp(en), getattr(pc, "fwd", True)))
        out[nm] = Y.Tile(nm, col, qs)
    return out


def samples(ps, k=400):
    pts = []
    for pc in ps:
        st, en = X.dse(pc)
        if pc.kind == "S":
            a, b = (float(st[0]), float(st[1])), (float(en[0]), float(en[1]))
            pts += [(a[0] + (b[0] - a[0]) * i / k, a[1] + (b[1] - a[1]) * i / k) for i in range(k + 1)]
        else:
            c, r = (float(pc.C[0]), float(pc.C[1])), float(pc.rho)
            a0 = math.atan2(float(pc.S[1]) - c[1], float(pc.S[0]) - c[0])
            a1 = math.atan2(float(pc.E[1]) - c[1], float(pc.E[0]) - c[0])
            while a1 <= a0:
                a1 += 2 * math.pi
            pts += [(c[0] + r * math.cos(a0 + (a1 - a0) * i / k), c[1] + r * math.sin(a0 + (a1 - a0) * i / k)) for i in range(k + 1)]
    return pts


if __name__ == "__main__":
    plant = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == "--plant" else None
    tiles = R.Bowtie(plant).tiles()
    yt = conv(tiles)
    names = sorted(tiles)
    rej, nsf, n = [], [], 0
    lo_min, hi_diam = 9.0, 0.0
    for i, a in enumerate(names):
        for b in names[i:]:
            if tiles[a][0] != tiles[b][0]:
                continue
            n += 1
            r = Y.pair(yt[a], yt[b])
            if r.reject:
                rej.append((a, b))
            if a != b and r.min_lt1:
                nsf.append((a, b))
            sa, sb = samples(tiles[a][1]), samples(tiles[b][1])
            ds = [math.hypot(x[0] - y[0], x[1] - y[1]) for x in sa for y in sb]
            if a == b:
                hi_diam = max(hi_diam, max(ds))
                print(f"  {a}|{b}: FS114-YB reject={r.reject} max_eq1={r.max_eq1}; float max {max(ds):.9f}")
            else:
                lo_min = min(lo_min, min(ds))
                print(f"  {a}|{b}: FS114-YB reject={r.reject} min_eq1={r.min_eq1}; float min {min(ds):.9f} max {max(ds):.6f}")
    print(f"FS114-YB's checker (unedited): {n} same-colour pairs examined; rejected {rej}; min < 1 at distinct pairs {nsf}")
    print(f"float guard: least sampled distance between distinct same-colour tiles {lo_min:.9f}; greatest sampled tile diameter {hi_diam:.9f}")
