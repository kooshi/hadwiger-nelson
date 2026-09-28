#!/usr/bin/env python3
"""FS112-YB2's exact curved-tile checker over a TOWER OF REAL SQUARE-ROOT EXTENSIONS (killing test 2 of data/fs112/claims.md §8).

Written blind: not derived from, and without reading, the pair logic of tools/fs112_y_check.py, tools/fs112_y2_*, or tools/fs112_yb_check.py.

ARITHMETIC.  A Tower is Q(sqrt d_1)(sqrt d_2)...(sqrt d_n), each d_k a POSITIVE element of the previous level.  An element of level k is a pair
(a, b) of level-(k-1) elements meaning a + b*sqrt(d_k); level 0 is a Fraction.  Sums and products are polynomial identities in the square roots,
so they are exact whatever algebraic relations hold among the radicands.  THE SIGN IS EXACT BY RECURSION: sign(a + b sqrt d) is sign a when
sign a = sign b (or b = 0), sign b when a = 0, and otherwise sign(a) * sign(a^2 - b^2 d) -- a statement about real numbers that needs no
assumption that d is a non-square.  Inversion uses the conjugate and RAISES (never guesses) if a^2 - b^2 d = 0 at a nonzero element (a radicand
that is a square lower down).  Floats are printed, never compared.

TILES.  A tile is a closed region given by its boundary pieces: Seg(P, Q) and Arc(C, rho, S, E), the arc of the circle (C, rho) counter-clockwise
from S to E, spanning strictly less than 180 degrees (asserted; split a longer arc).  Coordinates, centres and radii lie in one tower.

THE VERDICT for a same-colour pair of tiles (a tile with itself included): with m, M the minimum and maximum of |p - q| over p in T1, q in T2,
the interior cross-distances fill the open interval (m, M) (tiles are closed discs' images: interiors connected and dense), so
    REJECT  iff  m < 1 < M.
COMPLETENESS.  m and M are attained on boundary pieces, at a pair each of whose points is an endpoint of its piece or a critical point of the
distance along its piece; the candidate list below holds every such pair and each candidate is a realised distance (direction and foot
conditions are checked exactly):
  endpoint-endpoint; endpoint to a segment's interior (the foot); endpoint X to an arc (the arc points C +- rho (X-C)/|X-C|, or every point
  when X = C); segment-arc interior pairs (the arc points C +- rho n/|n|, n normal to the segment, with their feet); arc-arc interior pairs on
  the line of centres (C1 + s1 rho1 u, C2 + s2 rho2 u), or, for concentric arcs, the radially aligned and the antipodal pairs; segment-segment
  interior pairs are never strict extremes unless the segments meet.
Every candidate distance has the form |sqrt(A) + B| with A >= 0 and A, B in the tower, and is compared with 1 exactly.
MEETING (m = 0 for distinct tiles) is decided exactly, with NO map hypothesis: shared or incident endpoints, segment crossings, segment-circle
and circle-circle intersection points (each a + b sqrt(Delta) with Delta in the tower) tested for lying on both pieces.

Checker plants (--kplant NAME, or set PLANT): noself (skip self-pairs), endpoints_only (endpoint-endpoint candidates only), no_interior (drop
the segment-arc and arc-arc interior candidates), no_meet (skip the meeting test), closed_interval (REJECT iff m <= 1 <= M: tightness visible),
cw_arcs (read every arc clockwise).  Each is shown to flip exactly the self-test controls predicted for it.
Run: python3 tools/fs112_yb2_check.py --selftest [--kplant NAME]
"""
from __future__ import annotations
import math
import sys
from fractions import Fraction as Fr
from itertools import combinations_with_replacement

PLANT = None


# ============================================================ level arithmetic (x, y at level k of the radicand list ds)
def _z(k):
    return Fr(0) if k == 0 else (_z(k - 1), _z(k - 1))


