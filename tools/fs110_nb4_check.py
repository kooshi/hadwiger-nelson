#!/usr/bin/env python3
"""FS110-NB4 exact checks (blind verifier of FS110-N4; written from the statements and the fragment formulas only).

C1  SHADOW: the curvature of the concentric shadow circle, and the second-order extremum identities behind f and f~ (sympy, exact).
C2  FIN: the reciprocal identities, monotonicity, and exit of the extremal sequences in exact rationals; a plant (lambda = upsilon
    allowed) must produce a surviving constant sequence.
C3  WCH (FS110-Y4 §11.4, from its formula): v = (0,0) is doubly shadowed along the tip at p = (T, 0) -- exact rational witnesses on
    omega(p) strictly inside N's colour-3 horn and inside S''s colour-2 horn; and colour 1 cannot sit directly above N's 3-horn
    (exact witness in v's colour-1 horn), which is FIN's first upward step failing (f~(1/2) = 1 > 1/2).
C4  WC1H (from its formula): v is cubic with a cusp; SHAVE split along y = 0 is valid (exact inequalities); both single-colour tip
    recolourings have exact witnesses at distance exactly 1.
Plants: each check has a planted fault that must fire for its own reason (run with --plants).
Every verdict is printed; the exit status is 0 only if every check passes and every plant fires.
"""
import sys
from fractions import Fraction as Q
import sympy as sp

FAIL = []


def check(name, ok, detail=""):
    print(("PASS " if ok else "FAIL ") + name + ((" -- " + detail) if detail else ""))
    if not ok:
        FAIL.append(name)
    return ok


# ---------------------------------------------------------------- C1 SHADOW
def c1_shadow():
    lam, ups, T, Y, x = sp.symbols("lambda upsilon T Y x", real=True)
    f = lam / (1 + lam)
    ft = ups / (1 - ups)
    # lambda > 0: tile = disc of radius 1/lam about C = N + n/lam, N = (0,1); |C - v| = 1 + 1/lam; curvature 1/(1+1/lam) = f
    check("C1a curvature of shadow circle, lam>0", sp.simplify(1 / (1 + 1 / lam) - f) == 0)
    # -1 < lam < 0: tile = outside disc of radius 1/|lam| about C = N + n/lam (below v); |C - v| = 1/|lam| - 1 = -1/lam - 1;
    # the circle is centred below v, so its signed curvature (toward +n) is -1/(-1/lam - 1) = lam/(1+lam) = f
    check("C1b curvature of shadow circle, -1<lam<0", sp.simplify(-1 / (-1 / lam - 1) - f) == 0)
    # second-order model going down: omega(p) near N is y = Y - (x-T)^2/2; region above y = lam x^2/2 is met iff Y > f T^2/2
    g = Y - (x - T) ** 2 / 2 - lam * x ** 2 / 2
    xs = sp.solve(sp.diff(g, x), x)[0]
    check("C1c max_x [Y-(x-T)^2/2-lam x^2/2] = Y - f T^2/2", sp.simplify(g.subs(x, xs) - (Y - f * T ** 2 / 2)) == 0,
          "argmax x = %s" % xs)
    # going up: omega(p) near S' is y = Y + (x-T)^2/2; region below y = ups x^2/2 is met iff Y < f~ T^2/2
    h = Y + (x - T) ** 2 / 2 - ups * x ** 2 / 2
    xs2 = sp.solve(sp.diff(h, x), x)[0]
    check("C1d min_x [Y+(x-T)^2/2-ups x^2/2] = Y - f~ T^2/2", sp.simplify(h.subs(x, xs2) - (Y - ft * T ** 2 / 2)) == 0,
          "argmin x = %s" % xs2)
    # in-type contact at N with arc curvature k > 1 (tile inside the disc of radius 1/k about C = N - n/k): the shadow boundary is the
    # circle through v centred at C, curvature 1/(1-1/k) = k/(k-1) > 1
    k = sp.symbols("k", positive=True)
    check("C1e in-type shadow curvature k/(k-1) > 1 for k > 1", sp.simplify(1 / (1 - 1 / k) - k / (k - 1)) == 0
          and sp.simplify(k / (k - 1) - 1 - 1 / (k - 1)) == 0)


