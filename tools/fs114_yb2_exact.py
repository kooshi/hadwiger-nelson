#!/usr/bin/env python3
"""FS114-YB2's exact checker for fragments bounded by segments and circular arcs (written for this job; no FS114-Y2/Y3 file read, and no other
job's distance or sign code borrowed -- FS-112's builders are imported only to convert their held objects).

NUMBERS.  A `Tw` is a tower Q(sqrt d_1)...(sqrt d_n), each d_i a positive element of the level below.  A value of level i is a pair (a, b) meaning
a + b sqrt(d_i), a and b of level i-1; level 0 is a Fraction.  The sign is decided exactly by recursion: sign(a + b sqrt d) = sign a if b = 0,
sign b if a = 0, the common sign if they agree, and sign(a) * sign(a^2 - b^2 d) if they differ (a fact about real numbers, true even when d
happens to be a square lower down).  One more square root is never adjoined: every test below reduces to the sign of k + m sqrt(E) with k, m, E in
the tower (`sgn_km`), decided by the same rule.

GEOMETRY.  A tile is a list of pieces forming its closed boundary: Seg(P, Q), or Arc(C, rho, S, E), the arc of the circle about C of radius rho
from S counter-clockwise to E, spanning more than 0 and at most 180 degrees.

VERDICT for two tiles of one colour (a tile with itself included): REJECT iff min < 1 < max, min and max the least and greatest distance between
points of the two closed tiles, decided against 1 exactly from a COMPLETE list of realised candidates -- every critical pair of |x - y|^2 on
piece x piece: endpoint pairs; an endpoint against the foot on a segment, or against the two points of an arc's circle on the line through the
centre; a segment's foot of an arc's centre against the arc's two points on that normal; two arcs on their line of centres (concentric: any
common or opposite direction) -- plus exact CROSSING tests (a crossing gives distance 0, which no candidate need realise).  Each candidate
distance is |sqrt(D) + k| and is compared with 1 exactly.  Distinct tiles are assumed to have disjoint interiors (the map check supplies it), so
their minimum is attained on the boundaries.  For distinct tiles the NON-SIAMESE test is min >= 1.

POINTS.  straddle(z, tile) iff min < 1 < max over the closed tile, min = 0 when z is in the tile (exact ray count, the ray's slope changed on any
degenerate hit).  A colour is free at z iff no tile of that colour straddles z.

CHECKER PLANTS (each fires only through its own code path): `noself` (skip a tile against itself), `closed` (REJECT iff min <= 1 <= max),
`nocross` (skip crossing tests), `endsonly` (endpoint pairs only), `nointerior` (drop the foot-normal and line-of-centres candidates).
"""
from __future__ import annotations
import math
from fractions import Fraction as Fr

PLANT = set()


# ------------------------------------------------------------------ the tower
def _zero(i):
    return Fr(0) if i == 0 else (_zero(i - 1), _zero(i - 1))


class Tw:
    def __init__(self, ds=(), names=()):
        self.ds = list(ds)          # raw radicands, d_i of level i-1
        self.names = list(names)
        self.n = len(self.ds)
        self.fl = []
        for i, d in enumerate(self.ds):
            self.fl.append(math.sqrt(_flt(d, i, self.fl)))

    def ext(self, x, name):
        x = self.num(x)
        assert x.sign() > 0, "radicand must be positive"
        return Tw(self.ds + [x.v], self.names + [name])

    def num(self, x):
        if isinstance(x, Q):
            return x.up(self)
        return Q(self, _up(Fr(x), 0, self.n))

    def root(self, i):
        """sqrt(d_i), i in 1..n"""
        v = (_zero(i - 1), _up(Fr(1), 0, i - 1))
        return Q(self, _up(v, i, self.n))


def _up(v, i, j):
    for k in range(i, j):
        v = (v, _zero(k))
    return v


def _flt(v, i, fl):
    if i == 0:
        return float(v)
    return _flt(v[0], i - 1, fl) + _flt(v[1], i - 1, fl) * fl[i - 1]


def _add(x, y, i):
    return x + y if i == 0 else (_add(x[0], y[0], i - 1), _add(x[1], y[1], i - 1))


