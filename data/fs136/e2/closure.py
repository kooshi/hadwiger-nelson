#!/usr/bin/env python3
"""FS136-E2 — labelled corners, their classes, the table at a point, and the forced closure: EXACT.

  python3 data/fs136/e2/closure.py close  r7|flower|strip1|strip2 [--rounds=N] [--plane] [--fault=bar] [--brief]
                                                                 (--plane: the closure in the whole plane, the object's edge ignored)
  python3 data/fs136/e2/closure.py window [--fault=bar]        C136-FORCED's control at seven: every pair of lattice points of R7
                                                                 less than 2 apart in a window, the table at each common unit point
  python3 data/fs136/e2/closure.py stops  [--fault=move]       C136-STOP-GERMS: the strip's, the disk's, the bowtie fragment's stop
                                                                 (and the flower's, the first round's own germ entry, as a positive)
  python3 data/fs136/e2/closure.py selftest                    the arithmetic and the classifier on cases worked by hand

OBJECTS.  A CURVE at a point x is a ray from x or a circular arc starting at x: (direction d, side s of its centre: +1 left,
0 a ray, -1 right, squared radius r2).  Curves at one point are ordered counter-clockwise by direction and, in one direction,
by signed curvature s / radius.  A CORNER (lo, hi) at x is the region between lo and hi counter-clockwise, near x; a labelled
corner carries a label.  For |w - x| = 1 the unit circle S(w) has two branches at x; the corner is INNER at w iff it lies
between the branch b- and the branch b+ (the side of w), OUTER iff between b+ and b-, CROSSING otherwise (C136-CLASS).
THE TABLE at w: the members are the points of the family at distance exactly 1 from w; their unit circles cut 2m corners at w
(C136-CORNERS); on a corner a label is BARRED if some corner of that label at a member x is not inner at w when the corner at w
is inside S(x), not outer when it is outside.  One label unbarred: FORCED (C136-FORCED).  None: EMPTIED.  Two or more: FREE.
THE CLOSURE in U: rounds; in each, the table at every point one unit from two or more points of the family, and — for a point
of the family carrying at least k - 1 labels — along its whole unit circle (one sample per open arc between critical
directions, and the critical points); forced corners at points of U join the family at the end of the round; stop when a round
adds none.  A forced corner inside a corner the family already has with that label is not new; one that overlaps a corner of
another label at its point is a CONFLICT (the colouring would have two labels on an open set).

ARITHMETIC.  tools/fs114_yb_exact.py (imported, not edited): towers Q(sqrt d_1)...(sqrt d_n) with exact signs.  Added here:
sqrt_in (is x a square in the current tower? exact, by descent through the levels) and tsqrt (the root, extending the tower
only when it is not there), so the tower stays a tower of fields.  EVERY decision of a table is an exact sign; floats are used
to pre-filter distances (then confirmed exactly), to print, and in the two float CONTROLS:
  class-samples   every class the tables used is re-read by sampling the corner in floats at two radii (another code path);
  agree           every forced corner at a point inside the object is sampled against the object's own colour function.
--fault=bar   one planted wrong bar.  window: the first corner of each pair is read as crossing wherever it is inner.
              close: the label the clean first round forces first (if it forces none: the least label left on its first free
              corner) is barred on every corner of every table - a forced corner must then be emptied, or a free one forced.
--fault=move  (stops) the point across moved by (1/50, 0): no member is one unit away and nothing is concluded.
--fault=bend  (selftest) the order of curves ignores curvature: the tangent cases must then fail.
"""
import sys, os, math, functools, json
from fractions import Fraction as Fr
HERE = os.path.dirname(os.path.abspath(__file__)); ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
for p in ("tools", os.path.join("data", "fs124", "e1"), os.path.join("data", "fs136", "e1")):
    sys.path.insert(0, os.path.join(ROOT, p))
ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
OPT = {a[2:].split("=")[0]: (a.split("=", 1)[1] if "=" in a else True) for a in sys.argv[1:] if a.startswith("--")}
sys.argv = [sys.argv[0]]
import fs114_yb_exact as K
TAU = 2 * math.pi
FAULT = OPT.get("fault")


# ----------------------------------------------------------------------------------------------- arithmetic
class F:
    T = None          # the current tower; only ever extended


def sqrt_in(x, k):
    """a Num s of the current tower with s*s == x, x an element of level <= k; None if x is no square at level k."""
    T = F.T
    if k == 0:
        v = x.v
        if v < 0: return None
        rn, rd = math.isqrt(v.numerator), math.isqrt(v.denominator)
        return K.Num(T, 0, Fr(rn, rd)) if rn * rn == v.numerator and rd * rd == v.denominator else None
    if x.k < k: a, b = x, None
    else:
        a, b = K.Num(T, k - 1, x.v[0]), K.Num(T, k - 1, x.v[1])
        if b.sign() == 0: b = None
    D, g = K.Num(T, k - 1, T.D[k - 1]), T.gen(k)
    if b is None:
        s = sqrt_in(a, k - 1)
        if s is not None: return s
        t = sqrt_in(a / D, k - 1)
        return None if t is None else t * g
    n = sqrt_in(a * a - b * b * D, k - 1)
    if n is None: return None
    for sg in (1, -1):
        s2 = (a + sg * n) / 2
        if s2.sign() <= 0: continue
        s = sqrt_in(s2, k - 1)
        if s is not None: return s + (b / (2 * s)) * g
    return None


