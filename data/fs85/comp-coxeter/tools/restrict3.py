from spectral import *
from math import lcm
import collections
S5,_,_=theta([-2,-1,0,1,2])
def restr(t,k):
    a=sum(Q(x)*y for x,y in zip(fam[k][0],t))%1
    b=sum(Q(x)*y for x,y in zip(fam[k][1],t))%1
    return (a,b)
for k in (3,4):
    R=collections.Counter(restr(t,k) for t in S5)
    on=[p for p in R if p[0]==Q(1,2) or p[1]==Q(1,2) or (p[1]-p[0])%1==Q(1,2)]
    print('family',k,': |R|=',len(R),' on circles:',len(on))
    off=sorted(p for p in R if p not in on)
    print('  off-circle restricted characters (phi(eta^k), phi(zeta eta^k)):',[(str(a),str(b)) for a,b in off][:40])
    print('  orders of off-circle:',collections.Counter(lcm(a.denominator,b.denominator) for a,b in off))
