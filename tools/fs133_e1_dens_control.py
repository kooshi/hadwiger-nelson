#!/usr/bin/env python3
"""FS133-E1: exact controls for C133-DENS (plans/FS133-E1-derivation.md, stage 3).  Standard library, exact rationals.

  upper | lower   The alternating-annuli field.  S_j (j = 0, 1) is the union of the annuli {4^k <= |x|^2 < 4^(k+1)} with
                  k = j (mod 2) (the unit disc goes to S_0); a fair coin picks j.  Every point lies in exactly one S_j, so
                  the mean of 1[x in S_j] is alpha = 1/2 at every x.  f_j(k) = area(S_j ∩ B(0, 2^(k+1))) / area(B(0, 2^(k+1)))
                  is an exact rational.  'upper' prints whether, for both j, the LARGEST f_j(k) over 6 <= k <= 40 is >= 1/2
                  (the claim's direction: upper density >= alpha);  'lower' prints the same with the SMALLEST (the direction
                  not claimed: lower density), which must fail.
  packing <s>     The model.  Open discs of radius 1/2 centred on s*(Z(1,0) + Z(1/2, sqrt3/2)).  Squared distances between
                  centres are s^2 (a^2 + ab + b^2).  The union is 1-avoiding iff every two distinct centres are at distance
                  >= 2 (then points of different discs are at distance > 1, and points of one disc at distance < 1).
                  Prints whether min over nonzero |a|,|b| <= 8 of s^2 (a^2+ab+b^2) >= 4.  s = 2 is the model; s = 19/10 the fault.
"""
import sys
from fractions import Fraction as Fr

def annuli(mode):
    half = Fr(1, 2)
    res = []
    for j in (0, 1):
        vals = []
        for k in range(6, 41):
            # areas in units of pi: disc |x|<1 has 1 (to S_0); annulus i has 4^(i+1) - 4^i = 3*4^i, i = 0..k
            a = sum(3 * 4**i for i in range(0, k + 1) if i % 2 == j) + (1 if j == 0 else 0)
            vals.append(Fr(a, 4**(k + 1)))
        res.append(max(vals) if mode == "upper" else min(vals))
    return all(v >= half for v in res)

def packing(s):
    s = Fr(s)
    m = min(s * s * (a * a + a * b + b * b) for a in range(-8, 9) for b in range(-8, 9) if (a, b) != (0, 0))
    return m >= 4

if __name__ == "__main__":
    mode = sys.argv[1]
    if mode in ("upper", "lower"):
        print(annuli(mode))
    elif mode == "packing":
        print(packing(sys.argv[2]))
    else:
        sys.exit("unknown mode")
