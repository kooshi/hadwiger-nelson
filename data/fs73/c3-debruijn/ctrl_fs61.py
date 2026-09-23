import sys, json, math, sympy, time
from theta_x import theta_exact
M=30; d=int(sys.argv[1])
U=[]
R=int(math.isqrt(M*M//d))+1
for p in range(-M,M+1):
  for q in range(-M,M+1):
    for r in range(-R,R+1):
      for s in range(-R,R+1):
        if p*p+q*q+d*(r*r+s*s)==M*M and p*r+q*s==0 and (r-q)%2==0 and (s-p)%2==0: U.append((p,q,r,s))
B=sympy.Matrix([[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]])
Uc=[[int(x) for x in B.T.solve(sympy.Matrix(u))] for u in U]
# check U spans (rank) -- Theta on the full module; if U spans a sublattice, Theta over Hom(Lambda) still valid for the graph
print('d',d,'|U|',len(U),'rank',sympy.Matrix(Uc).rank())
t=time.time()
reps,boxes,nodes=theta_exact(Uc,3)
pts=set(); nonpt=0
for bx in boxes:
    if any(lo!=hi for lo,hi in bx): nonpt+=1
    else: pts.add(tuple(lo%1 for lo,hi in bx))
print('nodes',nodes,'leaves',len(boxes),'point-leaves distinct',len(pts),'non-point leaves',nonpt,'time',round(time.time()-t,1))
for bx in boxes[:5]: print([(str(a),str(b)) for a,b in bx])
