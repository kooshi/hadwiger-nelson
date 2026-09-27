#!/usr/bin/env python3
"""FS110-YB's exact same-colour distance checker for tiles bounded by segments and circular arcs over Q(sqrt 3).

Written blind to the construction side's checker (tools/fs110_y_*), from the fragments' formulas in
data/fs110/briefs/YB110-instance.md.

For two closed tiles A, B (bounded by segments and circular arcs), the cross-distance range is [min, max] of |p - q|, p in A, q in B.
Both extremes are attained on the boundaries (for min, when the closures are disjoint; a shared point gives 0 among the vertex pairs), at a pair
where each point is a piece endpoint or satisfies the first-order condition on its piece. The complete candidate list:
  VV  endpoint - endpoint
  VS  endpoint - foot on a segment (interior foot)
  VA  endpoint - nearest and farthest point of an arc (the direction +-(p - C), if on the arc)
  SA  segment interior - arc interior: q = C +- r n (n the segment's unit normal), p its foot
  AA  arc interior - arc interior, non-concentric centres: both points on the line of centres (four sign choices)
(segment-segment interior pairs are parallel and dominated by VS; concentric arc-arc interior pairs are dominated by VA.)
Every candidate is a genuine pair of points of the closures, so min and max are the extremes over candidates, EXACTLY.
Values are compared with 1 exactly: squared distances in Q(sqrt3), or |sqrt(R2) + k| with R2, k in Q(sqrt3).
A pair REJECTs iff min < 1 < max. Pairs are generated from the colour map: every same-colour pair, each tile with itself included,
and the count is asserted to be sum_c n_c (n_c + 1) / 2.
"""
from fractions import Fraction as Fr
import itertools, math, sys

# ---------------------------------------------------------------- exact Q(sqrt3)
class Q3:
    __slots__ = ("a", "b")
    def __init__(s, a=0, b=0):
        s.a = Fr(a); s.b = Fr(b)
    def __add__(s, o): o = q3(o); return Q3(s.a + o.a, s.b + o.b)
    __radd__ = __add__
    def __sub__(s, o): o = q3(o); return Q3(s.a - o.a, s.b - o.b)
    def __rsub__(s, o): return q3(o) - s
    def __neg__(s): return Q3(-s.a, -s.b)
    def __mul__(s, o): o = q3(o); return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)
    __rmul__ = __mul__
    def inv(s):
        n = s.a * s.a - 3 * s.b * s.b
        assert n != 0
        return Q3(s.a / n, -s.b / n)
    def __truediv__(s, o): return s * q3(o).inv()
    def sign(s):
        sa = (s.a > 0) - (s.a < 0); sb = (s.b > 0) - (s.b < 0)
        if sb == 0: return sa
        if sa == 0: return sb
        if sa == sb: return sa
        return sa if s.a * s.a > 3 * s.b * s.b else sb
    def __float__(s): return float(s.a) + float(s.b) * math.sqrt(3)
    def __eq__(s, o): o = q3(o); return s.a == o.a and s.b == o.b
    def __hash__(s): return hash((s.a, s.b))
    def __repr__(s): return f"({s.a}{'+' if s.b >= 0 else '-'}{abs(s.b)}r3)"

def q3(x): return x if isinstance(x, Q3) else Q3(x)
R3 = Q3(0, 1)

# points are tuples (Q3, Q3)
def P(x, y): return (q3(x), q3(y))
def add(p, q): return (p[0] + q[0], p[1] + q[1])
def sub(p, q): return (p[0] - q[0], p[1] - q[1])
def mul(k, p): return (q3(k) * p[0], q3(k) * p[1])
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def cross(p, q): return p[0] * q[1] - p[1] * q[0]
def n2(p): return dot(p, p)
def perp(p): return (-p[1], p[0])
def fl(p): return (float(p[0]), float(p[1]))

HALF = Fr(1, 2)
def e(deg):
    """exact unit vector at a multiple of 30 degrees"""
    assert deg % 30 == 0
    t = {0: (1, 0), 30: (R3 * HALF, HALF), 60: (HALF, R3 * HALF), 90: (0, 1)}
    k = deg % 360
    base = k % 90; quad = k // 90
    x, y = t[base]
    x, y = q3(x), q3(y)
    for _ in range(quad): x, y = -y, x
    return (x, y)

def rot(p, c, s):
    """rotate vector p by the angle with cosine c, sine s (exact)"""
    return (c * p[0] - s * p[1], s * p[0] + c * p[1])

CA, SA_ = Q3(Fr(63, 65)), Q3(Fr(16, 65))          # alpha = 2 arctan(1/8)
def e_pm_alpha(deg, sgn):
    return rot(e(deg), CA, SA_ if sgn > 0 else -SA_)

