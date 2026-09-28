#!/usr/bin/env python3
"""FS114-YB's exact checker for maps bounded by segments and circular arcs (written for the job, without reading any FS114-Y file and without
FS-112's pair or sign code).

ARITHMETIC.  A `Tower` is Q(sqrt d_1)(sqrt d_2)...(sqrt d_n), each d_k a positive element of the level below.  An element of level k is a pair
(a, b) = a + b sqrt(d_k) of level-(k-1) elements; level 0 is a Fraction.  Sums and products are identities in the square roots.  The SIGN is exact
by recursion: sign(a + b sqrt d) is sign a when b = 0, sign b when a = 0, the common sign when they agree, and sign(a) * sign(a^2 - b^2 d) when
they differ -- a statement about real numbers that holds even if some d_k happens to be a square lower down.  Equality is sign = 0.  Inversion
multiplies by the conjugate and raises if the conjugate norm vanishes at a nonzero element (never guesses).

GEOMETRY.  A tile is a closed chain of pieces in counter-clockwise order; a piece is a segment, or an arc of a circle (centre C, radius rho)
traversed counter-clockwise or clockwise about C, spanning strictly between 0 and 180 degrees.

THE VERDICT for two tiles of one colour (a tile with itself included): REJECT iff m < 1 < M, where m and M are the minimum and maximum distance
between points of the two closed tiles.  Interior points of the two tiles then realise distance exactly 1 (the interiors are connected); if
M <= 1 or m >= 1 no interior pair does (an interior point is never extreme).  m and M are decided exactly from a COMPLETE list of candidate
point pairs, each a realised distance: every critical point of the squared distance on (piece) x (piece) -- endpoint pairs; an endpoint against
the other piece's foot of perpendicular (segment) or radial points (arc); a segment against an arc along the segment's normal through the
centre; two arcs along their line of centres (radial and antipodal pairs when concentric) -- and an exact INTERSECTION test of every two pieces
(a crossing gives m = 0 at a pair none of the other candidates need realise).  Every candidate distance has the form sqrt(S) or |sqrt(D) + k|
with S, D, k in the tower and is compared with 1 exactly.  For a tile with itself m = 0.  No map hypothesis is used by the verdict.

POINTS.  For a point z and a tile, straddle(z, tile) iff min < 1 < max over the closed tile (min = 0 if z lies in it, decided by an exact ray
count).  A colour is free at z iff no tile of that colour (outside an optional ignore list) straddles z.

CHECKER PLANTS (each fires only through the code path it names): `noself` (skip a tile against itself), `closed_interval` (REJECT iff
m <= 1 <= M: every tight contact shows), `no_intersect` (skip the intersection test), `endpoints_only` (keep endpoint pairs only), `no_interior` (drop the interior-interior
candidates: segment-arc normals and lines of centres).
"""
from __future__ import annotations
import math
from fractions import Fraction as Fr

PLANT = None   # the checker plant in force (module level, set by drivers)


# =========================================================================== raw tower arithmetic
def _zero(k):
    return Fr(0) if k == 0 else (_zero(k - 1), _zero(k - 1))


def _lift(x, kf, kt):
    while kf < kt:
        x = (x, _zero(kf))
        kf += 1
    return x


def _add(x, y, k):
    return x + y if k == 0 else (_add(x[0], y[0], k - 1), _add(x[1], y[1], k - 1))


def _neg(x, k):
    return -x if k == 0 else (_neg(x[0], k - 1), _neg(x[1], k - 1))


def _scal(x, q, k):
    return x * q if k == 0 else (_scal(x[0], q, k - 1), _scal(x[1], q, k - 1))


def _mul(x, y, k, D):
    if k == 0:
        return x * y
    a, b = x
    c, e = y
    ac = _mul(a, c, k - 1, D)
    be = _mul(b, e, k - 1, D)
    return (_add(ac, _mul(be, D[k - 1], k - 1, D), k - 1), _add(_mul(a, e, k - 1, D), _mul(b, c, k - 1, D), k - 1))


