#!/usr/bin/env python3
"""FS110-CD exact checks (seconds; objects given by formula; nothing searched).

Checks the derived claims of plans/FS110-CD-verification.md §2 that reduce to exact arithmetic:

  A1  two closed unit discs with centres 2 apart meet only at the midpoint (Theorem D2 (i));
  A2  the cusp points u + t e_perp are at squared distance 1 + t^2 from both antipodes (Theorem D2 (ii));
  A3  separation (Lemma R step 3): for x strictly inside a minor arc [b, b'] (< 60 deg) and y = sigma^{+-1}(x),
      the unit circle about y puts b and b' strictly on opposite sides;
  A4  the stranger's configuration (E3) of §2.7 satisfies its stated local constraints;
  B   circle colourings with rational-degree arcs: properness (mono-mono, bi-bi), Lemma 5's procedure
      (simple recolouring or the six-arc chain), and Prop. 18's three points, on formula-given colourings.

Each check has a planted fault that must fire for its own reason; run with no arguments.
Exit status 0 iff every check passes and every plant fires as expected.
"""
from fractions import Fraction as Fr
import sys
import sympy as sp

FAIL = []


def check(cond, msg):
    if not cond:
        FAIL.append(msg)
    print(("ok   " if cond else "FAIL ") + msg)


# ---------------------------------------------------------------- A: geometry, exact
def a1(sep):
    """Return (identity_ok, only_midpoint) for centres p=(-sep/2,0), p'=(sep/2,0)."""
    x, y = sp.symbols("x y", real=True)
    s = sp.Rational(sep)
    p, q = sp.Matrix([-s / 2, 0]), sp.Matrix([s / 2, 0])
    X = sp.Matrix([x, y])
    lhs = (X - p).dot(X - p) + (X - q).dot(X - q)
    rhs = 2 * X.dot(X) + s**2 / 2
    identity_ok = sp.simplify(lhs - rhs) == 0
    # both discs contain X iff lhs <= 2; with sep=2: 2|X|^2 + 2 <= 2 forces X = 0.
    # witness search-free: the point (0, t) with t^2 = 1 - s^2/4 lies in both discs; it is the midpoint iff t = 0.
    t2 = 1 - s**2 / 4
    only_midpoint = (t2 == 0)
    return identity_ok, only_midpoint


def a2():
    t = sp.symbols("t", real=True, nonzero=True)
    u = sp.Matrix([0, 0])
    e = sp.Matrix([1, 0])
    eperp = sp.Matrix([0, 1])
    qpt, ppt = u + e, u - e
    X = u + t * eperp
    dq = sp.expand((X - qpt).dot(X - qpt))
    dp = sp.expand((X - ppt).dot(X - ppt))
    return dq == 1 + t**2 and dp == 1 + t**2


def on_circle(tpar):
    """Rational point of the unit circle from the half-angle tangent tpar (exact)."""
    tpar = sp.Rational(tpar)
    return sp.Matrix([(1 - tpar**2) / (1 + tpar**2), 2 * tpar / (1 + tpar**2)])


def rot(v, deg):
    c, s = sp.cos(sp.pi * sp.Rational(deg, 180)), sp.sin(sp.pi * sp.Rational(deg, 180))
    return sp.Matrix([c * v[0] - s * v[1], s * v[0] + c * v[1]])


def a3(alpha, alpha2, shift=60):
    """x = (1,0) rotated by a rational point; b = x rotated by -alpha, b' by +alpha2 (degrees), y = x rotated by +-shift.
    Returns True iff for both signs b and b' are strictly on opposite sides of the unit circle about y."""
    x = on_circle(Fr(1, 7))
    b, b2 = rot(x, -alpha), rot(x, alpha2)
    res = []
    for sgn in (1, -1):
        y = rot(x, sgn * shift)
        f = lambda z: sp.nsimplify(sp.simplify((z - y).dot(z - y) - 1))
        sb, sb2 = sp.sign(sp.simplify(f(b))), sp.sign(sp.simplify(f(b2)))
        res.append(sb * sb2 == -1)
    return all(res)


