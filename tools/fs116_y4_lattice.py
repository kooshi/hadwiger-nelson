#!/usr/bin/env python3
"""FS116-Y4: exact checks of the plane facts behind FS116-Y4-SYM, -SPOKE and -Q1 (a check of the hand readings at named points, not a proof and not a
search: no map, colouring, tile graph or ring type is enumerated).

Arithmetic: exact in Q(sqrt3), by FS114-YB's tower (tools/fs114_yb_exact.py, imported read-only).  Unit vectors near an angle are e(30k) times a
rational unit vector ((1-m^2)/(1+m^2), 2m/(1+m^2)), so every witness point is exact and every comparison with 1 is a sign.

  sym   [--plant swap]   the forced data of round 3 (star, ring colours, hub tips and outer colours, lens colours) mapped by sigma_30 with colours (3 4)
                         and by sigma_120 with (1 2)(X Xb): every datum must land on a datum.  Plant: sigma_30 with (1 2) instead.
  spoke [--plant q1]     at 12 points x = 2y_2 + s u(chi) (s = 1/10^4, chi = 15 + 30j): each exclusion FS116-Y4-SPOKE claims, with its witnesses checked
                         to lie in the region the argument puts them in.  Plant: Z_1's anchor q_1 moved to q_1 + (0, 1/4).
  q1    [--plant q1]     at 12 points x = q_1 + s u(chi): each exclusion FS116-Y4-Q1 claims, in its sector, with witnesses; and, outside each sector,
                         whether the same witnesses fail (reported, not asserted).  Plant: the centre q_1 moved to q_1 + (1/4, 0).
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as K   # noqa: E402  (read-only import)

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
T = K.Tower.base().extend(3, "3")
R3 = T.gen(1)
H = T(Fr(1, 2))
ZERO, ONE = T(0), T(1)


def E30(k):
    """the exact unit vector at angle 30k degrees."""
    c = [ONE, R3 / 2, H, ZERO, -H, -(R3 / 2), -ONE, -(R3 / 2), -H, ZERO, H, R3 / 2]
    k %= 12
    return (c[k], c[(k - 3) % 12])


def cmul(a, b):
    return (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0])


def ru(deg):
    """an exact unit vector at an angle within 0.01 degree of deg (deg in degrees)."""
    k = round(deg / 30)
    d = math.radians(deg - 30 * k)
    m = Fr(round(math.tan(d / 2) * 10**6), 10**6)
    r = (T((1 - m * m) / (1 + m * m)), T(2 * m / (1 + m * m)))
    return cmul(E30(k), r)


add, sub, n2, cross = K.vadd, K.vsub, K.n2, K.cross


def sc(t, v):
    return (v[0] * t, v[1] * t)


def lt1(a, b):
    return (n2(sub(a, b)) - 1).sign() < 0


def gt1(a, b):
    return (n2(sub(a, b)) - 1).sign() > 0


def in_open_cone(v, a_deg, b_deg):
    """direction of v strictly inside the ccw cone from a to b (width < 180; a, b multiples of 30)."""
    ea, eb = E30(a_deg // 30), E30(b_deg // 30)
    return cross(ea, v).sign() > 0 and cross(v, eb).sign() > 0


P = (ZERO, ZERO)
y = [E30(2 * k) for k in range(6)]
q = [add(y[k], y[(k + 1) % 6]) for k in range(6)]
y2x2 = sc(T(2), y[2])
TINY = [T(Fr(1, 10**j)) for j in (2, 3, 4, 5, 6, 7, 8)]


def on_ring_arc(w, k0, k1):
    """w on omega(p) strictly between y_k0 and y_k1 (60 degrees apart, ccw)."""
    return (n2(w) - 1).is0() and cross(y[k0], w).sign() > 0 and cross(w, y[k1]).sign() > 0


def in_lens(w, k):
    """w in L_k: within 1 of y_k and y_(k+1), not within 1 of p (open conditions, so w is interior)."""
    return lt1(w, y[k]) and lt1(w, y[(k + 1) % 6]) and gt1(w, P)


def witness(x, cands, region, want):
    """the first candidate in the region whose distance to x is below 1 (want='lt') or above 1 (want='gt'); None if none."""
    for w in cands:
        if region(w) and (lt1(x, w) if want == "lt" else gt1(x, w)):
            return w
    return None


def ring_near(k, side):
    """ring points near y_k, on the side toward y_(k+side), at shrinking angles."""
    out = []
    for t in TINY:
        m = t / 2
        r = (ONE - m * m, T(2) * m * side)
        nr = ONE + m * m
        out.append(cmul(y[k], (r[0] / nr, r[1] / nr)))
    return out


def near(z, deg):
    u = ru(deg)
    return [add(z, sc(t, u)) for t in TINY]


def straddle(x, lo_cands, lo_reg, hi_cands, hi_reg):
    a = witness(x, lo_cands, lo_reg, "lt")
    b = witness(x, hi_cands, hi_reg, "gt")
    return a is not None and b is not None


# =========================================================================== SYM
def run_sym():
    # forced data: (kind, angle in degrees, colour or colours); hubs at 60k, lens far vertices at 60k+30
    star = [("cone", (-30, 90), 1), ("cone", (90, 150), 3), ("cone", (150, 270), 2), ("cone", (270, 330), 4)]
    ring = [("ring", (60 * k, 60 * k + 60), "X" if k % 2 == 0 else "Xb") for k in range(6)]
    tips = [("tip", 0, 1), ("tip", 60, 1), ("tip", 120, 3), ("tip", 180, 2), ("tip", 240, 2), ("tip", 300, 4)]
    # outer colours at each hub: the forced one, and the optional second with its ccw order (None if no second option)
    outer = [("outer", 0, (3, (2, 3))), ("outer", 60, (4, (4, 2))), ("outer", 120, (4, None)), ("outer", 180, (4, (1, 4))),
             ("outer", 240, (3, (3, 1))), ("outer", 300, (3, None))]
    lens = [("lens", 90, 2), ("lens", 330, 2), ("lens", 150, 1), ("lens", 270, 1)]
    data = star + ring + tips + outer + lens
    maps = {"sigma_30": (lambda a: (60 - a) % 360, {3: 4, 4: 3}),
            "sigma_120": (lambda a: (240 - a) % 360, {1: 2, 2: 1, "X": "Xb", "Xb": "X"})}
    if PLANT == "swap":
        maps["sigma_30"] = (lambda a: (60 - a) % 360, {1: 2, 2: 1})
    ok_all = True
    for name, (f, cm) in maps.items():
        c = lambda v: cm.get(v, v)
        bad = []
        for kind, ang, col in data:
            if kind in ("cone", "ring"):
                a, b = ang
                img = (f(b) % 360, f(a) % 360)          # a reflection reverses orientation
                key = lambda z: (z[0] % 360, z[1] % 360 if z[1] % 360 else 360)
                want = [d for d in data if d[0] == kind and key(d[1]) == key(img)]
                if not want or want[0][2] != c(col):
                    bad.append((kind, ang, col))
            elif kind == "outer":
                forced, pair = col
                want = [d for d in data if d[0] == "outer" and d[1] == f(ang)]
                img_pair = None if pair is None else (c(pair[1]), c(pair[0]))   # ccw order reverses
                if not want or want[0][2][0] != c(forced) or want[0][2][1] != img_pair:
                    bad.append((kind, ang, col))
            else:
                want = [d for d in data if d[0] == kind and d[1] == f(ang)]
                if not want or want[0][2] != c(col):
                    bad.append((kind, ang, col))
        print(f"  {name}: {len(data)} forced data, {len(bad)} not carried to a datum{': ' + str(bad) if bad else ''}")
        ok_all &= not bad
    print("SYM: every datum carried" if ok_all else "SYM: FAILS")
    return 0


# =========================================================================== SPOKE
def run_spoke():
    s = T(Fr(1, 10**4))
    q1 = add(q[1], (ZERO, T(Fr(1, 4)))) if PLANT == "q1" else q[1]
    fails = []
    for j in range(12):
        chi = 15 + 30 * j
        x = add(y2x2, sc(s, ru(chi)))
        inside = (n2(sub(x, y[2])) - 1).sign() < 0
        # 2 by Z_1 (lens L_1 near q_1), 1 by Z_2 (lens L_2 near q_2): everywhere near 2y_2
        z1 = straddle(x, near(q1, 220), lambda w: in_lens(w, 1), near(q1, 320), lambda w: in_lens(w, 1))
        z2 = straddle(x, near(q[2], 20), lambda w: in_lens(w, 2), near(q[2], 280), lambda w: in_lens(w, 2))
        if not z1:
            fails.append((chi, "colour 2 (Z_1)"))
        if not z2:
            fails.append((chi, "colour 1 (Z_2)"))
        if inside:
            # Xb by R_12, X by R_23: ring points near y_2 and the ring points e(90), e(150)
            r12 = straddle(x, ring_near(2, -1), lambda w: on_ring_arc(w, 1, 2), [E30(3)], lambda w: on_ring_arc(w, 1, 2))
            r23 = straddle(x, ring_near(2, +1), lambda w: on_ring_arc(w, 2, 3), [E30(5)], lambda w: on_ring_arc(w, 2, 3))
            # 3 by T3: points near y_2 in its tip cone (270, 330), and points near p in its cone (90, 150)
            t3 = straddle(x, near(y[2], 300), lambda w: in_open_cone(sub(w, y[2]), 270, 330),
                          near(P, 120), lambda w: in_open_cone(w, 90, 150))
            # the 4-tile at x is within 1 of O_2's points near y_2 in its cone (90, 150)
            o2 = witness(x, near(y[2], 120), lambda w: in_open_cone(sub(w, y[2]), 90, 150), "lt") is not None
            for ok, nm in ((r12, "colour Xb (R_12)"), (r23, "colour X (R_23)"), (t3, "colour 3 (T3)"), (o2, "4-tile meets O_2")):
                if not ok:
                    fails.append((chi, nm))
        else:
            # outside: a 4-tile at x is within 1 of O_2's points inside omega(y_2) near 2y_2
            o2 = witness(x, near(y2x2, 240), lambda w: lt1(w, y[2]), "lt") is not None
            if not o2:
                fails.append((chi, "4-tile outside meets O_2"))
    for f in fails:
        print(f"  FAIL at chi = {f[0]}: {f[1]}")
    print(f"SPOKE facts at 12 points: {'all hold' if not fails else str(len(fails)) + ' fail'}")
    return 0


# =========================================================================== Q1
def run_q1():
    s = T(Fr(1, 10**4))
    c = add(q[1], (T(Fr(1, 4)), ZERO)) if PLANT == "q1" else q[1]
    fails, sharp = [], []
    for j in range(12):
        chi = 15 + 30 * j
        x = add(c, sc(s, ru(chi)))
        # Xb everywhere: R_12 holds e(90) within 1 (its far point is the distance-2 argument, checked as a lattice fact below)
        if not lt1(x, E30(3)):
            fails.append((chi, "Xb: e(90) within 1"))
        # 4 everywhere: O_2 holds points near y_2 (cone (90,150)) and points of B(y_2,1) near 2y_2
        o2 = straddle(x, near(y[2], 120), lambda w: in_open_cone(sub(w, y[2]), 90, 150), near(y2x2, 240), lambda w: lt1(w, y[2]))
        if not o2:
            fails.append((chi, "4 (O_2)"))
        claims = [
            ("X (R_23)", 150 < chi < 330, ring_near(2, +1), lambda w: on_ring_arc(w, 2, 3), [E30(5)], lambda w: on_ring_arc(w, 2, 3)),
            ("X (R_01)", chi > 210 or chi < 30, ring_near(1, -1), lambda w: on_ring_arc(w, 0, 1), [E30(1)], lambda w: on_ring_arc(w, 0, 1)),
            ("3 (T3)", 150 < chi < 330, near(y[2], 300), lambda w: in_open_cone(sub(w, y[2]), 270, 330), near(P, 120),
             lambda w: in_open_cone(w, 90, 150)),
            ("1 (T1)", chi > 210 or chi < 30, near(y[1], 240), lambda w: in_open_cone(sub(w, y[1]), 210, 270), near(P, 30),
             lambda w: in_open_cone(w, 0, 60)),
        ]
        for nm, claimed, lo, lr, hi, hr in claims:
            ok = straddle(x, lo, lr, hi, hr)
            if claimed and not ok:
                fails.append((chi, nm))
            if not claimed and ok:
                sharp.append((chi, nm))
        if 210 < chi < 330 and not in_lens(x, 1):
            fails.append((chi, "x in L_1"))
    # the lattice fact of the far point of R_12: |y_0 - q_1| = 2 with midpoint y_1
    if not ((n2(sub(y[0], q[1])) - 4).is0() and K.veq(sc(H, add(y[0], q[1])), y[1])):
        fails.append(("-", "|y_0 - q_1| = 2, midpoint y_1"))
    for f in fails:
        print(f"  FAIL at chi = {f[0]}: {f[1]}")
    print(f"  outside its claimed sector a witness also exists (information): {sharp if sharp else 'none'}")
    print(f"Q1 facts at 12 points: {'all hold' if not fails else str(len(fails)) + ' fail'}")
    return 0


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "sym"
    sys.exit({"sym": run_sym, "spoke": run_spoke, "q1": run_q1}[cmd]())
