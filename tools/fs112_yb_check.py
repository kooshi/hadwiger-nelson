#!/usr/bin/env python3
"""FS112-YB's exact same-colour distance checker for maps bounded by segments and circular arcs (killing test 2 of data/fs112/claims.md §8).

Written by job FS112-YB (the blind verifier of FS-112's construction side) without reading the construction side's checker
(tools/fs112_y_*). The frozen FS-110 checkers were read (as the brief requires) and are used only as calibration targets.

THE CHECK. For two closed tiles A, B of one colour (A is B allowed), the set of cross-distances {|p - q| : p in A, q in B} is the interval
[m, M] (A x B is connected). The tile interiors are open, connected and dense in the closures, so the interior cross-distances fill the
OPEN interval (m, M) (for A = B, [0, M) with M the diameter). Hence "no two interior points of one colour at distance exactly 1" holds for
the pair iff 1 is not in (m, M):  REJECT  iff  m < 1 < M.  For A = B this is  M > 1  (diameter above 1).

WHERE m AND M ARE ATTAINED. M is attained at a pair of boundary points (|p - q| is convex in each point). m is 0 if the closures meet, and
otherwise attained at boundary points (a map's distinct tiles have disjoint interiors; containment is excluded by that hypothesis). At an
extreme pair (p, q) of the product of two boundary pieces (each a compact segment or circular arc), each point is a piece endpoint or a
critical point of the distance on its piece: q - p is normal to the piece at that point. The candidate list below holds every such pair:
  VV   endpoint - endpoint;
  VP   endpoint X - interior point of a piece: the foot of X on a segment; on an arc about C, the points C +- r(X - C)/|X - C|
       (X = C: every arc point is at distance r);
  SA   segment interior - arc interior: q - p normal to the segment and radial for the arc, so the line through C perpendicular to the
       segment: p the foot F of C, q = C +- r (F - C)/|F - C| (F = C: q = C +- r n, n the segment normal);
  AA   arc interior - arc interior, centres distinct: both points on the line of centres, four sign choices; concentric: radial pairs, distance
       |r1 - r2| (a common direction) or r1 + r2 (opposite directions), taken whenever such directions exist (two angular intervals meet iff
       one holds an endpoint of the other);
  SS   segment interior - segment interior: q - p normal to both, so the segments are parallel and the distance is constant along the
       family of normal pairs, whose end is a VP pair: dominated, not listed.
Each candidate is a realised pair of closure points (the direction conditions are checked exactly), so min and max over the candidates are m
and M EXACTLY, once the meeting test (below) supplies m = 0.
MEETING TEST (no map hypothesis): exact segment-segment, segment-arc and arc-arc intersection tests; two distinct tiles touch iff two of their
pieces meet.

ARITHMETIC. Numbers lie in a multiquadratic field Q(sqrt p : p in PRIMES), stored exactly (Fractions on the basis of square-free products).
A sign is decided by rational interval bounds on the square roots (integer isqrt), refined until the interval excludes 0; a nonzero element
of the field is a nonzero real, so this terminates, and zero is decided exactly (all coefficients zero). Critical points bring one more
square root: every candidate distance is |sqrt(A) + B| with A >= 0 and A, B in the field, and intersection points are a + b sqrt(g) with
a, b, g in the field; both are compared exactly (sign of a + b sqrt(g) by the signs of a, b and of a^2 - b^2 g). Nothing is compared in
floating point; floats are printed for reading only.

PLANTS (--plant NAME, or set PLANT): noself (skip the tile-with-itself pair), endpoints_only (VV candidates only), no_meet (no meeting test),
closed_interval (REJECT when 1 is in the CLOSED range: every exact contact at distance 1 then rejects, which certifies tightness), no_arcarc
(drop the AA candidates), no_sa (drop the SA candidates). `python3 tools/fs112_yb_check.py --selftest` runs the controls and each plant against
its predicted effect.
"""
from __future__ import annotations
from fractions import Fraction as Fr
from math import isqrt
import itertools
import sys

PLANT = None
PRIMES = (2, 3, 5, 7, 11, 13, 17, 19, 23)


def _prod(mask):
    n = 1
    for i, p in enumerate(PRIMES):
        if mask >> i & 1:
            n *= p
    return n


_SQB = {}


