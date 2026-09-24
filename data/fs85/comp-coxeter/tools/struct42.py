from spectral import *
from math import lcm
import collections
S9,_,_=theta(list(range(-4,5))); S9=sorted(S9)
def order(t): return lcm(*[x.denominator for x in t])
U=[c9(Z**j*ETA**k) for j in range(6) for k in range(-4,5)]
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
o2=[t for t in S9 if order(t)==2]
Epi={}
for p in o2:
    U0=[v for v in U if ev(p,v)==0]
    E=[t for t in S9 if all(ev(t,v)==Q(1,2) for v in U0)]
    Epi[p]=E
    print('pi=',tuple(int(2*x) for x in p),'|U0|=',len(U0),'|E_pi|=',len(E),'orders',collections.Counter(order(t) for t in E))
allE=set().union(*Epi.values())
print('union of E_pi:',len(allE),' union with order-2 points:',len(allE|set(o2)),' of 42')
# pairwise intersections
ps=list(Epi)
for a in range(6):
    print([len(set(Epi[ps[a]])&set(Epi[ps[b]])) for b in range(6)])
# for each theta in S9: which families' circles (j index) -- the direction pattern
def dirs(t):
    return tuple(tuple(j for j in range(3) if ev(t,fam[k][j])==Q(1,2)) for k in range(-4,5))
for p in o2: print('pi',tuple(int(2*x) for x in p),'circle pattern',dirs(p))
e=Epi[o2[0]][0]; print('an E-point pattern', dirs(e), order(e))
