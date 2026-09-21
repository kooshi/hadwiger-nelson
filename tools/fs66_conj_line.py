#!/usr/bin/env python3
"""FS-66 conjecture note, falsifier for Lemma W (the weighted form of the conjecture is false).
The set I = {(a, b) in (Z/p^2)^2 : b = 0 mod p, a even as an integer in [0, p^2-3]} is independent in UD(Z/p^2, 2); its
fibre shares live on the single-direction line {(j,0)} of G_1 (an induced p-cycle, alpha = (p-1)/2) and sum to
(p^2-1)/(2p) > (p-1)/2.  Exact integers.  Usage: fs66_conj_line.py P"""
import sys
from fractions import Fraction
p = int(sys.argv[1]); q = p*p
S2 = [(a, b) for a in range(q) for b in range(q) if (a*a + b*b) % q == 1]
assert len(S2) == p*(p+1)
I = {(a, b) for a in range(0, q-2, 2) for b in range(0, q, p)}
bad = [(z, s) for z in I for s in S2 if ((z[0]+s[0]) % q, (z[1]+s[1]) % q) in I]
assert not bad, bad[:3]
share = {}
for (a, b) in I: share[(a % p, b % p)] = share.get((a % p, b % p), 0) + 1
assert all(x[1] == 0 for x in share)
line = [(j, 0) for j in range(p)]
S1 = {(a % p, b % p) for (a, b) in S2}
ind_edges = [(x, y) for x in line for y in line if ((y[0]-x[0]) % p, (y[1]-x[1]) % p) in S1]
assert len(ind_edges) == 2*p, "the line is not an induced p-cycle"
tot = sum(Fraction(v, q) for v in share.values())
print(f"p={p}: |I| = {len(I)} independent in UD(Z/{q},2) [checked against all {len(S2)} unit vectors];")
print(f"  fibre shares on the line: {sorted(set(Fraction(v, q) for v in share.values()))}; sum = {tot} = (p^2-1)/(2p) = {Fraction(q-1, 2*p)}")
print(f"  alpha of the induced {p}-cycle = {(p-1)//2};  excess = {tot - (p-1)//2} = (p-1)/(2p)")
assert tot == Fraction(q-1, 2*p)
