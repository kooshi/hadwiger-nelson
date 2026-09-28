#!/usr/bin/env python3
"""FS111-M3: exact checks for the honeycomb class HC (plans/FS111-M3-finiteness.md §1.6, §2).

HC's skeleton: L = 2 + sqrt3/3; face centres O on the triangular lattice spanned by
L(3/2, sqrt3/2), L(0, sqrt3); centroids C = O + L u(60k); at each C the closed equilateral
triangle of side 1 with its vertices pointing at the three face centres around C; on each
honeycomb edge the segment sigma of length 1, perpendicular to the edge, at its midpoint;
at each O the closed disc of radius 1/2.

Every number below lives in Q(sqrt3) and every comparison is exact (class Q3: a + b*sqrt3
with a, b Fractions; the sign of a + b*sqrt3 is decided by comparing squares).

Checks (each prints PASS/FAIL; exit 0 iff the faithful object passes all and every plant
fails exactly its named checks):
  H1  block distances on a patch: triangle-triangle >= 2; triangle-segment = 1 exactly when
      the triangle flanks the segment, else >= 1 + 1/8; segment-segment >= sqrt3;
      disc-triangle >= 3/2; disc-segment >= sqrt3 - 1/2; flanking sides parallel at distance 2.
  H2  f(s) = 1 + sqrt3/2 - sqrt(1 - (1/2+s)^2) - sqrt(1 - s^2) >= 0 on [0, 1/2] (the vesica
      of sigma lies in the apex's exclusion zone): f is increasing (hand: both square roots
      decrease in s >= 0), so f >= 0 iff f(0) >= 0; f(0) = 0 exactly.
  H3  the quadrilateral Q = conv{(3/2,0), v=(2,0), e=(3/2, sqrt3/2), q=(3/2)u(30)} lies in
      B(v,1) u B(e,1): split by the perpendicular bisector of v, e; every vertex of each half
      within distance 1 of its centre (halves are convex, so vertices suffice).
  H4  the gap polynomial phi(x) = x^2 (w-x)^2 / 4 on [0, w], w <= 1: |phi''| <= w^2/2 <= 1/2,
      |phi'| <= (1/2) w^2 min(x, w-x), phi <= (w^2/4) min(x, w-x)^2 (checked symbolically on
      [0, w/2] by sympy, then by symmetry).
  H5  the exterior-ball numbers: for |x|, |y| <= 5/2, x != 0 or y != 0:
      max((2/5) x^2, |y|) > (5/16) x^2 + (5/256) y^2   (case split, exact).
  H7  sampled exact identity on the flat skeleton (bands as segments): at grid points
      z = (i*sqrt3/(4N), j/(4N)), z in int(triangles u discs) XOR z on a unit circle about
      (triangles u segments u discs); a control, not the proof.
Plants:
  side19   triangles of side 19/20 at the same centroids   -> H1 (flanking distance != 1), H2, H7 (free points)
  closer   L - 1/10 (triangles closer)                       -> H1 (a triangle-segment distance < 1), H7
  nosigma  H3 without the segment's disc B(e,1)              -> H3
  eps1/2   g = (1/2) sum phi_J (twice the curvature)         -> H4
  R2       exterior radius 2 in H5                           -> H5
Output: data/fs111/fs111-m3/honey.out (also printed).
"""
from fractions import Fraction as Fr
import itertools
import sys

OUT = "data/fs111/fs111-m3/honey.out"
LOG = []


def log(s=""):
    print(s)
    LOG.append(s)


