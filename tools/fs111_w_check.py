#!/usr/bin/env python3
"""FS111-W — exact checker for periodic colourings of the plane by convex polygon tiles, given by formula.

Job FS111-W (FS-111's competitor W, the wild side).  Every object this job builds is a periodic tiling of the plane by
closed convex polygons (one or more base tiles, translated by a lattice), each tile carrying one colour.  Coordinates
lie in the field Q(sqrt 3) and every comparison is exact (class ``Q3``): no float enters any verdict.

What is checked (``data/fs111/claims.md`` §0 names; D-NF classes are the open tiles of one colour):

  P  (a.e.-proper)  no two interior points of one colour are at distance exactly 1.  For two closed convex tiles the set
     of distances between their interiors is the open interval (dist, maxdist) (``dist`` = 0 if they touch); for one
     tile it is (0, diam).  P holds iff no same-coloured pair (and no single tile) has dist < 1 < maxdist.
  T  (tight)        some same-coloured pair has dist = 1 < maxdist, or maxdist = 1 > dist (or a tile has diam = 1): then
     for every eps > 0 a positive measure of monochromatic pairs lies in [1 - eps, 1 + eps] (D-SLACK: slack for no eps).
  S  (saturated)    no essential boundary point is free for any colour of its essential multicolour (C-SAT-T's
     conclusion).  For these tilings a boundary point x of a tile t of colour c (not interior to the union of
     c-tiles) is c-free iff the unit circle about x misses the closure of the c-tiles, i.e. every c-tile u has
     dist(x, u) > 1 or maxdist(x, u) < 1.  S is certified by a sufficient test, exact: every edge of every tile is
     covered by the projections of same-coloured tiles' edges that are parallel to it, face it from outside, at
     distance exactly 1 (then dist(x, u) = 1 at every covered x); and every vertex has a contact pointwise.
  F  (a free point) the negation of S at one named point, strict: every same-coloured tile u has dist(x, u) > 1 or
     maxdist(x, u) < 1.
  J  junction data: the multicolour of every vertex of the base tiles (the colours of the tiles containing it).

Controls (by formula; ``CLAUDE.md`` G20, row 33; ``data/fs111/claims.md`` §5):
  hex7    regular hexagons of circumradius 1/2 (diameter exactly 1), centres m u + n v, u = (sqrt3/2, 0),
          v = (sqrt3/4, 3/4), colour (m + 3n) mod 7.  Expected: P, T, not S (F at an edge midpoint).
  brick7  half-open 4/5 x 3/5 bricks, row j shifted 2/5 j, colour (i + 3j) mod 7 (``Proofs/HadwigerNelson/Instances/
          Seven.lean``, ``sevenBrick``).  Closed cells here.  Expected: P, T, not S.
  sq9     squares of side 1/2, colour (i mod 3, j mod 3).  Expected: P, T, S -- a saturated colouring (FS111-W-SQ9).

Planted faults (``--plant NAME``); each must fail at exactly the named set of assertions, for its own reason (the
failure message names the tile pair or edge):
  hexbig    hex7 at circumradius 11/20 (diameter 11/10)                 -> {P (own diameter), T (no exact 1), S}
  hexcol    hex7 coloured (m + 2n) mod 7 (not an ideal; a short vector) -> {P (a same-coloured pair), S}
  sq16      squares of side 1/2 coloured (i mod 4, j mod 4)             -> {T (gap 3/2: slack), S}
  sq9shear  sq9 with row j shifted by j/4                               -> {S} only (horizontal edges uncovered)
  sq9j2     squares of side 1/2 coloured (i mod 3, j mod 2)             -> {P (rows two apart), S}
  sq9free   the free-point test run on sq9's edge midpoint              -> {F} (sq9's midpoint has contacts)

Usage:  fs111_w_check.py [--object NAME] [--plant NAME]      exit 0 iff every expectation holds
        fs111_w_check.py --self-test                          controls, plants and stubs; exit 0 iff all behave

Grade of what it computes: [tools], exact.  It certifies objects given by formula; families are derivations (G21).
"""

from __future__ import annotations

