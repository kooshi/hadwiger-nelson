#!/usr/bin/env python3
"""FS131-E5 exact checks for the two derivations of plans/FS131-E5-derivation.md.

Usage: python3 tools/fs131_e5_checks.py <section> [--plant]
Sections (each prints one verdict line; the derive gate compares it with the expected line):
  sh-id      Q1, (SH): the offset identity |y-O|^2 - (1/nu + 1)^2 == -(2/mu) * tanHeight_{S'}(mu)(y), mu = nu/(1+nu),
             and the vertical drop |(p, q-t)|^2 - |(p, q)|^2 == t (t - 2q).   --plant: mu = nu/(1-nu) (curvUp in place of curvDown).
  sh-sample  Q1, (E1)+(E2): for rational horns H- (lower bound nu4 in v's frame, upper nu3), and rational points y near S' = v - n,
             the predicted shadow (X<0: TanAbove S' mu4; X>=0: |y - v| < 1) against the truth, computed independently as
             min dist(y, closure H-) < 1 by minimizing over the three boundary arcs (50-digit mpmath).   --plant: the curvUp map.
  sep-order  Q1, SEP: tanHeight(mu4) - tanHeight(muG) == (muG - mu4) rho^2 / 2, so TanAbove mu4 and TanBelow muG meet iff muG > mu4.
             --plant: the sign flipped.
  claim-e    Q2, Claim E: with P = 0, A = e(0), z = (1+s) e(delta), (1+s) cos delta < 1, no rational grid point p near q_A = 2 A with
             p.e(pi/2) <= 0 satisfies |p - z|^2 <= 1 <= |p - A|^2.   --plant: s = 3 (sec delta - 1), a lens beyond the tangent line.
  end-cap    Q2, the arc side at the end: a lens between omega(P) and a circle beta tangent to omega(P) at A of curvature kappa, against a tile Y
             near q_A outside a circle tangent to the radius-2 circle at q_A of curvature kY < 1/2 (arc side) and outside B(A, 1) (beyond
             side): no lens point within distance <= 1 of a grid point of Y when kappa > kY/(1-kY).   --plant: kappa below the threshold.
Exit status 0 when the section ran (its verdict line is the result); non-zero only on an internal error.
"""
import sys
from fractions import Fraction as Fr

PLANT = "--plant" in sys.argv


def curv_down(nu):
    return nu / (1 - nu) if PLANT else nu / (1 + nu)


def sh_id():
    import sympy as sp
    nu, X, Yp, p, q, t = sp.symbols("nu X Yp p q t", real=True)
    mu = curv_down(nu)
    # frame at v = 0 along a = (1, 0); S' = (0, -1); C has centre O = (0, 1/nu); y = S' + (X, Yp)
    lhs = X**2 + (-1 + Yp - 1 / nu) ** 2 - (1 / nu + 1) ** 2
    rhs = -(2 / mu) * (Yp - mu * (X**2 + Yp**2) / 2)
    d1 = sp.simplify(sp.expand(lhs - rhs))
    d2 = sp.simplify(sp.expand((p**2 + (q - t) ** 2) - (p**2 + q**2) - t * (t - 2 * q)))
    ok = (d1 == 0) + (d2 == 0)
    print(f"SH-ID identities zero: {ok} of 2")


def th(mu, x, y):
    return y - mu * (x * x + y * y) / 2


def sh_sample():
    import mpmath as mp
    mp.mp.dps = 50
    pairs = [(Fr(-1, 2), Fr(1, 4)), (Fr(-1, 5), Fr(1, 2)), (Fr(0), Fr(1, 2)), (Fr(1, 3), Fr(2, 3)), (Fr(3, 5), Fr(1))]
    r = Fr(1, 5)
    agree = total = 0

    def branch(nu, x):  # the circle th(nu) = 0 through the origin, as y(x) near 0
        if nu == 0:
            return mp.mpf(0)
        return (1 - mp.sqrt(1 - (nu * x) ** 2)) / nu

    def min_dist2(y0, nu4, nu3):
        Yx, Yy = mp.mpf(y0[0].numerator) / y0[0].denominator, mp.mpf(y0[1].numerator) / y0[1].denominator

        def f_arc(nu):
            def f(x):
                return (x - Yx) ** 2 + (branch(nu, x) - Yy) ** 2
            return f

        def xend(nu):  # where the arc meets |z| = r (x < 0)
            lo, hi = -mp.mpf(r), mp.mpf(0)
            for _ in range(200):
                mid = (lo + hi) / 2
                if mid**2 + branch(nu, mid) ** 2 > mp.mpf(r) ** 2:
                    lo = mid
                else:
                    hi = mid
            return hi

        best = mp.mpf(10)
        for nu in (nu4, nu3):
            f, a, b = f_arc(mp.mpf(nu.numerator) / nu.denominator), xend(mp.mpf(nu.numerator) / nu.denominator), mp.mpf(0)
            n = 400
            xs = [a + (b - a) * k / n for k in range(n + 1)]
            vals = [f(x) for x in xs]
            k = min(range(n + 1), key=lambda i: vals[i])
            lo, hi = xs[max(k - 1, 0)], xs[min(k + 1, n)]
            g = (mp.sqrt(5) - 1) / 2
            for _ in range(160):
                m1, m2 = hi - g * (hi - lo), lo + g * (hi - lo)
                if f(m1) < f(m2):
                    hi = m2
                else:
                    lo = m1
            best = min(best, f((lo + hi) / 2), vals[0], vals[-1])
        # the outer arc |z| = r between the two arcs: its points are at distance ~ sqrt(r^2 + 1) > 1 from y; include its ends (already in)
        return best

    for nu4, nu3 in pairs:
        mu4 = curv_down(nu4)
        rho = r * r / 50
        for Xf in (Fr(-9, 10), Fr(-1, 2), Fr(-1, 5), Fr(1, 5), Fr(1, 2)):
            X = Xf * rho
            for c in (Fr(-3, 2), Fr(-1, 2), Fr(-1, 10), Fr(1, 10), Fr(1, 2), Fr(3, 2)):
                # place y at height c * X^2 above the true shadow boundary of its side
                base_mu = (nu4 / (1 + nu4)) if X < 0 else Fr(1)
                # solve th_{S'}(base_mu)(X, Yp) = c X^2 to second order: Yp = base_mu X^2 / 2 + c X^2 (then exact th is evaluated)
                Yp = base_mu * X * X / 2 + c * X * X
                y0 = (X, Fr(-1) + Yp)
                true_side = th(base_mu, X, Yp) > 0
                if (th(base_mu, X, Yp) > 0) != (c > 0):
                    continue  # second-order placement failed to land on the intended side; skip (never happens at this scale)
                pred = (th(mu4, X, Yp) > 0) if X < 0 else (th(Fr(1), X, Yp) > 0)
                truth = min_dist2(y0, nu4, nu3) < 1
                total += 1
                agree += (pred == truth)
                del true_side
    print(f"SH-SAMPLE agree {agree} of {total}")


