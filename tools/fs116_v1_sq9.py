#!/usr/bin/env python3
"""FS116-V1: the square nine-colouring of side 1/2 (FS111-W-SQ9), exact, as SATPIN's model at k = 9, and the spurious-edge monster.

Squares S(i, j) = [i/2, (i+1)/2] x [j/2, (j+1)/2], colour (i mod 3, j mod 3). Everything in exact rationals.
Checks, in a window of squares about p = (1/2, 1/2):
  V  validity: distinct same-colour closed squares are at distance >= 1 (so interior points of one colour are never at
     distance exactly 1; a square's own diameter is sqrt(2)/2 < 1).
  S  saturation of every essential boundary point of B(p, 1) sampled on a rational grid: at an edge point x (sides a, b,
     nu pointing to b), x + nu lies in cl(colour a) and x - nu in cl(colour b); at a vertex q, each of its four colours is
     carried at one of q +- e1, q +- e2. (A contact at distance exactly 1 from the support, as the definition asks.)
  C  SATPIN's conclusion at p for each of the four edges at p: tangent type (segments; x +- nu(x) as above at sample x and at the
     limit x = p), and every colour of p carried on omega(p).
  M  the monster: a spurious diagonal segment from p into S(0, 0), both sides colour (0, 0); it is not a unit arc, and x + nu(x)
     is not in cl((0,0)) at sample points: an edge of neither type.
Prints one summary line. Plants: --plant-colour (colour (i mod 2, j mod 3)) must fail V; --plant-sign (nu to a's side) must
fail S and C."""
import sys
from fractions import Fraction as Fr
from itertools import product

PLANT_COL = "--plant-colour" in sys.argv
PLANT_SIGN = "--plant-sign" in sys.argv
H = Fr(1, 2)


def colour(i, j):
    return (i % 2 if PLANT_COL else i % 3, j % 3)


def squares_at(z):
    """indices (i, j) of the closed squares containing the point z"""
    x, y = z
    out = []
    for i in {int((2 * x).__floor__()), int((2 * x).__floor__()) - 1}:
        for j in {int((2 * y).__floor__()), int((2 * y).__floor__()) - 1}:
            if Fr(i, 2) <= x <= Fr(i + 1, 2) and Fr(j, 2) <= y <= Fr(j + 1, 2):
                out.append((i, j))
    return out


def carries(z, c):
    return any(colour(*s) == c for s in squares_at(z))


def sqdist2(s, t):
    (i, j), (k, l) = s, t
    dx = max(0, abs(i - k) - 1) * H
    dy = max(0, abs(j - l) - 1) * H
    return dx * dx + dy * dy


def main():
    W = range(-6, 8)
    sq = [(i, j) for i in W for j in W]
    # V
    bad_v = sum(1 for s in sq for t in sq if s < t and colour(*s) == colour(*t) and sqdist2(s, t) < 1)
    # S: edge points and vertices within B(p, 1), p = (1/2, 1/2)
    p = (H, H)
    bad_s = checked_s = 0
    grid = [Fr(n, 14) for n in range(-7, 22)]
    for x, y in product(grid, grid):
        if (x - p[0]) ** 2 + (y - p[1]) ** 2 > 1:
            continue
        onv, onh = (2 * x).denominator == 1, (2 * y).denominator == 1
        if onv and onh:  # a vertex: four colours
            cols = {colour(*s) for s in squares_at((x, y))}
            pts = [(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)]
            checked_s += 1
            bad_s += any(not any(carries(q, c) for q in pts) for c in cols)
        elif onv or onh:  # an edge point
            if onv:  # vertical edge x = m/2: a = left square, b = right square, nu = +e1
                m = int(2 * x); jj = int((2 * y).__floor__())
                a, b, nu = colour(m - 1, jj), colour(m, jj), (1, 0)
            else:  # horizontal edge y = m/2: a = lower, b = upper, nu = +e2
                m = int(2 * y); ii = int((2 * x).__floor__())
                a, b, nu = colour(ii, m - 1), colour(ii, m), (0, 1)
            if PLANT_SIGN:
                nu = (-nu[0], -nu[1])
            checked_s += 1
            bad_s += not (carries((x + nu[0], y + nu[1]), a) and carries((x - nu[0], y - nu[1]), b))
    # C: the four edges at p; directions d, the tile on the clockwise side is a
    bad_c = 0
    for d in [(1, 0), (0, 1), (-1, 0), (0, -1)]:
        cw = (d[1], -d[0])  # clockwise normal of the ray p + t d
        ccw = (-cw[0], -cw[1])
        # side tiles: the squares touching the ray just clockwise / counter-clockwise of it
        pt = lambda t, n, e=Fr(1, 100): (p[0] + t * d[0] + e * n[0], p[1] + t * d[1] + e * n[1])
        a = colour(*squares_at(pt(Fr(1, 4), cw))[0])
        b = colour(*squares_at(pt(Fr(1, 4), ccw))[0])
        nu = ccw if not PLANT_SIGN else cw
        for t in [Fr(0), Fr(1, 1000), Fr(1, 10), Fr(1, 4), Fr(49, 100)]:
            x = (p[0] + t * d[0], p[1] + t * d[1])
            bad_c += not (carries((x[0] + nu[0], x[1] + nu[1]), a) and carries((x[0] - nu[0], x[1] - nu[1]), b))
    pcols = {colour(*s) for s in squares_at(p)}
    ring = [(p[0] + 1, p[1]), (p[0] - 1, p[1]), (p[0], p[1] + 1), (p[0], p[1] - 1)]
    bad_c += sum(1 for c in pcols if not any(carries(q, c) for q in ring))
    # M: spurious diagonal edge from p toward (0, 0), inside S(0, 0); nu = (1, -1)/sqrt2 is irrational, so test
    # x + nu in cl((0,0)) by interval: S(0,0)'s colour class near x + nu.
    import math
    c0 = colour(0, 0)
    neither = 0
    for t in [0.01, 0.1, 0.2, 0.3]:
        x = (0.5 - t, 0.5 - t)
        for s in (1, -1):
            z = (x[0] + s / math.sqrt(2), x[1] - s / math.sqrt(2))
            i, j = math.floor(2 * z[0]), math.floor(2 * z[1])
            # z is at distance > 1e-6 from every grid line at these t, so it lies in the open square S(i, j)
            assert min(abs(2 * z[0] - round(2 * z[0])), abs(2 * z[1] - round(2 * z[1]))) > 1e-6
            if colour(i, j) != c0:
                neither += 1
                break
    print(f"V: {bad_v} bad of {sum(1 for s in sq for t in sq if s < t and colour(*s) == colour(*t))} same-colour pairs; "
          f"S: {bad_s} bad of {checked_s} boundary points; C: {bad_c} bad; M: spurious edge fails tangent at {neither} of 4 points")


main()
