#!/usr/bin/env python3
"""FS111-VM2: blind exact rebuild of DISC7 (M2-DISCK7) and the checks M2-NOSEL, M2-HULLC and M2-REDUCE-C lean on.

DISC7 (as the claim states it): translates of a smooth non-circular convex body K of constant width 1, support function
    h(t) = 1/2 + sin(3t)^3 / 200,
one at each centre of the tight hexagonal seven-colouring (regular hexagons of circumradius 1/2, vertices in the directions
k*pi/3 from their centres), coloured by the index-7 colour lattice of hex7.

Everything decided here is exact (sympy on closed forms; Fractions for bounds).  Floats appear only in two labelled GUARD
lines (the true extremes of the radius of curvature), never in a verdict.

Checks (each prints PASS/FAIL with its reason):
  W   constant width            h(t) + h(t + pi) - 1 == 0 identically
  CV  strict convexity          rho = h + h'' >= c0 - sum|c_k| > 0  (exact Fourier coefficients of rho)
  NC  non-circular              h - 1/2 is not identically 0
  VX  hexagon vertices on dK    h(k pi/3) = 1/2 and h'(k pi/3) = 0 for k = 0..5, so x(k pi/3) = (1/2) u(k pi/3) is the vertex
                                and (K convex) the hexagon lies in K: the bodies cover the plane
  SEP same-colour separation    min colour-lattice distance d_c (exact, enumerated) > 2 * max h + 1   => no unit pair across bodies
  MAX maximality                covering radius of the colour lattice <= 1 + min h  => every point is within distance <= 1 of each
                                colour's union, and (constant width) at distance exactly 1 from it
  LNS neighbours overlap        min h > sqrt(3)/4 (the apothem): every edge of the tiling lies inside a lens of positive area
  EXC exclusive points          each centre lies in no other body (neighbour distance sqrt3/2 > max h)
  FAR non-neighbours disjoint   second-neighbour distance 3/2 > 2 max h
  PAR self-parallel             x(t + pi) = x(t) - u(t): the inward unit parallel of dK is dK
  KAP curvature range           1/rho in [1/(1/2 + R), 1/(1/2 - R)], R = sum|c_k| of rho - 1/2 (exact); GUARD: sampled extremes
  FACE the REDUCE-C face colouring at a vertex (k = 7): the three bodies' tangent lines at a hexagon vertex are distinct; the six
                                sectors alternate one body / two bodies; for all 8 lens choices the merged map has exactly 3
                                boundaries at the vertex (S-V Condition 2's degree >= 3), and no sector is uncovered.

Plants (--plant NAME; each must fail at the check named, for its own reason; the faithful run must pass all):
  amp    amplitude 1/40 instead of 1/200        -> CV fails (and the GUARD shows rho < 0)
  rot    cos(3t)^3 in place of sin(3t)^3         -> VX fails (h = 1/2 -+ 1/200 at the vertex directions: vertices not covered)
  width  sin(3t)^2 in place of sin(3t)^3         -> W fails (and PAR)
  lat4   colouring by the four cosets of 2L      -> SEP fails (same-colour centres sqrt3 apart)
Output: data/fs111/fs111-vm2/disc7.out (faithful) and disc7_plants.out.
Stage 2 addition: --object disck7-m2 runs the same body at M2 §1.6's hex7 lattice (centres m(sqrt3/2, 0) + n(sqrt3/4, 3/4), hexagon
vertices at 30 + 60k degrees): VX fails and a tiling vertex is uncovered by all three adjacent bodies (output disck7_m2orient.out).
Stage 2 addition: --object disc7 runs the same exact checks on M2's DISC7 (the circumscribed discs, h = 1/2; curvature exactly 2);
output data/fs111/fs111-vm2/disc7_discs.out.
"""
from __future__ import annotations
import sys
from fractions import Fraction as Fr
import sympy as sp

t = sp.symbols("t", real=True)
PLANT = None
OBJECT = "disck7"      # --object disc7: M2's DISC7 (circumscribed discs of radius 1/2, h = 1/2), added at stage 2
for i, a in enumerate(sys.argv):
    if a == "--plant":
        PLANT = sys.argv[i + 1]
    if a == "--object":
        OBJECT = sys.argv[i + 1]

LOG = []


def say(s):
    print(s)
    LOG.append(s)


def check(name, ok, why):
    say(f"{name:4s} {'PASS' if ok else 'FAIL'}  {why}")
    return ok