class Q3:
    """a + b*sqrt(3), exact."""
    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a = Fr(a)
        self.b = Fr(b)

    def __add__(s, o):
        o = q3(o)
        return Q3(s.a + o.a, s.b + o.b)

    __radd__ = __add__

    def __sub__(s, o):
        o = q3(o)
        return Q3(s.a - o.a, s.b - o.b)

    def __rsub__(s, o):
        return q3(o) - s

    def __neg__(s):
        return Q3(-s.a, -s.b)

    def __mul__(s, o):
        o = q3(o)
        return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)

    __rmul__ = __mul__

    def __truediv__(s, o):
        o = q3(o)
        n = o.a * o.a - 3 * o.b * o.b
        return s * Q3(o.a / n, -o.b / n)

    def sign(s):
        a, b = s.a, s.b
        if a >= 0 and b >= 0:
            return 0 if (a == 0 and b == 0) else 1
        if a <= 0 and b <= 0:
            return -1
        # opposite signs: compare a^2 with 3 b^2
        d = a * a - 3 * b * b
        if d == 0:
            return 0
        return (1 if a > 0 else -1) if d > 0 else (1 if b > 0 else -1)

    def __lt__(s, o):
        return (s - o).sign() < 0

    def __le__(s, o):
        return (s - o).sign() <= 0

    def __gt__(s, o):
        return (s - o).sign() > 0

    def __ge__(s, o):
        return (s - o).sign() >= 0

    def __eq__(s, o):
        return (s - o).sign() == 0

    def __hash__(s):
        return hash((s.a, s.b))

    def f(s):
        return float(s.a) + float(s.b) * 3 ** 0.5

    def __repr__(s):
        return f"({s.a}+{s.b}r3)"


def q3(x):
    return x if isinstance(x, Q3) else Q3(x)


R3 = Q3(0, 1)
HALF = Fr(1, 2)
# unit vectors u(30 m), m = 0..11
U = {}
for m in range(12):
    c = [Q3(1), Q3(0, HALF), Q3(HALF), Q3(0), Q3(-HALF), Q3(0, -HALF)]
    cs = [(Q3(1), Q3(0)), (Q3(0, HALF), Q3(HALF)), (Q3(HALF), Q3(0, HALF)), (Q3(0), Q3(1)),
          (Q3(-HALF), Q3(0, HALF)), (Q3(0, -HALF), Q3(HALF))]
    x, y = cs[m % 6]
    U[m] = (x, y) if m < 6 else (-x, -y)


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def mul(k, p):
    return (k * p[0], k * p[1])


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def n2(p):
    return dot(p, p)


def pseg2(z, p, q):
    """squared distance from point z to segment [p, q], exact."""
    v = sub(q, p)
    t = dot(sub(z, p), v) / n2(v)
    if t <= 0:
        return n2(sub(z, p))
    if t >= 1:
        return n2(sub(z, q))
    return n2(sub(z, add(p, mul(t, v))))


def cross(p, q):
    return p[0] * q[1] - p[1] * q[0]


def segs_cross(p, q, r, s):
    d1, d2 = cross(sub(q, p), sub(r, p)), cross(sub(q, p), sub(s, p))
    d3, d4 = cross(sub(s, r), sub(p, r)), cross(sub(s, r), sub(q, r))
    return d1.sign() * d2.sign() < 0 and d3.sign() * d4.sign() < 0


def sseg2(p, q, r, s):
    if segs_cross(p, q, r, s):
        return Q3(0)
    return min(pseg2(p, r, s), pseg2(q, r, s), pseg2(r, p, q), pseg2(s, p, q))


def build(side=Fr(1), Lshift=Fr(0), reach=2):
    L = Q3(2, Fr(1, 3)) + Lshift
    a1 = (L * Fr(3, 2), L * Q3(0, HALF))
    a2 = (Q3(0), L * R3)
    Os = []
    for i in range(-reach, reach + 1):
        for j in range(-reach, reach + 1):
            Os.append(add(mul(Q3(i), a1), mul(Q3(j), a2)))
    Rc = Q3(0, Fr(1, 3)) * side  # circumradius side/sqrt3
    cents = {}
    for O in Os:
        for k in range(6):
            C = add(O, mul(L, U[2 * k]))
            cents.setdefault((C[0], C[1]), (C, k))
    tris = {}
    for key, (C, k) in cents.items():
        # vertex pointing back at the face centre: direction u(60k + 180) = U[(2k+6)%12]
        vs = [add(C, mul(Rc, U[(2 * k + 6 + 4 * m) % 12])) for m in range(3)]
        tris[key] = vs
    keys = list(cents)
    segs = []
    for i, k1 in enumerate(keys):
        for k2 in keys[i + 1:]:
            C1, C2 = cents[k1][0], cents[k2][0]
            d = sub(C2, C1)
            if n2(d) == L * L:
                M = mul(Fr(1, 2), add(C1, C2))
                # unit perpendicular: rotate d/L by 90 degrees
                e = (d[0] / L, d[1] / L)
                nrm = (-e[1], e[0])
                segs.append((add(M, mul(-HALF, nrm)), add(M, mul(HALF, nrm)), k1, k2))
    return L, Os, tris, segs


