#!/usr/bin/env python3
"""FS112-Y's exact curved-map checker over a tower of real quadratic fields (killing test 2 of data/fs112/claims.md).

For same-colour tiles bounded by segments and circular arcs whose data lie in a real field
    F = Q(sqrt d_1)(sqrt d_2)...(sqrt d_K),   d_k > 0 an element of the previous level, not a square there,
decide EXACTLY whether 1 is interior to the cross-distance range [min, max] of two tiles (REJECT) -- a tile against itself
included (REJECT iff its diameter exceeds 1).  ACCEPT is the suspect verdict: a missed pair makes acceptance easy, so every
run prints the number of pairs examined against the number the object has.

Model (the same as FS110-Y's frozen checker, tools/fs110_y_check.py, which works in Q(sqrt 3) only):
  * A tile is a closed region given by its boundary primitives Seg(P, Q) and Arc(C, r, S, E) (the arc counter-clockwise
    from S to E on the circle of centre C and radius r; S == E is a full circle).
  * min and max of |p - q| over two tiles are attained on boundary pairs; at an extreme pair each point is an endpoint of
    its primitive or the connecting line is normal to it.  cands() lists every such critical pair, each a realised distance
    (direction conditions checked), so min/max over the candidates are the true extremes.
  * MAP HYPOTHESIS: boundaries of distinct tiles meet only at listed endpoints (no transversal crossings); two distinct
    tiles touch iff they share an endpoint (then min = 0).  The float guard partition() checks this on samples; it is a
    guard, never part of a verdict.
Every candidate distance is |sqrt(A) + B| with A >= 0 and A, B in F; its comparison with 1 is exact (sign in the tower).

Checker plants (--plant NAME, or PLANT = ...): noself, endpoints_only, closed_interval, cw_arcs -- FS110-Y's four, same meaning.
"""
from __future__ import annotations
from fractions import Fraction as Fr
import itertools, math

PLANT = None


# ================================================================== the tower
class Field:
    """Q(sqrt d_1)...(sqrt d_K).  An element of level k is a pair (a, b) = a + b*sqrt(d_k), a, b of level k-1; level 0 is a
    Fraction.  All elements of one field are stored at the top level K.  ds[k-1] is d_k, given at level k-1 (a Fraction for
    k = 1, a pair for k = 2, ...)."""

    def __init__(self, ds, names=None):
        self.D = [None] + list(ds)
        self.K = len(ds)
        self.names = names or [f"d{k}" for k in range(1, self.K + 1)]
        for k in range(1, self.K + 1):
            assert self._sign(k - 1, self.D[k]) > 0, "radicand must be positive"

    # ---- level arithmetic
    def _zero(self, k): return Fr(0) if k == 0 else (self._zero(k - 1), self._zero(k - 1))
    def _lift(self, j, x, k):        # level j -> level k
        while j < k:
            x = (x, self._zero(j)); j += 1
        return x
    def _add(self, k, x, y): return x + y if k == 0 else (self._add(k - 1, x[0], y[0]), self._add(k - 1, x[1], y[1]))
    def _neg(self, k, x): return -x if k == 0 else (self._neg(k - 1, x[0]), self._neg(k - 1, x[1]))
    def _mul(self, k, x, y):
        if k == 0: return x * y
        a1, b1 = x; a2, b2 = y
        return (self._add(k - 1, self._mul(k - 1, a1, a2), self._mul(k - 1, self.D[k], self._mul(k - 1, b1, b2))),
                self._add(k - 1, self._mul(k - 1, a1, b2), self._mul(k - 1, a2, b1)))
    def _norm(self, k, x):           # a^2 - d b^2, level k-1
        a, b = x
        return self._add(k - 1, self._mul(k - 1, a, a), self._neg(k - 1, self._mul(k - 1, self.D[k], self._mul(k - 1, b, b))))
    def _inv(self, k, x):
        if k == 0:
            if x == 0: raise ZeroDivisionError
            return 1 / x
        a, b = x
        ni = self._inv(k - 1, self._norm(k, x))
        return (self._mul(k - 1, a, ni), self._neg(k - 1, self._mul(k - 1, b, ni)))
    def _sign(self, k, x):
        if k == 0: return (x > 0) - (x < 0)
        a, b = x
        sa, sb = self._sign(k - 1, a), self._sign(k - 1, b)
        if sb == 0: return sa
        if sa == 0: return sb
        if sa == sb: return sa
        st = self._sign(k - 1, self._norm(k, x))      # a^2 - d b^2
        return sa if st > 0 else (sb if st < 0 else 0)
    def _float(self, k, x):
        if k == 0: return float(x)
        return self._float(k - 1, x[0]) + self._float(k - 1, x[1]) * math.sqrt(self._float(k - 1, self.D[k]))

    # ---- public
    def __call__(self, x):
        if isinstance(x, Num): return x
        return Num(self, self._lift(0, Fr(x), self.K))
    def gen(self, k):
        """sqrt(d_k) as an element."""
        one = self._lift(0, Fr(1), k - 1)
        return Num(self, self._lift(k, (self._zero(k - 1), one), self.K))
    def embed(self, j, x):
        """an element given at level j (nested pairs) as a top-level element."""
        return Num(self, self._lift(j, x, self.K))


