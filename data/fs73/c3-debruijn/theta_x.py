# EXACT rotation set Theta_k via DFS with the exact simplex (xlp.py). theta in [0,1]^r (closed fundamental domain).
import math
from fractions import Fraction as Fr
from xlp import simplex_min

def lp(c,A,b,r):
    A2=[list(row) for row in A]+[[1 if i==j else 0 for j in range(r)] for i in range(r)]
    b2=list(b)+[Fr(1)]*r
    return simplex_min(c,A2,b2)

def reps_of(Uc):
    reps=[]; seen=set()
    for u in Uc:
        t=tuple(u); m=tuple(-x for x in u)
        if m in seen or t in seen: continue
        seen.add(t); reps.append(list(u))
    return reps

def theta_exact(Uc,k,lo=None,hi=None):
    reps=reps_of(Uc); r=len(reps[0])
    lo=Fr(1,k) if lo is None else lo; hi=1-lo if hi is None else hi
    order=sorted(range(len(reps)),key=lambda j:-sum(abs(x) for x in reps[j]))
    leaves=[]; nodes=[0]
    def dfs(idx,A,b):
        nodes[0]+=1
        if idx==len(reps): leaves.append((A,b)); return
        a=reps[order[idx]]
        vmin,_=lp(a,A,b,r)
        if vmin is None: return
        vmax,_=lp([-x for x in a],A,b,r); vmax=-vmax
        for n in range(math.floor(vmin-hi),math.ceil(vmax-lo)+1):
            L=n+lo; H=n+hi
            if H<vmin or L>vmax: continue
            A2=A+[a,[-x for x in a]]; b2=b+[H,-L]
            v,_=lp([0]*r,A2,b2,r)
            if v is not None: dfs(idx+1,A2,b2)
    dfs(0,[],[])
    boxes=[]
    for A,b in leaves:
        box=[]
        for i in range(r):
            e=[1 if j==i else 0 for j in range(r)]
            mn,_=lp(e,A,b,r); mx,_=lp([-x for x in e],A,b,r)
            box.append((mn,-mx))
        boxes.append(box)
    return reps,boxes,nodes[0]