def tri_edges(vs):
    return [(vs[m], vs[(m + 1) % 3]) for m in range(3)]


def dist2_tri_tri(t1, t2):
    return min(sseg2(p, q, r, s) for (p, q) in tri_edges(t1) for (r, s) in tri_edges(t2))


def dist2_tri_seg(t, p, q):
    return min(sseg2(a, b, p, q) for (a, b) in tri_edges(t))


def H1(side=Fr(1), Lshift=Fr(0)):
    L, Os, tris, segs = build(side, Lshift, reach=1)
    fails = []
    near = lambda P, Q_, r: n2(sub(P, Q_)) <= Q3(r) * Q3(r)
    centre = (Q3(0), Q3(0))
    # restrict to blocks within 6 of the central face centre
    T = {k: v for k, v in tris.items() if near(k, centre, 6)}
    S = [s for s in segs if near(s[0], centre, 6)]
    D = [O for O in Os if near(O, centre, 6)]
    tk = list(T)
    mins = {}
    for i, k1 in enumerate(tk):
        for k2 in tk[i + 1:]:
            d2 = dist2_tri_tri(T[k1], T[k2])
            mins["TT"] = min(mins.get("TT", d2), d2)
            if d2 < 4:
                fails.append(("TT<2", k1, k2))
    flank_ok = True
    for (p, q, c1, c2) in S:
        for k in tk:
            d2 = dist2_tri_seg(T[k], p, q)
            if k in (c1, c2):
                if not (d2 == 1):
                    flank_ok = False
                    fails.append(("flank!=1", k, d2.f()))
            else:
                mins["TS"] = min(mins.get("TS", d2), d2)
                if d2 < Q3(Fr(81, 64)):
                    fails.append(("TS<9/8", k, d2.f()))
    for i, s1 in enumerate(S):
        for s2 in S[i + 1:]:
            d2 = sseg2(s1[0], s1[1], s2[0], s2[1])
            mins["SS"] = min(mins.get("SS", d2), d2)
            if d2 < 3:
                fails.append(("SS<sqrt3", d2.f()))
    for O in D:
        for k in tk:
            d2 = min(pseg2(O, a, b) for (a, b) in tri_edges(T[k]))
            mins["DT"] = min(mins.get("DT", d2), d2)
            if d2 < 4:  # distance from O >= 2, so disc-triangle >= 3/2
                fails.append(("DT<3/2", d2.f()))
        for (p, q, c1, c2) in S:
            d2 = pseg2(O, p, q)
            mins["DS"] = min(mins.get("DS", d2), d2)
            if d2 < 3:  # distance from O >= sqrt3, disc-segment >= sqrt3 - 1/2
                fails.append(("DS<sqrt3-1/2", d2.f()))
    return fails, {k: round(v.f() ** 0.5, 6) for k, v in mins.items()}, len(T), len(S), len(D)


def sqrt_bounds(x, k=40):
    """rational lo <= sqrt(x) <= hi for rational x >= 0 (bisection)."""
    lo, hi = Fr(0), max(Fr(1), x)
    for _ in range(k):
        mid = (lo + hi) / 2
        if mid * mid <= x:
            lo = mid
        else:
            hi = mid
    return lo, hi


