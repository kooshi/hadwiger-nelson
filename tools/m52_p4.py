# P4: class-avoidance at k=4 on U (the it-4 unit part): distance-2 pairs and sqrt3 pairs
import sys, json, time, math
sys.path.insert(0,'tools')
import numpy as np, mpmath as mp
from scipy.spatial import cKDTree
import batchkill as B, rigidity
label="S29-depth2r-it2v2-depth1-it2v2-depth1-vdel28-it2v2-depth1"
obj,_=B.load_object(label); ue=obj.unit_edges(); live=[i for i in range(obj.n) if i not in obj.deleted]
mp.mp.dps=40; ex=obj.mp_values(40)
P=np.array(obj.pts); tree=cKDTree(P[live]); lv=np.array(live)
def pairs_at(d):
    out=[]
    for i,j in tree.query_pairs(d+1e-6):
        a,b=int(lv[i]),int(lv[j])
        if abs(np.linalg.norm(P[a]-P[b])-d)<1e-6:
            D=ex[a]-ex[b]
            if abs(mp.sqrt((D*mp.conj(D)).real)-d)<mp.mpf(10)**-30: out.append((a,b))
    return sorted(out)
res={}
for name,d in (("d2",2.0),("sqrt3",math.sqrt(3))):
    inst=pairs_at(d)
    t0=time.time(); row=rigidity.class_avoid(obj.n, ue, 4, inst, cap=1800)
    print(f"[P4] class {name}: {len(inst)} exact pairs among {len(live)} live points; avoid-all at k=4: {row['outcome'].upper()} ({time.time()-t0:.0f}s)", flush=True)
    res[name]=dict(instances=len(inst), **{k:v for k,v in row.items() if k!='colours'})
    if row['outcome']=='unsat':
        t0=time.time(); row2=rigidity.class_avoid_binary(obj.n, ue, 4, inst, cap=1800)
        print(f"[P4]   second encoding (2-bit): {row2['outcome'].upper()} ({time.time()-t0:.0f}s)", flush=True)
        res[name]['binary']=row2['outcome']
json.dump(dict(kind="p4-class-avoid", object=label, results=res), open('data/m52/p4-class-avoid.json','w'), indent=1)
