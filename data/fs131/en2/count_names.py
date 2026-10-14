#!/usr/bin/env python3
"""FS131-EN2, entry EN2-CNT: the counting lemma's three steps, by complete enumeration of small cases.

Alphabet {0,1} (a = 2); block length k; a set G of "good" words of length k; theta = p/q; length n.
W = the words w of length n with  #{0 <= j <= n-k : w[j:j+k] not in G} <= theta*n.
Steps checked, for every case of the fixed grid below:
  (i)   for EVERY word of length n, the greedy parse (take a block at j when w[j:j+k] is in G and j <= n-k,
        else a single letter) has  #singles <= #bad starts + k - 1;
  (ii)  #W <= sum over s <= floor(theta*n) + k - 1 of N(n, s), N(n, s) the number of token sequences of total
        length n with exactly s single letters (N(n,s) = a N(n-1,s-1) + #G N(n-k,s));
  (iii) with g = max(#G, 2):  #W <= (2a)^(theta*n + k) * g^(2n/k), compared as integers after raising both
        sides to the power k*q.
Prints: <violations of (i)> <of (ii)> <of (iii)> <cases>.   Expect 0 0 0 and the number of cases.
--plant: in (iii) drop the factor (2a)^(theta*n + k) (the bound must then fail somewhere)."""
import sys
from itertools import product

plant = "--plant" in sys.argv
a = 2
grids = [(2, ["00"]), (2, ["00", "11"]), (3, ["000"]), (3, ["000", "111", "010"]), (3, ["001", "010", "100", "111", "000"])]
thetas = [(1, 10), (3, 10), (1, 2), (9, 10)]
v1 = v2 = v3 = cases = 0
for k, G in grids:
    Gs = set(G)
    g = max(len(Gs), 2)
    for n in range(k, 14):
        words = ["".join(t) for t in product("01", repeat=n)]
        badstarts = {}
        for w in words:
            b = sum(w[j:j + k] not in Gs for j in range(n - k + 1))
            badstarts[w] = b
            j = s = 0
            while j < n:
                if j <= n - k and w[j:j + k] in Gs:
                    j += k
                else:
                    s += 1
                    j += 1
            v1 += s > b + k - 1
        # N[m][s]
        N = [[0] * (n + 1) for _ in range(n + 1)]
        N[0][0] = 1
        for m in range(1, n + 1):
            for s in range(0, m + 1):
                N[m][s] = (a * N[m - 1][s - 1] if s >= 1 else 0) + (len(Gs) * N[m - k][s] if m >= k else 0)
        for p, q in thetas:
            cases += 1
            W = sum(1 for w in words if q * badstarts[w] <= p * n)
            cap = (p * n) // q + k - 1
            v2 += W > sum(N[n][s] for s in range(0, min(cap, n) + 1))
            lhs = W ** (k * q)
            rhs = g ** (2 * n * q) * (1 if plant else (2 * a) ** (k * (p * n + k * q)))
            v3 += lhs > rhs
print(v1, v2, v3, cases)
