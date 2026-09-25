#!/usr/bin/env python3
"""FS-86 verifier B1: second code path for the least eigenvalue of Gamma_p, p = 3 mod 4.
Derivation (mine, recorded in plans/FS86-B1-verification.md): for (a,b) != 0 with c = a^2 + b^2,
  lambda = sum_{x^2+y^2=1} e((ax+by)/p) = (1/p) sum_t sum_{x,y} e((t(x^2+y^2-1) + ax + by)/p)
         = -sum_{t != 0} e(-(t + c/(4t))/p)   (Gauss sums: g(t)^2 = (-1/p) p = -p for p = 3 mod 4)
         = -K(1, c/4), a Kloosterman sum, |K| <= 2 sqrt(p) (Weil).
Computes min over c of -K(1,c/4) with mpmath at 60 digits and compares with the direct circle sum of gamma_spectra.py.
Plant: --plant uses +K instead of -K (the sign slip); the comparison with the circle sum must then FAIL."""
import sys
from mpmath import mp, cos, pi, mpf
mp.dps = 60
from gamma_spectra import run as circle_run

def kl_min(p, sign=-1):
    inv4 = pow(4, -1, p)
    best = None
    for c in range(1, p):
        k = sum(cos(2*pi*((t + c*inv4*pow(t, -1, p)) % p)/p) for t in range(1, p))
        lam = sign*k
        best = lam if best is None or lam < best else best
    return best

if __name__ == "__main__":
    sign = +1 if "--plant" in sys.argv else -1
    for p in [11, 19, 23, 31, 43, 47, 59, 83, 131]:
        lk = kl_min(p, sign)
        lc = circle_run(p)['lmin']
        agree = abs(lk - lc) < mpf(10)**-45
        print(f"p={p:4d} kloosterman lmin={mp.nstr(lk, 22):>28}  circle lmin={mp.nstr(lc, 22):>28}  "
              f"agree={'PASS' if agree else 'FAIL'}  lmin+(p+1)/3={mp.nstr(lk + mpf(p+1)/3, 15)}")
