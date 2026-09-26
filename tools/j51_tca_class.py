#!/usr/bin/env python3
"""J51 (FS-100 planner): which real quadratic fields sit in T-C(A)'s class?

T-C(A)'s class (plans/R88-derivation.md, R88-TCA, J28D's class form): "every real field whose stable places all have
all-levels ratio < 1/4". The derivation in plans/FS100-three-field-lemma.md §1.4 fixes the finite set that decides it:
at a stable odd place with residue F_p the all-levels four-colour ratio is < 1/4 unless p in {3, 7} (11, 19: FS-66
certificates, every level by Lemma P (ii); 23, 31: Hoffman; p >= 37: Weil + Hoffman + Lemma P), and a stable dyadic place
has ratio >= 1/4 (tight at 1/4, row 67, or ramified in L/F). So only p in {2, 3, 7} can exclude a field.

This script is exact (integer arithmetic only): it lists each field's stable places up to a bound, applies the rule, and
checks the derived congruence form "in class <=> d = 47, 143, 167 (mod 168)" over every squarefree d up to a bound.

Plant (--plant): a wrong 2-adic square test (u = 1 mod 4 instead of mod 8), which calls d = 3 (mod 8) dyadic-split and
must move Q(sqrt 59) into the class; the script exits non-zero if the plant does not fire.
"""
import sys

PLANT = "--plant" in sys.argv


def is_squarefree(n):
    k = 2
    while k * k <= n:
        if n % (k * k) == 0:
            return False
        k += 1
    return True


def primes_upto(n):
    s = [True] * (n + 1)
    s[0] = s[1] = False
    for i in range(2, int(n ** 0.5) + 1):
        if s[i]:
            s[i * i::i] = [False] * len(s[i * i::i])
    return [i for i in range(n + 1) if s[i]]


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def is_2adic_square(n):
    """n a nonzero integer: a square in Q_2 iff v_2(n) even and the odd part = 1 (mod 8)."""
    if n == 0:
        return True
    v = 0
    while n % 2 == 0:
        n //= 2
        v += 1
    if v % 2:
        return False
    return (n % 4 == 1) if PLANT else (n % 8 == 1)


def stable_places(d, bound):
    """Stable places of Q(sqrt d), d > 1 squarefree: list of (p, kind, residue size)."""
    out = []
    # dyadic: v is non-stable iff i in F_v iff -d is a 2-adic square (d not a square)
    if not is_2adic_square(-d):
        kind = "split" if d % 8 == 1 else ("inert" if d % 8 == 5 else "ramified")
        out.append((2, kind, None))
    for p in primes_upto(bound)[1:]:
        if d % p == 0:
            if p % 4 == 3:
                out.append((p, "ramified", p))
        elif legendre(d, p) == 1:
            if p % 4 == 3:
                out.append((p, "split", p))
        # inert: residue field F_{p^2}, q = 1 (mod 4): never stable
    return out


def bad_places(d, bound=400):
    """Stable places whose all-levels ratio is >= 1/4, by the derived rule."""
    return [(p, k) for (p, k, q) in stable_places(d, bound) if p in (2, 3, 7)]


def local_bound(d, bound=400):
    ps = {p for (p, _, _) in stable_places(d, bound)}
    if 2 in ps:
        return "<=4"
    if 3 in ps:
        return "3"
    if 7 in ps:
        return "4"
    if 11 in ps or 19 in ps:
        return "5"
    return ">=6"


def main():
    rows = [(47, True, "control"), (143, None, "target"), (311, None, "target"), (335, None, "target"),
            (167, None, "side"), (59, False, "control"), (11, False, "control")]
    ok = True
    print("field      stable places (p<=100)                                  bad    in-class  L")
    verdict = {}
    for d, must, role in rows:
        sp = [(p, k) for (p, k, _) in stable_places(d, 100)]
        bad = bad_places(d)
        inc = not bad
        verdict[d] = inc
        print(f"Q(sqrt{d:<4}) {str(sp)[:62]:<62} {str(bad):<6} {inc!s:<9} {local_bound(d)}  [{role}]")
        if must is not None and inc != must:
            print(f"  CONTROL FAILED at d={d}: expected {must}")
            ok = False
    # the derived congruence form, over every squarefree d <= 5000
    mism = [d for d in range(2, 5001) if is_squarefree(d)
            and ((not bad_places(d, 10)) != (d % 168 in (47, 143, 167)))]
    print(f"congruence form d = 47,143,167 (mod 168) <=> in class: mismatches over squarefree d<=5000: {len(mism)}"
          + (f" first {mism[:5]}" if mism else ""))
    if mism:
        ok = False
    if PLANT:
        fired = verdict.get(59) is True or not ok
        print("PLANT", "FIRED" if fired else "DID NOT FIRE")
        sys.exit(0 if fired else 2)
    print("ALL CHECKS PASS" if ok else "FAILURE")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
