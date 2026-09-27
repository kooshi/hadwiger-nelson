#!/usr/bin/env python3
"""FS106-TQ: exact and numerical checks of the constants behind C-Q-REM, C-Q-HOLEa and the eps^2 bound,
the two controls, and the held numbers of [Parts2020c].  Every check returns (ok, message); every check has a
planted fault (`--plant NAME`) that must make exactly that check fail, for the reason named in its message.

Grades: checks marked [exact] use sympy rationals/radicals; [float] ones evaluate a closed form on a grid with a
stated margin and are a sanity check on a hand proof, never the proof.

Usage:  python3 tools/fs106_tq_checks.py            # all checks, exit 0 iff all pass
        python3 tools/fs106_tq_checks.py --plant X  # exit 0 iff the planted check fails and all others pass
"""
import math
import sys

import sympy as sp

PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------------------------------------------------
# REM-i: the two-radius kept condition refutes a monochromatic band pair when (1-eta)/4 > pi*eta   [exact]
# good pairs >= (1-eta) eps^3 / 4 ;  bad pairs <= pi * eta * eps^3   (hand, plans/FS106-TQ-derivation.md 2.2)
def check_rem_constant():
    eta = sp.Rational(1, 10) if planted("rem_constant") else sp.Rational(1, 20)
    margin = (1 - eta) / 4 - sp.pi * eta
    ok = bool(margin > 0)
    thr = 1 / (1 + 4 * sp.pi)
    return ok, f"eta={eta}: (1-eta)/4 - pi*eta = {sp.N(margin, 8)} (>0 needed); threshold eta < 1/(1+4pi) = {sp.N(thr, 8)}"


# REM-i chord lemma: for |D-1| <= 3eps/2 and 0 < eps <= 1/2, the unit circle about x' (|x'-y| = D) has an arc of
# length >= 2 eps inside B(y, 2 eps).  Closed form: arc = 2*arccos((1 + D^2 - R^2)/(2D)), R the ball radius.  [float]
def check_rem_chord():
    R_factor = 1.0 if planted("rem_chord") else 2.0     # plant: ball of radius eps instead of 2 eps
    worst = float("inf")
    for i in range(1, 501):
        eps = 0.5 * i / 500
        R = R_factor * eps
        for j in range(-300, 301):
            D = 1 + 1.5 * eps * j / 300
            c = (1 + D * D - R * R) / (2 * D)
            arc = 0.0 if c >= 1 else (2 * math.pi if c <= -1 else 2 * math.acos(c))
            worst = min(worst, arc / (2 * eps))
    ok = worst >= 1 - 1e-12
    return ok, f"min over grid of arc/(2 eps) = {worst:.6f} (>= 1 needed; ball radius {R_factor:g} eps)"


# Pointwise core (D1 / A3 with explicit constants): good >= theta r^3/16, bad <= pi eta r^3/4.  [exact]
def check_core_constant():
    theta = sp.Rational(1, 100)
    eta = theta / (2 * sp.pi) if planted("core_constant") else theta / (8 * sp.pi)
    margin = theta / 16 - sp.pi * eta / 4
    return bool(margin > 0), f"theta={theta}, eta={sp.N(eta, 6)}: theta/16 - pi*eta/4 = {sp.N(margin, 6)} (>0 needed)"


# ---------------------------------------------------------------------------------------------------------
# Control 1: the tight hexagonal 7-colouring, regular hexagons of side s = 1/2 (diameter exactly 1).  [exact]
def check_hex_tight():
    s = sp.Rational(11, 20) if planted("hex_tight") else sp.Rational(1, 2)
    diam = 2 * s
    same = (sp.sqrt(21) - 2) * s          # distance between nearest same-colour hexagons, index-7 sublattice
    ok = bool(diam <= 1) and bool(same > 1)
    tight = bool(sp.Eq(diam, 1))
    return ok, (f"s={s}: diameter {diam} (<=1 needed, =1 is tight: {tight}); same-colour gap (sqrt21-2)s = "
                f"{sp.N(same, 8)} (>1 needed)")


# Control 1, geometry of its monochromatic band pairs: x,y in one hexagon H with |x-y| >= 1-eps have some vertex
# within 4eps/3 of x or of y (hand: the 60-degree cones at opposite vertices, |x-y|^2 <= 1-(a+b)+(a+b)^2, so
# (a+b)(1-(a+b)) <= 2eps and a+b <= 8eps/3).  Plant: 0.4 eps, below the axis pair a = b = eps/2.  [float]
def check_hex_pairs():
    eps = 0.05
    tol = 0.4 * eps if planted("hex_pairs") else 4.0 * eps / 3
    verts = [(0.5 * math.cos(math.pi * k / 3), 0.5 * math.sin(math.pi * k / 3)) for k in range(6)]

    def inside(px, py):
        for k in range(6):
            ax, ay = verts[k]
            bx, by = verts[(k + 1) % 6]
            if (bx - ax) * (py - ay) - (by - ay) * (px - ax) < -1e-15:
                return False
        return True

    pts = []
    N = 70
    for i in range(N + 1):
        for j in range(N + 1):
            px, py = -0.5 + i / N, -0.5 + j / N
            if inside(px, py):
                pts.append((px, py))
    pts += verts
    near = [min(math.dist(p, v) for v in verts) for p in pts]
    bad = 0
    count = 0
    for a in range(len(pts)):
        for b in range(a + 1, len(pts)):
            if math.dist(pts[a], pts[b]) >= 1 - eps:
                count += 1
                if min(near[a], near[b]) > tol:
                    bad += 1
    return bad == 0, f"eps={eps}: {count} grid pairs at distance >= 1-eps; {bad} with no point within {tol:.3f} of a vertex"