def tsqrt(x):
    x = F.T(x); sx = x.sign()
    assert sx >= 0, "root of a negative number"
    if sx == 0: return F.T(0)
    r = sqrt_in(x, len(F.T.D))
    if r is None:
        F.T = F.T.extend(x, f"r{len(F.T.D) + 1}"); r = F.T.gen(len(F.T.D))
    assert (r * r - x).sign() == 0
    return r if r.sign() > 0 else -r


def sub(a, b): return (a[0] - b[0], a[1] - b[1])
def add(a, b): return (a[0] + b[0], a[1] + b[1])
def n2(a): return a[0] * a[0] + a[1] * a[1]
def crs(a, b): return a[0] * b[1] - a[1] * b[0]
def dot(a, b): return a[0] * b[0] + a[1] * b[1]
def fl(p): return (float(p[0]), float(p[1]))


class Pts:
    """the registry of exact points: an index per point, found by float distance and confirmed exactly."""
    def __init__(s): s.P = []; s.f = []
    def id(s, p):
        p = (F.T(p[0]), F.T(p[1])); q = fl(p)
        for i, g in enumerate(s.f):
            if abs(g[0] - q[0]) < 1e-7 and abs(g[1] - q[1]) < 1e-7 and K.veq(s.P[i], p): return i
        s.P.append(p); s.f.append(q); return len(s.P) - 1


def is_unit(p, q):
    d = sub(p, q)
    return abs(float(d[0]) ** 2 + float(d[1]) ** 2 - 1) < 1e-6 and (n2(d) - 1).sign() == 0


def cups(x, y):
    """the points one unit from both x and y (none, one when |x - y| = 2, or two)."""
    v = sub(y, x); d2 = n2(v); f = float(d2)
    if f < 1e-12 or f > 4 + 1e-6: return []
    s4 = (d2 - 4).sign()
    if s4 > 0: return []
    mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2)
    if s4 == 0: return [mid]
    s = tsqrt((4 - d2) / (4 * d2))
    return [(mid[0] - s * v[1], mid[1] + s * v[0]), (mid[0] + s * v[1], mid[1] - s * v[0])]


# ----------------------------------------------------------------------------------------------- curves, corners, classes
class Curve:
    __slots__ = ("d", "s", "r2", "c", "h")
    def __init__(s_, d, s, r2=None, c=None):
        s_.d, s_.s, s_.r2, s_.c = (F.T(d[0]), F.T(d[1])), s, r2, c
        sy = s_.d[1].sign()
        s_.h = 0 if sy > 0 else (1 if sy < 0 else (0 if s_.d[0].sign() > 0 else 1))


def cmp_dir(a, b):
    if a.h != b.h: return -1 if a.h < b.h else 1
    return -crs(a.d, b.d).sign()


def cmp_curve(a, b):
    c = cmp_dir(a, b)
    if c or FAULT == "bend": return c
    if a.s != b.s: return -1 if a.s < b.s else 1
    if a.s == 0: return 0
    g = (b.r2 - a.r2).sign()
    return g if a.s > 0 else -g


def cle(base, x, y, cmp=cmp_curve, strict=False):
    """x before y (or equal, unless strict) in the cyclic order counted counter-clockwise from base."""
    rx, ry = cmp(x, base) < 0, cmp(y, base) < 0
    if rx != ry: return not rx
    c = cmp(x, y)
    return c < 0 if strict else c <= 0


def within(lo, hi, a, b, cmp=cmp_curve):
    """the corner (lo, hi) lies in the closed corner (a, b):  a <= lo < hi <= b counted from a."""
    return cle(a, lo, hi, cmp, True) and cle(a, hi, b, cmp)


def branches(x, w):
    """the two branches at x of the unit circle about w (|w - x| = 1): (b-, b+); inside S(w) is from b- to b+."""
    e = sub(w, x); one = F.T(1)
    return Curve((e[1], -e[0]), 1, one, w), Curve((-e[1], e[0]), -1, one, w)


class Corner:
    def __init__(s, label, lo, hi, src): s.label, s.lo, s.hi, s.src = label, lo, hi, src


def klass_exact(lo, hi, x, w):
    bm, bp = branches(x, w)
    if within(lo, hi, bm, bp): return "inner"
    if within(lo, hi, bp, bm): return "outer"
    return "crossing"


def first_order(lo, hi, x, w, want):
    """does the corner's cone of directions hold one strictly on the wrong side of the tangent to S(w) at x?
    want = 'inner': a direction strictly away from w; want = 'outer': one strictly toward w.  (Else the bar is second order.)"""
    if cmp_dir(lo, hi) == 0 and cmp_curve(lo, hi) > 0: return True          # the corner is all directions
    bm, bp = branches(x, w)
    a, b = (bm, bp) if want == "inner" else (bp, bm)
    ok = cle(a, lo, hi, cmp_dir) and cle(a, hi, b, cmp_dir) and not (cmp_dir(lo, a) != 0 and cmp_dir(hi, a) == 0)
    return not ok


# ---- floats: the sampling control
def cpt(cv, x, t):
    d = fl(cv.d); n = math.hypot(*d); d = (d[0] / n, d[1] / n)
    if cv.s == 0: return (x[0] + t * d[0], x[1] + t * d[1])
    c = fl(cv.c); rho = math.hypot(x[0] - c[0], x[1] - c[1]); al = 2 * math.asin(min(1.0, t / (2 * rho))) * cv.s
    vx, vy = x[0] - c[0], x[1] - c[1]
    return (c[0] + vx * math.cos(al) - vy * math.sin(al), c[1] + vx * math.sin(al) + vy * math.cos(al))