def _lift(x, kf, kt):
    for k in range(kf, kt):
        x = (x, _z(k))
    return x


def _add(x, y, k):
    return x + y if k == 0 else (_add(x[0], y[0], k - 1), _add(x[1], y[1], k - 1))


def _neg(x, k):
    return -x if k == 0 else (_neg(x[0], k - 1), _neg(x[1], k - 1))


def _scal(x, q, k):
    return x * q if k == 0 else (_scal(x[0], q, k - 1), _scal(x[1], q, k - 1))


def _mul(x, y, k, ds):
    if k == 0:
        return x * y
    a, b = x
    c, e = y
    j = k - 1
    return (_add(_mul(a, c, j, ds), _mul(_mul(b, e, j, ds), ds[j], j, ds), j), _add(_mul(a, e, j, ds), _mul(b, c, j, ds), j))


def _sgn(x, k, ds):
    if k == 0:
        return (x > 0) - (x < 0)
    a, b = x
    j = k - 1
    sb = _sgn(b, j, ds)
    sa = _sgn(a, j, ds)
    if sb == 0:
        return sa
    if sa == 0 or sa == sb:
        return sb if sa == 0 else sa
    t = _sgn(_add(_mul(a, a, j, ds), _neg(_mul(_mul(b, b, j, ds), ds[j], j, ds), j), j), j, ds)
    return sa if t > 0 else (sb if t < 0 else 0)


class DegenerateTower(ArithmeticError):
    pass


def _inv(x, k, ds):
    if k == 0:
        return Fr(1) / x
    a, b = x
    j = k - 1
    nrm = _add(_mul(a, a, j, ds), _neg(_mul(_mul(b, b, j, ds), ds[j], j, ds), j), j)
    if _sgn(nrm, j, ds) == 0:
        if _sgn(x, k, ds) == 0:
            raise ZeroDivisionError("inverse of zero")
        raise DegenerateTower("conjugate norm vanishes at a nonzero element: a radicand is a square lower down")
    ni = _inv(nrm, j, ds)
    return (_mul(a, ni, j, ds), _neg(_mul(b, ni, j, ds), j))


def _float(x, k, dsf):
    if k == 0:
        return float(x)
    return _float(x[0], k - 1, dsf) + _float(x[1], k - 1, dsf) * dsf[k - 1]


# ============================================================ towers and their elements
class Tower:
    """Q(sqrt d_1)...(sqrt d_n).  Build with Tower.base() then .extend(g, name)."""
    _count = 0

    def __init__(self, ds, names, parent):
        Tower._count += 1
        self.uid = Tower._count
        self.ds, self.names, self.parent = ds, names, parent
        self.n = len(ds)
        self.chain = (parent.chain if parent else ()) + (self.uid,)
        dsf = []
        for i, d in enumerate(ds):
            dsf.append(math.sqrt(_float(d, i, dsf)))
        self.dsf = dsf

    @staticmethod
    def base():
        return Tower([], [], None)

    def extend(self, g, name):
        g = self(g)
        assert g.sign() > 0, f"radicand {name} not positive"
        return Tower(self.ds + [g.v], self.names + [name], self)

    def gen(self, i=None):
        """the generator sqrt(d_i) (default: the last)."""
        i = self.n if i is None else i
        x = (_z(i - 1), _lift(Fr(1), 0, i - 1)) if i > 0 else None
        return N(self, _lift(x, i, self.n))

    def __call__(self, x):
        if isinstance(x, N):
            return x.to(self)
        return N(self, _lift(Fr(x), 0, self.n))

    def is_ancestor_of(self, other):
        return other.chain[:len(self.chain)] == self.chain

    def __repr__(self):
        return "Q(" + ", ".join("sqrt " + nm for nm in self.names) + ")"


