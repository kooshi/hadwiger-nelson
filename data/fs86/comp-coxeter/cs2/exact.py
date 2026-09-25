"""Exact tightness check: every eigenvalue lambda_chi = sum_{s in S_m} chi(s) satisfies lambda >= -|S|/3, equality decided
exactly in Q(zeta_{2^K}) (basis zeta^j, 0 <= j < 2^{K-1}); counts the minimisers.  Uses tower.setup."""
import sys, itertools
import numpy as np
from sympy import Matrix, ilcm
from tower import setup

def build(n, m):
    d, mul, power_x, conj = setup(n)
    e = 2 if n == 12 else 4
    one = [1]+[0]*(d-1)
    zeta = power_x(n//8) if n % 8 == 0 else power_x(n//4)
    pi = [one[j]-zeta[j] for j in range(d)]
    omega = power_x(n//3)
    k = -(-m//e)
    def ppow(t):
        r = one
        for _ in range(t): r = mul(r, pi)
        return r
    shift = ppow(e*k - m)
    in_Pm = lambda y: all(c % (2**k) == 0 for c in mul(y, shift))
    pis = [ppow(j) for j in range(m)]
    digs = [[0]*d, one, omega, [one[t]+omega[t] for t in range(d)]]
    reps = []
    for choice in itertools.product(range(4), repeat=m):
        v = [0]*d
        for j,c in enumerate(choice):
            if c:
                t = mul(pis[j], digs[c]); v = [v[q]+t[q] for q in range(d)]
        reps.append(v)
    S = [r for r in reps if in_Pm([a-b for a,b in zip(mul(r, conj(r)), one)])]
    B = Matrix([mul(ppow(m), power_x(i)) for i in range(d)]).T
    Binv = B.inv()
    den = int(ilcm(*[x.q for x in Binv]))
    G = np.array([[int(x*den) % den for x in Binv.row(i)] for i in range(d)], dtype=np.int64)  # generators of M*/Z^d, scaled by den
    return d, S, G, den

def check(n, m):
    d, S, G, den = build(n, m)
    K = den.bit_length()-1; assert 2**K == den
    # enumerate M*/Z^d as integer vectors mod den
    seen = {tuple([0]*d)}; fr = [tuple([0]*d)]
    while fr:
        nf = []
        for g in fr:
            for h in G:
                s = tuple((a+b) % den for a,b in zip(g,h))
                if s not in seen: seen.add(s); nf.append(s)
        fr = nf
    C = np.array(sorted(seen), dtype=np.int64)
    assert len(C) == 4**m
    Sa = np.array(S, dtype=np.int64)
    ph = (C @ Sa.T) % den                       # exact phases j/den
    half = den//2
    # canonical coefficients c_j = n_j - n_{j+half}, j < half
    cnt = np.zeros((len(C), den), dtype=np.int64)
    rows = np.repeat(np.arange(len(C)), Sa.shape[0])
    np.add.at(cnt, (rows, ph.ravel()), 1)
    can = cnt[:, :half] - cnt[:, half:]
    target = np.zeros(half, dtype=np.int64); s3 = len(S)//3; assert 3*s3 == len(S); target[0] = -s3
    is_min = np.all(can == target, axis=1)
    lam = (cnt * np.cos(2*np.pi*np.arange(den)/den)).sum(axis=1)
    gaps = lam + s3
    nonmin_gap = gaps[~is_min].min()
    return len(S), int(is_min.sum()), float(nonmin_gap), den

if __name__ == '__main__':
    n = int(sys.argv[1])
    for m in range(1, int(sys.argv[2])+1):
        s, nmin, g, den = check(n, m)
        print(f"n={n} m={m} |S|={s} exact minimisers (lambda = -|S|/3 in Q(zeta_{den})): {nmin}; smallest other gap lambda+|S|/3 = {g:.6f}", flush=True)
