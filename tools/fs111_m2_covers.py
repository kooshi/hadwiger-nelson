#!/usr/bin/env python3
"""FS111-M2: exact checks of the maximal covers DISC7 (k = 7) and SQ9 (k = 9).

Checks, all in exact rational arithmetic (no floats anywhere in a verdict):

  M2-FIX (the shadow identity) for each class F of the cover, at every point z of an
  exact grid covering a period cell with margin:
        z in int F   XOR   z in F + S^1        (F + S^1 = points at distance exactly 1 from F)
  "both" means an interior point at distance 1 from the class (a unit pair: not
  unit-avoiding); "neither" means a free point (the class is not maximal).

  COVER: every grid point lies in the closed class of some colour.
  DISC7 only: same-class centres >= 2 apart (unit-avoiding), every disc has exclusive
  points (its centre is in no other class), neighbouring discs overlap (lens points).

DISC7. Hex7's centres c(m, n) = m(sqrt3/2, 0) + n(sqrt3/4, 3/4), colour (m + 3n) mod 7;
class a = union of closed discs of radius 1/2 about its centres.  Grid points
z = (i*sqrt3/(4N), 3j/(4N)) make every |z - c|^2 rational:
    |z - c(m, n)|^2 = (3/16)(i/N - 2m - n)^2 + (9/16)(j/N - n)^2.
For a disc of radius r about c:  z in int  iff |z-c| < r;  T_1(z) meets the disc
iff (1 - r) <= |z - c| <= 1 + r  (r <= 1).

SQ9. Closed squares [3i/2, 3i/2 + 1/2] x [3j/2, 3j/2 + 1/2] form class (0, 0) (the
other eight are translates by multiples of 1/2); a closed square K and a point z:
T_1(z) meets K iff dist(z, K) <= 1 <= maxdist(z, K) (K connected).

Plants (each must fire for its own reason, and only that):
  disc-r11/20   radius 11/20: internal diameter 1.1 -> "both" (and nothing else)
  disc-idx13    colours by m + 4n mod 13 (13 classes, min norm 13): covering radius
                sqrt(13)/2 > 3/2 -> "neither" (and nothing else)
  disc-drop6    only colours 0..5 used as the cover -> COVER fails (and nothing else)
  sq-period2    squares of side 1/2 at period 2 (16 colours): slack -> "neither"
  sq-side3/4    squares of side 3/4 at period 3/2: gap 3/4 < 1 -> "both"
Faithful twins (DISC7, SQ9) must pass every check.

Output: data/fs111/fs111-m2/covers.out (also printed).  Exit 0 iff every faithful
object passes and every plant fires exactly its named failure.
"""
from fractions import Fraction as Fr
import itertools
import sys

OUT = "data/fs111/fs111-m2/covers.out"
lines = []


def log(s=""):
    print(s)
    lines.append(s)


# ---------------------------------------------------------------- DISC-type covers
def disc_centres(colour_of, ncol, window):
    """Centres (m, n) with m, n in window, grouped by colour."""
    by = {a: [] for a in range(ncol)}
    for m in range(-window, window + 1):
        for n in range(-window, window + 1):
            by[colour_of(m, n)].append((m, n))
    return by


def d2(i, j, N, m, n):
    """|z - c(m, n)|^2 for z = (i*sqrt3/(4N), 3j/(4N)); rational."""
    return Fr(3, 16) * (Fr(i, N) - 2 * m - n) ** 2 + Fr(9, 16) * (Fr(j, N) - n) ** 2