def _neg(x, i):
    return -x if i == 0 else (_neg(x[0], i - 1), _neg(x[1], i - 1))


def _mul(x, y, i, ds):
    if i == 0:
        return x * y
    a, b = x
    c, e = y
    ac = _mul(a, c, i - 1, ds)
    be = _mul(b, e, i - 1, ds)
    return (_add(ac, _mul(be, ds[i - 1], i - 1, ds), i - 1), _add(_mul(a, e, i - 1, ds), _mul(b, c, i - 1, ds), i - 1))


def _sgn(x, i, ds):
    if i == 0:
        return (x > 0) - (x < 0)
    a, b = x
    sa, sb = _sgn(a, i - 1, ds), _sgn(b, i - 1, ds)
    if sb == 0:
        return sa
    if sa == 0:
        return sb
    if sa == sb:
        return sa
    nrm = _add(_mul(a, a, i - 1, ds), _neg(_mul(_mul(b, b, i - 1, ds), ds[i - 1], i - 1, ds), i - 1), i - 1)
    return sa * _sgn(nrm, i - 1, ds)


def _inv(x, i, ds):
    if i == 0:
        if x == 0:
            raise ZeroDivisionError
        return 1 / x
    a, b = x
    nrm = _add(_mul(a, a, i - 1, ds), _neg(_mul(_mul(b, b, i - 1, ds), ds[i - 1], i - 1, ds), i - 1), i - 1)
    if _sgn(nrm, i - 1, ds) == 0:
        raise ZeroDivisionError("conjugate norm vanishes")
    ni = _inv(nrm, i - 1, ds)
    return (_mul(a, ni, i - 1, ds), _neg(_mul(b, ni, i - 1, ds), i - 1))


class Q:
    __slots__ = ("T", "v")

    def __init__(self, T, v):
        self.T, self.v = T, v

    def up(self, T):
        if self.T is T:
            return self
        assert T.ds[:self.T.n] == self.T.ds, "unrelated towers"
        return Q(T, _up(self.v, self.T.n, T.n))

    def _c(self, o):
        if isinstance(o, Q):
            if o.T is self.T:
                return self, o
            if o.T.n >= self.T.n:
                return self.up(o.T), o
            return self, o.up(self.T)
        return self, self.T.num(o)

    def __add__(s, o):
        a, b = s._c(o)
        return Q(a.T, _add(a.v, b.v, a.T.n))

    __radd__ = __add__

    def __neg__(s):
        return Q(s.T, _neg(s.v, s.T.n))

    def __sub__(s, o):
        return s + (-(s._c(o)[1]))

    def __rsub__(s, o):
        return (-s) + o

    def __mul__(s, o):
        a, b = s._c(o)
        return Q(a.T, _mul(a.v, b.v, a.T.n, a.T.ds))

    __rmul__ = __mul__

    def inv(s):
        return Q(s.T, _inv(s.v, s.T.n, s.T.ds))

    def __truediv__(s, o):
        a, b = s._c(o)
        return a * b.inv()

    def __rtruediv__(s, o):
        return s.T.num(o) * s.inv()

    def sign(s):
        return _sgn(s.v, s.T.n, s.T.ds)

    def __eq__(s, o):
        return (s - o).sign() == 0

    def __hash__(s):
        return hash(round(float(s), 9))

    def __lt__(s, o): return (s - o).sign() < 0
    def __le__(s, o): return (s - o).sign() <= 0
    def __gt__(s, o): return (s - o).sign() > 0
    def __ge__(s, o): return (s - o).sign() >= 0

    def __float__(s):
        return _flt(s.v, s.T.n, s.T.fl)

    def __repr__(s):
        return f"{float(s):.9f}"


def sgn_km(k, m, E):
    """sign of k + m sqrt(E), E >= 0 (all in one tower)."""
    se = E.sign()
    assert se >= 0, "negative radicand"
    sk, sm = k.sign(), m.sign()
    if se == 0 or sm == 0:
        return sk
    if sk == 0:
        return sm
    if sk == sm:
        return sk
    return sk * (k * k - m * m * E).sign()


