#!/usr/bin/env python3
"""FS111-VMW exact geometry engine: tilings by closed tiles bounded by unit arcs and segments, coordinates in Q(sqrt 3).

Written by job FS111-VMW (blind verifier of FS-111 round 1), 2026-09-28.  No floats decide anything here: every verdict is a
sign of an element of Q(sqrt 3), or of sqrt(q) + k with q in Q(sqrt 3) and k an integer, decided by squaring.

What it decides, for colourings given by formula (a list of closed tiles with colours):
  * pair_range(T, T')  -- whether 1 lies in the open interval (dmin, dmax) of distances between the closed tiles, and
                           whether dmin == 1 or dmax == 1 (a tight contact).  For two connected closed tiles with
                           nonempty interiors, the distances between interior points fill (dmin, dmax) (the product of the
                           interiors is connected and |x - y| is an open map off the diagonal), so "no two interior points of
                           T, T' at distance exactly 1" <=> 1 not in (dmin, dmax).  Within one tile: <=> dmax <= 1.
  * point_contact(x, T) -- whether some point y of the closed tile T has |x - y| = 1, i.e. dmin(x,T) <= 1 <= dmax(x,T).
                           For x in a tiling, "x is j-free" (data/fs111/claims.md, section 0) <=> no closed tile of colour j
                           has a point at distance exactly 1 from x (the closure of the open colour-j tiles is the union of
                           the closed colour-j tiles; supp is closed, S(x,1) compact).
  * certificates        -- a whole boundary piece is non-free for colour j when (a) it is an arc centred at a point c lying
                           in a closed colour-j tile (then every point of the arc is at distance exactly 1 from c), or (b) it
                           is a segment [p, q] whose unit translate [p + v, q + v] lies in a closed convex colour-j tile.

Candidate sets (the extrema of |x - y| over two pieces are among these; standard critical-point analysis):
  point-point: the distance.  point-segment: endpoints, the perpendicular foot (min only).
  point-arc: endpoints; the nearest (x - c direction) and farthest (c - x direction) points of the circle when on the arc.
  segment-segment: each endpoint against the other piece.  arc-arc: endpoints against the other piece, and the four
  line-of-centres pairs when on both arcs.  segment-arc: endpoints against the other piece, and the arc points c +- n
  (n the segment's unit normal) with their feet when on both.
Concentric distinct arcs are refused (NotImplementedError: fail loud), since none of the tilings checked has them.
"""
from __future__ import annotations

from fractions import Fraction as Fr
from itertools import product


# ----------------------------------------------------------------------------------------------------------------- Q(sqrt 3)
class Q3:
    """a + b*sqrt(3), a, b rational."""
    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a = Fr(a)
        self.b = Fr(b)

    @staticmethod
    def of(v):
        return v if isinstance(v, Q3) else Q3(v, 0)

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

    def inv(self):
        n = self.a * self.a - 3 * self.b * self.b
        if n == 0:
            raise ZeroDivisionError("Q3 zero")
        return Q3(self.a / n, -self.b / n)

    def __truediv__(self, o):
        return self * Q3.of(o).inv()

    def sign(self):
        a, b = self.a, self.b
        if a >= 0 and b >= 0:
            return 0 if (a == 0 and b == 0) else 1
        if a <= 0 and b <= 0:
            return -1
        # opposite signs: compare a^2 with 3 b^2
        d = a * a - 3 * b * b
        if a > 0:          # a > 0 > b
            return 1 if d > 0 else (-1 if d < 0 else 0)
        return -1 if d > 0 else (1 if d < 0 else 0)   # a < 0 < b

    def __eq__(self, o):
        o = Q3.of(o)
        return self.a == o.a and self.b == o.b

    def __hash__(self):
        return hash((self.a, self.b))

    def __float__(self):
        return float(self.a) + float(self.b) * 3 ** 0.5

    def __repr__(self):
        if self.b == 0:
            return str(self.a)
        return f"({self.a}{'+' if self.b >= 0 else '-'}{abs(self.b)}r3)"

    def sqrt_exact(self):
        """Exact square root in Q(sqrt3) if one exists (non-negative root), else None."""
        if self.sign() < 0:
            return None
        if self.b == 0:
            r = _rat_sqrt(self.a)
            if r is not None:
                return Q3(r, 0)
            r = _rat_sqrt(self.a / 3)
            return Q3(0, r) if r is not None else None
        # (x + y r3)^2 = x^2 + 3y^2 + 2xy r3
        a, b = self.a, self.b
        # x^2 + 3 y^2 = a, 2 x y = b  ->  x^2 roots of t^2 - a t + 3 b^2 / 4 = 0
        disc = a * a - 3 * b * b
        s = _rat_sqrt(disc)
        if s is None:
            return None
        for x2 in ((a + s) / 2, (a - s) / 2):
            x = _rat_sqrt(x2)
            if x is None or x == 0:
                continue
            y = b / (2 * x)
            r = Q3(x, y)
            if r * r == self:
                return r if r.sign() >= 0 else -r
        return None


