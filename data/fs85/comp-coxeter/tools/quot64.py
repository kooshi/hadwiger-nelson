import io, contextlib, collections, itertools
with contextlib.redirect_stdout(io.StringIO()):
    from chir2 import *
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_decomp
# P+ basis rows (coords9); Smith: D = S*Pp*T  -> Lambda/P+ coordinates
Pp_int=Matrix([[int(x) for x in r] for r in Pp.tolist()])
D,S_,T_=smith_normal_decomp(Pp_int)
d=[D[i,i] for i in range(4)]
print('Lambda/P+ invariants:',d)
Tinv=T_.inv()
def qcoord(v):   # coordinates of v in Lambda/P+ = prod Z/d_i : v (row) * T  mod d
    r=Matrix([v])*T_
    return tuple(int(r[i])%d[i] for i in range(4))
Ubar=collections.Counter(qcoord(c9(Z**j*ETA**k)) for j in range(6) for k in range(-4,5))
print('distinct images of the 54 unit vectors in Lambda/P+:',len(Ubar),' multiplicities',sorted(set(Ubar.values())))
print('images:',sorted(Ubar))

from zlin import hnf, index_full
for name,P in (('P+',Pp),('P-',Pm)):
    rows=[list(map(int,r)) for r in P.tolist()]+[[9,0,0,0],c9(Z)]
    print(name,': [Lambda : T0 + P] =',index_full(hnf(rows),4))
# which families land on which hexagon in Lambda/P+
HA={(1,1),(1,6),(2,7),(7,7),(7,2),(6,1)}
fams=collections.defaultdict(list)
for k in range(-4,5):
    im=[qcoord(c9(Z**j*ETA**k))[2:] for j in range(6)]
    fams['A' if set(im)<=HA else 'B'].append(k)
    # orientation: image of zeta^j eta^k vs image of zeta^j (as rotation index)
print('families on hexagon A (image of T0 is A?):',fams['A'],' on B:',fams['B'])
print('image of T0 hexagon:',[qcoord(c9(Z**j))[2:] for j in range(6)])
