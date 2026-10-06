#!/usr/bin/env python3
"""FS131-E8 — exact check of the three curve inequalities of § Finite length, the end tangent and the polar graph, on every
bang-bang curve of curvature ±K built from M steps of arclength θ₀, where (cos θ₀, sin θ₀) = (399/401, 40/401).

A step of curvature εK (ε = ±1) and arclength θ₀ turns the unit tangent by εKθ₀ and moves the point by
(1/(εK)) (sin ψ₂ − sin ψ₁, cos ψ₁ − cos ψ₂); every quantity is rational. For each prefix of m steps (arclength s = mθ₀ ≤ 15θ₀ < π/2):
  C1  ⟨γ(s) − γ(0), T(0)⟩ ≥ sin s            (the chord along the initial tangent)
  C2  ⟨γ(s) − γ(0), T(s)⟩ ≥ sin s            (the derivative of |γ(s) − γ(0)|²/2: the distance from the end grows)
  C3  ⟨γ(s) − γ(0), T(0)⟩² ≥ |γ(s) − γ(0)|² (1 + cos s)/2, for m ≤ 10 (s ≤ π/3): the chord's direction is within s/2 of T(0)
Prints the number of violated (prefix, inequality) pairs. With K = 1 (the derivation's bound) it prints 0.
Usage: e8_chord.py [--kappa K] [--steps M]      (the planted fault: --kappa 2, curvature 2 on steps of the same length)"""
import sys
from fractions import Fraction as F
K = int(sys.argv[sys.argv.index("--kappa") + 1]) if "--kappa" in sys.argv else 1
M = int(sys.argv[sys.argv.index("--steps") + 1]) if "--steps" in sys.argv else 15
c0, s0 = F(399, 401), F(40, 401)
assert c0 * c0 + s0 * s0 == 1
def rot(c, s, n):                      # (cos, sin) of the angle advanced by n·θ₀, n of either sign
    for _ in range(abs(n)):
        c, s = (c * c0 - s * s0, s * c0 + c * s0) if n > 0 else (c * c0 + s * s0, s * c0 - c * s0)
    return c, s
ref = [(F(1), F(0))]                   # (cos mθ₀, sin mθ₀)
for m in range(M):
    ref.append(rot(*ref[-1], 1))
assert all(c > 0 for c, _ in ref), "M·θ₀ must stay below π/2"
bad = 0
stack = [(0, F(0), F(0), F(1), F(0))]  # m, x, y, cos ψ, sin ψ   (T(0) = (1, 0))
while stack:
    m, x, y, c, s = stack.pop()
    if m:
        cs, sn = ref[m]
        if x < sn: bad += 1                                   # C1
        if x * c + y * s < sn: bad += 1                       # C2
        if m <= 10 and 2 * x * x < (x * x + y * y) * (1 + cs): bad += 1   # C3
    if m < M:
        for e in (1, -1):
            c2, s2 = rot(c, s, e * K)
            stack.append((m + 1, x + F(e, K) * (s2 - s), y + F(e, K) * (c - c2), c2, s2))
print(bad)
