import json, time
from theta_x import theta_exact
Uc=json.load(open('k_Uc.json'))
t=time.time(); reps,boxes,nodes=theta_exact(Uc,3)
print('degrey k=3 NEGATIVE CONTROL (contains Moser spindle): nodes',nodes,'leaves',len(boxes),'time',round(time.time()-t,1))