def _sign(x, k, D):
    if k == 0:
        return (x > 0) - (x < 0)
    a, b = x
    sa, sb = _sign(a, k - 1, D), _sign(b, k - 1, D)
    if sb == 0:
        return sa
    if sa == 0 or sa == sb:
        return sb if sa == 0 else sa
    n = _add(_mul(a, a, k - 1, D), _neg(_mul(_mul(b, b, k - 1, D), D[k - 1], k - 1, D), k - 1), k - 1)
    return sa * _sign(n, k - 1, D)


def _inv(x, k, D):
    if k == 0:
        if x == 0:
            raise ZeroDivisionError("inverse of 0")
        return 1 / x
    a, b = x
    n = _add(_mul(a, a, k - 1, D), _neg(_mul(_mul(b, b, k - 1, D), D[k - 1], k - 1, D), k - 1), k - 1)
    if _sign(n, k - 1, D) == 0:
        if _sign(x, k, D) == 0:
            raise ZeroDivisionError("inverse of 0")
        raise ArithmeticError("degenerate tower: a radicand is a square below its level")
    ni = _inv(n, k - 1, D)
    return (_mul(a, ni, k - 1, D), _neg(_mul(b, ni, k - 1, D), k - 1))


def _float(x, k, Df):
    return float(x) if k == 0 else _float(x[0], k - 1, Df) + _float(x[1], k - 1, Df) * Df[k - 1]


class Tower:
    """Q(sqrt d_1)...(sqrt d_n).  `extend(x, name)` returns a new tower one level up whose new radicand is x (an element of this tower, > 0)."""

    def __init__(self, D=(), names=(), Df=()):
        self.D = tuple(D)
        self.names = tuple(names)
        self.Df = tuple(Df)

    @staticmethod
    def base():
        return Tower()

    def extend(self, x, name):
        x = self(x)
        assert x.sign() > 0, f"radicand {name} not positive"
        v = _lift(x.v, x.k, len(self.D))
        return Tower(self.D + (v,), self.names + (name,), self.Df + (math.sqrt(float(x)),))

    def gen(self, i):
        """sqrt(d_i) as an element (i = 1 .. n)."""
        v = (_zero(i - 1), _lift(Fr(1), 0, i - 1))
        return Num(self, i, v)

    def __call__(self, x):
        if isinstance(x, Num):
            return x.to(self)
        return Num(self, 0, Fr(x))

    def is_prefix_of(self, other):
        return len(self.D) <= len(other.D) and all(a is b for a, b in zip(self.D, other.D))


class Num:
    __slots__ = ("T", "k", "v")

    def __init__(self, T, k, v):
        self.T, self.k, self.v = T, k, v

    def to(self, T):
        if self.T is T:
            return self
        if not self.T.is_prefix_of(T):
            raise ValueError("elements of incompatible towers")
        return Num(T, self.k, self.v)

    def _co(self, o):
        if not isinstance(o, Num):
            o = Num(self.T, 0, Fr(o))
        if self.T is o.T:
            T = self.T
        elif self.T.is_prefix_of(o.T):
            T = o.T
        elif o.T.is_prefix_of(self.T):
            T = self.T
        else:
            raise ValueError("elements of incompatible towers")
        k = max(self.k, o.k)
        return T, k, _lift(self.v, self.k, k), _lift(o.v, o.k, k)

    def __add__(s, o):
        T, k, a, b = s._co(o)
        return Num(T, k, _add(a, b, k))

    __radd__ = __add__

    def __sub__(s, o):
        T, k, a, b = s._co(o)
        return Num(T, k, _add(a, _neg(b, k), k))

    def __rsub__(s, o):
        return (-s) + o

    def __neg__(s):
        return Num(s.T, s.k, _neg(s.v, s.k))

    def __mul__(s, o):
        if not isinstance(o, Num):
            return Num(s.T, s.k, _scal(s.v, Fr(o), s.k))
        T, k, a, b = s._co(o)
        return Num(T, k, _mul(a, b, k, T.D))

    __rmul__ = __mul__

    def inv(s):
        return Num(s.T, s.k, _inv(s.v, s.k, s.T.D))

    def __truediv__(s, o):
        if not isinstance(o, Num):
            return Num(s.T, s.k, _scal(s.v, 1 / Fr(o), s.k))
        return s * o.inv()

    def __rtruediv__(s, o):
        return s.inv() * o

    def sign(s):
        return _sign(s.v, s.k, s.T.D)

    def is0(s):
        return s.sign() == 0

    def __eq__(s, o):
        return (s - o).sign() == 0

    def __ne__(s, o):
        return (s - o).sign() != 0

    def __lt__(s, o):
        return (s - o).sign() < 0

    def __le__(s, o):
        return (s - o).sign() <= 0

    def __gt__(s, o):
        return (s - o).sign() > 0

    def __ge__(s, o):
        return (s - o).sign() >= 0

    __hash__ = None

    def __float__(s):
        return _float(s.v, s.k, s.T.Df)

    def __repr__(s):
        return f"{float(s):.12g}"


