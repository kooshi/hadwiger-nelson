#!/usr/bin/env python3
"""FS110-CE: exact checks of the hand derivations in plans/FS110-CE-verification.md § Stage 2 (FS110-CB's D4 and D5 items 1-4, 6 at cusps).

Every check is an exact check of a derived claim, seconds; no search for a witness (standing rule 3).
  BIKE  D4's endpoint analysis, exhausted.  Lifts with a = f(y1^in) = 0; each 60-degree step of the E band raises f by 3k + e, e in {1,2}, any k
        (CB takes k = 0 "WLOG"; k = -1 is its mirror, |k| >= 2 dies on the D band); J, Jz in {-1,0,1} (Jz = 0 when d <= sqrt 3); G = g(x1^<-).
        Constraints: D_y = G, D_z = G - f(z1^app) in one band {3m+1, 3m+2}; c'(x1) contains the residues of f(x1^y), f(x1^z), G and has size <= 2;
        c'(z1) contains f(z1^in), f(z1^app); (ii): c'(x1) = c'(z1) with two elements is impossible.  A point whose known residues are ONE colour may
        carry an unknown second colour (a spike, e.g. a horn touching the circle): treated adversarially, so (ii) fires only on fully known sets.
        Claim: no assignment survives, for d <= sqrt 3 and for d > sqrt 3.
  AL    the Antipodal Lemma: at a trichromatic centre u (ordinary, cusp, double cusp), an arc point x != u never lies within 1 of both u + e and u - e,
        so the strip's majority side is never "outside" at both e and -e.  Exact votes sign(|u +- e - x|^2 - 1) on rational circle arcs and segments,
        at two small parameters, over about 80 rational directions e including the cusp normal.  Also records that "inside" at both ends DOES occur
        (the a6 horn at +-n): the lemma is one-sided, which is why the repair keeps only V-in points on the circle.
  BETA  FS110-CD's (beta) configuration in rational form: v' = (1,0); edges a|c along (-4,3)/5, a|i along (-1,0), c|i along (-4,-3)/5; the path P
        is the circle of centre (4/3, 4/9), radius 5/9, tangent to (-4,3) at v', through b = (4/5, 3/5), inside the open disc between them.
        Claim: item 2's colour (the tile beside P outside Q) is a, while the circle just beyond v' is c.
  SPIKE a path tangent to the circle from inside (circle of radius 1/2 centred (1/2, 0), touching at s = (1,0) only): the tile between P and the
        circle is the circle's colour S on both sides of s, so item 2's colour (P's far side, T) differs from the colour beyond s.
  E3H   an (E3) vertex whose third sector is a HORN: b = (1,0), horn edges the circles of radius 1/2 and 1/3 internally tangent at b (curvatures 2, 3
        toward u), the a|c edge the segment along +x.  Claim: the horn lies strictly inside the disc near b, the circle does not enter it, the a|c
        edge leaves the disc: a colour change of the circle with no inward a|c path (CB's item 4 presumes one).
Plants (--plant NAME), each predicted to make its check report a failure for the reason named:
  noII           BIKE without (ii): assignments survive (the cases CB closes by (ii) reopen).
  noClosure      BIKE without G in c'(x1): assignments survive (the cases CB closes by "G's colour lies in c'(x1)" reopen).
  nearAntipodal  AL with e' = (s, -c) in place of -e = (-s, -c): a double cusp along +tau votes "outside" at both (the lemma needs exact antipodes).
"""
from __future__ import annotations
import sys
from fractions import Fraction as Fr
import itertools

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
FAIL = []


def say(ok, msg):
    print(("ok    " if ok else "FAIL  ") + msg)
    if not ok:
        FAIL.append(msg)


# ---------------- BIKE ----------------
def band(D):
    return None if D % 3 == 0 else (D - 1) // 3


def bike(overshoot):
    survivors = []
    for k, J, Jz, e1, e2, G in itertools.product(range(-3, 4), (-1, 0, 1), (-1, 0, 1), (1, 2), (1, 2), range(-12, 13)):
        if not overshoot and Jz != 0:
            continue
        s1, s2 = 3 * k + e1, 3 * k + e2
        fxz, fxy = s1, s1 - J                     # f(x1^z) = a + step, f(x1^y) = f(x1^z) - J
        fzin = fxy + s2                            # f(z1^in) = f(x1^y) + step
        fzap = fzin + Jz                           # f(z1^approach)
        Dy, Dz = G, G - fzap
        if band(Dy) is None or band(Dz) is None or band(Dy) != band(Dz):
            continue
        cx = {fxy % 3, fxz % 3} | ({G % 3} if PLANT != "noClosure" else set())
        cz = {fzin % 3, fzap % 3}
        if len(cx) > 2:
            continue
        if PLANT != "noII" and len(cx) == 2 and cx == cz:
            continue
        survivors.append((k, J, Jz, e1, e2, G))
    return survivors


