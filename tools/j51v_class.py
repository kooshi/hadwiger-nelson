#!/usr/bin/env python3
"""J51V: which stable places does a real quadratic field Q(sqrt d) have, and is it in T-C(A)'s class? (exact, seconds; no search)

T-C(A)'s class (plans/R88-derivation.md R88-TCA, J28D's class form): every stable place of L = F(i) has all-levels ratio < 1/4.
For F = Q(sqrt d), d squarefree, d = 3 (mod 4):
  * dyadic: 2 ramifies in F; F_2 = Q_2(sqrt d) = Q_2(i) iff -d is a 2-adic square iff d = 7 (mod 8); then the dyadic place SPLITS in L/F
    (ratio 0). Otherwise it is stable (and the field is outside the class's four-colour count: a tight or ramified dyadic place).
  * odd p = 1 (mod 4): i in Q_p, split in L. p = 3 (mod 4): stable iff p | d (ramified in F; residue F_p, -1 not a square) or (d/p) = 1
    (split in F; residue F_p). p inert in F: residue F_{p^2} holds sqrt(-1), split in L.
The all-levels ratio at a stable odd place with residue F_p: >= 1/4 at level one for p = 3, 7 (Gamma_3, Gamma_7 are 3-, 4-colourable);
< 1/4 at every level for p = 11, 19 by FS-66's certificates (ramified towers by Lemma P (ii), plans/FS86-B1-verification.md), for 23, 31, 43,
47 by Hoffman + Lemma P (plans/FS84-S1-derivation.md §1.3 step 8), for p >= 37 by Weil + Hoffman + Lemma P. So, for d = 3 (mod 4):
    in class  <=>  d = 7 (mod 8)  and  neither 3 nor 7 is stable.
Controls: d = 47 must be IN (row 113); d = 59 (type (B), d = 3 mod 8) and d = 11 must be OUT; d = 23 is OUT through 7 alone (d = 7 mod 8,
(23/7) = 1, 3 inert) and d = 31 through 3 alone ((31/3) = 1, 7 inert).
Plant: --plant forget-seven (drop 7 from the bad list) must make the d = 23 control fail, exit 1. (Its first target, d = 11, could NOT fire:
Q(sqrt 11) is already out through its stable dyadic place, 11 = 3 mod 8 -- a recorded unreachable plant.)
"""
from __future__ import annotations

import argparse
import sys


def legendre(a: int, p: int) -> int:
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def primes(n: int) -> list[int]:
    s = [True] * (n + 1)
    s[0] = s[1] = False
    for i in range(2, int(n**0.5) + 1):
        if s[i]:
            s[i * i :: i] = [False] * len(s[i * i :: i])
    return [i for i, b in enumerate(s) if b]


def stable_odd(d: int, bound: int = 100) -> list[tuple[int, str]]:
    out = []
    for p in primes(bound):
        if p == 2 or p % 4 != 3:
            continue
        if d % p == 0:
            out.append((p, "ramified"))
        elif legendre(d, p) == 1:
            out.append((p, "split-in-F"))
    return out


def in_class(d: int, bad: set[int]) -> tuple[bool, str]:
    assert d % 4 == 3
    dy = "split in L" if d % 8 == 7 else "STABLE"
    st = stable_odd(d)
    badst = [p for p, _ in st if p in bad]
    ok = (d % 8 == 7) and not badst
    return ok, f"dyadic {dy}; stable odd p < 100: {st}; bad stable: {badst}"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", default="none", choices=["none", "forget-seven"])
    a = ap.parse_args()
    bad = {3} if a.plant == "forget-seven" else {3, 7}
    fails = []
    expect = {47: True, 143: True, 311: True, 335: True, 59: False, 11: False, 23: False, 31: False}
    for d, want in expect.items():
        ok, info = in_class(d, bad)
        print(f"Q(sqrt {d}): in class = {ok}   ({info})")
        if ok != want:
            fails.append((d, ok, want))
    # the residue fields the three K0 fields actually use, below 50 (for the record)
    if fails:
        print(f"FAIL: {fails}")
        return 1
    print("ALL CHECKS PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
