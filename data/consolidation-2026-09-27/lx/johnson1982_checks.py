#!/usr/bin/env python3
"""Job LX, stage 2: exact checks of three statements read in [Johnson1982] (Discrete Math. 40 (1982) 219-223).

1. Corollary 3's relation in Q^4 (p. 221): 3*[(1,1,3,5)/6] - 1*[(1,1,1,1)/2] - (0,0,1,0) - 2*(0,0,0,1) = 0, every term a unit
   vector, coefficient sum 3 - 1 - 1 - 2 odd.
2. Corollary 2's set K = {p/q : p, q positive integers, p + q odd} (p. 220) is, on the positive rationals, exactly {s : v2(s) != 0}.
3. The reach of his Theorem for n >= 3: a colouring by a homomorphism psi with psi = 1 on S (S weakly n-free) maps the graph into
   Cay(Z/n, {+1, -1}), the n-cycle, which has no K4 for any n >= 3 -- so the Theorem never 4-colours a graph containing K4 (the unit
   tetrahedron of Q^4, for instance), and never colours a graph of chromatic number >= 4 at all (C_n is 2- or 3-chromatic).
Exits non-zero on failure; a planted wrong coefficient must break check 1.
"""
from fractions import Fraction as F
from itertools import combinations
import sys

fails = []


def check(c, m):
    if not c:
        fails.append(m)
        print("FAIL:", m)


def N(x):
    return sum(c * c for c in x)


terms = [(3, tuple(F(c, 6) for c in (1, 1, 3, 5))), (-1, tuple(F(c, 2) for c in (1, 1, 1, 1))),
         (-1, (F(0), F(0), F(1), F(0))), (-2, (F(0), F(0), F(0), F(1)))]


def total(ts):
    return tuple(sum(m * x[i] for m, x in ts) for i in range(4))


check(all(N(x) == 1 for _, x in terms), "every term a unit vector")
check(total(terms) == (0, 0, 0, 0), "the relation sums to zero")
check(sum(m for m, _ in terms) % 2 == 1, "coefficient sum odd")
planted = [(2, terms[0][1])] + terms[1:]
check(total(planted) != (0, 0, 0, 0), "planted coefficient 2 breaks the relation")


def v2(s):
    n, d, v = s.numerator, s.denominator, 0
    while n % 2 == 0:
        n //= 2; v += 1
    while d % 2 == 0:
        d //= 2; v -= 1
    return v


K = {F(p, q) for p in range(1, 60) for q in range(1, 60) if (p + q) % 2 == 1}
sample = {F(p, q) for p in range(1, 30) for q in range(1, 30)}
check(all((s in K) == (v2(s) != 0) for s in sample), "K = {v2(s) != 0} on p, q < 30")

for n in range(3, 40):
    adj = lambda a, b: (a - b) % n in (1, n - 1)
    has_k4 = any(all(adj(a, b) for a, b in combinations(q, 2)) for q in combinations(range(n), 4))
    check(not has_k4, "C_%d has no K4" % n)

print("checks:", "PASS" if not fails else "FAIL (%d)" % len(fails))
sys.exit(1 if fails else 0)
