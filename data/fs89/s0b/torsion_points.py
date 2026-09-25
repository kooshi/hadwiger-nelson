"""Exact list of the torsion characters of R5 = Z[i][1/5] in Theta_4(U5) of order N <= NMAX (5 does not divide N):
characters x + yi -> (a x + b y)/N of Z[i]/N, band [1/4, 3/4] on the image of U5 = <i, w> in (Z[i]/N)^x.
Prints, per primitive order, the count and the margins (the archimedean disc radius of each leaf: r = least distance of
a value to the band's edge).  Finite and exact; not a search for a witness (it lists a fixed finite set per N)."""
import sys
from fractions import Fraction as Fr
from math import gcd

def units_image(N):
    inv5 = pow(5, -1, N) if N > 1 else 0
    w = ((3 * inv5) % N, (4 * inv5) % N)
    def mul(p, q):
        return ((p[0]*q[0] - p[1]*q[1]) % N, (p[0]*q[1] + p[1]*q[0]) % N)
    S, frontier = {(1 % N, 0)}, [(1 % N, 0)]
    gens = [(0, 1 % N), w]
    while frontier:
        new = []
        for s in frontier:
            for g in gens:
                t = mul(s, g)
                if t not in S:
                    S.add(t); new.append(t)
        frontier = new
    return S

NMAX = int(sys.argv[1]) if len(sys.argv) > 1 else 40
total = 0
for N in range(2, NMAX + 1):
    if N % 5 == 0:
        continue
    S = units_image(N)
    found = []
    for a in range(N):
        for b in range(N):
            if gcd(gcd(a, b), N) != 1:
                continue  # not primitive of order N
            ok = True
            for x, y in S:                     # integer test: N <= 4*((a x + b y) mod N) <= 3N
                t = 4 * ((a*x + b*y) % N)
                if t < N or t > 3 * N:
                    ok = False
                    break
            if ok:
                vals = [Fr((a*x + b*y) % N, N) for x, y in S]
                r = min(min(v - Fr(1,4), Fr(3,4) - v) for v in vals)
                found.append(((a, b), r))
    if found:
        total += len(found)
        rs = sorted(set(r for _, r in found))
        print(f"N={N:3d}  |U5 mod N|={len(S):4d}  characters in band: {len(found):3d}  margins {[str(r) for r in rs]}  e.g. {found[0][0]}")
print("total primitive torsion characters found up to N =", NMAX, ":", total)
