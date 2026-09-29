#!/usr/bin/env python3
"""FS121-DB1 control: the degenerate case of lemma DB1-L3 (no colour has two positive-angle sectors at a point of Σ), exact (sympy).

Frame: p = (0, 0) is a point of Σ; G1 is a positive-angle sector of colour γ at p, below its edge r; n = (0, 1) points out of G1, t = (1, 0)
is r's tangent at p. r is an arc of the unit circle about y, and y carries γ only as a cusp tangent to the boundary ray of its allowed
cone (the degenerate case of Case K in § 2.3). By the comparison step, the cusp lies outside the open unit disc about p: its points are
q = y + (±λ, ∓(λ²/2 − c)) with c > 0 (sign so that |q − p| > 1).

K−: y = p − n, γ inside r (G1 = inside the unit disc about y, below r, above the ray at −60°); q = (λ, −1 + λ²/2 − c). Claim: the unit
    circle about q passes through G1 near p (a violation of a.e.-properness against G1 itself).
K+: y = p + n, γ outside r; q = (−λ, 1 − λ²/2 + c). A second γ sector G2 with directions in (60°, 120°) is the hypothesis to refute. Claim:
    the unit circle about q passes through G2 near p (a violation against G2).
Each claim is checked at 9 sample points of the circle, exactly. λ = 1/10, c = 1/2000; every sample lies within 1/20 of p.

Usage: python3 tools/fs121_db1_cusp.py [--plant]   (--plant takes c = −1/2000: the cusp inside the unit disc about p, which the comparison
step forbids; the circles then miss G1 and G2, and the counts must read otherwise). Prints one line; exits 0 either way.
"""
import sys
import sympy as sp

lam = sp.Rational(1, 10)
c = sp.Rational(-1, 2000) if '--plant' in sys.argv else sp.Rational(1, 2000)
s3 = sp.sqrt(3)
small = sp.Rational(1, 20)


def pos(e):
    return bool(sp.simplify(e).is_positive)


# K−
q = (lam, -1 + lam ** 2 / 2 - c)
hits_minus = 0
for j in range(9):
    mu = (sp.Rational(1, 2000) / lam) * (sp.Rational(1, 2) + sp.Rational(j, 20))   # mu in (c/(2λ), c/λ) at the true c
    eta = q[1] + sp.sqrt(1 - (mu - q[0]) ** 2)                                    # upper branch of the circle about q, near p
    below_r = pos(1 - (mu ** 2 + (eta + 1) ** 2))                                   # inside the unit disc about y = (0, -1)
    in_angle = pos(-eta) and pos(eta + s3 * mu)                                    # direction in (-60°, 0°)
    near = pos(small ** 2 - mu ** 2 - eta ** 2)
    hits_minus += below_r and in_angle and near

# K+
q = (-lam, 1 - lam ** 2 / 2 + c)
hits_plus = 0
for j in range(-4, 5):
    mu = sp.Rational(1, 2000) * sp.Rational(j, 10)                                 # |mu| <= 0.4 c < c/√3 at the true c
    eta = q[1] - sp.sqrt(1 - (mu - q[0]) ** 2)                                    # lower branch of the circle about q, near p
    in_g2 = pos(eta) and pos(eta ** 2 - 3 * mu ** 2)                               # direction in (60°, 120°)
    near = pos(small ** 2 - mu ** 2 - eta ** 2)
    hits_plus += in_g2 and near

print(f'K- circle about the cusp point meets G1 at {hits_minus} of 9; K+ circle meets G2 at {hits_plus} of 9')
