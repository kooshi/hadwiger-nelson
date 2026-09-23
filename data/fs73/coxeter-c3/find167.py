from shapes import units
from theta2 import lattice_coords, halfset
from lllbb import *
import sys, math, json
from fractions import Fraction as Fr
from sympy import Matrix, Rational
M=int(sys.argv[1]); d=int(sys.argv[2]); tl=float(sys.argv[3])
H=[[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
U=units(M,H,d)
B,C=lattice_coords(U)
Bl=[list(map(int,B[:,j])) for j in range(B.shape[1])]
sd=math.sqrt(d)
emb=lambda v:[(v[0]+v[1]*sd)/M,(v[2]+v[3]*sd)/M,(v[0]-v[1]*sd)/M,(v[2]-v[3]*sd)/M]
L=lll(Bl,emb)
Uc=[solve_coords(L,list(u)) for u in U]
S=halfset(Uc)
# B&B stopping at first leaf
import time
order=sorted(range(len(S)), key=lambda i: sum(abs(x) for x in S[i])); Sx=[S[i] for i in order]
t0=time.time(); stack=[(0,[],[])]; nodes=0; found=None
while stack and time.time()-t0<tl:
    idx,Aub,bub=stack.pop(); nodes+=1
    if idx==len(Sx): found=(Aub,bub); break
    u=Sx[idx]; cf=[float(x) for x in u]
    r1=linprog(cf,A_ub=Aub or None,b_ub=bub or None,bounds=[(0,1)]*4,method="highs")
    if r1.status!=0: continue
    r2=linprog([-x for x in cf],A_ub=Aub or None,b_ub=bub or None,bounds=[(0,1)]*4,method="highs")
    mn,mx=r1.fun,-r2.fun
    for j in range(math.floor(mn-2/3)-1, math.ceil(mx-1/3)+2):
        l=j+1/3; h=j+2/3
        if h<mn-1e-9 or l>mx+1e-9: continue
        stack.append((idx+1, Aub+[cf,[-x for x in cf]], bub+[h,-l]))
print("nodes",nodes,"found",found is not None, round(time.time()-t0,1),"s")
if found:
    Aub,bub=found
    # centre-ish point: maximise slack t: A x + t <= b
    import numpy as np
    A=np.array(Aub); b=np.array(bub)
    res=linprog([0,0,0,0,-1],A_ub=np.hstack([A,np.ones((len(b),1))]),b_ub=b,bounds=[(0,1)]*4+[(0,1)],method="highs")
    x=res.x[:4]; print("slack",res.x[4], "theta float", x)
    for den in (10**3,10**4,10**5,10**6,10**8):
        th=[Fr(v).limit_denominator(den) for v in x]
        ok=all(Fr(1,3) <= (sum(th[i]*u[i] for i in range(4)) % 1) <= Fr(2,3) for u in S)
        if ok: break
    print("exact check", ok, "theta", th)
    if ok:
        # express theta as a functional on (a,b,c,e)-coords: theta(v) = th . coords_L(v)
        Lm=Matrix(L).T   # columns = basis vectors in (a,b,c,e)
        wv=Matrix([[Rational(t.numerator,t.denominator) for t in th]])*Lm.inv()  # functional on (a,b,c,e)
        print("functional on (a,b,c,e):", list(wv))
        mins=min(min((sum(th[i]*u[i] for i in range(4)))%1, 1-(sum(th[i]*u[i] for i in range(4)))%1) for u in S)
        print("min ||theta(u)|| =", mins, float(mins))
        json.dump({"M":M,"d":d,"basis_L":L,"theta":[str(t) for t in th],"functional_abce":[str(x) for x in wv],"U":[list(u) for u in U]}, open(f"theta167_{M}.json","w"))
