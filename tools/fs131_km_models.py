#!/usr/bin/env python3
"""FS131-KM1: sampling controls on the painted classes of the skeleton's models (Plane/Models/{Moves, Stuck, Bends}).

Each model is the seven-colour brick map (valid in the kernel) with spare colours painted on small sets, so validity is: no two
points of one painted colour at distance exactly 1. For each painted colour the check samples points x of the class, points y on the
unit circle about x, and counts the y that carry the same painted colour (a class is open, so a monochromatic unit pair has a
neighbourhood of them and sampling finds it). Colourings are by formula, as in the Lean definitions; nothing is searched.
Also: every painted set lies strictly inside its brick; the stuck model's shadow witnesses; awayModel's contact interval.

  python3 tools/fs131_km_models.py            # all controls, exit 0 iff all hold
  python3 tools/fs131_km_models.py --plant    # the tangent disc moved to the pole N (tangent at plantPt + i): the horn is then in
                                              # its shadow and the control must report monochromatic pairs (exit 1)
"""
import math, random, sys

PLANT = "--plant" in sys.argv
V = complex(0.4, 0.3); N = V + 1j; S = V - 1j
DIR = (1j if PLANT else complex(0.6, 0.8)); TC = V + 0.95 * DIR


def frame(v, a, z):
    w = (z - v) * complex(math.cos(a), -math.sin(a)); return w.real, w.imag

def th(k, x, y): return y - k * (x * x + y * y) / 2

def horn(v, a, k1, k2, r, z):
    x, y = frame(v, a, z)
    return abs(z - v) < r and x > 0 and th(k1, x, y) > 0 and th(k2, x, y) < 0

def sq(p, z): return abs((z - p).real) < 0.05 and abs((z - p).imag) < 0.05

def col_horn(z):
    return 7 if (horn(V, 0, -.5, .5, .1, z) or abs(z - TC) < .05) else None

def col_two(z):
    return 7 if (horn(V, 0, -.75, -.5, .1, z) or horn(V, 0, .5, .75, .1, z) or abs(z - TC) < .05) else None

def col_stuck(z):
    if abs(z - V) < .1:
        return 7 if abs(z - N) < 1 else 8 if abs(z - S) < 1 else 9
    for p, toward, away in ((N, 7, 9), (S, 8, 9)):
        if sq(p, z):
            a, b = (z - p).real, (z - p).imag
            if p is S: b = -b          # mirror: "toward the vertex" is b > |a| at S
            if b < -abs(a): return toward
            if b > abs(a): return away
            if a > abs(b): return 10
            if a < -abs(b): return 11
            return None
    return None

def col_shadow(z):
    if horn(V, 0, .5, .75, .1, z) or horn(S, 0, .1, .2, .05, z): return 7
    if horn(V, 0, -.75, -.5, .1, z) or horn(N, 0, -.2, -.1, .05, z): return 8
    return None

P = complex(-0.6, 0.3)
def col_away(z):
    x, y = z.real, z.imag
    if 0 < x < .8 and 0 < y < .6 and abs(z - P) < 1: return 7
    if .8 < x < 1.6 and 0 < y < .6 and abs(z - P) > 2: return 7
    return None

BOXES = {  # where each model paints: (centre, half-size) boxes to sample class points from
    "hornModel": (col_horn, [(V, .1), (TC, .05)]),
    "twoHornModel": (col_two, [(V, .1), (TC, .05)]),
    "stuckModel": (col_stuck, [(V, .1), (N, .05), (S, .05)]),
    "shadowModel": (col_shadow, [(V, .1), (N, .05), (S, .05)]),
    "awayModel": (col_away, [(complex(.4, .3), .4), (complex(1.2, .3), .4)]),
}

def mono_pairs(col, boxes, n=60000, seed=1):
    rng = random.Random(seed); bad = 0; tried = 0
    for _ in range(n):
        c, h = rng.choice(boxes)
        x = c + complex(rng.uniform(-h, h), rng.uniform(-h, h))
        cx = col(x)
        if cx is None: continue
        # aim the unit circle at the other painted boxes (and uniformly)
        for (c2, h2) in boxes:
            t = c2 + complex(rng.uniform(-h2, h2), rng.uniform(-h2, h2))
            if abs(t - x) < 1e-9: continue
            y = x + (t - x) / abs(t - x)
            tried += 1
            if col(y) == cx: bad += 1
        a = rng.uniform(0, 2 * math.pi); y = x + complex(math.cos(a), math.sin(a)); tried += 1
        if col(y) == cx: bad += 1
    return tried, bad

def in_brick(z, margin=0.0):
    r = math.floor(z.imag / .6); c = math.floor((z.real - .4 * r) / .8)
    return (.6 * r + margin < z.imag < .6 * (r + 1) - margin) and (.4 * r + .8 * c + margin < z.real < .4 * r + .8 * (c + 1) - margin), (c, r)

ok = True
for name, (col, boxes) in BOXES.items():
    tried, bad = mono_pairs(col, boxes)
    print(f"{name}: unit pairs tried {tried}, monochromatic in a painted colour: {bad}")
    ok &= bad == 0
# the painted sets sit strictly inside bricks
for label, z, m in (("B(plantPt,1/10)", V, .1), ("square at N", N, .05), ("square at S'", S, .05), ("tangent disc", TC, .05)):
    inside, cell = in_brick(z, m)
    print(f"{label}: strictly inside brick {cell} with its margin: {inside}")
    ok &= inside
print(f"|plantDir| = {abs(complex(.6,.8)):.12f}; tangent disc inside the unit disc: {abs(TC - V) + .05 <= 1 + 1e-12}")
# stuck: a horn point is at distance exactly 1 from a point of the 7-wedge at N and of the 8-wedge at S'
rng = random.Random(7); hits = 0; total = 0
for _ in range(20000):
    r = .02
    z = V + complex(rng.uniform(-r, r), rng.uniform(-r, r))
    if col_stuck(z) != 9 or abs(z - V) >= r: continue
    x, y = (z - V).real, (z - V).imag
    b1 = (1 - math.sqrt(1 - x * x)) - y; b2 = y + 1 - math.sqrt(1 - x * x)
    w1 = N - 1j * b1; w2 = S + 1j * b2; total += 1
    if abs(abs(z - w1) - 1) < 1e-12 and abs(abs(z - w2) - 1) < 1e-12 and col_stuck(w1) == 7 and col_stuck(w2) == 8: hits += 1
print(f"stuckModel: horn points within 1/50 of the vertex shadowed by the 7-wedge and by the 8-wedge: {hits} of {total}")
ok &= hits == total and total > 0
# awayModel: the radius-2 contacts are |theta| <= arcsin(3/20), inside |theta| <= arcsin(3/10)
a1, a2 = math.asin(.3), math.asin(.15); good = True
for i in range(2001):
    t = -a1 + 2 * a1 * i / 2000; q = P + 2 * complex(math.cos(t), math.sin(t))
    closed_T2 = .8 <= q.real <= 1.6 and -1e-12 <= q.imag <= .6 + 1e-12
    good &= closed_T2 == (abs(t) <= a2 + 1e-9)
print(f"awayModel: radius-2 points in the closed second brick exactly for |theta| <= arcsin(3/20): {good}")
ok &= good
print("ALL HOLD" if ok else "FAILED")
sys.exit(0 if ok else 1)
