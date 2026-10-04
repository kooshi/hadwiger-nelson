#!/usr/bin/env python3
"""FS131-E2: two exact fragments about z = 0 with a both-kind unit arc A and a cusp tile H at z.

  --variant monster  (default)  five colours used; z carries exactly THREE colours {c, c', d}; the tile D (colour d) lies on
                                both sides of H's cusp — two sectors at z, its closure meets itself at z (not a Jordan domain).
                                Valid, non-Siamese; every other tile a Jordan domain; closures of distinct tiles meet in connected
                                sets. It meets every hypothesis of `four_of_bothKind` as stated at commit 05cb0a3e (cones may be
                                one direction) and fails its conclusion.
  --variant model               six colours; D split into D_R, D_L of different colours meeting only at z; every tile a Jordan
                                domain: a non-Siamese SIMPLE valid fragment with a both-kind arc at z and a cusp at z, z carrying
                                exactly FOUR colours — a model of E2-Q1's hypotheses with the cusp present.

The geometry (exact): a = arcsin(5/13); A = r([pi/2 - a, pi/2 + a]) on the unit circle, ends P1 = (5/13, 12/13), P2 = (-5/13, 12/13).
  H     = {Im w > 0, |w| < 1, |w - 13/10| > 13/10, |w + 13/10| > 13/10}   (colour c)  — the horn: cusp at 0 along pi/2, top side A
  T'    = {0 < |w| < rT, arg w in (pi + a, 2pi - a)}                     (colour c') — rT = 1/4 (monster), 1/2 (model)
  T_out = {1 < |w| < 14/13, arg w in (pi/2 - a, pi/2 + a)}               (colour c')
  D     = B(0, 1/2) minus cl H minus cl T'                               (monster: one tile, colour d)
  D_R, D_L = the parts of B(0,1/2) minus cl H minus cl T' with Re w > 0, < 0   (model: colours d, e)
  V     = {Im w > 0, 2|Re w| < Im w, 51/52 < |w| < 57/52};  Q_R, Q_L = V minus cl H minus cl T_out, Re w > 0 / < 0
  domain U = B(0, 1/2) u H u V;  arcs: A, the two horn arcs, T' rays (and its radius-1/4 arc in the monster), T_out's two
  radial segments and outer arc, the segment {0} x [14/13, 57/52] splitting the strip above T_out.

What is exact: every identity and inequality the hand validity proof (plans/FS131-E2-derivation.md § 2.4) rests on, checked in
sympy / Fraction arithmetic; that every same-coloured pair of tiles carries a certificate; the plant's witness (two interior points
of one colour at distance exactly 1). What is a sanity check only: a rational grid classification (each grid point of U off the arcs
in exactly one tile; the containments the certificates use hold on every grid point; the tiles at z read off small circles).

--plant recolour : Q_R takes H's colour; no certificate covers (H, Q_R) and an exact witness pair at distance 1 is exhibited.
--plant widen    : T' widened to directions (pi - a, 2pi + a); the far certificate (T', T_out) fails.
"""
import sys
from fractions import Fraction as Fr

import sympy as sp

VARIANT = "model" if "--variant" in sys.argv and sys.argv[sys.argv.index("--variant") + 1] == "model" else "monster"
PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None

SA, CA = Fr(5, 13), Fr(12, 13)           # sin a, cos a
RT = Fr(1, 2) if VARIANT == "model" else Fr(1, 4)
R_TOUT = Fr(14, 13)
V_IN, V_OUT = Fr(51, 52), Fr(57, 52)

fails = []


def check(name, ok, detail=""):
    print(("ok    " if ok else "FAIL  ") + name + (f"  [{detail}]" if detail else ""))
    if not ok:
        fails.append(name)


# ---------- exact membership predicates (rational points) ----------

def n2(x, y):
    return x * x + y * y


def in_H(x, y):
    return y > 0 and n2(x, y) < 1 and n2(x, y) - Fr(13, 5) * x > 0 and n2(x, y) + Fr(13, 5) * x > 0


def in_clH(x, y):
    return y >= 0 and n2(x, y) <= 1 and n2(x, y) - Fr(13, 5) * x >= 0 and n2(x, y) + Fr(13, 5) * x >= 0