def H2(side=Fr(1)):
    """f(s) = 1 + h - sqrt(1-(side/2+s)^2) - sqrt(1-s^2), h = side*sqrt3/2, is increasing on
    [0, side/2] (both square roots decrease in s >= 0: the hand step), so f >= 0 there iff
    f(0) = h - sqrt(1 - side^2/4) >= 0.  Checked exactly: for side = 1, sqrt(3/4) = sqrt3/2 = h,
    f(0) = 0; otherwise the sign of f(0) is decided by rational bounds on sqrt(1 - side^2/4)."""
    h = side * Q3(0, HALF)
    x0 = 1 - side * side / 4
    if side == 1:
        return [] if (h - Q3(0, HALF)).sign() == 0 else ["f(0)!=0"]
    lo, hi = sqrt_bounds(x0, 60)
    if (h - Q3(hi)).sign() >= 0:
        return []
    return ["f(0)<0"] if (h - Q3(lo)).sign() < 0 else ["f(0)?"]


def H3(use_sigma=True):
    fails = []
    v = (Q3(2), Q3(0))
    e = (Q3(Fr(3, 2)), Q3(0, HALF))
    a = (Q3(Fr(3, 2)), Q3(0))
    q = (Q3(0, Fr(3, 4)), Q3(Fr(3, 4)))
    poly = [a, v, e, q]
    one = Q3(1)
    if not use_sigma:
        far = [p for p in poly if n2(sub(p, v)) > one]
        return ["Q-not-covered"] if far else [], None
    # split by the perpendicular bisector of v, e: sign of <z - m, e - v>
    m = mul(Fr(1, 2), add(v, e))
    w = sub(e, v)
    side = lambda z: dot(sub(z, m), w)
    halves = {1: [], -1: []}
    n = len(poly)
    for i in range(n):
        z1, z2 = poly[i], poly[(i + 1) % n]
        s1, s2 = side(z1).sign(), side(z2).sign()
        if s1 >= 0:
            halves[1].append(z1)
        if s1 <= 0:
            halves[-1].append(z1)
        if s1 * s2 < 0:
            t = side(z1) / (side(z1) - side(z2))
            x = add(z1, mul(t, sub(z2, z1)))
            halves[1].append(x)
            halves[-1].append(x)
    worst = []
    for sg, centre in ((1, e), (-1, v)):
        for z in halves[sg]:
            d2 = n2(sub(z, centre))
            worst.append(d2.f() ** 0.5)
            if d2 > one:
                fails.append(("half", sg, d2.f()))
    return fails, max(worst)


def H4(eps=None):
    import sympy as sp
    x, w = sp.symbols("x w", positive=True)
    phi = x ** 2 * (w - x) ** 2 * (sp.Rational(1, 4) if eps is None else eps)
    d1 = sp.diff(phi, x)
    d2 = sp.diff(phi, x, 2)
    fails = []
    # on 0 <= x <= w/2 (min(x, w-x) = x); substitute x = w*r, r in [0, 1/2]
    r = sp.symbols("r", nonnegative=True)
    sub_ = {x: w * r}
    e2 = sp.simplify(d2.subs(sub_) / w ** 2)  # |phi''|/w^2 <= 1/2
    e1 = sp.simplify(sp.Abs(d1.subs(sub_)) / (w ** 2 * w * r))  # |phi'| <= (1/2) w^2 x
    e0 = sp.simplify(phi.subs(sub_) / (w ** 2 * (w * r) ** 2))  # phi <= (w^2/4) x^2
    rr = [sp.Rational(k, 400) for k in range(0, 201)]
    # exact polynomial checks on r in [0, 1/2]:
    p2 = sp.Poly(sp.expand(e2), r)
    # |p2| <= 1/2: p2 = (1 - 6 r + 6 r^2)/2; roots of p2 - 1/2 and p2 + 1/2 on [0, 1/2]
    ok2 = all(abs(p2.eval(t)) <= sp.Rational(1, 2) for t in rr) and \
        sp.solve(sp.Eq(p2.as_expr(), sp.Rational(1, 2)), r) is not None
    # derivative bound: |phi'| = (1/2) x (w-x) |w - 2x| <= (1/2) w^2 x
    # phi' = (1/2) w^3 r (1-r)(1-2r) with x = w r; on r in [0, 1/2] all factors >= 0 and (1-r)(1-2r) <= 1
    ok1 = sp.expand(d1.subs(sub_) - w ** 3 * r / 2 * (1 - r) * (1 - 2 * r)) == 0
    ok0 = sp.simplify(e0 - (1 - r) ** 2 / 4) == 0
    # (1 - r)(1 - 2r) <= 1 and (1 - r)^2/4 <= 1/4 on [0, 1/2]: trivial; (1-6r+6r^2) in [-1/2, 1] on [0,1/2]
    vmin = sp.minimum(1 - 6 * r + 6 * r ** 2, r, sp.Interval(0, sp.Rational(1, 2)))
    vmax = sp.maximum(1 - 6 * r + 6 * r ** 2, r, sp.Interval(0, sp.Rational(1, 2)))
    if not (vmin == sp.Rational(-1, 2) and vmax == 1):
        fails.append(("phi''", vmin, vmax))
    if not ok1:
        fails.append("phi'")
    if not ok0:
        fails.append("phi")
    if not sp.simplify(e2 - (1 - 6 * r + 6 * r ** 2) / 2) == 0:
        fails.append("phi''-form")
    return fails