def sign_ab(a, b, D):
    """exact sign of a + b sqrt(D), D >= 0."""
    if D.sign() < 0:
        raise ValueError("negative radicand")
    sa = a.sign()
    if D.is0() or b.is0():
        return sa
    sb = b.sign()
    if sa == 0:
        return sb
    if sa == sb:
        return sa
    return sa * (a * a - b * b * D).sign()


def _ssp(D, c):
    """exact sign of sqrt(D) + c, D >= 0."""
    if D.sign() < 0:
        raise ValueError("negative radicand")
    if D.is0():
        return c.sign()
    if c.sign() >= 0:
        return 1
    return (D - c * c).sign()


# =========================================================================== vectors
def vsub(p, q): return (p[0] - q[0], p[1] - q[1])
def vadd(p, q): return (p[0] + q[0], p[1] + q[1])
def vmul(t, p): return (p[0] * t, p[1] * t)
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def cross(p, q): return p[0] * q[1] - p[1] * q[0]
def n2(p): return dot(p, p)
def J(p): return (-p[1], p[0])
def veq(p, q): return (p[0] - q[0]).is0() and (p[1] - q[1]).is0()
def is0v(p): return p[0].is0() and p[1].is0()
def fpt(p): return (round(float(p[0]), 6), round(float(p[1]), 6))


# =========================================================================== pieces
class Seg:
    kind = "S"

    def __init__(s, P, Q):
        assert not veq(P, Q), "degenerate segment"
        s.P, s.Q = P, Q

    def ends(s):
        return s.P, s.Q

    def __repr__(s):
        return f"Seg{fpt(s.P)}->{fpt(s.Q)}"


class Arc:
    """traversed from P to Q about C; ccw = True if that traversal is counter-clockwise about C.  (S, E) is the counter-clockwise pair."""
    kind = "A"

    def __init__(s, C, rho, P, Q, ccw):
        s.C, s.rho, s.P, s.Q, s.ccw = C, rho, P, Q, ccw
        assert rho.sign() > 0, "radius not positive"
        assert n2(vsub(P, C)) == rho * rho, f"arc end {fpt(P)} off its circle about {fpt(C)}"
        assert n2(vsub(Q, C)) == rho * rho, f"arc end {fpt(Q)} off its circle about {fpt(C)}"
        s.S, s.E = (P, Q) if ccw else (Q, P)
        s.a, s.e = vsub(s.S, C), vsub(s.E, C)
        assert cross(s.a, s.e).sign() > 0, "arc must span strictly between 0 and 180 degrees"

    def ends(s):
        return s.P, s.Q

    def has_dir(s, w):
        """is C + rho w/|w| on the closed arc?  (w a nonzero vector)"""
        return cross(s.a, w).sign() >= 0 and cross(w, s.e).sign() >= 0

    def has_dir_sqrt(s, w0, w1, D):
        """is the direction w0 + w1 sqrt(D) on the closed arc?"""
        return (sign_ab(cross(s.a, w0), cross(s.a, w1), D) >= 0 and sign_ab(cross(w0, s.e), cross(w1, s.e), D) >= 0)

    def __repr__(s):
        return f"Arc[{fpt(s.C)} r{float(s.rho):.4g} {fpt(s.P)}->{fpt(s.Q)} {'ccw' if s.ccw else 'cw'}]"