def samples(lo, hi, x, ts=(2e-3, 5e-4), frs=(0.03, 0.2, 0.5, 0.8, 0.97)):
    x = fl(x); out = []
    for t in ts:
        p, q = cpt(lo, x, t), cpt(hi, x, t)
        a0 = math.atan2(p[1] - x[1], p[0] - x[0]); sp = (math.atan2(q[1] - x[1], q[0] - x[0]) - a0) % TAU
        e = min(0.05 * t, sp / 3)                      # two samples hugging the edges: where a tangent edge shows at second order
        for a in [a0 + fr * sp for fr in frs] + [a0 + e, a0 + sp - e]: out.append((x[0] + t * math.cos(a), x[1] + t * math.sin(a)))
    return out


def klass_float(lo, hi, x, w):
    w = fl(w); v = [(q[0] - w[0]) ** 2 + (q[1] - w[1]) ** 2 - 1 for q in samples(lo, hi, x)]
    if all(a < 1e-12 for a in v): return "inner"
    if all(a > -1e-12 for a in v): return "outer"
    return "crossing"


# ----------------------------------------------------------------------------------------------- corners of an object's tiles
def curve_fwd(pc, at_start=True):
    v = pc.P if at_start else pc.Q
    if pc.kind == "S": return Curve(sub(pc.Q, pc.P), 0)
    r = sub(v, pc.C); t = (-r[1], r[0]) if pc.ccw else (r[1], -r[0])
    return Curve(t, 1 if pc.ccw else -1, pc.rho * pc.rho, pc.C)


def curve_back(pc, v=None):
    v = pc.Q if v is None else v
    if pc.kind == "S": return Curve(sub(pc.P, pc.Q), 0)
    r = sub(v, pc.C); t = (r[1], -r[0]) if pc.ccw else (-r[1], r[0])
    return Curve(t, -1 if pc.ccw else 1, pc.rho * pc.rho, pc.C)


def on_open_piece(v, pc):
    if pc.kind == "S":
        e = sub(pc.Q, pc.P); u = sub(v, pc.P)
        if abs(float(crs(u, e))) > 1e-6: return False
        return crs(u, e).sign() == 0 and dot(u, e).sign() > 0 and (dot(u, e) - n2(e)).sign() < 0
    r = sub(v, pc.C)
    return abs(float(n2(r)) - float(pc.rho) ** 2) < 1e-6 and (n2(r) - pc.rho * pc.rho).sign() == 0 and crs(pc.a, r).sign() > 0 and crs(r, pc.e).sign() > 0


def corners_at(tiles, v):
    """the labelled corners at v of the tiles that have v on their boundary, counter-clockwise; and whether they fill a
    neighbourhood of v (each corner's upper edge is the next one's lower edge, all round)."""
    out = []; vf = fl(v)
    for t in tiles:
        ccw = t.area_float() > 0; n = len(t.pieces)
        for i, pc in enumerate(t.pieces):
            qf = fl(pc.Q)
            if abs(qf[0] - vf[0]) < 1e-7 and abs(qf[1] - vf[1]) < 1e-7 and K.veq(pc.Q, v):
                o, b = curve_fwd(t.pieces[(i + 1) % n]), curve_back(pc)
                out.append(Corner(t.colour, o, b, t.name) if ccw else Corner(t.colour, b, o, t.name))
            elif on_open_piece(v, pc):
                if pc.kind == "S": o, b = Curve(sub(pc.Q, pc.P), 0), Curve(sub(pc.P, pc.Q), 0)
                else:
                    r = sub(v, pc.C); tg = (-r[1], r[0]) if pc.ccw else (r[1], -r[0])
                    o, b = Curve(tg, 1 if pc.ccw else -1, pc.rho * pc.rho, pc.C), curve_back(pc, v)
                out.append(Corner(t.colour, o, b, t.name) if ccw else Corner(t.colour, b, o, t.name))
    out.sort(key=functools.cmp_to_key(lambda a, b: cmp_curve(a.lo, b.lo)))
    full = bool(out) and all(cmp_curve(out[i].hi, out[(i + 1) % len(out)].lo) == 0 for i in range(len(out)))
    return out, full


class Pc:
    """a boundary piece of a tile of tools/fs112_yb2_objects.py, its numbers carried into the current tower: a segment
    P-Q, or an arc from S to E counter-clockwise about C.  Those tiles list their pieces without a direction of travel."""
    def __init__(s, kind, A, B, C=None, rho=None): s.kind, s.P, s.Q, s.C, s.rho = kind, A, B, C, rho


def conv_native(T):
    """the tiles' numbers (towers of fs112_yb2_check: nested pairs over a list of radicands) rebuilt in a tower of FIELDS:
    each radicand's root is taken by tsqrt, which adjoins it only if it is not already there."""
    x0 = next(iter(T.values()))[1][0]; x0 = (x0.P if x0.kind == "S" else x0.S)[0]; ds = x0.T.ds
    F.T = K.Tower.base(); gens = []
    def cv(v, k):
        if k == 0: return F.T(Fr(v))
        return cv(v[0], k - 1) + cv(v[1], k - 1) * gens[k - 1]
    for i, d in enumerate(ds): gens.append(tsqrt(cv(d, i)))
    num = lambda x: cv(x.v, len(x.T.ds)); pt = lambda q: (num(q[0]), num(q[1]))
    return {nm: (c, [Pc("S", pt(pc.P), pt(pc.Q)) if pc.kind == "S" else Pc("A", pt(pc.S), pt(pc.E), pt(pc.C), num(pc.rho)) for pc in ps]) for nm, (c, ps) in T.items()}