# ---------------------------------------------------------------- C2 FIN
def f(l):
    return l / (1 + l)


def ft(u):
    return u / (1 - u)


def c2_fin(strict=True):
    lam, ups = sp.symbols("lambda upsilon", real=True)
    ok1 = sp.simplify(1 / (lam / (1 + lam)) - 1 / lam - 1) == 0 and sp.simplify(1 / (ups / (1 - ups)) - 1 / ups + 1) == 0
    ok2 = sp.simplify((lam / (1 + lam)).subs(lam, ups / (1 - ups)) - ups) == 0
    ok3 = sp.simplify(sp.diff(lam / (1 + lam), lam) - 1 / (1 + lam) ** 2) == 0 and sp.simplify(
        sp.diff(ups / (1 - ups), ups) - 1 / (1 - ups) ** 2) == 0
    if strict:
        check("C2a 1/f = 1/lam + 1, 1/f~ = 1/ups - 1, f(f~(u)) = u, f, f~ increasing", ok1 and ok2 and ok3)
    # extremal sequences: going up, ups_{k+1} >= f~(ups_k); going down, lam_{k-1} <= f(lam_k). Monotonicity makes the extremal
    # sequences bound every admissible one. From every rational start on a grid, they must leave (-1, 1) within the stated bounds.
    worst = 0
    survivors = []
    starts = [(Q(a, 97) - Q(1, 2) * 0, Q(b, 97)) for a in range(-96, 97) for b in range(-96, 97)]
    for (l0, u0) in starts:
        if not (l0 < u0 if strict else l0 <= u0):
            continue
        if u0 > 0:
            u, steps = u0, 0
            while u < 1:
                if u >= Q(1, 2):
                    u, steps = Q(1), steps + 1  # f~(u) >= 1
                    break
                u, steps = ft(u), steps + 1
                if steps > 10 ** 4:
                    break
            bound = int(1 / u0) + 1
            worst = max(worst, steps - bound)
            if u < 1:
                survivors.append((l0, u0))
        elif l0 < 0:
            l, steps = l0, 0
            while l > -1:
                if l <= Q(-1, 2):
                    l, steps = Q(-1), steps + 1
                    break
                l, steps = f(l), steps + 1
                if steps > 10 ** 4:
                    break
            bound = int(1 / (-l0)) + 1
            worst = max(worst, steps - bound)
            if l > -1:
                survivors.append((l0, u0))
        else:
            survivors.append((l0, u0))  # l0 >= 0 >= u0 with l0 <= u0: only (0, 0), reachable only when strict is False
    return survivors, worst


# ---------------------------------------------------------------- geometry helpers (exact rationals)
def on_unit_circle(p, s):
    """Rational point of omega(p) with parameter s (tan of half the angle)."""
    d = 1 + s * s
    return (p[0] + (1 - s * s) / d, p[1] + 2 * s / d)


