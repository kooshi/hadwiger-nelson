#!/usr/bin/env python3
"""SEARCH-2026-10-04: the exact checker for an arc three-colouring of the bicycle T1(u) ∪ T1(v), u = (0, 0), v = (d, 0), d rational in (1, 2).

A certificate (JSON) gives d, and for each circle a cyclic list of arc START points (exact sympy expressions, counterclockwise), each with the
colour of the half-open arc [start_k, start_{k+1}); plus exception points (exact) with their own colour.  Every point of the union then has one
colour.  The checker proves, in exact arithmetic, that no two points at distance exactly 1 share a colour:

  check 0  the circles' two intersection points get one colour (an exception, or equal arc colours on both circles);
  check 1  for each circle C, every x on C differs from rot_C(x, 60°): the circle is cut at every start, every exception, every intersection
           point and their images under rot_C(·, −60°); each cut point is checked, and each open cell at one exact interior sample point (both
           colours are constant on a cell);
  check 2  for every y on T1(v), its partners on T1(u) (|x − y| = 1) differ from it: T1(v) is cut at its starts, its exceptions, the
           intersection points, the partners of every start and exception of T1(u), and the two points with |y − u| = 2; each cut point is
           checked, and each open cell at one exact interior sample point (y's colour, the partner count and the partners' colours are constant
           on a cell, since a partner changes colour only at a start or an exception, and the count only at |y − u| = 2).
  These three cover every unit pair of the union (two points of one circle are 1 apart iff 60° apart; a cross pair is a partner pair).

Signs: rigorous interval arithmetic (mpmath.iv, outward rounding) on the exact expression; an interval containing 0 is settled only by an exact
zero test (sympy minimal_polynomial == X), otherwise the checker raises UNDECIDED.  Exit 0 = ACCEPT, 1 = REJECT (a monochromatic unit pair,
printed), 2 = UNDECIDED or malformed.

Usage:  search_20261004_check.py CERT.json
        search_20261004_check.py make-fs107 OUT.json [shift|noexception] [A B C]   # FS107-2 tangent colouring, d = 2A/C, A²+B²=C² (default 15 8 17)
        search_20261004_check.py make-ts1 OUT.json D [flipcell]               # TS1 at phi = 0 and rational d (record § 3)
"""
import json
import math
import sys
from fractions import Fraction

import sympy as sp
from mpmath import iv, mp

iv.dps = 60
mp.dps = 60
XSYM = sp.Symbol("X")
S3 = sp.sqrt(3)
C6 = [sp.Integer(1), sp.Rational(1, 2), sp.Rational(-1, 2), sp.Integer(-1), sp.Rational(-1, 2), sp.Rational(1, 2)]
S6 = [sp.Integer(0), S3 / 2, S3 / 2, sp.Integer(0), -S3 / 2, -S3 / 2]


class Undecided(Exception):
    pass


def to_iv(e):
    if e.is_Integer:
        return iv.mpf(int(e))
    if e.is_Rational:
        return iv.mpf(int(e.p)) / iv.mpf(int(e.q))
    if e.is_Add:
        r = iv.mpf(0)
        for a in e.args:
            r = r + to_iv(a)
        return r
    if e.is_Mul:
        r = iv.mpf(1)
        for a in e.args:
            r = r * to_iv(a)
        return r
    if e.is_Pow:
        b, x = e.args
        if x == sp.Rational(1, 2):
            return iv.sqrt(to_iv(b))
        if x == sp.Rational(-1, 2):
            return 1 / iv.sqrt(to_iv(b))
        if x.is_Integer:
            n = int(x)
            bb = to_iv(b)
            return bb ** n if n >= 0 else 1 / (bb ** (-n))
        if x.is_Rational and x.q == 2:
            return iv.sqrt(to_iv(b)) ** int(x.p)
    raise Undecided(f"cannot evaluate {e!r} in interval arithmetic")


ZERO_TESTS = [0]


def sign(e):
    e = sp.sympify(e)
    if e == 0:
        return 0
    I = to_iv(e)
    if I.a > 0:
        return 1
    if I.b < 0:
        return -1
    ZERO_TESTS[0] += 1
    mpoly = sp.minimal_polynomial(e, XSYM)
    if sp.expand(mpoly - XSYM) == 0:
        return 0
    raise Undecided(f"interval {I} contains 0 and the minimal polynomial is {mpoly}")