def support():
    if OBJECT == "disc7":
        return sp.Rational(1, 2) + 0 * t
    if PLANT == "amp":
        return sp.Rational(1, 2) + sp.sin(3 * t) ** 3 / 40
    if PLANT == "rot":
        return sp.Rational(1, 2) + sp.cos(3 * t) ** 3 / 200
    if PLANT == "width":
        return sp.Rational(1, 2) + sp.sin(3 * t) ** 2 / 200
    return sp.Rational(1, 2) + sp.sin(3 * t) ** 3 / 200


def fourier(expr):
    """exact Fourier coefficients {k: c_k} of a trigonometric polynomial in t (complex exponential form)."""
    z = sp.symbols("z")
    e = sp.expand(expr.rewrite(sp.exp))
    e = sp.expand(e.subs(sp.exp(sp.I * t), z))
    # after substitution, exp(k*I*t) may remain as exp(I*t)**k -> handled by subs; collect powers of z
    e = sp.expand(e)
    poly = sp.Poly(sp.expand(e * z ** 40), z)
    out = {}
    for (deg,), c in poly.terms():
        k = deg - 40
        c = sp.nsimplify(sp.simplify(c))
        if c != 0:
            out[k] = c
    return out


def abs_sum_nonconst(coeffs):
    """sum over k != 0 of |c_k| (exact: each c_k here is rational or rational * I)."""
    s = sp.Integer(0)
    for k, c in coeffs.items():
        if k != 0:
            s += sp.Abs(c)
    return sp.nsimplify(s)


