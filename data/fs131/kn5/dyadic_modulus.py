#!/usr/bin/env python3
"""FS131-KN5 stage 5: the least modulus at which each shape lemma is a finite statement.

For a class and a modulus M in {4, 8, 16}: does 'Q1 = 0 and Q2 = 0 (mod M), not all even => claim' hold for every
(a, b, c, d, N) mod M and every residue of m mod M in the class?  (claim reads residues mod 4; dyadic_check.claim.)
For class C also: the same at M = 8 with the all-odd quadruples (a, b, c, d) left out, and at M = 16 on the all-odd
quadruples alone - the split a proof by `decide` would use.
Prints one line per question with the number of cases satisfying the hypotheses and the number of failures.
Control: class C at M = 8 with nothing left out must FAIL (the all-odd quadruples need 16); exit 1 if it passes.
"""
import sys
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from dyadic_check import claim, CLASSES


def run(cls, M, keep=lambda a, b, c, d: True):
    mod, residues = CLASSES[cls]
    seen = bad = 0
    for m in range(M):
        if m % mod not in residues:
            continue
        for a in range(M):
            for b in range(M):
                for c in range(M):
                    for d in range(M):
                        if not keep(a, b, c, d) or (a * b + c * d) % M:
                            continue
                        s = a * a + c * c + m * (b * b + d * d)
                        for N in range(M):
                            if (s - N * N) % M:
                                continue
                            if all(x % 2 == 0 for x in (a, b, c, d, N)):
                                continue
                            seen += 1
                            bad += not claim(cls, a, b, c, d, N)
    return seen, bad


allodd = lambda a, b, c, d: a % 2 == b % 2 == c % 2 == d % 2 == 1
ok = True
for cls in "ABC":
    for M in (4, 8, 16):
        if cls == "C" and M == 4:
            continue  # the class is defined modulo 8
        seen, bad = run(cls, M)
        print(f"class {cls} mod {M:2d}: cases {seen:6d} failures {bad}")
seen, bad = run("C", 8, lambda a, b, c, d: not allodd(a, b, c, d))
print(f"class C mod  8, all-odd quadruples left out: cases {seen} failures {bad}"); ok &= bad == 0 and seen > 0
seen, bad = run("C", 16, allodd)
print(f"class C mod 16, all-odd quadruples only:     cases {seen} failures {bad}  (0 cases = the pattern is impossible)")
ok &= bad == 0
seen, bad = run("C", 8)
print(f"control, class C mod 8 with nothing left out: failures {bad} (must be > 0)"); ok &= bad > 0
sys.exit(0 if ok else 1)