def cmp_abs(D, k):
    """sign(|sqrt(D) + k| - 1), D >= 0."""
    one = D.T.num(1)
    a = sgn_km(k - one, one, D)        # sign(s - 1)
    b = sgn_km(k + one, one, D)        # sign(s + 1)
    if a > 0 or b < 0:
        return 1
    if a == 0 or b == 0:
        return 0
    return -1


# ------------------------------------------------------------------ vectors and pieces
def sub(p, q): return (p[0] - q[0], p[1] - q[1])
def add(p, q): return (p[0] + q[0], p[1] + q[1])
def smul(t, p): return (p[0] * t, p[1] * t)
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def crs(p, q): return p[0] * q[1] - p[1] * q[0]
def nn(p): return dot(p, p)
def rot90(p): return (-p[1], p[0])
def same(p, q): return (p[0] - q[0]).sign() == 0 and (p[1] - q[1]).sign() == 0
def fp(p): return f"({float(p[0]):.6f}, {float(p[1]):.6f})"


class Seg:
    kind = "S"

    def __init__(s, P, Q_):
        assert not same(P, Q_), "degenerate segment"
        s.P, s.Q = P, Q_

    def ends(s): return (s.P, s.Q)
    def rev(s): return Seg(s.Q, s.P)
    def __repr__(s): return f"Seg{fp(s.P)}->{fp(s.Q)}"


class Arc:
    kind = "A"

    def __init__(s, C, rho, S, E):
        s.C, s.rho, s.S, s.E = C, rho, S, E
        assert rho.sign() > 0
        assert nn(sub(S, C)) == rho * rho, f"arc start off circle {fp(S)} about {fp(C)}"
        assert nn(sub(E, C)) == rho * rho, f"arc end off circle {fp(E)} about {fp(C)}"
        u, v = sub(S, C), sub(E, C)
        c = crs(u, v).sign()
        assert c > 0 or (c == 0 and dot(u, v).sign() < 0), "arc must span (0, 180] degrees counter-clockwise"

    def ends(s): return (s.S, s.E)
    def __repr__(s): return f"Arc[C{fp(s.C)} r{float(s.rho):.4f} {fp(s.S)}->{fp(s.E)}]"

    def has(s, w):
        """direction w (nonzero) within the closed span."""
        u, v = sub(s.S, s.C), sub(s.E, s.C)
        return crs(u, w).sign() >= 0 and crs(w, v).sign() >= 0

    def has_km(s, w0, w1, E, strict=False):
        """direction w0 + sqrt(E) w1 within the (closed or open) span."""
        u, v = sub(s.S, s.C), sub(s.E, s.C)
        a = sgn_km(crs(u, w0), crs(u, w1), E)
        b = sgn_km(crs(w0, v), crs(w1, v), E)
        return (a > 0 and b > 0) if strict else (a >= 0 and b >= 0)


def arc(C, rho, X, Y, ccw=True):
    """the arc traversed from X to Y, counter-clockwise about C or clockwise; stored counter-clockwise, with its direction in `fwd`."""
    a = Arc(C, rho, X, Y) if ccw else Arc(C, rho, Y, X)
    a.fwd = ccw
    return a


def dse(pc):
    """(start, end) in the direction the tile boundary traverses the piece."""
    if pc.kind == "S" or getattr(pc, "fwd", True):
        return pc.ends()
    return (pc.E, pc.S)


# ------------------------------------------------------------------ candidates (D, k): the distance |sqrt(D) + k|, each realised
def _pt_seg(x, sg, out):
    d = sub(sg.Q, sg.P)
    t = dot(sub(x, sg.P), d)
    if t.sign() > 0 and (t - nn(d)).sign() < 0:
        F = add(sg.P, smul(t / nn(d), d))
        out.append((nn(sub(x, F)), x[0].T.num(0)))


def _pt_arc(x, ar, out, far=True):
    w = sub(x, ar.C)
    D = nn(w)
    z = x[0].T.num(0)
    if D.sign() == 0:
        out.append((z, ar.rho))
        return
    if ar.has(w):
        out.append((D, -ar.rho))
    if far and ar.has(smul(-1, w)):
        out.append((D, ar.rho))