class N:
    """an element of a Tower."""
    __slots__ = ("T", "v")

    def __init__(self, T, v):
        self.T, self.v = T, v

    def to(self, T):
        if self.T is T:
            return self
        assert self.T.is_ancestor_of(T), "elements of unrelated towers"
        return N(T, _lift(self.v, self.T.n, T.n))

    def _co(self, o):
        if not isinstance(o, N):
            return self, N(self.T, _lift(Fr(o), 0, self.T.n))
        if o.T is self.T:
            return self, o
        if self.T.is_ancestor_of(o.T):
            return self.to(o.T), o
        return self, o.to(self.T)

    def __add__(s, o):
        a, b = s._co(o)
        return N(a.T, _add(a.v, b.v, a.T.n))
    __radd__ = __add__

    def __sub__(s, o):
        a, b = s._co(o)
        return N(a.T, _add(a.v, _neg(b.v, a.T.n), a.T.n))

    def __rsub__(s, o):
        return (-s) + o

    def __neg__(s):
        return N(s.T, _neg(s.v, s.T.n))

    def __mul__(s, o):
        if not isinstance(o, N):
            return N(s.T, _scal(s.v, Fr(o), s.T.n))
        a, b = s._co(o)
        return N(a.T, _mul(a.v, b.v, a.T.n, a.T.ds))
    __rmul__ = __mul__

    def inv(s):
        return N(s.T, _inv(s.v, s.T.n, s.T.ds))

    def __truediv__(s, o):
        if not isinstance(o, N):
            return N(s.T, _scal(s.v, 1 / Fr(o), s.T.n))
        a, b = s._co(o)
        return a * b.inv()

    def __rtruediv__(s, o):
        return s.inv() * o

    def sign(s):
        return _sgn(s.v, s.T.n, s.T.ds)

    def is0(s):
        return s.sign() == 0

    def __eq__(s, o):
        return (s - o).sign() == 0

    def __ne__(s, o):
        return not s.__eq__(o)

    def __lt__(s, o): return (s - o).sign() < 0
    def __le__(s, o): return (s - o).sign() <= 0
    def __gt__(s, o): return (s - o).sign() > 0
    def __ge__(s, o): return (s - o).sign() >= 0
    __hash__ = None

    def __float__(s):
        return _float(s.v, s.T.n, s.T.dsf)

    def __repr__(s):
        return f"{float(s):.9g}"


def sign_ab(a, b, D):
    """exact sign of a + b*sqrt(D), a, b, D tower elements, D >= 0."""
    sD = D.sign()
    assert sD >= 0
    sa, sb = a.sign(), (b.sign() if sD > 0 else 0)
    if sb == 0:
        return sa
    if sa == 0 or sa == sb:
        return sb if sa == 0 else sa
    t = (a * a - b * b * D).sign()
    return sa if t > 0 else (sb if t < 0 else 0)


def sqrt_lt(A, c):   # sqrt(A) < c
    return c.sign() > 0 and A < c * c


def sqrt_gt(A, c):   # sqrt(A) > c
    return c.sign() < 0 or A > c * c


def lt1(A, B):       # |sqrt A + B| < 1
    return sqrt_lt(A, 1 - B) and sqrt_gt(A, -1 - B)


def gt1(A, B):       # |sqrt A + B| > 1
    return sqrt_gt(A, 1 - B) or sqrt_lt(A, -1 - B)


def cand_float(A, B):
    return abs(math.sqrt(max(float(A), 0.0)) + float(B))


# ============================================================ vectors and pieces
def vsub(p, q): return (p[0] - q[0], p[1] - q[1])
def vadd(p, q): return (p[0] + q[0], p[1] + q[1])
def vmul(t, p): return (p[0] * t, p[1] * t)
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def cross(p, q): return p[0] * q[1] - p[1] * q[0]
def n2(p): return dot(p, p)
def perp(p): return (-p[1], p[0])
def veq(p, q): return (p[0] - q[0]).is0() and (p[1] - q[1]).is0()
def is0v(p): return p[0].is0() and p[1].is0()
def fpt(p): return (float(p[0]), float(p[1]))