import argparse
import itertools
import sys
from fractions import Fraction as Fr


# ----------------------------------------------------------------------------------------------------------------
# The field Q(sqrt 3), exact.
# ----------------------------------------------------------------------------------------------------------------

class Q3:
    """a + b*sqrt(3) with rational a, b.  Exact arithmetic and exact sign."""

    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a = Fr(a)
        self.b = Fr(b)

    @staticmethod
    def of(x) -> "Q3":
        return x if isinstance(x, Q3) else Q3(x, 0)

    def __add__(self, o):
        o = Q3.of(o)
        return Q3(self.a + o.a, self.b + o.b)

    __radd__ = __add__

    def __neg__(self):
        return Q3(-self.a, -self.b)

    def __sub__(self, o):
        return self + (-Q3.of(o))

    def __rsub__(self, o):
        return Q3.of(o) - self

    def __mul__(self, o):
        o = Q3.of(o)
        return Q3(self.a * o.a + 3 * self.b * o.b, self.a * o.b + self.b * o.a)

    __rmul__ = __mul__

    def inv(self) -> "Q3":
        n = self.a * self.a - 3 * self.b * self.b
        if n == 0:
            raise ZeroDivisionError("Q3 zero")
        return Q3(self.a / n, -self.b / n)

    def __truediv__(self, o):
        return self * Q3.of(o).inv()

    def sign(self) -> int:
        a, b = self.a, self.b
        sa = (a > 0) - (a < 0)
        sb = (b > 0) - (b < 0)
        if sb == 0:
            return sa
        if sa == 0:
            return sb
        if sa == sb:
            return sa
        # opposite signs: compare a^2 with 3 b^2
        d = a * a - 3 * b * b
        sd = (d > 0) - (d < 0)
        return sa * sd

    def __eq__(self, o):
        return (self - Q3.of(o)).sign() == 0

    def __lt__(self, o):
        return (self - Q3.of(o)).sign() < 0

    def __le__(self, o):
        return (self - Q3.of(o)).sign() <= 0

    def __gt__(self, o):
        return (self - Q3.of(o)).sign() > 0

    def __ge__(self, o):
        return (self - Q3.of(o)).sign() >= 0

    def __hash__(self):
        return hash((self.a, self.b))

    def __float__(self):
        return float(self.a) + float(self.b) * 3 ** 0.5

    def __repr__(self):
        if self.b == 0:
            return f"{self.a}"
        return f"({self.a} + {self.b}*r3)"


R3 = Q3(0, 1)


def pt(x, y):
    return (Q3.of(x), Q3.of(y))


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def scale(p, k):
    return (p[0] * k, p[1] * k)


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def cross(p, q):
    return p[0] * q[1] - p[1] * q[0]


def d2(p, q):
    v = sub(p, q)
    return dot(v, v)


def seg_d2(p, a, b):
    """Squared distance from point p to the closed segment [a, b], exact."""
    ab = sub(b, a)
    L = dot(ab, ab)
    t = dot(sub(p, a), ab) / L
    if t <= 0:
        return d2(p, a)
    if t >= 1:
        return d2(p, b)
    foot = add(a, scale(ab, t))
    return d2(p, foot)


def point_in_convex(p, poly) -> bool:
    """Closed convex polygon (CCW): p inside or on boundary."""
    n = len(poly)
    for i in range(n):
        if cross(sub(poly[(i + 1) % n], poly[i]), sub(p, poly[i])) < 0:
            return False
    return True


def point_poly_d2(p, poly):
    if point_in_convex(p, poly):
        return Q3(0)
    n = len(poly)
    return min((seg_d2(p, poly[i], poly[(i + 1) % n]) for i in range(n)), key=float_key)


def float_key(x: Q3):
    # used only to pick candidates for min/max; every candidate is then compared exactly below
    return float(x)


def exact_min(xs):
    xs = list(xs)
    m = xs[0]
    for x in xs[1:]:
        if x < m:
            m = x
    return m


def exact_max(xs):
    xs = list(xs)
    m = xs[0]
    for x in xs[1:]:
        if x > m:
            m = x
    return m