def check_disc(name, colour_of, ncol, r, cover_colours=None, N=4, box=(-8, 44, -6, 34)):
    """Shadow identity per class, the cover, exclusivity and lenses.  Returns the set of
    failure kinds found: {'both', 'neither', 'cover', 'pairs', 'exclusive', 'lens'}."""
    if cover_colours is None:
        cover_colours = list(range(ncol))
    by = disc_centres(colour_of, ncol, 60)
    r2 = r * r
    lo2, hi2 = (1 - r) ** 2, (1 + r) ** 2
    fails = set()
    first = {}
    i0, i1, j0, j1 = box
    npts = 0
    for i in range(i0, i1 + 1):
        for j in range(j0, j1 + 1):
            npts += 1
            covered = False
            inside = [False] * ncol
            shadow = [False] * ncol
            # every centre within distance 1 + r <= 1.6 of z: |Y| <= 2.2, |X| <= 3.8
            nc = j // N
            for n in range(nc - 4, nc + 5):
                mc = (i // N - n) // 2
                for m in range(mc - 4, mc + 5):
                    a = colour_of(m, n)
                    q = d2(i, j, N, m, n)
                    if q < r2:
                        inside[a] = True
                    if lo2 <= q <= hi2:
                        shadow[a] = True
                    if q <= r2 and a in cover_colours:
                        covered = True
            for a in range(ncol):
                if inside[a] and shadow[a]:
                    fails.add("both")
                    first.setdefault("both", (i, j, a))
                if not inside[a] and not shadow[a]:
                    fails.add("neither")
                    first.setdefault("neither", (i, j, a))
            if not covered:
                fails.add("cover")
                first.setdefault("cover", (i, j))
    # class-level: same-class centres (unit-avoiding needs centre distance >= 1 + 2r
    # when 2r <= 1 ... and a disc of diameter 2r > 1 has internal pairs anyway)
    for a in range(ncol):
        cs = [c for c in by[a] if abs(c[0]) <= 8 and abs(c[1]) <= 8]
        for c, c2 in itertools.combinations(cs, 2):
            q = Fr(3, 4) * ((c[0] - c2[0]) ** 2 + (c[0] - c2[0]) * (c[1] - c2[1]) + (c[1] - c2[1]) ** 2)
            if q < (1 + 2 * r) ** 2 and q > 0:
                fails.add("pairs")
                first.setdefault("pairs", (c, c2))
    # exclusivity and lenses (only meaningful for the full colouring)
    allc = [(c, a) for a in range(ncol) for c in by[a] if abs(c[0]) <= 3 and abs(c[1]) <= 3]
    for (c, a) in allc:
        for (c2, b) in allc:
            if b == a:
                continue
            q = Fr(3, 4) * ((c[0] - c2[0]) ** 2 + (c[0] - c2[0]) * (c[1] - c2[1]) + (c[1] - c2[1]) ** 2)
            if q <= r2:
                fails.add("exclusive")
                first.setdefault("exclusive", (c, c2))
    # lens: midpoint of c(0,0) and c(1,0) is inside both discs iff (sqrt3/4)^2 = 3/16 < r^2
    if not (Fr(3, 16) < r2 and colour_of(0, 0) != colour_of(1, 0)):
        fails.add("lens")
    log(f"[{name}] grid points {npts} x {ncol} classes; failures: {sorted(fails) or 'none'}; first: {first}")
    return fails


# ---------------------------------------------------------------- square covers
def sq_dist2(x, y, a, b, s):
    """squared dist and squared maxdist from (x, y) to the closed square [a, a+s] x [b, b+s]."""
    dx = max(Fr(0), a - x, x - (a + s))
    dy = max(Fr(0), b - y, y - (b + s))
    Dx = max(abs(x - a), abs(x - (a + s)))
    Dy = max(abs(y - b), abs(y - (b + s)))
    return dx * dx + dy * dy, Dx * Dx + Dy * Dy


def check_sq(name, side, period, step=Fr(1, 16)):
    """Class (0,0): squares [p*i, p*i + side] x [p*j, p*j + side].  Shadow identity on an
    exact grid over one period cell with margin."""
    fails = set()
    first = {}
    npts = 0
    k = int(period / step)
    for u in range(-k, 2 * k + 1):
        for v in range(-k, 2 * k + 1):
            x, y = u * step, v * step
            npts += 1
            inside = shadow = False
            for i in range(-3, 5):
                for j in range(-3, 5):
                    a, b = period * i, period * j
                    if a < x < a + side and b < y < b + side:
                        inside = True
                    dd, DD = sq_dist2(x, y, a, b, side)
                    if dd <= 1 <= DD:
                        shadow = True
            if inside and shadow:
                fails.add("both")
                first.setdefault("both", (x, y))
            if not inside and not shadow:
                fails.add("neither")
                first.setdefault("neither", (x, y))
    log(f"[{name}] grid points {npts}; failures: {sorted(fails) or 'none'}; first: {first}")
    return fails


def main():
    ok = True

    def expect(name, got, want):
        nonlocal ok
        verdict = "PASS" if got == want else "FAIL"
        if got != want:
            ok = False
        log(f"   -> {name}: expected {sorted(want) or 'none'}, got {sorted(got) or 'none'}: {verdict}")

    log("FS111-M2 exact checks: DISC7 and SQ9 as maximal covers (tools/fs111_m2_covers.py)")
    log("")
    c7 = lambda m, n: (m + 3 * n) % 7
    expect("DISC7 (faithful)", check_disc("DISC7", c7, 7, Fr(1, 2)), set())
    expect("plant disc-r11/20", check_disc("disc-r11/20", c7, 7, Fr(11, 20)), {"both"})
    c13 = lambda m, n: (m + 4 * n) % 13
    expect("plant disc-idx13", check_disc("disc-idx13", c13, 13, Fr(1, 2), box=(-8, 30, -6, 24)), {"neither"})
    expect("plant disc-drop6", check_disc("disc-drop6", c7, 7, Fr(1, 2), cover_colours=[0, 1, 2, 3, 4, 5]), {"cover"})
    log("")
    expect("SQ9 class (0,0) (faithful)", check_sq("SQ9", Fr(1, 2), Fr(3, 2)), set())
    expect("plant sq-period2", check_sq("sq-period2", Fr(1, 2), Fr(2)), {"neither"})
    expect("plant sq-side3/4", check_sq("sq-side3/4", Fr(3, 4), Fr(3, 2)), {"both"})
    log("")
    log("ALL PASS" if ok else "SOME CHECK FAILED")
    with open(OUT, "w") as fh:
        fh.write("\n".join(lines) + "\n")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