def sep_order():
    import sympy as sp
    m4, mG, x, y = sp.symbols("m4 mG x y", real=True)
    sign = -1 if PLANT else 1
    d = sp.simplify(sp.expand(th(m4, x, y) - th(mG, x, y) - sign * (mG - m4) * (x**2 + y**2) / 2))
    print(f"SEP-ORDER identity zero: {d == 0}")


def rat_cs(tq):
    return (1 - tq * tq) / (1 + tq * tq), 2 * tq / (1 + tq * tq)


def claim_e():
    viol = checked = 0
    for tq in (Fr(1, 50), Fr(1, 20), Fr(1, 10), Fr(1, 5)):
        cd, sd = rat_cs(tq)
        sec_m1 = 1 / cd - 1
        for frac in (Fr(1, 10), Fr(1, 2), Fr(9, 10), Fr(99, 100)):
            s = 3 * sec_m1 if PLANT else frac * sec_m1
            zx, zy = (1 + s) * cd, (1 + s) * sd
            d2 = (2 * tq) ** 2  # ~ delta^2
            for i in range(-20, 21):
                u = Fr(i, 10) * d2
                for j in range(0, 41):
                    v = -Fr(j, 20) * 2 * tq
                    px, py = 2 + u, v
                    checked += 1
                    if (px - zx) ** 2 + (py - zy) ** 2 <= 1 <= (px - 1) ** 2 + py**2:
                        viol += 1
    print(f"CLAIM-E violations {viol} of {checked}")


def end_cap():
    viol = checked = 0
    for kY in (Fr(0), Fr(1, 4), Fr(2, 5), Fr(49, 100)):
        thr = kY / (1 - kY)
        kap = thr - (1 - thr) / 2 if PLANT else (thr + 1) / 2
        # beta: the circle tangent to omega(P) at A = (1, 0) with curvature kap toward P (centre (1 - 1/kap, 0); kap = 0: the line x = 1).
        # On the ray from P at angle delta it sits at the root near 1 of F(rho) = kap rho^2 - 2 rho (kap - 1) cos delta + kap - 2.
        for tq in (Fr(1, 40), Fr(1, 20)):
            cd, sd = rat_cs(tq)
            lo, hi = Fr(1), Fr(11, 10)
            for _ in range(70):
                mid = (lo + hi) / 2
                if kap * mid * mid - 2 * mid * (kap - 1) * cd + kap - 2 < 0:
                    lo = mid
                else:
                    hi = mid
            zx, zy = lo * cd, lo * sd  # the lens's outermost point at this angle (the lens lies between rho = 1 and rho = lo)
            d = 2 * tq
            for i in range(-80, 81):
                px = 2 + Fr(i, 40) * d * d
                for j in range(-60, 61):
                    py = Fr(j, 20) * d
                    # Y: arc side (py > 0) outside the circle of curvature kY tangent to the radius-2 circle at q_A; beyond side outside B(A, 1)
                    if py > 0:
                        if kY == 0:
                            inY = px > 2
                        else:
                            oy = 2 - 1 / kY
                            inY = (px - oy) ** 2 + py**2 > (1 / kY) ** 2
                    else:
                        inY = (px - 1) ** 2 + py**2 > 1
                    if not inY:
                        continue
                    checked += 1
                    if (px - zx) ** 2 + (py - zy) ** 2 <= 1:
                        viol += 1
    print(f"END-CAP violations {viol} of {checked}")


SECTIONS = {"sh-id": sh_id, "sh-sample": sh_sample, "sep-order": sep_order, "claim-e": claim_e, "end-cap": end_cap}

if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if len(args) != 1 or args[0] not in SECTIONS:
        print(__doc__)
        sys.exit(2)
    SECTIONS[args[0]]()
