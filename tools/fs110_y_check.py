#!/usr/bin/env python3
"""FS110-Y's exact curved-map checker (killing test 6 of data/fs110/claims.md).

For same-colour tiles bounded by segments and circular arcs with data in Q(sqrt 3), decide exactly whether the
cross-distance range [min, max] has 1 in its interior (REJECT) -- including a tile against itself (diameter > 1).

Model and completeness (stated, not assumed silently):
  * A tile is a closed region given by its boundary primitives: Seg(P, Q) and Arc(C, r, S, E) (counter-clockwise
    from S to E on the circle of centre C and radius r; S == E means a full circle).
  * min and max of |p - q| over two tiles with disjoint interiors are attained on boundary pairs; at an extreme pair
    each point is an endpoint or the connecting line is normal to its primitive.  The candidate list below contains
    every such critical pair, and every candidate is a realised distance (direction conditions are checked), so
    min/max over candidates are the true min/max.
  * MAP HYPOTHESIS: boundaries of distinct tiles meet only at listed endpoints (no transversal crossings).  Then two
    distinct tiles touch iff they share an endpoint exactly, and min = 0 exactly then.
Every candidate distance has the form |sqrt(A) + B| with A >= 0, A, B in Q(sqrt 3); comparison with 1 is exact.

Planted faults (--plant NAME) for the negative controls: noself, endpoints_only, closed_interval, cw_arcs.
"""
from __future__ import annotations
from fractions import Fraction as Fr
import sys

PLANT = None


class Q3:
    """a + b*sqrt(3), a, b rational; exact sign."""
    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a, self.b = Fr(a), Fr(b)

    def __add__(s, o): o = q(o); return Q3(s.a + o.a, s.b + o.b)
    __radd__ = __add__
    def __sub__(s, o): o = q(o); return Q3(s.a - o.a, s.b - o.b)
    def __rsub__(s, o): return q(o) - s
    def __neg__(s): return Q3(-s.a, -s.b)
    def __mul__(s, o): o = q(o); return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)
    __rmul__ = __mul__
    def __truediv__(s, o):
        o = q(o); n = o.a * o.a - 3 * o.b * o.b
        if n == 0: raise ZeroDivisionError
        return s * Q3(o.a / n, -o.b / n)

    def sign(s):
        a, b = s.a, s.b
        if b == 0: return (a > 0) - (a < 0)
        if a == 0: return (b > 0) - (b < 0)
        if (a > 0) == (b > 0): return 1 if a > 0 else -1
        return (1 if a > 0 else -1) if a * a > 3 * b * b else (1 if b > 0 else -1)

    def __eq__(s, o): return (s - q(o)).sign() == 0
    def __lt__(s, o): return (s - q(o)).sign() < 0
    def __gt__(s, o): return (s - q(o)).sign() > 0
    def __le__(s, o): return (s - q(o)).sign() <= 0
    def __ge__(s, o): return (s - q(o)).sign() >= 0
    def __hash__(s): return hash((s.a, s.b))
    def __repr__(s): return f"({s.a}+{s.b}r3)" if s.b else f"{s.a}"
    def f(s): return float(s.a) + float(s.b) * 3 ** 0.5


def q(x): return x if isinstance(x, Q3) else Q3(x)


R3 = Q3(0, 1)
V = tuple  # a point / vector is a pair of Q3


def sub(p, r): return (p[0] - r[0], p[1] - r[1])
def add(p, r): return (p[0] + r[0], p[1] + r[1])
def mul(t, p): return (t * p[0], t * p[1])
def dot(p, r): return p[0] * r[0] + p[1] * r[1]
def cross(p, r): return p[0] * r[1] - p[1] * r[0]
def n2(p): return dot(p, p)
def is0(p): return p[0] == 0 and p[1] == 0
def pt(x, y): return (q(x), q(y))


class Seg:
    def __init__(s, P, Q): s.P, s.Q = P, Q
    def ends(s): return [s.P, s.Q]


class Arc:
    def __init__(s, C, r, S, E):
        s.C, s.r, s.S, s.E = C, q(r), S, E
        assert n2(sub(S, C)) == s.r * s.r and n2(sub(E, C)) == s.r * s.r, "arc endpoint off its circle"
        if PLANT == "cw_arcs": s.S, s.E = E, S          # planted: wrong orientation
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


