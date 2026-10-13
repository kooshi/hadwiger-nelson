#!/usr/bin/env python3
"""FS131-EN1: the signed reading of "gives T + A measure 0" fails.

nu = lambda_r - lambda_r', two archimedean circle measures (FS100-EFX; J45 § 4.2 "Readings"), is rotation-invariant and has
nu(T + A) = 1 - 1 = 0, while its Fourier coefficient at 1 is J0(2 pi r) - J0(2 pi r').
usage: j0_check.py <r> <r'>      prints J0(2 pi r) - J0(2 pi r') to six places (power series, exact rationals in pi's float)."""
import sys, math
def j0(x):
    s = t = 1.0
    for k in range(1, 80):
        t *= -(x * x) / (4.0 * k * k); s += t
    return s
r, rp = float(sys.argv[1]), float(sys.argv[2])
print(f"{j0(2 * math.pi * r) - j0(2 * math.pi * rp):.6f}")
