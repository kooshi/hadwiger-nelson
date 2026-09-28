#!/usr/bin/env python3
"""FS114-L60 exact checks: FS112-L60 at its boundary (a unit arc of exactly 60 degrees with constant sides).

Exact arithmetic in Q(sqrt 3) (class Q3 below: a + b*sqrt3 with rational a, b, and an exact sign); points on unit circles by the
rational parametrisation e(t) = ((1 - t^2)/(1 + t^2), 2t/(1 + t^2)) or by the 30-degree points, which lie in Q(sqrt 3). No floats
decide anything. Frame: P = 0, A = e(0 deg) = (1, 0), B = e(60 deg) = (1/2, sqrt3/2), C = A + B; the arc alpha of omega(P) from A to B;
K_in = Reul(P, A, B) (the Reuleaux triangle inside alpha), K_out = Reul(A, B, C) minus B(P, 1) (the Reuleaux cap outside it).

Checks (each returns GREEN or RED with a reason code):
  CHORD   the arc's chord |A - B_end|^2 against 1: CHORD_EQ at 60 deg (allowed: <= 60 deg), CHORD_OVER past it.
  TILE    the equality tile: named points of the cap K_out (corners, arc midpoints, interior points, the omega(P)-arc at named
          angles) lie in the lens B(A,1) & B(B,1) (closed) and in B(C,1), outside the open B(P,1), pairwise <= 1 apart; the
          omega(P)-arc touches the circle omega(C) only at A and B.
  RADIAL  N112-L60's proof step at 60 deg: the radial point (1 + eps)A lies OUTSIDE the closed B(B,1), so it is in no tile that
          reaches B; the frozen tools' number |(1+eps)A - (1+eps)B|^2 = 10201/10000 reproduced.
  NBSTEP  NB-L60's route at 60 deg: beyond the interior point e(d) the lens holds (1+tau)e(d) only for tau <= tau*(d) =
          2 B.e(d) - 1 < 2 sqrt3 t (t = tan(d/2)), and the pair (1+tau*)e(d), (1+tau*)e(60 - d) is exactly (2cos2d - 1)^2 <= 1
          apart: "t >> d" is unavailable at equality.
  SECOND  L60's second clause at 60 deg: for interior w, w +- 60 deg are more than 1 from B or from A (so outside K_in and K_out:
          the interior reading holds); the ends A, B are corners of both K_in and K_out, 1 apart, and omega(A) meets omega(P) at
          B at 60 deg (transversal) while missing the interiors of K_in, K_out (both lie in the closed B(A,1)).
  FRAG    a valid fragment by formula on a neighbourhood of the closed arc: colour 1 = int K_in, 3 = int K_out, 4 = B(A, r) minus
          K_in, K_out, 5 = B(B, r) minus K_in, K_out, r = 1/4: named probes about A and B fall in exactly one class, in the
          sector the tangent cones predict; the small classes have diameter 2r < 1 (the Reuleaux classes have diameter 1,
          attained only on the boundary: constant width, by hand).
  ENV60   N2-ENV's near-tile margin at 60 deg at the far corner C: toward-lens points z = (1 - s)e(t) with a thin profile
          satisfy |C - z|^2 < 1 (so recolouring the lens by s_out keeps every near tile within < 1).
  COR3    NB3's first-order cone model of N3-COR3 (imported from the frozen tools/fs112_nb3_checks.py, unedited) re-run with
          arc lengths 55, 59, 60 deg (the frozen run stopped at 50): every strip-holds case has an empty probe, every
          both-fail case forces four colours.

Plants (each must turn exactly its own check red, with its own reason):
  past       (just past the boundary) B_end moved to e(289/500), at 60.04 deg: CHORD -> CHORD_OVER.
  radial     (at the boundary) the outer tile given N112-L60's premise, the radial points (1+1/100)A, (1+1/100)B: TILE ->
             OUTSIDE_LENS.
  radial_in  the radial point taken at eps = 0 (the end A itself): RADIAL -> RADIAL_NOT_OUTSIDE.
  nb_free    NB's premise "t >> d" planted, tau = 20 t at t = 1/100: NBSTEP -> NB_POINT_OUTSIDE.
  second_end the "interior" point taken at the end A: SECOND -> INTERIOR_NOT_CLEAR.
  frag_big   the small discs given radius 3/5: FRAG -> SMALL_DIAM_OVER.
  env_thick  a lens profile of slope 10 (s = 1/10 at t = 1/100): ENV60 -> ENV_MARGIN_LOST.
  cor3_nou1  NB3's own plant (N112-U1 dropped at w), at the 55-60 deg arcs: COR3 -> red.

Usage: python3 tools/fs114_l60_check.py [--plant NAME] | --self-test
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent


# ---------------------------------------------------------------- exact Q(sqrt 3)
class Q3:
    __slots__ = ("a", "b")

    def __init__(self, a=0, b=0):
        self.a, self.b = Fr(a), Fr(b)

    def __add__(self, o):
        o = q3(o)
        return Q3(self.a + o.a, self.b + o.b)

    __radd__ = __add__

    def __sub__(self, o):
        o = q3(o)
        return Q3(self.a - o.a, self.b - o.b)

    def __rsub__(self, o):
        return q3(o) - self

    def __neg__(self):
        return Q3(-self.a, -self.b)

    def __mul__(self, o):
        o = q3(o)
        return Q3(self.a * o.a + 3 * self.b * o.b, self.a * o.b + self.b * o.a)

    __rmul__ = __mul__

    def inv(self):
        n = self.a * self.a - 3 * self.b * self.b
        if n == 0:
            raise ZeroDivisionError("Q3 zero")
        return Q3(self.a / n, -self.b / n)

    def __truediv__(self, o):
        return self * q3(o).inv()

    def sign(self) -> int:
        a, b = self.a, self.b
        sa, sb = (a > 0) - (a < 0), (b > 0) - (b < 0)
        if sb == 0:
            return sa
        if sa == 0:
            return sb
        if sa == sb:
            return sa
        d = a * a - 3 * b * b          # |a| vs |b| sqrt3
        return sa if d > 0 else (sb if d < 0 else 0)

    def __eq__(self, o):
        return (self - q3(o)).sign() == 0

    def __lt__(self, o):
        return (self - q3(o)).sign() < 0

    def __le__(self, o):
        return (self - q3(o)).sign() <= 0

    def __gt__(self, o):
        return (self - q3(o)).sign() > 0

    def __ge__(self, o):
        return (self - q3(o)).sign() >= 0

    def __hash__(self):
        return hash((self.a, self.b))

    def f(self) -> float:            # display only
        return float(self.a) + float(self.b) * 3 ** 0.5

    def __repr__(self):
        if self.b == 0:
            return str(self.a)
        return f"({self.a} + {self.b}*sqrt3)"


def q3(x):
    return x if isinstance(x, Q3) else Q3(x, 0)


S3 = Q3(0, 1)                           # sqrt 3
HALF = Q3(Fr(1, 2))


def pt(x, y):
    return (q3(x), q3(y))


def add(p, q):
    return (p[0] + q[0], p[1] + q[1])


def sub(p, q):
    return (p[0] - q[0], p[1] - q[1])


def scale(k, p):
    return (q3(k) * p[0], q3(k) * p[1])


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def d2(p, q):
    r = sub(p, q)
    return dot(r, r)


def e_rat(t):
    """the point of the unit circle at angle 2*arctan(t); t may be a Q3."""
    t = q3(t)
    den = 1 + t * t
    return ((1 - t * t) / den, (2 * t) / den)


def rot60(p, sgn=1):
    c, s = HALF, HALF * S3 * sgn
    return (c * p[0] - s * p[1], s * p[0] + c * p[1])


def reflect30(p):
    """reflection in the line through 0 at 30 deg: (x, y) -> (x/2 + (sqrt3/2) y, (sqrt3/2) x - y/2)."""
    return (HALF * p[0] + HALF * S3 * p[1], HALF * S3 * p[0] - HALF * p[1])


def e30(k):
    """e(30k deg), exact in Q(sqrt3)."""
    table = [(1, 0), (HALF * S3, HALF), (HALF, HALF * S3), (0, 1)]
    k %= 12
    quad, r = divmod(k, 3)
    x, y = table[r]
    x, y = q3(x), q3(y)
    for _ in range(quad):
        x, y = -y, x
    return (x, y)


P = pt(0, 0)
A = pt(1, 0)
B = pt(HALF, HALF * S3)
C = add(A, B)
ONE = q3(1)


def in_closed_disc(p, c):
    return d2(p, c) <= ONE


def in_open_disc(p, c):
    return d2(p, c) < ONE


def in_K_in(p, strict=False):                        # Reul(P, A, B)
    f = in_open_disc if strict else in_closed_disc
    return f(p, P) and f(p, A) and f(p, B)


def in_K_out(p, strict=False):                       # Reul(A, B, C) minus B(P, 1)
    f = in_open_disc if strict else in_closed_disc
    outside = (d2(p, P) > ONE) if strict else (d2(p, P) >= ONE)
    return f(p, A) and f(p, B) and f(p, C) and outside


# ---------------------------------------------------------------- checks
def check_CHORD(plant):
    Bend = e_rat(Fr(289, 500)) if plant == "past" else B
    assert d2(Bend, P) == ONE, "B_end off omega(P)"
    if plant == "past":
        assert Bend[0] < HALF and Bend[1] > 0, "the planted end is not past 60 deg"
    c2 = d2(A, Bend)
    if c2 > ONE:
        return "RED", "CHORD_OVER", f"|A - B_end|^2 = {c2} > 1: no tile holds both ends (TS-C)"
    if c2 == ONE:
        return "GREEN", "CHORD_EQ", f"|A - B|^2 = {c2} = 1: 60 deg is allowed (<= 60), and is the equality case"
    return "GREEN", "CHORD_LT", f"|A - B_end|^2 = {c2} < 1"


def tile_points(plant):
    eps = Fr(1, 100)
    pts = {
        "A": A, "B": B, "C": C,
        "mid omega(P)": e30(1),
        "mid omega(A)": add(A, e30(3)),               # A + e(90): arc of omega(A) from B to C
        "mid omega(B)": add(B, e30(-1)),              # B + e(-30): arc of omega(B) from A to C
        "near A": add(A, scale(eps, e30(2))),         # A + eps e(60)
        "near B": add(B, scale(eps, e30(0))),         # B + eps e(0)
        "(1+eps)e(30)": scale(1 + eps, e30(1)),
        "centroid": scale(Fr(1, 3), add(add(A, B), C)),
    }
    for t in (Fr(1, 10), Fr(1, 5), Fr(1, 2)):         # points of omega(P) inside the arc (angles 11.4, 22.6, 53.1 deg)
        pts[f"omega(P) at t={t}"] = e_rat(t)
    if plant == "radial":
        pts["radial (1+eps)A"] = scale(1 + eps, A)
        pts["radial (1+eps)B"] = scale(1 + eps, B)
    return pts


def check_TILE(plant):
    pts = tile_points(plant)
    for name, p in pts.items():
        if not (in_closed_disc(p, A) and in_closed_disc(p, B)):
            far = "B" if not in_closed_disc(p, B) else "A"
            return "RED", "OUTSIDE_LENS", f"{name} is at squared distance {d2(p, B if far == 'B' else A)} > 1 from {far}"
        if not (in_closed_disc(p, C) and d2(p, P) >= ONE):
            return "RED", "OUTSIDE_CAP", f"{name}: |p-C|^2 = {d2(p, C)}, |p|^2 = {d2(p, P)}"
    names = list(pts)
    mx, at = q3(0), []
    for i in range(len(names)):
        for j in range(i + 1, len(names)):
            v = d2(pts[names[i]], pts[names[j]])
            if v > mx:
                mx, at = v, [(names[i], names[j])]
            elif v == mx:
                at.append((names[i], names[j]))
    if mx > ONE:
        return "RED", "DIAM_OVER", f"max squared distance {mx} at {at}"
    # the omega(P)-arc touches omega(C) only at its ends: |e - C|^2 = 4 - 2 sqrt3 cos(phi - 30) equals 1 at A, B, < 1 inside
    ends = (d2(A, C) == ONE, d2(B, C) == ONE)
    inside = all(d2(e_rat(t), C) < ONE for t in (Fr(1, 100), Fr(1, 10), Fr(1, 5), Fr(1, 2), Fr(57, 100)))
    if not (all(ends) and inside):
        return "RED", "ARC_OFF_CAP", "the omega(P)-arc leaves B(C,1)"
    return "GREEN", "CAP_IN_LENS", (f"{len(pts)} named points of K_out lie in B(A,1) & B(B,1) & B(C,1), outside B(P,1); max squared "
                                    f"distance {mx}, attained only at {sorted(set(at))}; the omega(P)-arc meets omega(C) only at A, B")


def check_RADIAL(plant):
    out = []
    for eps in ((Fr(0),) if plant == "radial_in" else (Fr(1, 100), Fr(1, 10 ** 6))):
        RA = scale(1 + eps, A)
        v = d2(RA, B)
        if not v > ONE:
            return "RED", "RADIAL_NOT_OUTSIDE", f"eps = {eps}: |(1+eps)A - B|^2 = {v}, not > 1"
        out.append(f"eps={eps}: |(1+eps)A - B|^2 = {v}")
    old = d2(scale(Fr(101, 100), A), scale(Fr(101, 100), B))
    if old != Q3(Fr(10201, 10000)):
        return "RED", "OLD_NUMBER_DIFFERS", f"{old}"
    return "GREEN", "RADIAL_OUTSIDE", ("; ".join(out) + f" (> 1: outside the closed B(B,1), so in no tile reaching B); "
                                       f"the frozen tools' pair distance^2 {old} reproduced")


def check_NBSTEP(plant):
    rows = []
    for t in (Fr(1, 100), Fr(1, 20), Fr(1, 10), Fr(1, 5), Fr(1, 4)):   # d = 2 arctan t < 30 deg (tan 15 = 0.2679)
        w = e_rat(t)
        tau_star = 2 * dot(B, w) - 1
        if plant == "nb_free" and t == Fr(1, 100):
            tau = q3(20 * t)
            pnt = scale(1 + tau, w)
            if not in_closed_disc(pnt, B):
                return "RED", "NB_POINT_OUTSIDE", f"planted tau = {tau} > tau* = {tau_star}: (1+tau)e(d) at |.-B|^2 = {d2(pnt, B)} > 1"
        q = scale(1 + tau_star, w)
        if d2(q, B) != ONE:
            return "RED", "TAU_STAR_WRONG", f"t={t}"
        if not tau_star < 2 * S3 * t:
            return "RED", "TAU_NOT_SMALL", f"t={t}: tau* = {tau_star}"
        w2 = reflect30(w)                                        # e(60 - d)
        pair = d2(scale(1 + tau_star, w), scale(1 + tau_star, w2))
        cos2d = q3(((1 - t * t) ** 2 - 4 * t * t) / (1 + t * t) ** 2)
        if pair != (2 * cos2d - 1) * (2 * cos2d - 1) or not pair <= ONE:
            return "RED", "NB_PAIR_OVER", f"t={t}: pair^2 = {pair}"
        rows.append(f"t={t}: tau*={tau_star.f():.6f} (< 2sqrt3 t = {(2 * S3 * t).f():.6f}), pair^2={pair.f():.6f}")
    return "GREEN", "NB_PAIR_LE1", "; ".join(rows)


def check_SECOND(plant):
    ts = [Fr(0)] if plant == "second_end" else [Fr(1, 10), Fr(1, 5), Q3(2, -1)]   # angles 11.4, 22.6, 30 deg (tan 15 = 2 - sqrt3)
    for t in ts:
        w = e_rat(t)
        wp, wm = rot60(w, +1), rot60(w, -1)
        if not (d2(wp, A) > ONE and d2(wm, B) > ONE):
            return "RED", "INTERIOR_NOT_CLEAR", f"t={t}: |w+60 - A|^2 = {d2(wp, A)}, |w-60 - B|^2 = {d2(wm, B)}"
    ends = in_K_in(A) and in_K_in(B) and in_K_out(A) and in_K_out(B) and d2(A, B) == ONE
    cosang = dot(B, sub(B, A))                           # normals of omega(P), omega(A) at B, both unit: cos of the crossing angle
    if not (ends and cosang == HALF):
        return "RED", "ENDS_WRONG", f"ends={ends}, cos={cosang}"
    return "GREEN", "INTERIOR_CLEAR_ENDS_SHARED", ("interior w: w+60 is > 1 from A and w-60 > 1 from B (outside K_in, K_out); the ends "
                                                   "A, B are corners of K_in and K_out, 1 apart; omega(A) crosses omega(P) at B at 60 deg")


def frag_class(p, r):
    """colour of a point of the fragment by formula, or None off the fragment; raises if two classes claim it."""
    cls = []
    if in_K_in(p, strict=True):
        cls.append(1)
    if in_K_out(p, strict=True):
        cls.append(3)
    kin, kout = in_K_in(p), in_K_out(p)
    if d2(p, A) < r * r and not kin and not kout:
        cls.append(4)
    if d2(p, B) < r * r and not kin and not kout:
        cls.append(5)
    if len(cls) > 1:
        raise AssertionError(f"point claimed by {cls}")
    return cls[0] if cls else None


def check_FRAG(plant):
    r = q3(Fr(3, 5) if plant == "frag_big" else Fr(1, 4))
    if not (2 * r < ONE):
        return "RED", "SMALL_DIAM_OVER", f"the small classes have diameter 2r = {2 * r} >= 1"
    if not (d2(A, B) >= 4 * r * r):
        return "RED", "SMALL_OVERLAP", "discs about A and B overlap"
    rho = Fr(1, 8)
    # expected classes by direction at A (tangent cones): (30,90) cap, (90,210) K_in, (210,390) colour 4; at B: (-30,30) cap,
    # (210,330) K_in, (30,210) colour 5. Directions on a cone boundary (30, 90, 210 at A) are reported, not asserted.
    exp_A = {1: 4, 2: 3, 4: 1, 5: 1, 6: 1, 8: 4, 9: 4, 10: 4, 11: 4, 0: 4}
    exp_B = {0: 3, 2: 5, 3: 5, 4: 5, 5: 5, 6: 5, 8: 1, 9: 1, 10: 1}
    got = {}
    for (cen, name, exp) in ((A, "A", exp_A), (B, "B", exp_B)):
        for k in range(12):
            p = add(cen, scale(rho, e30(k)))
            c = frag_class(p, r)
            got[f"{name}+e({30 * k})/8"] = c
            if c is None:
                return "RED", "HOLE", f"probe {name} + e({30 * k})/8 in no class"
            if k in exp and exp[k] != c:
                return "RED", "WRONG_SECTOR", f"probe {name} + e({30 * k})/8: class {c}, expected {exp[k]}"
    for t in (Fr(1, 10), Fr(1, 4), Fr(1, 2)):                     # across the arc's interior: inside 1, outside 3
        w = e_rat(t)
        if frag_class(scale(Fr(99, 100), w), r) != 1 or frag_class(scale(Fr(101, 100), w), r) != 3:
            return "RED", "WRONG_SIDE", f"t={t}"
    return "GREEN", "FRAGMENT_OK", ("probes about A and B each in exactly one class, sectors as the tangent cones predict; "
                                    f"sides of the arc 1 | 3; small classes of diameter {2 * r} < 1; classes: {got}")


def check_ENV60(plant):
    cases = [(Fr(1, 100), Fr(1, 200)), (Fr(1, 10), Fr(1, 20)), (Fr(1, 5), Fr(1, 10)), (Q3(2, -1), Fr(1, 10))]
    if plant == "env_thick":
        cases = [(Fr(1, 100), Fr(1, 10))]
    rows = []
    for t, s in cases:
        z = scale(1 - q3(s), e_rat(t))
        v = d2(C, z)
        if not v < ONE:
            return "RED", "ENV_MARGIN_LOST", f"t={t}, s={s}: |C - z|^2 = {v} >= 1"
        rows.append(f"t={t}, s={s}: 1 - |C-z|^2 = {(ONE - v).f():.6f}")
    return "GREEN", "ENV_MARGIN_POSITIVE", "; ".join(rows)


def check_COR3(plant):
    sys.path.insert(0, str(REPO / "tools"))
    import fs112_nb3_checks as nb3          # frozen; imported, never edited
    nb3_plant = "cor3_nou1" if plant == "cor3_nou1" else None
    eps = Fr(1, 100)
    thetas = [Fr(n) for n in (3, 30, 60, 90, 120, 150, 177)]
    ells, ellvs = [Fr(55), Fr(59), Fr(60)], [Fr(7), Fr(30), Fr(60)]
    U, V = nb3.configs((5, 4, 6)), nb3.configs((2, 1, 3))
    n_fail = n_hold = n_empty = n_overlap = 0
    for theta in thetas:
        for ell in ells:
            for ellv in ellvs:
                probes_u = [Fr(90) - eps, Fr(90) + eps, Fr(270) - eps, Fr(270) + eps]
                probes_v = [p - theta for p in probes_u]
                for un, (uarcs, Xui, Xuo) in U.items():
                    for side in ("in", "out"):
                        ps = [p for p in probes_u if nb3.inopen(p, 90 - theta, 270 - theta) == (side == "in")]
                        empties = [p for p in ps if not nb3.admissible(p, uarcs, None, (Xui, Xuo), None, theta, ell, ellv, side, nb3_plant)]
                        if not empties:
                            return "RED", "HOLD_NO_EMPTY", f"u={un} theta={theta} ell={ell} side={side}"
                        n_hold += 1
                    for vn, (varcs, Xvi, Xvo) in V.items():
                        spans = [(Fr(180) - ell, Fr(180)) if o == "cw" else (Fr(180), Fr(180) + ell) for (o, _, _) in uarcs]
                        b = Fr(180) - theta
                        vspans = [(b - ellv, b) if o == "cw" else (b, b + ellv) for (o, _, _) in varcs]
                        if any(max(x[0], y[0]) < min(x[1], y[1]) for x in spans for y in vspans):
                            n_overlap += 1
                            continue
                        adm = {p: nb3.admissible(p, uarcs, varcs, (Xui, Xuo), (Xvi, Xvo), theta, ell, ellv, "fail", nb3_plant)
                               for p in probes_u + probes_v}
                        if any(not s for s in adm.values()):
                            n_empty += 1
                            continue
                        forced = [any(s <= X for s in adm.values()) for X in (Xui, Xuo, Xvi, Xvo)]
                        if not all(forced):
                            return "RED", "NOT_FOUR", f"u={un} v={vn} theta={theta} ell={ell} ellv={ellv}"
                        n_fail += 1
    return "GREEN", "COR3_AT_60", (f"arc lengths 55, 59, 60 (v: 7, 30, 60): {n_hold} strip-holds cases each with an empty probe; "
                                   f"{n_fail} both-fail cases each forcing four colours; {n_empty} impossible outright; {n_overlap} skipped")


CHECKS = {"CHORD": check_CHORD, "TILE": check_TILE, "RADIAL": check_RADIAL, "NBSTEP": check_NBSTEP, "SECOND": check_SECOND,
          "FRAG": check_FRAG, "ENV60": check_ENV60, "COR3": check_COR3}
EXPECT_GREEN = {"CHORD": "CHORD_EQ", "TILE": "CAP_IN_LENS", "RADIAL": "RADIAL_OUTSIDE", "NBSTEP": "NB_PAIR_LE1",
                "SECOND": "INTERIOR_CLEAR_ENDS_SHARED", "FRAG": "FRAGMENT_OK", "ENV60": "ENV_MARGIN_POSITIVE", "COR3": "COR3_AT_60"}
PLANTS = {"past": ("CHORD", "CHORD_OVER"), "radial": ("TILE", "OUTSIDE_LENS"), "radial_in": ("RADIAL", "RADIAL_NOT_OUTSIDE"),
          "nb_free": ("NBSTEP", "NB_POINT_OUTSIDE"), "second_end": ("SECOND", "INTERIOR_NOT_CLEAR"),
          "frag_big": ("FRAG", "SMALL_DIAM_OVER"), "env_thick": ("ENV60", "ENV_MARGIN_LOST"), "cor3_nou1": ("COR3", None)}


def run(plant=None):
    return {n: fn(plant) for n, fn in CHECKS.items()}


def main(argv):
    if argv and argv[0] == "--self-test":
        bad = False
        res = run()
        print("faithful run:")
        for n, (v, why, det) in res.items():
            ok = v == "GREEN" and why == EXPECT_GREEN[n]
            bad |= not ok
            print(f"  {n}: {v} {why}{'' if ok else '   <-- DEFECT (expected GREEN ' + EXPECT_GREEN[n] + ')'}\n      {det}")
        for p, (target, reason) in PLANTS.items():
            r = run(p)
            reds = [n for n, (v, _, _) in r.items() if v == "RED"]
            others_ok = all(r[n][1] == EXPECT_GREEN[n] for n in r if n != target)
            fired = reds == [target] and (reason is None or r[target][1] == reason) and others_ok
            bad |= not fired
            print(f"plant {p}: {'FIRES' if fired else 'DEFECT'} -> {target}: {r[target][1]}: {r[target][2]}; reds={reds}")
        print("SELF-TEST", "PASS" if not bad else "FAIL")
        return 1 if bad else 0
    plant = argv[1] if argv and argv[0] == "--plant" else None
    res = run(plant)
    for n, (v, why, det) in res.items():
        print(f"{n}: {v} {why}\n    {det}")
    return 0 if all(v == "GREEN" for v, _, _ in res.values()) else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