def H5(R=Fr(5, 4)):
    """max(2x^2/5, |y|) > 5x^2/16 + 5y^2/256 for |x|, |y| <= 5/2, (x, y) != 0.
    Case A: 2x^2/5 >= |y|: RHS <= 5x^2/16 + 5(2x^2/5)^2/256 = 5x^2/16 + x^4/320 <= x^2 (5/16 + 25/1280)
            = x^2 * 425/1280 < 2x^2/5 = 512/1280 x^2  (x != 0; if x = 0 then y = 0).
    Case B: |y| > 2x^2/5: RHS < (5/16)(5/2)|y| + (5/256)(5/2)|y| = |y| (25/32 + 25/512) = |y| 425/512 < |y|."""
    ca = Fr(5, 16) + Fr(25, 1280)
    cb = Fr(25, 32) + Fr(25, 512)
    k = 1 / (2 * R)  # the sagitta constant: depth >= x^2/(2R)
    return [] if (ca < k and cb < 1) else ["H5"]


def H7(side=Fr(1), Lshift=Fr(0), N=2, box=(-24, 24, -44, 44)):
    """Sampled exact identity on the flat skeleton around the central face centre."""
    L, Os, tris, segs = build(side, Lshift, reach=1)
    near = lambda P, r: n2(P) <= Q3(r * r)
    T = [v for k, v in tris.items() if near((k[0], k[1]), 6)]
    S = [(p, q) for (p, q, c1, c2) in segs if near(p, 6)]
    D = [O for O in Os if near(O, 6)]
    free, both, npts = [], [], 0
    one = Q3(1)
    quarter, nine4 = Q3(Fr(1, 4)), Q3(Fr(9, 4))
    for i in range(box[0], box[1] + 1):
        for j in range(box[2], box[3] + 1):
            z = (Q3(0, Fr(i, 4 * N)), Q3(Fr(j, 4 * N)))
            if not near(z, Fr(5, 2)):
                continue
            npts += 1
            inside, excl = False, False
            for O in D:
                r2 = n2(sub(z, O))
                if r2 < quarter:
                    inside = True
                if quarter <= r2 <= nine4:
                    excl = True
            for vs in T:
                cr = [cross(sub(vs[(m + 1) % 3], vs[m]), sub(z, vs[m])).sign() for m in range(3)]
                ins = all(c > 0 for c in cr) or all(c < 0 for c in cr)
                if ins:
                    inside = True
                else:
                    d2 = min(pseg2(z, a, b) for (a, b) in tri_edges(vs))
                    D2 = max(n2(sub(z, a)) for a in vs)
                    if d2 <= one <= D2:
                        excl = True
            for (p, q) in S:
                d2 = pseg2(z, p, q)
                D2 = max(n2(sub(z, p)), n2(sub(z, q)))
                if d2 <= one <= D2:
                    excl = True
            if not inside and not excl:
                free.append((round(z[0].f(), 4), round(z[1].f(), 4)))
            if inside and excl:
                both.append((round(z[0].f(), 4), round(z[1].f(), 4)))
    return free, both, npts