def _rat_sqrt(q):
    q = Fr(q)
    if q < 0:
        return None
    from math import isqrt
    n, d = q.numerator, q.denominator
    rn, rd = isqrt(n), isqrt(d)
    if rn * rn == n and rd * rd == d:
        return Fr(rn, rd)
    return None


R3 = Q3(0, 1)
HALF = Q3(Fr(1, 2))


def P(x, y):
    return (Q3.of(x), Q3.of(y))


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def scal(k, p):
    k = Q3.of(k)
    return (k * p[0], k * p[1])


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def cross(p, q):
    return p[0] * q[1] - p[1] * q[0]


def n2(p):
    return dot(p, p)


def peq(p, q):
    return p[0] == q[0] and p[1] == q[1]


def fmt(p):
    return f"({float(p[0]):.6f}, {float(p[1]):.6f})"


# ------------------------------------------------------------------------------------------------ distances sqrt(q) + k
class D:
    """A distance value s*sqrt(q) + k, q in Q(sqrt3) >= 0, s in {+1,-1}, k integer.  Only compared with 1."""
    __slots__ = ("s", "q", "k", "why")

    def __init__(self, q, k=0, s=1, why=""):
        self.q = Q3.of(q)
        self.k = int(k)
        self.s = s
        self.why = why
        assert self.q.sign() >= 0

    def cmp1(self):
        """sign(value - 1)."""
        m = 1 - self.k          # compare s*sqrt(q) with m
        if self.s == 1:
            if m <= 0:
                return 1 if (self.q.sign() > 0 or m < 0) else 0
            return (self.q - m * m).sign()
        # -sqrt(q) vs m  <=>  -(sqrt(q) vs -m)
        mm = -m
        if mm <= 0:
            r = 1 if (self.q.sign() > 0 or mm < 0) else 0
        else:
            r = (self.q - mm * mm).sign()
        return -r

    def __float__(self):
        return self.s * float(self.q) ** 0.5 + self.k

    def __repr__(self):
        return f"{float(self):.9f}"


def D_abs(q, k):
    """|sqrt(q) + k| as a D."""
    d = D(q, k, 1)
    # sign of sqrt(q) + k
    if k >= 0:
        sg = 1 if (q.sign() > 0 or k > 0) else 0
    else:
        sg = (q - k * k).sign()
    if sg >= 0:
        return d
    return D(q, -k, -1)


# --------------------------------------------------------------------------------------------------------------- pieces
class Seg:
    def __init__(self, p, q):
        self.p, self.q = p, q
        assert not peq(p, q)

    def ends(self):
        return (self.p, self.q)

    def __repr__(self):
        return f"Seg{fmt(self.p)}->{fmt(self.q)}"


class Arc:
    """Unit-radius arc, centre c, counter-clockwise from p0 to p1, span < 180 degrees."""

    def __init__(self, c, p0, p1):
        self.c, self.p0, self.p1 = c, p0, p1
        u0, u1 = sub(p0, c), sub(p1, c)
        assert n2(u0) == 1 and n2(u1) == 1, (fmt(c), fmt(p0), fmt(p1))
        assert cross(u0, u1).sign() > 0, "span must be in (0, 180) degrees"

    def ends(self):
        return (self.p0, self.p1)

    def dir_in(self, d):
        """Direction d (nonzero, any length) lies in the closed angular range of the arc."""
        u0, u1 = sub(self.p0, self.c), sub(self.p1, self.c)
        return cross(u0, d).sign() >= 0 and cross(d, u1).sign() >= 0

    def __repr__(self):
        return f"Arc[c={fmt(self.c)}]{fmt(self.p0)}->{fmt(self.p1)}"


def on_piece(x, pc):
    if isinstance(pc, Seg):
        d, e = sub(x, pc.p), sub(pc.q, pc.p)
        if cross(d, e).sign() != 0:
            return False
        t = dot(d, e) / n2(e)
        return t.sign() >= 0 and (t - 1).sign() <= 0
    v = sub(x, pc.c)
    return n2(v) == 1 and pc.dir_in(v)


