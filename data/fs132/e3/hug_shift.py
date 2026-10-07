#!/usr/bin/env python3
"""FS132-E3 control `hug-shift` (of C132-M-HUG and C132-M-STEP).

Coordinates (p = 0, angles in radians, e(t) = exp(it)).  A point z with 0 < |z| < 1 is written
    z = e(a) + e(a - 2pi/3 - d),  d > 0:
e(a) and e(a - 2pi/3 - d) are the two points of the unit circle about p at distance 1 from z.
For z near y0 = e(0) (so a near pi/3) and z' near y1 = e(pi/3), written by (a, d) and (a', d'),
|z - z'| = 1 fixes a' = a + pi/3 + D(d, d').  Claimed by the derivation:
  eps(d, d') := D(d, d') - d' > 0 for small d, d' > 0;  eps / (d d') -> 2/sqrt(3);  eps(d, 0) = 0;
  and with a = pi/3 - eps/2 the pair (z, z') has |z - y1| > 1, |z' - y0| > 1, |z| < 1, |z'| < 1, |z - z'| = 1.
Prints the range of eps/(d d') over a 12 x 12 grid (d, d' from 0.005 to 0.06), the number of grid points with
eps <= 0, and the number of grid points whose pair fails one of the five properties.
--fault: takes a = pi/3 + eps/2 (the other side of the change point): every pair then fails."""
import sys
from mpmath import mp, mpf, findroot, cos, sin, pi, sqrt, mpc, fabs
mp.dps = 40
fault = "--fault" in sys.argv
def e(t): return mpc(cos(t), sin(t))
def zpt(a, d): return e(a) + e(a - 2*pi/3 - d)
def D(d, dp):
    z = zpt(pi/3, d)                                    # the relation is rotation invariant
    return findroot(lambda x: abs(z - zpt(2*pi/3 + x, dp))**2 - 1, dp)
grid = [mpf(k)/200 for k in range(1, 13)]
lo = hi = None; nonpos = bad = 0
y0, y1 = e(0), e(pi/3)
for d in grid:
    for dp in grid:
        x = D(d, dp); eps = x - dp; q = eps/(d*dp)
        lo = q if lo is None or q < lo else lo
        hi = q if hi is None or q > hi else hi
        if eps <= 0: nonpos += 1
        a = pi/3 + (eps/2 if fault else -eps/2)
        z = zpt(a, d); zp = zpt(a + pi/3 + x, dp)
        ok = abs(z - y1) > 1 and abs(zp - y0) > 1 and abs(z) < 1 and abs(zp) < 1 and fabs(abs(z - zp) - 1) < mpf(10)**-25
        bad += 0 if ok else 1
axis = max(fabs(D(d, mpf(0))) for d in grid[:4])
print(f"ratio-min={float(lo):.4f} ratio-max={float(hi):.4f} limit={float(2/sqrt(3)):.4f} nonpositive={nonpos} bad-pairs={bad} axis-below-1e-30={axis < mpf(10)**-30}")