def poly_dist2(P, Q):
    """Squared distance between closed convex polygons (0 if they meet)."""
    for p in P:
        if point_in_convex(p, Q):
            return Q3(0)
    for q in Q:
        if point_in_convex(q, P):
            return Q3(0)
    cands = []
    for p in P:
        for i in range(len(Q)):
            cands.append(seg_d2(p, Q[i], Q[(i + 1) % len(Q)]))
    for q in Q:
        for i in range(len(P)):
            cands.append(seg_d2(q, P[i], P[(i + 1) % len(P)]))
    # disjoint convex polygons: the distance is attained between a vertex and an edge (possibly crossing edges give 0,
    # handled by an edge-intersection test)
    for i in range(len(P)):
        for j in range(len(Q)):
            if segs_cross(P[i], P[(i + 1) % len(P)], Q[j], Q[(j + 1) % len(Q)]):
                return Q3(0)
    return exact_min(cands)


def segs_cross(a, b, c, d) -> bool:
    d1 = cross(sub(b, a), sub(c, a)).sign()
    d2_ = cross(sub(b, a), sub(d, a)).sign()
    d3 = cross(sub(d, c), sub(a, c)).sign()
    d4 = cross(sub(d, c), sub(b, c)).sign()
    return d1 * d2_ < 0 and d3 * d4 < 0


def poly_maxdist2(P, Q):
    return exact_max(d2(p, q) for p in P for q in Q)


def point_maxdist2(x, Q):
    return exact_max(d2(x, q) for q in Q)


# ----------------------------------------------------------------------------------------------------------------
# Periodic tilings.
# ----------------------------------------------------------------------------------------------------------------

class Tiling:
    """base_tiles: list of (name, polygon, colour_fn) where colour_fn(m, n) gives the colour of the translate by
    m*L1 + n*L2.  Translates are enumerated over |m|, |n| <= reach."""

    def __init__(self, name, base, L1, L2, reach):
        self.name = name
        self.base = base
        self.L1 = L1
        self.L2 = L2
        self.reach = reach

    def translate(self, poly, m, n):
        off = add(scale(self.L1, Q3(m)), scale(self.L2, Q3(n)))
        return [add(p, off) for p in poly]

    def tiles_near(self):
        out = []
        for (bname, poly, col) in self.base:
            for m in range(-self.reach, self.reach + 1):
                for n in range(-self.reach, self.reach + 1):
                    out.append(((bname, m, n), self.translate(poly, m, n), col(m, n)))
        return out

    def base_tiles(self):
        return [((bname, 0, 0), poly, col(0, 0)) for (bname, poly, col) in self.base]


def check_P(T: Tiling):
    """a.e.-proper: for each base tile t and each same-coloured tile u near it: not (dist < 1 < maxdist)."""
    fails = []
    near = T.tiles_near()
    for (tid, tp, tc) in T.base_tiles():
        for (uid, up, uc) in near:
            if uc != tc:
                continue
            if uid == tid:
                dm = poly_maxdist2(tp, tp)
                if dm > 1:
                    fails.append(f"P: tile {tid} colour {tc} has diameter^2 {dm} > 1")
                continue
            dmin = poly_dist2(tp, up)
            dmax = poly_maxdist2(tp, up)
            if dmin < 1 and dmax > 1:
                fails.append(f"P: tiles {tid} and {uid} (colour {tc}) have dist^2 {dmin} < 1 < maxdist^2 {dmax}")
    return fails


def check_T(T: Tiling):
    """tight: some same-coloured pair (or one tile) with an interior-distance interval ending exactly at 1."""
    near = T.tiles_near()
    for (tid, tp, tc) in T.base_tiles():
        for (uid, up, uc) in near:
            if uc != tc:
                continue
            if uid == tid:
                if poly_maxdist2(tp, tp) == 1:
                    return None, f"tile {tid} has diameter exactly 1"
                continue
            dmin = poly_dist2(tp, up)
            dmax = poly_maxdist2(tp, up)
            if dmin == 1 and dmax > 1:
                return None, f"tiles {tid}, {uid} (colour {tc}) at distance exactly 1"
            if dmax == 1 and dmin < 1:
                return None, f"tiles {tid}, {uid} (colour {tc}) with maxdist exactly 1"
    return "T: no same-coloured pair has an interval ending at 1 (the colouring has slack)", None


