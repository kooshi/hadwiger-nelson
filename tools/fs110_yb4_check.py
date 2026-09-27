#!/usr/bin/env python3
"""FS110-YB4's own exact checker for map fragments bounded by circular arcs and segments (blind; written before
looking at the construction side's checker).

The check (claims §4 test 6): for every pair of same-colour tiles, a tile with itself included, the exact range of
cross-distances over the closures, [m, M], must not have 1 in its interior: m >= 1 ("apart") or M <= 1 ("Siamese");
a tile with itself needs M <= 1 (diameter). For open connected tiles the range of distances between interior points
is the open interval (m, M), so this is exactly A-EXACT (no interior pair at distance exactly 1).

m and M are attained at critical pairs of the distance function on the product of the boundaries (or at a common
point, distance 0). Every such pair is enumerated: endpoint-endpoint, endpoint-piece (foot / radial points),
arc-arc on the line of centres (concentric arcs: radial pairs), arc-segment along the segment's normal through the
centre, and piece-piece intersections. Every candidate is a genuine point pair of the closures; min and max over the
candidates are therefore m and M exactly.

Arithmetic: numbers are exact in Q or in one quadratic field Q(sqrt d) (Fractions); anything else (a nested radical,
or two different quadratic fields meeting) falls back to a rigorous mpmath interval. A comparison with 1 is decided
exactly, or by interval separation, or reported AMBIGUOUS (never guessed). Equality with 1 is only ever asserted
exactly.

Faults can be planted through PLANT (a set of names) to watch the controls fire: 'no_self', 'no_vertex_arc',
'no_arc_arc', 'closed_interval', 'no_intersect'.
"""
from fractions import Fraction as Fr
from functools import lru_cache
import sympy
from mpmath import iv

iv.dps = 60
PLANT = set()
LOG = {'amb_member': 0, 'amb_cmp': 0}