class Seg:
    kind = "S"

    def __init__(s, P, Q):
        assert not veq(P, Q), "degenerate segment"
        s.P, s.Q = P, Q

    def ends(s):
        return (s.P, s.Q)

    def contains(s, X):
        v, w = vsub(s.Q, s.P), vsub(X, s.P)
        if not cross(v, w).is0():
            return False
        t = dot(w, v)
        return t.sign() >= 0 and t <= n2(v)

    def reversed(s):
        return Seg(s.Q, s.P)

    def __repr__(s):
        return f"Seg{fpt(s.P)}->{fpt(s.Q)}"


class Arc:
    kind = "A"

    def __init__(s, C, rho, S, E):
        s.C, s.rho, s.S, s.E = C, rho, S, E
        assert rho.sign() > 0, "radius not positive"
        assert n2(vsub(S, C)) == rho * rho, f"arc start off its circle: {fpt(S)} about {fpt(C)} rho {float(rho)}"
        assert n2(vsub(E, C)) == rho * rho, f"arc end off its circle: {fpt(E)} about {fpt(C)} rho {float(rho)}"
        assert cross(vsub(S, C), vsub(E, C)).sign() > 0, "arc must span strictly between 0 and 180 degrees counter-clockwise"

    def ends(s):
        return (s.S, s.E)

    def has_dir(s, w):
        """is C + rho*w/|w| on the closed arc?  (w a nonzero vector)"""
        a, e = vsub(s.S, s.C), vsub(s.E, s.C)
        if PLANT == "cw_arcs":                                   # planted: the clockwise (complementary) arc
            return cross(e, w).sign() >= 0 or cross(w, a).sign() >= 0
        return cross(a, w).sign() >= 0 and cross(w, e).sign() >= 0

    def dir_ab(s, a0, b0, a1, b1, D):
        """is the direction (a0 + b0 sqrt D, a1 + b1 sqrt D) on the closed arc?  exact."""
        a, e = vsub(s.S, s.C), vsub(s.E, s.C)
        c1 = sign_ab(a[0] * a1 - a[1] * a0, a[0] * b1 - a[1] * b0, D)       # cross(a, w)
        c2 = sign_ab(a0 * e[1] - a1 * e[0], b0 * e[1] - b1 * e[0], D)       # cross(w, e)
        if PLANT == "cw_arcs":
            c3 = sign_ab(e[0] * a1 - e[1] * a0, e[0] * b1 - e[1] * b0, D)
            c4 = sign_ab(a0 * a[1] - a1 * a[0], b0 * a[1] - b1 * a[0], D)
            return c3 >= 0 or c4 >= 0
        return c1 >= 0 and c2 >= 0

    def contains(s, X):
        w = vsub(X, s.C)
        return n2(w) == s.rho * s.rho and s.has_dir(w)

    def __repr__(s):
        return f"Arc(C{fpt(s.C)}, r{float(s.rho):.6f}, {fpt(s.S)}->{fpt(s.E)})"


# ============================================================ meeting (exact, no map hypothesis)
def meet(p1, p2):
    for X in p1.ends():
        if p2.contains(X):
            return True
    for X in p2.ends():
        if p1.contains(X):
            return True
    if p1.kind == "S" and p2.kind == "S":
        return _seg_seg_cross(p1, p2)
    if p1.kind == "S":
        return _seg_arc_meet(p1, p2)
    if p2.kind == "S":
        return _seg_arc_meet(p2, p1)
    return _arc_arc_meet(p1, p2)


def _seg_seg_cross(s, t):
    d1 = cross(vsub(s.Q, s.P), vsub(t.P, s.P)).sign()
    d2 = cross(vsub(s.Q, s.P), vsub(t.Q, s.P)).sign()
    d3 = cross(vsub(t.Q, t.P), vsub(s.P, t.P)).sign()
    d4 = cross(vsub(t.Q, t.P), vsub(s.Q, t.P)).sign()
    return d1 * d2 < 0 and d3 * d4 < 0          # touching cases are caught by the endpoint tests


