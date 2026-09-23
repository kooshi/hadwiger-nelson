# Exact LP: minimise c.x subject to A x <= b, x >= 0, over Fractions. Two-phase tableau simplex, Bland's rule
# (terminates, no cycling). Returns (value, x) or (None, None) if infeasible. Assumes bounded (caller adds x<=1 rows).
from fractions import Fraction as Fr

def simplex_min(c, A, b):
    m=len(A); n=len(c)
    # rows: A x + s = b; for b<0 multiply by -1: -A x - s = -b, add artificial
    # variables: x (n), s (m), art (m_neg)
    rows=[]; basis=[]
    neg=[i for i in range(m) if b[i]<0]
    nart=len(neg); N=n+m+nart
    ai=0
    for i in range(m):
        row=[Fr(0)]*(N+1)
        sgn=-1 if b[i]<0 else 1
        for j in range(n): row[j]=Fr(A[i][j])*sgn
        row[n+i]=Fr(sgn)
        row[N]=Fr(b[i])*sgn
        if b[i]<0:
            row[n+m+ai]=Fr(1); basis.append(n+m+ai); ai+=1
        else: basis.append(n+i)
        rows.append(row)
    def pivot(r,col):
        pv=rows[r][col]; rows[r]=[v/pv for v in rows[r]]
        for i in range(len(rows)):
            if i!=r and rows[i][col]!=0:
                f=rows[i][col]; ri=rows[r]
                rows[i]=[a-f*bb for a,bb in zip(rows[i],ri)]
        basis[r]=col
    def run(cost,allowed):
        while True:
            # reduced costs
            cb=[cost[basis[i]] for i in range(len(rows))]
            enter=None
            for j in range(N):
                if not allowed[j] or j in basis: continue
                rc=cost[j]-sum(cb[i]*rows[i][j] for i in range(len(rows)))
                if rc<0: enter=j; break   # Bland: smallest index
            if enter is None: return
            best=None
            for i in range(len(rows)):
                if rows[i][enter]>0:
                    ratio=rows[i][N]/rows[i][enter]
                    if best is None or ratio<best[0] or (ratio==best[0] and basis[i]<basis[best[1]]): best=(ratio,i)
            if best is None: raise ValueError('unbounded')
            pivot(best[1],enter)
    if nart:
        cost1=[Fr(0)]*(n+m)+[Fr(1)]*nart
        run(cost1,[True]*N)
        val=sum(rows[i][N] for i in range(len(rows)) if basis[i]>=n+m)
        if val>0: return None,None
        # drive artificials out of basis
        for i in range(len(rows)):
            if basis[i]>=n+m:
                for j in range(n+m):
                    if rows[i][j]!=0: pivot(i,j); break
    cost2=[Fr(x) for x in c]+[Fr(0)]*(m+nart)
    allowed=[True]*(n+m)+[False]*nart
    run(cost2,allowed)
    x=[Fr(0)]*n
    for i in range(len(rows)):
        if basis[i]<n: x[basis[i]]=rows[i][N]
    return sum(Fr(c[j])*x[j] for j in range(n)), x