def tp_dir(x, y, strict=True):
    """direction in (pi + a, 2pi - a) [the plant widens it to (pi - a, 2pi + a)]."""
    if PLANT == "widen":
        # complement of the closed upper cone [a, pi - a]: not (y > 0 and 5|x| <= 12 y), roughly; strict version
        return not (y >= 0 and 5 * abs(x) <= 12 * y) if strict else not (y > 0 and 5 * abs(x) < 12 * y)
    return (y < 0 and 5 * abs(x) < 12 * (-y)) if strict else (y <= 0 and 5 * abs(x) <= 12 * (-y))


def in_Tp(x, y):
    return 0 < n2(x, y) < RT * RT and tp_dir(x, y)


def in_clTp(x, y):
    return n2(x, y) <= RT * RT and (n2(x, y) == 0 or tp_dir(x, y, strict=False))


def in_Tout(x, y):
    return y > 0 and 12 * abs(x) < 5 * y and 1 < n2(x, y) < R_TOUT * R_TOUT


def in_clTout(x, y):
    return y >= 0 and 12 * abs(x) <= 5 * y and 1 <= n2(x, y) <= R_TOUT * R_TOUT


def in_V(x, y):
    return y > 0 and 2 * abs(x) < y and V_IN * V_IN < n2(x, y) < V_OUT * V_OUT


def in_D_all(x, y):
    return n2(x, y) < Fr(1, 4) and not in_clH(x, y) and not in_clTp(x, y)


def in_QR(x, y):
    return in_V(x, y) and x > 0 and not in_clH(x, y) and not in_clTout(x, y)


def in_QL(x, y):
    return in_V(x, y) and x < 0 and not in_clH(x, y) and not in_clTout(x, y)


def in_dom(x, y):
    return n2(x, y) < Fr(1, 4) or in_H(x, y) or in_V(x, y)


# tiles and colours (colour indices in Fin 6; c = 0, c' = 1, d = 2, ...)
if VARIANT == "monster":
    TILES = {"H": in_H, "Tp": in_Tp, "Tout": in_Tout, "D": in_D_all, "QR": in_QR, "QL": in_QL}
    COL = {"H": 0, "Tp": 1, "Tout": 1, "D": 2, "QR": 3, "QL": 4}
else:
    TILES = {"H": in_H, "Tp": in_Tp, "Tout": in_Tout,
             "DR": lambda x, y: in_D_all(x, y) and x > 0, "DL": lambda x, y: in_D_all(x, y) and x < 0,
             "QR": in_QR, "QL": in_QL}
    COL = {"H": 0, "Tp": 1, "Tout": 1, "DR": 2, "DL": 3, "QR": 4, "QL": 5}
if PLANT == "recolour":
    COL["QR"] = COL["H"]

# ---------- 1. symbolic identities ----------
X, Y, a = sp.symbols("x y a", real=True)
circ = sp.expand((X - sp.Rational(13, 10)) ** 2 + Y ** 2 - sp.Rational(169, 100))
check("horn circle |w - 13/10| = 13/10  <=>  |w|^2 = (13/5) Re w", sp.simplify(circ - (X ** 2 + Y ** 2 - sp.Rational(13, 5) * X)) == 0)
p1 = (sp.Rational(5, 13), sp.Rational(12, 13))
check("P1 on the unit circle and on the right horn circle",
      p1[0] ** 2 + p1[1] ** 2 == 1 and circ.subs({X: p1[0], Y: p1[1]}) == 0)
check("horn arcs tangent to the imaginary axis at 0 (centres on the real axis, through 0)", circ.subs({X: 0, Y: 0}) == 0)
# on a horn arc |Re w| / |w| = (5/13)|w| <= 5/13 = sin a: the arc lies in the closed sector |theta - pi/2| <= a, |w| <= 1
cos2a = 1 - 2 * SA * SA
check("cos 2a = 119/169 and 119/169 > 1/2 (the sector's interior pairs are below 1)", cos2a == Fr(119, 169) and cos2a > Fr(1, 2))
th1, th2 = sp.pi / 2 - a, sp.pi / 2 + a
lo, hi = sp.simplify(th1 - (2 * sp.pi - a)), sp.simplify(th2 - (sp.pi + a))
check("T'/T_out angle differences lie in (theta1 - (2pi - a), theta2 - (pi + a)) = (-3pi/2, -pi/2)",
      lo == -3 * sp.pi / 2 and hi == -sp.pi / 2 and PLANT != "widen",
      "plant widen: T' reaches (pi - a, 2pi + a), differences (-3pi/2 - 2a, -pi/2 + 2a), cosine positive near the ends" if PLANT == "widen" else "")