def _seg_arc_meet(s, a):
    v = vsub(s.Q, s.P)
    w0 = vsub(s.P, a.C)
    L2, b = n2(v), dot(w0, v)
    Dl = b * b - L2 * (n2(w0) - a.rho * a.rho)
    if Dl.sign() < 0:
        return False
    for sg in (1, -1):
        # t * L2 = -b + sg sqrt(Dl); on the segment iff 0 <= t*L2 <= L2
        if sign_ab(-b, s_(sg, Dl), Dl) < 0 or sign_ab(L2 + b, s_(-sg, Dl), Dl) < 0:
            continue
        # direction from C, times L2:  L2*w0 + (t L2) v
        a0, b0 = L2 * w0[0] - b * v[0], v[0] * sg
        a1, b1 = L2 * w0[1] - b * v[1], v[1] * sg
        if a.dir_ab(a0, b0, a1, b1, Dl):
            return True
    return False


def s_(sg, D):
    return D.T(sg)


def _arc_arc_meet(a1, a2):
    w = vsub(a2.C, a1.C)
    D = n2(w)
    if D.is0():
        if not (a1.rho == a2.rho):
            return False
        return any(a2.has_dir(vsub(X, a2.C)) for X in a1.ends()) or any(a1.has_dir(vsub(X, a1.C)) for X in a2.ends())
    lam = (D + a1.rho * a1.rho - a2.rho * a2.rho) / (D * 2)
    mu2 = a1.rho * a1.rho / D - lam * lam
    if mu2.sign() < 0:
        return False
    wp = perp(w)
    for sg in (1, -1):
        # y - C1 = lam w + sg mu wp ;  y - C2 = (lam - 1) w + sg mu wp   (mu = sqrt(mu2))
        if a1.dir_ab(lam * w[0], wp[0] * sg, lam * w[1], wp[1] * sg, mu2) and \
                a2.dir_ab((lam - 1) * w[0], wp[0] * sg, (lam - 1) * w[1], wp[1] * sg, mu2):
            return True
    return False


# ============================================================ candidates |sqrt A + B|
def cands(p1, p2):
    T = p1.ends()[0][0].T
    zero = T(0)
    out = []
    for X in p1.ends():
        for Y in p2.ends():
            out.append((n2(vsub(X, Y)), zero))
    if PLANT == "endpoints_only":
        return out
    for (X, p) in [(X, p2) for X in p1.ends()] + [(Y, p1) for Y in p2.ends()]:
        if p.kind == "S":
            v = vsub(p.Q, p.P)
            t = dot(vsub(X, p.P), v)
            if t.sign() > 0 and t < n2(v):
                c = cross(vsub(X, p.P), v)
                out.append((c * c / n2(v), zero))
        else:
            w = vsub(X, p.C)
            if is0v(w):
                out.append((zero, p.rho))
                continue
            if p.has_dir(w):
                out.append((n2(w), -p.rho))
            if p.has_dir(vmul(-1, w)):
                out.append((n2(w), p.rho))
    if PLANT == "no_interior":
        return out
    if p1.kind != p2.kind:
        s, a = (p1, p2) if p1.kind == "S" else (p2, p1)
        v = vsub(s.Q, s.P)
        t = dot(vsub(a.C, s.P), v)
        if t.sign() >= 0 and t <= n2(v):
            nv = perp(v)
            h = dot(vsub(a.C, s.P), nv)
            A = h * h / n2(v)
            for sg in (1, -1):
                if a.has_dir(vmul(sg, nv)):
                    out.append((A, a.rho * (sg if h.sign() >= 0 else -sg)))
    elif p1.kind == "A":
        a1, a2 = p1, p2
        w = vsub(a2.C, a1.C)
        if is0v(w):
            dirs = [vsub(X, a1.C) for X in a1.ends() + a2.ends()]
            for v in dirs + [vmul(-1, x) for x in dirs]:
                if a1.has_dir(v) and a2.has_dir(v):
                    out.append((zero, a1.rho - a2.rho))
                if a1.has_dir(v) and a2.has_dir(vmul(-1, v)):
                    out.append((zero, a1.rho + a2.rho))
        else:
            D = n2(w)
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if a1.has_dir(vmul(s1, w)) and a2.has_dir(vmul(s2, w)):
                        out.append((D, a2.rho * s2 - a1.rho * s1))
    return out


