#!/usr/bin/env python3
"""FS-73 V2: independent exact computation of Θ_R, the rotation set of the 12 rational unit vectors ±1, ±i, (±3±4i)/5, (±4±3i)/5.

Θ_R = {μ ∈ ℝ² : ⟨μ, x⟩ mod 1 ∈ [1/3, 2/3] for all 12 x}.  Every cell (fixed integer parts) is a closed convex polygon, bounded by
the ±1, ±i conditions, so it is the convex hull of its vertices, and each vertex is an intersection of two boundary lines
⟨μ, x⟩ = k + 1/3 or k + 2/3.  Enumerate every such intersection exactly in a window covering one period, keep the points of Θ_R,
group them by cell (the tuple of integer parts), and report each cell's vertex count and centre, modulo the period lattice.
Checks implementer E's P3b-T3 (Θ_R = (5/2,5/2) + (D0 ∪ F4) + 5ℤ², D0 a 12-gon, F4 four isolated points)."""
import itertools
import math
from fractions import Fraction as F

X = [(F(1), F(0)), (F(0), F(1)), (F(3, 5), F(4, 5)), (F(3, 5), F(-4, 5)), (F(4, 5), F(3, 5)), (F(4, 5), F(-3, 5))]
LO, HI = F(-1), F(6)


def val(mu, x):
    return mu[0] * x[0] + mu[1] * x[1]


def inside(mu):
    return all(F(1, 3) <= val(mu, x) - math.floor(val(mu, x)) <= F(2, 3) for x in X)


def cell(mu):
    return tuple(math.floor(val(mu, x)) for x in X)


lines = []   # (x, c): ⟨μ, x⟩ = c
for x in X:
    # ⟨μ, x⟩ ranges over [LO·(|x0|+|x1|)…] — generous integer range
    for k in range(-15, 16):
        lines += [(x, k + F(1, 3)), (x, k + F(2, 3))]
pts = set()
for (x1, c1), (x2, c2) in itertools.combinations(lines, 2):
    det = x1[0] * x2[1] - x1[1] * x2[0]
    if det == 0:
        continue
    mu = ((c1 * x2[1] - c2 * x1[1]) / det, (x1[0] * c2 - x2[0] * c1) / det)
    if LO <= mu[0] <= HI and LO <= mu[1] <= HI and inside(mu):
        pts.add(mu)
cells = {}
for mu in pts:
    cells.setdefault(cell(mu), set()).add(mu)
# reduce to one period: centre mod 5 (5ℤ² is a period: ⟨5e, x⟩ ∈ ℤ for all x)
summary = {}
for c, vs in cells.items():
    cx = sum(v[0] for v in vs) / len(vs)
    cy = sum(v[1] for v in vs) / len(vs)
    key = (cx % 5, cy % 5, len(vs))
    summary[key] = summary.get(key, 0) + 1
for (cx, cy, n), m in sorted(summary.items()):
    print(f"cell centre ({cx}, {cy}) mod 5, {n} vertices")
# E's description: D0 = {δ : |⟨δ,x⟩| ≤ 1/6}, centre (5/2, 5/2); F4 = (5/2,5/2) + (±5/6, ±5/6)
c0 = (F(5, 2), F(5, 2))
d0 = [mu for mu in pts if all(abs(val((mu[0] - c0[0], mu[1] - c0[1]), x)) <= F(1, 6) for x in X)]
print("vertices of D0 found:", len(d0))
for s in itertools.product((1, -1), repeat=2):
    p = (c0[0] + s[0] * F(5, 6), c0[1] + s[1] * F(5, 6))
    print("F4 point", p, "in Θ_R:", inside(p), "cell size:", len(cells[cell(p)]))