def cands(a, b):
    z = a.ends()[0][0].T.num(0)
    out = []
    for x in a.ends():
        for y in b.ends():
            out.append((nn(sub(x, y)), z))
    if "endsonly" in PLANT:
        return out
    for x in a.ends():
        (_pt_seg if b.kind == "S" else _pt_arc)(x, b, out)
    for y in b.ends():
        (_pt_seg if a.kind == "S" else _pt_arc)(y, a, out)
    if "nointerior" in PLANT:
        return out
    if a.kind == "S" and b.kind == "A":
        _seg_arc(a, b, out)
    elif a.kind == "A" and b.kind == "S":
        _seg_arc(b, a, out)
    elif a.kind == "A" and b.kind == "A":
        _arc_arc(a, b, out)
    return out


def _seg_arc(sg, ar, out):
    d = sub(sg.Q, sg.P)
    t = dot(sub(ar.C, sg.P), d)
    if not (t.sign() > 0 and (t - nn(d)).sign() < 0):
        return
    F = add(sg.P, smul(t / nn(d), d))
    w = sub(F, ar.C)
    D = nn(w)
    if D.sign() == 0:
        out.append((D, ar.rho))
        return
    if ar.has(w):
        out.append((D, -ar.rho))
    if ar.has(smul(-1, w)):
        out.append((D, ar.rho))


def _arc_arc(a, b, out):
    u = sub(b.C, a.C)
    D = nn(u)
    z = u[0].T.num(0)
    if D.sign() == 0:
        # concentric: same direction -> |rho_a - rho_b|, opposite -> rho_a + rho_b
        if _spans_meet(a, b, 1):
            out.append((z, a.rho - b.rho))
        if _spans_meet(a, b, -1):
            out.append((z, a.rho + b.rho))
        return
    for sa in (1, -1):
        for sb in (1, -1):
            if a.has(smul(sa, u)) and b.has(smul(sb, u)):
                out.append((D, b.rho * sb - a.rho * sa))


def _spans_meet(a, b, sgn):
    for w in (sub(a.S, a.C), sub(a.E, a.C)):
        if b.has(smul(sgn, w)):
            return True
    for w in (sub(b.S, b.C), sub(b.E, b.C)):
        if a.has(smul(sgn, w)):
            return True
    return False


# ------------------------------------------------------------------ crossings
def crosses(a, b):
    if a.kind == "S" and b.kind == "S":
        return _ss(a, b)
    if a.kind == "S":
        return _sa(a, b)
    if b.kind == "S":
        return _sa(b, a)
    return _aa(a, b)


def _on_seg(p, sg):
    d, w = sub(sg.Q, sg.P), sub(p, sg.P)
    return crs(d, w).sign() == 0 and dot(w, d).sign() >= 0 and (dot(w, d) - nn(d)).sign() <= 0


def _ss(a, b):
    d1, d2 = sub(a.Q, a.P), sub(b.Q, b.P)
    o1 = crs(d1, sub(b.P, a.P)).sign()
    o2 = crs(d1, sub(b.Q, a.P)).sign()
    o3 = crs(d2, sub(a.P, b.P)).sign()
    o4 = crs(d2, sub(a.Q, b.P)).sign()
    if o1 * o2 < 0 and o3 * o4 < 0:
        return True
    return _on_seg(b.P, a) or _on_seg(b.Q, a) or _on_seg(a.P, b) or _on_seg(a.Q, b)


def _sa(sg, ar):
    d = sub(sg.Q, sg.P)
    pc = sub(sg.P, ar.C)
    A_ = nn(d)
    B_ = dot(d, pc)
    C_ = nn(pc) - ar.rho * ar.rho
    Dl = B_ * B_ - A_ * C_
    if Dl.sign() < 0:
        return False
    for s in (1, -1):
        m = pc[0].T.num(s)
        # t = (-B + s sqrt Dl)/A in [0, 1]
        if sgn_km(-B_, m, Dl) < 0 or sgn_km(-B_ - A_, m, Dl) > 0:
            continue
        # direction from C: A pc + (-B + s sqrtDl) d = (A pc - B d) + s sqrtDl d
        w0 = sub(smul(A_, pc), smul(B_, d))
        w1 = smul(m, d)
        if ar.has_km(w0, w1, Dl):
            return True
    return False