def corners_native(T, v, tilefn):
    """as corners_at, for tiles whose pieces carry no direction of travel: at v each tile has two curves (along the two
    pieces that end at v, or both ways along the piece v is inside); of the two corners they bound, the tile's is the one
    whose float sample the object's own point-location puts in that tile."""
    out = []; vf = fl(v)
    for nm, (col, ps) in T.items():
        cvs = []
        for pc in ps:
            for end, other in ((pc.P, pc.Q), (pc.Q, pc.P)):
                ef = fl(end)
                if abs(ef[0] - vf[0]) < 1e-7 and abs(ef[1] - vf[1]) < 1e-7 and K.veq(end, v):
                    if pc.kind == "S": cvs.append(Curve(sub(other, end), 0))
                    else:
                        r = sub(v, pc.C); first = end is pc.P
                        cvs.append(Curve((-r[1], r[0]) if first else (r[1], -r[0]), 1 if first else -1, pc.rho * pc.rho, pc.C))
            inside = False
            if pc.kind == "S":
                e = sub(pc.Q, pc.P); u = sub(v, pc.P)
                inside = abs(float(crs(u, e))) < 1e-6 and crs(u, e).sign() == 0 and dot(u, e).sign() > 0 and (dot(u, e) - n2(e)).sign() < 0
                if inside: cvs += [Curve(e, 0), Curve((-e[0], -e[1]), 0)]
            else:
                r = sub(v, pc.C)
                inside = (abs(float(n2(r)) - float(pc.rho) ** 2) < 1e-6 and (n2(r) - pc.rho * pc.rho).sign() == 0
                          and crs(sub(pc.P, pc.C), r).sign() > 0 and crs(r, sub(pc.Q, pc.C)).sign() > 0)
                if inside: cvs += [Curve((-r[1], r[0]), 1, pc.rho * pc.rho, pc.C), Curve((r[1], -r[0]), -1, pc.rho * pc.rho, pc.C)]
        if not cvs: continue
        assert len(cvs) == 2, f"tile {nm}: {len(cvs)} curves at the point"
        a, b = cvs
        pick = [(lo, hi) for lo, hi in ((a, b), (b, a)) if all(tilefn(q) == nm for q in samples(lo, hi, v)[:5])]
        assert len(pick) == 1, f"tile {nm}: its corner at the point is not decided by the samples"
        out.append(Corner(col, pick[0][0], pick[0][1], nm))
    out.sort(key=functools.cmp_to_key(lambda a, b: cmp_curve(a.lo, b.lo)))
    full = bool(out) and all(cmp_curve(out[i].hi, out[(i + 1) % len(out)].lo) == 0 for i in range(len(out)))
    return out, full


def locate(tiles, q):
    best = None
    for t in tiles:
        for pc in t.pieces:
            for v in (pc.P, pc.Q):
                d = math.hypot(float(v[0]) - q[0], float(v[1]) - q[1])
                if best is None or d < best[0]: best = (d, v)
    assert best[0] < 1e-6, f"no vertex at {q}"
    return best[1]


def top_tower(tiles):
    T = None
    for t in tiles:
        for pc in t.pieces:
            for v in (pc.P, pc.Q):
                for c in v:
                    if isinstance(c, K.Num) and (T is None or len(c.T.D) > len(T.D)): T = c.T
    return T


# ----------------------------------------------------------------------------------------------- the objects
def obj_r7(lo=-3, hi=4):
    import tight_checks as TC
    F.T = K.Tower.base().extend(3, "3"); r3 = F.T.gen(1); one = F.T(1)
    L = lambda m, n: (F.T(m) + F.T(Fr(n, 2)), r3 * Fr(n, 2))
    tiles = []
    for m in range(lo, hi):
        for n in range(lo, hi):
            A, B, C = L(m, n), L(m + 1, n), L(m, n + 1)
            tiles.append(K.Tile(f"u{m},{n}", 2 * (m % 2) + (n % 2), [K.Arc(A, one, B, C, True), K.Arc(B, one, C, A, True), K.Arc(C, one, A, B, True)]))
            D1, D2, D3 = L(m + 1, n), L(m, n + 1), L(m + 1, n + 1)
            tiles.append(K.Tile(f"d{m},{n}", 4 + ((m - n) % 3), [K.Arc(L(m, n), one, D1, D2, True), K.Arc(L(m, n + 2), one, D2, D3, True), K.Arc(L(m + 2, n), one, D3, D1, True)]))
    for t in tiles:                                    # the labels against the first round's colour function, at centroids
        g = [sum(float(pc.P[i]) for pc in t.pieces) / 3 for i in (0, 1)]
        assert TC.r7col(g) == t.colour, t.name
    return dict(name="r7", tiles=tiles, L=L, labels=frozenset(range(7)), inU=lambda w: True, col=TC.r7col, U="the plane",
                corners=lambda v: corners_at(tiles, v))


