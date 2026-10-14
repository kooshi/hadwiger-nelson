#!/usr/bin/env python3
"""FS131-KN4: NF4-S9 at F = Q, P = (1+i), level m (O/P^m with P^2 = (2)): the norm-one elements of Z[i]/P^m against the
image of the unit vectors of Q^2. For even m = 2j, O/P^m = Z[i]/2^j.
A unit vector of Q^2 is (a + bi)/c with a^2 + b^2 = c^2, c odd (c even forces a, b even); its residue mod 2^j is
(a + bi) * c^{-1}.  Usage: s9_check.py [--plant]   (--plant: count a non-unit-vector as one; the image must grow)"""
import sys
from math import gcd
plant = "--plant" in sys.argv
for j in (1, 2, 3):
    N = 2**j
    normone = {(a, b) for a in range(N) for b in range(N) if (a*a + b*b) % N == 1 % N}
    image = set()
    B = 60
    for a in range(-B, B+1):
        for b in range(-B, B+1):
            c2 = a*a + b*b
            c = int(round(c2**0.5))
            ok = (c*c == c2 and c % 2 == 1)
            if plant and (a, b) == (1, 2):
                ok, c = True, 1
            if ok:
                ci = pow(c, -1, N) if N > 1 else 0
                image.add(((a*ci) % N, (b*ci) % N))
    print(f"m={2*j}: |O/P^m|={N*N}  norm-one={len(normone)}  image of U_Q={len(image)}  equal={normone == image}"
          + ("" if normone == image else f"  missed e.g. {sorted(normone - image)[:3]}"))
