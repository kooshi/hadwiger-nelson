"""Exact arithmetic for de Grey's lattice, written by verifier 2 (FS-85) from the definitions only.

E = Q(sqrt-3, sqrt-11); an element is a 4-tuple of Fractions in the basis (1, z, w, z*w), z = zeta_6, w = (1 + sqrt-11)/2,
with z^2 = z - 1 and w^2 = w - 3.  Lambda = (1/9) O_E; Lambda-coordinates of x are the integers 9*x in that basis.
"""
from fractions import Fraction as Fr
from itertools import product
from math import gcd

# ---------- Q(zeta_6): pairs (a, b) = a + b z, z^2 = z - 1 ----------
def zmul(p, q):
    a, b = p; c, d = q
    # (a + b z)(c + d z) = ac + (ad + bc) z + bd z^2 = (ac - bd) + (ad + bc + bd) z
    return (a * c - b * d, a * d + b * c + b * d)

def zadd(p, q):
    return (p[0] + q[0], p[1] + q[1])

def zneg(p):
    return (-p[0], -p[1])

# ---------- E: 4-tuples (a, b, c, d) = (a + b z) + (c + d z) w ----------
def split(x):
    return (x[0], x[1]), (x[2], x[3])

def join(A, B):
    return (A[0], A[1], B[0], B[1])

def mul(x, y):
    A, B = split(x); C, D = split(y)
    # (A + B w)(C + D w) = AC + (AD + BC) w + BD w^2 = (AC - 3BD) + (AD + BC + BD) w
    BD = zmul(B, D)
    first = zadd(zmul(A, C), (-3 * BD[0], -3 * BD[1]))
    second = zadd(zadd(zmul(A, D), zmul(B, C)), BD)
    return join(first, second)

def add(x, y):
    return tuple(a + b for a, b in zip(x, y))

def sub(x, y):
    return tuple(a - b for a, b in zip(x, y))

def scal(r, x):
    return tuple(Fr(r) * a for a in x)

ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
ZERO = (Fr(0),) * 4
Z6 = (Fr(0), Fr(1), Fr(0), Fr(0))
W = (Fr(0), Fr(0), Fr(1), Fr(0))

def zconj(p):
    # conj(z) = 1 - z
    a, b = p
    return (a + b, -b)

def conj(x):
    # complex conjugation: z -> 1 - z, w -> 1 - w
    A, B = split(x)
    Ab, Bb = zconj(A), zconj(B)
    # A' + B' (1 - w) = (A' + B') - B' w
    return join(zadd(Ab, Bb), zneg(Bb))

def power(x, n):
    if n < 0:
        # for unit vectors (|x| = 1) the inverse is the conjugate; assert it
        xi = conj(x)
        assert mul(x, xi) == ONE, "power(): negative power of a non-unit-vector"
        x, n = xi, -n
    r = ONE
    for _ in range(n):
        r = mul(r, x)
    return r

def sqnorm(x):
    """|x|^2, must be rational."""
    n = mul(x, conj(x))
    assert n[1] == 0 and n[2] == 0 and n[3] == 0, n
    return n[0]

SQRTm3 = sub(scal(2, Z6), ONE)          # 2z - 1
SQRTm11 = sub(scal(2, W), ONE)          # 2w - 1
ETA = scal(Fr(1, 3), mul(SQRTm3, sub(ONE, W)))   # (2z - 1)(1 - w)/3 = (sqrt33 + i sqrt3)/6

def lam(x):
    """Lambda-coordinates (integers) of x, or None if x is not in Lambda."""
    y = [9 * a for a in x]
    if all(a.denominator == 1 for a in y):
        return tuple(int(a) for a in y)
    return None

def from_lam(v):
    return tuple(Fr(a, 9) for a in v)

def unit(j, k):
    return mul(power(Z6, j % 6), power(ETA, k))

FAMILIES = range(-4, 5)
U = {(j, k): unit(j, k) for k in FAMILIES for j in range(6)}
ULAM = {key: lam(u) for key, u in U.items()}

# ---------- integer linear algebra ----------
def hnf_rows(rows):
    """Row-style Hermite normal form (upper triangular, positive pivots) of the integer row lattice; returns nonzero rows."""
    A = [list(r) for r in rows]
    m = len(A[0]) if A else 0
    out = []
    col = 0
    r0 = 0
    while col < m and r0 < len(A):
        # bring gcd of column `col` among rows r0.. to row r0
        while True:
            nz = [i for i in range(r0, len(A)) if A[i][col] != 0]
            if not nz:
                break
            piv = min(nz, key=lambda i: abs(A[i][col]))
            A[r0], A[piv] = A[piv], A[r0]
            done = True
            for i in range(r0 + 1, len(A)):
                if A[i][col] != 0:
                    q = A[i][col] // A[r0][col]
                    A[i] = [a - q * b for a, b in zip(A[i], A[r0])]
                    if A[i][col] != 0:
                        done = False
            if done:
                break
        if any(A[i][col] != 0 for i in range(r0, len(A))):
            if A[r0][col] < 0:
                A[r0] = [-a for a in A[r0]]
            for i in range(r0):
                q = A[i][col] // A[r0][col]
                A[i] = [a - q * b for a, b in zip(A[i], A[r0])]
            r0 += 1
        col += 1
    return [r for r in A[:r0]]

def det(M):
    M = [[Fr(a) for a in r] for r in M]
    n = len(M); d = Fr(1)
    for c in range(n):
        p = next((i for i in range(c, n) if M[i][c] != 0), None)
        if p is None:
            return Fr(0)
        if p != c:
            M[c], M[p] = M[p], M[c]; d = -d
        d *= M[c][c]
        for i in range(c + 1, n):
            f = M[i][c] / M[c][c]
            M[i] = [a - f * b for a, b in zip(M[i], M[c])]
    return d

def inv(M):
    n = len(M)
    A = [[Fr(a) for a in r] + [Fr(int(i == j)) for j in range(n)] for i, r in enumerate(M)]
    for c in range(n):
        p = next(i for i in range(c, n) if A[i][c] != 0)
        A[c], A[p] = A[p], A[c]
        pv = A[c][c]
        A[c] = [a / pv for a in A[c]]
        for i in range(n):
            if i != c and A[i][c] != 0:
                f = A[i][c]
                A[i] = [a - f * b for a, b in zip(A[i], A[c])]
    return [r[n:] for r in A]

def index_of(rows):
    """Index in Z^4 of the lattice spanned by integer rows (must have rank 4)."""
    H = hnf_rows(rows)
    assert len(H) == 4, ("rank", len(H))
    return abs(det(H)), H

def in_lattice(v, H):
    """Is integer vector v in the row lattice with HNF H (square, full rank)?"""
    Hi = inv(H)
    c = [sum(Fr(v[i]) * Hi[i][j] for i in range(4)) for j in range(4)]
    return all(x.denominator == 1 for x in c)