def edges(poly):
    return [(poly[i], poly[(i + 1) % len(poly)]) for i in range(len(poly))]


def check_S(T: Tiling):
    """saturated (sufficient test): every edge of every base tile covered by same-coloured facing edges at distance 1
    on the outer side; every vertex has a contact pointwise.  Assumes same-coloured tiles do not touch (then every
    boundary point of a tile is an essential boundary point of its colour); asserted."""
    fails = []
    near = T.tiles_near()
    for (tid, tp, tc) in T.base_tiles():
        same = [(uid, up) for (uid, up, uc) in near if uc == tc and uid != tid]
        for (uid, up) in same:
            if poly_dist2(tp, up) == 0:
                fails.append(f"S-precondition: same-coloured tiles {tid}, {uid} touch")
        for (a, b) in edges(tp):
            ab = sub(b, a)
            L2 = dot(ab, ab)
            # outward normal direction (CCW polygon): rotate ab by -90 degrees
            nrm = (ab[1], -ab[0])
            covered = []
            for (uid, up) in same:
                for (c, d) in edges(up):
                    cd = sub(d, c)
                    if cross(ab, cd).sign() != 0:
                        continue  # not parallel
                    if dot(ab, cd).sign() >= 0:
                        continue  # a facing edge of a CCW polygon runs the opposite way
                    # signed offset of line cd from line ab along the outward normal, squared-normalised
                    off = dot(sub(c, a), nrm)  # = |nrm| * signed distance
                    if off.sign() <= 0:
                        continue  # not on the outer side
                    # distance exactly 1:  off^2 = |nrm|^2 = L2
                    if not (off * off == L2):
                        continue
                    # projection parameters of c, d onto ab (0..1 along ab)
                    tc_ = dot(sub(c, a), ab) / L2
                    td_ = dot(sub(d, a), ab) / L2
                    lo, hi = (tc_, td_) if tc_ <= td_ else (td_, tc_)
                    covered.append((lo, hi))
            # union of covered intervals must contain [0, 1]
            covered.sort(key=lambda iv: float(iv[0]))
            reach = Q3(0)
            ok = False
            for (lo, hi) in covered:
                if lo > reach:
                    break
                if hi > reach:
                    reach = hi
                if reach >= 1:
                    ok = True
                    break
            if not ok:
                fails.append(f"S: edge {a}->{b} of tile {tid} (colour {tc}) not covered by facing edges at distance 1"
                             f" (covered up to parameter {reach})")
        for v in tp:
            if not any(point_poly_d2(v, up) <= 1 and point_maxdist2(v, up) >= 1 for (uid, up) in same):
                fails.append(f"S: vertex {v} of tile {tid} (colour {tc}) has no contact")
    return fails


def check_F(T: Tiling, x, colour):
    """x is colour-free: every tile of that colour has dist(x, u) > 1 or maxdist(x, u) < 1, strictly."""
    near = T.tiles_near()
    for (uid, up, uc) in near:
        if uc != colour:
            continue
        dm = point_poly_d2(x, up)
        dM = point_maxdist2(x, up)
        if not (dm > 1 or dM < 1):
            return f"F: point {x} has a colour-{colour} contact in tile {uid} (dist^2 {dm}, maxdist^2 {dM})"
    return None


def vertex_types(T: Tiling):
    near = T.tiles_near()
    out = {}
    for (tid, tp, tc) in T.base_tiles():
        for v in tp:
            cols = sorted({uc for (uid, up, uc) in near if point_in_convex(v, up)}, key=str)
            out[(tid, v)] = cols
    return out


# ----------------------------------------------------------------------------------------------------------------
# The objects, by formula.
# ----------------------------------------------------------------------------------------------------------------