for ov in (False, True):
    sv = bike(ov)
    say(not sv, f"BIKE d {'> sqrt3 (overshoot)' if ov else '<= sqrt3'}: {len(sv)} surviving assignments"
        + (f", e.g. (k,J,Jz,e1,e2,G) = {sv[:3]}" if sv else ""))

# ---------------- AL ----------------
def unit(p, q):                                   # rational unit vector from a Pythagorean parameter
    return (Fr(q * q - p * p, p * p + q * q), Fr(2 * p * q, p * p + q * q))


def arc_point(t, kappa, mu):
    """point of the arc leaving u = 0 with unit tangent t and signed curvature kappa toward the left normal, at small parameter mu > 0."""
    nl = (-t[1], t[0])
    if kappa == 0:
        return (mu * t[0], mu * t[1])
    R = 1 / Fr(kappa)
    m = mu if R > 0 else -mu                      # move along +t
    a, b = 2 * R * m / (1 + m * m), 2 * R * m * m / (1 + m * m)
    return (a * t[0] + b * nl[0], a * t[1] + b * nl[1])


def vote_out(x, e):                               # arc point x votes "outside" at e iff |u + e - x| < 1
    return (e[0] - x[0])**2 + (e[1] - x[1])**2 - 1 < 0


TAU, NEG = (Fr(1), Fr(0)), (Fr(-1), Fr(0))
CENTRES = {
    "ordinary": [(TAU, Fr(1, 2)), (unit(2, 1), Fr(-3)), (unit(1, 3), Fr(0))],
    "cusp, straddling horn (kappa 3, 1/2) + arc": [(TAU, Fr(3)), (TAU, Fr(1, 2)), (unit(3, 1), Fr(2, 3))],
    "a6 cusp (kappa 1/2, -1/2) + segment along -tau": [(TAU, Fr(1, 2)), (TAU, Fr(-1, 2)), (NEG, Fr(0))],
    "cusp, horn (kappa 3, 2) + segment along -tau": [(TAU, Fr(3)), (TAU, Fr(2)), (NEG, Fr(0))],
    "double cusp along tau (kappa -2, 1/2, 3)": [(TAU, Fr(-2)), (TAU, Fr(1, 2)), (TAU, Fr(3))],
}
DIRS = [unit(p, q) for p in range(0, 9) for q in range(1, 9)]
DIRS = list(dict.fromkeys(DIRS))
DIRS += [(-d[0], d[1]) for d in DIRS] + [(Fr(0), Fr(1)), (Fr(0), Fr(-1))]
DIRS = list(dict.fromkeys(DIRS))
both_in_seen = []
for name, arcs in CENTRES.items():
    bad = []
    for e in DIRS:
        e2 = (-e[0], -e[1]) if PLANT != "nearAntipodal" else (e[0], -e[1])
        if e2 == e:
            continue
        votes = []
        for mu in (Fr(1, 10**4), Fr(1, 10**6)):
            pts = [arc_point(t, k, mu) for t, k in arcs]
            votes.append(tuple((vote_out(x, e), vote_out(x, e2)) for x in pts))
        stable = votes[0] == votes[1]
        v = votes[0]
        per_arc_both = any(a and b for a, b in v)
        maj_e, maj_e2 = sum(a for a, _ in v) >= 2, sum(b for _, b in v) >= 2
        if maj_e is False and maj_e2 is False and all(not a and not b for a, b in v):
            both_in_seen.append((name, e))
        if not stable or per_arc_both or (maj_e and maj_e2):
            bad.append((e, v, stable))
    say(not bad, f"AL {name}: {len(DIRS)} directions, no arc votes outside at both e and {'-e' if PLANT != 'nearAntipodal' else 'e_mirror'}, "
        f"majority never outside at both ({len(bad)} violations)" + (f"; first {bad[0]}" if bad else ""))
a6_both_in = [e for n, e in both_in_seen if n.startswith("a6") and e in ((Fr(0), Fr(1)), (Fr(0), Fr(-1)))]
say(PLANT == "nearAntipodal" or len(a6_both_in) == 2,
    "AL one-sided: at the a6 cusp all three arcs vote INSIDE at both +n and -n (antipodal V-out points are not excluded)")

# ---------------- BETA ----------------
def cross(p, q):
    return p[0] * q[1] - p[1] * q[0]


def pang(d):                                      # exact pseudo-angle in [0, 4), monotone in the true angle
    x, y = d
    t = x / (abs(x) + abs(y))
    return 1 - t if (y > 0 or (y == 0 and x > 0)) else 3 + t