def cands(p1, p2, same=False):
    """critical (A, B) pairs, distance |sqrt(A) + B|, between primitives p1 and p2."""
    out = []
    for X in p1.ends():
        for Y in p2.ends():
            out.append((n2(sub(X, Y)), Q3(0)))
    if PLANT == "endpoints_only":
        return out
    for (X, p) in [(X, p2) for X in p1.ends()] + [(Y, p1) for Y in p2.ends()]:
        if isinstance(p, Seg):
            d = sub(p.Q, p.P); t = dot(sub(X, p.P), d) / n2(d)
            if Q3(0) < t < Q3(1):
                out.append((n2(sub(X, add(p.P, mul(t, d)))), Q3(0)))
        else:
            w = sub(X, p.C)
            if is0(w): out.append((Q3(0), p.r)); continue
            if p.has_dir(w): out.append((n2(w), -p.r))
            if p.has_dir(mul(-1, w)): out.append((n2(w), p.r))
    segs = [x for x in (p1, p2) if isinstance(x, Seg)]
    arcs = [x for x in (p1, p2) if isinstance(x, Arc)]
    if len(segs) == 1 and len(arcs) == 1:
        s, a = segs[0], arcs[0]
        d = sub(s.Q, s.P); t = dot(sub(a.C, s.P), d) / n2(d)
        if Q3(0) < t < Q3(1):
            F = add(s.P, mul(t, d)); w = sub(F, a.C)
            if is0(w):
                nrm = (-d[1], d[0])
                for v in (nrm, mul(-1, nrm)):
                    if a.has_dir(v): out.append((Q3(0), a.r))
            else:
                if a.has_dir(w): out.append((n2(w), -a.r))
                if a.has_dir(mul(-1, w)): out.append((n2(w), a.r))
    if len(arcs) == 2:
        a1, a2 = arcs
        w = sub(a2.C, a1.C)
        if is0(w):  # concentric (or the same arc): radial pairs; the extreme directions are endpoint directions or
            # their negatives (an intersection of two arcs of directions ends at an endpoint of one of them)
            dirs = [sub(a1.S, a1.C), sub(a1.E, a1.C), sub(a2.S, a2.C), sub(a2.E, a2.C)]
            for v in dirs + [mul(-1, x) for x in dirs]:
                if a1.has_dir(v) and a2.has_dir(v):              # same direction: |r1 - r2|
                    out.append((Q3(0), a1.r - a2.r))
                if a1.has_dir(v) and a2.has_dir(mul(-1, v)):     # opposite directions: r1 + r2
                    out.append((Q3(0), a1.r + a2.r))
        else:
            for s1 in (1, -1):
                for s2 in (1, -1):
                    if a1.has_dir(mul(s1, w)) and a2.has_dir(mul(s2, w)):
                        out.append((n2(w), s2 * a2.r - s1 * a1.r))
    return out


def lt1(A, B):  # |sqrt(A) + B| < 1
    def sqrt_lt(A, c): return c > 0 and A < c * c
    def sqrt_gt(A, c): return c < 0 or A > c * c
    return sqrt_lt(A, 1 - B) and sqrt_gt(A, -1 - B)


def gt1(A, B):  # |sqrt(A) + B| > 1
    def sqrt_gt(A, c): return c < 0 or A > c * c
    def sqrt_lt(A, c): return c > 0 and A < c * c
    return sqrt_gt(A, 1 - B) or sqrt_lt(A, -1 - B)


def ge1(A, B): return not lt1(A, B)
def le1(A, B): return not gt1(A, B)


def pair_verdict(T1, T2, self_pair=False):
    """REJECT iff 1 is interior to the cross-distance range of tiles T1, T2 (lists of primitives)."""
    cs = [c for p1 in T1 for p2 in T2 for c in cands(p1, p2)]
    if self_pair:
        touch = True
    else:
        e1 = {(x.a, x.b, y.a, y.b) for p in T1 for (x, y) in p.ends()}
        e2 = {(x.a, x.b, y.a, y.b) for p in T2 for (x, y) in p.ends()}
        touch = bool(e1 & e2)
    if PLANT == "closed_interval":   # planted: 1 in the CLOSED range rejects
        lo = touch or any(le1(*c) for c in cs); hi = any(ge1(*c) for c in cs)
    else:
        lo = touch or any(lt1(*c) for c in cs); hi = any(gt1(*c) for c in cs)
    return "REJECT" if (lo and hi) else "ACCEPT"


def check(tiles, pairs):
    """tiles: {name: [primitives]}; pairs: list of (name1, name2) of one colour (name1 == name2 is the self-pair)."""
    bad = []
    for (a, b) in pairs:
        if a == b and PLANT == "noself":
            continue
        v = pair_verdict(tiles[a], tiles[b], self_pair=(a == b))
        if v == "REJECT": bad.append((a, b))
    return ("REJECT", bad) if bad else ("ACCEPT", [])