def _aa(a, b):
    u = sub(b.C, a.C)
    D = nn(u)
    if D.sign() == 0:
        return (a.rho - b.rho).sign() == 0 and _spans_meet(a, b, 1)
    h = (D + a.rho * a.rho - b.rho * b.rho) / (D * 2)
    E = (D * a.rho * a.rho * 4 - (D + a.rho * a.rho - b.rho * b.rho) * (D + a.rho * a.rho - b.rho * b.rho)) / (D * D * 4)
    if E.sign() < 0:
        return False
    Ju = rot90(u)
    for s in (1, -1):
        # point = a.C + h u + s sqrtE Ju
        wa0, wa1 = smul(h, u), smul(s, Ju)
        wb0, wb1 = sub(smul(h, u), u), smul(s, Ju)
        if a.has_km(wa0, wa1, E) and b.has_km(wb0, wb1, E):
            return True
    return False


# ------------------------------------------------------------------ tile pairs
def pair(A, B, selfpair=False):
    """(cmp(min, 1), cmp(max, 1), n_candidates): min is 0 for a tile with itself or on a crossing."""
    cs = []
    crossing = False
    for i, a in enumerate(A):
        for j, b in enumerate(B):
            cs.extend(cands(a, b))
            if not selfpair and "nocross" not in PLANT and crosses(a, b):
                crossing = True
    cmps = [cmp_abs(D, k) for (D, k) in cs]
    mx = max(cmps)
    mn = -1 if (selfpair or crossing) else min(cmps)
    return mn, mx, len(cs)


def verdict(mn, mx):
    if "closed" in PLANT:
        return "REJECT" if (mn <= 0 and mx >= 0) else "ACCEPT"
    return "REJECT" if (mn < 0 and mx > 0) else "ACCEPT"


def check(tiles, log=print, label="", pairs=None):
    """every same-colour pair, a tile with itself included.  Returns (rejects, n_pairs, tight list, nonsiamese_failures)."""
    names = sorted(tiles)
    rejects, tight, nsf = [], [], []
    n = 0
    for ia, a in enumerate(names):
        for b in names[ia:]:
            if tiles[a][0] != tiles[b][0]:
                continue
            if pairs is not None and (a, b) not in pairs:
                continue
            sp = a == b
            if sp and "noself" in PLANT:
                continue
            n += 1
            mn, mx, nc = pair(tiles[a][1], tiles[b][1], selfpair=sp)
            v = verdict(mn, mx)
            if v == "REJECT":
                rejects.append((a, b))
            if (sp and mx == 0) or (not sp and mn == 0):
                tight.append((a, b, "max=1" if sp else "min=1"))
            if not sp and mn < 0:
                nsf.append((a, b))
            log(f"  {label}{a}|{b}: min {'<' if mn < 0 else '=' if mn == 0 else '>'}1  max {'<' if mx < 0 else '=' if mx == 0 else '>'}1"
                f"  ({nc} candidates) {v}")
    return rejects, n, tight, nsf


# ------------------------------------------------------------------ points
def on_piece(z, pc):
    if pc.kind == "S":
        return _on_seg(z, pc)
    w = sub(z, pc.C)
    return nn(w) == pc.rho * pc.rho and pc.has(w)


