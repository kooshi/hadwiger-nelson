from shapes import units
from theta2 import lattice_coords, halfset
from lllbb import lll, solve_coords, bb
import sys, math
key=sys.argv[1]; d=int(sys.argv[2]); tl=float(sys.argv[3])
M=int(key.split('|')[0]); H=[list(map(int,r.split(','))) for r in key.split('|')[1].split(';')]
U=units(M,H,d); B,C=lattice_coords(U)
Bl=[list(map(int,B[:,j])) for j in range(B.shape[1])]
sd=math.sqrt(d)
emb=lambda v:[(v[0]+v[1]*sd)/M,(v[2]+v[3]*sd)/M,(v[0]-v[1]*sd)/M,(v[2]-v[3]*sd)/M]
L=lll(Bl,emb); S=halfset([solve_coords(L,list(u)) for u in U])
ok,nodes,leaves=bb(S,len(S[0]),tlimit=tl)
print(key,"d",d,"|U|",len(U),"rank",len(S[0]),"finished" if ok else "TIMEOUT","nodes",nodes,"leaves(nonempty cells)",len(leaves),flush=True)
