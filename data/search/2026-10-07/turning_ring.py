#!/usr/bin/env python3
"""SEARCH-2026-10-07 — six-sector rings about a three-way point: the exact pair tables, the encoding, the decode.

The object (a "fragment" in FS110-Y's sense): seven flowers, about x = (0,0) and about the six ring points
y_k = e(60k deg), k = 0..5.  All data lie in Q(sqrt 3); every verdict is tools/fs110_y_check.pair_verdict (imported,
not edited): REJECT iff 1 is interior to the exact cross-distance range of two same-colour tiles.

  ring flower k   six curvilinear 60-degree wedges cut by the three unit circles through y_k (about x, y_{k-1}, y_{k+1}).
                  Wedge w lies between the rays at relative angles -90 + 60w and -30 + 60w (relative to the outward
                  direction e(60k)):  0 = O_cw, 1 = O_far, 2 = O_ccw (outside the ring), 3 = I_ccw, 4 = I_lens,
                  5 = I_cw (inside it).  Each ray is an arc of one of the three circles, of angle 2 atan(ta).
  x flower        twelve elementary 30-degree sub-sectors E_j (directions 30j .. 30j + 30).  The odd directions
                  30(2m+1) = 60k + 90 are the critical ones (tangent at x to the unit circles about y_k and y_{k+3});
                  a critical ray is S (straight), A (an arc of the unit circle about y_k) or B (about y_{k+3}).
  labels          0, 1, 2 = a, b, n (the ring's);  3, 4, 5 = the three labels meeting at x.

Subcommands:
  tables OUT.json [--ta 1/8] [--plant NAME]   every pair verdict (ring x ring, x-subtile x ring), exact; in parallel
  geom   [--ta 1/8]                            float guard: flowers cover a disc about their centre, no overlap
"""
from __future__ import annotations
import sys, os, json, math, itertools, multiprocessing
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools"))
import fs110_y_check as C      # noqa: E402  (frozen by convention; imported only)
import fs110_y_fragments as F  # noqa: E402  (for e, on_circle, polyline, inside; imported only)

Seg, Arc, pt, add, mul = C.Seg, C.Arc, C.pt, C.add, C.mul
X0 = pt(0, 0)
Y = [F.e(60 * k) for k in range(6)]
WNAME = ["O_cw", "O_far", "O_ccw", "I_ccw", "I_lens", "I_cw"]
TYPES = ["S", "A", "B"]
GPLANT = None      # geometry plants: "far_chord" (the two rays of O_far replaced by chords), "x_shift" (x flower moved)


def ring_flower(k, ta):
    """the six wedges at y_k, each a list of three primitives (two rays and a closing chord)."""
    km, kp = (k - 1) % 6, (k + 1) % 6
    y = Y[k]
    P = [F.on_circle(X0, 60 * k, ta, -1),            # rel -90: along the ring, clockwise
         F.on_circle(Y[km], 60 * k + 60, ta, -1),    # rel -30: on the unit circle about y_{k-1}
         F.on_circle(Y[kp], 60 * k - 60, ta, +1),    # rel +30: on the unit circle about y_{k+1}
         F.on_circle(X0, 60 * k, ta, +1),            # rel +90: along the ring, counter-clockwise
         F.on_circle(Y[km], 60 * k + 60, ta, +1),    # rel 150: on the unit circle about y_{k-1}
         F.on_circle(Y[kp], 60 * k - 60, ta, -1)]    # rel 210: on the unit circle about y_{k+1}
    rays = [Arc(X0, 1, P[0], y), Arc(Y[km], 1, P[1], y), Arc(Y[kp], 1, y, P[2]),
            Arc(X0, 1, y, P[3]), Arc(Y[km], 1, y, P[4]), Arc(Y[kp], 1, P[5], y)]
    if GPLANT == "far_chord":
        rays[1], rays[2] = Seg(P[1], y), Seg(y, P[2])
    return [[rays[w], rays[(w + 1) % 6], Seg(P[w], P[(w + 1) % 6])] for w in range(6)]


def crit_of(j):
    """the critical (odd) direction index bounding E_j, and its m = 0..5 (direction 30(2m+1))."""
    jc = j if j % 2 == 1 else j + 1
    return jc % 12, ((jc % 12) - 1) // 2