class Num:
    __slots__ = ("F", "v")
    def __init__(self, F, v): self.F, self.v = F, v
    def _c(self, o): return o if isinstance(o, Num) else self.F(o)
    def __add__(s, o): o = s._c(o); return Num(s.F, s.F._add(s.F.K, s.v, o.v))
    __radd__ = __add__
    def __neg__(s): return Num(s.F, s.F._neg(s.F.K, s.v))
    def __sub__(s, o): return s + (-s._c(o))
    def __rsub__(s, o): return s._c(o) - s
    def __mul__(s, o): o = s._c(o); return Num(s.F, s.F._mul(s.F.K, s.v, o.v))
    __rmul__ = __mul__
    def __truediv__(s, o): o = s._c(o); return Num(s.F, s.F._mul(s.F.K, s.v, s.F._inv(s.F.K, o.v)))
    def __rtruediv__(s, o): return s._c(o) / s
    def sign(s): return s.F._sign(s.F.K, s.v)
    def __eq__(s, o): return (s - s._c(o)).sign() == 0
    def __lt__(s, o): return (s - s._c(o)).sign() < 0
    def __gt__(s, o): return (s - s._c(o)).sign() > 0
    def __le__(s, o): return (s - s._c(o)).sign() <= 0
    def __ge__(s, o): return (s - s._c(o)).sign() >= 0
    def __hash__(s): return hash(s.v)
    def key(s): return s.v
    def f(s): return s.F._float(s.F.K, s.v)
    def __repr__(s): return f"{s.f():.9f}"


# ================================================================== geometry (generic over Num)
def sub(p, r): return (p[0] - r[0], p[1] - r[1])
def add(p, r): return (p[0] + r[0], p[1] + r[1])
def mul(t, p): return (t * p[0], t * p[1])
def dot(p, r): return p[0] * r[0] + p[1] * r[1]
def cross(p, r): return p[0] * r[1] - p[1] * r[0]
def n2(p): return dot(p, p)
def is0(p): return p[0] == 0 and p[1] == 0
def pkey(p): return (p[0].key(), p[1].key())


class Seg:
    def __init__(s, P, Q): s.P, s.Q = P, Q
    def ends(s): return [s.P, s.Q]
    def __repr__(s): return f"Seg({s.P},{s.Q})"


class Arc:
    def __init__(s, C, r, S, E):
        s.C, s.r, s.S, s.E = C, r, S, E
        assert n2(sub(S, C)) == r * r and n2(sub(E, C)) == r * r, "arc endpoint off its circle"
        if PLANT == "cw_arcs": s.S, s.E = E, S
    def ends(s): return [s.S, s.E]
    def has_dir(s, w):
        """is C + r*w/|w| on the arc (ccw from S to E)?"""
        if s.S[0] == s.E[0] and s.S[1] == s.E[1]: return True
        a, e = sub(s.S, s.C), sub(s.E, s.C)
        def half(v):
            c, d = cross(a, v), dot(a, v)
            return 0 if (c > 0 or (c == 0 and d > 0)) else 1
        hw, he = half(w), half(e)
        if hw != he: return hw < he
        return cross(w, e) >= 0
    def __repr__(s): return f"Arc(C={s.C}, r={s.r}, {s.S}->{s.E})"


