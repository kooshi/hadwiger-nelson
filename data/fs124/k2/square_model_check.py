#!/usr/bin/env python3
"""FS124-K2: a sampling check (floats; an instrument, not a proof) of the two six-colour witnesses planned for
`Plane/ClosePairModel` — that no sampled unit pair between the disc about w and the discs about x and y is monochromatic.

  square : x = 0, w = 1, y = 1 - i (the witness planned for exists_closePair_full)
  lone   : x = -1, w = 0, y = -i   (the witness planned for exists_closePair_not_separatesAt)

Labels: x's pieces a=0, b=1, c=2; y's pieces d=3, e=4, f=5.  `--fault` exchanges the labels a and e near w in the
square model (and a, b near w in the lone model): the check must then report monochromatic pairs.
"""
import sys, math, random, cmath
random.seed(124)
FAULT = "--fault" in sys.argv
D = 0.1

def square(z):
    x, w, y = 0, 1, 1 - 1j
    if abs(z - w) < D:
        ix, iy = abs(z - x) < 1, abs(z - y) < 1
        lab = {(True, True): 0, (False, True): 3, (False, False): 1, (True, False): 4}[(ix, iy)]
        if FAULT: lab = {0: 4, 4: 0}.get(lab, lab)
        return lab
    if abs(z - x) < D:
        return 2 if abs(z - 1j) < 1 else (0 if abs(z - 1) < 1 else 1)
    if abs(z - y) < D:
        return 5 if abs(z + 1j) < 1 else (3 if abs(z - 1) < 1 else 4)
    return None

def lone(z):
    x, w, y = -1, 0, -1j
    if abs(z - w) < D:
        lab = 0 if abs(z - x) < 1 else 1
        if FAULT: lab = 1 - lab
        return lab
    if abs(z - x) < D:
        t = z - x                      # u = w - x = 1
        if t.real > abs(t.imag) and t.real < D / 2: return 0      # the petal toward w
        if -t.real > abs(t.imag): return 1                        # the sector away from w
        return 2
    if abs(z - y) < D:
        t = (z - y) / 1j               # turn so that w - y = i becomes 1
        if t.real < -abs(t.imag): return 4                        # a sector away from w: outer
        return 3 if t.imag > 0 else 5                             # two sectors holding the tangent directions
    return None

def run(col, centres, n=400000):
    w = centres["w"]; bad = 0; seen = 0; pairs = {}
    for name in ("x", "y"):
        p = centres[name]
        for _ in range(n):
            r = D * math.sqrt(random.random()); t = p + r * cmath.exp(2j * math.pi * random.random())
            base = cmath.phase(w - p); z = t + cmath.exp(1j * (base + random.uniform(-0.25, 0.25)))
            if abs(z - w) >= D: continue
            a, b = col(t), col(z); seen += 1
            pairs[(a, b)] = pairs.get((a, b), 0) + 1
            if a == b: bad += 1
    return seen, bad, len(pairs)

for name, col, centres in (("square", square, dict(x=0, w=1, y=1 - 1j)), ("lone", lone, dict(x=-1, w=0, y=-1j))):
    seen, bad, kinds = run(col, centres)
    print(f"{name}: unit-pairs-sampled={seen} monochromatic={bad} label-pairs-seen={kinds}{' (fault planted)' if FAULT else ''}")
