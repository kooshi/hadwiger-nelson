"""Exact plane geometry over Q(sqrt 3), for FS107-VW's checks (job FS107-VW, 2026-09-27).

Numbers are a + b*sqrt(3) with a, b Fractions; every comparison is exact (sign of a + b*sqrt3 decided by
squaring).  Pieces are convex polygons ('poly') or a triangle minus an open disc centred at one of its
vertices ('tridisc').  The distance range [min, max] of a pair of pieces is computed exactly:
  * max over hull vertices (the hull of a tridisc is conv{E1, E2, B1, B2}, E the arc ends);
  * min over pairs of boundary elements (segments; for the arc: its ends, and |s - O| - rho over the part
    of each opposing segment inside the arc's cone).
A distance is returned as a Dist: sqrt(d2) - off (off = 0 except arc distances), compared exactly.
This module trusts nothing from any other job; it is independent of FS107-W's tools.
"""
from fractions import Fraction as F


class Q3:
    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a = F(a)
        self.b = F(b)

    @staticmethod
    def c(x):
        return x if isinstance(x, Q3) else Q3(x, 0)

    def __add__(self, o):
        o = Q3.c(o)
        return Q3(self.a + o.a, self.b + o.b)

    __radd__ = __add__

    def __sub__(self, o):
        o = Q3.c(o)
        return Q3(self.a - o.a, self.b - o.b)

    def __rsub__(self, o):
        return Q3.c(o) - self

    def __neg__(self):
        return Q3(-self.a, -self.b)

    def __mul__(self, o):
        o = Q3.c(o)
        return Q3(self.a * o.a + 3 * self.b * o.b, self.a * o.b + self.b * o.a)

    __rmul__ = __mul__

    def __truediv__(self, o):
        o = Q3.c(o)
        n = o.a * o.a - 3 * o.b * o.b
        if n == 0:
            raise ZeroDivisionError
        return self * Q3(o.a / n, -o.b / n)

    def sign(self):
        a, b = self.a, self.b
        if b == 0:
            return (a > 0) - (a < 0)
        if a == 0:
            return (b > 0) - (b < 0)
        if a > 0 and b > 0:
            return 1
        if a < 0 and b < 0:
            return -1
        s = a * a - 3 * b * b  # sign of |a| - |b|sqrt3
        if s == 0:
            return 0
        return (1 if a > 0 else -1) * (1 if s > 0 else -1)

    def __lt__(self, o):
        return (self - o).sign() < 0

    def __le__(self, o):
        return (self - o).sign() <= 0

    def __gt__(self, o):
        return (self - o).sign() > 0

    def __ge__(self, o):
        return (self - o).sign() >= 0

    def __eq__(self, o):
        return (self - o).sign() == 0

    def __hash__(self):
        return hash((self.a, self.b))

    def __float__(self):
        return float(self.a) + float(self.b) * 3 ** 0.5

    def __repr__(self):
        return f"({self.a}+{self.b}r3)"


S3 = Q3(0, 1)
HALF = F(1, 2)
# unit vectors u(30 k degrees), k = 0..11, exactly in Q(sqrt3)
_C = [Q3(1), Q3(0, HALF), Q3(HALF), Q3(0), Q3(-HALF), Q3(0, -HALF), Q3(-1), Q3(0, -HALF), Q3(-HALF), Q3(0),
      Q3(HALF), Q3(0, HALF)]
_S = [Q3(0), Q3(HALF), Q3(0, HALF), Q3(1), Q3(0, HALF), Q3(HALF), Q3(0), Q3(-HALF), Q3(0, -HALF), Q3(-1),
      Q3(0, -HALF), Q3(-HALF)]


def u30(k):
    k %= 12
    return (_C[k], _S[k])


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def scale(t, p):
    return (p[0] * t, p[1] * t)


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def cross(p, q):
    return p[0] * q[1] - p[1] * q[0]


def n2(p):
    return dot(p, p)


class Dist:
    """sqrt(d2) - off, off >= 0 rational or Q3."""

    __slots__ = ("d2", "off")

    def __init__(self, d2, off=Q3(0)):
        self.d2 = Q3.c(d2)
        self.off = Q3.c(off)

    def ge(self, t):  # value >= t  (t >= 0)
        rhs = Q3.c(t) + self.off
        return self.d2 >= rhs * rhs

    def le(self, t):
        rhs = Q3.c(t) + self.off
        if rhs.sign() < 0:
            return False
        return self.d2 <= rhs * rhs

    def lt(self, other):  # exact comparison of two Dists, via float then exact where needed
        return float(self) < float(other)

    def __float__(self):
        return max(float(self.d2), 0.0) ** 0.5 - float(self.off)

    def __repr__(self):
        return f"{float(self):.9f}"


def seg_point_d2(p, a, b):
    ab = sub(b, a)
    L = n2(ab)
    t = dot(sub(p, a), ab) / L
    if t.sign() <= 0:
        return n2(sub(p, a))
    if (t - 1).sign() >= 0:
        return n2(sub(p, b))
    c = add(a, scale(t, ab))
    return n2(sub(p, c))


def orient(a, b, c):
    return cross(sub(b, a), sub(c, a)).sign()