def main():
    h = support()
    hp = sp.diff(h, t)
    rho = sp.simplify(h + sp.diff(h, t, 2))
    say(f"object = {OBJECT}, plant = {PLANT}")
    say(f"h(t)   = {h}")
    say(f"rho(t) = h + h'' = {sp.simplify(sp.expand_trig(rho))}")
    ok_all = True

    # W: constant width
    wdef = sp.simplify(sp.expand_trig(h + h.subs(t, t + sp.pi) - 1))
    ok_all &= check("W", wdef == 0, f"h(t) + h(t+pi) - 1 = {wdef}")

    # CV: exact lower bound on rho via Fourier coefficients
    cr = fourier(rho)
    c0 = cr.get(0, sp.Integer(0))
    R = abs_sum_nonconst(cr)
    lb = sp.nsimplify(c0 - R)
    say(f"     rho Fourier: {dict(sorted(cr.items()))}")
    ok_all &= check("CV", lb > 0, f"rho >= c0 - sum|c_k| = {c0} - {R} = {lb}")
    # GUARD (float, not a verdict): sampled extremes of rho
    f = sp.lambdify(t, rho, "math")
    vals = [f(2 * 3.141592653589793 * i / 200000) for i in range(200000)]
    say(f"     GUARD (float, sampled 2e5 points): min rho = {min(vals):.6f}, max rho = {max(vals):.6f}; "
        f"curvature range [{1 / max(vals):.4f}, {1 / min(vals) if min(vals) > 0 else float('inf'):.4f}]")

    # NC: non-circular
    ch = fourier(h)
    if OBJECT == "disc7":
        check("NC", not any(k != 0 for k in ch), "h = 1/2: the discs are circles (DISC7 claims no non-circularity; recorded, not required)")
    else:
        ok_all &= check("NC", any(k != 0 for k in ch), f"h - 1/2 has nonzero Fourier modes {sorted(k for k in ch if k != 0)}")

    # bounds on h
    Mh = abs_sum_nonconst(ch)
    h0 = ch.get(0, sp.Integer(0))
    hmin, hmax = sp.nsimplify(h0 - Mh), sp.nsimplify(h0 + Mh)
    say(f"     h bounds (exact, by Fourier): {hmin} <= h <= {hmax}")

    # VX: vertices at k pi/3 on the boundary with h = 1/2 and h' = 0
    vx_ok = True
    VOFF = sp.pi / 6 if OBJECT == "disck7-m2" else 0     # M2 §1.6's hex7: centres m(sqrt3/2, 0) + n(sqrt3/4, 3/4), vertices at 30 + 60k deg
    for k in range(6):
        tv = VOFF + k * sp.pi / 3
        hv, hpv = sp.simplify(h.subs(t, tv)), sp.simplify(hp.subs(t, tv))
        if not (hv == sp.Rational(1, 2) and hpv == 0):
            vx_ok = False
            say(f"     vertex direction {sp.nsimplify(tv)}: h = {hv}, h' = {hpv}")
    ok_all &= check("VX", vx_ok, "h(k pi/3) = 1/2 and h'(k pi/3) = 0 for k = 0..5: every hexagon vertex is x(k pi/3) on dK; K convex "
                    "contains the hexagon" if vx_ok else "some hexagon vertex is not the boundary point of K in its direction")
    if not vx_ok:
        # exact coverage witness: a tiling vertex is seen from its three hexagons' centres in directions t0, t0 + 2pi/3,
        # t0 + 4pi/3; it lies outside body i iff v.u(t) > h(t) for some t, and t = its own direction suffices when h < 1/2 there
        for k0 in range(2):
            t0 = VOFF + k0 * sp.pi / 3
            hs = [sp.simplify(h.subs(t, t0 + j * 2 * sp.pi / 3)) for j in range(3)]
            out = all(hh < sp.Rational(1, 2) for hh in hs)
            say(f"     tiling vertex seen in directions {sp.nsimplify(t0)} + (0, 2pi/3, 4pi/3): h = {hs}: "
                + ("OUTSIDE all three bodies -- uncovered point, the bodies do not cover" if out else "covered by some body"))

    # colour lattice: hex centres L = Z a + Z b, a = (sqrt3/2) e(30deg), b = (sqrt3/2) e(90deg); |m a + n b|^2 = (3/4)(m^2 + mn + n^2)
    if PLANT == "lat4":
        kernel = lambda m, n: m % 2 == 0 and n % 2 == 0
        cname = "cosets of 2L (4 colours)"
    else:
        kernel = lambda m, n: (m + 5 * n) % 7 == 0
        cname = "c(m, n) = (m + 5n) mod 7 (index 7; kernel spanned by (2,1), (-1,3))"
    q = [(m * m + m * n + n * n, m, n) for m in range(-12, 13) for n in range(-12, 13) if (m, n) != (0, 0) and kernel(m, n)]
    qmin = min(q)[0]
    dc2 = Fr(3, 4) * qmin
    say(f"     colouring {cname}: min kernel norm m^2+mn+n^2 = {qmin} (box |m|,|n| <= 12), d_c^2 = {dc2}")
    # SEP: d_c > 1 + 2 hmax
    need = (1 + 2 * Fr(str(hmax))) ** 2
    ok_all &= check("SEP", dc2 > need, f"d_c^2 = {dc2} vs (1 + 2 max h)^2 = {need}: every cross-body same-colour pair is > 1 apart")
    # MAX: covering radius of a triangular lattice of spacing d_c is d_c / sqrt3
    Rc2 = dc2 / 3
    need2 = (1 + Fr(str(hmin))) ** 2
    ok_all &= check("MAX", Rc2 <= need2, f"covering radius^2 = {Rc2} <= (1 + min h)^2 = {need2}: every point within <= 1 of every colour")
    # LNS: min h > sqrt3/4  <=> hmin^2 > 3/16
    ok_all &= check("LNS", Fr(str(hmin)) ** 2 > Fr(3, 16), f"(min h)^2 = {Fr(str(hmin)) ** 2} > 3/16: bodies bulge past every edge")
    # EXC and FAR
    ok_all &= check("EXC", Fr(3, 4) > Fr(str(hmax)) ** 2, f"(sqrt3/2)^2 = 3/4 > (max h)^2 = {Fr(str(hmax)) ** 2}: centres are exclusive")
    ok_all &= check("FAR", Fr(3, 2) > 2 * Fr(str(hmax)), f"3/2 > 2 max h = {2 * Fr(str(hmax))}: only first neighbours meet")

    # PAR: x(t + pi) = x(t) - u(t)
    u = sp.Matrix([sp.cos(t), sp.sin(t)])
    up = sp.Matrix([-sp.sin(t), sp.cos(t)])
    x = h * u + hp * up
    xpi = x.subs(t, t + sp.pi)
    par = sp.simplify(sp.expand_trig(xpi - (x - u)))
    ok_all &= check("PAR", par == sp.zeros(2, 1), f"x(t+pi) - (x(t) - u(t)) = {list(par)}: the unit parallel of dK is dK")

    # KAP: curvature range, exact
    Rr = R
    lo_k = sp.nsimplify(1 / (sp.Rational(1, 2) + Rr))
    hi_k = sp.nsimplify(1 / (sp.Rational(1, 2) - Rr)) if sp.Rational(1, 2) - Rr > 0 else sp.oo
    kap_gt1 = bool(lo_k > 1)
    check("KAP", kap_gt1, f"curvature 1/rho in [{lo_k}, {hi_k}] = [{float(lo_k):.4f}, {float(hi_k):.4f}] (exact bounds); "
          + ("every value > 1: semiconvexity with constant 1 fails everywhere on dK" if kap_gt1 else
             "the exact bound does not put every curvature above 1"))

    # FACE: at a hexagon vertex v shared by H1 (centre 0), H2 (centre (3/4, sqrt3/4)), H3 (centre (3/4, -sqrt3/4)); v = (1/2, 0).
    # In body i the vertex is in direction tv_i from its centre; the outward normal of K_i at v is u(tv_i) (the boundary point
    # x(tv_i) has normal u(tv_i)).  Near v body i is, to first order, {v + d : d . u(tv_i) < 0}.
    if OBJECT == "disck7-m2":
        say("     FACE n/a for this orientation (the bodies do not cover; see VX)")
        say(f"ALL {'PASS' if ok_all else 'FAIL'} (object = {OBJECT}, plant = {PLANT})")
        return ok_all
    s3 = sp.sqrt(3)
    centres = {1: sp.Matrix([0, 0]), 2: sp.Matrix([sp.Rational(3, 4), s3 / 4]), 3: sp.Matrix([sp.Rational(3, 4), -s3 / 4])}
    v = sp.Matrix([sp.Rational(1, 2), 0])
    normals = {}
    face_ok = True
    for i, c in centres.items():
        d = v - c
        tv = sp.atan2(d[1], d[0])
        # the vertex must be a boundary point of K_i: |d| = 1/2 and h(tv) = 1/2, h'(tv) = 0
        if not (sp.simplify(d.dot(d) - sp.Rational(1, 4)) == 0 and sp.simplify(h.subs(t, tv) - sp.Rational(1, 2)) == 0
                and sp.simplify(hp.subs(t, tv)) == 0):
            face_ok = False
        normals[i] = sp.Matrix([sp.cos(tv), sp.sin(tv)])
    # the three tangent lines are distinct iff the normals are pairwise non-parallel
    for i in (1, 2, 3):
        for j in (1, 2, 3):
            if i < j and sp.simplify(normals[i][0] * normals[j][1] - normals[i][1] * normals[j][0]) == 0:
                face_ok = False
    # sector midpoints: the tangent rays are at the directions perpendicular to the normals; test 12 directions e(15 + 30 m) deg
    # and classify (exact signs); sectors are the maximal runs of equal membership.
    dirs = [sp.Matrix([sp.cos(sp.pi * (1 + 2 * m) / 12), sp.sin(sp.pi * (1 + 2 * m) / 12)]) for m in range(12)]
    member = []
    for d in dirs:
        s = frozenset(i for i in (1, 2, 3) if sp.simplify(d.dot(normals[i])) < 0) if face_ok else frozenset()
        member.append(s)
    runs = []
    if not face_ok:
        member = [frozenset()]
    for s in member:
        if not runs or runs[-1] != s:
            runs.append(s)
    if len(runs) > 1 and runs[0] == runs[-1]:
        runs.pop()
    say(f"     sectors at v (ccw from 15 deg): {[sorted(r) for r in runs]}")
    if any(len(r) == 0 for r in runs):
        face_ok = False
        say("     an uncovered sector at v")
    lenses = [r for r in runs if len(r) == 2]
    if len(runs) != 6 or len(lenses) != 3:
        face_ok = False
    degs = []
    import itertools
    for choice in ([] if not face_ok else [None]):
        pass
    for choice in (itertools.product(*[sorted(r) for r in lenses]) if face_ok else []):
        pick = dict(zip(lenses, choice))
        cols = [min(r) if len(r) == 1 else pick[r] for r in runs]
        changes = sum(cols[i] != cols[(i + 1) % len(cols)] for i in range(len(cols)))
        degs.append(changes)
    face_ok = face_ok and all(dg == 3 for dg in degs)
    ok_all &= check("FACE", face_ok, f"six sectors alternating 1/2 bodies; merged degrees over the 8 lens choices: {degs} "
                    f"(each vertex keeps exactly 3 boundaries: Condition 2 holds for the face colouring)")

    say(f"ALL {'PASS' if ok_all else 'FAIL'} (plant = {PLANT})")
    return ok_all


if __name__ == "__main__":
    main()
