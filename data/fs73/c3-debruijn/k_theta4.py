import json, sympy, time
from fractions import Fraction as Fr
from theta_x import theta_exact
d=json.load(open('/home/kooshi/source/lean-dir/data/fs73/census/lattice-degrey.json'))
H=sympy.Matrix(d['H']); U=d['U']
Uc=[]
for u in U:
    sol=H.T.solve_least_squares(sympy.Matrix(u)) if False else None
    # exact solve of H^T a = u (8x4 system, consistent)
    a=sympy.symbols('a0:4'); eqs=[sum(H[i,j]*a[i] for i in range(4))-u[j] for j in range(8)]
    s=sympy.solve(eqs,a,dict=True)[0]; v=[s[x] for x in a]
    assert all(x.is_integer for x in v), (u,v)
    Uc.append([int(x) for x in v])
json.dump(Uc,open('k_Uc.json','w'))
print('|U|',len(Uc),'rank',sympy.Matrix(Uc).rank())
t=time.time()
reps,boxes,nodes=theta_exact(Uc,4)
pts=set(); nonpt=[]
for bx in boxes:
    if any(lo!=hi for lo,hi in bx): nonpt.append(bx)
    else: pts.add(tuple(lo%1 for lo,hi in bx))
print('nodes',nodes,'leaves',len(boxes),'distinct points',len(pts),'non-point leaves',len(nonpt),'time',round(time.time()-t,1))
from math import lcm
for p in sorted(pts): print([str(x) for x in p],'order',lcm(*[x.denominator for x in p]))
for bx in nonpt[:10]: print('NONPT',[(str(a),str(b)) for a,b in bx])
json.dump({'points':[[str(x) for x in p] for p in sorted(pts)],'nonpoint':[[(str(a),str(b)) for a,b in bx] for bx in nonpt]},open('k_theta4.json','w'))