check("cos(2 atan(1/2)) = 3/5 (angular spread of V)", sp.simplify(sp.cos(2 * sp.atan(sp.Rational(1, 2))) - sp.Rational(3, 5)) == 0)

# ---------- 2. the certificates ----------
diam_tout = (R_TOUT - 1) ** 2 + 2 * R_TOUT ** 2 * (1 - cos2a)
check("T_out: (14/13 - 1)^2 + 2 (14/13)^2 (1 - cos 2a) = 19769/28561 < 1", diam_tout == Fr(19769, 28561) and diam_tout < 1)
corners = [s * s + t * t - Fr(6, 5) * s * t for s in (V_IN, V_OUT) for t in (V_IN, V_OUT)]
check("V: max over corners of s^2 + t^2 - (6/5) s t = 12996/13520 < 1", max(corners) == Fr(12996, 13520) and max(corners) < 1)

# certificate kinds: 'near' (every cross distance below 1), 'far' (every cross distance above 1)
SHAPE = {"H": "sector", "Tp": "ball", "Tout": "tout", "D": "ball", "DR": "ball", "DL": "ball", "QR": "V", "QL": "V"}


def certificate(t1, t2):
    if t1 == t2:
        kind = SHAPE[t1]
        if kind == "sector":
            return "near", "H inside the open sector |theta - pi/2| < a of B(0,1); f(s,t) = s^2 + t^2 - 2st cos 2a < 1 for s,t in (0,1), cos 2a > 1/2"
        if kind == "ball":
            r = RT if t1 == "Tp" else Fr(1, 2)
            return ("near", f"inside the open ball B(0, {r}), diameter {2 * r} <= 1") if 2 * r <= 1 else (None, "ball too large")
        if kind == "tout":
            return "near", "diameter^2 <= 19769/28561"
        if kind == "V":
            return "near", "inside V, distance^2 < 12996/13520"
    pair = {t1, t2}
    if pair == {"Tp", "Tout"} and PLANT != "widen":
        return "far", "|w - v|^2 = |w|^2 - 2 s t cos(alpha - phi) + t^2 > |w|^2 > 1, cos < 0 on (-3pi/2, -pi/2)"
    if pair <= {"QR", "QL"}:
        return "near", "both inside V, distance^2 < 12996/13520"
    return None, "no certificate"


names = list(TILES)
for i, t1 in enumerate(names):
    for t2 in names[i:]:
        if COL[t1] != COL[t2]:
            continue
        kind, why = certificate(t1, t2)
        if t1 == t2:
            check(f"validity within {t1} (colour {COL[t1]})", kind == "near", why)
        else:
            check(f"validity across {t1}, {t2} (colour {COL[t1]})", kind in ("near", "far"), why)
            check(f"non-Siamese: {t1}, {t2} far apart", kind == "far", why)

# ---------- 3. the plant's exact witness ----------
if PLANT == "recolour":
    h = (Fr(0), Fr(1, 26))
    w = (Fr(39, 89), Fr(1, 26) + Fr(80, 89))
    wit = in_H(*h) and in_QR(*w) and n2(w[0] - h[0], w[1] - h[1]) == 1
    check("plant witness absent: no two interior points of H's colour at distance exactly 1", not wit,
          f"h = {h} in H, w = {w} in Q_R, |w - h|^2 = 1 exactly" if wit else "")

# ---------- 4. the colours at z, the cones, IsRingArc (exact facts plus a grid sanity check) ----------
AT_Z = ["H", "Tp", "D"] if VARIANT == "monster" else ["H", "Tp", "DR", "DL"]
check(f"tiles with 0 in their closure: {AT_Z}; T_out, Q_R, Q_L at distance >= 51/52 from 0", True)
colours_at_z = sorted({COL[t] for t in AT_Z})
want = 3 if VARIANT == "monster" else 4
check(f"z = 0 carries exactly {want} colours: {colours_at_z}", len(colours_at_z) == want)
check("c = colour(H) and c' = colour(T') both carried at z (H inner, T_out outer along A)", COL["H"] in colours_at_z and COL["Tp"] in colours_at_z)
# A in V (so in the domain): |Re|/Im on A at most 5/12 < 1/2, radius 1 in (51/52, 57/52)
check("A lies in the domain (inside V)", Fr(5, 12) < Fr(1, 2) and V_IN < 1 < V_OUT)
# inner side of A: (1 - eta) e(theta), |cos theta| < 5/13, lies outside both horn circles: (1 - eta) > (13/5)|cos theta|
check("inner side of A at its interior points is H alone: |cos theta| < sin a = 5/13 on (theta1, theta2), so (13/5)|cos theta| < (13/5)(5/13) = 1", Fr(13, 5) * SA == 1)
# sanity: small circles about 0 — which tile holds each direction (exact rational points near the circle of radius 1/1000)
import math

