# C-S2: exact spectrum of the dyadic tower of Q(sqrt2,sqrt3): L = Q2(zeta24), K = Q2(sqrt2,sqrt3), conj zeta -> zeta^-1.
# P_m = Cay(O/P^m, S_m), S_m = image of norm-one units. Tight at 4 colours iff min eigenvalue = -|S_m|/3.
# Exact integer lattice arithmetic; eigenvalues by FFT on the Smith form (floating output, integer-valued up to rounding; checked).
import numpy as np, itertools, sys
N=8  # Phi24 = x^8 - x^4 + 1
def mul(a,b):
    r=[0]*15
    for i,x in enumerate(a):
        if x:
            for j,y in enumerate(b):
                if y: r[i+j]+=x*y
    for d in range(14,7,-1):          # x^8 = x^4 - 1
        c=r[d]
        if c: r[d]=0; r[d-4]+=c; r[d-8]-=c
    return r[:8]
def zpow(k):
    k%=24; e=[1]+[0]*7
    z=[0,1,0,0,0,0,0,0]
    for _ in range(k): e=mul(e,z)
    return e
def conj(a):
    r=[0]*8
    for i,x in enumerate(a):
        if x:
            p=zpow(-i); r=[r[j]+x*p[j] for j in range(8)]
    return r
z8=zpow(3); pi=[1-z8[0]]+[-c for c in z8[1:]]   # pi = 1 - zeta8, uniformiser (e=4)
def smith(A):
    # returns (d, V) with rows of A spanning L, x in L iff (x@V)_i = 0 mod d_i
    A=[row[:] for row in A]; n=len(A); V=[[int(i==j) for j in range(n)] for i in range(n)]
    def colop(i,j,q):  # col_j -= q col_i  (on A and V)
        for r in range(n): A[r][j]-=q*A[r][i]
        for r in range(n): V[r][j]-=q*V[r][i]
    def swapc(i,j):
        for r in range(n): A[r][i],A[r][j]=A[r][j],A[r][i]
        for r in range(n): V[r][i],V[r][j]=V[r][j],V[r][i]
    for t in range(n):
        while True:
            piv=min(((abs(A[r][c]),r,c) for r in range(t,n) for c in range(t,n) if A[r][c]),default=None)
            if piv is None: break
            _,r,c=piv; A[t],A[r]=A[r],A[t]; swapc(t,c)
            done=True
            for c in range(t+1,n):
                q=A[t][c]//A[t][t]; colop(t,c,q)
                if A[t][c]: done=False
            for r in range(t+1,n):
                q=A[r][t]//A[t][t]; A[r]=[A[r][k]-q*A[t][k] for k in range(n)]
                if A[r][t]: done=False
            if done:
                bad=[(r,c) for r in range(t+1,n) for c in range(t+1,n) if A[r][c]%A[t][t]]
                if not bad: break
                r,c=bad[0]; A[t]=[A[t][k]+A[r][k] for k in range(n)]
    return [abs(A[i][i]) for i in range(n)], np.array(V,dtype=object)
def run(m):
    pm=[1]+[0]*7
    for _ in range(m): pm=mul(pm,pi)
    A=[]; b=pm
    for i in range(8): A.append(b[:]); b=mul(b,[0,1,0,0,0,0,0,0])
    d,V=smith(A); Vi=np.array(__import__('sympy').Matrix(V.tolist()).inv().tolist(),dtype=object)
    assert np.prod(d)==4**m, (d,m)
    dims=[x for x in d]
    def coords(x): return tuple(int(v)%di for v,di in zip(np.array(x,dtype=object)@V,dims))
    ind=np.zeros([x for x in dims],dtype=float); S=0
    for y in itertools.product(*[range(x) for x in dims]):
        x=list((np.array(y,dtype=object)@Vi))
        x=[int(v) for v in x]
        n=mul(x,conj(x)); n[0]-=1
        if all(v==0 for v in coords(n)): ind[y]=1; S+=1
    lam=np.real(np.fft.fftn(ind))
    mn=lam.min(); 
    print(f"m={m} |G|={4**m} dims={dims} |S_m|={S} lam_min={mn:.6f} -|S|/3={-S/3:.6f} tight={abs(mn+S/3)<1e-6} mult_min={int(np.sum(abs(lam-mn)<1e-6))}",flush=True)
for m in range(1,int(sys.argv[1])+1): run(m)