def reverse(pc):
    if pc.kind == "S":
        return Seg(pc.Q, pc.P)
    return Arc(pc.C, pc.rho, pc.Q, pc.P, not pc.ccw)


# =========================================================================== candidates: realised distances, each compared with 1 exactly
class Cand:
    """distance sqrt(S) (kind 'sq') or |sqrt(D) + c| (kind 'rad')"""
    __slots__ = ("kind", "a", "b", "why")

    def __init__(self, kind, a, b=None, why=""):
        self.kind, self.a, self.b, self.why = kind, a, b, why

    def cmp1(self):
        if self.kind == "sq":
            return (self.a - 1).sign()
        D, c = self.a, self.b
        hi = _ssp(D, c - 1)       # sign(sqrt D + c - 1)
        lo = _ssp(D, c + 1)       # sign(sqrt D + c + 1)
        if hi < 0 and lo > 0:
            return -1
        if hi > 0 or lo < 0:
            return 1
        return 0

    def value(self):
        if self.kind == "sq":
            return math.sqrt(max(float(self.a), 0.0))
        return abs(math.sqrt(max(float(self.a), 0.0)) + float(self.b))


def point_piece(p, pc, tag=""):
    out = [Cand("sq", n2(vsub(p, pc.P)), why=tag + "end"), Cand("sq", n2(vsub(p, pc.Q)), why=tag + "end")]
    if PLANT == "endpoints_only":
        return out
    if pc.kind == "S":
        v = vsub(pc.Q, pc.P)
        t = dot(vsub(p, pc.P), v) / n2(v)
        if t.sign() > 0 and (t - 1).sign() < 0:
            f = vadd(pc.P, vmul(t, v))
            out.append(Cand("sq", n2(vsub(p, f)), why=tag + "foot"))
    else:
        w = vsub(p, pc.C)
        if is0v(w):
            out.append(Cand("sq", pc.rho * pc.rho, why=tag + "centre"))
        else:
            D = n2(w)
            if pc.has_dir(w):
                out.append(Cand("rad", D, -pc.rho, why=tag + "near"))
            if pc.has_dir((-w[0], -w[1])):
                out.append(Cand("rad", D, pc.rho, why=tag + "far"))
    return out


def piece_piece(a, b):
    out = []
    for p in a.ends():
        out += point_piece(p, b, "a-end/")
    for p in b.ends():
        out += point_piece(p, a, "b-end/")
    if PLANT in ("endpoints_only", "no_interior"):
        return out
    if a.kind == "S" and b.kind == "S":
        return out
    if a.kind == "A" and b.kind == "S":
        a, b = b, a
    if a.kind == "S":           # segment a, arc b
        v = vsub(a.Q, a.P)
        t = dot(vsub(b.C, a.P), v) / n2(v)
        if t.sign() > 0 and (t - 1).sign() < 0:
            f = vadd(a.P, vmul(t, v))
            w = vsub(f, b.C)
            if is0v(w):
                for d in (J(v), (-J(v)[0], -J(v)[1])):
                    if b.has_dir(d):
                        out.append(Cand("sq", b.rho * b.rho, why="seg-through-centre"))
            else:
                D = n2(w)
                if b.has_dir(w):
                    out.append(Cand("rad", D, -b.rho, why="seg-arc normal near"))
                if b.has_dir((-w[0], -w[1])):
                    out.append(Cand("rad", D, b.rho, why="seg-arc normal far"))
        return out
    # two arcs
    u = vsub(b.C, a.C)
    if is0v(u):
        if ranges_overlap(a, b, False):
            out.append(Cand("sq", (a.rho - b.rho) * (a.rho - b.rho), why="concentric radial"))
        if ranges_overlap(a, b, True):
            out.append(Cand("sq", (a.rho + b.rho) * (a.rho + b.rho), why="concentric antipodal"))
        return out
    D = n2(u)
    for s1 in (1, -1):
        for s2 in (1, -1):
            if a.has_dir(vmul(s1, u)) and b.has_dir(vmul(s2, u)):
                out.append(Cand("rad", D, b.rho * s2 - a.rho * s1, why="line of centres"))
    return out