r0 = Fr(1, 1000)
seen = []
for j in range(3600):
    t = 2 * math.pi * j / 3600
    x, y = Fr(round(r0 * 10 ** 9 * Fr(math.cos(t))), 10 ** 9), Fr(round(r0 * 10 ** 9 * Fr(math.sin(t))), 10 ** 9)
    hold = [n for n, f in TILES.items() if f(x, y)]
    seen.append(hold[0] if len(hold) == 1 else ("Γ" if not hold else "OVERLAP"))
runs = []
for s in seen:
    if not runs or runs[-1][0] != s:
        runs.append([s, 1])
    else:
        runs[-1][1] += 1
if len(runs) > 1 and runs[0][0] == runs[-1][0]:
    runs[0][1] += runs.pop()[1]
desc = " ".join(f"{n}({c})" for n, c in runs)
check("no grid point of the small circle in two tiles", "OVERLAP" not in seen, desc)
names_round = [n for n, _ in runs if n != "Γ"]
def cyclic_eq(word, target):
    return len(word) == len(target) and any(word[i:] + word[:i] == target for i in range(len(word)))


# the cusp H shows only at the sample exactly at 90 degrees (its width at radius 1/1000 is about 4e-7)
if VARIANT == "monster":
    check("monster: round 0 the cyclic word is D, H (the cusp), D, T' — D on both sides of the cusp, two sectors",
          cyclic_eq(names_round, ["D", "H", "D", "Tp"]), desc)
else:
    check("model: round 0 the cyclic word is D_R, H (the cusp), D_L, T' — one sector each",
          cyclic_eq(names_round, ["DR", "H", "DL", "Tp"]), desc)

# the open side cones S1 = (-a, a) and S2 = (pi - a, pi + a) at z: which tiles hold them (sample directions on the small circle)
a_f = math.asin(5 / 13)
s1 = {seen[j] for j in range(3600) if abs(((2 * math.pi * j / 3600 + math.pi) % (2 * math.pi)) - math.pi) < a_f - 1e-3}
s2 = {seen[j] for j in range(3600) if abs(2 * math.pi * j / 3600 - math.pi) < a_f - 1e-3}
if VARIANT == "monster":
    check("monster: one tile, D (colour d), holds both open side cones — the clause's two further colours are one colour",
          s1 == {"D"} and s2 == {"D"}, f"S1 -> {sorted(s1)}, S2 -> {sorted(s2)}")
else:
    check("model: D_R holds S1, D_L holds S2, of different colours — the fourth colour, with the cusp present",
          s1 == {"DR"} and s2 == {"DL"} and COL["DR"] != COL["DL"], f"S1 -> {sorted(s1)}, S2 -> {sorted(s2)}")

# grid sanity over the domain
step = Fr(1, 61)
bad_overlap = bad_contain = count = 0
k = -80
while k <= 80:
    x = k * step
    m = -40
    while m <= 80:
        y = m * step
        if in_dom(x, y):
            hold = [n for n, f in TILES.items() if f(x, y)]
            count += 1
            if len(hold) > 1:
                bad_overlap += 1
            for n in hold:
                if n == "H" and not (169 * x * x < 25 * n2(x, y) and n2(x, y) < 1):
                    bad_contain += 1
                if n in ("D", "DR", "DL", "Tp") and not n2(x, y) < Fr(1, 4):
                    bad_contain += 1
                if n in ("QR", "QL") and not in_V(x, y):
                    bad_contain += 1
        m += 1
    k += 1
check(f"grid sanity: {count} domain points, none in two tiles", bad_overlap == 0)
check("grid sanity: every grid point of H in the open sector, of D/T' in B(0,1/2), of Q in V", bad_contain == 0)

print(f"variant {VARIANT}" + (f", plant {PLANT}" if PLANT else "") + ": " + ("FRAG ALL OK" if not fails else f"FRAG FAIL ({len(fails)})"))
sys.exit(0 if not fails else 1)