@lru_cache(maxsize=None)
def _sqfree(n):
    s, d = 1, 1
    for p, e in sympy.factorint(n).items():
        s *= p ** (e // 2)
        if e % 2:
            d *= p
    return s, d


def _ivq(q):
    return iv.mpf(q.numerator) / iv.mpf(q.denominator)


class Num:
    """a + b*sqrt(d) exactly (d squarefree, d == 1 means rational with b == 0), or an interval only (a is None)."""
    __slots__ = ('a', 'b', 'd', 'i')

    def __init__(self, a=None, b=Fr(0), d=1, i=None):
        if a is not None:
            a, b = Fr(a), Fr(b)
            if b == 0:
                d = 1
            self.a, self.b, self.d = a, b, d
            self.i = _ivq(a) + (_ivq(b) * iv.sqrt(iv.mpf(d)) if d != 1 else 0)
        else:
            self.a, self.b, self.d, self.i = None, None, None, i

    @property
    def exact(self):
        return self.a is not None

    def _compat(self, o):
        return self.exact and o.exact and (self.d == 1 or o.d == 1 or self.d == o.d)

    def __add__(s, o):
        o = N(o)
        if s._compat(o):
            return Num(s.a + o.a, s.b + o.b, max(s.d, o.d))
        return Num(i=s.i + o.i)
    __radd__ = __add__

    def __neg__(s):
        return Num(-s.a, -s.b, s.d) if s.exact else Num(i=-s.i)

    def __sub__(s, o):
        return s + (-N(o))

    def __rsub__(s, o):
        return N(o) + (-s)

    def __mul__(s, o):
        o = N(o)
        if s._compat(o):
            d = max(s.d, o.d)
            return Num(s.a * o.a + s.b * o.b * d, s.a * o.b + s.b * o.a, d)
        return Num(i=s.i * o.i)
    __rmul__ = __mul__

    def __truediv__(s, o):
        o = N(o)
        if s._compat(o):
            den = o.a * o.a - o.b * o.b * o.d
            conj = Num(o.a / den, -o.b / den, o.d)
            return s * conj
        return Num(i=s.i / o.i)

    def sqrt(s):
        if s.exact and s.d == 1:
            if s.a == 0:
                return Num(0)
            if s.a < 0:
                raise ValueError('sqrt of negative')
            n = s.a.numerator * s.a.denominator
            if n < 10 ** 60:
                q, d = _sqfree(n)
                return Num(0, Fr(q, s.a.denominator), d) if d != 1 else Num(Fr(q, s.a.denominator))
        lo = s.i.a
        x = s.i if lo >= 0 else iv.mpf([0, s.i.b])
        return Num(i=iv.sqrt(x))

    def sign(self):
        if self.exact:
            a, b, d = self.a, self.b, self.d
            if b == 0:
                return (a > 0) - (a < 0)
            sa, sb = (a > 0) - (a < 0), (b > 0) - (b < 0)
            if sa == 0:
                return sb
            if sa == sb:
                return sa
            return sa if a * a > b * b * d else sb
        if self.i.a > 0:
            return 1
        if self.i.b < 0:
            return -1
        return None

    def f(self):
        return float(self.i.mid)

    def __repr__(self):
        if self.exact:
            return f'{self.a}' if self.d == 1 else f'({self.a})+({self.b})*sqrt({self.d})'
        return f'~{self.f():.12g}'


def N(x):
    return x if isinstance(x, Num) else Num(x)


def sgn(x):
    return N(x).sign()


# ---------------------------------------------------------------- geometry
class P:
    __slots__ = ('x', 'y')

    def __init__(self, x, y):
        self.x, self.y = N(x), N(y)

    def __add__(s, o):
        return P(s.x + o.x, s.y + o.y)

    def __sub__(s, o):
        return P(s.x - o.x, s.y - o.y)

    def __mul__(s, k):
        return P(s.x * k, s.y * k)

    def fl(self):
        return (self.x.f(), self.y.f())

    def __repr__(self):
        return f'({self.x.f():.6f},{self.y.f():.6f})'


def dot(u, w):
    return u.x * w.x + u.y * w.y


def cross(u, w):
    return u.x * w.y - u.y * w.x


def d2(p, q):
    r = p - q
    return dot(r, r)


def same_point(p, q):
    return sgn(p.x - q.x) == 0 and sgn(p.y - q.y) == 0


class Seg:
    def __init__(self, A, B):
        self.A, self.B = A, B

    def ends(self):
        return [self.A, self.B]


class Arc:
    """The arc of the circle (C, R) run counter-clockwise from S to E (S, E on the circle; S != E)."""

    def __init__(self, C, R, S, E):
        self.C, self.R, self.S, self.E = C, N(R), S, E
        for X in (S, E):
            e = sgn(d2(X, C) - self.R * self.R)
            assert e == 0 or e is None and abs((d2(X, C) - self.R * self.R).f()) < 1e-40, 'arc endpoint off circle'

    def ends(self):
        return [self.S, self.E]


def _half(u, w):
    c = sgn(cross(u, w))
    if c is None:
        return None
    if c > 0:
        return 0
    if c < 0:
        return 1
    t = sgn(dot(u, w))
    return None if t is None else (0 if t > 0 else 1)


def _angle_le(u, w1, w2):
    """angle(u->w1) <= angle(u->w2), angles counter-clockwise in [0, 2 pi)."""
    h1, h2 = _half(u, w1), _half(u, w2)
    if h1 is None or h2 is None:
        return None
    if h1 != h2:
        return h1 < h2
    c = sgn(cross(w1, w2))
    return None if c is None else c >= 0


def on_arc(arc, X):
    """X is on arc's circle; is it on the arc?  None if undecided (X within rounding of an endpoint)."""
    if same_point(X, arc.S) or same_point(X, arc.E):
        return True
    return _angle_le(arc.S - arc.C, X - arc.C, arc.E - arc.C)


def _ang(u):
    from mpmath import mp, atan2, pi
    mp.dps = 60
    a = atan2(u.y.i.mid, u.x.i.mid)
    return a if a >= 0 else a + 2 * pi


def _member(arc, X):
    m = on_arc(arc, X)
    if m is not None:
        return m
    # a sign was undecided by the exact/interval test: an exact collinearity computed through intervals.  Decide by
    # angles at 60 digits when X is at least 1e-30 (in angle) from both endpoints; otherwise X is the endpoint to 30
    # digits and the endpoint candidate covers it.
    from mpmath import mp, pi
    mp.dps = 60
    tS = _ang(arc.S - arc.C)
    tX = (_ang(X - arc.C) - tS) % (2 * pi)
    tE = (_ang(arc.E - arc.C) - tS) % (2 * pi)
    near = min(tX, 2 * pi - tX, abs(tX - tE))
    if near > mp.mpf('1e-30'):
        LOG['amb_member_angle'] = LOG.get('amb_member_angle', 0) + 1
        return tX <= tE
    LOG['amb_member'] += 1
    LOG['amb_gap_max'] = max(LOG.get('amb_gap_max', 0), float(near))
    return False


class Tile:
    def __init__(self, name, colour, pieces):
        self.name, self.colour, self.pieces = name, colour, pieces

    def ends(self):
        out = []
        for pc in self.pieces:
            for e in pc.ends():
                if not any(same_point(e, o) for o in out):
                    out.append(e)
        return out


# ---------------------------------------------------------------- critical candidates
def _vertex_piece(p, pc, out, tag):
    if isinstance(pc, Seg):
        dv = pc.B - pc.A
        tau = dot(p - pc.A, dv) / dot(dv, dv)
        s0, s1 = sgn(tau), sgn(tau - 1)
        if s0 is None or s1 is None:
            LOG['amb_member'] += 1
            LOG['amb_tau_max'] = max(LOG.get('amb_tau_max', 0), float(min(abs(tau.i).b, abs(tau.i - 1).b)))
            return
        if s0 >= 0 and s1 <= 0:
            F = pc.A + dv * tau
            out.append((d2(p, F), tag + ':v-seg', p, F))
        return
    if 'no_vertex_arc' in PLANT:
        return
    w = p - pc.C
    n2 = dot(w, w)
    if sgn(n2) == 0:
        out.append((pc.R * pc.R, tag + ':centre-arc', p, pc.S))
        return
    nw = n2.sqrt()
    for s in (1, -1):
        X = pc.C + w * (pc.R * s / nw)
        if _member(pc, X):
            dd = nw - pc.R * s
            out.append((dd * dd, tag + ':v-arc', p, X))


def _piece_piece(p1, p2, out):
    if isinstance(p1, Seg) and isinstance(p2, Seg):
        return
    if isinstance(p1, Seg):
        p1, p2 = p2, p1
    if isinstance(p2, Arc):
        if 'no_arc_arc' in PLANT:
            return
        e = p2.C - p1.C
        L2 = dot(e, e)
        if sgn(L2) == 0:                     # concentric: radial pairs
            R1, R2 = p1.R, p2.R
            for sgn2, val in ((1, R1 - R2), (-1, R1 + R2)):
                X2 = p1.C + (p2.S - p2.C) * (R1 / R2 * sgn2)
                X1 = p2.C + (p1.S - p1.C) * (R2 / R1 * sgn2)
                if _member(p1, X2) or _member(p2, X1):
                    out.append((val * val, 'arc-arc:concentric', X2, p2.S))
            return
        L = L2.sqrt()
        u = e * (Num(1) / L)
        for s1 in (1, -1):
            X1 = p1.C + u * (p1.R * s1)
            if not _member(p1, X1):
                continue
            for s2 in (1, -1):
                X2 = p2.C + u * (p2.R * s2)
                if _member(p2, X2):
                    dd = L + p2.R * s2 - p1.R * s1
                    out.append((dd * dd, 'arc-arc:centres', X1, X2))
        return
    # arc p1, segment p2: arc points along the segment's normal through the centre
    dv = p2.B - p2.A
    ln = dot(dv, dv).sqrt()
    nrm = P(-dv.y / ln, dv.x / ln)
    for s in (1, -1):
        X = p1.C + nrm * (p1.R * s)
        if not _member(p1, X):
            continue
        tau = dot(X - p2.A, dv) / dot(dv, dv)
        s0, s1 = sgn(tau), sgn(tau - 1)
        if s0 is None or s1 is None:
            LOG['amb_member'] += 1
            continue
        if s0 >= 0 and s1 <= 0:
            F = p2.A + dv * tau
            out.append((d2(X, F), 'arc-seg:normal', X, F))


def _line_circle(A, B, C, R):
    dv = B - A
    w = A - C
    a = dot(dv, dv)
    b = dot(w, dv)
    c = dot(w, w) - R * R
    disc = b * b - a * c
    sd = sgn(disc)
    if sd is None or sd < 0:
        return []
    r = disc.sqrt()
    return [((-b + s * r) / a) for s in (1, -1)]


def _intersections(p1, p2):
    """closure points common to two pieces (only existence matters: a candidate at distance 0)."""
    if 'no_intersect' in PLANT:
        return False
    if isinstance(p1, Seg) and isinstance(p2, Seg):
        A, B, Cc, D = p1.A, p1.B, p2.A, p2.B
        o1, o2 = sgn(cross(B - A, Cc - A)), sgn(cross(B - A, D - A))
        o3, o4 = sgn(cross(D - Cc, A - Cc)), sgn(cross(D - Cc, B - Cc))
        if None in (o1, o2, o3, o4):
            return None
        if o1 * o2 < 0 and o3 * o4 < 0:
            return True
        for (X, Y, Z, o) in ((A, B, Cc, o1), (A, B, D, o2), (Cc, D, A, o3), (Cc, D, B, o4)):
            if o == 0:
                t = dot(Z - X, Y - X)
                if sgn(t) >= 0 and sgn(t - dot(Y - X, Y - X)) <= 0:
                    return True
        return False
    if isinstance(p1, Seg):
        p1, p2 = p2, p1
    if isinstance(p2, Seg):
        for tau in _line_circle(p2.A, p2.B, p1.C, p1.R):
            s0, s1 = sgn(tau), sgn(tau - 1)
            if s0 is None or s1 is None:
                return None
            if s0 >= 0 and s1 <= 0:
                X = p2.A + (p2.B - p2.A) * tau
                if on_arc(p1, X):
                    return True
        return False
    # arc-arc
    e = p2.C - p1.C
    L2 = dot(e, e)
    if sgn(L2) == 0:
        if sgn(p1.R - p2.R) != 0:
            return False
        return bool(on_arc(p1, p2.S) or on_arc(p1, p2.E) or on_arc(p2, p1.S))
    a = (L2 + p1.R * p1.R - p2.R * p2.R) / (L2 * 2)
    h2 = p1.R * p1.R - a * a * L2
    sh = sgn(h2)
    if sh is None or sh < 0:
        return sh is None and None
    h = (h2 / L2).sqrt()
    M = p1.C + e * a
    perp = P(-e.y, e.x)
    for s in (1, -1):
        X = M + perp * (h * s)
        if on_arc(p1, X) and on_arc(p2, X):
            return True
    return False


def candidates(A, B):
    self_pair = A is B
    out = []
    EA, EB = A.ends(), B.ends()
    for p in EA:
        for q in EB:
            out.append((d2(p, q), 'v-v', p, q))
    for p in EA:
        for pc in B.pieces:
            _vertex_piece(p, pc, out, 'A')
    if not self_pair:
        for q in EB:
            for pc in A.pieces:
                _vertex_piece(q, pc, out, 'B')
    for p1 in A.pieces:
        for p2 in B.pieces:
            _piece_piece(p1, p2, out)
    touch = False
    if not self_pair:
        for p1 in A.pieces:
            for p2 in B.pieces:
                r = _intersections(p1, p2)
                if r:
                    touch = True
                elif r is None:
                    LOG['amb_member'] += 1
    if touch:
        out.append((Num(0), 'touch', None, None))
    return out


def check_pair(A, B):
    """Verdict for the same-colour pair (A, B) (A is B for a tile with itself)."""
    cs = candidates(A, B)
    lt, eq, gt, amb = [], [], [], []
    for c in cs:
        s = sgn(c[0] - 1)
        (amb if s is None else lt if s < 0 else eq if s == 0 else gt).append(c)
    if amb:
        LOG['amb_cmp'] += len(amb)
    lo = min(cs, key=lambda c: c[0].i.a)
    hi = max(cs, key=lambda c: c[0].i.b)
    if A is B:
        if 'no_self' in PLANT:
            return dict(verdict='OK', kind='self(unchecked)', tight=[], lo=lo, hi=hi, n=len(cs))
        v = 'REJECT' if gt else ('AMBIG' if amb else 'OK')
        return dict(verdict=v, kind='self', tight=eq, lo=lo, hi=hi, n=len(cs))
    if lt and gt:
        v, kind = 'REJECT', 'straddle'
    elif amb:
        v, kind = 'AMBIG', '?'
    elif not lt:
        v, kind = 'OK', 'apart'
    else:
        v, kind = 'OK', 'siamese'
    if 'closed_interval' in PLANT and v == 'OK' and eq:
        v, kind = 'REJECT', 'closed_interval_plant'
    return dict(verdict=v, kind=kind, tight=eq if v == 'OK' else [], lo=lo, hi=hi, n=len(cs))


def same_colour_pairs(tiles):
    out = []
    for i, A in enumerate(tiles):
        for B in tiles[i:]:
            if A.colour == B.colour:
                out.append((A, B))
    return out


def check_fragment(tiles, verbose=False):
    names = [t.name for t in tiles]
    assert len(set(names)) == len(names), 'duplicate tile names'
    res = []
    for A, B in same_colour_pairs(tiles):
        r = check_pair(A, B)
        r['pair'] = (A.name, B.name)
        res.append(r)
    rej = [r['pair'] for r in res if r['verdict'] == 'REJECT']
    amb = [r['pair'] for r in res if r['verdict'] == 'AMBIG']
    tight = []
    for r in res:
        pts = []
        for c in r['tight']:
            key = (c[1].split(':')[-1],) + (tuple(round(v, 9) for v in c[2].fl()) if c[2] is not None else ()) + \
                  (tuple(round(v, 9) for v in c[3].fl()) if c[3] is not None else ())
            if key not in pts:
                pts.append(key)
        if pts:
            tight.append((r['pair'], pts))
    verdict = 'REJECT' if rej else ('AMBIG' if amb else 'ACCEPT')
    return dict(verdict=verdict, pairs=len(res), reject=rej, ambig=amb, tight=tight, results=res)