# --------------------------------------------------------------------------------- candidate distances point <-> piece
def cand_point_piece(x, pc, want_min=True, want_max=True):
    out = []
    for e in pc.ends():
        out.append(D(n2(sub(x, e)), why=f"end {fmt(e)}"))
    if isinstance(pc, Seg):
        if want_min:
            d, e = sub(x, pc.p), sub(pc.q, pc.p)
            t = dot(d, e) / n2(e)
            if t.sign() >= 0 and (t - 1).sign() <= 0:
                foot = add(pc.p, scal(t, e))
                out.append(D(n2(sub(x, foot)), why=f"foot {fmt(foot)}"))
        return out
    v = sub(x, pc.c)
    if n2(v).sign() == 0:
        out.append(D(Q3(1), why="centre"))
        return out
    if want_min and pc.dir_in(v):
        out.append(D_abs(n2(v), -1))
        out[-1].why = "near circle point"
    if want_max and pc.dir_in(scal(-1, v)):
        out.append(D(n2(v), 1, why="far circle point"))
    return out


def unit_normal(seg):
    e = sub(seg.q, seg.p)
    L = n2(e).sqrt_exact()
    if L is None:
        raise NotImplementedError(f"segment {seg} has no unit normal in Q(sqrt3)")
    return (-e[1] / L, e[0] / L)


def cand_piece_piece(A, B):
    out = []
    for e in A.ends():
        out += cand_point_piece(e, B)
    for e in B.ends():
        out += cand_point_piece(e, A)
    if isinstance(A, Arc) and isinstance(B, Arc):
        w = sub(B.c, A.c)
        if n2(w).sign() == 0:
            if peq(A.p0, B.p0) and peq(A.p1, B.p1):
                return out       # the same arc: extrema at endpoints (span < 180)
            # same circle: chord 2|sin(delta/2)| is monotone in |delta| on [0, pi]; interior extrema only at delta = 0
            # (the arcs meet: distance 0) and delta = pi (antipodal points: distance 2)
            c = A.c
            if any(B.dir_in(sub(e, c)) for e in A.ends()) or any(A.dir_in(sub(e, c)) for e in B.ends()):
                out.append(D(Q3(0), why="concentric arcs meet"))
            if any(B.dir_in(sub(c, e)) for e in A.ends()) or any(A.dir_in(sub(c, e)) for e in B.ends()):
                out.append(D(Q3(4), why="concentric antipodal"))
            return out
        for s1, s2 in product((1, -1), repeat=2):
            if A.dir_in(scal(s1, w)) and B.dir_in(scal(s2, w)):
                # P = cA + s1 u, Q = cB + s2 u, u = w/|w|: Q - P = (|w| + s2 - s1) u
                out.append(D_abs(n2(w), s2 - s1))
                out[-1].why = f"centres s1={s1} s2={s2}"
    elif isinstance(A, Seg) and isinstance(B, Seg):
        pass
    else:
        seg, arc = (A, B) if isinstance(A, Seg) else (B, A)
        n = unit_normal(seg)
        for s in (1, -1):
            if arc.dir_in(scal(s, n)):
                pt = add(arc.c, scal(s, n))
                d, e = sub(pt, seg.p), sub(seg.q, seg.p)
                t = dot(d, e) / n2(e)
                if t.sign() >= 0 and (t - 1).sign() <= 0:
                    foot = add(seg.p, scal(t, e))
                    out.append(D(n2(sub(pt, foot)), why="arc-seg normal"))
    return out


# ------------------------------------------------------------------------------------------------------------------ tiles
class Tile:
    """A closed tile: boundary pieces in order (a closed curve), a colour, a name, and optionally its vertex list
    (for convex polygons, used by point-in-tile)."""

    def __init__(self, name, colour, pieces, convex_poly=None, zero_density_points=(), member=None):
        self.name, self.colour, self.pieces = name, colour, pieces
        self.member = member              # exact closed-membership test for curved tiles (x -> bool)
        self.poly = convex_poly           # CCW vertex list if a convex polygon
        self.zero = list(zero_density_points)   # boundary points where the tile has density 0 (cusps)
        # sanity: closed chain
        for a, b in zip(pieces, pieces[1:] + pieces[:1]):
            assert peq(a.ends()[1], b.ends()[0]), f"{name}: boundary not closed at {fmt(a.ends()[1])}"

    def contains_closed(self, x):
        for pc in self.pieces:
            if on_piece(x, pc):
                return True
        if self.member is not None:
            return self.member(x)
        if self.poly is not None:
            vs = self.poly
            return all(cross(sub(vs[(i + 1) % len(vs)], vs[i]), sub(x, vs[i])).sign() >= 0 for i in range(len(vs)))
        return False   # curved tiles without a member test: only boundary membership is decided

    def __repr__(self):
        return f"{self.name}<{self.colour}>"


