#!/usr/bin/env python3
"""FS131-E8 — exact check of the lens step of § The local structure off Σ, step (3): two interface points x′, x″ with unit
normals ν′, ν″, each carrying two tangent open unit discs that hold in the ball N = B(x, ρ), have |ν′ − ν″| ≤ C |x′ − x″| with C = 6.

The step's content: if w = x′ − x″, δ = |w| ≤ ρ/8, |⟨w, ν″⟩| ≤ δ²/2 (x′ lies outside both discs at x″) and L = |ν′ − ν″| > Cδ, then
the point p = x′ + σ(ν″ − ν′), with σ the largest multiple of 1/64 that is at most 1/2 and has σL ≤ ρ/4, lies in both
  D₁ = B(x′ − ν′, 1)  (the disc of colour a at x′)   and   D₂ = B(x″ + ν″, 1)  (the disc of colour b at x″),
and within ρ/4 of x′ — so in N: an open set almost everywhere of two colours, which is impossible.
WLOG ν″ = (0, 1) and ρ = 1 (the statement is invariant under rotation; a smaller ρ is a sub-case). Rational data only:
ν′ over 8-fold images of ((q²−p²)/(q²+p²), 2pq/(q²+p²)), q = 40; w = (a, c·a²/2), a = ±j/64 (j ≤ 7), c ∈ {−1, −1/2, 0, 1/2, 1}.
Prints the number of admissible triples (ν′, w) at which p misses D₁ or D₂. With C = 6 it prints 0.
Usage: e8_lens.py [--C C]      (the planted fault: --C 1, the hypothesis weakened to L > δ)"""
import sys
from fractions import Fraction as F
C = F(sys.argv[sys.argv.index("--C") + 1]) if "--C" in sys.argv else F(6)
rho = F(1)
U = set()
q = 40
for p in range(0, q + 1):
    X, Y = F(q * q - p * p, q * q + p * p), F(2 * p * q, q * q + p * p)
    for (u, v) in ((X, Y), (Y, X)):
        for su in (1, -1):
            for sv in (1, -1):
                U.add((su * u, sv * v))
W = [(F(s * j, 64), c * F(j * j, 64 * 64) / 2) for j in range(1, 8) for s in (1, -1)
     for c in (F(-1), F(-1, 2), F(0), F(1, 2), F(1))]
n2 = (F(0), F(1))
bad = tested = 0
for (a, b) in W:
    d2 = a * a + b * b
    assert abs(b) <= d2 / 2 and 64 * d2 <= rho * rho          # x′ outside both discs at x″; δ ≤ ρ/8
    for (u, v) in U:
        dx, dy = n2[0] - u, n2[1] - v                           # Δ = ν″ − ν′
        L2 = dx * dx + dy * dy
        if not L2 > C * C * d2:
            continue
        tested += 1
        k = 32
        while k > 0 and F(k, 64) ** 2 * L2 > rho * rho / 16:
            k -= 1
        s = F(k, 64)
        in1 = (s * dx + u) ** 2 + (s * dy + v) ** 2 < 1         # p − (x′ − ν′) = σΔ + ν′
        in2 = (a + s * dx - n2[0]) ** 2 + (b + s * dy - n2[1]) ** 2 < 1   # p − (x″ + ν″) = w + σΔ − ν″
        if not (k > 0 and in1 and in2):
            bad += 1
assert tested > 1000
print(bad)
