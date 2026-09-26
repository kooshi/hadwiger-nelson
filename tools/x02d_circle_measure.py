#!/usr/bin/env python3
"""X02D: numeric sanity for the circle measure refuting CE-1's hypothesis (H) (not a certificate; the proof is by hand).
The pushforward nu of uniform measure on {|lambda| = 1} under lambda -> (x -> exp(2 pi i Re(lambda x))) has Fourier
coefficient J0(2 pi |x|) at x. Checks: nu-hat(1) = J0(2 pi) != 0 (so nu is not Haar); the Cesaro mean of |nu-hat(j)|^2,
j = 1..N, tends to 0 (Wiener: no atoms in the image on the circle group, so nu is not finitely supported).
--plant-haar replaces J0 by the Haar coefficients (0 for x != 0): the 'not Haar' check must FAIL.
--plant-atom adds an atom of mass 1/2 at the trivial character: the 'no atoms' check must FAIL."""
import sys
from mpmath import mp, besselj, pi
mp.dps = 30
haar = "--plant-haar" in sys.argv
atom = "--plant-atom" in sys.argv
def coeff(j):
    c = 0 if haar else besselj(0, 2 * pi * j)
    return (c + 1) / 2 if atom else c
c1 = coeff(1)
print("nu-hat(1) =", c1)
ok1 = abs(c1) > mp.mpf("0.1")
print("not Haar (|nu-hat(1)| > 0.1):", "ok" if ok1 else "FAIL")
means = []
for N in (10, 100, 1000):
    means.append(sum(abs(coeff(j)) ** 2 for j in range(1, N + 1)) / N)
print("Cesaro means of |nu-hat(j)|^2 at N = 10, 100, 1000:", [mp.nstr(m, 6) for m in means])
ok2 = means[-1] < mp.mpf("0.001") and means[-1] < means[0]
print("no atoms (mean -> 0):", "ok" if ok2 else "FAIL")
sys.exit(0 if (ok1 and ok2) else 1)