# ============================================================ the pair verdict
class PairResult:
    __slots__ = ("verdict", "touch", "mcmp", "Mcmp", "mf", "Mf", "ncand")

    def __repr__(s):
        return f"{s.verdict} min{s.mcmp}1 max{s.Mcmp}1 ~[{s.mf:.6f}, {s.Mf:.6f}]"


def _cmp(lo, eq):
    return "<" if lo else ("=" if eq else ">")


def pair_verdict(T1, T2, self_pair=False):
    cs = [c for p1 in T1 for p2 in T2 for c in cands(p1, p2)]
    if self_pair:
        touch = True
    elif PLANT == "no_meet":
        touch = False
    else:
        touch = any(meet(p1, p2) for p1 in T1 for p2 in T2)
    r = PairResult()
    r.touch, r.ncand = touch, len(cs)
    any_lt = touch or any(lt1(*c) for c in cs)
    any_gt = any(gt1(*c) for c in cs)
    any_eq = any((not lt1(*c)) and (not gt1(*c)) for c in cs)
    fl = [cand_float(*c) for c in cs]
    r.mf = 0.0 if touch else min(fl)
    r.Mf = max(fl)
    r.mcmp = _cmp(any_lt, any_eq)                    # the exact minimum against 1
    r.Mcmp = ">" if any_gt else ("=" if any_eq else "<")   # the exact maximum against 1
    if PLANT == "closed_interval":
        rej = (any_lt or any_eq) and (any_gt or any_eq)
    else:
        rej = any_lt and any_gt
    r.verdict = "REJECT" if rej else "ACCEPT"
    return r


def colour_pairs(tiles):
    """every same-colour pair of a {name: (colour, pieces)} map, a tile with itself included."""
    names = sorted(tiles)
    return [(a, b) for a, b in combinations_with_replacement(names, 2) if tiles[a][0] == tiles[b][0]]


def check_object(tiles, pairs=None):
    """{name: (colour, pieces)} -> (rows, bad, n_present).  pairs default: generated from the colour map."""
    present = colour_pairs(tiles)
    pairs = present if pairs is None else pairs
    rows, bad = [], []
    for a, b in pairs:
        if a == b and PLANT == "noself":
            continue
        r = pair_verdict(tiles[a][1], tiles[b][1], self_pair=(a == b))
        rows.append((a, b, tiles[a][0], r))
        if r.verdict == "REJECT":
            bad.append((a, b))
    return rows, bad, len(present)


# ============================================================ self-test controls (exact)
def _t3():
    return Tower.base().extend(3, "3")


def _ratpt(t):
    """(1 - t^2, 2t)/(1 + t^2): a rational point of the unit circle."""
    t = Fr(t)
    return (Fr(1) - t * t) / (1 + t * t), 2 * t / (1 + t * t)


def crescent(C, r_out, r_in, u_left, u_right):
    """the region between the circles (C, r_out) and (C, r_in), from the unit direction u_right counter-clockwise to u_left (rational)."""
    ul, ur = u_left, u_right
    O = lambda u, r: (C[0] + r * u[0], C[1] + r * u[1])
    return [Arc(C, r_out, O(ur, r_out), O(ul, r_out)), Seg(O(ul, r_out), O(ul, r_in)),
            Arc(C, r_in, O(ur, r_in), O(ul, r_in)), Seg(O(ur, r_in), O(ur, r_out))]