def num(e):
    return mp.mpf(to_iv(sp.sympify(e)).mid)


def same(p, q):
    return sign(p[0] - q[0]) == 0 and sign(p[1] - q[1]) == 0


def cross(a, b):
    return a[0] * b[1] - a[1] * b[0]


def sub(a, b):
    return (a[0] - b[0], a[1] - b[1])


def rot(c, x, k):
    """rotate x about c by 60k degrees (exact)."""
    k %= 6
    dx, dy = x[0] - c[0], x[1] - c[1]
    return (sp.nsimplify(c[0] + C6[k] * dx - S6[k] * dy) if False else c[0] + C6[k] * dx - S6[k] * dy,
            c[1] + S6[k] * dx + C6[k] * dy)


def ang(c, x):
    """numeric angle in [0, 2π) for sorting only; every decision is made by sign()."""
    a = mp.atan2(num(x[1] - c[1]), num(x[0] - c[0]))
    return a if a >= 0 else a + 2 * mp.pi


class Circle:
    def __init__(self, name, centre, starts, exceptions):
        self.name, self.c = name, centre
        self.starts = starts             # [(point, colour)] counterclockwise
        self.exc = exceptions            # [(point, colour)] for points of this circle
        self.sang = [ang(centre, p) for p, _ in starts]
        for i in range(len(starts)):
            nxt = (i + 1) % len(starts)
            gap = (self.sang[nxt] - self.sang[i]) % (2 * mp.pi)
            if not (0 < gap < mp.pi * 0.99):
                raise Undecided(f"circle {name}: starts not counterclockwise with arcs < 180 degrees at {i}")

    def arc_colour(self, x):
        a = ang(self.c, x)
        n = len(self.starts)
        # candidate arc by angle, then decided exactly
        k = max((i for i in range(n) if self.sang[i] <= a), default=None, key=lambda i: self.sang[i])
        if k is None:
            k = max(range(n), key=lambda i: self.sang[i])
        for kk in (k, (k - 1) % n, (k + 1) % n):
            s0, s1 = self.starts[kk][0], self.starts[(kk + 1) % n][0]
            if same(x, s0):
                return self.starts[kk][1]
            if sign(cross(sub(s0, self.c), sub(x, self.c))) > 0 and sign(cross(sub(x, self.c), sub(s1, self.c))) > 0 and not same(x, s1):
                return self.starts[kk][1]
        raise Undecided(f"circle {self.name}: no arc found for a point at angle {float(a)}")


def colour(x, circ, allexc):
    for p, col in allexc:
        if abs(num(p[0] - x[0])) < 1e-30 and abs(num(p[1] - x[1])) < 1e-30 and same(p, x):
            return col
    return circ.arc_colour(x)


def partners(y, c):
    """points of the unit circle about c at distance exactly 1 from y (exact)."""
    D2 = (y[0] - c[0]) ** 2 + (y[1] - c[1]) ** 2
    s = sign(D2 - 4)
    if s > 0:
        return []
    m = ((y[0] + c[0]) / 2, (y[1] + c[1]) / 2)
    if s == 0:
        return [m]
    h = sp.sqrt(sp.Integer(1) / D2 - sp.Rational(1, 4))
    px, py = -(y[1] - c[1]), (y[0] - c[0])
    return [(m[0] + h * px, m[1] + h * py), (m[0] - h * px, m[1] - h * py)]


def sorted_unique(c, pts):
    """sort points of one circle by angle and merge exact duplicates; near-duplicates that are not equal raise."""
    tagged = sorted(((ang(c, p), p) for p in pts), key=lambda t: t[0])
    out = []
    for a, p in tagged:
        if out and abs(a - out[-1][0]) < mp.mpf(10) ** -30:
            if same(p, out[-1][1]):
                continue
            raise Undecided("two cut points within 1e-30 rad that are not equal")
        out.append((a, p))
    if len(out) > 1 and abs(out[0][0] + 2 * mp.pi - out[-1][0]) < mp.mpf(10) ** -30:
        if same(out[0][1], out[-1][1]):
            out.pop()
        else:
            raise Undecided("wrap-around near-duplicate")
    return out