# Control 1, non-keeping near a vertex: a point x of H within 4eps/3 of a vertex v has B(x, 2eps) containing
# B(v, 2eps/3), of which H covers only 1/3 (the 120-degree angle); so the outside fraction of B(x,2eps) is
# >= (2/3)(1/9) = 2/27.  [exact]
def check_hex_nonkept():
    eta = sp.Rational(1, 10) if planted("hex_nonkept") else sp.Rational(1, 20)
    outside = sp.Rational(2, 3) * sp.Rational(1, 9)
    return bool(outside > eta), f"outside fraction >= {outside} > eta = {eta} needed"


# ---------------------------------------------------------------------------------------------------------
# The eps^2 bound: in every disc U_3(z) a hole contains B(q,t) cap U_3(z) for t -> eps/2; for q in U_3(z), t <= 1,
# |B(q,t) cap U_3(z)| >= pi t^2 / 4 (hand: the sector of B(q,t) toward z of half-angle pi/4 ... see record).  [float]
def check_disc_cap():
    worst = float("inf")
    R = 3.0
    for i in range(1, 41):
        t = i / 40
        for j in range(0, 61):
            d = R * j / 60                       # |q - z|
            # area of intersection of discs radius t (centre at distance d) and R
            if d + t <= R:
                area = math.pi * t * t
            else:
                a1 = t * t * math.acos((d * d + t * t - R * R) / (2 * d * t))
                a2 = R * R * math.acos((d * d + R * R - t * t) / (2 * d * R))
                a3 = 0.5 * math.sqrt(max(0.0, (-d + t + R) * (d + t - R) * (d - t + R) * (d + t + R)))
                area = a1 + a2 - a3
            worst = min(worst, area / (math.pi * t * t))
    need = 0.5 if planted("disc_cap") else 0.25
    return worst >= need, f"min |B(q,t) cap U_3| / (pi t^2) = {worst:.6f} over q in U_3, t in (0,1] (>= {need} needed)"


# ---------------------------------------------------------------------------------------------------------
# [Parts2020c]: the held numbers.  rho6 = 6992.1655504123 (p. 7), delta6 = 1/rho6 ~ 0.000143017209, coverage
# > 99.985698 %.  Consistency: the straight-sided void formula S_Delta = lp+nr+mq-np+vs+wt at his optimal
# parameters gives rho ~ 6985, his Table 1 "straight, wavy" value 6985.378399; curving adds ~0.1 %.   [exact arithmetic]
def check_parts():
    rho6 = sp.Rational("6197.5793083297") if planted("parts") else sp.Rational("6992.1655504123")
    delta6 = 1 / rho6
    cover = 1 - delta6
    ok1 = bool(cover > sp.Rational("0.99985698"))
    P = {k: sp.Rational(v) for k, v in dict(x="0.9220971880", y="0.5", l="0.0133435475", m="0.0099987220",
                                           n="0.0033448254", v="0.0033448254", w="0.0033448254", p="0.0008269367",
                                           q="0.0035745405", r="0.0054885277", s="0.0005758591",
                                           t="0.0005111915").items()}
    SD = P["l"] * P["p"] + P["n"] * P["r"] + P["m"] * P["q"] - P["n"] * P["p"] + P["v"] * P["s"] + P["w"] * P["t"]
    rho_straight = P["x"] * P["y"] / SD
    ok2 = abs(float(rho_straight) - 6985.378399) < 10
    return ok1 and ok2, (f"delta6 = {sp.N(delta6, 10)}, coverage {sp.N(cover, 12)} (> 0.99985698 needed); "
                         f"straight-sided rho at his parameters = {sp.N(rho_straight, 10)} (Table 1: 6985.378399)")


CHECKS = [check_rem_constant, check_rem_chord, check_core_constant, check_hex_tight, check_hex_pairs,
          check_hex_nonkept, check_disc_cap, check_parts]
NAMES = ["rem_constant", "rem_chord", "core_constant", "hex_tight", "hex_pairs", "hex_nonkept", "disc_cap", "parts"]


def main():
    global PLANT
    if len(sys.argv) == 3 and sys.argv[1] == "--plant":
        PLANT = sys.argv[2]
        if PLANT not in NAMES:
            print(f"unknown plant {PLANT}; choose from {NAMES}")
            return 2
    fails = []
    for name, chk in zip(NAMES, CHECKS):
        ok, msg = chk()
        print(f"{'PASS' if ok else 'FAIL'}  {name}: {msg}")
        if not ok:
            fails.append(name)
    if PLANT is None:
        print("ALL PASS" if not fails else f"FAILED: {fails}")
        return 0 if not fails else 1
    good = fails == [PLANT]
    print(f"PLANT {PLANT}: {'fired alone, as required' if good else f'WRONG — failures {fails}'}")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main())