def controls():
    T = _t3()
    q = T
    r3 = T.gen()
    P = lambda x, y: (q(x), q(y))
    poly = lambda *v: [Seg(v[i], v[(i + 1) % len(v)]) for i in range(len(v))]
    sq = lambda x0, y0, a: poly(P(x0, y0), P(x0 + a, y0), P(x0 + a, y0 + a), P(x0, y0 + a))
    one = q(1)
    A0, A1, A2 = P(0, 0), P(1, 0), (q(Fr(1, 2)), r3 / 2)
    reu = [Arc(A0, one, A1, A2), Arc(A1, one, A2, A0), Arc(A2, one, A0, A1)]
    sh = P(2, 0)
    reu2 = [Arc(vadd(A0, sh), one, vadd(A1, sh), vadd(A2, sh)), Arc(vadd(A1, sh), one, vadd(A2, sh), vadd(A0, sh)),
            Arc(vadd(A2, sh), one, vadd(A0, sh), vadd(A1, sh))]
    R = []
    # (name, tiles, pairs or None, want, the plants predicted to flip it)
    R.append(("Reuleaux triangle, width 1 (self)", {"T": (1, reu)}, None, "ACCEPT", {"closed_interval", "cw_arcs"}))
    R.append(("two Reuleaux, gap exactly 1", {"T": (1, reu), "U": (1, reu2)}, None, "ACCEPT", {"closed_interval", "cw_arcs"}))
    R.append(("square 7/10 (diagonal 0.99)", {"S": (1, sq(0, 0, Fr(7, 10)))}, None, "ACCEPT", set()))
    R.append(("square 3/4 (diagonal 1.06)", {"S": (1, sq(0, 0, Fr(3, 4)))}, None, "REJECT", {"noself"}))
    R.append(("two squares 1/2, gap 9/10", {"S": (1, sq(0, 0, Fr(1, 2))), "U": (1, sq(Fr(14, 10), 0, Fr(1, 2)))}, None,
              "REJECT", set()))
    # two caps facing each other, nearest pair interior to both arcs: circles of radius 1 centred (-1/2, 0) and (5/2 - 1/10 ... )
    # cap L: the arc of the circle centred (-3/5, 0), radius 1, through (2/5, 0), from (-3/5 + x1, -y1) to (-3/5 + x1, y1) with its chord;
    # cap R: its mirror about x = 2/5 + 9/20 (gap 9/10 between the arcs' tips); endpoints farther than 1 apart.
    c, s = _ratpt(Fr(1, 4))                                   # (15/17, 8/17): ~28.07 deg
    CL, CR = P(Fr(-3, 5), 0), P(Fr(-3, 5) + 2 * Fr(2, 5) + Fr(9, 10) + Fr(6, 5), 0)
    capL = [Arc(CL, one, P(Fr(-3, 5) + c, -s), P(Fr(-3, 5) + c, s)), Seg(P(Fr(-3, 5) + c, s), P(Fr(-3, 5) + c, -s))]
    xR = CR[0]
    capR = [Arc(CR, one, (xR - c, q(s)), (xR - c, q(-s))), Seg((xR - c, q(-s)), (xR - c, q(s)))]
    R.append(("two unit caps, nearest pair interior to both arcs", {"L": (1, capL), "R": (1, capR)}, [("L", "R")], "REJECT",
              {"endpoints_only", "no_interior", "cw_arcs"}))
    # a cap facing a bar: the nearest pair is the cap's tip (0.4, 0) against the bar's side x = 1.3 (distance 9/10), interior to both;
    # the bar spans |y| <= 7/10 so its corners are 1.0249 from the arc and the cap's ends 1.018 from its side (every other candidate > 1)
    bar = poly(P(Fr(13, 10), Fr(-7, 10)), P(Fr(27, 20), Fr(-7, 10)), P(Fr(27, 20), Fr(7, 10)), P(Fr(13, 10), Fr(7, 10)))
    R.append(("a cap facing a bar, nearest pair interior to arc and bar", {"L": (1, capL), "B": (1, bar)}, [("L", "B")], "REJECT",
              {"endpoints_only", "no_interior", "cw_arcs"}))
    # two long bars crossing (a map defect; cross pair only): every critical candidate >= 1.49, the true minimum 0
    h = Fr(1, 100)
    b1 = poly(P(Fr(-3, 2), -h), P(Fr(3, 2), -h), P(Fr(3, 2), h), P(Fr(-3, 2), h))
    b2 = poly(P(-h, Fr(-3, 2)), P(h, Fr(-3, 2)), P(h, Fr(3, 2)), P(-h, Fr(3, 2)))
    R.append(("two long bars crossing (cross pair only)", {"X": (1, b1), "Y": (1, b2)}, [("X", "Y")], "REJECT", {"no_meet"}))
    # a thin crescent (radii 2 and 99/50 about (0, -3/2), +-36.87 deg about the vertical, radial ends) crossed by a long thin bar:
    # the pieces meet only where the bar's sides cross the two ARCS; every critical candidate >= 1.13 (cross pair only)
    cr = crescent(P(0, Fr(-3, 2)), q(2), q(Fr(99, 50)), (Fr(-3, 5), Fr(4, 5)), (Fr(3, 5), Fr(4, 5)))
    thin = poly(P(Fr(-1, 20), Fr(-3, 2)), P(Fr(1, 20), Fr(-3, 2)), P(Fr(1, 20), Fr(5, 2)), P(Fr(-1, 20), Fr(5, 2)))
    R.append(("a crescent crossed by a long bar at its arcs (cross pair only)", {"X": (1, cr), "Y": (1, thin)}, [("X", "Y")], "REJECT",
              {"no_meet", "cw_arcs"}))
    # two thin crescents crossing at right angles: the second is the first turned 90 deg about (0, 49/100); they meet only arc-to-arc
    rot = lambda p: (-(p[1] - Fr(49, 100)), p[0] + Fr(49, 100))
    cr2 = [Arc(rot(x.C), x.rho, rot(x.S), rot(x.E)) if x.kind == "A" else Seg(rot(x.P), rot(x.Q)) for x in cr]
    R.append(("two crescents crossing arc to arc (cross pair only)", {"X": (1, cr), "Y": (1, cr2)}, [("X", "Y")], "REJECT",
              {"no_meet"}))
    # cw_arcs (registered after the first run showed flips where none had been registered -- an omission, logged): the complementary arcs
    # (> 180 deg) put antipodal points in each Reuleaux tile (REJECT) and remove the near pieces of the caps and crescent (ACCEPT); the two
    # crescents' complementary circles still meet near (2.0, -1.51), so that control stays REJECT.
    return R


def selftest():
    res = []
    for name, tiles, pairs, want, flips in controls():
        rows, bad, npres = check_object(tiles, pairs)
        got = "REJECT" if bad else "ACCEPT"
        expect = want if PLANT not in flips else ("ACCEPT" if want == "REJECT" else "REJECT")
        res.append((name, want, expect, got, rows))
    return res


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--kplant" in args:
        PLANT = args[args.index("--kplant") + 1]
    if "--selftest" in args:
        ok = True
        for name, want, expect, got, rows in selftest():
            flag = "ok" if got == expect else "MISMATCH"
            ok &= got == expect
            detail = "; ".join(f"{a}/{b} {r}" for a, b, c, r in rows)
            print(f"{flag:8s} {name:62s} faithful {want:6s} predicted-under-plant {expect:6s} got {got:6s} | {detail}")
        print("PLANT", PLANT, "ALL AS PREDICTED" if ok else "SOME MISMATCH")
        sys.exit(0 if ok else 1)
