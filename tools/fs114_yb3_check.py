#!/usr/bin/env python3
"""FS114-YB3's checker for fragments bounded by segments and circular arcs (written for this job; no FS114-Y4 file read; no other job's
distance or sign code borrowed -- FS-112's and FS114-YB2's builders are imported only to convert their held objects, in `fs114_yb3_run.py`).

A DIFFERENT METHOD FROM FS114-YB2's tower signs, on purpose (independence).  Every number is an `R`: an exact sympy expression paired with a
rigorous mpmath interval (`iv`, 400 bits).  A sign is read from the interval when it excludes 0; when it does not, the exact expression is tested
for zero by its minimal polynomial over Q (sympy's `minimal_polynomial`, a decision, not a heuristic): the polynomial `x` means exactly 0, anything
else means "nonzero but closer than the interval can see", which raises `Undecided` -- loudly, never read as a verdict.

GEOMETRY.  A tile is a list of pieces forming its closed boundary: `Seg(P, Q)` or `Arc(C, rho, S, E)` (the arc about C of radius rho from S
counter-clockwise to E, spanning (0, 180] degrees; `fwd` records the traversal direction).  VERDICT for two tiles of one colour (a tile with itself
included): REJECT iff min < 1 < max, min and max the least and greatest distances between the two closed tiles, from the complete list of
critical pairs of |x - y|^2 on piece x piece -- endpoint pairs; an endpoint against a segment's foot, or against the two points of an arc's circle
on the line through its centre; a segment's foot of an arc's centre against the arc's two points on that normal; two arcs on their line of
centres (concentric: common or opposite directions) -- plus exact crossing tests.  Each candidate distance is |sqrt(D) + k| (D >= 0), compared
with 1 exactly.  Distinct tiles are assumed to have disjoint interiors.  NON-SIAMESE for distinct tiles: min >= 1.

CHECKER PLANTS (each fires only through its own code path): `noself`, `closed` (REJECT iff min <= 1 <= max), `nocross`, `endsonly`,
`nointerior`, `tieup` (an interval that cannot see the sign reads +1 with no exact test: a tie at 1 then reads as "above 1").
"""
from __future__ import annotations
import sympy as sp
from mpmath import iv

iv.prec = 400
PLANT = set()
_X = sp.Symbol("x")
STATS = {"exact_zero_tests": 0}


class Undecided(ArithmeticError):
    pass


def _iv_of(e):
    """a rigorous interval for a sympy expression built from rationals, +, *, integer powers and square roots."""
    if e.is_Rational:
        return iv.mpf(int(e.p)) / iv.mpf(int(e.q))
    if e.is_Add:
        s = iv.mpf(0)
        for a in e.args:
            s = s + _iv_of(a)
        return s
    if e.is_Mul:
        s = iv.mpf(1)
        for a in e.args:
            s = s * _iv_of(a)
        return s
    if e.is_Pow:
        b, x = e.args
        if x == sp.Rational(1, 2):
            return iv.sqrt(_iv_of(b))
        if x == sp.Rational(-1, 2):
            return 1 / iv.sqrt(_iv_of(b))
        if x.is_Integer:
            return _iv_of(b) ** int(x)
        if x.is_Rational and x.q == 2:
            return iv.sqrt(_iv_of(b)) ** int(x.p)
    raise ValueError(f"cannot bound {e}")


