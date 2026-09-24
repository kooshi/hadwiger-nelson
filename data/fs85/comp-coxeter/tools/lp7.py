"""Extended LP (float probe, shape fixed in advance): point-group-invariant weights on Theta_{-2..2};
equalities R(u) = -1/3 on U; inequalities R(v) >= -1/3 for every nonzero v in U+U (valid for every colouring). Maximise bad weight."""
import io, contextlib, math, collections, itertools, pickle
with contextlib.redirect_stdout(io.StringIO()):
    from lp6 import *
import numpy as np
from scipy.optimize import linprog
S5l=sorted(S5); seen=set(); orbs=[]
for t in S5l:
    if t in seen: continue
    O=orbit(t); seen|=O; orbs.append(sorted(O))
print('theta orbits:',len(orbs))
badO=[not (set(O)&S9) for O in orbs]
assert all(b or set(O)<=S9 for O,b in zip(orbs,badO))
# v-orbits in U and in (U+U)\(U u {0}), acting on vectors by the same generators
def vorb(v):
    # represent v as E element
    z=EF(*[Q(x,9) for x in v]); O={tuple(v)}; fr=[z]
    while fr:
        s=fr.pop()
        for g in gens:
            r=g(s); key=tuple(c9(r))
            if key not in O: O.add(key); fr.append(r)
    return O
Uset=set(tuple(u) for u in Uall)
def reps(vs):
    seen=set(); out=[]
    for v in sorted(vs):
        if v in seen: continue
        O=vorb(v); seen|=O; out.append(v)
    return out
Ureps=reps(Uset); Vreps=reps(set(v for v in two if any(v) and v not in Uset))
print('U orbits',len(Ureps),'  (U+U) orbits',len(Vreps))
def coef(O,v): return sum(math.cos(2*math.pi*float(ev(s,v))) for s in O)   # sum over orbit (weight per theta = W_O)
n=len(orbs)
Aeq=[[coef(O,u) for O in orbs] for u in Ureps]+[[len(O) for O in orbs]]
beq=[-1/3]*len(Ureps)+[1.0]
Aub=[[-(coef(O,v)+len(O)/3) for O in orbs] for v in Vreps]; bub=[0.0]*len(Vreps)
c=[-(len(O) if b else 0) for O,b in zip(orbs,badO)]
res=linprog(c,A_ub=Aub,b_ub=bub,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*n,method='highs')
print(res.status,res.message,' max bad weight =',-res.fun if res.status==0 else None)
if res.status==0:
    sup=[i for i in range(n) if res.x[i]*len(orbs[i])>1e-9]
    print('support (orbit size, bad, weight, order):',[(len(orbs[i]),badO[i],round(res.x[i]*len(orbs[i]),5),order(orbs[i][0])) for i in sup])
pickle.dump((orbs,badO,Ureps,Vreps),open('lp7.pkl','wb'))
