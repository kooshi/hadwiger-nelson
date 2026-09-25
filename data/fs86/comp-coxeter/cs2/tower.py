"""Exact dyadic tower of a cyclotomic field Q(zeta_n) (n = 12 or 24) whose unique prime P above 2 is inert/unramified
over the real subfield: vertices O/P^m, connection set S_m = {x : x*conj(x) = 1 mod P^m}; spectrum of Cay(O/P^m, S_m).
Control: n = 12 is row 67's tower (tight at levels 1-8, lambda_min = -|S|/3)."""
import sys, itertools
import numpy as np
from sympy import cyclotomic_poly, symbols, Poly, Matrix
x = symbols('x')

def setup(n):
    phi = [int(c) for c in Poly(cyclotomic_poly(n, x), x).all_coeffs()][::-1]  # low->high, monic
    d = len(phi) - 1
    def mul(a, b):
        c = [0]*(2*d-1)
        for i,ai in enumerate(a):
            if ai:
                for j,bj in enumerate(b):
                    c[i+j] += ai*bj
        for k in range(2*d-2, d-1, -1):
            t = c[k]
            if t:
                for j in range(d+1):
                    c[k-d+j] -= t*phi[j]
        return c[:d]
    def power_x(e):
        e %= n
        r = [0]*d; r[0]=1
        xv = [0]*d; xv[1]=1
        for _ in range(e): r = mul(r, xv)
        return r
    def conj(a):  # zeta -> zeta^{-1}
        r = [0]*d
        for i,ai in enumerate(a):
            if ai:
                p = power_x(-i)
                r = [r[j]+ai*p[j] for j in range(d)]
        return r
    return d, mul, power_x, conj

def run(n, m):
    d, mul, power_x, conj = setup(n)
    e = 2 if n == 12 else 4          # ramification index of P over 2
    one = [1]+[0]*(d-1)
    zeta4 = power_x(n//4)            # i
    zeta8 = power_x(n//8) if n % 8 == 0 else None
    pi = [one[j]-(zeta8 if zeta8 else zeta4)[j] for j in range(d)]   # uniformizer: 1 - zeta_{2e}
    omega = power_x(n//3)            # zeta_3, generates residue field F4
    k = -(-m//e)                     # 2^k in P^{e k}, e*k >= m
    def ppow(t):
        r = one
        for _ in range(t): r = mul(r, pi)
        return r
    shift = ppow(e*k - m)
    def in_Pm(y):
        z = mul(y, shift)
        return all(c % (2**k) == 0 for c in z)
    # sanity: pi^e / 2 is a unit: pi^e in P^e, not in P^{e+1}
    # representatives sum_{j<m} pi^j (a_j + b_j omega)
    pis = [ppow(j) for j in range(m)]
    digs = [[0]*d, one, omega, [one[t]+omega[t] for t in range(d)]]
    reps = []
    for choice in itertools.product(range(4), repeat=m):
        v = [0]*d
        for j,c in enumerate(choice):
            if c:
                t = mul(pis[j], digs[c])
                v = [v[q]+t[q] for q in range(d)]
        reps.append(v)
    S = [r for r in reps if in_Pm([a-b for a,b in zip(mul(r, conj(r)), one)])]
    # lattice P^m = pi^m O: basis pi^m * x^i
    pm = ppow(m)
    B = np.array([mul(pm, power_x(i)) for i in range(d)], dtype=object).T   # columns
    Bm = Matrix(B.tolist())
    Binv = Bm.inv()
    # characters: c in Z^d B^{-1} mod Z^d ; enumerate via Smith-free approach: c = z * Binv for z in Z^d mod Z^d B ... use dual basis rows
    # coordinates of S elements
    Sc = np.array(S, dtype=np.int64)
    # dual group: rows of Binv generate M*; M*/Z^d has order |det B| = 4^m. Enumerate by reducing combinations.
    D = [list(Binv.row(i)) for i in range(d)]
    from fractions import Fraction
    Dq = np.array([[float(Fraction(int(c.p), int(c.q))) for c in row] for row in D])
    # orders: generate group by BFS over generator rows mod 1 (as exact fractions)
    import sympy
    gens = [tuple(sympy.Rational(c) % 1 for c in row) for row in D]
    seen = {tuple([sympy.Integer(0)]*d)}
    frontier = list(seen)
    while frontier:
        nf = []
        for g in frontier:
            for h in gens:
                s = tuple((a+b) % 1 for a,b in zip(g,h))
                if s not in seen:
                    seen.add(s); nf.append(s)
        frontier = nf
    chars = np.array([[float(c) for c in g] for g in seen])
    assert len(chars) == 4**m, (len(chars), 4**m)
    phase = chars @ Sc.T.astype(float)          # (#chars, |S|)
    lam = np.cos(2*np.pi*phase).sum(axis=1)
    lam_sorted = np.sort(lam)
    nmin = int(np.sum(np.abs(lam - lam_sorted[0]) < 1e-7))
    return len(S), lam_sorted[0], nmin, lam_sorted[:6]

if __name__ == '__main__':
    n = int(sys.argv[1]); mmax = int(sys.argv[2])
    for m in range(1, mmax+1):
        s, lmin, nmin, low = run(n, m)
        print(f"n={n} m={m} |S|={s} lambda_min={lmin:.9f} -|S|/3={-s/3:.9f} gap={lmin + s/3:+.3e} #min={nmin} low={np.round(low,4)}", flush=True)