class R:
    __slots__ = ("e", "i")

    def __init__(self, e, i=None):
        self.e = sp.sympify(e) if not isinstance(e, sp.Basic) else e
        self.i = _iv_of(self.e) if i is None else i

    @staticmethod
    def of(x):
        return x if isinstance(x, R) else R(sp.sympify(x) if not isinstance(x, sp.Basic) else x)

    def __add__(a, b):
        b = R.of(b)
        return R(a.e + b.e, a.i + b.i)

    __radd__ = __add__

    def __sub__(a, b):
        b = R.of(b)
        return R(a.e - b.e, a.i - b.i)

    def __rsub__(a, b):
        return R.of(b) - a

    def __mul__(a, b):
        b = R.of(b)
        return R(a.e * b.e, a.i * b.i)

    __rmul__ = __mul__

    def __truediv__(a, b):
        b = R.of(b)
        if b.sign() == 0:
            raise ZeroDivisionError
        return R(a.e / b.e, a.i / b.i)

    def __neg__(a):
        return R(-a.e, -a.i)

    def sqrt(a):
        s = a.sign()
        if s < 0:
            raise ValueError("sqrt of a negative")
        if s == 0:
            return R(sp.Integer(0), iv.mpf(0))
        lo = a.i.a if a.i.a > 0 else iv.mpf(0).a
        return R(sp.sqrt(a.e), iv.sqrt(iv.mpf([lo, a.i.b])))

    def sign(a):
        if a.i.a > 0:
            return 1
        if a.i.b < 0:
            return -1
        STATS["exact_zero_tests"] += 1
        mp = sp.minimal_polynomial(a.e, _X)
        if sp.Poly(mp, _X) == sp.Poly(_X, _X):
            return 0
        raise Undecided(f"nonzero value inside the interval: {a.e} ~ {a.i}")

    def __float__(a):
        return float(a.i.mid)


def P(x, y):
    return (R.of(x), R.of(y))


def sub(p, q): return (p[0] - q[0], p[1] - q[1])
def add(p, q): return (p[0] + q[0], p[1] + q[1])
def smul(t, p): return (p[0] * t, p[1] * t)
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def crs(p, q): return p[0] * q[1] - p[1] * q[0]
def nn(p): return dot(p, p)
def perp(p): return (-p[1], p[0])
def same(p, q): return (p[0] - q[0]).sign() == 0 and (p[1] - q[1]).sign() == 0
def fp(p): return f"({float(p[0]):.5f}, {float(p[1]):.5f})"


class Seg:
    kind = "S"

    def __init__(s, P0, Q0):
        s.P, s.Q = P0, Q0
        assert not same(P0, Q0), "degenerate segment"
        s.fwd = True

    def ends(s): return (s.P, s.Q)
    def __repr__(s): return f"Seg{fp(s.P)}->{fp(s.Q)}"


class Arc:
    kind = "A"

    def __init__(s, C, rho, S, E, fwd=True):
        s.C, s.rho, s.S, s.E, s.fwd = C, R.of(rho), S, E, fwd
        assert s.rho.sign() > 0
        assert (nn(sub(S, C)) - s.rho * s.rho).sign() == 0, f"arc start off its circle {fp(S)}"
        assert (nn(sub(E, C)) - s.rho * s.rho).sign() == 0, f"arc end off its circle {fp(E)}"
        u, v = sub(S, C), sub(E, C)
        c = crs(u, v).sign()
        assert c > 0 or (c == 0 and dot(u, v).sign() < 0), "arc must span (0, 180] degrees counter-clockwise"

    def ends(s): return (s.S, s.E)

    def has(s, w):
        """direction w (nonzero vector) within the closed span."""
        u, v = sub(s.S, s.C), sub(s.E, s.C)
        return crs(u, w).sign() >= 0 and crs(w, v).sign() >= 0

    def __repr__(s): return f"Arc[C{fp(s.C)} r{float(s.rho):.4f} {fp(s.S)}->{fp(s.E)}]"


def arc(C, rho, X, Y, ccw=True):
    """the arc traversed from X to Y about C, counter-clockwise or clockwise; stored counter-clockwise, direction in `fwd`."""
    return Arc(C, rho, X, Y, True) if ccw else Arc(C, rho, Y, X, False)


def dse(pc):
    """(start, end) in traversal order."""
    if pc.kind == "S" or pc.fwd:
        return pc.ends()
    return (pc.E, pc.S)


# ------------------------------------------------------------------ candidates: (D, k) meaning the distance |sqrt(D) + k|
ZERO = R.of(0)


