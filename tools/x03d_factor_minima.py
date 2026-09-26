#!/usr/bin/env python3
"""X03D stage 3 check: the least normalised U-mean of a character in T + A, factor by factor.

For a prime q = 3 (mod 4) the level-one factor is Gamma_q = Cay(F_q^2, S), S = {x^2 + y^2 = 1}, |S| = q + 1; its normalised
eigenvalue at (a, b) is (1/|S|) sum_{s in S} cos(2 pi (a s1 + b s2) / q). Inert towers keep this ratio exactly (CLAUDE.md G54),
so level one gives the all-levels value. The real place: the U-mean of x -> e(Re(xi x)) over the unit circle is J0(2 pi |xi|),
whose minimum is J0(j_{1,1}) ~ -0.402759.

Claim checked (derived in plans/FS100-X03D-derivation.md stage 3): at Q(sqrt47) the factors 11, 19 and the real place have least
normalised mean BELOW -1/3 (they fail H*), so Lambda := -inf_{T+A} M > 1/3.
Controls with known answers (R88-TC-tab; CLAUDE.md G54): 23 passes H* by ~1.6e-3, 31 by ~4.9e-6 (lambda_min + d/3 = 1.5617e-4).
Plant (--plant): drop one point of S; the control at 31 must then fail (it is a margin of 5e-6).
"""
import sys, math
import numpy as np
from scipy.special import j0
from scipy.optimize import brentq

def min_ratio(q, plant=False):
    S = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y - 1) % q == 0]
    assert len(S) == q + 1, (q, len(S))
    if plant:
        S = S[1:]
    S = np.array(S)
    a, b = np.meshgrid(np.arange(q), np.arange(q), indexing="ij")
    A = np.stack([a.ravel(), b.ravel()], axis=1)[1:]          # nonzero frequencies
    lam = np.cos(2 * np.pi * (A @ S.T) / q).sum(axis=1)
    return lam.min() / len(S)

def main():
    plant = "--plant" in sys.argv
    ok = True
    j11 = brentq(lambda t: -__import__("scipy.special", fromlist=["j1"]).j1(t), 3.5, 4.2)
    J = float(j0(j11))
    print(f"real place: j11 = {j11:.6f}, J0(j11) = {J:.6f}, J0 + 1/3 = {J + 1/3:+.6f}")
    ok &= J + 1 / 3 < -0.06
    for q, expect in [(11, "fail"), (19, "fail"), (23, "pass"), (31, "pass")]:
        r = min_ratio(q, plant)
        m = r + 1 / 3
        print(f"q = {q:2d}: min lambda/d = {r:+.9f}, margin to -1/3 = {m:+.3e}  (expected H* {expect})")
        if expect == "fail":
            ok &= m < -1e-3
        elif q == 23:
            ok &= 1.0e-3 < m < 2.2e-3
        else:
            ok &= 4.0e-6 < m < 6.0e-6
    print("ALL CHECKS PASS" if ok else "CHECK FAILED")
    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
