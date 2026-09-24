import io, contextlib, math, collections
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
    from spectral5 import order
import sympy as sp
S5,_,_=theta([-2,-1,0,1,2]); S9,_,_=theta(list(range(-4,5))); S9=set(S9)
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
def lamS(t,k): return sum(2*sp.cos(2*sp.pi*sp.Rational(ev(t,v).numerator,ev(t,v).denominator)) for v in fam[k])
def lamF(t,k): return sum(2*math.cos(2*math.pi*float(ev(t,v))) for v in fam[k])
cands=sorted([t for t in S5 if t not in S9 and lamF(t,3)+lamF(t,-3)+4<-1e-6 and lamF(t,4)+lamF(t,-4)+4<-1e-6], key=order)
print('both-negative bad characters by order:',collections.Counter(order(t) for t in cands))
t=cands[0]
A3=sp.nsimplify(sp.simplify(lamS(t,3)+lamS(t,-3)+4)); A4=sp.nsimplify(sp.simplify(lamS(t,4)+lamS(t,-4)+4))
print('theta =',[str(x) for x in t],' order',order(t))
print('A3 =',sp.radsimp(A3),'=',float(A3),'   A4 =',sp.radsimp(A4),'=',float(A4))
# the two order-6 partners with vectors (3,0) and (0,3)
o6=[s for s in S5 if order(s)==6]
COS={Q(0):1,Q(1,6):Q(1,2),Q(1,3):Q(-1,2),Q(1,2):-1,Q(2,3):Q(-1,2),Q(5,6):Q(1,2)}
def lq(s,k): return sum(2*COS[ev(s,v)] for v in fam[k])
p30=next(s for s in o6 if (lq(s,3)+lq(s,-3)+4, lq(s,4)+lq(s,-4)+4)==(3,0))
p03=next(s for s in o6 if (lq(s,3)+lq(s,-3)+4, lq(s,4)+lq(s,-4)+4)==(0,3))
print('partner (3,0):',[str(x) for x in p30],'  partner (0,3):',[str(x) for x in p03])
print('weights  w(theta)=1, w(p30) = -A3/3 =',float(-A3/3),', w(p03) = -A4/3 =',float(-A4/3),'; all characters outside Theta_all:',t not in S9, p30 not in S9, p03 not in S9)
