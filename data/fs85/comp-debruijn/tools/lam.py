"""Exact arithmetic on de Grey's lattice Lambda = (1/9) O_E, E = Q(sqrt-3, sqrt-11).

Elements of E are held as 4-vectors of Fractions over the Q-basis (1, s3, s11, s33) with
s3 = sqrt(-3), s11 = sqrt(-11), s33 = s3*s11 = -sqrt(33).  Complex numbers are x + i y with
x, y in Q(sqrt3, sqrt11) real: sqrt3 = -i*s3, i.e. i*sqrt3 = s3, i*sqrt11 = s11, sqrt33 = -s33.
"""
from fractions import Fraction as Fr
import json, itertools

# multiplication table for basis (1, s3, s11, s33): s3^2=-3, s11^2=-11, s33 = s3 s11, s33^2 = 33
def mul(a, b):
    a0,a1,a2,a3 = a; b0,b1,b2,b3 = b
    c0 = a0*b0 - 3*a1*b1 - 11*a2*b2 + 33*a3*b3
    c1 = a0*b1 + a1*b0 + (-11)*a2*b3 + (-11)*a3*b2   # s11*s33 = s11*s3*s11 = -11 s3
    c2 = a0*b2 + a2*b0 + (-3)*a1*b3 + (-3)*a3*b1     # s3*s33 = -3 s11
    c3 = a0*b3 + a3*b0 + a1*b2 + a2*b1
    return (c0,c1,c2,c3)
def add(a,b): return tuple(x+y for x,y in zip(a,b))
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
def sc(k,a): return tuple(Fr(k)*x for x in a)
def conj(a):  # complex conjugation: s3 -> -s3, s11 -> -s11, s33 -> s33
    return (a[0], -a[1], -a[2], a[3])
def norm(a):  # |a|^2, an element of Q(sqrt33) represented in the basis
    return mul(a, conj(a))
def inv(a):
    n = norm(a)  # n = n0 + n3 s33 ; 1/n = (n0 - n3 s33)/(n0^2 - 33 n3^2)
    assert n[1]==0 and n[2]==0
    d = n[0]**2 - 33*n[3]**2
    ninv = (n[0]/d, Fr(0), Fr(0), -n[3]/d)
    return mul(conj(a), ninv)
ONE = (Fr(1),Fr(0),Fr(0),Fr(0))
Z6 = (Fr(1,2),Fr(1,2),Fr(0),Fr(0))          # zeta6 = (1+sqrt-3)/2
W  = (Fr(1,2),Fr(0),Fr(1,2),Fr(0))          # w = (1+sqrt-11)/2
BASIS = [ONE, Z6, W, mul(Z6,W)]

def coords(a):
    """coordinates of a in the Z-basis (1, zeta6, w, zeta6 w) of O_E (exact rational solve)."""
    # columns of the basis in the Q-basis
    import sympy
    M = sympy.Matrix([[sympy.Rational(b[i].numerator, b[i].denominator) for b in BASIS] for i in range(4)])
    v = sympy.Matrix([sympy.Rational(x.numerator, x.denominator) for x in a])
    sol = M.LUsolve(v)
    return tuple(Fr(int(s.p), int(s.q)) for s in sol)
def in_Lambda(a):
    return all((9*x).denominator == 1 for x in coords(a))
def is_unit(a):
    return norm(a) == ONE

def from_fs73(vec, M=36):
    """(x_S)_S, (y_S)_S over M, S in order (), (3), (11), (33); x = sum x_S sqrt(S)/M (real)."""
    x = vec[:4]; y = vec[4:]
    # z = x + i y ; sqrt3 = -i s3 -> as element: sqrt3 = (0, ?, ...) : i*sqrt3 = s3 => sqrt3 = -i s3.
    # We need i as an element of E: i is NOT in E. So real parts must combine: x + i y with x,y real in Q(sqrt3,sqrt11).
    # sqrt3 and i separately are not in E, but i*sqrt3 = s3, i*sqrt11 = s11, sqrt33 = -s33, and rationals are fine.
    # So z = x0 + x33 sqrt33 + i(y3 sqrt3 + y11 sqrt11) requires x3 = x11 = 0 = y0 = y33.
    assert x[1]==0 and x[2]==0 and y[0]==0 and y[3]==0, vec
    return (Fr(x[0],M), Fr(y[1],M), Fr(y[2],M), Fr(-x[3],M))

def load_U():
    d = json.load(open('/home/kooshi/source/lean-dir/data/fs73/census/lattice-degrey.json'))
    return [from_fs73(v, d['M']) for v in d['U']]

def fmt(a):
    return '(' + ', '.join(str(x) for x in a) + ')'
