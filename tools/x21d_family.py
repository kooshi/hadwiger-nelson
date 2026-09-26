#!/usr/bin/env python3
"""X21D exact check (seconds): the L >= 5 family of real quadratic fields, Q-0 and A-2's residue data.

Checks, for squarefree d in [2, N]:
  (a) Q-0: d = 7 (mod 8)  ==>  -d is a square in Q_2 (so Q_2(sqrt d) = Q_2(i): the dyadic place of Q(sqrt d) splits in
      L = Q(sqrt d, i), i.e. is not stable).  Tested by brute force: x^2 = -d (mod 2^k) solvable for k = 3..12 with x odd.
      Conversely, for odd d != 7 (mod 8), -d is NOT a square in Q_2 (so the claim's hypothesis is not idle).
  (b) d = 47, 143, 167 (mod 168)  <=>  [d = 7 (mod 8), 3 inert in Q(sqrt d), 7 inert in Q(sqrt d)] for squarefree d
      (inert = Legendre symbol -1, by Euler's criterion; p inert in F with p = 3 (mod 4) means F_p contains i: not stable).
  (c) A-2's four fields: 11 is stable (split or ramified in F, residue field F_11) at 47, 143, 311, 335, each in the family.
  (d) Q(sqrt 167): the stable odd places below 100 (p = 3 mod 4, split or ramified), listed.
  (e) A-4's reach: the level-one mixing constant max|lambda|/deg over non-trivial characters of Gamma_q exceeds 1/3 at q = 11, 19
      (so a stable 11 or 19 is not 4-thick and J48-N4cor cannot reach an L = 5 family member). Float character sums; the margin is > 0.04.
Plants (each must make an assertion fail): --plant-dyadic (use d = 3 mod 8 as the dyadic test), --plant-legendre (flip (d/11)),
--plant-halve (normalise by 2*deg: the thickness assertion (e) must fail).
Exit 0 = all assertions hold; 1 = an assertion failed (printed).
"""
import sys

PLANT = set(a for a in sys.argv[1:] if a.startswith("--plant"))


def squarefree(n):
    k = 2
    while k * k <= n:
        if n % (k * k) == 0:
            return False
        k += 1
    return True


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    r = pow(a, (p - 1) // 2, p)
    s = 1 if r == 1 else -1
    if "--plant-legendre" in PLANT and p == 11:
        s = -s
    return s


def minus_d_square_in_Q2(d):
    """-d (d odd) is a 2-adic square iff x^2 = -d mod 2^k solvable for all k (k = 3 suffices; checked to 12)."""
    if "--plant-dyadic" in PLANT:
        return d % 8 == 3
    for k in range(3, 13):
        m = 1 << k
        if not any((x * x + d) % m == 0 for x in range(1, m, 2)):
            return False
    return True


def stable_odd(d, p):
    """p = 3 (mod 4) odd prime: a place of F above p is stable (does not split in F(i)) iff p splits or ramifies in F."""
    assert p % 4 == 3
    return legendre(d, p) in (0, 1)


def main():
    N = 3000
    fails = []
    fam = []
    for d in range(2, N + 1):
        if not squarefree(d):
            continue
        if d % 2 == 1:
            sq = minus_d_square_in_Q2(d)
            if (d % 8 == 7) != sq:
                fails.append(f"(a) d={d}: d%8={d%8}, -d square in Q2: {sq}")
        cls = d % 168 in (47, 143, 167)
        cond = d % 8 == 7 and legendre(d, 3) == -1 and legendre(d, 7) == -1
        if cls != cond:
            fails.append(f"(b) d={d}")
        if cls:
            fam.append(d)
    for d in (47, 143, 311, 335):
        if d not in fam:
            fails.append(f"(c) {d} not in family")
        if not stable_odd(d, 11):
            fails.append(f"(c) 11 not stable at {d}")
    primes = [p for p in range(3, 100) if all(p % q for q in range(2, p)) and p % 4 == 3]
    st167 = [p for p in primes if stable_odd(167, p)]
    if st167[:3] != [23, 43, 59]:
        fails.append(f"(d) stable places of Q(sqrt167) below 60: {st167}")
    import cmath, math
    for q in (11, 19):
        circ = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
        norm = len(circ) * (2 if "--plant-halve" in PLANT else 1)
        lam = max(abs(sum(cmath.exp(2j * math.pi * (a * x + b * y) / q) for x, y in circ).real) / norm
                  for a in range(q) for b in range(q) if (a, b) != (0, 0))
        print(f"lambda*(Gamma_{q}) = {lam:.6f} (deg {len(circ)})")
        if not lam > 1 / 3 + 0.04:
            fails.append(f"(e) lambda*(Gamma_{q}) = {lam:.6f} not > 1/3")
    l5 = [d for d in fam if stable_odd(d, 11) or stable_odd(d, 19)]
    print(f"family (squarefree d <= {N}): {len(fam)} fields; first 12: {fam[:12]}")
    print(f"with 11 or 19 stable (L = 5): {len(l5)}; first 12: {l5[:12]}")
    print(f"Q(sqrt167) stable odd places < 100: {st167}")
    if fails:
        print("FAIL:", *fails[:10], sep="\n  ")
        sys.exit(1)
    print("ALL CHECKS HOLD")


if __name__ == "__main__":
    main()
