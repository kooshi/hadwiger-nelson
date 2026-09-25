import json
from theta_exact import *
Uc=json.load(open('q11_Uc.json'))
reps,boxes,nodes=theta_exact(Uc,3)
print('reps',len(reps),'nodes',nodes,'leaves',len(boxes))
pts=set(); nonpoint=0
for bx in boxes:
    if any(lo!=hi for lo,hi in bx): nonpoint+=1; print('NONPOINT',bx); continue
    pts.add(canon(bx))
print('distinct points mod Z^4:',len(pts),'non-point leaves:',nonpoint)
tor=all(all((3*x)%1==0 for x in p) for p in pts)
print('all 3-torsion:',tor)
for p in sorted(pts): print(p)
json.dump([[str(x) for x in p] for p in sorted(pts)],open('q11_theta3_points.json','w'))