def sample_between(c, a0, p0, a1, p1):
    """an exact rational point of the circle strictly between p0 and p1 (counterclockwise, arc < 180°)."""
    if a1 <= a0:
        a1 += 2 * mp.pi
    mid = (a0 + a1) / 2
    flip = abs(math.cos(float(mid) / 2)) < 0.2       # near angle π use the opposite chart
    base = mid - mp.pi if flip else mid
    for den in (10 ** 6, 10 ** 9, 10 ** 15, 10 ** 25):
        t = Fraction(str(mp.tan(base / 2))).limit_denominator(den)
        t = sp.Rational(t.numerator, t.denominator)
        cx, sy = (1 - t * t) / (1 + t * t), 2 * t / (1 + t * t)
        if flip:
            cx, sy = -cx, -sy
        s = (c[0] + cx, c[1] + sy)
        if sign(cross(sub(p0, c), sub(s, c))) > 0 and sign(cross(sub(s, c), sub(p1, c))) > 0:
            return s
    raise Undecided("no rational sample point found in a cell")


def check(cert, verbose=True):
    d = sp.Rational(cert["d"])
    if not (1 < d < 2):
        raise Undecided("d must be in (1, 2)")
    U, V = (sp.Integer(0), sp.Integer(0)), (d, sp.Integer(0))
    P = lambda xy: (sp.sympify(xy[0]), sp.sympify(xy[1]))
    allexc = [(P(e[:2]), int(e[2])) for e in cert["exceptions"]]
    for p, _ in allexc:
        on_u = sign(p[0] ** 2 + p[1] ** 2 - 1) == 0
        on_v = sign((p[0] - d) ** 2 + p[1] ** 2 - 1) == 0
        if not (on_u or on_v):
            raise Undecided("an exception point lies on neither circle")
    cu = Circle("u", U, [(P(s[:2]), int(s[2])) for s in cert["u_starts"]], None)
    cv = Circle("v", V, [(P(s[:2]), int(s[2])) for s in cert["v_starts"]], None)
    for circ in (cu, cv):
        for p, _ in circ.starts:
            if sign((p[0] - circ.c[0]) ** 2 + (p[1] - circ.c[1]) ** 2 - 1) != 0:
                raise Undecided(f"a start of circle {circ.name} is not on it")
    on = lambda circ, p: sign((p[0] - circ.c[0]) ** 2 + (p[1] - circ.c[1]) ** 2 - 1) == 0
    exc_u = [p for p, _ in allexc if on(cu, p)]
    exc_v = [p for p, _ in allexc if on(cv, p)]
    h = sp.sqrt(1 - d * d / 4)
    inter = [(d / 2, h), (d / 2, -h)]
    stats = {"cut_points": 0, "cells": 0, "pairs_checked": 0}
    bad = []

    def report(kind, a, ca, b, cb):
        bad.append((kind, [str(sp.N(a[0], 20)), str(sp.N(a[1], 20))], ca, [str(sp.N(b[0], 20)), str(sp.N(b[1], 20))], cb))

    # check 0
    for p in inter:
        a, b = colour(p, cu, allexc), colour(p, cv, allexc)
        if a != b:
            report("intersection point coloured differently on the two circles", p, a, p, b)
    # check 1
    for circ, excs in ((cu, exc_u), (cv, exc_v)):
        base = [p for p, _ in circ.starts] + excs + inter
        cuts = base + [rot(circ.c, p, -1) for p in base]
        cs = sorted_unique(circ.c, cuts)
        pts = [p for _, p in cs]
        for i in range(len(cs)):
            a0, p0 = cs[i]
            a1, p1 = cs[(i + 1) % len(cs)]
            pts.append(sample_between(circ.c, a0, p0, a1, p1))
            stats["cells"] += 1
        stats["cut_points"] += len(cs)
        for x in pts:
            x2 = rot(circ.c, x, 1)
            c1, c2 = colour(x, circ, allexc), colour(x2, circ, allexc)
            stats["pairs_checked"] += 1
            if c1 == c2:
                report(f"60-degree pair on circle {circ.name}", x, c1, x2, c2)
    # check 2
    cuts = [p for p, _ in cv.starts] + exc_v + inter
    for s in [p for p, _ in cu.starts] + exc_u:
        cuts += partners(s, V)
    cth = (3 - d * d) / (2 * d)
    sth = sp.sqrt(1 - cth * cth)
    cuts += [(d + cth, sth), (d + cth, -sth)]
    cs = sorted_unique(V, cuts)
    pts = [p for _, p in cs]
    for i in range(len(cs)):
        a0, p0 = cs[i]
        a1, p1 = cs[(i + 1) % len(cs)]
        pts.append(sample_between(V, a0, p0, a1, p1))
        stats["cells"] += 1
    stats["cut_points"] += len(cs)
    for y in pts:
        cy = colour(y, cv, allexc)
        for x in partners(y, U):
            cx = colour(x, cu, allexc)
            stats["pairs_checked"] += 1
            if cx == cy:
                report("cross pair", x, cx, y, cy)
    stats["exact_zero_tests"] = ZERO_TESTS[0]
    if verbose:
        print(f"d = {d}; {stats}")
    return bad, stats