def _sqrt_bounds(n, k):
    """rational lo <= sqrt(n) <= hi with hi - lo <= 2^-k (exact when n is a square)."""
    key = (n, k)
    v = _SQB.get(key)
    if v is None:
        N = n << (2 * k)
        s = isqrt(N)
        v = (Fr(s, 1 << k), Fr(s if s * s == N else s + 1, 1 << k))
        _SQB[key] = v
    return v


class F:
    """an element of Q(sqrt p : p in PRIMES): {mask: Fraction}, the basis element of `mask` being prod_{p in mask} sqrt p."""
    __slots__ = ("c",)

    def __init__(self, c=None):
        self.c = {m: a for m, a in (c or {}).items() if a != 0}

    @staticmethod
    def of(x):
        if isinstance(x, F):
            return x
        x = Fr(x)
        return F({0: x})

    @staticmethod
    def sqrt(n):
        """sqrt of a positive rational whose square-free part is a product of PRIMES."""
        n = Fr(n)
        assert n > 0
        num, den = n.numerator * n.denominator, n.denominator     # sqrt(a/b) = sqrt(a b)/b
        mask, sq = 0, 1
        for i, p in enumerate(PRIMES):
            e = 0
            while num % p == 0:
                num //= p
                e += 1
            if e % 2:
                mask |= 1 << i
            sq *= p ** (e // 2)
        r = isqrt(num)
        assert r * r == num, f"square-free part of {n} outside PRIMES"
        return F({mask: Fr(sq * r, den)})

    def __add__(s, o):
        if isinstance(o, Sur):
            return NotImplemented
        o = F.of(o)
        c = dict(s.c)
        for m, a in o.c.items():
            c[m] = c.get(m, 0) + a
        return F(c)

    __radd__ = __add__

    def __neg__(s):
        return F({m: -a for m, a in s.c.items()})

    def __sub__(s, o):
        if isinstance(o, Sur):
            return NotImplemented
        return s + (-F.of(o))

    def __rsub__(s, o):
        return F.of(o) - s

    def __mul__(s, o):
        if isinstance(o, Sur):
            return NotImplemented
        o = F.of(o)
        c = {}
        for m1, a1 in s.c.items():
            for m2, a2 in o.c.items():
                m = m1 ^ m2
                c[m] = c.get(m, 0) + a1 * a2 * _prod(m1 & m2)
        return F(c)

    __rmul__ = __mul__

    def conj(s, i):
        return F({m: (-a if m >> i & 1 else a) for m, a in s.c.items()})

    def inv(s):
        assert s.c, "division by zero"
        num, den = F.of(1), s
        for i in range(len(PRIMES)):
            if any(m >> i & 1 for m in den.c):
                cj = den.conj(i)
                num, den = num * cj, den * cj
        assert set(den.c) == {0}
        return num * F.of(1 / den.c[0])

    def __truediv__(s, o):
        return s * F.of(o).inv()

    def __rtruediv__(s, o):
        return F.of(o) * s.inv()

    def is0(s):
        return not s.c

    def sign(s):
        if not s.c:
            return 0
        if set(s.c) == {0}:
            return 1 if s.c[0] > 0 else -1
        k = 48
        while True:
            lo = hi = Fr(0)
            for m, a in s.c.items():
                l, h = (Fr(1), Fr(1)) if m == 0 else _sqrt_bounds(_prod(m), k)
                if a > 0:
                    lo += a * l
                    hi += a * h
                else:
                    lo += a * h
                    hi += a * l
            if lo > 0:
                return 1
            if hi < 0:
                return -1
            k *= 2

    def __eq__(s, o):
        return (s - F.of(o)).is0()

    def __hash__(s):
        return hash(frozenset(s.c.items()))

    def __lt__(s, o): return (s - F.of(o)).sign() < 0
    def __le__(s, o): return (s - F.of(o)).sign() <= 0
    def __gt__(s, o): return (s - F.of(o)).sign() > 0
    def __ge__(s, o): return (s - F.of(o)).sign() >= 0

    def __float__(s):
        return float(sum(float(a) * _prod(m) ** 0.5 for m, a in s.c.items()))

    def __repr__(s):
        if not s.c:
            return "0"
        parts = []
        for m, a in sorted(s.c.items()):
            parts.append(f"{a}" if m == 0 else f"{a}*sqrt({_prod(m)})")
        return "(" + " + ".join(parts) + ")"


class Sur:
    """a + b*sqrt(g), a, b, g in F, g >= 0 (the coordinates of a point one square root beyond the field)."""
    __slots__ = ("a", "b", "g")

    def __init__(s, a, b=None, g=None):
        s.a, s.b, s.g = F.of(a), F.of(0 if b is None else b), F.of(0 if g is None else g)

    @staticmethod
    def of(x):
        return x if isinstance(x, Sur) else Sur(x)

    def _g(s, o):
        if s.b.is0():
            return o.g
        if o.b.is0():
            return s.g
        assert s.g == o.g, "mixed radicands"
        return s.g

    def __add__(s, o):
        o = Sur.of(o)
        return Sur(s.a + o.a, s.b + o.b, s._g(o))

    __radd__ = __add__

    def __sub__(s, o):
        o = Sur.of(o)
        return Sur(s.a - o.a, s.b - o.b, s._g(o))

    def __rsub__(s, o):
        return Sur.of(o) - s

    def __neg__(s):
        return Sur(-s.a, -s.b, s.g)

    def __mul__(s, o):
        if isinstance(o, Sur):
            g = s._g(o)
            return Sur(s.a * o.a + s.b * o.b * g, s.a * o.b + s.b * o.a, g)
        o = F.of(o)
        return Sur(s.a * o, s.b * o, s.g)

    __rmul__ = __mul__

    def sign(s):
        sa, sb = s.a.sign(), s.b.sign()
        if sb == 0 or s.g.is0():
            return sa
        assert s.g.sign() > 0
        if sa == 0:
            return sb
        if sa == sb:
            return sa
        d = (s.a * s.a - s.b * s.b * s.g).sign()
        return sa if d > 0 else (sb if d < 0 else 0)

    def __float__(s):
        return float(s.a) + float(s.b) * max(float(s.g), 0.0) ** 0.5


def sgn(x):
    return x.sign()


# ------------------------------------------------------------------ points and pieces
def pt(x, y):
    return (F.of(x), F.of(y))


def vadd(p, q): return (p[0] + q[0], p[1] + q[1])
def vsub(p, q): return (p[0] - q[0], p[1] - q[1])
def vmul(k, p): return (p[0] * k, p[1] * k) if isinstance(p[0], Sur) else (F.of(k) * p[0], F.of(k) * p[1])
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def cross(p, q): return p[0] * q[1] - p[1] * q[0]
def n2(p): return dot(p, p)
def veq(p, q): return (p[0] - q[0]).is0() and (p[1] - q[1]).is0()
def vneg(p): return (-p[0], -p[1])
def fpt(p): return (float(p[0]), float(p[1]))


class Seg:
    kind = "S"

    def __init__(s, P, Q):
        assert not veq(P, Q), "degenerate segment"
        s.P, s.Q = P, Q

    def ends(s):
        return (s.P, s.Q)

    def key(s):
        a, b = s.P, s.Q
        return ("S",) + tuple(sorted([(a[0].__hash__(), a[1].__hash__()), (b[0].__hash__(), b[1].__hash__())]))

    def __repr__(s):
        return f"Seg({fpt(s.P)}, {fpt(s.Q)})"


class Arc:
    """the arc of the circle (C, r) counter-clockwise from S to E (S == E only with full=True)."""
    kind = "A"

    def __init__(s, C, r, S, E, full=False):
        s.C, s.r, s.S, s.E, s.full = C, F.of(r), S, E, full
        assert s.r.sign() > 0
        assert n2(vsub(S, C)) == s.r * s.r, f"arc start off its circle: {fpt(S)} about {fpt(C)} r={float(s.r)}"
        assert n2(vsub(E, C)) == s.r * s.r, f"arc end off its circle: {fpt(E)} about {fpt(C)} r={float(s.r)}"
        assert full or not veq(S, E)

    def ends(s):
        return () if s.full else (s.S, s.E)

    def has_dir(s, w):
        """is C + r*w/|w| on the arc?  w may have Sur components."""
        if s.full:
            return True
        a, e = vsub(s.S, s.C), vsub(s.E, s.C)

        def half(v):
            c, d = sgn(cross(a, v)), sgn(dot(a, v))
            return 0 if (c > 0 or (c == 0 and d > 0)) else 1
        wa = (Sur.of(w[0]), Sur.of(w[1]))
        hw, he = half(wa), half(e)
        if hw != he:
            return hw < he
        return sgn(cross(wa, (Sur.of(e[0]), Sur.of(e[1])))) >= 0

    def __repr__(s):
        return f"Arc(C={fpt(s.C)}, r={float(s.r)}, {fpt(s.S)} -> {fpt(s.E)})"


# ------------------------------------------------------------------ candidates: (A, B, tag), distance |sqrt(A) + B|
Z = F.of(0)


def _cand_point(X, p, out, tag):
    if p.kind == "S":
        d = vsub(p.Q, p.P)
        t = dot(vsub(X, p.P), d) / n2(d)
        if t.sign() > 0 and (t - 1).sign() < 0:
            Fp = vadd(p.P, vmul(t, d))
            out.append((n2(vsub(X, Fp)), Z, (tag + ":VS", X, Fp)))
    else:
        w = vsub(X, p.C)
        if veq(w, (Z, Z)):
            out.append((Z, p.r, (tag + ":VA-centre", X, None)))
            return
        if p.has_dir(w):
            out.append((n2(w), -p.r, (tag + ":VA-near", X, None)))
        if p.has_dir(vneg(w)):
            out.append((n2(w), p.r, (tag + ":VA-far", X, None)))


def cands(p1, p2):
    out = []
    for X in p1.ends():
        for Y in p2.ends():
            out.append((n2(vsub(X, Y)), Z, ("VV", X, Y)))
    if PLANT == "endpoints_only":
        return out
    for X in p1.ends():
        _cand_point(X, p2, out, "1")
    for Y in p2.ends():
        _cand_point(Y, p1, out, "2")
    kinds = p1.kind + p2.kind
    if kinds in ("SA", "AS") and PLANT != "no_sa":
        s, a = (p1, p2) if p1.kind == "S" else (p2, p1)
        d = vsub(s.Q, s.P)
        t = dot(vsub(a.C, s.P), d) / n2(d)
        if t.sign() > 0 and (t - 1).sign() < 0:
            Fp = vadd(s.P, vmul(t, d))
            w = vsub(Fp, a.C)
            if veq(w, (Z, Z)):
                nrm = (-d[1], d[0])
                for v in (nrm, vneg(nrm)):
                    if a.has_dir(v):
                        out.append((Z, a.r, ("SA-centre", Fp, None)))
            else:
                if a.has_dir(w):
                    out.append((n2(w), -a.r, ("SA-near", Fp, None)))
                if a.has_dir(vneg(w)):
                    out.append((n2(w), a.r, ("SA-far", Fp, None)))
    if kinds == "AA" and PLANT != "no_arcarc":
        e = vsub(p2.C, p1.C)
        if veq(e, (Z, Z)):
            dirs = [vsub(x, p1.C) for x in p1.ends()] + [vsub(x, p2.C) for x in p2.ends()]
            if not dirs:
                dirs = [pt(1, 0)]
            for v in dirs + [vneg(x) for x in dirs]:
                if p1.has_dir(v) and p2.has_dir(v):
                    out.append((Z, p1.r - p2.r, ("AA-concentric-same", None, None)))
                if p1.has_dir(v) and p2.has_dir(vneg(v)):
                    out.append((Z, p1.r + p2.r, ("AA-concentric-opp", None, None)))
        else:
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if p1.has_dir(vmul(s1, e)) and p2.has_dir(vmul(s2, e)):
                        out.append((n2(e), s2 * p2.r - s1 * p1.r, ("AA-centres", None, None)))
    return out


def val(c):
    A, B = c[0], c[1]
    return abs(max(float(A), 0.0) ** 0.5 + float(B))


def _sqrt_lt(A, c):   # sqrt(A) < c
    return c.sign() > 0 and (A - c * c).sign() < 0


def _sqrt_gt(A, c):   # sqrt(A) > c
    return c.sign() < 0 or (A - c * c).sign() > 0


def cmp1(c):
    """-1, 0, +1 as |sqrt(A) + B| is below, equal to, above 1 (exact)."""
    A, B = c[0], c[1]
    one = F.of(1)
    if _sqrt_lt(A, one - B) and _sqrt_gt(A, -one - B):
        return -1
    if _sqrt_gt(A, one - B) or _sqrt_lt(A, -one - B):
        return 1
    return 0


# ------------------------------------------------------------------ meeting test
def _onseg(P, Q, X):
    return cross(vsub(Q, P), vsub(X, P)).is0() and dot(vsub(X, P), vsub(X, Q)).sign() <= 0


def _meet_ss(s, t):
    d1, d2 = vsub(s.Q, s.P), vsub(t.Q, t.P)
    o1, o2 = sgn(cross(d1, vsub(t.P, s.P))), sgn(cross(d1, vsub(t.Q, s.P)))
    o3, o4 = sgn(cross(d2, vsub(s.P, t.P))), sgn(cross(d2, vsub(s.Q, t.P)))
    if o1 * o2 < 0 and o3 * o4 < 0:
        return True
    return _onseg(s.P, s.Q, t.P) or _onseg(s.P, s.Q, t.Q) or _onseg(t.P, t.Q, s.P) or _onseg(t.P, t.Q, s.Q)


def _meet_sa(s, a):
    d, f = vsub(s.Q, s.P), vsub(s.P, a.C)
    A, B, Cc = n2(d), dot(d, f), n2(f) - a.r * a.r
    disc = B * B - A * Cc
    if disc.sign() < 0:
        return False
    for sg in (1, -1):
        num = Sur(-B, sg, disc)                  # t = num / A
        if num.sign() < 0 or Sur(A + B, -sg, disc).sign() < 0:
            continue
        w = (Sur(A * f[0] - B * d[0], sg * d[0], disc), Sur(A * f[1] - B * d[1], sg * d[1], disc))   # A*(X - C)
        if a.has_dir(w):
            return True
    return False


def _meet_aa(a1, a2):
    e = vsub(a2.C, a1.C)
    D = n2(e)
    if D.is0():
        if not (a1.r - a2.r).is0():
            return False
        if a1.full or a2.full:
            return True
        return any(a2.has_dir(vsub(x, a2.C)) for x in a1.ends()) or any(a1.has_dir(vsub(x, a1.C)) for x in a2.ends())
    al = (a1.r * a1.r - a2.r * a2.r + D) / (D * 2)
    h2 = a1.r * a1.r / D - al * al
    if h2.sign() < 0:
        return False
    for sg in (1, -1):
        w1 = (Sur(al * e[0], -sg * e[1], h2), Sur(al * e[1], sg * e[0], h2))
        w2 = (Sur((al - 1) * e[0], -sg * e[1], h2), Sur((al - 1) * e[1], sg * e[0], h2))
        if a1.has_dir(w1) and a2.has_dir(w2):
            return True
    return False


def meet(p, q):
    k = p.kind + q.kind
    if k == "SS":
        return _meet_ss(p, q)
    if k == "SA":
        return _meet_sa(p, q)
    if k == "AS":
        return _meet_sa(q, p)
    return _meet_aa(p, q)


def touch(T1, T2):
    return any(meet(p, q) for p in T1 for q in T2)


# ------------------------------------------------------------------ the pair verdict
class PairResult:
    __slots__ = ("verdict", "lo_class", "hi_class", "lo", "hi", "contacts", "ncand", "touch", "lo_c", "hi_c")


def pair_verdict(T1, T2, self_pair=False):
    r = PairResult()
    if self_pair and PLANT == "noself":             # planted: the tile-with-itself pair is never examined (reaches every driver)
        r.verdict, r.lo_class, r.hi_class, r.lo, r.hi, r.contacts, r.ncand, r.touch, r.lo_c, r.hi_c = \
            "ACCEPT", -1, -1, 0.0, 0.0, [], 0, True, None, None
        return r
    cs = [c for p in T1 for q in T2 for c in cands(p, q)]
    r.ncand = len(cs)
    cls = [cmp1(c) for c in cs]
    if self_pair:
        r.touch = True
    else:
        r.touch = False if PLANT == "no_meet" else touch(T1, T2)
    lo_lt = r.touch or any(k < 0 for k in cls)
    lo_eq = any(k == 0 for k in cls)
    hi_gt = any(k > 0 for k in cls)
    hi_eq = lo_eq
    r.lo_class = -1 if lo_lt else (0 if lo_eq else 1)
    r.hi_class = 1 if hi_gt else (0 if hi_eq else -1)
    vals = [val(c) for c in cs]
    r.lo = 0.0 if r.touch else min(vals)
    r.hi = max(vals)
    r.lo_c = None if r.touch else min(cs, key=val)
    r.hi_c = max(cs, key=val)
    r.contacts = [c for c, k in zip(cs, cls) if k == 0]
    if PLANT == "closed_interval":
        rej = (r.lo_class <= 0) and (r.hi_class >= 0)       # planted: 1 in the CLOSED range rejects
    else:
        rej = lo_lt and hi_gt
    r.verdict = "REJECT" if rej else "ACCEPT"
    return r


def check_fragment(T, pairs=None):
    """T: {name: (colour, [pieces])}. Every same-colour pair, each tile with itself included, generated from the colour map (or the
    explicit list `pairs`, for a control that asks one pair)."""
    names = sorted(T)
    if pairs is None:
        pairs = [(a, b) for a, b in itertools.combinations_with_replacement(names, 2) if T[a][0] == T[b][0]]
    counts = {}
    for n in names:
        counts[T[n][0]] = counts.get(T[n][0], 0) + 1
    expect = sum(k * (k + 1) // 2 for k in counts.values())
    rows, bad = [], []
    for a, b in pairs:
        r = pair_verdict(T[a][1], T[b][1], self_pair=(a == b))
        rows.append((a, b, T[a][0], r))
        if r.verdict == "REJECT":
            bad.append((a, b))
    return dict(verdict="REJECT" if bad else "ACCEPT", bad=bad, rows=rows, examined=len(rows), expected=expect,
                tiles=len(names))


# ------------------------------------------------------------------ controls (exact, known answers)
def _reuleaux(shift=(0, 0)):
    R3 = F.sqrt(3)
    P0, P1, P2 = pt(0, 0), pt(1, 0), (F.of(Fr(1, 2)), R3 / 2)
    sh = pt(*shift)
    P0, P1, P2 = vadd(P0, sh), vadd(P1, sh), vadd(P2, sh)
    return [Arc(P0, 1, P1, P2), Arc(P1, 1, P2, P0), Arc(P2, 1, P0, P1)]


def _square(x0, y0, s):
    a, b, c, d = pt(x0, y0), pt(x0 + s, y0), pt(x0 + s, y0 + s), pt(x0, y0 + s)
    return [Seg(a, b), Seg(b, c), Seg(c, d), Seg(d, a)]


def controls():
    """(name, tiles-dict, expected verdict, reason)"""
    R3 = F.sqrt(3)
    out = []
    out.append(("Reuleaux triangle, width 1 (self)", {"T": (1, _reuleaux())}, None, "ACCEPT", "constant width 1: diameter exactly 1"))
    out.append(("two Reuleaux triangles 2 apart along x (gap exactly 1)", {"T": (1, _reuleaux()), "U": (1, _reuleaux((2, 0)))},
                None, "ACCEPT", "min = 1 exactly (vertex (1,0) to vertex (2,0)), max > 1"))
    out.append(("two Reuleaux triangles 19/10 apart (gap 9/10)", {"T": (1, _reuleaux()), "U": (1, _reuleaux((Fr(19, 10), 0)))},
                None, "REJECT", "min 9/10 < 1 < max"))
    out.append(("square of side 7/10 (diagonal 0.99)", {"Q": (1, _square(0, 0, Fr(7, 10)))}, None, "ACCEPT", "diameter 7*sqrt2/10 < 1"))
    out.append(("square of side 3/4 (diagonal 1.06)", {"Q": (1, _square(0, 0, Fr(3, 4)))}, None, "REJECT", "diameter 3*sqrt2/4 > 1"))
    # AA witness: two unit-radius caps (half-angle arctan(7/24), chord 14/25, diameter 14/25) facing, centres 297/100 apart: the nearest
    # pair (97/100) is interior to both arcs; every endpoint candidate is > 1 (VV 1.05, VA 1.029, SA 1.01)
    C1, C2 = pt(0, 0), pt(Fr(297, 100), 0)
    a1 = Arc(C1, 1, pt(Fr(24, 25), Fr(-7, 25)), pt(Fr(24, 25), Fr(7, 25)))
    a2 = Arc(C2, 1, pt(Fr(297, 100) - Fr(24, 25), Fr(7, 25)), pt(Fr(297, 100) - Fr(24, 25), Fr(-7, 25)))
    cap1 = [a1, Seg(a1.E, a1.S)]
    cap2 = [a2, Seg(a2.E, a2.S)]
    out.append(("two unit caps facing, centres 297/100 apart (nearest pair interior to both arcs: 97/100)", {"A": (1, cap1), "B": (1, cap2)},
                None, "REJECT", "min 97/100 at the arcs' midpoints (AA only; every other candidate is > 1); max > 1"))
    # SA witness: the cap facing a thin bar [197/100, 2] x [-9/20, 9/20] (diameter 0.9005): nearest pair interior to both (97/100)
    xa, xb, yb = Fr(197, 100), Fr(2), Fr(9, 20)
    bar = [Seg(pt(xa, -yb), pt(xa, yb)), Seg(pt(xa, yb), pt(xb, yb)), Seg(pt(xb, yb), pt(xb, -yb)), Seg(pt(xb, -yb), pt(xa, -yb))]
    out.append(("unit cap facing a thin bar at x = 197/100 (nearest pair interior to both: 97/100)", {"A": (1, cap1), "B": (1, bar)},
                None, "REJECT", "min 97/100 from the cap's midpoint to the bar (SA only; VS 1.01, VA 1.021, VV 1.024); max > 1"))
    # meeting witness: two long crossing bars; ONLY their cross pair is asked (their self-pairs have diameter > 1)
    barh = [Seg(pt(-3, 0), pt(3, 0)), Seg(pt(3, 0), pt(3, Fr(1, 10))), Seg(pt(3, Fr(1, 10)), pt(-3, Fr(1, 10))),
            Seg(pt(-3, Fr(1, 10)), pt(-3, 0))]
    barv = [Seg(pt(Fr(1, 20), -3), pt(Fr(1, 20), 3)), Seg(pt(Fr(1, 20), 3), pt(Fr(-1, 20), 3)),
            Seg(pt(Fr(-1, 20), 3), pt(Fr(-1, 20), -3)), Seg(pt(Fr(-1, 20), -3), pt(Fr(1, 20), -3))]
    out.append(("two crossing bars of length 6, cross pair only", {"H": (1, barh), "V": (1, barv)}, [("H", "V")], "REJECT",
                "they cross (min 0, seen only by the meeting test: every candidate is > 1) and max > 1"))
    return out


PLANT_PREDICTIONS = {
    # plant: {control name: predicted verdict under the plant}
    "noself": {"square of side 3/4 (diagonal 1.06)": "ACCEPT"},
    "endpoints_only": {"two unit caps facing, centres 297/100 apart (nearest pair interior to both arcs: 97/100)": "ACCEPT",
                       "unit cap facing a thin bar at x = 197/100 (nearest pair interior to both: 97/100)": "ACCEPT"},
    "no_arcarc": {"two unit caps facing, centres 297/100 apart (nearest pair interior to both arcs: 97/100)": "ACCEPT"},
    "no_sa": {"unit cap facing a thin bar at x = 197/100 (nearest pair interior to both: 97/100)": "ACCEPT"},
    "closed_interval": {"Reuleaux triangle, width 1 (self)": "REJECT",
                        "two Reuleaux triangles 2 apart along x (gap exactly 1)": "REJECT"},
    "no_meet": {"two crossing bars of length 6, cross pair only": "ACCEPT"},
}


def selftest():
    global PLANT
    ok = True
    for plant in [None] + list(PLANT_PREDICTIONS):
        PLANT = plant
        for (name, T, prs, want, why) in controls():
            want_p = PLANT_PREDICTIONS.get(plant, {}).get(name, want) if plant else want
            got = check_fragment(T, prs)["verdict"]
            flag = "ok" if got == want_p else "MISMATCH"
            ok &= got == want_p
            if plant is None or want_p != want or got != want:
                print(f"  [{plant or 'faithful'}] {flag:8s} {name:75s} want {want_p} got {got}")
    PLANT = None
    return ok


if __name__ == "__main__":
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
    if "--selftest" in sys.argv:
        good = selftest()
        print("SELFTEST", "ALL AS PREDICTED" if good else "SOME MISMATCH")
        sys.exit(0 if good else 1)
    print(__doc__)