def obj_tiles(name):
    import rings_read as RR
    if name in ("strip", "disk"):
        import fs112_yb2_objects as O, fs116_n1_ring as RG
        nat = O.Strip().tiles(-4, 6) if name == "strip" else O.Disk().tiles()
        col, tile, verts = RR.tiles_col(RG.fl_tiles(nat)); T = conv_native(nat)
        allv = [v for c, ps in T.values() for pc in ps for v in (pc.P, pc.Q)]
        def loc(q):
            d, v = min(((math.hypot(float(v[0]) - q[0], float(v[1]) - q[1]), i), v) for i, v in enumerate(allv))
            assert d[0] < 1e-6, f"no vertex at {q}"
            return v
        corners = lambda v: corners_native(T, v, tile); labels = frozenset(c for c, ps in T.values())
    else:
        if name == "flower":
            import fs116_y2_six as Y2
            tiles = list(Y2.fragment()[3]); floatname = "sixfrag"
        else:
            import fs114_y2_k1 as K1
            tiles = list(K1.build()); floatname = "bowtie"
        F.T = top_tower(tiles)
        col, tile, verts = RR.tiles_col(RR.load(floatname))
        loc = lambda q: locate(tiles, q); corners = lambda v: corners_at(tiles, v); labels = frozenset(t.colour for t in tiles)
    inside = lambda w: RR.circle_labels(col, fl(w), 2e-2) is not None and RR.circle_labels(col, fl(w), 1e-2) is not None
    ob = dict(name=name, labels=labels, col=col, corners=corners, locate=loc, inU=inside, U="the object as its float reader reads it (two small circles about the point)")
    if name == "flower": ob.update(inU=lambda w: (n2(w) - Fr(9, 4)).sign() < 0, U="the open disc of radius 3/2")
    return ob


SEEDS = {"r7": ("r7", None), "flower": ("flower", [(-1.0, 0.0), (0.0, -1.0)]), "strip1": ("strip", [(0.0, 0.0), (0.5, 0.0)]),
         "strip2": ("strip", [(-0.25, math.sqrt(15) / 4), (0.5, math.sqrt(3) / 2)])}


# ----------------------------------------------------------------------------------------------- the table and the closure
class Run:
    def __init__(s, labels):
        s.R = Pts(); s.fam = {}; s.labels = labels; s.kc = {}; s.ncls = 0; s.nmis = 0; s.first = None; s.plant = None

    def add(s, p, corners):
        i = s.R.id(p); s.fam.setdefault(i, []).extend(corners)
        if s.first is None and corners: s.first = corners[0]
        return i

    def klass(s, g, xi, wi):
        key = (id(g), wi)
        if key not in s.kc:
            x, w = s.R.P[xi], s.R.P[wi]
            e = klass_exact(g.lo, g.hi, x, w); f = klass_float(g.lo, g.hi, x, w)
            s.ncls += 1; s.nmis += e != f
            if FAULT == "bar" and g is s.first and e == "inner": e = "crossing"
            s.kc[key] = e
        return s.kc[key]

    def table(s, wi, members=None):
        w = s.R.P[wi]
        mem = [i for i in s.fam if i != wi and s.fam[i] and is_unit(s.R.P[i], w)] if members is None else members
        brs = []
        for i in mem:
            bm, bp = branches(w, s.R.P[i]); brs += [(bm, i), (bp, i)]
        brs.sort(key=functools.cmp_to_key(lambda a, b: cmp_curve(a[0], b[0])))
        out = []
        for j in range(len(brs)):
            lo, hi = brs[j][0], brs[(j + 1) % len(brs)][0]
            sides, bars = {}, {}
            for i in mem:
                bm, bp = branches(w, s.R.P[i])
                if within(lo, hi, bm, bp): sides[i] = "in"
                else:
                    assert within(lo, hi, bp, bm), "a corner of the arrangement on no side of a member's circle"
                    sides[i] = "out"
                need = "inner" if sides[i] == "in" else "outer"
                for g in s.fam[i]:
                    cl = s.klass(g, i, wi)
                    if cl != need: bars.setdefault(g.label, []).append((i, g, cl, need))
            if s.plant is not None: bars.setdefault(s.plant, []).append((mem[0], Corner(s.plant, None, None, "PLANTED"), "planted", "planted"))
            out.append(dict(lo=lo, hi=hi, sides=sides, bars=bars, left=s.labels - set(bars)))
        return mem, out

    def status(s, wi, c, lab):
        """a forced corner against the corners the family already has at its point: 'held', 'conflict' or 'new'."""
        st = "new"
        for g in s.fam.get(wi, []):
            if within(c["lo"], c["hi"], g.lo, g.hi):
                if g.label == lab: st = "held"
                else: return "conflict"
            elif not within(c["lo"], c["hi"], g.hi, g.lo) and g.label != lab: return "conflict"
        return st

    def scan(s, xi):
        """along the whole unit circle of a point carrying at least k - 1 labels: one sample per open arc between critical
        directions (edges of its corners turned by a quarter; directions to common unit points with other members)."""
        x = s.R.P[xi]; crit = []
        for g in s.fam[xi]:
            for cv in (g.lo, g.hi):
                n = tsqrt(n2(cv.d)); d = (cv.d[0] / n, cv.d[1] / n)
                crit += [(-d[1], d[0]), (d[1], -d[0])]
        for i in s.fam:
            if i != xi and s.fam[i]: crit += [sub(w, x) for w in cups(x, s.R.P[i])]
        cs = []
        for e in crit:
            c = Curve(e, 0)
            if not any(cmp_dir(c, o) == 0 for o in cs): cs.append(c)
        cs.sort(key=functools.cmp_to_key(cmp_dir))
        res = []
        for j, c1 in enumerate(cs):
            c2 = cs[(j + 1) % len(cs)]
            for k in range(1, 40):
                u = Fr(1, 2 ** k); co, si = (1 - u * u) / (1 + u * u), 2 * u / (1 + u * u)
                e = (c1.d[0] * co - c1.d[1] * si, c1.d[0] * si + c1.d[1] * co); ce = Curve(e, 0)
                if cmp_dir(c1, ce) != 0 and (len(cs) == 1 or (cle(c1, ce, c2, cmp_dir, True))): break
            wi = s.R.id(add(x, e))
            mem, tab = s.table(wi, [xi])
            res.append(("arc", wi, tab))
        for c1 in cs:
            wi = s.R.id(add(x, c1.d))
            mem, tab = s.table(wi)
            if mem == [xi]: res.append(("point", wi, tab))
        return res


