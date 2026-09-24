"""Exact arithmetic in E = Q(sqrt-3, sqrt-11) on the O_E-basis 1, z, w, zw
(z = zeta6 = (1+sqrt-3)/2, w = (1+sqrt-11)/2).  z^2 = z - 1, w^2 = w - 3.
De Grey's lattice Lambda = (1/9) O_E.  Coxeter, FS-85."""
from fractions import Fraction as Q
import cmath, itertools

class E:
    __slots__=("c",)
    def __init__(s,a=0,b=0,c=0,d=0):
        s.c=(Q(a),Q(b),Q(c),Q(d))
    @staticmethod
    def of(t): return E(*t)
    def __add__(s,o):
        o=lift(o); return E(*[x+y for x,y in zip(s.c,o.c)])
    __radd__=__add__
    def __neg__(s): return E(*[-x for x in s.c])
    def __sub__(s,o): return s+(-lift(o))
    def __rsub__(s,o): return lift(o)-s
    def __mul__(s,o):
        o=lift(o)
        # (a+bz)(p+qz) in Z[z]: z^2=z-1
        def mz(x,y):
            a,b=x; p,q=y
            return (a*p-b*q, a*q+b*p+b*q)
        a,b,c,d=s.c; p,q,r,t=o.c
        A=(a,b); B=(c,d); P=(p,q); R=(r,t)   # s = A + B w, o = P + R w
        AP=mz(A,P); AR=mz(A,R); BP=mz(B,P); BR=mz(B,R)
        # B R w^2 = B R (w - 3)
        c0=(AP[0]-3*BR[0], AP[1]-3*BR[1])
        c1=(AR[0]+BP[0]+BR[0], AR[1]+BP[1]+BR[1])
        return E(c0[0],c0[1],c1[0],c1[1])
    __rmul__=__mul__
    def conj(s):
        # zbar = 1 - z, wbar = 1 - w ; (a + b z)(...)...
        a,b,c,d=s.c
        # a + b(1-z) + c(1-w) + d(1-z)(1-w) = a+b+c+d + (-b-d) z + (-c-d) w + d zw
        return E(a+b+c+d, -b-d, -c-d, d)
    def norm(s):  # z * zbar, an element of E+ (returned as E)
        return s*s.conj()
    def inv(s):
        # 1/s = conj-stuff: use norm down to Q.  N_{E/Q} via product over Galois group.
        g=[s, s.conj(), s.sig3(), s.sig11()]
        # s * s.conj() * s.sig3()*s.sig11() is rational
        p=s.conj()*s.sig3()*s.sig11()
        n=s*p
        assert n.c[1]==n.c[2]==n.c[3]==0, n
        return p*E(1/n.c[0])
    def sig3(s):   # sqrt-3 -> -sqrt-3, sqrt-11 fixed : z -> 1-z, w -> w
        a,b,c,d=s.c
        # a + b(1-z) + c w + d(1-z) w
        return E(a+b, -b, c+d, -d)
    def sig11(s):  # sqrt-11 -> -sqrt-11 : w -> 1-w
        a,b,c,d=s.c
        return E(a+c, b+d, -c, -d)
    def __truediv__(s,o): return s*lift(o).inv()
    def __pow__(s,n):
        if n<0: return (s.inv())**(-n)
        r=E(1)
        for _ in range(n): r=r*s
        return r
    def __eq__(s,o): return s.c==lift(o).c
    def __hash__(s): return hash(s.c)
    def cx(s):
        z=cmath.exp(1j*cmath.pi/3); w=(1+1j*11**0.5)/2
        a,b,c,d=[float(x) for x in s.c]
        return a+b*z+c*w+d*z*w
    def in_lattice(s, den=9):
        return all((x*den).denominator==1 for x in s.c)
    def coords9(s): return tuple(int(x*9) if (x*9).denominator==1 else x*9 for x in s.c)
    def is_eis(s): return s.c[2]==0 and s.c[3]==0
    def __repr__(s): return "E(%s)"%",".join(str(x) for x in s.c)

def lift(o): return o if isinstance(o,E) else E(o)

Z=E(0,1); W=E(0,0,1)
ETA=(2*Z-1)*(1-W)*E(Q(1,3))
UNITS=[Z**j*ETA**k for j in range(6) for k in range(-4,5)]
