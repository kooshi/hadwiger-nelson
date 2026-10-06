#!/usr/bin/env python3
"""FS131-K10: the period polynomial of E7 (the degree-7 subfield of Q(zeta_29)), exactly, and the finite facts the plan's route reads.

g(x) = prod over the seven cosets c of H = {1,12,17,28} in (Z/29)^x of (x - eta_c), eta_c = sum_{h in H} zeta^{ch}, computed in
Z[zeta]/(1 + zeta + ... + zeta^28) by exact integer arithmetic on vectors of length 29 (cyclic convolution), then reduced.
Checks: g is monic of degree 7 with integer coefficients; g is irreducible mod 2 and mod 7 (no factor of degree <= 3, by exhaustive
division); for every prime p < 347 with p = 3 (mod 4): not (g has a root mod p and 3, 11 are squares mod p); at p = 347 all three hold.
`--fault` replaces H by {1,12,17,27} (not a subgroup) and must fail.
"""
import sys
from itertools import product

def conv(a, b):
    c = [0] * 29
    for i, x in enumerate(a):
        if x:
            for j, y in enumerate(b):
                if y: c[(i + j) % 29] += x * y
    return c

def reduce_const(v):
    # modulo 1 + z + ... + z^28: subtract v[1] times the all-ones vector; a rational integer iff the rest vanishes
    w = [x - v[1] for x in v]
    return w[0] if all(x == 0 for x in w[1:]) else None

def polymul(P, Q):  # polynomials in x with vector coefficients, low degree first
    R = [[0] * 29 for _ in range(len(P) + len(Q) - 1)]
    for i, a in enumerate(P):
        for j, b in enumerate(Q):
            c = conv(a, b)
            R[i + j] = [u + v for u, v in zip(R[i + j], c)]
    return R

def divides_mod(f, g, p):  # does monic f divide g mod p (lists low degree first)
    g = [c % p for c in g]
    while len(g) >= len(f):
        lead = g[-1]
        if lead:
            for i in range(len(f)):
                g[len(g) - len(f) + i] = (g[len(g) - len(f) + i] - lead * f[i]) % p
        g.pop()
    return all(c == 0 for c in g)

def irreducible_mod(g, p):
    for d in (1, 2, 3):
        for tail in product(range(p), repeat=d):
            if divides_mod(list(tail) + [1], g, p): return False
    return True

def is_prime(n):
    return n > 1 and all(n % i for i in range(2, int(n ** 0.5) + 1))

def main():
    H = [1, 12, 17, 27] if '--fault' in sys.argv else [1, 12, 17, 28]
    one = [1] + [0] * 28
    seen, cosets = set(), []
    for c in range(1, 29):
        if c in seen: continue
        co = sorted({(c * h) % 29 for h in H}); seen |= set(co); cosets.append(co)
    P = [one]
    for co in cosets[:7]:
        eta = [0] * 29
        for k in co: eta[k] += 1
        P = polymul(P, [[-x for x in eta], one])
    coeffs = [reduce_const(v) for v in P]
    print('cosets:', len(cosets), ' g (low degree first):', coeffs)
    ok = len(cosets) == 7 and None not in coeffs and len(coeffs) == 8 and coeffs[-1] == 1
    if ok:
        g = coeffs
        root = lambda p: any(sum(c * pow(x, i, p) for i, c in enumerate(g)) % p == 0 for x in range(p))
        sq = lambda a, p: any((x * x - a) % p == 0 for x in range(p))
        irr2, irr7 = irreducible_mod(g, 2), irreducible_mod(g, 7)
        bad = [p for p in range(3, 347) if is_prime(p) and p % 4 == 3 and root(p) and sq(3, p) and sq(11, p)]
        at347 = root(347) and sq(3, 347) and sq(11, 347)
        print('irreducible mod 2:', irr2, ' mod 7:', irr7, ' primes < 347 with a usable degree-one place:', bad, ' at 347:', at347)
        ok = irr2 and irr7 and not bad and at347 and g == [1, -9, 14, 28, -7, -12, 1, 1]
    print('CHECK:', 'PASS' if ok else 'FAIL')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main())
