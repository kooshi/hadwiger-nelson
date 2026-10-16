#!/usr/bin/env python3
"""FS131-ICS1 — the family's census by exact arithmetic: the squarefree d <= N with d = 47, 143, 167 (mod 168), and which of
them `SqrtFiveClass.chromaticNumber_planeOver_sqrt_eq_five` reaches (d a square, zero included, modulo 11 or modulo 19).
Compared with the ledger's "44 of the 52 with d <= 3000" (row 123). --plant drops the zero case of the square test and
requires the count to change (47*11... members divisible by 11 or 19 are reached only through the zero case)."""
import sys

def squarefree(n):
    d = 2
    while d * d <= n:
        if n % (d * d) == 0:
            return False
        d += 1
    return True

def is_sq(a, p, zero=True):
    a %= p
    if a == 0:
        return zero
    return any((x * x) % p == a for x in range(1, p))

def main():
    plant = "--plant" in sys.argv
    N = 3000
    cls = [d for d in range(1, N + 1) if d % 168 in (47, 143, 167) and squarefree(d)]
    reached = [d for d in cls if is_sq(d, 11, not plant) or is_sq(d, 19, not plant)]
    rest = [d for d in cls if d not in reached]
    print(f"class members, squarefree, d <= {N}: {len(cls)}")
    print(f"reached (a square, zero {'excluded (PLANT)' if plant else 'included'}, mod 11 or mod 19): {len(reached)}")
    print(f"not reached: {len(rest)}: {rest}")
    ok = (len(cls), len(reached)) == (52, 44)
    print("MATCHES the ledger's 44 of 52" if ok else "DIFFERS from the ledger's 44 of 52")
    return 0 if ok else 1

if __name__ == "__main__":
    sys.exit(main())