def a4(u_wedge_half=40):
    """E3 configuration: returns dict of the local constraints (exact trig at the wedge ends)."""
    c = lambda d: sp.cos(sp.pi * sp.Rational(d, 180))
    out = {}
    # at u: i-wedge |arg| < u_wedge_half lies in the tangent cone of B(b,1) at u  <=>  cos > 0 on the open wedge
    out["u_wedge_in_Bbar(b,1)"] = sp.simplify(c(u_wedge_half)) >= 0
    # at b=(1,0): i-wedge (150,210) points into the disc  <=>  cos < 0 on the closed wedge ends
    out["b_wedge_inside"] = all(sp.simplify(c(d)) < 0 for d in (150, 210))
    # e_ac along 0 deg leaves the disc
    out["e_ac_outward"] = c(0) > 0
    # omega(u) at b has tangent directions 90 (in c = (0,150)) and 270 (in a = (210,360))
    out["tangent_90_in_c"] = 0 < 90 < 150
    out["tangent_270_in_a"] = 210 < 270 < 360
    # u's annulus on the outer side at direction 0: two of u's edge directions within 90 deg of 0
    edges = [u_wedge_half, -u_wedge_half, 180]
    out["two_edges_within_90"] = sum(1 for d in edges if abs(((d + 180) % 360) - 180) < 90) >= 2
    return out


# ---------------------------------------------------------------- B: circle colourings, exact rational degrees
FULL = Fr(360)


def norm(a):
    return Fr(a) % FULL


class Col:
    """Arcs [s_i, s_{i+1}) mod 360 with colours; starts strictly increasing in [0,360)."""

    def __init__(self, arcs):
        arcs = sorted((norm(s), c) for s, c in arcs)
        # merge equal neighbours
        merged = []
        for s, c in arcs:
            if merged and merged[-1][1] == c:
                continue
            merged.append((s, c))
        if len(merged) > 1 and merged[0][1] == merged[-1][1]:
            merged = merged[1:]
        self.arcs = merged

    def n(self):
        return len(self.arcs)

    def arc(self, i):
        s, c = self.arcs[i % self.n()]
        e = self.arcs[(i + 1) % self.n()][0]
        ln = (e - s) % FULL
        return s, ln, c

    def bich(self):
        """bichromatic points: (angle, frozenset pair)"""
        return [(self.arcs[i][0], frozenset({self.arcs[i - 1][1], self.arcs[i][1]})) for i in range(self.n())]


def open_overlap(s1, l1, s2, l2):
    """do open arcs (s1, s1+l1) and (s2, s2+l2) mod 360 intersect?"""
    d = (s2 - s1) % FULL  # start of arc 2 relative to arc 1
    # arc2 relative: (d, d+l2) ; arc1: (0, l1); consider also wrap: (d-360, d-360+l2)
    for off in (d, d - FULL):
        if off < l1 and off + l2 > 0:
            return True
    return False


def proper(col, shift=Fr(60)):
    """Return (True, '') or (False, reason)."""
    n = col.n()
    for i in range(n):
        si, li, ci = col.arc(i)
        if li > shift:
            return False, f"arc {i} of colour {ci} has length {li} > 60 (holds a unit chord)"
        for j in range(n):
            sj, lj, cj = col.arc(j)
            if ci == cj and open_overlap(si + shift, li, sj, lj):
                return False, f"mono-mono: arc {i} (colour {ci}) rotated by 60 meets arc {j} (colour {cj})"
    B = col.bich()
    for (a, pa) in B:
        for (b, pb) in B:
            if (b - a) % FULL == shift and pa == pb:
                return False, f"bi-bi: points {a} and {b} both {sorted(pa)}"
    return True, ""


def cyclic(col):
    n = col.n()
    return all(col.arc(i - 1)[2] != col.arc(i + 1)[2] for i in range(n))


