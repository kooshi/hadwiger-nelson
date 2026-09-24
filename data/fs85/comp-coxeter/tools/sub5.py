"""Spectral support on the connected component Lambda5 = <U_{|k|<=2}> (index 81 in Lambda)."""
from spectral import *
from zlin import *
from math import lcm
import collections
from sympy import Matrix
rows=[c9(Z**j*ETA**k) for j in range(6) for k in range(-2,3)]
B=Matrix(hnf(rows))            # rows: basis of Lambda5 in coords9
Binv=B.inv()
def coords5(v): 
    r=Matrix([v])*Binv
    assert all(x.q==1 for x in r), r
    return [int(x) for x in r]
fam5={k:[coords5(c9(Z**j*ETA**k)) for j in range(3)] for k in range(-2,3)}
def theta5(K):
    sols=set(); tori=0
    for js in itertools.product(range(3),repeat=len(K)):
        res=solve_half([fam5[k][j] for k,j in zip(K,js)])
        if res[0]=='torus': tori+=1
        elif res[0]=='finite': sols.update(res[1])
    return sols,tori
S,t=theta5([-2,-1,0,1,2])
def order(t): return lcm(*[x.denominator for x in t])
print('on Lambda5: |Theta|=',len(S),'tori',t,'orders',sorted(collections.Counter(order(x) for x in S).items()))

def jchoices(t):
    out=[]
    for js in itertools.product(range(3),repeat=5):
        if all(sum(Q(a)*x for a,x in zip(fam5[k][j],t))%1==Q(1,2) for k,j in zip(range(-2,3),js)): out.append(js)
    return out
o10=[x for x in S if order(x)==10]
two=collections.Counter(tuple((5*y)%1 for y in x) for x in o10)
print('2-parts of order-10 points:',len(two),'distinct;',[tuple(str(y) for y in k) for k in two],'mult',set(two.values()))
fiv=collections.Counter(tuple((6*y)%1 for y in x) for x in o10)
print('5-parts:',len(fiv),'distinct')
jc=collections.Counter(tuple(jchoices(x)[0]) for x in o10)
print('j-choices realising order-10 points (j_-2..j_2):',dict(jc))
o2=[x for x in S if order(x)==2]
print('order-2 points:',[tuple(str(y) for y in x) for x in o2])
for x in o2: print('  jchoices of',tuple(str(y) for y in x),':',jchoices(x))
