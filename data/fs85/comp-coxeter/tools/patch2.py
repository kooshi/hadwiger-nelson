"""Patchwork setup: classes of family +-4 unit vectors in V = Lambda/Lambda7 ~ F3^2, and their rho_+ shifts."""
import io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    from quot64 import *
from zlin import hnf
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_decomp
L7=Matrix(hnf([c9(Z**j*ETA**k) for j in range(6) for k in range(-3,4)]))
D,S7,T7=smith_normal_decomp(L7); d7=[D[i,i] for i in range(4)]
print('Lambda/Lambda7 invariants',d7)
def cls(v):
    r=Matrix([v])*T7
    return tuple(int(r[i])%d7[i] for i in range(4) if d7[i]!=1)
T0img={qcoord(c9(Z**j))[2:]:j for j in range(6)}
for k in (4,-4):
    for j in range(6):
        u=c9(Z**j*ETA**k); print('u = z^%d eta^%d : class %s  rho_+ shift z^%d'%(j,k,cls(u),T0img[qcoord(u)[2:]]))
print('class of T0 generators:',cls(c9(Z**0)),cls(c9(Z)))
for k in range(-3,4): assert all(cls(c9(Z**j*ETA**k))==(0,0) for j in range(6))
# class of eta^4 * v for v in T0 : phi(v) linear; phi(1), phi(zeta)
