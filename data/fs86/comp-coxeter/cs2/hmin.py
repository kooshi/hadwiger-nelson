"""Common kernel H_min of the level-4 minimisers in O/P^4, for n = 12 (control: trivial, FS38-D2-B) and n = 24."""
import sys, itertools
import numpy as np
from exact import build
for n in (12, 24):
    m = 4
    d, S, G, den = build(n, m)
    seen = {tuple([0]*d)}; fr = [tuple([0]*d)]
    while fr:
        nf = []
        for g in fr:
            for h in G:
                s = tuple((a+b) % den for a,b in zip(g,h))
                if s not in seen: seen.add(s); nf.append(s)
        fr = nf
    C = np.array(sorted(seen), dtype=np.int64)
    Sa = np.array(S, dtype=np.int64)
    ph = (C @ Sa.T) % den
    lam = np.cos(2*np.pi*ph/den).sum(axis=1)
    mins = C[np.abs(lam + len(S)/3) < 1e-9]
    # vertices of O/P^4: all reps; kernel = reps y with mins @ y = 0 mod den
    from tower import setup
    d2, mul, power_x, conj = setup(n)
    e = 2 if n == 12 else 4
    one = [1]+[0]*(d-1)
    zeta = power_x(n//8) if n % 8 == 0 else power_x(n//4)
    pi = [one[j]-zeta[j] for j in range(d)]; omega = power_x(n//3)
    def ppow(t):
        r = one
        for _ in range(t): r = mul(r, pi)
        return r
    pis = [ppow(j) for j in range(m)]
    digs = [[0]*d, one, omega, [one[t]+omega[t] for t in range(d)]]
    ker = 0
    for choice in itertools.product(range(4), repeat=m):
        v = [0]*d
        for j,c in enumerate(choice):
            if c:
                t = mul(pis[j], digs[c]); v = [v[q]+t[q] for q in range(d)]
        if np.all((mins @ np.array(v, dtype=np.int64)) % den == 0): ker += 1
    print(f"n={n}: {len(mins)} minimisers at level 4; |H_min| = {ker} (1 means trivial common kernel)")
