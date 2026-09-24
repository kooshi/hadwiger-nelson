"""Poros's round-2 question: do the 54 pair-correlation equalities R(u) = -1/3 force the weights onto Theta_all?
Galois-orbit reduction: theta -> N theta (N in (Z/120)^x) preserves Theta_{-2..2}; a rational feasible w averages to an orbit-constant
one, and on orbit-constant weights every coefficient is an integer (orbit sums of roots of unity).  Exact rational LP."""
import io, contextlib, math, collections
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
S5,_,_=theta([-2,-1,0,1,2]); S5=set(S5)
S9,_,_=theta(list(range(-4,5))); S9=set(S9)
Us=[c9(Z**j*ETA**k) for j in range(3) for k in range(-4,5)]   # 27 directions up to sign
units=[N for N in range(120) if math.gcd(N,120)==1]
seen=set(); orbits=[]
for t in sorted(S5):
    if t in seen: continue
    O=set(tuple((N*x)%1 for x in t) for N in units)
    assert O<=S5
    seen|=O; orbits.append(sorted(O))
print('orbits:',len(orbits))
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
T=[]
for O in orbits:
    row=[]
    for v in Us:
        s=sum(math.cos(2*math.pi*float(ev(t,v))) for t in O)
        r=round(s); assert abs(s-r)<1e-6, s; row.append(r)
    T.append(row)
bad=[any(t not in S9 for t in O) for O in orbits]
assert all((not b) or all(t not in S9 for t in O) for O,b in zip(orbits,bad))
print('good orbits',bad.count(False),' bad orbits',bad.count(True))
import numpy as np
from scipy.optimize import linprog
n=len(orbits)
A=np.array([[T[o][i] for o in range(n)] for i in range(len(Us))]+[[len(O) for O in orbits]],dtype=float)
b=np.array([-1/3]*len(Us)+[1.0])
c=np.array([-(len(O) if bb else 0) for O,bb in zip(orbits,bad)],dtype=float)
res=linprog(c,A_eq=A,b_eq=b,bounds=[(0,None)]*n,method='highs')
print(res.status,res.message,' max bad weight =',-res.fun if res.status==0 else None)
if res.status==0:
    x=res.x; sup=[i for i in range(n) if x[i]>1e-12]
    print('support:',[(i,len(orbits[i]),bad[i],round(x[i]*len(orbits[i]),6)) for i in sup])
    import pickle; pickle.dump((orbits,T,bad,sup),open('lp2.pkl','wb'))
