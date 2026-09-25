import sys, time, math
sys.path.insert(0,'/home/kooshi/source/lean-dir/tools')
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds, linprog
from fs73_theta_lib import lattice_problem, parse_key
key=sys.argv[1]; d=int(sys.argv[2]); tl=float(sys.argv[3]) if len(sys.argv)>3 else 600
eps=float(sys.argv[4]) if len(sys.argv)>4 else 0.0
M,_=parse_key(key)
t0=time.time(); U,B,S=lattice_problem(key,d); r=4
Uh=[]; seen=set()
for u in U:
    if tuple(-x for x in u) in seen: continue
    seen.add(tuple(u)); Uh.append(u)
m=len(Uh)
Cu=np.array(Uh,float)/M; Bb=np.array(B,float)/M
# j bounds: phi ranges over parallelepiped {phi: 0<=Bb phi<=1}; phi = Bb^{-1} w
Binv=np.linalg.inv(Bb); G=Cu@Binv   # theta(u) as function of w in [0,1]^4
lo=np.minimum(G,0).sum(1); hi=np.maximum(G,0).sum(1); jl=np.floor(lo)-1; jh=np.ceil(hi)
nv=r+m; rows=[]; lb=[]; ub=[]
for k in range(4):
    row=np.zeros(nv); row[:r]=Bb[k]; rows.append(row); lb.append(0); ub.append(1)
for k in range(m):
    row=np.zeros(nv); row[:r]=Cu[k]; row[r+k]=-1; rows.append(row); lb.append(1/3+eps); ub.append(2/3-eps)
res=milp(np.zeros(nv),constraints=LinearConstraint(np.array(rows),lb,ub),integrality=np.r_[np.zeros(r),np.ones(m)],
         bounds=Bounds(np.r_[np.full(r,-np.inf),jl],np.r_[np.full(r,np.inf),jh]),
         options={"time_limit":tl,"disp":False,"mip_rel_gap":0,"primal_feasibility_tolerance":1e-9} if False else {"time_limit":tl,"disp":False})
print(key, d, "units",len(U),"status",res.status,res.message.split('(')[0],"time",round(time.time()-t0,1),flush=True)
if res.x is not None:
    phi=res.x[:r]; vals=Cu@phi; fr=vals-np.floor(vals)
    print("phi",phi,"min frac",fr.min(),"max frac",fr.max())
    np.save(f"mip2_{d}_{M}.npy",res.x)