def segs_intersect(a, b, c, d):
    o1, o2, o3, o4 = orient(a, b, c), orient(a, b, d), orient(c, d, a), orient(c, d, b)
    if o1 * o2 < 0 and o3 * o4 < 0:
        return True

    def on(p, q, r):  # r on segment pq, given collinear
        return (min(p[0], q[0]) <= r[0] <= max(p[0], q[0])) and (min(p[1], q[1]) <= r[1] <= max(p[1], q[1]))

    if o1 == 0 and on(a, b, c):
        return True
    if o2 == 0 and on(a, b, d):
        return True
    if o3 == 0 and on(c, d, a):
        return True
    if o4 == 0 and on(c, d, b):
        return True
    return False


def seg_seg_d2(a, b, c, d):
    if segs_intersect(a, b, c, d):
        return Q3(0)
    return min(seg_point_d2(a, c, d), seg_point_d2(b, c, d), seg_point_d2(c, a, b), seg_point_d2(d, a, b))


class Poly:
    kind = "poly"

    def __init__(self, verts, name=""):
        self.v = list(verts)  # counter-clockwise, convex
        self.name = name

    def hull(self):
        return self.v

    def segs(self):
        n = len(self.v)
        return [(self.v[i], self.v[(i + 1) % n]) for i in range(n)]

    def contains(self, p):
        return all(orient(a, b, p) >= 0 for a, b in self.segs())

    def shift(self, w):
        return Poly([add(p, w) for p in self.v], self.name)


class TriDisc:
    """conv(O, B1, B2) minus the open disc D(O, rho); requires rho < |OB1| = |OB2| (checked), (B1, B2) ccw about O,
    and the arc inside the triangle (rho^2 < dist(O, line B1B2)^2, checked)."""

    kind = "tridisc"

    def __init__(self, O, B1, B2, rho, R, name=""):
        self.O, self.B1, self.B2, self.rho, self.name = O, B1, B2, Q3.c(rho), name
        R = Q3.c(R)
        assert n2(sub(B1, O)) == R * R and n2(sub(B2, O)) == R * R, "legs must have length R"
        assert self.rho > Q3(0) and self.rho < R
        assert orient(O, B1, B2) > 0
        assert seg_point_d2(O, B1, B2) > self.rho * self.rho, "arc must stay inside the triangle"
        t = self.rho / R
        self.E1 = add(O, scale(t, sub(B1, O)))
        self.E2 = add(O, scale(t, sub(B2, O)))
        self.R = R

    def hull(self):
        return [self.E1, self.B1, self.B2, self.E2]

    def segs(self):
        return [(self.E1, self.B1), (self.B1, self.B2), (self.B2, self.E2)]

    def tri(self):
        return Poly([self.O, self.B1, self.B2], self.name + ":tri")

    def shift(self, w):
        return TriDisc(add(self.O, w), add(self.B1, w), add(self.B2, w), self.rho, self.R, self.name)

    def arc_seg_cands(self, a, b):
        """candidates whose minimum is the exact min distance from the arc to segment ab (ab outside the disc):
        the two arc ends against ab, and |s - O| - rho over the part of ab inside the arc's cone."""
        cands = [Dist(seg_point_d2(self.E1, a, b)), Dist(seg_point_d2(self.E2, a, b))]
        O, v1, v2 = self.O, sub(self.B1, self.O), sub(self.B2, self.O)
        lo, hi = Q3(0), Q3(1)
        d = sub(b, a)
        for (g0, g1) in ((cross(v1, sub(a, O)), cross(v1, d)), (cross(sub(a, O), v2), cross(d, v2))):
            # need g0 + lam g1 >= 0
            if g1.sign() == 0:
                if g0.sign() < 0:
                    return cands
                continue
            r = -g0 / g1
            if g1.sign() > 0:
                if r > lo:
                    lo = r
            else:
                if r < hi:
                    hi = r
        if lo <= hi:
            p, q = add(a, scale(lo, d)), add(a, scale(hi, d))
            dd = n2(sub(p, O)) if lo == hi else seg_point_d2(O, p, q)
            if dd < self.rho * self.rho:
                raise ValueError("segment enters the disc: not handled")
            cands.append(Dist(dd, self.rho))
        return cands


def piece_min_cands(A, B):
    """list of Dists whose minimum is a lower bound for min{|x - y| : x in A, y in B}, exact except for
    tridisc-tridisc pairs, where the arc-arc part is bounded below by the triangles' distance (flagged).
    Returns (cands, exact_flag). A zero candidate means the pieces meet."""
    for X, Y in ((A, B), (B, A)):
        if Y.kind == "poly":
            if any(Y.contains(p) for p in X.hull()):
                return [Dist(0)], True
        else:
            T = Y.tri()
            if any(T.contains(p) and n2(sub(p, Y.O)) >= Y.rho * Y.rho for p in X.hull()):
                return [Dist(0)], True
    cands = [Dist(seg_seg_d2(a, b, c, d)) for (a, b) in A.segs() for (c, d) in B.segs()]
    for X, Y in ((A, B), (B, A)):
        if X.kind == "tridisc":
            for (c, d) in Y.segs():
                cands += X.arc_seg_cands(c, d)
    exact = True
    if A.kind == "tridisc" and B.kind == "tridisc":
        tc, _ = piece_min_cands(A.tri(), B.tri())
        cands += tc
        exact = False
    return cands, exact


def piece_max_cands(A, B):
    return [Dist(n2(sub(p, q))) for p in A.hull() for q in B.hull()]
