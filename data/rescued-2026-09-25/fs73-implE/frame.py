import math, sys
from fractions import Fraction as Fr
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form
from explore import units
def zbasis(U):
    # row HNF of the integer matrix whose rows are U -> basis rows
    H=hermite_normal_form(Matrix([list(u) for u in U]).T)  # columns
    B=[list(map(int,H[:,j])) for j in range(H.shape[1]) if any(H[:,j])]
    return B
def coords(B,u):
    x=Matrix(B).T.solve(Matrix(list(u))); assert all(t.q==1 for t in x); return [int(t) for t in x]
def lll_gram(B,G,delta=Fr(99,100)):
    # exact LLL of integer row basis B under Gram form G (rational symmetric matrix on the ambient coords)
    B=[list(b) for b in B]; n=len(B)
    ip=lambda x,y: sum(x[i]*G[i][j]*y[j] for i in range(len(x)) for j in range(len(y)) if G[i][j])
    def gso():
        Bs=[];mu=[[Fr(0)]*n for _ in range(n)];nn=[]
        for i in range(n):
            v=[Fr(t) for t in B[i]]
            for j in range(i):
                mu[i][j]=ip(B[i],Bs[j])/nn[j]; v=[v[t]-mu[i][j]*Bs[j][t] for t in range(len(v))]
            Bs.append(v); nn.append(ip(v,v))
        return Bs,mu,nn
    k=1
    while k<n:
        Bs,mu,nn=gso()
        for j in range(k-1,-1,-1):
            q=round(mu[k][j])
            if q:
                B[k]=[B[k][t]-q*B[j][t] for t in range(len(B[k]))]; Bs,mu,nn=gso()
        if nn[k]>=(delta-mu[k][k-1]**2)*nn[k-1]: k+=1
        else: B[k],B[k-1]=B[k-1],B[k]; k=max(k-1,1)
    return B
if __name__=="__main__":
    key=sys.argv[1]; d=int(sys.argv[2])
    M,U=units(key,d)
    B=zbasis(U); C=[coords(B,u) for u in U]
    print("basis",B,"max|coef|",max(max(abs(x) for x in c) for c in C), "sum l1", sum(sum(abs(x) for x in c) for c in C))
    # dual reduction: coefficient of u on dual vector w is w.c ; Q(w)=sum_u (w.c_u)^2  -> Gram = sum_u c c^T
    r=len(B)
    G=[[Fr(sum(c[i]*c[j] for c in C)) for j in range(r)] for i in range(r)]
    W=lll_gram([[1 if i==j else 0 for j in range(r)] for i in range(r)],G)
    # new coords of u: (w_k . c_u)_k ; W unimodular
    Wm=Matrix(W); print("det W",Wm.det())
    C2=[[sum(W[k][i]*c[i] for i in range(r)) for k in range(r)] for c in C]
    print("dual-reduced: max|coef|",max(max(abs(x) for x in c) for c in C2),"sum l1",sum(sum(abs(x) for x in c) for c in C2))
    half=[]
    for c in C2:
        if tuple(-x for x in c) not in [tuple(h) for h in half]: half.append(c)
    for c in sorted(half,key=lambda c:sum(map(abs,c))): print(c)