def make_fs107(plant=None, a=15, b=8, c=17):
    """FS107-2 at its tangent offsets: d = 2a/c with a² + b² = c² (so p = (a/c, b/c) is rational), phi = gamma + 60°, psi = 180° − gamma
    (mod 120°), cos gamma = a/c, p recoloured 2.  Default a, b, c = 15, 8, 17: d = 30/17."""
    assert a * a + b * b == c * c
    d = sp.Rational(2 * a, c)
    p = (sp.Rational(a, c), sp.Rational(b, c))
    U, V = (sp.Integer(0), sp.Integer(0)), (d, sp.Integer(0))
    if plant == "shift":   # rotate T1(u)'s pattern by 2·atan(1/100) ≈ 1.15°
        t = sp.Rational(1, 100)
        cr, sr = (1 - t * t) / (1 + t * t), 2 * t / (1 + t * t)
        p_u = (cr * p[0] - sr * p[1], sr * p[0] + cr * p[1])
    else:
        p_u = p
    # arc k of T1(u) starts at gamma + 60k; colour 1 iff k odd (record § 2.3)
    u_starts = [(rot(U, p_u, k), 1 if k % 2 == 1 else 2) for k in range(6)]
    # arc k of T1(v) starts at eta_p + 60k (eta_p = 180° − gamma, the point p seen from v); colour 1 iff k even
    v_starts = [(rot(V, p, k), 1 if k % 2 == 0 else 3) for k in range(6)]
    exc = [] if plant in ("noexception", "shift") else [(p, 2)]   # the shift plant drops p's recolouring: p is no longer a boundary
    S = lambda q: [str(sp.simplify(q[0])), str(sp.simplify(q[1]))]
    # order counterclockwise from the smallest angle
    u_starts.sort(key=lambda t: ang(U, t[0]))
    v_starts.sort(key=lambda t: ang(V, t[0]))
    return {"d": str(d), "u_starts": [S(q) + [c] for q, c in u_starts], "v_starts": [S(q) + [c] for q, c in v_starts],
            "exceptions": [S(q) + [c] for q, c in exc],
            "what": "FS107-2 tangent colouring: T1(u) alternating {1,2} with a boundary at p, T1(v) alternating {1,3} with a boundary at p, "
                    f"p = ({a}/{c}, {b}/{c}) coloured 2, d = {d}" + (f"; PLANT {plant}" if plant else "")}


