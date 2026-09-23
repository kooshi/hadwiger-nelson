# Build an EXACT emptiness (or nonemptiness) certificate for Theta = {theta in [0,1]^r : theta.u mod 1 in [1/3,2/3] for u in S}.
# Node = list of (constraint index, integer j) meaning j+1/3 <= theta.u <= j+2/3. At each node for the next constraint c we
# record dual multipliers y (>= 0, one per row of the node's inequality system) certifying L <= c.theta and c.theta <= U,
# with the box handled optimally; children = every j with [j+1/3, j+2/3] meeting [L, U].
import sys, json, math, time
from fractions import Fraction as Fr
import numpy as np
from scipy.optimize import linprog
def rows(S, path):
    A=[]; b=[]
    for (i,j) in path:
        c=S[i]; A.append([Fr(x) for x in c]); b.append(Fr(3*j+2,3))      #  c.t <= j+2/3
        A.append([Fr(-x) for x in c]); b.append(Fr(-(3*j+1),3))          # -c.t <= -(j+1/3)
    return A,b
def bound_from_y(A,b,c,y):
    # lower bound on c.t over {A t <= b, 0<=t<=1}: -c = y A + u - v, u,v>=0; choose u = max(0, -(yA + c)); L = -(y.b + sum u)
    r=len(c); yA=[sum(y[k]*A[k][i] for k in range(len(A))) for i in range(r)]
    u=[max(Fr(0), -(yA[i]+c[i])) for i in range(r)]
    return -(sum(y[k]*b[k] for k in range(len(A))) + sum(u))
def float_dual(A,b,c,r):
    if not A:
        return []
    Af=np.array([[float(x) for x in row] for row in A]); bf=np.array([float(x) for x in b])
    res=linprog([float(x) for x in c],A_ub=Af,b_ub=bf,bounds=[(0,1)]*r,method="highs")
    if res.status==2:   # infeasible: Farkas ray via phase-1 LP: min sum s s.t. A t - s <= b
        return None
    if res.status!=0: return None
    return [max(0.0,-x) for x in res.ineqlin.marginals]
def rat(v): return Fr(v).limit_denominator(10**9)
def children(L,U):
    lo=math.floor(L-Fr(2,3)); hi=math.ceil(U-Fr(1,3))
    return [j for j in range(lo,hi+1) if Fr(3*j+1,3)<=U and Fr(3*j+2,3)>=L]
def build(S, r, tcap):
    t0=time.time(); nodes=[]; leaves=[]
    stack=[[]]
    while stack:
        if time.time()-t0>tcap: return None
        path=stack.pop(); idx=len(path)
        if idx==len(S): leaves.append(path); continue
        A,b=rows(S,path); c=[Fr(x) for x in S[idx]]
        yl=float_dual(A,b,c,r); yu=float_dual(A,b,[-x for x in c],r)
        if yl is None or yu is None:
            # infeasible node polytope: certify with a Farkas combination found as the dual of max 0 (use phase-1 via L>U trick)
            # fall back: bound c.t with multipliers from a relaxed LP (drop nothing) -- use y giving L>U through the ray below
            ray=farkas(A,b,r)
            nodes.append({"p":path,"farkas":[str(x) for x in ray]}); continue
        yl=[rat(x) for x in yl]; yu=[rat(x) for x in yu]
        L=bound_from_y(A,b,c,yl); U=-bound_from_y(A,b,[-x for x in c],yu)
        ch=children(L,U)
        nodes.append({"p":path,"yl":[str(x) for x in yl],"yu":[str(x) for x in yu],"ch":ch})
        for j in ch: stack.append(path+[(idx,j)])
    return nodes, leaves
def farkas(A,b,r):
    # find y>=0 with yA + u - v = 0 (u,v box multipliers) and y.b + sum(u) < 0: LP  min y.b + sum(u) s.t. -(yA) <= u ... use
    # formulation: variables y>=0 (m), u>=0 (r): constraint yA + u >= 0 (so v = yA+u >= 0), normalise sum y = 1, minimise y.b + sum u
    m=len(A); Af=np.array([[float(x) for x in row] for row in A]); bf=[float(x) for x in b]
    cobj=bf+[1.0]*r
    Aub=np.hstack([-Af.T, -np.eye(r)]); bub=np.zeros(r)
    Aeq=np.array([[1.0]*m+[0.0]*r]); beq=[1.0]
    res=linprog(cobj,A_ub=Aub,b_ub=bub,A_eq=Aeq,b_eq=beq,bounds=[(0,None)]*(m+r),method="highs")
    return [rat(max(0.0,x)) for x in res.x[:m]]
if __name__=="__main__":
    import pickle
    src=sys.argv[1]; out=sys.argv[2]; tcap=float(sys.argv[3])
    S=json.load(open(src))["S"]; r=len(S[0])
    res=build(S,r,tcap)
    if res is None: print("CAP"); sys.exit(1)
    nodes,leaves=res
    src_j=json.load(open(src)); json.dump({"key":src_j["key"],"d":src_j["d"],"basis":src_j["basis"],"S":S,"nodes":nodes,"leaves":leaves},open(out,"w"))
    print("nodes",len(nodes),"leaves",len(leaves))