def hex7(a=Fr(1, 2), coeff=3):
    a = Q3(a)
    # pointy-top hexagon: vertices at angles 30 + 60k, circumradius a
    verts = [pt(0, 0)] * 0
    half = a * Fr(1, 2)
    rt = R3 * a * Fr(1, 2)  # a*sqrt3/2
    poly = [(rt, half), (Q3(0), a), (-rt, half), (-rt, -half), (Q3(0), -a), (rt, -half)]
    L1 = (R3 * a, Q3(0))                    # sqrt3 a along x
    L2 = (R3 * a * Fr(1, 2), a * Fr(3, 2))  # sqrt3 a/2, 3a/2
    return Tiling(f"hex7(a={a}, colour (m+{coeff}n) mod 7)", [("H", poly, lambda m, n: (m + coeff * n) % 7)],
                  L1, L2, reach=6)


def brick7(w=Fr(4, 5), h=Fr(3, 5), s=Fr(2, 5), coeff=3):
    poly = [pt(0, 0), pt(w, 0), pt(w, h), pt(0, h)]
    L1 = pt(w, 0)
    L2 = pt(s, h)
    return Tiling(f"brick7(w={w}, h={h}, shear={s}, colour (i+{coeff}j) mod 7)",
                  [("B", poly, lambda m, n: (m + coeff * n) % 7)], L1, L2, reach=6)


def sqN(side=Fr(1, 2), N=3, shift=None):
    poly = [pt(0, 0), pt(side, 0), pt(side, side), pt(0, side)]
    L1 = pt(side, 0)
    L2 = pt(0, side)

    def col(m, n):
        return (m % N, n % N)

    return Tiling(f"sq(side={side}, colour (i mod {N}, j mod {N}))", [("S", poly, col)], L1, L2, reach=2 * N + 2)


def sq9_sheared():
    """sq9 with row j shifted by j/4 (a mis-specified formula): still a.e.-proper and tight, but horizontal edges face
    no same-coloured edge at distance 1 -- the saturation test must fail and nothing else."""
    side = Fr(1, 2)
    poly = [pt(0, 0), pt(side, 0), pt(side, side), pt(0, side)]
    return Tiling("sq9 with rows sheared by 1/4", [("S", poly, lambda m, n: (m % 3, n % 3))],
                  pt(side, 0), pt(Fr(1, 4), side), reach=8)


def sq9_j2():
    """squares of side 1/2 coloured (i mod 3, j mod 2): same-coloured squares two rows apart are 1/2 apart with
    maxdist > 1 -- a.e.-properness must fail (and saturation, whose horizontal edges face gap 1/2 or 3/2)."""
    side = Fr(1, 2)
    poly = [pt(0, 0), pt(side, 0), pt(side, side), pt(0, side)]
    return Tiling("sq(side=1/2, colour (i mod 3, j mod 2))", [("S", poly, lambda m, n: (m % 3, n % 2))],
                  pt(side, 0), pt(0, side), reach=8)


# expectations: which of P, T, S hold; F = "edgemid" means the first edge's midpoint must be free for both colours
OBJECTS = {
    "hex7": (lambda: hex7(), dict(P=True, T=True, S=False, F="edgemid")),
    "brick7": (lambda: brick7(), dict(P=True, T=True, S=False, F=pt(Fr(1, 5), 0))),
    "sq9": (lambda: sqN(Fr(1, 2), 3), dict(P=True, T=True, S=True, F=None)),
}

# plants: (builder, the exact set of assertions that must fail, F spec)
PLANTS = {
    "hexbig": (lambda: hex7(a=Fr(11, 20)), {"P", "T", "S"}, None),
    "hexcol": (lambda: hex7(coeff=2), {"P", "S"}, None),
    "sq16": (lambda: sqN(Fr(1, 2), 4), {"T", "S"}, None),
    "sq9shear": (lambda: sq9_sheared(), {"S"}, None),
    "sq9j2": (lambda: sq9_j2(), {"P", "S"}, None),
    "sq9free": (lambda: sqN(Fr(1, 2), 3), {"F"}, "edgemid"),
}


