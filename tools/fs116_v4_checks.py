#!/usr/bin/env python3
"""FS116-V4's exact checks for its re-derivations of FS116-S1-KAPPA, -RUNG and -QF.

Every check is exact (fractions, or sympy for the one radical identity). Each subcommand
prints one short line. With --plant it runs the same check with one fault planted, so that a
pass is a check that could have failed. Nothing here enumerates maps or colourings of the
plane: the KAPPA check samples abstract labellings of germ slots on a circle, and the SQ9
checks evaluate the square nine-colouring (FS111-W-SQ9) at named points.

  parity     KAPPA's window parity: on a ring cut into 6m germ slots, every labelling of
             the slots by the two absent colours with label(i + m) = 1 - label(i) puts an
             odd number of change points in every half-open window of m consecutive slot
             boundaries. Prints the number of windows with an even count (expect 0).
             --plant counts in closed windows (m + 1 boundaries) instead.
  three      KAPPA's non-Siamese step: for change points c1 < c2 < c3 with c3 - c1 < 60 deg
             and the arcs J0 = (c1 - e, c1), J2 = (c2, c3), sJ1 = (c1 + 60, c2 + 60), the
             separations J0-J2 and J2-sJ1 stay below 60 deg and J0-sJ1 stays above 60 deg.
             Prints the number of violations over a rational grid (expect 0).
             --plant drops the hypothesis c3 - c1 < 60 deg.
  sq9anti    KAPPA's not-claimed control: in SQ9, r(45) and r(225) carry one colour.
             --plant compares r(45) with r(15) (r(135) would not do: it carries
             r(45)'s colour too, so that plant cannot fire).
  sq9rung    RUNG's partner step on an inhabitant (SQ9, saturated, k = 9): the points
             (s, 1 + 1/1000), 0 < s < 1/2, carry c_IV, the colour below the east edge.
             --plant looks at (s, -1 - 1/1000) instead.
  ceil       RUNG's "in particular" at phi = 120 deg: cos phi + sqrt(sin phi (2 - sin phi))
             equals sqrt(sqrt 3 - 3/4) - 1/2 exactly. --plant uses phi = 135 deg.
  outer      QF's outer-colour step: for a ring point r(g), g not a multiple of 90 deg, the
             quadrants whose whole closed cone makes an angle of at least 90 deg with r(g)
             are exactly the opposite quadrant. Prints the number of failures over a
             rational grid of g (expect 0). --plant widens the test to 60 deg.
"""
import sys
from fractions import Fraction as F


def parity(plant):
    import random
    rng = random.Random(116)
    bad = 0
    for m in (3, 4, 5, 7, 12):
        n = 6 * m
        for _ in range(400):
            first = [rng.randrange(2) for _ in range(m)]
            lab = [0] * n
            for i in range(n):
                k, r = divmod(i, m)
                lab[i] = first[r] ^ (k & 1)
            # boundary b sits between slot b-1 and slot b; it is a change point when labels differ
            chg = [lab[(b - 1) % n] != lab[b] for b in range(n)]
            width = m + 1 if plant else m
            for start in range(n):
                cnt = sum(chg[(start + j) % n] for j in range(width))
                bad += (cnt % 2 == 0)
    print(bad)


def three(plant):
    bad = 0
    eps = F(1, 1000)
    pts = [F(k, 2) for k in range(0, 160)]  # half-degree grid on [0, 80)
    for c1 in pts[:20]:
        for c2 in pts:
            for c3 in pts:
                if not (c1 < c2 < c3):
                    continue
                if not plant and not (c3 - c1 < 60):
                    continue
                if plant and not (c3 - c1 >= 60):
                    continue
                # separations between open intervals (a, b) and (c, d) with c > b-ish: (c - b, d - a)
                j0, j2, sj1 = (c1 - eps, c1), (c2, c3), (c1 + 60, c2 + 60)
                sup02 = j2[1] - j0[0]          # largest separation J0-J2 (not attained)
                sup2s = sj1[1] - j2[0]         # largest separation J2-sJ1 (not attained)
                inf0s = sj1[0] - j0[1]         # smallest separation J0-sJ1 (not attained)
                sup0s = sj1[1] - j0[0]
                ok = (sup02 <= 60 and j2[0] - j0[1] > 0 and sup2s <= 60 and sj1[0] - j2[1] > 0
                      and inf0s >= 60 and sup0s <= 180)
                bad += (not ok)
    print(bad)


def sq9_colour(x, y):
    # square nine-colouring of side 1/2 (FS111-W-SQ9): colour (floor(2x) mod 3, floor(2y) mod 3)
    import math
    return (math.floor(2 * x) % 3, math.floor(2 * y) % 3)


def sq9anti(plant):
    import sympy as s
    def col(deg):
        a = s.pi * deg / 180
        return (int(s.floor(2 * s.cos(a))) % 3, int(s.floor(2 * s.sin(a))) % 3)
    print(col(45) == (col(15) if plant else col(225)))


def sq9rung(plant):
    c_iv = sq9_colour(F(1, 4), F(-1, 4))
    ys = F(-1) - F(1, 1000) if plant else F(1) + F(1, 1000)
    print(all(sq9_colour(F(k, 100), ys) == c_iv for k in range(1, 50)))


def ceil(plant):
    import sympy as s
    phi = s.pi * (135 if plant else 120) / 180
    val = s.cos(phi) + s.sqrt(s.sin(phi) * (2 - s.sin(phi)))
    target = s.sqrt(s.sqrt(3) - s.Rational(3, 4)) - s.Rational(1, 2)
    print(s.simplify(val - target) == 0)


def outer(plant):
    # quadrant j's closed cone is [90 j, 90 j + 90] (j = 0 is quadrant I); the cone makes an angle
    # of at least 90 deg with direction g when every theta in it has theta - g in [90, 270] mod 360.
    lim = F(60) if plant else F(90)
    bad = 0
    for k in range(1, 720):
        g = F(k, 2)
        if g % 90 == 0:
            continue
        good = []
        for j in range(4):
            lo, hi = (F(90 * j) - g) % 360, (F(90 * j + 90) - g) % 360
            # the cone [lo, hi] (mod 360) of length 90 must lie inside [lim, 360 - lim]
            if lo <= hi and lo >= lim and hi <= 360 - lim:
                good.append(j)
        opposite = (int(g // 90) + 2) % 4
        bad += (good != [opposite])
    print(bad)


if __name__ == "__main__":
    cmd, plant = sys.argv[1], "--plant" in sys.argv[2:]
    {"parity": parity, "three": three, "sq9anti": sq9anti, "sq9rung": sq9rung,
     "ceil": ceil, "outer": outer}[cmd](plant)
