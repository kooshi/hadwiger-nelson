import sys, time, math
sys.path.insert(0,'/home/kooshi/source/lean-dir/tools')
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds
from fs73_theta_lib import lattice_problem
key=sys.argv[1]; d=int(sys.argv[2]); tl=float(sys.argv[3]) if len(sys.argv)>3 else 600
eps=float(sys.argv[4]) if len(sys.argv)>4 else 0.0
t0=time.time(); U,B,S=lattice_problem(key,d); r=len(B); m=len(S)
print("units",len(U),"half",m,"rank",r,"basis",B,"enum",round(time.time()-t0,1),"s",flush=True)
C=np.array(S,float)
lo=np.minimum(C,0).sum(1); hi=np.maximum(C,0).sum(1)
jl=np.floor(lo)-1; jh=np.ceil(hi)
nv=r+m
A=np.zeros((2*m,nv)); lb=np.full(2*m,-np.inf); ub=np.zeros(2*m)
for k in range(m):
    A[2*k,:r]=C[k]; A[2*k,r+k]=-1; ub[2*k]=2/3-eps          # c.w - j <= 2/3
    A[2*k+1,:r]=-C[k]; A[2*k+1,r+k]=1; ub[2*k+1]=-1/3-eps    # -(c.w - j) <= -1/3
res=milp(np.zeros(nv),constraints=LinearConstraint(A,lb,ub),integrality=np.r_[np.zeros(r),np.ones(m)],
         bounds=Bounds(np.r_[np.zeros(r),jl],np.r_[np.ones(r),jh]),options={"time_limit":tl,"disp":False,"mip_rel_gap":0})
print("status",res.status,res.message,"time",round(time.time()-t0,1),flush=True)
if res.x is not None:
    w=res.x[:r]; vals=C@w; fr=vals-np.floor(vals)
    print("w",w,"min frac",fr.min(),"max frac",fr.max())
    np.save(f"mip_{d}_{key.split('|')[0]}.npy",res.x)