def ang(cv): return math.degrees(math.atan2(float(cv.d[1]), float(cv.d[0]))) % 360
def cstr(c): return f"[{ang(c['lo']):.1f}{'+-0'[c['lo'].s - 1] if c['lo'].s else ''},{ang(c['hi']):.1f}{'+-0'[c['hi'].s - 1] if c['hi'].s else ''}]"
def pstr(p): return f"({float(p[0]):.5f},{float(p[1]):.5f})"
def lstr(ls): return "".join(sorted(map(str, ls))) or "EMPTY"


def close(seed):
    oname, where = SEEDS[seed]
    ob = obj_r7() if oname == "r7" else obj_tiles(oname)
    if OPT.get("plane"): ob["inU"] = lambda w: True; ob["U"] = "the plane (the object's edge ignored: the seed alone)"; seed_out = seed + ".plane"
    else: seed_out = seed
    run = Run(ob["labels"]); k = len(ob["labels"])
    pts = [ob["L"](0, 0), ob["L"](1, 0)] if oname == "r7" else [ob["locate"](q) for q in where]
    seedids = []; nseed = 0; fullness = []
    for p in pts:
        cs, full = ob["corners"](p); fullness.append(full); nseed += len(cs)
        seedids.append(run.add(p, cs))
    if FAULT == "bar":          # the plant, for a closure: one wrong bar - the label of the first corner the clean first round forces
        run.first = None        # (or, if it forces none, the least label left on its first free corner) is barred on every corner
        ids = list(run.fam); cand = sorted({run.R.id(w) for a in ids for b in ids if a < b for w in cups(run.R.P[a], run.R.P[b])})
        tabs = [c for wi in cand for c in run.table(wi)[1]]
        one = [c for c in tabs if len(c["left"]) == 1] or [c for c in tabs if c["left"]]
        run.plant = sorted(one[0]["left"], key=str)[0]
    steps = []; lines = []; rounds = int(OPT.get("rounds", 8)); closed = False; emptied = []; conflicts = []; arcforced = 0
    for r in range(1, rounds + 1):
        ids = [i for i in run.fam if run.fam[i]]; cand = set()
        for a in range(len(ids)):
            for b in range(a + 1, len(ids)):
                for w in cups(run.R.P[ids[a]], run.R.P[ids[b]]): cand.add(run.R.id(w))
        new = []; view = []; emptied = []; conflicts = []; scans = []; arcforced = 0
        for wi in sorted(cand):
            w = run.R.P[wi]; inu = ob["inU"](w); mem, tab = run.table(wi)
            for c in tab:
                st = "empty" if not c["left"] else ("forced" if len(c["left"]) == 1 else "free")
                if st == "empty": emptied.append((wi, c, inu))
                if st == "forced" and inu:
                    lab = next(iter(c["left"])); h = run.status(wi, c, lab)
                    if h == "conflict": conflicts.append((wi, c, lab))
                    if h == "new": new.append((wi, c, lab))
                    st = "forced:" + h
                view.append((wi, inu, mem, c, st))
        for xi in ids:
            if len({g.label for g in run.fam[xi]}) >= k - 1:
                sc = run.scan(xi); scans.append((xi, sc))
                arcforced += sum(1 for kind, wi, tab in sc if kind == "arc" for c in tab if len(c["left"]) <= 1)
        for wi, c, lab in new:
            run.fam.setdefault(wi, []).append(Corner(lab, c["lo"], c["hi"], f"forced, round {r}"))
            steps.append(dict(round=r, point=fl(run.R.P[wi]), corner=cstr(c), label=str(lab),
                              sides={pstr(run.R.P[i]): sd for i, sd in c["sides"].items()},
                              bars={str(a): [dict(member=fl(run.R.P[i]), corner_of=g.src, label=str(g.label), klass=cl, needed=need) for i, g, cl, need in bs] for a, bs in c["bars"].items()}))
        lines.append(f"round {r}: points read {len(cand)}; forced corners added {len(new)}; emptied {len(emptied)}; conflicts {len(conflicts)}; tower height {len(F.T.D)}")
        if not new: closed = True; break
    # ---- the last round's view is the closure's table
    forced = [(wi, g) for wi in run.fam for g in run.fam[wi] if g.src.startswith("forced")]
    cnt = {}
    for wi, inu, mem, c, st in view:
        key = ("seed-point " if wi in seedids else ("" if inu else "outside-U ")) + st.split(":")[0]
        cnt[key] = cnt.get(key, 0) + 1
    agree = bad = unread = 0
    for wi, g in forced:
        cols = [ob["col"](q) for q in samples(g.lo, g.hi, run.R.P[wi])]
        if None in cols: unread += 1
        elif all(c == g.label for c in cols): agree += 1
        else: bad += 1
    fpts = sorted({wi for wi, g in forced})
    brief = (f"{seed}: seed={nseed} corners at {len(pts)} points (full neighbourhoods: {all(fullness)}) labels={k} | rounds={r} closed={'yes' if closed else 'NO'} | "
             f"forced={len(forced)} at {len(fpts)} points | emptied={len(emptied)} conflicts={len(conflicts)} | arc-scans={len(scans)} arc-forced={arcforced} | "
             f"corners read: " + " ".join(f"{a}={b}" for a, b in sorted(cnt.items())) + f" | agree-with-object={agree} of {len(forced)} (disagree {bad}, unread {unread}) | "
             f"class-samples={run.ncls} mismatches={run.nmis}")
    print(brief)
    if OPT.get("brief"): return 0
    out = [brief, f"U = {ob['U']}; fault = {FAULT}"] + lines + ["", "THE SEED"]
    for i in seedids:
        out.append(f"  {pstr(run.R.P[i])}: " + " ".join(f"{g.label}:{cstr(dict(lo=g.lo, hi=g.hi))}({g.src})" for g in run.fam[i] if not g.src.startswith("forced")))
    out += ["", "THE FORCED CORNERS (the closure less the seed)"]
    for wi, g in forced:
        out.append(f"  {pstr(run.R.P[wi])} label {g.label} corner {cstr(dict(lo=g.lo, hi=g.hi))} ({g.src})")
    out += ["", "THE TABLE AT EVERY POINT ONE UNIT FROM TWO OR MORE POINTS OF THE CLOSURE (last round)"]
    free = []
    for wi, inu, mem, c, st in view:
        out.append(f"  {pstr(run.R.P[wi])} {'in U' if inu else 'OUTSIDE U'}{' SEED POINT' if wi in seedids else ''} members {' '.join(pstr(run.R.P[i]) + ':' + c['sides'][i] for i in mem)} "
                   f"corner {cstr(c)} left={lstr(c['left'])} {st}")
        if st == "free" and inu and wi not in seedids:
            free.append(f"search request | seed {seed} | point {pstr(run.R.P[wi])} | corner {cstr(c)} ({' '.join(c['sides'][i] + ' S' + pstr(run.R.P[i]) for i in mem)}) | labels left {lstr(c['left'])}")
    out += ["", "ALONG THE UNIT CIRCLES OF POINTS CARRYING AT LEAST k - 1 LABELS"]
    for xi, sc in scans:
        for kind, wi, tab in sc:
            out.append(f"  about {pstr(run.R.P[xi])} {kind} at {pstr(run.R.P[wi])}: " + " ".join(f"{c['sides'][xi]}:left={lstr(c['left'])}" for c in tab))
    os.makedirs(os.path.join(HERE, "out"), exist_ok=True)
    if not FAULT:
        open(os.path.join(HERE, "out", f"{seed_out}.txt"), "w").write("\n".join(out) + "\n")
        json.dump(steps, open(os.path.join(HERE, "out", f"{seed_out}.steps.json"), "w"), indent=1)
        open(os.path.join(HERE, "out", f"{seed_out}.free.txt"), "w").write("\n".join(free) + ("\n" if free else ""))
    return 0


