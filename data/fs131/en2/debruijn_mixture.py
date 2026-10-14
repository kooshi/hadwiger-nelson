#!/usr/bin/env python3
"""FS131-EN2, entry EN2-MEAN-RATE: the one enumerated fact under the example.

For each order d given (default 2 4 8) build a binary de Bruijn word of order d (the concatenation of the
Lyndon words whose length divides d, in lexicographic order) and count, over its P = 2^d cyclic windows:
  for n = 1..d     every binary word of length n occurs exactly 2^(d-n) times  (so the n-marginal of the
                   uniform measure on the cyclic shifts is uniform, H_n = n log 2);
  for n = d..d+2   the P windows are pairwise distinct                         (so H_n = d log 2).
Prints one line per d:  d  P  <number of n at which the derived profile fails>.   Expect the last column 0.
--plant: flip one letter of the word first (the profile must then fail at some n)."""
import sys
from collections import Counter


def de_bruijn(d):
    seq, a = [], [0] * (d + 1)

    def db(t, p):
        if t > d:
            if d % p == 0:
                seq.extend(a[1:p + 1])
        else:
            a[t] = a[t - p]
            db(t + 1, p)
            for j in range(a[t - p] + 1, 2):
                a[t] = j
                db(t + 1, t)
    db(1, 1)
    return seq


plant = "--plant" in sys.argv
orders = [int(x) for x in sys.argv[1:] if x.isdigit()] or [2, 4, 8]
for d in orders:
    w = de_bruijn(d)
    P = len(w)
    if plant:
        w[P // 2] ^= 1
    bad = 0
    for n in range(1, d + 3):
        c = Counter(tuple(w[(i + j) % P] for j in range(n)) for i in range(P))
        if n <= d:
            ok = len(c) == 2 ** n and set(c.values()) == {2 ** (d - n)}
        else:
            ok = len(c) == P
        if n == d:
            ok = ok and len(c) == P
        bad += not ok
    print(d, P, bad)
