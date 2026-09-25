import json, numpy as np, sympy
from theta import *
U=json.load(open('q11_U.json'))
B=sympy.Matrix([[2,0,0,0],[0,2,0,0],[0,1,1,0],[1,0,0,1]])
Uc=[list(B.T.solve(sympy.Matrix(u))) for u in U]
Uc=[[int(x) for x in v] for v in Uc]
json.dump(Uc,open('q11_Uc.json','w'))
reps,leaves=theta_set(Uc,3)
print('reps',len(reps),'leaves',len(leaves))
for Aub,bub in leaves:
    bx=leaf_box(np.array(Aub),np.array(bub),4)
    print([ (round(a,6),round(b,6)) for a,b in bx])
