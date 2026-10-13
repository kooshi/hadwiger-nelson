#!/usr/bin/env python3
"""FS131-ER1: exact checks behind Stage 3 (the recognition) and Stage 5 (the sentence modulo 168).

Modes (each prints one line; integer arithmetic only):
  filter C for Q in 2..8, K in 1..3, q = Q!, n = 4 q^(2K) - C ([Davies2026] Lemma 5.1's theta^2 is C = 1): the number
           of (Q, K, p), p prime <= Q, at which n is NOT congruent to -1 modulo p (and modulo 16 when p = 2).
  classes Q1,Q2  for Q in the list, K in 1..2: how many residues modulo 168 of the squarefree part of n lie outside
           {47, 143, 167}, then the sorted set of those residues;
           n = 4 q^(2K) - 1 (the lemma's fields from Q = 7 on are Q1,Q2 = 7,8).
  small    the squarefree part of n at (Q, K) = (2,1), (3,1), (4,1).
  cover A,B,C [fwd|conv]  for squarefree n in 2..20000 (one direction, or both when omitted): the number of n at which "none of the three printed four-colourings applies"
           disagrees with "n = A, B or C modulo 168" (the paper's classes are 47,143,167).  The three: n != 3 mod 4 (two colours); n = 3 mod 8 (four,
           additive); n = 0 or 1 mod 3 (three); n zero or a square modulo 7 (the plane at 7, four).
  nonsqf N the residue of N modulo 168, and of its squarefree part (423 = 9 * 47 gives 87 47).
  field N  N modulo 168 (row 128's field: 635087).
"""
import sys
from math import factorial

def primes_upto(m):
    return [p for p in range(2, m + 1) if all(p % d for d in range(2, int(p ** 0.5) + 1))]

def squarefree_part(n):
    m, d = 1, 2
    while d * d <= n:
        e = 0
        while n % d == 0:
            n //= d; e += 1
        if e % 2: m *= d
        d += 1
    return m * n

def is_squarefree(n):
    d = 2
    while d * d <= n:
        if n % (d * d) == 0: return False
        d += 1
    return True

mode = sys.argv[1]
if mode == "filter":
    bad = 0
    for Q in range(2, 9):
        for K in range(1, 4):
            n = 4 * factorial(Q) ** (2 * K) - int(sys.argv[2])
            for p in primes_upto(Q):
                if (n + 1) % p: bad += 1
                if p == 2 and n % 16 != 15: bad += 1
    print(bad)
elif mode == "classes":
    out = set()
    for Q in [int(x) for x in sys.argv[2].split(',')]:
        for K in (1, 2):
            q = factorial(Q) ** K
            out.add((squarefree_part(2 * q - 1) * squarefree_part(2 * q + 1)) % 168)  # 2q-1, 2q+1 coprime
    print(len(out - {47, 143, 167}), sorted(out))
elif mode == "small":
    print([squarefree_part(4 * factorial(Q) ** 2 - 1) for Q in (2, 3, 4)])
elif mode == "cover":
    CLASSES = {int(x) for x in sys.argv[2].split(',')}
    bad = 0
    for n in range(2, 20001):
        if not is_squarefree(n): continue
        covered = (n % 4 != 3) or (n % 8 == 3) or (n % 3 in (0, 1)) or (n % 7 in (0, 1, 2, 4))
        inc = n % 168 in CLASSES
        d = sys.argv[3] if len(sys.argv) > 3 else 'both'
        if d in ('fwd', 'both') and (not covered) and (not inc): bad += 1   # none holds, yet outside the classes
        if d in ('conv', 'both') and covered and inc: bad += 1              # in a class, yet some condition holds
    print(bad)
elif mode == "nonsqf":
    n = int(sys.argv[2])
    print(n % 168, squarefree_part(n) % 168)
elif mode == "field":
    print(int(sys.argv[2]) % 168)