def _pt_seg(x, sg, out, interior=True):
    out.append((nn(sub(x, sg.P)), ZERO))
    out.append((nn(sub(x, sg.Q)), ZERO))
    if not interior:
        return
    d = sub(sg.Q, sg.P)
    t = dot(sub(x, sg.P), d)
    if t.sign() > 0 and (t - nn(d)).sign() < 0:
        c = crs(d, sub(x, sg.P))
        out.append((c * c / nn(d), ZERO))


def _pt_arc(x, a, out, interior=True):
    out.append((nn(sub(x, a.S)), ZERO))
    out.append((nn(sub(x, a.E)), ZERO))
    if not interior:
        return
    w = sub(x, a.C)
    D = nn(w)
    if D.sign() == 0:
        out.append((ZERO, a.rho))
        return
    if a.has(w):
        out.append((D, -a.rho))
    if a.has((-w[0], -w[1])):
        out.append((D, a.rho))


def _pt_piece(x, pc, out, interior=True):
    (_pt_seg if pc.kind == "S" else _pt_arc)(x, pc, out, interior)


def _cross_seg_seg(s, t):
    d1, d2 = sub(s.Q, s.P), sub(t.Q, t.P)
    den = crs(d1, d2)
    if den.sign() == 0:
        return False
    w = sub(t.P, s.P)
    u = crs(w, d2) / den
    v = crs(w, d1) / den
    return u.sign() >= 0 and (u - 1).sign() <= 0 and v.sign() >= 0 and (v - 1).sign() <= 0


def _cross_seg_arc(s, a):
    d = sub(s.Q, s.P)
    w = sub(s.P, a.C)
    A, B, Cc = nn(d), dot(d, w) * 2, nn(w) - a.rho * a.rho
    disc = B * B - A * Cc * 4
    if disc.sign() < 0:
        return False
    r = disc.sqrt()
    for t in ((-B - r) / (A * 2), (-B + r) / (A * 2)):
        if t.sign() >= 0 and (t - 1).sign() <= 0 and a.has(add(w, smul(t, d))):
            return True
    return False


def _cross_arc_arc(a, b):
    v = sub(b.C, a.C)
    D2 = nn(v)
    if D2.sign() == 0:
        return False
    x = (D2 + a.rho * a.rho - b.rho * b.rho) / (D2 * 2)
    h2 = a.rho * a.rho / D2 - x * x
    if h2.sign() < 0:
        return False
    y = h2.sqrt()
    for sg in (1, -1):
        off = add(smul(x, v), smul(y * sg, perp(v)))      # point - a.C
        if a.has(off) and b.has(sub(add(a.C, off), b.C)):
            return True
    return False


def _crosses(p, q):
    if p.kind == "S" and q.kind == "S":
        return _cross_seg_seg(p, q)
    if p.kind == "S":
        return _cross_seg_arc(p, q)
    if q.kind == "S":
        return _cross_seg_arc(q, p)
    return _cross_arc_arc(p, q)


def cands(p, q):
    """candidate distances between two pieces (the pieces may be the same object)."""
    out = []
    endsonly = "endsonly" in PLANT
    interior = "nointerior" not in PLANT and not endsonly
    for x in p.ends():
        _pt_piece(x, q, out, interior=not endsonly)
    for x in q.ends():
        _pt_piece(x, p, out, interior=not endsonly)
    if not interior:
        return out
    if p.kind == "A" and q.kind == "A":
        v = sub(q.C, p.C)
        D = nn(v)
        if D.sign() == 0:
            # concentric: common directions give |rho_p - rho_q|, opposite ones rho_p + rho_q
            for w, k in _concentric_dirs(p, q):
                out.append((ZERO, k))
        else:
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if p.has(smul(R.of(s1), v)) and q.has(smul(R.of(s2), v)):
                        out.append((D, q.rho * s2 - p.rho * s1))
    elif p.kind != q.kind:
        sg, a = (p, q) if p.kind == "S" else (q, p)
        d = sub(sg.Q, sg.P)
        t = dot(sub(a.C, sg.P), d) / nn(d)
        if t.sign() > 0 and (t - 1).sign() < 0:
            F = add(sg.P, smul(t, d))
            w = sub(F, a.C)
            Dw = nn(w)
            if Dw.sign() == 0:
                out.append((ZERO, a.rho))
            else:
                if a.has(w):
                    out.append((Dw, -a.rho))
                if a.has((-w[0], -w[1])):
                    out.append((Dw, a.rho))
    return out


