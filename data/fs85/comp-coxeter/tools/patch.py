"""The patchwork picture (round 2): x -> ([x] in Lambda/Lambda5, rho_eps(x) in T0/8T0).  Classes and rho-images of the outer families."""
import io, contextlib, collections
with contextlib.redirect_stdout(io.StringIO()):
    from quot64 import *
from zlin import hnf, in_span
L5rows=[c9(Z**j*ETA**k) for j in range(6) for k in range(-2,3)]
Pp_rows=[list(map(int,r)) for r in Pp.tolist()]
for k in (3,4,-3,-4):
    ins=[in_span(c9(Z**j*ETA**k),L5rows) for j in range(6)]
    print('family',k,': in Lambda5?',ins)
# is (eta^{2m} - zeta^{2m}) T0 in P+ ?  (P+ = class vanishing on (eta^2-zeta^2)T0)
for m in (1,2,-1,-2):
    for e in (1,-1):
        v=[c9((ETA**(2*m)-Z**(2*m*e))*Z**j) for j in range(2)]
        print('m=%d eps=%d: (eta^%d - zeta^%d)T0 in P+ ?'%(m,e,2*m,2*m*e), all(in_span(x,Pp_rows) for x in v))
# rho_+ images: express q-coordinates of unit vectors in terms of the T0 hexagon image
T0img={qcoord(c9(Z**j))[2:]:j for j in range(6)}
for k in range(-4,5):
    im=[qcoord(c9(Z**j*ETA**k))[2:] for j in range(6)]
    print(k, [('z^%d'%T0img[p]) if p in T0img else p for p in im])