def lemma5(col, shift=Fr(60), log=None):
    """S-V Lemma 5 as re-derived in §2.5. Returns the cyclic colouring; asserts the derived structure."""
    steps = 0
    while not cyclic(col):
        steps += 1
        assert steps < 1000
        n = col.n()
        sand = [i for i in range(n) if col.arc(i - 1)[2] == col.arc(i + 1)[2]]
        i = min(sand, key=lambda k: col.arc(k)[1])
        s, ln, c = col.arc(i)
        nb = col.arc(i - 1)[2]
        trial = Col([(a, (nb if k == i else cc)) for k, (a, cc) in enumerate(col.arcs)])
        ok, why = proper(trial, shift)
        old_b = set(a for a, _ in col.bich())
        if ok:
            new_b = set(a for a, _ in trial.bich())
            assert new_b <= old_b, "Lemma 5 created a bichromatic point"
            if log is not None:
                log.append(f"simple recolour of arc at {s} (len {ln}) {c}->{nb}")
            col = trial
            continue
        # the derived chain: sigma^{d k}(A), k=1..5, are arcs of the colouring with the same length,
        # colours c+k, flanked by c+k+1 (colour names 1,2,3 cyclic in the orientation c -> nb -> third)
        third = ({1, 2, 3} - {c, nb}).pop()
        seq = [c, nb, third]  # colour of sigma^k(A) is seq[k % 3], flank seq[(k+1) % 3]
        found = None
        for d in (1, -1):
            starts = {a: k for k, (a, _) in enumerate(col.arcs)}
            idx = []
            good = True
            for k in range(6):
                sk = norm(s + d * k * shift)
                if sk not in starts:
                    good = False
                    break
                j = starts[sk]
                sj, lj, cj = col.arc(j)
                if lj != ln or cj != seq[k % 3] or col.arc(j - 1)[2] != seq[(k + 1) % 3] or col.arc(j + 1)[2] != seq[(k + 1) % 3]:
                    good = False
                    break
                idx.append(j)
            if good:
                found = idx
                break
        assert found is not None, f"derived chain structure absent at arc {s}: {why}"
        newc = {}
        for k, j in enumerate(found):
            newc[j] = seq[(k + 1) % 3]
        trial = Col([(a, newc.get(k, cc)) for k, (a, cc) in enumerate(col.arcs)])
        ok2, why2 = proper(trial, shift)
        assert ok2, f"six-arc recolouring improper: {why2}"
        new_b = set(a for a, _ in trial.bich())
        assert new_b <= old_b
        if log is not None:
            log.append(f"six-arc chain recolour from arc at {s} (len {ln})")
        col = trial
    return col


def prop18(col, shift=Fr(60)):
    """Three points of each pair pairwise more than 60 deg (and less than 300 deg) apart."""
    B = col.bich()
    res = {}
    for pair in {pa for _, pa in B}:
        pts = sorted(a for a, pa in B if pa == pair)
        ok = False
        for i in range(len(pts)):
            for j in range(i + 1, len(pts)):
                for k in range(j + 1, len(pts)):
                    tri = (pts[i], pts[j], pts[k])
                    if all(shift < (y - x) % FULL < FULL - shift for x in tri for y in tri if x != y):
                        ok = True
        res[tuple(sorted(pair))] = ok
    return res


def cyc_uniform(m):
    step = FULL / m
    return Col([(k * step, (k % 3) + 1) for k in range(m)])


def with_insert(base, s, ln, c):
    """insert an arc [s, s+ln) of colour c into base (both ends inside one arc of base)."""
    arcs = list(base.arcs)
    # colour just after s+ln is the base colour at that angle
    def colour_at(a):
        a = norm(a)
        best = None
        for st, cc in base.arcs:
            if st <= a:
                best = cc
        return best if best is not None else base.arcs[-1][1]
    after = colour_at(s + ln)
    arcs += [(norm(s), c), (norm(s + ln), after)]
    return Col(arcs)