def ranges_overlap(a, b, antipodal):
    sgn = -1 if antipodal else 1
    return (a.has_dir(vmul(sgn, b.a)) or a.has_dir(vmul(sgn, b.e)) or b.has_dir(vmul(sgn, a.a)) or b.has_dir(vmul(sgn, a.e)))


# =========================================================================== exact intersection of two pieces
def _on_seg(p, s):
    v, w = vsub(s.Q, s.P), vsub(p, s.P)
    if not cross(v, w).is0():
        return False
    t = dot(w, v)
    return t.sign() >= 0 and (t - n2(v)).sign() <= 0


def intersect(a, b):
    if a.kind == "S" and b.kind == "S":
        d1 = cross(vsub(a.Q, a.P), vsub(b.P, a.P)).sign()
        d2 = cross(vsub(a.Q, a.P), vsub(b.Q, a.P)).sign()
        d3 = cross(vsub(b.Q, b.P), vsub(a.P, b.P)).sign()
        d4 = cross(vsub(b.Q, b.P), vsub(a.Q, b.P)).sign()
        if d1 * d2 < 0 and d3 * d4 < 0:
            return True
        return _on_seg(b.P, a) or _on_seg(b.Q, a) or _on_seg(a.P, b) or _on_seg(a.Q, b)
    if a.kind == "A" and b.kind == "S":
        a, b = b, a
    if a.kind == "S":
        v = vsub(a.Q, a.P)
        w0 = vsub(a.P, b.C)
        A = n2(v)
        B = dot(v, w0)
        C0 = n2(w0) - b.rho * b.rho
        disc = B * B - A * C0
        if disc.sign() < 0:
            return False
        for s in ((1,) if disc.is0() else (1, -1)):
            # t = (-B + s sqrt disc)/A in [0, 1]
            if sign_ab(-B, _num_like(B, s), disc) < 0:
                continue
            if sign_ab(A + B, _num_like(B, -s), disc) < 0:
                continue
            al = vsub(w0, vmul(B / A, v))
            be = vmul(_num_like(B, s) / A, v)
            if b.has_dir_sqrt(al, be, disc):
                return True
        return False
    # two arcs
    d = vsub(b.C, a.C)
    if is0v(d):
        return (a.rho - b.rho).is0() and ranges_overlap(a, b, False)
    D = n2(d)
    lam = (D + a.rho * a.rho - b.rho * b.rho) / (D * 2)
    mu2 = a.rho * a.rho / D - lam * lam
    if mu2.sign() < 0:
        return False
    for s in ((1,) if mu2.is0() else (1, -1)):
        be = vmul(_num_like(lam, s), J(d))
        if a.has_dir_sqrt(vmul(lam, d), be, mu2) and b.has_dir_sqrt(vmul(lam - 1, d), be, mu2):
            return True
    return False


def _num_like(x, q):
    return Num(x.T, 0, Fr(q))