# ---------------------------------------------------------------- pieces and tiles
class Seg:
    def __init__(s, p, q): s.p, s.q = p, q
    def ends(s): return [s.p, s.q]
    def mapped(s, f): return Seg(f(s.p), f(s.q))

class Arc:
    """arc of the circle about C of radius r (in Q3), counter-clockwise from p to q"""
    def __init__(s, C, r, p, q, check=True):
        s.C, s.r, s.p, s.q = C, q3(r), p, q
        if check:
            assert n2(sub(p, C)) == s.r * s.r, "arc start not on circle"
            assert n2(sub(q, C)) == s.r * s.r, "arc end not on circle"
    def ends(s): return [s.p, s.q]
    def mapped(s, f): return Arc(f(s.C), s.r, f(s.p), f(s.q))   # f must be a rotation or translation (orientation kept)
    def has_dir(s, x):
        """is the direction x (a nonzero vector from C) on the closed arc?"""
        if PLANT == "ARCFULL": return True
        a = sub(s.p, s.C); b = sub(s.q, s.C)
        cab = cross(a, b).sign()
        if cab > 0:
            return cross(a, x).sign() >= 0 and cross(x, b).sign() >= 0
        if cab < 0:
            return not (cross(b, x).sign() > 0 and cross(x, a).sign() > 0)
        # a, b parallel: a half-turn (b = -a) or degenerate
        if dot(a, b).sign() < 0:
            return cross(a, x).sign() >= 0
        return cross(a, x).sign() == 0 and dot(a, x).sign() > 0

def arc_cw(C, r, p, q):
    """arc clockwise from p to q = counter-clockwise from q to p"""
    return Arc(C, r, q, p)

class Tile:
    def __init__(s, name, colour, pieces):
        s.name, s.colour, s.pieces = name, colour, pieces
        s.check_closed()
    def check_closed(s):
        # consecutive pieces share an endpoint (as sets), and the chain closes
        ends = [pc.ends() for pc in s.pieces]
        for i in range(len(ends)):
            a = ends[i]; b = ends[(i + 1) % len(ends)]
            assert any(x == y for x in a for y in b), f"tile {s.name}: pieces {i},{i+1} not joined"
    def verts(s):
        out = []
        for pc in s.pieces:
            for v in pc.ends():
                if not any(v == w for w in out): out.append(v)
        return out
    def mapped(s, f, name, colour): return Tile(name, colour, [pc.mapped(f) for pc in s.pieces])

# ---------------------------------------------------------------- exact comparison of candidate values with 1
def cmp_sqrt(R2, c):
    """sign(sqrt(R2) - c), R2 >= 0"""
    if c.sign() < 0: return 1
    return (R2 - c * c).sign()

def cmp1(val):
    """sign(value - 1) for a candidate distance"""
    kind = val[0]
    if kind == "sq":
        return (val[1] - 1).sign()
    R2, k = val[1], val[2]
    s1 = cmp_sqrt(R2, q3(1) - k)       # sign(sqrt R2 + k - 1)
    s2 = cmp_sqrt(R2, q3(-1) - k)      # sign(sqrt R2 + k + 1)
    if s1 > 0 or s2 < 0: return 1
    if s1 == 0 or s2 == 0: return 0
    return -1

def fval(val):
    if val[0] == "sq": return math.sqrt(max(0.0, float(val[1])))
    return abs(math.sqrt(max(0.0, float(val[1]))) + float(val[2]))

# ---------------------------------------------------------------- candidates
PLANT = None      # set by the self-test: "VV","VS","VA","SA","AA","ARCFULL","SELF","CROSS"

def cand_point_piece(p, pc, out):
    if isinstance(pc, Seg):
        if PLANT == "VS": return
        D = sub(pc.q, pc.p); DD = n2(D)
        t = dot(sub(p, pc.p), D) / DD
        if t.sign() > 0 and (t - 1).sign() < 0:
            h = cross(D, sub(p, pc.p))
            out.append(("VS", ("sq", h * h / DD)))
    else:
        x = sub(p, pc.C); X2 = n2(x)
        if X2.sign() == 0: return          # p at the centre: every arc point at distance r, the arc's ends already count
        for sg, tag in ((1, "near"), (-1, "far")):
            if PLANT == "VA" + tag: continue
            d = x if sg > 0 else (-x[0], -x[1])
            if pc.has_dir(d):
                # nearest: |sqrt X2 - r| ; farthest: sqrt X2 + r
                out.append(("VA" + tag, ("root", X2, -pc.r if sg > 0 else pc.r)))

