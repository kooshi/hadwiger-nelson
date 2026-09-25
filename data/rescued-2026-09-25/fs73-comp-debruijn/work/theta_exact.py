# EXACT rotation set Theta_k(Lambda,U) = {theta in R^r/Z^r : theta.u in [1/k,1-1/k] mod 1, all u in U}
# DFS over integer shifts n_j with exact rational LP (sympy simplex). Fundamental domain [0,1]^r (closed; points
# with a coordinate 0 or 1 are identified mod Z^r afterwards). Returns the leaf polytopes, each given by its exact
# coordinate box and, if a point, the point.
import sympy
from sympy import Rational as Q
from sympy.solvers.simplex import linprog, InfeasibleLPError

def lp(c, A, b, r):
    A2 = [list(row) for row in A] + [[1 if i==j else 0 for j in range(r)] for i in range(r)]
    b2 = list(b) + [1]*r
    try:
        val, x = linprog(c, A=A2, b=b2)   # x >= 0 implicit
        return val, x
    except InfeasibleLPError:
        return None, None

def reps_of(Uc):
    reps=[]; seen=set()
    for u in Uc:
        t=tuple(u); m=tuple(-x for x in u)
        if m in seen or t in seen: continue
        seen.add(t); reps.append(list(u))
    return reps

def theta_exact(Uc, k):
    reps=reps_of(Uc); r=len(reps[0])
    lo=Q(1,k); hi=1-Q(1,k)
    order=sorted(range(len(reps)),key=lambda j:-sum(abs(x) for x in reps[j]))
    leaves=[]; nodes=[0]
    def dfs(idx,A,b):
        nodes[0]+=1
        if idx==len(reps):
            leaves.append((A,b)); return
        a=reps[order[idx]]
        vmin,_=lp(a,A,b,r)
        if vmin is None: return
        vmax,_=lp([-x for x in a],A,b,r); vmax=-vmax
        n0=sympy.floor(vmin-hi); n1=sympy.ceiling(vmax-lo)
        for n in range(int(n0),int(n1)+1):
            L=n+lo; H=n+hi
            if H<vmin or L>vmax: continue
            A2=A+[a,[-x for x in a]]; b2=b+[H,-L]
            v,_=lp([0]*r,A2,b2,r)
            if v is not None: dfs(idx+1,A2,b2)
    dfs(0,[],[])
    out=[]
    for A,b in leaves:
        box=[]
        for i in range(r):
            e=[1 if j==i else 0 for j in range(r)]
            mn,_=lp(e,A,b,r); mx,_=lp([-x for x in e],A,b,r)
            box.append((mn,-mx))
        out.append(box)
    return reps,out,nodes[0]

def canon(box):
    # a point box -> tuple mod 1
    return tuple((lo % 1) for lo,hi in box)