# =========================================================================== tiles
class Tile:
    def __init__(self, name, colour, pieces):
        self.name, self.colour, self.pieces = name, colour, pieces
        for i, pc in enumerate(pieces):
            nx = pieces[(i + 1) % len(pieces)]
            assert veq(pc.Q, nx.P), f"tile {name}: piece {i} does not end where piece {i + 1} starts"
        self._bbox = None

    def bbox(self):
        if self._bbox is None:
            xs, ys = [], []
            for pc in self.pieces:
                for p in pc.ends():
                    xs.append(p[0])
                    ys.append(p[1])
                if pc.kind == "A":
                    one, zero = pc.rho.T(1), pc.rho.T(0)
                    for d in ((one, zero), (-one, zero), (zero, one), (zero, -one)):
                        if pc.has_dir(d):
                            q = vadd(pc.C, vmul(pc.rho, d))
                            xs.append(q[0])
                            ys.append(q[1])
            self._bbox = (_mn(xs), _mx(xs), _mn(ys), _mx(ys))
        return self._bbox

    def area_float(self):
        tot = 0.0
        for pc in self.pieces:
            P, Q = (float(pc.P[0]), float(pc.P[1])), (float(pc.Q[0]), float(pc.Q[1]))
            tot += (P[0] * Q[1] - Q[0] * P[1]) / 2
            if pc.kind == "A":
                r = float(pc.rho)
                ch = math.dist(P, Q)
                th = 2 * math.asin(min(1.0, ch / (2 * r)))
                seg = r * r / 2 * (th - math.sin(th))
                tot += seg if pc.ccw else -seg
        return tot


def _mn(xs):
    m = xs[0]
    for x in xs[1:]:
        if x < m:
            m = x
    return m


def _mx(xs):
    m = xs[0]
    for x in xs[1:]:
        if x > m:
            m = x
    return m


def bbox_gap_ge1(A, B):
    """exact: is the gap between the tiles' bounding boxes at least 1 in x or in y?  (then m >= 1)"""
    ax0, ax1, ay0, ay1 = A.bbox()
    bx0, bx1, by0, by1 = B.bbox()
    return (bx0 - ax1 - 1).sign() >= 0 or (ax0 - bx1 - 1).sign() >= 0 or (by0 - ay1 - 1).sign() >= 0 or (ay0 - by1 - 1).sign() >= 0


class PairResult:
    def __init__(self, A, B, touch, lt, eq, gt, n):
        self.A, self.B, self.touch, self.lt, self.eq, self.gt, self.n = A, B, touch, lt, eq, gt, n
        self.min_lt1 = touch or lt
        self.max_gt1 = gt
        if PLANT == "closed_interval":
            self.reject = (self.min_lt1 or eq) and (self.max_gt1 or eq)
        else:
            self.reject = self.min_lt1 and self.max_gt1
        # a tight contact: the minimum is exactly 1 (no candidate below, touch false, some candidate equal) or the maximum is exactly 1
        self.min_eq1 = (not self.min_lt1) and eq     # every candidate >= 1, one equal: the minimum is exactly 1 (the list is complete)
        self.max_eq1 = (not gt) and eq                # every candidate <= 1, one equal: the maximum is exactly 1

    def straddles(self):
        return self.min_lt1 and self.max_gt1


def pair(A, B):
    """the exact verdict for tiles A, B (A is B allowed)."""
    same = A is B
    touch = same
    lt = eq = gt = False
    n = 0
    for a in A.pieces:
        for b in B.pieces:
            if not touch and PLANT != "no_intersect" and intersect(a, b):
                touch = True
            for c in piece_piece(a, b):
                n += 1
                s = c.cmp1()
                if s < 0:
                    lt = True
                elif s > 0:
                    gt = True
                else:
                    eq = True
    return PairResult(A, B, touch, lt, eq, gt, n)


def straddle_tiles(A, B):
    """do two tiles (any colours) have interior points at distance exactly 1?  exact; bounding boxes dismiss first."""
    if A is not B and bbox_gap_ge1(A, B):
        return False
    return pair(A, B).straddles()


