"""Exact check of the decomposition used by the alternate-triple lemma:
Theta_{-3..3} = Theta_all + Ann(Lambda7)  and  Theta_{-2..2} = Theta~ + Ann(Lambda5), Theta~ = 3-free parts (42 + 48 of order 10)."""
import io, contextlib, itertools
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
    from spectral5 import order
from math import lcm
def twopart_odd(t):   # primary decomposition of a torsion character
    n=order(t); a=1
    while n%2==0: n//=2; a*=2
    # t = t2 + to with t2 of order a (2-power), to of odd order n: use CRT idempotents
    e2=pow(n, -1, a)*n if a>1 else 0      # e2 = 1 mod a, 0 mod n
    t2=tuple((e2*x)%1 for x in t); to=tuple((x-y)%1 for x,y in zip(t,t2))
    return t2,to
def ann(K):  # characters of Lambda killing Lambda_K: 3-torsion with t.v = 0 for all v in U_K
    vs=[c9(Z**j*ETA**k) for j in range(3) for k in K]
    out=[]
    for t in itertools.product([Q(0),Q(1,3),Q(2,3)],repeat=4):
        if all(sum(a*x for a,x in zip(v,t))%1==0 for v in vs): out.append(t)
    return out
S9=set(theta(list(range(-4,5)))[0]); S7=set(theta(list(range(-3,4)))[0]); S5=set(theta(list(range(-2,3)))[0])
A7=ann(range(-3,4)); A5=ann(range(-2,3))
print('|Ann(L7)|=',len(A7),' |Ann(L5)|=',len(A5))
print('Theta_{-3..3} == Theta_all + Ann(L7):', S7=={tuple((a+b)%1 for a,b in zip(s,t)) for s in S9 for t in A7})
T5=set(); bad=0
for t in S5:
    t2,to=twopart_odd(t)
    # split odd part into 3- and 5-parts
    n=order(to) if any(to) else 1
    n3=1
    while n%3==0: n//=3; n3*=3
    if n3>1 and n>1:
        e3=pow(n,-1,n3)*n; t3=tuple((e3*x)%1 for x in to)
    elif n3>1: t3=to
    else: t3=tuple(Q(0) for _ in to)
    if t3 not in set(A5): bad+=1
    T5.add(tuple((x-y)%1 for x,y in zip(t,t3)))
print('3-parts of Theta_{-2..2} all in Ann(L5):',bad==0,' |3-free parts| =',len(T5),' orders',sorted(set(order(t) for t in T5)),' of which in Theta_all:',len(T5&S9))
