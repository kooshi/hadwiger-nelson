#!/usr/bin/env python3
"""FS124-I4: a sampling check (floats; an instrument, not a proof) of the two six-colour witnesses as this job
formalizes them, before any Lean is written — that no sampled unit pair between two of the three discs is
monochromatic — and of the two real inequalities the unit-square witness rests on.

Frame of both: x = 0, w = 1, discs of radius 1/4.

  lone   : y = 1 + i.  Near x the petal colouring of Plane/ThreePiece (`petalCol`: 1 on |Im| < Re < 1/8, 2 on
           |Im| < -Re < 1/8, 0 elsewhere); near w the label 1 inside S(x), 2 outside; near y the sector colouring
           translated, labels 3, 4, 5.
  square : y = 1 - i = T 0 with T z = 1 + i (z - 1), the quarter turn about w.  Near x the lens colouring
           (`lensCol`: 2 above the real axis; below it 0 inside S(w), 1 outside); near y the same turned by T,
           labels 3, 4, 5; near w: 0 inside S(x) and S(y), 4 inside S(x) only, 3 inside S(y) only, 1 outside both.

`--fault` exchanges two labels near w in each model: the check must then report monochromatic pairs.
"""
import sys, math, random, cmath
random.seed(1244)
FAULT = "--fault" in sys.argv
R = 0.25

def sector(z):
    if z.real > 0 and z.imag > 0: return 0
    if z.real < 0 and z.real < z.imag: return 1
    return 2

def petal(z):
    if abs(z.imag) < z.real and z.real < 1 / 8: return 1
    if abs(z.imag) < -z.real and -z.real < 1 / 8: return 2
    return 0

def lens(z):
    if z.imag > 0: return 2
    return 0 if abs(z - 1) < 1 else 1

def lone(z):
    y = 1 + 1j
    if abs(z) < R: return petal(z)
    if abs(z - y) < R: return 3 + sector(z - y)
    if abs(z - 1) < R:
        lab = 1 if abs(z) < 1 else 2
        if FAULT: lab = 3 - lab
        return lab
    return None

def square(z):
    y = 1 - 1j
    if abs(z) < R: return lens(z)
    if abs(z - y) < R: return 3 + lens(1 - 1j * (z - 1))          # T^{-1} z = 1 - i (z - 1)
    if abs(z - 1) < R:
        ix, iy = abs(z) < 1, abs(z - y) < 1
        lab = {(True, True): 0, (True, False): 4, (False, True): 3, (False, False): 1}[(ix, iy)]
        if FAULT: lab = {0: 4, 4: 0}.get(lab, lab)
        return lab
    return None

def run(col, centres, n=600000):
    bad = seen = 0
    kinds = {}
    names = list(centres)
    for a in names:
        for b in names:
            if a == b: continue
            p, q = centres[a], centres[b]
            if abs(abs(p - q) - 1) > 2 * R: continue                # no unit pair between these two discs
            base = cmath.phase(q - p)
            for _ in range(n):
                r = R * math.sqrt(random.random()); t = p + r * cmath.exp(2j * math.pi * random.random())
                z = t + cmath.exp(1j * (base + random.uniform(-0.6, 0.6)))
                if abs(z - q) >= R: continue
                la, lb = col(t), col(z); seen += 1
                kinds[(la, lb)] = kinds.get((la, lb), 0) + 1
                if la == lb: bad += 1
    return seen, bad, len(kinds)

def inequalities(n=2000000):
    """Lemma I: |z| < 1, 1 < |z - (1+i)|, |z - 1| < 1/4, |t - 1| < 1, Im t <= 0, |t| < 1/4  ==>  |z - t| < 1.
    Lemma II: 1 < |z|, 1 < |z - (1-i)|, |z - 1| < 1/4, 1 < |t - 1|, Im t <= 0, |t| < 1/4    ==>  1 < |z - t|.
    Returns (cases of I, violations of I, least slack of I, cases of II, violations of II, least slack of II)."""
    c1 = v1 = c2 = v2 = 0
    m1 = m2 = 9.0
    for _ in range(n):
        r = R * math.sqrt(random.random()); z = 1 + r * cmath.exp(2j * math.pi * random.random())
        r = R * math.sqrt(random.random()); t = r * cmath.exp(2j * math.pi * random.random())
        if FAULT: t = t.conjugate() if t.imag <= 0 else t            # the fault: the hypothesis Im t <= 0 dropped
        elif t.imag > 0: continue
        d = abs(z - t)
        if abs(z) < 1 and abs(z - (1 + 1j)) > 1 and abs(t - 1) < 1:
            c1 += 1; m1 = min(m1, 1 - d); v1 += d >= 1
        if abs(z) > 1 and abs(z - (1 - 1j)) > 1 and abs(t - 1) > 1:
            c2 += 1; m2 = min(m2, d - 1); v2 += d <= 1
    return c1, v1, m1, c2, v2, m2

tag = " (fault planted)" if FAULT else ""
for name, col, centres in (("lone", lone, dict(x=0, w=1, y=1 + 1j)), ("square", square, dict(x=0, w=1, y=1 - 1j))):
    seen, bad, kinds = run(col, centres)
    print(f"{name}: unit-pairs-sampled={seen} monochromatic={bad} label-pairs-seen={kinds}{tag}")
c1, v1, m1, c2, v2, m2 = inequalities()
print(f"lemma-I: cases={c1} violations={v1} least-slack={m1:.3e}{tag}")
print(f"lemma-II: cases={c2} violations={v2} least-slack={m2:.3e}{tag}")
