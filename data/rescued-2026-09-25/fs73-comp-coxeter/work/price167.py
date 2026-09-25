from shapes import units
from theta2 import lattice_coords, halfset
from lllbb import *
import sys, math
M=int(sys.argv[1]); d=int(sys.argv[2]); tl=float(sys.argv[3])
H=[[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]]
U=units(M,H,d)
B,C=lattice_coords(U)   # B: sympy matrix, columns basis in (a,b,c,e); C: coords
Bl=[list(map(int,B[:,j])) for j in range(B.shape[1])]
sd=math.sqrt(d)
emb=lambda v:[(v[0]+v[1]*sd)/M,(v[2]+v[3]*sd)/M,(v[0]-v[1]*sd)/M,(v[2]-v[3]*sd)/M]
L=lll(Bl,emb)
Uc=[solve_coords(L,list(u)) for u in U]
S=halfset(Uc)
print("M",M,"d",d,"|U|",len(U),"LLL-basis units max |coef|",max(max(abs(x) for x in s) for s in S), "sum l1", sum(sum(abs(x) for x in s) for s in S), flush=True)
ok,nodes,leaves=bb(S,4,tlimit=tl)
print("finished" if ok else "TIMEOUT", "nodes",nodes,"leaves",len(leaves), flush=True)
