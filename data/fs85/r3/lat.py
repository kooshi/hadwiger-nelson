"""FS-85 R3 (de Bruijn): exact arithmetic on de Grey's lattice Lambda = (1/9) O_E, E = Q(sqrt-3, sqrt-11).
Elements are integer 4-vectors: the coordinates of 9x in the O_E-basis 1, z, w, zw (z = zeta6, w = (1+sqrt-11)/2),
z^2 = z - 1, w^2 = w - 3.  Self-contained (no import from other agents' tools)."""
from fractions import Fraction as Fr
import itertools

def mul(p, q):
    """product of two elements of E given as rational 4-vectors in the basis 1, z, w, zw."""
    def mz(x, y):                       # (a + b z)(c + d z), z^2 = z - 1
        a, b = x; c, d = y
        return (a*c - b*d, a*d + b*c + b*d)
    A = (p[0], p[1]); B = (p[2], p[3]); P = (q[0], q[1]); R = (q[2], q[3])
    AP = mz(A, P); AR = mz(A, R); BP = mz(B, P); BR = mz(B, R)
    c0 = (AP[0] - 3*BR[0], AP[1] - 3*BR[1])          # B R w^2 = B R (w - 3)
    c1 = (AR[0] + BP[0] + BR[0], AR[1] + BP[1] + BR[1])
    return (c0[0], c0[1], c1[0], c1[1])

def conj(p):
    a, b, c, d = p                     # zbar = 1 - z, wbar = 1 - w
    return (a + b + c + d, -b - d, -c - d, d)

def add(p, q): return tuple(x + y for x, y in zip(p, q))
def neg(p): return tuple(-x for x in p)
def sc(k, p): return tuple(k*x for x in p)

ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
Z = (Fr(0), Fr(1), Fr(0), Fr(0))
W = (Fr(0), Fr(0), Fr(1), Fr(0))
ETA = sc(Fr(1, 3), mul(add(sc(2, Z), neg(ONE)), add(ONE, neg(W))))     # eta = (2z-1)(1-w)/3 = (sqrt33 + i sqrt3)/6

def pw(p, n):
    r = ONE
    if n >= 0:
        for _ in range(n): r = mul(r, p)
        return r
    # inverse of a unit: conj
    pinv = conj(p)
    assert mul(p, pinv) == ONE, "not a unit"
    for _ in range(-n): r = mul(r, pinv)
    return r

def c9(p):
    v = [x*9 for x in p]
    assert all(Fr(x).denominator == 1 for x in v), p
    return tuple(int(x) for x in v)

def unit(j, k): return mul(pw(Z, j), pw(ETA, k))
UNITS = {(j, k): c9(unit(j, k)) for j in range(6) for k in range(-4, 5)}

def cplx(p):
    import cmath
    z = cmath.exp(1j*cmath.pi/3); w = (1 + 1j*11**0.5)/2
    a, b, c, d = [float(x) for x in p]
    return a + b*z + c*w + d*z*w

if __name__ == "__main__":
    # sanity: every unit has norm 1 and distinct; 54 of them
    for (j, k), v in UNITS.items():
        p = tuple(Fr(x, 9) for x in v)
        assert mul(p, conj(p)) == ONE
        assert abs(abs(cplx(p)) - 1) < 1e-12
    assert len(set(UNITS.values())) == 54
    print("54 distinct unit vectors of norm one; eta =", [str(x) for x in ETA])
