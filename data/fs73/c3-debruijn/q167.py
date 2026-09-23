import sys, json, math, sympy, time
from theta_x import theta_exact
d=167; M=int(sys.argv[1]); tag=sys.argv[2]
U=set()
R=math.isqrt(M*M//d)+1
for r in range(-R,R+1):
  for s in range(-R,R+1):
    rest=M*M-d*(r*r+s*s)
    if rest<0: continue
    if r==0 and s==0:
      for p in range(-M,M+1):
        q2=rest-p*p
        if q2>=0:
          q=math.isqrt(q2)
          if q*q==q2: U.add((p,q,0,0)); U.add((p,-q,0,0))
      continue
    g=math.gcd(r,s); a,b=s//g,-r//g   # (p,q)=t(a,b)
    n2=a*a+b*b
    if rest%n2: continue
    t2=rest//n2; t=math.isqrt(t2)
    if t*t!=t2: continue
    for tt in {t,-t}: U.add((tt*a,tt*b,r,s))
U=[u for u in U if (u[2]-u[1])%2==0 and (u[3]-u[0])%2==0]
print(tag,'M',M,'|U|',len(U))
B=sympy.Matrix([[1,0,0,1],[0,1,1,0],[0,0,2,0],[0,0,0,2]])
Uc=[[int(x) for x in B.T.solve(sympy.Matrix(u))] for u in U]
print('rank',sympy.Matrix(Uc).rank())
json.dump({'U':sorted(U),'Uc':Uc},open(f'q167_{tag}.json','w'))
t0=time.time()
reps,boxes,nodes=theta_exact(Uc,3)
pts=set(); nonpt=[]
for bx in boxes:
    if any(lo!=hi for lo,hi in bx): nonpt.append(bx)
    else: pts.add(tuple(lo%1 for lo,hi in bx))
print(tag,'nodes',nodes,'leaves',len(boxes),'points',len(pts),'nonpoint',len(nonpt),'time',round(time.time()-t0,1))
for p in sorted(pts)[:20]: print([str(x) for x in p])
for bx in nonpt[:5]: print('NP',[(str(a),str(b)) for a,b in bx])