def cands(p1, p2):
    """critical (A, B), distance |sqrt(A) + B|, between primitives p1 and p2 (FS110-Y's list, generic)."""
    zero = p1.ends()[0][0] * 0
    out = [(n2(sub(X, Y)), zero) for X in p1.ends() for Y in p2.ends()]
    if PLANT == "endpoints_only":
        return out
    for (X, p) in [(X, p2) for X in p1.ends()] + [(Y, p1) for Y in p2.ends()]:
        if isinstance(p, Seg):
            d = sub(p.Q, p.P); t = dot(sub(X, p.P), d) / n2(d)
            if zero < t < zero + 1:
                out.append((n2(sub(X, add(p.P, mul(t, d)))), zero))
        else:
            w = sub(X, p.C)
            if is0(w): out.append((zero, p.r)); continue
            if p.has_dir(w): out.append((n2(w), -p.r))
            if p.has_dir(mul(-1, w)): out.append((n2(w), p.r))
    segs = [x for x in (p1, p2) if isinstance(x, Seg)]
    arcs = [x for x in (p1, p2) if isinstance(x, Arc)]
    if len(segs) == 1 and len(arcs) == 1:
        s, a = segs[0], arcs[0]
        d = sub(s.Q, s.P); t = dot(sub(a.C, s.P), d) / n2(d)
        if zero < t < zero + 1:
            Fp = add(s.P, mul(t, d)); w = sub(Fp, a.C)
            if is0(w):
                nrm = (-d[1], d[0])
                for v in (nrm, mul(-1, nrm)):
                    if a.has_dir(v): out.append((zero, a.r))
            else:
                if a.has_dir(w): out.append((n2(w), -a.r))
                if a.has_dir(mul(-1, w)): out.append((n2(w), a.r))
    if len(arcs) == 2:
        a1, a2 = arcs
        w = sub(a2.C, a1.C)
        if is0(w):
            dirs = [sub(a1.S, a1.C), sub(a1.E, a1.C), sub(a2.S, a2.C), sub(a2.E, a2.C)]
            for v in dirs + [mul(-1, x) for x in dirs]:
                if a1.has_dir(v) and a2.has_dir(v): out.append((zero, a1.r - a2.r))
                if a1.has_dir(v) and a2.has_dir(mul(-1, v)): out.append((zero, a1.r + a2.r))
        else:
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if a1.has_dir(mul(s1, w)) and a2.has_dir(mul(s2, w)):
                        out.append((n2(w), s2 * a2.r - s1 * a1.r))
    return out


def lt1(A, B):  # |sqrt(A) + B| < 1
    c1, c2 = 1 - B, -1 - B
    return (c1 > 0 and A < c1 * c1) and (c2 < 0 or A > c2 * c2)


def gt1(A, B):  # |sqrt(A) + B| > 1
    c1, c2 = 1 - B, -1 - B
    return (c1 < 0 or A > c1 * c1) or (c2 > 0 and A < c2 * c2)


def pair_verdict(T1, T2, self_pair=False):
    cs = [c for p1 in T1 for p2 in T2 for c in cands(p1, p2)]
    if self_pair:
        touch = True
    else:
        e1 = {pkey(x) for p in T1 for x in p.ends()}
        e2 = {pkey(x) for p in T2 for x in p.ends()}
        touch = bool(e1 & e2)
    if PLANT == "closed_interval":
        lo = touch or any(not gt1(*c) for c in cs); hi = any(not lt1(*c) for c in cs)
    else:
        lo = touch or any(lt1(*c) for c in cs); hi = any(gt1(*c) for c in cs)
    return "REJECT" if (lo and hi) else "ACCEPT"


def frange(T1, T2, self_pair=False):
    """float [min, max] for the record (not a verdict)."""
    vals = [abs(math.sqrt(max(A.f(), 0.0)) + B.f()) for p1 in T1 for p2 in T2 for (A, B) in cands(p1, p2)]
    return (0.0 if self_pair else min(vals)), max(vals)


