import json
from theta_x import *
Uc=json.load(open('q11_Uc.json'))
reps,boxes,nodes=theta_exact(Uc,3)
print('reps',len(reps),'nodes',nodes,'leaves',len(boxes))
pts=set(); nonpoint=[]
for bx in boxes:
    if any(lo!=hi for lo,hi in bx): nonpoint.append(bx); continue
    pts.add(tuple(lo%1 for lo,hi in bx))
print('distinct points mod Z^4:',len(pts),'non-point leaves:',len(nonpoint))
print('all 3-torsion:',all(all((3*x)%1==0 for x in p) for p in pts))
json.dump([[str(x) for x in p] for p in sorted(pts)],open('q11_theta3_points.json','w'))
for p in sorted(pts): print([str(x) for x in p])