def d2(a, b):
    return (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2


def rat_s_toward(p, target):
    """s = tan(theta/2) for the direction from p to target, as an exact rational close to it (computed, not searched)."""
    th = sp.atan2(sp.Rational(target[1] - p[1]), sp.Rational(target[0] - p[0]))
    return Q(str(sp.N(sp.tan(th / 2), 40))).limit_denominator(10 ** 15)


# WCH (FS110-Y4 §11.4): v's colour-1 horn between the circles of radius 2 about (0, +-2) (box |x| <= 1/10); colour 2 above, 3 below.
# N = (0,1): colour-3 double horn between the circle of radius 4 about (0,-3) (lower) and radius 2 about (0,3) (upper); colour-1 disc
# of radius 1/2 about (0,3/2); ring piece (colour 4) elsewhere near N. S' = (0,-1): the mirror y -> -y with (2 3)(4 5).
def in_v_horn(z, L=Q(1, 10)):
    return d2(z, (0, 2)) > 4 and d2(z, (0, -2)) > 4 and 0 < abs(z[0]) <= L


def in_N_3horn(z, L=Q(1, 20)):
    return d2(z, (0, -3)) > 16 and d2(z, (0, 3)) > 4 and 0 < abs(z[0]) <= L and abs(z[1] - 1) < Q(1, 100)


def in_S_2horn(z, L=Q(1, 20)):
    return in_N_3horn((z[0], -z[1]), L)


def in_N_3horn_planted(z, L=Q(1, 20)):
    # plant: N's colour-3 horn raised into the band between the arc of radius 2 about (0,3) (curvature 1/2) and N's colour-1 disc
    # (curvature 2): its lower arc has lambda = 1/2, so sigma_h = f(1/2) = 1/3 and p = (T, 0) is no longer h-shadowed
    return d2(z, (0, 3)) < 4 and d2(z, (0, Q(3, 2))) > Q(1, 4) and 0 < abs(z[0]) <= L and abs(z[1] - 1) < Q(1, 100)


def c3_wch(plant=False):
    res = {}
    for T in (Q(1, 100), Q(1, 1000)):
        p = (T, Q(0))
        # p in v's horn, and in the open shadows: outside the circle of radius 3 about (0,-3) (h) and about (0,3) (g)
        inside = in_v_horn(p) or (d2(p, (0, 2)) > 4 and d2(p, (0, -2)) > 4)
        res[("p in horn", T)] = inside and d2(p, (0, -3)) > 9 and d2(p, (0, 3)) > 9
        # exact witness in N's 3-horn: the farthest point of omega(p) from (0,-3), approximated rationally on omega(p)
        n = sp.sqrt(sp.Rational(T) ** 2 + 9)
        target = (sp.Rational(T) + sp.Rational(T) / n, 3 / n)
        tgt = (Q(str(sp.N(target[0], 40))), Q(str(sp.N(target[1], 40))))
        s = rat_s_toward(p, tgt)
        z = on_unit_circle(p, s)
        horn = in_N_3horn_planted if plant else in_N_3horn
        res[("3-witness", T)] = d2(z, p) == 1 and horn(z)
        zm = on_unit_circle(p, -s)  # the mirror direction: (z_x, -z_y)
        res[("2-witness", T)] = d2(zm, p) == 1 and in_S_2horn(zm)
    if plant:
        return res
    for key, ok in res.items():
        check("C3 WCH %s T=%s" % key, ok)
    # colour 1 directly above N's 3-horn is refused: q = N + (T, Y) with Y just above the horn's upper arc (radius 2 about (0,3)) and
    # below T^2/2 = the upper edge of v's horn shadow at N (f~(1/2) = 1); exact witness on omega(q) inside v's colour-1 horn.
    T, Y = Q(1, 100), Q(4, 100000)
    q = (T, 1 + Y)
    above_3horn = d2(q, (0, 3)) < 4 and d2(q, (0, Q(3, 2))) > Q(1, 4)  # below the upper-arc circle?  (see note)
    # the 3-horn is OUTSIDE the disc of radius 2 about (0,3); the region between the horn and the colour-1 disc is inside that disc
    # and outside the colour-1 disc: that is where the formula puts colour 4
    target = (2 * T, q[1] - sp.sqrt(1 - sp.Rational(T) ** 2))
    tgt = (Q(str(sp.N(target[0], 40))), Q(str(sp.N(target[1], 40))))
    s = rat_s_toward(q, tgt)
    z = on_unit_circle(q, s)
    check("C3 WCH: q = N+(1/100, 4e-5) lies between N's 3-horn and N's colour-1 disc (colour 4 there)", above_3horn)
    check("C3 WCH: colour 1 at q would see v's colour-1 horn at distance exactly 1 (FIN's first upward step)",
          d2(z, q) == 1 and in_v_horn(z), "z = (%s, %s)" % (float(z[0]), float(z[1])))


# WC1H (FS110-Y4 §11.4): v's single colour-1 horn along +a (x > 0) between the circles of radius 2 about (0,+-2); colour 2 above, 3 below,
# the 2|3 boundary along -a. N: colour 1 the sector (60, 180) deg, colour 3 the sector (0, 60) deg (lower ray along +a), ring (4) below
# y = 1. S': mirror with (2 3)(4 5): colour 2 the sector (-60, 0) deg about S', colour 1 (-180, -60), ring (5) above y = -1.
def in_N_3sector(z, planted=False):
    x, y = z[0], z[1] - 1
    if planted:  # wc1h_ylow-type plant: the 3-sector turned to reach -30 deg: (-30, 30) deg
        return x > 0 and 3 * y * y < x * x and 0 < x * x + y * y < Q(1, 100)
    return x > 0 and y > 0 and y * y < 3 * x * x and x * x + y * y < Q(1, 100)


def in_S_2sector(z):
    return in_N_3sector((z[0], -z[1]))


def c4_wc1h(plant=False):
    out = {}
    # (i) the split is valid: every tip point with y > 0 is at distance > 1 from every point with y < -1 (S''s 2-sector lies in
    # y < -1), and every tip point with y < 0 at distance > 1 from every point with y > 1 (N's 3-sector lies in y > 1).
    # The inequality |p - q| >= |p_y - q_y| > 1 is the proof; here we check the sector formulas lie in those half-planes by their
    # defining inequalities (symbolically: y > 0 is part of the definition), and verify on exact sample points of the sectors.
    samples = [(Q(i, 400), Q(j, 400)) for i in range(1, 40) for j in range(-39, 40)]
    n3 = [(x, 1 + y) for (x, y) in samples if in_N_3sector((x, 1 + y), planted=plant)]
    s2 = [(x, -1 - y) for (x, y) in samples if in_S_2sector((x, -1 - y))]
    out["N 3-sector in y > 1"] = all(q[1] > 1 for q in n3) and len(n3) > 0
    out["S' 2-sector in y < -1"] = all(q[1] < -1 for q in s2) and len(s2) > 0
    if plant:
        return out
    for k_, ok in out.items():
        check("C4 WC1H " + k_, ok)
    # (ii) single-colour tip recolourings refused, exact witnesses
    for T in (Q(1, 100), Q(1, 1000)):
        p_low = (T, -T * T / 8)  # in v's horn (|y| < ~T^2/4), below the tangent line
        p_up = (T, T * T / 8)
        z2 = (p_low[0], p_low[1] - 1)  # bottom of omega(p_low)
        z3 = (p_up[0], p_up[1] + 1)  # top of omega(p_up)
        check("C4 WC1H tip->2 refused at T=%s: omega(p) meets S''s 2-sector" % T,
              in_v_horn(p_low) and d2(z2, p_low) == 1 and in_S_2sector(z2))
        check("C4 WC1H tip->3 refused at T=%s: omega(p) meets N's 3-sector" % T,
              in_v_horn(p_up) and d2(z3, p_up) == 1 and in_N_3sector(z3))
        # and the split points are not refused by these sectors: p_up is colour 2 after SHAVE, p_low colour 3
        check("C4 WC1H after SHAVE at T=%s: p_up (colour 2) has y > 0, p_low (colour 3) has y < 0" % T, p_up[1] > 0 > p_low[1])


def main():
    plants = "--plants" in sys.argv
    c1_shadow()
    surv, worst = c2_fin(strict=True)
    check("C2b FIN: no admissible start survives (strict)", surv == [], "survivors=%d" % len(surv))
    check("C2c FIN: exit within the stated bound 1/ups (up) or 1/|lam| (down)", worst <= 0, "max excess=%d" % worst)
    c3_wch()
    c4_wc1h()
    if plants:
        print("---- plants (each must fire for its own reason)")
        surv_p, _ = c2_fin(strict=False)
        check("PLANT C2 (lambda = upsilon allowed) produces the constant survivor (0,0)", (Q(0), Q(0)) in surv_p,
              "survivors=%s" % surv_p[:3])
        r = c3_wch(plant=True)
        fired = all(not ok for k_, ok in r.items() if k_[0] == "3-witness") and all(ok for k_, ok in r.items() if k_[0] == "2-witness")
        check("PLANT C3 (N's 3-horn raised above v's horn): the 3-witness fails, the 2-witness still holds", fired)
        r4 = c4_wc1h(plant=True)
        check("PLANT C4 (N's 3-sector reaches -30 deg): the half-plane check y > 1 fails", not r4["N 3-sector in y > 1"]
              and r4["S' 2-sector in y < -1"])
    print("SUMMARY: %d failures %s" % (len(FAIL), FAIL))
    sys.exit(1 if FAIL else 0)


if __name__ == "__main__":
    main()