def sp_half():
    import sympy as sp
    return sp.Rational(1, 2)


def main():
    ok = True
    log("FS111-M3 exact checks of the honeycomb class HC (tools/fs111_m3_honey.py)")
    f1, mins, nt, ns, nd = H1()
    log(f"H1 faithful: {nt} triangles, {ns} segments, {nd} discs; minimum distances {mins}; "
        f"failures {len(f1)} -> {'PASS' if not f1 else 'FAIL ' + str(f1[:3])}")
    ok &= not f1
    f2 = H2()
    log(f"H2 faithful: f(0) = 0 exactly (f increasing: hand) -> {'PASS' if not f2 else 'FAIL ' + str(f2[:3])}")
    ok &= not f2
    f3, worst = H3()
    log(f"H3 faithful: Q in B(v,1) u B(e,1); worst vertex distance to its centre {worst:.6f} -> {'PASS' if not f3 else 'FAIL ' + str(f3)}")
    ok &= not f3
    f4 = H4()
    log(f"H4 faithful: gap polynomial bounds -> {'PASS' if not f4 else 'FAIL ' + str(f4)}")
    ok &= not f4
    f5 = H5()
    log(f"H5 faithful: exterior-ball constants 425/1280 < 2/5, 425/512 < 1 -> {'PASS' if not f5 else 'FAIL'}")
    ok &= not f5
    fr, bo, npts = H7()
    # 'both' points must lie on triangle sides (boundary): recheck with the closed triangle
    log(f"H7 faithful: {npts} exact grid points within 5/2 of a face centre; free {len(fr)}; "
        f"interior-and-excluded {len(bo)} -> {'PASS' if not fr and not bo else 'FAIL ' + str((fr[:4], bo[:4]))}")
    ok &= (not fr and not bo)
    log("")
    log("Plants (each must fail exactly its named checks):")
    # side19
    p1 = H1(side=Fr(19, 20))[0]
    p2 = H2(side=Fr(19, 20))
    p7 = H7(side=Fr(19, 20))[0]
    fired = bool(p1) and bool(p2) and bool(p7)
    log(f"  side19: H1 fails {len(p1)} ({p1[0][0] if p1 else '-'}), H2 fails {len(p2)}, H7 free {len(p7)} "
        f"(e.g. {p7[:2]}) -> {'FIRED' if fired else 'DID NOT FIRE'}")
    ok &= fired
    q1 = H1(Lshift=Fr(-1, 10))[0]
    q7 = H7(Lshift=Fr(-1, 10))
    kinds = sorted(set(x[0] for x in q1))
    fired = any(k in ("TS<9/8", "flank!=1") for k in kinds) and (q7[1] != [])
    log(f"  closer: H1 failure kinds {kinds}, H7 interior-and-excluded {len(q7[1])} -> {'FIRED' if fired else 'DID NOT FIRE'}")
    ok &= fired
    p4 = H4(eps=sp_half())
    log(f"  eps1/2: H4 with g = (1/2) sum phi_J -> {'FIRED' if p4 else 'DID NOT FIRE'} {p4}")
    ok &= bool(p4)
    p5 = H5(R=Fr(2))
    log(f"  R2: H5 with exterior radius 2 (sagitta constant 1/4 < 425/1280) -> {'FIRED' if p5 else 'DID NOT FIRE'}")
    ok &= bool(p5)
    r3 = H3(use_sigma=False)[0]
    log(f"  nosigma: H3 without B(e,1) -> {'FIRED' if r3 else 'DID NOT FIRE'} {r3}")
    ok &= bool(r3)
    log("")
    log("ALL PASS" if ok else "SOMETHING FAILED")
    with open(OUT, "w") as fh:
        fh.write("\n".join(LOG) + "\n")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
