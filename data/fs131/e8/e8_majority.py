#!/usr/bin/env python3
"""FS131-E8 § 5 — exact check of the Chebyshev step that replaces the pointwise ergodic theorem in J45-SI-5 (c):
for n indicators of probability p, pairwise independent, P(at least n/2 of them are 1) ≤ p(1 − p) / (n (1/2 − p)²)  [= 8/n at p = 1/3].
Computed for the binomial law (the independent case) in exact rationals, n = 1 … 300. Prints the number of n at which the bound fails.
Usage: e8_majority.py [--p a/b]      (the planted fault: --p 2/3, a minority colour that is in fact the majority)"""
import sys
from fractions import Fraction as F
from math import comb
p = F(sys.argv[sys.argv.index("--p") + 1]) if "--p" in sys.argv else F(1, 3)
bad = 0
for n in range(1, 301):
    tail = sum(comb(n, j) * p ** j * (1 - p) ** (n - j) for j in range((n + 1) // 2, n + 1))   # P(Bin(n, p) ≥ n/2)
    if tail > p * (1 - p) / (n * (F(1, 2) - p) ** 2):
        bad += 1
print(bad)
