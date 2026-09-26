#!/usr/bin/env python3
"""Crunch job J46 (blind verifier of FS-84's SI claim list): exact checks of seconds.

Not a search.  Three checks of identities that the stage-2 proofs in plans/FS84-SI-V-verification.md use:

  (1) the tetrahedral identity  <sum_j a_j e_j, sum_k b_k e_k> = (4/3) sum_j a_j b_j - 1/3  for probability vectors a, b
      (sympy, symbolic in a_0..a_2, b_0..b_2 with a_3, b_3 eliminated);
  (2) the conditional-expectation identity behind (SI), on a finite model: G = Z/N, a random proper colouring
      (uniform translate of a fixed proper colouring, some points recoloured independently at random), the "E-part" of the spectrum
      the characters killing a subgroup K; then for every u,
          C(u) - (1/|K|) sum_{k in K} C(u + k)  ==  C(u) + 1/3 - (4/3) E[ sum_j a_j(0) a_j(u) ],
      with a_j(x) = P(c(x) = j | K-invariant sigma-algebra); on edges the left side is <= 0, with equality iff the supports are disjoint.
      Exact rational arithmetic over the whole finite probability space.
  (3) J_0 takes a negative value: J_0(3.8317...) < 0 (mpmath, 50 digits, with an explicit error margin).

Plants (each must FIRE, i.e. the check must report a failure when the plant is active):
  P1: Gram value -1/4 in place of -1/3 in (1) and (2);
  P2: in (2), condition on a partition that is not the K-invariant one (a_j computed from a non-invariant average);
  P3: in (3), evaluate at 2.0 (where J_0 > 0).

Exit status 0 iff every check passes and every plant fires.
"""
from fractions import Fraction as Fr
from itertools import product
import sys

import sympy as sp
import mpmath


def tetra_identity(gram_off):
    a = sp.symbols("a0:3")
    b = sp.symbols("b0:3")
    A = list(a) + [1 - sum(a)]
    B = list(b) + [1 - sum(b)]
    lhs = sum(A[j] * B[k] * (1 if j == k else gram_off) for j in range(4) for k in range(4))
    rhs = sp.Rational(4, 3) * sum(A[j] * B[j] for j in range(4)) - sp.Rational(1, 3)
    return sp.simplify(sp.expand(lhs - rhs)) == 0


# ---- (2) the finite model ------------------------------------------------------------------------------------------
N = 12
GENS = [1, 11, 5, 7]          # symmetric generating set (edges x ~ x +- 1, x +- 5)
KS = ([0, 6], [0, 3, 6, 9])   # subgroups whose annihilators play E; the first gives equality on edges, the second strict
BASE = [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3]   # proper for GENS: x and x+1, x+5 differ mod 4 (5 = 1 mod 4)
# recolour positions p = 0 mod 12 of the translated colouring: position x (after translate) may become colour of a "free" choice
# we recolour x with (x + t) % 12 == 0 to one of the colours absent from its neighbourhood, or keep it


def proper(col):
    return all(col[x] != col[(x + g) % N] for x in range(N) for g in GENS)


def build_space():
    """Return a list of (probability, colouring) over the finite space (t, noise)."""
    assert proper(BASE)
    space = []
    for t in range(N):
        col = [BASE[(x + t) % N] for x in range(N)]
        # the gapped point: x0 with (x0 + t) % N == 0
        x0 = (-t) % N
        nb = {col[(x0 + g) % N] for g in GENS}
        avail = sorted({c for c in range(4) if c not in nb} | {col[x0]})
        for c in avail:
            new = list(col)
            new[x0] = c
            assert proper(new)
            space.append((Fr(1, N) * Fr(1, len(avail)), new))
    return space


def gram(j, k, off):
    return Fr(1) if j == k else off


def check_model(off, K, plant_partition=False, want_strict=None):
    space = build_space()
    strict_seen = False
    C = {}
    for u in range(N):
        C[u] = sum(p * gram(col[0], col[u], off) for p, col in space)
    ok = True
    for u in range(N):
        left = C[u] - Fr(1, len(K)) * sum(C[(u + k) % N] for k in K)
        # a_j(x) = P(c(x)=j | K-invariant): average of indicators over the K-orbit (exact for a finite group acting)
        exp_overlap = Fr(0)
        for p, col in space:
            if plant_partition:
                orb0, orbu = [0, 1], [u, (u + 1) % N]      # not a K-orbit: wrong conditioning
            else:
                orb0, orbu = [k % N for k in K], [(u + k) % N for k in K]
            a0 = [Fr(sum(1 for x in orb0 if col[x] == j), len(orb0)) for j in range(4)]
            au = [Fr(sum(1 for x in orbu if col[x] == j), len(orbu)) for j in range(4)]
            exp_overlap += p * sum(a0[j] * au[j] for j in range(4))
        right = C[u] + Fr(1, 3) - Fr(4, 3) * exp_overlap
        if left != right:
            ok = False
        if u in GENS:
            if not (left <= 0):
                ok = False
            if (left == 0) != (exp_overlap == 0):
                ok = False
            if left < 0:
                strict_seen = True
    if want_strict is not None and strict_seen != want_strict:
        ok = False
    return ok


def check_bessel(z):
    mpmath.mp.dps = 50
    val = mpmath.besselj(0, mpmath.mpf(z))
    return val < mpmath.mpf("-0.4")          # J_0(3.8317) = -0.40276...


def main():
    results = []
    results.append(("(1) tetrahedral identity", tetra_identity(sp.Rational(-1, 3)), True))
    results.append(("(1) plant P1 (Gram -1/4)", tetra_identity(sp.Rational(-1, 4)), False))
    results.append(("(2) finite-model identity, K={0,6} (equality on edges)", check_model(Fr(-1, 3), KS[0], want_strict=False), True))
    results.append(("(2) finite-model identity, K={0,3,6,9} (strict on edges)", check_model(Fr(-1, 3), KS[1], want_strict=True), True))
    results.append(("(2) plant P1 (Gram -1/4)", check_model(Fr(-1, 4), KS[1]), False))
    results.append(("(2) plant P2 (non-invariant conditioning)", check_model(Fr(-1, 3), KS[1], plant_partition=True), False))
    results.append(("(3) J0(3.8317) < -0.4", check_bessel("3.8317"), True))
    results.append(("(3) plant P3 (J0 at 2.0)", check_bessel("2.0"), False))
    good = True
    for name, got, want in results:
        status = "ok" if got == want else "FAIL"
        if got != want:
            good = False
        kind = "check passes" if want else "plant fires"
        print(f"{status:4}  {name}: got {got}, expected {want} ({kind})")
    print("ALL OK" if good else "SOME FAILED")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main())