def inside(z, ps, slopes=(Fr(1, 7), Fr(-2, 9), Fr(3, 11), Fr(5, 13), Fr(-7, 17), Fr(11, 19))):
    """True if z is in the closed tile (on a piece counts), by an exact ray count; the slope changes on any degenerate hit."""
    if any(on_piece(z, pc) for pc in ps):
        return True
    T = z[0].T
    for sl in slopes:
        d = (T.num(1), T.num(sl))
        cnt, bad = 0, False
        for pc in ps:
            if pc.kind == "S":
                e = sub(pc.Q, pc.P)
                den = crs(d, e)
                if den.sign() == 0:
                    if crs(d, sub(pc.P, z)).sign() == 0:
                        bad = True
                    continue
                w = sub(pc.P, z)
                t = crs(w, e) / den
                u = crs(w, d) / den
                if t.sign() <= 0:
                    continue
                if u.sign() == 0 or (u - 1).sign() == 0:
                    bad = True
                    continue
                if u.sign() > 0 and (u - 1).sign() < 0:
                    cnt += 1
            else:
                pcz = sub(z, pc.C)
                A_, B_, C_ = nn(d), dot(d, pcz), nn(pcz) - pc.rho * pc.rho
                Dl = B_ * B_ - A_ * C_
                if Dl.sign() < 0:
                    continue
                if Dl.sign() == 0:
                    bad = True
                    continue
                for s in (1, -1):
                    m = T.num(s)
                    st = sgn_km(-B_, m, Dl)
                    if st < 0:
                        continue
                    if st == 0:        # t = 0: z on the circle, not on the arc (on_piece was checked): not a crossing
                        continue
                    w0 = sub(smul(A_, pcz), smul(B_, d))
                    w1 = smul(m, d)
                    if pc.has_km(w0, w1, Dl, strict=True):
                        cnt += 1
                    elif pc.has_km(w0, w1, Dl):
                        bad = True
            if bad:
                break
        if not bad:
            return cnt % 2 == 1
    raise RuntimeError("ray count degenerate on every slope")


def pt_minmax(z, ps):
    """(cmp(min,1), cmp(max,1)) over the closed tile."""
    T = z[0].T
    zero = T.num(0)
    cs = []
    for pc in ps:
        for x in pc.ends():
            cs.append((nn(sub(z, x)), zero))
        if pc.kind == "S":
            _pt_seg(z, pc, cs)
        else:
            _pt_arc(z, pc, cs)
    c = [cmp_abs(D, k) for D, k in cs]
    mn = -1 if inside(z, ps) else min(c)
    return mn, max(c)


def straddlers(z, tiles):
    out = {}
    for nm, (col, ps) in tiles.items():
        mn, mx = pt_minmax(z, ps)
        if mn < 0 and mx > 0:
            out.setdefault(col, []).append(nm)
    return out


def free(z, tiles, colours, ignore=()):
    tt = {k: v for k, v in tiles.items() if k not in ignore}
    st = straddlers(z, tt)
    return [c for c in colours if c not in st], st


# ------------------------------------------------------------------ map consistency
def pkey(pc):
    """an orientation-free key of a piece (float, for matching only; exact equality is re-checked)."""
    a, b = pc.ends()
    ka, kb = (round(float(a[0]), 9), round(float(a[1]), 9)), (round(float(b[0]), 9), round(float(b[1]), 9))
    if pc.kind == "S":
        return ("S",) + tuple(sorted([ka, kb]))
    return ("A", round(float(pc.C[0]), 9), round(float(pc.C[1]), 9), round(float(pc.rho), 9)) + tuple(sorted([ka, kb]))


def closed_chain(ps):
    """each piece's end meets the next piece's start in the order given (orientation as listed)."""
    return all(same(dse(ps[i])[1], dse(ps[(i + 1) % len(ps)])[0]) for i in range(len(ps)))


def float_area(ps, n=2000):
    """signed area by sampling the boundary as traversed (a guard only)."""
    pts = []
    for pc in ps:
        st, en = dse(pc)
        if pc.kind == "S":
            pts.append((float(st[0]), float(st[1])))
        else:
            c = (float(pc.C[0]), float(pc.C[1]))
            r = float(pc.rho)
            a0 = math.atan2(float(st[1]) - c[1], float(st[0]) - c[0])
            a1 = math.atan2(float(en[1]) - c[1], float(en[0]) - c[0])
            if getattr(pc, "fwd", True):
                while a1 <= a0:
                    a1 += 2 * math.pi
            else:
                while a0 <= a1:
                    a0 += 2 * math.pi
            pts += [(c[0] + r * math.cos(a0 + (a1 - a0) * i / n), c[1] + r * math.sin(a0 + (a1 - a0) * i / n)) for i in range(n)]
    s = 0.0
    for i in range(len(pts)):
        x0, y0 = pts[i]
        x1, y1 = pts[(i + 1) % len(pts)]
        s += x0 * y1 - x1 * y0
    return s / 2