def pair_range(T, U):
    """Return (lo, hi) with lo = sign(dmin - 1), hi = sign(dmax - 1) over the closed tiles (T may be U)."""
    cands = []
    if T is U:
        for i, A in enumerate(T.pieces):
            for B in T.pieces[i:]:
                cands += cand_piece_piece(A, B)
        lo = -1       # dmin = 0 within a tile
    else:
        for A in T.pieces:
            for B in U.pieces:
                cands += cand_piece_piece(A, B)
        lo = min(c.cmp1() for c in cands)
    hi = max(c.cmp1() for c in cands)
    return lo, hi


def point_contact(x, T):
    """True iff some point of the closed tile T is at distance exactly 1 from x."""
    if T.contains_closed(x):
        lo = -1
    else:
        lo = min(c.cmp1() for pc in T.pieces for c in cand_point_piece(x, pc))
    hi = max(c.cmp1() for pc in T.pieces for c in cand_point_piece(x, pc))
    return lo <= 0 <= hi


# ------------------------------------------------------------------------------------------------------------ polygons
def polygon(name, colour, verts):
    pcs = [Seg(verts[i], verts[(i + 1) % len(verts)]) for i in range(len(verts))]
    return Tile(name, colour, pcs, convex_poly=verts)


def centroid_float(T):
    xs = [float(p[0]) for pc in T.pieces for p in pc.ends()]
    ys = [float(p[1]) for pc in T.pieces for p in pc.ends()]
    return (sum(xs) / len(xs), sum(ys) / len(ys))


# --------------------------------------------------------------------------------------------------------- the checks
def check_proper_tight(tiles, focus, radius=3.2):
    """For every tile in `focus`, against every same-colour tile of `tiles` within float centre distance `radius`:
    returns (improper list, tight contacts list).  Exact verdicts; the float radius only preselects pairs and is
    generous (every tile here has diameter <= 1, so a pair with centre distance > 3 has dmin > 1)."""
    bad, tight = [], []
    for T in focus:
        cT = centroid_float(T)
        for U in tiles:
            if U.colour != T.colour:
                continue
            cU = centroid_float(U)
            if (cT[0] - cU[0]) ** 2 + (cT[1] - cU[1]) ** 2 > radius ** 2:
                continue
            lo, hi = pair_range(T, U)
            if T is U:
                if hi > 0:
                    bad.append((T, U, "diameter > 1"))
                elif hi == 0:
                    tight.append((T, U, "dmax = 1"))
            else:
                if lo < 0 < hi:
                    bad.append((T, U, "1 in (dmin, dmax)"))
                elif lo == 0 or hi == 0:
                    tight.append((T, U, "dmin = 1" if lo == 0 else "dmax = 1"))
    return bad, tight


def free_colours_at(x, tiles, colours, radius=3.2):
    """The colours j for which x is j-free (no closed colour-j tile has a point at distance exactly 1 from x)."""
    fx = (float(x[0]), float(x[1]))
    has = set()
    for U in tiles:
        if U.colour in has:
            continue
        cU = centroid_float(U)
        if (fx[0] - cU[0]) ** 2 + (fx[1] - cU[1]) ** 2 > radius ** 2:
            continue
        if point_contact(x, U):
            has.add(U.colour)
    return [c for c in colours if c not in has]


def certify_piece(T, pc, tiles):
    """A certificate that every point of the boundary piece pc of tile T has a point of a closed tile of T's colour at
    distance exactly 1.  Returns a description or None."""
    same = [U for U in tiles if U.colour == T.colour]
    if isinstance(pc, Arc):
        for U in same:
            if U.contains_closed(pc.c):
                return f"arc centre {fmt(pc.c)} lies in closed {U.name}"
        return None
    e = sub(pc.q, pc.p)
    L = n2(e).sqrt_exact()
    if L is None:
        return None
    n = (-e[1] / L, e[0] / L)
    for v in (n, scal(-1, n)):
        a, b = add(pc.p, v), add(pc.q, v)
        for U in same:
            if U.poly is not None and U.contains_closed(a) and U.contains_closed(b):
                return f"unit translate by {fmt(v)} lies in closed {U.name}"
    return None