def window():
    """C136-FORCED at seven: every pair of lattice points less than 2 apart with both in the window; at each common unit
    point the table from the pair's twelve corners, each corner's labels left against the labels R7 has there (exactly)."""
    ob = obj_r7(-4, 5); tiles = ob["tiles"]; L = ob["L"]
    W = [(m, n) for m in range(-1, 3) for n in range(-1, 3)]
    tot = dict(pairs=0, points=0, corners=0, viol=0, forced=0, forced_wrong=0, exact=0, empty=0); ncls = nmis = 0
    cache = {}
    def cor(mn):
        if mn not in cache: cache[mn] = corners_at(tiles, L(*mn))[0]
        return cache[mn]
    for a in range(len(W)):
        for b in range(a + 1, len(W)):
            x, y = L(*W[a]), L(*W[b])
            if float(n2(sub(x, y))) > 3.5: continue
            tot["pairs"] += 1
            run = Run(ob["labels"]); run.add(x, [Corner(g.label, g.lo, g.hi, g.src) for g in cor(W[a])]); run.add(y, [Corner(g.label, g.lo, g.hi, g.src) for g in cor(W[b])])
            for w in cups(x, y):
                wi = run.R.id(w); mem, tab = run.table(wi); here = corners_at(tiles, w)[0]; tot["points"] += 1
                for c in tab:
                    present = {g.label for g in here if not within(c["lo"], c["hi"], g.hi, g.lo)}
                    tot["corners"] += 1; tot["viol"] += not present <= c["left"]; tot["exact"] += present == c["left"]; tot["empty"] += not c["left"]
                    if len(c["left"]) == 1: tot["forced"] += 1; tot["forced_wrong"] += present != c["left"]
            ncls += run.ncls; nmis += run.nmis
    print("r7 window: " + " ".join(f"{k}={v}" for k, v in tot.items()) + f" class-samples={ncls} mismatches={nmis}")
    return 0


STOPS = {"strip": ((0.0, 0.0), (-0.25, math.sqrt(15) / 4), (0.5, math.sqrt(3) / 2)),
         "disk": ((-0.5, 0.16245984811645317), (-1.5, 0.16245984811645317), (-0.80901699437, 1.11351636441)),
         "bowtie": ((0.0, 0.0), (math.sqrt(3) / 2, -0.5), (math.sqrt(3) / 2, 0.5)),
         "flower": ((0.0, 0.0), (math.cos(-math.pi / 6), math.sin(-math.pi / 6)), (math.cos(math.pi / 6), math.sin(math.pi / 6)))}


