#!/usr/bin/env python3
"""X23D: T-C(A)@0's class (every stable place of L = F(i) has all-levels four-colour ratio < 1/4) and L(F) for real
multiquadratic fields F = Q(sqrt a_1, ..., sqrt a_k), by exact Legendre symbols and 2-adic square classes.

The derivation (plans/FS100-X23D-derivation.md, stage 2) fixes the finite set first: for multiquadratic F every residue field
of F is F_p or F_{p^2}, so the usable (stable) odd q are primes p = 3 mod 4 with residue degree f = 1; every such p >= 11 has
all-levels ratio < 1/4 by held inputs (FS-66 at 11, 19; Hoffman at 23, 31; Weil + Hoffman + Lemma P from 37), so only
p in {3, 7} and the dyadic places can break the class, and those are exactly the stable targets with chi <= 4.  The listing of
stable odd places below BOUND is a sanity check against the advisor's list, not part of the decision.

Plant (--plant NAME): 'f-even-stable' treats residue degree 2 as stable (a wrong usability test); it must move Q(sqrt3, sqrt5)
out of the class (7 becomes 'stable').  'dyadic-ignore-minus1' forgets -1's class in the dyadic test; it must move
Q(sqrt47) out of the class (its split dyadic place becomes 'stable').
"""
import sys
from itertools import product

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def squarefree_part(n):
    s, d = 1, 2
    m = n
    while d * d <= m:
        while m % (d * d) == 0:
            m //= d * d
        d += 1
    return m


def span(gens):
    """All square-free products of subsets of gens (the non-trivial square classes of F over Q)."""
    out = set()
    for bits in product((0, 1), repeat=len(gens)):
        v = 1
        for b, g in zip(bits, gens):
            if b:
                v *= g
        out.add(squarefree_part(v))
    return out


def residue_degree(gens, p):
    """(e, f) of an odd prime p in F = Q(sqrt gens) (Galois group elementary abelian 2-group)."""
    classes = span(gens)
    ram = any(c % p == 0 for c in classes if c != 1)
    e = 2 if ram else 1
    # f = 1 iff every class prime to p is a square mod p (Frobenius trivial on the inertia-fixed field)
    f = 1
    for c in classes:
        if c % p and legendre(c, p) == -1:
            f = 2
    return e, f


# 2-adic square classes: Q_2^x / squares = <-1, 2, 5>; represent a class as a vector (a, b, c) for (-1)^a 2^b 5^c
def two_adic_class(n):
    b = 0
    while n % 2 == 0:
        n //= 2
        b += 1
    b %= 2
    u = n % 8
    table = {1: (0, 0), 3: (1, 1), 5: (0, 1), 7: (1, 0)}  # u = (-1)^a 5^c mod 8
    a, c = table[u]
    return (a, b, c)


def vspan(vecs):
    out = {(0, 0, 0)}
    for v in vecs:
        out |= {tuple((x + y) % 2 for x, y in zip(w, v)) for w in out}
    return out


def dyadic(gens):
    H = vspan([two_adic_class(g) for g in gens])
    minus1 = (1, 0, 0)
    five = (0, 0, 1)
    if PLANT == "dyadic-ignore-minus1":
        minus1 = (1, 1, 1)  # a wrong class
    if minus1 in H:
        return "split", None
    fF = 2 if five in H else 1
    HL = vspan(list(H) + [minus1])
    fL = 2 if five in HL else 1
    if fL == 2 * fF:
        return "inert", 2 ** fF
    return "ramified", 2 ** fF


def field_report(name, gens, bound=200):
    lines = [f"== {name}: gens {gens}"]
    breakers = []
    st, Q = dyadic(gens)
    lines.append(f"  dyadic: {st}" + (f", residue F_{Q}, target U_{Q} (ratio >= 1/4: U_Q 4-colourable for Q <= 32; ramified: 1/2)" if Q else ""))
    if st == "inert" and Q <= 32:
        breakers.append(f"dyadic inert U_{Q}")
    if st == "ramified":
        breakers.append("dyadic ramified (row 100's exception)")
    stable = []
    for p in [x for x in range(3, bound) if all(x % d for d in range(2, int(x ** 0.5) + 1))]:
        e, f = residue_degree(gens, p)
        is_stable = (p % 4 == 3) and (f == 1)
        if PLANT == "f-even-stable":
            is_stable = (p % 4 == 3)
        if is_stable:
            stable.append((p, e))
            if p in (3, 7):
                breakers.append(f"stable {p} (Gamma_{p}: ratio {'1/3' if p == 3 else '2/7'} >= 1/4)")
    lines.append(f"  stable odd places below {bound} (p, e): {stable}")
    inclass = not breakers
    lines.append(f"  breakers: {breakers if breakers else 'none'}")
    lines.append(f"  T-C(A)@0 class: {inclass};  L(F) >= 5: {inclass}")
    return inclass, lines


def main():
    cases = [
        ("K = Q(sqrt3, sqrt11)", [3, 11], False),
        ("Q(sqrt2, sqrt3)", [2, 3], False),
        ("Q(sqrt11)", [11], False),
        ("Q(sqrt23)", [23], False),
        ("Q(sqrt47)", [47], True),
        ("Q(sqrt3, sqrt5)", [3, 5], True),
        # known-positive controls (chi >= 5 known unconditionally): Heule-510's field K(sqrt5), and K(sqrt7) (rho_63 arena, row 64)
        ("K(sqrt5) = Q(sqrt3, sqrt5, sqrt11)", [3, 5, 11], True),
        ("K(sqrt7) = Q(sqrt3, sqrt7, sqrt11)", [3, 7, 11], True),
    ]
    ok = True
    for name, gens, want in cases:
        got, lines = field_report(name, gens)
        print("\n".join(lines))
        print(f"  expected class {want}: {'PASS' if got == want else 'FAIL'}")
        ok &= (got == want)
    # the quadratic family cross-check (row 117): class <=> d = 47, 143, 167 mod 168, squarefree d < 2000
    bad = []
    for d in range(2, 2000):
        if squarefree_part(d) != d:
            continue
        got, _ = field_report(str(d), [d])
        want = d % 168 in (47, 143, 167)
        if got != want:
            bad.append(d)
    print(f"row 117 cross-check, squarefree d < 2000: mismatches {bad[:10]} ({len(bad)})")
    ok &= not bad
    print("ALL PASS" if ok else "A CHECK FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