def cand_seg_arc(sg_, ar, out):
    if PLANT == "SA": return
    D = sub(sg_.q, sg_.p); DD = n2(D)
    t = dot(sub(ar.C, sg_.p), D) / DD
    if not (t.sign() >= 0 and (t - 1).sign() <= 0): return
    n = perp(D)
    hnum = dot(sub(ar.C, sg_.p), n)          # signed height times |D|
    h2 = hnum * hnum / DD
    hs = hnum.sign()
    for sig in (1, -1):
        d = n if sig > 0 else (-n[0], -n[1])
        if not ar.has_dir(d): continue
        # distance |h + sig r| with h = hs * sqrt(h2)
        k = ar.r * sig if hs >= 0 else -ar.r * sig
        out.append(("SA", ("root", h2, k)))

def cand_arc_arc(a1, a2, out):
    if PLANT == "AA": return
    dC = sub(a2.C, a1.C); rho2 = n2(dC)
    if rho2.sign() == 0: return               # concentric: dominated by VA
    for s1 in (1, -1):
        d1 = dC if s1 > 0 else (-dC[0], -dC[1])
        if not a1.has_dir(d1): continue
        for s2 in (1, -1):
            d2 = dC if s2 > 0 else (-dC[0], -dC[1])
            if not a2.has_dir(d2): continue
            out.append(("AA", ("root", rho2, a2.r * s2 - a1.r * s1)))

def candidates(A, B):
    out = []
    VA_, VB_ = A.verts(), B.verts()
    if PLANT != "VV":
        for p in VA_:
            for q in VB_:
                out.append(("VV", ("sq", n2(sub(p, q)))))
    for p in VA_:
        for pc in B.pieces: cand_point_piece(p, pc, out)
    for q in VB_:
        for pc in A.pieces: cand_point_piece(q, pc, out)
    for x in A.pieces:
        for y in B.pieces:
            if isinstance(x, Seg) and isinstance(y, Arc): cand_seg_arc(x, y, out)
            if isinstance(x, Arc) and isinstance(y, Seg): cand_seg_arc(y, x, out)
            if isinstance(x, Arc) and isinstance(y, Arc): cand_arc_arc(x, y, out)
    return out

def judge(A, B):
    cs = candidates(A, B)
    if A is B: cs.append(("self", ("sq", q3(0))))
    cm = [(cmp1(v), kind, v) for kind, v in cs]
    lt = [c for c in cm if c[0] < 0]; gt = [c for c in cm if c[0] > 0]; eq = [c for c in cm if c[0] == 0]
    fvals = [fval(v) for _, v in cs]
    lo, hi = min(fvals), max(fvals)
    verdict = "REJECT" if (lt and gt) else "ACCEPT"
    contact = (not lt and bool(eq)) or (not gt and bool(eq))
    kind = "self" if A is B else ("siamese" if not gt else ("far" if not lt else "straddle"))
    wit = sorted({c[1] for c in lt}) , sorted({c[1] for c in gt})
    return dict(A=A.name, B=B.name, colour=A.colour, verdict=verdict, contact=contact, kind=kind, lo=lo, hi=hi, lt_by=wit[0], gt_by=wit[1])

def pairs_of(tiles):
    bycol = {}
    for t in tiles: bycol.setdefault(t.colour, []).append(t)
    out = []
    for c, ts in sorted(bycol.items()):
        for i in range(len(ts)):
            for j in range(i, len(ts)):
                if PLANT == "SELF" and i == j: continue
                if PLANT == "CROSS" and i != j: continue
                out.append((ts[i], ts[j]))
    expect = sum(len(ts) * (len(ts) + 1) // 2 for ts in bycol.values())
    return out, expect

def check(tiles, label, verbose=True):
    prs, expect = pairs_of(tiles)
    res = [judge(a, b) for a, b in prs]
    count_ok = (len(prs) == expect)
    nrej = sum(r["verdict"] == "REJECT" for r in res)
    ncon = sum(r["contact"] for r in res)
    verdict = "ACCEPT" if (nrej == 0 and count_ok) else ("REJECT" if nrej else "COUNT-FAIL")
    if verbose:
        print(f"== {label}: tiles={len(tiles)} pairs={len(prs)} expected={expect} count_ok={count_ok} rejects={nrej} contacts_at_1={ncon} -> {verdict}")
        for r in res:
            flag = "REJECT" if r["verdict"] == "REJECT" else ("contact" if r["contact"] else "")
            print(f"   {r['A']:>6} {r['B']:>6} c{r['colour']} {r['kind']:8} [{r['lo']:.6f}, {r['hi']:.6f}] {flag}"
                  + (f"  (<1 by {r['lt_by']}, >1 by {r['gt_by']})" if r["verdict"] == "REJECT" else ""))
    return dict(verdict=verdict, count_ok=count_ok, rejects=nrej, contacts=ncon, res=res, pairs=len(prs), expect=expect)
