# independent rebuild of mu_{Q+1} in F_{Q^2} by carry-less arithmetic (no exp table), for Q = 64 and 128
import numpy as np, sys, random, time
def clmul(a, b, m2, poly):
    r = 0
    while b:
        if b & 1: r ^= a
        b >>= 1; a <<= 1
        if a >> m2: a ^= poly
    return r
def power(x, e, m2, poly):
    r = 1
    while e:
        if e & 1: r = clmul(r, x, m2, poly)
        x = clmul(x, x, m2, poly); e >>= 1
    return r
def irreducible(m2, poly):  # x^(2^m2) = x mod poly and gcd conditions via order of x dividing 2^m2-1 with no smaller subfield
    x = 2
    y = x
    for _ in range(m2): y = clmul(y, y, m2, poly)
    if y != x: return False
    for d in range(1, m2):
        if m2 % d == 0:
            z = x
            for _ in range(d): z = clmul(z, z, m2, poly)
            if z == x: return False
    return True
for m2, Q in ((12, 64), (14, 128)):
    poly = next((1 << m2) | low for low in range(3, 1 << m2, 2) if bin(low).count("1") in (2, 4) and irreducible(m2, (1 << m2) | low)) if True else None
    n = 1 << m2
    mu = [x for x in range(1, n) if power(x, Q + 1, m2, poly) == 1]
    assert len(mu) == Q + 1, len(mu)
    # mu_3 inside: check a triangle exists (1, w, w^2 with 1+w+w^2 = 0)
    if (Q + 1) % 3 == 0:
        w = next(x for x in mu if x != 1 and power(x, 3, m2, poly) == 1)
        assert 1 ^ w ^ clmul(w, w, m2, poly) == 0, "mu_3 must close a triangle"
    a = np.arange(n, dtype=np.int64); ev = np.zeros(n, dtype=np.int64)
    for u in mu:
        v = a & u; par = np.zeros(n, dtype=np.int64)
        while v.any(): par ^= v & 1; v >>= 1
        ev += 1 - 2 * par
    lmin = int(ev[1:].min())
    print(f"Q={Q} (poly {bin(poly)}): degree {Q+1}, lambda_min {lmin}, Hoffman chi >= {1 + (Q+1)/(-lmin):.3f}, alpha <= {n*(-lmin)/(Q+1-lmin):.1f}", flush=True)
    np.save(f"data/fs54/char2/mu{Q}.npy", np.array(mu)); open(f"data/fs54/char2/poly{Q}.txt", "w").write(str(poly))