def stops():
    for name in ARGS[1:] or ["strip", "disk", "bowtie", "flower"]:
        ob = obj_tiles(name); p, x, y = (ob["locate"](q) for q in STOPS[name])
        w = sub(add(x, y), p)
        if FAULT == "move": w = (w[0] + Fr(1, 50), w[1])
        run = Run(ob["labels"]); names = []
        for z in (x, y):
            cs, full = ob["corners"](z); run.add(z, cs); names.append(" ".join(g.src for g in cs) + ("" if full else " (NOT a full neighbourhood)"))
        wi = run.R.id(w); mem, tab = run.table(wi)
        if len(mem) < 2:
            print(f"{name}: w={pstr(w)}: {len(mem)} members one unit away - nothing concluded"); continue
        res = []
        for c in tab:
            sd = "/".join(c["sides"][i] for i in mem)
            if c["left"]: res.append(f"{sd}={lstr(c['left'])}"); continue
            order = 0; second = []
            for a, bs in sorted(c["bars"].items(), key=lambda t: str(t[0])):
                o = min(1 if first_order(g.lo, g.hi, run.R.P[i], w, need) else 2 for i, g, cl, need in bs)
                order = max(order, o)
                if o == 2: second.append(str(a))
            res.append(f"{sd}=EMPTY(order {order}" + (f"; second-order only: {''.join(second)}" if second else "") + ")")
        print(f"{name}: w={pstr(w)} corners at x: {names[0]} | at y: {names[1]} | labels={len(ob['labels'])} | corners at w (x/y): " + " ".join(res) +
              f" | class-samples={run.ncls} mismatches={run.nmis}")
    return 0


def selftest():
    F.T = K.Tower.base().extend(3, "3"); r3 = F.T.gen(1); ok = []
    ok.append(float(tsqrt(F.T(Fr(3, 4)))) > 0 and len(F.T.D) == 1)                     # sqrt(3)/2 is in Q(sqrt 3)
    ok.append((tsqrt(7 + 4 * r3) - (2 + r3)).sign() == 0 and len(F.T.D) == 1)           # sqrt(7 + 4 sqrt 3) = 2 + sqrt 3
    tsqrt(F.T(2)); ok.append(len(F.T.D) == 2)                                           # sqrt 2 is not: the tower grows
    ok.append((tsqrt(F.T(6)) - tsqrt(F.T(2)) * r3).sign() == 0 and len(F.T.D) == 2)     # sqrt 6 = sqrt 2 sqrt 3: no growth
    O = (F.T(0), F.T(0)); w = (F.T(1), F.T(0)); one = F.T(1)
    ray = lambda a, b: Curve((F.T(a), F.T(b)), 0)
    up = Curve((0, 1), -1, one, w); dn = Curve((0, -1), 1, one, w)                      # the branches of S(w) at O
    horn_lo = Curve((0, 1), -1, one, w); far = Curve((0, 1), 1, one, (F.T(-1), F.T(0)))  # between S(w) and S(-w), upward
    cases = [(ray(1, 1), ray(-1, 1), "crossing"), (ray(1, -1), ray(1, 1), "inner"), (ray(-1, 1), ray(-1, -1), "outer"),
             (ray(0, -1), ray(0, 1), "crossing"),      # the right half-plane: its edges are tangent rays, outside S(w)
             (dn, up, "inner"),                        # the disc's own germ
             (horn_lo, far, "outer"),                  # the horn between two unit circles tangent at O
             (ray(0, 1), far, "outer"), (horn_lo, ray(0, 1), "outer"),
             (Curve((0, 1), -1, F.T(Fr(1, 4)), (F.T(Fr(1, 2)), F.T(0))), up, "inner"),   # the horn between a circle of radius 1/2 inside S(w) and S(w)
             (up, Curve((0, 1), -1, F.T(4), (F.T(2), F.T(0))), "outer"),                 # between S(w) and a circle of radius 2 on the same side
             (dn, Curve((0, 1), -1, F.T(Fr(1, 4)), (F.T(Fr(1, 2)), F.T(0))), "inner")]
    for lo, hi, want in cases:
        e, f = klass_exact(lo, hi, O, w), klass_float(lo, hi, O, w); ok.append(e == want and f == want)
    # C136-CORNERS: two members antipodal about O cut four corners, two of them outside both circles; two others cut four with four side vectors
    for mem, want in (([w, (F.T(-1), F.T(0))], ["in/out", "out/in", "out/out", "out/out"]), ([w, (F.T(0), F.T(1))], ["in/in", "in/out", "out/in", "out/out"]),
                      ([w, (F.T(-1), F.T(0)), (F.T(0), F.T(1))], ["in/out/in", "in/out/out", "out/in/in", "out/in/out", "out/out/in", "out/out/out"])):
        run = Run(frozenset()); ids = [run.R.id(q) for q in mem]; oi = run.R.id(O)
        for i in ids: run.fam[i] = []
        try: got = sorted("/".join(c["sides"][i] for i in ids) for c in run.table(oi, ids)[1])
        except AssertionError: got = None
        ok.append(got == want)
    print(f"selftest: {sum(ok)} of {len(ok)} " + ("OK" if all(ok) else "FAILED " + str([i for i, v in enumerate(ok) if not v])))
    return 0 if all(ok) or FAULT else 1


if __name__ == "__main__":
    mode = ARGS[0] if ARGS else ""
    if mode == "close": sys.exit(close(ARGS[1]))
    if mode == "window": sys.exit(window())
    if mode == "stops": sys.exit(stops())
    if mode == "selftest": sys.exit(selftest())
    print(__doc__); sys.exit(2)
