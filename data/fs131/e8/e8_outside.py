#!/usr/bin/env python3
"""FS131-E8 § 6.3 — exact check of the lens bound (the planner's `IsUnitCurve.one_le_dist`): a unit-speed curve whose tangent
angle is 1-Lipschitz in arclength, of length at most π/2, stays outside the two open unit discs tangent to it at its start:
  C4  |γ(s) − γ(0) ∓ i T(0)|² ≥ 1   for both signs.
On every bang-bang curve of curvature ±K built from M steps of arclength θ₀, (cos θ₀, sin θ₀) = (399/401, 40/401), as e8_chord.py.
Prints the number of violated (prefix, sign) pairs; 0 with K = 1.
Usage: e8_outside.py [--kappa K] [--steps M]      (the planted fault: --kappa 2)"""
import sys
from fractions import Fraction as F
K = int(sys.argv[sys.argv.index("--kappa") + 1]) if "--kappa" in sys.argv else 1
M = int(sys.argv[sys.argv.index("--steps") + 1]) if "--steps" in sys.argv else 15
c0, s0 = F(399, 401), F(40, 401)
def rot(c, s, n):
    for _ in range(abs(n)):
        c, s = (c * c0 - s * s0, s * c0 + c * s0) if n > 0 else (c * c0 + s * s0, s * c0 - c * s0)
    return c, s
bad = 0
stack = [(0, F(0), F(0), F(1), F(0))]   # m, x, y, cos ψ, sin ψ; T(0) = (1, 0), i T(0) = (0, 1)
while stack:
    m, x, y, c, s = stack.pop()
    if m:
        if x * x + (y - 1) ** 2 < 1: bad += 1
        if x * x + (y + 1) ** 2 < 1: bad += 1
    if m < M:
        for e in (1, -1):
            c2, s2 = rot(c, s, e * K)
            stack.append((m + 1, x + F(e, K) * (s2 - s), y + F(e, K) * (c - c2), c2, s2))
print(bad)
