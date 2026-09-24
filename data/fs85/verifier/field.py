"""Exact arithmetic in E = Q(sqrt-3, sqrt-11) for the FS-85 verifier.

Elements are 4-tuples of Fractions in the basis (1, a, b, ab), a^2 = -3, b^2 = -11.
O_E = Z<1, zeta, w, zeta*w>, zeta = (1+a)/2, w = (1+b)/2 (discriminants -3, -11 coprime).
Lambda = (1/9) O_E.  Standard library only.
"""
from fractions import Fraction as Fr
from itertools import product

A2, B2 = -3, -11


def E(c0=0, c1=0, c2=0, c3=0):
    return (Fr(c0), Fr(c1), Fr(c2), Fr(c3))


ZERO, ONE = E(0), E(1)
SQ3 = E(0, 1)            # sqrt(-3)
SQ11 = E(0, 0, 1)        # sqrt(-11)


def add(x, y):
    return tuple(p + q for p, q in zip(x, y))


def sub(x, y):
    return tuple(p - q for p, q in zip(x, y))


def neg(x):
    return tuple(-p for p in x)


def smul(r, x):
    r = Fr(r)
    return tuple(r * p for p in x)


def mul(x, y):
    x0, x1, x2, x3 = x
    y0, y1, y2, y3 = y
    # (x0 + x1 a + x2 b + x3 ab)(y0 + y1 a + y2 b + y3 ab)
    c0 = x0*y0 + A2*x1*y1 + B2*x2*y2 + A2*B2*x3*y3
    c1 = x0*y1 + x1*y0 + B2*(x2*y3 + x3*y2)
    c2 = x0*y2 + x2*y0 + A2*(x1*y3 + x3*y1)
    c3 = x0*y3 + x3*y0 + x1*y2 + x2*y1
    return (c0, c1, c2, c3)


def conj(x):  # complex conjugation: a -> -a, b -> -b, ab -> ab
    return (x[0], -x[1], -x[2], x[3])


def norm_rel(x):  # x * conj(x), lies in Q(ab) = Q(sqrt33)
    return mul(x, conj(x))


def inv(x):
    # x^{-1} = conj(x) * (n0 - n3 ab) / (n0^2 - 33 n3^2) where x conj(x) = n0 + n3 ab
    n = norm_rel(x)
    assert n[1] == 0 and n[2] == 0
    d = n[0]**2 - 33*n[3]**2
    return mul(conj(x), E(n[0]/d, 0, 0, -n[3]/d))


def div(x, y):
    return mul(x, inv(y))


def power(x, k):
    if k < 0:
        return power(inv(x), -k)
    r = ONE
    for _ in range(k):
        r = mul(r, x)
    return r


ZETA = E(Fr(1, 2), Fr(1, 2))
W = E(Fr(1, 2), 0, Fr(1, 2))
ETA = E(0, Fr(1, 6), 0, Fr(-1, 6))       # (sqrt33 + i sqrt3)/6, sqrt33 = -ab, i sqrt3 = a


def to_OE(x):
    """Coordinates of x in the basis (1, zeta, w, zeta*w) of O_E (Fractions)."""
    # 1, zeta=(1+a)/2, w=(1+b)/2, zw=(1+a+b+ab)/4
    x0, x1, x2, x3 = x
    s = 4*x3                  # coefficient of zw
    q = 2*(x1 - s/4)          # zeta coefficient: a-part = q/2 + s/4
    r = 2*(x2 - s/4)          # w coefficient: b-part = r/2 + s/4
    p = x0 - q/2 - r/2 - s/4
    return (p, q, r, s)


def from_OE(p, q, r, s):
    return add(add(E(p), smul(q, ZETA)), add(smul(r, W), smul(s, mul(ZETA, W))))


def in_OE(x):
    return all(c.denominator == 1 for c in to_OE(x))


def in_Lambda(x):
    return in_OE(smul(9, x))


def lam_coords(x):
    """Integer coordinates of x in the Z-basis (1, zeta, w, zeta w)/9 of Lambda."""
    c = to_OE(smul(9, x))
    assert all(v.denominator == 1 for v in c), ("not in Lambda", x)
    return tuple(int(v) for v in c)


def cplx(x):
    import cmath
    a = complex(0, 3**0.5)
    b = complex(0, 11**0.5)
    return float(x[0]) + float(x[1])*a + float(x[2])*b + float(x[3])*a*b


# ---- residues at the two primes above 2 -------------------------------------
# F4 = Z[zeta]/2 = {u + v*zeta}, zeta^2 = zeta + 1 (mod 2).  Represented as pairs (u, v) mod 2.
def f4_add(x, y):
    return ((x[0] + y[0]) % 2, (x[1] + y[1]) % 2)


def f4_mul(x, y):
    u = x[0]*y[0] + x[1]*y[1]          # zeta^2 = 1 + zeta
    v = x[0]*y[1] + x[1]*y[0] + x[1]*y[1]
    return (u % 2, v % 2)


F4 = [(0, 0), (1, 0), (0, 1), (1, 1)]
F4_ZETA = (0, 1)
F4_ZETA2 = (1, 1)
# O_E / 2 = F4[w]/(w^2 + w + 1); the two roots of X^2+X+1 in F4 are zeta and zeta^2.
PRIMES = {'p': F4_ZETA, "p'": F4_ZETA2}


def red(x, q):
    """Reduction of x in Lambda at the prime q in {'p', "p'"} (9 = 1 in F4)."""
    p, qq, r, s = lam_coords(x)       # 9x = p + qq zeta + r w + s zeta w
    wq = PRIMES[q]
    base = (p % 2, qq % 2)
    wc = (r % 2, s % 2)
    return f4_add(base, f4_mul(wc, wq))


def red_T0(t):
    """t in Z[zeta] as an E-element -> t mod 2 in F4 (the same at both primes)."""
    c = to_OE(t)
    assert c[2] == 0 and c[3] == 0 and all(v.denominator == 1 for v in c)
    return (int(c[0]) % 2, int(c[1]) % 2)
