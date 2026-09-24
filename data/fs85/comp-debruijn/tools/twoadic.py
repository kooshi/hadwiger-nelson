"""The two 2-adic embeddings of E = Q(sqrt-3, sqrt-11) into Q2(zeta3) (2 splits into p, p' in E; each residue field F4).
Elements of Z2[zeta3] mod 2^N as pairs (a, b) = a + b*zeta3, zeta3^2 = -1 - zeta3."""
N = 40; MOD = 1 << N
def zmul(x, y):
    a,b = x; c,d = y
    # (a + b z)(c + d z) = ac + (ad+bc) z + bd z^2 = ac - bd + (ad + bc - bd) z
    return ((a*c - b*d) % MOD, (a*d + b*c - b*d) % MOD)
def zadd(x,y): return ((x[0]+y[0])%MOD, (x[1]+y[1])%MOD)
def zsc(k,x): return ((k*x[0])%MOD, (k*x[1])%MOD)
def sqrt2adic(n):
    # n = 1 mod 8; Hensel: x^2 = n mod 2^N, x = 1 mod 4
    x = 1
    for k in range(3, N+1):
        if (x*x - n) % (1 << k): x += 1 << (k-2)
    x %= MOD
    assert (x*x - n) % MOD == 0
    return x
S33 = sqrt2adic(33)
SQM3 = (1, 2)                   # sqrt(-3) = 1 + 2 zeta3
inv3 = pow(3, -1, MOD); inv2half = None
def half(x):
    assert x[0] % 2 == 0 and x[1] % 2 == 0, x
    return ((x[0]//2) % (MOD//2), (x[1]//2) % (MOD//2))   # precision drops to N-1 bits
def emb(a, sign):
    """image of a in E in Z2[zeta3] mod 2^(N-1), via coordinates in the O_E basis (1, zeta6, w, zeta6 w) (denominators odd).
    sign = +1 for p, -1 for p' (sqrt33 -> sign*S33)."""
    from lam import coords
    from fractions import Fraction
    s = sign * S33 % MOD
    img_s11 = zsc((-inv3) % MOD, zmul(((-s) % MOD, 0), SQM3))   # s11 = s33*s3/(-3), s33 = -sqrt33
    wimg = half(zadd((1,0), img_s11))
    z6 = (1, 1)                                                  # zeta6 = 1 + zeta3
    basis = [(1,0), z6, wimg, zmul(z6, wimg)]
    tot = (0, 0)
    for coef, img in zip(coords(a), basis):
        coef = Fraction(coef)
        assert coef.denominator % 2 == 1
        k = coef.numerator * pow(coef.denominator, -1, MOD) % MOD
        tot = zadd(tot, zsc(k, img))
    return (tot[0] % (MOD//2), tot[1] % (MOD//2))
def red(x, k):  # reduce mod 2^k
    return (x[0] % (1<<k), x[1] % (1<<k))