# =========================================================================== points against tiles
def inside(z, tile):
    """exact: 1 inside, 0 on the boundary, -1 outside.  Ray casting with a rational direction; retried on any degeneracy."""
    T = z[0].T
    for d in ((1, 0), (7, 3), (5, -11), (-3, 13), (17, 5), (2, -9), (-13, -4)):
        dv = (T(d[0]), T(d[1]))
        r = _ray(z, dv, tile)
        if r is not None:
            return r
    raise ArithmeticError("ray casting degenerate in every direction tried")


def _ray(z, d, tile):
    cnt = 0
    for pc in tile.pieces:
        if pc.kind == "S":
            if _on_seg(z, pc):
                return 0
            v = vsub(pc.Q, pc.P)
            den = cross(d, v)
            w = vsub(pc.P, z)
            if den.is0():
                if cross(d, w).is0():      # collinear with the ray's line
                    return None
                continue
            t = cross(w, v) / den
            s = cross(w, d) / den
            if t.sign() <= 0:
                continue
            if s.is0() or (s - 1).is0():
                return None
            if s.sign() > 0 and (s - 1).sign() < 0:
                cnt += 1
        else:
            w = vsub(z, pc.C)
            A = n2(d)
            B = dot(d, w)
            C0 = n2(w) - pc.rho * pc.rho
            if C0.is0() and pc.has_dir(w):
                return 0
            disc = B * B - A * C0
            if disc.sign() < 0:
                continue
            if disc.is0():
                t = -B / A
                if t.sign() > 0 and pc.has_dir(vadd(w, vmul(t, d))):
                    return None           # tangent
                continue
            for s in (1, -1):
                sN = _num_like(B, s)
                st = sign_ab(-B, sN, disc)
                if st <= 0:
                    continue
                al = vsub(w, vmul(B / A, d))
                be = vmul(sN / A, d)
                c1 = sign_ab(cross(pc.a, al), cross(pc.a, be), disc)
                c2 = sign_ab(cross(al, pc.e), cross(be, pc.e), disc)
                if c1 == 0 or c2 == 0:
                    return None           # through an arc end
                if c1 > 0 and c2 > 0:
                    cnt += 1
    return 1 if cnt % 2 else -1


def point_tile(z, tile):
    """(min < 1, max > 1, min == 1 or max == 1 possible) for the closed tile against the point z."""
    ins = inside(z, tile)
    lt = ins >= 0
    gt = eq = False
    for pc in tile.pieces:
        for c in point_piece(z, pc):
            s = c.cmp1()
            lt |= s < 0
            gt |= s > 0
            eq |= s == 0
    return lt, gt, eq, ins


def free_colours(z, tiles, colours, ignore=()):
    blocked = {}
    for t in tiles:
        if t.name in ignore:
            continue
        lt, gt, eq, ins = point_tile(z, t)
        if lt and gt:
            blocked.setdefault(t.colour, []).append(t.name)
    return [c for c in colours if c not in blocked], blocked


# =========================================================================== map consistency
def consistency(tiles, open_ok=lambda pc: False):
    """every piece shared by exactly two tiles in opposite directions, or accepted as open (a rim or window edge) by open_ok."""
    table = []
    for t in tiles:
        for pc in t.pieces:
            table.append((t.name, pc))
    bad = []
    unmatched = 0
    for i, (nm, pc) in enumerate(table):
        mates = [nm2 for j, (nm2, q) in enumerate(table) if j != i and _same_piece_rev(pc, q)]
        if len(mates) == 1:
            continue
        if not mates and open_ok(pc):
            unmatched += 1
            continue
        bad.append((nm, pc, mates))
    return bad, unmatched


def _same_piece_rev(p, q):
    if p.kind != q.kind or not veq(p.P, q.Q) or not veq(p.Q, q.P):
        return False
    if p.kind == "S":
        return True
    return veq(p.C, q.C) and (p.rho - q.rho).is0() and p.ccw != q.ccw