# ---------------------------------------------------------------- controls (all exact, in Q(sqrt 3))
def hexagon(c, a):
    a = q(a); h = a * R3 / 2
    vs = [pt(a, 0), (a / 2, h), (-a / 2, h), (-a, q(0)), (-a / 2, -h), (a / 2, -h)]
    vs = [add(c, v) for v in vs]
    return [Seg(vs[i], vs[(i + 1) % 6]) for i in range(6)]


def hex_colouring(a, sublattice):
    """colour class 0 of a hexagonal colouring with side a: the origin hexagon and its translates by the
    same-colour sublattice within distance 3."""
    a = q(a)
    v1, v2 = (a * 3 / 2, a * R3 / 2), (q(0), a * R3)
    tiles = {"H0": hexagon(pt(0, 0), a)}; pairs = [("H0", "H0")]
    for m in range(-8, 9):
        for n in range(-8, 9):
            if (m, n) == (0, 0) or not sublattice(m, n): continue
            c = add(mul(m, v1), mul(n, v2))
            if n2(c) > 9: continue
            nm = f"H{m},{n}"; tiles[nm] = hexagon(c, a); pairs.append(("H0", nm))
    return tiles, pairs


def controls():
    R = {}
    # ACCEPT: the tight hexagonal 7-colouring (side 1/2, diameter exactly 1)
    R["hex7 tight (a=1/2)"] = ("ACCEPT", check(*hex_colouring(Fr(1, 2), lambda m, n: (m + 3 * n) % 7 == 0))[0])
    # REJECT: diameter 1.1
    R["hex7 a=11/20 (diameter 1.1)"] = ("REJECT", check(*hex_colouring(Fr(11, 20), lambda m, n: (m + 3 * n) % 7 == 0))[0])
    # REJECT: a four-colouring by the index-4 sublattice (same-colour hexagons sqrt3 apart)
    R["hex4 (index-4 sublattice)"] = ("REJECT", check(*hex_colouring(Fr(1, 2), lambda m, n: m % 2 == 0 and n % 2 == 0))[0])
    # curved ACCEPT: the Reuleaux triangle of width 1 (constant width: diameter exactly 1)
    P0, P1, P2 = pt(0, 0), pt(1, 0), (Q3(Fr(1, 2)), R3 / 2)
    reu = [Arc(P0, 1, P1, P2), Arc(P1, 1, P2, P0), Arc(P2, 1, P0, P1)]
    R["Reuleaux triangle, width 1"] = ("ACCEPT", check({"T": reu}, [("T", "T")])[0])
    # curved: circular segments on the chord [-1/2, 1/2], circle centre (0, sqrt3/6), radius 1/sqrt3
    C, r = (q(0), R3 / 6), R3 / 3
    A, B = pt(Fr(-1, 2), 0), pt(Fr(1, 2), 0)
    minor = [Seg(A, B), Arc(C, r, A, B)]      # ccw from 210 deg to 330 deg: below the chord
    major = [Seg(A, B), Arc(C, r, B, A)]      # ccw from -30 deg to 210 deg: 240 deg, holds an antipodal pair
    R["minor segment (diameter = chord = 1)"] = ("ACCEPT", check({"S": minor}, [("S", "S")])[0])
    R["major segment (diameter 2/sqrt3, interior antipodes)"] = ("REJECT", check({"S": major}, [("S", "S")])[0])
    # two unit-width Reuleaux triangles at distance exactly 1 along an axis (outer pair, touching distance 1): ACCEPT
    sh = pt(2, 0)
    reu2 = [Arc(add(P0, sh), 1, add(P1, sh), add(P2, sh)), Arc(add(P1, sh), 1, add(P2, sh), add(P0, sh)),
            Arc(add(P2, sh), 1, add(P0, sh), add(P1, sh))]
    R["two Reuleaux, gap exactly 1 (min = 1)"] = ("ACCEPT", check({"T": reu, "U": reu2}, [("T", "U")])[0])
    return R


if __name__ == "__main__":
    if len(sys.argv) > 2 and sys.argv[1] == "--plant":
        PLANT = sys.argv[2]
    res = controls(); ok = True
    for k, (want, got) in res.items():
        flag = "ok" if want == got else "MISMATCH"
        ok &= want == got
        print(f"{flag:8s} {k:55s} want {want:6s} got {got}")
    print("PLANT", PLANT, "ALL CONTROLS AS EXPECTED" if ok else "SOME CONTROL FLIPPED")
    sys.exit(0 if ok else 1)
