import io, contextlib, collections
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
    from spectral5 import period_lattice, order
    from zlin import hnf, index_full
E2=ETA**2
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
def vanish(t,m):
    return all(ev(t,c9((E2-Z**m)*Z**j))==0 for j in range(2))
S5,_,_=theta([-2,-1,0,1,2]); S5=sorted(S5)
cls=collections.Counter((vanish(t,2),vanish(t,4)) for t in S5)
print('Theta_{-2..2} by chirality class (vanish on (eta^2-z^2)T0, on (eta^2-z^4)T0):',cls)
Cp=[t for t in S5 if vanish(t,2)]; Cm=[t for t in S5 if vanish(t,4)]
Pp,dp=period_lattice(Cp); Pm,dm=period_lattice(Cm)
print('[Lambda:P+]=',abs(Pp.det()),'orders lcm',dp,' [Lambda:P-]=',abs(Pm.det()),'lcm',dm)
S=hnf([list(map(int,r)) for r in Pp.tolist()]+[list(map(int,r)) for r in Pm.tolist()])
print('[Lambda : P+ + P-] =',index_full(S,4))
