#!/usr/bin/env python3
"""FS116-V6 — the hugging lemma's distance (lemma V6-HUG in plans/FS116-V6-verification.md).

p = 0, y_k = e(60k). a(s) = y_0 + e(120 + s) runs along the unit circle about y_0 from y_1 toward p; b(t) = y_1 + e(300 - t)
runs along the unit circle about y_1 from y_0 toward p (s, t in degrees). The lemma: for 0 < s, t <= 60,
    |a(s) - b(t)|^2 - 1 = -8 sin(s/2) sin(t/2) cos((s+t)/2) < 0.

Usage: fs116_v6_hug.py inward    the lemma's configuration (expect: identity holds; every grid pair below 1)
       fs116_v6_hug.py outward   the planted fault: b(t) = y_1 + e(300 + t) runs OUTWARD from y_0 (away from p); the same
                                 identity is asserted against it, and the grid count is printed — it must differ.
The identity is checked symbolically (sympy) and the sign on the grid s, t in {1, ..., 60} degrees in floating point; the
smallest deficit on that grid is 8 sin^2(0.5 deg) cos(1 deg) ~ 6.1e-4, far above double rounding, and the script asserts it.
"""
import math
import sys

import sympy as sp


def main() -> int:
    mode = sys.argv[1] if len(sys.argv) > 1 else "inward"
    if mode not in ("inward", "outward"):
        print(f"unknown mode {mode!r}")
        return 2
    sign = -1 if mode == "inward" else 1
    s, t = sp.symbols("s t", real=True)
    deg = sp.pi / 180
    e = lambda ang: sp.Matrix([sp.cos(ang * deg), sp.sin(ang * deg)])  # noqa: E731
    y0 = sp.Matrix([1, 0])
    y1 = sp.Matrix([sp.Rational(1, 2), sp.sqrt(3) / 2])
    a = y0 + e(120 + s)
    b = y1 + e(300 + sign * t)
    d2 = sp.expand((a - b).dot(a - b))
    claimed = -8 * sp.sin(s * deg / 2) * sp.sin(t * deg / 2) * sp.cos((s + t) * deg / 2)
    resid = sp.simplify(sp.expand_trig(sp.expand(d2 - 1 - claimed)))
    # a second, independent test of the identity: exact evaluation at 7 rational-degree points to 40 digits
    pts = [(1, 1), (7, 3), (30, 30), (45, 10), (60, 60), (13, 59), (2, 37)]
    numeric_ok = all(abs(sp.N((d2 - 1 - claimed).subs({s: u, t: v}), 40)) < sp.Float(10) ** -30 for u, v in pts)
    holds = (resid == 0) and numeric_ok
    below = 0
    total = 0
    worst = None
    for si in range(1, 61):
        for ti in range(1, 61):
            ax = 1 + math.cos(math.radians(120 + si))
            ay = math.sin(math.radians(120 + si))
            bx = 0.5 + math.cos(math.radians(300 + sign * ti))
            by = math.sqrt(3) / 2 + math.sin(math.radians(300 + sign * ti))
            v = (ax - bx) ** 2 + (ay - by) ** 2 - 1
            total += 1
            if v < 0:
                below += 1
            worst = abs(v) if worst is None else min(worst, abs(v))
    assert worst is not None and worst > 1e-4, f"grid value within rounding of 0: {worst}"
    print(f"identity {'holds' if holds else 'fails'}; below 1: {below} of {total}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