def check_pairs(tiles, pairs):
    """tiles: {name: (colour, [prims])}; pairs: [(a, b)] same colour (a == b the self pair). Returns (verdict, bad, n)."""
    bad = []
    for (a, b) in pairs:
        assert tiles[a][0] == tiles[b][0]
        if a == b and PLANT == "noself": continue
        if pair_verdict(tiles[a][1], tiles[b][1], self_pair=(a == b)) == "REJECT": bad.append((a, b))
    return ("REJECT" if bad else "ACCEPT"), bad, len(pairs)


def all_pairs(tiles):
    """every same-colour pair of a finite fragment, each tile with itself included -- generated from the colour map."""
    names = sorted(tiles)
    return [(a, b) for a, b in itertools.combinations_with_replacement(names, 2) if tiles[a][0] == tiles[b][0]]


def closure_type(tiles, P):
    """P_cl(P): colours of tiles whose closure contains P (exact: P an endpoint, on a segment, or on an arc)."""
    cols = set()
    for nm, (c, prims) in tiles.items():
        for p in prims:
            hit = any(is0(sub(P, X)) for X in p.ends())
            if not hit and isinstance(p, Seg):
                d = sub(p.Q, p.P); w = sub(P, p.P)
                hit = cross(d, w) == 0 and dot(w, d) >= 0 and dot(w, d) <= n2(d)
            if not hit and isinstance(p, Arc):
                w = sub(P, p.C)
                hit = n2(w) == p.r * p.r and p.has_dir(w)
            if hit: cols.add(c); break
    return cols


# ================================================================== float guard (never a verdict)
def polyline(prims, n=24):
    out = []
    for p in prims:
        if isinstance(p, Seg):
            out.append([(p.P[0].f(), p.P[1].f()), (p.Q[0].f(), p.Q[1].f())])
        else:
            cx, cy = p.C[0].f(), p.C[1].f(); r = p.r.f()
            a0 = math.atan2(p.S[1].f() - cy, p.S[0].f() - cx); a1 = math.atan2(p.E[1].f() - cy, p.E[0].f() - cx)
            span = (a1 - a0) % (2 * math.pi)
            assert span < math.pi / 2, "arc span >= 90 deg: wrong orientation?"
            out.append([(cx + r * math.cos(a0 + span * i / n), cy + r * math.sin(a0 + span * i / n)) for i in range(n + 1)])
    return out


def inside(chains, x, y):
    cnt = 0
    for ch in chains:
        for (x1, y1), (x2, y2) in zip(ch, ch[1:]):
            if (y1 > y) != (y2 > y) and x < x1 + (y - y1) * (x2 - x1) / (y2 - y1):
                cnt += 1
    return cnt % 2 == 1


def partition(tiles, box, n=60, margin=1e-3):
    """sample an n x n grid in box = (x0, x1, y0, y1); every sample farther than `margin` from all boundaries must lie in
    exactly one tile.  Returns (samples used, overlaps, holes)."""
    polys = {k: polyline(v[1], 64) for k, v in tiles.items()}
    segs = [s for ch in polys.values() for c in ch for s in zip(c, c[1:])]
    def dseg(x, y, a, b):
        (x1, y1), (x2, y2) = a, b; dx, dy = x2 - x1, y2 - y1; L = dx * dx + dy * dy
        t = 0 if L == 0 else max(0, min(1, ((x - x1) * dx + (y - y1) * dy) / L))
        return math.hypot(x - x1 - t * dx, y - y1 - t * dy)
    x0, x1, y0, y1 = box; used = over = hole = 0
    for i in range(n):
        for j in range(n):
            x = x0 + (x1 - x0) * (i + 0.5) / n; y = y0 + (y1 - y0) * (j + 0.5) / n
            if min(dseg(x, y, a, b) for a, b in segs) < margin: continue
            k = sum(inside(ch, x, y) for ch in polys.values()); used += 1
            over += k > 1; hole += k == 0
    return used, over, hole


# ================================================================== the strip (CAL-STRIP), rebuilt from the printed rule
def strip_field():
    return Field([Fr(3), (Fr(5), Fr(0))], names=["3", "5"])


STRIP_COL = {"A": (1, 2, 3), "B": (4, 5, 6), "C": (5, 6, 4), "D": (2, 3, 1)}    # Fig. 4's pattern, j mod 3