def _concentric_dirs(p, q):
    res = []
    for w in (sub(p.S, p.C), sub(p.E, p.C), sub(q.S, q.C), sub(q.E, q.C)):
        if p.has(w) and q.has(w):
            res.append((w, p.rho - q.rho))
        mw = (-w[0], -w[1])
        if p.has(w) and q.has(mw):
            res.append((w, p.rho + q.rho))
        if p.has(mw) and q.has(w):
            res.append((mw, p.rho + q.rho))
    return res


def cmp1(D, k):
    """sign(|sqrt(D) + k| - 1), exactly."""
    v = D.sqrt() + k if D.sign() > 0 else k
    m = (v * v - 1)
    if "tieup" in PLANT and not (m.i.a > 0 or m.i.b < 0):
        return 1        # planted: a tie the interval cannot see reads "above 1", no exact test
    return m.sign()


def minmax(A, B, same_tile):
    """(min_lt1, max_gt1, tight): is min < 1, is max > 1, and whether some candidate is exactly 1."""
    lt, gt, tight = False, False, False
    crossed = False
    for p in A:
        for q in B:
            if not same_tile and "nocross" not in PLANT and _crosses(p, q):
                crossed = True
            for D, k in cands(p, q):
                c = cmp1(D, k)
                if c < 0:
                    lt = True
                elif c > 0:
                    gt = True
                else:
                    tight = True
    if same_tile or crossed:
        lt = True        # min is 0
    return lt, gt, tight


def verdict(A, B, same_tile):
    lt, gt, tight = minmax(A, B, same_tile)
    if "noself" in PLANT and same_tile:
        return "ACCEPT", lt, gt, tight
    if "closed" in PLANT:
        rej = (lt or tight) and (gt or tight)
    else:
        rej = lt and gt
    return ("REJECT" if rej else "ACCEPT"), lt, gt, tight


def check(tiles, pairs=None, log=print):
    """tiles: name -> (colour, pieces).  Returns (rejected pairs, examined, tight pairs, non-Siamese failures)."""
    names = sorted(tiles)
    if pairs is None:
        pairs = [(a, b) for i, a in enumerate(names) for b in names[i:] if tiles[a][0] == tiles[b][0]]
    rej, tight, nsf = [], [], []
    for a, b in sorted(pairs):
        v, lt, gt, t = verdict(tiles[a][1], tiles[b][1], a == b)
        if v == "REJECT":
            rej.append((a, b))
            log(f"  REJECT {a} {b}")
        if t:
            tight.append((a, b))
        if a != b and lt:
            nsf.append((a, b))
    return rej, len(pairs), tight, nsf


# ------------------------------------------------------------------ sectors at a vertex
def tangent_out(pc, at_start=True):
    """the unit-free tangent of a piece in traversal direction, at its start (or at its end)."""
    st, en = dse(pc)
    if pc.kind == "S":
        return sub(en, st)
    X = st if at_start else en
    r = sub(X, pc.C)
    t = perp(r)
    return t if pc.fwd else (-t[0], -t[1])


def sectors_at(v, tiles):
    """for each tile whose boundary passes through v: (name, colour, leaving direction, arriving-reversed direction) -- the tile's sector at v
    runs counter-clockwise from the first to the second (boundaries counter-clockwise).  A tile passing v twice is listed twice."""
    out = []
    for nm, (col, ps) in tiles.items():
        m = len(ps)
        for i, pc in enumerate(ps):
            st, en = dse(pc)
            if same(st, v):
                prev = ps[(i - 1) % m]
                ti = tangent_out(prev, at_start=False)
                out.append((nm, col, tangent_out(pc, at_start=True), (-ti[0], -ti[1])))
    return out


def ang(w):
    import math
    return math.degrees(math.atan2(float(w[1]), float(w[0]))) % 360.0