def x_subtile(j, ty, ta):
    """E_j, the sub-sector of the x flower between directions 30j and 30j + 30; ty = type of its critical ray."""
    rho = C.q(2 * Fr(ta) / (1 + Fr(ta) ** 2))          # = sin(2 atan ta): about the rays' length
    jc, m = crit_of(j)
    jn = (j + 1) % 12 if j % 2 == 1 else j
    org = X0 if GPLANT != "x_shift" else pt(Fr(1, 50), 0)
    pn = add(org, mul(rho, F.e(30 * jn)))
    rn = Seg(org, pn)
    k = ((jc - 3) // 2) % 6                             # 30 jc = 60k + 90
    if ty == "S" or GPLANT == "x_shift":
        pc = add(org, mul(rho, F.e(30 * jc))); rc = Seg(org, pc)
    elif ty == "A":                                     # on the unit circle about y_k
        pc = F.on_circle(Y[k], 60 * k + 180, ta, -1); rc = Arc(Y[k], 1, pc, X0)
    else:                                               # "B": on the unit circle about y_{k+3}
        pc = F.on_circle(Y[(k + 3) % 6], 60 * k, ta, +1); rc = Arc(Y[(k + 3) % 6], 1, X0, pc)
    return [rn, rc, Seg(pn, pc)]


# ------------------------------------------------------------------ the tables
_TA = None


def _init(ta, plant, gplant):
    global _TA, GPLANT
    _TA = ta; C.PLANT = plant; GPLANT = gplant


def _rr(job):
    (k, a, k2, b) = job
    t1, t2 = ring_flower(k, _TA)[a], ring_flower(k2, _TA)[b]
    return (job, C.pair_verdict(t1, t2, self_pair=((k, a) == (k2, b))))


def _xr(job):
    (j, ty, k, w) = job
    return (job, C.pair_verdict(x_subtile(j, ty, _TA), ring_flower(k, _TA)[w]))


def tables(ta, plant=None, gplant=None, procs=12):
    ring = [(k, w) for k in range(6) for w in range(6)]
    rr_jobs = [(k, a, k2, b) for (k, a), (k2, b) in itertools.combinations_with_replacement(ring, 2)]
    xr_jobs = [(j, ty, k, w) for j in range(12) for ty in TYPES for (k, w) in ring]
    ctx = multiprocessing.get_context("fork")
    with ctx.Pool(procs, initializer=_init, initargs=(ta, plant, gplant)) as pool:
        rr = pool.map(_rr, rr_jobs, chunksize=8)
        xr = pool.map(_xr, xr_jobs, chunksize=8)
    assert len(rr) == len(rr_jobs) == 666 and len(xr) == len(xr_jobs) == 1296
    return {"ta": str(ta), "plant": plant, "gplant": gplant,
            "rr_reject": sorted([list(j) for j, v in rr if v == "REJECT"]),
            "xr_reject": sorted([list(j) for j, v in xr if v == "REJECT"]),
            "rr_pairs": len(rr), "xr_pairs": len(xr)}


# ------------------------------------------------------------------ float geometry guard (not a verdict)
def geom(ta):
    r = 0.6 * 2 * math.atan(float(ta))       # sample radius: inside every flower
    bad = n = 0
    for k in range(6):
        fl = ring_flower(k, ta)
        cx, cy = Y[k][0].f(), Y[k][1].f()
        for i in range(-10, 11):
            for jj in range(-10, 11):
                x, y = cx + r * i / 10 + 1.3e-7, cy + r * jj / 10 + 2.1e-7
                if (x - cx) ** 2 + (y - cy) ** 2 > r * r: continue
                inn = [w for w in range(6) if F.inside(fl[w], x, y)]
                # the expected wedge, from the three circles
                o = math.hypot(x, y) > 1
                ip = math.hypot(x - Y[(k + 1) % 6][0].f(), y - Y[(k + 1) % 6][1].f()) < 1
                im = math.hypot(x - Y[(k - 1) % 6][0].f(), y - Y[(k - 1) % 6][1].f()) < 1
                want = {(True, False, True): 0, (True, False, False): 1, (True, True, False): 2,
                        (False, True, False): 3, (False, True, True): 4, (False, False, True): 5}[(o, ip, im)]
                n += 1; bad += (inn != [want])
    for kinds in ("SSSSSS", "AAAAAA", "BBBBBB", "SABSAB"):
        for i in range(-10, 11):
            for jj in range(-10, 11):
                x, y = r * i / 10 + 1.3e-7, r * jj / 10 + 2.1e-7
                if x * x + y * y > r * r: continue
                inn = [j for j in range(12) if F.inside(x_subtile(j, kinds[crit_of(j)[1]], ta), x, y)]
                want = int((math.degrees(math.atan2(y, x)) % 360) // 30)
                n += 1; bad += (len(inn) != 1) or (kinds == "SSSSSS" and inn != [want])
    return n, bad


if __name__ == "__main__":
    a = sys.argv[1:]
    ta = Fr(a[a.index("--ta") + 1]) if "--ta" in a else Fr(1, 8)
    plant = a[a.index("--plant") + 1] if "--plant" in a else None
    gplant = a[a.index("--gplant") + 1] if "--gplant" in a else None
    if a[0] == "tables":
        T = tables(ta, plant, gplant)
        with open(a[1], "w") as fh:
            json.dump(T, fh, indent=0)
        print(f"ta={ta} plant={plant} gplant={gplant} ring-ring pairs={T['rr_pairs']} REJECT={len(T['rr_reject'])}  "
              f"x-ring pairs={T['xr_pairs']} REJECT={len(T['xr_reject'])}  -> {a[1]}")
    elif a[0] == "geom":
        GPLANT = gplant
        n, bad = geom(ta)
        print(f"ta={ta} gplant={gplant} geometry-samples={n} wrong-tile-count={bad}")
        sys.exit(0 if bad == 0 else 1)
