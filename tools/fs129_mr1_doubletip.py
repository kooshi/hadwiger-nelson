#!/usr/bin/env python3
"""FS129-MR1 — exact checks for FS129-MR1-DOUBLETIP (the double tip at two adjacent change points, any ring).

Three checks, each of one step of the argument in plans/FS129-MR1-audit.md § Argument for FS129-MR1-DOUBLETIP.

1. colour: with the ring's off-boundary colours drawn from the two colours absent at p, a change point y
   (c(psi+) != c(psi-)) and the 60-degree twist (c(psi+60+) != c(psi+)) force c(psi+60+) = c(psi-): checked over
   every assignment from a palette of size 2.  --fault-colour uses a palette of size 3 (a seventh colour: three
   absent colours), where the two flank colours can differ.
2. flank: the least-curved flank edges, arcs of omega(y') from y and of omega(y) from y' (|y - y'| = 1), at turning
   angle phi are exactly 2cos(phi) - 1 apart (sympy, symbolic), below 1 for 0 < phi <= 60 degrees; V6-HUG's
   identity |a(s) - b(t)|^2 - 1 = -8 sin(s/2) sin(t/2) cos((s+t)/2) and the three-unit-step closure
   |u+v+w|^2 - 1 = (u+v)(v+w)(w+u)/(uvw) hold symbolically, and FS114-YB4-2ND's exact form of FS114-Y5-PXKILL's
   pair, 2(1 - cos s)(1 - cos t) - 2 sin s sin t, equals V6-HUG's right side; the ring points r(psi - d), r(psi + 60 + d) are
   2 sin(30 + d) > 1 apart.  --fault-flank replaces the arcs by the tangent segments (curvature 0), which stay 1 apart.
3. cone: on the circle of directions at y (psi = 0), every closed interval of directions (one cone: simple) that
   contains 210 and the ring germ direction 90+ either meets the open tip cone (150, 210) or contains the clockwise
   ring germ direction 270- in its interior: checked over every interval with endpoints on a 1-degree grid.
   --fault-cone drops the tip cone from the check (t absent), so an interval escapes.

Prints "colour ok; flank ok; cone ok" when all three hold.
"""
import itertools
import sys

import sympy as sp

FAULT_COLOUR = "--fault-colour" in sys.argv
FAULT_FLANK = "--fault-flank" in sys.argv
FAULT_CONE = "--fault-cone" in sys.argv


def colour_check():
    palette = ["X", "Y", "Z"] if FAULT_COLOUR else ["X", "Y"]
    bad = 0
    for c_minus, c_plus, c_plus60 in itertools.product(palette, repeat=3):
        if c_plus == c_minus:          # y is a change point
            continue
        if c_plus60 == c_plus:         # the twist (V4-TWIST)
            continue
        if c_plus60 != c_minus:
            bad += 1
    return "colour ok" if bad == 0 else f"colour: {bad} assignments with differing flank colours"


def flank_check():
    phi, s, t, d = sp.symbols("phi s t d", real=True)
    # y = 0, y' = e(120 deg) (psi = 0); edge at y leaving along 210 deg, edge at y' leaving along 210 deg.
    # least-curved case: arcs of the unit circles omega(y') and omega(y) themselves.
    yp = sp.Matrix([sp.cos(2 * sp.pi / 3), sp.sin(2 * sp.pi / 3)])
    if FAULT_FLANK:
        ea = phi * sp.Matrix([sp.cos(7 * sp.pi / 6), sp.sin(7 * sp.pi / 6)])
        eb = yp + phi * sp.Matrix([sp.cos(7 * sp.pi / 6), sp.sin(7 * sp.pi / 6)])
    else:
        # omega(y') through y: y' + e(300 deg - phi) leaves y (phi = 0) along 210 deg, curving toward y'
        ea = yp + sp.Matrix([sp.cos(5 * sp.pi / 3 - phi), sp.sin(5 * sp.pi / 3 - phi)])
        # omega(y) through y': e(120 deg + phi) leaves y' (phi = 0) along 210 deg, curving toward y
        eb = sp.Matrix([sp.cos(2 * sp.pi / 3 + phi), sp.sin(2 * sp.pi / 3 + phi)])
    dist2 = sp.simplify(((ea - eb).T * (ea - eb))[0])
    target = (2 * sp.cos(phi) - 1) ** 2
    if sp.simplify(sp.expand_trig(dist2 - target)) != 0:
        # report the distance at phi = 30 degrees
        v = sp.nsimplify(sp.sqrt(dist2.subs(phi, sp.pi / 6)))
        return f"flank: distance at 30 deg is {v}, not 2cos(phi) - 1"
    # V6-HUG's identity, with a(s) = y0 + e(120 + s), b(t) = y1 + e(300 - t), y0 = (1, 0), y1 = e(60)
    y0 = sp.Matrix([1, 0])
    y1 = sp.Matrix([sp.Rational(1, 2), sp.sqrt(3) / 2])
    a = y0 + sp.Matrix([sp.cos(2 * sp.pi / 3 + s), sp.sin(2 * sp.pi / 3 + s)])
    b = y1 + sp.Matrix([sp.cos(5 * sp.pi / 3 - t), sp.sin(5 * sp.pi / 3 - t)])
    lhs = ((a - b).T * (a - b))[0] - 1
    rhs = -8 * sp.sin(s / 2) * sp.sin(t / 2) * sp.cos((s + t) / 2)
    if sp.simplify(sp.expand_trig(sp.expand(lhs - rhs))) != 0:
        return "flank: V6-HUG identity fails"
    # FS114-YB4-2ND's exact form of FS114-Y5-PXKILL's pair is the same law, expanded
    yb4 = 2 * (1 - sp.cos(s)) * (1 - sp.cos(t)) - 2 * sp.sin(s) * sp.sin(t)
    if sp.simplify(sp.expand_trig(sp.expand(yb4 - rhs))) != 0:
        return "flank: YB4-2ND's form differs from V6-HUG's"
    # three-unit-step closure, on symbols u, v, w with conjugates 1/u, 1/v, 1/w
    u, v, w = sp.symbols("u v w", nonzero=True)
    lhs3 = (u + v + w) * (1 / u + 1 / v + 1 / w) - 1
    rhs3 = (u + v) * (v + w) * (w + u) / (u * v * w)
    if sp.simplify(lhs3 - rhs3) != 0:
        return "flank: three-step closure fails"
    # ring points r(-d) and r(60 + d) on omega(p): chord 2 sin(30 deg + d) > 1 for 0 < d < 120 deg
    chord = 2 * sp.sin(sp.pi / 6 + d)
    if not all(chord.subs(d, sp.pi * k / 360) > 1 for k in range(1, 60)):
        return "flank: ring points not more than 1 apart"
    return "flank ok"


def cone_check():
    # directions in degrees on a 1-degree grid; an interval [al, al + w] taken counter-clockwise, 0 < w < 360
    tip = set(range(151, 210))       # open tip cone (150, 210), grid interior points
    escape = 0
    for al in range(360):
        for wdt in range(1, 360):
            pts = {(al + k) % 360 for k in range(wdt + 1)}
            interior = {(al + k) % 360 for k in range(1, wdt)}
            if 210 not in pts or 91 not in pts:
                continue
            meets_tip = (not FAULT_CONE) and bool(tip & interior)
            holds_cw_germ = 269 in interior
            if not meets_tip and not holds_cw_germ:
                escape += 1
    return "cone ok" if escape == 0 else f"cone: {escape} intervals escape"


def main():
    out = [colour_check(), flank_check(), cone_check()]
    print("; ".join(out))


if __name__ == "__main__":
    main()
