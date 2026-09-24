import sys, io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    from chir import *
from spectral5 import period_lattice
from zlin import hnf, index_full
from sympy import Matrix
Cp=sorted(set().union(*[Epi[p] for p in o2 if vanish(p,2)]))
Cm=sorted(set().union(*[Epi[p] for p in o2 if vanish(p,4)]))
print('|C+|=',len(Cp),' |C-|=',len(Cm),' disjoint:',not set(Cp)&set(Cm), ' union 42:',len(set(Cp)|set(Cm)))
Pp,_=period_lattice(Cp); Pm,_=period_lattice(Cm)
print('[Lambda:P+]=',abs(Pp.det()),' [Lambda:P-]=',abs(Pm.det()))
S=hnf([list(map(int,r)) for r in Pp.tolist()]+[list(map(int,r)) for r in Pm.tolist()])
print('[Lambda : P+ + P-] =',index_full(S,4))
I=hnf([list(map(int,r)) for r in Pp.tolist()])  # check intersection = 8Lambda: index of P+ cap P- via lcm... use dual: C+ u C- generates full 8-dual (done before)
