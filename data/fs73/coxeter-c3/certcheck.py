# Standalone exact checker for certtree.py certificates. Trusts nothing but Fraction arithmetic.
# Claim checked: if 'leaves' is empty, Theta(S) = {theta in [0,1]^r : theta.u mod 1 in [1/3,2/3] for all u in S} is empty.
import sys, json, math
from fractions import Fraction as Fr
C=json.load(open(sys.argv[1])); S=C["S"]; r=len(S[0])
def rows(path):
    A=[]; b=[]
    for (i,j) in path:
        c=S[i]; A.append([Fr(x) for x in c]); b.append(Fr(3*j+2,3)); A.append([Fr(-x) for x in c]); b.append(Fr(-(3*j+1),3))
    return A,b
def lower(A,b,c,y):
    assert len(y)==len(A) and all(x>=0 for x in y)
    yA=[sum(y[k]*A[k][i] for k in range(len(A))) for i in range(r)]
    u=[max(Fr(0),-(yA[i]+c[i])) for i in range(r)]
    return -(sum(y[k]*b[k] for k in range(len(A)))+sum(u))

# --- the certificate's S must be ALL unit vectors of the lattice, in coordinates of a Z-basis of span(U) ---
assert "key" in C and "basis" in C, "certificate must name its lattice"
if True:
    key=C["key"]; d=C["d"]; M=int(key.split('|')[0]); H=[list(map(int,x.split(','))) for x in key.split('|')[1].split(';')]
    def inlat(v):
        v=list(v)
        for i in range(4):
            if v[i]%H[i][i]: return False
            q=v[i]//H[i][i]; v=[v[t]-q*H[i][t] for t in range(4)]
        return all(x==0 for x in v)
    U=set()
    for a in range(-M,M+1):
        for bb in range(-M,M+1):
            if a*a+d*bb*bb>M*M: continue
            for e in range(-M,M+1):
                r2=M*M-a*a-d*bb*bb-d*e*e
                if r2<0: continue
                cc=math.isqrt(r2)
                for c2 in {cc,-cc}:
                    if c2*c2==r2 and a*bb+c2*e==0 and inlat((a,bb,c2,e)): U.add((a,bb,c2,e))
    Bm=C["basis"]   # rows = basis vectors in (a,b,c,e)
    # solve coords exactly by Cramer (4x4 Fractions)
    def solve(Bm,v):
        n=4; Mx=[[Fr(Bm[j][i]) for j in range(n)]+[Fr(v[i])] for i in range(n)]
        for col in range(n):
            piv=next(i for i in range(col,n) if Mx[i][col]!=0); Mx[col],Mx[piv]=Mx[piv],Mx[col]
            for i in range(n):
                if i!=col and Mx[i][col]!=0:
                    f=Mx[i][col]/Mx[col][col]; Mx[i]=[Mx[i][t]-f*Mx[col][t] for t in range(n+1)]
        return [Mx[i][n]/Mx[i][i] for i in range(n)]
    coords=[solve(Bm,u) for u in U]
    assert all(x.denominator==1 for c in coords for x in c), "a unit vector is not an integer combination of the basis"
    half={tuple(int(x) for x in c) for c in coords}
    Sset={tuple(s) for s in S}
    assert all(s in half and tuple(-x for x in s) in half for s in Sset) and all(c in Sset or tuple(-x for x in c) in Sset for c in half), "S is not the full unit set"
    # basis vectors must lie in span(U): check the index [span(basis) : span(U)] = 1 via determinants of the coord lattice
    from itertools import combinations
    g=0
    for q in combinations(sorted(half),4):
        m=[[Fr(x) for x in row] for row in q]
        # det
        dm=[r[:] for r in m]; det=Fr(1)
        for col in range(4):
            piv=next((i for i in range(col,4) if dm[i][col]!=0),None)
            if piv is None: det=Fr(0); break
            if piv!=col: dm[col],dm[piv]=dm[piv],dm[col]; det=-det
            det*=dm[col][col]
            for i in range(col+1,4):
                f=dm[i][col]/dm[col][col]; dm[i]=[dm[i][t]-f*dm[col][t] for t in range(4)]
        g=math.gcd(g,int(abs(det)))
        if g==1: break
    assert g==1, "the unit vectors do not span the basis lattice (index %d)"%g
    print("lattice check OK:", len(U), "unit vectors, all in S up to sign; S spans the basis lattice")
node={tuple(map(tuple,n["p"])):n for n in C["nodes"]}
leaves={tuple(map(tuple,l)) for l in C["leaves"]}
todo=[()]; seen=0
while todo:
    p=todo.pop(); seen+=1
    if len(p)==len(S): assert p in leaves, "uncertified leaf"; continue
    n=node[p]; A,b=rows(list(p))
    if "farkas" in n:
        y=[Fr(x) for x in n["farkas"]]
        # y>=0, and for the box: v = yA + u >= 0 with u = max(0,-yA); infeasible iff y.b + sum(u) < 0
        L=lower(A,b,[Fr(0)]*r,y)   # certifies 0 >= L... we need contradiction: 0 = 0.t >= -(y.b+sum u) > 0
        assert L>0, "Farkas vector does not certify infeasibility"; continue
    c=[Fr(x) for x in S[len(p)]]
    L=lower(A,b,c,[Fr(x) for x in n["yl"]]); U=-lower(A,b,[-x for x in c],[Fr(x) for x in n["yu"]])
    need=[j for j in range(math.floor(L-Fr(2,3)),math.ceil(U-Fr(1,3))+1) if Fr(3*j+1,3)<=U and Fr(3*j+2,3)>=L]
    assert sorted(n["ch"])==need, "children do not cover the certified range"
    for j in need: todo.append(p+((len(p),j),))
print("CERTIFICATE OK: nodes checked",seen,"leaves",len(leaves), "=> Theta EMPTY" if not leaves else "=> leaves present (nonempty candidates)")
