from pysat.solvers import Glucose4, Minisat22, Cadical153
from fractions import Fraction
import rank1_density as R
def cnf(D,k,L):
    cl=[];v=lambda i,c:i*k+c+1
    for i in range(L):
        cl.append([v(i,c) for c in range(k)])
        for d in D:
            if i+d<L:
                for c in range(k): cl.append([-v(i,c),-v(i+d,c)])
    return cl
def sat(D,k,L,S):
    s=S(bootstrap_with=cnf(D,k,L)); r=s.solve(); s.delete(); return r
for D in [(1,3,7,12,17,22),(1,6,8,11,12)]:
    # independent-set density check
    print("D=",D)
    # minimal refusing window by bisection with Glucose4
    lo,hi=max(D)+1,400
    assert not sat(D,4,hi,Glucose4)
    while lo<hi:
        m=(lo+hi)//2
        if sat(D,4,m,Glucose4): lo=m+1
        else: hi=m
    print("  minimal refusing window (Glucose4):",lo,"; Minisat22 agrees UNSAT at it:",not sat(D,4,lo,Minisat22),"; SAT at",lo-1,":",sat(D,4,lo-1,Minisat22))
A={(1,3,7,12,17,22):(29,[0,2,4,6,10,15,20,25]),(1,6,8,11,12):(20,[0,2,4,7,17])}
for D,(p,S) in A.items():
    bad=[(a,b) for a in S for b in S if a!=b and ((a-b)%p in {d%p for d in D} )]
    print("D=",D,"period",p,"set",S,"independent:",not bad,"density",Fraction(len(S),p))
print(R.analyse((1,6,8,11,12),4))