def strip(jmin, jmax, plant=None, cols=None):
    """[AxenovichEtAl2014] Thm 4.2's strip on columns jmin..jmax.  plant: None | 'tall' (H/2 raised by 1/100) |
    'flat' (the arcs shared by A_j and C_j, and their mirrors, replaced by chords) | 'swap' (C_1 and C_2 exchange colours)."""
    F = strip_field(); r3, r5 = F.gen(1), F.gen(2)
    h1 = r3 / 2                  # side height sqrt(1 - 1/4)
    h2 = r3 * r5 / 4             # apex height sqrt(1 - 1/16) = sqrt15/4
    top = h1 + h2 + (Fr(1, 100) if plant == "tall" else 0)
    one = F(1)
    def x(j): return F(Fr(j, 2))
    def P(a, b): return (F(a) if not isinstance(a, Num) else a, F(b) if not isinstance(b, Num) else b)
    def arcA_left(j):   # A_j's left arc: centre (x_{j+1}, 0), from (x_j, h1) [angle 120] ccw? -> it runs from apex to valley ccw
        C = P(x(j + 1), 0); return Arc(C, one, P(x(j) + Fr(1, 4), h2), P(x(j), h1))
    def arcA_right(j):  # A_j's right arc: centre (x_j, 0), from (x_{j+1}, h1) [60 deg] ccw to the apex
        C = P(x(j), 0); return Arc(C, one, P(x(j + 1), h1), P(x(j) + Fr(1, 4), h2))
    def mir(p):
        if isinstance(p, Seg): return Seg((p.Q[0], -p.Q[1]), (p.P[0], -p.P[1]))
        return Arc((p.C[0], -p.C[1]), p.r, (p.E[0], -p.E[1]), (p.S[0], -p.S[1]))
    def chord(a): return Seg(a.S, a.E)
    tiles = {}
    cmap = cols or STRIP_COL
    for j in range(jmin, jmax + 1):
        L, R = arcA_left(j), arcA_right(j)
        if plant == "flat": L, R = chord(L), chord(R)
        A = [Seg(P(x(j), 0), P(x(j + 1), 0)), Seg(P(x(j + 1), 0), P(x(j + 1), h1)), R, L, Seg(P(x(j), h1), P(x(j), 0))]
        Rl, Lr = arcA_right(j - 1), arcA_left(j)      # C_j sits on A_{j-1}'s right arc and A_j's left arc
        if plant == "flat": Rl, Lr = chord(Rl), chord(Lr)
        Ct = [Rl, Lr, Seg(P(x(j) + Fr(1, 4), h2), P(x(j) + Fr(1, 4), top)), Seg(P(x(j) + Fr(1, 4), top), P(x(j) - Fr(1, 4), top)),
              Seg(P(x(j) - Fr(1, 4), top), P(x(j) - Fr(1, 4), h2))]
        m = j % 3
        tiles[f"A{j}"] = (cmap["A"][m], A)
        tiles[f"B{j}"] = (cmap["B"][m], [mir(p) for p in A])
        tiles[f"C{j}"] = (cmap["C"][m], Ct)
        tiles[f"D{j}"] = (cmap["D"][m], [mir(p) for p in Ct])
    if plant == "swap":
        for j in range(jmin, jmax + 1):
            if j % 3 in (1, 2):
                c, prims = tiles[f"C{j}"]
                tiles[f"C{j}"] = ({6: 4, 4: 6}[c], prims)
    return F, tiles, top


def xext(prims):
    xs = [e[0] for p in prims for e in p.ends()]
    lo = min(xs, key=lambda v: v.f()); hi = max(xs, key=lambda v: v.f())
    return lo, hi


def strip_pairs(tiles, fund=(0, 1, 2)):
    """ordered pairs (T, T') of one colour, T in one period (columns fund), T' any tile of the window whose x-extent comes
    within 1 of T's (exact rational extents); pairs farther apart have min > 1 and cannot REJECT."""
    out = []
    for a, (ca, pa) in tiles.items():
        if int(a[1:]) not in fund: continue
        la, ha = xext(pa)
        for b, (cb, pb) in tiles.items():
            if cb != ca: continue
            lb, hb = xext(pb)
            gap = max(lb - ha, la - hb)
            if gap <= 1: out.append((a, b))
    return out
