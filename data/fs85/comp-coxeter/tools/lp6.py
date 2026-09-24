"""Poros's LP, answered NO with an exact two-character witness, point-group averaged; then tested against R(v) >= -1/3 on small v."""
import io, contextlib, math, collections, itertools
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
    from spectral5 import order
from efield import E as EF
S5,_,_=theta([-2,-1,0,1,2]); S9,_,_=theta(list(range(-4,5))); S9=set(S9)
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
def lamF(t,k): return sum(2*math.cos(2*math.pi*float(ev(t,v))) for v in fam[k])
basis=[EF(Q(1,9)),EF(0,Q(1,9)),EF(0,0,Q(1,9)),EF(0,0,0,Q(1,9))]
gens=[lambda z: z*Z, lambda z: z.conj(), lambda z: z.sig3(), lambda z: z.sig11()]
def act(t,g):   # (theta o g)(x) = theta(g x): coordinates t'_i = theta(g b_i)
    return tuple(ev(t,c9(g(b))) for b in basis)
def orbit(t):
    O={t}; fr=[t]
    while fr:
        s=fr.pop(); 
        for g in gens:
            r=act(s,g)
            if r not in O: O.add(r); fr.append(r)
    return O
t1=(Q(11,12),Q(1,2),Q(7,12),Q(7,12))
A=lamF(t1,3)+lamF(t1,-3)+4
t2=next(s for s in S5 if order(s)==6 and abs(lamF(s,3)+lamF(s,-3)+4-3)<1e-9 and abs(lamF(s,4)+lamF(s,-4)+4-3)<1e-9)
O1=orbit(t1); O2=orbit(t2)
assert O1<=set(S5) and O2<=set(S5) and not (O1|O2)&S9
w1=1.0; w2=-A/3            # 1 : (2 sqrt3 - 3)/3
W={}
for s in O1: W[s]=W.get(s,0)+w1/len(O1)
for s in O2: W[s]=W.get(s,0)+w2/len(O2)
tot=sum(W.values()); W={s:x/tot for s,x in W.items()}
def R(v): return sum(x*math.cos(2*math.pi*float(ev(s,v))) for s,x in W.items())
Uall=[c9(Z**j*ETA**k) for j in range(6) for k in range(-4,5)]
print('orbit sizes',len(O1),len(O2),' max |R(u)+1/3| over U:',max(abs(R(u)+1/3) for u in Uall))
two=set(tuple(a+b for a,b in zip(u,v)) for u in Uall for v in Uall)
m=min((R(v),v) for v in two if any(v))
print('min R(v) over nonzero v in U+U:',m[0],' (bound -1/3 =',-1/3,')')