def in_ccw_wedge(d, lo, hi):                     # d strictly inside the counter-clockwise wedge from lo to hi
    A, D, H = pang(lo), pang(d), pang(hi)
    return (A < D < H) if A < H else (D > A or D < H)


vp, b = (Fr(1), Fr(0)), (Fr(4, 5), Fr(3, 5))
C, r = (Fr(4, 3), Fr(4, 9)), Fr(5, 9)
d2 = lambda p, q: (p[0] - q[0])**2 + (p[1] - q[1])**2
say(d2(vp, C) == r * r and d2(b, C) == r * r and r != 1, "BETA: P (centre (4/3,4/9), radius 5/9 != 1) passes through v' and b")
say((vp[0] - C[0]) * (-4) + (vp[1] - C[1]) * 3 == 0, "BETA: P is tangent to the a|c edge direction (-4,3) at v'")
wv = ((vp[0] - C[0]) / r, (vp[1] - C[1]) / r)            # (-3/5, -4/5)
wb = ((b[0] - C[0]) / r, (b[1] - C[1]) / r)              # (-24/25, 7/25)
say((wv[1], -wv[0]) == (Fr(-4, 5), Fr(3, 5)), "BETA: P leaves v' clockwise about its centre, in direction (-4,3)/5")
samples = [w for w in (unit(p, q) for p in range(1, 40) for q in range(1, 40)) for w in (w, (-w[0], w[1]), (-w[0], -w[1]), (w[0], -w[1]))]
on_arc = [w for w in samples if in_ccw_wedge(w, wb, wv)]         # the clockwise arc from wv to wb = ccw wedge from wb to wv
inside = all((C[0] + r * w[0])**2 + (C[1] + r * w[1])**2 < 1 for w in on_arc)
say(len(on_arc) > 50 and inside, f"BETA: {len(on_arc)} rational points of P strictly between v' and b all lie in the open disc")
E_ac, E_ai, E_ci = (Fr(-4), Fr(3)), (Fr(-1), Fr(0)), (Fr(-4), Fr(-3))
sector = lambda d: "a" if in_ccw_wedge(d, E_ac, E_ai) else "i" if in_ccw_wedge(d, E_ai, E_ci) else "c"
arc_dir, beyond = (Fr(0), Fr(1)), (Fr(0), Fr(-1))         # circle's tangent at v' toward b, and away from b
qmid = (arc_dir[0] * 5 + E_ac[0], arc_dir[1] * 5 + E_ac[1])     # a direction strictly inside the Q-wedge (90 deg, 143 deg)
out_side = (E_ac[0] * 5 + E_ai[0] * 5, E_ac[1] * 5 + E_ai[1] * 5)  # just past P's edge, away from Q
say(sector(arc_dir) == "c" and sector(beyond) == "c" and sector(qmid) == "c", "BETA: the circle and Q lie in sector c = S at v' (both circle arcs in one sector)")
say(sector(out_side) == "a", "BETA: the tile beside P outside Q is a: item 2 recolours [b, v'] by a, while the circle just beyond v' is c -- MISMATCH")
say(all(sector(d) != "i" for d in (arc_dir, beyond)) and (E_ai[0] < 0 and E_ac[0] < 0 and E_ci[0] < 0), "BETA: all three edges enter the disc, the circle avoids the i-sector")

# ---------------- SPIKE ----------------
Cs, rs, s = (Fr(1, 2), Fr(0)), Fr(1, 2), (Fr(1), Fr(0))
pts = [(Cs[0] + rs * w[0], Cs[1] + rs * w[1]) for w in samples + [(Fr(1), Fr(0))]]
touch = [p for p in pts if p[0]**2 + p[1]**2 >= 1]
say(touch == [s] * len(touch) and len(touch) >= 1, "SPIKE: the path circle meets the closed disc's boundary only at s (internally tangent); c'(s) = {S, T}, no colour change at s")

# ---------------- E3H ----------------
horn = [((Fr(1) - Fr(1, 2), Fr(0)), Fr(1, 2)), ((Fr(1) - Fr(1, 3), Fr(0)), Fr(1, 3))]
ok_in = all(all((c[0] + rr * w[0])**2 + (c[1] + rr * w[1])**2 <= 1 for w in samples) for c, rr in horn)
omega_out = all(d2((w[0], w[1]), horn[0][0]) >= horn[0][1]**2 for w in samples)   # unit circle points stay outside the curvature-2 circle
seg_out = all((1 + Fr(1, k))**2 > 1 for k in range(1, 100))
say(ok_in and omega_out and seg_out, "E3H: horn edges (curvature 2, 3) lie in the closed disc, the circle never enters the horn, the a|c segment along +x leaves the disc")

print("ALL AS PREDICTED" if not FAIL else f"{len(FAIL)} FAILURE(S)")
sys.exit(0 if not FAIL else 1)