def make_ts1(d, plant=None):
    """TS1 at phi = 0: T1(u) alternating {1, 2} with starts at 60k (colour 1 at even k); T1(v) coloured hexagon by hexagon from its lists
    (FS106-TS's reduction), cut at the folded breakpoints and the intersection points; cut points coloured separately where needed."""
    import itertools
    d = sp.Rational(d)
    U, V = (sp.Integer(0), sp.Integer(0)), (d, sp.Integer(0))
    e1 = (sp.Integer(1), sp.Integer(0))
    u_starts = [(rot(U, e1, k), 1 if k % 2 == 0 else 2) for k in range(6)]
    cu = Circle("u", U, u_starts, None)
    h = sp.sqrt(1 - d * d / 4)
    inter = [(d / 2, h), (d / 2, -h)]
    cuts = list(inter)
    for st, _ in u_starts:
        cuts += partners(st, V)
    cth = (3 - d * d) / (2 * d)
    sth = sp.sqrt(1 - cth * cth)
    cuts += [(d + cth, sth), (d + cth, -sth)]
    folded = [rot(V, q, k) for q in cuts for k in range(6)]
    cs = sorted_unique(V, folded)
    n = len(cs)
    if n % 6:
        raise Undecided(f"folded cut set has {n} points, not a multiple of 6")
    m = n // 6

    def lists_at(y):
        if any(abs(num(y[0] - q[0])) < 1e-30 and abs(num(y[1] - q[1])) < 1e-30 and same(y, q) for q in inter):
            return (colour(y, cu, []),)            # an intersection point keeps its T1(u) colour
        cols = {colour(x, cu, []) for x in partners(y, U)}
        return tuple(c for c in (1, 2, 3) if c not in cols)

    def hex_colouring(lists):
        for col in itertools.product(*lists):
            if all(col[i] != col[(i + 1) % 6] for i in range(6)):
                return col
        return None

    v_starts, exc = [], []
    cell_col, point_col = {}, {}
    for i in range(m):
        idx = [i + m * k for k in range(6)]
        # the cut-point hexagon
        col = hex_colouring([lists_at(cs[j][1]) for j in idx])
        if col is None:
            raise Undecided(f"cut-point hexagon {i} not list-colourable")
        for j, c in zip(idx, col):
            point_col[j] = c
        # the open-cell hexagon (lists constant on the cell: sampled at one exact interior point)
        samples = [sample_between(V, cs[j][0], cs[j][1], cs[(j + 1) % n][0], cs[(j + 1) % n][1]) for j in idx]
        col = hex_colouring([lists_at(y) for y in samples])
        if col is None:
            raise Undecided(f"cell hexagon {i} not list-colourable")
        for j, c in zip(idx, col):
            cell_col[j] = c
    if plant == "flipcell":   # recolour one open cell to break its hexagon
        j0 = max(cell_col, key=lambda j: (cell_col[j] != cell_col[(j + m) % n], -j))
        cell_col[j0] = cell_col[(j0 + m) % n]
    for j in range(n):
        v_starts.append((cs[j][1], cell_col[j]))
        if point_col[j] != cell_col[j]:
            exc.append((cs[j][1], point_col[j]))
    S = lambda q: [str(q[0]), str(q[1])]
    return {"d": str(d), "u_starts": [S(q) + [c] for q, c in u_starts], "v_starts": [S(q) + [c] for q, c in v_starts],
            "exceptions": [S(q) + [c] for q, c in exc],
            "what": f"TS1 at phi = 0, d = {d}: T1(u) alternating {{1,2}} from theta = 0; T1(v) by hexagon list-colouring, {n} arcs, "
                    f"{len(exc)} cut points recoloured" + (f"; PLANT {plant}" if plant else "")}


if __name__ == "__main__":
    try:
        if sys.argv[1] == "make-ts1":
            cert = make_ts1(sys.argv[3], sys.argv[4] if len(sys.argv) > 4 else None)
            json.dump(cert, open(sys.argv[2], "w"), indent=1)
            print("wrote", sys.argv[2], "-", cert["what"])
            sys.exit(0)
        if sys.argv[1] == "make-fs107":
            args = sys.argv[3:]
            plant = args[0] if args and not args[0].isdigit() else None
            abc = [int(x) for x in args if x.isdigit()] or [15, 8, 17]
            cert = make_fs107(plant, *abc)
            json.dump(cert, open(sys.argv[2], "w"), indent=1)
            print("wrote", sys.argv[2])
            sys.exit(0)
        cert = json.load(open(sys.argv[1]))
        bad, stats = check(cert)
    except Undecided as e:
        print("UNDECIDED:", e)
        sys.exit(2)
    if bad:
        print(f"REJECT: {len(bad)} monochromatic unit pair(s); first: {bad[0]}")
        sys.exit(1)
    print("ACCEPT: no monochromatic unit pair in the bicycle under this colouring")
    sys.exit(0)
