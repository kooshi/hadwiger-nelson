#!/usr/bin/env python3
"""X25B's exact checks for FS100-T1 (the class of real quadratic fields whose stable places all have all-levels
four-colour ratio < 1/4).  Seconds of arithmetic that check a derived claim; no search.

  (1) The residue classes mod 168 cut out by the derivation's three local conditions
      (dyadic place split: d = 7 mod 8; 3 not stable: d = 2 mod 3; 7 not stable: (d/7) = -1)
      are exactly {47, 143, 167}.
  (2) Level-one spectra of Gamma_p = Cay(F_p^2, {x^2+y^2=1}) for p = 11, 19, 23, 31: tau_p = -lambda_min/(p+1).
      Hoffman gives ratio < 1/4 iff tau_p < 1/3.  Controls: fails at 11 and 19 (Hoffman ratios 0.2855, 0.2756 per
      LEDGER row 88), holds at 23 and 31 (31 by about 4.9e-6).  Float sums of p+1 cosines: error < 1e-12, margins
      checked to exceed 1e-8.
  (3) Weil tail: 2*sqrt(p)/(p+1) < 1/3 for every prime p = 3 mod 4 with p >= 43 (monotone from p = 34), and it
      fails at 31 (so 31 needs (2)).
  (4) FS-66's recorded all-levels bounds U(p) (exact rationals U_num/scale from data/fs66/b1/cert-p*.json):
      4*U < p^2 at 11, 19, 23.  (This reads the certificates' stated U; their CERTIFIED status is LEDGER row 75's.)
  (5) The new-level normalised bound 2/(p+1) < 1/3 for p >= 7.

Plants: `--plant1` flips the 7-condition to (d/7) = +1 in (1); `--plant2` moves 31's Hoffman threshold to 1/3 - 1e-3 in (2);
each must make its assertion fail (exit 1).  Exit 0: all checks pass.
"""
import json
import math
import sys
from fractions import Fraction

PLANT1 = "--plant1" in sys.argv
PLANT2 = "--plant2" in sys.argv
PLANT = PLANT1 or PLANT2


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def check_residues():
    cls = []
    for r in range(168):
        dyadic_split = r % 8 == 7
        three_not_stable = r % 3 == 2
        want7 = 1 if PLANT1 else -1
        seven_not_stable = legendre(r, 7) == want7
        if dyadic_split and three_not_stable and seven_not_stable:
            cls.append(r)
    print("(1) classes mod 168:", cls)
    assert cls == [47, 143, 167], f"(1) FAILED: {cls}"
    for d in (47, 143, 311, 335, 167):
        assert d % 168 in cls, d
    for d in (59, 11, 83, 131, 23, 71):
        assert d % 168 not in cls, d
    print("    members 47,143,311,335,167 in; 59,11,83,131,23,71 out: OK")


def spectrum_tau(p):
    circle = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    assert len(circle) == p + 1, f"circle size {len(circle)} != p+1 at p={p}"
    lam_min = None
    for a in range(p):
        for b in range(p):
            if a == 0 and b == 0:
                continue
            s = sum(math.cos(2 * math.pi * ((a * x + b * y) % p) / p) for x, y in circle)
            lam_min = s if lam_min is None else min(lam_min, s)
    return -lam_min / (p + 1)


def check_hoffman():
    third = 1 / 3
    taus = {p: spectrum_tau(p) for p in (11, 19, 23, 31)}
    for p, t in taus.items():
        print(f"(2) p={p}: tau={t:.9f}  tau-1/3={t - third:+.3e}  Hoffman ratio={t / (1 + t):.6f}")
    assert taus[11] > third + 1e-8 and taus[19] > third + 1e-8, "(2) control FAILED: Hoffman should fail at 11, 19"
    assert abs(taus[11] / (1 + taus[11]) - 0.2855) < 5e-4 and abs(taus[19] / (1 + taus[19]) - 0.2756) < 5e-4
    assert taus[23] < third - 1e-8, "(2) FAILED at 23"
    thr31 = third - 1e-3 if PLANT2 else third
    assert taus[31] < thr31 - 1e-8, "(2) FAILED at 31"
    print("    Hoffman < 1/4 at 23 and 31; fails at 11 and 19 (controls): OK")


def check_weil():
    ok = all(6 * math.sqrt(p) < p + 1 for p in range(34, 5000))
    assert ok
    assert not (6 * math.sqrt(31) < 32), "(3) control FAILED: Weil should not suffice at 31"
    print("(3) Weil tail 2sqrt(p)/(p+1) < 1/3 for 34 <= p < 5000 (monotone beyond); fails at 31: OK")


def check_fs66():
    for p in (11, 19, 23):
        d = json.load(open(f"data/fs66/b1/cert-p{p}.json"))
        assert d["p"] == p and d["format"] == "fs66-b1-cert-v2"
        U = Fraction(d["U_num"], d["scale"])
        print(f"(4) p={p}: U={float(U):.6f}  U/p^2={float(U / p**2):.6f}  4U<p^2: {4 * U < p * p}")
        assert 4 * U < p * p, f"(4) FAILED at {p}"


def check_newlevel():
    assert all(Fraction(2, p + 1) < Fraction(1, 3) for p in range(7, 10000))
    print("(5) 2/(p+1) < 1/3 for p >= 7: OK")


if __name__ == "__main__":
    try:
        check_residues()
        check_hoffman()
        check_weil()
        check_fs66()
        check_newlevel()
    except AssertionError as e:
        print("ASSERTION:", e)
        sys.exit(1)
    print("ALL OK" + (" (PLANT DID NOT FIRE)" if PLANT else ""))
    sys.exit(0)
