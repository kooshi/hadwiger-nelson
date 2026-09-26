#!/usr/bin/env python3
"""X27D: the one local fact the split-escape lemma (X27D-SPL) rests on, checked exactly on Z/p^k.

Claim (the finite model of int_{O_v^x} psi(c u) du = 0 for |c|_v >= q^2):
  for N = p^k and an integer c with v_p(c) <= k - 2, sum_{u in (Z/N)^x} e(c u / N) = 0.
Exact route: sum_{x mod N} e(c x/N) = N [N | c], so the unit sum is N[N|c] - (N/p)[(N/p) | c]  (integers).
Cross-check: the same sum in floating point, directly over the units (a check of the identity, not of the claim).
Plant (--plant): include u = 0 in the "unit" set; the claim must then FAIL and the script exit 1.
"""
import cmath, math, sys

PLANT = "--plant" in sys.argv

def unit_sum_exact(p, k, c):
    N = p ** k
    return (N if c % N == 0 else 0) - ((N // p) if c % (N // p) == 0 else 0)

def unit_sum_float(p, k, c):
    N = p ** k
    us = [u for u in range(N) if (u % p != 0) or (PLANT and u == 0)]
    return sum(cmath.exp(2j * math.pi * c * u / N) for u in us)

bad = 0; checked = 0
for p in (2, 3, 5, 7, 11):
    for k in (2, 3, 4):
        N = p ** k
        for c in range(1, N):
            vp = 0; cc = c
            while cc % p == 0: cc //= p; vp += 1
            ex = unit_sum_exact(p, k, c)
            fl = unit_sum_float(p, k, c)
            if not PLANT and abs(fl - ex) > 1e-6:
                print("identity mismatch", p, k, c, ex, fl); bad += 1
            if vp <= k - 2:
                checked += 1
                val = fl if PLANT else ex
                if abs(val) > 1e-6:
                    bad += 1
if bad:
    print(f"RED: {bad} failures (plant={PLANT}) over {checked} instances with v_p(c) <= k-2"); sys.exit(1)
print(f"GREEN: unit sums vanish at all {checked} instances with v_p(c) <= k-2 (p <= 11, k <= 4); identity cross-checked")