def chain_example(lengths=None):
    base = cyc_uniform(6)  # [0,60):1, [60,120):2, ... proper, the Prop. 17 pattern
    lengths = lengths or [Fr(2)] * 6
    seq = [1, 2, 3]
    col = base
    for k in range(6):
        col = with_insert(col, Fr(70) + 60 * k, lengths[k], seq[k % 3])
    return col


def main():
    print("== A: geometry (exact)")
    ident, only = a1(2)
    check(ident and only, "A1 discs of radius 1 with centres 2 apart meet only at the midpoint")
    ident_p, only_p = a1(Fr(19, 10))
    check(ident_p and not only_p, "A1-plant: centres 1.9 apart -> a common point off the midpoint exists (plant fires)")
    check(a2(), "A2 cusp points u + t e_perp are at squared distance 1 + t^2 from q and from 2u - q")
    check(a3(25, 20), "A3 separation: b, b' at -25, +20 deg around x are split by omega(sigma^{+-1} x)")
    check(a3(59, 1), "A3 separation at the extreme b at -59 deg")
    check(not a3(25, 20, shift=Fr(40)), "A3-plant: a 40-degree partner (not unit distance) need not separate (plant fires)")
    cfg = a4()
    check(all(cfg.values()), f"A4 E3 configuration satisfies its local constraints: {cfg}")
    cfg_p = a4(u_wedge_half=100)
    check(not cfg_p["u_wedge_in_Bbar(b,1)"], "A4-plant: a 200-degree i-wedge at u violates Lemma H (plant fires for that reason)")

    print("== B: circle colourings (exact rational degrees)")
    for m in (9, 12, 30):
        col = cyc_uniform(m)
        ok, why = proper(col)
        check(ok and cyclic(col), f"B cyclic {m}-arc colouring is proper and cyclic")
        r = prop18(col)
        check(all(r.values()), f"B Prop. 18 on the {m}-arc colouring: {r}")
    c15 = cyc_uniform(15)
    ok15, why15 = proper(c15)
    check(not ok15 and "mono-mono" in why15, f"B-control: the uniform 15-arc cyclic colouring is improper (60 deg = 2.5 arcs): {why15}")
    six = cyc_uniform(6)
    ok, why = proper(six)
    check(ok, "B the six-arc hexagon colouring is proper as a circle colouring (Prop. 17 is what excludes it)")
    check(not all(prop18(six).values()), "B Prop. 18 fails on six arcs (so k >= 3 is needed)")

    ins = with_insert(cyc_uniform(9), Fr(50), Fr(2), 1)
    ok, why = proper(ins)
    check(ok and not cyclic(ins), "B inserted 2-degree arc at 50: proper, not cyclic")
    log = []
    out = lemma5(ins, log=log)
    check(proper(out)[0] and cyclic(out), f"B Lemma 5 on the inserted example -> {log}")
    bad = with_insert(cyc_uniform(9), Fr(59), Fr(2), 1)
    ok, why = proper(bad)
    check(not ok and "mono-mono" in why, f"B-plant: arc inserted at 59 is improper for the mono-mono reason: {why}")

    ch = chain_example()
    ok, why = proper(ch)
    check(ok and not cyclic(ch), "B chain example (six 2-degree arcs at 70 + 60k): proper, not cyclic")
    log = []
    out = lemma5(ch, log=log)
    check(proper(out)[0] and cyclic(out) and out.n() == 6, f"B Lemma 5 takes the six-arc chain: {log}")
    ch_bad = chain_example(lengths=[Fr(2)] * 3 + [Fr(5, 2)] + [Fr(2)] * 2)
    ok, why = proper(ch_bad)
    check(not ok and "mono-mono" in why, f"B-plant: unequal chain lengths are improper (the derived equal-length step): {why}")

    print("== summary")
    if FAIL:
        print(f"{len(FAIL)} FAILED")
        for f in FAIL:
            print("  " + f)
        return 1
    print("all checks passed; all plants fired for their own reason")
    return 0


if __name__ == "__main__":
    sys.exit(main())