def edge_midpoint_free(T: Tiling, x=None):
    """The named point x (default: the midpoint of the base tile's first edge) must be free for every colour of the
    tiles containing it; returns (point, colours, fail-or-None).  For brick7 the default midpoint (2/5, 0) is a
    T-vertex of the row below, with a contact (its cell's far corner at distance exactly 1): the brick's free point is
    (1/5, 0), interior to the edge between cells (0, 0) and (0, -1)."""
    (tid, tp, tc) = T.base_tiles()[0]
    if x is None:
        a, b = tp[0], tp[1]
        x = scale(add(a, b), Fr(1, 2))
    near = T.tiles_near()
    across = sorted({uc for (uid, up, uc) in near if uid != tid and point_in_convex(x, up)} - {tc}, key=str)
    msgs = []
    for c in [tc] + across:
        f = check_F(T, x, c)
        if f:
            msgs.append(f)
    return x, [tc] + across, (msgs or None)


def run(T: Tiling, F=None, verbose=True):
    """Evaluates P, T, S (and F at the edge midpoint if F == "edgemid"); returns the set of assertions that FAIL."""
    failed = set()
    out = []
    pf = check_P(T)
    out.append(f"  P (a.e.-proper): {'HOLDS' if not pf else 'FAILS: ' + pf[0] + f'  [{len(pf)} failures]'}")
    tf, twit = check_T(T)
    out.append(f"  T (tight): {'HOLDS: ' + twit if tf is None else 'FAILS: ' + tf}")
    sf = check_S(T)
    out.append(f"  S (saturated, sufficient test): {'HOLDS' if not sf else 'FAILS: ' + sf[0] + f'  [{len(sf)} failures]'}")
    if pf:
        failed.add("P")
    if tf is not None:
        failed.add("T")
    if sf:
        failed.add("S")
    if F is not None:
        x, cols, msgs = edge_midpoint_free(T, None if F == "edgemid" else F)
        out.append(f"  F (free point): edge midpoint {x}, colours {cols}: "
                   f"{'FREE for every colour there' if msgs is None else 'NOT FREE: ' + msgs[0]}")
        if msgs is not None:
            failed.add("F")
    vt = vertex_types(T)
    out.append("  J (vertex multicolours of the base tiles): " + "; ".join(f"{v}: {c}" for (_, v), c in vt.items()))
    if verbose:
        print("\n".join(out))
    return failed


def expected_failures(expect: dict):
    s = {k for k in ("P", "T", "S") if expect.get(k) is False}
    return s


def self_test():
    ok = True
    for name, (mk, expect) in OBJECTS.items():
        T = mk()
        print(f"### control {name}: {T.name}")
        f = run(T, F=expect.get("F"))
        want = expected_failures(expect)
        good = f == want
        print(f"  => fails {sorted(f)}, expected {sorted(want)}: {'AS EXPECTED' if good else 'UNEXPECTED'}")
        ok &= good
    for name, (mk, want, Fspec) in PLANTS.items():
        T = mk()
        print(f"### plant {name}: {T.name} (must fail exactly {sorted(want)})")
        f = run(T, F=Fspec)
        good = f == want
        print(f"  => fails {sorted(f)}: {'FIRES FOR ITS OWN REASON' if good else 'PLANT MISBEHAVES'}")
        ok &= good
    print("SELF-TEST", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--object", choices=sorted(OBJECTS))
    ap.add_argument("--plant", choices=sorted(PLANTS))
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        return self_test()
    if args.plant:
        mk, want, Fspec = PLANTS[args.plant]
        T = mk()
        print(f"### plant {args.plant}: {T.name}")
        f = run(T, F=Fspec)
        print(f"  fails {sorted(f)} (must fail exactly {sorted(want)})")
        return 1 if f else 0
    names = [args.object] if args.object else sorted(OBJECTS)
    bad = False
    for name in names:
        mk, expect = OBJECTS[name]
        T = mk()
        print(f"### {name}: {T.name}")
        f = run(T, F=expect.get("F"))
        want = expected_failures(expect)
        print(f"  => fails {sorted(f)}, expected {sorted(want)}: {'AS EXPECTED' if f == want else 'UNEXPECTED'}")
        bad |= f != want
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
